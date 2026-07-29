# How to add skills support to your agent - 如何为你的智能体添加 skills 支持

原文地址：[https://agentskills.io/client-implementation/adding-skills-support](https://agentskills.io/client-implementation/adding-skills-support)

> A guide for adding Agent Skills support to an AI agent or development tool.

> 一份为 AI 智能体或开发工具添加 Agent Skills 支持的指南。

This guide walks through how to add Agent Skills support to an AI agent or development tool. It covers the full lifecycle: discovering skills, telling the model about them, loading their content into context, and keeping that content effective over time.

本指南讲解如何为 AI 智能体或开发工具添加 Agent Skills 支持，涵盖完整的生命周期：发现 skills、向模型告知它们的存在、将其内容加载到上下文中，以及在整个会话过程中让这些内容持续保持有效。

The core integration is the same regardless of your agent's architecture. The implementation details vary based on two factors:

无论你的智能体采用何种架构，核心的集成方式都是相同的。具体的实现细节则取决于以下两个因素：

* **Where do skills live?** A locally-running agent can scan the user's filesystem for skill directories. A cloud-hosted or sandboxed agent will need an alternative discovery mechanism — an API, a remote registry, or bundled assets.
* **How does the model access skill content?** If the model has file-reading capabilities, it can read `SKILL.md` files directly. Otherwise, you'll provide a dedicated tool or inject skill content into the prompt programmatically.

* **skills 存放在哪里？** 本地运行的智能体可以扫描用户的文件系统来查找 skill 目录。云端托管或运行在沙箱中的智能体则需要一种替代的发现机制——例如 API、远程注册表，或随程序打包的静态资源。
* **模型如何访问 skill 内容？** 如果模型具备文件读取能力，它可以直接读取 `SKILL.md` 文件。否则，你需要提供一个专用工具，或者通过程序化的方式将 skill 内容注入到提示词（prompt）中。

The guide notes where these differences matter. You don't need to support every scenario — follow the path that fits your agent.

本指南会在相关之处标注这些差异带来的影响。你不需要支持所有场景——只需遵循适合你的智能体的那条路径即可。

**Prerequisites**: Familiarity with the [Agent Skills specification](/specification), which defines the `SKILL.md` file format, frontmatter fields, and directory conventions.

**前置条件**：熟悉 [Agent Skills 规范](/specification)，该规范定义了 `SKILL.md` 文件格式、frontmatter 字段以及目录约定。

## 1. The core principle: progressive disclosure - 核心原则：渐进式披露

Every skills-compatible agent follows the same three-tier loading strategy:

每一个兼容 skills 的智能体都遵循相同的三层加载策略：

| Tier            | What's loaded               | When                                 | Token cost                  |
| --------------- | ---------------------------- | ------------------------------------- | ---------------------------- |
| 1. Catalog      | Name + description          | Session start                        | \~50-100 tokens per skill   |
| 2. Instructions | Full `SKILL.md` body        | When the skill is activated          | \<5000 tokens (recommended) |
| 3. Resources    | Scripts, references, assets | When the instructions reference them | Varies                      |

| 层级                    | 加载内容                     | 加载时机                     | Token 开销                    |
| ----------------------- | ---------------------------- | ---------------------------- | ------------------------------ |
| 1. 目录清单（Catalog）  | 名称 + 描述                  | 会话开始时                   | 每个 skill 约 50-100 tokens   |
| 2. 指令（Instructions） | 完整的 `SKILL.md` 正文       | 当 skill 被激活时            | 建议 \<5000 tokens             |
| 3. 资源（Resources）    | 脚本、参考资料、静态资源     | 当指令中引用它们时           | 视情况而定                     |

The model sees the catalog from the start, so it knows what skills are available. When it decides a skill is relevant, it loads the full instructions. If those instructions reference supporting files, the model loads them individually as needed.

模型从一开始就能看到这份目录清单，因此它知道有哪些 skills 可用。当它判断某个 skill 相关时，就会加载完整的指令。如果这些指令中引用了配套文件，模型会按需逐个加载它们。

This keeps the base context small while giving the model access to specialized knowledge on demand. An agent with 20 installed skills doesn't pay the token cost of 20 full instruction sets upfront — only the ones actually used in a given conversation.

这样既能让基础上下文保持精简，又能让模型按需访问专业知识。一个安装了 20 个 skills 的智能体，并不需要预先支付这 20 套完整指令的 token 开销——只需要为一次对话中实际用到的那些付出成本即可。

## 2. Step 1: Discover skills - 第 1 步：发现 skills

At session startup, find all available skills and load their metadata.

在会话启动时，找出所有可用的 skills，并加载它们的元数据。

### 2.1 Where to scan - 扫描哪些目录

Which directories you scan depends on your agent's environment. Most locally-running agents scan at least two scopes:

需要扫描哪些目录取决于你的智能体所处的环境。大多数本地运行的智能体至少会扫描两个范围：

* **Project-level** (relative to the working directory): Skills specific to a project or repository.
* **User-level** (relative to the home directory): Skills available across all projects for a given user.

* **项目级**（相对于工作目录）：特定于某个项目或代码仓库的 skills。
* **用户级**（相对于主目录）：对某个用户而言，跨所有项目都可用的 skills。

Other scopes are possible too — for example, organization-wide skills deployed by an admin, or skills bundled with the agent itself. The right set of scopes depends on your agent's deployment model.

其他范围同样是可行的——例如由管理员部署的、面向整个组织的 skills，或者与智能体本身一同打包的 skills。合适的范围组合取决于你的智能体的部署模型。

Within each scope, consider scanning both a **client-specific directory** and the **`.agents/skills/` convention**:

在每个范围内，可以考虑同时扫描**客户端专属目录**以及 **`.agents/skills/` 约定目录**：

| Scope   | Path                               | Purpose                       |
| ------- | ----------------------------------- | ------------------------------ |
| Project | `<project>/.<your-client>/skills/` | Your client's native location |
| Project | `<project>/.agents/skills/`        | Cross-client interoperability |
| User    | `~/.<your-client>/skills/`         | Your client's native location |
| User    | `~/.agents/skills/`                | Cross-client interoperability |

| 范围   | 路径                                | 用途                 |
| ------ | ----------------------------------- | -------------------- |
| 项目级 | `<project>/.<your-client>/skills/` | 你的客户端的原生位置 |
| 项目级 | `<project>/.agents/skills/`        | 跨客户端互操作       |
| 用户级 | `~/.<your-client>/skills/`         | 你的客户端的原生位置 |
| 用户级 | `~/.agents/skills/`                | 跨客户端互操作       |

The `.agents/skills/` paths have emerged as a widely-adopted convention for cross-client skill sharing. While the Agent Skills specification does not mandate where skill directories live (it only defines what goes inside them), scanning `.agents/skills/` means skills installed by other compliant clients are automatically visible to yours, and vice versa.

`.agents/skills/` 这一路径已经成为一种被广泛采用的、用于跨客户端共享 skill 的约定。虽然 Agent Skills 规范并不强制规定 skill 目录应放在何处（它只定义了目录内部应包含什么），但扫描 `.agents/skills/` 意味着其他兼容客户端所安装的 skills 会自动对你的客户端可见，反之亦然。

> Some implementations also scan `.claude/skills/` (both project-level and user-level) for pragmatic compatibility, since many existing skills are installed there. Other additional locations include ancestor directories up to the git root (useful for monorepos), [XDG](https://specifications.freedesktop.org/basedir-spec/latest/) config directories, and user-configured paths.

> 出于实用性上的兼容考虑，有些实现也会扫描 `.claude/skills/`（包括项目级和用户级），因为很多现有的 skills 都安装在那里。其他可能会额外扫描的位置还包括：直至 Git 根目录的各级上级目录（适用于单体代码仓库场景）、[XDG](https://specifications.freedesktop.org/basedir-spec/latest/) 配置目录，以及用户自定义的路径。

### 2.2 What to scan for - 扫描什么内容

Within each skills directory, look for **subdirectories containing a file named exactly `SKILL.md`**:

在每个 skills 目录中，查找**包含一个名称恰好为 `SKILL.md` 的文件的子目录**：

```
~/.agents/skills/
├── pdf-processing/
│   ├── SKILL.md          ← discovered
│   └── scripts/
│       └── extract.py
├── data-analysis/
│   └── SKILL.md          ← discovered
└── README.md             ← ignored (not a skill directory)
```

```
~/.agents/skills/
├── pdf-processing/
│   ├── SKILL.md          ← 被发现
│   └── scripts/
│       └── extract.py
├── data-analysis/
│   └── SKILL.md          ← 被发现
└── README.md             ← 被忽略（不是 skill 目录）
```

Practical scanning rules:

实际扫描时的一些实用规则：

* Skip directories that won't contain skills, such as `.git/` and `node_modules/`
* Optionally respect `.gitignore` to avoid scanning build artifacts
* Set reasonable bounds (e.g., max depth of 4-6 levels, max 2000 directories) to prevent runaway scanning in large directory trees

* 跳过不可能包含 skills 的目录，例如 `.git/` 和 `node_modules/`
* 可以选择遵循 `.gitignore`，避免扫描构建产物
* 设置合理的边界（例如最大深度 4-6 层、最多扫描 2000 个目录），防止在庞大的目录树中出现失控的扫描

### 2.3 Handling name collisions - 处理名称冲突

When two skills share the same `name`, apply a deterministic precedence rule.

当两个 skills 拥有相同的 `name` 时，应采用一条确定性的优先级规则。

The universal convention across existing implementations: **project-level skills override user-level skills.**

现有实现中普遍采用的约定是：**项目级 skills 会覆盖用户级 skills。**

Within the same scope (e.g., two skills named `code-review` found under both `<project>/.agents/skills/` and `<project>/.<your-client>/skills/`), either first-found or last-found is acceptable — pick one and be consistent. Log a warning when a collision occurs so the user knows a skill was shadowed.

在同一范围内（例如在 `<project>/.agents/skills/` 和 `<project>/.<your-client>/skills/` 下都发现了名为 `code-review` 的 skill），采用“先发现的优先”还是“后发现的优先”都可以——选定一种规则并保持一致即可。发生冲突时应记录一条警告日志，让用户知道某个 skill 被遮蔽了。

### 2.4 Trust considerations - 信任方面的考量

Project-level skills come from the repository being worked on, which may be untrusted (e.g., a freshly cloned open-source project). Consider gating project-level skill loading on a trust check — only load them if the user has marked the project folder as trusted. This prevents untrusted repositories from silently injecting instructions into the agent's context.

项目级 skills 来自正在处理的代码仓库，而这个仓库可能是不可信的（例如一个刚克隆下来的开源项目）。可以考虑为加载项目级 skills 增加一道信任检查——只有当用户已将该项目文件夹标记为可信时，才加载其中的 skills。这样可以防止不可信的代码仓库在用户不知情的情况下，向智能体的上下文中注入指令。

### 2.5 Cloud-hosted and sandboxed agents - 云端托管与沙箱化的智能体

If your agent runs in a container or on a remote server, it won't have access to the user's local filesystem. Discovery needs to work differently depending on the skill scope:

如果你的智能体运行在容器中或远程服务器上，它就无法访问用户本地的文件系统。此时，发现机制需要根据 skill 的范围采取不同的做法：

* **Project-level skills** are often the easiest case. If the agent operates on a cloned repository (even inside a sandbox), project-level skills travel with the code and can be scanned from the repo's directory tree.
* **User-level and organization-level skills** don't exist in the sandbox. You'll need to provision them from an external source — for example, cloning a configuration repository, accepting skill URLs or packages through your agent's settings, or letting users upload skill directories through a web UI.
* **Built-in skills** can be packaged as static assets within the agent's deployment artifact, making them available in every session without external fetching.

* **项目级 skills** 通常是最简单的情形。如果智能体是基于一份克隆下来的代码仓库进行操作的（即便是在沙箱中），项目级 skills 会随代码一起分发，可以直接从该仓库的目录树中扫描到。
* **用户级和组织级 skills** 在沙箱中并不存在，你需要从外部来源为其提供内容——例如克隆一个配置仓库、通过智能体的设置接受 skill 的 URL 或压缩包，或者让用户通过网页 UI 上传 skill 目录。
* **内置 skills** 可以作为静态资源打包进智能体的部署产物中，这样每个会话都能直接使用它们，无需从外部获取。

Once skills are available to the agent, the rest of the lifecycle — parsing, disclosure, activation — works the same.

一旦 skills 对智能体变得可用，生命周期的其余部分——解析、披露、激活——都会以同样的方式运作。

## 3. Step 2: Parse `SKILL.md` files - 第 2 步：解析 `SKILL.md` 文件

For each discovered `SKILL.md`, extract the metadata and body content.

对每一个被发现的 `SKILL.md`，都要提取出其元数据和正文内容。

### 3.1 Frontmatter extraction - 提取 Frontmatter

A `SKILL.md` file has two parts: YAML frontmatter between `---` delimiters, and a markdown body after the closing delimiter. To parse:

一个 `SKILL.md` 文件包含两部分：位于 `---` 分隔符之间的 YAML frontmatter，以及结束分隔符之后的 markdown 正文。解析步骤如下：

1. Find the opening `---` at the start of the file and the closing `---` after it.
2. Parse the YAML block between them. Extract `name` and `description` (required), plus any optional fields.
3. Everything after the closing `---`, trimmed, is the skill's body content.

1. 找到文件开头的第一个 `---`，以及紧随其后的第二个（结束用的）`---`。
2. 解析两者之间的 YAML 块，提取必填的 `name` 和 `description`，以及任何可选字段。
3. 结束分隔符 `---` 之后的所有内容（去除首尾空白后）即为该 skill 的正文内容。

See the [specification](/specification) for the full set of frontmatter fields and their constraints.

关于 frontmatter 字段的完整列表及其约束，请参阅[规范](/specification)。

### 3.2 Handling malformed YAML - 处理格式错误的 YAML

Skill files authored for other clients may contain technically invalid YAML that their parsers happen to accept. The most common issue is unquoted values containing colons:

为其他客户端编写的 skill 文件，其中可能包含技术上无效、但对方的解析器恰好能够接受的 YAML。最常见的问题是包含冒号却未加引号的值：

```yaml theme={null}
# Technically invalid YAML — the colon breaks parsing
description: Use this skill when: the user asks about PDFs
```

```yaml theme={null}
# 技术上这是无效的 YAML —— 冒号会破坏解析
description: 当出现以下情况时使用此 skill：用户询问关于 PDF 的问题
```

Consider a fallback that wraps such values in quotes or converts them to YAML block scalars before retrying. This improves cross-client compatibility at minimal cost.

可以考虑提供一种兜底方案：在重新解析之前，先给这类值加上引号，或者把它们转换为 YAML 块标量（block scalar）。这样能以很小的代价提升跨客户端兼容性。

### 3.3 Lenient validation - 宽松校验

Warn on issues but still load the skill when possible:

对于遇到的问题给出警告，但在可能的情况下仍然加载该 skill：

* Name doesn't match the parent directory name → warn, load anyway
* Name exceeds 64 characters → warn, load anyway
* Description is missing or empty → skip the skill (a description is essential for disclosure), log the error
* YAML is completely unparseable → skip the skill, log the error

* `name` 与父目录名称不一致 → 发出警告，但仍然加载
* `name` 超过 64 个字符 → 发出警告，但仍然加载
* `description` 缺失或为空 → 跳过该 skill（description 对于披露而言是必不可少的），并记录错误
* YAML 完全无法解析 → 跳过该 skill，并记录错误

Record diagnostics so they can be surfaced to the user (in a debug command, log file, or UI), but don't block skill loading on cosmetic issues.

记录这些诊断信息，以便能够展示给用户（通过调试命令、日志文件或 UI），但不要因为无关紧要的格式问题而阻止 skill 的加载。

> The [specification](/specification) defines strict constraints on the `name` field (matching the parent directory, character set, max length). The lenient approach above deliberately relaxes these to improve compatibility with skills authored for other clients.

> [规范](/specification)对 `name` 字段定义了严格的约束（需与父目录一致、字符集限制、最大长度限制）。上文所述的宽松处理方式是刻意放宽了这些限制，以便提升与为其他客户端编写的 skills 之间的兼容性。

### 3.4 What to store - 需要存储哪些内容

At minimum, each skill record needs three fields:

每条 skill 记录至少需要包含三个字段：

| Field         | Description                          |
| ------------- | -------------------------------------- |
| `name`        | From frontmatter                     |
| `description` | From frontmatter                     |
| `location`    | Absolute path to the `SKILL.md` file |

| 字段          | 说明                     |
| ------------- | ------------------------ |
| `name`        | 来自 frontmatter          |
| `description` | 来自 frontmatter          |
| `location`    | `SKILL.md` 文件的绝对路径 |

Store these in an in-memory map keyed by `name` for fast lookup during activation.

将这些信息存储在一个以 `name` 为键的内存映射（map）中，以便在激活时能够快速查找。

You can also store the **body** (the markdown content after the frontmatter) at discovery time, or read it from `location` at activation time. Storing it makes activation faster; reading it at activation time uses less memory in aggregate and picks up changes to skill files between activations.

你也可以选择在发现阶段就存储**正文**（frontmatter 之后的 markdown 内容），或者在激活时再从 `location` 读取。提前存储可以让激活速度更快；在激活时才读取则总体上占用更少的内存，并且能够感知到 skill 文件在两次激活之间发生的变化。

The skill's **base directory** (the parent directory of `location`) is needed later to resolve relative paths and enumerate bundled resources — derive it from `location` when needed.

skill 的**基础目录**（即 `location` 的父目录）在后续解析相对路径、枚举随附资源时会用到——需要时可以直接从 `location` 推导出来。

## 4. Step 3: Disclose available skills to the model - 第 3 步：向模型披露可用的 skills

Tell the model what skills exist without loading their full content. This is [tier 1 of progressive disclosure](#the-core-principle-progressive-disclosure).

在不加载完整内容的前提下，告诉模型有哪些 skills 存在。这就是[渐进式披露的第一层](#the-core-principle-progressive-disclosure)。

### 4.1 Building the skill catalog - 构建 skill 目录清单

For each discovered skill, include `name`, `description`, and optionally `location` (the path to the `SKILL.md` file) in whatever structured format suits your stack — XML, JSON, or a bulleted list all work:

对每一个被发现的 skill，都在适合你技术栈的任意结构化格式中包含它的 `name`、`description`，以及可选的 `location`（`SKILL.md` 文件的路径）——XML、JSON 或者项目符号列表都可以：

```xml theme={null}
<available_skills>
  <skill>
    <name>pdf-processing</name>
    <description>Extract PDF text, fill forms, merge files. Use when handling PDFs.</description>
    <location>/home/user/.agents/skills/pdf-processing/SKILL.md</location>
  </skill>
  <skill>
    <name>data-analysis</name>
    <description>Analyze datasets, generate charts, and create summary reports.</description>
    <location>/home/user/project/.agents/skills/data-analysis/SKILL.md</location>
  </skill>
</available_skills>
```

```xml theme={null}
<available_skills>
  <skill>
    <name>pdf-processing</name>
    <description>提取 PDF 文本、填写表单、合并文件。当处理 PDF 时使用。</description>
    <location>/home/user/.agents/skills/pdf-processing/SKILL.md</location>
  </skill>
  <skill>
    <name>data-analysis</name>
    <description>分析数据集、生成图表并创建摘要报告。</description>
    <location>/home/user/project/.agents/skills/data-analysis/SKILL.md</location>
  </skill>
</available_skills>
```

The `location` field serves two purposes: it enables file-read activation (see [Step 4](#step-4-activate-skills)), and it gives the model a base path for resolving relative references in the skill body (like `scripts/evaluate.py`). If your dedicated activation tool provides the skill directory path in its result (see [Structured wrapping](#structured-wrapping) in Step 4), you can omit `location` from the catalog. Otherwise, include it.

`location` 字段有两个用途：一是支持基于文件读取的激活方式（参见[第 4 步](#step-4-activate-skills)），二是为模型提供一个基础路径，用于解析 skill 正文中的相对引用（例如 `scripts/evaluate.py`）。如果你的专用激活工具会在其返回结果中提供 skill 目录路径（参见第 4 步中的[结构化包装](#structured-wrapping)），那么可以在目录清单中省略 `location`；否则就应当包含它。

Each skill adds roughly 50-100 tokens to the catalog. Even with dozens of skills installed, the catalog remains compact.

每个 skill 大约会给目录清单增加 50-100 个 token。即使安装了几十个 skills，这份目录清单依然能保持精简。

### 4.2 Where to place the catalog - 目录清单放在哪里

Two approaches are common:

有两种常见的做法：

**System prompt section**: Add the catalog as a labeled section in the system prompt, preceded by brief instructions on how to use skills. This is the simplest approach and works with any model that has access to a file-reading tool.

**系统提示词（system prompt）中的一个小节**：将目录清单作为系统提示词中带标签的一个小节加入，前面附上关于如何使用 skills 的简要说明。这是最简单的做法，只要模型能够访问文件读取工具，就可以适用于任何模型。

**Tool description**: Embed the catalog in the description of a dedicated skill-activation tool (see [Step 4](#step-4-activate-skills)). This keeps the system prompt clean and naturally couples discovery with activation.

**工具描述**：将目录清单嵌入到专用 skill 激活工具的描述中（参见[第 4 步](#step-4-activate-skills)）。这样可以让系统提示词保持简洁，并让“发现”与“激活”这两个环节自然地耦合在一起。

Both work. System prompt placement is simpler and more broadly compatible; tool description embedding is cleaner when you have a dedicated activation tool.

两种做法都可行。放在系统提示词中更简单、兼容性也更广泛；如果你已经有一个专用的激活工具，嵌入到工具描述中则会更加简洁。

### 4.3 Behavioral instructions - 行为指令

Include a short instruction block alongside the catalog telling the model how and when to use skills. The wording depends on which activation mechanism you support (see [Step 4](#step-4-activate-skills)):

在目录清单旁边附上一段简短的指令，告诉模型该如何以及何时使用 skills。具体措辞取决于你支持哪种激活机制（参见[第 4 步](#step-4-activate-skills)）：

**If the model activates skills by reading files:**

**如果模型通过读取文件来激活 skills：**

```
The following skills provide specialized instructions for specific tasks.
When a task matches a skill's description, use your file-read tool to load
the SKILL.md at the listed location before proceeding.
When a skill references relative paths, resolve them against the skill's
directory (the parent of SKILL.md) and use absolute paths in tool calls.
```

```
以下 skills 为特定任务提供了专门的指令。
当某个任务与某个 skill 的描述相匹配时，请在继续之前，使用你的文件读取
工具加载所列位置处的 SKILL.md。
当某个 skill 引用相对路径时，请将其相对于该 skill 的目录（即 SKILL.md
的父目录）进行解析，并在工具调用中使用绝对路径。
```

**If the model activates skills via a dedicated tool:**

**如果模型通过专用工具来激活 skills：**

```
The following skills provide specialized instructions for specific tasks.
When a task matches a skill's description, call the activate_skill tool
with the skill's name to load its full instructions.
```

```
以下 skills 为特定任务提供了专门的指令。
当某个任务与某个 skill 的描述相匹配时，调用 activate_skill 工具并传入
该 skill 的名称，以加载其完整指令。
```

Keep these instructions concise. The goal is to tell the model that skills exist and how to load them — the skill content itself provides the detailed instructions once loaded.

请保持这些指令的简洁。其目的只是告诉模型 skills 的存在以及如何加载它们——一旦加载完成，详细的指令自然会由 skill 内容本身来提供。

### 4.4 Filtering - 过滤

Some skills should be excluded from the catalog. Common reasons:

有些 skills 应当从目录清单中排除。常见的原因包括：

* The user has disabled the skill in settings
* A permission system denies access to the skill
* The skill has opted out of model-driven activation (e.g., via a `disable-model-invocation` flag)

* 用户已在设置中禁用了该 skill
* 权限系统拒绝了对该 skill 的访问
* 该 skill 已选择退出模型驱动的激活方式（例如通过 `disable-model-invocation` 标志）

**Hide filtered skills entirely** from the catalog rather than listing them and blocking at activation time. This prevents the model from wasting turns attempting to load skills it can't use.

应当**将被过滤掉的 skills 从目录清单中彻底隐藏**，而不是把它们列出来、等到激活时再加以阻止。这样可以避免模型浪费轮次去尝试加载它无法使用的 skills。

### 4.5 When no skills are available - 当没有可用的 skills 时

If no skills are discovered, omit the catalog and behavioral instructions entirely. Don't show an empty `<available_skills/>` block or register a skill tool with no valid options — this would confuse the model.

如果没有发现任何 skills，就应当完全省略目录清单和行为指令。不要展示一个空的 `<available_skills/>` 块，也不要注册一个没有任何有效选项的 skill 工具——这会让模型感到困惑。

## 5. Step 4: Activate skills - 第 4 步：激活 skills

When the model or user selects a skill, deliver the full instructions into the conversation context. This is [tier 2 of progressive disclosure](#the-core-principle-progressive-disclosure).

当模型或用户选定某个 skill 后，就将完整的指令投递到对话上下文中。这就是[渐进式披露的第二层](#the-core-principle-progressive-disclosure)。

### 5.1 Model-driven activation - 模型驱动的激活

Most implementations rely on the model's own judgment as the activation mechanism, rather than implementing harness-side trigger matching or keyword detection. The model reads the catalog (from [Step 3](#step-3-disclose-available-skills-to-the-model)), decides a skill is relevant to the current task, and loads it.

大多数实现都依靠模型自身的判断作为激活机制，而不是在 harness（宿主程序）一侧实现触发匹配或关键词检测。模型会读取（来自[第 3 步](#step-3-disclose-available-skills-to-the-model)的）目录清单，判断某个 skill 与当前任务相关，然后将其加载。

Two implementation patterns:

有两种实现方式：

**File-read activation**: The model calls its standard file-read tool with the `SKILL.md` path from the catalog. No special infrastructure needed — the agent's existing file-reading capability is sufficient. The model receives the file content as a tool result. This is the simplest approach when the model has file access.

**基于文件读取的激活**：模型调用其标准的文件读取工具，传入目录清单中给出的 `SKILL.md` 路径。这不需要任何特殊的基础设施——智能体现有的文件读取能力就已经足够。模型会以工具结果的形式收到文件内容。当模型具备文件访问能力时，这是最简单的做法。

**Dedicated tool activation**: Register a tool (e.g., `activate_skill`) that takes a skill name and returns the content. This is required when the model can't read files directly, and optional (but useful) even when it can. Advantages over raw file reads:

**基于专用工具的激活**：注册一个工具（例如 `activate_skill`），接收 skill 名称并返回其内容。当模型无法直接读取文件时，这种方式是必需的；而即便模型可以直接读取文件，采用这种方式也是可选的（但很有用）。相比原始的文件读取，它具备以下优势：

* Control what content is returned — e.g., strip YAML frontmatter or preserve it (see [What the model receives](#what-the-model-receives) below)
* Wrap content in structured tags for identification during context management
* List bundled resources (e.g., `references/*`) alongside the instructions
* Enforce permissions or prompt for user consent
* Track activation for analytics

* 可以控制返回哪些内容——例如剥离 YAML frontmatter，或者保留它（参见下文的[模型收到的内容](#what-the-model-receives)）
* 可以用结构化标签包装内容，便于在上下文管理时进行识别
* 可以在返回指令的同时，列出随附的资源（例如 `references/*`）
* 可以强制执行权限校验，或提示用户进行确认
* 可以为分析统计而记录激活情况

> If you use a dedicated activation tool, constrain the `name` parameter to the set of valid skill names (e.g., as an enum in the tool schema). This prevents the model from hallucinating nonexistent skill names. If no skills are available, don't register the tool at all.

> 如果你使用专用的激活工具，应当将 `name` 参数约束为有效 skill 名称的集合（例如在工具的 schema 中将其定义为枚举）。这样可以防止模型幻觉出并不存在的 skill 名称。如果没有可用的 skills，那就完全不要注册这个工具。

### 5.2 User-explicit activation - 用户显式激活

Users should also be able to activate skills directly, without waiting for the model to decide. The most common pattern is a **slash command or mention syntax** (`/skill-name` or `$skill-name`) that the harness intercepts. The specific syntax is up to you — the key idea is that the harness handles the lookup and injection, so the model receives skill content without needing to take an activation action itself.

用户也应当能够直接激活 skills，而不必等待模型做出决定。最常见的模式是由 harness 拦截的**斜杠命令或提及语法**（`/skill-name` 或 `$skill-name`）。具体的语法形式由你自行决定——核心思路是：查找与注入的工作由 harness 来完成，因此模型无需自己执行激活动作，就能收到 skill 内容。

An autocomplete widget (listing available skills as the user types) can also make this discoverable.

一个自动补全控件（在用户输入时列出可用的 skills）也有助于让用户发现这一功能。

### 5.3 What the model receives - 模型收到的内容

When a skill is activated, the model receives the skill's instructions. Two options for what exactly that content looks like:

当某个 skill 被激活时，模型会收到该 skill 的指令。至于这些内容具体呈现为什么样子，有两种选择：

**Full file**: The model sees the entire `SKILL.md` including YAML frontmatter. This is the natural outcome with file-read activation, where the model reads the raw file. It's also a valid choice for dedicated tools. The frontmatter may contain fields useful at activation time — for example, [`compatibility`](/specification#compatibility-field) notes environment requirements that could inform how the model executes the skill's instructions.

**完整文件**：模型看到的是包括 YAML frontmatter 在内的整个 `SKILL.md`。在基于文件读取的激活方式中，由于模型直接读取的是原始文件，这是自然而然的结果；对于专用工具而言，这也是一种合理的选择。frontmatter 中可能包含一些在激活时有用的字段——例如 [`compatibility`](/specification#compatibility-field) 会说明环境要求，这可能会影响模型执行该 skill 指令的方式。

**Body only (frontmatter stripped)**: The harness parses and removes the YAML frontmatter, returning only the markdown instructions. Among existing implementations with dedicated activation tools, most take this approach — stripping the frontmatter after extracting `name` and `description` during discovery.

**仅正文（去除 frontmatter）**：harness 解析并移除 YAML frontmatter，只返回 markdown 指令部分。在现有的、带有专用激活工具的实现中，大多数都采用这种做法——在发现阶段提取出 `name` 和 `description` 之后，就将 frontmatter 剥离掉。

Both approaches work in practice.

这两种方式在实践中都是可行的。

### 5.4 Structured wrapping - 结构化包装

If you use a dedicated activation tool, consider wrapping skill content in identifying tags. For example:

如果你使用专用的激活工具，可以考虑用带标识作用的标签把 skill 内容包裹起来。例如：

```xml theme={null}
<skill_content name="pdf-processing">
# PDF Processing

## When to use this skill
Use this skill when the user needs to work with PDF files...

[rest of SKILL.md body]

Skill directory: /home/user/.agents/skills/pdf-processing
Relative paths in this skill are relative to the skill directory.

<skill_resources>
  <file>scripts/extract.py</file>
  <file>scripts/merge.py</file>
  <file>references/pdf-spec-summary.md</file>
</skill_resources>
</skill_content>
```

```xml theme={null}
<skill_content name="pdf-processing">
# PDF 处理

## 何时使用此 skill
当用户需要处理 PDF 文件时使用此 skill……

[SKILL.md 正文的其余部分]

Skill 目录：/home/user/.agents/skills/pdf-processing
此 skill 中的相对路径均相对于该 skill 目录而言。

<skill_resources>
  <file>scripts/extract.py</file>
  <file>scripts/merge.py</file>
  <file>references/pdf-spec-summary.md</file>
</skill_resources>
</skill_content>
```

This has practical benefits:

这样做具有实际的好处：

* The model can clearly distinguish skill instructions from other conversation content
* The harness can identify skill content during context compaction ([Step 5](#step-5-manage-skill-context-over-time))
* Bundled resources are surfaced to the model without being eagerly loaded

* 模型可以清楚地将 skill 指令与其他对话内容区分开来
* harness 可以在上下文压缩（[第 5 步](#step-5-manage-skill-context-over-time)）时识别出 skill 内容
* 随附的资源会被展示给模型，但不会被急切地（提前）加载

### 5.5 Listing bundled resources - 列出随附的资源

When a dedicated activation tool returns skill content, it can also enumerate supporting files (scripts, references, assets) in the skill directory — but it should **not eagerly read them**. The model loads specific files on demand using its file-read tools when the skill's instructions reference them.

当专用的激活工具返回 skill 内容时，它也可以枚举出该 skill 目录中的配套文件（脚本、参考资料、静态资源）——但**不应该急切地读取它们**。只有当 skill 的指令中引用了某个具体文件时，模型才会使用自己的文件读取工具按需加载它。

For large skill directories, consider capping the listing and noting that it may be incomplete.

对于较大的 skill 目录，可以考虑对列表数量设置上限，并注明该列表可能并不完整。

### 5.6 Permission allowlisting - 权限允许列表

If your agent has a permission system that gates file access, **allowlist skill directories** so the model can read bundled resources without triggering user confirmation prompts. Without this, every reference to a bundled script or reference file results in a permission dialog, breaking the flow for skills that include resources beyond the `SKILL.md` itself.

如果你的智能体有一套用于管控文件访问的权限系统，应当**将 skill 目录加入允许列表**，这样模型就能读取随附的资源，而不会触发用户确认弹窗。如果不这样做，每次引用随附的脚本或参考资料文件都会弹出权限对话框，这会打断那些除 `SKILL.md` 本身之外还包含其他资源的 skills 的使用流程。

## 6. Step 5: Manage skill context over time - 第 5 步：随时间管理 skill 的上下文

Once skill instructions are in the conversation context, keep them effective for the duration of the session.

一旦 skill 指令进入了对话上下文，就要确保它们在整个会话期间持续保持有效。

### 6.1 Protect skill content from context compaction - 保护 skill 内容不被上下文压缩

If your agent truncates or summarizes older messages when the context window fills up, **exempt skill content from pruning**. Skill instructions are durable behavioral guidance — losing them mid-conversation silently degrades the agent's performance without any visible error. The model continues operating but without the specialized instructions the skill provided.

如果你的智能体会在上下文窗口填满时截断或总结较早的消息，那么应当**让 skill 内容豁免于这种裁剪（pruning）**。Skill 指令是持久性的行为指导——如果在对话中途丢失了它们，会在没有任何可见错误的情况下，悄无声息地降低智能体的表现。模型仍会继续运作，但已经失去了该 skill 原本提供的专业指令。

Common approaches:

常见的做法包括：

* Flag skill tool outputs as protected so the pruning algorithm skips them
* Use the [structured tags](#structured-wrapping) from Step 4 to identify skill content and preserve it during compaction

* 将 skill 工具的输出标记为受保护状态，使裁剪算法跳过它们
* 使用[第 4 步](#step-4-activate-skills)中的[结构化标签](#structured-wrapping)来识别 skill 内容，并在压缩过程中将其保留下来

### 6.2 Deduplicate activations - 去重激活

Consider tracking which skills have been activated in the current session. If the model (or user) attempts to load a skill that's already in context, you can skip the re-injection to avoid the same instructions appearing multiple times in the conversation.

可以考虑追踪当前会话中哪些 skills 已经被激活过。如果模型（或用户）试图加载一个已经在上下文中的 skill，你可以跳过这次重复注入，避免同一份指令在对话中多次出现。

### 6.3 Subagent delegation (optional) - 子智能体委托（可选）

This is an advanced pattern only supported by some clients. Instead of injecting skill instructions into the main conversation, the skill is run in a **separate subagent session**. The subagent receives the skill instructions, performs the task, and returns a summary of its work to the main conversation.

这是一种只有部分客户端支持的高级模式。它不是将 skill 指令注入到主对话中，而是让该 skill 在一个**独立的子智能体会话**中运行。子智能体接收 skill 指令、执行任务，然后将其工作成果的摘要返回给主对话。

This pattern is useful when a skill's workflow is complex enough to benefit from a dedicated, focused session.

当某个 skill 的工作流足够复杂、能够从一个专注、独立的会话中获益时，这种模式就会很有用。
