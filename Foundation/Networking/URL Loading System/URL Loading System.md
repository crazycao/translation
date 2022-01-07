# URL Loading System

原文地址：[https://developer.apple.com/documentation/foundation/url_loading_system](https://developer.apple.com/documentation/foundation/url_loading_system)

> **Framework**
>
> Foundation

Interact with URLs and communicate with servers using standard Internet protocols.

与 URL 交互，以及使用标准 Internet 协议与服务器通信。

# Overview 概览

The URL Loading System provides access to resources identified by URLs, using standard protocols like https or custom protocols you create. Loading is performed asynchronously, so your app can remain responsive and handle incoming data or errors as they arrive.

URL加载系统使用 https 等标准协议或您创建的自定义协议提供对由URL标识的资源的访问。加载是异步执行的，因此您的应用程序可以保持响应，并在收到传入数据或错误时处理它们。

You use a [URLSession](https://developer.apple.com/documentation/foundation/urlsession) instance to create one or more [URLSessionTask](https://developer.apple.com/documentation/foundation/urlsessiontask) instances, which can fetch and return data to your app, download files, or upload data and files to remote locations. To configure a session, you use a [URLSessionConfiguration](https://developer.apple.com/documentation/foundation/urlsessionconfiguration) object, which controls behavior like how to use caches and cookies, or whether to allow connections on a cellular network.

你可以使用 [URLSession](https://developer.apple.com/documentation/foundation/urlsession) 实例创建一个或多个 [URLSessionTask](https://developer.apple.com/documentation/foundation/urlsessiontask) 实例，这些实例可以获取数据并将其返回到应用程序、下载文件或将数据和文件上载到远程位置。要配置会话，请使用 [URLSessionConfiguration](https://developer.apple.com/documentation/foundation/urlsessionconfiguration) 对象，该对象控制如何使用缓存和cookie，或是否允许在蜂窝网络上连接等行为。

You can use one session repeatedly to create tasks. For example, a web browser might have separate sessions for regular and private browsing use, where the private session doesn’t cache its data. Figure 1 shows how two sessions with these configurations can then create multiple tasks.

您可以重复使用一个会话来创建任务。例如，web浏览器可能有单独的会话用于常规和私人浏览，其中私人会话不会缓存其数据。图1显示了使用这些配置的两个会话如何创建多个任务。

Figure 1 Creating tasks from URL sessions 图 1 从 URL 会话创建任务
![Figure showing two scenarios, default browsing and private browsing, each with a URL Session creating multiple URL Session Tasks. In the default browsing case, the URL Session contains a default configuration. In the private browsing case, it contains an ephemeral configuration.](https://docs-assets.developer.apple.com/published/4bf9c6d271/6789dd96-afdc-4c18-b8eb-01f9012dc04d.png)

Each session is associated with a delegate to receive periodic updates (or errors). The default delegate calls a completion handler block that you provide; if you choose to provide your own custom delegate, this block is not called.

每个会话都与一个代理关联，以接收定期更新（或错误）。默认代理调用您提供的完成处理操作 block；如果选择提供自己的自定义代理，则不调用此 block。

You can configure a session to run in the background, so that while the app is suspended, the system can download data on its behalf and wake up the app to deliver the results.

您可以将会话配置为在后台运行，以便在应用程序挂起时，系统可以代替其下载数据并唤醒应用程序以交付结果。

# Topics - 主题

## Essentials - 要素

Configure and create sessions, then use them to create tasks that interact with URLs.

配置和创建会话，然后使用它们创建与URL交互的任务。

[Fetching Website Data into Memory - 将网站数据提取到内存中](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)

Receive data directly into memory by creating a data task from a URL session.

通过从URL会话创建数据任务，将接收的数据直接放到内存中。

[Analyzing HTTP Traffic with Instruments - 用 Instruments 分析HTTP流量](https://developer.apple.com/documentation/foundation/url_loading_system/analyzing_http_traffic_with_instruments)

Measure HTTP-based network performance and usage of your apps.

测量基于HTTP的网络性能和应用程序的使用情况。

class [URLSession](https://developer.apple.com/documentation/foundation/urlsession)

An object that coordinates a group of related, network data transfer tasks.

协调一组相关网络数据传输任务的对象。

class [URLSessionTask](https://developer.apple.com/documentation/foundation/urlsessiontask)

A task, like downloading a specific resource, performed in a URL session.

在URL会话中执行的任务，如下载特定资源。

## Requests and Responses - 请求和响应

struct [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)

A URL load request that is independent of protocol or URL scheme.

不依赖协议或 URL scheme 的 URL 加载请求。

class [URLResponse](https://developer.apple.com/documentation/foundation/urlresponse)

The metadata associated with the response to a URL load request, independent of protocol and URL scheme.

与 URL 加载请求的响应相关联的元数据，与协议和URL scheme无关。

class [HTTPURLResponse](https://developer.apple.com/documentation/foundation/httpurlresponse)

The metadata associated with the response to an HTTP protocol URL load request.

与 HTTP 协议的 URL 加载请求的响应相关联的元数据。

## Uploading - 上传

[Uploading Data to a Website - 上传数据到网站](https://developer.apple.com/documentation/foundation/url_loading_system/uploading_data_to_a_website)

Post data from your app to servers.

从你的 app 发布数据到服务器。

[Uploading Streams of Data - 上传数据流](https://developer.apple.com/documentation/foundation/url_loading_system/uploading_streams_of_data)

Send a stream of data to a server.

向服务器发送数据流。

## Downloading - 下载

[Downloading Files from Websites - 从网站下载数据](https://developer.apple.com/documentation/foundation/url_loading_system/downloading_files_from_websites)

Download files directly to the filesystem.

直接将文件下载到文件系统。

[Pausing and Resuming Downloads - 暂停和恢复下载](https://developer.apple.com/documentation/foundation/url_loading_system/pausing_and_resuming_downloads)

Allow the user to resume a download without starting over.

允许用户在不重新开始的情况下继续下载。

[Downloading Files in the Background - 在后台下载文件](https://developer.apple.com/documentation/foundation/url_loading_system/downloading_files_in_the_background)

Create tasks that download files while your app is inactive.

创建在 app 处于非活动状态时下载文件的任务。

## Cache Behavior - 缓存行为

[Accessing Cached Data - 访问缓存数据](https://developer.apple.com/documentation/foundation/url_loading_system/accessing_cached_data)

Control how URL requests make use of previously cached data.

控制URL请求如何使用以前缓存的数据。

class [CachedURLResponse](https://developer.apple.com/documentation/foundation/cachedurlresponse)

A cached response to a URL request.

对URL请求的缓存响应。

class [URLCache](https://developer.apple.com/documentation/foundation/urlcache)

An object that maps URL requests to cached response objects.

将URL请求映射到缓存响应对象的对象。

## Authentication and Credentials - 身份验证和证书

[Handling an Authentication Challenge - 处理身份验证质询](https://developer.apple.com/documentation/foundation/url_loading_system/handling_an_authentication_challenge)

Respond appropriately when a server demands authentication for a URL request.

当服务器要求对 URL 请求进行身份验证时，请做出适当的响应。

class [URLAuthenticationChallenge](https://developer.apple.com/documentation/foundation/urlauthenticationchallenge)

A challenge from a server requiring authentication from the client.

来自服务器的质询，需要来自客户端的身份验证。

class [URLCredential](https://developer.apple.com/documentation/foundation/urlcredential)

An authentication credential consisting of information specific to the type of credential and the type of persistent storage to use, if any.

一种身份验证凭据，由特定于凭据类型和要使用的持久存储类型（如果有）的信息组成。

class [URLCredentialStorage](https://developer.apple.com/documentation/foundation/urlcredentialstorage)

The manager of a shared credentials cache.

共享证书缓存的管理器。

class [URLProtectionSpace](https://developer.apple.com/documentation/foundation/urlprotectionspace)

A server or an area on a server, commonly referred to as a realm, that requires authentication.

需要身份验证的服务器或服务器上的区域，通常称为域。

## Network Activity Attribution - 网络活动归因

[Inspecting App Activity Data - 检查 App 的活动数据](https://developer.apple.com/documentation/network/privacy_management/inspecting_app_activity_data)

Verify that your app accesses only the user data and network resources that you expect it to access.

验证您的应用程序仅访问您希望它访问的用户数据和网络资源。

[Indicating the Source of Network Activity - 指示网络活动的来源](https://developer.apple.com/documentation/network/privacy_management/indicating_the_source_of_network_activity)

Control whether the App Privacy Report attributes network traffic to the app or to the user.

控制 App 隐私报告是将网络流量归因于应用还是归因于用户。

## Cookies

class [HTTPCookie](https://developer.apple.com/documentation/foundation/httpcookie)

A representation of an HTTP cookie.

HTTP cookie的表示形式。

class [HTTPCookieStorage](https://developer.apple.com/documentation/foundation/httpcookiestorage)

A container that manages the storage of cookies.

管理cookies存储的容器。

## Errors

struct [URLError](https://developer.apple.com/documentation/foundation/urlerror)

Error codes returned by URL loading APIs.

URL 加载 API 返回的错误代码。

[URL Loading System Error Info Keys - URL 加载系统错误信息的 Key](https://developer.apple.com/documentation/foundation/url_loading_system/url_loading_system_error_info_keys)

Recognize these keys from the user info dictionary of error objects produced by URL Loading APIs.

从 URL 加载 API 生成的错误对象的用户信息字典中识别这些键。

## Legacy - 遗产

[Legacy URL Loading Systems - 过去的 URL 加载系统](https://developer.apple.com/documentation/foundation/url_loading_system/legacy_url_loading_systems)

Migrate your code away from using these legacy objects.

把你的代码从这些使用这些过时的对象中迁移出来。

# See Also 其它参考

## Networking - 网络

[Bonjour](https://developer.apple.com/documentation/foundation/bonjour) （译者注：Bonjour是苹果为基于组播域名服务(multicast DNS)的开放性零设置网络标准所起的名字，能自动发现IP网络上的电脑、设备和服务。）

Advertise services for easy discovery on local networks, or discover services advertised by others.

易于在本地网络上发现的广告服务，或发现其他人的广告的服务。