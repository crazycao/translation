# dispatch\_get\_global\_queue

原文链接：[https://developer.apple.com/documentation/dispatch/1452927-dispatch\_get\_global\_queue?language=objc](https://developer.apple.com/documentation/dispatch/1452927-dispatch_get_global_queue?language=objc)

Returns a system-defined global concurrent queue with the specified quality-of-service class.

返回一个系统定义的具有指定服务质量类的全局并发队列。

## Declaration 声明

	dispatch_queue_global_t dispatch_get_global_queue(intptr_t identifier, uintptr_t flags);
	
## Parameters 参数

### identifier 标识符

The quality of service you want to give to tasks executed using this queue. Quality-of-service helps determine the priority given to tasks executed by the queue. You may specify the values QOS\_CLASS\_USER\_INTERACTIVE, QOS\_CLASS\_USER\_INITIATED, QOS\_CLASS\_UTILITY, or QOS\_CLASS\_BACKGROUND. Queues that handle user-interactive or user-initiated tasks have a higher priority than tasks meant to run in the background.

在使用这个队列执行任务时你想要给定的服务质量。服务质量决定了由这个队列执行的任务的优先级。你可以指定这个值为 QOS\_CLASS\_USER\_INTERACTIVE, QOS\_CLASS\_USER\_INITIATED, QOS\_CLASS\_UTILITY, 或 QOS\_CLASS\_BACKGROUND。处理用户交互或用户启动的任务的队列拥有比打算在后台运行的任务更高的优先级。

In OS X 10.9 or earlier, you can specify one of the dispatch queue priority values, which are found in [dispatch\_queue\_priority\_t](https://developer.apple.com/documentation/dispatch/dispatch_queue_priority_t?language=objc). These values map to an appropriate quality-of-service class.

在 OS X 10.9 及以前的版本中，你可以指定一个调度队列优先级的值，参见 [dispatch\_queue\_priority\_t](https://developer.apple.com/documentation/dispatch/dispatch_queue_priority_t?language=objc)。这些值映射到合适的服务质量类。

### flags 标记

Flags that are reserved for future use. Always specify 0 for this parameter.

标记是为将来使用而准备的。这个参数通常被设置为 0。

## Return Value 返回值

The requested global concurrent queue.

请求的全局并发队列。

## Discussion 讨论

This function returns a queue suitable for executing tasks with the specified quality-of-service level. Calls to the [dispatch_suspend](https://developer.apple.com/documentation/dispatch/1452801-dispatch_suspend?language=objc), [dispatch_resume](https://developer.apple.com/documentation/dispatch/1452929-dispatch_resume?language=objc) and [dispatch\_set\_context](https://developer.apple.com/documentation/dispatch/1452807-dispatch_set_context?language=objc) functions have no effect on the returned queues.

这个方法返回一个适合于按指定服务质量等级执行任务的队列。在返回的队列中调用 [dispatch_suspend](https://developer.apple.com/documentation/dispatch/1452801-dispatch_suspend?language=objc), [dispatch_resume](https://developer.apple.com/documentation/dispatch/1452929-dispatch_resume?language=objc), [dispatch\_set\_context](https://developer.apple.com/documentation/dispatch/1452807-dispatch_set_context?language=objc) 等方法都是无效的。

Tasks submitted to the returned queue are scheduled concurrently with respect to one another.

提交到返回的队列中的任务相互之间被并行的调度。










