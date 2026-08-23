#!/usr/bin/env bash
set -euo pipefail

# Shared helpers: PLUGIN_ROOT, resolve_codegraph_version, resolve_codegraph_bin
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/common.sh"

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

if ! CODEGRAPH_BIN="$(resolve_codegraph_bin)"; then
  printf '%s\n' 'CodeGraph CLI is not installed or is not on PATH.' >&2
  printf 'Run CODEGRAPH_VERSION=%s bash scripts/install-codegraph.sh from the plugin directory.\n' "$(resolve_codegraph_version || true)" >&2
  exit 127
fi

if [[ -d "${project_dir}/.codegraph" ]]; then
  printf 'CodeGraph index already exists: %s/.codegraph\n' "${project_dir}"
  exit 0
fi

printf 'Initializing CodeGraph index: %s\n' "${project_dir}"
if ! "${CODEGRAPH_BIN}" init "${project_dir}"; then
  printf 'CodeGraph init failed for: %s\n' "${project_dir}" >&2
  exit 1
fi

if [[ ! -d "${project_dir}/.codegraph" ]]; then
  printf 'CodeGraph init completed but did not create %s/.codegraph\n' "${project_dir}" >&2
  exit 1
fi

printf 'CodeGraph index initialized: %s/.codegraph\n' "${project_dir}"

