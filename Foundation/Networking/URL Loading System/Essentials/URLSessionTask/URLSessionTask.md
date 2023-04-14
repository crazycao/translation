# URLSessionTask

原文地址：[https://developer.apple.com/documentation/foundation/urlsessiontask](https://developer.apple.com/documentation/foundation/urlsessiontask)

> iOS 7.0+
iPadOS 7.0+
macOS 10.9+
Mac Catalyst 13.1+
tvOS 9.0+
watchOS 2.0+

A task, like downloading a specific resource, performed in a URL session.

在 URL 会话中执行的任务，如下载特定资源。

# Declaration 声明

```
class URLSessionTask : NSObject
```

# Overview 概览

The `URLSessionTask` class is the base class for tasks in a URL session. Tasks are always part of a session; you create a task by calling one of the task creation methods on a [URLSession](https://developer.apple.com/documentation/foundation/urlsession) instance. The method you call determines the type of task.

`URLSessionTask` 类是 URL 会话中任务的基类。任务总是会话的一部分；您可以通过调用 [URLSession](https://developer.apple.com/documentation/foundation/urlsession) 实例上的任一任务创建方法来创建任务。您调用的方法决定了任务的类型。

- Use `URLSession`’s [dataTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411554-datatask) and related methods to create [URLSessionDataTask](https://developer.apple.com/documentation/foundation/urlsessiondatatask) instances. Data tasks request a resource, returning the server’s response as one or more `NSData` objects in memory. They are supported in default, ephemeral, and shared sessions, but are not supported in background sessions.

	使用 `URLSession` 的 [dataTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411554-datatask) 和相关方法创建 [URLSessionDataTask](https://developer.apple.com/documentation/foundation/urlsessiondatatask) 实例。数据任务请求资源，将服务器的响应作为内存中的一个或多个 `NSData` 对象返回。它们在默认会话、临时会话和共享会话中受支持，但在后台会话中不受支持。

- Use `URLSession`’s [uploadTask(with:from:)](https://developer.apple.com/documentation/foundation/urlsession/1409763-uploadtask) and related methods to create [URLSessionUploadTask](https://developer.apple.com/documentation/foundation/urlsessionuploadtask) instances. Upload tasks are like data tasks, except that they make it easier to provide a request body so you can upload data before retrieving the server’s response. Additionally, upload tasks are supported in background sessions.

	使用 `URLSession` 的 [uploadTask(with:from:)](https://developer.apple.com/documentation/foundation/urlsession/1409763-uploadtask) 和相关方法来创建 [URLSessionUploadTask](https://developer.apple.com/documentation/foundation/urlsessionuploadtask) 实例。上传任务与数据任务类似，只是它们可以更容易地提供请求主体，以便您可以在检索服务器响应之前上传数据。此外，后台会话支持上传任务。

- Use `URLSession`’s [downloadTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411482-downloadtask) and related methods to create [URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask) instances. Download tasks download a resource directly to a file on disk. Download tasks are supported in any type of session.

	使用 `URLSession` 的 [downloadTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411482-downloadtask) 和相关方法创建 [URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask) 实例。下载任务将资源直接下载到磁盘上的文件中。任何类型的会话都支持下载任务。

- Use `URLSession`’s [streamTask(withHostName:port:)](https://developer.apple.com/documentation/foundation/urlsession/1411587-streamtask) or [streamTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411545-streamtask) to create [URLSessionStreamTask](https://developer.apple.com/documentation/foundation/urlsessionstreamtask) instances. Stream tasks establish a TCP/IP connection from a host name and port or a net service object.

	使用 `URLSession` 的 [streamTask(withHostName:port:)](https://developer.apple.com/documentation/foundation/urlsession/1411587-streamtask) 或 [streamTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411545-streamtask) 创建 [URLSessionStreamTask](https://developer.apple.com/documentation/foundation/urlsessionstreamtask) 实例。流任务从主机名和端口或网络服务对象建立 TCP/IP 连接。

After you create a task, you start it by calling its [resume()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411121-resume) method. The session then maintains a strong reference to the task until the request finishes or fails; you don’t need to maintain a reference to the task unless it’s useful for your app’s internal bookkeeping.

创建任务后，通过调用其 [resume()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411121-resume) 方法来启动它。然后，会话保持对任务的强引用，直到请求完成或失败；你不需要维护对任务的引用，除非它对你的应用程序的内部业务有用。

> **Note** **说明**
>
> All task properties support key-value observing.
> 
> 所有的任务属性都支持键值观察。

# Topics 主题

## Controlling the Task State 控制任务状态

- func cancel()

	Cancels the task.
	
	取消任务。
	
- func resume()

	Resumes the task, if it is suspended.
	
	如果任务被挂起，则恢复任务。
	
- func suspend()

	Temporarily suspends a task.
	
	临时挂起任务。
	
- var state: URLSessionTask.State

	The current state of the task—active, suspended, in the process of being canceled, or completed.
	
	任务当前的状态——活跃、挂起、取消过程中 或者 已完成。
	
- enum URLSessionTask.State

	Constants for determining the current state of a task.
	
	定义任务当前状态的常量。
	
- var priority: Float

	The relative priority at which you’d like a host to handle the task, specified as a floating point value between `0.0` (lowest priority) and `1.0` (highest priority).
	
	您希望主机处理任务的相对优先级，指定为 `0.0`（最低优先级）和 `1.0`（最高优先级）之间的浮点值。
	
- URL Session Task Priority

	Constants for providing task priority hints to a host, used with the `priority` property.
	
	用于向主机提供任务优先级提示的常量，与 `priority` 属性一起使用。
	
## Obtaining Task Progress 获取任务进度

- var progress: Progress

	A representation of the overall task progress.
	
	整个任务进度的表示。
	
- var countOfBytesExpectedToReceive: Int64

	The number of bytes that the task expects to receive in the response body.
	
	任务期望在响应体中接收的字节数。
	
- var countOfBytesReceived: Int64

	The number of bytes that the task has received from the server in the response body.
	
	任务在响应体中从服务器接收的字节数。
	
- var countOfBytesExpectedToSend: Int64

	The number of bytes that the task expects to send in the request body.
	
	任务期望在请求体中发送的字节数。
	
- var countOfBytesSent: Int64

	The number of bytes that the task has sent to the server in the request body.
	
	任务在请求体中发到服务器的字节数。
	
- let NSURLSessionTransferSizeUnknown: Int64

	The total size of the transfer cannot be determined.
	
	无法确定传输的总大小。
	
## Obtaining General Task Information 获取通用任务信息

- var currentRequest: URLRequest?

	The URL request object currently being handled by the task.
	
	任务当前正在处理的 URL 请求对象。
	
- var originalRequest: URLRequest?

	The original request object passed when the task was created.
	
	任务创建时传入的原始请求对象。
	
- var response: URLResponse?

	The server’s response to the currently active request.
	
	当前活跃的请求的服务端响应。
	
- var taskDescription: String?

	An app-provided string value for the current task.
	
	App 为当前任务提供的字符串值。
	
- var taskIdentifier: Int

	An identifier uniquely identifying the task within a given session.
	
	在给定会话中唯一标识任务的标识符。
	
- var error: Error?

	An error object that indicates why the task failed.
	
	表明任务为什么会失败的错误对象。
	
## Determining Task Behavior 定义任务行为

- var prefersIncrementalDelivery: Bool

	A Boolean value that determines whether to deliver a partial response body in increments.
	
	一个布尔值，用于确定是否以增量传递部分响应正文。
	
## Using a Task-Specific Delegate 使用特定任务的代理

- var delegate: URLSessionTaskDelegate?
	
	A delegate specific to the task.
	
	特定任务的代理。
	
- protocol URLSessionTaskDelegate

	A protocol that defines methods that URL session instances call on their delegates to handle task-level events.
	
	用于定义 URL 会话实例调用其代理来处理任务级事件的方法的协议。
	
## Scheduling Tasks 安排任务

- var countOfBytesClientExpectsToReceive: Int64

	A best-guess upper bound on the number of bytes the client expects to receive.
	
	客户端预期接收的字节数的最佳猜测上限。
	
- var countOfBytesClientExpectsToSend: Int64

	A best-guess upper bound on the number of bytes the client expects to send.
	
	客户端预期发送的字节数的最佳猜测上限。
	
- let NSURLSessionTransferSizeUnknown: Int64

	The total size of the transfer cannot be determined.
	
	无法确定传输的总大小。
	
- var earliestBeginDate: Date?

	The earliest date at which the network load should begin.
	
	网络加载应开始的最早日期。

## Deprecated 弃用

- init() 【Deprecated】

	Initializes an empty URL sesson task.
	
	初始化一个空的 URL 会话任务。
	

- class func new() -> Self 【Deprecated】

	Creates a new URL session task.
	
	创建一个新的 URL 会话任务。


# Relationships 关系

## Inherits From 继承
- NSObject

## Conforms To
- NSCopying
- ProgressReporting
- Sendable

# See Also 其它参考

## Essentials - 要素

### Fetching Website Data into Memory 将网站数据提取到内存中

Receive data directly into memory by creating a data task from a URL session.

通过从URL会话创建数据任务，将数据直接接收到内存中。

### Analyzing HTTP Traffic with Instruments 使用 Instruments 分析 HTTP 流量

Measure HTTP-based network performance and usage of your apps.

测量基于 HTTP 的网络性能和应用程序的使用情况。

### class URLSession

An object that coordinates a group of related, network data transfer tasks.

协调一组相关的网络数据传输任务的对象。
