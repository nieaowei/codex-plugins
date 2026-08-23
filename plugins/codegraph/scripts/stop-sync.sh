#!/bin/sh
set -eu

command -v codegraph >/dev/null 2>&1 || exit 0

[ "${CODEGRAPH_NO_DAEMON:-0}" = "1" ] || exit 0

project_dir="${CODEGRAPH_PROJECT_PATH:-$(pwd -P)}"
if command -v git >/dev/null 2>&1; then
  git_root=$(git -C "$project_dir" rev-parse --show-toplevel 2>/dev/null || true)
  [ -z "$git_root" ] || project_dir="$git_root"
fi

codegraph sync --quiet "$project_dir"
exit 0
