# CodeGraph for Codex

This plugin connects Codex to the upstream CodeGraph CLI and its local
`codegraph_explore` MCP tool. CodeGraph indexes source code into a local graph,
traces cross-file relationships, and auto-syncs an initialized project as files
change.

## Setup

Install the upstream CLI on macOS or Linux from this plugin directory:

```bash
CODEGRAPH_VERSION=1.5.0 bash scripts/install-codegraph.sh
```

The plugin's MCP server starts `codegraph serve --mcp`; it does not modify Codex
configuration outside the plugin. When Codex detects a repository-understanding
intent, the skill automatically initializes the project if `.codegraph/` is
missing:

```bash
bash scripts/ensure-index.sh /path/to/project
```

The index lives in `.codegraph/` and is local to that project. The watcher keeps
it fresh after initialization. Use `codegraph status` or `codegraph sync` for
diagnostics and manual synchronization. Exact one-file lookups and unrelated
tasks do not trigger initialization.

## Included behavior

- `codegraph_explore` is the default MCP tool for semantic repository questions.
- The `codegraph` skill teaches when to query the graph and when to fall back to
  exact file tools.
- The wrapper gives an actionable error when the CLI is not installed.

CodeGraph is MIT-licensed and runs locally. See the [upstream repository](https://github.com/colbymchenry/codegraph) and [documentation](https://colbymchenry.github.io/codegraph/) for the complete CLI, supported languages, and troubleshooting guide.
