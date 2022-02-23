# App Tracking Transparency

原文地址：[https://developer.apple.com/documentation/apptrackingtransparency](https://developer.apple.com/documentation/apptrackingtransparency)

> **Availability**
> 
> iOS 14.0+
iPadOS 14.0+
macOS 11.0+
Mac Catalyst 14.0+
tvOS 14.0+

Request user authorization to access app-related data for tracking the user or the device.

请求用户授权以访问应用程序相关数据以跟踪用户或设备。

# Overview 概览

You must use the AppTrackingTransparency framework if your app collects data about end users and shares it with other companies for purposes of tracking across apps and web sites. The AppTrackingTransparency framework presents an app-tracking authorization request to the user and provides the tracking authorization status.

如果您的应用程序收集终端用户的数据并与其他公司共享，以便跨应用程序和网站跟踪用户，则必须使用 AppTrackingTransparency 框架。AppTrackingTransparency 框架向用户展示应用程序跟踪授权请求，并提供跟踪授权状态。

To use the AppTrackingTransparency framework:

1. Set up a [NSUserTrackingUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription) to display a system-permission alert request for your app installed on end-user devices.

2. Call [requestTrackingAuthorization(completionHandler:)](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization) to present the app-tracking authorization request to the end user.

3. Use [trackingAuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus) to determine the app-tracking permission status. See [ATTrackingManager.AuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus) for status enums.

要使用 AppTrackingTransparency 框架：

1. 设置 [NSUserTrackingUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription) 以显示一个系统权限弹窗，为安装在终端用户设备上的应用程序的发起请求。
2. 调用 [requestTrackingAuthorization(completionHandler:)](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization) 将应用程序跟踪授权请求呈现给终端用户。
3. 使用 [trackingAuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus) 确定应用程序跟踪权限状态。状态枚举参见 [ATTrackingManager.AuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus)。

For more information about app tracking and privacy, see [User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/) and [App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/).

有关应用程序跟踪和隐私的更多信息，请参阅 [User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/) 和 [App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/)。

# Topics 主题

## Essentials

### property list key [NSUserTrackingUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription)

A message that informs the user why an app is requesting permission to use data for tracking the user or the device.

一条告知用户应用程序请求使用数据跟踪用户或设备的原因的消息。

**Name:** Privacy - Tracking Usage Description

## Class and Components

### class [ATTrackingManager](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager)

A class that provides a tracking authorization request and the tracking authorization status of the app.

提供应用程序的跟踪授权请求和跟踪授权状态的类。