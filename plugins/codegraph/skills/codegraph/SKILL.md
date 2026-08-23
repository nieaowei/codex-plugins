---
name: codegraph
description: Use CodeGraph before grep, find, or reading files when a repository has a .codegraph/ index; skip CodeGraph when the index is absent.
---

## CodeGraph

In repositories indexed by CodeGraph (a `.codegraph/` directory exists at repo
root), reach for it BEFORE grep/find or reading files when you need to
understand or locate code:

- **MCP tool (when available):** `codegraph_explore` answers most code questions
  in one call — the relevant symbols' verbatim source plus the call paths
  between them, including dynamic-dispatch hops grep can't follow. Name a file
  or symbol in the query to read its current line-numbered source.
- **Shell (always works):** `codegraph explore "<symbol names or question>"`
  prints the same output.

If there is no `.codegraph/` directory, skip CodeGraph entirely — indexing is
the user's decision.
