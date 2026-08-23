#!/usr/bin/env bash
# Shared helpers for the CodeGraph plugin scripts.
#
# Source, do not execute. Consumers run with 'set -euo pipefail' and source via:
#
#   source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/common.sh"
#
# The single source of truth for the pinned upstream CodeGraph release is the
# plugin manifest. The manifest version is '<upstream>+codex.<cachebuster>';
# the helpers below strip the Codex suffix so scripts and the manifest never
# drift from each other.

# Absolute plugin root, derived from this file's location (scripts/../).
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

# Resolve the upstream CodeGraph release pinned in .codex-plugin/plugin.json.
# Prints the version (e.g. 1.5.0) and returns 0, or returns 1 when the manifest
# is missing or carries no resolvable version.
resolve_codegraph_version() {
  local manifest="${PLUGIN_ROOT}/.codex-plugin/plugin.json"
  local version=""
  [[ -f "${manifest}" ]] || return 1
  version="$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "${manifest}" | head -n1)"
  version="${version%%+*}"
  [[ -n "${version}" ]] || return 1
  printf '%s' "${version}"
}

# Locate the codegraph binary: prefer CODEGRAPH_BIN_DIR, then PATH.
# Prints the resolved path and returns 0, or returns 1 when not found.
resolve_codegraph_bin() {
  local local_bin="${CODEGRAPH_BIN_DIR:-${HOME}/.local/bin}/codegraph"
  if [[ -x "${local_bin}" ]]; then
    printf '%s' "${local_bin}"
  elif command -v codegraph >/dev/null 2>&1; then
    command -v codegraph
  else
    return 1
  fi
}

