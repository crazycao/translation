# init(label:qos:attributes:autoreleaseFrequency:target:)

原文链接：[https://developer.apple.com/documentation/dispatch/dispatchqueue/2300059-init](https://developer.apple.com/documentation/dispatch/dispatchqueue/2300059-init)

Creates a new dispatch queue to which you can submit blocks.
	
创建一个新的可以提交 block 的 dispatch 队列。

## Declaration 声明

	convenience init(label: String, qos: DispatchQoS = .unspecified, attributes: DispatchQueue.Attributes = [], autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency = .inherit, target: DispatchQueue? = nil)

## Parameters 参数

### label

A string label to attach to the queue to uniquely identify it in debugging tools such as Instruments, sample, stackshots, and crash reports. Because applications, libraries, and frameworks can all create their own dispatch queues, a reverse-DNS naming style (com.example.myqueue) is recommended. This parameter is optional and can be NULL.

附加到队列的字符串标签，以便在调试工具（例如 Instruments、示例、堆栈快照和崩溃报告）中唯一标识它。由于应用程序、库和框架都可以创建自己的调度队列，因此建议使用反向DNS命名样式（com.example.myqueue）。此参数是可选的，可以为空。

### qos

The quality-of-service level to associate with the queue. This value determines the priority at which the system schedules tasks for execution. For a list of possible values, see `DispatchQoS.QoSClass`.

与队列相关的服务质量级别。这个值决定系统安排执行任务的优先级。可能的值列表，参见 `DispatchQoS.QoSClass`。

### attributes

The attributes to associate with the queue. Include the concurrent attribute to create a dispatch queue that executes tasks concurrently. If you omit that attribute, the dispatch queue executes tasks serially.

与队列相关的属性。要创建执行并发任务的队列，就要包含并发属性。如果省略这个属性，dispatch 队列会串行执行任务。

### autoreleaseFrequency

The frequency with which to autorelease objects created by the blocks that the queue schedules. For a list of possible values, see `DispatchQueue.AutoreleaseFrequency`.

自动释放由队列调度 block 创建的对象的频率。可能的值列表，参见 `DispatchQueue.AutoreleaseFrequency`。

### target

The target queue on which to execute blocks. Specify `DISPATCH_TARGET_QUEUE_DEFAULT` if you want the system to provide a queue that is appropriate for the current object.

要在其上执行 block 的目标队列。如果你想要系统为当前对象提供合适的队列，就指定为 `DISPATCH_TARGET_QUEUE_DEFAULT`。










