# Dispatch Group 调度组

原文链接：[https://developer.apple.com/documentation/dispatch/dispatch_group?language=objc](https://developer.apple.com/documentation/dispatch/dispatch_group?language=objc)

A group of tasks that you monitor as a single unit.
	
作为一个独立单元来看待的一组任务。
		
## Overview 概览

Groups allow you to aggregate a set of tasks and synchronize behaviors on the group. You attach multiple blocks to a group and schedule them for asynchronous execution on the same queue or different queues. When all blocks finish executing, the group executes its completion handler. You can also wait synchronously for all blocks in the group to finish executing.

调度组允许你聚合一个任务集合，并同步整个组的行为。你把多个 block 添加到一个组，并异步的安排他们在同一个队列或不同的队列中执行。当所有的 block 执行完成时，调度组会执行它的完成句柄。你也可以同步的等待组里的所有 block 执行完成。

## Topics 主题

### Creating a Dispatch Group 创建调度组

- [dispatch\_group\_create]()

	Creates a new group to which you can assign block objects.
	
	创建一个新的组，你可以分配 block 对象到该组。

- [dispatch\_group\_t]()

	A group of block objects submitted to a queue for asynchronous invocation.
	
	提交到队列以进行异步调用的一组 block 对象。

- [OS\_dispatch\_group]()

### Adding Work to the Group 添加工作到组

- [dispatch\_group\_async]()

	Schedules a block asynchronously for execution and simultaneously associates it with the specified dispatch group.
	
	安排一个 block 异步执行，同时将它与指定的调度组关联。

- [dispatch\_group\_async\_f]()

	Submits an application-defined function to a dispatch queue and associates it with the specified dispatch group.
	
	提交一个程序定义的方法到调度队列，并将其与指定的调度组关联。

### Adding a Completion Handler 添加完成句柄

- [dispatch\_group\_notify]()

	Schedules a block object to be submitted to a queue when a group of previously submitted block objects have completed.
	
	定制一个将提交到队列的 block 对象，当组中之前提交的 block 对象都已经完成时会提交该对象。

- [dispatch\_group\_notify\_f]()

	Schedules an application-defined function to be submitted to a queue when a group of previously submitted block objects have completed.
	
	定制一个将提交到队列的程序定义的函数，当组中之前提交的 block 对象都已经完成时会提交该函数。

### Waiting for Tasks to Finish Executing 等待任务完成执行

- [dispatch\_group\_wait]()

	Waits synchronously for the previously submitted block objects to finish; returns if the blocks do not complete before the specified timeout period has elapsed.
	
	同步等待之前提交的 block 对象完成；如果 block 没有在指定的超时时间内完成，也会返回。

### Updating the Group Manually 手动更新组

- [dispatch\_group\_enter]()

	Explicitly indicates that a block has entered the group.
	
	明确的指出，一个 block 已经进入该组。

- [dispatch\_group\_leave]()

	Explicitly indicates that a block in the group finished executing.
	
	明确的指出，组里的一个 block 已经完成执行。
	
