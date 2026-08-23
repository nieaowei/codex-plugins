# CodeGraph for Codex

This plugin connects Codex to the upstream CodeGraph CLI and its local
`codegraph_explore` MCP tool. CodeGraph indexes source code into a local graph,
traces cross-file relationships, and auto-syncs an indexed project as files
change. A SessionStart hook injects a concise CodeGraph usage reminder as
additional developer context.

## Setup

Install the upstream CLI on macOS or Linux from this plugin directory:

```bash
bash scripts/install-codegraph.sh
```

This installs the CodeGraph release pinned in `.codex-plugin/plugin.json`
(currently v1.5.0). Override with `CODEGRAPH_VERSION=x.y.z` when you need a
different release.

The plugin's MCP server starts `codegraph serve --mcp`; it does not modify Codex
configuration outside the plugin. The skill uses CodeGraph first for projects
that already contain a `.codegraph/` index;
unindexed projects are left to normal repository tools because indexing is the
user's decision:

```bash
bash scripts/ensure-index.sh /path/to/project
```

The index lives in `.codegraph/` and is local to that project. The watcher keeps
it fresh after initialization. Use `codegraph status <repo-root>` or
`codegraph sync <repo-root>` for diagnostics and manual synchronization. The
`ensure-index.sh` helper remains available for explicit user-directed setup; the
skill does not invoke it automatically. If the CLI or MCP is unavailable, the
skill reports that briefly and falls back to normal repository tools.

## Proactive use

For any implementation, bug fix, refactor, rename, test, review, or architecture
task, the skill queries `codegraph_explore` before broad file search or the first
edit in an indexed project — regardless of repository size or whether
relationships are obviously cross-file. It uses the graph to find entry points,
callers, callees, routes, dependencies, and impact, then uses exact file tools
only for symbols/files omitted by the graph, configs/docs, generated files, or
stale-banner files. Cross-file changes get a second callers/impact query before
they are finalized. If MCP is unavailable, equivalent CLI commands are
required substitutes.

## Included behavior

- `codegraph_explore` is the default MCP tool for semantic repository questions
  and pre-edit code reconnaissance.
- The `SessionStart` hook injects a hardcoded, concise reminder to use the
  `codegraph` skill through `hookSpecificOutput.additionalContext` on startup,
  resume, clear, and compact when a project index is present.
- The `codegraph` skill triggers on implementation and investigation work, with
  an explicit skip condition for projects without a `.codegraph/` index.
- The wrapper gives an actionable error when the CLI is not installed.

CodeGraph is MIT-licensed and runs locally. See the [upstream repository](https://github.com/colbymchenry/codegraph) and [documentation](https://colbymchenry.github.io/codegraph/) for the complete CLI, supported languages, and troubleshooting guide.
