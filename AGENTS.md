# AGENTS.md

本文档适用于整个 `codex-plugins` 多插件仓库。它定义跨插件的目录结构、marketplace 登记、维护、验证和发布规范。某个插件目录内的 `AGENTS.md` 可以在不违反本文档的前提下补充更具体的实现要求。

## 仓库边界

- 每个插件都位于 `plugins/<plugin-name>/`，插件之间应保持可独立安装、更新和验证。
- `.agents/plugins/marketplace.json` 是插件发现和发布登记的唯一清单。
- 插件专属脚本、skill、参考文档、测试和配置说明必须放在对应插件目录中。
- 根目录 `README.md` 只描述仓库级能力和通用流程，不维护某个插件的操作手册。

## 插件结构规范

每个可安装插件至少包含：

```text
plugins/<plugin-name>/
└── .codex-plugin/plugin.json
```

推荐的完整结构如下：

```text
plugins/<plugin-name>/
├── .codex-plugin/plugin.json  # 必需：插件 manifest
├── skills/<skill-name>/       # 推荐：Codex skill 与其资源
├── scripts/                   # 可选：安装或运行脚本
├── references/                # 可选：参考资料
├── tests/                     # 可选：插件测试
├── README.md                  # 推荐：面向插件使用者的说明
└── AGENTS.md                  # 可选：插件专属代理规则
```

目录名使用简洁、稳定的小写 kebab-case。manifest 中的 `name` 应与插件标识保持一致，`skills` 等路径使用相对于插件根目录的路径。插件不得依赖另一个插件未声明的内部文件或运行时状态。

## Marketplace 规范

在 `.agents/plugins/marketplace.json` 中登记插件时：

- `plugins` 数组中的 `name` 必须唯一。
- `source.path` 必须是仓库内的插件目录，并指向 `plugins/<plugin-name>`。
- `source`、`policy` 和 `category` 字段应与 Codex 插件格式保持一致。
- 新增、重命名、移动或移除插件时，必须同步更新清单及相关文档。
- 清单中不得登记不存在的路径，也不得将凭证或机器本地路径写入 `source`。

## 新增插件流程

1. 明确插件的职责、触发条件、权限边界和外部依赖，确认它不应直接复用另一个插件的私有实现。
2. 创建 `plugins/<plugin-name>/` 和 `.codex-plugin/plugin.json`。
3. 添加 skill、脚本、参考资料和插件 README；skill 的 frontmatter、相对引用和触发描述必须完整。
4. 在 `.agents/plugins/marketplace.json` 登记插件名称、相对路径、安装策略和分类。
5. 为插件提供最小可运行验证，包括加载检查和一个代表性用户流程。
6. 检查 JSON、路径、文档链接和安全边界，再提交变更。

## 更新插件流程

1. 先阅读插件目录内的 `AGENTS.md`、`README.md` 和入口 skill，确认现有行为与版本约束。
2. 只修改实现该需求所需的插件文件，避免把插件专属配置提升到仓库根目录。
3. 若更新依赖、二进制、API 或外部文档，同时更新版本号、校验值、来源链接和用户说明。
4. 若改变触发条件、权限或破坏性操作，更新 skill 的规则和安全说明，并补充相应验证。
5. 运行插件自己的验证命令，再执行仓库级清单和路径检查。

## 移除或弃用插件流程

移除插件前确认它不再需要发布或安装。然后按以下顺序处理：

1. 从 `.agents/plugins/marketplace.json` 移除对应登记。
2. 更新 README 或其他仓库文档中对插件数量、路径和能力的描述。
3. 删除插件目录前，检查是否存在仍被其他插件引用的资源或文档链接。
4. 若需要保留迁移信息，写明替代插件、最后版本和迁移方式；不要留下指向不存在路径的链接。

## 文档与安全规范

- 根 README 面向仓库使用者；插件 README 面向该插件使用者；skill 文档面向 Codex 执行任务，三者职责不要混淆。
- 外部文档、下载地址、API 说明和命令参数应保留来源链接，并以可验证的最新资料为准。
- 不提交 AccessKey、Token、Cookie、私钥、用户数据、内部 URL 或包含敏感信息的日志。
- 脚本不得通过日志、错误信息或调试输出回显秘密；涉及写入、删除或远程变更时，应遵循插件自身的确认和安全规则。
- 下载的二进制、构建产物和机器本地缓存不应进入版本库，除非插件明确要求并经过审查。
- shell 脚本应使用 `set -euo pipefail`，避免依赖 root 权限和未声明的工作目录。

## 验证要求

每次新增或修改插件后，根据变更范围执行以下检查：

1. 解析 `.agents/plugins/marketplace.json` 和受影响的 `plugin.json`，确认 JSON 有效。
2. 检查所有 `source.path`、manifest 中的 skill 路径和文档相对链接都存在。
3. 检查 skill frontmatter、引用文件和触发描述；对脚本运行 shell 语法检查。
4. 运行插件提供的最小验证命令，至少覆盖入口加载或一个代表性用户流程。
5. 对涉及网络、凭证或远程资源的验证，使用最小权限和只读操作；不要在验证输出中暴露秘密。
6. 若修改 marketplace，确认插件列表无重复名称、无悬空路径，并检查安装策略和分类仍然正确。

验证不能通过时，不得通过删除测试、放宽安全规则或隐藏错误来获得绿色结果；应修复根因，或在交付说明中记录已知的预存问题。

## 发布与版本维护

- 插件版本在各自的 manifest 中维护；仓库级变更不应无故修改未受影响插件的版本。
- 发布前确认 marketplace 中的 `source.path`、manifest 版本和插件文档一致。
- 版本升级涉及下载地址、校验值、API 或文档时，应在同一变更中同步更新相关引用并完成回归验证。
- 发布后通过 Codex 插件管理界面重新加载或安装插件，确认 marketplace 中展示的名称、分类和描述正确。
