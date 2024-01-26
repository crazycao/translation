# Customizing the Appearance of Notifications - 自定义通知外观

原文地址：
[https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications)

Customize the appearance of your iOS app’s notification alerts with a notification content app extension.

使用通知内容应用扩展（Notification Content App Extension），可以自定义您的iOS应用程序通知提醒的外观。

# Overview 概述

When an iOS device receives a notification containing an alert, the system displays the contents of the alert in two stages. Initially, it displays an abbreviated banner with the title, subtitle, and two to four lines of body text from the notification. If the user presses the abbreviated banner, iOS displays the full notification interface, including any notification-related actions. The system provides the interface for the abbreviated banner, but you can customize the full interface using a notification content app extension.

当 iOS 设备接收到包含提醒的通知时，系统会以两个阶段显示提醒的内容。初始阶段，它会显示一个简略的横幅，其中包含通知的标题、副标题和两到四行正文文本。如果用户点击简略横幅，iOS 会显示完整的通知界面，以及与通知相关的操作。系统为简略横幅提供界面，但您可以使用通知内容应用扩展自定义完整的界面。

![Screenshots showing the abbreviated banner and the full notification.](https://docs-assets.developer.apple.com/published/fe3a6ff8be679015dabe6c840abb63de/customizing_the_appearance_of_notifications-1@1x.png)

The notification content app extension manages a view controller that displays your custom notification interface. This view controller can supplement or replace the default system interface for your notifications. You can use your view controller to:

通知内容应用扩展管理一个视图控制器，用于显示自定义的通知界面。这个视图控制器可以补充或替代默认的系统界面来显示通知。您可以使用视图控制器来：

- Customize the placement of items, including the alert’s title, subtitle, and body text.
- Substitute different fonts or styling for interface elements.
- Display app-specific data—for example, data stored in `app-specific` keys of the notification’s payload.
- Include custom images or branding.

- 自定义项目的布局，包括提醒的标题、副标题和正文文本。
- 替换界面元素的不同字体或样式。
- 显示应用特定的数据，例如存储在通知负载的 `app-specific` 键中的数据。
- 包含自定义的图像或品牌标识。

Your app extension must configure its view controller using the data immediately available, such as the contents of the notification and the files present in your app extension’s bundle. If you use an app group to share data between your app and your app extension, you may also use any files found in the app group. To ensure your notifications are delivered in a timely manner, configure the views as quickly as possible. Don’t perform any long-running tasks, like trying to retrieve data over the network.

您的应用扩展必须使用立即可用的数据配置其视图控制器，例如通知的内容和应用扩展包中存在的文件。如果您使用应用组来在应用和应用扩展之间共享数据，您还可以使用应用组中的任何文件。为确保通知及时传递，请尽快配置视图。不要执行任何长时间运行的任务，比如尝试通过网络检索数据。

> **Note** **注意**
>
> Notification content app extensions are supported only in iOS apps. For information about how to customize the appearance of notifications in watchOS, see [App Programming Guide for watchOS](https://developer.apple.com/library/archive/documentation/General/Conceptual/WatchKitProgrammingGuide/index.html#//apple_ref/doc/uid/TP40014969).
> 
> 通知内容应用扩展仅在 iOS app 中支持。关于如何在 watchOS 中自定义通知外观的信息，参见《[watchOS 应用编程指南](https://developer.apple.com/library/archive/documentation/General/Conceptual/WatchKitProgrammingGuide/index.html#//apple_ref/doc/uid/TP40014969)》

## Add the Notification Content App Extension to Your Project - 将通知内容应用扩展添加到你的工程中

To add a notification content app extension to your iOS app:

1. Choose File > New > Target in Xcode.
2. Select Notification Content Extension from iOS Application Extension.
3. Click Next.
4. Provide a name for your app extension.
5. Click Finish.

>

要将通知内容应用扩展添加到你的 iOS app 中：

1. 在 Xcode 中选择 File > New > Target。
2. 从 iOS Application Extension 中选中 Notification Content Extension。
3. 点击 Next。
4. 为你的应用扩展提供一个名字。
5. 点击 Finish。

> **Note** **注意**
>
> You may add more than one notification content app extension to your project, but each one must support a unique set of notification categories. You specify the categories for your app extension in its `Info.plist` file, as described in [Declare the Supported Notification Types](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications#Declare-the-Supported-Notification-Types).
> 
> 您可以在项目中添加多个通知内容应用扩展，但是每个扩展必须支持一个唯一的通知类别集合。您可以在应用扩展的 `Info.plist` 文件中指定其支持的类别，具体描述在《[声明支持的通知类型](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications#Declare-the-Supported-Notification-Types)》中提到。

## Add Views to Your View Controller - 给你的视图控制器添加视图

The template provided by Xcode includes a storyboard and a view controller for you to configure. Build your custom notification interface by adding views to your view controller. For example, use labels to display the title, subtitle, and body text of the notification. You can also add image views and views that display noninteractive content. You don’t need to provide any initial content for your views.

Xcode 提供的模板包括一个故事板和一个视图控制器供您配置。通过向视图控制器添加视图来构建您的自定义通知界面。例如，使用标签来显示通知的标题、副标题和正文文本。您还可以添加图像视图和显示非交互内容的视图。您不需要为视图提供任何初始内容。

You can add interactive controls (for example, buttons or switches) in iOS 12 and later. For more information, see [Support Interactive Controls](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications#Support-Interactive-Controls).

在iOS 12及更高版本中您可以添加交互控件（例如按钮或开关）。有关更多信息，请参阅《[支持交互控件](https://developer.apple.com/documentation/usernotificationsui/customizing-the-appearance-of-notifications#Support-Interactive-Controls)》。

> **Important** **重要**
>
> Don’t add additional view controllers to your app extension or storyboard file. Your app extension must contain exactly one view controller.
> 
> 请勿向您的应用扩展或故事板文件添加额外的视图控制器。您的应用扩展必须只包含一个视图控制器。

## Configure Your View Controller - 配置你的视图控制器

Use the [didReceive(\_:)](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/didreceive(_:)) method of your view controller to update its labels and other views. The notification payload contains the data to use when configuring your view controller. You can also use data from the other files of your app extension. The code listing below shows a version of this method that retrieves the title and body text from the notification payload and assigns the strings to two `UILabel` controls, which are stored as outlets on the view controller.

使用视图控制器的 [didReceive(\_:)](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/didreceive(_:)) 方法来更新其标签和其他视图。通知负载包含了在配置视图控制器时使用的数据。您还可以使用应用扩展的其他文件中的数据。下面的代码示例展示了这个方法的一种写法，它从通知负载中获取标题和正文文本，并将这些字符串分配给视图控制器上存储为 outlet 的两个 `UILabel` 控件。

```
func didReceive(_ notification: UNNotification) {
   self.bodyText?.text = notification.request.content.body
   self.headlineText?.text = notification.request.content.title
}
```

If a second notification arrives when your view controller is already visible, the system calls the [didReceive(\_:)](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/didreceive(_:)) method again with the new notification payload.

如果在您的视图控制器已经可见时有第二个通知到达，系统会使用新的通知负载再次调用 [didReceive(\_:)](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/didreceive(_:)) 方法。

## Declare the Supported Notification Types - 声明支持的通知类型

Specify the types of notifications for which your notification content app extension provides an interface. When it receives a notification, the system matches the notification’s category value—its type—with the declared categories of any notification content app extensions in your app. If it finds a match, the system loads the corresponding app extension.

指定您的通知内容应用扩展提供界面的通知类型。当接收到通知时，系统会将通知的类别值（即其类型）与您的应用中的任何通知内容应用扩展的声明类别进行匹配。如果找到匹配项，系统将加载相应的应用扩展。

In the `Info.plist` file of your notification content app extension, configure the `UNNotificationExtensionCategory` key with the category strings of the notifications that your extension supports. Category strings are identifiers contained in the `UNNotificationCategory` objects that you register from your iOS app. You use these strings to differentiate the types of notifications that your app can receive. For example, you might include the string `MEETING_INVITE` in any notifications that indicate the arrival of a new meeting invitation. Identifier strings are case sensitive.

在通知内容应用扩展的 `Info.plist` 文件中，使用 `UNNotificationExtensionCategory` 键配置您的扩展支持的通知类别字符串。通知类别字符串是您从 iOS 应用程序注册的 `UNNotificationCategory` 对象中包含的标识符。您使用这些字符串来区分您的应用可以接收的通知类型。例如，您可以在任何指示新会议邀请到达的通知中包含字符串 `MEETING_INVITE`。标识符字符串区分大小写。

The following figure shows the `Info.plist` file of a notification content app extension that supports two different notification types. Because it supports two types, the value for the UNNotificationExtensionCategory key consists of an array with the strings `GENERAL` and `PLANE_AVAILABLE`. If a notification with either of those types arrives, the system displays the interface from this notification content app extension.

下图显示了支持两种不同通知类型的通知内容应用扩展的 `Info.plist` 文件。因为它支持两种类型，`UNNotificationExtensionCategory` 键的值由一个包含字符串 `GENERAL` 和 `PLANE_AVAILABLE` 的数组组成。如果具有这两种类型之一的通知到达，系统将显示该通知内容应用扩展的界面。

![A screenshot of the plist editor, showing the UNNotificationExtensionCategory for two notification types.](https://docs-assets.developer.apple.com/published/152e34869924e4cd1a285365566a5a97/customizing_the_appearance_of_notifications-2@2x.png)

> **Note** **注意**
> 
> Initially, the value of the `UNNotificationExtensionCategory` key is a string, which lets your notification content app extension support only one notification type. To support multiple types, change the type to an array of strings.
> 
> 最初，`UNNotificationExtensionCategory` 键的值是一个字符串，这使得您的通知内容应用扩展仅支持一种通知类型。要支持多种类型，请将类型更改为字符串数组。

For a local notification, put its category string into the `categoryIdentifier` property of your `UNMutableNotificationContent` object. For a remote notification, put the string into the `category` key of your JSON payload. For information about declaring your app’s notification types, see [Declaring your actionable notification types](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types).

对于本地通知，将其类别字符串放入您的 `UNMutableNotificationContent` 对象的 `categoryIdentifier` 属性中。对于远程通知，将该字符串放入您的 JSON 负载的 `category` 键中。有关声明您的应用程序的通知类型的信息，请参阅《[声明您的可操作通知类型](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types)》。

For more information about the keys in your `Info.plist` file, see [UNNotificationContentExtension](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension).

关于 `Info.plist` 文件的键的更多信息，参见 [UNNotificationContentExtension](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension)。

## Hide the Default Notification Interface - 隐藏默认通知界面

The system displays some default information with every notification, including those for which you provide a custom interface. The system always displays a header that includes the app name and icon. The system also displays an interface with the title, subtitle, and body text of the notification, but you can hide this portion of the interface if you prefer.

系统在每个通知中显示一些默认信息，包括您提供自定义界面的通知。系统始终显示包含应用程序名称和图标的标题栏。系统还显示通知的标题、副标题和正文文本的界面，但如果您愿意，您可以隐藏此部分界面。

For example, you might hide the default notification interface if your custom interface displays the same information. The following figure illustrates the layout of the notification interface with and without the default content.

例如，如果您的自定义界面显示相同的信息，您可能会隐藏默认的通知界面。下图说明了带有和不带有默认内容的通知界面的布局。

![The default interface displays a header, followed by your custom content, followed by the default system content. If you hide the default system content, only the header and your custom interface are displayed.](https://docs-assets.developer.apple.com/published/a62382090758a2f43ea487b72c5298d5/customizing_the_appearance_of_notifications-3@2x.png)

To remove the default system content, add the `UNNotificationExtensionDefaultContentHidden` key to your extension’s `Info.plist` file and set the value of the key to `true`. For more information about this key, see [UNNotificationContentExtension](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension).

要移除默认的系统内容，请将 `UNNotificationExtensionDefaultContentHidden` 键添加到您的扩展的 `Info.plist` 文件中，并将该键的值设置为 `true`。有关此键的更多信息，请参阅 [UNNotificationContentExtension](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension)。

## Incorporating Media Into Your Interface - 将媒体内容整合到您的界面中

To support the playback of audio or video from your custom notifications interface, implement the following:

为了支持从您的自定义通知界面播放音频或视频，请执行以下操作：

- In the view controller’s [mediaPlayPauseButtonType](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediaplaypausebuttontype) property, return the type of button you want.
- In the view controller’s [mediaPlayPauseButtonFrame](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediaplaypausebuttonframe) property, return the button’s frame.
- In the [mediaPlay()](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediaplay()) method, start playing your media file.
- in the [mediaPause()](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediapause()) button, stop playing your media file.

- 在视图控制器的 [mediaPlayPauseButtonType](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediaplaypausebuttontype) 属性中返回您想要的按钮类型。
- 在视图控制器的 [mediaPlayPauseButtonFrame](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediaplaypausebuttonframe) 属性中返回按钮的框架。
- 在 [mediaPlay()](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediaplay()) 方法中，开始播放您的媒体文件。
- 在 [mediaPause()](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension/mediapause()) 按钮中，停止播放您的媒体文件。

The system draws a media button for you, handling all user interactions. When the buttons are pressed, it calls the `mediaPlay()` and `mediaPause()` methods so that you can start and stop playback.

系统会为您绘制一个媒体按钮，并处理所有用户交互。当按下按钮时，它会调用 `mediaPlay()` 和 `mediaPause()` 方法，以便您可以开始和停止播放。

To programmatically start or stop playback of your media file, call the current [NSExtensionContext](https://developer.apple.com/documentation/foundation/nsextensioncontext) object’s [mediaPlayingStarted()](https://developer.apple.com/documentation/foundation/nsextensioncontext/1648523-mediaplayingstarted) and [mediaPlayingPaused()](https://developer.apple.com/documentation/foundation/nsextensioncontext/1648527-mediaplayingpaused) methods. Use your view controller’s [extensionContext](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621411-extensioncontext) property to access the extension context.

要以编程方式启动或停止播放您的媒体文件，请调用当前 [NSExtensionContext](https://developer.apple.com/documentation/foundation/nsextensioncontext) 对象的 [mediaPlayingStarted()](https://developer.apple.com/documentation/foundation/nsextensioncontext/1648523-mediaplayingstarted) 和 [mediaPlayingPaused()](https://developer.apple.com/documentation/foundation/nsextensioncontext/1648527-mediaplayingpaused) 方法。使用您的视图控制器的 [extensionContext](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621411-extensioncontext) 属性来访问扩展上下文。

## Support Interactive Controls - 支持交互控件

In iOS 12 and later you can enable user interactions in your custom notifications. This lets you add interactive controls, such as buttons and switches to your custom interface.

在 iOS 12 及更高版本中，您可以在自定义通知中启用用户交互。这使您可以向自定义界面添加交互式控件，如按钮和开关。

To enable user interactions:

1. Open your Notification Content Extension’s `Info.plist` file.
2. Add the `UNNotificationExtensionUserInteractionEnabled` key to your extension attributes. Give it a Boolean value, set to `YES`.

要启用用户交互：

1. 打开您的通知内容扩展的 `Info.plist` 文件。
2. 在扩展属性中添加 `UNNotificationExtensionUserInteractionEnabled` 键。将其布尔值设置为 `YES`。

The following figure shows the `Info.plist` file, with notifications enabled.

下图展示了一个通知交互启用的 `Info.plist` 文件。

![A screenshot of the plist editor, showing the UNNotificationExtensionUserInteractionEnabled key added to the NSExtensionAttributes dictionary.](https://docs-assets.developer.apple.com/published/56e764232f71daec129a208c72a7d564/customizing_the_appearance_of_notifications-4@2x.png)

# See Also - 其他参考

## Notification Content App Extension - 通知内容应用扩展

### protocol [UNNotificationContentExtension](https://developer.apple.com/documentation/usernotificationsui/unnotificationcontentextension)

An object that presents a custom interface for a delivered local or remote notification.

一种为已递送的本地或远程通知呈现自定义界面的对象。
