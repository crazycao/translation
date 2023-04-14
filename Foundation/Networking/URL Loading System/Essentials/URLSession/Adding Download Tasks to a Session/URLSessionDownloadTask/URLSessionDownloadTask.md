# URLSessionDownloadTask

原文地址：
[https://developer.apple.com/documentation/foundation/urlsessiondownloadtask](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask)

>__Framework__
>
> Foundation
>
>__SDKs__
>
>iOS 7.0+ | iPadOS 7.0+ | macOS 10.9+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

A URL session task that stores downloaded data to a file.

将下载的数据存储到文件中的URL会话任务。

# Declaration 声明
```
class URLSessionDownloadTask : URLSessionTask
```

# Overview 概览

An URLSessionDownloadTask is a concrete subclass of URLSessionTask, which provides most of the methods for this class.

`URLSessionDownloadTask` 是 `URLSessionTask` 的一个具体子类， `URLSessionTask`  为其提供了大部分方法。

Download tasks directly write the server’s response data to a temporary file, providing your app with progress updates as data arrives from the server. When you use download tasks in background sessions, these downloads continue even when your app is in the suspended state or otherwise not running.

下载任务直接将服务器的响应数据写入临时文件，在数据从服务器到达时为您的应用程序提供进度更新。当您在后台会话中使用下载任务时，即使您的应用程序处于挂起状态或未运行，这些下载也会继续。

You can pause (cancel) download tasks and resume them later (assuming the server supports doing so). You can also resume downloads that failed because of network connectivity problems.

您可以暂停（取消）下载任务，然后再继续（假设服务器支持这样做）。您也可以恢复因网络连接问题而失败的下载。


## Download Delegate Behavior 下载代理行为

When you use a download task, your delegate receives several callbacks unique to download scenarios.

当您使用下载任务时，您的代理会收到几个下载场景特有的回调。

- During download, the session periodically calls the delegate’s [urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1409408-urlsession) method with status information.

- 在下载过程中，会话定期调用代理的 [urlSession(_:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1409408-urlsession) 方法，传入状态信息。

- Upon successful completion, the session calls the delegate’s [urlSession(_:downloadTask:didFinishDownloadingTo:)](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1411575-urlsession) method or completion handler. In that method, you must either open the file for reading or move it to a permanent location in your app’s sandbox container directory.

- 成功完成后，会话调用代理的 [urlSession(_:downloadTask:didFinishDownloadingTo:)](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate/1411575-urlsession) 方法或完成处理程序。在这个方法中，您必须打开文件进行读取，或者将其移动到应用程序沙盒容器目录中的永久位置。

- Upon unsuccessful completion, the session calls the delegate’s [urlSession(_:task:didCompleteWithError:)](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate/1411610-urlsession) method or completion handler. The only errors your delegate receives through the error parameter are client-side errors, such as being unable to resolve the hostname or connect to the host. To check for server-side errors, inspect the [response](https://developer.apple.com/documentation/foundation/urlsessiontask/1410586-response) property of the task parameter received by this callback.

- 在未成功完成时，会话调用代理的 [urlSession(_:task:didCompleteWithError:)](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate/1411610-urlsession) 方法或完成处理程序。代理通过 error 参数接收到的错误只有客户端错误，例如无法解析主机名或连接到主机。要检查服务器端错误，请检查此回调接收到的任务参数的  [response](https://developer.apple.com/documentation/foundation/urlsessiontask/1410586-response) 属性。

# Topics 主题

## Canceling a Download 取消下载

- [func cancel(byProducingResumeData: (Data?) -> Void)](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask/1411634-cancel)

	Cancels a download and calls a callback with resume data for later use.

	取消下载并调用回调，在回调中带有供以后使用的恢复数据。

## Creating Download Tasks 创建下载任务

- [init()](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask/3240620-init) 【Deprecated】

	Initializes a download task.
	
	初始化下载任务。

- [class func new() -> Self](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask/3240621-new) 【Deprecated】

	Creates and initializes a download task.

	创建并初始化下载任务。