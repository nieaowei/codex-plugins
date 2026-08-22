---
name: ossutil2
description: "Use ossutil 2.0 (Alibaba Cloud OSS CLI) to manage buckets and objects: upload, download, copy, sync, list, delete, presign, restore, and configure credentials. Triggers when the user mentions ossutil, Aliyun OSS, Alibaba Cloud OSS, or asks to operate on OSS buckets/objects from the terminal."
---

# ossutil 2.0 for Alibaba Cloud OSS

ossutil 2.0 is the command-line tool for managing Alibaba Cloud OSS resources: fast upload, download, copy, and day-to-day bucket/object operations. This skill bundles the official Chinese documentation so you can answer questions and construct correct commands from authoritative references.

## When to use

- The user mentions ossutil, Aliyun OSS, or Alibaba Cloud OSS.
- The user wants to upload, download, copy, or sync files to/from OSS.
- The user wants bucket operations: create (mb), delete (rb), list (ls), size (du), info (stat).
- The user wants object operations: append, cat, cp, mkdir, rm, set-props, hash, presign, restore, revert.
- The user asks about installation, configuration, or credentials for ossutil 2.0.

## Running ossutil

This plugin downloads the official ossutil 2.3.0 binary on first use. Run it through the wrapper script:

```bash
<plugin-root>/scripts/ossutil.sh version
```

Resolution order:

1. Cached binary at `~/.cache/ossutil-plugin/2.3.0/ossutil` (or `$XDG_CACHE_HOME/...`) if a previous download succeeded.
2. `ossutil` on PATH, but only when its version is 2.x. A 1.x binary is rejected with an error, because ossutil 1.x and 2.x have incompatible command syntax.
3. First use: download the official platform zip from `gosspublic.alicdn.com`, verify its SHA256 against the checksums published on the official ossutil 2.0 download page, extract, and cache it. Supported platforms: macOS arm64/x86_64 and Linux amd64/arm64/arm/386.

## Reference map

All references are in `references/` relative to this SKILL.md. Read the relevant one before answering or constructing commands; do not rely on memory for flags and option names.

| Topic | Reference |
| --- | --- |
| Overview: install, config, credentials, command structure, output formats | `references/ossutil2-概览.md` |
| Advanced commands intro | `references/00-高级命令.md` |
| append - append upload | `references/01-append-追加上传.md` |
| cat - output object content | `references/02-cat-输出文件内容.md` |
| cp - upload, download, copy | `references/03-cp-上传下载和拷贝文件.md` |
| du - get storage size | `references/04-du-获取大小.md` |
| hash - compute CRC64/MD5 | `references/05-hash-计算CRC64或MD5.md` |
| ls - list account-level resources | `references/06-ls-列举账号级别下的资源.md` |
| mb - create bucket | `references/07-mb-创建存储空间.md` |
| mkdir - create directory | `references/08-mkdir-创建目录.md` |
| presign - generate presigned URL | `references/09-presign-生成预签名URL.md` |
| restore - unfreeze objects | `references/10-restore-解冻文件.md` |
| unrestore - clean unfrozen objects | `references/11-unrestore-清理已解冻对象.md` |
| revert - restore version | `references/12-revert-恢复版本.md` |
| rm - delete | `references/13-rm-删除.md` |
| rb - delete bucket | `references/14-rb-删除存储空间.md` |
| set-props - set object properties | `references/15-set-props-设置对象属性.md` |
| stat - view bucket/object info | `references/16-stat-查看Bucket和Object信息.md` |

## Workflow

1. Identify which command(s) the task needs from the reference map above.
2. Read the corresponding reference file completely before constructing the command.
3. For install/config/credential questions, read `references/ossutil2-概览.md` first; it covers installation per OS, configuration priority, config file format, environment variables, and credential modes (AK, STS, RAMRoleARN, EcsRamRole, OIDC, external process, anonymous).
4. Construct the command with flags taken verbatim from the docs. Prefer `ossutil api -h` for API-level commands not covered by the bundled docs.
5. Before running destructive commands (rm, rb, unrestore, revert), confirm the exact target with the user unless the user already gave an explicit, unambiguous target in this conversation.

## First-run configuration guidance

When the user has not configured ossutil yet (or a command fails with a credential/config error), guide them through configuration instead of just dumping commands. Follow this flow:

1. Check current state first:
   - Run `ossutil version` (or `ossutil`) to confirm the binary is installed; if missing, point them to the install steps in `references/ossutil2-概览.md` for their OS.
   - Check whether `~/.ossutilconfig` exists and whether `OSS_ACCESS_KEY_ID` / `OSS_ACCESS_KEY_SECRET` are set in the environment.
2. If unconfigured, ask the user one question at a time, in this order:
   - Which credential mode they have: RAM user AK (most common), STS temporary token, RAMRoleARN, ECS RAMRole (only when running on an ECS instance), or anonymous access to a public bucket.
   - Their region ID (for example cn-hangzhou). If they do not know it, ask which city their bucket was created in and map it to the region ID from the docs.
3. Recommend the interactive wizard for beginners:
   - `ossutil config` prompts for the config file path (Enter to accept the default), AccessKey ID, AccessKey Secret, region, and optional endpoint. Tell the user they can press Enter to skip endpoint and use the default public endpoint; only enter an internal endpoint (for example https://oss-cn-hangzhou-internal.aliyuncs.com) when accessing OSS from another Alibaba Cloud product in the same region.
4. Offer the non-interactive alternative when the user prefers environment variables or cannot use the wizard:
   - AK mode: `export OSS_ACCESS_KEY_ID=...` and `export OSS_ACCESS_KEY_SECRET=...`
   - STS mode: also `export OSS_SESSION_TOKEN=...`
   - Remind them that command-line options (`-i`/`-k`) take highest priority, then environment variables, then the config file.
5. Verify the configuration with a read-only command, for example `ossutil ls` (account-level) or `ossutil ls oss://<bucket>`, before attempting any write operation.

Security rules while guiding:

- Never ask the user to paste secrets into the chat, and never echo AccessKey values in command output. Suggest they type values directly into the `ossutil config` wizard or export them in their own shell.
- If the user insists on writing a config file for them, write it without printing the secret back, and recommend `chmod 600 ~/.ossutilconfig`.
- If the user runs on an ECS instance, suggest EcsRamRole mode first to avoid long-lived keys entirely.

## Safety notes

- OSS paths use the `oss://bucket/key` scheme.
- Never log or echo AccessKey secrets in command output; prefer the configured profile or environment variables.
- `cp` does not support cross-account or cross-region copy.
- For versioned buckets, downloads can target a specific version.
