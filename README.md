# Codex Plugins

这是一个面向 Codex 的多插件仓库。每个插件都可以独立安装、更新和使用；仓库通过统一的 marketplace 清单发现插件，并把插件实现隔离在 `plugins/` 下。

## 插件发现

插件清单位于 [`.agents/plugins/marketplace.json`](.agents/plugins/marketplace.json)。它记录可用插件的名称、来源路径、安装策略和分类，是安装和发布插件时的登记入口。

安装时，将本仓库或该清单加载到 Codex 的插件管理界面，然后从列表中选择需要的插件。插件彼此独立，可以只安装其中一部分；安装后的使用方式和配置要求以插件目录内的文档为准。

本地开发或调试时，可以直接从 `plugins/<plugin-name>/` 加载插件。每个可安装插件都必须包含 `.codex-plugin/plugin.json`。

## 仓库结构

```text
.
├── .agents/plugins/marketplace.json  # 插件市场清单
├── plugins/
│   └── <plugin-name>/                # 相互独立的插件目录
│       ├── .codex-plugin/plugin.json # 插件元数据与入口
│       ├── skills/                   # Codex skills
│       ├── scripts/                  # 可选的运行/安装脚本
│       ├── references/               # 可选的参考资料
│       └── README.md                 # 推荐的插件专属说明
├── AGENTS.md                         # 仓库维护流程与规范
└── README.md
```

插件内部的脚本、参考资料、凭证说明和测试要求由插件自身负责。仓库级维护流程、目录规范和验证要求集中记录在 [`AGENTS.md`](AGENTS.md)；插件目录中的 `AGENTS.md` 可补充该插件的专属规则。

## 新增或维护插件

请先阅读 [`AGENTS.md`](AGENTS.md)，再执行插件新增、更新、移除或发布操作。基本要求包括：

- 每个插件拥有独立目录和 `.codex-plugin/plugin.json`。
- 插件专属内容放在自身目录内，避免跨插件共享隐式状态。
- 新增或移除插件时同步更新 `.agents/plugins/marketplace.json`。
- 不提交密钥、令牌、用户数据或下载后的二进制文件。
- 修改后执行适用于该插件的验证，并检查清单、manifest、skill frontmatter 和本地路径。

## 相关文件

- [插件市场清单](.agents/plugins/marketplace.json)
- [仓库维护流程与规范](AGENTS.md)
