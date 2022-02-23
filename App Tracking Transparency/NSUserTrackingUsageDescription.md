# NSUserTrackingUsageDescription

原文地址：[https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription)

> **Availability**
> 
> iOS 14.0+
iPadOS 14.0+
tvOS 14.0+

A message that informs the user why an app is requesting permission to use data for tracking the user or the device.

一条告知用户应用程序请求使用数据跟踪用户或设备的原因的消息。

# Details 详情

**Name**

Privacy - Tracking Usage Description

**Type**

String

# Discussion 讨论

If your app calls the App Tracking Transparency API, you must provide custom text, known as a _usage-description string_, which displays as a system-permission alert request. The usage-description string tells the user why the app is requesting permission to use data for tracking the user or the device. The user has the option to grant or deny the authorization request. If you don’t include a usage-description string, your app may crash when a user first launches it.

如果您的应用程序调用了 App Tracking Transparency API，则必须提供自定义文本，称之为 _用途说明字符串_，显示为系统权限请求弹窗。用途说明字符串告知用户应用程序请求使用数据跟踪用户或设备的原因。用户可以选择允许或拒绝授权请求。如果未包含用途说明字符串，则当用户首次启动应用程序时，应用程序可能会崩溃。

Make sure your app requests permission to track sometime before tracking occurs. This could be at first launch or when using certain features in your app. For example, when signing on with a third-party SSO.

确保你的应用程序在跟踪之前请求跟踪权限。这可能是在第一次启动或在应用程序中使用某些功能时。例如，使用第三方SSO登录时。

Set the `NSUserTrackingUsageDescription` key in the [Information Property List](https://developer.apple.com/documentation/bundleresources/information_property_list) (Info.plist):

1. Select your project’s _Info.plist_ file in Xcode Project navigator.

2. Modify the file using the Xcode Property List Editor: Privacy - Tracking Usage Description.

- Use sentence-style capitalization and appropriate ending punctuation. Keep the text short and specific. You don’t need to include your app name because the system already identifies your app.

- If the title is a sentence fragment, don’t add ending punctuation.

在  [Information Property List](https://developer.apple.com/documentation/bundleresources/information_property_list) (Info.plist) 中设置 `NSUserTrackingUsageDescription` 关键字：

1. 在 Xcode 项目导航器中选中你的项目的 _Info.plist_ 文件。
2. 使用 Xcode 属性列表编辑器修改文件：隐私 - 跟踪用途说明。

- 使用句子风格的大写规范（译者注：只对首字母大写）和适当的结尾标点。保持文字简短和具体。你不需要包括你的应用程序名，因为系统已经识别了你的应用程序。
- 如果标题是一个句子片段，则不要添加结尾标点符号。

See [Apple’s Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/accessing-user-data/) for example usage descriptions.

用途说明的例子请参阅 [Apple’s Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/accessing-user-data/)。