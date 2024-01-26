# Pushing background updates to your App - 推送后台更新到您的应用程序

原文地址：
[https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)

Deliver notifications that wake your app and update it in the background.

发送在后台唤醒您的应用程序并进行更新的通知。

# Overview 概述

If your app’s server-based content changes infrequently or at irregular intervals, you can use background notifications to notify your app when new content becomes available. A background notification is a remote notification that doesn’t display an alert, play a sound, or badge your app’s icon. It wakes your app in the background and gives it time to initiate downloads from your server and update its content.

如果您的应用程序的基于服务器的内容变化不频繁或不规律，您可以在新内容可用时使用后台通知来通知您的应用程序。后台通知是一种远程通知，不会显示提醒、播放声音或给应用程序的图标加角标。它会在后台唤醒您的应用程序，并给予其时间从服务器下载和更新内容。

> **Important** **重要**
>
> The system treats background notifications as low priority: you can use them to refresh your app’s content, but the system doesn’t guarantee their delivery. In addition, the system may throttle the delivery of background notifications if the total number becomes excessive. The number of background notifications allowed by the system depends on current conditions, but don’t try to send more than two or three per hour.
> 
> 系统将后台通知视为低优先级：您可以使用它们来刷新应用程序的内容，但系统不保证它们的发送。此外，如果后台通知的总数过多，系统可能会限制其发送。系统允许的后台通知数量取决于当前的条件，但请不要每小时发送超过两到三个。

## Enable the remote notifications capability 启用远程通知功能

To receive background notifications, you must add the remote notifications background mode to your app. In the `Signing and Capability` tab, add the `Background Modes` capability, then select the `Remote notification` checkbox. The figure below shows what you must select to recieve background notifications.

要接收后台通知，您必须将远程通知后台模式添加到您的应用程序中。在 `Signing and Capability` 选项卡中，添加 `Background Modes` 功能，然后选中 `Remote notification` 复选框。下图显示了接收后台通知需要选择的内容。

![Enabling the remote notification background mode in your project’s Capabilities tab.](https://docs-assets.developer.apple.com/published/fc6f19a01f/rendered2x-1689799547.png)

For watchOS, add this capability to your WatchKit Extension.

对于 watchOS，请将此功能添加到您的 WatchKit Extension 中。

## Create a background notification

To send a background notification, create a remote notification with an `aps` dictionary that includes only the `content-available` key, as shown in the sample code below. You may include custom keys in the payload, but the `aps` dictionary must not contain any keys that would trigger user interactions.

要发送后台通知，请创建一个远程通知，其中包含一个只包含 `content-available` 键的 `aps` 字典，如下面的示例代码所示。您可以在有效负载中包含自定义键，但 `aps` 字典不能包含任何会触发用户交互的键。

```
{
   "aps" : {
      "content-available" : 1
   },
   "acme1" : "bar",
   "acme2" : 42
}
```

Additionally, the notification’s POST request should contain the `apns-push-type` header field with a value of `background`, and the `apns-priority` field with a value of `5`. The APNs server requires the `apns-push-type` field when sending push notifications to Apple Watch, and recommends it for all platforms. For more information, see [Create a POST request to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns#2947607).

此外，通知的 POST 请求应包含 `apns-push-type` 头字段，并且其值为 `background`，以及 `apns-priority` 字段，其值为 `5`。APNs 服务器在向 Apple Watch 发送推送通知时需要 `apns-push-type` 字段，并建议在所有平台上使用它。有关更多信息，请参阅《[创建发往 APNs 的 POST 请求](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns#2947607)》。

## Receive background notifications 接收后台通知

When a device receives a background notification, the system may hold and delay the delivery of the notification, which can have the following side effects:

当设备接收到后台通知时，系统可能会暂停和延迟通知的发送，这可能会产生以下副作用：

- When the system receives a new background notification, it discards the older notification and only holds the newest one.
- If something force quits or kills the app, the system discards the held notification.
- If the user launches the app, the system immediately delivers the held notification.

- 当系统接收到新的后台通知时，它会丢弃旧的通知，只保留最新的通知。
- 如果应用程序被强制退出或终止，系统会丢弃保留的通知。
- 如果用户启动应用程序，系统会立即传递保留的通知。

To deliver a background notification, the system wakes your app in the background. On iOS it then calls your app delegate’s [application(_:didReceiveRemoteNotification:fetchCompletionHandler:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623013-application) method. On watchOS, it calls your extension delegate’s [didReceiveRemoteNotification(_:fetchCompletionHandler:)](https://developer.apple.com/documentation/watchkit/wkextensiondelegate/3152235-didreceiveremotenotification) method. Your app has 30 seconds to perform any tasks and call the provided completion handler. For more information, see [Handling notifications and notification-related actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions).

要传递后台通知，系统会在后台唤醒您的应用程序。在iOS上，它会调用应用程序委托的 [application(:didReceiveRemoteNotification:fetchCompletionHandler:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623013-application) 方法。在watchOS上，它会调用扩展委托的 [didReceiveRemoteNotification(:fetchCompletionHandler:)](https://developer.apple.com/documentation/watchkit/wkextensiondelegate/3152235-didreceiveremotenotification) 方法。您的应用程序有 30 秒的时间执行任何任务并调用提供的完成句柄。有关更多信息，请参阅《[处理通知和与通知相关的操作](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)》。

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
