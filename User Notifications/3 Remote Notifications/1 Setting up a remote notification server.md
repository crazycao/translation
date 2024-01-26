# Setting up a remote notification server - 修改新收到的通知中的内容

原文地址：
[https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server)

Generate notifications and push them to user devices.

生成通知并将其推送到用户设备。

# Overview 概述

Use remote notifications (also known as push notifications) to push small amounts of data to devices that use your app, even when your app isn’t running. Apps use notifications to provide important information to users. For example, a messaging service sends remote notifications when new messages arrive.

使用远程通知（也称为推送通知）将少量数据推送到使用您应用程序的设备，即使您的应用程序没有运行。应用程序使用通知向用户提供重要信息。例如，消息服务在新消息到达时发送远程通知。

The delivery of remote notifications involves several key components:

远程通知的发送涉及几个关键组成部分：

- Your company’s server, known as the provider server
- Apple Push Notification service (APNs)
- The user’s device
- Your app running on the user’s device
- 您公司的服务器，即提供者服务器
- 苹果推送通知服务（APNs）
- 用户的设备
- 运行在用户设备上的您的应用程序

Remote notifications begin with your company’s server. You decide which notifications you want to send to your users, and when to send them. When it’s time to send a notification, you generate a request that contains the notification data and a unique identifier for the user’s device. You then forward your request to APNs, which handles the delivery of the notification to the user’s device. Upon receipt of the notification, the operating system on the user’s device handles any user interactions and delivers the notification to your app.

远程通知始于您公司的服务器。您决定要向用户发送哪些通知以及何时发送。当需要发送通知时，您会生成一个包含通知数据和用户设备的唯一标识符的请求。然后，您将请求转发给 APNs，它负责将通知发送到用户的设备上。在接收到通知后，由用户设备上的操作系统处理所有用户交互，并将通知传递给您的应用程序。

![Your company's provider server communicates with Apple Push Notification service, which in turn communicates with the user's devices.](https://docs-assets.developer.apple.com/published/1fe29f6177/4ebaf4d8-031d-4eb5-b975-07373dfa6eb6.png)

You’re responsible for setting up a provider server (or servers) and for configuring your app to handle notifications on the user’s device. Apple manages everything in between, including the presentation of notifications to the user. You must also have an app running on the user’s device that can communicate with your server and provide necessary information. For information about how to configure your app to handle remote notifications, see [Registering your app with APNs](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns).

您负责设置提供者服务器（或服务器组）并配置您的应用程序以处理用户设备上的通知。Apple 负责中间的所有事务，包括向用户呈现通知。您还必须在用户设备上运行一个能够与您的服务器通信并提供必要信息的应用程序。有关如何配置您的应用程序以处理远程通知的信息，请参阅《[在 APNs 中注册您的应用程序](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns)》。

> **Tip** **提示**
>
> If you’re setting up a provider server to send push notifications to users in Safari and other browsers, see [Sending web push notifications in web apps and browsers](https://developer.apple.com/documentation/usernotifications/sending_web_push_notifications_in_web_apps_and_browsers).
> 
> 如果您正在设置一个提供者服务器，以向Safari和其他浏览器的用户发送推送通知，请参阅《[在 Web 应用程序和浏览器中发送 Web 推送通知](https://developer.apple.com/documentation/usernotifications/sending_web_push_notifications_in_web_apps_and_browsers)》。

## Build custom infrastructure for notifications - 构建自定义的通知基础设施

Setting up a remote notification server consists of a few key tasks. How you implement these tasks depends on your infrastructure. Use the technologies that are appropriate for your company:

设置远程通知服务器包含几个关键任务。如何实施这些任务取决于您的基础设施。使用适合您公司的技术：

- Write code to receive device tokens from instances of your app running on user devices, and to associate those tokens with your users' accounts. See [Registering your app with APNs](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns).
- Determine when to send notifications to your users, and write code to generate notification payloads. See [Generating a remote notification](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification).
- Manage a connection to APNs using HTTP/2 and TLS. See [Sending notification requests to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns).
- Write code to generate POST requests that contain your payloads, and send those requests over your HTTP/2 connection. See [Sending notification requests to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns).
- Regenerate your token periodically for token-based authentication. See [Establishing a token-based connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns).

- 编写代码以接收来自运行在用户设备上的您的应用程序实例的设备令牌，并将这些令牌与用户帐户关联起来。请参阅《[在APNs中注册您的应用程序](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns)》。
- 确定何时向用户发送通知，并编写代码生成通知负载。请参阅《[生成远程通知](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification)》。
- 使用 HTTP/2 和 TLS 管理与 APNs 的连接。请参阅《[向 APNs 发送通知请求](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)》。
- 编写代码生成包含负载的 POST 请求，并通过您的 HTTP/2 连接发送这些请求。请参阅《[向 APNs 发送通知请求](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)》。
- 定期重新生成基于令牌的身份验证所需的令牌。请参阅《[建立基于令牌的与 APNs 的连接](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)》。

## Establish a trusted connection to APNs - 建立与 APNs 的可信连接

Communication between your provider server and APNs must take place over a secure connection. Creating that connection requires installing the [AAA Certificate Services root certificate](https://comodoca.my.salesforce.com/sfc/dist/version/download/?oid=00D1N000002Ljih&ids=0683l00000G9fLm&d=%2Fa%2F3l000000VbG0%2Fh70Hv.GWfGuD79pR_if0MtGjJFcUj.NRZS_RLqEyC_4&asPdf=false) on each of your provider servers.

您的提供者服务器与 APNs 之间的通信必须在安全连接上进行。创建该连接需要在每个提供者服务器上安装 [AAA 证书服务根证书](https://comodoca.my.salesforce.com/sfc/dist/version/download/?oid=00D1N000002Ljih&ids=0683l00000G9fLm&d=%2Fa%2F3l000000VbG0%2Fh70Hv.GWfGuD79pR_if0MtGjJFcUj.NRZS_RLqEyC_4&asPdf=false)。

If your provider server runs macOS 10.14 or later, the AAA Certificate Services root certificate is in the keychain by default. On other systems, you might need to install this certificate yourself. You can download the “AAACertificateServices 5/12/2020” certificate from the [Sectigo KnowledgeBase](https://support.sectigo.com/Com_KnowledgeDetailPage?Id=kA03l00000117cL) website.

如果您的提供者服务器运行的是 macOS 10.14 或更高版本，则 AAA 证书服务根证书默认已在钥匙串中。在其他系统上，您可能需要自己安装此证书。您可以从 [Sectigo KnowledgeBase](https://support.sectigo.com/Com_KnowledgeDetailPage?Id=kA03l00000117cL) 网站下载 “AAACertificateServices 5/12/2020” 证书。

To send notifications, your provider server must establish either token-based or certificate-based trust with APNs using HTTP/2 and TLS. Both techniques have advantages and disadvantages, so decide which technique is best for your company.

要发送通知，您的提供者服务器必须使用 HTTP/2 和 TLS 与 APNs 建立基于令牌或基于证书的信任。这两种技术都有优缺点，因此请自行决定哪种技术最适合您的公司。

- To set up token-based trust with APNs, see [Establishing a token-based connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns).
- To set up certificate-based trust with APNs, see [Establishing a certificate-based connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns).

- 要建立与 APNs 的基于令牌的信任，请参阅《[建立基于令牌的与 APNs 的连接](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)》。
- 要建立与 APNs 的基于证书的信任，请参阅《[建立基于证书的与 APNs 的连接](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_certificate-based_connection_to_apns)》。

## Understand what APNs provides - 了解 APNs 提供的功能

APNs makes every effort to deliver your notifications, and to deliver them with the best user experience:

APNs 尽最大努力发送您的通知，并以最佳用户体验进行发送：

- APNs manages an accredited, encrypted, and persistent IP connection to the user’s device.
- APNs can store notifications for a device that’s currently offline. APNs then forwards the stored notifications when the device comes online.
- If APNs doesn’t deliver a notification immediately, either for device power considerations or because the destination is offline, it may coalesce notifications for the same bundle ID.

- APNs 管理一个经过认证、加密且持久的IP连接，用于与用户设备通信。
- APNs 可以为当前离线的设备存储通知。然后，在设备上线时，APNs会将存储的通知转发出去。
- 如果由于设备电量考虑或目标设备离线，APNs 无法立即发送通知，它可能会合并同一 Bundle ID 的通知。

# Topics - 话题

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

## Security

Create a secure connection between your provider server and APNs.

在提供者服务器和 APNs 之间创建安全连接。

### Establishing a token-based connection to APNs - 建立基于令牌的与 APNs 的连接

Secure your communications with Apple Push Notification service (APNs) by using stateless authentication tokens.

通过使用无状态认证令牌，确保与 Apple Push Notification service (APNs) 之间的通信安全。

### Establishing a certificate-based connection to APNs - 建立基于证书的与 APNs 的连接

Secure your communications with Apple Push Notification service (APNs) by installing a certificate on your provider server.

通过在提供者服务器上安装证书，确保与 Apple Push Notification service (APNs) 之间的通信安全。

# See Also - 其他参考
## Remote notifications - 远程通知

### Registering your app with APNs - 在 APNs 中注册您的应用程序

Communicate with Apple Push Notification service (APNs) and receive a unique device token that identifies your app.

与 Apple Push Notification service (APNs) 进行通信，并接收一个唯一的设备令牌，用于标识您的应用程序。

### Testing notifications using the Push Notification Console - 使用推送通知控制台进行通知测试

Send test notifications and access delivery logs to test your app’s integration with Apple Push Notification service.

发送测试通知并访问交付日志，以测试您的应用程序与 Apple Push Notification service 的集成。

### Sending push notifications using command-line tools - 使用命令行工具发送推送通知

Use basic macOS command-line tools to send push notifications to Apple Push Notification service (APNs).

使用基本的 macOS 命令行工具向 Apple Push Notification service (APNs) 发送推送通知。