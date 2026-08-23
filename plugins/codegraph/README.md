# CodeGraph for Codex

This plugin connects Codex to the local CodeGraph CLI. It provides the `codegraph_explore` MCP tool, a semantic-code skill, and a SessionStart check that preserves the existing index bootstrap behavior.

## Setup

The supported installer targets macOS and Linux:

```sh
cd plugins/codegraph
CODEGRAPH_VERSION=1.5.0 sh scripts/install-codegraph.sh
```

The MCP wrapper checks that `codegraph` is available and prints the setup command when it is missing. The installer uses a pinned upstream release; set `CODEGRAPH_VERSION` explicitly when upgrading.

## Runtime behavior

- The MCP server uses CodeGraph's built-in file watcher for normal synchronization.
- `CODEGRAPH_PROJECT_PATH` can select the project directory when a hook is launched from a nested working directory.
- Set `CODEGRAPH_NO_DAEMON=1` only when the watcher is disabled; then run `sh scripts/stop-sync.sh` for an explicit sync.
- Use CodeGraph's `projectPath` argument to query another already-indexed repository.

## Validation

```sh
python3 -m json.tool .codex-plugin/plugin.json >/dev/null
python3 -m json.tool .mcp.json >/dev/null
python3 -m json.tool hooks.json >/dev/null
for script in scripts/*.sh; do sh -n "$script"; done
```

See the [upstream CodeGraph README](https://github.com/colbymchenry/codegraph#readme) for CLI, MCP, watcher, and WSL2 troubleshooting details.
