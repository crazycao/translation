# Fetching Website Data into Memory - 将网站数据提取到内存中

原文地址：[https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)

> **Framework**
>
> Foundation

Receive data directly into memory by creating a data task from a URL session.

通过从 URL 会话创建数据任务，将数据直接接收到内存中。

# Overview 概览

For small interactions with remote servers, you can use the [URLSessionDataTask](https://developer.apple.com/documentation/foundation/urlsessiondatatask) class to receive response data into memory (as opposed to using the [URLSesessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask) class, which stores the data directly to the file system). A data task is ideal for uses like calling a web service endpoint.

对于与远程服务器的小型交互，可以使用 [URLSessionDataTask](https://developer.apple.com/documentation/foundation/urlsessiondatatask) 类将响应数据接收到内存中（与使用 [URLSesessionDownloadTask](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask) 类相反，后者将数据直接存储到文件系统）。数据任务非常适合于调用 web 服务终端等用途。

You use a URL session instance to create the task. If your needs are fairly simple, you can use the [shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared) instance of the [URLSession](https://developer.apple.com/documentation/foundation/urlsession) class. If you want to interact with the transfer through delegate callbacks, you’ll need to create a session instead of using the shared instance. You use a [URLSessionConfiguration](https://developer.apple.com/documentation/foundation/urlsessionconfiguration) instance when creating a session, also passing in a class that implements [URLSessionDelegate](https://developer.apple.com/documentation/foundation/urlsessiondelegate) or one of its subprotocols. Sessions can be reused to create multiple tasks, so for each unique configuration you need, create a session and store it as a property.

您可以使用 URL 会话实例来创建任务。如果您的需求相当简单，那么可以使用 [URLSession](https://developer.apple.com/documentation/foundation/urlsession) 类的[共享](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared)实例。如果希望通过委托回调与传输器交互，则需要创建会话，而不是使用共享实例。在创建会话时，您可以使用 [URLSessionConfiguration](https://developer.apple.com/documentation/foundation/urlsessionconfiguration) 实例，也可以传入实现 [URLSessionDelegate](https://developer.apple.com/documentation/foundation/urlsessiondelegate) 或它的某个子协议的类。会话可以重用以创建多个任务，因此对于每个您需要的独特配置，都可以创建一个会话并将其存储为属性。

> **Note** **注意**
>
> Be careful to not create more sessions than you need. For example, if you have several parts of your app that need a similarly configured session, create one session and share it among them.
> 
> 小心不要创建超过需要的会话。例如，如果你的应用程序有几个部分需要类似配置的会话，那么创建一个会话并在它们之间共享。

Once you have a session, you create a data task with one of the `dataTask()` methods. Tasks are created in a suspended state, and can be started by calling [resume()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411121-resume).

一旦您有了一个会话，您就可以使用  `dataTask()` 等方法来创建数据任务。任务是在挂起状态下创建的，可以通过调用 [resume()](https://developer.apple.com/documentation/foundation/urlsessiontask/1411121-resume) 来启动。

## Receive Results with a Completion Handler - 使用完成处理程序接收结果

The simplest way to fetch data is to create a data task that uses a completion handler. With this arrangement, the task delivers the server’s response, data, and possibly errors to a completion handler block that you provide. Figure 1 shows the relationship between a session and a task, and how results are delivered to the completion handler.

获取数据的最简单方法是创建一个使用完成处理程序的数据任务。通过这种安排，任务将服务器的响应、数据和可能的错误传递给您提供的完成处理程序块。图1显示了会话和任务之间的关系，以及结果如何传递给完成处理程序。

**Figure 1** Creating a completion handler to receive results from a task

**图1** 创建从任务接收结果的完成处理程序
![Figure showing a URL Session creating a URL Session Data Task. The task then sends the original request, retrieved data, or an error to the completion handler.](https://docs-assets.developer.apple.com/published/c7124fb5d7/bf4501ff-82b2-4dd4-9ec3-243ef0e70d21.png)

To create a data task that uses a completion handler, call the [dataTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411554-datatask) method of `URLSession`. Your completion handler needs to do three things:

要创建使用完成处理程序的数据任务，请调用 `URLSession` 的 [dataTask(with:)](https://developer.apple.com/documentation/foundation/urlsession/1411554-datatask) 方法。您的完成处理程序需要做三件事：

1. Verify that the error parameter is `nil`. If not, a transport error has occurred; handle the error and exit.
2. Check the response parameter to verify that the status code indicates success and that the MIME type is an expected value. If not, handle the server error and exit.
3. Use the data instance as needed.

>

1. 验证错误参数是否为 `nil`。如果不是，表示发生了传输错误；处理错误并退出。
2. 检查响应参数以验证状态代码是否指示成功，以及 MIME 类型是否为预期值。如果没有，请处理服务器错误并退出。
3. 根据需要使用数据实例。


Listing 1 shows a `startLoad()` method for fetching a URL’s contents. It starts by using the `URLSession` class’s shared instance to create a data task that delivers its results to a completion handler. After checking for local and server errors, this handler converts the data to a string, and uses it to populate a `WKWebView` outlet. Of course, your app might have other uses for fetched data, like parsing it into a data model.

清单1显示了一个用于获取 URL 内容的 `startLoad()` 方法。它首先使用 `URLSession` 类的共享实例创建一个数据任务，将其结果传递给完成处理程序。在检查本地和服务器错误后，此处理程序将数据转换为字符串，并使用它填充 `WKWebView` 出口。当然，你的应用程序还可能将获取的数据用于其他的用途，比如将其解析为数据模型。

**Listing 1** Creating a completion handler to receive data-loading results

**清单1** 创建一个接收数据加载结果的完成处理程序

```
func startLoad() {
    let url = URL(string: "https://www.example.com/")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            self.handleClientError(error)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            self.handleServerError(response)
            return
        }
        if let mimeType = httpResponse.mimeType, mimeType == "text/html",
            let data = data,
            let string = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.webView.loadHTMLString(string, baseURL: url)
            }
        }
    }
    task.resume()
}
```

> **Important** **重要**
>
> The completion handler is called on a different Grand Central Dispatch queue than the one that created the task. Therefore, any work that uses data or error to update the UI — like updating webView — should be explicitly placed on the main queue, as shown here.
> 
> 完成处理程序在与创建任务的队列不同的 GCD 队列上调用。因此，任何使用数据或错误来更新UI的工作（如更新webView）都应该显式地放在主队列中，如上所示。


## Receive Transfer Details and Results with a Delegate - 使用代理接收传输详情和结果

For a greater level of access to the task’s activity as it proceeds, when creating the data task, you can set a delegate on the session, rather than providing a completion handler. Figure 2 shows this arrangement.

在创建数据任务时，为了更精确地访问任务的活动，可以在会话上设置委托，而不是提供完成处理程序。图2显示了这种安排。

**Figure 2** Implementing a delegate to receive results from a task

**图2** 实现委托以接收任务结果
![Figure showing a URLSession creating a URLSessionDataTask. The session calls back to the delegate with progress updates, retrieved data, authentication challenges, etc.](https://docs-assets.developer.apple.com/published/8b22355c7f/730c8e1b-654f-4eb9-9c63-d439a69ac5d2.png)

With this approach, portions of the data are provided to the [urlSession(_:dataTask:didReceive:)](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1411528-urlsession) method of URLSessionDataDelegate as they arrive, until the transfer finishes or fails with an error. The delegate also receives other kinds of events as the transfer proceeds.

使用这种方法，部分数据在到达时就被提供给 [URLSessionDataDelegate](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate) 的 [urlSession(_:dataTask:didReceive:)](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1411528-urlsession) 方法，直到传输完成或出现错误。在传输过程中，代理还会接收其他类型的事件。

You need to create your own URLSession instance when using the delegate approach, rather than using the URLSession class’s simple shared instance. Creating a new session allows you to set your own class as the session’s delegate, as shown in Listing 2.

当使用委托方法时，您需要创建自己的 `URLSession` 实例，而不是使用 `URLSession` 类的简单共享实例。创建新会话允许您将自己的类设置为会话的委托，如清单2所示。

Declare that your class implements one or more of the delegate protocols ([URLSessionDelegate](https://developer.apple.com/documentation/foundation/urlsessiondelegate), [URLSessionTaskDelegate](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate), [URLSessionDataDelegate](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate), and [URLSessionDownloadDelegate](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate)). Then create the URL session instance with the initializer [init(configuration:delegate:delegateQueue:)](https://developer.apple.com/documentation/foundation/urlsession/1411597-init). You can customize the configuration instance used with this initializer. For example, it’s a good idea to set [waitsForConnectivity](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/2908812-waitsforconnectivity) to `true`. That way, the session waits for suitable connectivity, rather than failing immediately if the required connectivity is unavailable.

首先声明你的类实现了一个或多个委托协议（[URLSessionDelegate](https://developer.apple.com/documentation/foundation/urlsessiondelegate), [URLSessionTaskDelegate](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate), [URLSessionDataDelegate](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate) 和 [URLSessionDownloadDelegate](https://developer.apple.com/documentation/foundation/urlsessiondownloaddelegate)）。然后使用初始化方法 [init(configuration:delegate:delegateQueue:)](https://developer.apple.com/documentation/foundation/urlsession/1411597-init) 创建 URL 会话实例。您可以自定义与此初始化方法一起使用的配置实例。例如，最好将 [waitsForConnectivity](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/2908812-waitsforconnectivity) 设置为 `true`。这样，会话将等待合适的连接，而不是在所需的连接不可用时立即失败。

**Listing 2** Creating a URLSession that uses a delegate

**清单2** 创建使用代理的 URLSession

```
private lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    return URLSession(configuration: configuration,
                      delegate: self, delegateQueue: nil)
}()
```

Listing 3 shows a `startLoad()` method that uses this session to start a data task, and uses delegate callbacks to handle received data and errors. This listing implements three delegate callbacks:

清单3显示了一个 `startLoad()` 方法，该方法使用此会话启动数据任务，并使用委托回调来处理收到的数据和错误。此列表实现了三个委托回调：

- [urlSession(_:dataTask:didReceive:completionHandler:)](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1410027-urlsession) verifies that the response has a succesful HTTP status code, and that the MIME type is `text/html` or `text/plain`. If either of these is not the case, the task is canceled; otherwise, it’s allowed to proceed.
-  [urlSession(_:dataTask:didReceive:completionHandler:)](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1410027-urlsession) 验证响应中是否具有成功的 HTTP 状态代码，以及 MIME 类型是否为 `text/html` 或 `text/plain`。如果两者中的任何一个都不是这样，则任务被取消；否则，允许继续。

- [urlSession(_:dataTask:didReceive:)](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1411528-urlsession) takes each `Data` instance received by the task and appends it to a buffer called `receivedData`.
- [urlSession(_:dataTask:didReceive:)](https://developer.apple.com/documentation/foundation/urlsessiondatadelegate/1411528-urlsession) 获取任务接收到的每个 `Data` 实例，并将其添加到名为 `receivedData` 的缓冲区。

- [urlSession(_:task:didCompleteWithError:)](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate/1411610-urlsession) first looks to see if a transport-level error has occurred. If there is no error, it attempts to convert the `receivedData` buffer to a string and set it as the contents of webView.
- [urlSession(_:task:didCompleteWithError:)](https://developer.apple.com/documentation/foundation/urlsessiontaskdelegate/1411610-urlsession) 首先查看是否发生了传输级错误。如果没有错误，它会尝试将 `receivedData` 缓冲区转换为字符串，并将其设置为webView的内容。

**Listing 3** Using a delegate with a URL session data task
**清单3** 对 URL 会话数据任务一起使用代理

```
var receivedData: Data?

func startLoad() {
    loadButton.isEnabled = false
    let url = URL(string: "https://www.example.com/")!
    receivedData = Data()
    let task = session.dataTask(with: url)
    task.resume()
}

// delegate methods

func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse,
                completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
    guard let response = response as? HTTPURLResponse,
        (200...299).contains(response.statusCode),
        let mimeType = response.mimeType,
        mimeType == "text/html" else {
        completionHandler(.cancel)
        return
    }
    completionHandler(.allow)
}

func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    self.receivedData?.append(data)
}

func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    DispatchQueue.main.async {
        self.loadButton.isEnabled = true
        if let error = error {
            handleClientError(error)
        } else if let receivedData = self.receivedData,
            let string = String(data: receivedData, encoding: .utf8) {
            self.webView.loadHTMLString(string, baseURL: task.currentRequest?.url)
        }
    }
}
```

The various delegate protocols offer methods beyond those shown in the above code, for handling authentication challenges, following redirects, and other special cases. Using a URL Session, in the `URLSession` discussion, describes the various callbacks that may occur during a transfer.

除了上述代码中所示的方法外，各种委托协议还提供了处理身份验证挑战、重定向和其他特殊情况的方法。在 `URLSession` 讨论中，使用 URL 会话描述了传输过程中可能发生的各种回调。

# See Also 其它参考

## Essentials - 要素

### Analyzing HTTP Traffic with Instruments - 使用 Instruments 分析 HTTP 流量

Measure HTTP-based network performance and usage of your apps.

测量基于 HTTP 的网络性能和应用程序的使用情况。

### class [URLSession](https://developer.apple.com/documentation/foundation/urlsession)

An object that coordinates a group of related, network data transfer tasks.

协调一组相关网络数据传输任务的对象。

### class [URLSessionTask](https://developer.apple.com/documentation/foundation/urlsessiontask)

A task, like downloading a specific resource, performed in a URL session.

在URL会话中执行的任务，如下载特定资源。