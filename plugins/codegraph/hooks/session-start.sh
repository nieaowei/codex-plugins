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

# The hook already proved that this session has a CodeGraph index. Keep the
# injected reminder hardcoded so it remains concise and does not duplicate
# skill-routing metadata that has already been enforced above.
context='Use the `codegraph` skill for this task. Call `codegraph_explore` before grep, find, or reading indexed code; query relevant symbols or file paths and use the returned source and call paths.'

# Escape the JSON characters without requiring a runtime dependency beyond Bash.
json_context="$(printf '%s' "$context" | sed 's/\\/\\\\/g; s/"/\\"/g')"
printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$json_context"
