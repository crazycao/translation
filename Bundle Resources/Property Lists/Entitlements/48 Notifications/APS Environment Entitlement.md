# APS Environment Entitlement APS 环境授权

原文地址：[https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)

The environment for push notifications.

推送通知所使用的环境。

> iOS 10.0+ | iPadOS 10.0+ | tvOS 10.0+ | visionOS 1.0+ | watchOS 3.0+

> iOS 10.0 及以上 | iPadOS 10.0 及以上 | tvOS 10.0 及以上 | visionOS 1.0 及以上 | watchOS 3.0 及以上

## 1. Details - 详细信息

- Key

    aps-environment

- Type

    string

- 键

    aps-environment

- 类型

    string

## 2. Possible values - 可能的值

- development

    The APNs development environment.

- production

    The APNs production environment.

- development

    APNs 开发环境。

- production

    APNs 生产环境。

## 3. Discussion - 讨论

This key specifies whether to use the development or production Apple Push Notification service (APNs) environment when registering for push notifications.

此键指定在注册推送通知时，使用 Apple 推送通知服务（APNs）的开发环境还是生产环境。

Xcode sets the value of the entitlement based on your app’s current provisioning profile. For example, if you’re using a development provisioning profile, Xcode sets the value to `development`. Production provisioning profile and [Prerelease Versions and Beta Testers](https://developer.apple.com/documentation/appstoreconnectapi/prerelease-versions-and-beta-testers) use `production`. These default settings can be modified. The development environment is also referred to as the sandbox environment.

Xcode 会根据应用当前的描述文件设置这项授权的值。例如，如果使用的是开发描述文件，Xcode 会将该值设为 `development`。生产描述文件、[预发布版本和 Beta 测试人员](https://developer.apple.com/documentation/appstoreconnectapi/prerelease-versions-and-beta-testers)，使用 `production`。这些默认设置可以修改。开发环境也称为沙盒环境。

Use this entitlement for both the UserNotifications and PushKit frameworks.

UserNotifications 和 PushKit 这两个框架都使用这项授权。

To add this entitlement to your app, enable the Push Notifications capability in Xcode.

要为应用添加这项授权，请在 Xcode 中启用 Push Notifications（推送通知）能力。

# See also - 其他参考

## Related Documentation - 相关文档

### Registering your app with APNs - 向 APNs 注册你的应用

Communicate with Apple Push Notification service (APNs) and receive a unique device token that identifies your app.

与 Apple 推送通知服务（APNs）通信，并接收一个用于标识你的应用的唯一设备令牌。

### PushKit - PushKit 框架

Respond to push notifications related to your app’s complications, file providers, and VoIP services.

响应与应用的 complications（复杂功能）、文件提供程序和 VoIP 服务相关的推送通知。

## Notifications - 通知

### APS Environment (macOS) Entitlement - APS 环境（macOS）授权

The environment for push notifications in macOS apps.

macOS 应用中推送通知所使用的环境。

Key: com.apple.developer.aps-environment

键：com.apple.developer.aps-environment

### Critical Alerts - 关键警报

An entitlement that permits an app to receive critical alert notifications.

一项允许应用接收关键警报通知的授权。

Key: com.apple.developer.usernotifications.critical-alerts

键：com.apple.developer.usernotifications.critical-alerts

### com.apple.developer.usernotifications.filtering - 用户通知过滤

Enable receiving notifications without displaying the notification to the user.

允许在不向用户显示通知的情况下接收通知。
