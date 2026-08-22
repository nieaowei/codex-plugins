#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OSSUTIL_VERSION="2.3.0"
CACHE_DIR="${XDG_CACHE_HOME:-${HOME}/.cache}/ossutil-plugin/${OSSUTIL_VERSION}"
CACHE_BIN="${CACHE_DIR}/ossutil"

log() { printf 'ossutil.sh: %s\n' "$*" >&2; }

version_major_of() {
  "$1" version 2>/dev/null | awk '{print $1}' | cut -d. -f1
}

OSSUTIL_BIN=""
if [[ -x "${CACHE_BIN}" ]]; then
  OSSUTIL_BIN="${CACHE_BIN}"
elif command -v ossutil >/dev/null 2>&1; then
  if [[ "$(version_major_of ossutil)" == "2" ]]; then
    OSSUTIL_BIN="$(command -v ossutil)"
  else
    log "ossutil on PATH is not version 2.x; need a 2.x binary (found $(ossutil version 2>/dev/null || echo unknown))"
    exit 1
  fi
else
  bash "${SCRIPT_DIR}/install-ossutil.sh"
  OSSUTIL_BIN="${CACHE_BIN}"
fi

exec "${OSSUTIL_BIN}" "$@"
