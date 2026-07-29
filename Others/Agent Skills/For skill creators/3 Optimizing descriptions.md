# Optimizing skill descriptions - 优化 skill 描述

原文地址：[https://agentskills.io/skill-creation/optimizing-descriptions](https://agentskills.io/skill-creation/optimizing-descriptions)

> How to improve your skill's description so it triggers reliably on relevant prompts.

> 如何改进 skill 的 description，使它在遇到相关的提示时能可靠地被触发。

A skill only helps if it gets activated. The `description` field in your `SKILL.md` frontmatter is the primary mechanism agents use to decide whether to load a skill for a given task. An under-specified description means the skill won't trigger when it should; an over-broad description means it triggers when it shouldn't.

一个 skill 只有被激活时才能发挥作用。`SKILL.md` 前言中的 `description` 字段，是智能体决定是否为某个任务加载该 skill 的主要依据。描述得不够具体，skill 就无法在该触发时触发；描述得太宽泛，则会在不该触发时被触发。

This guide covers how to systematically test and improve your skill's description for triggering accuracy.

本指南介绍如何系统地测试并改进你 skill 的 description，以提升触发的准确性。

## 1. How skill triggering works - skill 触发机制

Agents use [progressive disclosure](/specification#progressive-disclosure) to manage context. At startup, they load only the `name` and `description` of each available skill — just enough to decide when a skill might be relevant. When a user's task matches a description, the agent reads the full `SKILL.md` into context and follows its instructions.

智能体通过[渐进式披露（progressive disclosure）](/specification#progressive-disclosure)来管理上下文。启动时，它只加载每个可用 skill 的 `name` 和 `description`——足以判断某个 skill 何时可能相关。当用户的任务与某个描述匹配时，智能体才会把完整的 `SKILL.md` 读入上下文，并按其指令行事。

This means the description carries the entire burden of triggering. If the description doesn't convey when the skill is useful, the agent won't know to reach for it.

这意味着触发的重担完全落在 description 上。如果描述没有说清 skill 在何时有用，智能体就不会想到去调用它。

One important nuance: agents typically only consult skills for tasks that require knowledge or capabilities beyond what they can handle alone. A simple, one-step request like "read this PDF" may not trigger a PDF skill even if the description matches perfectly, because the agent can handle it with basic tools. Tasks that involve specialized knowledge — an unfamiliar API, a domain-specific workflow, or an uncommon format — are where a well-written description can make the difference.

有一点需要注意：智能体通常只会为那些超出它自身能力范围、需要额外知识或能力的任务去查找 skill。像 “read this PDF”（读一下这份 PDF）这种简单的一步操作，即便描述完美匹配，也可能不会触发 PDF 相关的 skill，因为智能体用基本工具就能完成。真正让一份写得好的 description 发挥作用的，是那些涉及专业知识的任务——不熟悉的 API、特定领域的工作流，或者不常见的格式。

## 2. Writing effective descriptions - 编写有效的 description

Before testing, it helps to know what a good description looks like. A few principles:

在开始测试之前，先了解一下“什么才算好的 description”会很有帮助。几条原则：

* **Use imperative phrasing.** Frame the description as an instruction to the agent: "Use this skill when..." rather than "This skill does..." The agent is deciding whether to act, so tell it when to act.
* **Focus on user intent, not implementation.** Describe what the user is trying to achieve, not the skill's internal mechanics. The agent matches against what the user asked for.
* **Err on the side of being pushy.** Explicitly list contexts where the skill applies, including cases where the user doesn't name the domain directly: "even if they don't explicitly mention 'CSV' or 'analysis.'"
* **Keep it concise.** A few sentences to a short paragraph is usually right — long enough to cover the skill's scope, short enough that it doesn't bloat the agent's context across many skills. The [specification](/specification#description-field) enforces a hard limit of 1024 characters.

* **使用祈使语气。** 把 description 当作对智能体的一条指令来写：用 “Use this skill when…”（“在……时使用该 skill”），而不是 “This skill does…”（“该 skill 会……”）。智能体在决定是否要动手，所以你要告诉它 *什么时候* 动手。
* **关注用户意图，而不是实现细节。** 描述用户 *想要达成什么*，而不是 skill 内部的运作方式。智能体是在与用户的诉求做匹配。
* **宁可稍显主动一点。** 明确列出该 skill 适用的场景，包括用户没有直接点明领域名词的情况：例如“即便用户没有明确提到 ‘CSV’ 或 ‘analysis’”。
* **保持简洁。** 通常几句话到一小段就足够——足以覆盖 skill 的适用范围，又不至于让智能体在众多 skill 上下文里被撑爆。[规范](/specification#description-field)对此设定了 1024 字符的硬性上限。

## 3. Designing trigger eval queries - 设计用于触发评估的查询集

To test triggering, you need a set of eval queries — realistic user prompts labeled with whether they should or shouldn't trigger your skill.

要测试触发，你需要一组评估查询（eval queries）——即真实用户提示的样本，并标注它们*应该*或*不应该*触发你的 skill。

```json eval_queries.json theme={null}
[
  { "query": "I've got a spreadsheet in ~/data/q4_results.xlsx with revenue in col C and expenses in col D — can you add a profit margin column and highlight anything under 10%?", "should_trigger": true },
  { "query": "whats the quickest way to convert this json file to yaml", "should_trigger": false }
]
```

```json eval_queries.json theme={null}
[
  { "query": "我在 ~/data/q4_results.xlsx 有一份电子表格，C 列是营收、D 列是支出——你能帮我加一列利润率，并把低于 10% 的高亮出来吗？", "should_trigger": true },
  { "query": "把这个 json 文件转成 yaml 最快的方式是什么", "should_trigger": false }
]
```

Aim for about 20 queries: 8-10 that should trigger and 8-10 that shouldn't.

大约准备 20 条查询即可：8-10 条应该触发，8-10 条不应该触发。

### 3.1 Should-trigger queries - 应触发的查询

These test whether the description captures the skill's scope. Vary them along several axes:

这类查询用于测试 description 是否覆盖了 skill 的适用范围。可以在以下几个维度上做变化：

* **Phrasing**: some formal, some casual, some with typos or abbreviations.
* **Explicitness**: some name the skill's domain directly ("analyze this CSV"), others describe the need without naming it ("my boss wants a chart from this data file").
* **Detail**: mix terse prompts with context-heavy ones — a short "analyze my sales CSV and make a chart" alongside a longer message with file paths, column names, and backstory.
* **Complexity**: vary the number of steps and decision points. Include single-step tasks alongside multi-step workflows to test whether the agent can discern the skill is relevant when the task it addresses is buried in a larger chain.

* **措辞**：有些正式，有些随意，有些带错别字或缩写。
* **明确程度**：有的直接点名 skill 的领域（“分析这份 CSV”），有的则只描述需求而不点名（“我老板想让我基于这份数据文件做一张图表”）。
* **详略程度**：把简短提示和信息量大的提示混在一起——例如一句“分析我的销售 CSV 并做一张图表”，同时也放一条包含文件路径、列名和背景故事的更长消息。
* **复杂度**：改变步骤数和决策点的数量。既要包含单步任务，也要包含多步骤工作流，用来测试当 skill 所处理的任务被埋在一条更长的任务链里时，智能体是否还能识别出该 skill 是相关的。

The most useful should-trigger queries are ones where the skill would help but the connection isn't obvious from the query alone. These are the cases where description wording makes the difference — if the query already asks for exactly what the skill does, any reasonable description would trigger.

最有价值的“应触发”查询，是那些 skill 会真正帮上忙、但从查询本身看不出明显关联的情况。这正是 description 的措辞发挥决定性作用的场景——如果查询里已经完全说出了 skill 要做的事情，那么任何一份合理的 description 都能触发。

### 3.2 Should-not-trigger queries - 不应触发的查询

The most valuable negative test cases are **near-misses** — queries that share keywords or concepts with your skill but actually need something different. These test whether the description is precise, not just broad.

最有价值的负例是 **近似干扰项（near-misses）**——即那些与你的 skill 共享关键词或概念、但实际上需要的是别的能力的查询。这类用例用来测试 description 是否*精准*，而不仅仅是*宽泛*。

For a CSV analysis skill, weak negative examples would be:

对于一个“CSV 分析”类 skill，一般的反例可能是：

* `"Write a fibonacci function"` — obviously irrelevant, tests nothing.
* `"What's the weather today?"` — no keyword overlap, too easy.

* `“写一个斐波那契函数”` — 明显无关，什么都测不出。
* `“今天天气怎么样？”` — 没有任何关键词重叠，太容易了。

Strong negative examples:

极其负面的例子：

* `"I need to update the formulas in my Excel budget spreadsheet"` — shares "spreadsheet" and "data" concepts, but needs Excel editing, not CSV analysis.
* `"can you write a python script that reads a csv and uploads each row to our postgres database"` — involves CSV, but the task is database ETL, not analysis.

* `“我需要修改我 Excel 预算表里的公式”` — 共享了 “spreadsheet” 和 “data” 这些概念，但要做的是 Excel 编辑，而不是 CSV 分析。
* `“能不能写一段 python 脚本，读取一个 csv，把每一行上传到我们的 postgres 数据库”` — 涉及 CSV，但任务是数据库 ETL，而不是数据分析。

### 3.3 Tips for realism - 让样本更贴近真实的技巧

Real user prompts contain context that generic test queries lack. Include:

真实的用户提示里包含着通用测试查询所缺失的上下文。要包含：

* File paths (`~/Downloads/report_final_v2.xlsx`)
* Personal context (`"my manager asked me to..."`)
* Specific details (column names, company names, data values)
* Casual language, abbreviations, and occasional typos

* 文件路径（`~/Downloads/report_final_v2.xlsx`）
* 个人化背景（`“我经理让我……”`）
* 具体细节（列名、公司名、具体数据值）
* 口语化措辞、缩写，以及偶尔的错别字

## 4. Testing whether a description triggers - 测试 description 是否会触发

The basic approach: run each query through your agent with the skill installed and observe whether the agent invokes it. Make sure the skill is registered and discoverable by your agent — how this works varies by client (e.g., a skills directory, a configuration file, or a CLI flag).

基本做法是：在已安装该 skill 的智能体上跑一遍每一条查询，观察它是否被调用。请确保该 skill 已经在你的智能体中注册且可被发现——具体做法因客户端而异（可能是某个 skills 目录、一个配置文件，或一个 CLI 参数）。

Most agent clients provide some form of observability — execution logs, tool call histories, or verbose output — that lets you see which skills were consulted during a run. Check your client's documentation for details. The skill triggered if the agent loaded your skill's `SKILL.md`; it didn't trigger if the agent proceeded without consulting it.

大多数智能体客户端都提供某种可观测手段——执行日志、工具调用历史，或详细输出——让你能看到某次运行中哪些 skill 被查阅过。具体请查阅你所用客户端的文档。如果智能体加载了你的 `SKILL.md`，就算作触发；如果它没查阅就直接开工，则没有触发。

A query "passes" if:

一条查询“通过”的判定标准是：

* `should_trigger` is `true` and the skill was invoked, or
* `should_trigger` is `false` and the skill was not invoked.

* `should_trigger` 为 `true` 且 skill 被调用了，或者
* `should_trigger` 为 `false` 且 skill 没有被调用。

### 4.1 Running multiple times - 多次运行

Model behavior is nondeterministic — the same query might trigger the skill on one run but not the next. Run each query multiple times (3 is a reasonable starting point) and compute a **trigger rate**: the fraction of runs where the skill was invoked.

模型行为具有非确定性——同一条查询可能这一次触发了 skill，下一次却不触发。请为每条查询运行多次（3 次是一个合理的起点），并计算 **触发率（trigger rate）**：skill 被调用的次数占总运行次数的比例。

A should-trigger query passes if its trigger rate is above a threshold (0.5 is a reasonable default). A should-not-trigger query passes if its trigger rate is below that threshold.

对于“应触发”的查询，触发率高于某个阈值（0.5 是一个合理的默认值）即视为通过；对于“不应触发”的查询，触发率低于该阈值即视为通过。

With 20 queries at 3 runs each, that's 60 invocations. You'll want to script this. Here's the general structure — replace the `claude` invocation and detection logic in `check_triggered` with whatever your agent client provides:

20 条查询 × 每条 3 次 = 60 次调用。你会想把这一步脚本化。以下是一个大致框架——把 `check_triggered` 里的 `claude` 调用以及触发检测逻辑，替换成你所用智能体客户端提供的对应实现即可：

```bash theme={null}
#!/bin/bash
QUERIES_FILE="${1:?Usage: $0 <queries.json>}"
SKILL_NAME="my-skill"
RUNS=3

# This example uses Claude Code's JSON output to check for Skill tool calls.
# Replace this function with detection logic for your agent client.
# Should return 0 (success) if the skill was invoked, 1 otherwise.
check_triggered() {
  local query="$1"
  claude -p "$query" --output-format json 2>/dev/null \
    | jq -e --arg skill "$SKILL_NAME" \
      'any(.messages[].content[]; .type == "tool_use" and .name == "Skill" and .input.skill == $skill)' \
      > /dev/null 2>&1
}

count=$(jq length "$QUERIES_FILE")
for i in $(seq 0 $((count - 1))); do
  query=$(jq -r ".[$i].query" "$QUERIES_FILE")
  should_trigger=$(jq -r ".[$i].should_trigger" "$QUERIES_FILE")
  triggers=0

  for run in $(seq 1 $RUNS); do
    check_triggered "$query" && triggers=$((triggers + 1))
  done

  jq -n \
    --arg query "$query" \
    --argjson should_trigger "$should_trigger" \
    --argjson triggers "$triggers" \
    --argjson runs "$RUNS" \
    '{query: $query, should_trigger: $should_trigger, triggers: $triggers, runs: $runs, trigger_rate: ($triggers / $runs)}'
done | jq -s '.'
```

```bash theme={null}
#!/bin/bash
QUERIES_FILE="${1:?用法: $0 <queries.json>}"
SKILL_NAME="my-skill"
RUNS=3

# 本示例通过 Claude Code 的 JSON 输出来检测 Skill 工具调用。
# 请把该函数替换为你所用智能体客户端对应的检测逻辑。
# 若 skill 被调用则返回 0（成功），否则返回 1。
check_triggered() {
  local query="$1"
  claude -p "$query" --output-format json 2>/dev/null \
    | jq -e --arg skill "$SKILL_NAME" \
      'any(.messages[].content[]; .type == "tool_use" and .name == "Skill" and .input.skill == $skill)' \
      > /dev/null 2>&1
}

count=$(jq length "$QUERIES_FILE")
for i in $(seq 0 $((count - 1))); do
  query=$(jq -r ".[$i].query" "$QUERIES_FILE")
  should_trigger=$(jq -r ".[$i].should_trigger" "$QUERIES_FILE")
  triggers=0

  for run in $(seq 1 $RUNS); do
    check_triggered "$query" && triggers=$((triggers + 1))
  done

  jq -n \
    --arg query "$query" \
    --argjson should_trigger "$should_trigger" \
    --argjson triggers "$triggers" \
    --argjson runs "$RUNS" \
    '{query: $query, should_trigger: $should_trigger, triggers: $triggers, runs: $runs, trigger_rate: ($triggers / $runs)}'
done | jq -s '.'
```

> If your agent client supports it, you can stop a run early once the outcome is clear — the agent either consulted the skill or started working without it. This can significantly reduce the time and cost of running the full eval set.

> 如果你的智能体客户端支持，可以在结果已经明朗时提前终止某次运行——要么智能体已经查阅了该 skill，要么它没查就直接动手了。这能显著降低跑完整评估集所需的时间和成本。

## 5. Avoiding overfitting with train/validation splits - 用训练集/验证集拆分来避免过拟合

If you optimize the description against all your queries, you risk overfitting — crafting a description that works for these specific phrasings but fails on new ones.

如果你拿全部查询来优化 description，就有过拟合的风险——最终得到的 description 只对这些特定的措辞奏效，一遇到新的查询就不灵了。

The solution is to split your query set:

解决办法是拆分你的查询集：

* **Train set (\~60%)**: the queries you use to identify failures and guide improvements.
* **Validation set (\~40%)**: queries you set aside and only use to check whether improvements generalize.

* **训练集（\~60%）**：用来识别失败样例、指导改进方向的查询。
* **验证集（\~40%）**：单独留出来的查询，仅用于检查你所做的改进是否具有泛化能力。

Make sure both sets contain a proportional mix of should-trigger and should-not-trigger queries — don't accidentally put all the positives in one set. Shuffle randomly and keep the split fixed across iterations so you're comparing apples to apples.

请确保两个集合都按比例包含“应触发”和“不应触发”的查询——不要不小心把所有正例都塞进一个集合。随机打散后就固定这个划分，以便每一轮迭代都在同一标准下比较。

If you're using a script like the one [above](#running-multiple-times), you can split your queries into two files — `train_queries.json` and `validation_queries.json` — and run the script against each one separately.

如果你用的是[上面](#running-multiple-times)那样的脚本，可以把查询拆成两个文件——`train_queries.json` 和 `validation_queries.json`——然后分别跑一遍。

## 6. The optimization loop - 优化循环

1. **Evaluate** the current description on both *train and validation sets*. The train results guide your changes; the validation results tell you whether those changes are generalizing.
2. **Identify failures** in the *train set*: which should-trigger queries didn't trigger? Which should-not-trigger queries did?
   * Only use train set failures to guide your changes — whether you're revising the description yourself or prompting an LLM, keep validation set results out of the process.
3. **Revise the description.** Focus on generalizing:
   * If should-trigger queries are failing, the description may be too narrow. Broaden the scope or add context about when the skill is useful.
   * If should-not-trigger queries are false-triggering, the description may be too broad. Add specificity about what the skill does *not* do, or clarify the boundary between this skill and adjacent capabilities.
   * Avoid adding specific keywords from failed queries — that's overfitting. Instead, find the general category or concept those queries represent and address that.
   * If you're stuck after several iterations, try a structurally different approach to the description rather than incremental tweaks. A different framing or sentence structure may break through where refinement can't.
   * Check that the description stays under the 1024-character limit — descriptions tend to grow during optimization.
4. **Repeat** steps 1-3 until all *train set* queries pass or you stop seeing meaningful improvement.
5. **Select the best iteration** by its validation pass rate — the fraction of queries in the *validation set* that passed. Note that the best description may not be the last one you produced; an earlier iteration might have a higher validation pass rate than later ones that overfit to the train set.

>

1. **评估**当前 description 在*训练集和验证集*上的表现。训练集的结果指导你改哪里；验证集的结果告诉你这些改动是否具有泛化能力。
2. **识别*训练集*中的失败样例**：哪些“应触发”的查询没触发？哪些“不应触发”的查询却触发了？
   * 只用训练集的失败样例来指导修改——无论是你自己动手改，还是用 LLM 来提议修改，都要把验证集的结果排除在这一过程之外。
3. **修改 description。** 着眼于泛化：
   * 如果“应触发”的查询触发失败，说明 description 可能太窄。放宽适用范围，或补充说明 skill 在何时有用。
   * 如果“不应触发”的查询发生了误触发，说明 description 可能太宽。加上关于 skill *不做*什么的具体说明，或明确该 skill 与相邻能力之间的边界。
   * 不要照抄失败查询里的具体关键词——那就是过拟合。而是要找出那些查询所代表的通用类别或概念，然后针对这类概念做说明。
   * 如果迭代好几次都卡住了，就尝试一种在结构上完全不同的写法，而不是继续做微调。换一种叙述框架或句式，可能会突破微调无法解决的瓶颈。
   * 检查 description 是否仍在 1024 字符限制之内——在优化过程中，description 往往会越写越长。
4. **重复**步骤 1-3，直到*训练集*上所有查询都通过，或者你已经看不到有意义的进步为止。
5. **按验证通过率挑出最好的那一版**——也就是*验证集*中通过的查询占比。请注意，最好的 description 未必是你最后写的那一版；某个更早的迭代版本可能在验证集上通过率更高，而更后期的版本反而对训练集过拟合了。

Five iterations is usually enough. If performance isn't improving, the issue may be with the queries (too easy, too hard, or poorly labeled) rather than the description.

通常五轮迭代就足够了。如果性能不再提升，问题可能出在查询集上（太简单、太难，或者标注不当），而不是 description 本身。

> The [`skill-creator`](https://github.com/anthropics/skills/tree/main/skills/skill-creator) Skill automates this loop end-to-end: it splits the eval set, evaluates trigger rates in parallel, proposes description improvements using Claude, and generates a live HTML report you can watch as it runs.

> [`skill-creator`](https://github.com/anthropics/skills/tree/main/skills/skill-creator) 这个 Skill 端到端地自动化了整个循环：它会拆分评估集、并行评估触发率、用 Claude 提出 description 的改进建议，并生成一份可以实时观看的 HTML 报告。

## 7. Applying the result - 应用最终结果

Once you've selected the best description:

在你挑出最好的那一版 description 之后：

1. Update the `description` field in your `SKILL.md` frontmatter.
2. Verify the description is under the [1024-character limit](/specification#description-field).
3. Verify the description triggers as expected. Try a few prompts manually as a quick sanity check. For a more rigorous test, write 5-10 fresh queries (a mix of should-trigger and should-not-trigger) and run them through the eval script — since these queries were never part of the optimization process, they give you an honest check on whether the description generalizes.

1. 更新 `SKILL.md` frontmatter 中的 `description` 字段。
2. 确认 description 在 [1024 字符限制](/specification#description-field)以内。
3. 确认 description 能按预期触发。手动跑几条提示做个快速的合理性检查；如果想更严格地测试，可以另外写 5-10 条全新的查询（“应触发”和“不应触发”混合），交给评估脚本跑一次——由于这些查询从未参与过优化过程，它们能给你一个诚实的评判：description 究竟能否泛化。

Before and after:

前后对比：

```yaml theme={null}
# Before
description: Process CSV files.

# After
description: >
  Analyze CSV and tabular data files — compute summary statistics,
  add derived columns, generate charts, and clean messy data. Use this
  skill when the user has a CSV, TSV, or Excel file and wants to
  explore, transform, or visualize the data, even if they don't
  explicitly mention "CSV" or "analysis."
```

```yaml theme={null}
# 优化前
description: 处理 CSV 文件。

# 优化后
description: >
  分析 CSV 与表格类数据文件——计算汇总统计、添加派生列、生成图表，
  以及清洗脏数据。当用户手上有 CSV、TSV 或 Excel 文件，并想要探索、
  变换或可视化其中的数据时使用该 skill；即便用户没有明确提到
  “CSV” 或 “analysis”。
```

The improved description is more specific about what the skill does (summary stats, derived columns, charts, cleaning) and broader about when it applies (CSV, TSV, Excel; even without explicit keywords).

改进后的 description 在 skill *做什么*这件事上更具体（汇总统计、派生列、图表、清洗），在 skill *何时适用*这件事上更宽泛（CSV、TSV、Excel；即便没有明确关键词也算）。

## 8. Next steps - 后续步骤

Once your skill triggers reliably, you'll want to evaluate whether it produces good outputs. See [Evaluating skill output quality](/skill-creation/evaluating-skills) for how to set up test cases, grade results, and iterate.

一旦 skill 的触发已经足够可靠，你就会想评估它产出的质量是否也过关。关于如何搭建测试用例、给结果评分并进行迭代，请参见 [Evaluating skill output quality](/skill-creation/evaluating-skills)。
