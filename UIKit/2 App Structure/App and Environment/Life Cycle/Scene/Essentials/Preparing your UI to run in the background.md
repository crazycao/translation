# Preparing your UI to run in the background

原文链接：[https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-background](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-background)

Prepare your app to be suspended.

为应用进入挂起状态做好准备。


## Overview - 概览

Apps move to the background state for many reasons. When the user exits a foreground app, that app moves to the background state briefly before UIKit suspends it. The system may also launch an app directly into the background state, or move a suspended app into the background, and give it time to perform important tasks.

应用因多种原因会进入后台状态。当用户退出前台应用时，该应用会短暂进入后台状态，随后被 UIKit 挂起。系统也可能直接在后台状态下启动应用，或将已挂起的应用移入后台，并给予其时间执行重要任务。

When your app is in the background, it should do as little as possible, and preferably nothing. If your app was previously in the foreground, use the background transition to stop tasks and release any shared resources. If your app enters the background to process an important event, process the event and exit as quickly as possible.

当应用处于后台时，它应该尽量少做事，最好什么都不做。如果应用之前处于前台，请利用后台转场停止任务并释放所有共享资源。如果应用进入后台是为了处理重要事件，请尽快处理完事件后退出。

All state transitions result in UIKit sending notifications to the appropriate delegate object:

所有状态转场都会导致 UIKit 向相应的委托对象发送通知：

- In iOS 13 and later — A [UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate) object.
- In iOS 12 and earlier — The [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) object.

- iOS 13 及更高版本 — 使用 [UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate) 对象。
- iOS 12 及更早版本 — 使用 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 对象。

You can support both types of delegate objects, but UIKit always uses scene delegate objects when they're available. UIKit notifies only the scene delegate associated with the specific scene that's entering the background.

你可以同时支持这两种委托对象，但当场景委托对象可用时，UIKit 始终优先使用它。UIKit 仅通知与正在进入后台的特定场景关联的场景委托。


## Quiet your app upon deactivation - 停用时让应用安静下来

The system deactivates apps for several reasons. When the user exits the foreground app, the system deactivates that app immediately before moving it to the background. The system also deactivates apps when it needs to interrupt them temporarily — for example, to display system alerts. In the case of a system panel, the system reactivates the app when the user dismisses the panel.

系统因多种原因会停用应用。当用户退出前台应用时，系统会在将其移至后台之前立即停用该应用。系统也会在需要临时中断应用时停用它，例如显示系统提醒。对于系统面板的情况，当用户关闭面板后，系统会重新激活应用。

During deactivation, UIKit calls one of the following methods of your app:

在停用期间，UIKit 会调用应用的以下方法之一：

- For apps that support scenes — The [sceneWillResignActive(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenewillresignactive(_:)) method of the appropriate scene delegate object.
- For all other apps — The [applicationWillResignActive(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationwillresignactive(_:)) method of the app delegate object.

- 支持场景的应用 — 相应场景委托对象的 [sceneWillResignActive(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenewillresignactive(_:)) 方法。
- 其他所有应用 — 应用委托对象的 [applicationWillResignActive(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationwillresignactive(_:)) 方法。

Use deactivation to preserve the user's data and put your app in a quiet state by pausing all major work; specifically:

利用停用时机保存用户数据，并通过暂停所有主要工作将应用置于静默状态，具体包括：

- Save user data to disk and close any open files.
- Suspend dispatch and operation queues.
- Don't schedule any new tasks for execution.
- Invalidate any active timers.
- Pause gameplay automatically.
- Don't commit any new Metal work to be processed.
- Don't commit any new OpenGL commands.

- 将用户数据保存到磁盘并关闭所有打开的文件。
- 暂停调度队列和操作队列。
- 不要安排任何新任务执行。
- 使所有活跃的计时器失效。
- 自动暂停游戏进程。
- 不要提交任何新的 Metal 工作以供处理。
- 不要提交任何新的 OpenGL 命令。


## Release resources upon entering the background - 进入后台时释放资源

When your app transitions to the background, release memory and free up any shared resources your app is holding. For an app transitioning from the foreground to the background, freeing up memory is especially important. The foreground has priority over memory and other system resources, and the system terminates background apps as needed to make those resources available. Even if your app wasn't in the foreground, perform checks to ensure that it consumes as few resources as possible.

当应用转场至后台时，释放内存并释放应用持有的所有共享资源。对于从前台转场至后台的应用，释放内存尤为重要。前台应用在内存和其他系统资源方面享有优先权，系统会根据需要终止后台应用以释放这些资源。即使应用之前不在前台，也应进行检查以确保其占用尽可能少的资源。

Upon entering the background, UIKit calls one of the following methods of your app:

进入后台时，UIKit 会调用应用的以下方法之一：

- For apps that support scenes — The [sceneDidEnterBackground(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenedidenterbackground(_:)) method of the appropriate scene delegate object.
- For all other apps — The [applicationDidEnterBackground(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationdidenterbackground(_:)) method of the app delegate object.

- 支持场景的应用 — 相应场景委托对象的 [sceneDidEnterBackground(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenedidenterbackground(_:)) 方法。
- 其他所有应用 — 应用委托对象的 [applicationDidEnterBackground(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationdidenterbackground(_:)) 方法。

During a background transition, perform as many of the following tasks as makes sense for your app:

在后台转场期间，根据应用的实际情况执行以下尽可能多的任务：

- Discard any images or media that you read directly from files.
- Discard any large, in-memory objects that you can recreate or reload from disk.
- Release access to the camera and other shared hardware resources.
- Hide sensitive information (such as passwords) in your app's user interface.
- Dismiss alerts and other temporary interfaces.
- Close connections to any shared system databases.
- Unregister from Bonjour services and close any listening sockets associated with them.
- Ensure that all Metal command buffers have been scheduled. For more information, see Preparing your Metal app to run in the background.
- Ensure that all OpenGL commands you previously submitted have finished.

- 丢弃直接从文件读取的任何图像或媒体内容。
- 丢弃可以从磁盘重新创建或重新加载的大型内存对象。
- 释放对摄像头和其他共享硬件资源的访问权限。
- 在应用的用户界面中隐藏敏感信息（如密码）。
- 关闭提醒和其他临时界面。
- 关闭与任何共享系统数据库的连接。
- 从 Bonjour 服务取消注册，并关闭与之关联的所有监听套接字。
- 确保所有 Metal 命令缓冲区已完成调度。更多信息请参阅 Preparing your Metal app to run in the background。
- 确保之前提交的所有 OpenGL 命令已执行完毕。

You don't need to discard named images that you loaded from your app's asset catalog. Similarly, you don't need to release objects that adopt the `NSDiscardableContent` protocol or that you manage using an `NSCache` object. The system automatically handles the cleanup of those objects.

你不需要丢弃从应用资产目录加载的具名图像。同样，你也不需要释放遵循 `NSDiscardableContent` 协议的对象，或通过 `NSCache` 对象管理的对象。系统会自动处理这些对象的清理工作。

Make sure your app isn't holding any shared system resources when it transitions to the background. If it continues accessing resources like the camera or a shared system database after transitioning to the background, the system terminates your app to free up that resource. If you use a system framework to access a resource, check the framework's documentation for guidelines about what to do.

确保应用在转场至后台时没有持有任何共享系统资源。如果应用在进入后台后继续访问摄像头或共享系统数据库等资源，系统将终止应用以释放该资源。如果你使用系统框架访问资源，请查阅该框架的文档以获取相关指导。


## Prepare your UI for the app snapshot - 为应用快照准备 UI

After your app enters the background and your delegate method returns, UIKit takes a snapshot of your app's current user interface. The system displays the resulting image in the app switcher. It also displays the image temporarily when bringing your app back to the foreground.

在应用进入后台且委托方法返回后，UIKit 会对应用当前的用户界面进行截图。系统会在应用切换器中显示该图像，也会在将应用切换回前台时临时显示该图像。

Your app's UI must not contain any sensitive user information, such as passwords or credit card numbers. If your interface contains such information, remove it from your views when entering the background. Also, dismiss alerts, temporary interfaces, and system view controllers that obscure your app's content. The snapshot represents your app's interface and should be recognizable to users. When your app returns to the foreground, you can restore data and views as appropriate.

应用的 UI 不得包含任何敏感用户信息，例如密码或信用卡号码。如果界面包含此类信息，请在进入后台时将其从视图中移除。同时，关闭遮挡应用内容的提醒、临时界面和系统视图控制器。快照代表应用的界面，应能被用户识别。当应用返回前台时，可以适当恢复数据和视图。

> For apps that support state preservation and restoration, the system begins the preservation process shortly after your delegate method returns. Removing sensitive data also prevents that information from being saved in your app's preservation archive. For more information, see [Preserving your app's UI across launches](https://developer.apple.com/documentation/uikit/preserving-your-app-s-ui-across-launches).
>
> 对于支持状态保留与恢复的应用，系统会在委托方法返回后不久开始保留流程。移除敏感数据也可防止该信息被保存到应用的保留归档中。更多信息请参阅 [Preserving your app's UI across launches](https://developer.apple.com/documentation/uikit/preserving-your-app-s-ui-across-launches)。


## Respond to important events in the background - 在后台响应重要事件

Apps don't normally receive any extra execution time after they enter the background. However, UIKit does grant execution time to apps that support any of the following time-sensitive capabilities:

应用进入后台后通常不会获得额外的执行时间。但是，UIKit 会向支持以下任一时间敏感功能的应用授予执行时间：

- Audio communication using AirPlay, or Picture in Picture video.
- Location-sensitive services for users.
- Voice over IP.
- Communication with an external accessory.
- Communication with Bluetooth LE accessories, or conversion of the device into a Bluetooth LE accessory.
- Regular updates from a server.
- Support for Apple Push Notification service (APNs).

- 使用 AirPlay 进行音频通信，或使用画中画视频。
- 面向用户的位置敏感服务。
- VoIP（网络电话）。
- 与外部配件通信。
- 与蓝牙 LE 配件通信，或将设备转换为蓝牙 LE 配件。
- 从服务器定期更新。
- 支持 Apple 推送通知服务（APNs）。

Enable the Background Modes capability in Xcode if your app supports background features. Each background task has different requirements; see the appropriate framework for details about how to implement the feature. For information about how to schedule opportunistic background tasks, see [Background Tasks](https://developer.apple.com/documentation/backgroundtasks).

如果应用支持后台功能，请在 Xcode 中启用 Background Modes 功能。每种后台任务有不同的要求，请查阅相应框架的文档以了解如何实现该功能。有关如何调度后台任务的信息，请参阅 [Background Tasks](https://developer.apple.com/documentation/backgroundtasks)。


## Topics - 主题

### Background execution - 后台执行

- [Using background tasks to update your app](https://developer.apple.com/documentation/uikit/using-background-tasks-to-update-your-app)

	Configure your app to perform tasks in the background to make efficient use of processing time and power.

	配置应用在后台执行任务，以高效利用处理时间和电量。

- [Extending your app's background execution time](https://developer.apple.com/documentation/uikit/extending-your-app-s-background-execution-time)

	Ensure that critical tasks finish when your app moves to the background.

	确保应用移至后台时关键任务能够完成。

- [About the background execution sequence](https://developer.apple.com/documentation/uikit/about-the-background-execution-sequence)

	Learn the order in which your custom code is executed when your app moves to the background.

	了解应用移至后台时自定义代码的执行顺序。


## See Also - 另请参阅

### Essentials - 基础

- [Preparing your UI to run in the foreground](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-foreground)

	Configure your app to appear onscreen.

	配置你的应用以在屏幕上显示。
