App Programming Guide for iOS (4) ---- Strategies for Handling App State Transitions

原文链接：[https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW1](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW1)

<span id="4">
#4 Strategies for Handling App State Transitions - 控制App状态转换的策略

For each of the possible runtime states of an app, the system has different expectations while your app is in that state. When state transitions occur, the system notifies the app object, which in turn notifies its app delegate. You can use the state transition methods of the [UIApplicationDelegate](https://developer.apple.com/reference/uikit/uiapplicationdelegate) protocol to detect these state changes and respond appropriately. For example, when transitioning from the foreground to the background, you might write out any unsaved data and stop any ongoing tasks. The following sections offer tips and guidance for how to implement your state transition code.

对于 APP 的每一个可能的运行时状态，当你的 APP 在该状态时系统有不同的期望。当状态转换发生时，系统通知 APP 对象，APP 对象接着通知它的 APP 代理。你可以使用 [UIApplicationDelegate](https://developer.apple.com/reference/uikit/uiapplicationdelegate) 协议的状态转换方法检测这些状态变化并适当的响应。例如，当从前台转换到后台时，你可以卸下任何未保存的数据并停止任何正在进行的任务。以下部分提供了如何实现你的状态转换代码的提示和指南。

<span id="4.1">
## 4.1 What to Do at Launch Time - 启动时做什么

When your app is launched (either into the foreground or background), use your app delegate’s [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods to do the following:

当你的 APP 启动时（无论进入前台或后台），使用你的 APP 代理的 [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) 和 [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) 方法做以下事情：

- Check the contents of the launch options dictionary for information about why the app was launched, and respond appropriately.

- Initialize your app’s critical data structures.

- Prepare your app’s window and views for display:

  - Apps that use OpenGL ES for drawing must not use these methods to prepare their drawing environment. Instead, defer any OpenGL ES drawing calls to the [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method.
  - Show your app window from your [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) method. UIKit delays making the window visible until after the [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) method returns.

- 检查启动选项字典的内容查看关于 APP 为什么被启动的信息，并适当的响应。
- 初始化你的 APP 的关键数据结构。
- 准备你的 APP 的显示窗口和视图：
  - 使用 OpenGL ES 来绘图的 APP 一定不能使用这些方法来准备它们的绘图环境。相反，将任何 OpenGL ES 绘图调用推迟到 [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) 方法。
  - 从你的 [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) 方法开始展示你的 APP 的窗口。UIKit 延迟让窗口可见，直到 [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) 方法返回之后。

At launch time, the system automatically loads your app’s main storyboard file and loads the initial view controller. For apps that support state restoration, the state restoration machinery restores your interface to its previous state between calls to the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods. Use the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) method to show your app window and to determine if state restoration should happen at all. Use the [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) method to make any final adjustments to your app’s user interface.

在启动时，系统自动加载你的 APP 的 main storyboard 文件并加载初始视图控制器。对于支持状态恢复的 APP，状态恢复机制会在调用 [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) 和 [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) 方法之间把你的界面恢复到先前的状态。 使用 [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) 方法展示你的 APP 的窗口并决定是否要恢复状态。使用 [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) 方法对你的 APP 的用户界面做任何最终的调整。

Your [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods should always be as lightweight as possible to reduce your app’s launch time. Apps are expected to launch, initialize themselves, and start handling events in less than 5 seconds. If an app does not finish its launch cycle in a timely manner, the system kills it for being unresponsive. Thus, any tasks that might slow down your launch (such as accessing the network) should be scheduled performed on a secondary thread.

你的 [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) 和 [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) 方法应该总是尽可能轻量以减少你的 APP 的启动时间。期望 APP 在 5 秒钟以内就可以启动、初始化并开始处理事件。如果 APP 没有即使完成它的启动周期，系统会由于没有响应而杀死它。因此，任何可能减慢你的启动的任务（比如访问网络）都应该被调度到辅助线程上执行。

<span id="4.1.1">
### 4.1.1 The Launch Cycle - 启动周期

When your app is launched, it moves from the not running state to the active or background state, transitioning briefly through the inactive state. As part of the launch cycle, the system creates a process and main thread for your app and calls your app’s `main` function on that main thread. The default `main` function that comes with your Xcode project promptly hands control over to the UIKit framework, which does most of the work in initializing your app and preparing it to run.

当你的 APP 被启动，它将从未运行状态移到活跃或后台状态，短暂的从不活跃状态过渡。作为启动周期的一部分，系统为你的 APP 创建一个进程和主线程，并在该主线程调用你的 APP 的 `main` 函数。Xcode 工程的默认 `main` 函数迅速将控制权交给 UIKit 框架，由它来完成大部分 APP 初始化工作并准备运行。 

Figure 4-1 shows the sequence of events that occurs when an app is launched into the foreground, including the app delegate methods that are called.

图 4-1 展示了当 APP 启动到前台时发生的事件顺序，包括被调用的 APP 代理方法。

**Figure 4-1**  Launching an app into the foreground - 启动 APP 到前台

![Figure 4-1](images/app_launch_fg_2x.png)

When your app is launched into the background—usually to handle some type of background event—the launch cycle changes slightly to the one shown in Figure 4-2. The main difference is that instead of your app being made active, it enters the background state to handle the event and may be suspended at some point after that. When launching into the background, the system still loads your app’s user interface files but it does not display the app’s window.

当你的 APP 被启动到后台 —— 通常为了处理某些类型的后台事件 —— 启动周期稍微变化为图 4-2 中所示。主要的不同在于你的 APP 不再变成活跃的，它进入后台状态处理事件，并且在之后的某个时间可能被挂起。当启动进入后台时，系统仍然加载你的 APP 的用户界面文件，但它不会显示到 APP 的窗口上。

**Figure 4-2**  Launching an app into the background - 启动 APP 进入后台

![Figure 4-2](images/app_launch_bg_2x.png)

To determine whether your app is launching into the foreground or background, check the [applicationState](https://developer.apple.com/reference/uikit/uiapplication/1623003-applicationstate) property of the shared `UIApplication` object in your `application:willFinishLaunchingWithOptions:` or `application:didFinishLaunchingWithOptions:` delegate method. When the app is launched into the foreground, this property contains the value [UIApplicationStateInactive](https://developer.apple.com/reference/uikit/uiapplicationstate/1623000-inactive). When the app is launched into the background, the property contains the value [UIApplicationStateBackground](https://developer.apple.com/reference/uikit/uiapplicationstate/uiapplicationstatebackground) instead. You can use this difference to adjust the launch-time behavior of your delegate methods accordingly.

要觉得你的 APP 是启动进入前台还是后台，在你的 `application:willFinishLaunchingWithOptions:` 或 `application:didFinishLaunchingWithOptions:` 代理方法中检查共享的 `UIApplication` 对象的 [applicationState](https://developer.apple.com/reference/uikit/uiapplication/1623003-applicationstate) 属性。当 APP 被启动进入前台，这个属性的值为 [UIApplicationStateInactive](https://developer.apple.com/reference/uikit/uiapplicationstate/1623000-inactive)。当 APP 被启动进入后台，这个属性的值则是 [UIApplicationStateBackground](https://developer.apple.com/reference/uikit/uiapplicationstate/uiapplicationstatebackground)。你可以使用该区别来相应的调整你的代理方法的启动时行为。

> **Note:** When an app is launched so that it can open a URL, the sequence of startup events is slightly different from those shown in Figure 4-1 and Figure 4-2. For information about the startup sequences that occur when opening a URL, see [Handling URL Requests](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Inter-AppCommunication/Inter-AppCommunication.html#//apple_ref/doc/uid/TP40007072-CH6-SW13).
> 
> **注意：** 当 APP 被启动以打开一个 URL，启动事件的顺序与图 4-1 和图 4-2 中展示的都有轻微的不同。关于打开 URL 时发生的启动顺序，参见 [Handling URL Requests](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Inter-AppCommunication/Inter-AppCommunication.html#//apple_ref/doc/uid/TP40007072-CH6-SW13)。

<span id="4.1.2">
### 4.1.2 Launching in Landscape Mode - 横屏模式启动

Apps that uses only landscape orientations for their interface must explicitly ask the system to launch the app in that orientation. Normally, apps launch in portrait mode and rotate their interface to match the device orientation as needed. For apps that support both portrait and landscape orientations, always configure your views for portrait mode and then let your view controllers handle any rotations. If, however, your app supports landscape but not portrait orientations, perform the following tasks to make it launch in landscape mode initially:

界面只使用横屏方向的 APP 必须准确的告诉系统以该方向启动 APP。正常情况下，APP 都以竖屏方向启动，并按需要旋转它们的界面以匹配设备方向。对于既支持横屏方向又支持竖屏方向的 APP，总是配置视图到竖屏方向，然后让你的视图控制器处理任意旋转。然而，如果你的 APP 支持横屏，但并不支持竖屏方向，执行下列操作让它初始以横屏模式启动：

- Add the `UIInterfaceOrientation` key to your app’s *Info.plist* file and set the value of this key to either [UIInterfaceOrientationLandscapeLeft](https://developer.apple.com/reference/uikit/uiinterfaceorientation/uiinterfaceorientationlandscapeleft) or [UIInterfaceOrientationLandscapeRight](https://developer.apple.com/reference/uikit/uiinterfaceorientation/uiinterfaceorientationlandscaperight).
- Lay out your views in landscape mode and make sure that their layout or autosizing options are set correctly.
- Override your view controller’s [shouldAutorotateToInterfaceOrientation:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621459-shouldautorotatetointerfaceorien) method and return a `YES` for the left or right landscape orientations and a `NO` for portrait orientations.
- 添加 `UIInterfaceOrientation` key 到你的 APP 的 *Info.plist* 文件，并设置这个 key 的值为 [UIInterfaceOrientationLandscapeLeft](https://developer.apple.com/reference/uikit/uiinterfaceorientation/uiinterfaceorientationlandscapeleft) 或 [UIInterfaceOrientationLandscapeRight](https://developer.apple.com/reference/uikit/uiinterfaceorientation/uiinterfaceorientationlandscaperight)。
- 以横屏模式布局你的视图，并确保它们的布局或自动大小选项被正确设置。
- 重载你的视图控制器的 [shouldAutorotateToInterfaceOrientation:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621459-shouldautorotatetointerfaceorien) 方法，并对左或右横屏方向返回 `YES` 且对竖屏方向返回 `NO`。

> **Important:** Apps should always use view controllers to manage their window-based content.
> 
> **重要：** APP 应该总是使用视图控制器管理它们基于窗口的内容。

The `UIInterfaceOrientation` key in the *Info.plist* file tells iOS that it should configure the orientation of the app status bar (if one is displayed) as well as the orientation of views managed by any view controllers at launch time. View controllers respect this key and set their view’s initial orientation to match. Using this key is equivalent to calling the [setStatusBarOrientation:animated:](https://developer.apple.com/reference/uikit/uiapplication/1622939-setstatusbarorientation) method of `UIApplication` early in the execution of your `applicationDidFinishLaunching:` method.

在 *Info.plist* 文件中的 `UIInterfaceOrientation` key 告诉 iOS 它在启动时应该配置的 APP 状态栏的方向（如果要显示）以及被视图控制器管理的视图的方向。视图控制器关心这个 key，并设置它们的视图的初始方向以匹配。使用这个 key 相当于早在你的 `applicationDidFinishLaunching:` 方法执行的时候就调用了 `UIApplication` 的 [setStatusBarOrientation:animated:](https://developer.apple.com/reference/uikit/uiapplication/1622939-setstatusbarorientation) 方法。

<span id="4.1.3">
### 4.1.3 Installing App-Specific Data Files at First Launch - 在首次启动时安装 APP 特定的数据文件

You can use your app’s first launch cycle to set up any data or configuration files required to run. App-specific data files should be created in the *Library/Application Support/<bundleID>/* directory of your app sandbox, where *<bundleID>* is your app’s bundle identifier. You can further subdivide this directory to organize your data files as needed. You can also create files in other directories, such as to your app’s iCloud container directory or to the local Documents directory, depending on your needs.

你可以使用你的 APP 的首次启动周期设置运行所需的任何数据或配置文件。APP 特定的数据文件应该在你的 APP 沙盒的 *Library/Application Support/<bundleID>/* 目录中被创建，此处 *<bundleID>* 就是你的 APP 的 bundle 标识符。你可以按需要进一步细分该目录以组织你的数据文件。你也可以在其他目录下创建文件，比如到你 APP 的 iCloud 容器目录或到本地 Documents 目录，取决于你的需要。

If your app’s bundle contains data files that you plan to modify, copy those files out of the app bundle and modify the copies. You must not modify any files inside your app bundle. Because iOS apps are code signed, modifying files inside your app bundle invalidates your app’s signature and will prevent your app from launching in the future. Copying those files to the `Application Support` directory (or another writable directory in your sandbox) and modifying them there is the only way to use such files safely.

如果你的 APP bundle 包含你想要修改的数据文件，从 APP bundle 中把那些文件拷贝出来并修改拷贝。你一定不能在你的 APP bundle 里面修改任何文件。因为 iOS APP 是被代码签名的，在你的 APP bundle 内部修改文件意味着你的 APP 签名将在未来阻止你的 APP 启动。拷贝那些文件到 `Application Support` 目录（或你的沙盒中其他可写的目录）并修改它们是安全使用这些文件的唯一途径。

For more information about where to put app-related data files, see [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672).

关于放置 APP 相关的数据文件的更多信息，参见 [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672)。

<span id="4.2">
## 4.2 What to Do When Your App Is Interrupted Temporarily - 当App被暂时中断时做什么

Alert-based interruptions result in a temporary loss of control by your app. Your app continues to run in the foreground, but it does not receive touch events from the system. (It does continue to receive notifications and other types of events, such as accelerometer events, though.) In response to this change, your app should do the following in its [applicationWillResignActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) method:

基于弹窗的中断结果是你的 APP 暂时失去控制权。你的 APP 继续在前台运行，但是它不会收到来自系统的触碰事件。（但是它仍然可以接收通知和其他类型的事件，比如加速计事件。）为了响应该变化，你的 APP 应该在它的 [applicationWillResignActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) 方法中做下面这些事情：

- Save data and any relevant state information.
- Stop timers and other periodic tasks.
- Stop any running metadata queries.
- Do not initiate any new tasks.
- Pause movie playback (except when playing back over AirPlay).
- Enter into a pause state if your app is a game.
- Throttle back OpenGL ES frame rates.
- Suspend any dispatch queues or operation queues executing non-critical code. (You can continue processing network requests and other time-sensitive background tasks while inactive.)
- 保存数据和任何相关的状态信息。
- 停止定时器和其他周期性的任务。
- 停止任何正在运行的元数据查询。
- 不要开始任何新任务。
- 暂停电影播放（除了通过 AirPlay 的播放）。
- 如果你的 APP 是一个游戏，进入暂停状态。
- 调低 OpenGL ES 帧率。
- 挂起任何正在执行非关键代码的调度队列或操作队列。（在不活跃时，你仍可以继续处理网络请求和其他事件敏感的后台任务。）

When your app is moved back to the active state, its [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method should reverse any of the steps taken in the `applicationWillResignActive:` method. Thus, upon reactivation, your app should restart timers, resume dispatch queues, and throttle up OpenGL ES frame rates again. However, games should not resume automatically; they should remain paused until the user chooses to resume them.

当你的 APP 被移入活跃状态，它的 [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) 方法应该反转在 `applicationWillResignActive:` 方法中执行的所有步骤。因此，重新激活后，你的 APP 应该重新启动定时器，恢复调度队列，并再次调高 OpenGL ES 帧率。然而，游戏不应该自动恢复；它们应该保持暂停，直到用户选择恢复它们。

When the user presses the Sleep/Wake button, apps with files protected by the [NSFileProtectionComplete](https://developer.apple.com/reference/foundation/fileprotectiontype/1616200-complete) protection option must close any references to those files. For devices configured with an appropriate password, pressing the Sleep/Wake button locks the screen and forces the system to throw away the decryption keys for files with complete protection enabled. While the screen is locked, any attempts to access the corresponding files will fail. So if you have such files, you should close any references to them in your `applicationWillResignActive:` method and open new references in your `applicationDidBecomeActive:` method.

当用户按下 Sleep/Wake 按钮，带有受 [NSFileProtectionComplete](https://developer.apple.com/reference/foundation/fileprotectiontype/1616200-complete) 保护选项保护的文件的 APP 必须关闭对那些文件的所有引用。对于配有适当密码的设备，按下 Sleep/Wake 按钮会锁住屏幕并且强制系统丢弃开启了完全保护的文件的解密密钥。当屏幕被锁住，任何访问相应文件的尝试都会失败。因此如果你有这样的文件，你应该在你的 `applicationWillResignActive:` 方法中关闭所有对它们的引用，并在你的 `applicationDidBecomeActive:` 方法中打开新的引用。

> **Important:** Always save user data at appropriate checkpoints in your app. Although you can use app state transitions to force objects to write unsaved changes to disk, never wait for an app state transition to save data. For example, a view controller that manages user data should save its data when it is dismissed.
> 
> **重要：** 在你的 APP 中总在适当的检查点保存用户数据。尽管你可以使用 APP 状态过渡强制对象把未保存的改变写入硬盘，但永远不要等到 APP 状态变化才保存数据。例如，管理用户数据的视图控制器应该在它消失时就保存它的数据。

<span id="4.2.1">
### 4.2.1 Responding to Temporary Interruptions - 响应暂时的中断

When an alert-based interruption occurs, such as an incoming phone call, the app moves temporarily to the inactive state so that the system can prompt the user about how to proceed. The app remains in this state until the user dismisses the alert. At this point, the app either returns to the active state or moves to the background state. Figure 4-3 shows the flow of events through your app when an alert-based interruption occurs.

当基于弹窗的中断发生时，比如一个呼入的电话，APP 会暂时移入不活跃状态，以便系统可以提醒用户要怎么做。APP 保持在这个状态，直到用户关闭弹窗。在这个时候，APP 会返回到活跃状态或者进入后台状态。图 4-3 展示了当基于弹窗的中断发生时通过你的 APP 的事件流。

**Figure 4-3**  Handling alert-based interruptions - 处理基于弹窗的中断

![Figure 4-3](images/app_interruptions_2x.png)

Notifications that display a banner do not deactivate your app in the way that alert-based notifications do. Instead, the banner is laid along the top edge of your app window and your app continues receive touch events as before. However, if the user pulls down the banner to reveal the notification center, your app moves to the inactive state just as if an alert-based interruption had occurred. Your app remains in the inactive state until the user dismisses the notification center or launches another app. At this point, your app moves to the appropriate active or background state. The user can use the Settings app to configure which notifications display a banner and which display an alert.

显示 banner 的通知不会像基于弹窗的通知那样使你的 APP 失活。相反，banner 被放在 APP 窗口的顶部边沿，而你的 APP 可以像之前一样继续接收触碰事件。但是，如果用户拉下 banner 显示出通知中心，你的 APP 就会进入不活跃的状态，就好像基于弹窗的中断发生了一样。你的 APP 仍然处在不活跃的状态，直到用户关闭通知中心或者启动另一个 APP。在这个时候，你的 APP 适当的移入活跃或后台庄爱。用户可以使用 Settings APP 配置哪个通知显示 banner 而哪个通知显示弹窗。

Pressing the Sleep/Wake button is another type of interruption that causes your app to be deactivated temporarily. When the user presses this button, the system disables touch events, moves the app to the background, sets the value of the app’s [applicationState](https://developer.apple.com/reference/uikit/uiapplication/1623003-applicationstate) property to [UIApplicationStateBackground](https://developer.apple.com/reference/uikit/uiapplicationstate/uiapplicationstatebackground), and locks the screen. A locked screen has additional consequences for apps that use data protection to encrypt files. Those consequences are described in [What to Do When Your App Is Interrupted Temporarily](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW10).

按下 Sleep/Wake 按钮时导致你的 APP 暂时失活的另一种中断。当用户按下这个按钮时，系统禁用触碰事件，把 APP 移入后台，把 APP 的 [applicationState](https://developer.apple.com/reference/uikit/uiapplication/1623003-applicationstate) 属性设置成 [UIApplicationStateBackground](https://developer.apple.com/reference/uikit/uiapplicationstate/uiapplicationstatebackground)，并锁住屏幕。被锁住的屏幕对使用数据保护加密文件的 APP 有副作用。那些结果的描述在 [What to Do When Your App Is Interrupted Temporarily](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW10) 中。

<span id="4.3">
## 4.3 What to Do When Your App Enters the Foreground - 当App进入前台时做什么

Returning to the foreground is your app’s chance to restart the tasks that it stopped when it moved to the background. The steps that occur when moving to the foreground are shown in Figure 4-4. The [applicationWillEnterForeground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623076-applicationwillenterforeground) method should undo anything that was done in your `applicationDidEnterBackground:` method, and the [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method should continue to perform the same activation tasks that it would at launch time.

回到前台，你的 APP 就有机会重新启动它移入后台时关闭的任务。移入前台时发生的步骤如图 4-4 所示。[applicationWillEnterForeground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623076-applicationwillenterforeground) 方法应该撤销你在 `applicationDidEnterBackground:` 方法中做的所有事情，而 [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) 方法应该继续执行与 APP 启动时相同的激活任务。

**Figure 4-4**  Transitioning from the background to the foreground - 从后台到前台的过渡

![Figure 4-4](images/app_enter_foreground_2x.png)

> **Note:** The [UIApplicationWillEnterForegroundNotification](https://developer.apple.com/reference/uikit/uiapplicationwillenterforegroundnotification) notification is also available for tracking when your app reenters the foreground. Objects in your app can use the default notification center to register for this notification.
> 
> **注意：** [UIApplicationWillEnterForegroundNotification](https://developer.apple.com/reference/uikit/uiapplicationwillenterforegroundnotification) 通知也是可用的，以跟踪你的 APP 何时重新进入前台。你的 APP 中的对象可以使用默认的通知中心注册这个通知。

<span id="4.3.1">
### 4.3.1 Be Prepared to Process Queued Notifications - 准备处理排好队的通知

An app in the suspended state must be ready to handle any queued notifications when it returns to a foreground or background execution state. A suspended app does not execute any code and therefore cannot process notifications related to orientation changes, time changes, preferences changes, and many others that would affect the app’s appearance or state. To make sure these changes are not lost, the system queues many relevant notifications and delivers them to the app as soon as it starts executing code again (either in the foreground or background). To prevent your app from becoming overloaded with notifications when it resumes, the system coalesces events and delivers a single notification (of each relevant type) that reflects the net change since your app was suspended.

在挂起状态的 APP 必须准备好在它回到前台或后台执行状态时处理所有排好队的通知。一个被挂起的 APP 不会执行任何代码，因此不能处理关于方向改变、时间改变、偏好设置改变以及许多其他可能影响 APP 的显示或状态的通知。要确保这些改变没有丢失，系统把许多相关的通知纳入队列，并当 APP 再次开始（在前台或后台）执行代码时把它们发给 APP。为了防止 APP 在回复时通知过载，系统合并事件，并发送一个（每个相关类型的）通知，反应从你的 APP 被挂起之后的净变化。

Table 4-1 lists the notifications that can be coalesced and delivered to your app. Most of these notifications are delivered directly to the registered observers. Some, like those related to device orientation changes, are typically intercepted by a system framework and delivered to your app in another way.

表 4-1 列出了可能被合并发送到你的 APP 的通知。其中大部分直接发送给了注册的观察者。某些，比如那些与设备方向变化相关，通常被系统框架拦截并以另一种方式发送给你的 APP。

**Table 4-1**  Notifications delivered to waking apps - 发送到唤醒的 APP 的通知

| **Event**                                | **Notifications**                        |
| ---------------------------------------- | ---------------------------------------- |
| An accessory is connected or disconnected. </br> 配件连接或断开连接。 | [EAAccessoryDidConnectNotification](https://developer.apple.com/reference/externalaccessory/eaaccessorydidconnectnotification) </br> [EAAccessoryDidDisconnectNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1613901-eaaccessorydiddisconnect) |
| The device orientation changes. </br> 设备方向改变。         | [UIDeviceOrientationDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1620025-uideviceorientationdidchange) </br> In addition to this notification, view controllers update their interface orientations automatically. </br> 除此通知之外，视图控制器会自动更新它们的界面方向。|
| There is a significant time change.  </br> 有重要的时间改变。    | [UIApplicationSignificantTimeChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1623059-uiapplicationsignificanttimechan) |
| The battery level or battery state changes. </br> 电池电量或电池状态改变。 | [UIDeviceBatteryLevelDidChangeNotification](https://developer.apple.com/reference/uikit/uidevicebatteryleveldidchangenotification) </br> [UIDeviceBatteryStateDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1620052-uidevicebatterystatedidchange) |
| The proximity state changes. </br> 接近状态改变。            | [UIDeviceProximityStateDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1620046-uideviceproximitystatedidchange) |
| The status of protected files changes. </br> 受保护文件的状态改变。  | [UIApplicationProtectedDataWillBecomeUnavailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623058-uiapplicationprotecteddatawillbe) </br> [UIApplicationProtectedDataDidBecomeAvailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623039-uiapplicationprotecteddatadidbec) |
| An external display is connected or disconnected. </br> 扩展显示器连接或断开连接。 | [UIScreenDidConnectNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1617826-uiscreendidconnect) </br> [UIScreenDidDisconnectNotification](https://developer.apple.com/reference/uikit/uiscreendiddisconnectnotification) |
| The screen mode of a display changes. </br> 显示器的屏幕模式改变。    | [UIScreenModeDidChangeNotification](https://developer.apple.com/reference/uikit/uiscreenmodedidchangenotification) |
| Preferences that your app exposes through the Settings app changed. </br> APP 的偏好设置通过 Settings 改变。 | [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification) |
| The current language or locale settings changed. </br> 当前语言或定位设置改变  | [NSCurrentLocaleDidChangeNotification](https://developer.apple.com/reference/foundation/nslocale/1418141-currentlocaledidchangenotificati) |
| The status of the user’s iCloud account changed. </br>  用户的 iCloud 账户状态改变。 | [NSUbiquityIdentityDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1407629-nsubiquityidentitydidchange) |

Queued notifications are delivered on your app’s main run loop and are typically delivered before any touch events or other user input. Most apps should be able to handle these events quickly enough that they would not cause any noticeable lag when resumed. However, if your app appears sluggish when it returns from the background state, use Instruments to determine whether your notification handler code is causing the delay.

排好队的通知会被发送到你的 APP 的 main run loop 上，并且通常在所有触碰事件或其他用户输入之前就被发送。大部分 APP 应该能足够快的处理这些事件，而不会导致恢复时有任何明显的滞后。但是，如果你的 APP 从后台状态返回时显得迟缓，请使用 Instruments 确定是否你的通知处理代码导致了延迟。

An app returning to the foreground also receives view-update notifications for any views that were marked dirty since the last update. An app running in the background can still call the [setNeedsDisplay](https://developer.apple.com/reference/uikit/uiview/1622437-setneedsdisplay) or [setNeedsDisplayInRect:](https://developer.apple.com/reference/uikit/uiview/1622587-setneedsdisplayinrect) methods to request an update for its views. However, because the views are not visible, the system coalesces the requests and updates the views only after the app returns to the foreground.

返回到前台的 APP 也会受到从上次更新之后被标记为脏视图的所有视图更新通知。运行在后台的 APP 仍然可以调用 [setNeedsDisplay](https://developer.apple.com/reference/uikit/uiview/1622437-setneedsdisplay) 或 [setNeedsDisplayInRect:](https://developer.apple.com/reference/uikit/uiview/1622587-setneedsdisplayinrect) 方法为这些视图请求更新。然而，由于这些视图不可见，系统会合并这些请求，并只在 APP 返回到前台之后才更新这些视图。

<span id="4.3.2">
### 4.3.2 Handle iCloud Changes - 处理iCloud变更

If the status of iCloud changes for any reason, the system delivers a [NSUbiquityIdentityDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1407629-nsubiquityidentitydidchange) notification to your app. The state of iCloud changes when the user logs into or out of an iCloud account or enables or disables the syncing of documents and data. This notification is your app’s cue to update caches and any iCloud-related user interface elements to accommodate the change. For example, when the user logs out of iCloud, you should remove references to all iCloud–based files or data.

如果 iCloud 状态由于任何原因改变，系统都会发送一个 [NSUbiquityIdentityDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1407629-nsubiquityidentitydidchange) 通知到你的 APP。iCloud 的状态会在用户登入或登出 iCloud 账户或者启用或禁用文档和数据同步时发生变化。这个通知给你的 APP 暗示去更新缓存和所有与 iCloud 相关的用户界面元素以适应变化。例如，当用户从 iCloud 登出，你应该移除对所有基于 iCloud 的文件或数据的引用。

If your app has already prompted the user about whether to store files in iCloud, do not prompt again when the status of iCloud changes. After prompting the user the first time, store the user’s choice in your app’s local preferences. You might then want to expose that preference using a Settings bundle or as an option in your app. But do not repeat the prompt again unless that preference is not currently in the user defaults database.

如果你的 APP 已经提示用户是否把在 iCloud 中存储文件，当 iCloud 状态变化时就不要再次提示。在第一次提示用户之后，在你 APP 的本地偏好中保存用户的选择。然后，你可能想要使用 Settings bundle 或者在你的 APP 中以选项的方式展示这个偏好。但是都不用再次重复提醒，除非该偏好当前不在用户默认数据库中了。

<span id="4.3.3">
### 4.3.3 Handle Locale Changes - 处理定位变更

If a user changes the current locale while your app is suspended, you can use the [NSCurrentLocaleDidChangeNotification](https://developer.apple.com/reference/foundation/nslocale/1418141-currentlocaledidchangenotificati) notification to force updates to any views containing locale-sensitive information, such as dates, times, and numbers when your app returns to the foreground. Of course, the best way to avoid locale-related issues is to write your code in ways that make it easy to update views. For example:

如果一个用户在你的 APP 被挂起时改变了当前位置，你可以使用 [NSCurrentLocaleDidChangeNotification](https://developer.apple.com/reference/foundation/nslocale/1418141-currentlocaledidchangenotificati) 通知在你的 APP 返回前台时强制更新所有包含定位敏感信息的视图，比如日期、时间和数字。当然，避免定位相关问题的最好方式是以易于更新视图的方式写代码。例如：

- Use the [autoupdatingCurrentLocale](https://developer.apple.com/reference/foundation/nslocale/1414388-autoupdatingcurrent) class method when retrieving `NSLocale` objects. This method returns a locale object that updates itself automatically in response to changes, so you never need to recreate it. However, when the locale changes, you still need to refresh views that contain content derived from the current locale.
- 在检索 `NSLocale` 对象时使用 [autoupdatingCurrentLocale](https://developer.apple.com/reference/foundation/nslocale/1414388-autoupdatingcurrent) 类方法。该方法返回一个可以自动自我更新以响应变化的定位对象，所以你就永远不用重新创建它了。但是，当定位变化时，你仍然需要刷新包含从当前定位得到的内容的视图。
- Re-create any cached date and number formatter objects whenever the current locale information changes.
- 只要当前定位信息变化，就重新创建所有缓存的日期和数字格式的对象。

For more information about internationalizing your code to handle locale changes, see [Internationalization and Localization Guide](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i).

关于国际化你的代码以处理定位变化的更多信息，参见 [Internationalization and Localization Guide](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i)。

<span id="4.3.4">
### 4.3.4 Handle Changes to Your App’s Settings - 处理 APP 设置的变更

If your app has settings that are managed by the Settings app, it should observe the [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification) notification. Because the user can modify settings while your app is suspended or in the background, you can use this notification to respond to any important changes in those settings. In some cases, responding to this notification can help close a potential security hole. For example, an email program should respond to changes in the user’s account information. Failure to monitor these changes could cause privacy or security issues. Specifically, the current user might be able to send email using the old account information, even if the account no longer belongs to that person.

如果你的 APP 有被 Settings 应用管理的设置，它应该观察  [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification) 通知。因为用户可以在你的 APP 被挂起或在后台时修改设置，你可以使用这个通知响应那些设置中的所有重要变化。在某些情况下，响应这个通知可以帮助关闭潜在的安全漏洞。例如，邮件程序应该响应用户账户信息的变化。未能监视这些变化可能导致隐私或安全问题。特别的，当前用户可能使用旧的账户信息发送邮件，甚至这个账户已经不再属于那个人。

Upon receiving the `NSUserDefaultsDidChangeNotification` notification, your app should reload any relevant settings and, if necessary, reset its user interface appropriately. In cases where passwords or other security-related information has changed, you should also hide any previously displayed information and force the user to enter the new password.

当收到 `NSUserDefaultsDidChangeNotification` 通知，你的 APP 应该重新加载所有相关的设置，并且，如果必要，适当的重置用户界面。在密码或其他安全相关的信息改变时，你也应该隐藏所有先前显示的信息，并强制用户输入新的密码。

<span id="4.4">
## 4.4 What to Do When Your App Enters the Background - 当App进入后台时做什么

When moving from foreground to background execution, use the [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) method of your app delegate to do the following:

当从前台进入后台执行时，使用你 APP 代理的 [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) 方法做以下操作：

- **Prepare to have your app’s picture taken.** When your `applicationDidEnterBackground:` method returns, the system takes a picture of your app’s user interface and uses the resulting image for transition animations. If any views in your interface contain sensitive information, you should hide or modify those views before the `applicationDidEnterBackground:` method returns. If you add new views to your view hierarchy as part of this process, you must force those views to draw themselves, as described in [Prepare for the App Snapshot](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW27).
- **准备让你的 APP 拍照。** 当你的 `applicationDidEnterBackground:` 方法返回时，系统会拍一张你的 APP 的用户界面的照片，并用拍出的图片作为过渡动画。如果你的界面上的任何视图包含敏感信息，你应该在 `applicationDidEnterBackground:` 方法返回之前隐藏或修改那些视图。如果你添加新的视图到你的视图层级中作为这个过程的一部分，你必须强制那些视图自我绘制，如 [Prepare for the App Snapshot](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW27) 中所述。
- **Save any relevant app state information.** Prior to entering the background, your app should already have saved all critical user data. Use the transition to the background to save any last minute changes to your app’s state.
- **保存所有相关的 APP 状态信息。** 在进入后台之前，你的 APP 应该已经保存了所有重要的用户数据。使用到后台的过渡来保存任何最后一分钟的变化到你的 APP 的状态中。
- **Free up memory as needed.** Release any cached data that you do not need and do any simple cleanup that might reduce your app’s memory footprint. Apps with large memory footprints are the first to be terminated by the system, so release image resources, data caches, and any other objects that you no longer need. For more information, see [Reduce Your Memory Footprint](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW28).
- **按需释放内存。** 释放你不需要的任何缓存数据并做所有简单的清理，这会减少你的 APP 的内存占用。占用大量内存空间的 APP 会首先被系统终止，所以释放图片资源、数据缓存以及其他任何你不再需要的对象。更多信息，参见 [Reduce Your Memory Footprint](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html#//apple_ref/doc/uid/TP40007072-CH8-SW28)。

Your app delegate’s `applicationDidEnterBackground:` method has approximately 5 seconds to finish any tasks and return. In practice, this method should return as quickly as possible. If the method does not return before time runs out, your app is killed and purged from memory. If you still need more time to perform tasks, call the `beginBackgroundTaskWithExpirationHandler:` method to request background execution time and then start any long-running tasks in a secondary thread. Regardless of whether you start any background tasks, the `applicationDidEnterBackground:` method must still exit within 5 seconds.

你的 APP 代理的 `applicationDidEnterBackground:` 方法有 5 秒左右的时间完成所有任务并返回。实际上，这个方法应该尽可能快的返回。如果方法没有在时间耗尽之前返回，你的 APP 会被杀死并从内存中清除。如果你仍需要更多的时间执行任务，调用 `beginBackgroundTaskWithExpirationHandler:` 方法请求后台执行时间，然后在附加线程开始任何长时间运行的任务。不管你是否开启了任何后台任务，`applicationDidEnterBackground:` 方法必须仍在 5 秒内退出。

> **Note:** The system sends the [UIApplicationDidEnterBackgroundNotification](https://developer.apple.com/reference/uikit/uiapplicationdidenterbackgroundnotification) notification in addition to calling the `applicationDidEnterBackground:` method. You can use that notification to distribute cleanup tasks to other objects of your app.
> 
> **注意：** 系统除了调用 `applicationDidEnterBackground:` 方法之外还会发送 [UIApplicationDidEnterBackgroundNotification](https://developer.apple.com/reference/uikit/uiapplicationdidenterbackgroundnotification) 通知。你可以使用该通知把清理任务分配给你的 APP 的其他对象。

Depending on the features of your app, there are other things your app should do when moving to the background. For example, any active Bonjour services should be suspended and the app should stop calling OpenGL ES functions. For a list of things your app should do when moving to the background, see [Being a Responsible Background App](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html#//apple_ref/doc/uid/TP40007072-CH4-SW8).

取决于你的 APP 的功能，当移入后台时也有一些其他应该做的事情。例如，任何活跃的 Bonjour 服务应该被挂起，以及 APP 应该停止调用 OpenGL ES 函数。关于 APP 在移入后台时应该做的事情的列表，参见 [Being a Responsible Background App](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html#//apple_ref/doc/uid/TP40007072-CH4-SW8)。

<span id="4.4.1">
### 4.4.1 The Background Transition Cycle - 后台过渡周期

When the user presses the Home button, presses the Sleep/Wake button, or the system launches another app, the foreground app transitions to the inactive state and then to the background state. These transitions result in calls to the app delegate’s [applicationWillResignActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) and [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) methods, as shown in Figure 4-5. After returning from the applicationDidEnterBackground: method, most apps move to the suspended state shortly afterward. Apps that request specific background tasks (such as playing music) or that request a little extra execution time from the system may continue to run for a while longer.

当用户按下 Home 按钮，按下 Sleep/Wake 按钮 或者系统启动其他 APP 时，前台 APP 就会过渡到非活跃状态，然后到后台状态。这些过渡导致调用 APP 代理的 [applicationWillResignActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) 和 [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) 方法，如图 4-5 所示。在从 `applicationDidEnterBackground:` 方法返回之后，大部分 APP 不久后就会进入挂起状态。请求特定后台任务（如播放音乐）或从系统请求一点额外执行时间的 APP 会继续运行更长的一段时间。

**Figure 4-5**  Moving from the foreground to the background - 从前台移入后台

![Figure 4-5](images/app_bg_life_cycle_2x.png)

<span id="4.4.2">
### 4.4.2 Prepare for the App Snapshot - 准备 APP 快照

Shortly after an app delegate’s [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) method returns, the system takes a snapshot of the app’s windows. Similarly, when an app is woken up to perform background tasks, the system may take a new snapshot to reflect any relevant changes. For example, when an app is woken to process downloaded items, the system takes a new snapshot so that can reflect any changes caused by the incorporation of the items. The system uses these snapshot images in the multitasking UI to show the state of your app.

在你的 APP 代理的 [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) 方法返回后，系统立即就会拍一张 APP 的窗口的快照。类似的，当 APP 被唤醒执行后台任务时，系统可能拍新的快照以反映任何相关的变化。例如，当 APP 被唤醒处理下载项目，系统拍新的快照反映由这些项目的合集导致的任何变化。系统使用这些快照图片在多任务 UI 中展示你的 APP 的状态。

If you make changes to your views upon entering the background, you can call the [snapshotViewAfterScreenUpdates:](https://developer.apple.com/reference/uikit/uiview/1622531-snapshotviewafterscreenupdates) method of your main view to force those changes to be rendered. Calling the `setNeedsDisplay` method on a view is ineffective for snapshots because the snapshot is taken before the next drawing cycle, thus preventing any changes from being rendered. Calling the `snapshotViewAfterScreenUpdates:` method with a value of a `YES` forces an immediate update to the underlying buffers that the snapshot machinery uses.

如果在进入后台时你对你的视图做了任何改变，你都可以调用你的主视图的 [snapshotViewAfterScreenUpdate:](https://developer.apple.com/reference/uikit/uiview/1622531-snapshotviewafterscreenupdates) 方法强制渲染那些改变。对一个视图调用 `setNeedsDisplay` 方法对快照是无效果的，因为快照在下一个绘制周期之前就拍摄了，从而避免了任何改变被渲染。调用 `snapshotViewAfterScreenUpdates:` 方法并传入 `YES` 值，会强制立即更新快照装置使用的底层缓冲区。

<span id="4.4.3">
### 4.4.3 Reduce Your Memory Footprint - 减少内存占用

Every app should free up as much memory as is practical upon entering the background. The system tries to keep as many apps in memory at the same time as it can, but when memory runs low it terminates suspended apps to reclaim that memory. Apps that consume large amounts of memory while in the background are the first apps to be terminated.

每个 APP 在进入后台时都应该释放尽可能多的内存。系统会在内存中同时保持尽可能多的 APP，但是当内存降低时它会终止挂起的 APP 以回收内存。而在后台中时消耗大量内存的 APP 是首先被终止的。

Practically speaking, your app should remove strong references to objects as soon as they are no longer needed. Removing strong references gives the compiler the ability to release the objects right away so that the corresponding memory can be reclaimed. However, if you want to cache some objects to improve performance, you can wait until the app transitions to the background before removing references to them.

实际上，你的 APP 应该立即移除对不再需要的对象的强引用。移除强引用让编译器可以立刻释放对象，以便相应的内存被回收。但是，如果你希望缓存某些对象以提升体验，你可以等到 APP 过渡到后台时才移除对它们的引用。

Some examples of objects that you should remove strong references to as soon as possible include:

一些你应该尽可能移除强引用的对象的例子包括：

- Image objects you created. (Some methods of `UIImage` return images whose underlying image data is purged automatically by the system. For more information, see the discussion in the overview of [UIImage Class Reference](https://developer.apple.com/reference/uikit/uiimage). )
- Large media or data files that you can load again from disk
- Any other objects that your app does not need and can recreate easily later

- 你创建的图片对象。（`UIImage` 的某些方法返回的图片的底层图像数据是由系统自动清除的，参见 [UIImage Class Reference](https://developer.apple.com/reference/uikit/uiimage) 的概述中的讨论。）
- 你可以从硬盘再次加载的大的多媒体或数据文件
- 你的 APP 不需要并且之后很容易重新创建的任何其他对象

To help reduce your app’s memory footprint, the system automatically purges some data allocated on behalf of your app when your app moves to the background.

为了帮助减少你的 APP 的内存占用，系统在你的 APP 移入后台时自动清除了一些为你的 APP 分配的数据。

- The system purges the backing store for all Core Animation layers. This effort does not remove your app’s layer objects from memory, nor does it change the current layer properties. It simply prevents the contents of those layers from appearing onscreen, which given that the app is in the background should not happen anyway.
- It removes any system references to cached images.
- It removes strong references to some other system-managed data caches.

- 系统为所有 Core Animation 层清除备份存储。该操作既不会从内存中移除你的 APP 的 layer，也没有改变当前 layer 属性。它只是简单的阻止那些 layer 的内容出现在屏幕上，这也是在后台的 APP 不应该发生的事情。
- 移除了缓存图像的所有系统引用。
- 移除了对某些其他系统管理的数据缓存的强引用。





