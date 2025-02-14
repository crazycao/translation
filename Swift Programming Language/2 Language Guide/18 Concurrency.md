# Concurrency - 并发

> Perform asynchronous operations.
> 
> 执行异步操作。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency)

Swift has built-in support for writing asynchronous and parallel code in a structured way. Asynchronous code can be suspended and resumed later, although only one piece of the program executes at a time. Suspending and resuming code in your program lets it continue to make progress on short-term operations like updating its UI while continuing to work on long-running operations like fetching data over the network or parsing files. Parallel code means multiple pieces of code run simultaneously — for example, a computer with a four-core processor can run four pieces of code at the same time, with each core carrying out one of the tasks. A program that uses parallel and asynchronous code carries out multiple operations at a time, and it suspends operations that are waiting for an external system.

Swift 内建了对于以结构化方式编写异步和并行代码的支持。异步代码可以被挂起并在稍后恢复，尽管在任何时刻只有程序的一部分在执行。在你的程序中挂起和恢复代码可以让它在继续进行长时间操作，如网络获取数据或解析文件等，的同时，继续处理如更新 UI 等短期操作。并行代码意味着多段代码可以同时运行——例如，一台具有四核处理器的计算机可以同时运行四段代码，每个核心执行其中的一个任务。一个使用并行和异步代码的程序可以同时执行多个操作，并且它会挂起等待外部系统的操作。

The additional scheduling flexibility from parallel or asynchronous code also comes with a cost of increased complexity. Swift lets you express your intent in a way that enables some compile-time checking — for example, you can use actors to safely access mutable state. However, adding concurrency to slow or buggy code isn’t a guarantee that it will become fast or correct. In fact, adding concurrency might even make your code harder to debug. However, using Swift’s language-level support for concurrency in code that needs to be concurrent means Swift can help you catch problems at compile time.

并行或异步代码带来的额外调度灵活性也带来了复杂性的增加。Swift 允许你以一种能进行一些编译时检查的方式来表达你的意图——例如，你可以使用 actors 来安全地访问可变状态。然而，为慢速或有错误的代码添加并发性并不能保证它会变得快速或正确。实际上，添加并发性可能甚至使你的代码更难调试。不过，对于需要并发的代码来说，使用 Swift 的语言级别支持并发意味着 Swift 可以帮助你在编译时发现问题。

The rest of this chapter uses the term _concurrency_ to refer to this common combination of asynchronous and parallel code.

本章剩余部分使用术语“并发”来指代异步和并行代码的这种常见组合。

> **Note** **注意**
>
> If you’ve written concurrent code before, you might be used to working with threads. The concurrency model in Swift is built on top of threads, but you don’t interact with them directly. An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked. When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on.
> 
> 如果你以前写过并发代码，你可能习惯于处理线程。Swift 中的并发模型是建立在线程之上的，但你并不直接与它们交互。在 Swift 中，一个异步函数可以放弃它正在运行的线程，这可以让另一个异步函数在第一个函数被阻塞时在该线程上运行。当一个异步函数恢复运行时，Swift 不会保证该函数将在哪个线程上运行。

Although it’s possible to write concurrent code without using Swift’s language support, that code tends to be harder to read. For example, the following code downloads a list of photo names, downloads the first photo in that list, and shows that photo to the user:

虽然不使用 Swift 的语言支持也有可能编写并发代码，但这样的代码往往更难阅读。例如，以下代码下载照片名称列表，下载列表中的第一张照片，并将该照片展示给用户：

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

即使在这个简单的例子中，由于代码必须写成一系列完成处理程序，最终你会写出嵌套闭包。在这种风格下，嵌套很深的更复杂代码很快就会变得难以处理。

## 1 Defining and Calling Asynchronous Functions 定义和调用异步函数

An _asynchronous function_ or _asynchronous method_ is a special kind of function or method that can be suspended while it’s partway through execution. This is in contrast to ordinary, synchronous functions and methods, which either run to completion, throw an error, or never return. An asynchronous function or method still does one of those three things, but it can also pause in the middle when it’s waiting for something. Inside the body of an asynchronous function or method, you mark each of these places where execution can be suspended.

**异步函数** 或 **异步方法** 是一种特殊的函数或方法，它可以在执行过程中暂停。这与普通的同步函数和方法不同，普通的同步函数和方法要么执行完毕，要么抛出错误，要么永不返回。异步函数或方法仍然会出现这三种情况之一，但它也可以在等待某些操作时在中间暂停。在异步函数或方法的函数体中，你需要标记出每个可以暂停执行的位置。

To indicate that a function or method is asynchronous, you write the `async` keyword in its declaration after its parameters, similar to how you use `throws` to mark a throwing function. If the function or method returns a value, you write `async` before the return arrow (`->`). For example, here’s how you might fetch the names of photos in a gallery:

```
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... some asynchronous networking code ...
    return result
}
```

要表明一个函数或方法是异步的，你可以在其声明中的参数之后写上 `async` 关键字，这类似于使用 `throws` 来标记一个会抛出错误的函数。如果该函数或方法返回一个值，你要在返回箭头（`->`）之前写上 `async`。例如，下面展示了如何获取图库中照片的名称：

```
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... 一些异步网络代码 ...
    return result
}
```

For a function or method that’s both asynchronous and throwing, you write `async` before `throws`.

对于既是异步又会抛出错误的函数或方法，你要在 `throws` 之前写上 `async`。

When calling an asynchronous method, execution suspends until that method returns. You write `await` in front of the call to mark the possible suspension point. This is like writing `try` when calling a throwing function, to mark the possible change to the program’s flow if there’s an error. Inside an asynchronous method, the flow of execution is suspended only when you call another asynchronous method — suspension is never implicit or preemptive — which means every possible suspension point is marked with `await`. Marking all of the possible suspension points in your code helps make concurrent code easier to read and understand.

当调用一个异步方法时，执行会暂停，直到该方法返回结果。你要在调用前写上 `await` 来标记可能的暂停点。这就像调用一个会抛出错误的函数时写上 `try` 一样，用于标记如果出现错误，程序流程可能会发生的变化。在异步方法内部，只有在调用另一个异步方法时，执行流程才会暂停 —— 暂停永远不会是隐式的或抢占式的 —— 这意味着每个可能的暂停点都用 `await` 进行了标记。在代码中标记所有可能的暂停点有助于使并发代码更易于阅读和理解。

For example, the code below fetches the names of all the pictures in a gallery and then shows the first picture:

例如，下面的代码获取图库中所有图片的名称，然后展示第一张图片：

```
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

Because the `listPhotos(inGallery:)` and `downloadPhoto(named:)` functions both need to make network requests, they could take a relatively long time to complete. Making them both asynchronous by writing `async` before the return arrow lets the rest of the app’s code keep running while this code waits for the picture to be ready.

因为 `listPhotos(inGallery:)` 和 `downloadPhoto(named:)` 函数都需要进行网络请求，它们可能需要相对较长的时间才能完成。通过在返回箭头之前写上 `async` 使它们都成为异步函数，这样在这段代码等待图片准备好时，应用程序的其他代码可以继续运行。

To understand the concurrent nature of the example above, here’s one possible order of execution:

1. The code starts running from the first line and runs up to the first `await`. It calls the `listPhotos(inGallery:)` function and suspends execution while it waits for that function to return.
2. While this code’s execution is suspended, some other concurrent code in the same program runs. For example, maybe a long-running background task continues updating a list of new photo galleries. That code also runs until the next suspension point, marked by `await`, or until it completes.
3. After `listPhotos(inGallery:)` returns, this code continues execution starting at that point. It assigns the value that was returned to `photoNames`.
4. The lines that define `sortedNames` and `name` are regular, synchronous code. Because nothing is marked `await` on these lines, there aren’t any possible suspension points.
5. The next `await` marks the call to the `downloadPhoto(named:)` function. This code pauses execution again until that function returns, giving other concurrent code an opportunity to run.
6. After `downloadPhoto(named:)` returns, its return value is assigned to `photo` and then passed as an argument when calling `show(_:)`.

为了理解上述示例的并发特性，下面是一种可能的执行顺序：

1. 代码从第一行开始运行，一直运行到第一个 `await` 处。它调用 `listPhotos(inGallery:)` 函数，并在等待该函数返回时暂停执行。
2. 当这段代码的执行暂停时，同一程序中的其他并发代码开始运行。例如，可能一个长时间运行的后台任务会继续更新新图库的列表。这段代码也会一直运行，直到遇到下一个由 `await` 标记的暂停点，或者直到执行完毕。
3. 在 `listPhotos(inGallery:)` 返回后，这段代码从该点继续执行。它将返回的值赋给 `photoNames`。
4. 定义 `sortedNames` 和 `name` 的行是普通的同步代码。因为这些行上没有标记 `await`，所以没有可能的暂停点。
5. 下一个 `await` 标记了对 `downloadPhoto(named:)` 函数的调用。这段代码再次暂停执行，直到该函数返回，这为其他并发代码提供了运行的机会。
6. 在 `downloadPhoto(named:)` 返回后，其返回值被赋给 `photo`，然后在调用 `show(_:)` 时作为参数传递。

The possible suspension points in your code marked with `await` indicate that the current piece of code might pause execution while waiting for the asynchronous function or method to return. This is also called _yielding the thread_ because, behind the scenes, Swift suspends the execution of your code on the current thread and runs some other code on that thread instead. Because code with `await` needs to be able to suspend execution, only certain places in your program can call asynchronous functions or methods:

- Code in the body of an asynchronous function, method, or property.
- Code in the static `main()` method of a structure, class, or enumeration that’s marked with `@main`.
- Code in an unstructured child task, as shown in [Unstructured Concurrency]() below.

代码中用 `await` 标记的可能暂停点表明，当前这段代码在等待异步函数或方法返回时可能会暂停执行。这也被称为 **让出线程**，因为在底层，Swift 会暂停当前线程上代码的执行，转而在该线程上运行其他代码。由于带有 `await` 的代码需要能够暂停执行，所以在程序中只有特定的位置可以调用异步函数或方法：

- 异步函数、方法或属性的函数体中的代码。
- 用 `@main` 标记的结构体、类或枚举的静态 `main()` 方法中的代码。
- 非结构化子任务中的代码，如下面的《[非结构化并发](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency#Unstructured-Concurrency)》所示。

You can explicitly insert a suspension point by calling the [Task.yield()](https://developer.apple.com/documentation/swift/task/3814840-yield) method.

```
func generateSlideshow(forGallery gallery: String) async {
    let photos = await listPhotos(inGallery: gallery)
    for photo in photos {
        // ... render a few seconds of video for this photo ...
        await Task.yield()
    }
}
```

你可以通过调用 [Task.yield()](https://developer.apple.com/documentation/swift/task/3814840-yield) 方法来显式插入一个暂停点。

```
func generateSlideshow(forGallery gallery: String) async {
    let photos = await listPhotos(inGallery: gallery)
    for photo in photos {
        // ... 为这张照片渲染几秒钟的视频 ...
        await Task.yield()
    }
}
```

Assuming the code that renders video is synchronous, it doesn’t contain any suspension points. The work to render video could also take a long time. However, you can periodically call `Task.yield()` to explicitly add suspension points. Structuring long-running code this way lets Swift balance between making progress on this task, and letting other tasks in your program make progress on their work.

假设渲染视频的代码是同步的，它不包含任何暂停点。渲染视频的工作也可能需要很长时间。不过，你可以定期调用 `Task.yield()` 来显式添加暂停点。以这种方式组织长时间运行的代码，能让 Swift 在推进这个任务和让程序中的其他任务推进它们的工作之间取得平衡。

The `Task.sleep(for:tolerance:clock:)` method is useful when writing simple code to learn how concurrency works. This method suspends the current task for at least the given amount of time. Here’s a version of the `listPhotos(inGallery:)` function that uses `sleep(for:tolerance:clock:)` to simulate waiting for a network operation:

`Task.sleep(for:tolerance:clock:)` 方法在编写简单代码来学习并发如何工作时很有用。这个方法会让当前任务至少暂停指定的时间。下面是 `listPhotos(inGallery:)` 函数的一个版本，它使用 `sleep(for:tolerance:clock:)` 来模拟等待网络操作：

```
func listPhotos(inGallery name: String) async throws -> [String] {
    try await Task.sleep(for: .seconds(2))
    return ["IMG001", "IMG99", "IMG0404"]
}
```

The version of `listPhotos(inGallery:)` in the code above is both asynchronous and throwing, because the call to `Task.sleep(until:tolerance:clock:)` can throw an error. When you call this version of `listPhotos(inGallery:)`, you write both `try` and `await`:

上述代码中的 `listPhotos(inGallery:)` 版本既是异步的又是会抛出错误的，因为调用 `Task.sleep(until:tolerance:clock:)` 可能会抛出错误。当你调用这个版本的 `listPhotos(inGallery:)` 时，要同时写上 `try` 和 `await`：

```
let photos = try await listPhotos(inGallery: "A Rainy Weekend")
```

Asynchronous functions have some similarities to throwing functions: When you define an asynchronous or throwing function, you mark it with `async` or `throws`, and you mark calls to that function with `await` or `try`. An asynchronous function can call another asynchronous function, just like a throwing function can call another throwing function.

异步函数与会抛出错误的函数有一些相似之处：当你定义一个异步或会抛出错误的函数时，用 `async` 或 `throws` 标记它，并且在调用该函数时用 `await` 或 `try` 标记。异步函数可以调用另一个异步函数，就像会抛出错误的函数可以调用另一个会抛出错误的函数一样。

However, there’s a very important difference. You can wrap throwing code in a `do-catch` block to handle errors, or use `Result` to store the error for code elsewhere to handle it. These approaches let you call throwing functions from nonthrowing code. For example:

然而，有一个非常重要的区别。你可以将会抛出错误的代码包裹在 `do - catch` 块中以处理错误，或者使用 `Result` 来存储错误，以便让其他地方的代码来处理它。这些方法允许你从不会抛出错误的代码中调用会抛出错误的函数。例如：

```
func availableRainyWeekendPhotos() -> Result<[String], Error> {
    return Result {
        try listDownloadedPhotos(inGallery: "A Rainy Weekend")
    }
}
```

In contrast, there’s no safe way to wrap asynchronous code so you can call it from synchronous code and wait for the result. The Swift standard library intentionally omits this unsafe functionality — trying to implement it yourself can lead to problems like subtle races, threading issues, and deadlocks. When adding concurrent code to an existing project, work from the top down. Specifically, start by converting the top-most layer of code to use concurrency, and then start converting the functions and methods that it calls, working through the project’s architecture one layer at a time. There’s no way to take a bottom-up approach, because synchronous code can’t ever call asynchronous code.

相比之下，没有安全的方法可以包裹异步代码，从而让你从同步代码中调用它并等待结果。Swift 标准库有意省略了这种不安全的功能 —— 自己尝试实现它可能会导致一些问题，比如微妙的竞争条件、线程问题和死锁。当在现有项目中添加并发代码时，要采用自上而下的方式。具体来说，首先将最顶层的代码转换为使用并发，然后开始转换它所调用的函数和方法，一次处理项目架构的一层。无法采用自下而上的方法，因为同步代码永远不能调用异步代码。

## 2 Asynchronous Sequences 异步序列

The `listPhotos(inGallery:)` function in the previous section asynchronously returns the whole array at once, after all of the array’s elements are ready. Another approach is to wait for one element of the collection at a time using an asynchronous sequence. Here’s what iterating over an asynchronous sequence looks like:

上一节中的 `listPhotos(inGallery:)` 函数会在数组的所有元素都准备好之后，一次性异步返回整个数组。另一种方法是使用异步序列，一次等待集合中的一个元素。下面展示了如何遍历一个异步序列：


```
import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

Instead of using an ordinary `for-in` loop, the example above writes for with `await` after it. Like when you call an asynchronous function or method, writing `await` indicates a possible suspension point. A `for-await-in` loop potentially suspends execution at the beginning of each iteration, when it’s waiting for the next element to be available.

上述示例没有使用普通的 `for-in` 循环，而是在 `for` 后面加上了 `await`。就像调用异步函数或方法时一样，写上 `await` 表示可能存在暂停点。`for-await-in` 循环在每次迭代开始时，也就是等待下一个元素可用时，可能会暂停执行。

In the same way that you can use your own types in a `for-in` loop by adding conformance to the `Sequence` protocol, you can use your own types in a `for-await-in` loop by adding conformance to the AsyncSequence protocol.

就像你可以通过让自定义类型遵循 `Sequence` 协议从而在 `for-in` 循环中使用这些类型一样，你也可以通过让自定义类型遵循 `AsyncSequence` 协议，从而在 `for-await-in` 循环中使用这些类型。

## 3 Calling Asynchronous Functions in Parallel 并行调用异步函数

Calling an asynchronous function with `await` runs only one piece of code at a time. While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code. For example, to fetch the first three photos from a gallery, you could `await` three calls to the `downloadPhoto(named:)` function as follows:

使用 `await` 调用异步函数时，同一时间只会执行一段代码。当异步代码运行时，调用者会等待该代码执行完毕，然后才会继续执行下一行代码。例如，要从一个图库中获取前三张照片，你可以像下面这样使用 `await` 三次调用 `downloadPhoto(named:)` 函数：

```
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses, only one call to `downloadPhoto(named:)` runs at a time. Each photo downloads completely before the next one starts downloading. However, there’s no need for these operations to wait — each photo can download independently, or even at the same time.

这种方法有一个重要的缺点：虽然下载操作是异步的，在下载过程中可以让其他工作继续进行，但每次只能有一个对 `downloadPhoto(named:)` 函数的调用在运行。每张照片都要完全下载完成后，下一张照片才会开始下载。然而，这些操作并不需要相互等待 —— 每张照片都可以独立下载，甚至可以同时下载。

To call an asynchronous function and `let` it run in parallel with code around it, write `async` in front of let when you define a constant, and then write `await` each time you use the constant.

要调用一个异步函数并让它与周围的代码并行运行，在定义常量时，在 `let` 前面写上 `async`，然后每次使用该常量时都写上 `await`。

```
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

In this example, all three calls to `downloadPhoto(named:)` start without waiting for the previous one to complete. If there are enough system resources available, they can run at the same time. None of these function calls are marked with `await` because the code doesn’t suspend to wait for the function’s result. Instead, execution continues until the line where `photos` is defined — at that point, the program needs the results from these asynchronous calls, so you write `await` to pause execution until all three photos finish downloading.

在这个例子中，对 `downloadPhoto(named:)` 函数的三次调用都会立即开始，而不需要等待前一次调用完成。如果系统有足够的资源，它们可以同时运行。这些函数调用都没有用 `await` 标记，因为代码不会暂停以等待函数的结果。相反，执行会继续进行，直到定义 `photos` 的那一行 —— 在这一点上，程序需要这些异步调用的结果，所以你写上 `await` 来暂停执行，直到三张照片都下载完成。

Here’s how you can think about the differences between these two approaches:

- Call asynchronous functions with `await` when the code on the following lines depends on that function’s result. This creates work that is carried out sequentially.
- Call asynchronous functions with `async-let` when you don’t need the result until later in your code. This creates work that can be carried out in parallel.
- Both `await` and `async-let` allow other code to run while they’re suspended.
- In both cases, you mark the possible suspension point with `await` to indicate that execution will pause, if needed, until an asynchronous function has returned.

下面是对这两种方法差异的思考方式：

- 当后续代码依赖于某个异步函数的结果时，使用 `await` 调用该异步函数。这会创建按顺序执行的任务。
- 当在代码后面才需要某个异步函数的结果时，使用 `async-let` 调用该异步函数。这会创建可以并行执行的任务。
- `await` 和 `async-let` 在暂停时都允许其他代码运行。
- 在这两种情况下，你都用 `await` 标记可能的暂停点，以表明如果需要，执行会暂停，直到异步函数返回结果。

You can also mix both of these approaches in the same code.

你也可以在同一代码中混合使用这两种方法。

## 4 Tasks and Task Groups 任务和任务组

A _task_ is a unit of work that can be run asynchronously as part of your program. All asynchronous code runs as part of some task. A task itself does only one thing at a time, but when you create multiple tasks, Swift can schedule them to run simultaneously.

**任务** 是程序中可以异步执行的工作单元。所有异步代码都是作为某个任务的一部分运行的。一个任务一次只能做一件事，但当你创建多个任务时，Swift 可以调度它们同时运行。

The `async-let` syntax described in the previous section implicitly creates a child task — this syntax works well when you already know what tasks your program needs to run. You can also create a task group (an instance of [`TaskGroup`](https://developer.apple.com/documentation/swift/taskgroup)) and explicitly add child tasks to that group, which gives you more control over priority and cancellation, and lets you create a dynamic number of tasks.

上一节描述的 `async-let` 语法会隐式创建一个子任务 —— 当你已经知道程序需要运行哪些任务时，这种语法很适用。你也可以创建一个任务组（[`TaskGroup`](https://developer.apple.com/documentation/swift/taskgroup) 的实例），并显式地向该组中添加子任务，这样你就能更好地控制优先级和取消操作，还能动态创建任意数量的任务。

Tasks are arranged in a hierarchy. Each task in a given task group has the same parent task, and each task can have child tasks. Because of the explicit relationship between tasks and task groups, this approach is called _structured concurrency_. The explicit parent-child relationships between tasks has several advantages:

- In a parent task, you can’t forget to wait for its child tasks to complete.
- When setting a higher priority on a child task, the parent task’s priority is automatically escalated.
- When a parent task is canceled, each of its child tasks is also automatically canceled.
- Task-local values propagate to child tasks efficiently and automatically.

任务是按层次结构排列的。给定任务组中的每个任务都有相同的父任务，并且每个任务都可以有子任务。由于任务和任务组之间的关系是明确的，这种方法被称为 **结构化并发**。任务之间明确的父子关系有几个优点：

- 在父任务中，你不会忘记等待其子任务完成。
- 当为子任务设置更高的优先级时，父任务的优先级会自动提升。
- 当父任务被取消时，它的每个子任务也会自动被取消。
- 任务局部的值会高效且自动地传播到子任务。

Here’s another version of the code to download photos that handles any number of photos:

下面是另一个下载照片的代码版本，它可以处理任意数量的照片：

```
await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }

    for await photo in group {
        show(photo)
    }
}
```

The code above creates a new task group, and then creates child tasks to download each photo in the gallery. Swift runs as many of these tasks concurrently as conditions allow. As soon a child task finishes downloading a photo, that photo is displayed. There’s no guarantee about the order that child tasks complete, so the photos from this gallery can be shown in any order.

上述代码创建了一个新的任务组，然后创建子任务来下载图库中的每张照片。在条件允许的情况下，Swift 会尽可能并发地运行这些任务。一旦某个子任务完成照片下载，就会显示该照片。子任务完成的顺序没有保证，因此图库中的照片可以按任意顺序显示。

> **Note** **注意**
>
> If the code to download a photo could throw an error, you would call `withThrowingTaskGroup(of:returning:body:)` instead.
> 
> 如果下载照片的代码会抛出错误，那么你应该调用 `withThrowingTaskGroup(of:returning:body:)` 方法。

In the code listing above, each photo is downloaded and then displayed, so the task group doesn’t return any results. For a task group that returns a result, you add code that accumulates its result inside the closure you pass to `withTaskGroup(of:returning:body:)`.

在上面的代码中，每张照片下载后就会显示，因此任务组不会返回任何结果。对于需要返回结果的任务组，你需要在传递给 `withTaskGroup(of:returning:body:)` 的闭包内添加代码来累积结果。

```
let photos = await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }

    var results: [Data] = []
    for await photo in group {
        results.append(photo)
    }

    return results
}
```

Like the previous example, this example creates a child task for each photo to download it. Unlike the previous example, the `for-await-in` loop waits for the next child task to finish, appends the result of that task to the array of results, and then continues waiting until all child tasks have finished. Finally, the task group returns the array of downloaded photos as its overall result.

和前面的例子一样，这个例子为每张照片创建一个子任务来下载它。不同的是，`for-await-in` 循环会等待下一个子任务完成，将该任务的结果追加到结果数组中，然后继续等待，直到所有子任务都完成。最后，任务组将下载的照片数组作为整体结果返回。

### 4.1 Task Cancellation 任务取消

Swift concurrency uses a cooperative cancellation model. Each task checks whether it has been canceled at the appropriate points in its execution, and responds to cancellation appropriately. Depending on what work the task is doing, responding to cancellation usually means one of the following:

- Throwing an error like `CancellationError`
- Returning `nil` or an empty collection
- Returning the partially completed work

Swift 并发使用协作式取消模型。每个任务在执行过程中的适当位置检查自己是否已被取消，并对取消操作做出适当响应。根据任务正在执行的工作，对取消操作的响应通常意味着以下情况之一：

- 抛出像 `CancellationError` 这样的错误
- 返回 `nil` 或空集合
- 返回部分完成的工作

Downloading pictures could take a long time if the pictures are large or the network is slow. To let the user stop this work, without waiting for all of the tasks to complete, the tasks need check for cancellation and stop running if they are canceled. There are two ways a task can do this: by calling the [`Task.checkCancellation()`](https://developer.apple.com/documentation/swift/task/3814826-checkcancellation) type method, or by reading the [`Task.isCancelled`](https://developer.apple.com/documentation/swift/task/iscancelled-swift.type.property) type property. Calling `checkCancellation()` throws an error if the task is canceled; a throwing task can propagate the error out of the task, stopping all of the task’s work. This has the advantage of being simple to implement and understand. For more flexibility, use the `isCancelled` property, which lets you perform clean-up work as part of stopping the task, like closing network connections and deleting temporary files.

如果照片很大或者网络很慢，下载照片可能需要很长时间。为了让用户能够停止这项工作，而不是不等待所有任务完成，任务需要检查是否被取消，如果被取消就停止运行。任务可以通过两种方式来实现这一点：调用 [`Task.checkCancellation()`](https://developer.apple.com/documentation/swift/task/3814826-checkcancellation) 类方法，或者读取 [`Task.isCancelled`](https://developer.apple.com/documentation/swift/task/iscancelled-swift.type.property) 类属性。如果任务被取消，调用 `checkCancellation()` 会抛出错误；会抛出错误的任务可以将错误传播出任务，从而停止任务的所有工作。这种方法的优点是实现和理解起来都很简单。为了获得更多的灵活性，可以使用 `isCancelled` 属性，它允许你在停止任务时执行清理工作，比如关闭网络连接和删除临时文件。

```
let photos = await withTaskGroup(of: Optional<Data>.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        let added = group.addTaskUnlessCancelled {
            guard !Task.isCancelled else { return nil }
            return await downloadPhoto(named: name)
        }
        guard added else { break }
    }

    var results: [Data] = []
    for await photo in group {
        if let photo { results.append(photo) }
    }
    return results
}
```

The code above makes several changes from the previous version:

- Each task is added using the [`TaskGroup.addTaskUnlessCancelled(priority:operation:)`](https://developer.apple.com/documentation/swift/taskgroup/addtaskunlesscancelled(priority:operation:)) method, to avoid starting new work after cancellation.
- After each call to `addTaskUnlessCancelled(priority:operation:)`, the code confirms that the new child task was added. If the group is canceled, the value of `added` is `false` — in that case, the code stops trying to download additional photos.
- Each task checks for cancellation before starting to download the photo. If it has been canceled, the task returns `nil`.
- At the end, the task group skips `nil` values when collecting the results. Handling cancellation by returning `nil` means the task group can return a partial result — the photos that were already downloaded at the time of cancellation — instead of discarding that completed work.

上述代码与之前的版本相比有几处改动：

- 使用 [`TaskGroup.addTaskUnlessCancelled(priority:operation:)`](https://developer.apple.com/documentation/swift/taskgroup/addtaskunlesscancelled(priority:operation:)) 方法添加每个任务，以避免在取消操作后开始新的工作。
- 每次调用 `addTaskUnlessCancelled(priority:operation:)` 后，代码会确认新的子任务是否已添加。如果任务组被取消，`added` 的值为 `false` —— 在这种情况下，代码会停止尝试下载更多照片。
- 每个任务在开始下载照片之前会检查是否被取消。如果已被取消，任务将返回 `nil`。
- 最后，任务组在收集结果时会跳过 `nil` 值。通过返回 `nil` 来处理取消操作意味着任务组可以返回部分结果 —— 即取消时已经下载好的照片 —— 而不是丢弃已完成的工作。

> **Note** **注意**
>
> To check whether a task has been canceled from outside that task, use the [`Task.isCancelled`](https://developer.apple.com/documentation/swift/task/iscancelled-swift.property) instance property instead of the type property.
> 
> 要从任务外部检查任务是否已被取消，应使用 [`Task.isCancelled`](https://developer.apple.com/documentation/swift/task/iscancelled-swift.property) 实例属性，而不是类属性。

For work that needs immediate notification of cancellation, use the [`Task.withTaskCancellationHandler(operation:onCancel:isolation:)`](https://developer.apple.com/documentation/swift/withtaskcancellationhandler(operation:oncancel:isolation:)) method. For example:

```
let task = await Task.withTaskCancellationHandler {
    // ...
} onCancel: {
    print("Canceled!")
}

// ... some time later...
task.cancel()  // Prints "Canceled!"
```

对于需要立即获知取消通知的工作，可以使用 [`Task.withTaskCancellationHandler(operation:onCancel:isolation:)`](https://developer.apple.com/documentation/swift/withtaskcancellationhandler(operation:oncancel:isolation:)) 方法。例如：

```
let task = await Task.withTaskCancellationHandler {
    // ...
} onCancel: {
    print("Canceled!")
}

// ... 一段时间后 ...
task.cancel()  // 输出 "Canceled!"
```

When using a cancellation handler, task cancellation is still cooperative: The task either runs to completion or checks for cancellation and stops early. Because the task is still running when the cancellation handler starts, avoid sharing state between the task and its cancellation handler, which could create a race condition.

使用取消处理程序时，任务取消仍然是协作式的：任务要么运行到完成，要么检查是否被取消并提前停止。由于取消处理程序开始时任务仍在运行，要避免在任务和其取消处理程序之间共享状态，否则可能会产生竞态条件。

### 4.2 Unstructured Concurrency 非结构化并发

In addition to the structured approaches to concurrency described in the previous sections, Swift also supports unstructured concurrency. Unlike tasks that are part of a task group, an _unstructured task_ doesn’t have a parent task. You have complete flexibility to manage unstructured tasks in whatever way your program needs, but you’re also completely responsible for their correctness. To create an unstructured task that runs on the current actor, call the [`Task.init(priority:operation:)`](https://developer.apple.com/documentation/swift/task/3856790-init) initializer. To create an unstructured task that’s not part of the current actor, known more specifically as a detached task, call the [`Task.detached(priority:operation:)`](https://developer.apple.com/documentation/swift/task/3856786-detached) class method. Both of these operations return a task that you can interact with — for example, to wait for its result or to cancel it.

```
let newPhoto = // ... some photo data ...
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value
```

For more information about managing detached tasks, see [Task](https://developer.apple.com/documentation/swift/task).

除了前面章节所描述的结构化并发方法之外，Swift 还支持非结构化并发。与属于任务组的任务不同，**非结构化任务** 没有父任务。你可以根据程序的需求，以任意方式灵活管理非结构化任务，但同时你也需要完全对它们的正确性负责。要创建一个在当前参与者（actor）上运行的非结构化任务，可调用 [`Task.init(priority:operation:)`](https://developer.apple.com/documentation/swift/task/3856790-init) 初始化方法。要创建一个不属于当前参与者的非结构化任务，也就是所谓的独立任务，可调用 [`Task.detached(priority:operation:)`](https://developer.apple.com/documentation/swift/task/3856786-detached) 类方法。这两种操作都会返回一个可以与之交互的任务，例如等待其结果或取消它。

```
let newPhoto = // ... 一些照片数据 ...
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value
```

有关管理独立任务的更多信息，请参阅《[任务](https://developer.apple.com/documentation/swift/task)》相关内容。

## 5 Actors 参与者

You can use tasks to break up your program into isolated, concurrent pieces. Tasks are isolated from each other, which is what makes it safe for them to run at the same time, but sometimes you need to share some information between tasks. Actors let you safely share information between concurrent code.

你可以使用任务将程序拆分为相互隔离的并发碎片。任务之间相互隔离，这使得它们可以安全地同时运行，但有时你需要在任务之间共享一些信息。Actor 可以让你在并发代码之间安全地共享信息。

Like classes, actors are reference types, so the comparison of value types and reference types in [Classes Are Reference Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures#Classes-Are-Reference-Types) applies to actors as well as classes. Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to interact with the same instance of an actor. For example, here’s an actor that records temperatures:

和类一样，Actor 也是引用类型，因此在《[类是引用类型](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures#Classes-Are-Reference-Types)》中对值类型和引用类型的比较同样适用于 Actor。与类不同的是，Actor 一次只允许一个任务访问其可变状态，这使得多个任务中的代码可以安全地与同一个 Actor 实例进行交互。例如，下面是一个记录温度的 Actor：

```
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
```

You introduce an actor with the `actor` keyword, followed by its definition in a pair of braces. The `TemperatureLogger` actor has properties that other code outside the actor can access, and restricts the `max` property so only code inside the actor can update the maximum value.

你可以使用 `actor` 关键字来声明一个 Actor，后面跟着用一对花括号括起来的定义。`TemperatureLogger` actor 拥有可供 actor 外部代码访问的属性，并且对 `max` 属性进行了限制，只有 actor 内部的代码才能更新这个最大值。

You create an instance of an actor using the same initializer syntax as structures and classes. When you access a property or method of an actor, you use `await` to mark the potential suspension point. For example:

```
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// Prints "25"
```

你可以使用与结构体和类相同的初始化语法来创建 actor 的实例。当你访问 actor 的属性或方法时，需要使用 `await` 来标记可能的暂停点。例如：

```
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// 输出 "25"
```

In this example, accessing `logger.max` is a possible suspension point. Because the actor allows only one task at a time to access its mutable state, if code from another task is already interacting with the logger, this code suspends while it waits to access the property.

在这个例子中，访问 `logger.max` 是一个可能的暂停点。因为 actor 一次只允许一个任务访问其可变状态，如果另一个任务的代码已经在与 logger 进行交互，那么这段代码会在等待访问该属性时暂停。

In contrast, code that’s part of the actor doesn’t write `await` when accessing the actor’s properties. For example, here’s a method that updates a `TemperatureLogger` with a new temperature:

相比之下，actor 内部的代码在访问 actor 的属性时不需要写 `await`。例如，下面是一个用新温度更新 `TemperatureLogger` 的方法：

```
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
```

The `update(with:)` method is already running on the actor, so it doesn’t mark its access to properties like `max` with `await`. This method also shows one of the reasons why actors allow only one task at a time to interact with their mutable state: Some updates to an actor’s state temporarily break invariants. The `TemperatureLogger` actor keeps track of a list of temperatures and a maximum temperature, and it updates the maximum temperature when you record a new measurement. In the middle of an update, after appending the new measurement but before updating `max`, the temperature logger is in a temporary inconsistent state. Preventing multiple tasks from interacting with the same instance simultaneously prevents problems like the following sequence of events:

1. Your code calls the `update(with:)` method. It updates the `measurements` array first.
2. Before your code can update `max`, code elsewhere reads the maximum value and the array of temperatures.
3. Your code finishes its update by changing `max`.

`update(with:)` 方法已经在 actor 上运行，因此它在访问 `max` 等属性时不需要用 `await` 标记。这个方法也展示了 actor 一次只允许一个任务与其可变状态进行交互的原因之一：对 actor 状态的某些更新会暂时破坏其不变性。`TemperatureLogger` actor 会跟踪一个温度列表和一个最高温度，并且在记录新测量值时会更新最高温度。在更新过程中，在添加新测量值之后但在更新 `max` 之前，温度记录器处于暂时不一致的状态。防止多个任务同时与同一个实例进行交互可以避免以下一系列事件导致的问题：

1. 你的代码调用 `update(with:)` 方法。它首先更新 `measurements` 数组。
2. 在你的代码更新 `max` 之前，其他地方的代码读取了最大值和温度数组。
3. 你的代码通过更改 `max` 完成更新。

In this case, the code running elsewhere would read incorrect information because its access to the actor was interleaved in the middle of the call to `update(with:)` while the data was temporarily invalid. You can prevent this problem when using Swift actors because they only allow one operation on their state at a time, and because that code can be interrupted only in places where `await` marks a suspension point. Because `update(with:)` doesn’t contain any suspension points, no other code can access the data in the middle of an update.

在这种情况下，其他地方运行的代码会读取到错误的信息，因为它对 actor 的访问穿插在了 `update(with:)` 调用的中间，而此时数据是暂时无效的。使用 Swift actor 可以避免这个问题，因为它们一次只允许对其状态进行一个操作，并且代码只能在 `await` 标记的暂停点处被中断。由于 `update(with:)` 不包含任何暂停点，在更新过程中没有其他代码可以访问这些数据。

If code outside the actor tries to access those properties directly, like accessing a structure or class’s properties, you’ll get a compile-time error. For example:

```
print(logger.max)  // Error
```

如果 actor 外部的代码试图像访问结构体或类的属性那样直接访问这些属性，你会得到一个编译时错误。例如：

```
print(logger.max)  // 错误
```

Accessing `logger.max` without writing `await` fails because the properties of an actor are part of that actor’s isolated local state. The code to access this property needs to run as part of the actor, which is an asynchronous operation and requires writing `await`. Swift guarantees that only code running on an actor can access that actor’s local state. This guarantee is known as _actor isolation_.

不写 `await` 就访问 `logger.max` 会失败，因为 actor 的属性是该 actor 隔离的局部状态的一部分。访问这个属性的代码需要作为 actor 的一部分运行，这是一个异步操作，需要写 `await`。Swift 保证只有在 actor 上运行的代码才能访问该 actor 的局部状态。这种保证被称为 **actor 隔离**。

The following aspects of the Swift concurrency model work together to make it easier to reason about shared mutable state:

- Code in between possible suspension points runs sequentially, without the possibility of interruption from other concurrent code.
- Code that interacts with an actor’s local state runs only on that actor.
- An actor runs only one piece of code at a time.

Swift 并发模型的以下几个方面协同工作，使得对共享可变状态的推理更加容易：

- 可能的暂停点之间的代码按顺序运行，不会被其他并发代码中断。
- 与 actor 局部状态交互的代码只能在该 actor 上运行。
- actor 一次只运行一段代码。

Because of these guarantees, code that doesn’t include `await` and that’s inside an actor can make the updates without a risk of other places in your program observing the temporarily invalid state. For example, the code below converts measured temperatures from Fahrenheit to Celsius:

由于这些保证，actor 内部不包含 `await` 的代码可以进行更新，而不用担心程序的其他地方会观察到暂时无效的状态。例如，下面的代码将测量的温度从华氏度转换为摄氏度：

```
extension TemperatureLogger {
    func convertFahrenheitToCelsius() {
        measurements = measurements.map { measurement in
            (measurement - 32) * 5 / 9
        }
    }
}
```

The code above converts the array of `measurements`, one at a time. While the map operation is in progress, some temperatures are in Fahrenheit and others are in Celsius. However, because none of the code includes `await`, there are no potential suspension points in this method. The state that this method modifies belongs to the actor, which protects it against code reading or modifying it except when that code runs on the actor. This means there’s no way for other code to read a list of partially converted temperatures while unit conversion is in progress.

上述代码会逐个转换 `measurements` 数组中的元素。在 map 操作进行过程中，有些温度是华氏度，有些是摄氏度。然而，由于代码中没有包含 `await`，这个方法中没有潜在的暂停点。这个方法修改的状态属于 actor，这可以防止除了在 actor 上运行的代码之外的其他代码读取或修改它。这意味着在单位转换进行过程中，其他代码不可能读取到部分转换的温度列表。

In addition to writing code in an actor that protects temporary invalid state by omitting potential suspension points, you can move that code into a synchronous method. The `convertFahrenheitToCelsius()` method above is a synchronous method, so it’s guaranteed to never contain potential suspension points. This function encapsulates the code that temporarily makes the data model inconsistent, and makes it easier for anyone reading the code to recognize that no other code can run before data consistency is restored by completing the work. In the future, if you try to add concurrent code to this function, introducing a possible suspension point, you’ll get compile-time error instead of introducing a bug.

除了在 actor 中编写通过去掉潜在暂停点来保护暂时无效状态的代码之外，你还可以将该代码移到一个同步方法中。上面的 `convertFahrenheitToCelsius()` 方法就是一个同步方法，因此可以保证它永远不会包含潜在的暂停点。这个函数封装了暂时使数据模型不一致的代码，并且让阅读代码的人更容易认识到在通过完成工作恢复数据一致性之前，没有其他代码可以运行。将来，如果你试图向这个函数添加并发代码，引入一个可能的暂停点，你会得到一个编译时错误，而不是引入一个 bug。

## 6 Sendable Types 可发送类型

Tasks and actors let you divide a program into pieces that can safely run concurrently. Inside of a task or an instance of an actor, the part of a program that contains mutable state, like variables and properties, is called a _concurrency domain_. Some kinds of data can’t be shared between concurrency domains, because that data contains mutable state, but it doesn’t protect against overlapping access.

任务和 actor 能让你将程序拆分成可以安全并发运行的部分。在任务内部或 actor 实例内部，程序中包含可变状态（如变量和属性）的部分被称为 **并发域**。有些类型的数据不能在并发域之间共享，因为这些数据包含可变状态，但又没有针对重叠访问进行保护。

A type that can be shared from one concurrency domain to another is known as a _sendable type_. For example, it can be passed as an argument when calling an actor method or be returned as the result of a task. The examples earlier in this chapter didn’t discuss sendability because those examples use simple value types that are always safe to share for the data being passed between concurrency domains. In contrast, some types aren’t safe to pass across concurrency domains. For example, a class that contains mutable properties and doesn’t serialize access to those properties can produce unpredictable and incorrect results when you pass instances of that class between different tasks.

可以从一个并发域共享到另一个并发域的类型被称为 **可发送类型**。例如，它可以作为参数在调用 actor 方法时传递，或者作为任务的结果返回。本章前面的示例没有讨论可发送性，因为这些示例使用的是简单的值类型，在并发域之间传递这些数据时始终是安全的。相比之下，有些类型跨并发域传递是不安全的。例如，一个包含可变属性且没有对这些属性的访问进行序列化处理的类，当你在不同任务之间传递该类的实例时，可能会产生不可预测和不正确的结果。

You mark a type as being sendable by declaring conformance to the `Sendable` protocol. That protocol doesn’t have any code requirements, but it does have semantic requirements that Swift enforces. In general, there are three ways for a type to be sendable:

- The type is a value type, and its mutable state is made up of other sendable data — for example, a structure with stored properties that are sendable or an enumeration with associated values that are sendable.
- The type doesn’t have any mutable state, and its immutable state is made up of other sendable data — for example, a structure or class that has only read-only properties.
- The type has code that ensures the safety of its mutable state, like a class that’s marked `@MainActor` or a class that serializes access to its properties on a particular thread or queue.

For a detailed list of the semantic requirements, see the [`Sendable`](https://developer.apple.com/documentation/swift/sendable) protocol reference.

你可以通过声明类型遵循 `Sendable` 协议来将其标记为可发送类型。该协议没有任何代码要求，但有 Swift 会强制执行的语义要求。一般来说，有三种方式可以让一个类型成为可发送类型：

- 该类型是值类型，并且其可变状态由其他可发送的数据组成 —— 例如，一个存储属性为可发送类型的结构体，或者关联值为可发送类型的枚举。
- 该类型没有任何可变状态，并且其不可变状态由其他可发送的数据组成 —— 例如，一个只有只读属性的结构体或类。
- 该类型有确保其可变状态安全的代码，比如用 `@MainActor` 标记的类，或者在特定线程或队列上对其属性的访问进行序列化处理的类。

有关语义要求的详细列表，请参阅 [`Sendable`](https://developer.apple.com/documentation/swift/sendable) 协议参考文档。

Some types are always sendable, like structures that have only sendable properties and enumerations that have only sendable associated values. For example:

有些类型始终是可发送的，比如只包含可发送属性的结构体和只包含可发送关联值的枚举。例如：

```
struct TemperatureReading: Sendable {
    var measurement: Int
}

extension TemperatureLogger {
    func addReading(from reading: TemperatureReading) {
        measurements.append(reading.measurement)
    }
}

let logger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger.addReading(from: reading)
```

Because `TemperatureReading` is a structure that has only sendable properties, and the structure isn’t marked `public` or `@usableFromInline`, it’s implicitly sendable. Here’s a version of the structure where conformance to the Sendable protocol is implied:

因为 `TemperatureReading` 是一个只包含可发送属性的结构体，并且该结构体没有被标记为 `public` 或 `@usableFromInline`，所以它是隐式可发送的。下面是一个该结构体隐式遵循 Sendable 协议的版本：

```
struct TemperatureReading {
    var measurement: Int
}
```

To explicitly mark a type as not being sendable, overriding an implicit conformance to the `Sendable` protocol, use an extension:

要显式地将一个类型标记为不可发送，从而覆盖其对 `Sendable` 协议的隐式遵循，可以使用扩展：

```
struct FileDescriptor {
    let rawValue: CInt
}

@available(*, unavailable)
extension FileDescriptor: Sendable { }
```

The code above shows part of a wrapper around POSIX file descriptors. Even though interface for file descriptors uses integers to identify and interact with open files, and integer values are sendable, a file descriptor isn’t safe to send across concurrency domains.

上述代码展示了一个围绕 POSIX 文件描述符的包装器的部分内容。尽管文件描述符的接口使用整数来标识和与打开的文件进行交互，并且整数值是可发送的，但文件描述符跨并发域发送是不安全的。

In the code above, the `FileDescriptor` is a structure that meets the criteria to be implicitly sendable. However, the extension makes its conformance to `Sendable` unavailable, preventing the type from being sendable.

在上述代码中，`FileDescriptor` 是一个满足隐式可发送条件的结构体。然而，这个扩展让它对 `Sendable` 协议的遵循不可用，从而阻止该类型成为可发送类型。