# Specification - 规范

原文地址：[https://agentskills.io/specification](https://agentskills.io/specification)

> The complete format specification for Agent Skills.

> Agent Skills 的完整格式规范。

## Directory structure - 目录结构

A skill is a directory containing, at minimum, a `SKILL.md` file:

一个 skill 就是一个目录，至少包含一个 `SKILL.md` 文件：

```
skill-name/
├── SKILL.md          # Required: metadata + instructions
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
├── assets/           # Optional: templates, resources
└── ...               # Any additional files or directories
```

```
skill-name/
├── SKILL.md          # 必需：元数据 + 指令
├── scripts/          # 可选：可执行代码
├── references/       # 可选：文档
├── assets/           # 可选：模板、资源
└── ...               # 任何其他文件或目录
```

## `SKILL.md` format - `SKILL.md` 格式

The `SKILL.md` file must contain YAML frontmatter followed by Markdown content.

`SKILL.md` 文件必须包含 YAML frontmatter，后面接 Markdown 正文内容。

### Frontmatter - 前言（Frontmatter）

| Field           | Required | Constraints                                                                                                       |
| --------------- | -------- | ------|
| `name`          | Yes      | Max 64 characters. Lowercase letters, numbers, and hyphens only. Must not start or end with a hyphen.             |
| `description`   | Yes      | Max 1024 characters. Non-empty. Describes what the skill does and when to use it.                                 |
| `license`       | No       | License name or reference to a bundled license file.                                                              |
| `compatibility` | No       | Max 500 characters. Indicates environment requirements (intended product, system packages, network access, etc.). |
| `metadata`      | No       | Arbitrary key-value mapping for additional metadata.                                                              |
| `allowed-tools` | No       | Space-separated string of pre-approved tools the skill may use. (Experimental)                                    |

| 字段            | 是否必填 | 约束                                                                                                       |
| --------------- | -------- | ------ |
| `name`          | 是       | 最多 64 个字符。仅允许小写字母、数字和连字符。不能以连字符开头或结尾。                                     |
| `description`   | 是       | 最多 1024 个字符。不可为空。描述该 skill 的用途以及何时使用它。                                            |
| `license`       | 否       | 许可证名称，或指向随附许可证文件的引用。                                                                   |
| `compatibility` | 否       | 最多 500 个字符。用于说明环境要求（预期使用的产品、系统依赖包、网络访问需求等）。                          |
| `metadata`      | 否       | 用于存放附加元数据的任意键值映射。                                                                         |
| `allowed-tools` | 否       | 以空格分隔的字符串，列出该 skill 可以预先授权使用的工具。（实验性）                                        |

**Minimal example:**

**最小示例：**

```markdown SKILL.md theme={null}
---
name: skill-name
description: A description of what this skill does and when to use it.
---
```

**Example with optional fields:**

**包含可选字段的示例：**

```markdown SKILL.md theme={null}
---
name: pdf-processing
description: Extract PDF text, fill forms, merge files. Use when handling PDFs.
license: Apache-2.0
metadata:
  author: example-org
  version: "1.0"
---
```

#### `name` field - `name`（名称）字段

The required `name` field:

必填的 `name` 字段：

* Must be 1-64 characters
* May only contain unicode lowercase alphanumeric characters (`a-z`, `0-9`) and hyphens (`-`)
* Must not start or end with a hyphen (`-`)
* Must not contain consecutive hyphens (`--`)
* Must match the parent directory name

* 长度必须为 1-64 个字符
* 只能包含 unicode 小写字母数字字符（`a-z`、`0-9`）和连字符（`-`）
* 不能以连字符（`-`）开头或结尾
* 不能包含连续的连字符（`--`）
* 必须与其父目录的名称一致

**Valid examples:**

**合法示例：**

```yaml theme={null}
name: pdf-processing
```

```yaml theme={null}
name: data-analysis
```

```yaml theme={null}
name: code-review
```

**Invalid examples:**

**非法示例：**

```yaml theme={null}
name: PDF-Processing  # uppercase not allowed
```

```yaml theme={null}
name: PDF-Processing  # 不允许出现大写字母
```

```yaml theme={null}
name: -pdf  # cannot start with hyphen
```

```yaml theme={null}
name: -pdf  # 不能以连字符开头
```

```yaml theme={null}
name: pdf--processing  # consecutive hyphens not allowed
```

```yaml theme={null}
name: pdf--processing  # 不允许出现连续的连字符
```

#### `description` field - `description`（描述）字段

The required `description` field:

必填的 `description` 字段：

* Must be 1-1024 characters
* Should describe both what the skill does and when to use it
* Should include specific keywords that help agents identify relevant tasks

* 长度必须为 1-1024 个字符
* 应同时描述该 skill 的用途以及何时使用它
* 应包含具体的关键词，帮助智能体识别相关的任务

**Good example:**

**好的示例：**

```yaml theme={null}
description: Extracts text and tables from PDF files, fills PDF forms, and merges multiple PDFs. Use when working with PDF documents or when the user mentions PDFs, forms, or document extraction.
```

```yaml theme={null}
description: 从 PDF 文件中提取文本和表格、填写 PDF 表单，以及合并多个 PDF。当处理 PDF 文档，或用户提到 PDF、表单或文档提取时使用。
```

**Poor example:**

**不好的示例：**

```yaml theme={null}
description: Helps with PDFs.
```

```yaml theme={null}
description: 帮助处理 PDF。
```

#### `license` field - `license`（许可证）字段

The optional `license` field:

可选的 `license` 字段：

* Specifies the license applied to the skill
* We recommend keeping it short (either the name of a license or the name of a bundled license file)

* 用于指定该 skill 所采用的许可证
* 建议保持简短（可以是许可证名称，或随附的许可证文件的名称）

**Example:**

**示例：**

```yaml theme={null}
license: Proprietary. LICENSE.txt has complete terms
```

```yaml theme={null}
license: 专有许可。完整条款见 LICENSE.txt
```

#### `compatibility` field - `compatibility`（兼容性）字段

The optional `compatibility` field:

可选的 `compatibility` 字段：

* Must be 1-500 characters if provided
* Should only be included if your skill has specific environment requirements
* Can indicate intended product, required system packages, network access needs, etc.

* 如果提供，长度必须为 1-500 个字符
* 只有当你的 skill 有特定的环境要求时才需要提供
* 可用于说明预期使用的产品、所需的系统依赖包、网络访问需求等

**Examples:**

**示例：**

```yaml theme={null}
compatibility: Designed for Claude Code (or similar products)
```

```yaml theme={null}
compatibility: 为 Claude Code（或类似产品）设计
```

```yaml theme={null}
compatibility: Requires git, docker, jq, and access to the internet
```

```yaml theme={null}
compatibility: 需要 git、docker、jq 以及互联网访问
```

```yaml theme={null}
compatibility: Requires Python 3.14+ and uv
```

```yaml theme={null}
compatibility: 需要 Python 3.14+ 和 uv
```

> Most skills do not need the `compatibility` field.

> 大多数 skill 并不需要 `compatibility` 字段。

#### `metadata` field - `metadata`（元数据）字段

The optional `metadata` field:

可选的 `metadata` 字段：

* A map from string keys to string values
* Clients can use this to store additional properties not defined by the Agent Skills spec
* We recommend making your key names reasonably unique to avoid accidental conflicts

* 一个从字符串键到字符串值的映射
* 客户端可以利用它来存储 Agent Skills 规范未定义的附加属性
* 建议为键名取一个足够独特的名字，以避免意外冲突

**Example:**

**示例：**

```yaml theme={null}
metadata:
  author: example-org
  version: "1.0"
```

#### `allowed-tools` field - `allowed-tools`（允许使用的工具）字段

The optional `allowed-tools` field:

可选的 `allowed-tools` 字段：

* A space-separated string of tools that are pre-approved to run
* Experimental. Support for this field may vary between agent implementations

* 一个以空格分隔的字符串，列出被预先授权运行的工具
* 实验性字段。不同智能体实现对该字段的支持情况可能有所差异

**Example:**

**示例：**

```yaml theme={null}
allowed-tools: Bash(git:*) Bash(jq:*) Read
```

### Body content 正文内容

The Markdown body after the frontmatter contains the skill instructions. There are no format restrictions. Write whatever helps agents perform the task effectively.

frontmatter 之后的 Markdown 正文包含 skill 的指令。对格式没有限制，你可以写任何能帮助智能体高效完成任务的内容。

Recommended sections:

推荐包含的章节：

* Step-by-step instructions
* Examples of inputs and outputs
* Common edge cases

* 分步骤的操作说明
* 输入与输出的示例
* 常见的边界情况

Note that the agent will load this entire file once it's decided to activate a skill. Consider splitting longer `SKILL.md` content into referenced files.

请注意，一旦智能体决定激活某个 skill，它就会加载整个文件。对于较长的 `SKILL.md` 内容，可以考虑拆分到被引用的文件中。

## Optional directories 可选目录

### `scripts/` （脚本）

Contains executable code that agents can run. Scripts should:

存放智能体可以运行的可执行代码。脚本应当：

* Be self-contained or clearly document dependencies
* Include helpful error messages
* Handle edge cases gracefully

* 自包含，或者清晰地记录依赖关系
* 包含有用的错误提示信息
* 优雅地处理边界情况

Supported languages depend on the agent implementation. Common options include Python, Bash, and JavaScript.

支持的语言取决于具体的智能体实现，常见的选项包括 Python、Bash 和 JavaScript。

### `references/` （参考资料）

Contains additional documentation that agents can read when needed:

存放智能体在需要时可以阅读的附加文档：

* `REFERENCE.md` - Detailed technical reference
* `FORMS.md` - Form templates or structured data formats
* Domain-specific files (`finance.md`, `legal.md`, etc.)

* `REFERENCE.md` — 详细的技术参考
* `FORMS.md` — 表单模板或结构化数据格式
* 特定领域的文件（例如 `finance.md`、`legal.md` 等）

Keep individual [reference files](#file-references) focused. Agents load these on demand, so smaller files mean less use of context.

保持每个[引用文件](#file-references)聚焦于单一主题。智能体是按需加载这些文件的，因此文件越小，占用的上下文就越少。

### `assets/` （静态资源）

Contains static resources:

存放静态资源：

* Templates (document templates, configuration templates)
* Images (diagrams, examples)
* Data files (lookup tables, schemas)

* 模板（文档模板、配置模板）
* 图片（示意图、示例图）
* 数据文件（查找表、schema 等）

## Progressive disclosure 渐进式披露

Agents load skills *progressively*, pulling in more detail only as a task calls for it. Skills should be structured to take advantage of this:

智能体以*渐进式*的方式加载 skills，只在任务需要时才拉取更多细节。Skills 的结构应当充分利用这一机制：

1. **Metadata** (\~100 tokens): The `name` and `description` fields are loaded at startup for all skills
2. **Instructions** (\< 5000 tokens recommended): The full `SKILL.md` body is loaded when the skill is activated
3. **Resources** (as needed): Files (e.g. those in `scripts/`, `references/`, or `assets/`) are loaded only when required

1. **元数据（Metadata）**（约 100 tokens）：所有 skill 的 `name` 和 `description` 字段在启动时加载
2. **指令（Instructions）**（建议 \< 5000 tokens）：当 skill 被激活时，完整的 `SKILL.md` 正文才会被加载
3. **资源（Resources）**（按需加载）：只有在需要时才会加载相关文件（例如 `scripts/`、`references/` 或 `assets/` 中的文件）

Keep your main `SKILL.md` under 500 lines. Move detailed reference material to separate files.

将主 `SKILL.md` 文件保持在 500 行以内。把详细的参考资料放到单独的文件中。

## File references 文件引用

When referencing other files in your skill, use relative paths from the skill root:

在 skill 中引用其他文件时，请使用以 skill 根目录为基准的相对路径：

```markdown SKILL.md theme={null}
See [the reference guide](references/REFERENCE.md) for details.

Run the extraction script:
scripts/extract.py
```

```markdown SKILL.md theme={null}
详见[参考指南](references/REFERENCE.md)。

运行提取脚本：
scripts/extract.py
```

Keep file references one level deep from `SKILL.md`. Avoid deeply nested reference chains.

文件引用相对于 `SKILL.md` 只保持一层深度，避免出现过深的引用链。

## Validation 校验

Use the [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) reference library to validate your skills:

使用参考库 [skills-ref](https://github.com/agentskills/agentskills/tree/main/skills-ref) 来校验你的 skills：

```bash theme={null}
skills-ref validate ./my-skill
```

This checks that your `SKILL.md` frontmatter is valid and follows all naming conventions.

这会检查你的 `SKILL.md` frontmatter 是否有效，以及是否遵循所有命名规范。
