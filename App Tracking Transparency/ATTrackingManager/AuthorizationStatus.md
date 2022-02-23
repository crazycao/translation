# ATTrackingManager.AuthorizationStatus

原文地址：[https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus)

> **Availability**
> 
> iOS 14.0+
iPadOS 14.0+
macOS 11.0+
Mac Catalyst 14.0+
tvOS 14.0+

The status values for app tracking authorization.

应用程序跟踪授权的状态值。

# Declaration 声明

```
enum AuthorizationStatus : UInt, @unchecked Sendable
```

# Overview 概览

After a device receives an authorization request to approve access to app-related data that can be used for tracking the user or the device, the returned value is either:

- [ATTrackingManager.AuthorizationStatus.authorized](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/authorized), or
- [ATTrackingManager.AuthorizationStatus.denied](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/denied).

在设备收到关于批准对可用于跟踪用户或设备的应用程序相关数据的访问的授权请求以后，返回值为：

- [ATTrackingManager.AuthorizationStatus.authorized](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/authorized)，或
- [ATTrackingManager.AuthorizationStatus.denied](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/denied).

Before a device receives an authorization request to approve access to app-related data that can be used for tracking the user or the device, the returned value is: [ATTrackingManager.AuthorizationStatus.notDetermined](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/notdetermined).

在设备收到关于批准对可用于跟踪用户或设备的应用程序相关数据的访问的授权请求之前，返回值为：[ATTrackingManager.AuthorizationStatus.notDetermined](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/notdetermined)。

If authorization to use app tracking data is restricted, the value is: [ATTrackingManager.AuthorizationStatus.restricted](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/restricted).

如果使用应用程序跟踪数据的授权受到限制，则该值为：[ATTrackingManager.AuthorizationStatus.restricted](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/restricted)。

# Topics 主题

## Cases 实例

### case [authorized](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/authorized)

The value that returns if the user authorizes access to app-related data for tracking the user or the device.

如果用户授权访问应用程序相关数据以跟踪用户或设备，则返回该值。

### case [denied](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/denied)

The value that returns if the user denies authorization to access app-related data for tracking the user or the device.

如果用户拒绝访问用于跟踪用户或设备的应用程序相关数据的授权，则返回该值。

### case [notDetermined](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/notdetermined)

The value that returns when the app can’t determine the user’s authorization status for access to app-related data for tracking the user or the device.

当应用程序无法确定用户关于访问应用程序相关数据以跟踪用户或设备的授权状态时，返回该值。

### case [restricted](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/restricted)

The value that returns if authorization to access app-related data for tracking the user or the device has a restricted status.

如果访问应用程序相关数据以跟踪用户或设备的授权处于受限状态，则返回该值。

# Relationships 关系

## Conforms To

[Sendable](https://developer.apple.com/documentation/swift/sendable)

# See Also 其他参考

## Determining Tracking Authorization Status 确定跟踪授权状态

### class var [trackingAuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus): ATTrackingManager.AuthorizationStatus

The authorization status that is current for the calling application.

发起调用的应用程序的当前授权状态。