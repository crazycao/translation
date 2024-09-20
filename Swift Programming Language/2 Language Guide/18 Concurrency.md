# Concurrency - 并发

> Perform asynchronous operations.
> 
> 执行异步操作。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency)

Swift has built-in support for writing asynchronous and parallel code in a structured way. Asynchronous code can be suspended and resumed later, although only one piece of the program executes at a time. Suspending and resuming code in your program lets it continue to make progress on short-term operations like updating its UI while continuing to work on long-running operations like fetching data over the network or parsing files. Parallel code means multiple pieces of code run simultaneously — for example, a computer with a four-core processor can run four pieces of code at the same time, with each core carrying out one of the tasks. A program that uses parallel and asynchronous code carries out multiple operations at a time, and it suspends operations that are waiting for an external system.

Swift 内建了对于以结构化方式编写异步和并行代码的支持。异步代码可以被挂起并在稍后恢复，尽管在任何时刻只有程序的一部分在执行。在你的程序中挂起和恢复代码可以让它在继续进行长时间操作，如网络获取数据或解析文件等，的同时，继续处理如更新 UI 等短期操作。并行代码意味着多段代码可以同时运行——例如，一台具有四核处理器的计算机可以同时运行四段代码，每个核心执行其中的一个任务。一个使用并行和异步代码的程序可以同时执行多个操作，并且它会挂起等待外部系统的操作。

The additional scheduling flexibility from parallel or asynchronous code also comes with a cost of increased complexity. Swift lets you express your intent in a way that enables some compile-time checking — for example, you can use actors to safely access mutable state. However, adding concurrency to slow or buggy code isn’t a guarantee that it will become fast or correct. In fact, adding concurrency might even make your code harder to debug. However, using Swift’s language-level support for concurrency in code that needs to be concurrent means Swift can help you catch problems at compile time.

并行或异步代码带来的额外调度灵活性也带来了复杂性的增加。Swift 允许你以一种可以进行一些编译时检查的方式来表达你的意图——例如，你可以使用 actors 来安全地访问可变状态。然而，给慢速或有错误的代码添加并发性并不能保证它会变得快速或正确。实际上，添加并发性可能甚至使你的代码更难调试。然而，对于需要并发的代码来说，使用 Swift 的语言级别支持并发意味着 Swift 可以帮助你在编译时捕获问题。

The rest of this chapter uses the term _concurrency_ to refer to this common combination of asynchronous and parallel code.

本章剩余部分使用术语“并发”来指代异步和并行代码的这种常见组合。

> **Note** **注意**
>
> If you’ve written concurrent code before, you might be used to working with threads. The concurrency model in Swift is built on top of threads, but you don’t interact with them directly. An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked. When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on.
> 
> 如果你以前写过并发代码，你可能习惯于处理线程。Swift 中的并发模型是建立在线程之上的，但你并不直接与它们交互。在 Swift 中，一个异步函数可以放弃它正在运行的线程，这可以让另一个异步函数在第一个函数被阻塞时在该线程上运行。当一个异步函数恢复运行时，Swift 不会保证该函数将在哪个线程上运行。

Although it’s possible to write concurrent code without using Swift’s language support, that code tends to be harder to read. For example, the following code downloads a list of photo names, downloads the first photo in that list, and shows that photo to the user:

```
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```

Even in this simple case, because the code has to be written as a series of completion handlers, you end up writing nested closures. In this style, more complex code with deep nesting can quickly become unwieldy.
