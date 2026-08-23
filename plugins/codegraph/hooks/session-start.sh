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

: "${PLUGIN_ROOT:?PLUGIN_ROOT must be set by Codex when running plugin hooks}"
skill_file="${PLUGIN_ROOT}/skills/codegraph/SKILL.md"

if [[ ! -f "${skill_file}" ]]; then
  exit 0
fi

description="$(sed -n '/^---[[:space:]]*$/,/^---[[:space:]]*$/ {
  /^description:[[:space:]]*/ {
    s/^description:[[:space:]]*//
    p
    q
  }
}' "${skill_file}")"

if [[ -z "${description}" ]]; then
  exit 0
fi

# The frontmatter description is a single line. Escape the JSON characters
# here so the hook has no runtime dependency beyond Bash.
json_description="$(printf '%s' "$description" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$json_description"
