App Programming Guide for iOS








<span id="4">
# 4 Strategies for Handling App State Transitions 控制App状态转换的策略

For each of the possible runtime states of an app, the system has different expectations while your app is in that state. When state transitions occur, the system notifies the app object, which in turn notifies its app delegate. You can use the state transition methods of the [UIApplicationDelegate](https://developer.apple.com/reference/uikit/uiapplicationdelegate) protocol to detect these state changes and respond appropriately. For example, when transitioning from the foreground to the background, you might write out any unsaved data and stop any ongoing tasks. The following sections offer tips and guidance for how to implement your state transition code.

<span id="4.1">
## 4.1 What to Do at Launch Time 启动时做什么

When your app is launched (either into the foreground or background), use your app delegate’s [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods to do the following:

- Check the contents of the launch options dictionary for information about why the app was launched, and respond appropriately.

- Initialize your app’s critical data structures.

- Prepare your app’s window and views for display:

- - Apps that use OpenGL ES for drawing must not use these methods to prepare their drawing environment. Instead, defer any OpenGL ES drawing calls to the [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method.
  - Show your app window from your application:willFinishLaunchingWithOptions: method. UIKit delays making the window visible until after the application:didFinishLaunchingWithOptions: method returns.

At launch time, the system automatically loads your app’s main storyboard file and loads the initial view controller. For apps that support state restoration, the state restoration machinery restores your interface to its previous state between calls to the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods. Use the application:willFinishLaunchingWithOptions: method to show your app window and to determine if state restoration should happen at all. Use the application:didFinishLaunchingWithOptions: method to make any final adjustments to your app’s user interface.

Your application:willFinishLaunchingWithOptions: and application:didFinishLaunchingWithOptions: methods should always be as lightweight as possible to reduce your app’s launch time. Apps are expected to launch, initialize themselves, and start handling events in less than 5 seconds. If an app does not finish its launch cycle in a timely manner, the system kills it for being unresponsive. Thus, any tasks that might slow down your launch (such as accessing the network) should be scheduled performed on a secondary thread.

<span id="4.1.1">
### 4.1.1 The Launch Cycle 启动环

When your app is launched, it moves from the not running state to the active or background state, transitioning briefly through the inactive state. As part of the launch cycle, the system creates a process and main thread for your app and calls your app’s main function on that main thread. The default main function that comes with your Xcode project promptly hands control over to the UIKit framework, which does most of the work in initializing your app and preparing it to run.

Figure 4-1 shows the sequence of events that occurs when an app is launched into the foreground, including the app delegate methods that are called.

**Figure 4-1**  Launching an app into the foreground

![Figure 4-1](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_launch_fg_2x.png)

When your app is launched into the background—usually to handle some type of background event—the launch cycle changes slightly to the one shown in Figure 4-2. The main difference is that instead of your app being made active, it enters the background state to handle the event and may be suspended at some point after that. When launching into the background, the system still loads your app’s user interface files but it does not display the app’s window.

**Figure 4-2**  Launching an app into the background

![Figure 4-2](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_launch_bg_2x.png)

To determine whether your app is launching into the foreground or background, check the [applicationState](https://developer.apple.com/reference/uikit/uiapplication/1623003-applicationstate) property of the shared UIApplication object in your application:willFinishLaunchingWithOptions: or application:didFinishLaunchingWithOptions: delegate method. When the app is launched into the foreground, this property contains the value [UIApplicationStateInactive](https://developer.apple.com/reference/uikit/uiapplicationstate/1623000-inactive). When the app is launched into the background, the property contains the value [UIApplicationStateBackground](https://developer.apple.com/reference/uikit/uiapplicationstate/uiapplicationstatebackground) instead. You can use this difference to adjust the launch-time behavior of your delegate methods accordingly.

> **Note:** When an app is launched so that it can open a URL, the sequence of startup events is slightly different from those shown in Figure 4-1 and Figure 4-2. For information about the startup sequences that occur when opening a URL, see [Handling URL Requests](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Inter-AppCommunication/Inter-AppCommunication.html#//apple_ref/doc/uid/TP40007072-CH6-SW13).

<span id="4.1.2">
### 4.1.2 Launching in Landscape Mode 横屏模式启动

Apps that uses only landscape orientations for their interface must explicitly ask the system to launch the app in that orientation. Normally, apps launch in portrait mode and rotate their interface to match the device orientation as needed. For apps that support both portrait and landscape orientations, always configure your views for portrait mode and then let your view controllers handle any rotations. If, however, your app supports landscape but not portrait orientations, perform the following tasks to make it launch in landscape mode initially:

- Add the UIInterfaceOrientation key to your app’s Info.plist file and set the value of this key to either [UIInterfaceOrientationLandscapeLeft](https://developer.apple.com/reference/uikit/uiinterfaceorientation/uiinterfaceorientationlandscapeleft) or [UIInterfaceOrientationLandscapeRight](https://developer.apple.com/reference/uikit/uiinterfaceorientation/uiinterfaceorientationlandscaperight).
- Lay out your views in landscape mode and make sure that their layout or autosizing options are set correctly.
- Override your view controller’s [shouldAutorotateToInterfaceOrientation:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621459-shouldautorotatetointerfaceorien) method and return a YES/a for the left or right landscape orientations and a NO/a for portrait orientations.

> **Important:** Apps should always use view controllers to manage their window-based content.

The UIInterfaceOrientation key in the Info.plist file tells iOS that it should configure the orientation of the app status bar (if one is displayed) as well as the orientation of views managed by any view controllers at launch time. View controllers respect this key and set their view’s initial orientation to match. Using this key is equivalent to calling the [setStatusBarOrientation:animated:](https://developer.apple.com/reference/uikit/uiapplication/1622939-setstatusbarorientation) method of UIApplication early in the execution of your applicationDidFinishLaunching: method.

<span id="4.1.3">
### 4.1.3 Installing App-Specific Data Files at First Launch 在首次启动时安装App特有的数据文件

You can use your app’s first launch cycle to set up any data or configuration files required to run. App-specific data files should be created in the Library/Application Support/<bundleID>/ directory of your app sandbox, where <bundleID> is your app’s bundle identifier. You can further subdivide this directory to organize your data files as needed. You can also create files in other directories, such as to your app’s iCloud container directory or to the local Documents directory, depending on your needs.

If your app’s bundle contains data files that you plan to modify, copy those files out of the app bundle and modify the copies. You must not modify any files inside your app bundle. Because iOS apps are code signed, modifying files inside your app bundle invalidates your app’s signature and will prevent your app from launching in the future. Copying those files to the Application Support directory (or another writable directory in your sandbox) and modifying them there is the only way to use such files safely.

For more information about where to put app-related data files, see [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672).

<span id="4.2">
## 4.2 What to Do When Your App Is Interrupted Temporarily 当App被暂时中断时做什么

Alert-based interruptions result in a temporary loss of control by your app. Your app continues to run in the foreground, but it does not receive touch events from the system. (It does continue to receive notifications and other types of events, such as accelerometer events, though.) In response to this change, your app should do the following in its [applicationWillResignActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) method:

- Save data and any relevant state information.
- Stop timers and other periodic tasks.
- Stop any running metadata queries.
- Do not initiate any new tasks.
- Pause movie playback (except when playing back over AirPlay).
- Enter into a pause state if your app is a game.
- Throttle back OpenGL ES frame rates.
- Suspend any dispatch queues or operation queues executing non-critical code. (You can continue processing network requests and other time-sensitive background tasks while inactive.)

When your app is moved back to the active state, its [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method should reverse any of the steps taken in the applicationWillResignActive: method. Thus, upon reactivation, your app should restart timers, resume dispatch queues, and throttle up OpenGL ES frame rates again. However, games should not resume automatically; they should remain paused until the user chooses to resume them.

When the user presses the Sleep/Wake button, apps with files protected by the [NSFileProtectionComplete](https://developer.apple.com/reference/foundation/fileprotectiontype/1616200-complete) protection option must close any references to those files. For devices configured with an appropriate password, pressing the Sleep/Wake button locks the screen and forces the system to throw away the decryption keys for files with complete protection enabled. While the screen is locked, any attempts to access the corresponding files will fail. So if you have such files, you should close any references to them in your applicationWillResignActive: method and open new references in your applicationDidBecomeActive: method.

> **Important:** Always save user data at appropriate checkpoints in your app. Although you can use app state transitions to force objects to write unsaved changes to disk, never wait for an app state transition to save data. For example, a view controller that manages user data should save its data when it is dismissed.

<span id="4.2.1">
### 4.2.1 Responding to Temporary Interruptions 响应暂时中断

When an alert-based interruption occurs, such as an incoming phone call, the app moves temporarily to the inactive state so that the system can prompt the user about how to proceed. The app remains in this state until the user dismisses the alert. At this point, the app either returns to the active state or moves to the background state. Figure 4-3 shows the flow of events through your app when an alert-based interruption occurs.

**Figure 4-3**  Handling alert-based interruptions

![Figure 4-3](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_interruptions_2x.png)

Notifications that display a banner do not deactivate your app in the way that alert-based notifications do. Instead, the banner is laid along the top edge of your app window and your app continues receive touch events as before. However, if the user pulls down the banner to reveal the notification center, your app moves to the inactive state just as if an alert-based interruption had occurred. Your app remains in the inactive state until the user dismisses the notification center or launches another app. At this point, your app moves to the appropriate active or background state. The user can use the Settings app to configure which notifications display a banner and which display an alert.

Pressing the Sleep/Wake button is another type of interruption that causes your app to be deactivated temporarily. When the user presses this button, the system disables touch events, moves the app to the background, sets the value of the app’s [applicationState](https://developer.apple.com/reference/uikit/uiapplication/1623003-applicationstate) property to [UIApplicationStateBackground](https://developer.apple.com/reference/uikit/uiapplicationstate/uiapplicationstatebackground), and locks the screen. A locked screen has additional consequences for apps that use data protection to encrypt files. Those consequences are described in What to Do When Your App Is Interrupted Temporarily.

<span id="4.3">
## 4.3 What to Do When Your App Enters the Foreground 当App进入前台时做什么

Returning to the foreground is your app’s chance to restart the tasks that it stopped when it moved to the background. The steps that occur when moving to the foreground are shown in Figure 4-4. The [applicationWillEnterForeground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623076-applicationwillenterforeground) method should undo anything that was done in your applicationDidEnterBackground: method, and the [applicationDidBecomeActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622956-applicationdidbecomeactive) method should continue to perform the same activation tasks that it would at launch time.

**Figure 4-4**  Transitioning from the background to the foreground

![Figure 4-4](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_enter_foreground_2x.png)

> **Note:** The [UIApplicationWillEnterForegroundNotification](https://developer.apple.com/reference/uikit/uiapplicationwillenterforegroundnotification) notification is also available for tracking when your app reenters the foreground. Objects in your app can use the default notification center to register for this notification.

<span id="4.3.1">
### 4.3.1 Be Prepared to Process Queued Notifications 准备处理排好队的通知

An app in the suspended state must be ready to handle any queued notifications when it returns to a foreground or background execution state. A suspended app does not execute any code and therefore cannot process notifications related to orientation changes, time changes, preferences changes, and many others that would affect the app’s appearance or state. To make sure these changes are not lost, the system queues many relevant notifications and delivers them to the app as soon as it starts executing code again (either in the foreground or background). To prevent your app from becoming overloaded with notifications when it resumes, the system coalesces events and delivers a single notification (of each relevant type) that reflects the net change since your app was suspended.

Table 4-1 lists the notifications that can be coalesced and delivered to your app. Most of these notifications are delivered directly to the registered observers. Some, like those related to device orientation changes, are typically intercepted by a system framework and delivered to your app in another way.

**Table 4-1**  Notifications delivered to waking apps

| **Event**                                | **Notifications**                        |
| ---------------------------------------- | ---------------------------------------- |
| An accessory is connected or disconnected. | [EAAccessoryDidConnectNotification](https://developer.apple.com/reference/externalaccessory/eaaccessorydidconnectnotification)[EAAccessoryDidDisconnectNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1613901-eaaccessorydiddisconnect) |
| The device orientation changes.          | [UIDeviceOrientationDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1620025-uideviceorientationdidchange)In addition to this notification, view controllers update their interface orientations automatically. |
| There is a significant time change.      | [UIApplicationSignificantTimeChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1623059-uiapplicationsignificanttimechan) |
| The battery level or battery state changes. | [UIDeviceBatteryLevelDidChangeNotification](https://developer.apple.com/reference/uikit/uidevicebatteryleveldidchangenotification)[UIDeviceBatteryStateDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1620052-uidevicebatterystatedidchange) |
| The proximity state changes.             | [UIDeviceProximityStateDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1620046-uideviceproximitystatedidchange) |
| The status of protected files changes.   | [UIApplicationProtectedDataWillBecomeUnavailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623058-uiapplicationprotecteddatawillbe)[UIApplicationProtectedDataDidBecomeAvailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623039-uiapplicationprotecteddatadidbec) |
| An external display is connected or disconnected. | [UIScreenDidConnectNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1617826-uiscreendidconnect)[UIScreenDidDisconnectNotification](https://developer.apple.com/reference/uikit/uiscreendiddisconnectnotification) |
| The screen mode of a display changes.    | [UIScreenModeDidChangeNotification](https://developer.apple.com/reference/uikit/uiscreenmodedidchangenotification) |
| Preferences that your app exposes through the Settings app changed. | [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification) |
| The current language or locale settings changed. | [NSCurrentLocaleDidChangeNotification](https://developer.apple.com/reference/foundation/nslocale/1418141-currentlocaledidchangenotificati) |
| The status of the user’s iCloud account changed. | [NSUbiquityIdentityDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1407629-nsubiquityidentitydidchange) |

Queued notifications are delivered on your app’s main run loop and are typically delivered before any touch events or other user input. Most apps should be able to handle these events quickly enough that they would not cause any noticeable lag when resumed. However, if your app appears sluggish when it returns from the background state, use Instruments to determine whether your notification handler code is causing the delay.

An app returning to the foreground also receives view-update notifications for any views that were marked dirty since the last update. An app running in the background can still call the [setNeedsDisplay](https://developer.apple.com/reference/uikit/uiview/1622437-setneedsdisplay) or [setNeedsDisplayInRect:](https://developer.apple.com/reference/uikit/uiview/1622587-setneedsdisplayinrect) methods to request an update for its views. However, because the views are not visible, the system coalesces the requests and updates the views only after the app returns to the foreground.

<span id="4.3.2">
### 4.3.2 Handle iCloud Changes 处理iCloud变更

If the status of iCloud changes for any reason, the system delivers a [NSUbiquityIdentityDidChangeNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1407629-nsubiquityidentitydidchange) notification to your app. The state of iCloud changes when the user logs into or out of an iCloud account or enables or disables the syncing of documents and data. This notification is your app’s cue to update caches and any iCloud-related user interface elements to accommodate the change. For example, when the user logs out of iCloud, you should remove references to all iCloud–based files or data.

If your app has already prompted the user about whether to store files in iCloud, do not prompt again when the status of iCloud changes. After prompting the user the first time, store the user’s choice in your app’s local preferences. You might then want to expose that preference using a Settings bundle or as an option in your app. But do not repeat the prompt again unless that preference is not currently in the user defaults database.

<span id="4.3.3">
### 4.3.3 Handle Locale Changes 处理定位变更

If a user changes the current locale while your app is suspended, you can use the [NSCurrentLocaleDidChangeNotification](https://developer.apple.com/reference/foundation/nslocale/1418141-currentlocaledidchangenotificati) notification to force updates to any views containing locale-sensitive information, such as dates, times, and numbers when your app returns to the foreground. Of course, the best way to avoid locale-related issues is to write your code in ways that make it easy to update views. For example:

- Use the [autoupdatingCurrentLocale](https://developer.apple.com/reference/foundation/nslocale/1414388-autoupdatingcurrent) class method when retrieving NSLocale objects. This method returns a locale object that updates itself automatically in response to changes, so you never need to recreate it. However, when the locale changes, you still need to refresh views that contain content derived from the current locale.
- Re-create any cached date and number formatter objects whenever the current locale information changes.

For more information about internationalizing your code to handle locale changes, see [Internationalization and Localization Guide](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i).

<span id="4.3.4">
### 4.3.4 Handle Changes to Your App’s Settings 处理App设置的变更

If your app has settings that are managed by the Settings app, it should observe the [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification) notification. Because the user can modify settings while your app is suspended or in the background, you can use this notification to respond to any important changes in those settings. In some cases, responding to this notification can help close a potential security hole. For example, an email program should respond to changes in the user’s account information. Failure to monitor these changes could cause privacy or security issues. Specifically, the current user might be able to send email using the old account information, even if the account no longer belongs to that person.

Upon receiving the NSUserDefaultsDidChangeNotification notification, your app should reload any relevant settings and, if necessary, reset its user interface appropriately. In cases where passwords or other security-related information has changed, you should also hide any previously displayed information and force the user to enter the new password.

<span id="4.4">
## 4.4 What to Do When Your App Enters the Background 当App进入后台时做什么

When moving from foreground to background execution, use the [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) method of your app delegate to do the following:

- **Prepare to have your app’s picture taken.** When your applicationDidEnterBackground: method returns, the system takes a picture of your app’s user interface and uses the resulting image for transition animations. If any views in your interface contain sensitive information, you should hide or modify those views before the applicationDidEnterBackground: method returns. If you add new views to your view hierarchy as part of this process, you must force those views to draw themselves, as described in Prepare for the App Snapshot.
- **Save any relevant app state information.** Prior to entering the background, your app should already have saved all critical user data. Use the transition to the background to save any last minute changes to your app’s state.
- **Free up memory as needed.** Release any cached data that you do not need and do any simple cleanup that might reduce your app’s memory footprint. Apps with large memory footprints are the first to be terminated by the system, so release image resources, data caches, and any other objects that you no longer need. For more information, see Reduce Your Memory Footprint.

Your app delegate’s applicationDidEnterBackground: method has approximately 5 seconds to finish any tasks and return. In practice, this method should return as quickly as possible. If the method does not return before time runs out, your app is killed and purged from memory. If you still need more time to perform tasks, call the beginBackgroundTaskWithExpirationHandler: method to request background execution time and then start any long-running tasks in a secondary thread. Regardless of whether you start any background tasks, the applicationDidEnterBackground: method must still exit within 5 seconds.

> **Note:** The system sends the [UIApplicationDidEnterBackgroundNotification](https://developer.apple.com/reference/uikit/uiapplicationdidenterbackgroundnotification) notification in addition to calling the applicationDidEnterBackground: method. You can use that notification to distribute cleanup tasks to other objects of your app.

Depending on the features of your app, there are other things your app should do when moving to the background. For example, any active Bonjour services should be suspended and the app should stop calling OpenGL ES functions. For a list of things your app should do when moving to the background, see [Being a Responsible Background App](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/BackgroundExecution/BackgroundExecution.html#//apple_ref/doc/uid/TP40007072-CH4-SW8).

<span id="4.4.1">
### 4.4.1 The Background Transition Cycle 后台转换循环

When the user presses the Home button, presses the Sleep/Wake button, or the system launches another app, the foreground app transitions to the inactive state and then to the background state. These transitions result in calls to the app delegate’s [applicationWillResignActive:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622950-applicationwillresignactive) and [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) methods, as shown in Figure 4-5. After returning from the applicationDidEnterBackground: method, most apps move to the suspended state shortly afterward. Apps that request specific background tasks (such as playing music) or that request a little extra execution time from the system may continue to run for a while longer.

**Figure 4-5**  Moving from the foreground to the background

![Figure 4-5](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_bg_life_cycle_2x.png)

<span id="4.4.2">
### 4.4.2 Prepare for the App Snapshot 准备App快照

Shortly after an app delegate’s [applicationDidEnterBackground:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622997-applicationdidenterbackground) method returns, the system takes a snapshot of the app’s windows. Similarly, when an app is woken up to perform background tasks, the system may take a new snapshot to reflect any relevant changes. For example, when an app is woken to process downloaded items, the system takes a new snapshot so that can reflect any changes caused by the incorporation of the items. The system uses these snapshot images in the multitasking UI to show the state of your app.

If you make changes to your views upon entering the background, you can call the [snapshotViewAfterScreenUpdates:](https://developer.apple.com/reference/uikit/uiview/1622531-snapshotviewafterscreenupdates) method of your main view to force those changes to be rendered. Calling the setNeedsDisplay method on a view is ineffective for snapshots because the snapshot is taken before the next drawing cycle, thus preventing any changes from being rendered. Calling the snapshotViewAfterScreenUpdates: method with a value of a YES/a forces an immediate update to the underlying buffers that the snapshot machinery uses.

<span id="4.4.3">
### 4.4.3 Reduce Your Memory Footprint 减少内存占用

Every app should free up as much memory as is practical upon entering the background. The system tries to keep as many apps in memory at the same time as it can, but when memory runs low it terminates suspended apps to reclaim that memory. Apps that consume large amounts of memory while in the background are the first apps to be terminated.

Practically speaking, your app should remove strong references to objects as soon as they are no longer needed. Removing strong references gives the compiler the ability to release the objects right away so that the corresponding memory can be reclaimed. However, if you want to cache some objects to improve performance, you can wait until the app transitions to the background before removing references to them.

Some examples of objects that you should remove strong references to as soon as possible include:

- Image objects you created. (Some methods of UIImage return images whose underlying image data is purged automatically by the system. For more information, see the discussion in the overview of [UIImage Class Reference](https://developer.apple.com/reference/uikit/uiimage). )
- Large media or data files that you can load again from disk
- Any other objects that your app does not need and can recreate easily later

To help reduce your app’s memory footprint, the system automatically purges some data allocated on behalf of your app when your app moves to the background.

- The system purges the backing store for all Core Animation layers. This effort does not remove your app’s layer objects from memory, nor does it change the current layer properties. It simply prevents the contents of those layers from appearing onscreen, which given that the app is in the background should not happen anyway.
- It removes any system references to cached images.
- It removes strong references to some other system-managed data caches.

<span id=5>
#5 Strategies for Implementing Specific App Features 实现特定App功能的策略

Different apps have different needs but some behaviors are common to many types of app. The following sections provide guidance about how to implement specific types of features in your app.

<span id=5.1>
##5.1 Privacy Strategies 隐私策略

Protecting a user’s privacy is an important consideration in the design of an app. Privacy protection includes protecting the user’s data, including the user’s identity and personal information. The system frameworks already provide privacy controls for managing data such as contacts but your app should take steps to protect the data that you use locally.

<span id=5.1.1>
### 5.1.1 Protecting Data Using On-Disk Encryption 使用磁盘加密保护数据

Data protection uses built-in hardware to store files in an encrypted format on disk and to decrypt them on demand. While the user’s device is locked, protected files are inaccessible, even to the app that created them. The user must unlock the device (by entering the appropriate passcode) before an app can access one of its protected files.

Data protection is available on most iOS devices and is subject to the following requirements:

- The file system on the user’s device must support data protection. Most devices support this behavior.
- The user must have an active passcode lock set for the device.

To protect a file, you add an attribute to the file indicating the desired level of protection. Add this attribute using either the NSData class or the NSFileManager class. When writing new files, you can use the [writeToFile:options:error:](https://developer.apple.com/reference/foundation/nsdata/1414800-write) method of NSData with the appropriate protection value as one of the write options. For existing files, you can use the [setAttributes:ofItemAtPath:error:](https://developer.apple.com/reference/foundation/filemanager/1413667-setattributes) method of NSFileManager to set or change the value of the [NSFileProtectionKey](https://developer.apple.com/reference/foundation/nsfileprotectionkey). When using these methods, specify one of the following protection levels for the file:

- No protection—The file is encrypted but is not protected by the passcode and is available when the device is locked. Specify the [NSDataWritingFileProtectionNone](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1616757-nofileprotection) option (NSData) or the [NSFileProtectionNone](https://developer.apple.com/reference/foundation/nsfileprotectionnone) attribute (NSFileManager).
- Complete—The file is encrypted and inaccessible while the device is locked. Specify the [NSDataWritingFileProtectionComplete](https://developer.apple.com/reference/foundation/nsdatawritingoptions/nsdatawritingfileprotectioncomplete) option (NSData) or the [NSFileProtectionComplete](https://developer.apple.com/reference/foundation/fileprotectiontype/1616200-complete) attribute (NSFileManager).
- Complete unless already open—The file is encrypted. A closed file is inaccessible while the device is locked. After the user unlocks the device, your app can open the file and use it. If the user locks the device while the file is open, though, your app can continue to access it. Specify the [NSDataWritingFileProtectionCompleteUnlessOpen](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1616278-completefileprotectionunlessopen) option (NSData) or the [NSFileProtectionCompleteUnlessOpen](https://developer.apple.com/reference/foundation/fileprotectiontype/1617188-completeunlessopen) attribute (NSFileManager).
- Complete until first login—The file is encrypted and inaccessible until after the device has booted and the user has unlocked it once. Specify the [NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1617028-completefileprotectionuntilfirst) option (NSData) or the [NSFileProtectionCompleteUntilFirstUserAuthentication](https://developer.apple.com/reference/foundation/fileprotectiontype/1616633-completeuntilfirstuserauthentica) attribute (NSFileManager).

If you protect a file, your app must be prepared to lose access to that file. When complete file protection is enabled, your app loses the ability to read and write the file’s contents when the user locks the device. You can track changes to the state of protected files using one of the following techniques:

- The app delegate can implement the [applicationProtectedDataWillBecomeUnavailable:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623019-applicationprotecteddatawillbeco) and [applicationProtectedDataDidBecomeAvailable:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623044-applicationprotecteddatadidbecom) methods.
- Any object can register for the [UIApplicationProtectedDataWillBecomeUnavailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623058-uiapplicationprotecteddatawillbe) and [UIApplicationProtectedDataDidBecomeAvailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623039-uiapplicationprotecteddatadidbec) notifications.
- Any object can check the value of the [protectedDataAvailable](https://developer.apple.com/reference/uikit/uiapplication/1622925-isprotecteddataavailable) property of the shared UIApplication object to determine whether files are currently accessible.

For new files, it is recommended that you enable data protection before writing any data to them. If you are using the writeToFile:options:error: method to write the contents of an [NSData](https://developer.apple.com/reference/foundation/nsdata) object to disk, this happens automatically. For existing files, adding data protection replaces an unprotected file with a new protected version.

<span id=5.1.2>
### 5.1.2 Identifying Unique Users of Your App 识别App的唯一用户

You should identify a user of your app only when doing so offers a clear benefit to that user. In cases where you only need to differentiate one user of your app from another, iOS provides identifiers that can help you do that. However, if you need a higher level of security, you might need to do more work on your own. For example, an app that provides financial services would likely want to prompt the user for login credentials to ensure that the user is authorized to access a specific account.

> **Important:** When identifying a user, always be transparent about what you intend to do with any information you obtain. It is not acceptable to identify a user so that you can track them surreptitiously.

Here are some common scenarios that might require you to identify a user, along with solutions for how to implement them.

- **You want to link a user to a specific account on your server.** Include a login screen that requires the user to enter their account information securely. Always protect the account information you gather from the user by storing it in an encrypted form.
- **You want to differentiate instances of your app running on different devices.** Use the [identifierForVendor](https://developer.apple.com/reference/uikit/uidevice/1620059-identifierforvendor) property of the UIDevice class to obtain an ID that differentiates a user on one device from users on other devices. This technique does now allow you to identify specific users. A single user can have multiple devices, each with a different ID value.
- **You want to identify a user for the purposes of advertising.** Use the [advertisingIdentifier](https://developer.apple.com/reference/adsupport/asidentifiermanager/1614151-advertisingidentifier) property of the ASIdentifierManager class to obtain an ID for the user.

Because users are allowed to run apps on all of their iOS devices, Apple does not provide a way to identify the same user on multiple devices. If you need to identify a specific user, you must provide your own solution using universally unique IDs (UUIDs), a login account, or some other type of identification system.

<span id=5.2>
## 5.2 Respecting Restrictions 尊重限制

Users can set restrictions that specify the ratings of media they want to consume in apps. If your app plays media or modifies its behavior based on restrictions, you need to determine the current settings and respond when the settings change.

To get the current settings, get the shared [standardUserDefaults](https://developer.apple.com/reference/foundation/userdefaults/1416603-standard) object and use the [objectForKey:](https://developer.apple.com/reference/foundation/nsuserdefaults/1410095-objectforkey) method to view the values for the following keys:

| **Media rating key**                     | **Value**                                | com.apple.content-rating.ExplicitBooksAllowed | Boolean. If the value of this key is a NO/a, explicit books are not allowed |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |
| com.apple.content-rating.ExplicitMusicPodcastsAllowed | Boolean. If the value of this key is a NO/a, explicit music, movies, and podcasts are not allowed. |                                          |                                          |
| com.apple.content-rating.AppRating       | NSNumber. The value of this key ranges from 0 to 1000. An app whose rating is higher than the current key value is not allowed. |                                          |                                          |
| com.apple.content-rating.MovieRating     | NSNumber. The value of this key ranges from 0 to 1000. A movie whose rating is higher than the current key value is not allowed. |                                          |                                          |
| com.apple.content-rating.TVShowRating    | NSNumber. The value of this key ranges from 0 to 1000. A TV show whose rating is higher than the current key value is not allowed. |                                          |                                          |

> **Note:** If objectForKey: returns nil for a specific key, it means that information about this particular restriction is not available. In this case, your app can use its own policies to determine appropriate ratings.

To detect when the user makes a change to a restriction, register for the notification [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification). The shared standardUserDefaults object sends this notification to your app when it detects a change to a preference located in one of the persistent domains.

App ratings are defined for the us country code and are universally applied. Table 5-1 shows the value associated with each US app rating.

**Table 5-1**  App ratings

| **Rating name** | **Numerical value** |
| --------------- | ------------------- |
| 4+              | 100                 |
| 9+              | 200                 |
| 12+             | 300                 |
| 17+             | 600                 |

Movie and TV ratings vary by country. If a country or region doesn’t specify a rating system for movies or TV shows, your app should use its own policies to determine appropriate ratings. Although most regions define movie ratings, only a few define TV show ratings.

A region can define several rating levels, each of which is associated with a name that describes the rating and a number in the range of 0 to 1000. For example, the US uses the string “G” and the number 100 to specify the lowest movie rating level.

Even if your app doesn’t play media, you might want to map your own rating system to a movie or TV show rating system. For example, a game might enable certain features only when the US movie rating “R” is allowed. To view the current list of ratings, download this document’s companion file (the link is near the top of the page).

<span id=5.3>
## 5.3 Supporting Multiple Versions of iOS 支持iOS的多个版本

An app that supports the latest version of iOS plus one or more earlier versions must use runtime checks to prevent the use of newer APIs on older versions of iOS. Runtime checks prevent your app from crashing when it tries to use a feature that is not available on the current operating system.

There are several types of checks that you can make:

- To determine whether a class exists, see if its Class object is nil. The linker returns nil for any unknown class objects, making it possible to use a conditional check similar to the following:

>
	if ([UIPrintInteractionController class]) {
	   // Create an instance of the class and use it.
	}
	else {
	   // The print interaction controller is not available so use an alternative technique.
	}	
	
- To determine whether a method is available on an existing class, use the [instancesRespondToSelector:](https://developer.apple.com/reference/objectivec/nsobject/1418555-instancesrespondtoselector) class method or the [respondsToSelector:](https://developer.apple.com/reference/objectivec/nsobjectprotocol/1418583-responds) instance method.

- To determine whether a C-based function is available, perform a Boolean comparison of the function name to NULL. If the symbol is not NULL, you can call the function. For example:

>
	if (UIGraphicsBeginPDFPage != NULL) {
   		UIGraphicsBeginPDFPage();
	}

For more information and examples of how to write code that supports multiple deployment targets, see [SDK Compatibility Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Introduction/Introduction.html#//apple_ref/doc/uid/10000163i).

<span id=5.4>
##5.4 Preserving Your App’s Visual Appearance Across Launches 保持贯穿启动过程App视觉可见

Even if your app supports background execution, it cannot run forever. At some point, the system might need to terminate your app to free up memory for the current foreground app. However, the user should never have to care if an app is already running or was terminated. From the user’s perspective, quitting an app should just seem like a temporary interruption. When the user returns to an app, that app should always return the user to the last point of use, so that the user can continue with whatever task was in progress. This behavior provides a better experience for the user and with the state restoration support built in to UIKit is relatively easy to achieve.

The state preservation system in UIKit provides a simple but flexible infrastructure for preserving and restoring the state of your app’s view controllers and views. The job of the infrastructure is to drive the preservation and restoration processes at the appropriate times. To do that, UIKit needs help from your app. Only you understand the content of your app, and so only you can write the code needed to save and restore that content. And when you update your app’s UI, only you know how to map older preserved content to the newer objects in your interface.

There are three places where you have to think about state preservation in your app:

- Your app delegate object, which manages the app’s top-level state
- Your app’s view controller objects, which manage the overall state for your app’s user interface
- Your app’s custom views, which might have some custom data that needs to be preserved

UIKit allows you to choose which parts of your user interface you want to preserve. And if you already have custom code for handling state preservation, you can continue to use that code and migrate portions to the UIKit state preservation system as needed.

<span id=5.4.1>
###5.4.1 Enabling State Preservation and Restoration in Your App 在App中开启状态保持和恢复

State preservation and restoration is not an automatic feature and apps must opt-in to use it. Apps indicate their support for the feature by implementing the following methods in their app delegate:

- [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application)
- [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application)

Normally, your implementations of these methods just return a YES/a to indicate that state preservation and restoration can occur. However, apps that want to preserve and restore their state conditionally can return a NO/a in situations where the operations should not occur. For example, after releasing an update to your app, you might want to return a NO/a from your [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method if your app is unable to usefully restore the state from a previous version.

<span id=5.4.2>
###5.4.2 The Preservation and Restoration Process 保持和恢复过程

State preservation and restoration is an opt-in feature and works with the help of your app. Your app identifies objects that should be preserved and UIKit does the work of preserving and restoring those objects at appropriate times. Because UIKit handles so much of the process, it helps to understand what it does behind the scenes so that you know how your custom code fits into the overall scheme.

When thinking about state preservation and restoration, it helps to separate the two processes first. UIKit preserves your app’s state at appropriate times, such as when your app moves from the foreground to the background. When UIKit determines new state information is needed, it looks at your app’s views and view controllers to see which ones should be preserved. For each of those objects, UIKit writes preservation-related data to an encrypted on-disk file. The next time your app launches from scratch, UIKit looks for that file and, if it is present, uses it to try and restore your app’s state. Because the file is encrypted, state preservation and restoration only happens when the device is unlocked.

During the restoration process, UIKit uses the preserved data to reconstitute your interface but the creation of actual objects is handled by your code. Because your app might load objects from a storyboard file automatically, only your code knows which objects need to be created and which might already exist and can simply be returned. After creating each object, UIKit initializes them with the preserved state information.

During the preservation and restoration process, your app has a handful of responsibilities.

- During preservation, your app is responsible for:

  - Telling UIKit that it supports state preservation.
  - Telling UIKit which view controllers and views should be preserved.
  - Encoding relevant data for any preserved objects.

- During restoration, your app is responsible for:

  - Telling UIKit that it supports state restoration.
  - Providing (or creating) the objects that are requested by UIKit.
  - Decoding the state of your preserved objects and using it to return the object to its previous state.

Of your app’s responsibilities, the most significant are telling UIKit which objects to preserve and providing those objects during subsequent launches. Those two behaviors are where you should spend most of your time when designing your app’s preservation and restoration code. They are also where you have the most control over the actual process. To understand why that is the case, it helps to look at an example.

Figure 5-1 shows the view controller hierarchy of a tab bar interface after the user has interacted with several of the tabs. As you can see, some of the view controllers are loaded automatically as part of the app’s main storyboard file but some of the view controllers were presented or pushed onto the view controllers in different tabs. Without state restoration, only the view controllers from the main storyboard file would be restored during subsequent launches. By adding support for state restoration to your app, you can preserve all of the view controllers.

**Figure 5-1**  A sample view controller hierarchy
![Figure 5-1](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_hierarchy_initial_2x.png)

UIKit preserves only those objects that have an assigned restoration identifier. A restoration identifier is a string that identifies the view or view controller to UIKit and your app. The value of this string is significant only to your code but the presence of this string tells UIKit that it needs to preserve the tagged object. During the preservation process, UIKit walks your app’s view controller hierarchy and preserves all objects that have a restoration identifier. If a view controller does not have a restoration identifier, that view controller and all of its views and child view controllers are not preserved. Figure 5-2 shows an updated version of the previous view hierarchy, now with restoration identifies applied to most (but not all) of the view controllers.

**Figure 5-2**  Adding restoration identifies to view controllers
![Figure 5-2](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_hierarchy_preserve_2x.png)

Depending on your app, it might or might not make sense to preserve every view controller. If a view controller presents transitory information, you might not want to return to that same point on restore, opting instead to return the user to a more stable point in your interface.

For each view controller you choose to preserve, you also need to decide how you want to restore it later. UIKit offers two ways to recreate objects. You can let your app delegate recreate it or you can assign a restoration class to the view controller and let that class recreate it. A restoration class implements the [UIViewControllerRestoration](https://developer.apple.com/reference/uikit/uiviewcontrollerrestoration) protocol and is responsible for finding or creating a designated object at restore time. Here are some tips for when to use each one:

- **If the view controller is always loaded from your app’s main storyboard file at launch time, do not assign a restoration class.** Instead, let your app delegate find the object or take advantage of UIKit’s support for implicitly finding restored objects.
- **For view controllers that are not loaded from your main storyboard file at launch time, assign a restoration class.** The simplest option is to make each view controller its own restoration class.

During the preservation process, UIKit identifies the objects to save and writes each affected object’s state to disk. Each view controller object is given a chance to write out any data it wants to save. For example, a tab view controller saves the identity of the selected tab. UIKit also saves information such as the view controller’s restoration class to disk. And if any of the view controller’s views has a restoration identifier, UIKit asks them to save their state information too.

The next time the app is launched, UIKit loads the app’s main storyboard or nib file as usual, calls the app delegate’s [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) method, and then tries to restore the app’s previous state. The first thing it does is ask your app to provide the set of view controller objects that match the ones that were preserved. If a given view controller had an assigned restoration class, that class is asked to provide the object; otherwise, the app delegate is asked to provide it.

<span id=5.4.3>
###5.4.3 Flow of the Preservation Process 保持过程流

Figure 5-3 shows the high-level events that happen during state preservation and shows how the objects of your app are affected. Before preservation even occurs, UIKit asks your app delegate if it should occur by calling the [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application) method. If that method returns a YES/a, UIKit begins gathering and encoding your app’s views and view controllers. When it is finished, it writes the encoded data to disk.

**Figure 5-3**  High-level flow interface preservation
![Figure 5-3](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/save_process_simple_2x.png)

The next time your app launches, the system automatically looks for a preserved state file, and if present, uses it to restore your interface. Because this state information is only relevant between the previous and current launch cycles of your app, the file is typically discarded after your app finishes launching. The file is also discarded any time there is an error restoring your app. For example, if your app crashes during the restoration process, the system automatically throws away the state information during the next launch cycle to avoid another crash.

<span id=5.4.4>
###5.4.4 Flow of the Restoration Process 恢复过程流

Figure 5-4 shows the high-level events that happen during state restoration and shows how the objects of your app are affected. After the standard initialization and UI loading is complete, UIKit asks your app delegate if state restoration should occur at all by calling the [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method. This is your app delegate’s opportunity to examine the preserved data and determine if state restoration is possible. If it is, UIKit uses the app delegate and restoration classes to obtain references to your app’s view controllers. Each object is then provided with the data it needs to restore itself to its previous state.

**Figure 5-4**  High-level flow for restoring your user interface
![Figure 5-4](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/restoration_process_simple_2x.png)

Although UIKit helps restore the individual view controllers, it does not automatically restore the relationships between those view controllers. Instead, each view controller is responsible for encoding enough state information to return itself to its previous state. For example, a navigation controller encodes information about the order of the view controllers on its navigation stack. It then uses this information later to return those view controllers to their previous positions on the stack. Other view controllers that have embedded child view controllers are similarly responsible for encoding any information they need to restore their children later.

>**Note:** Not all view controllers need to encode their child view controllers. For example, tab bar controllers do not encode information about their child view controllers. Instead, it is assumed that your app follows the usual pattern of creating the appropriate child view controllers prior to creating the tab bar controller itself.

Because you are responsible for recreating your app’s view controllers, you have some flexibility to change your interface during the restoration process. For example, you could reorder the tabs in a tab bar controller and still use the preserved data to return each tab to its previous state. Of course, if you make dramatic changes to your view controller hierarchy, such as during an app update, you might not be able to use the preserved data.

<span id=5.4.5>
###5.4.5 What Happens When You Exclude Groups of View Controllers? 当你移除整组的视图控制器时会发生什么？

When the restoration identifier of a view controller is nil, that view controller and any child view controllers it manages are not preserved automatically. For example, in Figure 5-5, because a navigation controller did not have a restoration identifier, it and all of its child view controllers and views are omitted from the preserved data.

**Figure 5-5**  Excluding view controllers from the automatic preservation process
![Figure 5-5](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_caveats_2x.png)

Even if you decide not to preserve view controllers, that does not mean all of those view controllers disappear from the view hierarchy altogether. At launch time, your app might still create the view controllers as part of its default setup. For example, if any view controllers are loaded automatically from your app’s storyboard file, they would still appear, albeit in their default configuration, as shown in Figure 5-6.

**Figure 5-6**  Loading the default set of view controllers
![Figure 5-6](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_caveats_2_2x.png)

Something else to realize is that even if a view controller is not preserved automatically, you can still encode a reference to that view controller and preserve it manually. In Figure 5-5, the three child view controllers of the first navigation controller have restoration identifiers, even though there parent navigation controller does not. If your app delegate (or any preserved object) encodes a reference to those view controllers, their state is preserved. Even though their order in the navigation controller is not saved, you could still use those references to recreate the view controllers and install them in the navigation controller during subsequent launch cycles.

<span id=5.4.6>
###5.4.6 Checklist for Implementing State Preservation and Restoration 实现状态保持和恢复的核对清单

Supporting state preservation and restoration requires modifying your app delegate and view controller objects to encode and decode the state information. If your app has any custom views that also have preservable state information, you need to modify those objects too.

When adding state preservation and restoration to your code, use the following list to remind you of the code you need to write.

- (Required) Implement the [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application) and [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) methods in your app delegate; see Enabling State Preservation and Restoration in Your App.
- (Required) Assign restoration identifiers to each view controller you want to preserve by assigning a non empty string to their [restorationIdentifier](https://developer.apple.com/reference/uikit/uiviewcontroller/1621499-restorationidentifier) property; see Marking Your View Controllers for Preservation. If you want to save the state of specific views too, assign non empty strings to their [restorationIdentifier](https://developer.apple.com/reference/uikit/uiview/1622494-restorationidentifier) properties; see Preserving the State of Your Views.
- (Required) Show your app’s window from the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) method of your app delegate. The state restoration machinery needs the window so that it can restore scroll positions and other relevant bits of your app’s interface.
- Assign restoration classes to the appropriate view controllers. (If you do not do this, your app delegate is asked to provide the corresponding view controller at restore time.) See Restoring Your View Controllers at Launch Time.
- (Recommended) Encode and decode the state of your views and view controllers using the [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621461-encoderestorablestatewithcoder) and [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621429-decoderestorablestate) methods of those objects; see Encoding and Decoding Your View Controller’s State.
- Encode and decode any version information or additional state information for your app using the [application:willEncodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623099-application) and [application:didDecodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623006-application) methods of your app delegate; see Preserving Your App’s High-Level State.
- Objects that act as data sources for table views and collection views should implement the [UIDataSourceModelAssociation](https://developer.apple.com/reference/uikit/uidatasourcemodelassociation) protocol. Although not required, this protocol helps preserve the selected and visible items in those types of views. See Implementing Preservation-Friendly Data Sources.

<span id=5.4.7>
###5.4.7 Enabling State Preservation and Restoration in Your App 在App中启用状态保持和恢复

State preservation and restoration is not an automatic feature and apps must opt-in to use it. Apps indicate their support for the feature by implementing the following methods in their app delegate:

- [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application)
- [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application)

Normally, your implementations of these methods just return a YES/a to indicate that state preservation and restoration can occur. However, apps that want to preserve and restore their state conditionally can return a NO/a in situations where the operations should not occur. For example, after releasing an update to your app, you might want to return a NO/a from your [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method if your app is unable to usefully restore the state from a previous version.

<span id=5.4.8>
###5.4.8 Preserving the State of Your View Controllers 保持视图控制器的状态

Preserving the state of your app’s view controllers should be your main goal. View controllers define the structure of your user interface. They manage the views needed to present that interface and they coordinate the getting and setting of the data that backs those views. To preserve the state of a single view controller, you must do the following:

- (Required) Assign a restoration identifier to the view controller; see Marking Your View Controllers for Preservation.
- (Required) Provide code to create or locate new view controller objects at launch time; see Restoring Your View Controllers at Launch Time.
- (Optional) Implement the [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621461-encoderestorablestatewithcoder) and [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621429-decoderestorablestate) methods to encode and restore any state information that cannot be recreated during a subsequent launch; see Encoding and Decoding Your View Controller’s State.

<span id=5.4.8.1>
####5.4.8.1 Marking Your View Controllers for Preservation 为保持标记视图控制器

UIKit preserves only those view controllers whose [restorationIdentifier](https://developer.apple.com/reference/uikit/uiviewcontroller/1621499-restorationidentifier) property contains a valid string object. For view controllers that you know you want to preserve, set the value of this property when you initialize the view controller object. If you load the view controller from a storyboard or nib file, you can set the restoration identifier there.

Choosing an appropriate value for restoration identifiers is important. During the restoration process, your code uses the restoration identifier to determine which view controller to retrieve or create. If every view controller object is based on a different class, you can use the class name for the restoration identifier. However, if your view controller hierarchy contains multiple instances of the same class, you might need to choose different names based on each view usage.

When it asks you to provide a view controller, UIKit provides you with the restoration path of the view controller object. A restoration path is the sequence of restoration identifiers starting at the root view controller and walking down the view controller hierarchy to the current object. For example, imagine you have a tab bar controller whose restoration identifier is TabBarControllerID, and the first tab contains a navigation controller whose identifier is NavControllerID and whose root view controller’s identifier is MyViewController. The full restoration path for the root view controller would be TabBarControllerID/NavControllerID/MyViewController.

The restoration path for every object must be unique. If a view controller has two child view controllers, each child must have a different restoration identifier. However, two view controllers with different parent objects may use the same restoration identifier because the rest of the restoration path provides the needed uniqueness. Some UIKit view controllers, such as navigation controllers, automatically disambiguate their child view controllers, allowing you to use the same restoration identifiers for each child. For more information about the behavior of a given view controller, see the corresponding class reference.

At restore time, you use the provided restoration path to determine which view controller to return to UIKit. For more information on how you use restoration identifiers and restoration paths to restore view controllers, see Restoring Your View Controllers at Launch Time.

<span id=5.4.8.2>
####5.4.8.2 Restoring Your View Controllers at Launch Time 在启动时恢复你的视图控制器

During the restoration process, UIKit asks your app to create (or locate) the view controller objects that comprise your preserved user interface. UIKit adheres to the following process when trying to locate view controllers:

1. **If the view controller had a restoration class, UIKit asks that class to provide the view controller.** UIKit calls the [viewControllerWithRestorationIdentifierPath:coder:](https://developer.apple.com/reference/uikit/uiviewcontrollerrestoration/1616859-viewcontrollerwithrestorationide) method of the associated restoration class to retrieve the view controller. If that method returns nil, it is assumed that the app does not want to recreate the view controller and UIKit stops looking for it.
2. **If the view controller did not have a restoration class, UIKit asks the app delegate to provide the view controller.** UIKit calls the [application:viewControllerWithRestorationIdentifierPath:coder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623062-application) method of your app delegate to look for view controllers without a restoration class. If that method returns nil, UIKit tries to find the view controller implicitly.
3. **If a view controller with the correct restoration path already exists, UIKit uses that object.** If your app creates view controllers at launch time (either programmatically or by loading them from a resource file) and assigns restoration identifiers to them, UIKit finds them implicitly through their restoration paths.
4. **If the view controller was originally loaded from a storyboard file, UIKit uses the saved storyboard information to locate and create it.** UIKit saves information about a view controller’s storyboard inside the restoration archive. At restore time, it uses that information to locate the same storyboard file and instantiate the corresponding view controller if the view controller was not found by any other means.

It is worth noting that if you specify a restoration class for a view controller, UIKit does not try to find your view controller implicitly. If the viewControllerWithRestorationIdentifierPath:coder: method of your restoration class returns nil, UIKit stops trying to locate your view controller. This gives you control over whether you really want to create the view controller. If you do not specify a restoration class, UIKit does everything it can to find the view controller for you, creating it as necessary from your app’s storyboard files.

If you choose to use a restoration class, the implementation of your viewControllerWithRestorationIdentifierPath:coder: method should create a new instance of the class, perform some minimal initialization, and return the resulting object. Listing 5-1 shows an example of how you might use this method to load a view controller from a storyboard. Because the view controller was originally loaded from a storyboard, this method uses the [UIStateRestorationViewControllerStoryboardKey](https://developer.apple.com/reference/uikit/uistaterestorationviewcontrollerstoryboardkey) key to get the storyboard from the archive. Note that this method does not try to configure the view controller’s data fields. That step occurs later when the view controller’s state is decoded.

**Listing 5-1**  Creating a new view controller during restoration

	+ (UIViewController*) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
	                      coder:(NSCoder *)coder {
	   MyViewController* vc;
	   UIStoryboard* sb = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
	   if (sb) {
	      vc = (PushViewController*)[sb instantiateViewControllerWithIdentifier:@"MyViewController"];
	      vc.restorationIdentifier = [identifierComponents lastObject];
	      vc.restorationClass = [MyViewController class];
	   }
	    return vc;
	}

Reassigning the restoration identifier and restoration class, as in the preceding example, is a good habit to adopt when creating new view controllers. The simplest way to restore the restoration identifier is to grab the last item in the identifierComponents array and assign it to your view controller.

For objects that were already loaded from your app’s main storyboard file at launch time, do not create a new instance of each object. Instead, implement the application:viewControllerWithRestorationIdentifierPath:coder: method of your app delegate and use it to return the appropriate objects or let UIKit find those objects implicitly.

<span id=5.4.8.3>
####5.4.8.3 Encoding and Decoding Your View Controller’s State 编码和解码你的视图控制器状态

For each object slated for preservation, UIKit calls the object’s [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621461-encoderestorablestatewithcoder) method to give it a chance to save its state. During the decode process, a matching call to the [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621429-decoderestorablestate) method is made to decode that state and apply it to the object. The implementation of these methods is optional, but recommended, for your view controllers. You can use them to save and restore the following types of information:

- References to any data being displayed (not the data itself)
- For a container view controller, references to its child view controllers
- Information about the current selection
- For view controllers with a user-configurable view, information about the current configuration of that view.

In your encode and decode methods, you can encode any values supported by the coder, including other objects. For all objects except views and view controllers, the object must adopt the [NSCoding](https://developer.apple.com/reference/foundation/nscoding) protocol and use the methods of that protocol to write its state. For views and view controllers, the coder does not use the methods of the NSCoding protocol to save the object’s state. Instead, the coder saves the restoration identifier of the object and adds it to the list of preservable objects, which results in that object’s encodeRestorableStateWithCoder: method being called.

The encodeRestorableStateWithCoder: and decodeRestorableStateWithCoder: methods of your view controllers should always call super at some point in their implementation. Calling super gives the parent class a chance to save and restore any additional information. Listing 5-2 shows a sample implementation of these methods that save a numerical value used to identify the specified view controller.

**Listing 5-2**  Encoding and decoding a view controller’s state.
	- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
	   [super encodeRestorableStateWithCoder:coder];
	 
	   [coder encodeInt:self.number forKey:MyViewControllerNumber];
	}
	 
	- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
	   [super decodeRestorableStateWithCoder:coder];
	 
	   self.number = [coder decodeIntForKey:MyViewControllerNumber];
	}

Coder objects are not shared during the encode and decode process. Each object with preservable state receives its own coder that it can use to read or write data. The use of unique coders means that you do not have to worry about key namespace collisions among your own objects. However, you must still avoid using some special key names that UIKit provides. Specifically, each coder contains the [UIApplicationStateRestorationBundleVersionKey](https://developer.apple.com/reference/uikit/uiapplicationstaterestorationbundleversionkey) and [UIApplicationStateRestorationUserInterfaceIdiomKey](https://developer.apple.com/reference/uikit/uiapplicationstaterestorationuserinterfaceidiomkey) keys, which provide information about the bundle version and current user interface idiom. Coders associated with view controllers may also contain the [UIStateRestorationViewControllerStoryboardKey](https://developer.apple.com/reference/uikit/uistaterestorationviewcontrollerstoryboardkey) key, which identifies the storyboard from which that view controller originated.

For more information about implementing your encode and decode methods for your view controllers, see [UIViewController Class Reference](https://developer.apple.com/reference/uikit/uiviewcontroller).

<span id=5.4.9>
###5.4.9 Preserving the State of Your Views 保持视图的状态

If a view has state information worth preserving, you can save that state with the rest of your app’s view controllers. Because they are usually configured by their owning view controller, most views do not need to save state information. The only time you need to save a view’s state is when the view itself can be altered by the user in a way that is independent of its data or the owning view controller. For example, scroll views save the current scroll position, which is information that is not interesting to the view controller but which does affect how the view presents itself.

To designate that a view’s state should be saved, you do the following:

- Assign a valid string to the view’s [restorationIdentifier](https://developer.apple.com/reference/uikit/uiview/1622494-restorationidentifier) property.
- Use the view from a view controller that also has a valid restoration identifier.
- For table views and collection views, assign a data source that adopts the [UIDataSourceModelAssociation](https://developer.apple.com/reference/uikit/uidatasourcemodelassociation) protocol.

As with view controllers, assigning a restoration identifier to a view tells the system that the view object has state that your app wants to save. The restoration identifier can also be used to locate the view later.

Like view controllers, views define methods for encoding and decoding their custom state. If you create a view with state worth saving, you can use these methods to read and write any relevant data.

<span id=5.4.9.1>
####5.4.9.1 UIKit Views with Preservable State 可保持状态的UIKit视图

In order to save the state of any view, including both custom and standard system views, you must assign a restoration identifier to the view. Views without a restoration identifier are not added to the list of preservable objects by UIKit.

The following UIKit views have state information that can be preserved:

- [UICollectionView](https://developer.apple.com/reference/uikit/uicollectionview)
- [UIImageView](https://developer.apple.com/reference/uikit/uiimageview)
- [UIScrollView](https://developer.apple.com/reference/uikit/uiscrollview)
- [UITableView](https://developer.apple.com/reference/uikit/uitableview)
- [UITextField](https://developer.apple.com/reference/uikit/uitextfield)
- [UITextView](https://developer.apple.com/reference/uikit/uitextview)
- [UIWebView](https://developer.apple.com/reference/uikit/uiwebview)

Other frameworks may also have views with preservable state. For information about whether a view saves state information and what state it saves, see the reference for the corresponding class.

<span id=5.4.9.2>
####5.4.9.2 Preserving the State of a Custom View 保持自定义视图的状态

If you are implementing a custom view that has restorable state, implement the [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiview/1622516-encoderestorablestatewithcoder) and [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiview/1622638-decoderestorablestatewithcoder) methods and use them to encode and decode that state. Use those methods to save only the data that cannot be easily reconfigured by other means. For example, use these methods to save data that is modified by user interactions with the view. Do not use these methods to save the data being presented by the view or any data that the owning view controller can configure easily.

Listing 5-3 shows an example of how to preserve and restore the selection for a custom view that contains editable text. In the example, the range is accessible using the selectionRange and setSelectionRange: methods, which are custom methods the view uses to manage the selection. Encoding the data only requires writing it to the provided coder object. Restoring the data requires reading it and applying it to the view.

**Listing 5-3**  Preserving the selection of a custom text view

	// Preserve the text selection
	- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
	    [super encodeRestorableStateWithCoder:coder];
	 
	    NSRange range = [self selectionRange];
	    [coder encodeInt:range.length forKey:kMyTextViewSelectionRangeLength];
	    [coder encodeInt:range.location forKey:kMyTextViewSelectionRangeLocation];
	}
	 
	// Restore the text selection.
	- (void) decodeRestorableStateWithCoder:(NSCoder *)coder {
	   [super decodeRestorableStateWithCoder:coder];
	   if ([coder containsValueForKey:kMyTextViewSelectionRangeLength] &&
	           [coder containsValueForKey:kMyTextViewSelectionRangeLocation]) {
	      NSRange range;
	      range.length = [coder decodeIntForKey:kMyTextViewSelectionRangeLength];
	      range.location = [coder decodeIntForKey:kMyTextViewSelectionRangeLocation];
	      if (range.length > 0)
	         [self setSelectionRange:range];
	   }
	}

<span id=5.4.9.3>
####5.4.9.3 Implementing Preservation-Friendly Data Sources 实现友好保持的数据源

Because the data displayed by a table or collection view can change, both classes save information about the current selection and visible cells only if their data source implements the [UIDataSourceModelAssociation](https://developer.apple.com/reference/uikit/uidatasourcemodelassociation) protocol. This protocol provides a way for a table or collection view to identify the content it contains without relying on the index path of that content. Thus, regardless of where the data source places an item during the next launch cycle, the view still has all the information it needs to locate that item.

In order to implement the UIDataSourceModelAssociation protocol successfully, your data source object must be able to identify items between subsequent launches of the app. This means that any identification scheme you devise must be invariant for a given piece of data. This is essential because the data source must be able to retrieve the same piece of data for the same identifier each time it is requested. Implementing the protocol itself is a matter of mapping from a data item to its unique ID and back again.

Apps that use Core Data can implement the protocol by taking advantage of object identifiers. Each object in a Core Data store has a unique object identifier that can be converted into a URI and used to locate the object later. If your app does not use Core Data, you need to devise your own form of unique identifiers if you want to support state preservation for your views.

>**Note:** Remember that implementing the UIDataSourceModelAssociation protocol is only necessary to preserve attributes such as the current selection in a table or collection view. This protocol is not used to preserve the actual data managed by your data source. It is your app’s responsibility to ensure that its data is saved at appropriate times.

<span id=5.4.10>
###5.4.10 Preserving Your App’s High-Level State 保持App的高级状态

In addition to the data preserved by your app’s view controllers and views, UIKit provides hooks for you to save any miscellaneous data needed by your app. Specifically, the UIApplicationDelegate protocol includes the following methods for you to override:

- [application:willEncodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623099-application)
- [application:didDecodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623006-application)

If your app contains state that does not live in a view controller, but that needs to be preserved, you can use the preceding methods to save and restore it. The application:willEncodeRestorableStateWithCoder: method is called at the very beginning of the preservation process so that you can write out any high-level app state, such as the current version of your user interface. The application:didDecodeRestorableStateWithCoder: method is called at the end of the restoration state so that you can decode any data and perform any final cleanup that your app requires.

<span id=5.4.11>
###5.4.11 Tips for Saving and Restoring State Information 保存和恢复状态信息的诀窍

As you add support for state preservation and restoration to your app, consider the following guidelines:

- **Encode version information along with the rest of your app’s state.** During the preservation process, it is recommended that you encode a version string or number that identifies the current revision of your app’s user interface. You can encode this state in the [application:willEncodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623099-application) method of your app delegate. When your app delegate’s [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method is called, you can retrieve this information from the provided coder and use it to determine if state preservation is possible.
- **Do not include objects from your data model in your app’s state.** Apps should continue to save their data separately in iCloud or to local files on disk. Never use the state restoration mechanism to save that data. Preserved interface data may be deleted if problems occur during a restore operation. Therefore, any preservation-related data you write to disk should be considered purgeable.
- **The state preservation system expects you to use view controllers in the ways they were designed to be used.** The view controller hierarchy is created through a combination of view controller containment and by presenting one view controller from another. If your app displays the view of a view controller by another means—for example, by adding it to another view without creating a containment relationship between the corresponding view controllers—the preservation system will not be able to find your view controller to preserve it.
- **Remember that you might not want to preserve all view controllers.** In some cases, it might not make sense to preserve a view controller. For example, if the user left your app while it was displaying a view controller to change the user’s password, you might want to cancel the operation and restore the app to the previous screen. In such a case, you would not preserve the view controller that asks for the new password information.
- **Avoid swapping view controller classes during the restoration process.** The state preservation system encodes the class of the view controllers it preserves. During restoration, if your app returns an object whose class does not match (or is not a subclass of) the original object, the system does not ask the view controller to decode any state information. Thus, swapping out the old view controller for a completely different one does not restore the full state of the object.
- **The system automatically deletes an app’s preserved state when the user force quits the app.** Deleting the preserved state information when the app is killed is a safety precaution. (As a safety precaution, the system also deletes preserved state if the app crashes twice during launch.) If you want to test your app’s ability to restore its state, you should not use the multitasking bar to kill the app during debugging. Instead, use Xcode to kill the app or kill the app programmatically by installing a temporary command or gesture to call exit on demand.

<span id=5.5>
##5.5 Tips for Developing a VoIP App 开发VoIP App的诀窍

A Voice over Internet Protocol (VoIP) app allows the user to make phone calls using an Internet connection instead of the device’s cellular service. In iOS 8 and later, you can use the Apple Push Notification service (APNs) and the APIs of the PushKit framework to create a VoIP app. Relying on push notifications to enable VoIP functionality means that your app doesn’t have to maintain a persistent network connection to the associated service or configure a socket for VoIP usage. When a VoIP push notification arrives, your app is given time to handle the notification, even if the app is currently terminated.

>**Note:** VoIP push notifications are sent only to devices running iOS 8 or later. If you need to support devices that run earlier versions of iOS, you’re responsible for maintaining a compatible implementation.

As with any background audio app, the audio session for a VoIP app must be configured properly to ensure the app works smoothly with other audio-based apps. Because audio playback and recording for a VoIP app are not used all the time, it is especially important that you create and configure your app’s audio session object only when it’s needed. For example, you would create the audio session to notify the user of an incoming call or while the user was actually on a call. As soon as the call ends, you would then remove strong references to the audio session and give other audio apps the opportunity to play their audio.

For information about how to configure and manage an audio session for a VoIP app, see [Audio Session Programming Guide](https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007875). To learn more about using VoIP push notifications and the PushKit APIs to create a VoIP app, see [Energy Efficiency Guide for iOS Apps](https://developer.apple.com/library/content/documentation/Performance/Conceptual/EnergyGuide-iOS/index.html#//apple_ref/doc/uid/TP40015243).

There are several requirements for implementing a VoIP app:

1. Enable the Voice over IP background mode for your app. (Because VoIP apps involve audio content, it is recommended that you also enable the Audio and AirPlay background mode.) You enable background modes in the Capabilities tab of your Xcode project.
2. Use PushKit APIs to register to receive VoIP push notifications and handle incoming notifications.
3. Configure your audio session to handle transitions to and from active use.
4. To ensure a better user experience on iPhone, use the Core Telephony framework to adjust your behavior in relation to cell-based phone calls; see [Core Telephony Framework Reference](https://developer.apple.com/reference/coretelephony).
5. To ensure good performance for your VoIP app, use the System Configuration framework to detect network changes and allow your app to sleep as much as possible.
6. Request a VoIP Services certificate to allow your notification server to connect to the VoIP service.

Enabling the VoIP background mode lets the system know that it should allow the app to run in the background as needed to manage its network sockets. This key also permits your app to play background audio (although enabling the Audio and AirPlay mode is still encouraged). An app that supports this mode is also relaunched in the background immediately after system boot to ensure that the VoIP services are always available.

<span id=5.5.1>
###5.5.1 Using the Reachability Interfaces to Improve the User Experience 使用Reachability接口提升用户体验

Because VoIP apps rely heavily on the network, they should use the reachability interfaces of the System Configuration framework to track network availability and adjust their behavior accordingly. The reachability interfaces allow an app to be notified whenever network conditions change. For example, a VoIP app could close its network connections when the network becomes unavailable and recreate them when it becomes available again. The app could also use those kinds of changes to keep the user apprised about the state of the VoIP connection.

To use the reachability interfaces, you must register a callback function with the framework and use it to track changes. To register a callback function:

1. Create a [SCNetworkReachabilityRef](https://developer.apple.com/reference/systemconfiguration/scnetworkreachability) structure for your target remote host.
2. Assign a callback function to your structure (using the [SCNetworkReachabilitySetCallback](https://developer.apple.com/reference/systemconfiguration/1514903-scnetworkreachabilitysetcallback) function) that processes changes in your target’s reachability status.
3. Add that target to an active run loop of your app (such as the main run loop) using the [SCNetworkReachabilityScheduleWithRunLoop](https://developer.apple.com/reference/systemconfiguration/1514894-scnetworkreachabilityschedulewit) function.

Adjusting your app’s behavior based on the availability of the network can also help improve the battery life of the underlying device. Letting the system track the network changes means that your app can let itself go to sleep more often.

For more information about the reachability interfaces, see [System Configuration Framework Reference](https://developer.apple.com/reference/systemconfiguration).

# 6 Inter-App Communication App内部通信

Apps communicate only indirectly with other apps on a device. You can use AirDrop to share files and data with other apps. You can also define a custom URL scheme so that apps can send information to your app using URLs.

App只能间接与设备上的其他app通信。你可以使用AirDrop共享文件和数据给其他app。你也可以定义一个自定义的URL Scheme，让其他app可以使用URL发送信息给你的app。

> **Note:** You can also send files between apps using a [UIDocumentInteractionController](https://developer.apple.com/reference/uikit/uidocumentinteractioncontroller) object or a document picker. For information about adding support for a document interaction controller, see [Document Interaction Programming Topics for iOS](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010403). For information about using a document picker to open files, see [Document Picker Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentPickerProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40014451).

> **注意：** 你也可以使用 [UIDocumentInteractionController](https://developer.apple.com/reference/uikit/uidocumentinteractioncontroller) 对象或者文档采集器在app之间发送文件。 关于添加文档交互控制器的支持的信息，参见《 [Document Interaction Programming Topics for iOS](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010403) 》。关于使用文档采集器打开文件的信息，参见《 [Document Picker Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentPickerProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40014451) 》。

## 6.1 Supporting AirDrop 支持AirDrop

AirDrop lets you share photos, documents, URLs, and other types of data with nearby devices. AirDrop takes advantage of peer-to-peer networking to find nearby devices and connect to them.

AirDrop让你与附近的设备共享照片，文档，URL，及其他类型的数据。AirDrop利用点对点（P2P）网络找到附近的设备并与他们连接。

###6.1.1 Sending Files and Data to Another App 发送文件和数据给另一个app

To send files and data using AirDrop, use a [UIActivityViewController](https://developer.apple.com/reference/uikit/uiactivityviewcontroller) object to display an activity sheet from your user interface using. When creating this view controller, you specify the data objects that you want to share. The view controller displays only those activities that support the specified data. For AirDrop, you can specify images, strings, URLs, and several other types of data. You can also pass custom objects that adopt the [UIActivityItemSource](https://developer.apple.com/reference/uikit/uiactivityitemsource) protocol.

要使用AirDrop发送文件和数据，需要使用 [UIActivityViewController](https://developer.apple.com/reference/uikit/uiactivityviewcontroller) 对象在用户使用的界面上显示一个活动表。当创建这个视图控制器时，你要指定想要分享的数据对象。这个视图控制器只会显示支持这个指定对象的活动。对于AirDrop，你可以指定图像、字符串、URL以及其他类型的数据。你也可以传递采用了 [UIActivityItemSource](https://developer.apple.com/reference/uikit/uiactivityitemsource) 协议的自定义对象。

To display an activity view controller, you can use code similar to that shown in Listing 6-1. The activity view controller automatically uses the type of the specified object to determine what activities to display in the activity sheet. You do not have to specify the AirDrop activity explicitly. However, you can prevent the sheet from displaying specific types using the view controller’s [excludedActivityTypes](https://developer.apple.com/reference/uikit/uiactivityviewcontroller/1622009-excludedactivitytypes) property. When displaying an activity view controller on iPad, you must use a popover.

要显示活动视图控制器，你可以使用类似于表6-1中展示的代码。活动视图控制器自动使用指定对象的类型决定在活动表中显示哪些活动。你不用明确的指定AirDrop活动。但是你可以使用视图控制器的[excludedActivityTypes](https://developer.apple.com/reference/uikit/uiactivityviewcontroller/1622009-excludedactivitytypes) 属性让某些指定类型不在表中显示。当在iPad上显示活动视图控制器时，你必须使用一个popover。

**Listing 6-1**  Displaying an activity sheet on iPhone

	- (void)displayActivityControllerWithDataObject:(id)obj {
	   UIActivityViewController* vc = [[UIActivityViewController alloc]
	                                initWithActivityItems:@[obj] applicationActivities:nil];
	    [self presentViewController:vc animated:YES completion:nil];
	}

For more information about using the activity view controller, see [UIActivityViewController Class Reference](https://developer.apple.com/reference/uikit/uiactivityviewcontroller). For a complete list of activities and the data types they support, see [UIActivity Class Reference](https://developer.apple.com/reference/uikit/uiactivity).

关于使用活动视图控制器的更多信息，参见 [UIActivityViewController Class Reference](https://developer.apple.com/reference/uikit/uiactivityviewcontroller)。完整的活动列表以及它们支持的数据类型，参见 [UIActivity Class Reference](https://developer.apple.com/reference/uikit/uiactivity)。

###6.1.2 Receiving Files and Data Sent to Your App 接收发送到你的app的文件和数据

To receive files sent to your app using AirDrop, do the following:

要接收使用AirDrop发送到你的app的文件，要做这些事：

- In Xcode, declare support for the document types your app is capable of opening.
- In your app delegate, implement the [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) method. Use that method to receive the data that was sent by the other app.
- Be prepared to look for files in your app’s *Documents/Inbox* directory and move them out of that directory as needed.
- 在Xcode中，声明你的app能支持打开的文档类型。
- 在你的app代理中，实现 [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) 方法。使用这个方法接收由其他app发来的数据。
- 准备好在app的 *Documents/Inbox* 目录里查看文件，如果有必要就把它们移动到其他目录。

The Info tab of your Xcode project contains a Document Types section for specifying the document types your app supports. At a minimum, you must specify a name for your document type and one or more UTIs that represent the data type. For example, to declare support for PNG files, you would include public.png as the UTI string. iOS uses the specified UTIs to determine if your app is eligible to open a given document.

Xcode工程的*Info*标签包含了一个*Document Types*部分，可以指定你的app支持的文档类型。至少你必须指定一个文档类型的名字，以及一个或多个表示该数据类型的UTI（唯一标识符）。例如，要声明支持PNG文件，你需要包含 *public.png* 作为UTI字符串。iOS使用指定的UTI决定app是否有资格打开给出的文档。

After transferring an eligible document to your app’s container, iOS launches your app (if needed) and calls the *application:openURL:sourceApplication:annotation:* method of its app delegate. If your app is in the foreground, you should use this method to open the file and display it to the user. If your app is in the background, you might decide only to note that the file is there so that you can open it later. Because files transferred via AirDrop are encrypted using data protection, you cannot open files unless the device is currently unlocked.

在把有资格的文档传到你app的容器中之后，iOS启动你的app（如果需要）并调用app代理的*application:openURL:sourceApplication:annotation:*方法。如果你的app正在前台，你需要使用这个方法打开文件并显示给用户。如果你的app正在后台，你可能决定只是通知用户文件已经在这里了可以稍后打开。因为通过AirDrop传输的文件是使用数据保护编码的，除非设备当前已解锁，否则你无法打开这些文件。

Files transferred to your app using AirDrop are placed in your app’s *Documents/Inbox* directory. Your app has permission to read and delete files in this directory but it does not have permission to write to files. If you plan to modify the file, you must move it out of the *Inbox* directory before doing so. It is recommended that you delete files from the *Inbox* directory when you no longer need them.

使用AirDrop传输到你的app的文件被放在你的app的 *Documents/Inbox* 目录下。你的app有权限阅读和删除这个文件夹中的文件，但是没有权限写入这些文件。如果你想要修改这个文件，你必须在修改之前将它从 *Inbox* 文件夹移出来。当你不需要这些文件时，推荐你将它们从 *Inbox* 目录删除。

For more information about supporting document types in your app, see [Document-Based App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011149).

关于在app中支持文档类型的更多信息，参见《[Document-Based App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011149)》。

##6.2 Using URL Schemes to Communicate with Apps 使用URL Scheme与App通信

A URL scheme lets you communicate with other apps through a protocol that you define. To communicate with an app that implements such a scheme, you must create an appropriately formatted URL and ask the system to open it. To implement support for a custom scheme, you must declare support for the scheme and handle incoming URLs that use the scheme.

>**Note:** Apple provides built-in support for the http, mailto, tel, and sms URL schemes among others. It also supports http–based URLs targeted at the Maps, YouTube, and iPod apps. The handlers for these schemes are fixed and cannot be changed. If your URL type includes a scheme that is identical to one defined by Apple, the Apple-provided app is launched instead of your app. For information about the schemes supported by apple, see [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

###6.2.1 Sending a URL to Another App

When you want to send data to an app that implements a custom URL scheme, create an appropriately formatted URL and call the [openURL:](https://developer.apple.com/reference/uikit/uiapplication/1622961-openurl) method of the app object. The openURL: method launches the app with the registered scheme and passes your URL to it. At that point, control passes to the new app.

The following code fragment illustrates how one app can request the services of another app (“todolist” in this example is a hypothetical custom scheme registered by an app):

	NSURL *myURL = [NSURL URLWithString:@"todolist://www.acme.com?Quarterly%20Report#200806231300"];
	[[UIApplication sharedApplication] openURL:myURL];

If your app defines a custom URL scheme, it should implement a handler for that scheme as described in Implementing Custom URL Schemes. For more information about the system-supported URL schemes, including information about how to format the URLs, see [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

###6.2.2 Implementing Custom URL Schemes

If your app can receive specially formatted URLs, you should register the corresponding URL schemes with the system. Apps often use custom URL schemes to vend services to other apps. For example, the Maps app supports URLs for displaying specific map locations.

####6.2.2.1 Registering Custom URL Schemes

To register a URL type for your app, include the CFBundleURLTypes key in your app’s Info.plist file. The CFBundleURLTypes key contains an array of dictionaries, each of which defines a URL scheme the app supports. Table 6-1 describes the keys and values to include in each dictionary.

**Table 6-1**  Keys and values of the CFBundleURLTypes property

| **Key**            | **Value**                                |
| ------------------ | ---------------------------------------- |
| CFBundleURLName    | A string containing the abstract name of the URL scheme. To ensure uniqueness, it is recommended that you specify a reverse-DNS style of identifier, for example, com.acme.myscheme.The string you specify is also used as a key in your app’s InfoPlist.strings file. The value of the key is the human-readable scheme name. |
| CFBundleURLSchemes | An array of strings containing the URL scheme names—for example, http, mailto, tel, and sms. |

>**Note:** If more than one third-party app registers to handle the same URL scheme, there is currently no process for determining which app will be given that scheme.

####6.2.2.2 Handling URL Requests

An app that has its own custom URL scheme must be able to handle URLs passed to it. All URLs are passed to your app delegate, either at launch time or while your app is running or in the background. To handle incoming URLs, your delegate should implement the following methods:

- Use the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods to retrieve information about the URL and decide whether you want to open it. If either method returns a NO/a, your app’s URL handling code is not called.
- Use the [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) method to open the file.

If your app is not running when a URL request arrives, it is launched and moved to the foreground so that it can open the URL. The implementation of your application:willFinishLaunchingWithOptions: or application:didFinishLaunchingWithOptions: method should retrieve the URL from its options dictionary and determine whether the app can open it. If it can, return a YES/a and let your application:openURL:sourceApplication:annotation: (or application:handleOpenURL:) method handle the actual opening of the URL. (If you implement both methods, both must return a YES/a before the URL can be opened.) Figure 6-1 shows the modified launch sequence for an app that is asked to open a URL.

**Figure 6-1**  Launching an app to open a URL
![Figure 6-1](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_open_url_2x.png)

If your app is running but is in the background or suspended when a URL request arrives, it is moved to the foreground to open the URL. Shortly thereafter, the system calls the delegate’s application:openURL:sourceApplication:annotation: to check the URL and open it. Figure 6-2 shows the modified process for moving an app to the foreground to open a URL.

**Figure 6-2**  Waking a background app to open a URL
![Figure 6-2](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_bg_open_url_2x.png)

>**Note:** Apps that support custom URL schemes can specify different launch images to be displayed when launching the app to handle a URL. For more information about how to specify these launch images, see Displaying a Custom Launch Image When a URL is Opened.

All URLs are passed to your app in an [NSURL](https://developer.apple.com/reference/foundation/nsurl) object. It is up to you to define the format of the URL, but the NSURL class conforms to the RFC 1808 specification and therefore supports most URL formatting conventions. Specifically, the class includes methods that return the various parts of a URL as defined by RFC 1808, including the user, password, query, fragment, and parameter strings. The “protocol” for your custom scheme can use these URL parts for conveying various kinds of information.

In the implementation of [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) shown in Listing 6-2, the passed-in URL object conveys app-specific information in its query and fragment parts. The delegate extracts this information—in this case, the name of a to-do task and the date the task is due—and with it creates a model object of the app. This example assumes that the user is using a Gregorian calendar. If your app supports non-Gregorian calendars, you need to design your URL scheme accordingly and be prepared to handle those other calendar types in your code.

**Listing 6-2**  Handling a URL request based on a custom scheme

	- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
	        sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	    if ([[url scheme] isEqualToString:@"todolist"]) {
	        ToDoItem *item = [[ToDoItem alloc] init];
	        NSString *taskName = [url query];
	        if (!taskName || ![self isValidTaskString:taskName]) { // must have a task name
	            return NO;
	        }
	        taskName = [taskName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	 
	        item.toDoTask = taskName;
	        NSString *dateString = [url fragment];
	        if (!dateString || [dateString isEqualToString:@"today"]) {
	            item.dateDue = [NSDate date];
	        } else {
	            if (![self isValidDateString:dateString]) {
	                return NO;
	            }
	            // format: yyyymmddhhmm (24-hour clock)
	            NSString *curStr = [dateString substringWithRange:NSMakeRange(0, 4)];
	            NSInteger yeardigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(4, 2)];
	            NSInteger monthdigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(6, 2)];
	            NSInteger daydigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(8, 2)];
	            NSInteger hourdigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(10, 2)];
	            NSInteger minutedigit = [curStr integerValue];
	 
	            NSDateComponents *dateComps = [[NSDateComponents alloc] init];
	            [dateComps setYear:yeardigit];
	            [dateComps setMonth:monthdigit];
	            [dateComps setDay:daydigit];
	            [dateComps setHour:hourdigit];
	            [dateComps setMinute:minutedigit];
	            NSCalendar *calendar = [s[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	            NSDate *itemDate = [calendar dateFromComponents:dateComps];
	            if (!itemDate) {
	                return NO;
	            }
	            item.dateDue = itemDate;
	        }
	 
	        [(NSMutableArray *)self.list addObject:item];
	        return YES;
	    }
	    return NO;
	}

Be sure to validate the input you get from URLs passed to your app; see [Validating Input and Interprocess Communication](https://developer.apple.com/library/content/documentation/Security/Conceptual/SecureCodingGuide/Articles/ValidatingInput.html#//apple_ref/doc/uid/TP40007246) in [Secure Coding Guide](https://developer.apple.com/library/content/documentation/Security/Conceptual/SecureCodingGuide/Introduction.html#//apple_ref/doc/uid/TP40002415) to find out how to avoid problems related to URL handling. To learn about URL schemes defined by Apple, see [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

###6.2.3 Displaying a Custom Launch Image When a URL is Opened 当打开URL时显示自定义的启动图像

Apps that support custom URL schemes can provide a custom launch image for each scheme. When the system launches your app to handle a URL and no relevant snapshot is available, it displays the launch image you specify. To specify a launch image, provide a PNG image whose name uses the following naming conventions:

*\<basename>-\<url_scheme>\<other_modifiers>.png*

In this naming convention, basename represents the base image name specified by the *UILaunchImageFile* key in your app’s *Info.plist* file. If you do not specify a custom base name, use the string *Default*. The *<url_scheme>* portion of the name is your URL scheme name. To specify a generic launch image for the *myapp* URL scheme, you would include an image file with the name *Default-myapp@2x.png* in the app’s bundle. (The @2x modifier signifies that the image is intended for Retina displays. If your app also supports standard resolution displays, you would also provide a *Default-myapp.png* image.)

For information about the other modifiers you can include in launch image names, see the description of the *UILaunchImageFile* name key in [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247).

#7 Performance Tips 性能提示

At each step in the development of your app, consider the implications of your design choices on the overall performance of your app. Power usage and memory consumption are extremely important considerations for iOS apps, and there are many other considerations as well. The following sections describe the factors you should consider throughout the development process.

##7.1 Reduce Your App’s Power Consumption 降低你App的能量消耗

Power consumption on mobile devices is always an issue. The power management system in iOS conserves power by shutting down any hardware features that are not currently being used. You can help improve battery life by optimizing your use of the following features:

- The CPU
- Wi-Fi, Bluetooth, and baseband (EDGE, 3G) radios
- The Core Location framework
- The accelerometers
- The disk

The goal of your optimizations should be to do the most work you can in the most efficient way possible. You should always optimize your app’s algorithms using Instruments. But even the most optimized algorithm can still have a negative impact on a device’s battery life. You should therefore consider the following guidelines when writing your code:

- Avoid doing work that requires polling. Polling prevents the CPU from going to sleep. Instead of polling, use the [NSRunLoop](https://developer.apple.com/reference/foundation/runloop) or [NSTimer](https://developer.apple.com/reference/foundation/nstimer) classes to schedule work as needed.
- Leave the [idleTimerDisabled](https://developer.apple.com/reference/uikit/uiapplication/1623070-isidletimerdisabled) property of the shared [UIApplication](https://developer.apple.com/reference/uikit/uiapplication) object set to a NO/a whenever possible. The idle timer turns off the device’s screen after a specified period of inactivity. If your app does not need the screen to stay on, let the system turn it off. If your app experiences side effects as a result of the screen being turned off, you should modify your code to eliminate the side effects rather than disable the idle timer unnecessarily.
- Coalesce work whenever possible to maximize idle time. It generally takes less power to perform a set of calculations all at once than it does to perform them in small chunks over an extended period of time. Doing small bits of work periodically requires waking up the CPU more often and getting it into a state where it can perform your tasks.
- Avoid accessing the disk too frequently. For example, if your app saves state information to the disk, do so only when that state information changes, and coalesce changes whenever possible to avoid writing small changes at frequent intervals.
- Do not draw to the screen faster than is needed. Drawing is an expensive operation when it comes to power. Do not rely on the hardware to throttle your frame rates. Draw only as many frames as your app actually needs.
- If you use the [UIAccelerometer](https://developer.apple.com/reference/uikit/uiaccelerometer) class to receive regular accelerometer events, disable the delivery of those events when you do not need them. Similarly, set the frequency of event delivery to the smallest value that is suitable for your needs. For more information, see [Event Handling Guide for iOS](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009541).

The more data you transmit to the network, the more power must be used to run the radios. In fact, accessing the network is the most power-intensive operation you can perform. You can minimize that time by following these guidelines:

- Connect to external network servers only when needed, and do not poll those servers.
- When you must connect to the network, transmit the smallest amount of data needed to do the job. Use compact data formats, and do not include excess content that simply is ignored.
- Transmit data in bursts rather than spreading out transmission packets over time. The system turns off the Wi-Fi and cell radios when it detects a lack of activity. When it transmits data over a longer period of time, your app uses much more power than when it transmits the same amount of data in a shorter amount of time. When using the [NSURLSession](https://developer.apple.com/reference/foundation/urlsession) class to enqueue multiple upload or download tasks, enqueue those items together rather than waiting for one to finish before starting the next one. The system manages automatically executes queued tasks when it is most efficient to do so. 
- Connect to the network using the Wi-Fi radios whenever possible. Wi-Fi uses less power and is preferred over cellular radios.
- If you use the Core Location framework to gather location data, disable location updates as soon as you can and set the distance filter and accuracy levels to appropriate values. Core Location uses the available GPS, cell, and Wi-Fi networks to determine the user’s location. Although Core Location works hard to minimize the use of these radios, setting the accuracy and filter values gives Core Location the option to turn off hardware altogether in situations where it is not needed. For more information, see [Location and Maps Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009497).

The Instruments app includes several instruments for gathering power-related information. You can use these instruments to gather general information about power consumption and to gather specific measurements for hardware such as the Wi-Fi and Bluetooth radios, GPS receiver, display, and CPU. You can also enable Energy Diagnostics Logging on a device to gather information. For information about using Instruments to gather power-related data, see [Instruments User Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/index.html#//apple_ref/doc/uid/TP40004652). For information about how to enable Energy Diagnostics Logging on a device, see [Instruments Help](https://help.apple.com/instruments).

##7.2 Use Memory Efficiently 有效的使用内存

Apps are encouraged to use as little memory as possible so that the system may keep more apps in memory or dedicate more memory to foreground apps that truly need it. There is a direct correlation between the amount of free memory available to the system and the relative performance of your app. Less free memory means that the system is more likely to have trouble fulfilling future memory requests.

To ensure there is always enough free memory available, you should minimize your app’s memory usage and be responsive when the system asks you to free up memory.

###7.2.1 Observe Low-Memory Warnings 监控低内存警告

When the system dispatches a low-memory warning to your app, respond immediately. Low-memory warnings are your opportunity to remove references to objects that you do not need. Responding to these warnings is crucial because apps that fail to do so are more likely to be terminated. The system delivers memory warnings to your app using the following APIs:

- The [applicationDidReceiveMemoryWarning:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623063-applicationdidreceivememorywarni) method of your app delegate.
- The [didReceiveMemoryWarning](https://developer.apple.com/reference/uikit/uiviewcontroller/1621409-didreceivememorywarning) method of your UIViewController classes.
- The [UIApplicationDidReceiveMemoryWarningNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1622920-uiapplicationdidreceivememorywar) notification.
- Dispatch sources of type [DISPATCH_SOURCE_TYPE_MEMORYPRESSURE](https://developer.apple.com/reference/dispatch/dispatch_source_type_memorypressure). This technique is the only one that you can use to distinguish the severity of the memory pressure.

Upon receiving any of these warnings, your handler method should respond by immediately freeing up any unneeded memory. Use the warnings to clear out caches and release images. If you have large data structures that are not being used, write those structures to disk and release the in-memory copies of the data.

If your data model includes known purgeable resources, you can have a corresponding manager object register for the UIApplicationDidReceiveMemoryWarningNotification notification and remove strong references to its purgeable resources directly. Handling this notification directly avoids the need to route all memory warning calls through the app delegate.

>**Note:** You can test your app’s behavior under low-memory conditions using the Simulate Memory Warning command in iOS Simulator.

###7.2.2 Reduce Your App’s Memory Footprint 减少App占用的内存空间

Starting off with a low footprint gives you more room for expanding your app later. Table 7-1 lists some tips on how to reduce your app’s overall memory footprint.

**Table 7-1**  Tips for reducing your app’s memory footprint

| **Tip**                                  | **Actions to take**                      |
| ---------------------------------------- | ---------------------------------------- |
| Eliminate memory leaks.                  | Because memory is a critical resource in iOS, your app should never have memory leaks. Use the Instruments app to track down leaks in your code, both in Simulator and on actual devices. For more information on using Instruments, see [Instruments User Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/index.html#//apple_ref/doc/uid/TP40004652). |
| Make resource files as small as possible. | Files reside on disk but must be loaded into memory before they can be used. Compress all image files to make them as small as possible. (To compress PNG images—the preferred image format for iOS apps—use the pngcrush tool.) You can make property list files smaller by writing them out in a binary format using the [NSPropertyListSerialization](https://developer.apple.com/reference/foundation/nspropertylistserialization) class. |
| Use Core Data or SQLite for large data sets. | If your app manipulates large amounts of structured data, store it in a Core Data persistent store or in a SQLite database instead of in a flat file. Both Core Data and SQLite provides efficient ways to manage large data sets without requiring the entire set to be in memory all at once. |
| Load resources lazily.                   | You should never load a resource file until it is actually needed. Prefetching resource files may seem like a way to save time, but this practice actually slows down your app right away. In addition, if you end up not using the resource, loading it wastes memory for no good purpose. |

###7.2.3 Allocate Memory Wisely 谨慎的分配内存

Table 7-2 lists tips for improving memory usage in your app.

**Table 7-2**  Tips for allocating memory

| **Tip**                          | **Actions to take**                      |
| -------------------------------- | ---------------------------------------- |
| Impose size limits on resources. | Avoid loading a large resource file when a smaller one will do. Instead of using a high-resolution image, use one that is appropriately sized for iOS-based devices. If you must use large resource files, find ways to load only the portion of the file that you need at any given time. For example, rather than load the entire file into memory, use the mmap and munmap functions to map portions of the file into and out of memory. For more information about mapping files into memory, see a target="_self" File-System Performance Guidelines/a. |
| Avoid unbounded problem sets.    | Unbounded problem sets might require an arbitrarily large amount of data to compute. If the set requires more memory than is available, your app may be unable to complete the calculations. Your apps should avoid such sets whenever possible and work on problems with known memory limits. |

For detailed information about ARC and memory management, see [Transitioning to ARC Release Notes](https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226).

##7.3 Tune Your Networking Code 调节你的网络代码

The networking stack in iOS includes several interfaces for communicating over the radio hardware of iOS devices. The main programming interface is the CFNetwork framework, which builds on top of BSD sockets and opaque types in the Core Foundation framework to communicate with network entities. You can also use the [NSStream](https://developer.apple.com/reference/foundation/nsstream) classes in the Foundation framework and the low-level BSD sockets found in the Core OS layer of the system.

For information about how to use the CFNetwork framework for network communication, see [CFNetwork Programming Guide](https://developer.apple.com/library/content/documentation/Networking/Conceptual/CFNetwork/Introduction/Introduction.html#//apple_ref/doc/uid/TP30001132) and [CFNetwork Framework Reference](https://developer.apple.com/reference/cfnetwork). For information about using the NSStream class, see [Foundation Framework Reference](https://developer.apple.com/reference/foundation).

###7.3.1 Tips for Efficient Networking 高效网络的建议

Implementing code to receive or transmit data across the network is one of the most power-intensive operations on a device. Minimizing the amount of time spent transmitting or receiving data helps improve battery life. To that end, you should consider the following tips when writing your network-related code:

- For protocols you control, define your data formats to be as compact as possible.
- Avoid using chatty protocols.
- Transmit data packets in bursts whenever you can.

Cellular and Wi-Fi radios are designed to power down when there is no activity. Depending on the radio, though, doing so can take several seconds. If your app transmits small bursts of data every few seconds, the radios may stay powered up and continue to consume power, even when they are not actually doing anything. Rather than transmit small amounts of data more often, it is better to transmit a larger amount of data once or at relatively large intervals.

When communicating over the network, packets can be lost at any time. Therefore, when writing your networking code, you should be sure to make it as robust as possible when it comes to failure handling. It is perfectly reasonable to implement handlers that respond to changes in network conditions, but do not be surprised if those handlers are not called consistently. For example, the Bonjour networking callbacks may not always be called immediately in response to the disappearance of a network service. The Bonjour system service immediately invokes browsing callbacks when it receives a notification that a service is going away, but network services can disappear without notification. This situation might occur if the device providing the network service unexpectedly loses network connectivity or the notification is lost in transit.

###7.3.2 Using Wi-Fi 使用Wi-Fi

If your app accesses the network using the Wi-Fi radios, you must notify the system of that fact by including the UIRequiresPersistentWiFi key in the app’s Info.plist file. The inclusion of this key lets the system know that it should display the network selection dialog if it detects any active Wi-Fi hot spots. It also lets the system know that it should not attempt to shut down the Wi-Fi hardware while your app is running.

To prevent the Wi-Fi hardware from using too much power, iOS has a built-in timer that turns off the hardware completely after 30 minutes if no running app has requested its use through the UIRequiresPersistentWiFi key. If the user launches an app that includes the key, iOS effectively disables the timer for the duration of the app’s life cycle. As soon as that app quits or is suspended, however, the system reenables the timer.

>**Note:** Note that even when *UIRequiresPersistentWiFi* has a value of true, it has no effect when the device is idle (that is, screen-locked). The app is considered inactive, and although it may function on some levels, it has no Wi-Fi connection.

For more information on the *UIRequiresPersistentWiFi* key and the keys of the Info.plist file, see [The Information Property List File](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/ExpectedAppBehaviors/ExpectedAppBehaviors.html#//apple_ref/doc/uid/TP40007072-CH3-SW5).

###7.3.3 The Airplane Mode Alert 飞行模式警告

If your app launches while the device is in airplane mode, the system may display an alert to notify the user of that fact. The system displays this alert only when all of the following conditions are met:

- Your app’s information property list (*Info.plist*) file contains the *UIRequiresPersistentWiFi* key and the value of that key is set to true.
- Your app launches while the device is currently in airplane mode.
- Wi-Fi on the device has not been manually reenabled after the switch to airplane mode.

##7.4 Improve Your File Management 提升你的文件管理

Minimize the amount of data you write to the disk. File operations are relatively slow and involve writing to the flash drive, which has a limited lifespan. Some specific tips to help you minimize file-related operations include:

- Write only the portions of the file that changed, and aggregate changes when you can. Avoid writing out the entire file just to change a few bytes.
- When defining your file format, group frequently modified content together to minimize the overall number of blocks that need to be written to disk each time.
- If your data consists of structured content that is randomly accessed, store it in a Core Data persistent store or a SQLite database, especially if the amount of data you are manipulating could grow to more than a few megabytes.

Avoid writing cache files to disk. The only exception to this rule is when your app quits and you need to write state information that can be used to put your app back into the same state when it is next launched.

##7.5 Make App Backups More Efficient 让App备份更有效

Backups occur wirelessly via iCloud or when the user syncs the device with iTunes. During backups, files are transferred from the device to the user’s computer or iCloud account. The location of files in your app sandbox determines whether or not those files are backed up and restored. If your application creates many large files that change regularly and puts them in a location that is backed up, backups could be slowed down as a result. As you write your file-management code, you need to be mindful of this fact.

###7.5.1 App Backup Best Practices App备份的最佳实践

You do not have to prepare your app in any way for backup and restore operations. Devices with an active iCloud account have their app data backed up to iCloud at appropriate times. For devices that are plugged into a computer, iTunes performs an incremental backup of the app’s data files. However, iCloud and iTunes do not back up the contents of the following directories:

- \<Application_Home>/AppName.app
- \<Application_Data>/Library/Caches
- \<Application_Data>/tmp

To prevent the syncing process from taking a long time, be selective about where you place files inside your app’s home directory. Apps that store large files can slow down the process of backing up to iTunes or iCloud. These apps can also consume a large amount of a user's available storage, which may encourage the user to delete the app or disable backup of that app's data to iCloud. With this in mind, you should store app data according to the following guidelines:

- Critical data should be stored in the <Application_Data>/Documents directory. Critical data is any data that cannot be recreated by your app, such as user documents and other user-generated content.

- Support files include files your application downloads or generates and that your application can recreate as needed. The location for storing your application’s support files depends on the current iOS version.

  - In iOS 5.1 and later, store support files in the <Application_Data>/Library/Application Support directory and add the [NSURLIsExcludedFromBackupKey](https://developer.apple.com/reference/foundation/urlresourcekey/1408756-isexcludedfrombackupkey) attribute to the corresponding NSURL object using the [setResourceValue:forKey:error:](https://developer.apple.com/reference/foundation/nsurl/1413819-setresourcevalue) method. (If you are using Core Foundation, add the [kCFURLIsExcludedFromBackupKey](https://developer.apple.com/reference/corefoundation/kcfurlisexcludedfrombackupkey) key to your CFURLRef object using the [CFURLSetResourcePropertyForKey](https://developer.apple.com/reference/corefoundation/1541607-cfurlsetresourcepropertyforkey) function.) Applying this attribute prevents the files from being backed up to iTunes or iCloud. If you have a large number of support files, you may store them in a custom subdirectory and apply the extended attribute to just the directory.
  - In iOS 5.0 and earlier, store support files in the <Application_Data>/Library/Caches directory to prevent them from being backed up. If you are targeting iOS 5.0.1, see [How do I prevent files from being backed up to iCloud and iTunes?](https://developer.apple.com/library/content/qa/qa1719/_index.html#//apple_ref/doc/uid/DTS40011342) for information about how to exclude files from backups.

- Cached data should be stored in the <Application_Data>/Library/Caches directory. Examples of files you should put in the Caches directory include (but are not limited to) database cache files and downloadable content, such as that used by magazine, newspaper, and map apps. Your app should be able to gracefully handle situations where cached data is deleted by the system to free up disk space.

- Temporary data should be stored in the <Application_Data>/tmp directory. Temporary data comprises any data that you do not need to persist for an extended period of time. Remember to delete those files when you are done with them so that they do not continue to consume space on the user's device.

Although iTunes backs up the app bundle itself, it does not do this during every sync operation. Apps purchased directly from a device are backed up when that device is next synced with iTunes. Apps are not backed up during subsequent sync operations, though, unless the app bundle itself has changed (because the app was updated, for example).

For additional guidance about how you should use the directories in your app, see [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672).

###7.5.2 Files Saved During App Updates 在App更新时保存文件

When a user downloads an app update, iTunes installs the update in a new app directory. It then moves the user’s data files from the old installation over to the new app directory before deleting the old installation. Files in the following directories are guaranteed to be preserved during the update process:

- \<Application_Data>/Documents
- \<Application_Data>/Library

Although files in other user directories may also be moved over, you should not rely on them being present after an update.

##7.6 Move Work off the Main Thread 将工作移出主线程

Be sure to limit the type of work you do on the main thread of your app. The main thread is where your app handles touch events and other user input. To ensure that your app is always responsive to the user, you should never use the main thread to perform long-running or potentially unbounded tasks, such as tasks that access the network. Instead, you should always move those tasks onto background threads. The preferred way to do so is to use Grand Central Dispatch (GCD) or [NSOperation](https://developer.apple.com/reference/foundation/nsoperation) objects to perform tasks asynchronously.

Moving tasks into the background leaves your main thread free to continue processing user input, which is especially important when your app is starting up or quitting. During these times, your app is expected to respond to events in a timely manner. If your app’s main thread is blocked at launch time, the system could kill the app before it even finishes launching. If the main thread is blocked at quitting time, the system could similarly kill the app before it has a chance to write out crucial user data.

For more information about using GCD, operation objects, and threads, see [Concurrency Programming Guide](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091).