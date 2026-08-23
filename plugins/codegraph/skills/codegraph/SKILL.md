---
name: codegraph
description: Use CodeGraph in repositories with a .codegraph/ index before grep, find, or file reads; query symbols, files, and call paths with codegraph_explore or codegraph explore, and skip unindexed projects.
---

## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at repo
root), reach for it BEFORE grep/find or reading files when you need to
understand or locate code:

- **MCP tool — use it first, always:** `codegraph_explore` answers most code
  questions in one call — the relevant symbols' verbatim source plus the call
  paths between them, including dynamic-dispatch hops grep can't follow. Name a
  file or symbol in the query to read its current line-numbered source.
- **Never assume MCP is unavailable.** Before falling back to the shell, look the
  MCP tool up in the tool catalog, including deferred/nested MCP tools reachable
  through a `tools.*` namespace (e.g. `mcp__codegraph__codegraph_explore`). A
  tool absent from the top-level list is not proof it is missing.
- **Shell (only if no MCP `codegraph_explore` exists):**
  `codegraph explore "<symbol names or question>"` prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is
the user's decision.

## MCP Server instructions

CodeGraph is a SQLite knowledge graph of every symbol, edge, and file in the
workspace. It pre-computes structure that would otherwise be re-derived by
reading files, supports 30+ languages, and is kept current by a file watcher
(the index can lag writes briefly). Reach for it BEFORE and while writing or
editing code, not just for questions: one call returns the verbatim source plus
who calls it and what it affects, so the blast radius stays visible.

### One tool: `codegraph_explore`

`codegraph_explore` is Read-equivalent. It accepts a natural-language question
or a bag of symbol/file names and returns the relevant **verbatim,
line-numbered source** grouped by file, plus the call path (including
dynamic-dispatch hops such as callbacks, React re-renders, and JSX children) and
a blast-radius summary.

Always pass `projectPath` with the absolute path of the target repository (or a
directory inside it). The server resolves the nearest `.codegraph/` index from
that path; do not rely on an implicit default project.

Whether answering how something works or implementing a change, call
`codegraph_explore` before reading indexed files. One call usually answers the
whole question. CodeGraph is the pre-built search index, so a manual
grep/read loop or a delegated file-reading task repeats work it has already
done.

### How to query

- For architecture, bugs, “what/where is X”, or an area survey, use a natural-
  language question or the relevant names in one `codegraph_explore` call.
- For a flow or path from X to Y, name the symbols spanning the flow (for
  example, `mutateElement renderScene`) so the call path and dynamic-dispatch
  hops are surfaced.
- For a file or symbol you can name, include its name or path so the current
  line-numbered source is returned with its call path and blast radius.
- If more detail is needed, call `codegraph_explore` again with more specific
  names; treat returned source as already read.

### Anti-patterns

- Trust CodeGraph results instead of re-verifying them with grep.
- Do not grep or read first to find or understand indexed code; use one
  `codegraph_explore` call. Use raw tools only for details CodeGraph did not
  cover or for files it does not index, such as configs and docs.
- Do not reconstruct a flow by hand; name its endpoints and let CodeGraph
  surface the path.
- After editing, check for a staleness banner. If a response says files were
  edited since the last index sync, read those specific files for accurate
  content. If CodeGraph reports that auto-sync is disabled, read files directly
  until live watching is restored.
- If a file is flagged as changed on disk after the last sync, trust a full
  current source response; if source is omitted, read that specific file.
  Unflagged files remain trustworthy.
- If a file says “Already sent earlier in this conversation”, reuse the earlier
  source instead of fetching or reading it again, provided it has not changed.

### Limitations

- If a project is reported as not indexed, stop calling CodeGraph for that
  project for the rest of the session and use built-in tools there instead.
  Indexing is the user's decision; mention `codegraph init` only as an option.
- Index freshness may lag file writes briefly.
- Cross-file resolution is best-effort name matching; ambiguous calls may
  return multiple candidates.
- CodeGraph does not validate correctness; compilers, tests, and linters still
  do that.
