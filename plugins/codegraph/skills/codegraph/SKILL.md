---
name: codegraph
description: Proactively use CodeGraph for repository-understanding intent, including cross-file symbol lookup, call-path tracing, dependency exploration, route analysis, architecture questions, or impact analysis. Trigger even when .codegraph is missing; initialize the current project before querying when the user asks to understand or trace code.
---

# CodeGraph

CodeGraph is a local semantic index for source code. It follows symbols, imports,
call edges, framework routes, and impact paths so Codex can answer repository
questions without crawling files one by one.

## Intent detection and workflow

Use CodeGraph when the user asks questions such as “how does this flow work?”,
“what calls this function?”, “what breaks if I change this?”, “where is this
route handled?”, or otherwise needs relationships across files. Prefer the
`codegraph_explore` MCP tool for these intents.

For a matching intent, follow this sequence:

1. Determine the repository root. Prefer the current workspace root; otherwise
   resolve it with `git -C <path> rev-parse --show-toplevel`.
2. Check whether `<repo-root>/.codegraph/` exists.
3. If it does not exist, proactively run the plugin helper to create the index:

   ```bash
   bash scripts/ensure-index.sh <repo-root>
   ```

   This is an explicit user-requested workflow: `codegraph init` writes a local
   `.codegraph/` index and may take time on large repositories. Do not run it for
   unrelated tasks such as a one-file text lookup.
4. Query `codegraph_explore`, passing the absolute repository path as
   `projectPath` when the MCP server is not clearly rooted there.
5. Keep the query narrow and name important symbols, files, or flows. Fall back
   to built-in file tools if initialization or querying fails.

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

The helper initializes a project only after a matching repository-understanding
intent has been detected:

```bash
bash scripts/ensure-index.sh <repo-root>
```

Do not re-initialize an existing project after ordinary edits. The file watcher
keeps an existing index current.

## CLI fallback

The MCP server exposes `codegraph_explore` by default. If MCP is unavailable,
use the equivalent CLI commands:

```bash
codegraph explore "How does the request flow reach the handler?"
codegraph node <symbol-or-file>
codegraph callers <symbol>
codegraph callees <symbol>
codegraph impact <symbol>
codegraph status
```

For another repository, pass its absolute path as `projectPath` to the MCP tool;
run `bash scripts/ensure-index.sh <repo-root>` first when that repository has no
index.

## Freshness and safety

CodeGraph is local-only and does not require API keys. Its watcher normally
auto-syncs changes. If a sandbox prevents the watcher, run `codegraph sync`
explicitly before querying. For WSL2 projects under `/mnt`, consult the upstream
troubleshooting guidance and consider `CODEGRAPH_NO_DAEMON=1`.

## References

- Upstream repository: https://github.com/colbymchenry/codegraph
- Documentation: https://colbymchenry.github.io/codegraph/
- License: MIT
