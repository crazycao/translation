# downloadTask(with:completionHandler:)

原文地址：
[https://developer.apple.com/documentation/foundation/urlsession/1411608-downloadtask](https://developer.apple.com/documentation/foundation/urlsession/1411608-downloadtask)

>__Framework__
>
> Foundation
>
>__SDKs__
>
>iOS 7.0+ | iPadOS 7.0+ | macOS 10.9+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Creates a download task that retrieves the contents of the specified URL, saves the results to a file, and calls a handler upon completion.

创建一个下载任务，该任务检索指定 URL 的内容，将结果保存到文件中，并在完成后调用处理程序。

# Declaration 声明
```
func downloadTask(with url: URL, 
         completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
```

# Parameters 参数
## url
The URL to download.

要下载的 URL。

## completionHandler
The completion handler to call when the load request is complete. This handler is executed on the delegate queue.

加载请求完成时要调用的完成处理程序。此处理程序在代理队列上执行。

If you pass `nil`, only the session delegate methods are called when the task completes, making this method equivalent to the [downloadTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411482-downloadtask) method.

如果传入 `nil`，则在任务完成时只会调用会话的代理方法，此时该方法等效于 [downloadTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411482-downloadtask)  方法。

This completion handler takes the following parameters:

完成处理程序有下面这些参数：

- location

	The location of a temporary file where the server’s response is stored. You must move this file or open it for reading before your completion handler returns. Otherwise, the file is deleted, and the data is lost.
	
	存放服务器响应的临时文件的位置。在完成处理程序返回之前，必须移动或打开此文件进行读取。否则，文件将被删除，数据将丢失。

- response

	An object that provides response metadata, such as HTTP headers and status code. If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
	
	提供响应元数据（如HTTP头和状态代码）的对象。如果发出HTTP或HTTPS请求，则返回的对象实际上是HTTPURLResponse对象。

- error

	An error object that indicates why the request failed, or `nil` if the request was successful.
	
	一个错误对象，指示请求失败的原因；如果请求成功，则为 `nil`。
	
# Return Value 返回值
The new session download task.

新的会话下载任务。

# Discussion 讨论
By using the completion handler, the task bypasses calls to delegate methods for response and data delivery, and instead provides any resulting [NSData](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PropertyLists/OldStylePlists/OldStylePLists.html#//apple_ref/doc/uid/20001012-47169), [URLResponse](https://developer.apple.com/documentation/foundation/urlresponse), and [NSError](https://developer.apple.com/documentation/foundation/nserror) objects inside the completion handler. Delegate methods for handling authentication challenges, however, are still called.

通过使用完成处理程序，任务将绕过对代理方法进行响应和数据传递的调用，而是在完成处理程序中提供所生成的 [NSData](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/PropertyLists/OldStylePlists/OldStylePLists.html#//apple_ref/doc/uid/20001012-47169)、[URLResponse](https://developer.apple.com/documentation/foundation/urlresponse) 和 [NSError](https://developer.apple.com/documentation/foundation/nserror) 对象。但是，仍会调用用于处理身份验证挑战的代理方法。

You should pass a nil completion handler **only** when creating tasks in sessions whose delegates include a [urlSession(_:downloadTask:didFinishDownloadingTo:)](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1411575-urlsession) method.

**仅当**在代理中包含 [urlSession(_:downloadTask:didFinishDownloadingTo:)](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1411575-urlsession) 方法的会话中创建任务时，才应传递 `nil` 给 `completionHandler`。

After you create the task, you must start it by calling its [resume()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411121-resume) method.

创建任务后，必须通过调用其 [resume()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411121-resume) 方法启动任务。

If the request completes successfully, the `location` parameter of the completion handler block contains the location of the temporary file, and the `error` parameter is `nil`. If the request fails, the `location` parameter is `nil` and the error parameter contain information about the failure. If a response from the server is received, regardless of whether the request completes successfully or fails, the `response` parameter contains that information.

如果请求成功完成，则完成处理程序块的 `location ` 参数包含临时文件的位置，而 `error` 参数为 `nil`。如果请求失败，则 `location` 参数为 `nil`，而 `error` 参数包含有关失败的信息。如果接收到来自服务器的响应，无论请求是否成功完成，`response` 参数都会包含该信息。

# See Also 其它参考

## Adding Download Tasks to a Session

### func [downloadTask(with: URL) -> URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsession/1411482-downloadtask)

Creates a download task that retrieves the contents of the specified URL and saves the results to a file.

### func [downloadTask(with: URLRequest) -> URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsession/1411481-downloadtask)

Creates a download task that retrieves the contents of a URL based on the specified URL request object and saves the results to a file.

### func [downloadTask(with: URLRequest, completionHandler: (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsession/1411511-downloadtask)

Creates a download task that retrieves the contents of a URL based on the specified URL request object, saves the results to a file, and calls a handler upon completion.

### func [downloadTask(withResumeData: Data) -> URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsession/1409226-downloadtask)

Creates a download task to resume a previously canceled or failed download.

### func [downloadTask(withResumeData: Data, completionHandler: (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsession/1411598-downloadtask)

Creates a download task to resume a previously canceled or failed download and calls a handler upon completion.

### class [URLSessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask)

A URL session task that stores downloaded data to a file.

### protocol [URLSessionDownloadDelegate](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate)

A protocol that defines methods that URL session instances call on their delegates to handle task-level events specific to download tasks.
