# Dispatch Work Item 调度工作项目

原文链接：[https://developer.apple.com/documentation/dispatch/dispatch\_work\_item?language=objc](https://developer.apple.com/documentation/dispatch/dispatch_work_item?language=objc)

The work you want to perform, encapsulated in a way that lets you attach a completion handle or execution dependencies.
	
你想要执行的工作，以允许附加完成句柄或执行依赖项的方式封装。
	
## Overview 概览

A dispatch work item encapsulates work to be performed on a dispatch queue or within a dispatch group. You can also use a work item as a dispatch source event, registration, or cancellation handler.

调度工作项目封装了在调度队列上或在调度组里执行的工作。你也可以使用工作项目作为调度源事件、注册或取消句柄。

## Topics 主题

### Creating a Work Item 创建工作项目

- [dispatch\_block\_create]()

	Creates a new dispatch block on the heap using an existing block and the given flags.

	使用现有的 block 和给定的 flag 在堆上创建一个新的调度 block。


- [dispatch\_block\_create\_with\_qos\_class]()

	Creates a new dispatch block from an existing block and the given flags, and assigns it the specified quality-of-service class and relative priority.
	
	从一个现有的 block 和指定的 flag 创建一个新的调度 block，并给它分配指定的服务质量类和相关的优先级。

- [dispatch\_block\_t]()

	The prototype of blocks submitted to dispatch queues, which take no arguments and have no return value.
	
	提交到调度队列的 block 原型，没有参数也没有返回值。

- [dispatch\_block\_flags\_t]()

	Flags to pass to the `dispatch_block_create` and `dispatch_block_create_with_qos_class` functions.
	
	传给 `dispatch_block_create` 和 `dispatch_block_create_with_qos_class` 函数的 flag。

### Scheduling Work Items 安排工作项目

- [dispatch\_block\_perform]()

	Creates, synchronously executes, and releases a dispatch block from the specified block and flags.
	
	从指定的 block 和 flag 创建、同步执行和释放一个调度 block。
	
### Adding a Completion Handler 添加一个完成句柄

- [dispatch\_block\_notify]()

	Schedules a notification block to be submitted to a queue when the execution of a specified dispatch block has completed.
	
	安排一个当指定分派块的执行完成时将要要提交到队列的通知 block 。
	
### Delaying Execution of a Work Item 延迟执行工作项目

- [dispatch\_block\_wait]()

	Waits synchronously until execution of the specified dispatch block has completed or until the specified timeout has elapsed.
	
	同步等待，直到指定的调度 block 已经执行完成，或者直到指定的超时时间已过。
	
### Canceling a Work Item 取消一个工作项目

- [dispatch\_block\_cancel]()

	Cancels the specified dispatch block asynchronously.
	
	异步的取消指定的调度 block。

- [dispatch\_block\_testcancel]()

	Tests whether the given dispatch block has been canceled.
	
	测试给定的调度 block 是否已经被取消。
	
