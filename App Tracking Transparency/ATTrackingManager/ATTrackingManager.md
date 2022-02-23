# ATTrackingManager

原文地址：[https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager)

> **Availability**
> 
> iOS 14.0+
iPadOS 14.0+
macOS 11.0+
Mac Catalyst 14.0+
tvOS 14.0+

A class that provides a tracking authorization request and the tracking authorization status of the app.

提供应用程序的跟踪授权请求和跟踪授权状态的类。

# Declaration 声明

```
class ATTrackingManager : NSObject
```

# Topics 主题

## Requesting Authorization 请求授权

### class func [requestTrackingAuthorization(completionHandler: (ATTrackingManager.AuthorizationStatus) -> Void)](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization)

The request for user authorization to access app-related data.

用户访问应用程序相关数据的授权请求。

## Determining Tracking Authorization Status 确定跟踪授权状态

### class var [trackingAuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus): ATTrackingManager.AuthorizationStatus

The authorization status that is current for the calling application.

发起调用的应用程序的当前授权状态。

### enum [ATTrackingManager.AuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus)

The status values for app tracking authorization.

应用程序跟踪授权的状态值。

# Relationships

## Inherits From

### [NSObject](https://developer.apple.com/documentation/objectivec/nsobject)