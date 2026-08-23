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
configuration outside the plugin. The skill makes CodeGraph the mandatory first
step for code changes and investigations, even when the user does not mention
CodeGraph. For matching repository tasks it automatically initializes an
unindexed project before querying; only exact single-file lookups,
self-contained docs/config edits, or explicit user opt-out skip it:

```bash
bash scripts/ensure-index.sh /path/to/project
```

The index lives in `.codegraph/` and is local to that project. The watcher keeps
it fresh after initialization. Use `codegraph status <repo-root>` or
`codegraph sync <repo-root>` for diagnostics and manual synchronization. Exact
one-file lookups, self-contained docs/config edits, and unrelated tasks do not
trigger initialization. If initialization, the CLI, or MCP fails, the skill
reports that briefly and falls back to normal repository tools.

## Proactive use

For any implementation, bug fix, refactor, rename, test, review, or architecture
task, the skill queries `codegraph_explore` before broad file search or the first
edit — regardless of repository size or whether relationships are obviously
cross-file. It uses the graph to find entry points, callers, callees, routes,
dependencies, and impact, then uses exact file tools only for symbols/files
omitted by the graph, configs/docs, generated files, or stale-banner files.
Cross-file changes get a second callers/impact query before they are finalized.
If MCP is unavailable, equivalent CLI commands are required substitutes. If
initialization also fails, the skill reports that briefly and falls back to
normal repository tools.

## Included behavior

- `codegraph_explore` is the default MCP tool for semantic repository questions
  and pre-edit code reconnaissance.
- The `codegraph` skill triggers on implementation and investigation work, with
  explicit skip conditions for isolated one-file and plain-text tasks.
- The wrapper gives an actionable error when the CLI is not installed.

CodeGraph is MIT-licensed and runs locally. See the [upstream repository](https://github.com/colbymchenry/codegraph) and [documentation](https://colbymchenry.github.io/codegraph/) for the complete CLI, supported languages, and troubleshooting guide.
