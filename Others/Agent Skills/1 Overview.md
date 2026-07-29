
# Agent Skills Overview - Agent Skills 概览

原文地址：[https://agentskills.io/home](https://agentskills.io/home)


> A standardized way to give AI agents new capabilities and expertise.

> 一种为 AI 智能体赋予新能力和专业知识的标准化方式。


## What are Agent Skills? 什么是 Agent Skills？

Agent Skills are a lightweight, open format for extending AI agent capabilities with specialized knowledge and workflows.

Agent Skills 是一种轻量级、开放的格式，用于通过专业知识和工作流来扩展 AI 智能体的能力。

At its core, a skill is a folder containing a `SKILL.md` file. This file includes metadata (`name` and `description`, at minimum) and instructions that tell an agent how to perform a specific task. Skills can also bundle scripts, reference materials, templates, and other resources.

从本质上讲，一个 skill 就是一个包含 `SKILL.md` 文件的文件夹。该文件包含元数据（至少包括 `name` 和 `description`），以及告诉智能体如何执行特定任务的指令。Skills 还可以打包脚本、参考资料、模板和其他资源。

```
my-skill/
├── SKILL.md          # Required: metadata + instructions
├── scripts/          # Optional: executable code
├── references/       # Optional: documentation
├── assets/           # Optional: templates, resources
└── ...               # Any additional files or directories
```

```
my-skill/
├── SKILL.md          # 必需：元数据 + 指令
├── scripts/          # 可选：可执行代码
├── references/       # 可选：文档
├── assets/           # 可选：模板、资源
└── ...               # 任何其他文件或目录
```

## Why Agent Skills? 为什么需要 Agent Skills？

Agents are increasingly capable, but often don't have the context they need to do real work reliably. Skills solve this by packaging procedural knowledge and company-, team-, and user-specific context into portable, version-controlled folders that agents load on demand. This gives agents:

智能体的能力越来越强，但通常缺乏可靠完成实际工作所需的上下文。Skills 通过将流程性知识以及公司、团队和用户特定的上下文打包成可移植、受版本控制的文件夹，由智能体按需加载，从而解决了这一问题。这为智能体带来了：

* **Domain expertise**: Capture specialized knowledge — from legal review processes to data analysis pipelines to presentation formatting — as reusable instructions and resources.
* **Repeatable workflows**: Turn multi-step tasks into consistent, auditable procedures.
* **Cross-product reuse**: Build a skill once and use it across any skills-compatible agent.

* **领域专业知识**：将专业知识——从法律审查流程到数据分析流水线，再到演示文稿格式化——捕获为可复用的指令和资源。
* **可重复的工作流**：将多步骤任务转化为一致、可审计的流程。
* **跨产品复用**：只需构建一次 skill，就能在任何兼容 skills 的智能体中使用。

## How do Agent Skills work? Agent Skills 如何工作？

Agents load skills through **progressive disclosure**, in three stages:

智能体通过**渐进式披露（progressive disclosure）**分三个阶段加载 skills：

1. **Discovery**: At startup, agents load only the name and description of each available skill, just enough to know when it might be relevant.

1. **发现（Discovery）**：启动时，智能体仅加载每个可用 skill 的名称和描述，恰好足以判断何时可能相关。

2. **Activation**: When a task matches a skill's description, the agent reads the full `SKILL.md` instructions into context.

2. **激活（Activation）**：当任务与某个 skill 的描述匹配时，智能体将完整的 `SKILL.md` 指令读入上下文。

3. **Execution**: The agent follows the instructions, optionally executing bundled code or loading referenced files as needed.

3. **执行（Execution）**：智能体按照指令行动，并根据需要选择性地执行打包的代码或加载引用的文件。

Full instructions load only when a task calls for them, so agents can keep many skills on hand with only a small context footprint.

完整的指令仅在任务需要时才会加载，因此智能体可以在保持较小上下文占用的同时拥有众多可用的 skills。

## Where can I use Agent Skills? 在哪里可以使用 Agent Skills？

Agent Skills are supported by a large number of AI tools and agentic clients — see the [Client Showcase](https://agentskills.io/clients) to explore some of them!

Agent Skills 得到了大量 AI 工具和智能体客户端的支持——请查看 [Client Showcase](https://agentskills.io/clients) 以了解其中的一部分！

## Open development 开放式开发

The Agent Skills format was originally developed by [Anthropic](https://www.anthropic.com/), released as an open standard, and has been adopted by a growing number of agent products. The standard is open to contributions from the broader ecosystem.

Agent Skills 格式最初由 [Anthropic](https://www.anthropic.com/) 开发，作为开放标准发布，并已被越来越多的智能体产品所采用。该标准欢迎来自更广泛生态系统的贡献。

Come join the discussion on [GitHub](https://github.com/agentskills/agentskills) or [Discord](https://discord.gg/MKPE9g8aUy)!

欢迎加入 [GitHub](https://github.com/agentskills/agentskills) 或 [Discord](https://discord.gg/MKPE9g8aUy) 上的讨论！

## Get started with Agent Skills 开始使用 Agent Skills

- [Quickstart](/skill-creation/quickstart)

	Create your first Agent Skill and see it in action.

   创建你的第一个 Agent Skill 并体验其实际效果。

- [Specification](/specification)

	The complete format specification for Agent Skills.

   Agent Skills 的完整格式规范。