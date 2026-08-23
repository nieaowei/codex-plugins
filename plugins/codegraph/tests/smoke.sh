#!/bin/sh
set -eu

plugin_root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd -P)

python3 - "$plugin_root" <<'PY'
import json
import pathlib
import sys

root = pathlib.Path(sys.argv[1])
manifest = json.loads((root / ".codex-plugin/plugin.json").read_text())
assert manifest["hooks"] == "./hooks.json"
assert (root / manifest["hooks"]).is_file()
assert (root / manifest["mcpServers"]).is_file()
json.loads((root / "hooks.json").read_text())
json.loads((root / ".mcp.json").read_text())
PY

for script in "$plugin_root"/scripts/*.sh; do
  sh -n "$script"
done

if PATH=/usr/bin:/bin sh "$plugin_root/scripts/mcp-server.sh" >/dev/null 2>"$plugin_root/.mcp-smoke.err"; then
  echo "mcp wrapper unexpectedly found codegraph" >&2
  exit 1
fi
grep -q "CodeGraph CLI is not installed" "$plugin_root/.mcp-smoke.err"
rm -f "$plugin_root/.mcp-smoke.err"

echo "codegraph plugin smoke checks passed"
