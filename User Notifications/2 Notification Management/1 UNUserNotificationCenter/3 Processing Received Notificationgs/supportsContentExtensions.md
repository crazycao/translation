# supportsContentExtensions

原文地址：
[https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/2196946-supportscontentextensions](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/2196946-supportscontentextensions)

A Boolean value that indicates whether the device supports notification content extensions.

一个布尔值，表示设备是否支持通知内容扩展。

> iOS 10.0+
iPadOS 10.0+
macOS 10.14+
Mac Catalyst 13.1+
tvOS 10.0+
watchOS 3.0+
visionOS 1.0+

```
var supportsContentExtensions: Bool { get }
```

# Discussion - 讨论

Notification content extensions let you customize the appearance of the alerts displayed for your app's notifications. The value of this property is `true` for devices that support notification content extensions and `false` for devices that do not support them. For information about how to implement a notification content extension, see [Customizing the Appearance of Notifications](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications).

通知内容扩展允许您自定义应用程序通知显示的外观。对于支持通知内容扩展的设备，此属性的值为 `true`；对于不支持通知内容扩展的设备，该值为 `false`。关于如何实现通知内容扩展的详细信息，请参阅《[自定义通知外观](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications)》。

# See Also - 其他参考

## Processing received notifications - 处理收到的通知

### var [delegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649522-delegate): UNUserNotificationCenterDelegate?

The notification center’s delegate.

通知中心的代理。

### protocol [UNUserNotificationCenterDelegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate)

An interface for processing incoming notifications and responding to notification actions.

用于处理传入通知并响应通知操作的接口。

### var [supportsContentExtensions](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/2196946-supportscontentextensions): Bool

A Boolean value that indicates whether the device supports notification content extensions.

一个布尔值，表示设备是否支持通知内容扩展。