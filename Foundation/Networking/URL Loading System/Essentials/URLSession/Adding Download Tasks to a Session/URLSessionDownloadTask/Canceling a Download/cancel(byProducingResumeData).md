# cancel(byProducingResumeData:)

原文地址：
[https://developer.apple.com/documentation/foundation/urlsessiondownloadtask/1411634-cancel](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask/1411634-cancel)

>__Framework__
>
> Foundation
>
>__SDKs__
>
>iOS 7.0+ | iPadOS 7.0+ | macOS 10.9+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Cancels a download and calls a callback with resume data for later use.

取消下载并调用回调，在回调中带有供以后使用的恢复数据。

# Declaration 声明
```
func cancel(byProducingResumeData completionHandler: @escaping @Sendable (Data?) -> Void)
```

# Parameters 参数
## completionHandler

A completion handler that is called when the download has been successfully canceled.

成功取消下载时调用的完成处理程序。

If the download is resumable, the completion handler is provided with a `resumeData` object. Your app can later pass this object to a session’s [downloadTask(withResumeData:)](https://developer.apple.com/documentation/foundation/urlsession/1409226-downloadtask) or [downloadTask(withResumeData:completionHandler:)](https://developer.apple.com/documentation/foundation/urlsession/1411598-downloadtask) method to create a new task that resumes the download where it left off.

如果下载是可恢复的，则会为完成处理程序提供一个 `resumeData` 对象。您的应用程序稍后可以将此对象传递给会话的 [downloadTask(withResumeData:)](https://developer.apple.com/documentation/foundation/urlsession/1409226-downloadtask) 或 [downloadTask(withResumeData:completionHandler:)](https://developer.apple.com/documentation/foundation/urlsession/1411598-downloadtask) 方法，以创建一个新任务，从停止的位置恢复下载。

This block is not guaranteed to execute in a particular thread context. As such, you may want specify an appropriate dispatch queue in which to perform any work.

这个 block 不能保证在特定的线程上下文中执行。因此，您可能需要指定一个适当的调度队列来执行任何工作。

# Discussion 讨论

> **Concurrency Note** **并发说明**
>
> You can call this method from synchronous code using a completion handler, as shown on this page, or you can call it as an asynchronous method that has the following declaration:
> 
> 您可以使用完成处理程序从同步代码中调用此方法，如本页所示，也可以将其作为具有以下声明的异步方法进行调用：
>
> ```
> func cancelByProducingResumeData() async -> Data?
> ```
> 
> For information about concurrency and asynchronous code in Swift, see [Calling Objective-C APIs Asynchronously](https://developer.apple.com/documentation/swift/calling-objective-c-apis-asynchronously).
> 
> 有关 Swift 中并发和异步代码的信息，请参阅《[异步调用 Objective-C API](https://developer.apple.com/documentation/swift/calling-objective-c-apis-asynchronously)》。

A download can be resumed only if the following conditions are met:

只有满足以下条件的下载才能被恢复：

- The resource has not changed since you first requested it
- The task is an `HTTP` or `HTTPS GET` request
- The server provides either the `ETag` or `Last-Modified` header (or both) in its response
- The server supports byte-range requests
- The temporary file hasn’t been deleted by the system in response to disk space pressure

- 自您第一次请求以来，资源没有更改
- 该任务是 `HTTP` 或 `HTTPS GET` 请求
- 服务器在其响应中提供 `ETag` 或 `Last Modified` 头（或同时提供两者）
- 服务器支持字节范围请求
- 系统没有由于磁盘空间压力删除临时文件