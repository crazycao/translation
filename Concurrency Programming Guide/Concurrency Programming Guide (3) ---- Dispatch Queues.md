原文链接：[Concurrency Programming Guide (3) ---- Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html)

#3 Dispatch Queues 调度队列

Grand Central Dispatch (GCD) dispatch queues are a powerful tool for performing tasks. Dispatch queues let you execute arbitrary blocks of code either asynchronously or synchronously with respect to the caller. You can use dispatch queues to perform nearly all of the tasks that you used to perform on separate threads. The advantage of dispatch queues is that they are simpler to use and much more efficient at executing those tasks than the corresponding threaded code. 

Grand Central Dispatch (GCD) 调度队列是用于执行任务的强力工具。调度队列让你可以相对调用者同步或异步的执行任意代码块。你可以使用调度队列在单独的线程执行。调度队列的优势是更易于使用，并且在执行任务时比相应的线程代码更有效。

This chapter provides an introduction to dispatch queues, along with information about how to use them to execute general tasks in your application. If you want to replace existing threaded code with dispatch queues, you can find some additional tips for how to do that in [Migrating Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW1). 

本章提供了对调度队列的介绍，以及如何在你的程序中使用它们执行常见任务的信息。如果你想要使用调度队列替换已有的线程代码，你可以在《[Migrating Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW1)》中找到如何实现的附加建议。

##3.1 About Dispatch Queues 关于调度队列

Dispatch queues are an easy way to perform tasks asynchronously and concurrently in your application. A *task* is simply some work that your application needs to perform. For example, you could define a task to perform some calculations, create or modify a data structure, process some data read from a file, or any number of things. You define tasks by placing the corresponding code inside either a function or a [block object]() and adding it to a dispatch queue. 

调度队列是在你的程序中同步和异步的执行任务的简单方法。*任务*就是你的程序要执行的一些工作。例如，你可以定义一个任务执行某些计算，创建或修改一个数据结构，从某个文件处理一些数据读取，或者任意数量的事情。你只要把相应的代码放到一个函数或者一个[block对象]()中并将其添加到调度队列，就定义好了任务。

A dispatch queue is an object-like structure that manages the tasks you submit to it. All dispatch queues are first-in, first-out data structures. Thus, the tasks you add to a queue are always started in the same order that they were added. GCD provides some dispatch queues for you automatically, but others you can create for specific purposes. Table 3-1 lists the types of dispatch queues available to your application and how you use them.

调度队列是一个类似对象的数据结构，它管理了你提交的任务。所有的调度队列都是先进先出数据结构。因此，你添加到队列的任务总是按照它们被添加的相同的顺序开始。GCD自动为你提供了一些调度队列，但你为了特殊的目的可以创建其他的。表3-1列出了你的程序可用的调度队列的类型以及你要如何使用它们。

**Table 3-1**  Types of dispatch queues

**表 3-1** 调度队列的类型

| Type                | Description                              |
| ------------------- | ---------------------------------------- |
| Serial </br>串行             | Serial queues (also known as *private dispatch queues*) execute one task at a time in the order in which they are added to the queue. The currently executing task runs on a distinct thread (which can vary from task to task) that is managed by the dispatch queue. Serial queues are often used to synchronize access to a specific resource. You can create as many serial queues as you need, and each queue operates concurrently with respect to all other queues. In other words, if you create four serial queues, each queue executes only one task at a time but up to four tasks could still execute concurrently, one from each queue. For information on how to create serial queues, see [Creating Serial Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW6). </br>串行队列（也称为*私有调度队列*）按照任务添加到队列的顺序一次执行一个任务。当前执行的任务运行在由调度队列管理的一个独立的线程（从一个任务切换到另一个任务时可能变化）。串行队列通常用于同步访问特定的资源。你可以按需创建许多串行队列，每个队列相对于其他队列都是并发的执行。换句话说，如果你创建了四个串行队列，每一个队列一次只执行一个任务，但对于这四个任务来说，它们仍能并发的执行，每个任务在一个队列中。关于如何创建串行队列的信息，参见《[Creating Serial Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW6)》。 |
| Concurrent </br>并发          | Concurrent queues (also known as a type of *global dispatch queue*) execute one or more tasks concurrently, but tasks are still started in the order in which they were added to the queue. The currently executing tasks run on distinct threads that are managed by the dispatch queue. The exact number of tasks executing at any given point is variable and depends on system conditions.In iOS 5 and later, you can create concurrent dispatch queues yourself by specifying `DISPATCH_QUEUE_CONCURRENT` as the queue type. In addition, there are four predefined global concurrent queues for your application to use. For more information on how to get the global concurrent queues, see [Getting the Global Concurrent Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW5). </br>并发队列（也被称为*全局调度队列*）并发的执行一个或多个任务，但是任务仍然按照它们添加到队列中的顺序开始。当前执行的任务运行在由调度队列管理的多个独立的线程上。在任意给定点正在执行的任务的准确个数是可以获得的，但具体个数取决于系统条件。在iOS 5及以后，你可以自己创建并发调度队列，只要指定`DISPATCH_QUEUE_CONCURRENT`作为队列类型即可。另外，给你的程序预定义了四个全局并发队列可以使用。关于如何获得全局并发队列的更多信息，参见《[Getting the Global Concurrent Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW5)》。 |
| Main dispatch queue </br>主调度队列 | The main dispatch queue is a globally available serial queue that executes tasks on the application’s main thread. This queue works with the application’s run loop (if one is present) to interleave the execution of queued tasks with the execution of other event sources attached to the run loop. Because it runs on your application’s main thread, the main queue is often used as a key synchronization point for an application. Although you do not need to create the main dispatch queue, you do need to make sure your application drains it appropriately. For more information on how this queue is managed, see [Performing Tasks on the Main Thread](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW15). </br>主调度队列是一个全局可用的串行队列，它在程序的主线程执行任务。该队列与程序的run loop（如果已经存在一个）一起工作，将已在队列中的任务的执行与其他事件源的执行一起插入到run loop中。由于它运行在你的程序的主线程中，主线程通常会被用作程序的关键同步点。尽管你不需要创建主线程队列，但你需要确保你的程序合适的使用它。关于这个队列如何管理的更多信息，参见《[Performing Tasks on the Main Thread](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW15)》。 |

When it comes to adding concurrency to an application, dispatch queues provide several advantages over threads. The most direct advantage is the simplicity of the work-queue programming model. With threads, you have to write code both for the work you want to perform and for the creation and management of the threads themselves. Dispatch queues let you focus on the work you actually want to perform without having to worry about the thread creation and management. Instead, the system handles all of the thread creation and management for you. The advantage is that the system is able to manage threads much more efficiently than any single application ever could. The system can scale the number of threads dynamically based on the available resources and current system conditions. In addition, the system is usually able to start running your task more quickly than you could if you created the thread yourself. 

当即将添加并发到程序中，调度队列提供了若干跨线程的有利特性。最直接的优点就是工作队列编程模式的简化。要使用线程，你不得不写一些代码，既要完成你想要执行的工作，又要完成对线程自身的创建和管理。调度队列让你专注于你实际想要执行的工作，而不用为线程的创建和管理烦恼。取而代之的是，系统帮你处理了所有的线程创建和管理。这个优势就是系统可以比任何单个的应用程序更加有效的管理线程。系统可以基于可用的资源和当前系统条件动态的调节线程的数量。另外，系统总是可以比你自己创建线程更快速的开始运行你的任务。

Although you might think rewriting your code for dispatch queues would be difficult, it is often easier to write code for dispatch queues than it is to write code for threads. The key to writing your code is to design tasks that are self-contained and able to run asynchronously. (This is actually true for both threads and dispatch queues.) However, where dispatch queues have an advantage is in predictability. If you have two tasks that access the same shared resource but run on different threads, either thread could modify the resource first and you would need to use a lock to ensure that both tasks did not modify that resource at the same time. With dispatch queues, you could add both tasks to a serial dispatch queue to ensure that only one task modified the resource at any given time. This type of queue-based synchronization is more efficient than locks because locks always require an expensive kernel trap in both the contested and uncontested cases, whereas a dispatch queue works primarily in your application’s process space and only calls down to the kernel when absolutely necessary.

虽然你可能认为为调度队列重写你的代码会很困难，但为调度队列写代码通常比为线程写代码要更简单。写代码的关键是设计独立的并且能够异步运行的任务。（这对于线程和调度队列来说都是一样正确。）然而，调度队列有一个优点就是可预测性。如果你有两个任务访问同一个共享资源，但是它们运行在不同的线程，每个线程都可能先修改该资源，你就需要使用一个锁确保这两个线程不会同时修改该资源。在调度队列中，你可以把两个任务都添加到一个串行调度队列中以确保在任意给定时间只有一个任务在修改该资源。这种基于队列的同步比锁更有效，因为锁在有竞争和无竞争的情况下总是需要一个非常大的内核开销，而调度队列主要在你程序的处理空当工作，只会在绝对必要时才调用内核。

Although you would be right to point out that two tasks running in a serial queue do not run concurrently, you have to remember that if two threads take a lock at the same time, any concurrency offered by the threads is lost or significantly reduced. More importantly, the threaded model requires the creation of two threads, which take up both kernel and user-space memory. Dispatch queues do not pay the same memory penalty for their threads, and the threads they do use are kept busy and not blocked.

虽然你可能会指出运行在串行队列上的两个任务并不是并发的运行，这是对的，但是你应该记得如果两个线程同时采用了一个锁，由多线程提供的任何并发性都会丢失或者显著降低。更重要的是，基于线程的模型需要创建这两个线程，这将会占用内核和用户内存空间。调度队列并不会为它们的线程付出相同的内存负担，它们使用的内存会保持忙碌而不被阻塞。

Some other key points to remember about dispatch queues include the following:

下面列出了关于调度队列需要记住的其他关键点：

- Dispatch queues execute their tasks concurrently with respect to other dispatch queues. The serialization of tasks is limited to the tasks in a single dispatch queue. 
- 调度队列相对于其他调度队列并发的执行的它们的任务。任务的串行只限制单个调度队列中的任务。
- The system determines the total number of tasks executing at any one time. Thus, an application with 100 tasks in 100 different queues may not execute all of those tasks concurrently (unless it has 100 or more effective cores).
- 系统确定在任一时间执行的任务的总数。因此，一个程序即使有100个任务在100个不同的队列中也不会并发执行所有任务（除非它有超过100个有效的内核）。
- The system takes queue priority levels into account when choosing which new tasks to start. For information about how to set the priority of a serial queue, see [Providing a Clean Up Function For a Queue](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW7).
- 系统在选择开始哪个新任务时采用队列权重等级作为依据。关于。如何设置串行队列的权重的信息，参见《[Providing a Clean Up Function For a Queue](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW7)》。
- Tasks in a queue must be ready to execute at the time they are added to the queue. (If you have used Cocoa operation objects before, notice that this behavior differs from the model operations use.) 
- 队列中的任务必须在添加到队列时就准备好执行。（如果你之前使用Cocoa操作对象，注意这个行为与模型操作的用法不同。）
- Private dispatch queues are reference-counted objects. In addition to retaining the queue in your own code, be aware that dispatch sources can also be attached to a queue and also increment its retain count. Thus, you must make sure that all dispatch sources are canceled and all retain calls are balanced with an appropriate release call. For more information about retaining and releasing queues, see [Memory Management for Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW11). For more information about dispatch sources, see [About Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW12). 
- 私有调度队列是引用计数的对象。要在你自己的代码中持有队列，注意调度源也被附加到队列上并增加了其引用计数。因此，你必须确保所有的调度源被释放，以及所有的持有调用与相关的释放调用保持平衡。关于持有和释放队列的更多信息，参见《[Memory Management for Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW11)》。关于调度源的更多信息，参见《[About Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW12)》。

For more information about interfaces you use to manipulate dispatch queues, see *Grand Central Dispatch (GCD) Reference*.

关于用于操作调度队列的接口的更多信息，参见《*Grand Central Dispatch (GCD) Reference*》。

##3.2 Queue-Related Technologies 基于队列的技术

In addition to dispatch queues, Grand Central Dispatch provides several technologies that use queues to help manage your code. Table 3-2 lists these technologies and provides links to where you can find out more information about them.

除了调度队列，GCD还提供了若干使用队列的技术帮助你管理你的代码。表3-2列出了这些技术，并提供了找到更多关于它们的信息的链接。

**Table 3-2** Technologies that use dispatch queues

**表 3-2** 使用调度队列的技术

| Technology          | Description                              |
| ------------------- | ---------------------------------------- |
| Dispatch groups </br>调度组    | A dispatch group is a way to monitor a set of [block objects]() for completion. (You can monitor the blocks synchronously or asynchronously depending on your needs.) Groups provide a useful synchronization mechanism for code that depends on the completion of other tasks. For more information about using groups, see [Waiting on Groups of Queued Tasks](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW25). </br>调度组是监控一组[block对象]()是否完成的方法。（你可以同步或异步的监控block，取决于你的需求。）组为依赖于其他任务完成的代码提供有用的同步机制。关于使用组的更多信息，参见《[Waiting on Groups of Queued Tasks](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW25)》。 |
| Dispatch semaphores </br>调度信号量 | A dispatch semaphore is similar to a traditional semaphore but is generally more efficient. Dispatch semaphores call down to the kernel only when the calling thread needs to be blocked because the semaphore is unavailable. If the semaphore is available, no kernel call is made. For an example of how to use dispatch semaphores, see [Using Dispatch Semaphores to Regulate the Use of Finite Resources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW24). </br>调度信号量与传统的信号量类似，但通常更高效。调度信号量只在调用线程需要被阻塞时才会调用内核，因为这时信号量是不可用的。如果信号量是可以用的，不需要进行内核调用。对于如何使用调度信号量的例子，参见《[Using Dispatch Semaphores to Regulate the Use of Finite Resources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW24)》。 |
| Dispatch sources </br>调度源   | A dispatch source generates notifications in response to specific types of system events. You can use dispatch sources to monitor events such as process notifications, signals, and descriptor events among others. When an event occurs, the dispatch source submits your task code asynchronously to the specified dispatch queue for processing. For more information about creating and using dispatch sources, see [Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1). </br>调度源产生相应的特定类型的系统事件的通知。你可以使用调度源监控事件，如其他过程的通知，信号，描述符事件等。当事件发生，调度源异步提交你的任务代码到指定的调度队列处理。关于创建和使用调度源的更多信息，参见《[Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1)》。 |

##3.3 Implementing Tasks Using Blocks 使用Block实现任务

[Block objects]() are a C-based language feature that you can use in your C, [Objective-C](), and C++ code. Blocks make it easy to define a self-contained unit of work. Although they might seem akin to function pointers, a block is actually represented by an underlying data structure that resembles an object and is created and managed for you by the compiler. The compiler packages up the code you provide (along with any related data) and encapsulates it in a form that can live in the heap and be passed around your application.

[Block对象]()是基于C语言的特性，你可以在你的C、[Objective-C]()和C++代码中使用它。Block使得更容易定义工作的独立单元。尽管它们可能跟函数指针差不多，block实际上是由类似于对象的基础数据结构来表示，并由编译器创建和管理。编译器会将你提供的代码（包括所有相关的数据）打包，以保存在堆中的形式封装起来，并传递给你的应用。

One of the key advantages of blocks is their ability to use variables from outside their own lexical scope. When you define a block inside a function or method, the block acts as a traditional code block would in some ways. For example, a block can read the values of variables defined in the parent scope. Variables accessed by the block are copied to the block data structure on the heap so that the block can access them later. When blocks are added to a dispatch queue, these values must typically be left in a read-only format. However, blocks that are executed synchronously can also use variables that have the `__block` keyword prepended to return data back to the parent’s calling scope. 

Block的一个主要优势是可以从它们的词法作用域之外使用变量。当你在一个函数或方法里定义block时，block在某些方面表现得跟传统代码块一样。例如，block可以读取定义在它们的父作用域的变量的值。由block访问的变量会被拷贝到堆上的block数据结构，以便block可以在之后访问它们。当block被添加到调度队列时，这些值必须一直留在只读格式。然而，同步执行的block也可以使用前面带有`__block`的值返回数据到父调用区域。

You declare blocks inline with your code using a syntax that is similar to the syntax used for function pointers. The main difference between a block and a function pointer is that the block name is preceded with a caret (`^`) instead of an asterisk (`*`). Like a function pointer, you can pass arguments to a block and receive a return value from it. Listing 3-1 shows you how to declare and execute blocks synchronously in your code. The variable `aBlock`is declared to be a block that takes a single integer parameter and returns no value. An actual block matching that prototype is then assigned to `aBlock` and declared inline. The last line executes the block immediately, printing the specified integers to standard out. 

你使用与函数指针类似的语法声明与你的代码内联的block。Block与函数指针的主要不同是block名字前面带有一个脱字号（`^`）而不是星号（`*`）。像函数指针一样，你可以传递参数到block并从中接收一个返回值。表3-1展示了如何在你的代码中声明并同步的执行block。变量`aBlock`声明成了一个block，传入一个整形参数，无返回值。然后，匹配该原型的实际block会关联到`aBlock`并内联声明。最后一行立即执行了block，打印指定的整数到标准输出。

**Listing 3-1**  A simple block example

	int x = 123;
	int y = 456;
	 
	// Block declaration and assignment
	void (^aBlock)(int) = ^(int z) {
	    printf("%d %d %d\n", x, y, z);
	};
	 
	// Execute the block
	aBlock(789);   // prints: 123 456 789

The following is a summary of some of the key guidelines you should consider when designing your blocks:

下面总结了一些在设计block时应该考虑的主要指导：

- For blocks that you plan to perform asynchronously using a dispatch queue, it is safe to capture scalar variables from the parent function or method and use them in the block. However, you should not try to capture large structures or other pointer-based variables that are allocated and deleted by the calling context. By the time your block is executed, the memory referenced by that pointer may be gone. Of course, it is safe to allocate memory (or an object) yourself and explicitly hand off ownership of that memory to the block. 
- 对于你计划使用调度队列异步执行的block，从父函数或方法中获取标量变量并在block中使用它们是安全的。但是，你不能尝试获取大结构或者其他基于指针的变量，它们由调用上下文分配和删除。在你的block执行时，由该指针引用的内存可以已经被释放。当然，你自己分配内存（或对象）并显式的移除内存与block的关系是安全的。
- Dispatch queues copy blocks that are added to them, and they release blocks when they finish executing. In other words, you do not need to explicitly copy blocks before adding them to a queue. 
- 调度队列会拷贝添加到其中的block，并当它们完成执行时释放block。换句话说，在添加block到队列之前，你不需要显式的拷贝block。
- Although queues are more efficient than raw threads at executing small tasks, there is still overhead to creating blocks and executing them on a queue. If a block does too little work, it may be cheaper to execute it inline than dispatch it to a queue. The way to tell if a block is doing too little work is to gather metrics for each path using the performance tools and compare them.
- 尽管在执行小任务时队列比原始线程更高效，但创建block和在队列中执行它们仍然会有开销。如果block做了太少的工作，内联执行比调度到队列更划算。判断一个block是否做了太少的工作的办法是使用性能工具采集每条路径的度量并比较它们。
- Do not cache data relative to the underlying thread and expect that data to be accessible from a different block. If tasks in the same queue need to share data, use the context pointer of the dispatch queue to store the data instead. For more information on how to access the context data of a dispatch queue, see [Storing Custom Context Information with a Queue](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW13). 
- 不要缓存与基本线程相关的数据并期望该数据可以从不同的block访问。如果同一个队列中的任务需要共享数据，使用调度队列的上下文指针储存数据。关于如何访问调度队列的上下文数据，参见《[Storing Custom Context Information with a Queue](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW13)》。
- If your block creates more than a few Objective-C objects, you might want to enclose parts of your block’s code in an @autorelease block to handle the memory management for those objects. Although GCD dispatch queues have their own autorelease pools, they make no guarantees as to when those pools are drained. If your application is memory constrained, creating your own autorelease pool allows you to free up the memory for autoreleased objects at more regular intervals.
- 如果你的block创建了一些Objective-C对象，你可能想要在@autorelease块中附上部分你的block的代码，以处理那些对象的内存管理。虽然GCD调度队列有它们自己的自动释放池，它们不能保值什么时候这些池子会放干。如果你的程序有内存限制，创建你自己的自动释放池可以让你在更多常规间隔释放自动释放对象的内存。

For more information about blocks, including how to declare and use them, see *Blocks Programming Topics*. For information about how you add blocks to a dispatch queue, see [Adding Tasks to a Queue](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW20). 

关于block的更多信息，包括如何声明和使用它们，参见*Blocks Programming Topics*。关于如何添加block到调度队列的信息，参见《[Adding Tasks to a Queue](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW20)》。

##3.4 Creating and Managing Dispatch Queues 创建和管理调度队列

Before you add your tasks to a queue, you have to decide what type of queue to use and how you intend to use it. Dispatch queues can execute tasks either serially or concurrently. In addition, if you have a specific use for the queue in mind, you can configure the queue attributes accordingly. The following sections show you how to create dispatch queues and configure them for use.

在你添加你的任务到队列之前，你需要决定使用哪种队列以及你将如何使用它。调度队列可以串行或并发的执行任务。另外，如果在你的想法中队列有特殊的用途，你可以相应的配置队列属性。下面一节向你展示了如何创建队列以及如何配置以使用。

###3.4.1 Getting the Global Concurrent Dispatch Queues 获取全局并发调度队列

A concurrent dispatch queue is useful when you have multiple tasks that can run in parallel. A concurrent queue is still a queue in that it dequeues tasks in a first-in, first-out order; however, a concurrent queue may dequeue additional tasks before any previous tasks finish. The actual number of tasks executed by a concurrent queue at any given moment is variable and can change dynamically as conditions in your application change. Many factors affect the number of tasks executed by the concurrent queues, including the number of available cores, the amount of work being done by other processes, and the number and priority of tasks in other serial dispatch queues. 

当你有可以平行运行的多个任务时，并发调度队列是非常有用的。并发队列仍然是一个队列，在这个队列中它仍按照先进先出的顺序让任务出列；但是，并发队列可能在前一个任务完成之前让另一个任务出列。在任意给定时刻一个并发队列执行的实际任务数是可变的，并且会随着你的应用程序的条件变化而动态变化。许多因素影响着并发队列执行的任务数，包括可用的内核个数，其他进程正在做的工作的量，以及其他串行调度队列中任务的数量和优先级。

The system provides each application with four concurrent dispatch queues. These queues are global to the application and are differentiated only by their priority level. Because they are global, you do not create them explicitly. Instead, you ask for one of the queues using the `dispatch_get_global_queue` function, as shown in the following example:

系统给每个程序提供了4个并发调度队列。这些队列对于程序是全局的并且只通过它们的优先级来区分。由于它们是全局的，你不用明确的创建它们。相反，你使用`dispatch_get_global_queue`函数请求其中一个队列，如下面的例子中展示的：

	dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

In addition to getting the default concurrent queue, you can also get queues with high- and low-priority levels by passing in the `DISPATCH_QUEUE_PRIORITY_HIGH` and `DISPATCH_QUEUE_PRIORITY_LOW` constants to the function instead, or get a background queue by passing the `DISPATCH_QUEUE_PRIORITY_BACKGROUND` constant. As you might expect, tasks in the high-priority concurrent queue execute before those in the default and low-priority queues. Similarly, tasks in the default queue execute before those in the low-priority queue.

除了获取默认的并发队列，你也可以通过传入`DISPATCH_QUEUE_PRIORITY_HIGH`和`DISPATCH_QUEUE_PRIORITY_LOW`到该函数来获取高和低优先级的队列，或者传入`DISPATCH_QUEUE_PRIORITY_BACKGROUND`常量获得后台队列。正如你可能期望的，在高优先级并发队列中的任务会比在默认和低优先级队列中的任务先执行。类似的，在默认队列中的任务会比在低优先级中的任务先执行。

>**Note:** The second argument to the `dispatch_get_global_queue` function is reserved for future expansion. For now, you should always pass `0` for this argument.
>
>**注意：**`dispatch_get_global_queue`函数的第二个参数是为以后扩展准备的。现在，你应该给这个参数传`0`就好。

Although dispatch queues are reference-counted objects, you do not need to retain and release the global concurrent queues. Because they are global to your application, retain and release calls for these queues are ignored. Therefore, you do not need to store references to these queues. You can just call the `dispatch_get_global_queue` function whenever you need a reference to one of them.

虽然调度队列是有引用计数的对象，你不需要保持或释放全局并发队列。因为它们对你的程序时全局的，对这些队列的保持或释放调用可以忽略。所以，你不需要保存这些队列的引用。你都可以只是在任何需要引用其中一个时调用`dispatch_get_global_queue`函数。

###3.4.2 Creating Serial Dispatch Queues 创建串行调度队列

Serial queues are useful when you want your tasks to execute in a specific order. A serial queue executes only one task at a time and always pulls tasks from the head of the queue. You might use a serial queue instead of a lock to protect a shared resource or mutable data structure. Unlike a lock, a serial queue ensures that tasks are executed in a predictable order. And as long as you submit your tasks to a serial queue asynchronously, the queue can never deadlock.

当你想要你的任务以特定顺序执行时，串行队列是非常有用的。串行队列一次只执行一个任务，并且总是从队列的头部拉取任务。你可能使用串行队列取代保护共享资源或可变数据结构的锁。与锁不同，串行队列确保任务以可预料的顺序执行。并且只要你异步提交任务到串行队列，该队列永远不会死锁。

Unlike concurrent queues, which are created for you, you must explicitly create and manage any serial queues you want to use. You can create any number of serial queues for your application but should avoid creating large numbers of serial queues solely as a means to execute as many tasks simultaneously as you can. If you want to execute large numbers of tasks concurrently, submit them to one of the global concurrent queues. When creating serial queues, try to identify a purpose for each queue, such as protecting a resource or synchronizing some key behavior of your application.

不像已经为你创建好的并发队列，你必须明确的创建和管理你想要使用的任何串行队列。你可以为你的程序创建任意个数的串行队列，但是应该避免单独创建大量串行队列来作为同时执行尽可能多的任务的手段。如果你想要并发的执行大量任务，把它们提交到全局并发队列就行。当创建串行队列时，尝试给每个队列确定一个目的，比如保护某个资源或者同步程序的一些关键行为。

Listing 3-2 shows the steps required to create a custom serial queue. The `dispatch_queue_create` function takes two parameters: the queue name and a set of queue attributes. The debugger and performance tools display the queue name to help you track how your tasks are being executed. The queue attributes are reserved for future use and should be `NULL`. 

表3-2展示了创建一个自定义串行队列需要的步骤。`dispatch_queue_create`方法由两个参数：队列名称和队列属性组合。调试器和性能工具会显示队列名称帮助你跟踪你的任务是如何执行的。队列属性是为未来使用保留的，应该传入`NULL`。

**Listing 3-2**  Creating a new serial queue

	dispatch_queue_t queue;
	queue = dispatch_queue_create("com.example.MyQueue", NULL);

In addition to any custom queues you create, the system automatically creates a serial queue and binds it to your application’s main thread. For more information about getting the queue for the main thread, see [Getting Common Queues at Runtime](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW3). 

除了你创建的任意自定义队列，系统自动的创建了一个串行队列并绑定到你的程序的主线程。关于获取主线程队列的更多信息，参见《[Getting Common Queues at Runtime](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW3)》。

###3.4.3 Getting Common Queues at Runtime 在运行时获取常见队列

Grand Central Dispatch provides functions to let you access several common dispatch queues from your application:

GCD提供了让你从程序中访问几个常见队列的函数：

- Use the `dispatch_get_current_queue` function for debugging purposes or to test the identity of the current queue. Calling this function from inside a [block object]() returns the queue to which the block was submitted (and on which it is now presumably running). Calling this function from outside of a block returns the default concurrent queue for your application.
- 使用`dispatch_get_current_queue`函数进行调试或者测试当前队列的标识。在一个[block对象]()中调用这个函数会返回这个block被提交到了哪一个队列中（并且它当前大概正在该队列中运行）。在一个block外面调用这个队列会返回你的程序的默认并发队列。
- Use the `dispatch_get_main_queue` function to get the serial dispatch queue associated with your application’s main thread. This queue is created automatically for Cocoa applications and for applications that either call the `dispatch_main` function or configure a run loop (using either the `CFRunLoopRef` type or an `NSRunLoop` object) on the main thread.
- 使用`dispatch_get_main_queue`函数获取与你的程序的主线程关联的串行调度队列。这个队列自动的为Cocoa程序创建，以及为在主线程调用了`dispatch_main`函数或者配置了一个run loop（使用`CFRunLoopRef`类型或`NSRunLoop`对象）的程序创建。
- Use the `dispatch_get_global_queue` function to get any of the shared concurrent queues. For more information, see [Getting the Global Concurrent Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW5). 
- 使用`dispatch_get_global_queue`函数获取任意共享并发队列。更多信息参见《[Getting the Global Concurrent Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW5)》。

###3.4.4 Memory Management for Dispatch Queues 调度队列的内存管理

Dispatch queues and other dispatch objects are reference-counted data types. When you create a serial dispatch queue, it has an initial reference count of 1. You can use the `dispatch_retain` and `dispatch_release` functions to increment and decrement that reference count as needed. When the reference count of a queue reaches zero, the system asynchronously deallocates the queue. 

调度队列及其他调度对象都是有引用计数的数据类型。当你创建一个串行调度队列时，它就有了初始引用计数 1。你可以使用`dispatch_retain`和`dispatch_release`函数按需增加或减少该引用计数。当一个队列的引用计数到了 0，系统会异步的销毁这个队列。

It is important to retain and release dispatch objects, such as queues, to ensure that they remain in memory while they are being used. As with [memory-managed]() Cocoa objects, the general rule is that if you plan to use a queue that was passed to your code, you should retain the queue before you use it and release it when you no longer need it. This basic pattern ensures that the queue remains in memory for as long as you are using it. 

保持和释放调度对象，如队列，是非常重要的，可以确保当使用它们时它们仍然在内存中。正如带[有内存管理的]()Cocoa对象一样，一般的规则是如果你要使用一个传到你的代码中的队列，你应该在打算使用它之前保持它，并且当你不在需要它的时候释放它。这个基本模式确保队列在你使用过程中一直保持在内存中。

**Note:** You do not need to retain or release any of the global dispatch queues, including the concurrent dispatch queues or the main dispatch queue. Any attempts to retain or release the queues are ignored.

**注意：**你不需要保持或释放任何全局调度队列，包括并发调度队列或主调度队列。任何对这些队列进行保持或释放的尝试都会被忽略。

Even if you implement a garbage-collected application, you must still retain and release your dispatch queues and other dispatch objects. Grand Central Dispatch does not support the garbage collection model for reclaiming memory.

即使你实现一个有垃圾回收的程序，你仍必须保持和释放你的调度队列和其他调度对象。GCD不支持垃圾收集模型来回收内存。

###3.4.5 Storing Custom Context Information with a Queue 使用队列储存自定义上下文信息

All dispatch objects (including dispatch queues) allow you to associate custom context data with the object. To set and get this data on a given object, you use the `dispatch_set_context` and `dispatch_get_context` functions. The system does not use your custom data in any way, and it is up to you to both allocate and deallocate the data at the appropriate times.

所有调度对象（包括调度队列）允许你用对象关联自定义上下文数据。要在一个给定的对象上设置和获取这个数据，可以使用`dispatch_set_context`和`dispatch_get_context`函数。系统不会以任何方式使用你的自定义数据，并且需要靠你在适当的时候分配和销毁改数据。

For queues, you can use context data to store a pointer to an Objective-C object or other data structure that helps identify the queue or its intended usage to your code. You can use the queue’s finalizer function to deallocate (or disassociate) your context data from the queue before it is deallocated. An example of how to write a finalizer function that clears a queue’s context data is shown in [Listing 3-3](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW8). 

对于队列，你可以使用上下文数据存储Objective-C对象的指针或者为帮助你的代码标识队列或它的计划用途的其他数据结构。你可以使用队列的终结函数在队列被销毁前销毁（或取消关联）你的上下文数据。如何写一个清理队列上下文数据的终结函数的列子展示在[表3-3](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/#//apple_ref/doc/uid/TP40008091-CH102-SW8)中。

###3.4.6 Providing a Clean Up Function For a Queue 为队列提供一个清理函数

After you create a serial dispatch queue, you can attach a finalizer function to perform any custom clean up when the queue is deallocated. Dispatch queues are reference counted objects and you can use the `dispatch_set_finalizer_f` function to specify a function to be executed when the reference count of your queue reaches zero. You use this function to clean up the context data associated with a queue and the function is called only if the context pointer is not `NULL`.

在你创建一个串行调度队列之后，你可以添加一个终结函数，在队列被销毁时执行任何自定义清理。调度队列是引用计数对象，你可以是使用`dispatch_set_finalizer_f`函数指定一个当队列的引用计数到达0时执行的函数。你使用这个函数清理关联到队列的上下文对象，并且这个函数只在上下文指针不是`NULL`时调用。

Listing 3-3 shows a custom finalizer function and a function that creates a queue and installs that finalizer. The queue uses the finalizer function to release the data stored in the queue’s context pointer. (The `myInitializeDataContextFunction` and `myCleanUpDataContextFunction` functions referenced from the code are custom functions that you would provide to initialize and clean up the contents of the data structure itself.) The context pointer passed to the finalizer function contains the data object associated with the queue.

表3-3展示了自定义终结函数和创建队列并安装该终结者的函数。队列使用终结函数释放储存在队列的上下文指针中的数据。（代码中引用的`myInitializeDataContextFunction`和`myCleanUpDataContextFunction`函数是你需要提供用来初始化和清理数据结构的内容的自定义函数。）传给终结函数的上下文指针包括了关联到队列的数据对象。

**Listing 3-3**  Installing a queue clean up function 安装一个队列清理函数

	void myFinalizerFunction(void *context)
	{
	    MyDataContext* theData = (MyDataContext*)context;
	 
	    // Clean up the contents of the structure
	    myCleanUpDataContextFunction(theData);
	 
	    // Now release the structure itself.
	    free(theData);
	}
	 
	dispatch_queue_t createMyQueue()
	{
	    MyDataContext*  data = (MyDataContext*) malloc(sizeof(MyDataContext));
	    myInitializeDataContextFunction(data);
	 
	    // Create the queue and set the context data.
	    dispatch_queue_t serialQueue = dispatch_queue_create("com.example.CriticalTaskQueue", NULL);
	    dispatch_set_context(serialQueue, data);
	    dispatch_set_finalizer_f(serialQueue, &myFinalizerFunction);
	 
	    return serialQueue;
	}

##3.5 Adding Tasks to a Queue 添加任务到队列

To execute a task, you must dispatch it to an appropriate dispatch queue. You can dispatch tasks synchronously or asynchronously, and you can dispatch them singly or in groups. Once in a queue, the queue becomes responsible for executing your tasks as soon as possible, given its constraints and the existing tasks already in the queue. This section shows you some of the techniques for dispatching tasks to a queue and describes the advantages of each.

要执行一个任务，你必须将其调度到合适的调度队列。你可以同步或异步的调度任务，你也可以单独或分组的调度它们。一旦在一个队列中，队列会负责根据任务约束和队列中已存在的任务尽可能快的执行你的任务。本节展示了调度任务到队列中的一些技术，并介绍了每一个的优点。

###3.5.1 Adding a Single Task to a Queue 添加单个任务到队列

There are two ways to add a task to a queue: asynchronously or synchronously. When possible, asynchronous execution using the `dispatch_async`and `dispatch_async_f` functions is preferred over the synchronous alternative. When you add a [block object]() or function to a queue, there is no way to know when that code will execute. As a result, adding blocks or functions asynchronously lets you schedule the execution of the code and continue to do other work from the calling thread. This is especially important if you are scheduling the task from your application’s main thread—perhaps in response to some user event.

这里有两个方法添加一个任务到队列：同步或异步。在可能的情况下，优先使用`dispatch_async`和`dispatch_async_f`函数异步执行，而把同步作为备选。当你添加一个[block对象]()或函数到队列，没有办法知道代码将在何时执行。因此，异步添加block或函数让你可以安排好代码的执行并继续在调用线程做其他工作。如果你正在程序的主线程安排任务——可能是响应一些用户事件，这将尤其重要。

Although you should add tasks asynchronously whenever possible, there may still be times when you need to add a task synchronously to prevent race conditions or other synchronization errors. In these instances, you can use the `dispatch_sync` and `dispatch_sync_f` functions to add the task to the queue. These functions block the current thread of execution until the specified task finishes executing. 

尽管你无论何时都应该尽可能异步添加任务，仍然有一些时候需要同步的添加任务以避免竞争条件或其他同步错误。在这些情况下，你可以使用`dispatch_sync`和`dispatch_sync_f`函数添加任务到队列。这些函数会阻塞当前执行的线程，直到指定的任务完成执行。

>**Important:** You should never call the `dispatch_sync` or `dispatch_sync_f` function from a task that is executing in the same queue that you are planning to pass to the function. This is particularly important for serial queues, which are guaranteed to deadlock, but should also be avoided for concurrent queues. 
>
>**重要：**在一个正在队列中执行的任务中，如果你想要调用`dispatch_sync`或`dispatch_sync_f`函数，永远不要把这个任务所在的队列传入这两个函数。这对于串行队列尤其重要，这肯定会死锁；而且也要避免在并行队列中这样用。

The following example shows how to use the block-based variants for dispatching tasks asynchronously and synchronously: 

下面的例子展示了如何使用基于block的变量同步和异步的调度任务：

	dispatch_queue_t myCustomQueue;
	myCustomQueue = dispatch_queue_create("com.example.MyCustomQueue", NULL);
	 
	dispatch_async(myCustomQueue, ^{
	    printf("Do some work here.\n");
	});
	 
	printf("The first block may or may not have run.\n");
	 
	dispatch_sync(myCustomQueue, ^{
	    printf("Do some more work here.\n");
	});
	printf("Both blocks have completed.\n");

###3.5.2 Performing a Completion Block When a Task Is Done 当任务完成后执行一个完成block

By their nature, tasks dispatched to a queue run independently of the code that created them. However, when the task is done, your application might still want to be notified of that fact so that it can incorporate the results. With traditional asynchronous programming, you might do this using a callback mechanism, but with dispatch queues you can use a completion block. 

很自然的，调度到队列的任务会独立于创建它们的代码之外运行。然而，当任务完成时，你的程序可能仍需要被通知以合并该结果。在传统的异步编程中，你可以使用回调机制做到，但是在调度队列，你可以使用一个完成block。

A completion block is just another piece of code that you dispatch to a queue at the end of your original task. The calling code typically provides the completion block as a parameter when it starts the task. All the task code has to do is submit the specified block or function to the specified queue when it finishes its work. 

完成block只是你调度到队列的另一片代码，添加到你的初始任务的后面。调用代码在开始任务时通常提供完成block作为参数。所有的任务代码必须要做的是，当完成其工作以后，提交指定的block或函数到指定的队列。

Listing 3-4 shows an averaging function implemented using [blocks](). The last two parameters to the averaging function allow the caller to specify a queue and block to use when reporting the results. After the averaging function computes its value, it passes the results to the specified block and dispatches it to the queue. To prevent the queue from being released prematurely, it is critical to retain that queue initially and release it once the completion block has been dispatched. 

表3-4展示了使用block实现的平均数函数。平均数函数的最后两个参数允许调用者指定报告结果时使用的队列和block。在平均数函数计算其值之后，它将结果传给指定的block并将其调度到队列。为了避免队列过早的释放，在最开始就保持该队列非常重要，并在完成block被调度后释放一次。

**Listing 3-4**  Executing a completion callback after a task

	void average_async(int *data, size_t len,
	   dispatch_queue_t queue, void (^block)(int))
	{
	   // Retain the queue provided by the user to make
	   // sure it does not disappear before the completion
	   // block can be called.
	   dispatch_retain(queue);
	 
	   // Do the work on the default concurrent queue and then
	   // call the user-provided block with the results.
	   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	      int avg = average(data, len);
	      dispatch_async(queue, ^{ block(avg);});
	 
	      // Release the user-provided queue when done
	      dispatch_release(queue);
	   });
	}

###3.5.3 Performing Loop Iterations Concurrently 并发的执行循环迭代

One place where concurrent dispatch queues might improve performance is in places where you have a loop that performs a fixed number of iterations. For example, suppose you have a `for` loop that does some work through each loop iteration: 

一个并发调度队列可能提升性能的地方是你要执行固定数量的迭代的循环的地方。例如，加入你有一个`for`循环，通过每次循环迭代做一些工作：

	for (i = 0; i < count; i++) {
	   printf("%u\n",i);
	}

If the work performed during each iteration is distinct from the work performed during all other iterations, and the order in which each successive loop finishes is unimportant, you can replace the loop with a call to the `dispatch_apply` or `dispatch_apply_f` function. These functions submit the specified [block]() or function to a queue once for each loop iteration. When dispatched to a concurrent queue, it is therefore possible to perform multiple loop iterations at the same time. 

如果每个迭代中执行的工作与所有其他迭代中执行的工作都是不同的，并且每个成功循环完成的顺序并不重要，你可以将这个循环替换成对`dispatch_apply`或`dispatch_apply_f`的函数的调用。当调度到一个并发队列，那就可能同时执行多个循环调度。

You can specify either a serial queue or a concurrent queue when calling `dispatch_apply` or `dispatch_apply_f`. Passing in a concurrent queue allows you to perform multiple loop iterations simultaneously and is the most common way to use these functions. Although using a serial queue is permissible and does the right thing for your code, using such a queue has no real performance advantages over leaving the loop in place. 

你可以在调用`dispatch_apply`或`dispatch_apply_f`时指定一个串行队列或并行队列。传入一个并行队列允许你同时执行多个循环迭代，这也是使用这些函数的最常用方法。尽管使用串行队列是可以的，并且从代码来看也没什么问题，但是使用这样的队列与保留原来的循环相比并没有实际的性能提升。

>**Important:** Like a regular `for` loop, the `dispatch_apply` and `dispatch_apply_f` functions do not return until all loop iterations are complete. You should therefore be careful when calling them from code that is already executing from the context of a queue. If the queue you pass as a parameter to the function is a serial queue and is the same one executing the current code, calling these functions will deadlock the queue. Because they effectively block the current thread, you should also be careful when calling these functions from your main thread, where they could prevent your event handling loop from responding to events in a timely manner. If your loop code requires a noticeable amount of processing time, you might want to call these functions from a different thread.
>
>**重要：**与常规的`for`循环一样，`dispatch_apply`和`dispatch_apply_f`函数并不会返回直到所有的循环迭代都完成。所以当你从已经在一个队列上下文中执行的代码开始调用它们时应该相当小心。如果你作为参数传递到函数的队列是串行队列并且与执行当前代码的队列是同一个，那调用这些函数将会让队列死锁。因为它们会有效的阻塞当前线程，所以当你在主线程调用这些函数时也应该非常小心，在主线程它们会阻止事件处理循环及时的响应事件。如果你的循环代码需要明显较多的处理时间，你应该从一个不同的线程调用这些函数。

Listing 3-5 shows how to replace the preceding `for` loop with the `dispatch_apply` syntax. The block you pass in to the `dispatch_apply` function must contain a single parameter that identifies the current loop iteration. When the block is executed, the value of this parameter is `0` for the first iteration, `1` for the second, and so on. The value of the parameter for the last iteration is `count - 1`, where `count` is the total number of iterations. 

表3-5展示了如何用`dispatch_apply`句法替换前面的`for`循环。你传入`dispatch_apply`函数的block必须包含一个标识当前循环迭代的参数。当block被执行，第一次迭代这个参数的值是`0`，第二次是`1`，等等。最后一次迭代中这个参数的值是`count - 1`，`count`代表迭代的总次数。

**Listing 3-5**  Performing the iterations of a `for` loop concurrently 并发执行`for`循环的迭代

	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	 
	dispatch_apply(count, queue, ^(size_t i) {
	   printf("%u\n",i);
	});

You should make sure that your task code does a reasonable amount of work through each iteration. As with any block or function you dispatch to a queue, there is overhead to scheduling that code for execution. If each iteration of your loop performs only a small amount of work, the overhead of scheduling the code may outweigh the performance benefits you might achieve from dispatching it to a queue. If you find this is true during your testing, you can use striding to increase the amount of work performed during each loop iteration. With striding, you group together multiple iterations of your original loop into a single block and reduce the iteration count proportionately. For example, if you perform 100 iterations initially but decide to use a stride of 4, you now perform 4 loop iterations from each block and your iteration count is 25. For an example of how to implement striding, see [Improving on Loop Code](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW2). 

你应该确保你的任务代码通过每个迭代完成合理数量的工作。与你调度到队列的任何block或函数一样，安排那些代码执行也有开销。如果你的循环的每个迭代只有少量的工作，安排代码的开销可能超过你通过调度它到队列获得的性能提升。如果你在你的测试中发现这是真的，你可以使用大步来增加每个循迭代中的工作量。随着大步，你将你原始循环中的多个迭代组合成一个单独的block并相应的减少迭代次数。例如，如果你一开始执行100次迭代，而决定使用4的步子，那么现在你每个block中执行4个循环迭代，而你的迭代数是25。关于如何实现大步的例子，参见《[Improving on Loop Code](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW2)》。

###3.5.4 Performing Tasks on the Main Thread 在主线程执行任务

Grand Central Dispatch provides a special dispatch queue that you can use to execute tasks on your application’s main thread. This queue is provided automatically for all applications and is drained automatically by any application that sets up a run loop (managed by either a `CFRunLoopRef` type or `NSRunLoop` object) on its main thread. If you are not creating a Cocoa application and do not want to set up a run loop explicitly, you must call the `dispatch_main` function to drain the main dispatch queue explicitly. You can still add tasks to the queue, but if you do not call this function those tasks are never executed. 

GCD提供了特殊的调度队列，你可以用其在程序的主线程执行任务。该队列为所有程序自动提供，并且被任何在主线程设置了run loop（由`CFRunLoopRef`类型或`NSRunLoop`对象管理）的程序自动放干。如果你不是在创建Cocoa程序并且不想显式的建立一个run loop，你必须调用`dispatch_main`函数显式的放干主调度队列。你仍然可以添加任务到这个队列，但是如果你没有调用这个函数，那些任务永远不会被执行。

You can get the dispatch queue for your application’s main thread by calling the `dispatch_get_main_queue` function. Tasks added to this queue are performed serially on the main thread itself. Therefore, you can use this queue as a synchronization point for work being done in other parts of your application.

你可以通过调用`dispatch_get_main_queue`函数为你程序的主线程获得调度队列。添加到这个队列的任务在主线程上串行的执行。因此，你可以使用这个队列作为程序中其他部分的工作完成的同步点。

###3.5.5 Using Objective-C Objects in Your Tasks 在任务中使用Objective-C

GCD provides built-in support for Cocoa memory management techniques so you may freely use Objective-C objects in the blocks you submit to dispatch queues. Each dispatch queue maintains its own autorelease pool to ensure that autoreleased objects are released at some point; queues make no guarantee about when they actually release those objects.

GCD为Cocoa内存管理技术提供嵌入式支持，所以你可以在你提交到调度队列的block中自由的使用Objective-C对象。每个调度队列维持自己的自动释放池，确保自动释放对象在某些节点能被释放；但队列并不保证这些对象合适真正释放了。

If your application is memory constrained and your block creates more than a few autoreleased objects, creating your own autorelease pool is the only way to ensure that your objects are released in a timely manner. If your block creates hundreds of objects, you might want to create more than one autorelease pool or drain your pool at regular intervals.

如果你程序的内存受限，而你的block又创建了较多自动释放对象，创建你自己的自动释放池是确保你的对象及时释放的唯一方法。如果你的block创建了几百个对象，你可能要创建不止一个自动释放池，或者隔一定时间就放干你的池子。

For more information about autorelease pools and Objective-C memory management, see *Advanced Memory Management Programming Guide*. 

关于自动释放池和Objective-C内存管理的更多信息，参见《Advanced Memory Management Programming Guide》。

##3.6 Suspending and Resuming Queues 暂停和恢复队列

You can prevent a queue from executing [block objects]() temporarily by suspending it. You suspend a dispatch queue using the `dispatch_suspend`function and resume it using the `dispatch_resume` function. Calling `dispatch_suspend` increments the queue’s suspension reference count, and calling `dispatch_resume` decrements the reference count. While the reference count is greater than zero, the queue remains suspended. Therefore, you must balance all suspend calls with a matching resume call in order to resume processing blocks. 

你可以通过暂停暂时阻止一个队列执行block对象。你使用`dispatch_suspend`函数暂停一个调度队列，并使用`dispatch_resume`函数恢复它。调用`dispatch_suspend`会增加队列的暂停引用计数，而调用`dispatch_resume`会减少该引用计数。当暂停引用计数大于0时，队列会保持暂停。因此，你必须保证所有的暂停调用和相匹配的恢复调用次数一致才能够恢复处理block。

>**Important:** Suspend and resume calls are asynchronous and take effect only between the execution of blocks. Suspending a queue does not cause an already executing block to stop.
>
>**重要：**暂停和恢复调用都是异步的，并且只在block的执行之间生效。暂停队列不会导致已经在执行的block停下来。

##3.7 Using Dispatch Semaphores to Regulate the Use of Finite Resources 使用调度信号量控制有限资源的使用

If the tasks you are submitting to dispatch queues access some finite resource, you may want to use a dispatch semaphore to regulate the number of tasks simultaneously accessing that resource. A dispatch semaphore works like a regular semaphore with one exception. When resources are available, it takes less time to acquire a dispatch semaphore than it does to acquire a traditional system semaphore. This is because Grand Central Dispatch does not call down into the kernel for this particular case. The only time it calls down into the kernel is when the resource is not available and the system needs to park your thread until the semaphore is signaled.

如果你提交到队列的任务访问了一些有限资源，你可能想用调度信号量控制同时访问该资源的任务的数量。调度信号量的工作方式就像带有一个异常的普通信号量。当资源可用时，获得一个调度信号量所花费的事件比获得传统系统信号量要少。这是因为GCD在这个特殊案例中并没有调用内核。它调用内核的唯一时间是资源不可用而系统需要停下你的线程知道信号量被发出。

The semantics for using a dispatch semaphore are as follows:

使用调度信号量的方法如下：

1. When you create the semaphore (using the `dispatch_semaphore_create` function), you can specify a positive integer indicating the number of resources available. 
2. In each task, call `dispatch_semaphore_wait` to wait on the semaphore.
3. When the wait call returns, acquire the resource and do your work.
4. When you are done with the resource, release it and signal the semaphore by calling the `dispatch_semaphore_signal` function.

>

1. 当你创建信号量（使用`dispatch_semaphore_create`函数）的时候，你可以指定一个正整数表示可用资源的数量。
2. 在每个任务中，调用`dispatch_semaphore_wait`等待信号量。
3. 当等待调用返回时，获得资源，并完成你的工作。
4. 当你用完了资源，释放它，并通过调用`dispatch_semaphore_signal`函数发出信号量。

For an example of how these steps work, consider the use of file descriptors on the system. Each application is given a limited number of file descriptors to use. If you have a task that processes large numbers of files, you do not want to open so many files at one time that you run out of file descriptors. Instead, you can use a semaphore to limit the number of file descriptors in use at any one time by your file-processing code. The basic pieces of code you would incorporate into your tasks is as follows: 

举个如何逐步完成这些工作的例子，假设在系统中使用文件描述符。每个程序只有有限数量的文件描述符可以使用。如果你有一个要处理大量文件的任务，你不想一下子打开这么多文件，这会用光文件描述符。取而代之的是，你可以使用信号量限制有你的文件处理代码同时使用的文件描述符的数量。你可以合并到你的任务中的基本代码片段如下：

	// Create the semaphore, specifying the initial pool size
	dispatch_semaphore_t fd_sema = dispatch_semaphore_create(getdtablesize() / 2);
	 
	// Wait for a free file descriptor
	dispatch_semaphore_wait(fd_sema, DISPATCH_TIME_FOREVER);
	fd = open("/etc/services", O_RDONLY);
	 
	// Release the file descriptor when done
	close(fd);
	dispatch_semaphore_signal(fd_sema);

When you create the semaphore, you specify the number of available resources. This value becomes the initial count variable for the semaphore. Each time you wait on the semaphore, the `dispatch_semaphore_wait` function decrements that count variable by 1. If the resulting value is negative, the function tells the kernel to block your thread. On the other end, the `dispatch_semaphore_signal` function increments the count variable by 1 to indicate that a resource has been freed up. If there are tasks blocked and waiting for a resource, one of them is subsequently unblocked and allowed to do its work. 

当你创建信号量时，你要指定可用资源的数量。这个值成为这个信号量的初始化计数变量。每次你等待信号量，`dispatch_semaphore_wait`函数会将计数变量减少1.如果结果值是负数，函数会让你喝阻塞你的线程。当另一个任务结束时，`dispatch_semaphore_signal`函数会将计数变量增加1，表示一个资源被释放了。如果有任务被阻塞并在等待资源，它们中的一个随后会停止阻塞，并允许做它的工作。

##3.8 Waiting on Groups of Queued Tasks 等待队列任务组

Dispatch groups are a way to block a thread until one or more tasks finish executing. You can use this behavior in places where you cannot make progress until all of the specified tasks are complete. For example, after dispatching several tasks to compute some data, you might use a group to wait on those tasks and then process the results when they are done. Another way to use dispatch groups is as an alternative to thread joins. Instead of starting several child threads and then joining with each of them, you could add the corresponding tasks to a dispatch group and wait on the entire group. 

调度组是阻塞一个线程知道一个或多个任务完成执行的方法。在某些地方，你无法取得进展，直到所有特定任务已完成，那么你可以使用这个行为。例如，在调度若干任务计算一些数据之后，你可以使用一个组等待那些任务完成，然后当它们完成了再处理结果。另一个使用调度组的方法是作为线程关联的替代方法。不再是开启若干子线程然后与他们关联，你可以添加相应的任务到调度组并等待全部组。

Listing 3-6 shows the basic process for setting up a group, dispatching tasks to it, and waiting on the results. Instead of dispatching tasks to a queue using the `dispatch_async` function, you use the `dispatch_group_async` function instead. This function associates the task with the group and queues it for execution. To wait on a group of tasks to finish, you then use the `dispatch_group_wait` function, passing in the appropriate group.

表3-6展示了设置一个组，调度任务到这个组，并等待结果的基本过程。不再使用`dispatch_async`函数调度任务到队列，而要用`dispatch_group_async`函数。这个函数会把任务与组关联，并放入队列执行。要等待一组任务完成，然后你要使用`dispatch_group_wait`函数，传入相关的组。

**Listing 3-6**  Waiting on asynchronous tasks 等待异步任务

	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_group_t group = dispatch_group_create();
	 
	// Add a task to the group
	// 添加任务到组
	dispatch_group_async(group, queue, ^{
	   // Some asynchronous work
	   // 一些异步操作
	});
	 
	// Do some other work while the tasks execute.
	// 当任务执行时做些其他工作
	 
	// When you cannot make any more forward progress,
	// wait on the group to block the current thread.
	// 当你无法取得更多进展，等待分组会阻塞当前线程。
	dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
	 
	// Release the group when it is no longer needed.
	// 当不再需要组时释放它。
	dispatch_release(group);

##3.9 Dispatch Queues and Thread Safety 调度队列与线程安全

It might seem odd to talk about thread safety in the context of dispatch queues, but thread safety is still a relevant topic. Any time you are implementing concurrency in your application, there are a few things you should know: 

在调度队列的上下文中讨论线程安全似乎有点器官，但是线程安全仍然是一个重要的话题。任何时候你在程序中实现并发，都应该知道这些事情：

- Dispatch queues themselves are thread safe. In other words, you can submit tasks to a dispatch queue from any thread on the system without first taking a lock or synchronizing access to the queue.
- 调度队列自己是线程安全的。换句话说，你可以从系统中的任意线程提交任务到调度队列，而不用首先设置一个锁或者同步访问队列。
- Do not call the `dispatch_sync` function from a task that is executing on the same queue that you pass to your function call. Doing so will deadlock the queue. If you need to dispatch to the current queue, do so asynchronously using the `dispatch_async` function. 
- 不要在任务中调用`dispatch_sync`函数时传入任务执行所在的队列。这么多会导致队列死锁。如果你需要调度到当前队列，使用`dispatch_async`函数异步完成。
- Avoid taking locks from the tasks you submit to a dispatch queue. Although it is safe to use locks from your tasks, when you acquire the lock, you risk blocking a serial queue entirely if that lock is unavailable. Similarly, for concurrent queues, waiting on a lock might prevent other tasks from executing instead. If you need to synchronize parts of your code, use a serial dispatch queue instead of a lock.
- 避免在你提交到调度队列的任务中设置锁。尽管在任务中使用锁也是安全的，但是当你获取锁时，如果锁不可用，你就有可能阻塞整个串行队列。类似的，对于并行队列，等待一个锁可能阻止其他任务执行。如果你需要同步你的一部分代码，使用串行队列而不是锁。
- Although you can obtain information about the underlying thread running a task, it is better to avoid doing so. For more information about the compatibility of dispatch queues with threads, see [Compatibility with POSIX Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW18).
- 尽管你可以获得关于基础线程运行任务的信息，最好避免这么做。关于线程和调度队列共存的更多信息，参见《[Compatibility with POSIX Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW18)》。

For additional tips on how to change your existing threaded code to use dispatch queues, see [Migrating Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW1).

关于如何将已有的基于线程的代码换成使用调度队列的更多建议，参见《[Migrating Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW1)》。