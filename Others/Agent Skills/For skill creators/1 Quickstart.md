# Quickstart - 快速开始

原文地址：[https://agentskills.io/skill-creation/quickstart](https://agentskills.io/skill-creation/quickstart)

> Create your first Agent Skill and see it work in VS Code.

> 创建你的第一个 Agent Skill，并在 VS Code 中看到它实际运行的效果。

In this tutorial, you'll create a skill that gives an agent the capability to roll dice using a random number generator.

在本教程中，你将创建一个 skill，让智能体拥有使用随机数生成器来掷骰子的能力。

## Prerequisites - 前置条件

* [VS Code](https://code.visualstudio.com/) with [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)

* [VS Code](https://code.visualstudio.com/) 并安装 [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)

> This tutorial uses VS Code, but Agent Skills are an open format. The same skill works in any compatible agent, including Claude Code and OpenAI Codex.

> 本教程使用 VS Code，但 Agent Skills 是一种开放格式。同一个 skill 可以在任何兼容的智能体中使用，包括 Claude Code 和 OpenAI Codex。

## Create the skill - 创建 skill

A skill is a folder containing a `SKILL.md` file. VS Code looks for skills in `.agents/skills/` by default. Create `.agents/skills/roll-dice/SKILL.md` in your project:

一个 skill 就是一个包含 `SKILL.md` 文件的文件夹。VS Code 默认在 `.agents/skills/` 目录下查找 skills。在你的项目中创建 `.agents/skills/roll-dice/SKILL.md` 文件：

````markdown .agents/skills/roll-dice/SKILL.md theme={null}
---
name: roll-dice
description: Roll dice using a random number generator. Use when asked to roll a die (d6, d20, etc.), roll dice, or generate a random dice roll.
---

To roll a die, use the following command that generates a random number from 1
to the given number of sides:

```bash
echo $((RANDOM % <sides> + 1))
```

```powershell
Get-Random -Minimum 1 -Maximum (<sides> + 1)
```

Replace `<sides>` with the number of sides on the die (e.g., 6 for a standard
die, 20 for a d20).
````

````markdown .agents/skills/roll-dice/SKILL.md theme={null}
---
name: roll-dice
description: 使用随机数生成器掷骰子。当被要求掷骰子（d6、d20 等）、掷骰或者生成一次随机掷骰结果时使用。
---

要掷一次骰子，请使用下面的命令，它会生成一个介于 1 到指定面数之间的随机数：

```bash
echo $((RANDOM % <sides> + 1))
```

```powershell
Get-Random -Minimum 1 -Maximum (<sides> + 1)
```

将 `<sides>` 替换为骰子的面数（例如标准骰子填 6，d20 骰子填 20）。
````

That's it — one file, under 20 lines. Here's what each part does:

就这么简单——一个文件，不到 20 行。下面说明每部分的作用：

* **`name`** — A short identifier for the skill. Must match the folder name.
* **`description`** — Tells the agent when to use this skill. This is how the agent decides whether to activate it.
* **The body** — Instructions the agent follows when the skill activates. Here, the agent is instructed to generate a random number using a terminal command, substituting the number of sides from the user's request.

* **`name`** — skill 的简短标识符。必须与其所在文件夹的名称一致。
* **`description`** — 告诉智能体何时使用该 skill。智能体依据这段描述来决定是否激活它。
* **正文（body）** — 当 skill 被激活时，智能体所遵循的指令。这里的指令告诉智能体使用一条终端命令来生成随机数，并将用户请求中的面数代入其中。

## Try it out - 试用一下

1. Open your project in VS Code.
2. Open the Copilot Chat panel.
3. Select **Agent** mode from the mode dropdown at the bottom of the chat panel.
4. Type `/skills` to confirm that `roll-dice` appears in the list. If it doesn't, check that the file is at `.agents/skills/roll-dice/SKILL.md` relative to your project root.
5. Ask: **"Roll a d20"**

1. 在 VS Code 中打开你的项目。
2. 打开 Copilot Chat 面板。
3. 在聊天面板底部的模式下拉框中选择 **Agent** 模式。
4. 输入 `/skills`，确认列表中出现 `roll-dice`。如果没有，请检查文件是否位于项目根目录下的 `.agents/skills/roll-dice/SKILL.md`。
5. 提问：**"Roll a d20"**（掷一个 d20）

The agent should activate the `roll-dice` skill. It may ask for permission to run a terminal command — allow it. It will run the command and return a random number between 1 and 20.

智能体应当会激活 `roll-dice` 这个 skill。它可能会请求运行终端命令的权限——允许它。它会执行该命令并返回一个 1 到 20 之间的随机数。

> Tool-use reliability varies across models — some follow skill instructions and run commands consistently, while others may attempt to answer on their own. If the agent responds without running a terminal command, try selecting a different model from the model dropdown.

> 不同模型在工具调用可靠性方面表现不同——有些模型能稳定地遵循 skill 指令并执行命令，而有些模型可能会试图自己直接给出答案。如果智能体在没有运行终端命令的情况下就作出了回复，可以尝试在模型下拉框中选择另一个模型。

## How it works - 工作原理

Here's what happened behind the scenes:

下面是幕后发生的事情：

1. **Discovery** — When the chat session started, the agent scanned default skill directories and found your skill. It read only the `name` and `description`, just enough to know when the skill might be relevant.

1. **发现（Discovery）** — 聊天会话开始时，智能体扫描默认的 skill 目录并发现了你的 skill。它只读取了 `name` 和 `description`，仅此以判断该 skill 何时可能相关。

2. **Activation** — When you asked about rolling dice, the agent matched your question to the skill's description and loaded the full `SKILL.md` body into context.

2. **激活（Activation）** — 当你询问关于掷骰子的问题时，智能体将你的提问与该 skill 的 description 匹配上，并把完整的 `SKILL.md` 正文加载进上下文。

3. **Execution** — The agent followed the instructions in the body, adapting the terminal command to the number of sides in your request.

3. **执行（Execution）** — 智能体按照正文中的指令行动，把终端命令根据你请求中的面数进行调整。

This process uses **progressive disclosure** to let the agent access many skills without loading all their instructions up front.

这一过程利用了**渐进式披露（progressive disclosure）**，让智能体可以在无需预先加载所有指令的情况下访问众多 skills。

## Next steps - 后续步骤

You've created a working Agent Skill. From here:

你已经创建了一个可用的 Agent Skill。接下来可以继续了解：

* **[Best practices](/skill-creation/best-practices)** — How to write skills that are well-scoped and effective.
* **[Optimizing skill descriptions](/skill-creation/optimizing-descriptions)** — Test and improve your skill's description so it activates on the right prompts.
* **[Specification](/specification)** — The complete format reference for `SKILL.md` files.
* **[Example skills](https://github.com/anthropics/skills)** — Browse real-world skills on GitHub.

* **[最佳实践（Best practices）](/skill-creation/best-practices)** — 如何编写范围合适且行之有效的 skill。
* **[优化 skill 描述（Optimizing skill descriptions）](/skill-creation/optimizing-descriptions)** — 测试并改进你的 skill 描述，使它能在正确的提示下被激活。
* **[规范（Specification）](/specification)** — `SKILL.md` 文件的完整格式参考。
* **[示例 skills（Example skills）](https://github.com/anthropics/skills)** — 在 GitHub 上浏览真实世界中的 skills。
