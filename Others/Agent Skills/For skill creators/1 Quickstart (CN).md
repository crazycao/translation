# 快速开始

原文地址：[https://agentskills.io/skill-creation/quickstart](https://agentskills.io/skill-creation/quickstart)

> 创建你的第一个 Agent Skill，并在 VS Code 中看到它实际运行的效果。

在本教程中，你将创建一个 skill，让智能体拥有使用随机数生成器来掷骰子的能力。

## 前置条件

* [VS Code](https://code.visualstudio.com/) 并安装 [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)

> 本教程使用 VS Code，但 Agent Skills 是一种开放格式。同一个 skill 可以在任何兼容的智能体中使用，包括 Claude Code 和 OpenAI Codex。

## 创建 skill

一个 skill 就是一个包含 `SKILL.md` 文件的文件夹。VS Code 默认在 `.agents/skills/` 目录下查找 skills。在你的项目中创建 `.agents/skills/roll-dice/SKILL.md` 文件：

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

就这么简单——一个文件，不到 20 行。下面说明每部分的作用：

* **`name`** — skill 的简短标识符。必须与其所在文件夹的名称一致。
* **`description`** — 告诉智能体何时使用该 skill。智能体依据这段描述来决定是否激活它。
* **正文（body）** — 当 skill 被激活时，智能体所遵循的指令。这里的指令告诉智能体使用一条终端命令来生成随机数，并将用户请求中的面数代入其中。

## 试用一下

1. 在 VS Code 中打开你的项目。
2. 打开 Copilot Chat 面板。
3. 在聊天面板底部的模式下拉框中选择 **Agent** 模式。
4. 输入 `/skills`，确认列表中出现 `roll-dice`。如果没有，请检查文件是否位于项目根目录下的 `.agents/skills/roll-dice/SKILL.md`。
5. 提问：**"Roll a d20"**（掷一个 d20）

智能体应当会激活 `roll-dice` 这个 skill。它可能会请求运行终端命令的权限——允许它。它会执行该命令并返回一个 1 到 20 之间的随机数。

> 不同模型在工具调用可靠性方面表现不同——有些模型能稳定地遵循 skill 指令并执行命令，而有些模型可能会试图自己直接给出答案。如果智能体在没有运行终端命令的情况下就作出了回复，可以尝试在模型下拉框中选择另一个模型。

## 工作原理

下面是幕后发生的事情：

1. **发现（Discovery）** — 聊天会话开始时，智能体扫描默认的 skill 目录并发现了你的 skill。它只读取了 `name` 和 `description`，仅此以判断该 skill 何时可能相关。

2. **激活（Activation）** — 当你询问关于掷骰子的问题时，智能体将你的提问与该 skill 的 description 匹配上，并把完整的 `SKILL.md` 正文加载进上下文。

3. **执行（Execution）** — 智能体按照正文中的指令行动，把终端命令根据你请求中的面数进行调整。

这一过程利用了**渐进式披露（progressive disclosure）**，让智能体可以在无需预先加载所有指令的情况下访问众多 skills。

## 后续步骤

你已经创建了一个可用的 Agent Skill。接下来可以继续了解：

* **[最佳实践（Best practices）](/skill-creation/best-practices)** — 如何编写范围合适且行之有效的 skill。
* **[优化 skill 描述（Optimizing skill descriptions）](/skill-creation/optimizing-descriptions)** — 测试并改进你的 skill 描述，使它能在正确的提示下被激活。
* **[规范（Specification）](/specification)** — `SKILL.md` 文件的完整格式参考。
* **[示例 skills（Example skills）](https://github.com/anthropics/skills)** — 在 GitHub 上浏览真实世界中的 skills。
