# Delivering a notification with Apple Push Notification service - 使用苹果推送通知服务传递通知



原文地址：
[https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/delivering_a_notification_with_apple_push_notification_service](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/delivering_a_notification_with_apple_push_notification_service)

Understand the factors that determine the delivery of a push notification with APNs.

了解决定使用APN发送推送通知的因素。

# Overview 概述

After accepting a push notification request, APNs attempts to deliver the notification to the destination device. Successful delivery depends on multiple factors, such as:

在接受推送通知请求后，APNs 尝试将通知发送到目标设备。成功的发送取决于多个因素，例如：

- Notification attributes, such as push priority and push type
- The destination device, such as the device’s power state
- External factors, such as device’s connection quality (both Cellular and Wi-Fi)

- 通知属性，例如推送优先级和推送类型。
- 目标设备，例如设备的电源状态。
- 外部因素，例如设备的连接质量（无论是蜂窝数据还是Wi-Fi）。

Based on these factors, APNs does one or more of the following:

基于这些因素，APNs 会执行以下一项或多项操作：

- Saves the push notification in persistent storage to attempt delivery later.
- Discards the push notification.
- Delivers the push notification.

- 将推送通知保存在持久存储中，以便稍后尝试发送。
- 丢弃推送通知。
- 发送推送通知。

Understanding the factors that impact the delivery of a push notification with APNs can help you choose the appropriate notification attributes. For information on how to test notifications, see [Testing notifications using the Push Notification Console](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console).

了解影响使用 APNs 传递推送通知的因素可以帮助您选择适当的通知属性。有关如何测试通知的信息，请参阅《[使用推送通知控制台进行测试通知](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console)》。

## Understand why APNs discards notifications 了解 APNs 为何丢弃通知

APNs discards a push notification if:

APNs丢弃推送通知的原因包括：

- Your push token is no longer active on the destination device.
- Push notifications for your app are disabled in Settings on the destination device. For more information, see [Asking permission to use notifications](https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications).
- The push notification expires.

- 目标设备上的推送令牌已不再有效。
- 目标设备的设置中禁用了您的应用程序的推送通知。有关更多信息，请参阅《[请求使用通知的权限](https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications)》。
- 推送通知已过期。

APNs discards a push notification if your push token is no longer active on the destination device. This may happen, if a user removes your application or the push token for your application changes. For more information, see [Registering your app with APNs](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns).

如果您的推送令牌在目标设备上不再有效，APNs 会丢弃推送通知。这可能发生在用户删除您的应用程序或您的应用程序的推送令牌发生了变化时。有关更多信息，请参阅《[将您的应用程序注册到 APNs](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns)》。

The figure below shows the logical flow that APNs takes to deliver a push notification to the destination device.

下图展示了 APNs 传递推送通知到目标设备的逻辑流程。

![A flow diagram depicting the steps taken by APNs to deliver a push notification to the destination device. Starting on the left, the APNs accepts the push notification and checks if the token is registered and if push notifications is enabled. If the answer is no, the APNs discards the notification. Then APNs checks if the destination device imposed power reservation. If the answer is no then the notification gets delivered to the destination device. Otherwise, APNs checks if the push is expired. If the answer is yes, then APNs discards the notification. If the answer is no, the APNS stores the notification in APNs storage to send at a later time. 流程图描述了 APNs 传递推送通知到目标设备的步骤。从左侧开始，APNs 接受推送通知并检查令牌是否注册以及推送通知是否启用。如果答案是否定的，APNs 会丢弃通知。然后，APNs 检查目标设备是否设置了电量保留。如果答案是否定的，则通知会被传递到目标设备。否则，APNs 会检查推送是否过期。如果答案是肯定的，则 APNs 会丢弃通知。如果答案是否定的，APNs 会将通知存储在 APNs 的存储中以便稍后发送。](https://docs-assets.developer.apple.com/published/63888ba475/rendered2x-1693426121.png)

## Understand when APNs stores notifications 了解 APNs 何时存储通知

If the destination device isn’t connected to APNs, then APNs saves the push notification in persistent storage to deliver later (unless it expires). APNs attempts to deliver an unexpired, stored push notification when the destination device connects to APNs server the next time. When APNs delivers the push notification to the destination device the delivery may take multiple attempts and some attempts may reach across multiple network interfaces.

如果目标设备未连接到 APNs，则 APNs 会将推送通知保存在持久存储中以便稍后传递（除非通知已过期）。当目标设备下次连接到 APNs 服务器时，APNs 会尝试传递未过期的存储的推送通知。在将推送通知传递给目标设备时，传递过程可能需要多次尝试，并且某些尝试可能跨越多个网络接口。

If the destination device is connected to APNs but it’s in low power mode, APNs may defer delivery of a notification to conserve battery. In that case, APNs stores the notification in persistent storage. When the device revises its power assertions and removes the restriction on delivery, APNs reattempts to deliver the stored notification.

如果目标设备已连接到 APNs，但处于低电量模式，APNs 可能会延迟传递通知以节省电量。在这种情况下，APNs 会将通知存储在持久存储中。当设备取消对传递的限制并解除对电池的限制时，APNs 会重新尝试传递存储的通知。

When APNs tries to deliver a notification from the APNs persistent storage, it might get delivered successfully or get discarded. While in APNs persistent storage, notifications can be overwritten by other notifications that you send for the same device token and bundle ID. APNs persistent storage only stores one notification per application per device. If you send multiple notifications for the same bundle ID while APNs can’t deliver the notifications, APNs preserves only one of the accepted push notifications. Most of the time it’s the last notification sent, but because APNs doesn’t have any ordering guarantees, this isn’t always the case.

当 APNs 尝试传递 APNs 持久存储中通知时，它可能会成功传递或丢弃通知。在 APNs 持久存储中，通知可以被您为相同设备令牌和 bundle ID 发送的其他通知覆盖。APNs 持久存储每个应用程序每个设备只存储一个通知。如果您为相同的 bundle ID 发送多个通知，而 APNs 无法传递这些通知，APNs 仅保留一个已接受的推送通知。大多数情况下，这是最后一个发送的通知，但由于 APNs 没有任何排序保证，这并不总是这样。

> **Note** **注意**
>
> When storing a push notification, APNs uses either the specified expiry or default to TTL of 30 days (whichever comes earliest).
> 
> 在存储推送通知时，APNs 使用指定的过期时间或默认的30天TTL（以较早者为准）。

If your push notification expires before the destination device connects to APNs and removes power state restrictions, APNs discards the notification. Your app may need to synchronize with your application server about the information that got missed due to discarded, expired or overwritten notification. See the figure below to understand the logical flow of a push notification getting discarded because the push notification expired.

如果您的推送通知在目标设备连接到 APNs 并解除电量状态限制之前过期，APNs 会丢弃该通知。您的应用程序可能需要与应用程序服务器同步有关由于丢弃、过期或被覆盖的通知而丢失的信息。请参阅下图，了解由于过期而丢弃推送通知的逻辑流程。

![A flow diagram depicting the steps taken by APNs to deliver a push notification to the destination device once the notification is in APNs storage. APNs checks if the device removed power reservation assertion and if the device is online with APNs. If the answer is no then APNs discards the notification. If the answer is yes, then APNs sends the notification back to device flow. In device flow, APNs reattempts to deliver the notfication. 流程图描述了当通知在 APNs 存储中时，APNs 传递推送通知到目标设备所采取的步骤。APNs 检查设备是否取消了电量保留声明，并且设备是否与 APNs 在线连接。如果答案是否定的，则 APNs 会丢弃通知。如果答案是肯定的，则 APNs 将通知发送回设备流程。在设备流程中，APNs 会尝试重新传递通知。](https://docs-assets.developer.apple.com/published/c013cf7573/rendered2x-1693426118.png)

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
