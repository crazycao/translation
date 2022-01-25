# Dispatch 调度

原文链接：[https://developer.apple.com/documentation/dispatch?language=objc](https://developer.apple.com/documentation/dispatch?language=objc)

Execute code concurrently on multicore hardware by submitting work to dispatch queues managed by the system.

通过把任务提交到系统管理的调度队列，在多核硬件上并发的执行代码。

## Overview 概览

Dispatch, also known as Grand Central Dispatch (GCD), contains language features, runtime libraries, and system enhancements that provide systemic, comprehensive improvements to the support for concurrent code execution on multicore hardware in macOS, iOS, watchOS, and tvOS.

调度，也被称为“大中心调度”（GCD），包含语言特性，runtime 库和系统增强。系统增强提供了系统的、全面的改进以支持在 macOS、iOS、watchOS 和 tvOS 的多核硬件上的代码并发执行。

The BSD subsystem, Core Foundation, and Cocoa APIs have all been extended to use these enhancements to help both the system and your application to run faster, more efficiently, and with improved responsiveness. Consider how difficult it is for a single application to use multiple cores effectively, let alone to do it on different computers with different numbers of computing cores or in an environment with multiple applications competing for those cores. GCD, operating at the system level, can better accommodate the needs of all running applications, matching them to the available system resources in a balanced fashion.

BSD 子系统、Core Foundation 和 Cocoa API 全都做了扩展，以使用这些增强，来帮助系统和你的程序运行得更快更高效，以及响应能力的提升。考虑一下，让单个应用有效的利用多个内核有多么困难，更不用说在有不同核数的计算机上做这件事，或者在多个程序竞争这些内核的环境下。GCD，运行在系统级别，可以更好的满足所有正在运行的程序的需求，以均衡的模式将它们与可用的系统资源进行匹配。

### Dispatch Objects and ARC 调度对象和 ARC

When you build your app using the Objective-C compiler, all dispatch objects are Objective-C objects. As such, when automatic reference counting (ARC) is enabled, dispatch objects are retained and released automatically, just like any other Objective-C object. When ARC is not enabled, use the `dispatch_retain` and `dispatch_release` functions (or Objective-C semantics) to retain and release your dispatch objects. You cannot use the Core Foundation retain and release functions.

当你使用 Objective-C 编译器构建你的程序时，所有的调度对象都是 Objective-C 对象。因此，当自动引用计数（ARC）启用时，调度对象会自动的保留和释放，就像其他 Objectiv-C 对象一样。当 ARC 未启用时，使用 `dispatch_retain` 和 `dispatch_release` 方法（或者 Objective-C 语义）来保留和释放你的调度对象。不能使用 Core Foundation 的保留和释放方法。

If you need to use retain and release semantics in an ARC-enabled app with a later deployment target (for maintaining compatibility with existing code), you can disable Objective-C-based dispatch objects by adding `-DOS_OBJECT_USE_OBJC=0` to your compiler flags.

如果你需要在一个开启了 ARC 的 app 中使用保留和释放语义，而又要在稍后的部署中保持与现有代码的兼容性，你可以通过在你的编译器标识中添加 `-DOS_OBJECT_USE_OBJC=0` 以禁用基于 Objective-C 的调度对象。

## Topics 主题

### Queues and Tasks 队列和任务

- [dispatch\_get\_main\_queue](./API/dispatch_get_main_queue.md)

	Returns the serial dispatch queue associated with the application’s main thread.
	
	返回与 app 的主线程相关联的串行调度队列。
	
- [dispatch\_get\_global\_queue](./API/dispatch_get_global_queue.md)

	Returns a system-defined global concurrent queue with the specified quality-of-service class.
	
	返回一个系统定义的具有指定服务质量类的全局并发队列。

- [Dispatch Queue 调度队列](./Dispatch Queue.md)

	An object that manages the execution of tasks serially or concurrently on your app's main thread or on a background thread.
	
	一个管理任务执行的对象，它可以控制任务在你的 APP 的主线程或后台线程上串行或并行的执行。
	
- [Dispatch Work Item 调度工作项目](./Dispatch Work Item.md)

	The work you want to perform, encapsulated in a way that lets you attach a completion handle or execution dependencies.
	
	你想要执行的工作，以允许附加完成句柄或执行依赖项的方式封装。
	
- [Dispatch Group 调度组](./Dispatch Group.md)

	A group of tasks that you monitor as a single unit.
	
	作为一个独立单元来看待的一组任务。

### Quality of Service 服务质量

- [dispatch\_qos\_class\_t](https://developer.apple.com/documentation/dispatch/dispatch_qos_class_t?language=objc)

	Quality-of-service classes that specify the priorities for executing tasks.
	
	指定执行任务的优先级的服务质量类。
	
- [dispatch\_queue\_priority\_t](https://developer.apple.com/documentation/dispatch/dispatch_queue_priority_t?language=objc)

	The execution priority for tasks in a global concurrent queue.
	
	在全局并发队列中的任务的执行优先级。
	
### System Event Monitoring 系统事件监视器

- [Dispatch Source 调度源](./Dispatch Source.md)

	An object that coordinates the processing of specific low-level system events, such as file-system events, timers, and UNIX signals.
	
	协调特定低级系统事件（如文件系统事件、计时器和UNIX信号）处理的对象。
	
- [Dispatch I/O 调度I/O](https://developer.apple.com/documentation/dispatch/dispatch_i_o?language=objc)

	An object that manages operations on a file descriptor using either stream-based or random-access semantics.
	
	管理 使用基于流或随机访问语义的 文件描述符的操作 的对象。
	
- [Dispatch Data 调度数据](https://developer.apple.com/documentation/dispatch/dispatch_data?language=objc)

	An object that manages a memory-based data buffer and exposes it as a contiguous block of memory.
	
	管理基于内存的数据缓冲区并将其作为连续内存块暴露出来的对象。

### Task Synchronization 任务同步

- [Dispatch Semaphore 调度信号量](https://developer.apple.com/documentation/dispatch/dispatch_semaphore?language=objc)

	An object that controls access to a resource across multiple execution contexts through use of a traditional counting semaphore.
	
	一种对象，通过使用传统的计数信号量来控制对多个执行上下文中资源的访问。

- [Dispatch Barrier 调度栅栏](https://developer.apple.com/documentation/dispatch/dispatch_barrier?language=objc)

	A synchronization point for tasks executing in a concurrent dispatch queue.

	在并发调度队列中执行的任务的同步点。
	
### Time Constructs 时间结构

- [dispatch_time](https://developer.apple.com/documentation/dispatch/1420519-dispatch_time?language=objc)

	Creates a `dispatch_time_t` relative to the default clock or modifies an existing `dispatch_time_t`.
	
	创建一个与默认时钟有关的 `dispatch_time_t` 或者修改一个已存在的 `dispatch_time_t`。
	
- [dispatch_walltime](https://developer.apple.com/documentation/dispatch/1420517-dispatch_walltime?language=objc)

	Creates a `dispatch_time_t` using an absolute time according to the wall clock.
	
	使用来自挂钟的绝对时间创建一个 `dispatch_time_t`。
	
- [dispatch\_time\_t](https://developer.apple.com/documentation/dispatch/dispatch_time_t?language=objc)

	An abstract representation of time.
	
	时间的抽象表达。
	
- [DISPATCH\_WALLTIME\_NOW](https://developer.apple.com/documentation/dispatch/2963138-anonymous/dispatch_walltime_now?language=objc)

	The current time.
	
	当前时间。
	
### Dispatch Objects 调度对象

- [Dispatch Objects 调度对象](./Dispatch Objects.md)

	The basic behaviors supported by all dispatch types.
	
	所有调度类型支持的基本行为。


