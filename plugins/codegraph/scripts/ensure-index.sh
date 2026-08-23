#!/usr/bin/env bash
set -euo pipefail

if [[ $# -gt 1 ]]; then
  printf 'Usage: %s [repo-root]\n' "$0" >&2
  exit 2
fi

project_dir="${1:-${CODEGRAPH_PROJECT_PATH:-$(pwd -P)}}"
project_dir="$(cd "${project_dir}" && pwd -P)"

if command -v git >/dev/null 2>&1; then
  git_root="$(git -C "${project_dir}" rev-parse --show-toplevel 2>/dev/null || true)"
  if [[ -n "${git_root}" ]]; then
    project_dir="${git_root}"
  fi
fi

local_bin="${CODEGRAPH_BIN_DIR:-${HOME}/.local/bin}/codegraph"
if [[ -x "${local_bin}" ]]; then
  CODEGRAPH_BIN="${local_bin}"
elif command -v codegraph >/dev/null 2>&1; then
  CODEGRAPH_BIN="$(command -v codegraph)"
else
  printf '%s\n' 'CodeGraph CLI is not installed or is not on PATH.' >&2
  printf '%s\n' 'Run CODEGRAPH_VERSION=1.5.0 bash scripts/install-codegraph.sh from the plugin directory.' >&2
  exit 127
fi

if [[ -d "${project_dir}/.codegraph" ]]; then
  printf 'CodeGraph index already exists: %s/.codegraph\n' "${project_dir}"
  exit 0
fi

printf 'Initializing CodeGraph index: %s\n' "${project_dir}"
exec "${CODEGRAPH_BIN}" init "${project_dir}"
