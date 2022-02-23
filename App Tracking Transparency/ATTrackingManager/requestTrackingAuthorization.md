# requestTrackingAuthorization(completionHandler:)

原文地址：[https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization)

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
class func requestTrackingAuthorization(completionHandler completion: @escaping (ATTrackingManager.AuthorizationStatus) -> Void)
```

# Discussion 讨论

>  **Concurrency Note** 
> 
> You can call this method from synchronous code using a completion handler, as shown on this page, or you can call it as an asynchronous method that has the following declaration:
>
> ```class func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus```
> 
> For information about concurrency and asynchronous code in Swift, see [Calling Objective-C APIs Asynchronously](https://developer.apple.com/documentation/swift/calling_objective-c_apis_asynchronously).
> 
> **并发注意事项**
>
> 通过使用完成句柄，您可以从同步代码中调用此方法，如本页所示，也可以将其作为具有以下声明的异步方法调用：
>
> ```class func requestTrackingAuthorization() async -> ATTrackingManager.AuthorizationStatus```
> 
> 关于 Swift 中并发和异步的更多信息，请参阅 [Calling Objective-C APIs Asynchronously](https://developer.apple.com/documentation/swift/calling_objective-c_apis_asynchronously)。

The `requestTrackingAuthorization(completionHandler:)` is a one-time request to authorize or deny access to app-related data that can be used for tracking the user or the device. The system remembers the user’s choice and doesn’t prompt again unless a user uninstalls and then reinstalls the app on the device.

`requestTrackingAuthorization(completionHandler:)` 是一个一次性请求，用于授权或拒绝访问可用于跟踪用户或设备的应用程序相关数据。系统会记住用户的选择，并且不会再次提示，除非用户卸载并在设备上重新安装应用程序。

Calls to the API only prompt when the application state is `UIApplicationStateActive`. The authorization prompt doesn’t display if another permission request is pending user confirmation. Concurrent requests aren’t preserved by iOS, and calls to the API through an app extension don’t prompt. Check the [trackingAuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus) for a status of [ATTrackingManager.AuthorizationStatus.notDetermined](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/notdetermined) to determine if you need to make an additional call.

仅当应用程序状态为 `UIApplicationStateActive` 时，调用这个 API 才会有提示。如果另一个权限请求正在等待用户确认，则不会显示这个授权提示。iOS 不会保留并发请求，通过应用程序扩展对 API 的调用也不会提示。检查  [trackingAuthorizationStatus](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547038-trackingauthorizationstatus) 是否为 [ATTrackingManager.AuthorizationStatus.notDetermined](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/authorizationstatus/notdetermined) 状态以确定你是否需要再发起一次调用。

> **Important**
>
> To use `requestTrackingAuthorization(completionHandler:)`, the [NSUserTrackingUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription) key must be in the [Information Property List](https://developer.apple.com/documentation/bundleresources/information_property_list).
> 
> **重要**
> 
> 要使用 `requestTrackingAuthorization(completionHandler:)`，必须先将 [NSUserTrackingUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsusertrackingusagedescription) 关键字设置到 [Information Property List](https://developer.apple.com/documentation/bundleresources/information_property_list) 中。