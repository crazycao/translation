# 面向 skill 创建者的最佳实践

原文地址：[https://agentskills.io/skill-creation/best-practices](https://agentskills.io/skill-creation/best-practices)

> 如何编写范围合适、且对具体任务经过合理校准的 skill。

## 从真实的专业经验出发

创建 skill 时的一个常见误区是：让 LLM 在没有任何领域上下文的情况下凭空生成 skill，完全依赖它的通用训练知识。这样得到的往往是含糊、通用的流程（“妥善处理错误”、“遵循认证最佳实践”），而不是那些让 skill 真正有价值的具体 API 用法、边界情况和项目约定。

有效的 skill 都建立在真实的专业经验之上。关键在于把领域相关的上下文喂进 skill 的创建过程中。

### 从一次真实动手的任务中提炼

先在与智能体的对话中完整地完成一次真实任务，一路提供上下文、纠正和偏好，然后再把其中可复用的模式提炼成一个 skill。重点关注：

* **有效的步骤** —— 最终把事情做成的那一串动作序列
* **你所做的纠正** —— 你曾经引导过智能体思路的地方（例如“用库 X 而不是 Y”、“注意边界情况 Z”）
* **输入 / 输出格式** —— 数据进入和产出时长什么样
* **你提供的上下文** —— 那些智能体本来不知道的、项目特有的事实、约定或约束

### 基于已有的项目材料合成

当你已经有一整套现成的知识资料时，可以把它们喂给 LLM，让它据此合成一个 skill。基于你团队真实的故障报告与执行手册合成的“数据管道”skill，会比基于一篇泛泛的“数据工程最佳实践”文章合成出来的 skill 好得多，因为它捕获的是*你自己的*范式、失败模式和恢复流程。关键在于使用项目相关的材料，而不是通用的参考资料。

好的原始材料包括：

* 内部文档、执行手册和代码风格指南
* API 规范、范式和配置文件
* Code review 评论和 issue 跟踪系统（沉淀了反复出现的关注点和 reviewer 的预期）
* 版本控制历史，尤其是补丁和修复（通过实际发生的变更揭示模式）
* 真实世界中出现的失败案例及其解决方案

## 通过真实执行不断打磨

skill 的初稿通常都需要打磨。让 skill 跑一些真实任务，然后把结果——所有结果，不只是失败的那些——反馈回创建过程。问自己：什么触发了误报？什么被遗漏了？哪些内容可以砍掉？

哪怕只是一轮“执行—修订”，质量都会有明显提升；复杂领域往往需要多轮迭代才能收敛。

> 请阅读智能体的执行 trace，而不仅仅看最终输出。如果智能体在无效步骤上浪费了时间，常见的原因包括：指令过于含糊（智能体尝试了好几种方案才找到一种行得通的）、指令不适用于当前任务（但智能体仍照做不误），或者给出了太多选项却没有明确的默认值。

如果你想要一套更结构化的迭代方法（包括测试用例、断言和评分），请参见 [Evaluating skill output quality](/skill-creation/evaluating-skills)。

## 明智地使用上下文

一旦某个 skill 被激活，它完整的 `SKILL.md` 正文就会与对话历史、系统上下文和其他活跃的 skill 一起加载进智能体的上下文窗口。skill 里的每一个 token 都在与窗口里其他所有内容争夺智能体的注意力。

### 补上智能体缺失的，省略它已经知道的

把重点放在智能体如果没有你的 skill 就*不会知道*的内容上：项目特有的约定、领域特有的流程、不太显然的边界情况，以及应当使用的特定工具或 API。你不需要解释 PDF 是什么、HTTP 如何工作，或者数据库迁移是干什么的。

````markdown theme={null}
<!-- 过于啰嗦 —— 智能体已经知道 PDF 是什么 -->
## 提取 PDF 文本

PDF（Portable Document Format）是一种常见的文件格式，可以包含文本、图片
和其他内容。要从 PDF 中提取文本，你需要使用一个库。推荐 pdfplumber，
因为它对大多数情况处理得都不错。

<!-- 更好 —— 直接切入智能体自己不会知道的内容 -->
## 提取 PDF 文本

使用 pdfplumber 提取文本。对于扫描件，改用 pdf2image 搭配 pytesseract。

```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

对每一段内容都自问一句：“如果没有这条指令，智能体会做错吗？”如果答案是否定的，就删掉它。如果拿不准，就动手测试。如果没有 skill，智能体也已经能把整个任务处理得很好，那么这个 skill 可能根本没有带来增量价值。关于如何系统地测试这一点，请参见 [Evaluating skill output quality](/skill-creation/evaluating-skills)。

### 设计内聚的工作单元

决定一个 skill 应该覆盖哪些内容，就像决定一个函数应该做什么：你希望它封装一段内聚的工作，并且能与其他 skill 良好组合。范围过窄的 skill 会迫使一次任务加载多个 skill，带来额外开销并可能出现相互冲突的指令；范围过宽的 skill 又很难被精准触发。“查询数据库并格式化结果”可能是一个内聚的单元，而如果同一个 skill 还覆盖了数据库管理，大概就是想做的事太多了。

### 适度即可，不必面面俱到

过于面面俱到的 skill 常常弊大于利——智能体会难以从中筛出真正相关的部分，还可能因为一些不适用于当前任务的指令而走上无效路径。简洁、分步的指引再配一个可运行的示例，通常比事无巨细的文档效果更好。当你发现自己在覆盖每一个边界情况时，先想想其中大部分是不是可以交给智能体自己判断。

### 用渐进式披露组织大型 skill

[规范](/specification#progressive-disclosure)建议把 `SKILL.md` 控制在 500 行、5,000 tokens 以内——只保留智能体每次运行都需要用到的核心指令。当 skill 确实需要更多内容时，把详细的参考资料放到 `references/` 或类似目录下的独立文件中。

关键在于告诉智能体*何时*加载每个文件。“如果 API 返回非 200 状态码就阅读 `references/api-errors.md`” 比笼统的一句“详见 references/”要有用得多。这样智能体就能按需加载上下文，而不是一次性全部载入——这正是[渐进式披露（progressive disclosure）](/specification#progressive-disclosure)所设计的工作方式。

## 校准对控制粒度的把握

skill 的每个部分并不都需要同等程度的强制性。指令的具体程度要与任务本身的脆弱度相匹配。

### 让具体程度与脆弱度匹配

当多种做法都可行、任务本身也允许一定变化时，**给智能体一些自由**。对于灵活的指令，解释 *为什么* 往往比刚性的指示更有效——理解了指令目的的智能体，在依赖上下文的判断上会表现得更好。一个 code review 的 skill 可以描述要重点关注的内容，而不需要规定确切的步骤：

```markdown theme={null}
## Code review 流程

1. 检查所有数据库查询是否存在 SQL 注入（使用参数化查询）
2. 确认每一个接口都有认证检查
3. 检查并发代码路径中是否存在竞态条件
4. 确认错误消息不会泄露内部细节
```

当操作比较脆弱、需要保持一致性，或者必须按特定顺序执行时，**要给出明确规定**：

````markdown theme={null}
## 数据库迁移

严格按照以下步骤执行：

```bash
python scripts/migrate.py --verify --backup
```

不要修改该命令或增加额外的参数。
````

大多数 skill 都是两者兼有的组合，需要分别校准每个部分。

### 提供默认选项，而不是列一份菜单

当有多种工具或方法都可行时，请选定一个默认方案，然后简要提及其他替代方案，而不是把它们作为并列的选项摆出来。

````markdown theme={null}
<!-- 选项过多 -->
你可以用 pypdf、pdfplumber、PyMuPDF 或 pdf2image……

<!-- 明确的默认方案 + 备用出路 -->
使用 pdfplumber 进行文本提取：

```python
import pdfplumber
```

对于需要 OCR 的扫描件 PDF，改用 pdf2image 搭配 pytesseract。
````

### 优先给出流程，而不是一次性的结论

skill 应当教会智能体*如何思考*一整类问题，而不是告诉它某一次特定情形*要产出什么*。对比一下：

```markdown theme={null}
<!-- 特定答案 —— 只对这个具体任务有用 -->
将 `orders` 表通过 `customer_id` 与 `customers` 表连接，过滤条件为
`region = 'EMEA'`，然后对 `amount` 列求和。

<!-- 可复用的方法 —— 对任何分析型查询都适用 -->
1. 从 `references/schema.yaml` 读取 schema，找出相关表
2. 按 `_id` 外键命名约定连接各表
3. 把用户请求中的过滤条件转成 WHERE 子句
4. 按需对数值列聚合，并以 markdown 表格形式格式化输出
```

这并不意味着 skill 中不能包含具体细节——输出格式模板（见 [Templates for output format](#templates-for-output-format)）、“绝不输出 PII” 之类的约束，以及针对特定工具的指令，都是很有价值的。关键在于：即便个别细节非常具体，*方法*本身也应当具有普适性。

## 编写有效指令的模式

以下是一些可复用的、用于组织 skill 内容的技巧。并不是每个 skill 都需要全部用上——挑选与你的任务相匹配的即可。

### “陷阱”章节

在很多 skill 中，价值最高的内容其实是一个陷阱清单——列出那些违背合理直觉的、与环境相关的事实。它们不是“要妥善处理错误”这种泛泛建议，而是针对智能体如果没被特别提醒就会犯的具体错误的具体纠正：

```markdown theme={null}
## 陷阱（Gotchas）

- `users` 表使用软删除。查询必须包含 `WHERE deleted_at IS NULL`，
  否则结果里会混进已停用的账号。
- 同一个用户 ID 在数据库中叫 `user_id`，在鉴权服务中叫 `uid`，
  在计费 API 中叫 `accountId`。这三个字段指向的是同一个值。
- 只要 Web 服务器还在运行，`/health` 接口就会返回 200，即便数据库连接
  已经断开。要检查完整服务健康度，请使用 `/ready`。
```

把陷阱清单放在 `SKILL.md` 里，让智能体在遇到相应情况*之前*就读到。放到单独的参考文件里也可以，但前提是你能明确告诉智能体何时加载它——对于不那么显眼的问题，智能体可能根本意识不到触发时机。

> 每当智能体犯下需要你纠正的错误时，就把那条纠正加入到陷阱章节。这是迭代改进 skill 最直接的手段之一（参见 [Refine with real execution](#refine-with-real-execution)）。

### 用模板约束输出格式

当你希望智能体按特定格式输出时，请直接给出一个模板。这比用文字描述格式更可靠，因为智能体擅长对具体结构做模式匹配。短模板可以直接内联在 `SKILL.md` 中；对于较长的模板，或者只在特定场景才需要用到的模板，请把它们放在 `assets/` 目录下，并在 `SKILL.md` 中引用，让它们只在需要时才加载。

````markdown theme={null}
## 报告结构

使用下面这个模板，根据具体分析情况按需调整各个小节：

```markdown
# [分析标题]

## 执行摘要
[用一段话概述关键发现]

## 关键发现
- 发现 1，附相关数据
- 发现 2，附相关数据

## 建议
1. 具体、可执行的建议
2. 具体、可执行的建议
```
````

### 用清单管理多步工作流

显式的清单可以帮助智能体跟踪进度、避免跳步，尤其是当步骤之间存在依赖关系或需要通过校验关卡时。

```markdown theme={null}
## 表单处理工作流

进度：
- [ ] 步骤 1：分析表单（运行 `scripts/analyze_form.py`）
- [ ] 步骤 2：创建字段映射（编辑 `fields.json`）
- [ ] 步骤 3：校验映射（运行 `scripts/validate_fields.py`）
- [ ] 步骤 4：填写表单（运行 `scripts/fill_form.py`）
- [ ] 步骤 5：验证输出（运行 `scripts/verify_output.py`）
```

### 校验循环

要求智能体在推进到下一步之前先校验自己的工作。模式是：完成工作 → 运行校验器（一个脚本、参考清单或自检）→ 修正问题 → 反复直到校验通过。

```markdown theme={null}
## 编辑工作流

1. 完成你的编辑
2. 运行校验：`python scripts/validate.py output/`
3. 如果校验失败：
   - 阅读错误消息
   - 修复问题
   - 重新运行校验
4. 只有在校验通过后才能继续下一步
```

一份参考文档也可以充当“校验器”——让智能体在最终定稿前对照参考文档检查自己的成果。

### 计划—校验—执行

对于批量操作或具有破坏性的操作，让智能体先以结构化格式生成一份中间计划，对照事实依据（source of truth）校验之后，再真正执行。

```markdown theme={null}
## PDF 表单填写

1. 提取表单字段：`python scripts/analyze_form.py input.pdf` → `form_fields.json`
   （列出每个字段的名称、类型，以及是否必填）
2. 创建 `field_values.json`，把每个字段名映射到其目标值
3. 校验：`python scripts/validate_fields.py form_fields.json field_values.json`
   （检查每个字段名是否存在于表单中、类型是否兼容，以及必填项是否缺失）
4. 如果校验失败，修改 `field_values.json` 后重新校验
5. 填写表单：`python scripts/fill_form.py input.pdf field_values.json output.pdf`
```

关键在于第 3 步：一个校验脚本，用来把计划（`field_values.json`）与事实依据（`form_fields.json`）进行比对。诸如 “Field 'signature\_date' not found — available fields: customer\_name, order\_total, signature\_date\_signed” 这样的错误信息，能给到智能体足够的信息去自我纠正。

### 内置可复用的脚本

在[迭代一个 skill](/skill-creation/evaluating-skills) 的过程中，对比智能体在不同测试用例下的执行 trace。如果你发现智能体每次都在独立重造同一套逻辑——比如生成图表、解析某种特定格式、校验输出——那就是一个信号：把这段逻辑写成一个经过测试的脚本，一次性打包到 `scripts/` 里。

关于如何设计和打包脚本，进一步内容见 [Using scripts in skills](/skill-creation/using-scripts)。

## 后续步骤

当你已经有一个可用的 skill 之后，可以借助以下两份指南进一步打磨它：

* **[评估 skill 输出质量（Evaluating skill output quality）](/skill-creation/evaluating-skills)** —— 建立测试用例、给结果打分，并系统地进行迭代。
* **[优化 skill 描述（Optimizing skill descriptions）](/skill-creation/optimizing-descriptions)** —— 测试并改进 skill 的 `description` 字段，让它能在正确的提示下被触发。
