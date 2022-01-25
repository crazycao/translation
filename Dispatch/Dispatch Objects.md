# Dispatch Objects 调度对象

原文链接：[https://developer.apple.com/documentation/dispatch/dispatch_objects?language=objc](https://developer.apple.com/documentation/dispatch/dispatch_objects?language=objc)

The basic behaviors supported by all dispatch types.
	
所有调度类型支持的基本行为。

## Overview 概览

There are many types of dispatch objects, including `dispatch_queue_t`, `dispatch_group_t`, and `dispatch_source_t`. The base dispatch object interfaces allow you to manage memory, pause and resume execution, define object context, log task data, and more.

有许多种类的调度对象，包括 `dispatch_queue_t`，`dispatch_group_t` 和 `dispatch_source_t`。基础调度对象接口允许你管理内存、暂停和继续执行，定义对象上下文，给任务数据写日志等等。

By default, dispatch objects are declared as Objective-C types when you build them with an Objective-C compiler. This behavior lets you adopt ARC and enable memory leak checks by the static analyzer. It also lets you add your objects to Cocoa collections.

默认情况下，在使用 Objective-C 编译器构建调度对象时，它们被声明为 Objective-C 类型。这个行为允许你采用 ARC，并启用由静态分析器执行的内存泄漏检查。它也允许你添加你的对象到 Cocoa 集合。

## Topics 主题

### Activating, Suspending, and Resuming the Object 激活、挂起和恢复对象

- [dispatch_activate](./API/dispatch_activate.md)

	Activates the dispatch object.
	
	激活调度对象。

- [dispatch_suspend](./API/dispatch_suspend.md)

	Suspends the invocation of block objects on a dispatch object.
	
	挂起对调度对象上的 block 对象进行调用。

- [dispatch_resume](./API/dispatch_resume.md)

	Resumes the invocation of block objects on a dispatch object.
	
	恢复对调度对象上的 block 对象进行调用。

- [dispatch\_object\_t](./API/dispatch_object_t.md)

	A dispatch object.
	
	调度对象。

### Changing the Assigned Target Queue 更改分配的目标队列

- [dispatch\_set\_target\_queue](./API/dispatch_set_target_queue.md)

	Specifies the dispatch queue on which to perform work associated with the current object.
	
	指定一个调度队列，在该调度队列上执行与当前对象相关的工作。

### Updating Contextual Data 更新上下文数据

- [dispatch\_get\_context]()

	Returns the application-defined context of an object.
	
	返回一个对象的程序定义的上下文。

- [dispatch\_set\_context]()

	Associates an application-defined context with the object.
	
	将应用程序定义的上下文与对象关联。

### Managing Memory 管理内存

- [dispatch_retain]()

	Increments the reference count (the retain count) of a dispatch object.
	
	增加一个调度对象的引用计数（保留数）。

- [dispatch_release]()

	Decrements the reference count (the retain count) of a dispatch object.
	
	减少一个调度对象的引用计数（保留数）。

- [dispatch\_set\_finalizer\_f]()

	Sets the finalizer function for a dispatch object.
	
	设置调度对象的终结器函数。