## AGENTS.md

This file is read by coding agents (Codex, Claude, etc.) working on this plugin. It describes the plugin's architecture, conventions, and development workflow.

## Plugin overview

A Codex plugin that bundles the official ossutil 2.0 CLI and its Chinese documentation as a skill. The skill teaches Codex to construct correct ossutil commands for managing Alibaba Cloud OSS buckets and objects.

The plugin is distributed as a personal Codex marketplace entry; the skill is auto-installed when the plugin is loaded.

## Directory structure

```
plugins/aliyun-ossutil/
  .codex-plugin/plugin.json    # Plugin manifest: name, version, skills path, interface
  AGENTS.md                    # This file
  scripts/
    ossutil.sh                 # Wrapper that resolves the binary and delegates to it
    install-ossutil.sh         # Download, checksum-verify, and cache the ossutil binary
  skills/
    ossutil2/
      SKILL.md                 # Skill definition: when to use, workflow, safety rules
      references/              # One .md per command + overview, all extracted from official docs
        ossutil2-概览.md       # Install, config, credentials, command structure
        00-高级命令.md          # Advanced commands intro
        01-append-追加上传.md
        02-cat-输出文件内容.md
        03-cp-上传下载和拷贝文件.md
        04-du-获取大小.md
        05-hash-计算CRC64或MD5.md
        06-ls-列举账号级别下的资源.md
        07-mb-创建存储空间.md
        08-mkdir-创建目录.md
        09-presign-生成预签名URL.md
        10-restore-解冻文件.md
        11-unrestore-清理已解冻对象.md
        12-revert-恢复版本.md
        13-rm-删除.md
        14-rb-删除存储空间.md
        15-set-props-设置对象属性.md
        16-stat-查看Bucket和Object信息.md
```

## Architecture

### plugin.json

The manifest declares the plugin's identity and interface. Key fields:

- `name`: `aliyun-ossutil` — the plugin identifier
- `version`: `2.3.0+codex.YYYYMMDDHHMMSS` — upstream ossutil version + Codex build timestamp
- `skills`: `./skills/` — path to the skills directory, relative to the plugin root
- `interface.defaultPrompt`: Three example prompts shown in the Codex plugin UI

When updating the ossutil version, update both `version` in plugin.json and `OSSUTIL_VERSION` in both scripts.

### Scripts

Two bash scripts that handle binary resolution and installation:

**ossutil.sh** — the entry point. Resolution order:
1. Cached binary at `~/.cache/ossutil-plugin/<version>/ossutil`
2. `ossutil` on PATH, but only if it is version 2.x (1.x is rejected)
3. Falls through to `install-ossutil.sh` for first-time download

**install-ossutil.sh** — downloads the platform-appropriate zip from `gosspublic.alicdn.com`, verifies SHA256, extracts, and caches the binary. Supported platforms: macOS arm64/x86_64, Linux amd64/arm64/arm/386. Windows is not supported by the install script.

Both scripts source their version from `OSSUTIL_VERSION` at the top. When bumping the version, update:
1. `OSSUTIL_VERSION` in both scripts
2. Download URLs and SHA256 checksums in `install-ossutil.sh`
3. The `version` field in `plugin.json`
4. The download table in `skills/ossutil2/references/ossutil2-概览.md`

### Skills

The `ossutil2` skill teaches Codex how to use ossutil. The `SKILL.md` is the entry point; it describes when to trigger the skill, the workflow, safety rules, and configuration guidance. It references the `references/` directory for command-specific documentation.

Each reference file covers one ossutil command, sourced from the official Alibaba Cloud documentation. The filenames are numbered for ordering and include both the command name and a Chinese description (e.g. `03-cp-上传下载和拷贝文件.md`).

## Reference extraction

All reference files under `skills/ossutil2/references/` are extracted from the official Alibaba Cloud OSS documentation using browser automation. The source pages are:

- Official docs base: `https://help.aliyun.com/zh/oss/developer-reference/`
- Advanced commands section: `https://help.aliyun.com/zh/oss/developer-reference/advanced-commands/`
- Sidebar path: 常用工具 > 命令行工具 ossutil 2.0 > 高级命令

### Page-to-file mapping

| File | Page slug | Page title |
| --- | --- | --- |
| `ossutil2-概览.md` | `ossutil-overview` | 命令行工具 ossutil 2.0 |
| `00-高级命令.md` | `advanced-commands` | 高级命令 |
| `01-append-追加上传.md` | `append-append-upload` | append（追加上传） |
| `02-cat-输出文件内容.md` | `cat-output-file-contents` | cat（输出文件内容） |
| `03-cp-上传下载和拷贝文件.md` | `cp-upload-download-and-copy-files` | cp（上传、下载和拷贝文件） |
| `04-du-获取大小.md` | `du-get-size` | du（获取大小） |
| `05-hash-计算CRC64或MD5.md` | `hash-calculate-crc64-or-md5` | hash（计算CRC64或MD5） |
| `06-ls-列举账号级别下的资源.md` | `ls-list-resources-under-the-account-level` | ls（列举账号级别下的资源） |
| `07-mb-创建存储空间.md` | `mb-create-storage-space` | mb（创建存储空间） |
| `08-mkdir-创建目录.md` | `mkdir-create-directory` | mkdir（创建目录） |
| `09-presign-生成预签名URL.md` | `presign-generate-presigned-url` | presign（生成预签名URL） |
| `10-restore-解冻文件.md` | `restore-unfrozen-file` | restore（解冻文件） |
| `11-unrestore-清理已解冻对象.md` | `unrestore` | unrestore（清理已解冻对象） |
| `12-revert-恢复版本.md` | `revert-recovery-version` | revert（恢复版本） |
| `13-rm-删除.md` | `rm-deleted` | rm（删除） |
| `14-rb-删除存储空间.md` | `rb-delete-bucket` | rb（删除存储空间） |
| `15-set-props-设置对象属性.md` | `set-props-set-object-properties` | set-props（设置对象属性） |
| `16-stat-查看Bucket和Object信息.md` | `stat2` | stat（查看Bucket和Object信息） |

Full URL = base + slug. Note: `sync（同步文件）` in the sidebar is currently a placeholder with no page; if Alibaba Cloud publishes it later, extract and save it following the method below.

### Extraction method

Each page has a "复制 MD 格式" (Copy MD Format) button in the top-right corner. The extraction process uses browser automation (Playwright CDP) to click this button and capture the Markdown content.

Key steps:

1. Navigate to the target page and wait for it to load (wait 1.5-2s after `waitForLoadState('load')`).
2. Inject a capture patch via CDP `Runtime.evaluate` before clicking. The button uses `document.execCommand('copy')`, so `tab.clipboard.readText()` cannot read the result. The patch must intercept both `navigator.clipboard.writeText` and `document.execCommand('copy')` to capture the copied text:
   ```js
   window.__copiedMD = { value: null, kind: null };
   // Override navigator.clipboard.writeText and document.execCommand('copy')
   // to write the copied text into window.__copiedMD.value
   ```
3. Click the "复制 MD 格式" button with Playwright.
4. Wait 1.2-1.5s, then read `window.__copiedMD.value` via CDP.
5. Verify the content is non-empty and ends with a complete sentence or code block, then write to the target file as UTF-8.
6. Navigate back to the `advanced-commands` page and refresh to clear the capture patch.

Important caveats:

- The capture patch must be re-injected after every page navigation.
- Some pages (cp, stat, rb) have naturally shorter content — this is not a truncation issue.
- File prefix numbers correspond to sidebar ordering; number new pages sequentially.
- If `sync（同步文件）` gets a page in the future, it should be numbered and placed between `set-props` and `stat` per the sidebar order.

## Development workflow

### Adding a new command

1. Find the official documentation for the command on the Alibaba Cloud OSS docs site.
2. Extract the page content using the extraction method above, save as a new reference file in `skills/ossutil2/references/` following the naming convention: `<NN>-<command>-<中文描述>.md`. Use the next available number.
3. Add the entry to the reference map in `SKILL.md`.
4. If the command introduces a new trigger keyword, update the `description` frontmatter in `SKILL.md`.

### Updating existing references

When the official docs are updated, re-extract the changed pages using the same method:

1. Identify which pages changed by checking the official docs site.
2. Re-extract the affected pages following the extraction method above, overwriting the existing reference files.
3. Review the diff for any command flag or behavior changes that affect `SKILL.md` guidance.

### Updating the ossutil version

1. Update `OSSUTIL_VERSION` in both `scripts/ossutil.sh` and `scripts/install-ossutil.sh`.
2. Update the download URLs and SHA256 checksums in `install-ossutil.sh` (the `zip_sha256_for` function). Get the SHA256 values from the official ossutil download page.
3. Update the `version` field in `plugin.json` to `<new-version>+codex.<current-timestamp>`.
4. Update the download table in `skills/ossutil2/references/ossutil2-概览.md` with the new URLs and checksums.
5. Review all reference files for any command changes in the new version.
6. Re-extract all reference pages if the new version has updated documentation.

### Modifying the skill behavior

- **Trigger rules**: Edit the `description` frontmatter and the "When to use" section in `SKILL.md`.
- **Workflow/rules**: Edit the "Workflow" and "Safety notes" sections in `SKILL.md`.
- **Command documentation**: Edit the relevant reference file in `references/`.
- **Configuration guidance**: Edit the "First-run configuration guidance" section in `SKILL.md`.

### Testing

After any change, verify the plugin works end-to-end:

1. **Binary resolution**: Run `bash scripts/ossutil.sh version` — it should print the ossutil version.
2. **First-time install**: Clear the cache (`rm -rf ~/.cache/ossutil-plugin`) and run again — it should download and verify.
3. **Skill loading**: The skill must be loadable by Codex. The `SKILL.md` frontmatter and all referenced files must be valid.
4. **Command construction**: Ask Codex to perform a common OSS operation (e.g. "list my buckets") and verify it constructs the correct ossutil command.

### Publishing

This plugin uses a personal marketplace entry at `.agents/plugins/marketplace.json`. After changes, update the marketplace entry and reinstall the plugin via the Codex plugin management UI.

## Conventions

- Keep reference files as close to the official docs as possible. Do not paraphrase or rewrite unless the original is unclear or outdated.
- The `SKILL.md` should be concise and actionable — it is the instruction set for Codex, not end-user documentation.
- All scripts are bash with `set -euo pipefail`. They must work on macOS (zsh/bash) and Linux.
- When adding a new command, include the full flag table from the official docs in the reference file.
- The wrapper script should never require root privileges. The binary is cached per-user.
- Never hardcode secrets or credentials in any file in this plugin.

