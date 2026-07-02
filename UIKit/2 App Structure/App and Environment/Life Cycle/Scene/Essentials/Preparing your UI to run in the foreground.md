# Preparing your UI to run in the foreground

原文链接：[https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-foreground](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-foreground)

Configure your app to appear onscreen.

配置你的应用以在屏幕上显示。


## Overview - 概览

Use foreground transitions to prepare your app's UI to appear onscreen. An app's transition to the foreground is usually in response to a user action. For example, when the user taps the app's icon, the system launches the app and brings it to the foreground. Use a foreground transition to update your app's UI, acquire resources, and start the services you need to handle user requests.

使用前台转场来准备应用显示在屏幕上的 UI。应用向前台的转场通常是响应用户操作而发生的。例如当用户点击应用图标时，系统会启动应用并将其切换到前台。利用前台转场来更新应用的 UI、获取所需资源，并启动处理用户请求所需的服务。

All state transitions result in UIKit sending notifications to the appropriate delegate object:

所有状态转场都会导致 UIKit 向相应的委托对象发送通知：

- In iOS 13 and later — A [UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate) object.
- In iOS 12 and earlier — The [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) object.

- iOS 13 及更高版本 — 使用 [UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate) 对象。
- iOS 12 及更早版本 — 使用 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 对象。

You can support both types of delegate objects, but UIKit always uses scene delegate objects when they're available. UIKit notifies only the scene delegate associated with the specific scene that's entering the foreground. For information about how to configure scene support, see [Specifying the scenes your app supports](https://developer.apple.com/documentation/uikit/specifying-the-scenes-your-app-supports).

你可以同时支持这两种委托对象，但当场景委托对象可用时，UIKit 始终优先使用它。UIKit 仅通知与正在进入前台的特定场景关联的场景委托。有关如何配置场景支持的信息，请参阅 [Specifying the scenes your app supports](https://developer.apple.com/documentation/uikit/specifying-the-scenes-your-app-supports)。


## Update your app's data model when entering the foreground - 进入前台时更新数据模型

At launch time, the system starts your app in the inactive state before transitioning it to the foreground. Use your app's launch-time methods to perform any work needed at that time. For an app that's in the background, UIKit moves your app to the inactive state by calling one of the following methods:

在启动时，系统会先将应用置于未激活状态，然后再将其转场至前台。使用应用的启动时方法执行此时所需的工作。对于处于后台的应用，UIKit 通过调用以下方法之一将应用移至未激活状态：

- For apps that support scenes — The [sceneWillEnterForeground(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenewillenterforeground(_:)) method of the appropriate scene delegate object.
- For all other apps — The [applicationWillEnterForeground(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationwillenterforeground(_:)) method.

- 支持场景的应用 — 相应场景委托对象的 [sceneWillEnterForeground(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenewillenterforeground(_:)) 方法。
- 其他所有应用 — [applicationWillEnterForeground(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationwillenterforeground(_:)) 方法。

When transitioning from the background to the foreground, use these methods to load resources from disk and fetch data from the network.

当从后台转场到前台时，使用这些方法从磁盘加载资源并从网络获取数据。

For information about how to prepare your app at launch time, see [Responding to the launch of your app](https://developer.apple.com/documentation/uikit/responding-to-the-launch-of-your-app).

有关如何在启动时准备应用的信息，请参阅 [Responding to the launch of your app](https://developer.apple.com/documentation/uikit/responding-to-the-launch-of-your-app)。


## Configure your user interface and initial tasks at activation - 激活时配置用户界面和初始任务

The system moves your app to the active state immediately before displaying the app's UI. Activation is a good time to configure your app's UI and runtime behavior; specifically:

系统会在显示应用 UI 之前立即将应用切换到激活状态。激活是配置应用 UI 和运行时行为的好时机，具体包括：

- Show your app's windows, if needed.
- Change the currently visible view controller, if needed.
- Update the data values and state of views and controls.
- Display controls to resume a paused game.
- Start or resume any dispatch queues that you use to execute tasks.
- Update data source objects.
- Start timers for periodic tasks.

- 根据需要显示应用的窗口。
- 根据需要切换当前可见的视图控制器。
- 更新视图和控件的数据值与状态。
- 显示用于恢复已暂停游戏的控件。
- 启动或恢复用于执行任务的调度队列。
- 更新数据源对象。
- 为周期性任务启动计时器。

Put your configuration code in one of the following methods:

将配置代码放在以下方法之一中：

- For a scene-based UI — The [sceneDidBecomeActive(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenedidbecomeactive(_:)) method of the appropriate scene delegate object.
- For all other apps — The [applicationDidBecomeActive(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationdidbecomeactive(_:)) method of your app delegate object.

- 基于场景的 UI — 相应场景委托对象的 [sceneDidBecomeActive(_:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/scenedidbecomeactive(_:)) 方法。
- 其他所有应用 — 应用委托对象的 [applicationDidBecomeActive(_:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/applicationdidbecomeactive(_:)) 方法。

Activation is also the time to put finishing touches on your UI before displaying it to the user. Don't run any code that might block your activation method. Instead, make sure you have everything you need in advance. For example, if your data changes frequently outside of the app, use background tasks to fetch updates from the network before your app returns to the foreground. Otherwise, be prepared to display existing data while you fetch changes asynchronously.

激活阶段也是在将 UI 展示给用户之前进行最后润色的时机。不要在激活方法中运行任何可能造成阻塞的代码，而应提前准备好所需的一切。例如，如果应用外部的数据频繁变化，请在应用返回前台之前使用后台任务从网络获取更新；否则，应做好在异步获取变更数据期间展示现有数据的准备。


## Start UI-specific tasks when your view appears - 视图出现时启动 UI 相关任务

When your activation method returns, UIKit shows any windows that you made visible. It also notifies any relevant view controllers that their views are about to appear. Use your view controller's [viewWillAppear(_:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/viewwillappear(_:)) method to perform any final updates to your interface. For example:

当激活方法返回后，UIKit 会显示所有你设为可见的窗口，同时通知相关视图控制器其视图即将出现。使用视图控制器的 [viewWillAppear(_:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/viewwillappear(_:)) 方法对界面进行最终更新。例如：

- Start user interface animations, as appropriate.
- Begin playing media files, if auto-play is enabled.
- Begin displaying graphics for games and immersive content at their full frame rates.

- 适时启动用户界面动画。
- 如果已启用自动播放，开始播放媒体文件。
- 以全帧率开始显示游戏和沉浸式内容的图形。

Don't try to show a different view controller or make major changes to your user interface. By the time your view controller appears onscreen, your interface should be ready to display.

不要尝试显示不同的视图控制器或对用户界面进行重大更改。当视图控制器出现在屏幕上时，界面应该已经准备好显示了。


## Topics - 主题

### State-change notifications - 状态变更通知

- [Processing queued notifications](https://developer.apple.com/documentation/uikit/processing-queued-notifications)

	Respond to notifications when coming out of the suspended state.

	当应用从挂起状态恢复运行时，对通知进行响应。


## See Also - 另请参阅

### Essentials - 基础

- [Preparing your UI to run in the background](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-background)

	Prepare your app to be suspended.

	为应用进入挂起状态做好准备。
