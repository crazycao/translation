# Evaluating skill output quality - 评估 skill 输出质量

原文地址：[https://agentskills.io/skill-creation/evaluating-skills](https://agentskills.io/skill-creation/evaluating-skills)

> How to test whether your skill produces good outputs using eval-driven iteration.

> 如何通过"以评估驱动的迭代"来测试 skill 是否能产出好的结果。

You wrote a skill, tried it on a prompt, and it seemed to work. But does it work reliably — across varied prompts, in edge cases, better than no skill at all? Running structured evaluations (evals) answers these questions and gives you a feedback loop for improving the skill systematically.

你写了一个 skill，拿一条 prompt 试了一下，看起来能用。但它是否*可靠*——在各种不同的 prompt 下、在边界情况下，都比完全没有这个 skill 时表现更好？运行结构化的评估（evals）可以回答这些问题，并为你提供一个可以系统性改进 skill 的反馈循环。

## 1. Designing test cases - 设计测试用例

A test case has three parts:

一个测试用例由三部分组成：

* **Prompt**: a realistic user message — the kind of thing someone would actually type.
* **Expected output**: a human-readable description of what success looks like.
* **Input files** (optional): files the skill needs to work with.

* **Prompt（提示）**：一条真实的用户消息——真实用户会实际打出来的那种内容。
* **预期输出**：用人类可读的方式描述"成功"应该是什么样子。
* **输入文件**（可选）：skill 需要处理的文件。

Store test cases in `evals/evals.json` inside your skill directory:

把测试用例存放在 skill 目录下的 `evals/evals.json` 中：

```json evals/evals.json theme={null}
{
  "skill_name": "csv-analyzer",
  "evals": [
    {
      "id": 1,
      "prompt": "I have a CSV of monthly sales data in data/sales_2025.csv. Can you find the top 3 months by revenue and make a bar chart?",
      "expected_output": "A bar chart image showing the top 3 months by revenue, with labeled axes and values.",
      "files": ["evals/files/sales_2025.csv"]
    },
    {
      "id": 2,
      "prompt": "there's a csv in my downloads called customers.csv, some rows have missing emails — can you clean it up and tell me how many were missing?",
      "expected_output": "A cleaned CSV with missing emails handled, plus a count of how many were missing.",
      "files": ["evals/files/customers.csv"]
    }
  ]
}
```

```json evals/evals.json theme={null}
{
  "skill_name": "csv-analyzer",
  "evals": [
    {
      "id": 1,
      "prompt": "我在 data/sales_2025.csv 里有一份月度销售数据的 CSV。你能找出营收排名前 3 的月份，并做一张柱状图吗？",
      "expected_output": "一张柱状图图片，展示营收排名前 3 的月份，坐标轴和数值都有标注。",
      "files": ["evals/files/sales_2025.csv"]
    },
    {
      "id": 2,
      "prompt": "我下载目录里有个叫 customers.csv 的文件，有些行缺邮箱——你能把它清理一下，并告诉我缺了多少条吗？",
      "expected_output": "一份处理好缺失邮箱问题的、干净的 CSV，外加缺失条数的统计。",
      "files": ["evals/files/customers.csv"]
    }
  ]
}
```

**Tips for writing good test prompts:**

**编写好的测试 prompt 的小技巧：**

* **Start with 2-3 test cases.** Don't over-invest before you've seen your first round of results. You can expand the set later.
* **Vary the prompts.** Use different phrasings, levels of detail, and formality. Some prompts should be casual ("hey can you clean up this csv"), others precise ("Parse the CSV at data/input.csv, drop rows where column B is null, and write the result to data/output.csv").
* **Cover edge cases.** Include at least one prompt that tests a boundary condition — a malformed input, an unusual request, or a case where the skill's instructions might be ambiguous.
* **Use realistic context.** Real users mention file paths, column names, and personal context. Prompts like "process this data" are too vague to test anything useful.

* **先从 2-3 个测试用例开始。** 在看到第一轮结果之前，不要投入过多精力；后面可以再扩充这个集合。
* **让 prompt 有所变化。** 使用不同的措辞、详略程度和正式程度。有些 prompt 可以很随意（“帮我清理一下这个 csv”），有些则要精确（“解析 data/input.csv 里的 CSV，丢弃列 B 为空的行，并把结果写入 data/output.csv”）。
* **覆盖边界情况。** 至少包含一条测试边界条件的 prompt——格式错误的输入、不寻常的请求，或者 skill 指令可能存在歧义的情形。
* **使用贴近真实的上下文。** 真实用户会提到文件路径、列名和个人化背景。像“处理一下这份数据”这种 prompt 太模糊了，测不出什么有用的东西。

Don't worry about defining specific pass/fail checks yet — just the prompts and expected outputs. You'll add detailed checks (called assertions) after you see what the first run produces.

先不用急着定义具体的通过/失败检查项——只需要 prompt 和预期输出。等你看到第一次运行的实际产出后，再添加详细的检查项（称为断言，assertions）。

## 2. Running evals - 运行评估

The core pattern is to run each test case twice: once **with the skill** and once **without it** (or with a previous version). This gives you a baseline to compare against.

核心模式是：每个测试用例都跑两遍——一遍**带上该 skill**，一遍**不带**（或者带上前一个版本）。这样你就有了一个可以对比的基线。

### 2.1 Workspace structure - 工作区结构

Organize eval results in a workspace directory alongside your skill directory. Each pass through the full eval loop gets its own `iteration-N/` directory. Within that, each test case gets an eval directory with `with_skill/` and `without_skill/` subdirectories:

在与 skill 目录并列的一个工作区目录中组织评估结果。每完整跑一轮评估循环，就对应一个独立的 `iteration-N/` 目录。在该目录下，每个测试用例都有自己的评估目录，其中包含 `with_skill/` 和 `without_skill/` 两个子目录：

```
csv-analyzer/
├── SKILL.md
└── evals/
    └── evals.json
csv-analyzer-workspace/
└── iteration-1/
    ├── eval-top-months-chart/
    │   ├── with_skill/
    │   │   ├── outputs/       # Files produced by the run
    │   │   ├── timing.json    # Tokens and duration
    │   │   └── grading.json   # Assertion results
    │   └── without_skill/
    │       ├── outputs/
    │       ├── timing.json
    │       └── grading.json
    ├── eval-clean-missing-emails/
    │   ├── with_skill/
    │   │   ├── outputs/
    │   │   ├── timing.json
    │   │   └── grading.json
    │   └── without_skill/
    │       ├── outputs/
    │       ├── timing.json
    │       └── grading.json
    └── benchmark.json         # Aggregated statistics
```

```
csv-analyzer/
├── SKILL.md
└── evals/
    └── evals.json
csv-analyzer-workspace/
└── iteration-1/
    ├── eval-top-months-chart/
    │   ├── with_skill/
    │   │   ├── outputs/       # 本次运行产出的文件
    │   │   ├── timing.json    # token 数与耗时
    │   │   └── grading.json   # 断言的评分结果
    │   └── without_skill/
    │       ├── outputs/
    │       ├── timing.json
    │       └── grading.json
    ├── eval-clean-missing-emails/
    │   ├── with_skill/
    │   │   ├── outputs/
    │   │   ├── timing.json
    │   │   └── grading.json
    │   └── without_skill/
    │       ├── outputs/
    │       ├── timing.json
    │       └── grading.json
    └── benchmark.json         # 汇总统计数据
```

The main file you author by hand is `evals/evals.json`. The other JSON files (`grading.json`, `timing.json`, `benchmark.json`) are produced during the eval process — by the agent, by scripts, or by you.

你需要手写的主文件只有 `evals/evals.json`。其余的 JSON 文件（`grading.json`、`timing.json`、`benchmark.json`）都是在评估过程中产生的——由智能体、脚本，或者你自己生成。

### 2.2 Spawning runs - 派生运行

Each eval run should start with a clean context — no leftover state from previous runs or from the skill development process. This ensures the agent follows only what the `SKILL.md` tells it. In environments that support subagents (Claude Code, for example), this isolation comes naturally: each child task starts fresh. Without subagents, use a separate session for each run.

每一次评估运行都应该从干净的上下文开始——不带有之前运行或 skill 开发过程中残留的状态。这样才能确保智能体只遵循 `SKILL.md` 里告诉它的内容。在支持子智能体（subagent）的环境中（例如 Claude Code），这种隔离是自然而然的：每个子任务都从零开始。如果不支持子智能体，就为每次运行使用一个独立的会话。

For each run, provide:

每次运行都需要提供：

* The skill path (or no skill for the baseline)
* The test prompt
* Any input files
* The output directory

* skill 的路径（若是跑基线则不提供）
* 测试用的 prompt
* 任何输入文件
* 输出目录

Here's an example of the instructions you'd give the agent for a single with-skill run:

下面是一个例子，展示你在单次"带 skill"的运行中会给智能体的指令：

```
Execute this task:
- Skill path: /path/to/csv-analyzer
- Task: I have a CSV of monthly sales data in data/sales_2025.csv.
  Can you find the top 3 months by revenue and make a bar chart?
- Input files: evals/files/sales_2025.csv
- Save outputs to: csv-analyzer-workspace/iteration-1/eval-top-months-chart/with_skill/outputs/
```

```
执行这个任务：
- Skill 路径：/path/to/csv-analyzer
- 任务：我在 data/sales_2025.csv 里有一份月度销售数据的 CSV。
  你能找出营收排名前 3 的月份，并做一张柱状图吗？
- 输入文件：evals/files/sales_2025.csv
- 把输出保存到：csv-analyzer-workspace/iteration-1/eval-top-months-chart/with_skill/outputs/
```

For the baseline, use the same prompt but without the skill path, saving to `without_skill/outputs/`.

对于基线运行，使用相同的 prompt，但不提供 skill 路径，并把输出保存到 `without_skill/outputs/`。

When improving an existing skill, use the previous version as your baseline. Snapshot it before editing (`cp -r <skill-path> <workspace>/skill-snapshot/`), point the baseline run at the snapshot, and save to `old_skill/outputs/` instead of `without_skill/`.

在改进已有的 skill 时，把前一个版本当作基线。在编辑之前先给它做一个快照（`cp -r <skill-path> <workspace>/skill-snapshot/`），让基线运行指向这个快照，并保存到 `old_skill/outputs/`，而不是 `without_skill/`。

### 2.3 Capturing timing data - 记录耗时数据

Timing data lets you compare how much time and tokens the skill costs relative to the baseline — a skill that dramatically improves output quality but triples token usage is a different trade-off than one that's both better and cheaper. When each run completes, record the token count and duration:

耗时数据可以让你对比 skill 相对于基线消耗了多少额外的时间和 token——一个能大幅提升输出质量、但 token 用量翻了三倍的 skill，与一个既更好又更省的 skill，是两种截然不同的取舍。每次运行完成后，记录下 token 数和耗时：

```json timing.json theme={null}
{
  "total_tokens": 84852,
  "duration_ms": 23332
}
```

> In Claude Code, when a subagent task finishes, the [task completion notification](https://platform.claude.com/docs/en/agent-sdk/typescript#sdk-task-notification-message) includes `total_tokens` and `duration_ms`. Save these values immediately — they aren't persisted anywhere else.

> 在 Claude Code 中，当一个子智能体任务完成时，[任务完成通知](https://platform.claude.com/docs/en/agent-sdk/typescript#sdk-task-notification-message)会包含 `total_tokens` 和 `duration_ms`。请立即保存这些数值——它们不会在其他任何地方被持久化保存。

## 3. Writing assertions - 编写断言

Assertions are verifiable statements about what the output should contain or achieve. Add them after you see your first round of outputs — you often don't know what "good" looks like until the skill has run.

断言（assertions）是关于输出应当包含什么、或应当达成什么的、可验证的陈述。请在你看到第一轮输出之后再添加它们——在 skill 真正运行之前，你往往并不清楚"好"到底长什么样。

Good assertions:

好的断言：

* `"The output file is valid JSON"` — programmatically verifiable.
* `"The bar chart has labeled axes"` — specific and observable.
* `"The report includes at least 3 recommendations"` — countable.

* `“输出文件是合法的 JSON”` — 可以用程序验证。
* `“柱状图的坐标轴都有标签”` — 具体且可观察。
* `“报告至少包含 3 条建议”` — 可计数。

Weak assertions:

弱的断言：

* `"The output is good"` — too vague to grade.
* `"The output uses exactly the phrase 'Total Revenue: $X'"` — too brittle; correct output with different wording would fail.

* `“输出结果不错”` — 太模糊，无法评分。
* `“输出内容必须逐字使用短语 ‘Total Revenue: $X’”` — 太脆弱；措辞不同但同样正确的输出会被判定失败。

Not everything needs an assertion. Some qualities — writing style, visual design, whether the output "feels right" — are hard to decompose into pass/fail checks. These are better caught during [human review](#reviewing-results-with-a-human). Reserve assertions for things that can be checked objectively.

并非所有事情都需要断言。有些特质——文字风格、视觉设计，或者输出"感觉对不对"——很难拆解成通过/失败的检查项。这类问题更适合在[人工审查](#reviewing-results-with-a-human)阶段发现。把断言留给那些可以客观检查的事情。

Add assertions to each test case in `evals/evals.json`:

把断言添加到 `evals/evals.json` 中的每个测试用例里：

```json evals/evals.json highlight={9-14} theme={null}
{
  "skill_name": "csv-analyzer",
  "evals": [
    {
      "id": 1,
      "prompt": "I have a CSV of monthly sales data in data/sales_2025.csv. Can you find the top 3 months by revenue and make a bar chart?",
      "expected_output": "A bar chart image showing the top 3 months by revenue, with labeled axes and values.",
      "files": ["evals/files/sales_2025.csv"],
      "assertions": [
        "The output includes a bar chart image file",
        "The chart shows exactly 3 months",
        "Both axes are labeled",
        "The chart title or caption mentions revenue"
      ]
    }
  ]
}
```

```json evals/evals.json highlight={9-14} theme={null}
{
  "skill_name": "csv-analyzer",
  "evals": [
    {
      "id": 1,
      "prompt": "我在 data/sales_2025.csv 里有一份月度销售数据的 CSV。你能找出营收排名前 3 的月份，并做一张柱状图吗？",
      "expected_output": "一张柱状图图片，展示营收排名前 3 的月份，坐标轴和数值都有标注。",
      "files": ["evals/files/sales_2025.csv"],
      "assertions": [
        "输出包含一个柱状图图片文件",
        "图表恰好展示了 3 个月份",
        "两个坐标轴都有标签",
        "图表标题或说明文字提到了营收"
      ]
    }
  ]
}
```

## 4. Grading outputs - 给输出打分

Grading means evaluating each assertion against the actual outputs and recording **PASS** or **FAIL** with specific evidence. The evidence should quote or reference the output, not just state an opinion.

打分（grading）意味着把每一条断言与实际的输出对照，并记录下**通过（PASS）**或**失败（FAIL）**，同时附上具体的证据。这些证据应当引用或指向实际输出，而不只是给出一个主观意见。

The simplest approach is to give the outputs and assertions to an LLM and ask it to evaluate each one. For assertions that can be checked by code (valid JSON, correct row count, file exists with expected dimensions), use a verification script — scripts are more reliable than LLM judgment for mechanical checks and reusable across iterations.

最简单的做法是把输出和断言都交给一个 LLM，让它逐条评估。对于那些可以用代码检查的断言（合法的 JSON、正确的行数、文件存在且尺寸符合预期），使用一个校验脚本——对于这类机械性检查，脚本比 LLM 的判断更可靠，而且可以在多轮迭代中复用。

```json grading.json theme={null}
{
  "assertion_results": [
    {
      "text": "The output includes a bar chart image file",
      "passed": true,
      "evidence": "Found chart.png (45KB) in outputs directory"
    },
    {
      "text": "The chart shows exactly 3 months",
      "passed": true,
      "evidence": "Chart displays bars for March, July, and November"
    },
    {
      "text": "Both axes are labeled",
      "passed": false,
      "evidence": "Y-axis is labeled 'Revenue ($)' but X-axis has no label"
    },
    {
      "text": "The chart title or caption mentions revenue",
      "passed": true,
      "evidence": "Chart title reads 'Top 3 Months by Revenue'"
    }
  ],
  "summary": {
    "passed": 3,
    "failed": 1,
    "total": 4,
    "pass_rate": 0.75
  }
}
```

```json grading.json theme={null}
{
  "assertion_results": [
    {
      "text": "输出包含一个柱状图图片文件",
      "passed": true,
      "evidence": "在 outputs 目录中找到了 chart.png（45KB）"
    },
    {
      "text": "图表恰好展示了 3 个月份",
      "passed": true,
      "evidence": "图表展示了 3 月、7 月和 11 月的柱状条"
    },
    {
      "text": "两个坐标轴都有标签",
      "passed": false,
      "evidence": "Y 轴标注为 'Revenue ($)'，但 X 轴没有标签"
    },
    {
      "text": "图表标题或说明文字提到了营收",
      "passed": true,
      "evidence": "图表标题为 'Top 3 Months by Revenue'"
    }
  ],
  "summary": {
    "passed": 3,
    "failed": 1,
    "total": 4,
    "pass_rate": 0.75
  }
}
```

### 4.1 Grading principles - 打分原则

* **Require concrete evidence for a PASS.** Don't give the benefit of the doubt. If an assertion says "includes a summary" and the output has a section titled "Summary" with one vague sentence, that's a FAIL — the label is there but the substance isn't.
* **Review the assertions themselves, not just the results.** While grading, notice when assertions are too easy (always pass regardless of skill quality), too hard (always fail even when the output is good), or unverifiable (can't be checked from the output alone). Fix these for the next iteration.

* **判定为通过（PASS）必须要有具体证据。** 不要抱着"姑且相信"的态度。如果某条断言说"包含摘要"，而输出里确实有一个标题为"摘要"的小节，但内容只有一句含糊其辞的话，那就应当判为失败（FAIL）——标签在，实质内容却不在。
* **不只审查结果，也要审查断言本身。** 在打分过程中，留意哪些断言太容易了（不管 skill 质量如何都会通过）、太苛刻了（即便输出很好也总是失败），或者根本无法验证（仅凭输出本身无法判断）。在下一轮迭代中修正这些断言。

> For comparing two skill versions, try **blind comparison**: present both outputs to an LLM judge without revealing which came from which version. The judge scores holistic qualities — organization, formatting, usability, polish — on its own rubric, free from bias about which version "should" be better. This complements assertion grading: two outputs might both pass all assertions but differ significantly in overall quality.

> 要对比两个 skill 版本时，可以尝试**盲对比（blind comparison）**：把两份输出都交给一个 LLM 评判者，但不透露哪份来自哪个版本。评判者依据自己的评分标准，对整体质量——组织结构、格式、可用性、精细程度——打分，不会因为"哪个版本理应更好"而产生偏见。这可以作为断言打分的补充：两份输出可能都通过了全部断言，但整体质量却相差很大。

## 5. Aggregating results - 汇总结果

Once every run in the iteration is graded, compute summary statistics per configuration and save them to `benchmark.json` alongside the eval directories (e.g., `csv-analyzer-workspace/iteration-1/benchmark.json`):

当这一轮迭代中的每次运行都打完分之后，按配置分别计算汇总统计数据，并把它们和各个评估目录一起保存到 `benchmark.json` 中（例如 `csv-analyzer-workspace/iteration-1/benchmark.json`）：

```json benchmark.json theme={null}
{
  "run_summary": {
    "with_skill": {
      "pass_rate": { "mean": 0.83, "stddev": 0.06 },
      "time_seconds": { "mean": 45.0, "stddev": 12.0 },
      "tokens": { "mean": 3800, "stddev": 400 }
    },
    "without_skill": {
      "pass_rate": { "mean": 0.33, "stddev": 0.10 },
      "time_seconds": { "mean": 32.0, "stddev": 8.0 },
      "tokens": { "mean": 2100, "stddev": 300 }
    },
    "delta": {
      "pass_rate": 0.50,
      "time_seconds": 13.0,
      "tokens": 1700
    }
  }
}
```

The `delta` tells you what the skill costs (more time, more tokens) and what it buys (higher pass rate). A skill that adds 13 seconds but improves pass rate by 50 percentage points is probably worth it. A skill that doubles token usage for a 2-point improvement might not be.

`delta`（差值）告诉你这个 skill 付出了什么代价（更多时间、更多 token），又换来了什么收益（更高的通过率）。一个多花 13 秒、但通过率提升 50 个百分点的 skill，大概率是值得的；而一个 token 用量翻倍、通过率只提升 2 个百分点的 skill，可能就不值得了。

> Standard deviation (`stddev`) is only meaningful with multiple runs per eval. In early iterations with just 2-3 test cases and single runs, focus on the raw pass counts and the delta — the statistical measures become useful as you expand the test set and run each eval multiple times.

> 标准差（`stddev`）只有在每个评估都运行多次的情况下才有意义。在早期只有 2-3 个测试用例、每个只跑一次的迭代阶段，请把注意力放在原始的通过次数和 `delta` 上——等到你扩充测试集、并让每个评估都跑多次之后，这些统计指标才会真正派上用场。

## 6. Analyzing patterns - 分析模式

Aggregate statistics can hide important patterns. After computing the benchmarks:

汇总统计数据可能掩盖一些重要的模式。在算出 benchmark 之后：

* **Remove or replace assertions that always pass in both configurations.** These don't tell you anything useful — the model handles them fine without the skill. They inflate the with-skill pass rate without reflecting actual skill value.
* **Investigate assertions that always fail in both configurations.** Either the assertion is broken (asking for something the model can't do), the test case is too hard, or the assertion is checking for the wrong thing. Fix these before the next iteration.
* **Study assertions that pass with the skill but fail without.** This is where the skill is clearly adding value. Understand *why* — which instructions or scripts made the difference?
* **Tighten instructions when results are inconsistent across runs.** If the same eval passes sometimes and fails others (reflected as high `stddev` in the benchmark), the eval may be flaky (sensitive to model randomness), or the skill's instructions may be ambiguous enough that the model interprets them differently each time. Add examples or more specific guidance to reduce ambiguity.
* **Check time and token outliers.** If one eval takes 3x longer than the others, read its execution transcript (the full log of what the model did during the run) to find the bottleneck.

* **删除或替换那些在两种配置下都总是通过的断言。** 这些断言没什么用——即便没有这个 skill，模型也能处理得很好。它们只会虚高"带 skill"一侧的通过率，却不能反映 skill 的真实价值。
* **调查那些在两种配置下都总是失败的断言。** 要么是断言本身有问题（要求模型做它做不到的事），要么是测试用例太难，要么是断言检查错了方向。在下一轮迭代之前先修好这些问题。
* **重点研究那些"带 skill 时通过、不带时失败"的断言。** 这正是 skill 明显带来价值的地方。要搞清楚*为什么*——是哪些指令或脚本起了作用？
* **当结果在多次运行中不一致时，收紧指令。** 如果同一个评估有时通过、有时失败（在 benchmark 中体现为较高的 `stddev`），可能是这个评估本身不稳定（对模型的随机性很敏感），也可能是 skill 的指令存在歧义，导致模型每次的理解都不一样。补充示例或更具体的指导，来减少歧义。
* **排查耗时和 token 的异常值。** 如果某个评估比其他的慢了 3 倍，就去读它的执行 trace（模型在这次运行中所做一切的完整日志），找出瓶颈所在。

## 7. Reviewing results with a human - 由人工审查结果

Assertion grading and pattern analysis catch a lot, but they only check what you thought to write assertions for. A human reviewer brings a fresh perspective — catching issues you didn't anticipate, noticing when the output is technically correct but misses the point, or spotting problems that are hard to express as pass/fail checks. For each test case, review the actual outputs alongside the grades.

断言打分和模式分析能抓出不少问题，但它们只能检查你当初想到要写成断言的那些内容。人工审查者能带来全新的视角——发现你没有预料到的问题，注意到输出在技术上正确、但没抓住重点的情况，或者揪出那些很难表达成通过/失败检查项的问题。对于每个测试用例，都要把实际输出和评分结果一起拿来审查。

Record specific feedback for each test case and save it in the workspace (e.g., as a `feedback.json` alongside the eval directories):

为每个测试用例记录具体的反馈，并保存在工作区中（例如作为一个 `feedback.json`，与各评估目录放在一起）：

```json feedback.json theme={null}
{
  "eval-top-months-chart": "The chart is missing axis labels and the months are in alphabetical order instead of chronological.",
  "eval-clean-missing-emails": ""
}
```

```json feedback.json theme={null}
{
  "eval-top-months-chart": "图表缺少坐标轴标签，而且月份是按字母顺序排列的，而不是按时间顺序。",
  "eval-clean-missing-emails": ""
}
```

"The chart is missing axis labels" is actionable; "looks bad" is not. Empty feedback means the output looked fine — that test case passed your review. During the [iteration step](#iterating-on-the-skill), focus your improvements on the test cases where you had specific complaints.

“图表缺少坐标轴标签”是可以据此采取行动的；“看起来很差”则不是。空的反馈意味着这份输出看起来没问题——也就是说这个测试用例通过了你的审查。在[迭代步骤](#iterating-on-the-skill)中，把改进的重点放在那些你提出了具体意见的测试用例上。

## 8. Iterating on the skill - 迭代改进 skill

After grading and reviewing, you have three sources of signal:

打分和审查完成之后，你手上有三种信号来源：

* **Failed assertions** point to specific gaps — a missing step, an unclear instruction, or a case the skill doesn't handle.
* **Human feedback** points to broader quality issues — the approach was wrong, the output was poorly structured, or the skill produced a technically correct but unhelpful result.
* **Execution transcripts** reveal *why* things went wrong. If the agent ignored an instruction, the instruction may be ambiguous. If the agent spent time on unproductive steps, those instructions may need to be simplified or removed.

* **失败的断言**指向具体的缺口——缺失的步骤、不清晰的指令，或者 skill 没有处理到的情形。
* **人工反馈**指向更宏观的质量问题——方法用错了、输出结构组织得不好，或者 skill 产出了一个技术上正确、但毫无帮助的结果。
* **执行 trace** 揭示事情出错的*原因*。如果智能体忽略了某条指令，说明这条指令可能有歧义；如果智能体在一些无效步骤上花费了时间，说明那些指令可能需要被简化或移除。

The most effective way to turn these signals into skill improvements is to give all three — along with the current `SKILL.md` — to an LLM and ask it to propose changes. The LLM can synthesize patterns across failed assertions, reviewer complaints, and transcript behavior that would be tedious to connect manually. When prompting the LLM, include these guidelines:

把这些信号转化为 skill 改进的最有效方式，是把这三种信号——连同当前的 `SKILL.md`——一起交给一个 LLM，让它提出修改建议。LLM 能够把失败的断言、审查者的意见，以及 trace 中体现的行为综合起来，找出那些如果靠人工手动串联会很繁琐的模式。在提示这个 LLM 时，请附上以下几条指导原则：

* **从反馈中做泛化。** 这个 skill 将会被用在许多不同的 prompt 上，而不仅仅是这些测试用例。修复方案应当广泛地解决底层问题，而不是针对具体样例打上狭窄的补丁。
* **保持 skill 精简。** 更少、更好的指令往往胜过面面俱到的规则。如果 trace 显示存在浪费的工作（不必要的校验、不需要的中间产物），就去掉那些指令。如果加了更多规则后通过率却停滞不前，说明这个 skill 可能被过度约束了——尝试删掉一些指令，看看结果是否保持不变甚至有所改善。
* **解释为什么这样做。** 基于推理的指令（"做 X，因为 Y 往往会导致 Z"）比刚性的指示（"永远做 X，绝不做 Y"）效果更好。当模型理解指令背后的目的时，会更可靠地遵循它。
* **把重复出现的工作打包起来。** 如果每次测试运行都各自独立地写出了类似的辅助脚本（一个图表生成器、一个数据解析器），这就是一个信号：应该把这段脚本打包进 skill 的 `scripts/` 目录里。具体做法请参见 [Using scripts](/skill-creation/using-scripts)。

* **Generalize from feedback.** The skill will be used across many different prompts, not just the test cases. Fixes should address underlying issues broadly rather than adding narrow patches for specific examples.
* **Keep the skill lean.** Fewer, better instructions often outperform exhaustive rules. If transcripts show wasted work (unnecessary validation, unneeded intermediate outputs), remove those instructions. If pass rates plateau despite adding more rules, the skill may be over-constrained — try removing instructions and see if results hold or improve.
* **Explain the why.** Reasoning-based instructions ("Do X because Y tends to cause Z") work better than rigid directives ("ALWAYS do X, NEVER do Y"). Models follow instructions more reliably when they understand the purpose.
* **Bundle repeated work.** If every test run independently wrote a similar helper script (a chart builder, a data parser), that's a signal to bundle the script into the skill's `scripts/` directory. See [Using scripts](/skill-creation/using-scripts) for how to do this.

### 8.1 The loop - 迭代循环

1. Give the eval signals and current `SKILL.md` to an LLM and ask it to propose improvements.
2. Review and apply the changes.
3. Rerun all test cases in a new `iteration-<N+1>/` directory.
4. Grade and aggregate the new results.
5. Review with a human. Repeat.

1. 把评估信号和当前的 `SKILL.md` 一起交给一个 LLM，让它提出改进建议。
2. 审查并应用这些修改。
3. 在一个新的 `iteration-<N+1>/` 目录中重新跑一遍所有测试用例。
4. 给新一轮的结果打分并汇总。
5. 由人工审查。然后重复以上步骤。

Stop when you're satisfied with the results, feedback is consistently empty, or you're no longer seeing meaningful improvement between iterations.

当你对结果感到满意、反馈持续为空，或者你已经看不到迭代之间有意义的提升时，就可以停下来了。

> The [`skill-creator`](https://github.com/anthropics/skills/tree/main/skills/skill-creator) Skill automates much of this workflow — running evals, grading assertions, aggregating benchmarks, and presenting results for human review.

> [`skill-creator`](https://github.com/anthropics/skills/tree/main/skills/skill-creator) 这个 Skill 自动化了这套工作流的大部分环节——运行评估、给断言打分、汇总 benchmark，并把结果呈现出来供人工审查。
