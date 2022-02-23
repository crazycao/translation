# trackingAuthorizationStatus

原文地址：[https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus)

> **Availability**
> 
> iOS 14.0+
iPadOS 14.0+
macOS 11.0+
Mac Catalyst 14.0+
tvOS 14.0+

The authorization status that is current for the calling application.

发起调用的应用程序的当前授权状态。

# Declaration 声明

```
class var trackingAuthorizationStatus: ATTrackingManager.AuthorizationStatus { get }
```

# Discussion 讨论

Use the `trackingAuthorizationStatus` property to check authorization status.

使用 `trackingAuthorizationStatus` 属性检查授权状态。

# See Also 其他参考

## Determining Tracking Authorization Status 确定跟踪授权状态

### enum [ATTrackingManager.AuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus)

The status values for app tracking authorization.

应用程序跟踪授权的状态值。
