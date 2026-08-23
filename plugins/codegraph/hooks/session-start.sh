#!/usr/bin/env bash
set -euo pipefail

# Codex sends the hook event as JSON on stdin. Read it so the injection can be
# scoped to the session's project rather than the plugin installation path.
event_input="$(cat)"
session_cwd="$(printf '%s' "$event_input" | sed -n 's/.*"cwd"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)"
session_cwd="${session_cwd:-$(pwd -P)}"

if [[ ! -d "${session_cwd}" ]]; then
  exit 0
fi

# Match CodeGraph's nearest-index resolution when the session starts in a
# repository subdirectory. Do not initialize a missing index here.
if ! project_dir="$(cd "${session_cwd}" && pwd -P)"; then
  exit 0
fi
codegraph_root=""
while :; do
  if [[ -d "${project_dir}/.codegraph" ]]; then
    codegraph_root="${project_dir}"
    break
  fi
  if [[ "${project_dir}" == "/" ]]; then
    break
  fi
  project_dir="${project_dir%/*}"
  [[ -n "${project_dir}" ]] || project_dir="/"
done

[[ -n "${codegraph_root}" ]] || exit 0

# Codex reads project-scoped MCP servers from .codex/config.toml. Add the
# CodeGraph stdio server once, preserving any existing project configuration.
config_dir="${codegraph_root}/.codex"
config_file="${config_dir}/config.toml"

# TOML permits either bare or quoted keys. Also recognize an inline server
# under [mcp_servers] so repeated SessionStart events remain idempotent.
has_codegraph_server() {
  [[ -f "${config_file}" ]] || return 1

  awk '
    function normalized(value) {
      gsub(/[[:space:]"\047]/, "", value)
      return value
    }
    /^[[:space:]]*\[/ {
      section = $0
      sub(/^[[:space:]]*\[+/, "", section)
      sub(/\]+[[:space:]]*(#.*)?$/, "", section)
      section = normalized(section)
      if (section == "mcp_servers.codegraph") found = 1
      in_mcp_servers = (section == "mcp_servers")
      next
    }
    in_mcp_servers && $0 !~ /^[[:space:]]*#/ && $0 ~ /^[[:space:]]*["\047]?codegraph["\047]?[[:space:]]*=/ {
      found = 1
    }
    $0 !~ /^[[:space:]]*#/ && $0 ~ /^[[:space:]]*["\047]?mcp_servers["\047]?\.["\047]?codegraph["\047]?([[:space:]]*\.|[[:space:]]*=)/ {
      found = 1
    }
    $0 !~ /^[[:space:]]*#/ && $0 ~ /^[[:space:]]*["\047]?mcp_servers["\047]?[[:space:]]*=/ && $0 ~ /[{,][[:space:]]*["\047]?codegraph["\047]?[[:space:]]*=/ {
      found = 1
    }
    END { exit(found ? 0 : 1) }
  ' "${config_file}"
}

config_added=0
if ! has_codegraph_server; then
  # A mkdir lock avoids duplicate tables when two sessions start together.
  lock_dir="${config_file}.codegraph.lock"
  if mkdir -p "${config_dir}" 2>/dev/null && mkdir "${lock_dir}" 2>/dev/null; then
    trap 'rmdir "${lock_dir}" 2>/dev/null || true' EXIT
    if ! has_codegraph_server; then
      write_mcp_config() {
        if [[ -s "${config_file}" ]] && [[ "$(tail -c 1 "${config_file}" 2>/dev/null || true)" != $'\n' ]]; then
          printf '\n' >> "${config_file}" 2>/dev/null || return 1
        fi
        {
          printf '\n# Added by the CodeGraph plugin; remove this block to disable it.\n'
          printf '[mcp_servers.codegraph]\n'
          printf 'command = "codegraph"\n'
          printf 'args = ["serve", "--mcp"]\n'
        } >> "${config_file}" 2>/dev/null
      }
      if write_mcp_config; then
        config_added=1
      fi
    fi
    rmdir "${lock_dir}" 2>/dev/null || true
    trap - EXIT
  fi
fi

# The hook already proved that this session has a CodeGraph index. Keep the
# injected reminder hardcoded so it remains concise and does not duplicate
# skill-routing metadata that has already been enforced above.
context='Codegraph index available and .codegraph directory exists. Use the `codegraph` skill for this task. Call `codegraph_explore` before grep, find, or reading indexed code; query relevant symbols or file paths and use the returned source and call paths.'
if [[ "${config_added}" -eq 1 ]]; then
  context="CodeGraph MCP server configuration was added to the project config. Start a new session for this configuration to take effect."
fi

# Escape the JSON characters without requiring a runtime dependency beyond Bash.
json_context="$(printf '%s' "$context" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$json_context"
