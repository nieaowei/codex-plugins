#!/bin/sh
set -euo pipefail

command -v codegraph >/dev/null 2>&1 || exit 0
[ -d .codegraph ] || exit 0

codegraph sync --quiet >/dev/null 2>&1 || true
exit 0
