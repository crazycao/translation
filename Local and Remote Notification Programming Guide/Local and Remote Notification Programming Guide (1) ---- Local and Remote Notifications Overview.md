# Local and Remote Notification Programming Guide

原文链接：
[https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/index.html#//apple_ref/doc/uid/TP40008194-CH3-SW1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/index.html#//apple_ref/doc/uid/TP40008194-CH3-SW1)

# 1 Notifications in your App - App中的通知

## 1.1 Local and Remote Notifications Overview - 本地和远程通知概览

Local notifications and remote notifications are ways to inform users when new data becomes available for your app, even when your app is not running in the foreground. For example, a messaging app might let the user know when a new message has arrived, and a calendar app might inform the user of an upcoming appointment. The difference between local and remote notifications is straightforward:

- With *local notifications*, your app configures the notification details locally and passes those details to the system, which then handles the delivery of the notification when your app is not in the foreground. Local notifications are supported on iOS, tvOS, and watchOS. 
- With *remote notifications*, you use one of your company’s servers to push data to user devices via the Apple Push Notification service. Remote notifications are supported on iOS, tvOS, watchOS, and macOS. 

Both local and remote notifications require you to add code to support the scheduling and handling of notifications in your app. For remote notifications, you must also provide a server environment that is capable of receiving data from user devices and sending notification-related data to the *Apple Push Notification service (APNs)*, which is an Apple-provided service that handles the delivery of remote notifications to user devices.

### 1.1.1 The User Notifications and User Notifications UI Frameworks - 用户通知框架和用户通知UI框架

The User Notifications framework provides a consistent way to schedule and handle local notifications starting in iOS 10, watchOS 3, and tvOS 10. In addition to managing local notifications, the framework also supports the handling of remote notifications, although the configuration of remote notifications still requires some platform-specific APIs. Because it is a separate framework, you can use it both from the apps you create and from the extensions you create, such as your WatchKit extension.

>NOTE
>
>The configuration and handling of remote notifications on macOS requires the use of platform-specific methods found in the AppKit framework.

The User Notifications framework also supports the creation of *notification service app extensions*, which let you modify the content of remote notifications before they are delivered. If you include a notification service app extension with your app, the system passes incoming notifications to your extension before delivering them to the user. You might use this type of extension to implement end-to-end encryption for your app’s notifications, to modify the notification content before delivery, or to download additional images or media related to the notification.

The User Notifications UI framework is a companion to the User Notifications framework that lets you customize the appearance of the system’s notification interface. You use the User Notifications UI framework to define a *notification content app extension*, whose job is to provide a view controller with custom content to display in the notification interface. The system displays your custom view controller instead of the default system interface. You might use this type of extension to incorporate media or dynamic content into your notification interfaces.

For more information about the classes of the User Notifications framework, see [*User Notifications Framework Reference*](https://developer.apple.com/reference/usernotifications). For information about the classes you use to create a notification content app extension, see [*User Notifications UI Framework Reference*](https://developer.apple.com/reference/usernotificationsui).

### 1.1.2 When to Use Local and Remote Notifications - 何时使用本地和远程通知

Because apps on iOS, tvOS, and watchOS are not always running, local notifications provide a way to alert the user when your app has new information to present. For example, an app that pulls data from a server in the background can schedule a local notification when some interesting piece of information is received. Local notifications are also well suited for apps such as calendar and to-do list apps that need to alert the user at a specific time or when a specific geographic location is reached.

Remote notifications are appropriate when some or all of the app’s data is managed by your company’s servers. With remote notifications, you decide when you want to push a notification to the user’s device. For example, a messaging app would use remote notifications to let users know when new messages arrive. Because they are sent from your server, you can send remote notifications at any time, including when the app is not running on the user’s device.

### 1.1.3 Local and Remote Notifications Look the Same to Users - 本地和远程通知在用户看来是一样的

To the user, there is no difference between a local and remote notification when presented on a given device. Both types of notifications have the same default appearance, which is provided by the system. You can customize the appearance in some cases, but mostly you choose how you want the user to be notified. Specifically, you choose one of the following options for delivering the notification:

- An onscreen alert or banner 
- A badge on your app’s icon 
- A sound that accompanies an alert, banner, or badge 

When configuring local and remote notifications, choose the interaction type that is most appropriate for the type of information you are delivering. For example, a to-do list app might have a list of items, each of which has a time when the item must be completed and a priority. For high-priority items, you might display an alert when the completion time passes to let the user know that they should act on the item right away. For lower-priority items, you might apply a badge to the app’s icon or play a sound to provide a more subtle reminder to complete the item.

Alerts let you display messages directly to the user, but the meaning of badges and sounds depends on your app. You might use different sounds to communicate specific types of events, such as the arrival of a message or the completion of a task. Badges always contain a numerical value and are commonly used to indicate the number of items that await the user’s attention. Figure 1-1 shows the positioning of a badge on the icon of an iOS app.

**Figure 1-1**An app icon with a badge number (iOS)

![1-1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/badged_app_2x.png)

Always use local and remote notifications judiciously to avoid annoying the user. The system lets users enable and disable the presentation of alerts, sounds, and badges on a per-app basis. Although notifications may still be delivered to your app, the system notifies the user only with the currently enabled options. If the user disables notifications altogether, APNs does not deliver your app’s notifications to the user’s device and the scheduling of local notifications always fails.

## 1.2 Managing Your App’s Notification Support - 管理应用的通知支持

Apps must be configured at launch time to support local and remote notifications. Specifically, you must configure your app in advance if it does any of the following:

- Displays alerts, play sounds, or badges its icon in response to an arriving notification. 
- Displays custom action buttons with a notification. 

Typically, you perform all of your configuration before your application finishes launching. In iOS and tvOS, this means configuring your notification support no later than the [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) method of your UIApplication delegate. In watchOS, configure that support no later than the [applicationDidFinishLaunching](https://developer.apple.com/reference/watchkit/wkextensiondelegate/1628241-applicationdidfinishlaunching) method of your WKExtension delegate. You may perform this configuration at a later time, but you must avoid scheduling any local or remote notifications targeting your app until this configuration is complete.

Apps that support remote notifications require additional configuration, which is described in [Configuring Remote Notification Support](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW1).

### 1.2.1 Requesting Authorization to Interact with the User - 请求与用户交互的授权

In iOS, tvOS, and watchOS, apps must have authorization to display alerts, play sounds, or badge the app’s icon in response to incoming notifications. Requesting authorization puts control of those interactions in the hands of the user, who can grant or deny your request. The user can also change the authorization settings for your app later in the system settings.

To request authorization, call the [requestAuthorizationWithOptions:completionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649527-requestauthorizationwithoptions) method of the shared UNUserNotificationCenter object. If your app is authorized for all of the requested interaction types, the system calls your completion handler block with the granted parameter set to YES. If one or more interaction type is disallowed, the parameter is NO. Listing 2-1 shows how to request authorization to play sounds and display alerts. Use the completion handler block to update your app’s behaviors based on whether the interaction types were granted or denied.

**Listing 2-1**Requesting authorization for user interactions

```
OBJECTIVE-C

	UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
	[center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
	   completionHandler:^(BOOL granted, NSError * _Nullable error) {
	      // Enable or disable features based on authorization.
	}];

SWIFT

	let center = UNUserNotificationCenter.current()
	center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
	    // Enable or disable features based on authorization.
	}
```

The first time that your app launches and calls the [requestAuthorizationWithOptions:completionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649527-requestauthorizationwithoptions) method, the system prompts the user to grant or deny the requested interactions. Because the system saves the user’s response, calls to this method during subsequent launches do not prompt the user again.

>NOTE
>
>The user can change the authorized interaction types for your app at any time using system settings. To determine precisely which types of interactions that you can use, call the [getNotificationSettingsWithCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649524-getnotificationsettingswithcompl) method of UNUserNotificationCenter.

### 1.2.2 Configuring Categories and Actionable Notifications - 配置类别和可操作的通知

Actionable notifications give the user a quick and easy way to perform relevant tasks in response to a notification. Instead of the user being forced to launch your app, the interface for an actionable notification displays custom action buttons that the user can tap. When tapped, each button dismisses the notification interface and forwards the selected action to your app for immediate handling. Forwarding the action to your app avoids the need for the user to navigate further in your app to perform the action, thereby saving time.

Apps must explicitly add support for actionable notifications. At launch time, apps must register one or more categories, which define the types of notifications that your app sends. Associated with each category are the actions that the user can perform when a notification of that type is delivered. Each category can have up to four actions associated with it, although the number of actions actually displayed depends on how and where the notification is displayed. For example, banners display no more than two actions.

>NOTE
>
>Actionable notifications are supported only on iOS and watchOS.

#### 1.2.2.1 Registering the Notification Categories for Your App - 为你的程序注册通知类别

Categories define the types of notifications that your app supports and communicate to the system how you want a notification to be presented. You use categories to associate custom actions with a notification and to specify options for how to handle notifications of that type. For example, you use the category options to specify whether the notification can be displayed in a CarPlay environment.

At launch time, you register all of your app’s categories at once using the [setNotificationCategories:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649512-setnotificationcategories) method of the shared [UNUserNotificationCenter](https://developer.apple.com/reference/usernotifications/unusernotificationcenter) object. Before calling that method, you create one or more instances of the [UNNotificationCategory](https://developer.apple.com/reference/usernotifications/unnotificationcategory) class and specify the category name and options to use when displaying notifications of that type. Category names are internal to your app and are never seen by the user. When scheduling notifications, you include the category name in the notification’s payload, which the system then uses to retrieve the options and display the notification.

Listing 2-2 shows how to create a simple [UNNotificationCategory](https://developer.apple.com/reference/usernotifications/unnotificationcategory) object and register it with the system. This category has the name “GENERAL” and is configured with a custom dismiss action option, which causes the system to notify the app when the user dismisses the notification interface without taking any other actions.

**Listing 2-2**Creating and registering a notification category

```
OBJECTIVE-C

	UNNotificationCategory* generalCategory = [UNNotificationCategory
	     categoryWithIdentifier:@"GENERAL"
	     actions:@[]
	     intentIdentifiers:@[]
	     options:UNNotificationCategoryOptionCustomDismissAction];
	 
	// Register the notification categories.
	UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
	[center setNotificationCategories:[NSSet setWithObjects:generalCategory, nil]];

SWIFT

	let generalCategory = UNNotificationCategory(identifier: "GENERAL",
	                                             actions: [],
	                                             intentIdentifiers: [],
	                                             options: .customDismissAction)
	 
	// Register the category.
	let center = UNUserNotificationCenter.current()
	center.setNotificationCategories([generalCategory])
```

You are not required to assign a category to all of the notifications that you schedule from your app. However, if you do not include a category, your notification is displayed without any custom actions or configuration options.

#### 1.2.2.2 Adding Custom Actions to Your Categories - 向你的类别添加自定义操作

Each of the categories you register may contain up to four custom actions. When a category contains custom actions, the system adds buttons to the notification interface, each with the title of one of your custom actions. If the user taps one of your custom actions, the system sends the corresponding action identifier to your app, launching your app as needed.

To define a custom action, create a [UNNotificationAction](https://developer.apple.com/reference/usernotifications/unnotificationaction) object and add it to one of your category objects. Each action contains the title string for the corresponding button and options for how to display the button and process the associated task. When the user selects an action, the system provides your app with the action’s identifier string, which you then use to identify the task to perform. Listing 2-3 extends the example in Listing 2-2 by adding a new category with two custom actions.

**Listing 2-3**Defining custom actions for a category

```
OBJECTIVE-C

	UNNotificationCategory* generalCategory = [UNNotificationCategory
	      categoryWithIdentifier:@"GENERAL"
	      actions:@[]
	      intentIdentifiers:@[]
	      options:UNNotificationCategoryOptionCustomDismissAction];
	 
	// Create the custom actions for expired timer notifications.
	UNNotificationAction* snoozeAction = [UNNotificationAction
	      actionWithIdentifier:@"SNOOZE_ACTION"
	      title:@"Snooze"
	      options:UNNotificationActionOptionNone];
	 
	UNNotificationAction* stopAction = [UNNotificationAction
	      actionWithIdentifier:@"STOP_ACTION"
	      title:@"Stop"
	      options:UNNotificationActionOptionForeground];
	 
	// Create the category with the custom actions.
	UNNotificationCategory* expiredCategory = [UNNotificationCategory
	      categoryWithIdentifier:@"TIMER_EXPIRED"
	      actions:@[snoozeAction, stopAction]
	      intentIdentifiers:@[]
	      options:UNNotificationCategoryOptionNone];
	 
	// Register the notification categories.
	UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
	[center setNotificationCategories:[NSSet setWithObjects:generalCategory, expiredCategory,
	      nil]];

SWIFT

	let generalCategory = UNNotificationCategory(identifier: "GENERAL",
	                                             actions: [],
	                                             intentIdentifiers: [],
	                                             options: .customDismissAction)
	 
	// Create the custom actions for the TIMER_EXPIRED category.
	let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
	                                        title: "Snooze",
	                                        options: UNNotificationActionOptions(rawValue: 0))
	let stopAction = UNNotificationAction(identifier: "STOP_ACTION",
	                                      title: "Stop",
	                                      options: .foreground)
	 
	let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
	                                             actions: [snoozeAction, stopAction],
	                                             intentIdentifiers: [],
	                                             options: UNNotificationCategoryOptions(rawValue: 0))
	 
	// Register the notification categories.
	let center = UNUserNotificationCenter.current()
	center.setNotificationCategories([generalCategory, expiredCategory])
```

Although you may specify up to four custom actions for each category, the system may display only the first two actions in some circumstances. For example, the system displays only two actions when displaying the notification in a banner. When initializing your [UNNotificationCategory](https://developer.apple.com/reference/usernotifications/unnotificationcategory) objects, always configure the array of actions so that the most relevant actions are first in the array.

If you configure an action using the [UNTextInputNotificationAction](https://developer.apple.com/reference/usernotifications/untextinputnotificationaction) class, the system provides a way for the user to enter text as part of the notification response. Text input actions are useful for gathering free form text from the user. For example, a message app could allow the user to provide a custom response to a message. When a text input action is delivered to your app to handle, the system packages the user’s response in a [UNTextInputNotificationResponse](https://developer.apple.com/reference/usernotifications/untextinputnotificationresponse) object.

For information about how to handle the selection of a custom action, see [Responding to the Selection of a Custom Action](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html#//apple_ref/doc/uid/TP40008194-CH5-SW2).

### 1.2.3 Preparing Custom Alert Sounds - 准备自定义的提醒铃声

Local and remote notifications can specify custom alert sounds to be played when the notification is delivered. You can package the audio data in an aiff, wav, or caf file. Because they are played by the system-sound facility, custom sounds must be in one of the following audio data formats:

- Linear PCM 
- MA4 (IMA/ADPCM) 
- µLaw 
- aLaw 

Place custom sound files in your app bundle or in the Library/Sounds folder of your app’s container directory. Custom sounds must be under 30 seconds when played. If a custom sound is over that limit, the default system sound is played instead.

You can use the afconvert tool to convert sounds. For example, to convert the 16-bit linear PCM system sound Submarine.aiff to IMA4 audio in a CAF file, use the following command in the Terminal app:

	afconvert /System/Library/Sounds/Submarine.aiff ~/Desktop/sub.caf -d ima4 -f caff -v

For information on how to associate a sound file with a notification, see [Adding a Sound to the Notification Content](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html#//apple_ref/doc/uid/TP40008194-CH5-SW3).

### 1.2.4 Managing Your App’s Notification Settings - 管理你程序的通知设置

Because users can change the notification settings for your app at any time, you can use the [getNotificationSettingsWithCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649524-getnotificationsettingswithcompl) method of the shared UNUserNotificationCenter object to get your app’s authorization status at any time. That method returns a UNNotificationSettings object whose contents reflect your app’s current authorization status and the current notification environment.

Use the information in the [UNNotificationSettings](https://developer.apple.com/reference/usernotifications/unnotificationsettings) object to adjust your app’s notification-related code. You can communicate your app’s alert, badge, and sound authorization settings to your provider so that it can adjust the options it includes in any remote notification payloads. (A *provider* is a server, that you deploy and manage, that you configure to work with APNs. For more on providers, see [APNs Overview](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1).) You can use other settings to adjust how you schedule and configure notifications. For more information about the available settings, see [*UNNotificationSettings Class Reference*](https://developer.apple.com/reference/usernotifications/unnotificationsettings).

### 1.2.5 Managing Delivered Notifications - 管理已发送的通知

When local and remote notifications are not handled directly by your app or the user, they are displayed in Notification Center so that they can be viewed later. Use the [getDeliveredNotificationsWithCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649520-getdeliverednotifications) method of the shared UNUserNotificationCenter object to get a list of notifications still being displayed in Notification Center. If you find any notifications that are now outdated and should not be displayed to the user, you can remove them using the [removeDeliveredNotificationsWithIdentifiers:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649500-removedeliverednotifications) method.

## 1.3 Scheduling and Handling Local Notifications - 安排和处理本地通知

Local notifications give you a way to alert the user at times when your app might not be running. You schedule local notifications at a time when your app is running either in the foreground or background. After scheduling a notification, the system takes on the responsibility of delivering the notification to the user at the appropriate time. Your app does not need to be running for the system to deliver the notification.

本地通知给你提供了一种方式可以在某些时候提醒用户，那时你的APP可能没有运行。你可以在应用程序在前台或后台运行时安排本地通知。在安排通知后，系统负责在适当的时间向用户发送通知。系统无需运行应用程序即可发送通知。

If your app is not running, or if it is in the background, the system displays local notifications directly to the user. The system can alert the user with an alert panel or banner, with a sound, or by badging your app’s icon. If your app provides a notification content app extension, the system can even use your custom interface to alert the user. If your app is in the foreground when a notification arrives, the system gives your app the opportunity to handle the notification internally.

如果您的应用程序未运行，或者处于后台，系统将直接向用户显示本地通知。系统可以通过警告板或横幅来通知用户，带有声音或者在APP图标上标记。如果您的应用程序提供通知内容应用程序扩展，系统甚至可以使用您的自定义界面向用户发出提醒。当通知到达时，如果您的应用程序位于前台，则系统将为您的APP提供一个在内部处理通知的机会。

>NOTE
>
>Local notifications are supported only in iOS, watchOS, and tvOS. In macOS, apps do not require local notifications to badge their icon, play sounds, or display alerts while running in the background. Those capabilities are already supported by the AppKit framework.
>
>注意
>
>本地通知只在 iOS、watchOS 和 tvOS 上支持。在 macOS 上，APP不需要本地通知来标记它们的图标、播放声音或者在后台运行时展示提醒。这些能力都已经在 AppKit 框架中支持了。

### 1.3.1 Configuring a Local Notification - 配置本地通知

The steps for configuring a local notification are as follows:

1. Create and configure a [UNMutableNotificationContent](https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent) object with the notification details. 
2. Create a [UNCalendarNotificationTrigger](https://developer.apple.com/reference/usernotifications/uncalendarnotificationtrigger), [UNTimeIntervalNotificationTrigger](https://developer.apple.com/reference/usernotifications/untimeintervalnotificationtrigger), or [UNLocationNotificationTrigger](https://developer.apple.com/reference/usernotifications/unlocationnotificationtrigger) object to describe the conditions under which the notification is delivered. 
3. Create a [UNNotificationRequest](https://developer.apple.com/reference/usernotifications/unnotificationrequest) object with the content and trigger information. 
4. Call the [addNotificationRequest:withCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649508-addnotificationrequest) method to schedule the notification; see [**Scheduling Local Notifications for Delivery**](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html#//apple_ref/doc/uid/TP40008194-CH5-SW5)

When creating the content for a notification, fill in the properties of the UNMutableNotificationContent object that reflect the type of interaction you want with the user. For example, fill in the [title](https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent/1649858-title) and [body](https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent/1649874-body) properties when you want to display an alert. The system uses the information you provide to determine how to interact with the user. You can also use the data in this object when handling a local notification that has been delivered to your app.

After creating the notification content, create a trigger object that defines when to deliver the notification. The User Notifications framework provides both time-based and location-based triggers. Configure the trigger with the required conditions and use that object plus your content to create the UNNotificationRequest object.

Listing 3-1 shows how to create and configure a local notification related to an alarm. The use of a UNCalendarNotificationTrigger causes the notification to be delivered at a specific date or time, which in this example is the next time the clock reaches 7:00 in the morning.

**Listing 3-1**Creating and configuring a local notification

```
OBJECTIVE-C

	UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
	content.title = [NSString localizedUserNotificationStringForKey:@"Wake up!" arguments:nil];
	content.body = [NSString localizedUserNotificationStringForKey:@"Rise and shine! It's morning time!"
	        arguments:nil];
	 
	// Configure the trigger for a 7am wakeup.
	NSDateComponents* date = [[NSDateComponents alloc] init];
	date.hour = 7;
	date.minute = 0;
	UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger
	       triggerWithDateMatchingComponents:date repeats:NO];
	 
	// Create the request object.
	UNNotificationRequest* request = [UNNotificationRequest
	       requestWithIdentifier:@"MorningAlarm" content:content trigger:trigger];

SWIFT

	let content = UNMutableNotificationContent()
	content.title = NSString.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
	content.body = NSString.localizedUserNotificationString(forKey: "Rise and shine! It's morning time!",
	                                                        arguments: nil)
	 
	// Configure the trigger for a 7am wakeup.
	var dateInfo = DateComponents()
	dateInfo.hour = 7
	dateInfo.minute = 0
	let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
	 
	// Create the request object.
	let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
```

Providing an identifier for the UNNotificationRequest object gives you a way to identify local notifications after they have been scheduled. You can use identifiers to look up pending requests later and to cancel them before they are delivered. For more information on scheduling and canceling requests, see Scheduling Local Notifications for Delivery.

#### 1.3.1.1 Assigning Custom Actions to a Local Notification - 给本地通知指派自定义操作

To display custom actions in the interface for a local notification, assign one of your registered category identifiers to the [categoryIdentifier](https://developer.apple.com/reference/usernotifications/unnotificationcontent/1649866-categoryidentifier) property of your [UNMutableNotificationContent](https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent) object during configuration. The system uses the category information to determine which action buttons, if any, to include in the notification interface. You must assign a value to this property before scheduling the notification request.

Listing 3-2 shows how to specify the category identifier for a local notification. In this example, the “TIMER_EXPIRED” string represents a category that was defined at launch time and that includes two custom actions. The code for registering this category is shown in [Listing 2-3](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SupportingNotificationsinYourApp.html#//apple_ref/doc/uid/TP40008194-CH4-SW4).

**Listing 3-2**Defining a category of actions for a local notification

```
OBJECTIVE-C

	UNNotificationContent *content = [[UNNotificationContent alloc] init];
	// Configure the content. . .
	 
	// Assign the category (and the associated actions).
	content.categoryIdentifier = @"TIMER_EXPIRED";
	 
	// Create the request and schedule the notification.

SWIFT

	let content = UNMutableNotificationContent()
	// Configure the content. . .
	 
	// Assign the category (and the associated actions).
	content.categoryIdentifier = "TIMER_EXPIRED"
	 
	// Create the request and schedule the notification.
```

For information on how to register custom actions with a category, see [Configuring Categories and Actionable Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SupportingNotificationsinYourApp.html#//apple_ref/doc/uid/TP40008194-CH4-SW26)

#### 1.3.1.2 Adding a Sound to the Notification Content - 给通知内容添加一个声音

If you want a local notification to play a sound when it is delivered, assign a value to the [sound](https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent/1649868-sound) property of your UNMutableNotificationContent object. You specify sounds using a [UNNotificationSound](https://developer.apple.com/reference/usernotifications/unnotificationsound) object, which lets you play either a custom sound or the default notification sound. Custom sounds must reside locally on the user’s device before they can be played. Store the sound files for your notifications in your app’s main bundle or download them and store them in the Library/Sounds subdirectory of your app’s container directory.

To play the default sound, create the sound file and assign it to your notification content. For example:

```
OBJECTIVE-C

	content.sound = [UNNotificationSound defaultSound];

SWIFT

	content.sound = UNNotificationSound.default()
```

When specifying custom sounds, specify only the filename of the sound file that you want played. If the system finds a suitable sound file with the name you provided, it plays that sound when delivering the notification. If the system does not find a suitable sound file, it plays the default sound.

```
OBJECTIVE-C

	content.sound = [UNNotificationSound soundNamed:@"MySound.aiff"];

SWIFT

	content.sound = UNNotificationSound(named: "MySound.aiff")
```

For information about the supported sound file formats, see [*UNNotificationSound Class Reference*](https://developer.apple.com/reference/usernotifications/unnotificationsound).

### 1.3.2 Scheduling Local Notifications for Delivery - 安排本地通知的发送

To schedule a local notification for delivery, create your [UNNotificationRequest](https://developer.apple.com/reference/usernotifications/unnotificationrequest) object and call the [addNotificationRequest:withCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649508-addnotificationrequest) method of UNUserNotificationCenter. The system schedules local notifications asynchronously, calling your completion handler block when scheduling is complete or when an error occurs. Listing 3-3 shows how to schedule a local notification for delivery. The code in this example completes the scheduling of the notification created in Listing 3-1.

**Listing 3-3**Scheduling a local notification for delivery

```
OBJECTIVE-C

	// Create the request object.
	UNNotificationRequest* request = [UNNotificationRequest
	       requestWithIdentifier:@"MorningAlarm" content:content trigger:trigger];
	 
	UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
	[center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
	   if (error != nil) {
	       NSLog(@"%@", error.localizedDescription);
	   }
	}];

SWIFT

	// Create the request object.
	let request = UNNotificationRequest(identifier: "MorningAlarm", content: content, trigger: trigger)
	 
	// Schedule the request.
	let center = UNUserNotificationCenter.current()
	center.add(request) { (error :  a href="" Error /a ?) in
	    if let theError = error {
	        print(theError.localizedDescription)
	    }
	}
```

Scheduled local notifications remain active until they are unscheduled by the system or until you cancel them explicitly. The system unschedules notifications automatically after they are delivered, unless the notification’s trigger is configured to repeat. To cancel an individual notification before it is delivered, or to cancel a repeating notification, call the [removePendingNotificationRequestsWithIdentifiers:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649517-removependingnotificationrequest) method of UNUserNotificationCenter. The notification being canceled must have an [identifier](https://developer.apple.com/reference/usernotifications/unnotificationrequest/1649634-identifier) assigned to its [UNNotificationRequest](https://developer.apple.com/reference/usernotifications/unnotificationrequest) object. To cancel all pending local notifications, regardless of whether they have a request identifier, call the [removeAllPendingNotificationRequests](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649509-removeallpendingnotificationrequ) method instead.

### 1.3.3 Responding to the Delivery of Notifications - 响应通知的发送

When your app is not running or is in the background, the system automatically delivers local and remote notifications using the interactions you specified. If the user selects an action, or chooses one of the standard interactions, the system notifies your app of the user’s selection. Your code can then use that selection to perform additional tasks. If your app is running in the foreground, notifications are delivered directly to your app. You can then decide whether to handle the notification quietly or alert the user.

To respond to the delivery of notifications, you must implement a delegate for the shared UNUserNotificationCenter object. Your delegate object must conform to the [UNUserNotificationCenterDelegate](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate) protocol, which the notification center uses to deliver notification information to your app. A delegate is required if your notifications contain custom actions.

>IMPORTANT
>
>You must assign your delegate to the shared UNUserNotificationCenter object before your app or app extension finishes launching. Failure to do so may prevent your app from handling notifications correctly.

For additional information on how to implement your delegate object, see [*UNUserNotificationCenterDelegate Protocol Reference*](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate).

#### 1.3.3.1 Handling Notifications When Your App Is in the Foreground - 当你的程序在后台时处理通知

If a notification arrives while your app is in the foreground, you can silence that notification or tell the system to continue to display the notification interface. The system silences notifications for foreground apps by default, delivering the notification’s data directly to your app. You can use the notification data to update your app’s interface directly. For example, if a new sports score arrived, you would just update that information in your interface.

If you want the system to continue to display the notification interface, provide a delegate object for the UNUserNotificationCenter and implement the [userNotificationCenter:willPresentNotification:withCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649518-usernotificationcenter) method. Your implementation of this method should still process the notification data. When finished, execute the provided completion handler block with the delivery option (if any) that you want the system to use. If you do not specify any options, the system silences the notification. Listing 3-4 shows a sample implementation of this method that tells the system to play a sound. The notification’s payload identifies which sound to play.

**Listing 3-4**Playing a sound while your app is in the foreground

```
OBJECTIVE-C

	- (void)userNotificationCenter:(UNUserNotificationCenter *)center
	        willPresentNotification:(UNNotification *)notification
	        withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
	   // Update the app interface directly.
	 
	    // Play a sound.
	   completionHandler(UNNotificationPresentationOptionSound);
	}

SWIFT

	func userNotificationCenter(_ center:  a href="" UNUserNotificationCenter /a ,
	                            willPresent notification:  a href="" UNNotification /a ,
	                            withCompletionHandler completionHandler: @escaping ( a href="" UNNotificationPresentationOptions /a ) ->  a href="" Void /a ) {
	    // Update the app interface directly.
	    
	    // Play a sound.
	    completionHandler(UNNotificationPresentationOptions.sound)
	}
```

The system does not call the userNotificationCenter:willPresentNotification:withCompletionHandler: method when your app is in the background or is not running. In those cases, the system alerts the user according to the information in the notification itself. You can still determine whether a notification was delivered using the [getDeliveredNotificationsWithCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenter/1649520-getdeliverednotifications) method of the UNUserNotificationCenter object.

#### 1.3.3.2 Responding to the Selection of a Custom Action - 响应自定义操作的选择

When the user selects a custom action from the notification interface, the system notifies your app of the user’s choice. Responses to custom actions are packaged in a [UNNotificationResponse](https://developer.apple.com/reference/usernotifications/unnotificationresponse) object and delivered to the delegate of your app’s shared [UNUserNotificationCenter](https://developer.apple.com/reference/usernotifications/unusernotificationcenter) object. To receive responses, your delegate object must implement the [userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter) method. Your implementation of that method must be able to process all of the custom actions supported by your app or app extension.

If your app or app extension is not running when a response is received, the system launches your app or app extension in the background to process the response. Use the provided background time to update your data structures and your app’s interface to reflect the user’s choice. Do not use the time to perform tasks unrelated to the processing of the custom action.

Listing 3-5 shows an implementation of the response handler method for a timer app with multiple categories and custom actions. The implementation uses both the action and the [categoryIdentifier](https://developer.apple.com/reference/usernotifications/unnotificationcontent/1649866-categoryidentifier) property to determine an appropriate course of action.

**Listing 3-5**Handling a custom notification action

```
OBJECTIVE-C

	- (void)userNotificationCenter:(UNUserNotificationCenter *)center
	           didReceiveNotificationResponse:(UNNotificationResponse *)response
	           withCompletionHandler:(void (^)(void))completionHandler {
	    if ([response.notification.request.content.categoryIdentifier isEqualToString:@"TIMER_EXPIRED"]) {
	        // Handle the actions for the expired timer.
	        if ([response.actionIdentifier isEqualToString:@"SNOOZE_ACTION"])
	        {
	            // Invalidate the old timer and create a new one. . .
	        }
	        else if ([response.actionIdentifier isEqualToString:@"STOP_ACTION"])
	        {
	            // Invalidate the timer. . .
	        }
	 
	    }
	 
	    // Else handle actions for other notification types. . .
	}

SWIFT

	func userNotificationCenter(_ center:  a href="" UNUserNotificationCenter /a ,
	                            didReceive response:  a href="" UNNotificationResponse /a ,
	                            withCompletionHandler completionHandler: @escaping () ->  a href="" Void /a ) {
	    if response.notification.request.content.categoryIdentifier == "TIMER_EXPIRED" {
	        // Handle the actions for the expired timer.
	        if response.actionIdentifier == "SNOOZE_ACTION" {
	            // Invalidate the old timer and create a new one. . .
	        }
	        else if response.actionIdentifier == "STOP_ACTION" {
	            // Invalidate the timer. . .
	        }
	    }
	    
	    // Else handle actions for other notification types. . .
	}
```

#### 1.3.3.3 Handling the Standard System Actions - 响应标准系统操作

In the system’s notification interface, users can explicitly dismiss the notification interface or launch your app instead of selecting one of your custom actions. Dismissing the interface involves tapping an applicable button or closing the interface directly; ignoring a notification or flicking a notification banner away does not represent an explicit dismissal. When system actions are triggered, the user notification center reports them to the [userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter) method its delegate. The response object passed to that method contains one of the following action identifiers:

- [UNNotificationDismissActionIdentifier](https://developer.apple.com/reference/usernotifications/unnotificationdismissactionidentifier) lets you know that the user explicitly dismissed the notification interface without selecting a custom action. 
- [UNNotificationDefaultActionIdentifier](https://developer.apple.com/reference/usernotifications/unnotificationdefaultactionidentifier) lets you know that the user launched your app without selecting a custom action. 

You handle the standard system actions in the same way that you handle other actions. Listing 3-6 shows a template for the [userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter) method that checks for these special actions.

**Listing 3-6**Handling the standard system actions

```
OBJECTIVE-C

	- (void)userNotificationCenter:(UNUserNotificationCenter *)center
	          didReceiveNotificationResponse:(UNNotificationResponse *)response
	          withCompletionHandler:(void (^)(void))completionHandler {
	   if ([response.actionIdentifier isEqualToString:UNNotificationDismissActionIdentifier]) {
	       // The user dismissed the notification without taking action.
	   }
	   else if ([response.actionIdentifier isEqualToString:UNNotificationDefaultActionIdentifier]) {
	       // The user launched the app.
	   }
	 
	   // Else handle any custom actions. . .
	}

SWIFT

	func userNotificationCenter(_ center:  a href="" UNUserNotificationCenter /a ,
	                            didReceive response:  a href="" UNNotificationResponse /a ,
	                            withCompletionHandler completionHandler: @escaping () ->  a href="" Void /a ) {
	    if response.actionIdentifier == UNNotificationDismissActionIdentifier {
	        // The user dismissed the notification without taking action
	    }
	    else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
	        // The user launched the app
	    }
	    
	    // Else handle any custom actions. . .
	}
```

## 1.4 Configuring Remote Notification Support - 配置远程通知支持

By supporting remote notifications you can provide up-to-date information to users of your app, even when the app is not running. To be able to receive and handle remote notifications, your app must:

1. Enable remote notifications. 
2. Register with Apple Push Notification service (APNs) and receive an app-specific device token. 
3. Send the device token to your notification provider server. 
4. Implement support for handling incoming remote notifications. 

This chapter explains these steps, all of which you implement in your app. For more about providers, which are servers that you deploy and manage for building and sending notification requests to APNs—read [APNs Overview](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1).

>NOTE
>
>The ability of APNs to deliver remote notifications to a nonrunning app requires the app to have been launched at least once.

On an iOS device, if a user force-quits your app using the app multitasking UI, the app does not receive remote notifications until the user relaunches it.

### 1.4.1 Enabling the Push Notifications Capability - 开启推送通知能力

For an app to handle remote notifications, it must have the proper entitlements to talk to APNs. You add this entitlement to your app using the Capabilities pane of your Xcode project, as described in “[Enable push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073?sub=dev73a37248c)” in Xcode Help.

Apps without required entitlements are rejected during the App Store review process. During testing, trying to register with APNs without the proper entitlement returns an error.

### 1.4.2 Registering to Receive Remote Notifications - 注册以接收远程通知

Each time your app launches, it must register with APNs. The methods to use differ according to the platform, but in all cases it works as follows:

1. Your app asks to be registered with APNs. 
2. On successful registration, APNs sends an app-specific device token to the device. 
3. The system delivers the device to your app by calling a method in your app delegate. 
4. Your app sends the device token to the app’s associated provider. 

For code snippets showing these steps, see Obtaining a Device Token in iOS and tvOS and Obtaining a Device Token in macOS.

An app-specific device token is globally unique and identifies one app-device combination. Upon receiving a device token from APNs in your app, it is your responsibility to open a network connection to your provider. It is also your responsibility, in your app, to then forward the device token along with any other relevant data you want to send to the provider. When the provider later sends remote notification requests to APNs, it must include the device token, along with the notification payload. For more on this, see [APNs Overview](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1).

Never cache device tokens in your app; instead, get them from the system when you need them. APNs issues a new device token to your app when certain events happen. The device token is guaranteed to be different, for example, when a user restores a device from a backup, when the user installs your app on a new device, and when the user reinstalls the operating system. Fetching the token, rather than relying on a cache, ensures that you have the current device token needed for your provider to communicate with APNs. When you attempt to fetch a device token but it has not changed, the fetch method returns quickly.

>IMPORTANT
>
>When a device token has changed, the user must launch your app once before APNs can once again deliver remote notifications to the device.

Apps running on watchOS do not register for remote notifications explicitly. Instead, they rely on their paired iPhone to forward remote notifications for display on the watch. The forwarding of remote notifications happens when the iPhone is locked (or the screen is asleep) and the Apple Watch is on the user’s wrist and unlocked.

For information about the data format for remote notifications and about how to send that data to APNs, see [Communicating with APNs](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW1).

#### 1.4.2.1 Obtaining a Device Token in iOS and tvOS - 在iOS和tvOS上获取设备令牌

In iOS and tvOS, you initiate APNs registration for your app by calling the [registerForRemoteNotifications](https://developer.apple.com/reference/uikit/uiapplication/1623078-registerforremotenotifications) method of the UIApplication object. Call this method at launch time as part of your normal startup sequence. The first time your app calls this method, the app object contacts APNs and requests the app-specific device token on your behalf. The system then asynchronously calls one of two following app delegate methods, depending on success or failure:

- On successful issuance of an app-specific device token, the system calls the [application:didRegisterForRemoteNotificationsWithDeviceToken:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622958-application) method. Implement this method to receive the token and forward it to your provider. 
- On error, the system calls the [application:didFailToRegisterForRemoteNotificationsWithError:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622962-application) method. Implement this method to respond to APNs registration errors. 

> IMPORTANT
>
>APNs device tokens are of variable length. Do not hard-code their size.

After successful APNs registration, the app object contacts APNs only when the device token has changed; otherwise, calling the registerForRemoteNotifications method results in a call to the application:didRegisterForRemoteNotificationsWithDeviceToken: method which returns the existing token quickly.

>NOTE
>
>If the device token changes while your app is running, the app object calls the application:didRegisterForRemoteNotificationsWithDeviceToken: delegate method again to notify you of the change.

Listing 4-1 shows how to fetch the device token for your iOS or tvOS app. The app delegate calls the registerForRemoteNotifications method as part of its regular launch-time setup. Upon receiving the device token, the application:didRegisterForRemoteNotificationsWithDeviceToken: method forwards it to the app’s associated provider using a custom method. If an error occurs during registration, the app temporarily disables any features related to remote notifications. Those features are reenabled when a valid device token is received.

**Listing 4-1**Registering for remote notifications in iOS

```
OBJECTIVE-C

	- (void)applicationDidFinishLaunching:(UIApplication *)app {
	    // Configure the user interactions first.
	    [self configureUserInteractions];
	 
	   // Register for remote notifications.
	    [[UIApplication sharedApplication] registerForRemoteNotifications];
	}
	 
	// Handle remote notification registration.
	- (void)application:(UIApplication *)app
	        didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	    // Forward the token to your provider, using a custom method.
	    [self enableRemoteNotificationFeatures];
	    [self forwardTokenToServer:devTokenBytes];
	}
	 
	- (void)application:(UIApplication *)app
	        didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
	    // The token is not currently available.
	    NSLog(@"Remote notification support is unavailable due to error: %@", err);
	    [self disableRemoteNotificationFeatures];
	}

SWIFT

	func application(_ application:  a href="" UIApplication /a ,
	                 didFinishLaunchingWithOptions launchOptions: [ a href="" UIApplicationLaunchOptionsKey /a : Any]?) ->  a href="" Bool /a  {
	    // Configure the user interactions first.
	    self.configureUserInteractions()
	    
	    // Register with APNs
	    UIApplication.shared.registerForRemoteNotifications()
	}
	 
	// Handle remote notification registration.
	func application(_ application:  a href="" UIApplication /a ,
	                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken:  a href="" Data /a ){
	    // Forward the token to your provider, using a custom method.
	    self.enableRemoteNotificationFeatures()
	    self.forwardTokenToServer(token: deviceToken)
	}
	 
	func application(_ application:  a href="" UIApplication /a ,
	                 didFailToRegisterForRemoteNotificationsWithError error:  a href="" Error /a ) {
	    // The token is not currently available.
	    print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
	    self.disableRemoteNotificationFeatures()
	}
```

If a cellular or Wi-Fi connection is not available, neither the [application:didRegisterForRemoteNotificationsWithDeviceToken:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622958-application) method nor the [application:didFailToRegisterForRemoteNotificationsWithError:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622962-application) method is called. For Wi-Fi connections, this sometimes occurs when the device cannot connect with APNs over the configured port. If this happens, the user can move to another Wi-Fi network that isn’t blocking the required port. On devices with a cellular radio, the user can also wait until the cellular data service becomes available.

In your application:didFailToRegisterForRemoteNotificationsWithError: implementation, use the error object to disable any features related to remote notifications. Because notifications are not going to be arriving anyway, it is better to degrade gracefully and avoid any local work needed to facilitate remote notifications. If remote notifications become available later, the app object notifies you by calling your delegate’s application:didRegisterForRemoteNotificationsWithDeviceToken: method.

#### 1.4.2.2 Obtaining a Device Token in macOS - 在macOS上获取设备令牌

In macOS, you obtain a device token for your app by calling the [registerForRemoteNotificationTypes:](https://developer.apple.com/reference/appkit/nsapplication/1428476-registerforremotenotificationtyp) method of the NSApplication object. It is recommended that you call this method at launch time as part of your normal startup sequence. The first time your app calls this method, the app object requests the token from APNs. After the initial call, the app object contacts APNs only when the device token changes; otherwise, it returns the existing token quickly.

The app object notifies its delegate asynchronously upon the successful or unsuccessful retrieval of the device token. You use these delegate callbacks to process the device token or to handle any errors that arose. You must implement the following delegate methods to track whether registration was successful:

- Use the [application:didRegisterForRemoteNotificationsWithDeviceToken:](https://developer.apple.com/reference/appkit/nsapplicationdelegate/1428766-application) to receive the device token and forward it to your provider. 
- Use the [application:didFailToRegisterForRemoteNotificationsWithError:](https://developer.apple.com/reference/appkit/nsapplicationdelegate/1428554-application) to respond to errors. 

>NOTE
>
>If the device token changes while your app is running, the app object calls the appropriate delegate method again to notify you of the change.

Listing 4-2 shows how to fetch the device token for your macOS app. The app delegate calls the registerForRemoteNotificationTypes: method as part of its regular launch-time setup, passing along the types of interactions that you intend to use. Upon receiving the device token, the application:didRegisterForRemoteNotificationsWithDeviceToken: method forwards it to the app’s associated provider using a custom method. If an error occurs during registration, the app temporarily disables any features related to remote notifications. Those features are reenabled when a valid device token is received.

**Listing 4-2**Registering for remote notifications in macOS

```
OBJECTIVE-C

		- (void)applicationDidFinishLaunching:(NSNotification *)notification {
		    // Configure the user interactions first.
		    [self configureUserInteractions];
		 
		    [NSApp registerForRemoteNotificationTypes:(NSRemoteNotificationTypeAlert | NSRemoteNotificationTypeSound)];
		}
		 
		- (void)application:(NSApplication *)application
		        didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
		    // Forward the token to your provider, using a custom method.
		    [self forwardTokenToServer:deviceToken];
		}
		 
		- (void)application:(NSApplication *)application
		        didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
		    NSLog(@"Remote notification support is unavailable due to error: %@", error);
		    [self disableRemoteNotificationFeatures];
		}
	
	SWIFT
	
	func applicationDidFinishLaunching(_ aNotification:  a href="" Notification /a ) {
	    // Configure the user interactions first.
	    self.configureUserInteractions()
	    
	    NSApplication.shared().registerForRemoteNotifications(matching: [.alert, .sound])
	}
	 
	// Handle remote notification registration.
	func application(_ application:  a href="" NSApplication /a ,
	                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken:  a href="" Data /a ) {
	    // Forward the token to your provider, using a custom method.
	    self.forwardTokenToServer(token: deviceToken)
	}
	 
	func application(_ application:  a href="" NSApplication /a ,
	                 didFailToRegisterForRemoteNotificationsWithError error:  a href="" Error /a ) {
	    // The token is not currently available.
	    print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
	}
```

### 1.4.3 Handling Remote Notifications - 处理远程通知

The User Notifications framework offers a unified API for use in iOS, watchOS, and tvOS apps, and supports most tasks associated with local and remote notifications. Here are some examples of tasks you can perform with this framework:

- If your app is in the foreground, you can receive the notification directly and silence it. 

- If your app is in the background or not running: 

  - You can respond when the user selects a custom action associated with a notification. 
  - You can respond when the user dismisses the notification or launches your app. 

Your app receives the payload of a remote notification through its app delegate. When a remote notification arrives, the system handles user interactions normally when the app is in the background. In iOS and tvOS, the system delivers the notification payload to the [application:didReceiveRemoteNotification:fetchCompletionHandler:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623013-application) method of the app delegate. In macOS, the system delivers the payload to the [application:didReceiveRemoteNotification:](https://developer.apple.com/reference/appkit/nsapplicationdelegate/1428430-application) method of the app delegate. You can use these methods to examine the payload and perform any related tasks. For example, upon receiving a silent remote notification, you might start downloading new content for your app.

For information about how to handle notifications using the methods of the User Notifications framework, see [Responding to the Delivery of Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html#//apple_ref/doc/uid/TP40008194-CH5-SW14). For information about how to handle notifications in your app delegate, see the [*UIApplicationDelegate Protocol Reference*](https://developer.apple.com/reference/uikit/uiapplicationdelegate) or [*NSApplicationDelegate Protocol Reference*](https://developer.apple.com/reference/appkit/nsapplicationdelegate) reference.

## 1.5 Modifying and Presenting Notifications - 修改和显示通知

You can modify the content or presentation of arriving notifications using app extensions. To modify the content of a remote notification before it is delivered, use a notification service app extension. To change how the notification’s content is presented onscreen, use a notification content app extension.

### 1.5.1 Modifying the Payload of a Remote Notification - 修改远程通知的负载

Use a notification service app extension to modify the payload of a remote notification before it is delivered to the user. Remote notifications originate from a server, which has control over the configuration and contents of the notification. A service extension lets your app make changes to the server-provided payload data before that data is presented to the user. You use service extensions to implement the following types of behaviors:

- Decrypt data that was delivered in an encrypted format. 
- Download images or other media files and add them as attachments to the notification. 
- Change the body or title text of the notification. 
- Add a thread identifier to the notification or modify the contents of the notification’s [userInfo](https://developer.apple.com/reference/usernotifications/unnotificationcontent/1649869-userinfo) dictionary. 

**To add a notification service app extension to your iOS app**

1. In Xcode, select New > Target to add a new target to your project. 
2. In the iOS > Application Extension section, select the Notification Service Extension target. 
3. Click Next. 
4. Specify the name and other details for your app extension. 
5. Click Finish. 

Xcode adds a preconfigured target to your app project.

The default notification service extension target provided by Xcode contains a subclass of the `UNNotificationServiceExtension` class for you to modify. Use the [didReceiveNotificationRequest:withContentHandler:](https://developer.apple.com/reference/usernotifications/unnotificationserviceextension/1648229-didreceivenotificationrequest) method to create and configure a new [UNMutableNotificationContent](https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent) object. You can make any changes you want to the new content object, replacing some or all of the original content values. When you are done, call the provided completion handler with your new content object. The system integrates your new content into the notification and delivers it to the user.

The system gives you a limited amount of time to modify the notification and call the provided completion handler, so you should perform any tasks quickly. If your `didReceiveNotificationRequest:withContentHandler:` method takes too long to call the completion handler, the system calls the [serviceExtensionTimeWillExpire](https://developer.apple.com/reference/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) method to give you one final opportunity to finish your modifications. If you do not call the completion handler in time, the system displays the notification’s original content.

Remote notifications sent by your server must be crafted explicitly to support modification by a notification service app extension. Notifications that do not include the proper modifications are delivered directly to the user without modification. When creating the payload for the remote notification, your server should do the following:

- Include the mutable-content key with a value of 1. 
- Include an alert dictionary with subkeys for the title and body of the alert. 

For more information about implementing the methods of your notification service app extension, see [*UNNotificationServiceExtension Class Reference*](https://developer.apple.com/reference/usernotifications/unnotificationserviceextension). For information about configuring the payload for remote notifications, see [Creating the Remote Notification Payload](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW1).

### 1.5.2 Presenting Notifications Using a Custom Interface on iOS - 在iOS上使用自定义界面显示通知

Use a notification content app extension to display a custom user interface for your app’s notifications. You use an extension of this type to incorporate custom content or to use a different layout than the default interface. For example, you might use this type of extension to display images or media files inline with your notifications.

A notification content app extension supports the presentation of local and remote notifications associated with a specific category. You specify the category for a local notification using the [categoryIdentifier](https://developer.apple.com/reference/usernotifications/unnotificationcontent/1649866-categoryidentifier) of your UNNotificationContent object. For remote notifications, your server includes a category key with an appropriate value in the aps dictionary of the payload. When a notification with that category arrives, the system loads the view controller from your extension and incorporates your content into the system interfaces. You use the notification contents to configure your view controller before it appears onscreen.

**To add a notification content app extension to your iOS app**

1. In Xcode, select New > Target to add a new target to your project. 
2. In the iOS > Application Extension section, select the Notification Content Extension target. 
3. Click Next. 
4. Specify the name and other details for your app extension. 
5. Click Finish. 

Xcode adds a preconfigured target to your app project.

The initial notification content app extension target is configured to present notifications associated with a single category. You must modify your target to specify which category of notifications you want to support with each extension. You specify the category using the UNNotificationExtensionCategory key in your target’s Info.plist file. Set the value of the key to the same string in the [identifier](https://developer.apple.com/reference/usernotifications/unnotificationcategory/1649276-identifier) property of the `UNNotificationCategory` object that your app registers at launch time.

**To support multiple notification categories with your app extension**

1. Select the Info.plist file of your notification content extension project. 
2. Expand the NSExtension dictionary to view the extension-related keys. 
3. Expand the NSExtensionAttributes dictionary. 
4. Change the type of the UNNotificationExtensionCategory key to Array. 
5. Add one entry for notification category that the extension handles. 

You may include multiple notification content app extensions in your iOS app bundle. The system expects only one extension to support a given category, so you must configure the UNNotificationExtensionCategory key of each extension with a different set of values.

For more information about implementing your notification content app extension, see [*UNNotificationContentExtension Protocol Reference*](https://developer.apple.com/reference/usernotificationsui/unnotificationcontentextension).

### 1.5.3 Presenting Notifications Using a Custom Interface on watchOS - 在watchOS上使用自定义界面显示通知

The WatchKit framework provides direct support for presenting notifications using a custom interface. A WatchKit extension may include one or more notification interface controllers to display when notifications arrive for your app. You use these interface controllers to present the content of your notifications. For information on how to implement a notification interface controller, see [*App Programming Guide for watchOS*](https://developer.apple.com/library/content/documentation/General/Conceptual/WatchKitProgrammingGuide/index.html#//apple_ref/doc/uid/TP40014969).