---
name: codegraph
description: Use the CodeGraph CLI for semantic code questions in an indexed repository. Trigger when a task needs cross-file symbol lookup, call-path tracing, impact analysis, or when a .codegraph/ directory exists at the repo root and the user asks to explore or explain code.
---

# CodeGraph

CodeGraph builds a local, pre-indexed code knowledge graph (100% local, auto-syncs on code changes). Querying it is usually cheaper and more precise than grep for cross-file questions.

## Check availability

1. If the repo root has a `.codegraph/` directory, prefer CodeGraph over grep/find for locating code.
2. Verify the CLI exists: `command -v codegraph`. If missing, run the plugin installer from the plugin directory:

   ```bash
   CODEGRAPH_VERSION=1.5.0 sh scripts/install-codegraph.sh
   ```

   The installer pins the upstream release and reports when the installed binary is not on PATH. Open a new shell if it installs into `~/.local/bin`.

## Initialize a project

```bash
cd <repo-root>
codegraph init
```

This creates `.codegraph/` and builds the full graph in one step.

## Querying

Run `codegraph --help` first if unsure of subcommands. Typical flows:

- Explore symbols/call paths with the default `codegraph_explore` MCP tool before reading files blindly.
- Keep queries narrow; fall back to `rg` only for plain-text matches the graph cannot answer.
- The graph auto-syncs on file changes; do not re-init after edits.
- For another indexed repository, pass its absolute path as `projectPath`.
- For a project without an index, stop using CodeGraph for that project and tell the user they can run `codegraph init` explicitly.

The CLI also provides `version`, `upgrade`, `affected`, `unlock`, `uninit`, `daemon`, and `telemetry` for maintenance and diagnostics.

## MCP server

This plugin ships an `.mcp.json` that starts a small wrapper and then launches `codegraph serve --mcp` over stdio. The wrapper gives an actionable error when the CLI is missing. CodeGraph's default MCP surface exposes `codegraph_explore`; use `projectPath` for a second indexed repository.

The MCP server watches files and normally syncs automatically. Set `CODEGRAPH_NO_DAEMON=1` only when the watcher is unavailable, then run `sh scripts/stop-sync.sh` as an explicit fallback. On WSL2 `/mnt` filesystems, consult the upstream troubleshooting guidance and consider `CODEGRAPH_NO_DAEMON=1`.

## References

- Upstream: https://github.com/colbymchenry/codegraph
- Docs: https://colbymchenry.github.io/codegraph/
- License: MIT
