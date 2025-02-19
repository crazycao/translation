# ActivityKit

原文地址：[https://developer.apple.com/documentation/ActivityKit](https://developer.apple.com/documentation/ActivityKit)

Share live updates from your app as Live Activities in the Dynamic Island, on the Lock Screen, and on the Smart Stack in watchOS.

在灵动岛、锁定屏幕以及 watchOS 的智能叠放中，以实时活动的形式分享你应用程序的实时更新。 

> iOS 16.1+
iPadOS 17.0+
Mac Catalyst 16.1+
watchOS 11.0+

## Overview 概述

With the ActivityKit framework, you can start a Live Activity to share live updates from your app in the Dynamic Island and on the Lock Screen. Especially for apps that push the limit of notifications to provide updated information, Live Activities can offer a richer, interactive and highly glanceable way for people to keep track of an event or activity over a couple of hours. For example, a sports app might start a Live Activity that makes live information available at a glance for the duration of a game.

借助 ActivityKit 框架，你可以启动实时活动，以便在灵动岛和锁定屏幕上分享你应用的实时更新。特别是对于那些竭力通过通知来提供最新信息的应用而言，实时活动为用户提供了一种更丰富、可交互且极具可视化的方式，让他们在数小时内持续追踪某个事件或活动。例如，一款体育应用可能会启动一项实时活动，在比赛期间让用户一眼就能获取实时信息。

A Live Activity appears in highly visible contexts:

- On the Lock Screen of iPhone and iPad, it appears at the top of the list alongside notifications.
- On devices that support it, the Live Activity appears in the Dynamic Island.
- On iPhone in StandBy, it appears using a minimal presentation at the top of the screen or scaled to fill the display.
- On the Home Screen and when other apps are in use, updates appear as a banner at the top of the screen of devices that don’t support the Dynamic Island if the update includes an alert configuration.
- In the Smart Stack in watchOS, the leading and trailing view for the Dynamic Island appear together to form the Live Activity.

实时活动会出现在极为显眼的位置：

- 在 iPhone 和 iPad 的锁定屏幕上，它与通知一同显示在列表顶部。
- 在支持灵动岛的设备上，实时活动会出现在灵动岛中。
- 在处于待机模式的 iPhone 上，它会以精简形式呈现在屏幕顶部，或者放大以铺满整个显示屏。
- 在主屏幕以及使用其他应用时，如果更新包含提醒配置，在不支持灵动岛的设备上，更新会以横幅形式出现在屏幕顶部。
- 在 watchOS 的智能叠放中，灵动岛的前置和后置视图会一同显示，构成实时活动。

> **Related sessions from WWDC23** **WWDC23 相关会议**
>
> [Session 10184: Meet ActivityKit](https://developer.apple.com/videos/play/wwdc2023/10184), [Session 10185: Update Live Activities with push notifications](https://developer.apple.com/videos/play/wwdc2023/10185), and [Session 10194: Design dynamic Live Activities](https://developer.apple.com/videos/play/wwdc2023/10194)
> 
> [会议 10184：认识 ActivityKit](https://developer.apple.com/videos/play/wwdc2023/10184)
> 
> [会议 10185：通过推送通知更新实时活动](https://developer.apple.com/videos/play/wwdc2023/10185)
> 
> [会议 10194：设计动态实时活动](https://developer.apple.com/videos/play/wwdc2023/10194)

In addition to viewing real-time information, people tap a Live Activity to launch your app and interact with its buttons or toggles to perform essential functionality without launching your app. In the Dynamic Island, people touch and hold the compact and minimal presentations to show an expanded presentation with more content that feels like a peek into your app.

除了查看实时信息，用户还可以点击实时活动来启动你的应用程序，并且无需启动应用，就能通过点击其中的按钮或切换开关来执行关键功能。在灵动岛中，用户长按紧凑展示区和极简展示区，即可显示出扩展展示区，呈现更多内容，仿佛是在查看你的应用内部。

![Three screenshots of iPhone that show a Live Activity for a delivery app. They show the Live Activity on the Lock Screen, in the leading and trailing presentations in the Dynamic Island, and in the expanded presentation.此处有三张 iPhone 截图，展示了一款配送应用的实时活动。截图分别展示了锁定屏幕上的实时活动、灵动岛前端及后端展示界面中的实时活动，以及扩展展示区中的实时活动。](https://docs-assets.developer.apple.com/published/a81e13e284bbdea7bed42f642b5d9ee5/live-activity-dynamic-island@2x.png)

In your app, use ActivityKit to configure, start, update, and end the Live Activity, and create the user interface of your Live Activities with a widget extension, SwiftUI, and WidgetKit. As a result of using SwiftUI and WidgetKit, you can share code between widgets and Live Activities or develop them in tandem.

在你的应用中，使用 ActivityKit 来配置、启动、更新和结束实时活动，并借助小组件扩展、SwiftUI 和 WidgetKit 创建实时活动的用户界面。由于使用了 SwiftUI 和 WidgetKit，你可以在小组件和实时活动之间共享代码，或者同步开发它们。

However, Live Activities use a different mechanism to receive updates compared to widgets. Instead of using a timeline mechanism, Live Activities receive updated data from your app with ActivityKit and remotely with ActivityKit push notifications. Starting with iOS 17.2 and iPadOS 17.2, you can also start Live Activities with ActivityKit push notifications.

不过，实时活动采用了与小组件不同的更新接收机制。实时活动并非使用时间线机制，而是通过 ActivityKit 从你的应用接收更新数据，以及通过 ActivityKit 推送通知进行远程更新。从 iOS 17.2 和 iPadOS 17.2 开始，你还可以通过 ActivityKit 推送通知来启动实时活动。

> **Note** **注意**
>
> visionOS doesn’t load WidgetKit extensions found in compatible iPad and iPhone apps. As a result, it doesn’t support Live Activities.
> 
> visionOS 不会加载兼容的 iPad 和 iPhone 应用中的 WidgetKit 扩展。因此，它不支持实时活动。

## Topics 主题

### Essentials 要素

- [Developing a WidgetKit strategy](https://developer.apple.com/documentation/WidgetKit/Developing-a-WidgetKit-strategy) 制定 WidgetKit 策略

	Explore features, tasks, related frameworks, and constraints as you make a plan to implement widgets, watch complications, and Live Activities.
	
	在规划实现小组件、手表复杂功能和实时活动时，深入研究其功能、任务、相关框架及限制条件。
	
- [ActivityKit updates](https://developer.apple.com/documentation/Updates/ActivityKit) 实时活动更新

	Learn about important changes in ActivityKit.
	
	了解 ActivityKit 中的重要变化。

### Live Activity implementation 实时活动实现

- [Displaying live data with Live Activities](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities) 通过实时活动展示实时数据

	Display your app’s data in the Dynamic Island and on the Lock Screen and offer quick interactions.
	
	在灵动岛和锁定屏幕上展示应用数据，并提供快速交互功能。

- [Starting and updating Live Activities with ActivityKit push notifications](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications) 使用 ActivityKit 推送通知启动和更新实时活动
 
	Use ActivityKit to receive push tokens and to remotely start, update, and end your Live Activity with ActivityKit notifications.
	
	使用 ActivityKit 接收推送令牌，并以此远程启动、更新和结束实时活动。
	
- [Adding accessible descriptions to widgets and Live Activities](https://developer.apple.com/documentation/activitykit/adding-accessible-descriptions-to-widgets-and-live-activities) 为小组件和实时活动添加无障碍描述

	Describe the interface elements of your widgets and Live Activities to help people understand what they represent.
	
	描述小组件和实时活动的界面元素，帮助用户理解其代表的内容。

- [class Activity](https://developer.apple.com/documentation/activitykit/activity) Activity 类

	The object you use to start, update, and end a Live Activity.
	
	用于启动、更新和结束实时活动的对象。

- [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) 表情符号别动队：支持实时活动、交互性和动画

	Offer Live Activities, animate data updates, and add interactivity to widgets.
	
	提供实时活动，为数据更新添加动画效果，并为小组件增加交互性。

- [NSSupportsLiveActivities](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSSupportsLiveActivities)

	A Boolean value that indicates whether an app supports Live Activities.
	
	一个布尔值，用于指示应用是否支持实时活动。
	
- [NSSupportsLiveActivitiesFrequentUpdates](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSSupportsLiveActivitiesFrequentUpdates)

	A Boolean value that indicates whether an app can update its Live Activities frequently.
	
	一个布尔值，用于指示应用是否能够频繁更新其实时活动。

### Widget extensions 小组件扩展

- [WidgetKit](https://developer.apple.com/documentation/WidgetKit)

	Extend the reach of your app by creating widgets, watch complications, Live Activities, and controls.
	
	通过创建小组件、手表复杂功能、实时活动和控件来扩大应用的影响力。

- [Creating a widget extension](https://developer.apple.com/documentation/WidgetKit/Creating-a-Widget-Extension) 创建小组件扩展

	Display your app’s content in a convenient, informative widget on various devices.
	
	在各种设备上以便捷且信息丰富的小组件形式展示应用内容。
	
- [Animating data updates in widgets and Live Activities](https://developer.apple.com/documentation/WidgetKit/Animating-data-updates-in-widgets-and-live-activities) 在小组件和实时活动中为数据更新添加动画效果

	Use SwiftUI animations to indicate data updates in your widgets and Live Activities.
	
	使用 SwiftUI 动画来指示小组件和实时活动中的数据更新。

### User interface 用户界面

- [Creating views for widgets, Live Activities, and watch complications](https://developer.apple.com/documentation/WidgetKit/Creating-views-for-widgets-Live-Activities-and-watch-complications) 为小组件、实时活动和手表复杂功能创建视图

	Implement glanceable views with WidgetKit and SwiftUI.
	
	使用 WidgetKit 和 SwiftUI 实现一目了然的视图。

- [Linking to specific app scenes from your widget or Live Activity](https://developer.apple.com/documentation/WidgetKit/Linking-to-specific-app-scenes-from-your-widget-or-Live-Activity) 从小组件或实时活动链接到特定的应用场景

	Add deep links to your widgets and Live Activities that enable people to open a specific scene in your app.
	
	在小组件和实时活动中添加深度链接，使用户能够打开应用中的特定场景。