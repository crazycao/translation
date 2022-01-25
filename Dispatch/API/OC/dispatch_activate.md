# dispatch_activate

原文链接：[https://developer.apple.com/documentation/dispatch/1641002-dispatch_activate?language=objc](https://developer.apple.com/documentation/dispatch/1641002-dispatch_activate?language=objc)

Activates the dispatch object.
	
激活调度对象。

## Declaration 声明

	void dispatch_activate(dispatch_object_t object);

## Discussion 讨论

Once a dispatch object has been activated, it cannot change its target queue.

调度对象一旦被激活，就不能再更换目标队列。











