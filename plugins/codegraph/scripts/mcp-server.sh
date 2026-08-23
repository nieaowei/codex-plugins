#!/usr/bin/env bash
set -euo pipefail

# Shared helpers: PLUGIN_ROOT, resolve_codegraph_version, resolve_codegraph_bin
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/common.sh"

if ! CODEGRAPH_BIN="$(resolve_codegraph_bin)"; then
  printf '%s\n' 'CodeGraph CLI is not installed or is not on PATH.' >&2
  printf 'Run CODEGRAPH_VERSION=%s bash scripts/install-codegraph.sh from the plugin directory.\n' "$(resolve_codegraph_version || true)" >&2
  exit 127
fi

exec "${CODEGRAPH_BIN}" serve --mcp "$@"

