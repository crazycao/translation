# Pipeline Best Practices 流水线最佳实践


原文地址：[https://www.jenkins.io/doc/book/pipeline/pipeline-best-practices/](https://www.jenkins.io/doc/book/pipeline/pipeline-best-practices/) 

> This guide provides a small selection of best practices for pipelines and points out the most common mistakes.
> 
> 本指南精选了一系列关于流水线的最佳实践，并指出了最常见的错误。

The goal is to point pipeline authors and maintainers towards patterns that result in better Pipeline execution and away from pitfalls they might otherwise not be aware of. This guide is not meant to be an exhaustive list of all possible Pipeline best practices but instead to provide a number of specific examples useful in tracking down common practices. Use it as a "do this" generally and not as an incredibly detailed "how-to".

本文档旨在为流水线的编写者和维护者指明能提升流水线执行效果的实践模式，同时帮助他们避开那些可能未曾察觉的陷阱。本指南并非要罗列所有可能的流水线最佳实践，而是提供若干具体示例，助力排查常见问题。请将其视为一份通用的 “建议做法” 参考，而非详尽至极的 “操作指南”。

This guide is arranged by area, guideline, then listing specific examples.

本指南按 “领域→准则→具体示例” 的结构编排。

# 1 General 通用准则

## 1.1 Making sure to use Groovy code in Pipelines as glue 确保在流水线中仅将 Groovy 代码用作 “粘合逻辑”

Use Groovy code to connect a set of actions rather than as the main functionality of your Pipeline. In other words, instead of relying on Pipeline functionality (Groovy or Pipeline steps) to drive the build process forward, use single steps (such as `sh`) to accomplish multiple parts of the build. Pipelines, as their complexity increases (the amount of Groovy code, number of steps used, etc.), require more resources (CPU, memory, storage) on the controller. Think of Pipeline as a tool to accomplish a build rather than the core of a build.

应使用 Groovy 代码连接一系列操作，而非将其作为流水线的核心功能。换句话说，不要依赖流水线功能（Groovy 代码或流水线步骤）推动构建过程，而应使用单一步骤（如 `sh` 步骤）完成构建的多个环节。随着流水线复杂度的增加（Groovy 代码量、使用的步骤数量等），控制器需要消耗更多资源（CPU、内存、存储）。请将流水线视为实现构建的工具，而非构建的核心本身。

Example: Using a single Maven build step to drive the build through its build/test/deploy process.

示例：使用单个 Maven 构建步骤，贯穿构建、测试、部署的全流程以驱动构建执行。

## 1.2 Running shell scripts in Jenkins Pipeline 在 Jenkins 流水线中运行 Shell 脚本

Using a shell script within Jenkins Pipeline can help simplify builds by combining multiple steps into a single stage. The shell script also allows users to add or update commands without having to modify each step or stage separately.

在 Jenkins 流水线内使用 Shell 脚本，可将多个步骤整合到单个阶段（stage），从而帮助简化构建流程。此外，通过 Shell 脚本，用户添加或更新命令时，无需分别修改每个步骤或阶段。

This video reviews using a shell script in Jenkins Pipeline and the benefits it provides.

本视频将介绍如何在 Jenkins 流水线中使用 Shell 脚本，以及该方式所带来的优势。

[https://youtu.be/mbeQWBNaNKQ](https://youtu.be/mbeQWBNaNKQ)

## 1.3 Avoiding complex Groovy code in Pipelines 在流水线中避免使用复杂的 Groovy 代码

For a Pipeline, Groovy code always executes on controller which means using controller resources(memory and CPU). Therefore, it is critically important to reduce the amount of Groovy code executed by Pipelines (this includes any methods called on classes imported in Pipelines). The following are the most common example Groovy methods to avoid using:

对于流水线而言，Groovy 代码始终在控制器上执行，这意味着它会占用控制器的资源（内存和 CPU）。因此，减少流水线执行的 Groovy 代码量（包括在流水线中导入的类所调用的任何方法）至关重要。以下是最常见的、应避免使用的 Groovy 方法示例：

1. **JsonSlurper**: This function (and some other similar ones like `XmlSlurper` or `readFile`) can be used to read from a file on disk, parse the data from that file into a JSON object, and inject that object into a Pipeline using a command like `JsonSlurper().parseText(readFile("$LOCAL_FILE"))`. This command loads the local file into memory on the controller twice and, if the file is very large or the command is executed frequently, will require a lot of memory.

	**JsonSlurper**: 该函数（以及其他类似函数，如 `XmlSlurper` 或 `readFile`）可用于读取磁盘上的文件，将文件中的数据解析为 JSON 对象，并通过 `JsonSlurper().parseText(readFile("$LOCAL_FILE"))` 这类命令将该对象注入到流水线中。此命令会将本地文件两次加载到控制器的内存中，若文件体积很大或该命令执行频率较高，将消耗大量内存。

	- Solution: Instead of using `JsonSlurper`, use a shell step and return the standard out. This shell would look something like this: `def JsonReturn = sh label: '', returnStdout: true, script: 'echo "$LOCAL_FILE"| jq "$PARSING_QUERY"'`. This will use agent resources to read the file and the `$PARSING_QUERY` will help parse down the file into a smaller size.
	- 解决方案：不要使用 `JsonSlurper`，而是使用 shell 步骤并返回标准输出。对应的 shell 命令大致如下：`def JsonReturn = sh label: '', returnStdout: true, script: 'echo "$LOCAL_FILE"| jq "$PARSING_QUERY"'`。这种方式会利用代理（agent）的资源读取文件，且 `$PARSING_QUERY` 可帮助将文件解析为更小的规模。

2. **HttpRequest**: Frequently this command is used to grab data from an external source and store it in a variable. This practice is not ideal because not only is that request coming directly from the controller (which could give incorrect results for things like HTTPS requests if the controller does not have certificates loaded), but also the response to that request is stored twice.

	**HttpRequest**: 该命令常被用于从外部源获取数据并存储到变量中。这种做法并不理想，原因有二：一是请求直接从控制器发起（若控制器未加载证书，对于 HTTPS 请求等场景可能会返回错误结果）；二是请求的响应会被存储两次。

	- Solution: Use a shell step to perform the HTTP request from the agent, for example using a tool like `curl` or `wget`, as appropriate. If the result must be later in the Pipeline, try to filter the result on the agent side as much as possible so that only the minimum required information must be transmitted back to the Jenkins controller.
	- 解决方案：使用 shell 步骤通过代理执行 HTTP 请求，例如根据需求使用 `curl` 或 `wget` 等工具。若流水线后续需要该请求结果，应尽可能在代理端对结果进行过滤，仅将最低必要的信息传输回 Jenkins 控制器。

## 1.4 Reducing repetition of similar Pipeline steps 减少流水线中相似步骤的重复

Combine Pipeline steps into single steps as often as possible to reduce the amount of overhead caused by the Pipeline execution engine itself. For example, if you run three shell steps back-to-back, each of those steps has to be started and stopped, requiring connections and resources on the agent and controller to be created and cleaned up. However, if you put all of the commands into a single shell step, then only a single step needs to be started and stopped.

尽可能将流水线步骤整合为单一步骤，以减少流水线执行引擎自身产生的开销。例如，若连续执行三个 shell 步骤，每个步骤都需要启动和停止，这会导致代理和控制器上的连接与资源频繁创建和清理。但如果将所有命令整合到一个 shell 步骤中，则只需启动和停止一次。

Example: Instead of creating a series of `echo` or `sh` steps, combine them into a single step or script.

示例：不要创建一系列 `echo` 或 `sh` 步骤，而是将它们整合为单个步骤或脚本。

## 1.5 Avoiding calls to Jenkins.getInstance 避免调用 Jenkins.getInstance

Using `Jenkins.instance` or its accessor methods in a Pipeline or shared library indicates a code misuse within that Pipeline/shared library. Using Jenkins APIs from an unsandboxed shared library means that the shared library is both a shared library and a kind of Jenkins plugin. You need to be very careful when interacting with Jenkins APIs from a Pipeline to avoid severe security and performance issues. If you must use Jenkins APIs in your build, the recommended approach is to create a minimal plugin in Java that implements a safe wrapper around the Jenkins API you want to access using Pipeline’s Step API. Using Jenkins APIs from a sandboxed Jenkinsfile directly means that you have probably had to whitelist methods that allow sandbox protections to be bypassed by anyone who can modify a Pipeline, which is a significant security risk. The whitelisted method is run as the System user, having overall admin permissions, which can lead to developers possessing higher permissions than intended.

在流水线或共享库中使用 `Jenkins.instance` 及其访问器方法，表明该流水线/共享库中存在代码误用问题。从非沙箱（unsandboxed）共享库中调用 Jenkins API，意味着该共享库既是共享库，也是一种 Jenkins 插件。在流水线中与 Jenkins API 交互时需格外谨慎，以避免严重的安全和性能问题。若必须在构建中使用 Jenkins API，推荐的做法是用 Java 开发一个轻量级插件，通过流水线的 Step API 为想要访问的 Jenkins API 实现一个安全的包装器。直接从沙箱（sandboxed）Jenkinsfile 中调用 Jenkins API，通常意味着你必须将某些方法加入白名单 —— 而这些方法可能会让任何能修改流水线的人绕过沙箱保护，这存在重大安全风险。被加入白名单的方法会以系统用户（System user）身份运行，拥有全局管理员权限，可能导致开发者获得超出预期的权限。

Solution: The best solution would be to work around the calls being made, but if they must be done then it would be better to implement a Jenkins plugin which is able to gather the data needed.

解决方案：最佳方案是避免进行此类调用；若确实必须执行，则最好开发一个 Jenkins 插件来获取所需数据。

## 1.6 Cleaning up old Jenkins builds 清理旧的 Jenkins 构建记录

As a Jenkins administrator, removing old or unwanted builds keeps the Jenkins controller running efficiently. When you do not remove older builds, there are less resources for more current and relevant builds. This video reviews using the `buildDiscarder` directive in individual Pipeline jobs. The video also reviews the process to keep specific historical builds.

作为 Jenkins 管理员，删除旧的或无用的构建记录，可确保 Jenkins 控制器高效运行。若不清理旧构建记录，当前和重要构建可使用的资源会减少。本视频将介绍如何在单个流水线任务中使用 `buildDiscarder` 指令，以及保留特定历史构建记录的流程。

[How to clean up old Jenkins builds](https://youtu.be/_Z7BlaTTGlo)

# 2 Using shared libraries 使用共享库

## 2.1 Do not override built-in Pipeline steps 不要重写流水线的内置步骤

Wherever possible stay away from customized/overwritten Pipeline steps. Overriding built-in Pipeline Steps is the process of using shared libraries to overwrite the standard Pipeline APIs like `sh` or `timeout`. This process is dangerous because the Pipeline APIs can change at any time causing custom code to break or give different results than expected. When custom code breaks because of Pipeline API changes, troubleshooting is difficult because even if the custom code has not changed, it may not work the same after an API update. So even if custom code has not changed, that does not mean after an API update it will keep working the same. Lastly, because of the ubiquitous use of these steps throughout Pipelines, if something is coded incorrectly/inefficiently the results can be catastrophic to Jenkins.

尽可能避免使用自定义/重写的流水线步骤。重写流水线内置步骤，指通过共享库覆盖 `sh` 或 `timeout` 等标准流水线 API 的过程。这种做法存在风险，因为流水线 API 可能随时变更，导致自定义代码失效或返回不符合预期的结果。当流水线 API 变更导致自定义代码失效时，问题排查会十分困难 —— 即使自定义代码未做修改，API 更新后其运行效果也可能发生变化。此外，由于这些步骤在各类流水线中广泛使用，若自定义代码存在错误或效率问题，可能会给 Jenkins 带来灾难性后果。

## 2.2 Avoiding large global variable declaration files 避免使用大型全局变量声明文件

Having large variable declaration files can require large amounts of memory for little to no benefit, because the file is loaded for every Pipeline whether the variables are needed or not. Creating small variable files that contain only variables relevant to the current execution is recommended.

大型变量声明文件会占用大量内存，却几乎没有收益；因为无论流水线是否需要这些变量，该文件都会在每个流水线启动时加载。建议创建小型变量文件，仅包含与当前执行流程相关的变量。

## 2.3 Avoiding very large shared libraries 避免使用过大的共享库

Using large shared libraries in Pipelines requires checking out a very large file before the Pipeline can start and loading the same shared library per job that is currently executing, which can lead to increased memory overhead and slower execution time.

在流水线中使用过大的共享库，需要在流水线启动前检出（check out）一个体积庞大的文件，且每个正在执行的任务都会加载相同的共享库，这会导致内存开销增加，执行速度变慢。

# 3 Answering additional FAQs 其他常见问题解答

## 3.1 Dealing with Concurrency in Pipelines 处理流水线中的并发问题

Try not to share workspaces across multiple Pipeline executions or multiple distinct Pipelines. This practice can lead to either unexpected file modification within each Pipeline or workspace renaming.

不要在多个流水线执行流程或多个独立流水线之间共享工作空间（workspace）。这种做法可能导致每个流水线中出现意外的文件修改，或引发工作空间重命名问题。

Ideally, shared volumes/disks are mounted in a separate place and the files are copied from that place to the current workspace. Then when the build is done the files can be copied back if there were updates done.

理想情况下，共享卷/磁盘应挂载在独立位置，文件需从该位置复制到当前工作空间；构建完成后，若文件有更新，可再复制回共享位置。

Build in distinct containers which create needed resources from scratch(cloud-type agents work great for this). Building these containers will ensure that the build process begins at the start every time and is easily repeatable. If building containers will not work, disable concurrency on the Pipeline or use the Lockable Resources Plugin to lock the workspace when it is running so that no other builds can use it while it is locked. WARNING: Disabling concurrency or locking the workspace when it is running can cause Pipelines to become blocked when waiting on resources if those resources are arbitrarily locked.

建议在独立容器中进行构建，容器会从头创建所需资源（云类型的代理对此尤为适用）。这种构建方式能确保每次构建流程都从初始状态开始，且易于重复执行。若无法使用容器构建，可禁用流水线的并发功能，或使用 “可锁定资源插件”（Lockable Resources Plugin）在工作空间运行时对其进行锁定，防止其他构建在锁定期间使用该工作空间。警告：禁用并发功能或在工作空间运行时锁定，若资源被随意锁定，可能导致流水线因等待资源而阻塞。

Also, be aware that both of these methods have slower time to results of builds than using unique resources for each job

另需注意，与为每个任务分配独立资源相比，上述两种方法都会导致构建结果的生成时间延长。

## 3.2 Avoiding NotSerializableException 避免 NotSerializableException 异常

Pipeline code is CPS-transformed so that Pipelines are able to resume after a Jenkins restart. That is, while the pipeline is running your script, you can shut down Jenkins or lose connectivity to an agent. When it comes back, Jenkins remembers what it was doing and your pipeline script resumes execution as if it were never interrupted. A technique known as "continuation-passing style (CPS)" execution plays a key role in resuming Pipelines. However, some Groovy expressions do not work correctly as a result of CPS transformation.

流水线代码会经过 CPS 转换（Continuation-Passing Style 转换），确保 Jenkins 重启后流水线能恢复执行。也就是说，在流水线运行过程中，即使关闭 Jenkins 或断开与代理的连接，重启/重连后 Jenkins 仍能记住之前的执行状态，流水线脚本会像未被中断一样继续执行。其中，“延续传递风格（CPS）” 执行技术是流水线能够恢复的关键。但受 CPS 转换影响，部分 Groovy 表达式可能无法正常工作。

Under the hood, CPS relies on being able to serialize the pipeline’s current state along with the remainder of the pipeline to be executed. This means that using Objects in the pipeline that are not serializable will trigger a NotSerializableException to be thrown when the pipeline attempts to persist its state.

从底层原理来看，CPS 依赖于将流水线的当前状态以及待执行的剩余流程序列化（serialize）。这意味着，若流水线中使用了不可序列化的对象，当流水线尝试持久化其状态时，会抛出 NotSerializableException 异常。

See [Pipeline CPS method mismatches](https://www.jenkins.io/redirect/pipeline-cps-method-mismatches) for more details and some examples of things that may be problematic.

有关可能存在问题的场景及示例，可参考《[Pipeline CPS 方法错配](https://www.jenkins.io/redirect/pipeline-cps-method-mismatches)》文档。

Below will cover techniques to ensure the pipeline can function as expected.

以下将介绍确保流水线正常运行的相关技巧：

### 3.2.1 Ensure Persisted Variables Are Serializable 确保持久化的变量可序列化

Local variables are captured as part of the pipeline’s state during serialization. This means that storing non-serializable objects in variables during pipeline execution will result in a NotSerializableException to be thrown.

序列化过程中，局部变量会作为流水线状态的一部分被捕获。这意味着，若在流水线执行期间将不可序列化的对象存储到变量中，会触发 NotSerializableException 异常。

### 3.2.2 Do not assign non-serializable objects to variables 不要将不可序列化的对象赋值给变量

One strategy to make use of non-serializable objects to always infer their value "just-in-time" instead of calculating their value and storing that value in a variable.

若需使用不可序列化的对象，建议采用 “即时（just-in-time）” 推导值的策略，而非计算值后将其存储到变量中。

### 3.2.3 Using @NonCPS 使用 @NonCPS 注解

If necessary, you can use the `@NonCPS` annotation to disable the CPS transformation for a specific method whose body would not execute correctly if it were CPS-transformed. Just be aware that this also means the Groovy function will have to restart completely since it is not transformed.

若有必要，可使用 `@NonCPS` 注解为特定方法禁用 CPS 转换 —— 某些方法若经过 CPS 转换，其内部逻辑可能无法正常执行。但需注意，这也意味着该 Groovy 函数无法恢复执行，若中断则需从头重新运行。

> Asynchronous Pipeline steps (such as `sh` and `sleep`) are always CPS-transformed, and may not be used inside of a method annotated with `@NonCPS`. In general, you should avoid using pipeline steps inside of methods annotated with `@NonCPS`
>
> 异步流水线步骤（如 `sh` 和 `sleep`）始终会经过 CPS 转换，不能在标注了 `@NonCPS` 的方法内部使用。总体而言，应避免在 `@NonCPS` 标注的方法中使用流水线步骤。

### 3.2.4 Pipeline Durability 流水线持久性

It is noteworthy that changing the pipeline’s durability can result in `NotSerializableException` not being thrown where they otherwise would have been. This is because decreasing the pipeline’s durability through PERFORMANCE_OPTIMIZED means that the pipeline’s current state is persisted significantly less frequently. Therefore, the pipeline never attempts to serialize the non-serializable values and as such, no exception is thrown.

值得注意的是，修改流水线的持久性设置，可能导致原本会抛出的 `NotSerializableException` 异常不再抛出。原因是：将流水线持久性设置为 “性能优化模式”（PERFORMANCE_OPTIMIZED）会大幅降低流水线当前状态的持久化频率，流水线因此不会尝试对不可序列化的值进行序列化，进而不会抛出异常。

> This note exists to inform users as to the root cause of this behavior. It is **not recommended** that the Pipeline’s durability setting be set to Performance Optimized purely to avoid serializability issues.
> 
> 此处说明旨在告知用户该行为的根本原因，**不建议**仅为避免序列化问题而将流水线的持久性设置为 “性能优化模式”。