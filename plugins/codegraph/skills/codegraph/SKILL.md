---
name: codegraph
description: Use CodeGraph proactively as the first repository map for implementation, debugging, refactoring, testing, review, and architecture work. Trigger before reading or editing code when callers, callees, routes, dependencies, or change impact are uncertain; automatically initialize an unindexed project for matching tasks, do not wait for the user to name CodeGraph, and fall back only when initialization or CodeGraph is unavailable or the task is an exact one-file lookup.
---

# CodeGraph

CodeGraph is a local semantic index for source code. It follows symbols, imports,
call edges, framework routes, and impact paths so Codex can answer repository
questions without crawling files one by one.

## When to activate

Do not wait for the user to say “CodeGraph”. Treat CodeGraph as the default
first-pass map whenever the task is a code change or investigation and any of
these are true:

- the request says add, fix, change, refactor, rename, test, review, debug, or
  explain a feature;
- the target symbol may have callers, callees, route registrations, generated
  adapters, or tests in other files;
- the task asks for a flow, dependency, ownership, architecture, regression
  surface, or impact assessment; or
- the repository already has a `.codegraph/` index.

Skip conditions take precedence even when an index exists: skip the graph for
an exact one-file text lookup, a self-contained docs/config edit, or a task
where the user explicitly asks not to inspect related code. When uncertain,
make one narrow CodeGraph query; a cheap map is preferable to blindly opening a
large tree.

## Required workflow

For a matching task, follow this sequence before broad `rg`, file crawling, or
the first edit:

1. Determine the repository root. Prefer the current workspace root; otherwise
   resolve it with `git -C <path> rev-parse --show-toplevel`.
2. Check whether `<repo-root>/.codegraph/` exists and check the CLI with
   `command -v codegraph`.
3. If the project is not indexed, automatically initialize it once before the
   first graph query:

   ```bash
   bash "${PLUGIN_ROOT}/scripts/ensure-index.sh" <repo-root>
   ```

   Resolve `${PLUGIN_ROOT}` to the installed plugin directory when the variable
   is not exported. This plugin intentionally opts into local initialization for
   matching repository tasks; do not run it for one-file or unrelated work.
   Wait for it to finish, verify the index exists, and then continue with the
   `codegraph_explore` query. The helper is idempotent when an index already
   exists.
4. Call the `codegraph_explore` MCP tool first, passing the absolute
   `projectPath` only when querying a repository other than the MCP server's
   current root. Keep the query narrow and name the important symbol, file,
   route, or flow.
5. Treat the returned line-numbered source as already read. Use its symbols and
   call paths to choose edits; do not reopen or grep-check the same indexed
   source. Use exact file tools only for symbols/files omitted by the graph,
   generated files, plain text, or configuration.
6. For a cross-file change, query the relevant symbol's callers/callees or
   impact again before finalizing, then inspect affected tests. This second
   pass is the graph-backed regression check.
7. If initialization, MCP, or the CLI fails, state the failure briefly and use
   built-in tools as a fallback; do not retry the same failing command blindly.

### Query recipes

- New feature or refactor: explore the entry point, its callers/callees, and
  the nearest tests before editing.
- Bug or unexpected behavior: explore the failing route/flow and both sides of
  the suspicious symbol before changing it.
- Rename or API change: explore callers and impact, then inspect affected tests.
- Code review: explore the changed symbols and their impact radius before
  deciding whether a finding is isolated or cross-module.
- Architecture question: explore the named subsystem and its dependency/route
  boundary, then use exact files for implementation details.

## Setup and project indexing

Check availability before relying on the CLI:

```bash
command -v codegraph
```

If it is missing on macOS or Linux, install the pinned upstream release from the
plugin directory:

```bash
CODEGRAPH_VERSION=1.5.0 bash scripts/install-codegraph.sh
```

Then open a new shell if `~/.local/bin` is not already on `PATH`.

The helper automatically creates a local index for a matching task when one is
missing:

```bash
bash "${PLUGIN_ROOT}/scripts/ensure-index.sh" <repo-root>
```

Do not re-initialize an existing project after ordinary edits. The file watcher
keeps an existing index current.

## CLI fallback

The MCP server exposes `codegraph_explore` by default. If MCP is unavailable,
use the equivalent CLI commands:

```bash
codegraph explore --path <repo-root> "How does the request flow reach the handler?"
codegraph node --path <repo-root> <symbol-or-file>
codegraph callers --path <repo-root> <symbol>
codegraph callees --path <repo-root> <symbol>
codegraph impact --path <repo-root> <symbol>
codegraph status <repo-root>
```

For another repository, pass its absolute path as `projectPath` to the MCP tool
and include that path in CLI commands when supported. Initialize it with the
helper above once before querying when it has no index.

## Freshness and safety

CodeGraph is local-only and does not require API keys. Its watcher normally
auto-syncs changes. If the status is stale or a sandbox prevents the watcher,
run `codegraph sync <repo-root>` explicitly before querying. For WSL2 projects
under `/mnt`, consult the upstream troubleshooting guidance and consider
`CODEGRAPH_NO_DAEMON=1`. An empty or no-result graph is not proof that a symbol
does not exist; verify the index status and fall back to exact file tools. If a
response marks files as edited since the last sync, read those listed files
directly; if auto-sync is disabled, use built-in tools for changed code until
the watcher is restored.

## References

- Upstream repository: https://github.com/colbymchenry/codegraph
- Documentation: https://colbymchenry.github.io/codegraph/
- License: MIT
