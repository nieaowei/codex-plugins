#!/usr/bin/env bash
set -euo pipefail

LOCAL_CODEGRAPH_BIN="${CODEGRAPH_BIN_DIR:-${HOME}/.local/bin}/codegraph"
if [[ -x "${LOCAL_CODEGRAPH_BIN}" ]]; then
  CODEGRAPH_BIN="${LOCAL_CODEGRAPH_BIN}"
elif command -v codegraph >/dev/null 2>&1; then
  CODEGRAPH_BIN="$(command -v codegraph)"
else
  printf '%s\n' 'CodeGraph CLI is not installed or is not on PATH.' >&2
  printf '%s\n' 'Run CODEGRAPH_VERSION=1.5.0 bash scripts/install-codegraph.sh from the plugin directory.' >&2
  exit 127
fi

exec "${CODEGRAPH_BIN}" serve --mcp "$@"
