# dispatch_suspend

原文链接：[https://developer.apple.com/documentation/dispatch/1452801-dispatch_suspend?language=objc](https://developer.apple.com/documentation/dispatch/1452801-dispatch_suspend?language=objc)

Suspends the invocation of block objects on a dispatch object.
	
挂起对调度对象上的 block 对象进行调用。

## Declaration 声明

	void dispatch_suspend(dispatch_object_t object);

## Parameters 参数

### object 对象

The dispatch queue or dispatch source to suspend. (You cannot suspend other types of dispatch objects.) This parameter cannot be NULL.

要挂起的调度队列或调度源。（你不能暂停其他类型的调度对象。）参数不能为 NULL。

## Discussion 讨论

By suspending a dispatch object, your application can temporarily prevent the execution of any blocks associated with that object. The suspension occurs after completion of any blocks running at the time of the call. Calling this function increments the suspension count of the object, and calling `dispatch_resume` decrements it. While the count is greater than zero, the object remains suspended, so you must balance each `dispatch_suspend` call with a matching `dispatch_resume` call.

通过挂起调度对象，你的程序可以暂时阻止任何与该对象关联的 block 执行。要等调用时正在运行的 block 完成之后挂起才会发生。调用这个函数会增加该对象的挂起数，而调用 `dispatch_resume` 会减少挂起数。当这个数字大于 0 时，对象会保持挂起，因此你必须确保每一次 `dispatch_suspend` 调用和对应的 `dispatch_resume` 调用一样多。

Any blocks submitted to a dispatch queue or events observed by a dispatch source are delivered once the object is resumed.

一旦对象恢复，所有提交到调度队列的 block 或者被调度源观察的事件都会执行。

> **Important**
>
> It is a programmer error to release an object that is currently suspended, because suspension implies that there is still work to be done. Therefore, always balance calls to this method with a corresponding call to `dispatch_resume` before disposing of the object. The behavior when releasing the last reference to a dispatch object while it is in a suspended state is undefined.
> 
> **重要**
> 
> 如果要释放一个当前被挂起的对象，程序员就犯错误了，因为挂起意味着还有工作要做。因此，在处理对象之前，请始终在该方法的调用和相应的 `dispatch_resume` 调用之间保持平衡。释放一个处在挂起状态的调度对象的最后一个引用，这个行为是未定义的。











