
# Agent Skills 概览

> 一种为 AI 智能体赋予新能力和专业知识的标准化方式。

## 什么是 Agent Skills？

Agent Skills 是一种轻量级、开放的格式，用于通过专业知识和工作流来扩展 AI 智能体的能力。

从本质上讲，一个 skill 就是一个包含 `SKILL.md` 文件的文件夹。该文件包含元数据（至少包括 `name` 和 `description`），以及告诉智能体如何执行特定任务的指令。Skills 还可以打包脚本、参考资料、模板和其他资源。

```
my-skill/
├── SKILL.md          # 必需：元数据 + 指令
├── scripts/          # 可选：可执行代码
├── references/       # 可选：文档
├── assets/           # 可选：模板、资源
└── ...               # 任何其他文件或目录
```

## 为什么需要 Agent Skills？

智能体的能力越来越强，但通常缺乏可靠完成实际工作所需的上下文。Skills 通过将流程性知识以及公司、团队和用户特定的上下文打包成可移植、受版本控制的文件夹，由智能体按需加载，从而解决了这一问题。这为智能体带来了：

* **领域专业知识**：将专业知识——从法律审查流程到数据分析流水线，再到演示文稿格式化——捕获为可复用的指令和资源。
* **可重复的工作流**：将多步骤任务转化为一致、可审计的流程。
* **跨产品复用**：只需构建一次 skill，就能在任何兼容 skills 的智能体中使用。

## Agent Skills 如何工作？

智能体通过**渐进式披露（progressive disclosure）**分三个阶段加载 skills：

1. **发现（Discovery）**：启动时，智能体仅加载每个可用 skill 的名称和描述，恰好足以判断何时可能相关。

2. **激活（Activation）**：当任务与某个 skill 的描述匹配时，智能体将完整的 `SKILL.md` 指令读入上下文。

3. **执行（Execution）**：智能体按照指令行动，并根据需要选择性地执行打包的代码或加载引用的文件。

完整的指令仅在任务需要时才会加载，因此智能体可以在保持较小上下文占用的同时拥有众多可用的 skills。

## 在哪里可以使用 Agent Skills？

Agent Skills 得到了大量 AI 工具和智能体客户端的支持——请查看 [Client Showcase](https://agentskills.io/clients) 以了解其中的一部分！

## 开放式开发

Agent Skills 格式最初由 [Anthropic](https://www.anthropic.com/) 开发，作为开放标准发布，并已被越来越多的智能体产品所采用。该标准欢迎来自更广泛生态系统的贡献。

欢迎加入 [GitHub](https://github.com/agentskills/agentskills) 或 [Discord](https://discord.gg/MKPE9g8aUy) 上的讨论！

## 开始使用 Agent Skills

- [Quickstart](/skill-creation/quickstart)

	创建你的第一个 Agent Skill 并体验其实际效果。

- [Specification](/specification)

	gent Skills 的完整格式规范。