#Concurrency Programming Guide

原文地址：[Concurrency Programming Guide ---- Concurrency and Application Design](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/uid/TP40008091-CH100-SW1)

#1 Concurrency and Application Design 并发与程序设计

In the early days of computing, the maximum amount of work per unit of time that a computer could perform was determined by the clock speed of the CPU. But as technology advanced and processor designs became more compact, heat and other physical constraints started to limit the maximum clock speeds of processors. And so, chip manufacturers looked for other ways to increase the total performance of their chips. The solution they settled on was increasing the number of processor cores on each chip. By increasing the number of cores, a single chip could execute more instructions per second without increasing the CPU speed or changing the chip size or thermal characteristics. The only problem was how to take advantage of the extra cores.

在计算早期，计算机每个时间单元可以执行的最大工作量取决于CPU的时钟速度。但是随着技术进步，处理器设计变得更加复杂，变热和其他物理约束开始限制处理器的最大时钟速度。并且因此，集成电路厂商者们要寻找其他途径提升他们集成电路的整体性能。他们选择的解决方案是增加内核的数量，一个单独的集成电路可以每秒执行更多的指令而不用提升CPU速度或者变更集成电路大小或热量指征。唯一的问题就是如何利用额外的内核。

In order to take advantage of multiple cores, a computer needs software that can do multiple things simultaneously. For a modern, multitasking operating system like OS X or iOS, there can be a hundred or more programs running at any given time, so scheduling each program on a different core should be possible. However, most of these programs are either system daemons or background applications that consume very little real processing time. Instead, what is really needed is a way for individual applications to make use of the extra cores more effectively.

为了利用多个内核，计算机需要可以同时做许多事情的软件。对于一个现代的多任务处理系统如 OS X 或 iOS，随时都可以有成败上千的程序，因此把按一个程序安排到不同的内核是可能的。然而，大部分程序只是系统后台驻留程序或者只花费非常少的实际处理时间的后台应用。相反，真正需要的是一个可以让单个应用更有效的利用额外的内核的方法。

The traditional way for an application to use multiple cores is to create multiple threads. However, as the number of cores increases, there are problems with threaded solutions. The biggest problem is that threaded code does not scale very well to arbitrary numbers of cores. You cannot create as many threads as there are cores and expect a program to run well. What you would need to know is the number of cores that can be used efficiently, which is a challenging thing for an application to compute on its own. Even if you manage to get the numbers correct, there is still the challenge of programming for so many threads, of making them run efficiently, and of keeping them from interfering with one another.

传统的在应用上使用多内核的方法是创建多个线程。然而，随着内核数量的增加，就会有一些基于线程的问题要解决。最大的问题是基于线程的代码并不能很好的扩展到任意数量的内核。你不能只是创建跟内核数一样多的线程就期望一个程序良好运行。你需要知道的是可以有效使用的内核的数量，要让一个应用自己计算这个是非常有挑战的事情。即使你可以获得正确的数字，为这么多线程编程、让它们有效运行并且保持它们互不干扰，这仍然是个挑战。

So, to summarize the problem, there needs to be a way for applications to take advantage of a variable number of computer cores. The amount of work performed by a single application also needs to be able to scale dynamically to accommodate changing system conditions. And the solution has to be simple enough so as to not increase the amount of work needed to take advantage of those cores. The good news is that Apple’s operating systems provide the solution to all of these problems, and this chapter takes a look at the technologies that comprise this solution and the design tweaks you can make to your code to take advantage of them. 

那么，总结这些问题，需要有一个让应用程序可以利用多个计算机内核的方法。由单个应用执行的工作量也需要能够动态缩放以适应变化的系统条件。并且解决方法必须足够简单，以免增加利用这些内核所需的工作量。好消息是苹果的操作系统提供了所有这些问题的解决方案，本章概览了组成该解决方案的技术和设计，你只需要稍加修改就可以让你的代码利用它们。

##1.1 The Move Away from Threads 离开线程

Although threads have been around for many years and continue to have their uses, they do not solve the general problem of executing multiple tasks in a scalable way. With threads, the burden of creating a scalable solution rests squarely on the shoulders of you, the developer. You have to decide how many threads to create and adjust that number dynamically as system conditions change. Another problem is that your application assumes most of the costs associated with creating and maintaining any threads it uses. 

尽管线程已经存在很多年了，并且将仍然继续有它们的用处，它们不能以一种可扩展的方式解决执行多任务的普遍问题。使用线程时，创建可扩展解决方案的重担直接落在了你，开发者，的肩上。你不得不决定创建多少个线程，并随着系统条件的改变动态调节这个数量。另一个问题是你的应用承担了大部分与创建和管理它用到的线程相关的开销。

Instead of relying on threads, OS X and iOS take an *asynchronous design approach* to solving the concurrency problem. Asynchronous functions have been present in operating systems for many years and are often used to initiate tasks that might take a long time, such as reading data from the disk. When called, an asynchronous function does some work behind the scenes to start a task running but returns before that task might actually be complete. Typically, this work involves acquiring a background thread, starting the desired task on that thread, and then sending a notification to the caller (usually through a callback function) when the task is done. In the past, if an asynchronous function did not exist for what you want to do, you would have to write your own asynchronous function and create your own threads. But now, OS X and iOS provide technologies to allow you to perform any task asynchronously without having to manage the threads yourself. 

与依赖线程不同的是，OS X 和 iOS 使用*异步设计方法*解决并发问题。异步函数被放到操作系统中已经很多年了，通常用于开始可能会需要很长时间的任务，比如从磁盘中读取数据。当被调用时，异步函数幕后做了一些工作让一个任务开始运行并在任务将要真正完成之前返回。通常，这些工作涉及获取一个后台线程、在该线程上开始期望的任务以及然后当任务完成时发送一个通知给调用者（通常通过一个回调函数）。在过去，如果你想做的事情所需的异步函数不存在，你不得不编写你自己的异步函数并且创建你自己的线程。但是现在，OS X 和 iOS 提供了这样的技术允许你异步执行任何任务而不需要自己管理线程。

One of the technologies for starting tasks asynchronously is *Grand Central Dispatch (GCD)*. This technology takes the thread management code you would normally write in your own applications and moves that code down to the system level. All you have to do is define the tasks you want to execute and add them to an appropriate dispatch queue. GCD takes care of creating the needed threads and of scheduling your tasks to run on those threads. Because the thread management is now part of the system, GCD provides a holistic approach to task management and execution, providing better efficiency than traditional threads. 

其中一个异步开始任务的技术是*大中央调度(Grand Central Dispatch，GCD)*。该技术取到你在你的应用中一般需要写的线程管理代码并将代码向下移动到系统级别。你要做的所有事情只是定义你想要执行的任务并将它们添加到一个合适的调度队列。由GCD关心创建所需的线程并将你的任务安排到这些线程中运行。因为线程管理现在是系统的一部分，GCD提供全面的方法来管理和执行，比传统线程提供的更加有效。

*Operation queues* are [Objective-C]() objects that act very much like dispatch queues. You define the tasks you want to execute and then add them to an operation queue, which handles the scheduling and execution of those tasks. Like GCD, operation queues handle all of the thread management for you, ensuring that tasks are executed as quickly and as efficiently as possible on the system. 

操作队列是[Objective-C]()对象，它的行为与调度队列非常相像。你定义你要执行的任务，然后添加到操作队列，它来处理这些任务的安排和执行。像GCD一样，操作队列为你处理了所有的线程管理，确保任务在系统中尽可能快速和有效的执行。

The following sections provide more information about dispatch queues, operation queues, and some other related asynchronous technologies you can use in your applications. 

后续章节中提供了关于调度队列、操作队列和你在你的应用中可能用到的其他相关异步技术的更多信息。

###1.1.1 Dispatch Queues 调度队列

Dispatch queues are a C-based mechanism for executing custom tasks. A *dispatch queue* executes tasks either serially or concurrently but always in a first-in, first-out order. (In other words, a dispatch queue always dequeues and starts tasks in the same order in which they were added to the queue.) A serial dispatch queue runs only one task at a time, waiting until that task is complete before dequeuing and starting a new one. By contrast, a concurrent dispatch queue starts as many tasks as it can without waiting for already started tasks to finish. 

调度队列是基于C的执行自定义任务的机制。*调度队列*既不是串行也不是并行的执行任务，但总是先进先出的顺序。（换句话说，调度队列总是以任务被加入到队列中相同的顺序开始任务和出列。）串行调度队列在一个时间只会运行一个任务，等到这个任务完成再出列前开始一个新的任务。相比之下，并发调度队列尽可能多的开始多个任务而不会等待已经开始的任务完成。

Dispatch queues have other benefits: 

- They provide a straightforward and simple programming interface.
- They offer automatic and holistic thread pool management.
- They provide the speed of tuned assembly. 
- They are much more memory efficient (because thread stacks do not linger in application memory).
- They do not trap to the kernel under load.
- The asynchronous dispatching of tasks to a dispatch queue cannot deadlock the queue.
- They scale gracefully under contention.
- Serial dispatch queues offer a more efficient alternative to locks and other synchronization primitives.

调度队列有其他好处：

- 它们提供了简单直接的编程接口。
- 它们提供了自动且全面的线程池管理。
- 它们提供了被调节的集合的速度。
- 它们有更加有效的内存使用（因为线程栈不会留在应用内存中）。
- 它们不会困住加载中的内核。
- 调度队列任务的异步调度不会让队列死锁。
- 它们在竞争下优雅的扩展。
- 串行调度队列给锁和其他早期同步化提供更加有效的替代物。

The tasks you submit to a dispatch queue must be encapsulated inside either a function or a [block object](). *Block objects* are a C language feature introduced in OS X v10.6 and iOS 4.0 that are similar to function pointers conceptually, but have some additional benefits. Instead of defining blocks in their own lexical scope, you typically define blocks inside another function or method so that they can access other variables from that function or method. Blocks can also be moved out of their original scope and copied onto the heap, which is what happens when you submit them to a dispatch queue. All of these semantics make it possible to implement very dynamic tasks with relatively little code. 

你提交给调度队列的任务必须包含在一个函数或者[block对象]()中。*Block对象*是 OS X v10.6 和 iOS 4.0 引入的C语言特性，在概念上类似于函数指针，但有一些额外的好处。与在它们自己的词汇领域定义block不同的是，你通常在另一个函数或方法中定义block以便它们可以从这个函数或方法中访问其他变量。Block也可以移出它们原来的领域，拷贝到堆上，当你把它们提交到调度队列时就会发生。所有这些语义让使用相当少的代码实现非常动态的任务成为可能。

Dispatch queues are part of the Grand Central Dispatch technology and are part of the C runtime. For more information about using dispatch queues in your applications, see [Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1). For more information about blocks and their benefits, see *Blocks Programming Topics*. 

调度队列时大中央调度技术的一部分，也是C运行时的一部分。关于在你的应用中使用调度队列的更多信息，参见[Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1)。关于block和它们的好处的更多信息，参见*Blocks Programming Topics*。

###1.1.2 Dispatch Sources 调度源

Dispatch sources are a C-based mechanism for processing specific types of system events asynchronously. A dispatch source encapsulates information about a particular type of system event and submits a specific [block object]() or function to a dispatch queue whenever that event occurs. You can use dispatch sources to monitor the following types of system events: 

调度源是基于C的机制，用于异步处理特定类型的系统事件。一个调度源包含一个特殊类型的系统事件，并且每当事件发生就会提交一个特定的[block对象]()或者函数到调度队列。你可以使用调度源监视下列类型的系统事件：

- Timers
- Signal handlers
- Descriptor-related events
- Process-related events
- Mach port events
- Custom events that you trigger
- 定时器
- 信号处理器
- 描述符相关事件
- 进程相关事件
- Mach端口事件
- 你触发的自定义事件

Dispatch sources are part of the Grand Central Dispatch technology. For information about using dispatch sources to receive events in your application, see [Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1).

调度源是GCD技术的一部分。关于使用调度源接收在你的应用中的事件的信息，参见[Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1)。

###1.1.3 Operation Queues 操作队列

An operation queue is the [Cocoa]() equivalent of a concurrent dispatch queue and is implemented by the `NSOperationQueue` class. Whereas dispatch queues always execute tasks in first-in, first-out order, operation queues take other factors into account when determining the execution order of tasks. Primary among these factors is whether a given task depends on the completion of other tasks. You configure dependencies when defining your tasks and can use them to create complex execution-order graphs for your tasks.

操作队列是并发调度队列的[Cocoa]()等价物，由 `NSOperationQueue` 类实现。然而调度队列总是按照先进先出的顺序执行任务，操作队列在决定任务执行顺序时则纳入了其他因素。这些因素中最主要的是给定的任务是否依赖其他任务的完成。你可以在定义任务时配置依赖，并可以使用它们为你的任务创建复杂的执行顺序图。

The tasks you submit to an operation queue must be instances of the `NSOperation` class. An *operation object* is an [Objective-C]() object that encapsulates the work you want to perform and any data needed to perform it. Because the `NSOperation` class is essentially an abstract base class, you typically define custom subclasses to perform your tasks. However, the Foundation [framework]() does include some concrete subclasses that you can create and use as is to perform tasks.

你提交到操作队列的任务必须是 `NSOperation` 类的实例。*操作对象*是一个[Objective-C]()对象，包括了你想要执行的工作和执行它所需的所有数据。因为 `NSOperation` 类本质上是一个抽象的基础类，你通常要定义自己的子类来执行你的任务。但是，Foundation[框架]()并没有包含一些你可以创建并用于执行任务的具体子类。

Operation objects generate key-value observing (KVO) notifications, which can be a useful way of monitoring the progress of your task. Although operation queues always execute operations concurrently, you can use dependencies to ensure they are executed serially when needed. 

操作对象会产生键-值观察（KVO）通知，这是监控任务过程的有效方法。尽管操作队列总是并发的执行操作，在需要时你可以使用依赖确保它们按顺序执行。

For more information about how to use operation queues, and how to define custom operation objects, see [Operation Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/OperationObjects/OperationObjects.html#//apple_ref/doc/uid/TP40008091-CH101-SW1). 

关于如何使用操作队列的更多信息，以及如何定义自定义操作对象，参见[Operation Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/OperationObjects/OperationObjects.html#//apple_ref/doc/uid/TP40008091-CH101-SW1)。

##1.2 Asynchronous Design Techniques 异步设计技术

Before you even consider redesigning your code to support concurrency, you should ask yourself whether doing so is necessary. Concurrency can improve the responsiveness of your code by ensuring that your main thread is free to respond to user events. It can even improve the efficiency of your code by leveraging more cores to do more work in the same amount of time. However, it also adds overhead and increases the overall complexity of your code, making it harder to write and debug your code. 

在你考虑重新设计你的代码以支持并发之前，你应该先问问你自己是否有必要这么做。并发可以确保你的主线程是空闲的以响应用户事件，从而提升你的代码的反应灵敏度。它甚至可以通过撬动更多内核来同时做更多的事情来提升你的代码的效率。但是，它也添加了正常消耗并增加你的代码的整个复杂度，让编写和调试代码都变得更困难。

Because it adds complexity, concurrency is not a feature that you can graft onto an application at the end of your product cycle. Doing it right requires careful consideration of the tasks your application performs and the data structures used to perform those tasks. Done incorrectly, you might find your code runs slower than before and is less responsive to the user. Therefore, it is worthwhile to take some time at the beginning of your design cycle to set some goals and to think about the approach you need to take. 

因为它增加了复杂度，并发不是一个可以在你的产品周期结束时移植到应用程序中的特性。把它做好需要仔细考虑你的应用需要执行的任务和用于执行这些任务的数据结构。一旦做错了，你可能发现你的代码比以前运行得更慢并且对用户更难响应。因此，在设计周期的开始就花点时间设置一些目标和思考你需要采取的方法是非常值得的。

Every application has different requirements and a different set of tasks that it performs. It is impossible for a document to tell you exactly how to design your application and its associated tasks. However, the following sections try to provide some guidance to help you make good choices during the design process. 

每个应用程序都有不同的需求，并且要执行不同的任务。不可能有一份文档准确的告诉你如何设计你的应用程序和相关的任务。但是以下章节尝试提供一些引导以帮助你在设计过程中做出正确的选择。

###1.2.1 Define Your Application’s Expected Behavior 定义你的应用的期望行为

Before you even think about adding concurrency to your application, you should always start by defining what you deem to be the correct behavior of your application. Understanding your application’s expected behavior gives you a way to validate your design later. It should also give you some idea of the expected performance benefits you might receive by introducing concurrency.

在你想要把并发添加到你的应用程序之前，你应该总是从定义什么你的程序的正确行为开始。理解你的程序的期望行为给了你一条在之后验证你的设计的方法。这也会给你一些期望的通过引入并发带来可以收到的性能提升的想法。

The first thing you should do is enumerate the tasks your application performs and the objects or data structures associated with each task. Initially, you might want to start with tasks that are performed when the user selects a menu item or clicks a button. These tasks offer discrete behavior and have a well defined start and end point. You should also enumerate other types of tasks your application may perform without user interaction, such as timer-based tasks. 

你要做的第一件事是列举出你的应用程序执行的任务和每个任务相关联的对象或数据结构。起初，你可能想要在用户选择一个菜单项或者点击一个按钮时开始执行任务。这些任务提供不相关联的行为，并且有定义好的开始点和结束点。你也应该列举你的应用程序不通过用户交互执行的其他类型的任务，如基于定时器的任务。

After you have your list of high-level tasks, start breaking each task down further into the set of steps that must be taken to complete the task successfully. At this level, you should be primarily concerned with the modifications you need to make to any data structures and objects and how those modifications affect your application’s overall state. You should also note any dependencies between objects and data structures as well. For example, if a task involves making the same change to an array of objects, it is worth noting whether the changes to one object affect any other objects. If the objects can be modified independently of each other, that might be a place where you could make those modifications concurrently.

在你有了高级任务的列表之后，开始打断每一个任务，然后进入到成功完成任务必须采用的步骤集合中。在这个层级，你应该主要关注将对任何一个数据结构和对象做出的修改以及那些改动如何影响你应用的整个状态。你也应该注意对象和数据结构之间的任何依赖。例如，如果一个任务涉及修改一组对象，值得注意的是对一个对象的修改是否会影响任何其他对象。如果这个对象可以独立于其他对象进行修改，那么这可能就是你可以并发的做出这些修改的地方。

###1.2.2 Factor Out Executable Units of Work 提出工作的可执行单元因素

From your understanding of your application’s tasks, you should already be able to identify places where your code might benefit from concurrency. If changing the order of one or more steps in a task changes the results, you probably need to continue performing those steps serially. If changing the order has no effect on the output, though, you should consider performing those steps concurrently. In both cases, you define the executable unit of work that represents the step or steps to be performed. This unit of work then becomes what you encapsulate using either a [block]() or an operation object and dispatch to the appropriate queue. 

从你的应用程序的任务的理解，你应该已经能够识别你的代码可能会从并发中获益的地方。如果修改任务重一个或多个步骤的顺序会改变结果，你可能需要串行的继续执行这些步骤。如果修改顺序对输出没有影响，那么你应该考虑并发的执行这些步骤。在这两种情况下，你应该要定义工作的可执行单元，这能表示将要被执行的任务。工作单元然后变成你改过以使用[block]()或者操作对象并且分配到合适的队列。

For each executable unit of work you identify, do not worry too much about the amount of work being performed, at least initially. Although there is always a cost to spinning up a thread, one of the advantages of dispatch queues and operation queues is that in many cases those costs are much smaller than they are for traditional threads. Thus, it is possible for you to execute smaller units of work more efficiently using queues than you could using threads. Of course, you should always measure your actual performance and adjust the size of your tasks as needed, but initially, no task should be considered too small.

对于每个你标记的工作的可执行单元，至少在开始的时候，不用担心工作执行了多少。尽管在线程上高速运转总会有一些开销，但是调度队列和操作队列的一个优势是，在许多情况下这个开销比使用传统线程小很多。因此，对你来说，执行更小的工作单元可能使用队列比使用线程更有效。当然，你应该总是要衡量你的实际性能，并按需调整你的任务的大小，但是在开始，再小的任务都不为过。

###1.2.3 Identify the Queues You Need 辨认你需要的队列

Now that your tasks are broken up into distinct units of work and encapsulated using [block objects]() or operation objects, you need to define the queues you are going to use to execute that code. For a given task, examine the blocks or operation objects you created and the order in which they must be executed to perform the task correctly. 

现在你的任务已经被打散成不同的工作单元，并使用[block对象]()或操作对象概括起来，你需要定义接下来用于执行这些代码的队列。对于一个给定的任务，检查你创建的block或操作对象以及它们必须被执行的顺序，才能正确的完成任务。

If you implemented your tasks using blocks, you can add your blocks to either a serial or concurrent dispatch queue. If a specific order is required, you would always add your blocks to a serial dispatch queue. If a specific order is not required, you can add the blocks to a concurrent dispatch queue or add them to several different dispatch queues, depending on your needs. 

如果你使用block实现你的任务，你可添加你的block到串行或并行调度队列。如果需要特定的顺序，你应该总是把block添加到串行调度队列。如果不需要特定的顺序，你可以添加block到并行调度队列或者添加到几个不同的调度队列中，这取决于你的需求。

If you implemented your tasks using operation objects, the choice of queue is often less interesting than the configuration of your objects. To perform operation objects serially, you must configure dependencies between the related objects. Dependencies prevent one operation from executing until the objects on which it depends have finished their work.

如果你使用操作对象实现你的任务，队列的选择就比对象的配置更无趣了。要串行的执行操作对象，你必须在相关的对象之间配置依赖。依赖会阻止一个操作执行，直到它依赖的对象已经完成它们的工作。

###1.2.4 Tips for Improving Efficiency 提升性能的窍门

In addition to simply factoring your code into smaller tasks and adding them to a queue, there are other ways to improve the overall efficiency of your code using queues: 

除了简单的把你的代码考虑成更小的任务并添加它们到队列中，还有其他方法使用队列提升你的代码的整体效率：

- **Consider computing values directly within your task if memory usage is a factor.** If your application is already memory bound, computing values directly now may be faster than loading cached values from main memory. Computing values directly uses the registers and caches of the given processor core, which are much faster than main memory. Of course, you should only do this if testing indicates this is a performance win.
- **如果内存使用是一个考虑因素，就直接在你的任务中计算值。**如果你的应用程序已经面临内存困境，现在直接计算值可能会比从主内存中加载缓存值更快。直接计算值使用寄存器和给定处理器内核的缓存，这比主内存快很多。当然，你应该只在测试发现性能更好的时候这么做。
- **Identify serial tasks early and do what you can to make them more concurrent.** If a task must be executed serially because it relies on some shared resource, consider changing your architecture to remove that shared resource. You might consider making copies of the resource for each client that needs one or eliminate the resource altogether. 
- **尽早辨识串行任务，尽可能让他们更具并发性。**如果一个任务因为依赖一些共享资源必须串行执行，考虑更改你的架构移除这个共享资源。你可以考虑为每个需要的客户端制作一份资源的拷贝或者一起删除这个资源。
- **Avoid using locks.** The support provided by dispatch queues and operation queues makes locks unnecessary in most situations. Instead of using locks to protect some shared resource, designate a serial queue (or use operation object dependencies) to execute tasks in the correct order.
- **避免使用锁。**调度队列和操作队列提供的支持让大部分情况下都没必要用锁。取代使用锁来保护共享资源的是，指定一个串行队列（或者使用操作对象依赖）来让任务以正确的顺序执行。
- **Rely on the system frameworks whenever possible.** The best way to achieve concurrency is to take advantage of the built-in concurrency provided by the system [frameworks](). Many frameworks use threads and other technologies internally to implement concurrent behaviors. When defining your tasks, look to see if an existing framework defines a function or method that does exactly what you want and does so concurrently. Using that API may save you effort and is more likely to give you the maximum concurrency possible.
- **尽可能依靠系统框架。**实现并发的最好方式是利用系统[框架]()提供的内嵌并发。许多框架使用线程和其他内部技术实现并发行为。当你定义你的任务时，看看是否已有的框架定义了函数或方法确实做了你想做的事情，并且是并发的完成的。使用API可以节省你的努力并且更可能给你最大的并发可能性。

##1.3 Performance Implications 性能的影响

Operation queues, dispatch queues, and dispatch sources are provided to make it easier for you to execute more code concurrently. However, these technologies do not guarantee improvements to the efficiency or responsiveness in your application. It is still your responsibility to use queues in a manner that is both effective for your needs and does not impose an undue burden on your application’s other resources. For example, although you could create 10,000 operation objects and submit them to an operation queue, doing so would cause your application to allocate a potentially nontrivial amount of memory, which could lead to paging and decreased performance. 

操作队列，调度队列和调度源被提供出来让你并发的执行更多代码变得更容易。但是这些技术不能保证提升你的应用程序的效率或响应能力。以对你需求有效但是不会过度占用你的应用程序的其他资源的方式使用队列仍然是你的责任。例如，尽管你可以创建1W个操作对象并将它们提交到操作队列，这么做将会导致你的应用程序潜在分配超级大量的内存，这会导致分页并降低性能。

Before introducing any amount of concurrency to your code—whether using queues or threads—you should always gather a set of baseline metrics that reflect your application’s current performance. After introducing your changes, you should then gather additional metrics and compare them to your baseline to see if your application’s overall efficiency has improved. If the introduction of concurrency makes your application less efficient or responsive, you should use the available performance tools to check for the potential causes. 

在引入任何数量的并发到你的代码之前——无论使用队列还是线程——你应该总是采集一组反映你的程序当前性能的基础度量值。在引入改动后，你应该再采集一组度量值，并将它们与你的基础值比较，看看你的程序的整体性能是否提升了。如果并发的引入导致你的程序效率或响应能力降低，你应该使用可获得的性能工具去检查潜在的问题。

For an introduction to performance and the available performance tools, and for links to more advanced performance-related topics, see *[Performance Overview](https://developer.apple.com/library/content/documentation/Performance/Conceptual/PerformanceOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40001410)*.

对于性能和可获得的性能工具的介绍，以及更多高级的性能相关的话题，参见*[Performance Overview](https://developer.apple.com/library/content/documentation/Performance/Conceptual/PerformanceOverview/Introduction/Introduction.html#//apple_ref/doc/uid/TP40001410)*。

##1.4 Concurrency and Other Technologies 并发和其他技术

Factoring your code into modular tasks is the best way to try and improve the amount of concurrency in your application. However, this design approach may not satisfy the needs of every application in every case. Depending on your tasks, there might be other options that can offer additional improvements in your application’s overall concurrency. This section outlines some of the other technologies to consider using as part of your design.

考虑把你的代码放入模块化任务中是尝试和提升你的应用程序中的并发数量的最好的方式。但是，这种设计可能满足不了每个程序在每种情况下的需求。这取决于你的任务，也可能有其他选择可以在你应用程序的整个并发中提供额外的提升。本节简略介绍了一些可以考虑用作你的设计的一部分的其他技术。

###1.4.1 OpenCL and Concurrency OpenCL和并发

In OS X, the *Open Computing Language (OpenCL)* is a standards-based technology for performing general-purpose computations on a computer’s graphics processor. OpenCL is a good technology to use if you have a well-defined set of computations that you want to apply to large data sets. For example, you might use OpenCL to perform filter computations on the pixels of an image or use it to perform complex math calculations on several values at once. In other words, OpenCL is geared more toward problem sets whose data can be operated on in parallel.

在 OS X中，*开放计算语言（OpenCL）*是一种在计算机的图形处理器上执行通用计算的标准技术。如果你已经定义好了一组想要用于大数据集的计算，OpenCL就是一种很好用的技术。例如，你可能使用OpenCL在图像的像素上执行过滤计算或者一次在若干值上执行复杂的数学计算。换句话说，OpenCL适合于更加面向数据可以被平行操作的问题集合。

Although OpenCL is good for performing massively data-parallel operations, it is not suitable for more general-purpose calculations. There is a nontrivial amount of effort required to prepare and transfer both the data and the required work kernel to a graphics card so that it can be operated on by a GPU. Similarly, there is a nontrivial amount of effort required to retrieve any results generated by OpenCL. As a result, any tasks that interact with the system are generally not recommended for use with OpenCL. For example, you would not use OpenCL to process data from files or network streams. Instead, the work you perform using OpenCL must be much more self-contained so that it can be transferred to the graphics processor and computed independently. 

尽管OpenCL可以很好的执行大规模的数据平行操作，它并不适合与更加通用的计算。需要进行超出常规的大量努力以做好准备，并将数据和需要的工作内核转到图形卡上，才能通过GPU执行。类似的，也需要进行超出常规的大量努力才能接受OpenCL生成的任何结果。结论就是，任何与系统交互的任务通常不建议使用OpenCL。例如，你不应该使用OpenCL从文件或网络流中处理数据。相反的，你使用OpenCL执行的工作必须更加自给自足，这样才能够传到图形处理器并独立计算。

For more information about OpenCL and how you use it, see *[OpenCL Programming Guide for Mac](https://developer.apple.com/library/content/documentation/Performance/Conceptual/OpenCL_MacProgGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008312)*.

关于OpenCL和如何使用它的更多信息，参见*[OpenCL Programming Guide for Mac](https://developer.apple.com/library/content/documentation/Performance/Conceptual/OpenCL_MacProgGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008312)*。

###1.4.2 When to Use Threads 何时使用线程

Although operation queues and dispatch queues are the preferred way to perform tasks concurrently, they are not a panacea. Depending on your application, there may still be times when you need to create custom threads. If you do create custom threads, you should strive to create as few threads as possible yourself and you should use those threads only for specific tasks that cannot be implemented any other way.

尽管操作队列和调度队列是并发执行任务的较好方法，但是它们也不是万能的。取决于你的应用程序，可能仍然有一些时候你需要创建自定义线程。如果你创建自定义线程，你应该尽可能少的自己创建线程，并且应该只使用那些线程处理不能通过其他方式实现的特定任务。

Threads are still a good way to implement code that must run in real time. Dispatch queues make every attempt to run their tasks as fast as possible but they do not address real time constraints. If you need more predictable behavior from code running in the background, threads may still offer a better alternative.

线程仍然是一个实现必须及时运行的代码的好方式。调度队列让每个视图运行的任务尽可能的快，但是它们并不是受到实时限制。如果你需要从在后台运行的代码中得到更多可预期的行为，线程仍然能提供更好的选择。

As with any threaded programming, you should always use threads judiciously and only when absolutely necessary. For more information about thread packages and how you use them, see *[Threading Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)*.

与任何线程编程一样，你应该总是谨慎的使用线程，并且只在绝对需要时才使用。关于线程包和如何使用它们的更多信息，参见*[Threading Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Multithreading/Introduction/Introduction.html#//apple_ref/doc/uid/10000057i)*。
