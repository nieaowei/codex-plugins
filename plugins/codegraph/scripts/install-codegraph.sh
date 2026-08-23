#!/usr/bin/env bash
set -euo pipefail

CODEGRAPH_VERSION="${CODEGRAPH_VERSION:-1.5.0}"
CODEGRAPH_VERSION="${CODEGRAPH_VERSION#v}"
RELEASE_TAG="v${CODEGRAPH_VERSION}"
export CODEGRAPH_VERSION

case "$(uname -s)" in
  Darwin|Linux) ;;
  *)
    printf 'Unsupported operating system: %s. Use install.ps1 from the upstream repository on Windows.\n' "$(uname -s)" >&2
    exit 1
    ;;
esac

command -v curl >/dev/null 2>&1 || {
  printf '%s\n' 'curl is required to install CodeGraph.' >&2
  exit 1
}

curl -fsSL "https://raw.githubusercontent.com/colbymchenry/codegraph/${RELEASE_TAG}/install.sh" | bash

BIN_DIR="${CODEGRAPH_BIN_DIR:-${HOME}/.local/bin}"
if [[ -x "${BIN_DIR}/codegraph" ]]; then
  printf 'Installed CodeGraph %s at %s/codegraph.\n' "${CODEGRAPH_VERSION}" "${BIN_DIR}"
  printf '%s\n' "Open a new shell if ${BIN_DIR} is not already on PATH."
else
  printf '%s\n' 'The upstream installer completed, but the CodeGraph binary was not found.' >&2
  exit 1
fi
