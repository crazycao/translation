# Handling Communication Notifications and Focus Status Updates - 处理通信通知与专注状态的更新

原文地址：
[https://developer.apple.com/documentation/usernotifications/handling-communication-notifications-and-focus-status-updates](https://developer.apple.com/documentation/usernotifications/handling-communication-notifications-and-focus-status-updates)

Create a richer calling and messaging experience in your app by implementing communication notifications and Focus status updates.

通过实现通信通知和专注状态更新，为你的应用创建一个更丰富的呼叫和消息体验。

[Download](https://docs-assets.developer.apple.com/published/47d72f90ec70/HandlingCommunicationNotificationsAndFocusStatusUpdates.zip)

> iOS 14.0+
iPadOS 14.0+
Xcode 13.0+

# Overview 概述

Communication notifications have a distinct user experience that features prominent avatars and group names, as well as unique breakthrough behaviors. Implement these notifications for incoming calls and messages to provide additional context to the user.

通信通知具有独特的用户体验，包括突出的头像和群组名称，以及独特的突破行为。为来电和消息实现这些通知，以向用户提供额外的上下文信息。

> **Note** **注意**
>
> This sample code project is associated with WWDC21 session 10091: [Send communication and Time Sensitive notifications](https://developer.apple.com/videos/play/wwdc2021/10091/).
> 
> 这个示例代码项目与 WWDC21 的第 10091 场会议相关：[发送通信和时间敏感通知](https://developer.apple.com/videos/play/wwdc2021/10091/)。

## Configure the Sample Code Project - 配置示例代码项目

This sample runs on physical devices in order to meet requirements for push notifications and the Notification Service Extension. The Notification Service Extension modifies a notification’s content before it’s displayed on the user’s device. To learn more about Notification Service Extensions, see [Modifying Content in Newly Delivered Notifications](https://developer.apple.com/documentation/UserNotifications/modifying-content-in-newly-delivered-notifications).

此示例在物理设备上运行，以满足推送通知和通知服务扩展的要求。通知服务扩展会在显示在用户设备上之前修改通知内容。要了解更多关于通知服务扩展的信息，请参见《[修改新送达通知中的内容](https://developer.apple.com/documentation/UserNotifications/modifying-content-in-newly-delivered-notifications)》。

Begin by configuring the iOS target to include your development team and a bundle identifier. The bundle identifier must support the following capabilities:

- Push notifications
- Communication notifications
- Time Sensitive notifications
- SiriKit

首先，在 iOS Target 中配置你的开发团队和一个 bundle ID。Bundle ID 必须支持以下能力：

- 推送通知
- 通信通知
- 时间敏感通知
- SiriKit

To support communication notifications, the app’s `Info.plist` file must contain a top-level entry with the key [NSUserActivityTypes](https://developer.apple.com/documentation/bundleresources/information_property_list/nsuseractivitytypes) and type `Array`. This array should contain `INStartCallIntent` if the app supports calling functionality, and `INSendMessageIntent` if it supports messaging.

为了支持通讯通知，应用的 `Info.plist` 文件必须包含一个键为 [NSUserActivityTypes](https://developer.apple.com/documentation/bundleresources/information_property_list/nsuseractivitytypes) 类型为数组的顶级条目，。如果应用支持呼叫功能，这个数组应包含 `INStartCallIntent`，如果支持消息功能，则应包含 `INSendMessageIntent`。

Accessing a user’s Focus status requires their authorization. To let the user know how the app uses their Focus status, include a usage description string. Provide this usage description string as a value for the `Privacy` - `Focus Status Usage Description` key in the app’s `Info.plist` file.

访问用户的专注状态需要他们的授权。为了让用户知道应用如何使用他们的专注状态，需要提供一个使用说明字符串。将这个使用说明字符串作为 APP 的 `Info.plist` 文件中的 `Privacy` - `Focus Status Usage Description` 键的值提供。

## Donate Intent Interactions - 贡献意图交互

Donate an intent interaction for each communication that takes place in the app. The app should donate both outgoing and incoming communication interactions. Donate incoming interactions to update communication notifications and enable their unique user experience and breakthrough behavior. Donate outgoing interactions when the current user sends messages or initiates calls. This allows the system to make better suggestions and provide communication notification functionality.

对于 APP 中发生的每次通讯，都应贡献一个意图交互。APP 应该既贡献出去的通信交互，也贡献进来的通信交互。贡献进来的交互以更新通信通知，并启用它们独特的用户体验和突破行为。贡献出去的交互则发生在当前用户发送消息或发起呼叫时。这些都让系统作出更好的建议和提供通信通知功能。

The sample initializes interactions in `CommunicationMapper.ineraction(communicationInformation:)` and donates them in the `suggest(communicationInformation:completion:)` method. The provided communication information determines the interaction’s direction.

示例在 `CommunicationMapper.ineraction(communicationInformation:)` 方法中初始化交互，并在 `suggest(communicationInformation:completion:)` 方法中贡献它们。提供的通信信息决定了交互的方向。

```
    /// Outgoing messages and calls suggest people involved for Focus breakthrough.
    /// 发出的消息和电话暗示了可能被允许打破专注状态的人。
    static func suggest(communicationInformation: CommunicationInformation,
                        completion: @escaping (Result<INInteraction, Error>) -> Void) {
        do {
            // Create an INInteraction.
            // 创建一个 INInteraction。
            let interaction = try CommunicationMapper.interaction(communicationInformation: communicationInformation)
            // Donate INInteraction to the system.
            // 把 INInteraction 贡献给系统。
            interaction.donate { [completion] error in
                DispatchQueue.global(qos: .userInitiated).async {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(interaction))
                    }
                }
            }
        } catch let error {
            // Catch CommunicationMapper errors.
            // 捕获 CommunicationMapper 错误。
            completion(.failure(error))
        }
    }
```

## Update Notification Content - 更新通知内容

To display a communication notification, your app should update the notification’s content. This allows the notification to break through scheduled notification summaries. It’s also possible for communication notifications to break through an enabled Focus when the Allowed People list contains the sender. Use the same intent object that initialized the incoming interaction. Wait for the interaction donation to complete before updating notification content.

为了显示通信通知，您的 APP 应更新通知的内容。这使得通知能够穿透预定的通知摘要。当允许人员列表中包含发送者时，通信通知也可能穿透启用的“专注”。使用初始化与进来的交互的相同意图对象。在更新通知内容之前，等待交互贡献完成。

The sample updates notification content in the Notification Service Extension by calling `CommunicationInteractor.update(notificationContent:communicationInformation:completion:)`.

示例在通知服务扩展中通过调用 `CommunicationInteractor.update(notificationContent:communicationInformation:completion:)` 更新通知内容。

```
    /// Update incoming notifications with a message or call information to allow the following:
    /// - Display an avatar, if present.
    /// - Check if sender is allowed to break through.
    /// - Update notification title (sender's name) and subtitle (group information).
    /// 更新进来的消息或电话信息的通知以实现以下目标：
    /// - 如果存在，显示头像。
    /// - 检查发送者是否被允许突破。
    /// - 更新通知标题（发送者的名字）和副标题（群组信息）。
    @available(iOS 15.0, watchOS 8.0, macOS 12.0, *)
    static func update(notificationContent: UNNotificationContent,
                       communicationInformation: CommunicationInformation,
                       completion: @escaping (Result<UNNotificationContent, Error>) -> Void) {
        suggest(communicationInformation: communicationInformation) { [notificationContent] result in
            switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let interaction):
                    guard let notificationContentProvider = interaction.intent as? UNNotificationContentProviding else {
                        completion(.failure(CommunicationInteractorError.unexpectedIntentType))
                        return
                    }
                    do {
                        let updatedContent = try notificationContent.updating(from: notificationContentProvider)
                        completion(.success(updatedContent))
                    } catch let error {
                        completion(.failure(error))
                    }
            }
        }
    }
```

## Request Focus Status - 请求专注状态

When a user has enabled a Focus, it may be useful to display that status to other users of an app. This informs other users when someone silences their notifications and may not see communications right away.

当用户启用了一种专注模式，将该状态显示给 APP 的其他用户可能会有所帮助。这能够告知其他用户，此时有人静音了他们的通知，并且可能不会立即看到通信。

Accessing the user’s Focus status requires explicit user authorization. To request authorization, use `INFocusStatusCenter.default.requestAuthorization(completionHandler:)` and parse the result. Someone can choose to authorize the app to access their Focus status, deny the app access, or choose neither.

访问用户的专注状态需要明确的用户授权。要请求授权，使用 `INFocusStatusCenter.default.requestAuthorization(completionHandler:)` 方法并解析结果。用户可以选择授权 APP 访问他们的专注状态，拒绝 APP 访问，或者两者都不选择。"

```
    /// Requests FocusStatusCenter authorization.
    /// Parameter completion: Result contains AuthorizationStatus or error.
    /// 请求 FocusStatusCenter 授权。
    /// 参数 completion: Result 包含 AuthorizationStatus 或错误。
    @available(iOS 15.0, watchOS 8.0, macOS 12.0, *)
    static func requestFocusStatusAuthorization(completion: @escaping (Result<AuthorizationStatus, Error>) -> Void) {
        INFocusStatusCenter.default.requestAuthorization { status in
            switch status {
                case .denied:
                    completion(.success(.denied))
                case .authorized:
                    completion(.success(.authorized))
                case .notDetermined:
                    completion(.success(.notDetermined))
                case .restricted:
                    completion(.success(.restricted))
                @unknown default:
                    completion(.success(.notSupported))
            }
        }
    }
```

Once authorized, an app can request the user’s current Focus status. The perspective of the app is important; the user doesn’t appear focused to an app if an enabled Focus allows notifications from that app.

一旦获得授权，APP 就可以请求用户的当前专注状态。APP 的视角很重要；如果一个已启用的专注模式允许来自该应用的通知，那么对于这个 APP 用户看起来并不处于专注状态。

The sample accesses the current Focus status in the `requestFocusStatus(completion:)` method. Unauthorized apps don’t receive a Focus status value. Ensure the app handles the `nil` Focus status case.

示例在 `requestFocusStatus(completion:)` 方法中访问当前的专注状态。未经授权的应用不会接收到状态状态值。确保应用处理了 `nil` 专注状态的情况。

```
    /// Requests current focus status.
    /// Requires UserNotifications and FocusStatus to be authorized and Communication Notifications capability enabled for the app's target.
    /// Parameter completion: Result contains FocusStatus isFocused Bool, which will be true if Focus is enabled and this app
    /// isn't in its Allowed Apps list.
    /// 请求当前专注状态。
    /// 需要同时授权 UserNotifications 和 FocusStatus，以及在 APP 的 target 中启用 Communication Notifications 能力。
    /// 参数 completion: Result 包含了 FocusStatus 的 isFocused 布尔值，如果专注模式开启，并且这个 APP 不在允许的 APP 列表中这个值将是 true。
    @available(iOS 15.0, watchOS 8.0, macOS 12.0, *)
    static func requestFocusStatus(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let isFocused = INFocusStatusCenter.default.focusStatus.isFocused else {
            completion(.failure(CommunicationInteractorError.focusStatusNotAvailable))
            return
        }
        completion(.success(isFocused))
    }
```

Observe Focus status changes from an Intents app extension. This extension launches in the background to handle interactions between your app and `SiriKit`. To learn more about Intents app extensions, see [Creating an Intents App Extension](https://developer.apple.com/documentation/sirikit/intent_handling_infrastructure/creating_an_intents_app_extension). Ensure your Intents app extension target includes support for `INShareFocusStatusIntent`. The Intents app extension target’s General tab in the project file contains the list of supported intents. Include the class names of all supported intents in the Supported Intents section.

从意图应用扩展观察专注状态的变化。此扩展在后台启动，以处理您的应用和 `SiriKit` 之间的交互。要了解更多关于意图应用扩展的信息，请参阅《[创建一个意图应用扩展](https://developer.apple.com/documentation/sirikit/intent_handling_infrastructure/creating_an_intents_app_extension)》。确保您的意图应用扩展 target 包括对 `INShareFocusStatusIntent` 的支持。项目文件中意图应用扩展 target 的 General 标签包含了支持的意图列表。在 Supported Intents 部分包含所有支持的意图的类名。

The Intents app extension in the sample handles incoming `INShareFocusStatusIntent` objects. When doing so, the sample uses the intent itself to access the `isFocused` bool directly instead of using the default `INFocusStatusCenter`.

在示例中的意图应用扩展处理了进来的 `INShareFocusStatusIntent` 对象。当这么做时，示例使用意图自己来直接访问 `isFocused` 布尔值，而不是使用默认的 `INFocusStatusCenter`。

```
/**
     For this Intent to be handled, the following requirements must be met:
     FocusStatusCenter authorized for parent app (target).
     UserNotifications authorized for parent app (target).
     Communication Notifications capability (entitlement) added to the parent app (target).
     */
/**
     要处理这个意图，必须满足以下要求：
     FocusStatusCenter 已授权给父应用（target）。
     UserNotifications 已授权给父应用（target）。
     Communication Notifications 能力（entitlement）已添加到父应用（target）。
     */
    func handle(intent: INShareFocusStatusIntent, completion: @escaping (INShareFocusStatusIntentResponse) -> Void) {
        let response = INShareFocusStatusIntentResponse(code: .success, userActivity: nil)
        if let isFocused = intent.focusStatus?.isFocused {
            // Send isFocused value to servers or AppGroup.
            // 发送 isFocused 值到服务端或者 AppGroup。
            print("Is user focused: \(isFocused)")
        }
        completion(response)
    }
```


# See Also - 其他参考
## Sample code - 示例代码

### [Implementing Alert Push Notifications](https://developer.apple.com/documentation/usernotifications/implementing-alert-push-notifications) - 实现警告推送通知

Add visible alert notifications to your app by using the UserNotifications framework.

使用 UserNotifications 框架添加可见的警告通知到你的 APP。

### [Implementing Background Push Notifications](https://developer.apple.com/documentation/usernotifications/implementing-background-push-notifications) - 实现后台推送通知

Add background notifications to your app by using the UserNotifications framework.

使用 UserNotifications 框架添加后台通知到你的 APP。