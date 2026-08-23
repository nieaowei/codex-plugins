#!/bin/sh
# Installs the CodeGraph CLI from the official upstream installer.
# Source: https://github.com/colbymchenry/codegraph (MIT)
set -eu

CODEGRAPH_VERSION="${CODEGRAPH_VERSION:-1.5.0}"
CODEGRAPH_VERSION="${CODEGRAPH_VERSION#v}"
export CODEGRAPH_VERSION
release_tag="v$CODEGRAPH_VERSION"

if command -v codegraph >/dev/null 2>&1; then
  installed_version=$(codegraph --version 2>/dev/null || true)
  case "$installed_version" in
    "$CODEGRAPH_VERSION"|"v$CODEGRAPH_VERSION")
      echo "codegraph ${installed_version} already installed: $(command -v codegraph)"
      exit 0
      ;;
    *)
      echo "Replacing codegraph ${installed_version:-unknown} with ${CODEGRAPH_VERSION}."
      ;;
  esac
fi

case "$(uname -s)" in
  Darwin|Linux)
    command -v curl >/dev/null 2>&1 || {
      echo "curl is required to install CodeGraph." >&2
      exit 1
    }
    curl -fsSL "https://raw.githubusercontent.com/colbymchenry/codegraph/$release_tag/install.sh" | sh
    bin_dir="${CODEGRAPH_BIN_DIR:-$HOME/.local/bin}"
    if [ -x "$bin_dir/codegraph" ]; then
      echo "Installed CodeGraph ${CODEGRAPH_VERSION} at $bin_dir/codegraph."
      echo "Open a new shell if $bin_dir is not already on PATH."
    else
      echo "Installer completed, but $bin_dir/codegraph was not found." >&2
      echo "Check the installer output and PATH before starting the MCP server." >&2
      exit 1
    fi
    ;;
  *)
    echo "Unsupported shell target; on Windows use install.ps1 from the upstream repo." >&2
    exit 1
    ;;
esac
