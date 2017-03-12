#Concurrency Programming Guide 并发编程指南

原文链接：[Concurrency Programming Guide ---- Introduction](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091-CH1-SW1)

#0 Introduction 介绍

Concurrency is the notion of multiple things happening at the same time. With the proliferation of multicore CPUs and the realization that the number of cores in each processor will only increase, software developers need new ways to take advantage of them. Although operating systems like OS X and iOS are capable of running multiple programs in parallel, most of those programs run in the background and perform tasks that require little continuous processor time. It is the current foreground application that both captures the user’s attention and keeps the computer busy. If an application has a lot of work to do but keeps only a fraction of the available cores occupied, those extra processing resources are wasted.

并发就是指多件事情同时发生。随着多核CPU的激增并且每个处理器中核的数目只会继续增长，软件开发者需要新的方法来利用它们。尽管像OS X和iOS这样的操作系统能平行的运行多个程序，但那些程序大部分运行在后台且只执行需要极少持续处理器时间的任务。获得用户的注意和让计算机保持忙碌的都是当前的前台应用。如果一个应用有许多工作要做，但是只占有一小部分可用的内核，那些额外的处理资源就浪费了。

In the past, introducing concurrency to an application required the creation of one or more additional threads. Unfortunately, writing threaded code is challenging. Threads are a low-level tool that must be managed manually. Given that the optimal number of threads for an application can change dynamically based on the current system load and the underlying hardware, implementing a correct threading solution becomes extremely difficult, if not impossible to achieve. In addition, the synchronization mechanisms typically used with threads add complexity and risk to software designs without any guarantees of improved performance. 

在过去，在程序中引入并发需要创建一个或多个附加线程。很不幸，编写线程代码真是一个挑战。线程是要一个必须手动管理的低级工具。对一个应用设定多少个线程才是最佳的会基于当前加载的系统及其之下的硬件动态变化，实现正确的线程方案变得非常困难，甚至无法实现。另外，通常与线程一起使用的同步机制给软件设计增加了复杂度和风险，无法保证性能提升。

Both OS X and iOS adopt a more asynchronous approach to the execution of concurrent tasks than is traditionally found in thread-based systems and applications. Rather than creating threads directly, applications need only define specific tasks and then let the system perform them. By letting the system manage the threads, applications gain a level of scalability not possible with raw threads. Application developers also gain a simpler and more efficient programming model. 

OS X和iOS采用更加异步的方法处理并发任务，而不是传统的在基于线程的系统和程序中处理。与直接创建线程不同，应用可以只定义具体任务，然后让系统执行它们。通过让系统管理线程，应用获得原始线程不可能达到的扩展性级别。应用开发者也得到了一种更简单更有效的编程模型。

This document describes the technique and technologies you should be using to implement concurrency in your applications. The technologies described in this document are available in both OS X and iOS.

本文介绍了用于在你的应用中实现并发的方法和技术。该技术在OS X和iOS上都可以使用。

##0.1 Organization of This Document 文档的组织结构

This document contains the following chapters:

本文档包括以下章节：

- [Concurrency and Application Design](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/uid/TP40008091-CH100-SW1) introduces the basics of asynchronous application design and the technologies for performing your custom tasks asynchronously. 
- [Operation Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/OperationObjects/OperationObjects.html#//apple_ref/doc/uid/TP40008091-CH101-SW1) shows you how to encapsulate and perform tasks using Objective-C objects. 
- [Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1) shows you how to execute tasks concurrently in C-based applications. 
- [Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1) shows you how to handle system events asynchronously.
- [Migrating Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW1) provides tips and techniques for migrating your existing thread-based code over to use newer technologies.
- [Concurrency and Application Design](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/ConcurrencyandApplicationDesign/ConcurrencyandApplicationDesign.html#//apple_ref/doc/uid/TP40008091-CH100-SW1)介绍了异步应用设计的基础知识和异步执行你的自定义任务的基本技术。
- [Operation Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/OperationObjects/OperationObjects.html#//apple_ref/doc/uid/TP40008091-CH101-SW1)展示了如何使用Objective-C对象包含和执行任务。
- [Dispatch Queues](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/OperationQueues/OperationQueues.html#//apple_ref/doc/uid/TP40008091-CH102-SW1) 展示了如何在基于C的程序中并发的执行任务。
- [Dispatch Sources](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/GCDWorkQueues/GCDWorkQueues.html#//apple_ref/doc/uid/TP40008091-CH103-SW1) 展示了如何异步处理系统事件。
- [Migrating Away from Threads](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/ThreadMigration/ThreadMigration.html#//apple_ref/doc/uid/TP40008091-CH105-SW1) 提供了建议和技术帮助你从已有的基于线程的代码迁移到新的技术。

This document also includes a glossary that defines relevant terms.

本文档还包括了一份定义相关术语的词汇表。

##0.2 A Note About Terminology 关于术语的注记

Before entering into a discussion about concurrency, it is necessary to define some relevant terminology to prevent confusion. Developers who are more familiar with UNIX systems or older OS X technologies may find the terms “task”, “process”, and “thread” used somewhat differently in this document. This document uses these terms in the following way:

在进入关于并发的讨论之前，必须要电一一些相关的术语以免混淆。熟悉UNIX系统或者旧OS X技术的程序员可能发现术语"任务"、"进程"、"线程"在本文中的用法有点不同。本文按照下面的方式使用这些术语：

- The term *thread* is used to refer to a separate path of execution for code. The underlying implementation for threads in OS X is based on the POSIX threads API.
- 术语*线程*用于称呼处理代码的独立路径。在OS X中的线程的底层实现是基于POSIX线程API的。
- The term *process* is used to refer to a running executable, which can encompass multiple threads.
- 术语*进程*用于称呼一个可执行的运行，可能包含多个线程。
- The term *task* is used to refer to the abstract concept of work that needs to be performed. 
- 术语*任务*用于称呼需要执行的工作的抽象概念。

For complete definitions of these and other key terms used by this document, see [Glossary](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/Glossary/Glossary.html#//apple_ref/doc/uid/TP40008091-CH104-SW2).

关于这些及其他关键术语在本文中的完整定义，参见[Glossary](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/Glossary/Glossary.html#//apple_ref/doc/uid/TP40008091-CH104-SW2)。

##0.3 See Also 其他参考

This document focuses on the preferred technologies for implementing concurrency in your applications and does not cover the use of threads. If you need information about using threads and other thread-related technologies, see *Threading Programming Guide*.

本文在应用中实现并发的高级技术，而没有涵盖线程的使用。如果你需要关于使用线程和其他基于线程的技术的信息，参见*Threading Programming Guide*。
