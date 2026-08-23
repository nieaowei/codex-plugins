# AGENTS.md

Plugin-specific rules for the CodeGraph Codex plugin. This file is read by
coding agents working on this plugin and supplements the repo-level
`AGENTS.md`.

## Plugin overview

Bundles the upstream CodeGraph CLI and its `codegraph_explore` MCP tool as a
Codex plugin. The skill uses CodeGraph first for indexed projects, skips
unindexed projects, and a SessionStart hook injects the current skill
description as additional developer context.

## Versioning contract

- The pinned upstream CodeGraph release lives in one place only: the
  `version` field of `.codex-plugin/plugin.json`, in the form
  `<upstream>+codex.<cachebuster>` (for example `1.5.0+codex.20260823171857`).
- `scripts/common.sh` derives the upstream version with
  `resolve_codegraph_version`, stripping the `+codex.*` suffix. Scripts and
  docs must never hardcode a version string; source the helper instead.
- To bump the pinned release, update the version prefix in the manifest and
  let the helper propagate it. Do not edit the `+codex.*` suffix by hand; use
  the plugin-creator `update_plugin_cachebuster.py` flow.

## Scripts

Three plugin bash scripts (all `set -euo pipefail`) plus `scripts/common.sh`:

- `common.sh` — sourced by the others. Sets `PLUGIN_ROOT`, and provides
  `resolve_codegraph_version` (from the manifest) and `resolve_codegraph_bin`
  (`CODEGRAPH_BIN_DIR` override, then `PATH`). Do not duplicate this logic.
- `install-codegraph.sh` — installs the pinned upstream release via the
  upstream installer; respects a `CODEGRAPH_VERSION` override.
- `mcp-server.sh` — resolves the binary and runs `codegraph serve --mcp`.
  Exits 127 with install guidance when the CLI is missing.
- `ensure-index.sh` — idempotent. Resolves the git root, skips when
  `.codegraph/` exists, otherwise runs `codegraph init` and verifies the index
  was actually created (exits non-zero otherwise).

## Skills

- `skills/codegraph/SKILL.md` is the only skill. Keep it aligned with upstream
  behavior (`codegraph_explore` is the only listed MCP tool; the CLI fallback
  commands mirror it).

## Hooks

- `hooks/hooks.json` registers the `SessionStart` hook for startup, resume,
  clear, and compact events.
- `hooks/session-start.sh` emits a hardcoded, concise reminder to use the
  `codegraph` skill through `hookSpecificOutput.additionalContext` after the
  index check passes. It also idempotently adds a project-scoped
  `mcp_servers.codegraph` entry to `.codex/config.toml` and tells the user to
  start a new session when that entry is created. Keep the output concise and
  avoid secrets. When the `codegraph` CLI is unavailable, it also instructs the
  agent to run the plugin's installation command automatically.

## Development workflow

1. Bump the upstream release by editing the version prefix in
   `.codex-plugin/plugin.json`; scripts pick it up automatically.
2. Bump the Codex cachebuster for local iteration with the plugin-creator
   `update_plugin_cachebuster.py` script.
3. Validate: run the plugin-creator `validate_plugin.py` against
   `plugins/codegraph` and `bash -n` every script and hook.
4. Reinstall from the `codex-plugins` marketplace and start a new thread to
   pick up the changes.

## Conventions

- Never hardcode a version or binary path in a script; use `common.sh`.
- Scripts must run on macOS and Linux with `set -euo pipefail`, no root
  privileges, and no unguarded destructive operations.
- Never log secrets or credentials. Downloads go through the pinned upstream
  installer.
