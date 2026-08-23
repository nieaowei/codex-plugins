#!/bin/sh
set -euo pipefail

command -v codegraph >/dev/null 2>&1 || exit 0

status=$(codegraph status 2>/dev/null || true)

case "$status" in
  *"Not initialized"*)
    codegraph init --quiet >/dev/null 2>&1 || codegraph init >/dev/null 2>&1 || true
    ;;
  *)
    if ! printf '%s' "$status" | grep -q "up to date"; then
      codegraph sync --quiet >/dev/null 2>&1 || true
    fi
    ;;
esac

exit 0
