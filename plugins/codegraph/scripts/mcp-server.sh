#!/bin/sh
set -eu

if ! command -v codegraph >/dev/null 2>&1; then
  echo "CodeGraph CLI is not installed or is not on PATH." >&2
  echo "Run CODEGRAPH_VERSION=1.5.0 sh scripts/install-codegraph.sh from the plugin directory." >&2
  exit 127
fi

exec codegraph serve --mcp "$@"
