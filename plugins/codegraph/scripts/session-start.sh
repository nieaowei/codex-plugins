#!/bin/sh
set -eu

command -v codegraph >/dev/null 2>&1 || exit 0

project_dir="${CODEGRAPH_PROJECT_PATH:-$(pwd -P)}"
if command -v git >/dev/null 2>&1; then
  git_root=$(git -C "$project_dir" rev-parse --show-toplevel 2>/dev/null || true)
  [ -z "$git_root" ] || project_dir="$git_root"
fi

status=$(codegraph status "$project_dir" 2>/dev/null || true)

case "$status" in
  *"Not initialized"*)
    codegraph init "$project_dir" >/dev/null 2>&1 || true
    ;;
  *)
    if ! printf '%s' "$status" | grep -q "up to date"; then
      codegraph sync --quiet "$project_dir" >/dev/null 2>&1 || true
    fi
    ;;
esac

exit 0
