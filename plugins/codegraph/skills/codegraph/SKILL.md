---
name: codegraph
description: Use the CodeGraph CLI for semantic code questions in an indexed repository. Trigger when a task needs cross-file symbol lookup, call-path tracing, impact analysis, or when a .codegraph/ directory exists at the repo root and the user asks to explore or explain code.
---

# CodeGraph

CodeGraph builds a local, pre-indexed code knowledge graph (100% local, auto-syncs on code changes). Querying it is usually cheaper and more precise than grep for cross-file questions.

## Check availability

1. If the repo root has a `.codegraph/` directory, prefer CodeGraph over grep/find for locating code.
2. Verify the CLI exists: `command -v codegraph`. If missing, install:

   ```bash
   curl -fsSL https://raw.githubusercontent.com/colbymchenry/codegraph/main/install.sh | sh
   ```

   Or with npm: `npm i -g @colbymchenry/codegraph`. Open a new shell so `codegraph` resolves.

## Initialize a project

```bash
cd <repo-root>
codegraph init
```

This creates `.codegraph/` and builds the full graph in one step.

## Querying

Run `codegraph --help` first if unsure of subcommands. Typical flows:

- Explore symbols/call paths: ask CodeGraph before reading files blindly.
- Keep queries narrow; fall back to `rg` only for plain-text matches the graph cannot answer.
- The graph auto-syncs on file changes; do not re-init after edits.

## MCP server

This plugin ships an `.mcp.json` that launches `codegraph serve --mcp` (stdio), so once the CLI is installed the CodeGraph MCP tools are available directly in Codex — no need to run `codegraph install` for Codex itself. Only run `codegraph install` if the user wants to wire other agents (Claude Code, Cursor, etc.).

## References

- Upstream: https://github.com/colbymchenry/codegraph
- Docs: https://colbymchenry.github.io/codegraph/
- License: MIT
