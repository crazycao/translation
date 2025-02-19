# Displaying live data with Live Activities
# 通过实时活动展示实时数据

原文地址：[https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities)

Display your app’s data in the Dynamic Island and on the Lock Screen and offer quick interactions.

在灵动岛和锁定屏幕上展示应用数据，并提供快速交互功能。

## 1 Overview 概述

Live Activities display your app’s most current data on the iPhone or iPad Lock Screen and in the Dynamic Island, allowing people to refer to live information at a glance and perform quick actions that are related to the displayed information.

实时活动可在 iPhone 或 iPad 的锁定屏幕以及灵动岛中展示你应用的最新数据，让用户一眼就能看到实时信息，并执行与所展示信息相关的快速操作。

To offer Live Activities, add code to your existing widget extension or create a new widget extension if your app doesn’t already include one. Live Activities use WidgetKit functionality and SwiftUI for their user interface. ActivityKit’s role is to handle the life cycle of each Live Activity: You use its API to request, update, and end a Live Activity and to receive ActivityKit push notifications.

若要提供实时活动功能，你需要在现有的小组件扩展中添加代码；若你的应用尚未包含小组件扩展，则需创建一个新的。实时活动的用户界面借助 WidgetKit 功能和 SwiftUI 来实现。ActivityKit 的作用是处理每个实时活动的生命周期：你可使用其 API 来请求、更新和结束实时活动，以及接收 ActivityKit 推送通知。

For design guidance, refer to [Human Interface Guidelines > Live Activities](https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/live-activities).

有关设计指导，请参考[《人机界面指南》中的 “实时活动” 部分](https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/live-activities)。

> **Related sessions from WWDC23** **WWDC2023 相关会议：**
>
> [Session 10184: Meet ActivityKit](https://developer.apple.com/videos/play/wwdc2023/10184) and [Session 10194: Design dynamic Live Activities](https://developer.apple.com/videos/play/wwdc2023/10194)
>
> [会议 10184：认识 ActivityKit](https://developer.apple.com/videos/play/wwdc2023/10184)
>
> [会议 10194：设计动态实时活动](https://developer.apple.com/videos/play/wwdc2023/10194)

## 2 Review Live Activity presentations 查看实时活动展示形式

Live Activities come in different presentations for the Lock Screen and the Dynamic Island. The Lock Screen presentation appears on all devices. On an unlocked device that doesn’t support the Dynamic Island, the Lock Screen presentation also appears as a banner for Live Activity updates that include an alert configuration. For example, if a person uses Mail on a device that doesn’t support the Dynamic Island while the Live Activity receives an update with an alert configuration, the system displays the Lock Screen presentation as a banner at the top of the screen to let them know about the updated Live Activity.

实时活动在锁定屏幕和灵动岛中有不同的展示形式。锁定屏幕展示形式在所有设备上都能出现。在不支持灵动岛的未锁定设备上，如果实时活动更新包含提醒配置，锁定屏幕展示形式还会以横幅形式出现。例如，若用户在不支持灵动岛的设备上使用邮件应用，同时实时活动收到带有提醒配置的更新，系统会在屏幕顶部以横幅形式显示锁定屏幕展示内容，告知用户实时活动已更新。

![Two screenshots of an iPhone that doesn’t support the Dynamic Island and shows a Live Activity for a delivery app. They show the Live Activity on the Lock Screen and the same presentation on the Home Screen as a banner.两张不支持灵动岛的 iPhone 截图，展示了一款配送应用的实时活动。截图分别展示了锁定屏幕上的实时活动，以及主屏幕上以横幅形式出现的相同展示。](https://docs-assets.developer.apple.com/published/10eb83bdd21c5c1c81c0c190206afb68/live-activity-notch@2x.png)

Devices that support the Dynamic Island display Live Activities in the Dynamic Island using several presentations. When there’s only one ongoing Live Activity, the system uses the compact presentation. It’s composed of two elements: one that displays on the leading side of the TrueDepth camera, and one that displays on the trailing side. Although the leading and trailing presentations are separate views, they form a cohesive view in the Dynamic Island, representing a single piece of information from your app. People can tap a compact Live Activity to open the app and get more details about the event or task.

支持灵动岛的设备在灵动岛中通过几种展示形式来呈现实时活动。当只有一个正在进行的实时活动时，系统会使用紧凑展示形式。它由两个元素组成：一个显示在原深感摄像头靠前一侧，另一个显示在靠后一侧。尽管前后展示是分开的视图，但它们在灵动岛中形成一个连贯的视图，代表你应用中的一条信息。用户可以点击紧凑的实时活动来打开应用，获取有关该事件或任务的更多详细信息。

![An illustration of the Dynamic Island with a Live Activity that appears in the compact leading and trailing presentations.一幅灵动岛的示意图，其中实时活动以紧凑的前后展示形式出现。](https://docs-assets.developer.apple.com/published/85a328d41929d4c1c6b224365adc1c71/type-compact@2x.png)

When multiple Live Activities from several apps are active, the system uses the circular minimal presentation to display two of them in the Dynamic Island. The system chooses a Live Activity from one app to appear attached to the Dynamic Island while it presents a Live Activity from another app detached from the Dynamic Island. As with a compact Live Activity, people can tap a minimal Live Activity to open the app and get more details about the event or task.

当来自多个应用的多个实时活动处于活跃状态时，系统会使用圆形极简展示形式在灵动岛中显示它们两个。系统会选择一个应用的实时活动显示在与灵动岛相连位置，同时将另一个应用的实时活动显示在与灵动岛分离的位置。和紧凑实时活动一样，用户可以点击极简实时活动来打开应用，获取有关该事件或任务的更多详细信息。

![An illustration of the Dynamic Island with a Live Activity that appears in the minimal presentation.一幅灵动岛的示意图，其中实时活动以极简式展示区出现。](https://docs-assets.developer.apple.com/published/a50ee6d09f8ab0a7f2e53c9e36807c8c/type-minimal@2x.png)

When people touch and hold a Live Activity in a compact or minimal presentation, the system displays the content in an expanded presentation.

当用户长按处于紧凑或简约展示形式的实时活动时，系统会以扩展式展示区显示其内容。

![An illustration of the Dynamic Island with a Live Activity that appears in the expanded presentations.一幅灵动岛的示意图，其中实时活动以扩展式展示区出现。](https://docs-assets.developer.apple.com/published/d865a4848645ca3e7e1b401fa6c94851/type-expanded@2x.png)

The minimal presentation also appears at the top of the iPhone Lock Screen when the device is in StandBy — in landscape orientation, charging, and with the display positioned at an angle to face the room. If a person taps the minimal presentation in StandBy, the Live Activity expands to fill the whole display using the Lock Screen presentation.

当设备处于待机模式（横向放置、正在充电且显示屏朝向房间）时，极简式展示区也会出现在 iPhone 锁定屏幕顶部。如果用户在待机模式下点击极简式展示区，实时活动会以锁定屏幕展示形式展开，铺满整个显示屏。

To add support for Live Activities in your app, you must support all presentations.

要在你的应用中添加对实时活动的支持，你必须支持所有这些展示形式。

## 3 Understand constraints 了解限制条件

A Live Activity can be active for up to eight hours unless its app or a person ends it before this limit. After the eight-hour limit, the system automatically ends the Live Activity, and immediately removes it from the Dynamic Island. However, the Live Activity remains on the Lock Screen until a person removes it or for up to four additional hours before the system removes it — whichever comes first. As a result, a Live Activity remains on the Lock Screen for a maximum of 12 hours.

实时活动最长可保持活跃状态 8 小时，除非应用或用户在此期限之前将其结束。达到 8 小时限制后，系统会自动结束实时活动，并立即将其从灵动岛中移除。不过，实时活动会继续保留在锁定屏幕上，直到用户将其移除，或者在系统移除它之前最多再保留 4 小时，以先到者为准。因此，实时活动在锁定屏幕上最多可保留 12 小时。

For more information about ending a Live Activity, refer to the “End the Live Activity” section below.

有关结束实时活动的更多信息，请参阅以下 “结束实时活动” 部分。

The system requires image assets for a Live Activity to use a resolution that’s smaller or equal to the size of the presentation for a device. If you use an image asset that’s larger than the size of the Live Activity presentation, the system might fail to start the Live Activity. For example, an image you use for the minimal presentation of your Live Activity shouldn’t exceed 45x36.67 points. For size guidance of Live Activity presentations, refer to [Human Interface Guidelines > Live Activities](https://developer.apple.com/design/human-interface-guidelines/live-activities#Specifications).

系统要求实时活动使用的图像资源分辨率小于或等于设备展示的尺寸。如果使用的图像资源大于实时活动展示的尺寸，系统可能无法启动实时活动。例如，用于实时活动极简展示区的图像不应超过 45×36.67 点。有关实时活动展示尺寸的指导信息，请参阅[《人机界面指南》中的 “实时活动” 部分](https://developer.apple.com/design/human-interface-guidelines/live-activities#Specifications)。

Each Live Activity runs in its own sandbox, and — unlike a widget — it can’t access the network or receive location updates. To update the dynamic data of an active Live Activity, use ActivityKit in your app or allow your Live Activities to receive ActivityKit push notifications as described in [Starting and updating Live Activities with ActivityKit push notifications](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications).

每个实时活动都在其自己的沙盒环境中运行，并且——与小组件不同——它无法访问网络或接收位置更新。要更新活跃实时活动的动态数据，可在应用中使用 ActivityKit，或者允许实时活动接收 ActivityKit 推送通知，如《[使用 ActivityKit 推送通知启动和更新实时活动](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications)》中所述。

> **Important** **重要**
>
> Static and dynamic data for a Live Activity, including data for ActivityKit updates and ActivityKit push notifications, can’t exceed a combined size of 4 KB.
> 
> 实时活动的静态和动态数据，包括用于 ActivityKit 更新和 ActivityKit 推送通知的数据，其总大小不能超过 4KB。

## 4 Add support for Live Activities to your app 为应用添加实时活动支持

The code that describes the user interface of your Live Activity is part of your app’s widget extension. If you already offer widgets in your app, add code for the Live Activity to your existing widget extension and reuse code between your widgets and Live Activities. However, although Live Activities leverage WidgetKit’s functionality, they aren’t widgets. In contrast to the timeline mechanism you use to update your widgets’ user interface, you start and update a Live Activity from your app with ActivityKit or with ActivityKit push notifications.

描述实时活动用户界面的代码是应用小组件扩展的一部分。如果你的应用已经提供了小组件，可将实时活动的代码添加到现有的小组件扩展中，并在小组件和实时活动之间复用代码。不过，尽管实时活动利用了 WidgetKit 的功能，但它们并非小组件。与用于更新小组件用户界面的时间线机制不同，你需要通过 ActivityKit 从应用内启动和更新实时活动，或使用 ActivityKit 推送通知。

> **Note** **注意**
>
> You can create a widget extension to adopt Live Activities without offering widgets. However, consider offering both widgets and Live Activities to allow people to add glanceable information and a personal touch to their device.
> 
> 你可以创建一个小组件扩展来支持实时活动，而无需提供小组件。不过，考虑同时提供小组件和实时活动，以便用户为他们的设备添加便捷查看的信息和个性化服务。

To support Live Activities:

1. Create a widget extension if you haven’t added one to your app and make sure to select “Include Live Activity” when you add a widget extension target to your Xcode project. For more information on creating a widget extension, refer to [WidgetKit](https://developer.apple.com/documentation/WidgetKit) and [Creating a widget extension](https://developer.apple.com/documentation/WidgetKit/Creating-a-Widget-Extension).

2. If your project includes an `Info.plist` file, add the Supports Live Activities entry to it, and set its Boolean value to `YES`. Alternatively, open the `Info.plist` file as source code, add the [NSSupportsLiveActivities](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSSupportsLiveActivities) key, then set the type to Boolean and its value to `YES`. If your project doesn’t have an `Info.plist` file, add the Supports Live Activities entry to the list of custom iOS target properties for your iOS app target and set its value to `YES`.

3. Add code that defines an [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) structure to describe the static and dynamic data of your Live Activity.

4. Use the `ActivityAttributes` you defined to create the [ActivityConfiguration](https://developer.apple.com/documentation/WidgetKit/ActivityConfiguration).

5. Add code to configure, start, update, and end your Live Activities.

6. Make your Live Activity interactive with [Button](https://developer.apple.com/documentation/SwiftUI/Button) or [Toggle](https://developer.apple.com/documentation/SwiftUI/Toggle) as described in [Adding interactivity to widgets and Live Activities](https://developer.apple.com/documentation/WidgetKit/Adding-interactivity-to-widgets-and-Live-Activities).

7. Add animations to bring attention to content updates as described in [Animating data updates in widgets and Live Activities](https://developer.apple.com/documentation/WidgetKit/Animating-data-updates-in-widgets-and-live-activities).

若要支持实时活动，可按以下步骤操作：

1. 如果你的应用尚未添加小组件扩展，则创建一个。在向 Xcode 项目添加小组件扩展目标时，务必选中 “Include Live Activity”（包含实时活动）。有关创建小组件扩展的更多信息，请参阅 [WidgetKit](https://developer.apple.com/documentation/WidgetKit) 和 《[创建小组件扩展](https://developer.apple.com/documentation/WidgetKit/Creating-a-Widget-Extension)》。
2. 如果你的项目包含 `Info.plist` 文件，向其中添加 “Supports Live Activities”（支持实时活动）条目，并将其布尔值设置为 `YES`。或者，以源代码形式打开 `Info.plist` 文件，添加 [NSSupportsLiveActivities](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSSupportsLiveActivities) 键，然后将类型设置为布尔值，并将其值设为 `YES`。如果你的项目没有 `Info.plist` 文件，将 “Supports Live Activities” 条目添加到 iOS 应用目标的自定义 iOS 目标属性列表中，并将其值设置为 `YES`。
3. 添加定义 [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) 结构体的代码，用于描述实时活动的静态和动态数据。
4. 使用你定义的 `ActivityAttributes` 创建 [ActivityConfiguration](https://developer.apple.com/documentation/WidgetKit/ActivityConfiguration)。
5. 添加用于配置、启动、更新和结束实时活动的代码。
6. 使用 [Button](https://developer.apple.com/documentation/SwiftUI/Button)（按钮）或 [Toggle](https://developer.apple.com/documentation/SwiftUI/Toggle)（切换开关）让实时活动具有交互性，如《[为小组件和实时活动添加交互性](https://developer.apple.com/documentation/WidgetKit/Adding-interactivity-to-widgets-and-Live-Activities)》中所述，。
7. 添加动画以突出内容更新,如《[在小组件和实时活动中为数据更新添加动画效果](https://developer.apple.com/documentation/WidgetKit/Animating-data-updates-in-widgets-and-live-activities)》中所述。

## 5 Define a set of static and dynamic data 定义一组静态和动态数据

After you add a widget extension target that includes Live Activities to your Xcode project, describe the data that your Live Activity displays by implementing [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes). The `ActivityAttributes` inform the system about static data that appears in the Live Activity. You also use `ActivityAttributes` to declare the required custom [Activity.ContentState](https://developer.apple.com/documentation/activitykit/activity/contentstate-swift.typealias) type that describes the dynamic data of your Live Activity. In the example below from the [Apple Developer Documentation](https://developer.apple.com/documentation) sample code project, `AdventureAttributes` describes the hero information as static data using let `hero: EmojiRanger`. Note how the code defines the `Activity.ContentState` to encapsulate dynamic data: the current health level of the hero and a string that describes what happens to the hero.

在向 Xcode 项目中添加包含实时活动的小组件扩展目标后，通过实现 [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) 来描述实时活动所显示的数据。`ActivityAttributes` 用于向系统提供实时活动中显示的静态数据。你还需使用 `ActivityAttributes` 声明所需的自定义 [Activity.ContentState](https://developer.apple.com/documentation/activitykit/activity/contentstate-swift.typealias) 类型，以描述实时活动的动态数据。在以下取自《[苹果开发者文档](https://developer.apple.com/documentation)示例代码项目的示例中，`AdventureAttributes` 使用 `let hero: EmojiRanger` 将英雄信息描述为静态数据。请注意代码是如何定义 `Activity.ContentState` 来封装动态数据的：英雄当前的健康值以及描述英雄遭遇的字符串。

```
import ActivityKit

struct AdventureAttributes: ActivityAttributes {
    struct ContentState: Codable & Hashable {
        let currentHealthLevel: Double
        let eventDescription: String
    }
    
    let hero: EmojiRanger
}
```

> **Tip** **提示**
>
> To make your code more descriptive and easy to read, you can define a type alias for the `ContentState`; for example: `public typealias HeroStatus = ContentState`.
> 
> 为了使代码更具描述性且易于阅读，你可以为 `ContentState` 定义一个类型别名；例如：`public typealias HeroStatus = ContentState`。

## 6 Add Live Activities to the widget extension 将实时活动添加到小组件扩展

Live Activities leverage WidgetKit. After you add code to describe the data that appears in the Live Activity with the `ActivityAttributes` structure, add code to return an [ActivityConfiguration](https://developer.apple.com/documentation/WidgetKit/ActivityConfiguration) in your widget implementation.

实时活动借助了 WidgetKit 的功能。在使用 `ActivityAttributes` 结构体添加代码描述实时活动中显示的数据后，在小组件实现中添加代码以返回 [ActivityConfiguration](https://developer.apple.com/documentation/WidgetKit/ActivityConfiguration)。

The following example uses the AdventureAttributes structure from the previous example:

下面的示例使用了上一个示例中的 `AdventureAttributes` 结构体：

```
import WidgetKit
import SwiftUI


struct AdventureActivityConfiguration: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AdventureAttributes.self) { context in
            // Create the presentation that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            // 创建出现在锁定屏幕以及不支持灵动岛的设备主屏幕上的横幅展示内容。
            // ...
        } dynamicIsland: { context in
            // Create the presentations that appear in the Dynamic Island.
            // 创建出现在灵动岛中的展示内容。
            // ...
        }
    }
}
```

> **Tip** **提示**
>
> If you select “Include Live Activities” when you add a new widget extension target to your project, Xcode automatically creates a widget bundle for you that includes a widget and a Live Activity.
> 
> 如果在向项目中添加新的小组件扩展目标时选择 “包含实时活动”，Xcode 会自动为你创建一个包含小组件和实时活动的小组件包。

If your app already offers widgets, add the Live Activity to your [WidgetBundle](https://developer.apple.com/documentation/SwiftUI/WidgetBundle). If you don’t have a WidgetBundle — for example, if you only offer one widget — create a widget bundle as described in [Creating a widget extension](https://developer.apple.com/documentation/WidgetKit/Creating-a-Widget-Extension) and then add the Live Activity to it.

如果你的应用已经提供了小组件，将实时活动添加到 [WidgetBundle](https://developer.apple.com/documentation/SwiftUI/WidgetBundle) 中。如果你没有 WidgetBundle —— 例如，如果你只提供了一个小组件 —— 按照《[创建小组件扩展](https://developer.apple.com/documentation/WidgetKit/Creating-a-Widget-Extension)》中的说明创建一个小组件包，然后将实时活动添加到其中。

## 7 Create the Lock Screen presentation 创建锁定屏幕展示区

To create the user interface of the Live Activity, you use SwiftUI in the widget extension you created earlier. Similar to widgets, you don’t provide the size of the user interface for your Live Activity but let the system determine the appropriate dimensions.

要创建实时活动的用户界面，你需要在之前创建的小组件扩展中使用 SwiftUI。与小组件类似，你无需为实时活动的用户界面指定尺寸，而是让系统来确定合适的维度。

Start with the presentation that appears on the Lock Screen. The following code displays the information that the `AdventureAttributes` struct describes using the custom `AdventureLiveActivityView`:

从出现在锁定屏幕上的展示界面开始。以下代码使用自定义的 `AdventureLiveActivityView` 来显示 `AdventureAttributes` 结构体所描述的信息：

```
struct AdventureActivityConfiguration: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AdventureAttributes.self) { context in
            // Create the presentation that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            // 创建出现在锁定屏幕以及不支持灵动岛的设备主屏幕上的横幅展示内容。
            AdventureLiveActivityView(
                hero: context.attributes.hero,
                isStale: context.isStale,
                contentState: context.state
            )
            .activityBackgroundTint(Color.liveActivityBackground.opacity(0.25))
        } dynamicIsland: { context in
            // Create the presentations that appear in the Dynamic Island.
            // 创建出现在灵动岛中的展示内容。
            // ...
        }
    }
}
```

> **Note** **注意**
>
> The system may truncate a Live Activity if its height exceeds 160 points.
> 
> 如果实时活动的高度超过 160 点，系统可能会将其截断。

On a device that doesn’t support the Dynamic Island, the system displays the Lock Screen presentation as a banner for a Live Activity update if:

- The device is unlocked and its app isn’t in use

- You pass an [AlertConfiguration](https://developer.apple.com/documentation/activitykit/alertconfiguration) to the [update(_:alertConfiguration:)](https://developer.apple.com/documentation/activitykit/activity/update(_:alertconfiguration:)) function

在不支持灵动岛的设备上，当满足以下条件时，系统会将锁定屏幕展示界面作为实时活动更新的横幅显示：

- 设备已解锁且应用未在使用中。
- 你向 [update(_:alertConfiguration:)](https://developer.apple.com/documentation/activitykit/activity/update(_:alertconfiguration:)) 函数传递了[AlertConfiguration](https://developer.apple.com/documentation/activitykit/alertconfiguration)。

On iPhone in StandBy, the Lock Screen presentation appears scaled to fill the screen of the device. Make sure your assets offer a high-enough resolution for StandBy. Additionally, consider updating the Lock Screen presentation to make use of the additional space. To detect Standby, use the [isActivityFullscreen](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/isActivityFullscreen) environment variable.

在处于待机模式的 iPhone 上，锁定屏幕展示区会放大以填满设备屏幕。确保你的资源图像分辨率足够高，以适配待机模式。此外，可以考虑更新锁定屏幕展示区，以充分利用额外的空间。要检测是否处于待机模式，可使用 [isActivityFullscreen](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/isActivityFullscreen) 环境变量。

## 8 Create the compact and minimal presentations 创建紧凑和极简展示区

Live Activities appear in the Dynamic Island of devices that support it. When you start one or more Live Activities and no other app starts a Live Activity, the compact leading and trailing presentations appear together to form a cohesive presentation in the Dynamic Island for one Live Activity.

实时活动会显示在支持灵动岛的设备的灵动岛区域。当你启动一个或多个实时活动，且没有其他应用启动实时活动时，紧凑的前端和后端展示区会组合在一起，在灵动岛中为一个实时活动形成一个连贯的展示区。

![An illustration that shows compact leading and trailing presentations for a Live Activity of a food delivery app. 一幅示意图，展示了一款食品配送应用实时活动的紧凑前端和后端展示区。](https://docs-assets.developer.apple.com/published/b0abe15dc55826875fcd33b57be94844/expanded-view@2x.png)

When more than one app starts a Live Activity, the system chooses which Live Activities are visible and displays two Live Activities using the minimal presentation for each: One minimal presentation appears attached to the Dynamic Island, while the other appears detached. Additionally, the detached minimal presentation appears on the Lock Screen on iPhone in StandBy. If your app starts more than one Live Activity at the same time, you can tell the system which one it should display by setting a relevance score. For more information, refer to the “Configure the Live Activity” section below.

当多个应用启动实时活动时，系统会选择哪些实时活动可见，并使用极简展示区显示两个实时活动：一个极简展示区附着在灵动岛区域，另一个则与之分离。此外，分离的极简展示区会显示在处于待机模式的 iPhone 的锁定屏幕上。如果你的应用同时启动了多个实时活动，你可以通过设置相关性得分来告知系统应该显示哪一个。更多信息，请参阅下面的《配置实时活动》部分。

![An illustration of the Dynamic Island with a Live Activity that appears in the minimal presentation.一幅灵动岛的示意图，其中一个实时活动以简约展示界面呈现。](https://docs-assets.developer.apple.com/published/c97586d2d3296e4c0b95c6a59c3d5127/minimal-view@2x.png)

The following example shows how the [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) app provides the required compact and minimal presentations. For the leading presentation, it reuses the custom SwiftUI view Avatar. For the trailing presentation, it uses a [ProgressView](https://developer.apple.com/documentation/SwiftUI/ProgressView).

以下示例展示了《[表情符号别动队：支持实时活动、交互性和动画](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations)》应用如何提供所需的紧凑和极简展示区。对于前端展示区，它复用了自定义的 SwiftUI 视图 `Avatar`。对于后端展示区，它使用了 [ProgressView](https://developer.apple.com/documentation/SwiftUI/ProgressView)。

```
import SwiftUI
import WidgetKit


struct AdventureActivityConfiguration: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AdventureAttributes.self) { context in
            // Create the presentation that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            // 创建出现在锁定屏幕以及不支持灵动岛的设备主屏幕上的横幅展示内容。
            // ...
        } dynamicIsland: { context in
            // Create the presentations that appear in the Dynamic Island.
            // 创建出现在灵动岛中的展示内容。
            DynamicIsland {
                // Create the expanded presentation.
                // 创建扩展展示区。
                // ...
            } compactLeading: {
                // Create the compact leading presentation.
                // 创建紧凑前端展示区。
                Avatar(hero: context.attributes.hero, includeBackground: true)
                    .accessibilityLabel("The avatar of \(context.attributes.hero.name).")
            } compactTrailing: {
                // Create the compact trailing presentation.
                // 创建紧凑后端展示区。
                ProgressView(value: context.state.currentHealthLevel, total: 1) {
                    let healthLevel = Int(context.state.currentHealthLevel * 100)
                    Text("\(healthLevel)")
                        .accessibilityLabel("Health level at \(healthLevel) percent.")
                }
                .progressViewStyle(.circular)
                .tint(context.state.currentHealthLevel <= 0.2 ? Color.red : Color.green)
            } minimal: {
                // Create the minimal presentation.
                // 创建极简展示区
                // ...
            }           
        }
    }
}
```

## 9 Create the expanded presentation 创建扩展展示区

In addition to the compact and minimal presentations, you must support the expanded presentation. It appears when a person touches and holds a compact or minimal presentation, and it also appears briefly for Live Activity updates.

除了紧凑和极简展示区外，你必须支持扩展展示区。当用户长按紧凑或极简展示区时，会显示扩展展示区，并且在实时活动更新时也会短暂显示。

![An illustration of the Dynamic Island with a Live Activity that appears in the expanded presentation.一幅灵动岛的示意图，其中一个实时活动以扩展展示区呈现。](https://docs-assets.developer.apple.com/published/b0abe15dc55826875fcd33b57be94844/expanded-view@2x.png)

Use the [DynamicIslandExpandedRegionPosition](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition) to specify detailed instructions where you want SwiftUI to position your content. The following example shows how the [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) app creates its expanded presentation using a [DynamicIslandExpandedContentBuilder](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedContentBuilder):

使用 [DynamicIslandExpandedRegionPosition](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition) 来指定你希望 SwiftUI 放置内容的详细位置。以下示例展示了《[表情符号别动队：支持实时活动、交互性和动画](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations)》应用如何使用 [DynamicIslandExpandedContentBuilder](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedContentBuilder) 创建其扩展展示区：

```
struct AdventureActivityConfiguration: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AdventureAttributes.self) { context in
            // Create the presentation that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            // 创建出现在锁定屏幕以及不支持灵动岛的设备主屏幕上的横幅展示内容。
            // ...
        } dynamicIsland: { context in
            // Create the presentations that appear in the Dynamic Island.
            // 创建出现在灵动岛中的展示内容。
            DynamicIsland {
                // Create the expanded presentation.
                // 创建扩展展示区。
                expandedContent(
                    hero: context.attributes.hero,
                    contentState: context.state,
                    isStale: context.isStale
                )
            } compactLeading: {
                // Create the compact leading presentation.
                // 创建紧凑前端展示区。
                // ...
            } compactTrailing: {
                // Create the compact trailing presentation.
                // 创建紧凑后端展示区。
                // ...
            } minimal: {
                // Create the minimal presentation.
                // 创建极简展示区。
                // ...
            }
        }
    }
    
    @DynamicIslandExpandedContentBuilder
    private func expandedContent(hero: EmojiRanger,
                                 contentState: AdventureAttributes.ContentState,
                                 isStale: Bool) -> DynamicIslandExpandedContent<some View> {
        DynamicIslandExpandedRegion(.leading) {
            LiveActivityAvatarView(hero: hero)
        }
        
        DynamicIslandExpandedRegion(.trailing) {
            StatsView(
                hero: hero,
                isStale: isStale
            )
        }
        
        DynamicIslandExpandedRegion(.bottom) {
            HealthBar(currentHealthLevel: contentState.currentHealthLevel)
            
            EventDescriptionView(
                hero: hero,
                contentState: contentState
            )
        }
    }
}
```

To render views that appear in the expanded Live Activity, the system divides the expanded presentation into different areas. Note how the example returns a [DynamicIsland](https://developer.apple.com/documentation/WidgetKit/DynamicIsland) that specifies several [DynamicIslandExpandedRegion](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegion) objects. Pass the following [DynamicIslandExpandedRegionPosition](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition) values to lay out your content at a specified position in the expanded presentation:

- [center](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/center) places content below the TrueDepth camera.

- [leading](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/leading) places content along the leading edge of the expanded Live Activity next to the TrueDepth camera and wraps additional content below it.

- [trailing](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/trailing) places content along the trailing edge of the expanded Live Activity next to the TrueDepth camera and wraps additional content below it.

- [bottom](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/bottom) places content below the leading, trailing, and center content.

为了渲染扩展实时活动中显示的视图，系统会将扩展展示界面划分为不同的区域。注意示例中如何返回一个指定了多个 [DynamicIslandExpandedRegion](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegion) 对象的 [DynamicIsland](https://developer.apple.com/documentation/WidgetKit/DynamicIsland)。传递以下 [DynamicIslandExpandedRegionPosition](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition) 值，以在扩展展示界面的指定位置布局你的内容：

- [center](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/center)：将内容放置在原深感摄像头下方。
- [leading](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/leading)：将内容沿着扩展实时活动的前置边缘放置在原深感摄像头旁边，并将额外内容换行显示在其下方。
- [trailing](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/trailing)：将内容沿着扩展实时活动的后置边缘放置在原深感摄像头旁边，并将额外内容换行显示在其下方。
- [bottom](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionPosition/bottom)：将内容放置在前置、后置和中心内容的下方。

![An illustration that shows the center, leading, trailing, and bottom positions for content for the expanded presentation in the Dynamic Island.一幅示意图，展示了灵动岛扩展展示区中内容的 center、leading、trailing 和 bottom 位置。](https://docs-assets.developer.apple.com/published/dec913bb4b4e8771fc8e55dbd4bdfb41/expanded-layout@2x.png)

To render content that appears in the expanded Live Activity, the system first determines the width of the center content while taking into account the minimal width of the leading and trailing content. The system then places and sizes the leading and trailing content based on its vertical position. By default, leading and trailing positions receive an equal amount of horizontal space.

为了渲染扩展实时活动中显示的内容，系统首先会在考虑前置和后置内容最小宽度的情况下确定中心内容的宽度。然后，系统会根据前置和后置内容的垂直位置来放置和调整其大小。默认情况下，前置和后置位置会获得相等的水平空间。

You can tell the system to prioritize one of the `DynamicIslandExpandedRegion` views by passing a priority to the [init(_:priority:content:)](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegion/init(_:priority:content:)) initializer. The system renders the view with the highest priority with the full width of the Dynamic Island. The following illustration shows leading and trailing positions in an expanded presentation with higher priority to render them below the TrueDepth camera.

你可以通过向 [init(_:priority:content:)](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegion/init(_:priority:content:)) 初始化器传递优先级，告诉系统对某个 `DynamicIslandExpandedRegion` 视图进行优先级排序。系统会以灵动岛的全宽渲染优先级最高的视图。以下示意图展示了扩展展示界面中具有更高优先级的前置和后置位置，以便将它们渲染在原深感摄像头下方。

![An illustration that shows the leading and trailing positions in an expanded presentation with higher priority to render them below the TrueDepth camera.一幅示意图，展示了扩展展示区中具有更高优先级的前置和后置位置，以便将它们渲染在原深感摄像头下方。](https://docs-assets.developer.apple.com/published/4b407ed4d7c0d68a5ebf2c41cb18b014/expanded-sections@2x.png)

> **Note** **注意**
>
> If content is too wide to appear in a leading position next to the TrueDepth camera, use the [belowIfTooWide](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionVerticalPlacement/belowIfTooWide) modifier to render leading content below the TrueDepth camera.
> 
> 如果内容太宽，无法显示在原深感摄像头旁边的前置位置，可以使用 [belowIfTooWide](https://developer.apple.com/documentation/WidgetKit/DynamicIslandExpandedRegionVerticalPlacement/belowIfTooWide) 修饰符将前置内容渲染在原深感摄像头下方。

## 10 Customize Live Activities in the Smart Stack on watchOS 在 watchOS 的智能叠放中自定义实时活动

Starting with iOS 18 and watchOS 11, Live Activities appear in the Smart Stack on Apple Watch automatically. Updates to your Live Activity on iOS are also automatically sent to Apple Watch. Review your current views to ensure that you’re displaying dynamically updated information that keeps people informed about the state of the activity.

从 iOS 18 和 watchOS 11 开始，实时活动会自动显示在 Apple Watch 的智能叠放中。你在 iOS 上对实时活动所做的更新也会自动同步到 Apple Watch。请检查你当前的视图，确保展示的是动态更新的信息，让用户随时了解活动状态。

- On iOS, alerting updates animate to display your Dynamic Island Expanded Views. When someone’s Apple Watch receives a Live Activity update, the system automatically launches the Smart Stack, displays your alert, and then shows your Live Activity.

- 在 iOS 上，带有提醒的更新会通过动画展示灵动岛的扩展视图。当用户的 Apple Watch 收到实时活动更新时，系统会自动打开智能叠放，显示提醒，然后展示实时活动。

- If your app is in the foreground, a banner displays at the bottom of the Apple Watch screen with your Dynamic Island compact view.

- 如果你的应用处于前台，Apple Watch 屏幕底部会以横幅形式显示灵动岛的紧凑视图。

- Tapping a Live Activity on Apple Watch shows a full-screen presentation with an option to open the app on iPhone. If your app has a watch app version, you can opt to open your app on watch with a tap on the Live Activity in the Smart Stack.

- 在 Apple Watch 上点击实时活动，会全屏展示活动内容，同时提供一个选项，可用于在 iPhone 上打开该应用。如果你的应用有 Apple Watch 版本，用户在智能叠放中点击实时活动时，你可以选择直接在 Apple Watch 上打开应用。

Provide a custom Live Activity view for Apple Watch using [supplementalActivityFamilies(_:)](https://developer.apple.com/documentation/SwiftUI/WidgetConfiguration/supplementalActivityFamilies(_:)) with a `.small` view modifier. Customize your content view for the Smart Stack using the [activityFamily](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/activityFamily) environment value. For watchOS, use `small` to provide an appropriate view for the Smart Stack. For the iOS Lock Screen, use `medium`.

你可以使用 [supplementalActivityFamilies(_:)](https://developer.apple.com/documentation/SwiftUI/WidgetConfiguration/supplementalActivityFamilies(_:)) 和 `.small` 视图修饰符为 Apple Watch 提供自定义的实时活动视图。使用 [activityFamily](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/activityFamily) 环境值，为智能叠放自定义内容视图。对于 watchOS，使用 `small` 为智能叠放提供合适的视图；对于 iOS 锁定屏幕，则使用 `medium`。

The code below uses `supplementalactivityfamilies(_:)` to specify the size of the Live Activity for devices that use iOS and watchOS.

下面的代码使用 `supplementalActivityFamilies(_:)` 为使用 iOS 和 watchOS 的设备指定实时活动的尺寸。

```
// A RideSharingActivity that supports the watchOS Smart Stack and the iOS Lock Screen.
// 一个支持 watchOS 智能叠放和 iOS 锁定屏幕的 RideSharingActivity（拼车活动）。
struct RideSharingActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RideAttributes.self) { context in
            RideSharingView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.bottom) {
                    RideShareDetails()
                }
            } compactLeading: {
                AppLogo()
            } compactTrailing: {
                ETAView()
            } minimal: {
                ETAView()
            }
        }
        .supplementalActivityFamilies([.small, .medium])
    }
}
```

You can opt-in to give people the ability to open your Watch app from your Live Activity. In the Build Settings for your Watch app target, add a value for the `Supports Launch for Live Activity Attribute Types` key in the `Info.plist` section. To launch your Watch app for all your Live Activities, leave the value empty. To launch for specific Live Activities, add an item for each `ActivityAttributes` conforming type that launches your Watch app.

你可以选择让用户能够从实时活动中打开你的 Apple Watch 应用。在 Apple Watch 应用目标的构建设置中，在 `Info.plist` 部分的 `Supports Launch for Live Activity Attribute Types` 键添加值。若要让所有实时活动都能打开你的 Apple Watch 应用，该值留空即可；若只想让特定的实时活动打开应用，则为每个符合 `ActivityAttributes` 的类型添加一个条目。

## 11 Set custom content margins 设置自定义内容边距

Limiting the content you display is key to offering glanceable, easy-to-read Live Activities. Aim to use the system’s default content margins for your Live Activities and only show content that’s relevant to the person viewing it. However, you may want to change the system’s default content margin to display more content or provide a custom user interface that matches your app. To set custom content margins, use [contentMargins(_:_:for:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/contentMargins(_:_:for:)). The following example results in a margin of eight points for the trailing edge of an expanded Live Activity.

限制展示的内容是提供一目了然、易于阅读的实时活动的关键。建议实时活动使用系统默认的内容边距，并且只展示与查看者相关的内容。不过，你可能想要更改系统默认的内容边距，以便展示更多内容，或者提供与应用相匹配的自定义用户界面。要设置自定义内容边距，可使用 [contentMargins(_:_:for:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/contentMargins(_:_:for:))。以下示例为扩展实时活动的后端边缘设置了 8 点的边距。

```
struct AdventureActivityConfiguration: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AdventureAttributes.self) { context in
            // Create the presentation that appears on the Lock Screen and as a
            // banner on the Home Screen of devices that don't support the
            // Dynamic Island.
            // 创建出现在锁定屏幕以及不支持灵动岛的设备主屏幕上的横幅展示内容。
            // ...
        } dynamicIsland: { context in
            // Create the presentations that appear in the Dynamic Island.
            // 创建出现在灵动岛中的展示内容。
            DynamicIsland {
                // Create the expanded presentation.
                // 创建扩展展示区。
                // ...
            } compactLeading: {
                // Create the compact leading presentation.
                // 创建紧凑前端展示区。
                // ...
            } compactTrailing: {
                // Create the compact trailing presentation.
                // 创建紧凑后端展示区。
                // ...
            } minimal: {
                // Create the minimal presentation.
                // 创建极简展示区。
                // ...
            }
            .contentMargins(.trailing, 8, for: .expanded)
        }
    }
}
```

If you repeatedly use the `contentMargins(_:_:for:)` modifier, the system uses the innermost specified values for a mode.

如果你多次使用 `contentMargins(_:_:for:)` 修饰符，系统会采用针对某种模式所指定的最内层的值。

> **Note** **注意**
>
> Avoid placing content too close to the edges of the Dynamic Island.
> 
> 避免将内容放置得离灵动岛边缘过近。

## 12 Use custom colors 使用自定义颜色

Live Activities in the Dynamic Island use a black background color with white text. Use the [keylineTint(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/keylineTint(_:)) modifier to apply a subtle tint color to the border of the Dynamic Island when the device is in Dark Mode and change text color as needed.

灵动岛中的实时活动默认采用黑色背景和白色文字。当设备处于深色模式时，你可以使用 [keylineTint(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/keylineTint(_:)) 修饰符为灵动岛的边框添加一种柔和的色调，并根据需要更改文字颜色。

> **Note** **注意**
>
> You can’t change the background color of Live Activities in the Dynamic Island.
> 
> 你无法更改灵动岛中实时活动的背景颜色。

By default, the Lock Screen presentation — including the banner that appears on devices that don’t support the Dynamic island — uses a solid white background color in Light Mode and a solid black background color in Dark Mode. To set a custom background color for the Lock Screen presentation, use the [activityBackgroundTint(_:)](https://developer.apple.com/documentation/SwiftUI/View/activityBackgroundTint(_:)) modifier. Be sure to choose a color that works well in both Dark or Light Mode or use different background colors that best fit each appearance. To set the translucency of the custom background color, use the [opacity(_:)](https://developer.apple.com/documentation/SwiftUI/Color/opacity(_:)) view modifier or specify an opaque background color.

默认情况下，锁定屏幕展示区（包括不支持灵动岛的设备上出现的横幅）在浅色模式下使用纯白色背景，在深色模式下使用纯黑色背景。若要为锁定屏幕展示区设置自定义背景颜色，可使用 [activityBackgroundTint(_:)](https://developer.apple.com/documentation/SwiftUI/View/activityBackgroundTint(_:)) 修饰符。务必选择一种在深色和浅色模式下都适用的颜色，或者针对不同的显示模式使用最合适的背景颜色。若要设置自定义背景颜色的透明度，可使用 [opacity(_:)](https://developer.apple.com/documentation/SwiftUI/Color/opacity(_:)) 视图修饰符，或者指定不透明的背景颜色。

If you choose a custom background color for the Lock Screen presentation, use the [activitySystemActionForegroundColor(_:)](https://developer.apple.com/documentation/SwiftUI/View/activitySystemActionForegroundColor(_:)) view modifier to customize the text color of the auxiliary button that allows people to end the Live Activity on the Lock Screen.

如果你为锁定屏幕展示界面选择了自定义背景颜色，可以使用 [activitySystemActionForegroundColor(_:)](https://developer.apple.com/documentation/SwiftUI/View/activitySystemActionForegroundColor(_:)) 视图修饰符来定制辅助按钮的文字颜色，该按钮可让用户在锁定屏幕上结束实时活动。

> **Note** ****
>
> On devices that include an Always-On display, the system dims the screen to preserve battery life and renders Live Activities on the Lock Screen as if in Dark Mode. Use SwiftUI’s [isLuminanceReduced](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/isLuminanceReduced) environment value to detect reduced luminance on devices with an Always-On display and use colors and images that look great with reduced luminance.
> 
> 在配备全天候显示屏的设备上，系统会调暗屏幕以节省电量，并且会将锁定屏幕上的实时活动渲染成深色模式下的效果。你可以使用 SwiftUI 的 [isLuminanceReduced](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/isLuminanceReduced) 环境值来检测全天候显示屏设备上的亮度降低情况，并使用在低亮度下显示效果良好的颜色和图像。

## 13 Create a deep link into your app 创建指向应用的深度链接

People tap a Live Activity to launch your app. To improve the user experience, you can use [widgetURL(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/widgetURL(_:)) to create a deep link into your app from the Lock Screen, compact leading, compact trailing, and minimal presentations. When the compact leading and trailing presentations are visible, make sure both link to the same screen in your app.

用户点击实时活动即可启动你的应用。为了提升用户体验，你可以使用 [widgetURL(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/widgetURL(_:)) 从锁定屏幕、紧凑前置、紧凑后置以及极简展示区创建指向你应用的深度链接。当紧凑前置和后置展示区可见时，要确保它们都链接到你应用中的同一屏幕。

The expanded presentation offers additional options to create deep links into your app for more utility using SwiftUI’s [Link](https://developer.apple.com/documentation/SwiftUI/Link).

扩展展示区提供了更多选择，可使用 SwiftUI 的 [Link](https://developer.apple.com/documentation/SwiftUI/Link) 创建指向你应用的深度链接，以增加更多实用功能。

If you don’t explicitly provide a deep link into your app with [widgetURL(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/widgetURL(_:)) or [Link](https://developer.apple.com/documentation/SwiftUI/Link), the system launches your app and passes a [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) object to the [scene(_:willContinueUserActivityWithType:)](https://developer.apple.com/documentation/UIKit/UISceneDelegate/scene(_:willContinueUserActivityWithType:)) and [scene(_:continue:)](https://developer.apple.com/documentation/UIKit/UISceneDelegate/scene(_:continue:)) callbacks. Implement both callbacks and check whether the `NSUserActivity` object’s [activityType](https://developer.apple.com/documentation/foundation/nsuseractivity/1409611-activitytype) is [NSUserActivityTypeLiveActivity](https://developer.apple.com/documentation/WidgetKit/NSUserActivityTypeLiveActivity), and add code to open a screen in your app that fits the context of the active Live Activity.

如果你没有使用 [widgetURL(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/widgetURL(_:)) 或 [Link](https://developer.apple.com/documentation/SwiftUI/Link) 明确提供指向你应用的深度链接，系统会启动你的应用，并将一个 [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) 对象传递给 [scene(_:willContinueUserActivityWithType:)](https://developer.apple.com/documentation/UIKit/UISceneDelegate/scene(_:willContinueUserActivityWithType:)) 和 [scene(_:continue:)](https://developer.apple.com/documentation/UIKit/UISceneDelegate/scene(_:continue:)) 回调函数。你需要实现这两个回调函数，并检查 `NSUserActivity` 对象的 [activityType](https://developer.apple.com/documentation/foundation/nsuseractivity/1409611-activitytype) 是否为 [NSUserActivityTypeLiveActivity](https://developer.apple.com/documentation/WidgetKit/NSUserActivityTypeLiveActivity)，然后添加代码以打开你应用中与活跃实时活动上下文相匹配的屏幕。

For additional information about deep linking into your app, refer to [Linking to specific app scenes from your widget or Live Activity](https://developer.apple.com/documentation/WidgetKit/Linking-to-specific-app-scenes-from-your-widget-or-Live-Activity).

有关创建指向你应用的深度链接的更多信息，请参阅《[从小组件或实时活动链接到特定的应用场景](https://developer.apple.com/documentation/WidgetKit/Linking-to-specific-app-scenes-from-your-widget-or-Live-Activity)》。

## 14 Add Buttons or Toggles 添加按钮或切换开关

Like widgets, starting with iOS 17 and iPadOS 17, Live Activities can contain SwiftUI buttons and toggles to provide quick actions. For example, a food-ordering app might show a button in its Live Activity that people tap to check in at a restaurant when they pick up a takeout order.

从 iOS 17 和 iPadOS 17 开始，和小组件一样，实时活动也可以包含 SwiftUI 按钮和切换开关，以提供快速操作。例如，一个订餐应用可能会在其实时活动中显示一个按钮，用户点击该按钮就可以在取外卖订单时在餐厅进行签到。

To add a toggle or button to a Live Activity, adopt the [App Intents](https://developer.apple.com/documentation/AppIntents) framework and use the initializers for Button and Toggle that take an app intent. For more information about using toggles and buttons in widget extensions, including for Live Activities, refer to [WidgetKit](https://developer.apple.com/documentation/WidgetKit).

要在实时活动中添加切换开关或按钮，需要采用 [App Intents](https://developer.apple.com/documentation/AppIntents) 框架，并使用接受应用意图的 Button 和 Toggle 初始化方法。关于在小组件扩展（包括实时活动）中使用切换开关和按钮的更多信息，请参考 [WidgetKit](https://developer.apple.com/documentation/WidgetKit)。

## 15 Provide accessibility labels 提供无障碍标签

Designing with accessibility in mind is a foundational principle when creating an app. It also applies to Live Activities. To allow people to customize how they interact with your Live Activity and to make sure VoiceOver for your Live Activity works correctly, add accessibility labels for the SwiftUI views you create for each Live Activity presentation. For more information, refer to Adding accessible descriptions to widgets and Live Activities.

在开发应用时，将无障碍设计理念融入其中是一项基本原则，这同样适用于实时活动。为了让用户能够自定义与实时活动的交互方式，并确保实时活动的语音旁白功能正常工作，要为你为每个实时活动展示界面创建的 SwiftUI 视图添加无障碍标签。更多信息请参考《[为小组件和实时活动添加无障碍描述](https://developer.apple.com/documentation/activitykit/adding-accessible-descriptions-to-widgets-and-live-activities)》。

## 16 Make sure Live Activities are available 确保实时活动可用

Live Activities are available on iPhone and iPad. If your app is available on additional platforms and offers a widget extension, make sure Live Activities are available at runtime. Additionally, people can choose to deactivate Live Activities for an app in the Settings app.

实时活动在 iPhone 和 iPad 上可用。如果您的应用在其他平台上也可用，并且提供小组件扩展，请确保实时活动在运行时可用。此外，用户可以选择在 “设置” 应用中停用某个应用的实时活动。

To refer to if Live Activities are available and if a person allowed your app to use Live Activities:

- Use [areActivitiesEnabled](https://developer.apple.com/documentation/activitykit/activityauthorizationinfo/areactivitiesenabled) to synchronously determine whether to show a user interface in your app for starting a Live Activity.

- Receive asynchronous user authorization updates by observing any user authorization changes with the [activityEnablementUpdates](https://developer.apple.com/documentation/activitykit/activityauthorizationinfo/activityenablementupdates-swift.property) stream and respond to them accordingly.

要判断实时活动是否可用以及用户是否允许您的应用使用实时活动：

- 使用 [areActivitiesEnabled](https://developer.apple.com/documentation/activitykit/activityauthorizationinfo/areactivitiesenabled) 同步确定是否在您的应用中显示用于启动实时活动的用户界面。
- 通过使用 [activityEnablementUpdates](https://developer.apple.com/documentation/activitykit/activityauthorizationinfo/activityenablementupdates-swift.property) 流观察用户授权的任何更改，来接收异步的用户授权更新，并据此做出响应。

> **Note** **注意**
>
> An app can start several Live Activities, and a device can run Live Activities from several apps — the exact number may depend on a variety of factors. In addition to making sure Live Activities are available, always handle any errors gracefully when starting, updating, or ending a Live Activity. For example, starting a Live Activity may fail because a person’s device may have reached its limit of active Live Activities.
> 
> 一个应用可以启动多个实时活动，一台设备也可以运行来自多个应用的实时活动，具体数量可能取决于多种因素。除了确保实时活动可用之外，在启动、更新或结束实时活动时，始终要妥善处理任何错误。例如，启动实时活动可能会失败，因为用户设备上的活动实时活动数量可能已达到上限。

## 17 Configure the Live Activity 配置实时活动

Before you can start a Live Activity in your app, configure it with an [ActivityContent](https://developer.apple.com/documentation/activitykit/activitycontent) structure. The activity content encapsulates the [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) and additional configuration information:

- The staleDate tells the system when the Live Activity content becomes outdated.

- The relevanceScore determines which of your Live Activities appears in the Dynamic Island and the order of your Live Activities on the Lock Screen.

在应用中启动实时活动之前，需使用 [ActivityContent](https://developer.apple.com/documentation/activitykit/activitycontent) 结构体对其进行配置。活动内容封装了 [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) 以及其他配置信息：

- [staleDate](https://developer.apple.com/documentation/activitykit/activitycontent/staledate)（过期日期）告知系统实时活动内容何时过期。
- [relevanceScore](https://developer.apple.com/documentation/activitykit/activitycontent/relevancescore)（相关性分数）决定您的实时活动中哪些会出现在灵动岛，以及它们在锁定屏幕上的显示顺序。

While setting the `staleDate` is optional, it’s helpful when you want to ensure your Live Activity doesn’t display outdated content. At the specified date, the [activityState](https://developer.apple.com/documentation/activitykit/activity/activitystate) changes to [ActivityState.stale](https://developer.apple.com/documentation/activitykit/activitystate/stale) and [isStale](https://developer.apple.com/documentation/WidgetKit/ActivityViewContext/isStale) changes to `true`. Access [isStale](https://developer.apple.com/documentation/WidgetKit/ActivityViewContext/isStale) to monitor the activity state and respond to outdated Live Activities that haven’t received updates. For example, while a person has network connectivity, a sports app could update the Live Activity with the latest game information and advance the stale date. If a person enters an area without network connectivity, the app can’t update the Live Activity with new information and an advanced stale date. Eventually, the Live Activity becomes stale and displays text to indicate that the displayed information is outdated. On the next app launch or when it performs background tasks, the app can also respond to the [ActivityState.stale](https://developer.apple.com/documentation/activitykit/activitystate/stale) state.

虽然设置 `staleDate` 是可选的，但如果您希望确保实时活动不显示过时内容，这会很有帮助。在指定日期，[activityState](https://developer.apple.com/documentation/activitykit/activity/activitystate) 会变为 [ActivityState.stale](https://developer.apple.com/documentation/activitykit/activitystate/stale) 而且 [isStale](https://developer.apple.com/documentation/WidgetKit/ActivityViewContext/isStale) 会变为 `true`。通过访问 [isStale](https://developer.apple.com/documentation/WidgetKit/ActivityViewContext/isStale) 来监控活动状态，并对未收到更新的过时实时活动做出响应。例如，当用户有网络连接时，体育类应用可以用最新的比赛信息更新实时活动，并延长过期日期。如果用户进入无网络连接的区域，应用无法用新信息和延长的过期日期来更新实时活动。最终，实时活动会过期，并显示文本表明所显示的信息已过时。在下一次应用启动或执行后台任务时，应用也可以对 [ActivityState.stale](https://developer.apple.com/documentation/activitykit/activitystate/stale) 状态做出响应。

If your app starts more than one Live Activity, provide a relevance score to determine the order of your Live Activities on the Lock Screen and which of your Live Activities appears in the Dynamic Island:

- If you don’t provide a relevance score or if Live Activities have the same relevance score, the system shows the first Live Activity you started in the Dynamic Island.

- If you use different relevance scores, the system shows the Live Activity with the highest relevance score in the Dynamic Island.

如果您的应用启动多个实时活动，可提供相关性分数来确定它们在锁定屏幕上的顺序以及哪些实时活动会出现在灵动岛：

- 如果您不提供相关性分数，或者多个实时活动具有相同的相关性分数，系统会在灵动岛中显示您最先启动的实时活动。
- 如果您使用不同的相关性分数，系统会在灵动岛中显示相关性分数最高的实时活动。

The system expects relative values for the relevance score. Assign a higher value for an important Live Activity content update — for example, a score of `100` — and use lower values for less important Live Activity content updates — for example, 50.

系统将相关性分数设计为一个相对值。为重要的实时活动内容更新分配较高的值，例如 `100`；为不太重要的实时活动内容更新使用较低的值，例如 `50`。

> **Note** **注意**
>
> Keep track of the relevance scores you assign for each ongoing Live Activity so you can change the order of them as needed with each Live Activity update.
> 
> 持续记录为每个正在进行的实时活动分配的相关性分数，以便在每次实时活动更新时根据需要更改它们的顺序。

## 18 Start the Live Activity 启动实时活动

You start a Live Activity in your app’s code while the app is in the foreground with the [request(attributes:content:pushType:)](https://developer.apple.com/documentation/activitykit/activity/request(attributes:content:pushtype:)) function. Pass the `ActivityAttributes` and `ActivityContent` objects you created to it and, if you implement ActivityKit push notifications, the `pushType` parameter.

当应用处于前台时，你可以在应用代码中使用 [request(attributes:content:pushType:)](https://developer.apple.com/documentation/activitykit/activity/request(attributes:content:pushtype:)) 函数来启动实时活动。将你创建的 `ActivityAttributes` 和 `ActivityContent` 对象传递给该函数，如果你实现了 ActivityKit 推送通知，还需传递 `pushType` 参数。

The following example from the [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) app creates the initial attributes and content state for the Emoji Rangers Live Activity.

以下示例来自《[表情符号别动队：支持实时活动、交互性和动画](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations)》应用，它为表情符号别动队实时活动创建了初始属性和内容状态。

```
if ActivityAuthorizationInfo().areActivitiesEnabled {
    do {
        let adventure = AdventureAttributes(hero: hero)
        let initialState = AdventureAttributes.ContentState(
            currentHealthLevel: hero.healthLevel,
            eventDescription: "Adventure has begun!"
        )
        
        let activity = try Activity.request(
            attributes: adventure,
            content: .init(state: initialState, staleDate: nil),
            pushType: .token
        )
        
        self.setup(withActivity: activity)
    } catch {
        errorMessage = """
				    Couldn't start activity
				    ------------------------
				    \(String(describing: error))
				    """
        
        self.errorMessage = errorMessage
    }
}
```

Your app can only start Live Activities while it’s in the foreground. However, you can update or end a Live Activity from your app while it runs in the background — for example, by using [Background Tasks](https://developer.apple.com/documentation/BackgroundTasks).

你的应用只能在前台运行时启动实时活动。不过，当应用在后台运行时，你可以对实时活动进行更新或结束操作，例如通过使用[后台任务](https://developer.apple.com/documentation/BackgroundTasks)来实现。

Additionally, you can enable Live Activity updates with ActivityKit push notifications. Pass .token as a value the pushType parameter as shown in the example above, and implement your remote notification server. Starting with iOS 17.2 and iPadOS 17.2, you can also start Live Activities with ActivityKit push notifications. For more information on using ActivityKit push notifications, refer to [Starting and updating Live Activities with ActivityKit push notifications](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications).

此外，你可以借助 ActivityKit 推送通知来实现实时活动的更新。如上述示例所示，将 `.token` 作为值传递给 `pushType` 参数，并设置好你的远程通知服务器。从 iOS 17.2 和 iPadOS 17.2 开始，你还能够通过 ActivityKit 推送通知来启动实时活动。如需了解更多关于使用 ActivityKit 推送通知的信息，请参考《[通过 ActivityKit 推送通知启动和更新实时活动](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications)》。

## 19 Update the Live Activity 更新实时活动

When you start a Live Activity from your app, update the data that appears in the Live Activity using the [update(_:)](https://developer.apple.com/documentation/activitykit/activity/update(_:)) function of the [Activity](https://developer.apple.com/documentation/activitykit/activity) object you received when you started the Live Activity. To retrieve your app’s active Live Activities, use [activities](https://developer.apple.com/documentation/activitykit/activity/activities).

当你从应用中启动实时活动后，可以使用启动实时活动时获取的 [Activity](https://developer.apple.com/documentation/activitykit/activity) 对象的 [update(_:)](https://developer.apple.com/documentation/activitykit/activity/update(_:)) 函数，来更新实时活动中显示的数据。若要检索应用的活动实时活动，可使用 [activities](https://developer.apple.com/documentation/activitykit/activity/activities)。

For important updates, use the [update(_:alertConfiguration:)](https://developer.apple.com/documentation/activitykit/activity/update(_:alertconfiguration:)) function to display an alert on iPhone, iPad, and a paired Apple Watch that tells a person about new Live Activity content. For example, the [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) app updates its Live Activity using an alert configuration to display an alert that lets people know that the hero has been knocked down:

对于重要更新，可使用 [update(_:alertConfiguration:)](https://developer.apple.com/documentation/activitykit/activity/update(_:alertconfiguration:)) 函数，在 iPhone、iPad 以及配对的 Apple Watch 上显示提醒，告知用户实时活动有新内容。例如，《[表情符号别动队：支持实时活动、交互性和动画](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations)》应用通过提醒配置来更新其实时活动，以显示提醒，告知用户英雄已被击倒：

```
guard let activity = currentActivity else {
    return
}


var alertConfig: AlertConfiguration? = nil
let contentState: AdventureAttributes.ContentState
if alert {
    let heroName = activity.attributes.hero.name
    
    alertConfig = AlertConfiguration(
        title: "\(heroName) has been knocked down!",
        body: "Open the app and use a potion to heal \(heroName).",
        sound: .default
    )
    
    contentState = AdventureAttributes.ContentState(
        currentHealthLevel: 0,
        eventDescription: "\(heroName) has been knocked down!"
    )
} else {
    contentState = AdventureAttributes.ContentState(
        currentHealthLevel: Double.random(in: 0...1),
        eventDescription: self.getEventDescription(hero: activity.attributes.hero)
    )
}


await activity.update(
    ActivityContent<AdventureAttributes.ContentState>(
        state: contentState,
        staleDate: Date.now + 15,
        relevanceScore: alert ? 100 : 50
    ),
    alertConfiguration: alertConfig
)
```

> **Note** **注意**
>
> The size of the updated data can’t exceed 4KB in size. 
> 
> 更新数据的大小不能超过 4KB。

On Apple Watch, the system uses the `title` and `body` attributes for the alert. On iPhone and iPad, the system doesn’t show a regular alert but instead shows the expanded Live Activity in the Dynamic Island or the Lock Screen presentation as a banner on devices without the Dynamic Island.

在 Apple Watch 上，系统会使用提醒的 `title` 和 `body` 属性。在 iPhone 和 iPad 上，系统不会显示常规提醒，而是在灵动岛中显示展开的实时活动，或者在没有灵动岛的设备上，以横幅形式在锁定屏幕展示。

## 20 Animate content updates 为内容更新添加动画

When you define the user interface of your Live Activity, the system ignores any animation modifiers — for example, [withAnimation(_:_:)](https://developer.apple.com/documentation/SwiftUI/withAnimation(_:_:)) and [animation(_:value:)](https://developer.apple.com/documentation/SwiftUI/View/animation(_:value:)) — and uses the system’s animation timing instead. However, the system performs some animation when the dynamic content of the Live Activity changes. Text views animate content changes with blurred content transitions, and the system animates content transitions for images and SF Symbols. If you add or remove views from the user interface based on content or state changes, views fade in and out. Use the following view transitions to configure these built-in transitions: [opacity](https://developer.apple.com/documentation/SwiftUI/AnyTransition/opacity), [move(edge:)](https://developer.apple.com/documentation/SwiftUI/AnyTransition/move(edge:)), [slide](https://developer.apple.com/documentation/SwiftUI/AnyTransition/slide), [push(from:)](https://developer.apple.com/documentation/SwiftUI/AnyTransition/push(from:)), or combinations of them. Additionally, request animations for timer text with [numericText(countsDown:)](https://developer.apple.com/documentation/SwiftUI/ContentTransition/numericText(countsDown:)).

当你定义实时活动的用户界面时，系统会忽略任何动画修饰符，例如 [withAnimation(_:_:)](https://developer.apple.com/documentation/SwiftUI/withAnimation(_:_:)) 和 [animation(_:value:)](https://developer.apple.com/documentation/SwiftUI/View/animation(_:value:))，而是使用系统的动画时间设置。不过，当实时活动的动态内容发生变化时，系统会执行一些动画效果。文本视图会通过模糊内容过渡来为内容变化添加动画，系统会为图像和 SF 符号的内容过渡添加动画。如果你根据内容或状态变化在用户界面中添加或移除视图，视图会淡入淡出。可使用以下视图过渡来配置这些内置过渡：[opacity](https://developer.apple.com/documentation/SwiftUI/AnyTransition/opacity)、[move(edge:)](https://developer.apple.com/documentation/SwiftUI/AnyTransition/move(edge:))、[slide](https://developer.apple.com/documentation/SwiftUI/AnyTransition/slide)、[push(from:)](https://developer.apple.com/documentation/SwiftUI/AnyTransition/push(from:)) 或它们的组合。此外，可使用 [numericText(countsDown:)](https://developer.apple.com/documentation/SwiftUI/ContentTransition/numericText(countsDown:)) 为计时器文本请求动画。

Starting with iOS 17 and iPadOS 17, you can animate data changes in your Live Activity with functions that give you more control over animation timing. For example, you can use [timingCurve(_:duration:)](https://developer.apple.com/documentation/SwiftUI/Animation/timingCurve(_:duration:)) to create an animation with a custom timing curve. For more information on SwiftUI animations, refer to [Animation](https://developer.apple.com/documentation/SwiftUI/Animation).

从 iOS 17 和 iPadOS 17 开始，你可以使用能让你更好控制动画时间的函数，为实时活动中的数据变化添加动画。例如，你可以使用 [timingCurve(_:duration:)](https://developer.apple.com/documentation/SwiftUI/Animation/timingCurve(_:duration:)) 创建具有自定义时间曲线的动画。有关 SwiftUI 动画的更多信息，请参考 [Animation](https://developer.apple.com/documentation/SwiftUI/Animation)。

> **Note** **注意**
>
> On devices that include an Always-On display, the system doesn’t perform animations to preserve battery life in Always On. Make sure to use SwiftUI’s [isLuminanceReduced](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/isLuminanceReduced) environment value to detect reduced luminance before animating content changes.
> 
> 在配备全天候显示屏的设备上，为了在常亮模式下节省电量，系统不会执行动画。在为内容变化添加动画之前，请务必使用 SwiftUI 的 [isLuminanceReduced](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/isLuminanceReduced) 环境值来检测亮度是否降低。

## 21 End the Live Activity 结束实时活动

Always end a Live Activity after the associated task or live event ends. A Live Activity that ended remains on the Lock Screen until the person removes it or the system removes it automatically. The automatic removal depends on the dismissal policy you provide to the [end(_:dismissalPolicy:)](https://developer.apple.com/documentation/activitykit/activity/end(_:dismissalpolicy:)) function. Always include an updated [Activity.ContentState](https://developer.apple.com/documentation/activitykit/activity/contentstate-swift.typealias) to ensure the Live Activity shows the latest and final content update after it ends. This is important because the Live Activity can remain visible on the Lock Screen for some time after it ends.

在相关任务或实时事件结束后，务必结束实时活动。已结束的实时活动会保留在锁定屏幕上，直到用户将其移除或系统自动移除。自动移除取决于你提供给 [end(_:dismissalPolicy:)](https://developer.apple.com/documentation/activitykit/activity/end(_:dismissalpolicy:)) 函数的移除策略。始终要包含更新后的 [Activity.ContentState](https://developer.apple.com/documentation/activitykit/activity/contentstate-swift.typealias)，以确保实时活动在结束后显示最新的最终内容更新。这一点很重要，因为实时活动结束后可能会在锁定屏幕上显示一段时间。

The following example shows how the [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) app ends its Live Activity and sets a custom dismissal policy based on a setting in the app:

以下示例展示了《[表情符号别动队：支持实时活动、交互性和动画](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations)》应用如何结束其实时活动，并根据应用中的设置设置自定义移除策略：

```
func endActivity(dismissTimeInterval: Double?) async {
    guard let activity = currentActivity else {
        return
    }
    
    let hero = activity.attributes.hero
    
    let finalContent = AdventureAttributes.ContentState(
        currentHealthLevel: 1.0,
        eventDescription: "Adventure over! \(hero.name) is taking a nap."
    )
    
    let dismissalPolicy: ActivityUIDismissalPolicy
    if let dismissTimeInterval = dismissTimeInterval {
        if dismissTimeInterval <= 0 {
            dismissalPolicy = .immediate
        } else {
            dismissalPolicy = .after(.now + dismissTimeInterval)
        }
    } else {
        dismissalPolicy = .default
    }
    
    await activity.end(ActivityContent(state: finalContent, staleDate: nil), dismissalPolicy: dismissalPolicy)
}
```

With the [.default](https://developer.apple.com/documentation/activitykit/activityuidismissalpolicy/default) dismissal policy, the Live Activity appears on the Lock Screen for some time after it ends to allow a person to glance at their phone to refer to the latest information. A person can choose to remove the Live Activity at any time, or the system removes it automatically four hours after it ended.

使用 [.default](https://developer.apple.com/documentation/activitykit/activityuidismissalpolicy/default) 移除策略时，已结束的实时活动会在结束后在锁定屏幕上显示一段时间，以便用户可以快速查看最新信息。用户可以随时选择移除实时活动，或者系统会在其结束四小时后自动移除。

To immediately remove the Live Activity that ended from the Lock Screen, use [immediate](https://developer.apple.com/documentation/activitykit/activityuidismissalpolicy/immediate). Alternatively, use [after(_:)](https://developer.apple.com/documentation/activitykit/activityuidismissalpolicy/after(_:)) to specify a date within a four-hour window. While you can provide any date, the system removes the ended Live Activity after the given date or after four hours from the moment the Live Activity ended — whichever comes first.

若要立即从锁定屏幕移除已结束的实时活动，可使用 [.immediate](https://developer.apple.com/documentation/activitykit/activityuidismissalpolicy/immediate)。或者，使用 [.after(_:)](https://developer.apple.com/documentation/activitykit/activityuidismissalpolicy/after(_:)) 在四小时的时间范围内指定一个日期。虽然你可以提供任意日期，但系统会在给定日期之后或实时活动结束后的四小时后移除已结束的实时活动，以先到者为准。

A person can remove your Live Activity from their Lock Screen at any time. This ends the Live Activity, but it doesn’t end or cancel the person’s action that started it. For example, a person may remove the Live Activity for their pizza delivery from the Lock Screen, but this doesn’t cancel the pizza order.

用户可以随时从锁定屏幕移除你的实时活动。这会结束实时活动，但不会结束或取消启动它的用户操作。例如，用户可能会从锁定屏幕移除披萨配送的实时活动，但这不会取消披萨订单。

> **Note** **注意**
>
> When a person or the system removes a Live Activity, its [ActivityState](https://developer.apple.com/documentation/activitykit/activitystate) changes to [ActivityState.dismissed](https://developer.apple.com/documentation/activitykit/activitystate/dismissed).
> 
> 当用户或系统移除实时活动时，其 [ActivityState](https://developer.apple.com/documentation/activitykit/activitystate) 会变为 [ActivityState.dismissed](https://developer.apple.com/documentation/activitykit/activitystate/dismissed)。

## 22 Update or end your Live Activity with a push notification 通过推送通知更新或结束实时活动

In addition to updating and ending a Live Activity from your app with ActivityKit, update or end a Live Activity with an ActivityKit push notification that you send from your server to the Apple Push Notification service (APNs). Starting with iOS 17.2 and iPadOS 17.2, ActivityKit push notifications can also start Live Activities. To learn more about using ActivityKit push notifications, refer to [Starting and updating Live Activities with ActivityKit push notifications](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications).

除了使用 ActivityKit 在应用内更新和结束实时活动之外，你还可以通过从服务器发送到 Apple 推送通知服务 (APNs) 的 ActivityKit 推送通知来更新或结束实时活动。从 iOS 17.2 和 iPadOS 17.2 开始，ActivityKit 推送通知还可以启动实时活动。若要了解有关使用 ActivityKit 推送通知的更多信息，请参阅《[通过 ActivityKit 推送通知启动和更新实时活动](https://developer.apple.com/documentation/activitykit/starting-and-updating-live-activities-with-activitykit-push-notifications)》。

## 23 Keep track of updates 跟踪更新

When you start a Live Activity, ActivityKit returns an [Activity](https://developer.apple.com/documentation/activitykit/activity) object. In addition to the [id](https://developer.apple.com/documentation/activitykit/activity/id-swift.property) that uniquely identifies each activity, the `Activity` offers sequences to observe content, activity state, and push token updates. Use the corresponding sequence to receive updates in your app, keep your app and Live Activities in sync, and respond to changed data:

当你启动实时活动时，ActivityKit 会返回一个 [Activity](https://developer.apple.com/documentation/activitykit/activity) 对象。除了用于唯一标识每个活动的 [id](https://developer.apple.com/documentation/activitykit/activity/id-swift.property) 之外，`Activity` 还提供了一些用于观察内容、活动状态和推送令牌的更新的序列。在应用中使用相应的序列来接收更新，使应用与实时活动保持同步，并对变化的数据做出响应：

- To observe changes to ongoing Live Activities and to asynchronously access a Live Activity when you start it, use [activityUpdates](https://developer.apple.com/documentation/activitykit/activity/activityupdates-swift.type.property).
- 要观察正在进行的实时活动的变化，并在启动实时活动时异步访问它，使用 [activityUpdates](https://developer.apple.com/documentation/activitykit/activity/activityupdates-swift.type.property)。

- To observe the state of an ongoing Live Activity — for example, to determine whether it’s active or has ended — use [activityStateUpdates](https://developer.apple.com/documentation/activitykit/activity/activitystateupdates-swift.property).
- 要观察正在进行的实时活动的状态，例如确定它是处于活动状态还是已结束，使用 [activityStateUpdates](https://developer.apple.com/documentation/activitykit/activity/activitystateupdates-swift.property)。

- To observe changes to the dynamic content of a Live Activity, use [contentUpdates](https://developer.apple.com/documentation/activitykit/activity/contentupdates-swift.property).
- 要观察实时活动动态内容的变化，使用 [contentUpdates](https://developer.apple.com/documentation/activitykit/activity/contentupdates-swift.property)。

- To observe changes to the push token of a Live Activity, use [pushTokenUpdates](https://developer.apple.com/documentation/activitykit/activity/pushtokenupdates-swift.property).
- 要观察实时活动推送令牌的变化，使用 [pushTokenUpdates](https://developer.apple.com/documentation/activitykit/activity/pushtokenupdates-swift.property)。

The following example shows how the [Emoji Rangers: Supporting Live Activities, interactivity, and animations](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations) app tracks updates its content for ongoing Live Activities and updates its adventure view accordingly:

以下示例展示了《[表情符号别动队：支持实时活动、交互性和动画](https://developer.apple.com/documentation/WidgetKit/emoji-rangers-supporting-live-activities-interactivity-and-animations)》应用如何跟踪正在进行的实时活动的内容更新，并相应地更新其冒险视图：

```
// Observe updates for ongoing Live Activities.
Task {
    for await content in activity.contentUpdates {
        self.updateAdventureView(content: content)
    }
}
```

## 24 Observe active Live Activities 观察活动中的实时活动

Your app can start more than one Live Activity. For example, a sports app may allow a person to start a Live Activity for each live sports game they’re interested in. If your app starts multiple Live Activities, keep track of ongoing Live Activities for your app using the [activities](https://developer.apple.com/documentation/activitykit/activity/activities) property to make sure your app is aware of all ongoing Live Activities that ActivityKit tracks. Another use case for fetching all activities is to maintain Live Activities that are in progress and make sure you don’t keep any activities running for longer than needed. For example, the system may stop your app, or your app may crash while a Live Activity is active. When the app launches the next time, check if any activities are still active, update your app’s stored Live Activity data, and end any Live Activity that’s no longer relevant.

你的应用可以启动多个实时活动。例如，一款体育应用可能允许用户为自己感兴趣的每一场体育直播赛事启动一个实时活动。如果你的应用启动了多个实时活动，可使用 [activities](https://developer.apple.com/documentation/activitykit/activity/activities) 属性跟踪应用中正在进行的实时活动，确保你的应用知晓 ActivityKit 所跟踪的所有正在进行的实时活动。获取所有活动的另一个用例是管理正在进行的实时活动，并确保不会让任何活动运行超过必要时长。例如，系统可能会终止你的应用，或者在实时活动处于活动状态时应用可能崩溃。当应用下次启动时，检查是否有任何活动仍处于活动状态，更新应用中存储的实时活动数据，并结束任何不再相关的实时活动。

## 25 Start and stop Live Activities from App Intents 通过应用意图启动和停止实时活动

The App Intents framework enables you to extend your app’s custom functionality to support system-level services like Siri and the Shortcuts app, as well as the functionality to start a Live Activity. For example, a sports app could expose functionality to start a Live Activity for a person’s favorite sports team with the Shortcuts app or Siri.

应用意图框架（App Intents framework）能让你扩展应用的自定义功能，以支持诸如 Siri 和快捷指令应用等系统级服务，还能实现启动实时活动的功能。例如，一款体育应用可以通过快捷指令应用或 Siri，开启为用户喜爱的体育团队启动实时活动的功能。

Starting a Live Activity from an app intent is almost the same as adopting [App Intents](https://developer.apple.com/documentation/AppIntents) to expose other functionality in your app:

1. Adopt the App Intents framework as described in [Making actions and content discoverable and widely available](https://developer.apple.com/documentation/AppIntents/Making-actions-and-content-discoverable-and-widely-available).
2. When you implement your app intent that starts the Live Activity, make sure it inherits from [LiveActivityStartingIntent](https://developer.apple.com/documentation/AppIntents/LiveActivityStartingIntent).
3. In your [LiveActivityStartingIntent](https://developer.apple.com/documentation/AppIntents/LiveActivityStartingIntent) implementation, add code to start the Live Activity.

通过应用意图启动实时活动，与采用应用意图来开放应用内其他功能的方式几乎相同：

1. 按照《[让操作和内容可被发现并广泛可用](https://developer.apple.com/documentation/AppIntents/Making-actions-and-content-discoverable-and-widely-available)》文档中的说明，采用应用意图框架。
2. 在实现启动实时活动的应用意图时，确保它继承自[LiveActivityStartingIntent](https://developer.apple.com/documentation/AppIntents/LiveActivityStartingIntent)。
3. 在 [LiveActivityStartingIntent](https://developer.apple.com/documentation/AppIntents/LiveActivityStartingIntent) 的实现代码中，添加启动实时活动的代码。

# See Also 其他参考

## Live Activity implementation 实时活动实现

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
