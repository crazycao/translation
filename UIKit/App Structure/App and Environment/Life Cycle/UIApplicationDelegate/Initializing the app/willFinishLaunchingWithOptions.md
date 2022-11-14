# application(_:willFinishLaunchingWithOptions:)

原文链接：[https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623032-application](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623032-application)

Tells the delegate that the launch process has begun but that state restoration hasn’t occured.

告诉代理启动过程已开始，但状态恢复尚未发生。

> iOS 6.0+
> 
> iPadOS 6.0+
> 
> Mac Catalyst 13.1+
> 
> tvOS 9.0+

## Declaration - 声明

```
optional func application(
    _ application: UIApplication,
    willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
) -> Bool
```

## Parameters - 参数

- `application`

	Your singleton app object.

	你的单例 app 对象。

- `launchOptions`

	A dictionary indicating the reason the app was launched (if any). The contents of this dictionary may be empty in situations where the user launched the app directly. For information about the possible keys in this dictionary and how to handle them, see [UIApplication.LaunchOptionsKey](https://developer.apple.com/documentation/uikit/uiapplication/launchoptionskey).
	
	指明 App 启动原因（如果有）的字典。在用户直接启动 App 的情况下，该字典的内容可能为空。有关字典中可能的 key 以及如何处理它们的信息，请参阅 [UIApplication.LaunchOptionsKey](https://developer.apple.com/documentation/uikit/uiapplication/launchoptionskey)。

## Return Value - 返回值

`false` if the app cannot handle the URL resource or continue a user activity, or if the app should not perform the [application(_:performActionFor:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622935-application) method because you’re handling the invocation of a Home screen quick action in this method; otherwise return `true`. The return value is ignored if the app is launched as a result of a remote notification.

如果 App 无法处理 URL 资源或无法继续用户活动，或者 App 不应该执行 [application(_:performActionFor:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622935-application) 方法，因为你正在这个方法中处理主屏幕快速操作的调用；以上情况返回 `false`，否则返回 `true`。如果通过远程通知启动 App，则会忽略返回值。

## Discussion - 讨论

Use this method (and the corresponding [application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application) method) to initialize your app and prepare it to run. This method is called after your app has been launched and its main storyboard or nib file has been loaded, but before your app’s state has been restored. At the time this method is called, your app is in the inactive state.

使用这个方法（以及相应的 [application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application) 方法）初始化你的 App 并准备运行。该方法在 App 启动之后被调用，而它的 main storyboard 或 nib 文件还没有加载，但是在 App 的状态恢复之前。在调用此方法时，你的 App 处于 inactive 状态。

If your app was launched by the system for a specific reason, the `launchOptions` dictionary contains data indicating the reason for the launch. For some launch reasons, the system may call additional methods of your app delegate. For example, if your app was launched to open a URL, the system calls the [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) method after your app finishes initializing itself. The presence of the launch keys gives you the opportunity to plan for that behavior. In the case of a URL to open, you might want to prevent state restoration if the URL represents a document that the user wanted to open.

如果你的 App 是由系统出于特定原因启动的，那么 `launchOptions` 字典就会包含指明启动原因的数据。对于某些启动原因，系统可能调用你的 App 代理的其他方法。例如，如果你的 App 被启动以打开一个 URL，系统就会在 App 初始化之后调用 [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) 方法。启动 key 的存在为您提供了计划该行为的机会。在要打开 URL 的案例中，如果 URL 代表一个用户想要打开的文档，你可能想要阻止状态恢复。

When asked to open a URL, the return result from this method is combined with the return result from the  [application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application) method to determine if a URL should be handled. If either method returns false, the system does not call the [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) method. If you do not implement one of the methods, only the return value of the implemented method is considered.

当请求打开 URL 时，该方法的返回结果与  [application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622921-application)  方法的结果相结合，以确定是否要处理这个 URL。如果任一方法返回 `false`，系统就不会调用 [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) 方法。如果你不实现其中一个方法，则只考虑已实现的方法的返回值。

In some cases, the user launches your app with a Home screen quick action. To ensure you handle this launch case correctly, read the discussion in the [application(_:performActionFor:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622935-application) method.

在某些情况下，用户会使用主屏幕快速操作启动 App。为了确保正确的处理这种启动情况，请阅读 [application(_:performActionFor:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622935-application) 方法中的讨论。

> **Important** **重要**
>
> If your app relies on the state restoration machinery to restore its view controllers, always show your app’s window from this method. Do not show the window in your app’s `application(_:didFinishLaunchingWithOptions:)` method. Calling the window’s `makeKeyAndVisible()` method does not make the window visible right away anyway. UIKit waits until your app’s `application(_:didFinishLaunchingWithOptions:)` method finishes before making the window visible on the screen.
> 
> 如果您的应用程序依赖于状态恢复机制来恢复其视图控制器，请始终使用此方法显示应用程序的窗口。不要在 App 的  `application(_:didFinishLaunchingWithOptions:)` 方法中展示 window。调用 window 的 `makeKeyAndVisible()` 方法不会是 window 立即可见。UIKit 会等到 App 的 `application(_:didFinishLaunchingWithOptions:)` 方法完成，才会让 window 在屏幕上可见。

# See Also - 其他参考

## Initializing the app - 初始化应用程序

### func application(UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool

Tells the delegate that the launch process is almost done and the app is almost ready to run.

### struct UIApplication.LaunchOptionsKey

The keys you use to access values in the launch options dictionary that the system passes to your app at initialization.

### class let didFinishLaunchingNotification: NSNotification.Name

A notification that posts immediately after the app finishes launching.


