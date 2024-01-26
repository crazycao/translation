# delegate - 代理

原文地址：
[https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649522-delegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/1649522-delegate)

The notification center’s delegate.

通知中心的代理。

> iOS 10.0+
iPadOS 10.0+
macOS 10.14+
Mac Catalyst 13.1+
tvOS 10.0+
watchOS 3.0+
visionOS 1.0+

```
weak var delegate: UNUserNotificationCenterDelegate? { get set }
```

# Discussion - 讨论

Use the delegate object to respond to user-selected actions and to process incoming notifications when your app is in the foreground. For example, you might use your delegate to silence notifications when your app is in the foreground.

使用代理对象来响应用户选择的操作并在应用程序处于前台时处理传入的通知。例如，您可以使用你的代理在应用程序处于前台时处理静默通知。

To guarantee that your app responds to all actionable notifications, you must set the value of this property before your app finishes launching. For an iOS app, this means updating this property in the [application(_:willFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623032-application) or [application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application) method of the app delegate. Notifications that cause your app to be launched or delivered shortly after these methods finish executing.

为了确保您的应用对所有可操作通知做出响应，您必须在应用程序完成启动之前设置此属性的值。对于iOS应用程序，这意味着在应用程序代理的 [application(_:willFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623032-application) 方法或 [application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application) 方法中更新此属性。这些方法执行完毕后立即就会接收到导致您的应用程序被启动的通知。

For more information about implementing the delegate methods, see [UNUserNotificationCenterDelegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate).

有关实现代理方法的更多信息，请参阅 [UNUserNotificationCenterDelegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate)。

# See Also - 其他参考

## Processing received notifications - 处理收到的通知
### protocol [UNUserNotificationCenterDelegate](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate)

An interface for processing incoming notifications and responding to notification actions.

用于处理传入通知并响应通知操作的接口。

### var [supportsContentExtensions](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/2196946-supportscontentextensions): Bool

A Boolean value that indicates whether the device supports notification content extensions.

一个布尔值，表示设备是否支持通知内容扩展。