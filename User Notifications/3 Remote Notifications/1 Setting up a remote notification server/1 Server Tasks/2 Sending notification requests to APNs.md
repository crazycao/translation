# Sending notification requests to APNs - 向 APNs 发送通知请求



原文地址：
[https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)

Transmit your remote notification payload and device token information to Apple Push Notification service (APNs).

将您的远程通知负载和设备令牌信息传输到苹果推送通知服务（APNs）。

# Overview 概述

As a best-effort service, APNs may reorder notifications you send to the same device token. If APNs can’t deliver a notification immediately, it may store the notification for 30 days or less, depending on the date you specify in the `apns-expiration` header. APNs attempts to deliver the notification the next time the device activates and is available online.

作为一种尽力服务（[BE Service](https://baike.baidu.com/item/best-effort%20service/804362?fr=ge_ala)），APNs 可能会重新排序发送到同一设备令牌的通知。如果 APNs 无法立即传递通知，它可能会在 30 天内或更短的时间内存储该通知，具体取决于你在 `apns-expiration` 标头中指定的日期。APNs 会在设备下次激活并联机时尝试传递通知。

APNs stores only one notification per bundle ID. When you send multiple notifications to the same device for a bundle ID, APNs selects only one notification to store in a non-deterministic way. Notifications with `apns-priority` 5 and 1 might get grouped and delivered in bursts to the user’s device. Your notifications may also get throttled, saved in storage, and in some cases, not delivered. The way the user interacts with your application and the power state of the device determines the exact behavior. For more information about the factors that impact the delivery of a push notification, see [Delivering a notification with Apple Push Notification service](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/delivering_a_notification_with_apple_push_notification_service).

APNs 仅存储一个与 Bundle ID 相关的通知。当你发送多个针对同一 Bundle ID 的通知到同一设备时，APNs 以非确定性的方式选择仅存储一个通知。具有 `apns-priority` 5 和 1 的通知可能会被分组，以突发方式传递到用户的设备。你的通知也可能会受限、被存储、在某些情况下无法传递。用户与你的应用程序的交互方式以及设备的电源状态决定了具体的行为。有关影响推送通知传递的因素的更多信息，请参阅《[使用 Apple 推送通知服务传递通知](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/delivering_a_notification_with_apple_push_notification_service)》。

When you have a notification to send to a user, your provider must construct a POST request and send it to Apple Push Notification service (APNs). Upon receiving your server’s POST request, APNs validates the request using either the provided authentication token or your server’s certificate. If validation succeeds, APNs uses the provided device token to identify the user’s device. It then tries to send your JSON payload to that device. For information on sending test notifications without setting up the environment, see [Testing notifications using the Push Notification Console](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console).

当你有通知要发送给用户时，你的提供者必须构建一个 POST 请求并发送给 Apple 推送通知服务（APNs）。在接收到你的服务器的 POST 请求后，APNs 使用提供的身份验证令牌或你的服务器证书进行验证。如果验证成功，APNs 使用提供的设备令牌来识别用户的设备。然后，它尝试将 JSON 负载发送到该设备。关于在不设置环境的情况下发送测试通知的信息，请参阅《[使用推送通知控制台进行测试通知](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console)》。

## Establish a connection to APNs - 建立到 APNs 的连接

Use HTTP/2 and TLS 1.2 or later to establish a connection between your provider server and one of the following servers:

使用 HTTP/2 和 TLS 1.2 或更高版本在你的提供者服务器和以下服务器之间建立连接：

- Development server: api.sandbox.push.apple.com:443
- Production server: api.push.apple.com:443

- 开发服务器：api.sandbox.push.apple.com:443
- 生产服务器：api.push.apple.com:443

Use the production server for your shipping apps and the development server for testing. When sending many remote notifications, you can establish multiple connections to these servers to improve performance.

对于你发布的应用程序，请使用生产服务器；测试时则使用开发服务器。当发送大量远程通知时，你可以建立多个与这些服务器的连接以提高性能。

> Tip
>
> You can also use port 2197 (instead of port 443) on either server when communicating with APNs. You might use this port to allow APNs traffic through your firewall but to block other HTTPS traffic.
> 
> **提示**
> 
> 当与 APNs 通信时，你还可以在任一服务器上使用端口 2197（而不是端口 443）。你可以通过此端口允许 APNs 流量通过防火墙，同时阻止其他 HTTPS 流量。

APNs allows multiple concurrent streams for each connection, but don’t assume a specific number of streams. The exact number varies based on server load and whether you use a provider certificate or an authentication token. For example, when using an authentication token, APNs allows only one stream until you post a request with a valid authentication token. APNs ignores `HTTP/2 PRIORITY` frames, so don’t send them on your streams.

APNs 允许每个连接同时进行多个并发流，但不要假设流的数量。确切的数量取决于服务器负载以及你使用的是提供者证书还是身份验证令牌。例如，当使用身份验证令牌时，APNs 仅允许一个流，直到你发送带有有效身份验证令牌的请求。APNs 忽略 `HTTP/2 PRIORITY` 帧，因此不要在你的流上发送这些帧。

If you experience a revoked provider certificate, or if you revoke your authentication token, close all connections to APNs, fix the problem, and then open new connections. APNs may also terminate a connection by sending a `GOAWAY` frame. The payload of the `GOAWAY` frame includes JSON data with a `reason` key, indicating the reason for the connection termination. For a list of values for the reason key, see the response error strings in [Handling notification responses from APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns).

如果你的提供者证书被撤销，或者你撤销了身份验证令牌，请关闭与 APNs 的所有连接，修复问题，然后重新建立连接。APNs 也可能通过发送 `GOAWAY` 帧来终止连接。`GOAWAY` 帧的负载会包含带有 `reason` 键的 JSON 数据，指示连接终止的原因。有关 reason 键的值列表，请参阅《[处理来自 APNs 的通知响应](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns)》中的响应错误字符串。

## Send a POST request to APNs - 向 APNs 发送 POST 请求

To deliver the notifications, you’re required to have some header fields. In addition to the preceding data, add the following header fields in to your request. Other headers are optional or may depend on whether you’re using token-based or certificate-based authentication.

为了传递通知，你需要一些标头字段。除了上述数据之外，请在请求中添加以下标头字段。其他标头是可选的，或者取决于你是使用基于令牌还是基于证书的身份验证。

Header field|Required|Description
|:-:|:-:|:-:|
:method|Required|The value `POST`.
:path|Required|The path to the device token. The value of this header is /3/device/<device_token>, where <device_token> is the hexadecimal bytes that identify the user’s device. Your app receives the bytes for this device token when registering for remote notifications. For more information, see Registering your app with APNs.
authorization|Required for token-based authentication|The value of this header is bearer <provider_token>, where <provider_token> is the encrypted token that authorizes you to send notifications for the specified topic. APNs ignores this header if you use certificate-based authentication. For more information, see Establishing a token-based connection to APNs.
apns-push-type|Required for watchOS 6 and later; recommended for macOS, iOS, tvOS, and iPadOS|The value of this header must accurately reflect the contents of your notification’s payload. If there’s a mismatch, or if the header is missing on required systems, APNs may return an error, delay the delivery of the notification, or drop it altogether.
apns-id|Optional|A canonical UUID that’s the unique ID for the notification. If an error occurs when sending the notification, APNs includes this value when reporting the error to your server. Canonical UUIDs are 32 lowercase hexadecimal digits, displayed in five groups separated by hyphens in the form 8-4-4-4-12. For example: 123e4567-e89b-12d3-a456-4266554400a0. If you omit this header, APNs creates a UUID for you and returns it in its response.
apns-expiration|Optional|The date at which the notification is no longer valid. This value is a UNIX epoch expressed in seconds (UTC). If the value is nonzero, APNs stores the notification and tries to deliver it at least once, repeating the attempt as needed until the specified date. If the value is 0, APNs attempts to deliver the notification only once and doesn’t store it.</br>A single APNs attempt may involve retries over multiple network interfaces and connections of the destination device. Often these retries span over some time period, depending on the network characteristics. In addition, a push notification may take some time on the network after APNs sends it to the device. APNs uses best efforts to honor the expiry date without any guarantee. If the value is nonzero, the notification may deliver after the specified timestamp. If the value is 0, the notification may deliver with some delay.</br>If you omit this header, APNs stores the push according to APNs storage policy. For more information, see Sending notification requests to APNs.
apns-priority|Optional|The priority of the notification. If you omit this header, APNs sets the notification priority to 10.</br>Specify 10 to send the notification immediately.</br>Specify 5 to send the notification based on power considerations on the user’s device.</br>Specify 1 to prioritize the device’s power considerations over all other factors for delivery, and prevent awakening the device.
apns-topic|Optional|The topic for the notification. In general, the topic is your app’s bundle ID/app ID. It can have a suffix based on the type of push notification. If you’re using a certificate that supports PushKit VoIP or watchOS complication notifications, you must include this header with the bundle ID of your app and if applicable, the proper suffix. If you’re using token-based authentication with APNs, you must include this header with the correct bundle ID and suffix combination. To learn more about app ID, see Register an App ID.
apns-collapse-id|Optional|An identifier you use to merge multiple notifications into a single notification for the user. Typically, each notification request displays a new notification on the user’s device. When sending the same notification more than once, use the same value in this header to merge the requests. The value of this key must not exceed 64 bytes.

APNs requires the use of HPACK (header compression for HTTP/2), which prevents repeatedly storing header keys and values. APNs maintains a small dynamic table for HPACK. To avoid filling up that table, encode your headers in the following way—especially when using many streams:

- Encode the :path and authorization values as literal header fields without indexing.
- Encode the apns-id, apns-expiration, and apns-collapse-id values differently based on whether this is an initial or subsequent request.

	- The first time you send these headers, encode them with incremental indexing to add the header fields to the dynamic table.
	- For subsequent requests, encode these headers as literal header fields without indexing.

- Encode all other fields as literal header fields with incremental indexing.

Put the JSON payload with the notification’s content into the body of your request. You must not use a compressed JSON payload, and it’s limited to a maximum size of 4 KB (4096 bytes). The maxiumum size for a Voice over Internet Protocol (VoIP) notification is 5 KB (5120 bytes).

The code snippet below shows a sample request constructed with an authentication token.

```
HEADERS
  - END_STREAM
  + END_HEADERS
  :method = POST
  :scheme = https
  :path = /3/device/00fc13adff785122b4ad28809a3420982341241421348097878e577c991de8f0
  host = api.sandbox.push.apple.com
  authorization = bearer eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0I
		 jogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6
		 Lxw7LZtEQcH6JENhJTMArwLf3sXwi
  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
  apns-push-type = alert
  apns-expiration = 0
  apns-priority = 10
  apns-topic = com.example.MyApp
DATA
  + END_STREAM
  { "aps" : { "alert" : "Hello" } }
```

The code snippet below shows a sample request constructed for use with a certificate. APNs uses the app’s bundle ID as the default topic.

```
HEADERS
  - END_STREAM
  + END_HEADERS
  :method = POST
  :scheme = https
  :path = /3/device/00fc13adff785122b4ad28809a3420982341241421348097878e577c991de8f0
  host = api.sandbox.push.apple.com
  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
  apns-push-type = alert
  apns-expiration = 0
  apns-priority = 10
DATA
  + END_STREAM
  { "aps" : { "alert" : "Hello" } }
```

## Know when to use push types
The apns-push-type header field has the following valid values. The descriptions below describe when and how to use these values. Send an apns-push-type header with each push. Recent and upcoming features may not work if this header is missing. See the table above to determine if this header is required or optional.

- alert

	The push type for notifications that trigger a user interaction—for example, an alert, badge, or sound. If you set this push type, the apns-topic header field must use your app’s bundle ID as the topic. For more information, see Generating a remote notification.

	If the notification requires immediate action from the user, set notification priority to 10; otherwise use 5.

	You’re required to use the alert push type on watchOS 6 and later. It’s recommended on macOS, iOS, tvOS, and iPadOS.

- background

	The push type for notifications that deliver content in the background, and don’t trigger any user interactions. If you set this push type, the apns-topic header field must use your app’s bundle ID as the topic. Always use priority 5. Using priority 10 is an error. For more information, see Pushing background updates to your App.

	You’re required to use the background push type on watchOS 6 and later. It’s recommended on macOS, iOS, tvOS, and iPadOS.

- location

	The push type for notifications that request a user’s location. If you set this push type, the apns-topic header field must use your app’s bundle ID with.location-query appended to the end. For more information, see Creating a location push service extension.

	The location push type isn’t available on macOS, tvOS, and watchOS. It’s recommended for iOS and iPadOS.

	If the location query requires an immediate response from the Location Push Service Extension, set notification apns-priority to 10; otherwise, use 5.

	The location push type supports only token-based authentication.

- voip

	The push type for notifications that provide information about an incoming Voice-over-IP (VoIP) call. For more information, see Responding to VoIP Notifications from PushKit.

	If you set this push type, the apns-topic header field must use your app’s bundle ID with.voip appended to the end. If you’re using certificate-based authentication, you must also register the certificate for VoIP services. The topic is then part of the 1.2.840.113635.100.6.3.4 or 1.2.840.113635.100.6.3.6 extension.

	The voip push type isn’t available on watchOS. It’s recommended on macOS, iOS, tvOS, and iPadOS.

- complication

	The push type for notifications that contain update information for a watchOS app’s complications. For more information, see Keeping your complications up to date.

	If you set this push type, the apns-topic header field must use your app’s bundle ID with.complication appended to the end. If you’re using certificate-based authentication, you must also register the certificate for WatchKit services. The topic is then part of the 1.2.840.113635.100.6.3.6 extension.

	The complication push type isn’t available on macOS, tvOS, and iPadOS. It’s recommended for watchOS and iOS.

- fileprovider

	The push type to signal changes to a File Provider extension. If you set this push type, the apns-topic header field must use your app’s bundle ID with.pushkit.fileprovider appended to the end. For more information, see Using push notifications to signal changes.

	The fileprovider push type isn’t available on watchOS. It’s recommended on macOS, iOS, tvOS, and iPadOS.

- mdm

	The push type for notifications that tell managed devices to contact the MDM server. If you set this push type, you must use the topic from the UID attribute in the subject of your MDM push certificate. For more information, see Device Management.

	The mdm push type isn’t available on watchOS. It’s recommended on macOS, iOS, tvOS, and iPadOS.

- liveactivity

	The push type to signal changes to a live activity session. If you set this push type, the apns-topic header field must use your app’s bundle ID with.push-type.liveactivity appended to the end. For more information, see Updating and ending your Live Activity with ActivityKit push notifications.

	The liveactivity push type isn’t available on watchOS, macOS, and tvOS. It’s recommended on iOS and iPadOS.

- pushtotalk

	The push type for notifications that provide information about updates to your application’s push to talk services. For more information, see Push to Talk. If you set this push type, the apns-topic header field must use your app’s bundle ID with.voip-ptt appended to the end.

	The pushtotalk push type isn’t available on watchOS, macOS, and tvOS. It’s recommended on iOS and iPadOS.

Certificate-based connection supports only a subset of push types and token-based connection supports all push-types. For more information, see Establishing a certificate-based connection to APNs. Check Extension 1.2.840.113635.100.6.3.6 and 1.2.840.113635.100.6.3.4 of your push certificate. These extensions list all the push topics allowed for your certificate. If a push topic for a specific push type isn’t listed, you can’t use the certificate to send a notification of that push type.

## Follow best practices while sending push notifications with APNs

Below are some APNs best practices to consider:

- Make an uncached DNS query to resolve the APNs server name, before each connection. This helps distribute push traffic from all providers across all APNs servers.
- Avoid push bursts over selective connections. Diversifying push traffic over many connections distributes push traffic for your application across all APNs servers.
- Reuse a connection as long as possible. In most cases, you can reuse a connection for many hours to days. If your connection is mostly idle, you may send a HTTP2 PING frame after an hour of inactivity. Reusing a connection often results in less bandwidth and CPU consumption.
- Create a unique value for the apns-id header to track your push notification. If you don’t provide one, APNs creates one and returns it as part of the response. Record this UUID to assist with debugging.
- Pay attention to status returned by APNs for each push and take appropriate action for your application. For more information, see Handling notification responses from APNs.
- If you’re using a certificate to connect to APNs, remember to get a new certificate and deploy it with your service before the expiry of the current certificate.
- Don’t make assumptions about device token size.

> Note
>
> APNs doesn’t support legacy binary protocol as of March 31, 2021. Update to the HTTP/2-based API as soon as possible.




# See Also - 其他参考

## Server Tasks - 服务器任务

###  Generating a remote notification - 生成远程通知

Send notifications to the user’s device with a JSON payload.

携带 JSON 负载向用户的设备发送通知。

### Sending notification requests to APNs - 向 APNs 发送通知请求

Transmit your remote notification payload and device token information to Apple Push Notification service (APNs).

将您的远程通知负载和设备令牌信息传输到苹果推送通知服务（APNs）。

### Handling notification responses from APNs - 处理来自 APNs 的通知响应

Respond to the status codes that the APNs servers return.

响应 APNs 服务器返回的状态代码。

### Delivering a notification with Apple Push Notification service - 使用苹果推送通知服务传递通知

Understand the factors that determine the delivery of a push notification with APNs.

了解决定使用APN发送推送通知的因素。

### Pushing background updates to your App - 推送后台更新到您的应用程序

Deliver notifications that wake your app and update it in the background.

发送在后台唤醒您的应用程序并进行更新的通知。
