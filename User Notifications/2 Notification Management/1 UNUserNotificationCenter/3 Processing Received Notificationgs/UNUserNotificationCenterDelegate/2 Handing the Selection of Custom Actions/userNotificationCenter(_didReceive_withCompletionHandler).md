# userNotificationCenter(_:didReceive:withCompletionHandler:)

原文地址：
[https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter)

Asks the delegate to process the user's response to a delivered notification.

请求代理对象处理用户对已发送通知的响应。

> iOS 10.0+
iPadOS 10.0+
macOS 10.14+
Mac Catalyst 13.1+
tvOS 10.0+
watchOS 3.0+
visionOS 1.0+

```
optional func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
)
```

# Parameters - 参数

- **center**

	The shared user notification center object that received the notification.
	
	收到通知的共享用户通知中心对象。

- **response**

	The user’s response to the notification. This object contains the original notification and the identifier string for the selected action. If the action allowed the user to provide a textual response, this parameter contains a [UNTextInputNotificationResponse](https://developer.apple.com/documentation/usernotifications/untextinputnotificationresponse) object.
	
	用户对通知的响应。此对象包含原始通知和所选操作的标识符字符串。如果操作允许用户提供文本响应，则此参数包含一个 [UNTextInputNotificationResponse](https://developer.apple.com/documentation/usernotifications/untextinputnotificationresponse) 对象。

- **completionHandler**

	The block to execute when you have finished processing the user’s response. You must execute this block at some point after processing the user's response to let the system know that you are done. The block has no return value or parameters.
	
	在完成处理用户的响应后执行的 block。您必须在处理完用户的响应后的某个时间点执行此 block，以告知系统您已完成处理。该 block 没有返回值或参数。

# Discussion - 讨论

> **Concurrency Note** **并发提醒**
>
> You can call this method from synchronous code using a completion handler, as shown on this page, or you can call it as an asynchronous method that has the following declaration:
> 
> 您可以从同步代码中调用此方法使用完成处理程序，如本页面所示，或者您可以将其作为具有以下声明的异步方法调用：
>
> ```
> optional func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async
> ```
> 
> For information about concurrency and asynchronous code in Swift, see [Calling Objective-C APIs Asynchronously](https://developer.apple.com/documentation/swift/calling-objective-c-apis-asynchronously).
> 
> 有关 Swift 中并发和异步代码的信息，请参阅《[Calling Objective-C APIs Asynchronously](https://developer.apple.com/documentation/swift/calling-objective-c-apis-asynchronously)》。

Use this method to process the user's response to a notification. If the user selected one of your app's custom actions, the response parameter contains the identifier for that action. (The response can also indicate that the user dismissed the notification interface, or launched your app, without selecting a custom action.) At the end of your implementation, call the `completionHandler` block to let the system know that you are done processing the user's response. If you do not implement this method, your app never responds to custom actions.

使用此方法来处理用户对通知的响应。如果用户选择了您应用程序的自定义操作之一，响应参数将包含该操作的标识符。（响应还可以指示用户关闭了通知界面或启动了您的应用程序，但未选择自定义操作。）在您的实现结束时，调用 `completionHandler` block，以告知系统您已完成处理用户的响应。如果您不实现此方法，您的应用程序将不会对自定义操作做出响应。

You specify your app’s notification types at app launch using [UNNotificationCategory](https://developer.apple.com/documentation/usernotifications/unnotificationcategory) objects, and you specify the custom actions for each type using [UNNotificationAction](https://developer.apple.com/documentation/usernotifications/unnotificationaction) objects. For information, see [Declaring your actionable notification types](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types).

您可以在应用程序启动时使用 [UNNotificationCategory](https://developer.apple.com/documentation/usernotifications/unnotificationcategory) 对象指定应用程序的通知类型，并使用 [UNNotificationAction](https://developer.apple.com/documentation/usernotifications/unnotificationaction) 对象为每个类型指定自定义操作。有关详细信息，请参阅《[Declaring your actionable notification types](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types)》。