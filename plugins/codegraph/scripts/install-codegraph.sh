#!/bin/sh
# Installs the CodeGraph CLI from the official upstream installer.
# Source: https://github.com/colbymchenry/codegraph (MIT)
set -euo pipefail

if command -v codegraph >/dev/null 2>&1; then
  echo "codegraph already installed: $(command -v codegraph)"
  exit 0
fi

case "$(uname -s)" in
  Darwin|Linux)
    curl -fsSL https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.sh | sh
    echo "Installed. Open a new shell so 'codegraph' resolves on PATH."
    ;;
  *)
    echo "Unsupported shell target; on Windows use install.ps1 from the upstream repo." >&2
    exit 1
    ;;
esac
