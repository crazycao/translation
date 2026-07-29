# Using scripts in skills - 在 skill 中使用脚本

原文地址：[https://agentskills.io/skill-creation/using-scripts](https://agentskills.io/skill-creation/using-scripts)

> How to run commands and bundle executable scripts in your skills.

> 如何运行命令，以及如何在 skill 中打包可执行脚本。

Skills can instruct agents to run shell commands and bundle reusable scripts in a `scripts/` directory. This guide covers one-off commands, self-contained scripts with their own dependencies, and how to design script interfaces for agentic use.

Skill 可以指示智能体运行 shell 命令，并在 `scripts/` 目录中打包可复用的脚本。本指南涵盖一次性命令、带有自身依赖的自包含脚本，以及如何为智能体使用场景设计脚本接口。

## 1. One-off commands - 一次性命令

When an existing package already does what you need, you can reference it directly in your `SKILL.md` instructions without a `scripts/` directory. Many ecosystems provide tools that auto-resolve dependencies at runtime.

当现有的包已经能满足你的需求时，你可以直接在 `SKILL.md` 的指令中引用它，而不需要 `scripts/` 目录。许多生态系统都提供了能在运行时自动解析依赖的工具。

- **uvx**
    
    [uvx](https://docs.astral.sh/uv/guides/tools/) runs Python packages in isolated environments with aggressive caching. It ships with [uv](https://docs.astral.sh/uv/).

    [uvx](https://docs.astral.sh/uv/guides/tools/) 会在隔离环境中运行 Python 包，并进行积极的缓存。它随 [uv](https://docs.astral.sh/uv/) 一起提供。

    ```bash theme={null}
    uvx ruff@0.8.0 check .
    uvx black@24.10.0 .
    ```

    * Not bundled with Python — requires a separate install.
    * Fast. Caches aggressively so repeat runs are near-instant.

    * 不随 Python 一起提供——需要单独安装。
    * 速度快。缓存策略十分积极，因此重复运行时几乎是瞬间完成。
  

- **pipx**
  
    [pipx](https://pipx.pypa.io/) runs Python packages in isolated environments. Available via OS package managers (`apt install pipx`, `brew install pipx`).

    [pipx](https://pipx.pypa.io/) 会在隔离环境中运行 Python 包。可以通过操作系统的包管理器安装（`apt install pipx`、`brew install pipx`）。

    ```bash theme={null}
    pipx run 'black==24.10.0' .
    pipx run 'ruff==0.8.0' check .
    ```

    * Not bundled with Python — requires a separate install.
    * A mature alternative to `uvx`. While `uvx` has become the standard recommendation, `pipx` remains a reliable option with broader OS package manager availability.

    * 不随 Python 一起提供——需要单独安装。
    * 是 `uvx` 的一个成熟替代方案。虽然 `uvx` 已经成为标准推荐做法，但 `pipx` 依然是一个可靠的选择，且在操作系统包管理器中的可用性更广。

- **npx**
  
    [npx](https://docs.npmjs.com/cli/commands/npx) runs npm packages, downloading them on demand. It ships with npm (which ships with Node.js).

    [npx](https://docs.npmjs.com/cli/commands/npx) 会按需下载并运行 npm 包。它随 npm（而 npm 又随 Node.js）一起提供。

    ```bash theme={null}
    npx eslint@9 --fix .
    npx create-vite@6 my-app
    ```

    * Bundled with Node.js — no extra install needed.
    * Downloads the package, runs it, and caches it for future use.
    * Pin versions with `npx package@version` for reproducibility.

    * 随 Node.js 一起提供——不需要额外安装。
    * 会下载包、运行它，并缓存以供后续使用。
    * 使用 `npx package@version` 锁定版本，以保证可复现性。

- **bunx**

    [bunx](https://bun.sh/docs/cli/bunx) is Bun's equivalent of `npx`. It ships with [Bun](https://bun.sh/).

    [bunx](https://bun.sh/docs/cli/bunx) 是 Bun 版本的 `npx`。它随 [Bun](https://bun.sh/) 一起提供。

    ```bash theme={null}
    bunx eslint@9 --fix .
    bunx create-vite@6 my-app
    ```

    * Drop-in replacement for `npx` in Bun-based environments.
    * Only appropriate when the user's environment has Bun rather than Node.js.

    * 在基于 Bun 的环境中可以直接替代 `npx`。
    * 只适用于用户环境中安装的是 Bun 而不是 Node.js 的情况。

- **deno run**
    [deno run](https://docs.deno.com/runtime/reference/cli/run/) runs scripts directly from URLs or specifiers. It ships with [Deno](https://deno.com/).

    [deno run](https://docs.deno.com/runtime/reference/cli/run/) 可以直接从 URL 或说明符运行脚本。它随 [Deno](https://deno.com/) 一起提供。

    ```bash theme={null}
    deno run npm:create-vite@6 my-app
    deno run --allow-read npm:eslint@9 -- --fix .
    ```

    * Permission flags (`--allow-read`, etc.) are required for filesystem/network access.
    * Use `--` to separate Deno flags from the tool's own flags.

    * 访问文件系统/网络需要权限 flag（`--allow-read` 等）。
    * 使用 `--` 来区分 Deno 自身的 flag 和被调用工具的 flag。

- **go run**

    [go run](https://pkg.go.dev/cmd/go#hdr-Compile_and_run_Go_program) compiles and runs Go packages directly. It is built into the `go` command.

    [go run](https://pkg.go.dev/cmd/go#hdr-Compile_and_run_Go_program) 会直接编译并运行 Go 包。它内置于 `go` 命令中。

    ```bash theme={null}
    go run golang.org/x/tools/cmd/goimports@v0.28.0 .
    go run github.com/golangci/golangci-lint/cmd/golangci-lint@v1.62.0 run
    ```

    * Built into Go — no extra tooling needed.
    * Pin versions or use `@latest` to make the command explicit.

    * 内置于 Go——不需要额外的工具。
    * 锁定版本，或者使用 `@latest` 让命令的行为更明确。

**Tips for one-off commands in skills:**

**在 skill 中使用一次性命令的小技巧：**

* **Pin versions** (e.g., `npx eslint@9.0.0`) so the command behaves the same over time.
* **State prerequisites** in your `SKILL.md` (e.g., "Requires Node.js 18+") rather than assuming the agent's environment has them. For runtime-level requirements, use the [`compatibility` frontmatter field](/specification#compatibility-field).
* **Move complex commands into scripts.** A one-off command works well when you're invoking a tool with a few flags. When a command grows complex enough that it's hard to get right on the first try, a tested script in `scripts/` is more reliable.

* **锁定版本**（例如 `npx eslint@9.0.0`），这样命令的行为才能长期保持一致。
* **在 `SKILL.md` 中声明前置条件**（例如“需要 Node.js 18+”），而不是假设智能体的环境已经具备这些条件。对于运行时层面的要求，使用 [`compatibility` 前言（Frontmatter）字段](/specification#compatibility-field)。
* **把复杂的命令移入脚本。** 当你只是用几个 flag 调用一个工具时，一次性命令效果很好；但当命令复杂到很难第一次就写对时，`scripts/` 目录下一个经过测试的脚本会更可靠。

## 2. Referencing scripts from `SKILL.md` - 从 `SKILL.md` 引用脚本

Use **relative paths from the skill directory root** to reference bundled files. The agent resolves these paths automatically — no absolute paths needed.

使用**相对于 skill 目录根路径的相对路径**来引用打包的文件。智能体会自动解析这些路径——不需要绝对路径。

List available scripts in your `SKILL.md` so the agent knows they exist:

在你的 `SKILL.md` 中列出可用的脚本，让智能体知道它们的存在：

```markdown SKILL.md theme={null}
## Available scripts

- **`scripts/validate.sh`** — Validates configuration files
- **`scripts/process.py`** — Processes input data
```

```markdown SKILL.md theme={null}
## 可用脚本

- **`scripts/validate.sh`** — 校验配置文件
- **`scripts/process.py`** — 处理输入数据
```

Then instruct the agent to run them:

然后指示智能体运行它们：

````markdown SKILL.md theme={null}
## Workflow

1. Run the validation script:
   ```bash
   bash scripts/validate.sh "$INPUT_FILE"
   ```

2. Process the results:
   ```bash
   python3 scripts/process.py --input results.json
   ```
````

````markdown SKILL.md theme={null}
## 工作流程

1. 运行校验脚本：
   ```bash
   bash scripts/validate.sh "$INPUT_FILE"
   ```

2. 处理结果：
   ```bash
   python3 scripts/process.py --input results.json
   ```
````

> The same relative-path convention works in support files like `references/*.md` — script execution paths (in code blocks) are relative to the **skill directory root**, because the agent runs commands from there.

> 同样的相对路径约定也适用于像 `references/*.md` 这样的支持文件——脚本执行路径（代码块中的路径）是相对于**skill 目录根路径**的，因为智能体正是从这个位置运行命令的。

## 3. Self-contained scripts - 自包含脚本

When you need reusable logic, bundle a script in `scripts/` that declares its own dependencies inline. The agent can run the script with a single command — no separate manifest file or install step required.

当你需要可复用的逻辑时，可以在 `scripts/` 中打包一个内联声明自身依赖的脚本。智能体只需一条命令就能运行该脚本——不需要单独的清单文件或安装步骤。

Several languages support inline dependency declarations:

有几种语言支持内联依赖声明：

- **Python**

    [PEP 723](https://peps.python.org/pep-0723/) defines a standard format for inline script metadata. Declare dependencies in a TOML block inside `# ///` markers:

    [PEP 723](https://peps.python.org/pep-0723/) 定义了内联脚本元数据的标准格式。在 `# ///` 标记内的 TOML 代码块中声明依赖：

    ```python scripts/extract.py theme={null}
    # /// script
    # dependencies = [
    #   "beautifulsoup4",
    # ]
    # ///

    from bs4 import BeautifulSoup

    html = '<html><body><h1>Welcome</h1><p class="info">This is a test.</p></body></html>'
    print(BeautifulSoup(html, "html.parser").select_one("p.info").get_text())
    ```

    Run with [uv](https://docs.astral.sh/uv/) (recommended):

    推荐使用 [uv](https://docs.astral.sh/uv/) 来运行：

    ```bash theme={null}
    uv run scripts/extract.py
    ```

    `uv run` creates an isolated environment, installs the declared dependencies, and runs the script. [pipx](https://pipx.pypa.io/) (`pipx run scripts/extract.py`) also supports PEP 723.

    `uv run` 会创建一个隔离环境，安装声明的依赖，并运行脚本。[pipx](https://pipx.pypa.io/)（`pipx run scripts/extract.py`）同样支持 PEP 723。

    * Pin versions with [PEP 508](https://peps.python.org/pep-0508/) specifiers: `"beautifulsoup4>=4.12,<5"`.
    * Use `requires-python` to constrain the Python version.
    * Use `uv lock --script` to create a lockfile for full reproducibility.

    * 使用 [PEP 508](https://peps.python.org/pep-0508/) 规范来锁定版本：`"beautifulsoup4>=4.12,<5"`。
    * 使用 `requires-python` 来限制 Python 版本。
    * 使用 `uv lock --script` 创建一个 lockfile，以实现完全的可复现性。
  
- **Deno**
    
    Deno's `npm:` and `jsr:` import specifiers make every script self-contained by default:

    Deno 的 `npm:` 和 `jsr:` 导入说明符默认就能让每个脚本都自包含：

    ```typescript scripts/extract.ts theme={null}
    #!/usr/bin/env -S deno run

    import * as cheerio from "npm:cheerio@1.0.0";

    const html = `<html><body><h1>Welcome</h1><p class="info">This is a test.</p></body></html>`;
    const $ = cheerio.load(html);
    console.log($("p.info").text());
    ```

    ```bash theme={null}
    deno run scripts/extract.ts
    ```

    * Use `npm:` for npm packages, `jsr:` for Deno-native packages.
    * Version specifiers follow semver: `@1.0.0` (exact), `@^1.0.0` (compatible).
    * Dependencies are cached globally. Use `--reload` to force re-fetch.
    * Packages with native addons (node-gyp) may not work — packages that ship pre-built binaries work best.

    * npm 包使用 `npm:`，Deno 原生包使用 `jsr:`。
    * 版本说明符遵循 semver 规范：`@1.0.0`（精确匹配）、`@^1.0.0`（兼容匹配）。
    * 依赖会被全局缓存。使用 `--reload` 强制重新拉取。
    * 带有原生插件（node-gyp）的包可能无法正常工作——提供预编译二进制文件的包效果最好。

- **Bun**
    
    Bun auto-installs missing packages at runtime when no `node_modules` directory is found. Pin versions directly in the import path:

    当找不到 `node_modules` 目录时，Bun 会在运行时自动安装缺失的包。可以直接在导入路径中锁定版本：

    ```typescript scripts/extract.ts theme={null}
    #!/usr/bin/env bun

    import * as cheerio from "cheerio@1.0.0";

    const html = `<html><body><h1>Welcome</h1><p class="info">This is a test.</p></body></html>`;
    const $ = cheerio.load(html);
    console.log($("p.info").text());
    ```

    ```bash theme={null}
    bun run scripts/extract.ts
    ```

    * No `package.json` or `node_modules` needed. TypeScript works natively.
    * Packages are cached globally. First run downloads; subsequent runs are near-instant.
    * If a `node_modules` directory exists anywhere up the directory tree, auto-install is disabled and Bun falls back to standard Node.js resolution.

    * 不需要 `package.json` 或 `node_modules`。TypeScript 原生可用。
    * 包会被全局缓存。首次运行会下载，之后的运行几乎瞬间完成。
    * 如果目录树中任何上级目录存在 `node_modules`，自动安装就会被禁用，Bun 会退回到标准的 Node.js 解析方式。

- **Ruby**
    
    Bundler ships with Ruby since 2.6. Use `bundler/inline` to declare gems directly in the script:

    自 2.6 版本起，Bundler 就随 Ruby 一起提供。使用 `bundler/inline` 可以直接在脚本中声明 gem：

    ```ruby scripts/extract.rb theme={null}
    require 'bundler/inline'

    gemfile do
      source 'https://rubygems.org'
      gem 'nokogiri'
    end

    html = '<html><body><h1>Welcome</h1><p class="info">This is a test.</p></body></html>'
    doc = Nokogiri::HTML(html)
    puts doc.at_css('p.info').text
    ```

    ```bash theme={null}
    ruby scripts/extract.rb
    ```

    * Pin versions explicitly (`gem 'nokogiri', '~> 1.16'`) — there is no lockfile.
    * An existing `Gemfile` or `BUNDLE_GEMFILE` env var in the working directory can interfere.

    * 显式锁定版本（`gem 'nokogiri', '~> 1.16'`）——因为没有 lockfile。
    * 工作目录中已存在的 `Gemfile` 或 `BUNDLE_GEMFILE` 环境变量可能会造成干扰。

## 4. Designing scripts for agentic use - 为智能体使用场景设计脚本

When an agent runs your script, it reads stdout and stderr to decide what to do next. A few design choices make scripts dramatically easier for agents to use.

当智能体运行你的脚本时，它会读取 stdout 和 stderr 来决定下一步做什么。一些设计上的选择能让脚本对智能体来说好用得多。

### 4.1 Avoid interactive prompts - 避免交互式提示

This is a hard requirement of the agent execution environment. Agents operate in non-interactive shells — they cannot respond to TTY prompts, password dialogs, or confirmation menus. A script that blocks on interactive input will hang indefinitely.

这是智能体执行环境的硬性要求。智能体运行在非交互式 shell 中——它们无法响应 TTY 提示、密码对话框或确认菜单。任何在交互式输入上阻塞的脚本都会无限期挂起。

Accept all input via command-line flags, environment variables, or stdin:

所有输入都应通过命令行 flag、环境变量或 stdin 来接收：

```
# Bad: hangs waiting for input
$ python scripts/deploy.py
Target environment: _

# Good: clear error with guidance
$ python scripts/deploy.py
Error: --env is required. Options: development, staging, production.
Usage: python scripts/deploy.py --env staging --tag v1.2.3
```

```
# 不好的做法：挂起等待输入
$ python scripts/deploy.py
目标环境：_

# 好的做法：给出清晰的错误提示
$ python scripts/deploy.py
错误：需要提供 --env。可选项：development、staging、production。
用法：python scripts/deploy.py --env staging --tag v1.2.3
```

### 4.2 Document usage with `--help` - 用 `--help` 记录用法

`--help` output is the primary way an agent learns your script's interface. Include a brief description, available flags, and usage examples:

`--help` 的输出是智能体了解你脚本接口的主要方式。请在其中包含简要描述、可用的 flag，以及使用示例：

```
Usage: scripts/process.py [OPTIONS] INPUT_FILE

Process input data and produce a summary report.

Options:
  --format FORMAT    Output format: json, csv, table (default: json)
  --output FILE      Write output to FILE instead of stdout
  --verbose          Print progress to stderr

Examples:
  scripts/process.py data.csv
  scripts/process.py --format csv --output report.csv data.csv
```

```
用法：scripts/process.py [OPTIONS] INPUT_FILE

处理输入数据并生成一份摘要报告。

选项：
  --format FORMAT    输出格式：json、csv、table（默认：json）
  --output FILE      把输出写入 FILE，而不是 stdout
  --verbose          将进度信息打印到 stderr

示例：
  scripts/process.py data.csv
  scripts/process.py --format csv --output report.csv data.csv
```

Keep it concise — the output enters the agent's context window alongside everything else it's working with.

保持简洁——这些输出会和智能体正在处理的其他一切内容一起进入它的上下文窗口。

### 4.3 Write helpful error messages - 编写有用的错误信息

When an agent gets an error, the message directly shapes its next attempt. An opaque "Error: invalid input" wastes a turn. Instead, say what went wrong, what was expected, and what to try:

当智能体遇到错误时，错误信息会直接影响它的下一次尝试。一句含糊不清的“错误：输入无效”会浪费一个回合。相反，应该说明哪里出错了、期望的是什么，以及可以尝试什么：

```
Error: --format must be one of: json, csv, table.
       Received: "xml"
```

```
错误：--format 必须是以下值之一：json、csv、table。
      收到的值："xml"
```

### 4.4 Use structured output - 使用结构化输出

Prefer structured formats — JSON, CSV, TSV — over free-form text. Structured formats can be consumed by both the agent and standard tools (`jq`, `cut`, `awk`), making your script composable in pipelines.

优先使用结构化格式——JSON、CSV、TSV——而不是自由格式的文本。结构化格式既能被智能体使用，也能被标准工具（`jq`、`cut`、`awk`）处理，这让你的脚本可以在管道中组合使用。

```
# Whitespace-aligned — hard to parse programmatically
NAME          STATUS    CREATED
my-service    running   2025-01-15

# Delimited — unambiguous field boundaries
{"name": "my-service", "status": "running", "created": "2025-01-15"}
```

```
# 用空白对齐——难以用程序解析
NAME          STATUS    CREATED
my-service    running   2025-01-15

# 用分隔符分隔——字段边界无歧义
{"name": "my-service", "status": "running", "created": "2025-01-15"}
```

**Separate data from diagnostics:** send structured data to stdout and progress messages, warnings, and other diagnostics to stderr. This lets the agent capture clean, parseable output while still having access to diagnostic information when needed.

**将数据与诊断信息分开：** 把结构化数据发送到 stdout，把进度消息、警告和其他诊断信息发送到 stderr。这样智能体既能获取干净、可解析的输出，又能在需要时访问诊断信息。

### 4.5 Further considerations - 其他注意事项

* **Idempotency.** Agents may retry commands. "Create if not exists" is safer than "create and fail on duplicate."
* **Input constraints.** Reject ambiguous input with a clear error rather than guessing. Use enums and closed sets where possible.
* **Dry-run support.** For destructive or stateful operations, a `--dry-run` flag lets the agent preview what will happen.
* **Meaningful exit codes.** Use distinct exit codes for different failure types (not found, invalid arguments, auth failure) and document them in your `--help` output so the agent knows what each code means.
* **Safe defaults.** Consider whether destructive operations should require explicit confirmation flags (`--confirm`, `--force`) or other safeguards appropriate to the risk level.
* **Predictable output size.** Many agent harnesses automatically truncate tool output beyond a threshold (e.g., 10-30K characters), potentially losing critical information. If your script might produce large output, default to a summary or a reasonable limit, and support flags like `--offset` so the agent can request more information when needed. Alternatively, if output is large and not amenable to pagination, require agents to pass an `--output` flag that specifies either an output file or `-` to explicitly opt in to stdout.

* **幂等性。** 智能体可能会重试命令。“若不存在则创建”比“创建，若已存在则报错”更安全。
* **输入约束。** 遇到有歧义的输入时，应给出明确的错误而不是靠猜测。尽可能使用枚举值和封闭集合。
* **支持 dry-run。** 对于具有破坏性或会改变状态的操作，`--dry-run` 标识能让智能体预览将会发生什么。
* **有意义的退出码。** 为不同类型的失败（未找到、参数无效、鉴权失败）使用不同的退出码，并在 `--help` 输出中说明每个退出码的含义，让智能体能够理解。
* **安全的默认值。** 考虑破坏性操作是否应该要求显式的确认 flag（`--confirm`、`--force`），或者其他与风险等级相匹配的保护措施。
* **可预测的输出体积。** 许多智能体运行环境（agent harness）会在工具输出超过某个阈值（例如 10-30K 字符）时自动截断，可能会因此丢失关键信息。如果你的脚本可能产生较大的输出，默认输出摘要或一个合理的上限，并支持像 `--offset` 这样的 flag，让智能体可以在需要时请求更多信息。或者，如果输出体积很大又不便分页，就要求智能体传入一个 `--output` 标识，指定一个输出文件，或者用 `-` 来显式选择输出到 stdout。
