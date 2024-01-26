# userNotificationCenter(_:willPresent:withCompletionHandler:)

原文地址：
[https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter)

Asks the delegate how to handle a notification that arrived while the app was running in the foreground.

询问代理如何处理在应用程序在前台运行时到达的通知。

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
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
)
```

# Parameters - 参数

- **center**

	The shared user notification center object that received the notification.
	
	收到通知的共享用户通知中心对象。

- **notification**

	The notification that is about to be delivered. Use the information in this object to determine an appropriate course of action. For example, you might use the information to update your app’s interface.
	
	即将递送的通知。使用此对象中的信息来确定适当的操作方式。例如，您可以使用这些信息来更新您应用程序的界面。

- **completionHandler**

	The block to execute with the presentation option for the notification. Always execute this block at some point during your implementation of this method. Use the options parameter to specify how you want the system to alert the user, if at all. This block has no return value and takes the following parameter:
	
	执行通知的展示选项的 block。在实现此方法的过程中，始终要执行此 block。使用 options 参数来指定您希望系统如何提醒用户（如果有的话）。该 block 没有返回值，并带有以下参数：

	- **options**

		The option for notifying the user. Specify [UNNotificationPresentationOptionNone](https://developer.apple.com/documentation/usernotifications/unnotificationpresentationoptionnone) to silence the notification completely. Specify other values to interact with the user. For a list of possible options, see [UNNotificationPresentationOptions](https://developer.apple.com/documentation/usernotifications/unnotificationpresentationoptions).
		
		通知用户的选项。指定 [UNNotificationPresentationOptionNone](https://developer.apple.com/documentation/usernotifications/unnotificationpresentationoptionnone) 来完全静音通知。指定其他值与用户进行交互。有关可能选项的列表，请参阅 [UNNotificationPresentationOptions](https://developer.apple.com/documentation/usernotifications/unnotificationpresentationoptions)。



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

If your app is in the foreground when a notification arrives, the shared user notification center calls this method to deliver the notification directly to your app. If you implement this method, you can take whatever actions are necessary to process the notification and update your app. When you finish, call the `completionHandler` block and specify how you want the system to alert the user, if at all.

如果您的应用程序在通知到达时处于前台，则共享的用户通知中心会调用此方法直接将通知传递给您的应用程序。如果您实现了此方法，您可以采取必要的操作来处理通知并更新您的应用程序。完成后，请调用 `completionHandler` block 并指定您希望系统如何提醒用户，视情况而定。

If your delegate does not implement this method, the system behaves as if you had passed the `UNNotificationPresentationOptionNone` option to the `completionHandler` block. If you do not provide a delegate at all for the `UNUserNotificationCenter` object, the system uses the notification’s original options to alert the user.

如果您的委托未实现此方法，则系统会表现得好像您向 `completionHandler` block 传递了 `UNNotificationPresentationOptionNone` 选项。如果您根本不为 `UNUserNotificationCenter` 对象提供委托，则系统将使用通知的原始选项来提醒用户。