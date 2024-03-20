# requestAuthorization(options:completionHandler:)

原文地址：
[https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/requestauthorization(options:completionhandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/requestauthorization(options:completionhandler:))

Requests a person’s authorization to allow local and remote notifications for your app.

请求用户授权，允许您的应用程序发送本地和远程通知。

> iOS 10.0+
iPadOS 10.0+
macOS 10.14+
Mac Catalyst 13.1+
tvOS 10.0+
watchOS 3.0+
visionOS 1.0+

- iOS, iPadOS, macOS, tvOS, watchOS

```
func requestAuthorization(
    options: UNAuthorizationOptions = [],
    completionHandler: @escaping (Bool, (any Error)?) -> Void
)
```

- iOS, iPadOS

```
func requestAuthorization(options: UNAuthorizationOptions = []) async throws -> Bool
```

# Parameters

- **options**

	The authorization options your app is requesting. You may combine the available constants to request authorization for multiple items. Request only the authorization options that you plan to use. For a list of possible values, see [UNAuthorizationOptions](https://developer.apple.com/documentation/usernotifications/unauthorizationoptions).
	
	您的应用程序正在请求的授权选项。您可以组合可用的常量来请求对多个项目的授权。只请求您计划使用的授权选项。有关可能值的列表,请参见 [UNAuthorizationOptions](https://developer.apple.com/documentation/usernotifications/unauthorizationoptions)。

- **completionHandler**

	The block to execute asynchronously with the results. This block may execute on a background thread. The block has no return value and has the following parameters:
	
	异步执行结果的代码块。此代码块可能在后台线程上执行。该代码块没有返回值，并具有以下参数:

	- **granted**

		A Boolean value indicating whether the person grants authorization. The value of this parameter is true when the person grants authorization for one or more options. The value is false when the person denies authorization or authorization is undetermined. Use [getNotificationSettings(completionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/getnotificationsettings(completionhandler:)) to check the authorization status.
		
		一个布尔值，表示用户是否授予授权。当用户为一个或多个选项授予授权时，此参数的值为 true。当用户拒绝授权或授权状态不确定时,该值为 false。使用 [getNotificationSettings(completionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/getnotificationsettings(completionhandler:)) 来检查授权状态。

	- **error**

		An object containing error information or nil if no error occurs.
		
		一个包含错误信息的对象，如果没有发生错误则为nil。


# Discussion - 讨论

> **Important** **重要**
>
> You can call this method from synchronous code using a completion handler, as shown on this page, or you can call it as an asynchronous method that has the following declaration:
> 
> 您可以使用完成处理程序从同步代码中调用此方法，如本页所示，也可以将其作为具有以下声明的异步方法来调用:
>
> ```
> func requestAuthorization(options: UNAuthorizationOptions = []) async throws -> Bool
> ```
>
> For information about concurrency and asynchronous code in Swift, see [Calling Objective-C APIs Asynchronously](https://developer.apple.com/documentation/Swift/calling-objective-c-apis-asynchronously).
> 
> 有关 Swift 中并发和异步代码的信息,请参阅《[异步调用 Objective-C API](https://developer.apple.com/documentation/Swift/calling-objective-c-apis-asynchronously)》。

If your app’s local or remote notifications involve user interactions, you must request authorization for the system to perform those interactions on your app’s behalf. Interactions include displaying an alert, playing a sound, or badging the app’s icon.

如果您应用程序的本地或远程通知涉及用户交互，则必须请求授权，以便系统能够代表您的应用程序执行这些交互。交互包括显示警报、播放声音或为应用程序图标添加角标。

> **Note** **注意**
>
> Always call this method before scheduling any local notifications and before registering with the Apple Push Notification service. Do this in a context that helps people understand why your app needs authorization, as described in [Asking permission to use notifications](https://developer.apple.com/documentation/usernotifications/asking-permission-to-use-notifications).
> 
> 请始终在安排任何本地通知和注册 Apple 推送通知服务之前调用这个方法。请在一个有助于用户理解为什么您的应用需要获得授权的上下文中做这件事，正如《[请求允许使用通知](https://developer.apple.com/documentation/usernotifications/asking-permission-to-use-notifications)》中所描述的那样。


The first time your app calls the method, the system prompts the person to authorize the requested interactions. The person may grant or deny authorization, and the system stores the person’s response. Subsequent calls to this method don’t prompt the person again. After determining the authorization status, the user notification center object executes the block in the `completionHandler` parameter. Use that block to make any adjustments to your app’s behavior. For example, if the person denied authorization, you might notify a remote notification server not to send notifications to the user’s device.

当您的应用程序首次调用该方法时，系统会提示用户授权所请求的交互。用户可以授予或拒绝授权，系统会存储用户的响应。之后对该方法的调用不会再次提示用户。在确定授权状态后，用户通知中心对象会执行 `completionHandler` 参数中的块。使用该块来调整您的应用程序的行为。例如，如果用户拒绝了授权，您可能会通知远程通知服务器不要向用户的设备发送通知。

The person may change the interactions they allow at any time in system settings. Use the [getNotificationSettings(completionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/getnotificationsettings(completionhandler:)) method to determine what interactions are allowed for your app.

用户可以随时在系统设置中更改允许的交互。使用 [getNotificationSettings(completionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/getnotificationsettings(completionhandler:)) 方法来确定允许您的应用程序进行哪些交互。

```
let center = UNUserNotificationCenter.current()
do {
     if try await center.requestAuthorization() == true {
          // You have authorization.
     } else {
          // You don't have authorization.
     }
} catch {
     // Handle any errors.
}
```

# See Also - 其他参考

## Requesting authorization - 请求授权

### struct [UNAuthorizationOptions](https://developer.apple.com/documentation/usernotifications/unauthorizationoptions)

Options that determine the authorized features of local and remote notifications.

用于确定本地和远程通知的授权功能的选项。

