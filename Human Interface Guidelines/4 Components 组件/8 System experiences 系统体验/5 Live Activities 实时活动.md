# Live Activities
# 实时活动

原文链接：[https://developer.apple.com/design/human-interface-guidelines/live-activities](https://developer.apple.com/design/human-interface-guidelines/live-activities)

中文链接：[https://developer.apple.com/cn/design/human-interface-guidelines/live-activities](https://developer.apple.com/cn/design/human-interface-guidelines/live-activities)

**A Live Activity displays up-to-date information from your app, allowing people to view the progress of an activity, event, or task at a glance.**

**实时活动显示来自你 App 的最新信息，可让用户一览活动、事件或任务的进度。**

![A stylized representation of the Dynamic Island, in collapsed and expanded form, displaying the score of a live sporting event. The image is tinted red to subtly reflect the red in the original six-color Apple logo.](https://docs-assets.developer.apple.com/published/05e81f3cb457f179fa1343f0753499c7/components-live-activities-intro@2x.png)

![灵动岛的风格化表现形式，以折叠和展开形式显示直播体育赛事的比分。图像呈红色，以巧妙地反映原始六色 Apple 标志中的红色。](https://docs-assets.developer.apple.com/published/6d01bc7166d9522666d515f03d5c9e7a/components-live-activities-intro@2x.png)

Live Activities provide frequent information updates that appear in glanceable locations such as the Lock Screen, on iPhone in StandBy, and the Dynamic Island. Starting in watchOS 11 and iOS 18, Live Activities also appear in the Smart Stack on Apple Watch. For apps with frequent content and status updates that go beyond the existing push notification system, Live Activities can be a more flexible way to keep people updated about live events, activities, or tasks over a couple of hours. In addition to frequently updating displayed data, they offer a way for people to interact with the information.

实时活动会在锁定屏幕、iPhone 上的待机显示和灵动岛等一目了然的位置提供频繁的信息更新。从 watchOS 11 和 iOS 18 开始，实时活动还会显示在 Apple Watch 上的智能叠放中。对于频繁更新内容和状态且不局限于现有推送通知系统的 App 而言，实时活动可作为一种更灵活的方式让用户在几小时内掌握实时事件、活动或任务的更新。除了频繁更新显示的数据外，实时活动还可让用户与信息交互。

For example, the Live Activity of a food delivery app might display the time remaining until your order arrives; a sports app could provide live in-game information for their Live Activity; and a workout app could show real time fitness metrics and offer interactive controls to pause or cancel the workout.

例如，外卖 App 的实时活动可能显示订单送达前的剩余时间，体育赛事 App 的实时活动可以提供进行中赛事的实时信息，体能训练 App 可以显示实时健身指标并提供暂停或取消体能训练的交互式控制。

In addition to appearing at the top of the notification list on the Lock Screen, Live Activities appear in the following locations:

除了显示在锁定屏幕的通知列表顶部外，实时活动还显示在以下位置：

- On devices that support the Dynamic Island, the system displays Live Activities in a persistent location around the TrueDepth camera.

- 在支持灵动岛的设备上，系统会在原深感摄像头周围的固定位置显示实时活动。

- On devices that don’t support the Dynamic Island, the system can display a Live Activity update in a banner that appears briefly at the top of the screen.

- 在不支持灵动岛的设备上，系统会在屏幕顶部短暂出现的横幅中显示实时活动更新。

- On iPhone in StandBy, a Live Activity fills the entire screen to offer glanceable information at a distance, or it takes up minimal space at the top of the screen to leave space for widgets.

- 在 iPhone 上的待机显示中，实时活动会填充整个屏幕以提供从一定距离即可一览的信息，或者占据屏幕顶部的极少空间来为小组件留出空间。

- On Apple Watch, when a Live Activity begins on a connected iPhone, the Smart Stack automatically appears with the Live Activity displayed at the top.

- 当所连接 iPhone 上的实时活动开始时，Apple Watch 上会自动出现在顶部显示实时活动的智能叠放。

## 1 Best practices 最佳实践

**Offer a Live Activity for tasks and live events that have a defined beginning and end.** People use Live Activities to track activities or ongoing tasks of short and medium duration. Don’t offer a Live Activity for a task that exceeds eight hours, and always end a Live Activity immediately after the task completes or the event ends.

**为已定义开始和结束的任务和实时事件提供实时活动。**用户使用实时活动跟踪较短和中等时长的活动或持续任务。请勿为超过八小时的任务提供实时活动，在任务完成或事件结束后应始终立即结束实时活动。

**Consider each Live Activity presentation.** Your Live Activity must support all locations, devices, and their corresponding appearances. Because Live Activities are a system-wide feature, carefully consider the amount of information your Live Activity displays and create a layout that best supports each of the places in the system where it appears.

**考虑每个实时活动展示区。**你的实时活动必须支持所有位置、设备及其对应的外观。因为实时活动是系统范围的功能，因此请仔细考虑实时活动显示的信息量并创建能够良好支持其在系统中每个位置出现的布局。

**Prioritize important information to make it easy to understand at a quick glance.** Your Live Activity doesn’t need to display everything. Think about what information people find most useful and prioritize the size and scale of it relative to other content you display. When a person wants to access more information, they can a tap the Live Activity to view your app where you can display more information if necessary.

**优先显示重要信息，让用户快速看一眼即可轻松了解。**实时活动不必显示所有内容。思考用户觉得最有用的信息，并优先考虑其相对于所显示其他内容的大小和缩放。用户想要访问更多信息时，可以轻点实时活动在 App 中查看你根据需要显示的更多信息。

**Don’t use a Live Activity to display ads or promotions.** Live Activities help people stay informed about ongoing events and tasks, so it’s important to display only information that’s related to those events and tasks.

**请勿使用实时活动显示广告或推广信息。**实时活动有助于用户随时掌握进行中的事件和任务，因此仅显示有关这些事件和任务的信息非常重要。

**Avoid displaying sensitive information in a Live Activity.** A Live Activity is visually prominent and could be viewed by casual observers. If people might consider the information in your Live Activity to be sensitive or private, display an innocuous summary and let people tap the Live Activity to access the sensitive information in your app.

**避免在实时活动中显示敏感信息。实时活动非常显眼，可能会被他人不经意间看到。**如果用户可能认为实时活动中的信息较为敏感或私密，请显示无害的摘要并让用户轻点实时活动以在 App 中访问敏感信息。

**Don’t add elements to your app that draw attention to the Dynamic Island.** Your Live Activity appears in the Dynamic Island while your app isn’t in use, and other items can appear in the Dynamic Island when your app is open.

**不要在 App 中添加引起对灵动岛关注的元素。**当你的 App 未使用时，其实时活动会显示在灵动岛中，而当 App 打开时，其他项目可能会显示在灵动岛中。

### 1.1 Starting, updating, and ending a Live Activity 开始、更新和结束实时活动

**Start a Live Activity when people expect it.** In Settings, people can turn off Live Activities for your app. To make it less likely for someone to turn them off, avoid surprising people by starting a Live Activity they don’t expect. If necessary, give people control over beginning and ending Live Activities with buttons. However, it can make sense to automatically initiate a Live Activity if a person starts a task or event. For example, ordering food for delivery or making a rideshare request could automatically start a Live Activity. Similarly, a sports app could offer a Live Activity that starts automatically for every match of a person’s favorite team. On devices that run iOS 17.2 and iPad OS 17.2 and later, the Live Activity can start with a remote push notification while the app is in the background. If you automatically start a Live Activity, display a button or toggle that represents this behavior and allows people to adjust it to their preferences.

**在用户期望时开始实时活动。**用户可以在“设置”中关闭 App 的实时活动。为了降低用户关闭实时活动的可能性，请避免启动不在用户预期内的实时活动并使其感到意外。根据需要提供按钮，让用户控制实时活动的开始和结束。但是，在用户开始任务或事件后自动开始实时活动在某些情况下十分合理。例如，外卖订餐或叫车后可自动开始实时活动。与之类似，体育赛事 App 可针对用户喜爱的球队为每场比赛提供自动开始的实时活动。在运行 iOS 17.2 和 iPadOS 17.2 及更高版本的设备上，当 App 在后台运行时，实时活动可通过远程推送通知的形式开始。如果自动开始实时活动，请显示一个表示此行为的按钮或开关并允许用户根据其喜好进行调整。

**Offer App Shortcuts that start your Live Activities.** App Shortcuts allow you to expose app functionality to the system so people can access it in various contexts. For example, an App Shortcut that starts your Live Activity allows people to track events using the Action button on iPhone. For more information on App Shortcuts, see [App Shortcuts](https://developer.apple.com/design/human-interface-guidelines/app-shortcuts).

提供开始实时活动的 App 快捷指令。App 快捷指令可让你向系统公开 App 功能，以便用户在各种情况下进行访问。例如，开始实时活动的 App 快捷指令可让用户使用 iPhone 上的操作按钮来跟踪事件。有关 App 快捷指令的更多信息，请参阅《[App 快捷指令](https://developer.apple.com/cn/design/human-interface-guidelines/app-shortcuts)》。

**Update a Live Activity only when new content is available.** If the underlying content or status doesn’t change, show the same content or status until it changes.

**仅在新内容可用时更新实时活动。**如果构成内容或状态并未更改，请在更改前一直显示相同内容或状态。

**Alert people about Live Activity updates only if it’s essential to get their attention.** Live Activity alerts light up the screen and by default play the notification sound for explicit updates the user shouldn’t miss. They also show the expanded presentation in the Dynamic Island or the Lock Screen presentation as a banner on devices that don’t support the Dynamic Island. Avoid alerting people too often or alerting them to updates that aren’t crucial because a person might deactivate Live Activities for your app in Settings. Additionally, don’t use push notifications alongside your Live Activity to alert people about Live Activity updates.

**仅在实时活动更新必须要关注时才提醒用户。**实时活动提醒会点亮屏幕，并默认为用户不应错过的明确更新播放通知声音。同时会在灵动岛中显示扩展式展示区，或者在不支持灵动岛的设备上，在锁定屏幕展示区中以横幅形式显示。避免过于频繁提醒用户或者提醒其无关紧要的更新，因为用户可能在“设置”中停用你 App 的实时活动。另外，不要同时使用推送通知和实时活动来提醒用户实时活动更新。

**If you offer tracking of multiple events, consider cycling through events instead of starting a new Live Activity for each event.** Cycling through events makes it easier for people to keep track of multiple events. For example, a sports app could offer to track all soccer matches that happen in one evening. Instead of starting many Live Activities, the app could update a single Live Activity with key events across all matches like goals, substitutions, fouls, and the start and end of each half in a single dynamic layout.

**如果提供对多个事件的跟踪，请考虑在事件之间循环显示，而非为每个事件开始新的实时活动。**在事件之间循环显示可让用户更容易跟踪多个事件。例如，体育赛事 App 可以跟踪一晚举行的所有足球比赛。该 App 可以在单个实时活动中使用单个动态布局更新所有比赛的关键事件，如进球、换人、犯规情况以及每个半场的开始和结束，而非开始多个实时活动。

**Consider removing the Live Activity from the Lock Screen shortly after the conclusion of your Live Activity.** In the Dynamic Island, the system immediately removes a Live Activity when it ends. On the Lock Screen and in the Smart Stack in watchOS, the system shows a Live Activity for up to four hours after it ends. Depending on the duration of your Live Activity, showing a summary in your Lock Screen presentation may only be relevant for a brief time after it ends. For example, a rideshare app could end the Live Activity when a ride completes and configure it to remain on the Lock Screen for 30 minutes — long enough for people to view the ride summary and leave a tip for the driver. Consider choosing a custom removal time that’s proportional to the duration of your Live Activity. In most cases, 15 to 30 minutes is adequate.

**考虑在实时活动结束后，立即从锁定屏幕移除实时活动。**在灵动岛中，系统会在实时活动结束后立即将其移除。实时活动结束后，系统会在锁定屏幕上和 watchOS 的智能叠放中显示该实时活动最长四小时。在锁定屏幕展示区显示摘要可能仅在实时活动结束后的短时间内相关，具体取决于实时活动的时长。例如，叫车 App 可在行程完结后结束实时活动并将其配置为在锁定屏幕上继续显示 30 分钟，这段时长足以让用户查看行程摘要和打赏司机。考虑选取与实时活动的时长相称的自定义移除时间。大多数情况下，15 到 30 分钟就已足够。

## 2 Design 设计

**Create a Live Activity that matches your app’s visual aesthetic and personality in both dark and light appearances.** Applying your app’s personality and visual aesthetic makes it easier for people to recognize your Live Activity. Aim to create a visual connection to your app with your Live Activity design. For example, consider using your app icon for inspiration.

**创建在深色和浅色外观下与 App 的视觉审美和特性适配的实时活动。** 应用 App 的特性和视觉审美可让用户更轻松辨识你的实时活动。尽量在 App 和实时活动设计之间形成视觉关联。例如，考虑从 App 图标获得灵感。

**If you use a logo mark as part of your brand in a Live Activity, display it without a container.** Don’t use the entire app icon.

**如果在实时活动中使用 logo 作为品牌宣传的一部分，请在不使用容器的情况下显示该标志。**请勿使用整个 App 图标。

**Use a bold color for your Live Activity background.** If your app has a recognizable key color people associate with it, use the key color for the background of your Live Activity. This color creates a strong foundation for your design that can make it more recognizable and distinguish it from other Live Activities and notifications.

**为实时活动背景使用醒目的颜色。**如果 App 具有用户能够联想到的高识别度主色，请将该主色用作实时活动的背景。此颜色会为你的设计打下良好基础，可提高实时活动的辨识度以及相较于其他实时活动和通知的区别度。

### 2.1 Creating Live Activity layouts 创建实时活动布局

**Don’t replicate notification layouts.** Create a unique layout that’s specific to the information that appears in the Live Activity.

**不要复制通知布局。**为实时活动中显示的信息创建特定的唯一布局。

**Make your layout as compact as possible.** Adjust the size and placement of elements in your Live Activity so they fit together. Create as compact of a layout as possible that only uses as much space as you need to clearly display its content.

**做到布局尽量紧凑。**调整实时活动中元素的大小和摆放位置，让其完美适配。创建尽量紧凑的布局以仅使用清楚显示其内容所需的空间。

**Dynamically change the height of your Live Activity.** When there is less information to show, reduce the height of the Live Activity to only use the space needed for the content. When more information becomes available, increase the height to display additional content. For example, a rideshare app might display a more compact Live Activity without additional details while it locates a driver. The app’s height extends as more information is available to display the estimated pickup time, driver details, and so on. Similarly, a sports app could use a more compact layout during half time of a soccer match when the teams rest. When the second half of the match starts, the Live Activity could expand to display key moments like fouls, goals, and so on.

**动态更改实时活动的高度。**显示的信息量减少时，请降低实时活动的高度以仅使用该内容所需的空间。显示的信息量增加时，请增加该高度以显示更多内容。例如，叫车 App 在寻找司机时可能显示不包含额外详细信息的更紧凑实时活动。当更多信息可用于显示预计接客时间、司机详细信息等内容时，App 的高度会延伸。与之类似，体育赛事 App 可在足球比赛的双方队伍中场休息期间使用更为紧凑的布局。比赛的下半场开始时，实时活动可以展开以显示犯规、进球等关键时刻。

**Adapt to different screen sizes and Live Activity presentations.** A Live Activity scales to adapt to screen sizes of different devices. Ensure it looks great on every device by supplying content at appropriate sizes. As you create layouts and assets for various devices and scale factors, use the values listed in [Specifications](https://developer.apple.com/design/human-interface-guidelines/live-activities#Specifications) as guidance, but note that the actual size on screen may vary or change.

**适配不同的屏幕尺寸和实时活动展示区。**实时活动会缩放以适配不同设备的屏幕尺寸。提供大小合适的内容，以确保其在所有设备上都良好呈现。当你针对各种设备和缩放系数创建布局和资源时，请使用《[规范](https://developer.apple.com/cn/design/human-interface-guidelines/live-activities#Specifications)》中列出的值作为指南，但注意屏幕上的实际大小可能会各不相同或发生变化。

**When separating a block of content, place it in an inset shape or use a thick line.** Don’t draw content all the way to the edge of the Dynamic Island.

**分隔内容块时，将内容块放在嵌入形状中或使用粗线条。**不要将内容一直绘制到灵动岛的边缘。

[Incorrect Usage]:

![An illustration that shows how a Live Activity draws content all the way to the edge of the Dynamic Island to separate content.](https://docs-assets.developer.apple.com/published/b5847471658c3f7df2b8e99496dcbf0a/live-activities-separating-content-incorrect@2x.png)

[Correct Usage]:

![An illustration that shows how you can place content in an inset, rounded shape to group it together.](https://docs-assets.developer.apple.com/published/5d2611cfd66d7880ef1120efb23433d8/live-activities-separating-content-pill@2x.png)

[Correct Usage]:

![An illustration that shows how you can use a line to separate a block of content.](https://docs-assets.developer.apple.com/published/70749f8051768c93460d3b3d261642fd/live-activities-separating-content-separator@2x.png)

【错误用法】

![插图显示实时活动如何将内容一直绘制到灵动岛的边缘以分隔内容。](https://docs-assets.developer.apple.com/published/239fd767b226df6c648030ba5287a8f2/live-activities-separating-content-incorrect@2x.png)

【正确用法】

![插图显示你可以如何将内容放在嵌入的圆角形状中以将其分组在一起。](https://docs-assets.developer.apple.com/published/d11c4135aba058b287f1b4863ed25044/live-activities-separating-content-pill@2x.png)

【正确用法】

![插图显示你可以如何使用线条来分隔内容块。](https://docs-assets.developer.apple.com/published/02882f91684a9618487addbb866f760a/live-activities-separating-content-separator@2x.png)

圆圈中有勾号表示用法正确。

**Use consistent margins and concentric placement for your elements.** Use even, matching margins between rounded shapes and the edges of the Live Activity to ensure a harmonious fit. For example, when placing a rounded rectangle near the corner of your Live Activity, make sure to match the element’s corner radius to the outer corner radius of the Live Activity by subtracting the margin. Use a SwiftUI container to apply the correct corner radius. For developer guidance, see [ContainerRelativeShape](https://developer.apple.com/documentation/SwiftUI/ContainerRelativeShape).

**为元素使用一致的外边距和同心放置方式。**在圆角形状和实时活动的边缘之间使用均匀、匹配的外边距以确保外观协调。例如，将圆角矩形放在实时活动的圆角附近时，确保通过减去外边距让元素的圆角半径匹配实时活动的外圆角半径。使用 SwiftUI 容器来应用正确的圆角半径。有关开发者指南，请参阅 [ContainerRelativeShape](https://developer.apple.com/documentation/SwiftUI/ContainerRelativeShape)。

![An illustration that shows a rounded shape in the Dynamic Island that uses even margins and fits harmoniously into the edges of the Dynamic Island.
插图显示灵动岛中的圆角形状使用均匀外边距，与灵动岛的边缘协调一致。](https://docs-assets.developer.apple.com/published/e7043c74cba9ac897df8ac0ef96263d3/live-activities-rounded-shapes@2x.png)

**Avoid placing text and nonrounded shapes too close to the margins.** Don’t place content in a way that intrudes into the rounded shape of the Live Activity. Try to keep content compact and snug within a margin that is concentric to the outer edge of the Live Activity.

**避免将文本和非圆角形状放得过于靠近外边距。**不要以侵占实时活动圆角形状的方式放置内容。尽量确保内容紧凑并紧贴到与实时活动外边缘同心的外边距内侧。

[incorrect usage]:

【错误用法】

![An illustration that shows how a Live Activity places an icon too far from the edge of the Dynamic Island.插图显示实时活动如何将图标放在离灵动岛边缘过远的位置。](https://docs-assets.developer.apple.com/published/c233ae11550a07c092b6199546d3abc5/live-activities-content-incorrect-position@2x.png)

[correct usage]:

【正确用法】

![An illustration that shows how a Live Activity places an icon close to the edge of the Dynamic Island without poking into the rounded shape of the Dynamic Island.插图显示实时活动如何将图标放在靠近灵动岛边缘且未侵入灵动岛圆角形状的位置。](https://docs-assets.developer.apple.com/published/e03c226074641c488624bff75e167fb6/live-activities-content-correct-position@2x.png)

To help place nonrounded content correctly, you can blur elements and aim to make the border of the resulting rounded, blurred shapes as concentric as possible with even margins to make them fit best with the outer perimeter.

为了帮助正确放置非圆角内容，你可以模糊化元素并尽量让生成的模糊圆角形状的边框与均匀外边距保持同心，从而使其与外周完美适配。

[incorrect usage]:

![An illustration that shows a Live Activity with blurred text that's too far from the edge of the Dynamic Island.](https://docs-assets.developer.apple.com/published/c14bd8fdb690390e8937e451417b1353/live-activities-blur-content-incorrect-position@2x.png)

[correct usage]:

![An illustration that shows a Live Activity with blurred text that's close to the edge of the Dynamic Island without poking into the rounded shape of the Dynamic Island.](https://docs-assets.developer.apple.com/published/9f31022de0db043f18cd61e20b4fded9/live-activities-blur-content-correct-position@2x.png)

【错误用法】

![插图显示包含模糊文本的实时活动距离灵动岛边缘过远。](https://docs-assets.developer.apple.com/published/032a4341fa5f4a2eafc57965d3eb2737/live-activities-blur-content-incorrect-position@2x.png)

【正确用法】

![插图显示包含模糊文本的实时活动靠近灵动岛边缘且未侵入灵动岛的圆角形状。](https://docs-assets.developer.apple.com/published/f8ee15144babfb5b4afa0c35127c1c81/live-activities-blur-content-correct-position@2x.png)

### 2.2 Adding transitions and animating content updates 添加过渡和内容更新动画

In addition to extending and contracting transitions, Live Activities use system and custom animations with a maximum duration of two seconds. Note that the system doesn’t perform animations on Always-On displays with reduced luminance.

除了展开和收缩过渡外，实时活动会使用最长 2 秒钟的系统和自定义动画。请注意，系统不会在亮度较低的全天候显示屏上播放动画。

**Use animations to reinforce the information you’re communicating and to bring attention to updates.** In addition to moving the position of elements in your layout, you can animate elements in and out with the default content replace transition, or create custom transitions using scale, opacity, and movement. For example, a sports app could use a numeric content transition to increase or decrease important numbers for a match or gently fade a timer in and out when it reaches zero.

**使用动画强调你要传达的信息以及让用户注意到更新。**除了移动元素在布局中的位置外，你可以使用默认的内容替换过渡通过动画展现元素的出现和消失，或者使用缩放、不透明度和移动来创建自定义过渡。例如，体育赛事 App 可以使用数字内容过渡来增加或减少比赛的重要数字，或者在计时器即将归零时平缓淡入和淡出计时器。

**Animate layout changes.** For some content updates — for example, when more information becomes available, or when the Live Activity expands to the full screen in StandBy — it can make sense to update the layout of your Live Activity. When your Live Activity transitions to a new layout, animate existing elements to their new positions rather than removing them and animating them back in. This kind of update preserves as much of the existing layout as possible during the transition.

**使用动画展现布局更改。**对于某些内容更新，例如当更多信息变为可用或者实时活动在待机显示下展开以全屏显示时，更新实时活动的布局十分合理。实时活动过渡到全新布局时，使用动画展现已有元素移到新位置，而非移除元素并使用动画让其重新出现。这种更新方式可在过渡期间尽量保留现有布局。

**Try to avoid overlapping elements.** Sometimes, it’s best to animate out certain elements and then re-animate them in at a new position to avoid colliding with other parts of your transition. For example, when animating items in lists, only animate the element that moves to a new position and use a fade-in-and-out transitions for the other list items.

**尽量避免使元素重叠。**有时候，最好使用动画展现某些元素消失，然后在新位置重新出现，从而避免与过渡的其他部分冲突。例如，使用动画展现列表中的项目时，仅使用动画展现移到新位置的元素，而为其他列表项使用淡入和淡出过渡。

> **Note** **注：**
>
> For developer guidance, see [Displaying live data with Live Activities](https://developer.apple.com/documentation/ActivityKit/displaying-live-data-with-live-activities).
> 
> 有关开发者指南，请参阅《[使用实时活动展示实时数据](https://developer.apple.com/documentation/ActivityKit/displaying-live-data-with-live-activities)》。

### 2.3 Offering interactivity 提供交互

**Make sure tapping the Live Activity opens your app at the right location.** Take people directly to details and actions related to the Live Activity — don’t require them to navigate to the relevant screen. For developer guidance on SwiftUI views that can deep link to specific screens in your app, see [Link](https://developer.apple.com/documentation/SwiftUI/Link) and [widgetURL(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/widgetURL(_:)).

**确保轻点实时活动会打开 App 正确的位置。**将用户直接引导至与实时活动相关的详细信息和操作，勿要求其导航至相关屏幕。有关可深度链接至 App 中特定屏幕的 SwiftUI 视图相关开发者指南，请参阅 [Link](https://developer.apple.com/documentation/SwiftUI/Link) 和 [widgetURL(_:)](https://developer.apple.com/documentation/WidgetKit/DynamicIsland/widgetURL(_:))。

**Offer quick controls.** Starting with iOS 17 and iPadOS 17, the expanded presentation in the Dynamic Island and the Lock Screen presentation can include buttons or toggles to offer people a way to perform tasks directly from the Live Activity. However, these elements can take up space that might otherwise display useful information. As a result, it’s important that you only include them if they are offering essential functionality that’s directly related to your Live Activity. For example, the Live Activity of the Timer app allows people to pause and cancel a timer. Similarly, a fitness app could allow people to pause and resume an ongoing workout.

**提供快速控制。**从 iOS 17 和 iPadOS 17 开始，灵动岛中的扩展式展示区和锁定屏幕展示区可以包括按钮或开关，从而让用户直接从实时活动执行任务。但是，这类元素可能占据原本显示有用信息的空间。因此，仅在元素提供与实时活动直接相关的基本功能时才包括这类元素，这一点十分重要。例如，计时器 App 的实时活动允许用户暂停和取消计时器。与之类似，健身 App 可允许用户暂停和继续正在进行的体能训练。

**Let people respond to event or progress updates.** Offer buttons or toggles to allow people to respond to updated data. For example, a rideshare app could show a button in its Live Activity that people tap to get in touch with the driver while they are waiting for their ride to arrive.

**让用户响应事件或进度更新。**提供按钮或开关以允许用户对数据更新做出响应。例如，叫车 App 可以在其实时活动中显示一个按钮，以便用户在等待车辆到达时可轻点来联系司机。

## 3 The Lock Screen 锁定屏幕

On the Lock Screen, the system uses the Lock Screen presentation to display a banner at the bottom of the screen. In this presentation, use a layout similar to the expanded presentation.

在锁定屏幕上，系统会使用锁屏展示区在屏幕底部显示横幅。在此展示区中，使用与扩展式展示区类似的布局。

![A screenshot of a Live Activity on the Lock Screen of iPhone that supports the Dynamic Island.](https://docs-assets.developer.apple.com/published/7859a0d79d91b03dc6bc6581c02b2ea2/live-activity-lock-screen@2x.png)

![支持灵动岛的 iPhone 锁定屏幕上显示的实时活动的截屏。](https://docs-assets.developer.apple.com/published/9b61b4044d303ac205bca60576326134/live-activity-lock-screen@2x.png)

On devices that don’t support the Dynamic Island, the system uses the Lock Screen presentation of your Live Activity as a banner that briefly overlays the Home Screen or another app. This overlay only happens when you alert people about an update to your Live Activity with an alert configuration.

在不支持灵动岛的设备上，系统会使用实时活动的锁屏展示区，并作为横幅短暂覆盖在主屏幕或其他 App 之上。这种覆盖情况仅在你通过提醒配置来提醒用户实时活动的更新时才会发生。

![A screenshot of a Live Activity that appears as a banner on the Home Screen of iPhone without Dynamic Island support.](https://docs-assets.developer.apple.com/published/d124eab5adf9b06af473c23e0d95a878/live-activity-notch@2x.png)

![在不支持灵动岛的 iPhone 上，实时活动作为横幅显示在主屏幕上的截屏。](https://docs-assets.developer.apple.com/published/a6bcc99dd50fb51e1d78fe79f3868cfd/live-activity-notch@2x.png)

**Carefully consider using a custom background color and opacity on the Lock Screen.** If you set a background color or image for Live Activities that appear on the Lock Screen, test colors to be sure they offer enough contrast — especially tint colors on devices in Always-On with reduced luminance. Note that you can’t choose a custom background color for Live Activity presentations that appear in the Dynamic Island.

**谨慎考虑在锁定屏幕上使用自定义背景颜色和不透明度。**如果为显示在锁定屏幕上的实时活动设定了背景颜色或图像，请测试颜色以确保其提供足够的对比度，尤其是在启用了低亮度全天候显示的设备上的色调。请注意，你无法为灵动岛中显示的实时活动展示区选取自定义背景颜色。

**Choose colors that work well on a personalized Lock Screen.** People customize their Lock Screen with wallpapers, custom tint colors, and widgets. To make a Live Activity fit a custom Lock Screen aesthetic while remaining legible, apply custom tint colors and opacity sparingly.

**选取适合个性化锁定屏幕的颜色。**用户会使用墙纸、自定义色调和小组件来个性化其锁定屏幕。若要让实时活动适合自定义锁定屏幕的审美风格并且保持可读，请谨慎应用自定义色调和不透明度。

**Make sure your design, assets, and colors look great and offer enough contrast in Dark Mode and on an Always-On display.** By default, a Live Activity on the Lock Screen uses a light background color in Light Mode and a dark background color in Dark Mode. If you apply a custom background color to your Lock Screen presentation, use a color that works well in both modes or use a different color for each mode. Additionally, verify your Live Activity design on an Always-On display with reduced luminance because the system adapts colors as needed in this appearance. For guidance, see [Dark Mode](https://developer.apple.com/design/human-interface-guidelines/dark-mode) and [Always On](https://developer.apple.com/design/human-interface-guidelines/always-on); for developer guidance, see [About asset catalogs](https://help.apple.com/xcode/mac/current/#/dev10510b1f7).

**确保你的设计、资源和颜色在深色模式和全天候显示屏上看起来美观并提供足够的对比度。**锁定屏幕上的实时活动默认在浅色模式下使用浅色背景颜色，在深色模式下使用深色背景颜色。如果为锁定屏幕展示区应用自定义背景颜色，请使用完美适配这两种模式的颜色或者为每种模式使用不同的颜色。另外，请在亮度降低的全天候显示屏上验证你的实时活动设计，因为系统会在这种外观下按需对颜色进行调整。有关指南，请参阅《[深色模式](https://developer.apple.com/cn/design/human-interface-guidelines/dark-mode)》和《[全天候显示](https://developer.apple.com/cn/design/human-interface-guidelines/always-on)》；有关开发者指南，请参阅 [About asset catalogs](https://help.apple.com/xcode/mac/current/#/dev10510b1f7)。

**Verify the generated color of the dismiss button on the Lock Screen.** The system automatically generates a matching dismiss button based on the background and foreground colors of your Live Activity. Be sure to check that the generated colors match your Live Activity design and adjust them if needed using [activitySystemActionForegroundColor(_:)](https://developer.apple.com/documentation/SwiftUI/View/activitySystemActionForegroundColor(_:)).

**在锁定屏幕上验证关闭按钮的生成颜色。**系统会基于实时活动的背景和前景颜色自动生成匹配的关闭按钮。请务必检查生成的颜色是否与实时活动设计相搭并根据需要使用 [activitySystemActionForegroundColor(_:)](https://developer.apple.com/documentation/SwiftUI/View/activitySystemActionForegroundColor(_:)) 进行调整。

**Use standard margins to align with notifications. **The standard layout margins are 14 points for Live Activities on the Lock Screen. In some cases, such as for the placement of graphics or buttons, you might need to use tighter margins, but avoid crowding the edges and creating a cluttered appearance. For developer guidance, see [padding(_:_:)](https://developer.apple.com/documentation/SwiftUI/View/padding(_:_:)).

**使用标准外边距与通知对齐。**锁定屏幕上实时活动的标准布局外边距为 14 点。在某些情况下（例如放置图形或按钮时）你可能需要使用更窄的外边距，但要避免挤到边缘和造成外观杂乱。有关开发者指南，请参阅 [padding(_:_:)](https://developer.apple.com/documentation/SwiftUI/View/padding(_:_:))。

## 4 StandBy 待机显示

![An image that shows the Lock Screen presentation of a Live Activity in StandBy, scaled up by 2x, with a dotted border to indicate the 2x scaling of the Live Activity.](https://docs-assets.developer.apple.com/published/73a140c355d0380b7af165a69d41c7c4/live-activity-standby-default-outline@2x.png)

![图像显示待机显示下放大两倍的实时活动锁定屏幕展示区，并以虚线边框表示此两倍放大。](https://docs-assets.developer.apple.com/published/37642e93c37baa998ae8f75976406279/live-activity-standby-default-outline@2x.png)

When a person taps the minimal presentation on iPhone in StandBy, the system scales the Lock Screen appearance by 2x to fill the entire screen. If you use a custom background color for your Live Activity, the system automatically extends it to the whole screen to create a seamless, full-screen design.

用户轻点 iPhone 待机显示下的极简式展示区时，系统会将锁屏外观放大两倍以填充整个屏幕。如果为实时活动使用自定义背景颜色，系统会自动将其延伸至整个屏幕，从而形成无缝的全屏设计。

**Update your layout to take advantage of the larger presentation.** Display additional information and make sure assets look great in the scaled-up presentation.

**更新布局以充分利用更大的展示区。**显示更多信息并确保资源在放大的展示区中看起来美观。

**Consider removing a custom background color in StandBy.** Without a custom background color, your Live Activity seamlessly blends with the device bezel and achieves a softer look that integrates with a person’s surroundings. Additionally, when you use the default background color, the system also scales your Live Activity slightly larger because it no longer needs to account for the margins around the TrueDepth camera.

**考虑在待机显示下移除自定义背景颜色。**不使用自定义背景颜色时，实时活动可无缝融入设备边框并形成与用户四周融合的更柔和外观。此外，当你使用默认背景颜色时，系统还会稍微放大你的实时活动，因为不再需要考虑原深感摄像头周围的外边距。

**Use standard margins and avoid extending graphic elements to the edge of the screen.** Without standard margins, content gets cut off as the Live Activity extends, making it feel broken. To visually separate regions of your layout, use a line or a container shape instead.

**使用标准外边距并避免将图形元素延伸至屏幕边缘。**如果不使用标准外边距，内容会在实时活动延伸时被截断，从而造成损坏感。若要在视觉上分离布局的各个区域，请转而使用线条或容器形状。

**Verify your design in Night Mode.** In Night Mode, the system automatically applies a visual treatment to your Live Activity to give it a red tint. Be sure to check that your Live Activity design uses colors that provide enough contrast in Night Mode.

**在夜间模式下验证你的设计。**在夜间模式下，系统会自动对实时活动进行视觉处理以应用红色调。 请务必检查实时活动设计所使用的颜色在夜间模式下能够提供足够的对比度。

![A Live Activity, scaled to fill the screen on iPhone in StandBy.](https://docs-assets.developer.apple.com/published/8f43d2e5d435682129b53b4e07ef4f11/live-activity-standby-night-mode@2x.png)

![iPhone 上的实时活动在待机显示下放大以填充整个屏幕。](https://docs-assets.developer.apple.com/published/f56d6f20b473c65186067ea111406b3d/live-activity-standby-night-mode@2x.png)

## 5 The Dynamic Island 灵动岛

The Dynamic Island serves as a unified home for alerts and indicators of ongoing activity. Design your layouts to feel at home within the shape and background color of the Dynamic Island, while preserving your Live Activity’s identity through use of color, iconography, and animation.

灵动岛是提醒和进行中活动指示符集中显示的大本营。为灵动岛中的布局赋予原生感以完美适配其形状和背景颜色，同时通过颜色、图像学和动画的使用来保留实时活动的识别度。

**Use color to express the character and identity of your app.** Live Activities in the Dynamic Island use a black opaque background. Consider using bold colors for text and objects to convey the personality and brand of your app. Bold colors make your Live Activity recognizable at a glance, and make it feel like a small, glanceable part of your app that stands out from other Live Activities. Additionally, bold colors can help reinforce the relationship between shapes, text, and icons in the Live Activity itself.

**使用颜色表达 App 的特征和识别度。**灵动岛中的实时活动使用黑色不透明背景。考虑为文本和对象使用醒目的颜色来传达 App 的特性和品牌。醒目的颜色可让用户一眼就能识别出你的实时活动，并让其感觉实时活动是 App 简单明了的一小部分，从其他实时活动中脱颖而出。此外，醒目的颜色有助于强调实时活动本身中形状、文本和图标之间的关系。

**Tint your Live Activity’s key line color so that it matches your content.** When the background is dark — for example, in Dark Mode — a key line appears around the Dynamic Island to distinguish it from other content. Choose a color for this key line that’s consistent with the color of other elements in your Live Activity.

**为实时活动的关键线着色，使其与内容匹配。**背景为深色时，例如在深色模式下，灵动岛周围会显示关键线以将其与其他内容区分开来。为此关键线选取与实时活动中其他元素的颜色一致的颜色。

**Ensure text is easy to read.** Use large, heavier–weight text — a medium weight or higher. Avoid small text that’s hard to read.

**确保文本易读。**使用中等粗细或更粗的大号较粗文本。避免使用难以阅读的小号文本。

[incorrect usage]:

【错误用法】

![An illustration that shows text in the Dynamic Island that’s small and difficult to read.](https://docs-assets.developer.apple.com/published/2c94feab294c552685df2649d17f910a/live-activities-text-incorrect-size@2x.png)

[correct usage]:

【正确用法】

![An illustration that shows text in the Dynamic Island with heavier weights and legible size.](https://docs-assets.developer.apple.com/published/b549f930325203f779bd4a09dc3c94df/live-activities-text-correct-size@2x.png)

**Use even margins that leave enough space between your content and the edge of the Dynamic Island.** Apply an even margin to elements all the way around the edge of the Dynamic Island, including the corners. This kind of margin prevents elements from poking into the rounded edges and creating visual tension.

**使用均匀外边距在内容和灵动岛边缘之间留出足够空间。**为靠近灵动岛四周边缘（包括圆角）的元素应用均匀外边距。这种外边距会防止元素侵入圆角边缘并形成视觉冲突感。

![An illustration that shows content in the Dynamic Island with even margins.](https://docs-assets.developer.apple.com/published/458a49f159fbf003028540d37e2f360a/live-activities-margins@2x.png)

![插图显示灵动岛中的内容使用均匀外边距。](https://docs-assets.developer.apple.com/published/c9d844a7917d8ac60f53cbb565dc36a1/live-activities-margins@2x.png)

**Animate Live Activity updates to change the shape of the Dynamic Island dynamically.** Not only do animations bring a person’s attention to updated information, they underline the active nature of your Live Activity in the Dynamic Island.

**使用动画展现实时活动更新以动态更改灵动岛的形状。**动画不仅能让用户注意到信息更新，还突出了灵动岛中实时活动的动态属性。

### 5.1 Compact presentation 紧凑式展示区

In the Dynamic Island, the system uses the compact presentation when only one Live Activity is active. The compact presentation consists of two separate elements: one that displays on the leading side of the TrueDepth camera, and one that displays on the trailing side. Even though the compact presentation offers limited space, it displays up-to-date information about your app’s Live Activity.

在灵动岛中，如果只有一个活跃的实时活动，系统会使用紧凑式展示区。紧凑式展示区由两个单独的元素组成：一个显示在原深感摄像头的前端，另一个显示在后端。虽然紧凑式展示区提供的空间有限，但它可显示 App 实时活动的最新信息。

![An illustration that shows the compact leading and compact trailing views in the Dynamic Island.](https://docs-assets.developer.apple.com/published/5de0db1a358dfccca20d67ecf1e32876/type-compact@2x.png)

![插图显示了灵动岛中的紧凑式前端和后端视图。](https://docs-assets.developer.apple.com/published/34d30f19656f990ed651be3d5615f39e/type-compact@2x.png)

**Communicate the most important information of your Live Activity.** Use the compact presentation to show dynamic information. Display live, up-to-date information that’s key to the Live Activity.

**传达实时活动最重要的信息。**使用紧凑式展示区显示动态信息。显示对实时活动至关重要的最新实时信息。

**Ensure unified information and design of the compact presentations in the Dynamic Island.** The TrueDepth camera separates the compact leading and compact trailing presentations of a Live Activity, but make sure the contents of both read as a single piece of information. Using consistent color or typography can help create a connection between leading and trailing presentations.

**确保在灵动岛的紧凑式展示区中使用统一的信息和设计。**原深感摄像头会将实时活动的紧凑式前端和紧凑式后端展示区分隔开来，因此需确保将这两部分的内容作为一条信息来理解。使用一致的颜色或字体排印有助于在前端和后端展示区之间形成一种关联。

**Keep information as narrow as possible and ensure content is snug against the TrueDepth camera.** Try not to obscure key information in the status bar, and maintain a balanced layout with similarly sized views in leading and trailing presentations. Don’t place padding between content and the TrueDepth camera. For example, use shortened units or less precise data to avoid creating an appearance that’s too wide or unbalanced.

**尽量压缩信息的宽度并确保内容贴近原深感摄像头。**尽量不要遮挡状态栏中的关键信息，并在前端和后端展示区中使用大小类似的视图来维持布局平衡。不要在内容和原深感摄像头之间添加内边距。例如，使用缩写的单位或精确度较低的数据以避免看起来太宽或不平衡。

[incorrect usage]:

![An illustration that shows a compact presentation that appears unbalanced and too wide because it uses padding around the true depth camera.](https://docs-assets.developer.apple.com/published/d276eb92e9fdd9ffe9622defaab7d13b/live-activities-unbalanced-content@2x.png)

[correct usage]:

![An illustration that shows a compact presentation that’s snug around the TrueDepth camera.](https://docs-assets.developer.apple.com/published/d17bee1109f0915694020846fc12a908/live-activities-balanced-content@2x.png)

【错误用法】

![插图显示紧凑式展示区在原深感摄像头周围使用了内边距，因而看起来过宽和不平衡。](https://docs-assets.developer.apple.com/published/9fa2e57fa5d6b14d961f855e82ccc72d/live-activities-unbalanced-content@2x.png)

【正确用法】

![插图显示紧凑式展示区紧贴在原深感摄像头周围。](https://docs-assets.developer.apple.com/published/dead241200ff9867d918474c0e7d90de/live-activities-balanced-content@2x.png)

**Link to the relevant scene in your app. **People tap a compact Live Activity to open the app and get more details about the event or task. They don’t need to view a generic scene in your app. Make sure to open the same scene in your app when people tap the leading or trailing presentation.

**链接到 App 中的相关场景。**用户轻点紧凑式实时活动来打开 App，并获取有关事件或任务的更多详细信息。他们不需要查看 App 中的通用场景。当用户轻点前端或后端展示区时，确保在 App 中打开相同场景。

### 5.2 Minimal presentation 极简展示区

When multiple Live Activities are active, the system uses the minimal presentation to display two of them in the Dynamic Island. One Live Activity appears attached to the Dynamic Island while the other appears detached. Depending on its content size, the detached minimal Live Activity appears circular or oval. As with a compact Live Activity, people tap a minimal Live Activity to open the app to get more details about the event or task or touch and hold it to use essential controls and view additional content in the expanded presentation.

有多个实时活动活跃时，系统会使用极简式展示区在灵动岛中显示其中的两个实时活动。一个实时活动看起来与灵动岛相连，另一个则看起来分离。分离的极简式实时活动会显示为圆形或椭圆形，具体取决于其内容大小。和紧凑式实时活动一样，用户轻点极简式实时活动即可打开 App，并获取有关事件或任务的更多详细信息，或者按住以在扩展式展示区中使用基本控制和查看额外内容。

![An illustration that shows the minimal presentation in the Dynamic Island.](https://docs-assets.developer.apple.com/published/2c38a9a60566204bec5e3c335430544f/type-minimal@2x.png)

![插图显示了灵动岛中的极简式展示区。](https://docs-assets.developer.apple.com/published/3ba724846fb21fad90a0beb08546c148/type-minimal@2x.png)

**Ensure that your Live Activity is recognizable in the minimal presentation.** If possible, display updated information instead of only presenting a logo, but ensure that people are able to quickly recognize your app. For example, the compact presentation for a Live Activity of the Timer app displays the remaining time instead of using a static icon.

**确保实时活动在极简式展示区中易于识别。**尽量显示更新信息而非仅呈现标志，但确保用户能够快速识别出你的 App。例如，计时器 App 的实时活动紧凑式展示区显示剩余时间而非使用静态图标。

### 5.3 Expanded presentation 扩展式展示区

When people touch and hold a Live Activity in a compact or minimal presentation, the system displays the content in the expanded presentation.

用户按住实时活动的紧凑式或极简式展示区时，系统会在扩展式展示区中显示内容。

![An illustration that shows the expanded view in the Dynamic Island.插图显示了灵动岛中的扩展式视图。](https://docs-assets.developer.apple.com/published/5fdac3e13c1f851b50f4d36b2588aa43/type-expanded@2x.png)

**Maintain the relative placement of elements to create a coherent layout between compact and expanded presentations.** The expanded presentation is an enlarged version of the compact presentation. Ensure that information and layouts expand predictably when the Live Activity transitions from compact to expanded presentation.

**维持元素的相对摆放位置以在紧凑式和扩展式展示区之间形成连贯的布局。扩展式展示区是紧凑式展示区的扩大版本。**请确保实时活动从紧凑式展示区向扩展式展示区过渡期间，对应信息和布局会按预期扩展。

**Use a shorter or a tall height for the expanded presentation.** If your content requires a small amount of vertical screen space, choose a height for the expanded presentation that clearly retains a capsule shape with continuous curves at the leading and trailing sides. If your expanded presentation requires more vertical screen space, use a height that’s rectangular with rounded edges. Avoid an in-between height that’s harder to visually resolve and less aesthetically pleasing.

**为扩展式展示区使用较矮或较高的高度。**如果内容需要少量垂直屏幕空间，请为扩展式展示区选取在前端和后端包含连续曲线且清晰保留胶囊形状的高度。如果扩展式展示区需要更多垂直屏幕空间，请使用包含圆角边缘且呈现矩形的高度。避免使用从视觉上更难分辨且降低了美观性的不高不低的高度。

[correct usage]:

【正确用法】

![An illustration that shows a Live Activity in the expanded presentation with a compact height and capsule shape that feels comfortable and is easy to visually resolve.插图显示了扩展式展示区中的实时活动使用了紧凑高度，胶囊形状让人看起来舒适且从视觉上容易分辨。](https://docs-assets.developer.apple.com/published/2243e4ad975cf4fba09a58b6e7570095/live-activities-expanded-height-pill@2x.png)

[incorrect usage]:

【错误用法】

![An illustration that shows a Live Activity in the expanded presentation with an in-between height that's hard to visually resolve.插图显示了扩展式展示区中的实时活动使用了不高不低的高度，造成从视觉上难以分辨。](https://docs-assets.developer.apple.com/published/6508f6e21873ae459c14c8ff5101eb69/live-activities-expanded-height-middle-incorrect@2x.png)

[correct usage]:

【正确用法】

![An illustration that shows a Live Activity in the expanded presentation with a tall, rounded-rectangular shape that feels comfortable and is easy to visually resolve.插图显示了扩展式展示区中的实时活动使用了较高的圆角矩形，让人看起来舒适且从视觉上容易分辨。](https://docs-assets.developer.apple.com/published/f1bfa965c7e9a96b92166b244fcacb63/live-activities-expanded-height-tall@2x.png)

**Wrap content tightly around the TrueDepth camera.** Try to avoid leaving space on the leading and trailing sides and below the TrueDepth camera. Arranging content close to the TrueDepth camera uses space more efficiently, and helps diminish the visual presence of the TrueDepth camera.

**在原深感摄像头周围紧凑绕排内容。**尽量避免在原深感摄像头的前端、后端和下方留有空间。将内容放在靠近原深感摄像头的位置能够更有效利用空间，且有助于从视觉上降低原深感摄像头的存在感。

[incorrect usage]:

![An illustration that shows an expanded presentation of a Live Activity that leaves empty space next to the TrueDepth camera.](https://docs-assets.developer.apple.com/published/3ceb56a39bb02fabcb71982ff83b97bc/live-activities-layout-incorrect@2x.png)

[correct usage]:

![An illustration that shows an expanded presentation of a Live Activity that uses the space next to the TrueDepth camera.](https://docs-assets.developer.apple.com/published/f7d14e4e62c0e135812a708a1926d11e/live-activities-layout-correct@2x.png)

【错误用法】

![插图显示实时活动的扩展式展示区在原深感摄像头旁边留有空白空间。](https://docs-assets.developer.apple.com/published/ea8199a77a83f2dbb9caa01ee774c049/live-activities-layout-incorrect@2x.png)

【正确用法】

![插图显示实时活动的扩展式展示区使用了原深感摄像头旁边的空间。](https://docs-assets.developer.apple.com/published/8585876525d7864fd5504ce69577724e/live-activities-layout-correct@2x.png)

## 6 Platform considerations 平台考量因素

No additional considerations for iOS or iPadOS. Not supported in macOS, tvOS, or visionOS.

无针对 iOS 或 iPadOS 的额外考量因素。在 macOS、Apple tvOS 或 visionOS 中不受支持。

### 6.1 watchOS

Starting with watchOS 11, when a Live Activity begins on an iPhone with a connected Apple Watch, the Smart Stack appears with the Live Activity at the top. By default, the view displayed in the Smart Stack combines the leading and trailing elements from the Live Activity’s compact presentation on iPhone. For the best experience, create a custom layout specifically for your Live Activity in the Smart Stack.

从 watchOS 11 开始，当与 Apple Watch 连接的 iPhone 上的实时活动开始时，在顶部显示实时活动的智能叠放会出现。智能叠放中显示的视图默认会结合 iPhone 上实时活动紧凑式展示区中的前端和后端元素。为提供最佳体验，请专门为智能叠放中的实时活动创建自定义布局。

iPhone compact view

![An illustration that shows the compact presentation of a Live Activity in the Dynamic Island on iPhone.](https://docs-assets.developer.apple.com/published/b32098ed4f4662df69db1df7a9cb4522/live-activities-ios-dynamic-island-default@2x.png)

iPhone 紧凑视图

![插图显示了 iPhone 灵动岛中实时活动的紧凑式展示区。](https://docs-assets.developer.apple.com/published/e92a2e2b55a45ce5f42a277540b211ed/live-activities-ios-dynamic-island-default@2x.png)

Default Smart Stack view

![An illustration that shows the automatically generated default presentation of a Live Activity in a Smart Stack view, with the leading and trailing elements from the iPhone compact view spaced apart in the lower corners.](https://docs-assets.developer.apple.com/published/1441a47a3ba447c6ccbfbd8ba8565bd5/live-activity-watch-default-implementation@2x.png)

默认智能叠放视图

![插图显示智能叠放视图中自动生成的实时活动默认展示区，其中 iPhone 紧凑视图中的前端和后端元素间隔排列在下方边角中。](https://docs-assets.developer.apple.com/published/63a7a36a272cabc4ed04fdf67ce72ed4/live-activity-watch-default-implementation@2x.png)

Custom Smart Stack view

![An illustration that shows a custom presentation of a Live Activity in a Smart Stack view, with a balanced design that shows a graphical countdown timer balanced with explanatory text.](https://docs-assets.developer.apple.com/published/cd8ec7a71aab86b947906afbdd802f6b/live-activity-watch-custom-implementation@2x.png)

自定义智能叠放视图

![插图显示智能叠放视图中实时活动的自定义展示区，采用的平衡设计显示了图形化倒计时器以及实现平衡的解释性文本。](https://docs-assets.developer.apple.com/published/80bc0dd7ec9dd0895131f95dd1db0c3e/live-activity-watch-custom-implementation@2x.png)

If you have a watchOS app, when someone taps the Live Activity in the Smart Stack, it opens the watchOS app directly. If you don’t have a watchOS app, tapping opens a full-screen view with a button to hand off to your app on the connected iPhone.

如果提供 watchOS App，用户轻点智能叠放中的实时活动时会直接打开 watchOS App。如果不提供 watchOS App，轻点会打开全屏幕视图，其中包含接力到所连接 iPhone 上 App 的按钮。

**Design a custom layout for your Live Activity in watchOS.** While the system provides a default view automatically, a custom layout designed for Apple Watch can provide more detailed information, and add interactive functionality like a button or toggle. For developer guidance, see [ActivityFamily](https://developer.apple.com/documentation/WidgetKit/ActivityFamily).

**为 watchOS 中的实时活动设计自定义布局。**虽然系统会自动提供默认视图，但专门为 Apple Watch 设计的自定义布局可提供更多详细信息，并增加按钮或切换等交互式功能。有关开发者指南，请参阅 [ActivityFamily](https://developer.apple.com/documentation/WidgetKit/ActivityFamily)。

**Show only what’s necessary to communicate significant states of the Live Activity.** It’s important to use space in the Smart Stack as efficiently as possible. Think of the most useful information that a Live Activity can convey:

**仅显示传达实时活动重要状态的必要信息。**尽量有效使用智能叠放中的空间十分重要。回想实时活动可传达的最有用信息：

- Progress, like the estimated arrival time of a delivery

- 进度，例如外卖的预计送达时间

- Interactivity, like a stopwatch or timer

- 交互性，例如秒表或计时器

- Significant changes, like when a sports score updates

- 重大变化，例如体育赛事比分更新

**Use interactivity for simple, direct actions.** While the Live Activity view on Apple Watch can contain a button or toggle, be considerate when adding them. Interactive elements are best for activities that people activate only once or temporarily pause and resume, like music, workouts, or apps that access the microphone to record live audio.

**将交互性用于简单、直接的操作。**虽然 Apple Watch 上的实时活动视图可包含按钮或切换，但在添加时应考虑周全。交互式元素最好用于用户仅激活一次或者暂时暂停并恢复的活动，例如音乐、体能训练或访问麦克风以录制实时音频的 App。

**Use only one custom button or toggle per view.** Because space is extremely limited, having multiple smaller or more tightly spaced controls increases the likelihood of people accidentally tapping the wrong control.

**每个视图仅使用一个自定义按钮或切换。**因为空间极其有限，使用多个尺寸更小或间距更紧凑的控制会增加用户误点错误控制的可能性。

**Prefer familiar layouts for your custom Live Activity views.** Templates with the system default margins and recommended sizes for text are available in [Apple Design Resources](https://developer.apple.com/design/resources/). Adopting these defaults ensures that your Live Activity fits in with the visual language of the Smart Stack and remains legible at a glance.

**优先为自定义实时活动视图使用用户熟悉的布局。**请参阅《[Apple 设计资源](https://developer.apple.com/design/resources/)》来获取采用系统默认外边距和建议文本字号的模板。采用这些默认模板可确保实时活动与智能叠放的视觉语言相得益彰，且一眼即可看清。

## 7 Specifications 规范

As you design your Live Activities, use the following values for guidance.

设计实时活动时，请使用以下值作为指导。

### 7.1 iOS Live Activity dimensions iOS 实时活动尺寸

All values listed in the tables below are in points. 

下表所列值的单位均为点。

屏幕尺寸（竖排）|紧凑式前端|紧凑式后端|极简式（给定宽度范围）|扩展式（给定高度范围）|锁屏（给定高度范围）
:-:|:-:|:-:|:-:|:-:|:-:
430x932|62.33x36.67|62.33x36.67|36.67–45x36.67|408x84-160|408x84-160
393x852|52.33x36.67|52.33x36.67|36.67–45x36.67|371x84-160|371x84-160

The Dynamic Island uses a corner radius of 44 points, and its rounded corner shape matches the TrueDepth camera.

灵动岛使用 44 点的圆角半径，并且其圆角形状与原深感摄像头相符。

展示区类型|设备|灵动岛宽度（点）
:-:|:-:|:-:
Compact or minimal</br>紧凑式或极简式|iPhone 16 Pro Max|250
 |iPhone 16 Pro|230
 |iPhone 16 Plus|250
 |iPhone 16|230
 |iPhone 15 Pro Max|250
 |iPhone 15 Pro|230
 |iPhone 15 Plus|250
 |iPhone 15|230
 |iPhone 14 Pro Max|250
 |iPhone 14 Pro|230|
Expanded</br>扩展式|iPhone 16 Pro Max|408
 |iPhone 16 Pro|371
 |iPhone 16 Plus|408
 |iPhone 16|371
 |iPhone 15 Pro Max|408
 |iPhone 15 Pro|371
 |iPhone 15 Plus|408
 |iPhone 15|371
 |iPhone 14 Pro Max|408
 |iPhone 14 Pro|371

### 7.2 iPadOS Live Activity dimensions iPadOS 实时活动尺寸

All values listed in the table below are in points.

下表所列值的单位均为点。

屏幕尺寸（竖排）|锁屏（给定高度范围）
:-:|:-:
1366x1024|500x84-160
1194x834|425x84-160
1012x834|425x84-160
1080x810|425x84-160
1024x768|425x84-160

## 8 Resources 资源

### 8.1 Developer documentation 开发者文档

[ActivityKit](https://developer.apple.com/documentation/ActivityKit)

[SwiftUI](https://developer.apple.com/documentation/SwiftUI)

[WidgetKit](https://developer.apple.com/documentation/WidgetKit)

[Developing a WidgetKit strategy](https://developer.apple.com/documentation/WidgetKit/Developing-a-WidgetKit-strategy)
