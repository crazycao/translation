
# Reduce and Prioritize Work 减少并安排工作的优先级

原文：
[https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/WorkLessInTheBackground.html#//apple_ref/doc/uid/TP40015243-CH22-SW1](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/WorkLessInTheBackground.html#//apple_ref/doc/uid/TP40015243-CH22-SW1)

# 1 Work Less in the Background 少在后台工作

When the user isn’t actively using your app, the system places it into a background state. The system may eventually suspend your app if it’s not performing important work, such as finishing a task the user initiated or running in a specially declared background execution mode.

当用户未积极使用您的应用时，系统会将其置于后台状态。如果您的应用程序没有执行重要的工作，例如完成用户启动的任务或在特殊声明的后台执行模式下运行，系统可能最终会暂停您的应用。

> **IMPORTANT** **重要**
>
> Your app shouldn’t wait to be suspended by the system. It should begin winding down activity immediately once notified that state has changed. When your app completes any remaining tasks, it should notify the system that background activity is complete. Failing to do so causes the app to remain active and draw energy unnecessarily.
> 
> 您的应用程序不应等待被系统暂停。一旦收到状态发生变化的通知，它应该立即开始结束活动。当您的应用程序完成任何剩余任务时，它应通知系统后台活动已完成。否则会导致应用程序保持活动状态，并消耗不必要的能量。

You can use [Energy organizer](https://help.apple.com/xcode/mac/current/#/dev36a5a9141) to view crash and energy reports that are generated from log information collected automatically from TestFlight users and with permission from users of the App Store versions of your apps. To learn more, see [Energy organizer](https://help.apple.com/xcode/mac/current/#/dev36a5a9141).

您可以使用 [Energy organizer](https://help.apple.com/xcode/mac/current/#/dev36a5a9141) 查看崩溃和能耗报告，这些报告由自动从 TestFlight 用户那里收集的日志信息生成，，并获得应用程序商店版本用户的许可。要了解更多信息，请参阅《[Energy organizer](https://help.apple.com/xcode/mac/current/#/dev36a5a9141)》。

## 1.1 Common Causes of Energy Wasted by Background Apps - 后台应用程序浪费能源的常见原因

Apps performing unnecessary background activity waste energy. The following are some common causes of wasted energy in background apps:

执行不必要的后台活动的应用程序浪费了能源。以下是后台应用程序中浪费能源的一些常见原因：

- Not notifying the system when background activity is complete
- Playing silent audio
- Performing location updates
- Interacting with Bluetooth accessories
- Downloads that could be deferred

>

- 后台活动完成时不通知系统
- 播放无声音频
- 执行位置更新
- 与蓝牙配件交互
- 可以推迟的下载

## 1.2 Suspend Activity When Your App Becomes Inactive or Moves to the Background - 在你的应用处于非活动状态或移动到后台时暂停活动

Implement [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) methods in your app delegate to receive calls and suspend activity when your app becomes inactive or transitions from the foreground to the background.

在应用程序委托中实现 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 方法，以在应用程序处于非活动状态或从前台转换到后台时接收调用并暂停活动。

### 1.2.1 applicationWillResignActive

The [applicationWillResignActive:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) method is called when your app enters an inactive state, such as when a phone call or text message comes in, or the user switches to another app and your app begins transitioning to a background state. This is a good place to pause activity, save data, and prepare for possible suspension. See Listing 3-1.

[applicationWillResignActive:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) 方法在您的应用程序进入非活动状态时被调用，例如当电话或短信进入，或者用户切换到另一个应用程序而您的应用开始转入后台状态时。这是暂停活动、保存数据和准备可能的暂停的好地方。请参见清单3-1。

**Listing 3-1** Responding when your app becomes inactive - 应用程序变成不活跃时的响应

```
optional func applicationWillResignActive(_ application: UIApplication) {
    // Halt operations, animations, and UI updates 
    // 停止操作、动画和UI更新
})
```

> **IMPORTANT** **重要**
>
> Your app shouldn’t rely on state transitions as an opportunity to save data. It should save data at appropriate points throughout the app’s lifecycle to protect against data loss.
>
> 你的应用程序不应该依赖状态转换来保存数据。它应该在整个应用程序生命周期的适当时间点保存数据，以防止数据丢失

### 1.2.2 applicationDidEnterBackground

The [applicationDidEnterBackground:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) method is called immediately after your app enters a background state. Stop any operations, animations, and UI updates immediately. See Listing 3-2.

[applicationDidEnterBackground:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) 方法在应用程序进入后台状态后立即调用。立即停止任何操作、动画和UI更新。请参见清单3-2。

**Listing 3-2** Responding when your app transitions to a background app - 应用程序转换到后台应用程序时的响应

```
optional func applicationDidEnterBackground(_ application: UIApplication) {
    // Halt operations, animations, and UI updates immediately
    // 立即停止操作、动画和UI更新
})
```

iOS allows only a few seconds for the `applicationDidEnterBackground` method to run. If your app needs more time to finish performing essential user initiated tasks, it should request more background execution time—the system allows up to a few more minutes of time on request. Call the [beginBackgroundTaskWithExpirationHandler:](https://developer.apple.com/documentation/uikit/uiapplication/1623031-beginbackgroundtaskwithexpiratio) method and pass it a handler, to be called if the extra time runs out. Next, run the remaining tasks on a dispatch queue or secondary thread.

iOS 只允许 `applicationDidEnterBackground` 方法运行几秒钟。如果您的应用程序需要更多时间来完成用户开启的基本任务，它应该请求更多的后台执行时间 —— 系统允许再请求最多几分钟的时间。调用 [beginBackgroundTaskWithExpirationHandler:](https://developer.apple.com/documentation/uikit/uiapplication/1623031-beginbackgroundtaskwithexpiratio) 方法，并向其传递一个处理程序，如果额外时间用完了该处理程序将被调用。接下来，会在调度队列或辅助线程上运行剩下的任务。

When background tasks are done, call the [endBackgroundTask:](https://developer.apple.com/documentation/uikit/uiapplication/1622970-endbackgroundtask) method to let the system know processing is complete. If you don’t call this method and background execution time exhausts, then the completion handler is called to give you one last shot at wrapping things up. After that, your app is suspended. See Listing 3-3.

后台任务完成后，调用 [endBackgroundTask:](https://developer.apple.com/documentation/uikit/uiapplication/1622970-endbackgroundtask) 方法让系统知道处理已完成。如果您不调用此方法，并且后台执行时间耗尽，则会调用完成处理程序，为您提供最后一次完成任务的机会。之后，您的应用程序将被挂起。请参见清单3-3。

> **IMPORTANT** **重要**
>
> Once your app finishes performing background tasks, don’t wait for the system to call the expiration handler. Call [endBackgroundTask:](https://developer.apple.com/documentation/uikit/uiapplication/1622970-endbackgroundtask) as soon as your app is done performing background tasks.
> 
> 应用程序完成后台任务后，不要等待系统调用过期处理程序。应用程序完成后台任务后立即调用 [endBackgroundTask:](https://developer.apple.com/documentation/uikit/uiapplication/1622970-endbackgroundtask)。

**Listing 3-3** Requesting additional background processing time - 请求额外的后台处理时间

```
// Request additional background execution time
// 请求额外的后台执行时间
var bgTaskID: UIBackgroundTaskIdentifier = 0
bgTaskID = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler() {
    // Completion handler to be performed if time runs out
    // 如果时间耗尽，完成处理程序将被执行
}
 
// Initiate background tasks
// 初始化后台任务
 
// Notify the system when the background tasks are done
// 当后台任务完成时通知系统
UIApplication.sharedApplication().endBackgroundTask(bgTaskID)
```

## 1.3 Resume Activity When Your App Becomes Active - 在应用程序处于活动状态时恢复活动

Implement [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) methods in your app delegate to receive calls and resume activity when your app becomes active again.

在应用程序委托中实现 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 方法，以便在应用程序再次激活时接收调用并恢复活动。

### 1.3.1 applicationWillEnterForeground

The [applicationWillEnterForeground:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623076-applicationwillenterforeground) method is called immediately before your app transitions from a background app to the active app. Start resuming operations, loading data, reinitializing the UI, and getting your app ready for the user. See Listing 3-4.

[applicationWillEnterForeground:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623076-applicationwillenterforeground) 方法在应用程序从后台 App 转为活跃 App 之前立即调用。开始恢复操作、加载数据、重新初始化UI，并为用户准备好应用程序。请参见清单3-4。

**Listing 3-4** Responding right before your app transitions to the foreground - 在应用程序转换到前台之前立即响应

```
optional func applicationWillEnterForeground(_ application: UIApplication) {
    // Prepare to resume operations, animations, and UI updates
    // 准备恢复操作、动画和 UI 更新
})
```

### 1.3.2 applicationDidBecomeActive

The [applicationDidBecomeActive:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method is called immediately after your app becomes the active app, after being launched by the system or transitioning from a background or inactive state. Fully resume any operations that were halted. See Listing 3-5.

当应用程序被系统启动或者从后台或非活跃状态转换，在变成活跃 App 后立即调用 [applicationDidBecomeActive:](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) 方法。完全恢复所有已停止的操作。参见清单3-5。

**Listing 3-5** Responding after your app transitioned to the foreground - 在应用程序转换为前台之后响应

```
optional func applicationDidBecomeActive(_ application: UIApplication) {
    // Resume operations, animations, and UI updates
    // 恢复操作、动画和 UI 更新
})
```

## 1.4 Resolving Runaway Background App Crashes - 解决失控的后台应用程序崩溃

iOS employs a CPU Monitor that watches background apps for excessive CPU usage and terminates them if they fall outside of certain limits. Most apps performing normal background activity should never encounter this situation. However, if your app reaches the limits and is terminated, the crash log indicates the reason for the termination. An exception type of `EXC_RESOURCE` and subtype of `CPU_FATAL` is specified, along with a message indicating that limits were exceeded. See Listing 3-6.

iOS 采用 CPU 监视器监视后台应用程序的 CPU 过度使用情况，如果超出某些限制，则终止这些应用程序。大多数执行正常后台活动的应用程序永远不会遇到这种情况。但是，如果您的应用程序达到限制并被终止，崩溃日志将指明终止的原因。崩溃日志中会指出 `EXC_RESOURCE` 异常类型和 `CPU_FATAL` 子类型，以及指示超出限制的消息。请参见清单3-6。

**Listing 3-6** Example of an Excess CPU Usage Crash Log Entry -  CPU使用过量崩溃日志条目的示例

```
Exception Type: EXC_RESOURCE
Exception Subtype: CPU_FATAL
Exception Message: (Limit 80%) Observed 89% over 60 seconds
```

The log also includes a stack trace, which lets you determine what your app was doing right before it was terminated. By analyzing the stack trace, you can identify the location of the runaway code and resolve it.

日志还包括堆栈跟踪，可以让您确定应用程序在终止前正在做什么。通过分析堆栈跟踪，您可以确定失控代码的位置并解决它。

> **NOTE** **注意**
>
> CPU Monitor is available in iOS 8 and later.
>
> CPU 监视器在 iOS 8 及更高版本中可用。

# 2 Prioritize Work with Quality of Service Classes - 优先顺序与服务质量类一起工作