# dispatch_resume

原文链接：[https://developer.apple.com/documentation/dispatch/1452929-dispatch_resume?language=objc](https://developer.apple.com/documentation/dispatch/1452929-dispatch_resume?language=objc)

Resumes the invocation of block objects on a dispatch object.
	
恢复对调度对象上的 block 对象进行调用。

## Declaration 声明

	void dispatch_resume(dispatch_object_t object);

## Parameters 参数

### object 对象

The object to be resumed. This parameter cannot be NULL.

要恢复的对象。参数不能为 NULL。

## Discussion 讨论

Calling this function decrements the suspension count of a suspended dispatch queue or dispatch event source object. While the count is greater than zero, the object remains suspended. When the suspension count returns to zero, any blocks submitted to the dispatch queue or any events observed by the dispatch source while suspended are delivered.

调用这个方法以减少挂起的调度队列或调度事件源对象的挂起数。当挂起数回到 0，所有提交到调度队列的 block 或者所有被挂起的调度源观察的事件都会执行。

With one exception, each call to dispatch_resume must balance a call to dispatch_suspend. New dispatch event source objects returned by dispatch_source_create have a suspension count of 1 and must be resumed before any events are delivered. This approach allows your application to fully configure the dispatch event source object prior to delivery of the first event. In all other cases, it is undefined to call dispatch_resume more times than dispatch_suspend, which would result in a negative suspension count.

每一个 `dispatch_resume` 的调用必须与 `dispatch_suspend` 的调用平衡，只有一个例外。由 `dispatch_source_create` 返回的新调度事件源对象的挂起数已经是 1，必须在所有事件执行之前就恢复。这个方法允许你的应用程序在执行第一个事件之前完全的配置调度事件源对象。在所有的其他情况下，调用 `dispatch_resume` 的次数比 `dispatch_suspend` 多都是不行的，这将导致负的挂起数。











