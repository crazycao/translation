# Best practices for skill creators - 面向 skill 创建者的最佳实践

原文地址：[https://agentskills.io/skill-creation/best-practices](https://agentskills.io/skill-creation/best-practices)

> How to write skills that are well-scoped and calibrated to the task.

> 如何编写范围合适、且对具体任务经过合理校准的 skill。

## Start from real expertise - 从真实的专业经验出发

A common pitfall in skill creation is asking an LLM to generate a skill without providing domain-specific context — relying solely on the LLM's general training knowledge. The result is vague, generic procedures ("handle errors appropriately," "follow best practices for authentication") rather than the specific API patterns, edge cases, and project conventions that make a skill valuable.

创建 skill 时的一个常见误区是：让 LLM 在没有任何领域上下文的情况下凭空生成 skill，完全依赖它的通用训练知识。这样得到的往往是含糊、通用的流程（“妥善处理错误”、“遵循认证最佳实践”），而不是那些让 skill 真正有价值的具体 API 用法、边界情况和项目约定。

Effective skills are grounded in real expertise. The key is feeding domain-specific context into the creation process.

有效的 skill 都建立在真实的专业经验之上。关键在于把领域相关的上下文喂进 skill 的创建过程中。

### Extract from a hands-on task - 从一次真实动手的任务中提炼

Complete a real task in conversation with an agent, providing context, corrections, and preferences along the way. Then extract the reusable pattern into a skill. Pay attention to:

先在与智能体的对话中完整地完成一次真实任务，一路提供上下文、纠正和偏好，然后再把其中可复用的模式提炼成一个 skill。重点关注：

* **Steps that worked** — the sequence of actions that led to success
* **Corrections you made** — places where you steered the agent's approach (e.g., "use library X instead of Y," "check for edge case Z")
* **Input/output formats** — what the data looked like going in and coming out
* **Context you provided** — project-specific facts, conventions, or constraints the agent didn't already know

* **有效的步骤** —— 最终把事情做成的那一串动作序列
* **你所做的纠正** —— 你曾经引导过智能体思路的地方（例如“用库 X 而不是 Y”、“注意边界情况 Z”）
* **输入 / 输出格式** —— 数据进入和产出时长什么样
* **你提供的上下文** —— 那些智能体本来不知道的、项目特有的事实、约定或约束

### Synthesize from existing project artifacts - 基于已有的项目材料合成

When you have a body of existing knowledge, you can feed it into an LLM and ask it to synthesize a skill. A data-pipeline skill synthesized from your team's actual incident reports and runbooks will outperform one synthesized from a generic "data engineering best practices" article, because it captures *your* schemas, failure modes, and recovery procedures. The key is project-specific material, not generic references.

当你已经有一整套现成的知识资料时，可以把它们喂给 LLM，让它据此合成一个 skill。基于你团队真实的故障报告与执行手册合成的“数据管道”skill，会比基于一篇泛泛的“数据工程最佳实践”文章合成出来的 skill 好得多，因为它捕获的是*你自己的*范式、失败模式和恢复流程。关键在于使用项目相关的材料，而不是通用的参考资料。

Good source material includes:

好的原始材料包括：

* Internal documentation, runbooks, and style guides
* API specifications, schemas, and configuration files
* Code review comments and issue trackers (captures recurring concerns and reviewer expectations)
* Version control history, especially patches and fixes (reveals patterns through what actually changed)
* Real-world failure cases and their resolutions

* 内部文档、执行手册和代码风格指南
* API 规范、范式和配置文件
* Code review 评论和 issue 跟踪系统（沉淀了反复出现的关注点和 reviewer 的预期）
* 版本控制历史，尤其是补丁和修复（通过实际发生的变更揭示模式）
* 真实世界中出现的失败案例及其解决方案

## Refine with real execution - 通过真实执行不断打磨

The first draft of a skill usually needs refinement. Run the skill against real tasks, then feed the results — all of them, not just failures — back into the creation process. Ask: what triggered false positives? What was missed? What could be cut?

skill 的初稿通常都需要打磨。让 skill 跑一些真实任务，然后把结果——所有结果，不只是失败的那些——反馈回创建过程。问自己：什么触发了误报？什么被遗漏了？哪些内容可以砍掉？

Even a single pass of execute-then-revise noticeably improves quality, and complex domains often benefit from several.

哪怕只是一轮“执行—修订”，质量都会有明显提升；复杂领域往往需要多轮迭代才能收敛。

> Read agent execution traces, not just final outputs. If the agent wastes time on unproductive steps, common causes include instructions that are too vague (the agent tries several approaches before finding one that works), instructions that don't apply to the current task (the agent follows them anyway), or too many options presented without a clear default.

> 请阅读智能体的执行 trace，而不仅仅看最终输出。如果智能体在无效步骤上浪费了时间，常见的原因包括：指令过于含糊（智能体尝试了好几种方案才找到一种行得通的）、指令不适用于当前任务（但智能体仍照做不误），或者给出了太多选项却没有明确的默认值。

For a more structured approach to iteration, including test cases, assertions, and grading, see [Evaluating skill output quality](/skill-creation/evaluating-skills).

如果你想要一套更结构化的迭代方法（包括测试用例、断言和评分），请参见 [Evaluating skill output quality](/skill-creation/evaluating-skills)。

## Spending context wisely - 明智地使用上下文

Once a skill activates, its full `SKILL.md` body loads into the agent's context window alongside conversation history, system context, and other active skills. Every token in your skill competes for the agent's attention with everything else in that window.

一旦某个 skill 被激活，它完整的 `SKILL.md` 正文就会与对话历史、系统上下文和其他活跃的 skill 一起加载进智能体的上下文窗口。skill 里的每一个 token 都在与窗口里其他所有内容争夺智能体的注意力。

### Add what the agent lacks, omit what it knows - 补上智能体缺失的，省略它已经知道的

Focus on what the agent *wouldn't* know without your skill: project-specific conventions, domain-specific procedures, non-obvious edge cases, and the particular tools or APIs to use. You don't need to explain what a PDF is, how HTTP works, or what a database migration does.

把重点放在智能体如果没有你的 skill 就*不会知道*的内容上：项目特有的约定、领域特有的流程、不太显然的边界情况，以及应当使用的特定工具或 API。你不需要解释 PDF 是什么、HTTP 如何工作，或者数据库迁移是干什么的。

````markdown theme={null}
<!-- Too verbose — the agent already knows what PDFs are -->
## Extract PDF text

PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. pdfplumber is recommended because it handles most cases well.

<!-- Better — jumps straight to what the agent wouldn't know on its own -->
## Extract PDF text

Use pdfplumber for text extraction. For scanned documents, fall back to
pdf2image with pytesseract.

```python
import pdfplumber

with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

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

Ask yourself about each piece of content: "Would the agent get this wrong without this instruction?" If the answer is no, cut it. If you're unsure, test it. And if the agent already handles the entire task well without the skill, the skill may not be adding value. See [Evaluating skill output quality](/skill-creation/evaluating-skills) for how to test this systematically.

对每一段内容都自问一句：“如果没有这条指令，智能体会做错吗？”如果答案是否定的，就删掉它。如果拿不准，就动手测试。如果没有 skill，智能体也已经能把整个任务处理得很好，那么这个 skill 可能根本没有带来增量价值。关于如何系统地测试这一点，请参见 [Evaluating skill output quality](/skill-creation/evaluating-skills)。

### Design coherent units - 设计内聚的工作单元

Deciding what a skill should cover is like deciding what a function should do: you want it to encapsulate a coherent unit of work that composes well with other skills. Skills scoped too narrowly force multiple skills to load for a single task, risking overhead and conflicting instructions. Skills scoped too broadly become hard to activate precisely. A skill for querying a database and formatting the results may be one coherent unit, while a skill that also covers database administration is probably trying to do too much.

决定一个 skill 应该覆盖哪些内容，就像决定一个函数应该做什么：你希望它封装一段内聚的工作，并且能与其他 skill 良好组合。范围过窄的 skill 会迫使一次任务加载多个 skill，带来额外开销并可能出现相互冲突的指令；范围过宽的 skill 又很难被精准触发。“查询数据库并格式化结果”可能是一个内聚的单元，而如果同一个 skill 还覆盖了数据库管理，大概就是想做的事太多了。

### Aim for moderate detail - 适度即可，不必面面俱到

Overly comprehensive skills can hurt more than they help — the agent struggles to extract what's relevant and may pursue unproductive paths triggered by instructions that don't apply to the current task. Concise, stepwise guidance with a working example tends to outperform exhaustive documentation. When you find yourself covering every edge case, consider whether most are better handled by the agent's own judgment.

过于面面俱到的 skill 常常弊大于利——智能体会难以从中筛出真正相关的部分，还可能因为一些不适用于当前任务的指令而走上无效路径。简洁、分步的指引再配一个可运行的示例，通常比事无巨细的文档效果更好。当你发现自己在覆盖每一个边界情况时，先想想其中大部分是不是可以交给智能体自己判断。

### Structure large skills with progressive disclosure - 用渐进式披露组织大型 skill

The [specification](/specification#progressive-disclosure) recommends keeping `SKILL.md` under 500 lines and 5,000 tokens — just the core instructions the agent needs on every run. When a skill legitimately needs more content, move detailed reference material to separate files in `references/` or similar directories.

[规范](/specification#progressive-disclosure)建议把 `SKILL.md` 控制在 500 行、5,000 tokens 以内——只保留智能体每次运行都需要用到的核心指令。当 skill 确实需要更多内容时，把详细的参考资料放到 `references/` 或类似目录下的独立文件中。

The key is telling the agent *when* to load each file. "Read `references/api-errors.md` if the API returns a non-200 status code" is more useful than a generic "see references/ for details." This lets the agent load context on demand rather than up front, which is how [progressive disclosure](/specification#progressive-disclosure) is designed to work.

关键在于告诉智能体*何时*加载每个文件。“如果 API 返回非 200 状态码就阅读 `references/api-errors.md`” 比笼统的一句“详见 references/”要有用得多。这样智能体就能按需加载上下文，而不是一次性全部载入——这正是[渐进式披露（progressive disclosure）](/specification#progressive-disclosure)所设计的工作方式。

## Calibrating control - 校准对控制粒度的把握

Not every part of a skill needs the same level of prescriptiveness. Match the specificity of your instructions to the fragility of the task.

skill 的每个部分并不都需要同等程度的强制性。指令的具体程度要与任务本身的脆弱度相匹配。

### Match specificity to fragility - 让具体程度与脆弱度匹配

**Give the agent freedom** when multiple approaches are valid and the task tolerates variation. For flexible instructions, explaining *why* can be more effective than rigid directives — an agent that understands the purpose behind an instruction makes better context-dependent decisions. A code review skill can describe what to look for without prescribing exact steps:

当多种做法都可行、任务本身也允许一定变化时，**给智能体一些自由**。对于灵活的指令，解释 *为什么* 往往比刚性的指示更有效——理解了指令目的的智能体，在依赖上下文的判断上会表现得更好。一个 code review 的 skill 可以描述要重点关注的内容，而不需要规定确切的步骤：

```markdown theme={null}
## Code review process

1. Check all database queries for SQL injection (use parameterized queries)
2. Verify authentication checks on every endpoint
3. Look for race conditions in concurrent code paths
4. Confirm error messages don't leak internal details
```

```markdown theme={null}
## Code review 流程

1. 检查所有数据库查询是否存在 SQL 注入（使用参数化查询）
2. 确认每一个接口都有认证检查
3. 检查并发代码路径中是否存在竞态条件
4. 确认错误消息不会泄露内部细节
```

**Be prescriptive** when operations are fragile, consistency matters, or a specific sequence must be followed:

当操作比较脆弱、需要保持一致性，或者必须按特定顺序执行时，**要给出明确规定**：

````markdown theme={null}
## Database migration

Run exactly this sequence:

```bash
python scripts/migrate.py --verify --backup
```

Do not modify the command or add additional flags.
````

````markdown theme={null}
## 数据库迁移

严格按照以下步骤执行：

```bash
python scripts/migrate.py --verify --backup
```

不要修改该命令或增加额外的参数。
````

Most skills have a mix. Calibrate each part independently.

大多数 skill 都是两者兼有的组合，需要分别校准每个部分。

### Provide defaults, not menus - 提供默认选项，而不是列一份菜单

When multiple tools or approaches could work, pick a default and mention alternatives briefly rather than presenting them as equal options.

当有多种工具或方法都可行时，请选定一个默认方案，然后简要提及其他替代方案，而不是把它们作为并列的选项摆出来。

````markdown theme={null}
<!-- Too many options -->
You can use pypdf, pdfplumber, PyMuPDF, or pdf2image...

<!-- Clear default with escape hatch -->
Use pdfplumber for text extraction:

```python
import pdfplumber
```

For scanned PDFs requiring OCR, use pdf2image with pytesseract instead.
````

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

### Favor procedures over declarations - 优先给出流程，而不是一次性的结论

A skill should teach the agent *how to approach* a class of problems, not *what to produce* for a specific instance. Compare:

skill 应当教会智能体*如何思考*一整类问题，而不是告诉它某一次特定情形*要产出什么*。对比一下：

```markdown theme={null}
<!-- Specific answer — only useful for this exact task -->
Join the `orders` table to `customers` on `customer_id`, filter where
`region = 'EMEA'`, and sum the `amount` column.

<!-- Reusable method — works for any analytical query -->
1. Read the schema from `references/schema.yaml` to find relevant tables
2. Join tables using the `_id` foreign key convention
3. Apply any filters from the user's request as WHERE clauses
4. Aggregate numeric columns as needed and format as a markdown table
```

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

This doesn't mean skills can't include specific details — output format templates (see [Templates for output format](#templates-for-output-format)), constraints like "never output PII," and tool-specific instructions are all valuable. The point is that the *approach* should generalize even when individual details are specific.

这并不意味着 skill 中不能包含具体细节——输出格式模板（见 [Templates for output format](#templates-for-output-format)）、“绝不输出 PII” 之类的约束，以及针对特定工具的指令，都是很有价值的。关键在于：即便个别细节非常具体，*方法*本身也应当具有普适性。

## Patterns for effective instructions - 编写有效指令的模式

These are reusable techniques for structuring skill content. Not every skill needs all of them — use the ones that fit your task.

以下是一些可复用的、用于组织 skill 内容的技巧。并不是每个 skill 都需要全部用上——挑选与你的任务相匹配的即可。

### Gotchas sections - “陷阱”章节

The highest-value content in many skills is a list of gotchas — environment-specific facts that defy reasonable assumptions. These aren't general advice ("handle errors appropriately") but concrete corrections to mistakes the agent will make without being told otherwise:

在很多 skill 中，价值最高的内容其实是一个陷阱清单——列出那些违背合理直觉的、与环境相关的事实。它们不是“要妥善处理错误”这种泛泛建议，而是针对智能体如果没被特别提醒就会犯的具体错误的具体纠正：

```markdown theme={null}
## Gotchas

- The `users` table uses soft deletes. Queries must include
  `WHERE deleted_at IS NULL` or results will include deactivated accounts.
- The user ID is `user_id` in the database, `uid` in the auth service,
  and `accountId` in the billing API. All three refer to the same value.
- The `/health` endpoint returns 200 as long as the web server is running,
  even if the database connection is down. Use `/ready` to check full
  service health.
```

```markdown theme={null}
## 陷阱（Gotchas）

- `users` 表使用软删除。查询必须包含 `WHERE deleted_at IS NULL`，
  否则结果里会混进已停用的账号。
- 同一个用户 ID 在数据库中叫 `user_id`，在鉴权服务中叫 `uid`，
  在计费 API 中叫 `accountId`。这三个字段指向的是同一个值。
- 只要 Web 服务器还在运行，`/health` 接口就会返回 200，即便数据库连接
  已经断开。要检查完整服务健康度，请使用 `/ready`。
```

Keep gotchas in `SKILL.md` where the agent reads them before encountering the situation. A separate reference file works if you tell the agent when to load it, but for non-obvious issues, the agent may not recognize the trigger.

把陷阱清单放在 `SKILL.md` 里，让智能体在遇到相应情况*之前*就读到。放到单独的参考文件里也可以，但前提是你能明确告诉智能体何时加载它——对于不那么显眼的问题，智能体可能根本意识不到触发时机。

> When an agent makes a mistake you have to correct, add the correction to the gotchas section. This is one of the most direct ways to improve a skill iteratively (see [Refine with real execution](#refine-with-real-execution)).

> 每当智能体犯下需要你纠正的错误时，就把那条纠正加入到陷阱章节。这是迭代改进 skill 最直接的手段之一（参见 [Refine with real execution](#refine-with-real-execution)）。

### Templates for output format - 用模板约束输出格式

When you need the agent to produce output in a specific format, provide a template. This is more reliable than describing the format in prose, because agents pattern-match well against concrete structures. Short templates can live inline in `SKILL.md`; for longer templates, or templates only needed in certain cases, store them in `assets/` and reference them from `SKILL.md` so they only load when needed.

当你希望智能体按特定格式输出时，请直接给出一个模板。这比用文字描述格式更可靠，因为智能体擅长对具体结构做模式匹配。短模板可以直接内联在 `SKILL.md` 中；对于较长的模板，或者只在特定场景才需要用到的模板，请把它们放在 `assets/` 目录下，并在 `SKILL.md` 中引用，让它们只在需要时才加载。

````markdown theme={null}
## Report structure

Use this template, adapting sections as needed for the specific analysis:

```markdown
# [Analysis Title]

## Executive summary
[One-paragraph overview of key findings]

## Key findings
- Finding 1 with supporting data
- Finding 2 with supporting data

## Recommendations
1. Specific actionable recommendation
2. Specific actionable recommendation
```
````

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

### Checklists for multi-step workflows - 用清单管理多步工作流

An explicit checklist helps the agent track progress and avoid skipping steps, especially when steps have dependencies or validation gates.

显式的清单可以帮助智能体跟踪进度、避免跳步，尤其是当步骤之间存在依赖关系或需要通过校验关卡时。

```markdown theme={null}
## Form processing workflow

Progress:
- [ ] Step 1: Analyze the form (run `scripts/analyze_form.py`)
- [ ] Step 2: Create field mapping (edit `fields.json`)
- [ ] Step 3: Validate mapping (run `scripts/validate_fields.py`)
- [ ] Step 4: Fill the form (run `scripts/fill_form.py`)
- [ ] Step 5: Verify output (run `scripts/verify_output.py`)
```

```markdown theme={null}
## 表单处理工作流

进度：
- [ ] 步骤 1：分析表单（运行 `scripts/analyze_form.py`）
- [ ] 步骤 2：创建字段映射（编辑 `fields.json`）
- [ ] 步骤 3：校验映射（运行 `scripts/validate_fields.py`）
- [ ] 步骤 4：填写表单（运行 `scripts/fill_form.py`）
- [ ] 步骤 5：验证输出（运行 `scripts/verify_output.py`）
```

### Validation loops - 校验循环

Instruct the agent to validate its own work before moving on. The pattern is: do the work, run a validator (a script, a reference checklist, or a self-check), fix any issues, and repeat until validation passes.

要求智能体在推进到下一步之前先校验自己的工作。模式是：完成工作 → 运行校验器（一个脚本、参考清单或自检）→ 修正问题 → 反复直到校验通过。

```markdown theme={null}
## Editing workflow

1. Make your edits
2. Run validation: `python scripts/validate.py output/`
3. If validation fails:
   - Review the error message
   - Fix the issues
   - Run validation again
4. Only proceed when validation passes
```

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

A reference document can also serve as the "validator" — instruct the agent to check its work against the reference before finalizing.

一份参考文档也可以充当“校验器”——让智能体在最终定稿前对照参考文档检查自己的成果。

### Plan-validate-execute - 计划—校验—执行

For batch or destructive operations, have the agent create an intermediate plan in a structured format, validate it against a source of truth, and only then execute.

对于批量操作或具有破坏性的操作，让智能体先以结构化格式生成一份中间计划，对照事实依据（source of truth）校验之后，再真正执行。

```markdown theme={null}
## PDF form filling

1. Extract form fields: `python scripts/analyze_form.py input.pdf` → `form_fields.json`
   (lists every field name, type, and whether it's required)
2. Create `field_values.json` mapping each field name to its intended value
3. Validate: `python scripts/validate_fields.py form_fields.json field_values.json`
   (checks that every field name exists in the form, types are compatible, and
   required fields aren't missing)
4. If validation fails, revise `field_values.json` and re-validate
5. Fill the form: `python scripts/fill_form.py input.pdf field_values.json output.pdf`
```

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

The key ingredient is step 3: a validation script that checks the plan (`field_values.json`) against the source of truth (`form_fields.json`). Errors like "Field 'signature\_date' not found — available fields: customer\_name, order\_total, signature\_date\_signed" give the agent enough information to self-correct.

关键在于第 3 步：一个校验脚本，用来把计划（`field_values.json`）与事实依据（`form_fields.json`）进行比对。诸如 “Field 'signature\_date' not found — available fields: customer\_name, order\_total, signature\_date\_signed” 这样的错误信息，能给到智能体足够的信息去自我纠正。

### Bundling reusable scripts - 内置可复用的脚本

When [iterating on a skill](/skill-creation/evaluating-skills), compare the agent's execution traces across test cases. If you notice the agent independently reinventing the same logic each run — building charts, parsing a specific format, validating output — that's a signal to write a tested script once and bundle it in `scripts/`.

在[迭代一个 skill](/skill-creation/evaluating-skills) 的过程中，对比智能体在不同测试用例下的执行 trace。如果你发现智能体每次都在独立重造同一套逻辑——比如生成图表、解析某种特定格式、校验输出——那就是一个信号：把这段逻辑写成一个经过测试的脚本，一次性打包到 `scripts/` 里。

For more on designing and bundling scripts, see [Using scripts in skills](/skill-creation/using-scripts).

关于如何设计和打包脚本，进一步内容见 [Using scripts in skills](/skill-creation/using-scripts)。

## Next steps - 后续步骤

Once you have a working skill, two guides can help you refine it further:

当你已经有一个可用的 skill 之后，可以借助以下两份指南进一步打磨它：

* **[Evaluating skill output quality](/skill-creation/evaluating-skills)** — Set up test cases, grade results, and iterate systematically.
* **[Optimizing skill descriptions](/skill-creation/optimizing-descriptions)** — Test and improve your skill's `description` field so it triggers on the right prompts.

* **[评估 skill 输出质量（Evaluating skill output quality）](/skill-creation/evaluating-skills)** —— 建立测试用例、给结果打分，并系统地进行迭代。
* **[优化 skill 描述（Optimizing skill descriptions）](/skill-creation/optimizing-descriptions)** —— 测试并改进 skill 的 `description` 字段，让它能在正确的提示下被触发。
