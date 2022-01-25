# dispatch\_set\_target\_queue

原文链接：[https://developer.apple.com/documentation/dispatch/1452989-dispatch\_set\_target\_queue?language=objc](https://developer.apple.com/documentation/dispatch/1452989-dispatch_set_target_queue?language=objc)

Specifies the dispatch queue on which to perform work associated with the current object.
	
指定一个调度队列，在该调度队列上执行与当前对象相关的工作。
	
## Declaration 声明

	void dispatch_set_target_queue(dispatch_object_t object, dispatch_queue_t queue);
	
## Parameters 参数

### object

The object to modify. This parameter cannot be NULL.

要修改的对象。该参数不能为空。

### queue

The new target queue for the object. The new queue is retained, and the previous target queue (if any) is released. Specify NULL if you want the system to provide a queue that is appropriate for the current object.

给该对象的新目标队列。新队列会被保留，而先前的目标度列（如果有）则会被释放。如果你想要系统为当前对象提供一个合适的队列，可以指定为 NULL。

## Discussion 讨论

The target queue determines the queue on which the object's finalizer is invoked. In addition, assigning a target queue affects how you deal with some dispatch objects, as described in the following table.

目标队列决定调用对象终结器的队列。另外，分配给目标队列会影响你对某些调度对象的处理，如下表所示：

|Dispatch object|Implications of assigning a target queue|
|:--:|:--:|
|Dispatch queues|Redirects all blocks from the current dispatch queue to the specified target queue. Use target queues to redirect work from several different queues onto a single queue. You might do this to minimize the total number of threads your app uses, while still preserving the execution semantics you need. The system doesn't allocate threads to the dispatch queue if it has a target queue, unless that target queue is a global concurrent queue. </br> 将当前调度队列中的所有 block 重定向到指定的目标队列。使用目标队列将工作从多个不同队列重定向到单个队列。您可以这样做以最小化应用程序使用的线程总数，同时仍保留所需的执行语义。如果调度队列已经有目标队列了，系统不会给它分配新的线程，除非该目标队列是一个全局并发队列。 </br> The target queue defines where blocks run, but it doesn't change the semantics of the current queue. Blocks submitted to a serial queue still execute serially, even if the underlying target queue is concurrent. In addition, you can't create concurrency where none exists. If a queue and its target queue are both serial, submitting blocks to both queues doesn't cause those blocks to run concurrently. The blocks still run serially in the order the target queue receives them. </br> 目标队列定义 block 的运行位置，但不会更改当前队列的语义。提交到串行队列的 block 仍然是串行执行的，即使底层目标队列是并发的。此外，您不能在不存在并发的情况下创建并发。如果一个队列及其目标队列都是串行的，那么向两个队列提交 block 不会导致这些 block 并发运行。block 仍然按照目标队列接收到它们的顺序串行运行。 </br> A dispatch queue inherits the minimum quality-of-service level from its target queue. </br> 调度队列从其目标队列继承最低服务质量级别。|
|Dispatch sources|Submits event handler and cancellation handler blocks to the specified target queue. </br> 将事件句柄 block 和取消句柄 block 提交到指定的目标队列。 |
|Dispatch I/O channels|Executes I/O operations on the specified target queue. The quality of service of the target queue affects the priority of the resulting I/O operations. For example, if the target queue's quality of service is `DispatchQoS.QoSClass.background`, then I/O operations performed by `dispatch_io_read` or `dispatch_io_write` on that queue are throttled when there is I/O contention.</br>对指定的目标队列执行I/O操作。目标队列的服务质量会影响最终I/O操作的优先级。例如，如果目标队列的服务质量是 `DispatchQoS.QoSClass.background`，那么当 I/O 竞争时，该队列上由 `dispatch_io_read` 或 `dispatch_io_write` 执行的 I/O 操作将受到限制。|

> **Important**
> 
> When setting up target queues, it is a programmer error to create cycles in the dispatch queue hierarchy. In other words, don't set the target of queue A to queue B and set the target of queue B to queue A.
> 
> **重要**
> 
> 当设置目标队列时，在调度队列层级中创建循环是一种编程错误。换句话说，不要将队列 A 的目标设置成队列 B，而把队列 B 的目标设置成队列 A。










