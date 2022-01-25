# dispatch\_get\_main\_queue

原文链接：[https://developer.apple.com/documentation/dispatch/1452921-dispatch\_get\_main\_queue?language=objc](https://developer.apple.com/documentation/dispatch/1452921-dispatch\_get\_main\_queue?language=objc)

Returns the serial dispatch queue associated with the application’s main thread.
	
返回与 app 的主线程相关联的串行调度队列。

## Declaration 声明

	dispatch_queue_main_t dispatch_get_main_queue(void);

## Return Value 返回值

Returns the main queue. This queue is created automatically on behalf of the main thread before main is called.

返回主队列。在 main 函数被调用之前，该队列作为主线程被自动创建。

## Discussion 讨论

The system automatically creates the main queue and associates it with your application’s main thread. Your app uses one (and only one) of the following three approaches to invoke blocks submitted to the main queue:

系统自动创建主队列并将它关联到你的程序的主线程。你的程序使用下面三种方法中的一种（且只有一种）来调用提交到主队列的代码块。

- Calling [dispatch_main](https://developer.apple.com/documentation/dispatch/1452860-dispatch_main?language=objc)
- Calling [UIApplicationMain](https://developer.apple.com/documentation/uikit/1622933-uiapplicationmain?language=objc) (iOS) or [NSApplicationMain](https://developer.apple.com/documentation/appkit/1428499-nsapplicationmain?language=objc) (macOS)
- Using a [CFRunLoopRef](https://developer.apple.com/documentation/corefoundation/cfrunloopref?language=objc) on the main thread

As with the global concurrent queues, calls to [dispatch_suspend](https://developer.apple.com/documentation/dispatch/1452801-dispatch_suspend?language=objc), [dispatch_resume](https://developer.apple.com/documentation/dispatch/1452929-dispatch_resume?language=objc), [dispatch\_set\_context](https://developer.apple.com/documentation/dispatch/1452807-dispatch_set_context?language=objc), and the like have no effect when used with queues returned by this function.

就像全局并发队列一样，在使用这个方法返回的队列时，调用 [dispatch_suspend](https://developer.apple.com/documentation/dispatch/1452801-dispatch_suspend?language=objc), [dispatch_resume](https://developer.apple.com/documentation/dispatch/1452929-dispatch_resume?language=objc), [dispatch\_set\_context](https://developer.apple.com/documentation/dispatch/1452807-dispatch_set_context?language=objc) 等方法都是无效的。













