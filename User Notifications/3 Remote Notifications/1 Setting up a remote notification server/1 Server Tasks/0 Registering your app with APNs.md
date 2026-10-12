# Registering your app with APNs 向 APNs 注册你的应用

原文地址：[https://developer.apple.com/documentation/usernotifications/registering-your-app-with-apns](https://developer.apple.com/documentation/usernotifications/registering-your-app-with-apns)

Communicate with Apple Push Notification service (APNs) and receive a unique device token that identifies your app.

与 Apple 推送通知服务（APNs）通信，并接收一个用于标识你的应用的唯一设备令牌。

## 1. Overview - 概览

Apple Push Notification service (APNs) must know the address of a user’s device before it can send notifications to that device. This address takes the form of a device token unique to both the device and your app. At launch time, your app communicates with APNs and receives its device token, which you then forward to your provider server. Your server includes that token with any notifications it sends.

Apple 推送通知服务（APNs）在向用户的设备发送通知之前，必须知道该设备的地址。这个地址是一个设备令牌，同时唯一标识这台设备和你的应用。应用启动时会与 APNs 通信并收到自己的设备令牌，然后你把该令牌转发到提供者服务器。服务器发送任何通知时都会带上这个令牌。

> **Note**
>
> You can’t use the same device token for more than one app, even when the apps are on the same device. Every app must request their own unique device token and forward it to your provider server.

> **注意**
>
> 同一个设备令牌不能用于多个应用，即使这些应用在同一台设备上也不行。每个应用都必须请求自己唯一的设备令牌，并把它转发到你的提供者服务器。

### 1.1 Enable the push notifications capability - 启用推送通知能力

To add the required entitlements to your app, enable the Push Notifications capability in your Xcode project, as shown in the figure below. Enabling this option in iOS adds the [APS Environment Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment) to the app. In macOS, it adds the [APS Environment (macOS) Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.aps-environment). See [Enable push notifications](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1) in Xcode help for more information.

要为应用添加所需的授权，请在 Xcode 项目中启用 Push Notifications（推送通知）能力，如下图所示。在 iOS 上启用此选项，会为应用添加 [APS Environment Entitlement（APS 环境授权）](https://developer.apple.com/documentation/bundleresources/entitlements/aps-environment)。在 macOS 上，则会添加 [APS Environment (macOS) Entitlement（APS 环境（macOS）授权）](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.aps-environment)。更多信息，请参阅 Xcode 帮助中的 [Enable push notifications（启用推送通知）](https://help.apple.com/xcode/mac/current/#/devdfd3d04a1)。

![Add entitlements to your Xcode project by enabling the push notification capability in the Capabilities tab.
在 Capabilities（能力）标签页中启用推送通知能力，为 Xcode 项目添加授权。](https://developer.apple.com/tutorials/images/com.apple.usernotifications/media-4321361@2x.png)

> **Important**
>
> In your developer account, enable the push notification service for the App ID assigned to your project. For more information about configuring your developer account, go to your [Developer Account](https://developer.apple.com/account/#/overview/) page.

> **重要**
>
> 在开发者账户中，为分配给该项目的 App ID 启用推送通知服务。有关配置开发者账户的更多信息，请前往你的 [Developer Account（开发者账户）](https://developer.apple.com/account/#/overview/) 页面。

### 1.2 Register your app and retrieve your app’s device token - 注册应用并获取应用的设备令牌

Register your app with APNs and receive a globally unique device token, which is effectively the address of your app on the current device. Your provider server must have this token before it can deliver notifications to the device.

向 APNs 注册你的应用，并接收一个全局唯一的设备令牌。它实际上就是你的应用在当前设备上的地址。提供者服务器必须先拥有这个令牌，才能向该设备投递通知。

You register your app and receive your device token each time your app launches using Apple-provided APIs. The registration process is similar across platforms:

每次应用启动时，都要使用 Apple 提供的 API 注册应用并接收设备令牌。各平台的注册过程相似：

- In iOS and tvOS, call the [registerForRemoteNotifications()](https://developer.apple.com/documentation/uikit/uiapplication/registerforremotenotifications()) method of [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication) to request the device token. Upon successful registration, you receive the token in your app delegate’s [application(_:didRegisterForRemoteNotificationsWithDeviceToken:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/application(_:didregisterforremotenotificationswithdevicetoken:)) method.
- In macOS, call the [registerForRemoteNotifications()](https://developer.apple.com/documentation/appkit/nsapplication/registerforremotenotifications()) method of [NSApplication](https://developer.apple.com/documentation/appkit/nsapplication) to request the device token. Upon successful registration, you receive the token in your app delegate’s [application(_:didRegisterForRemoteNotificationsWithDeviceToken:)](https://developer.apple.com/documentation/appkit/nsapplicationdelegate/application(_:didregisterforremotenotificationswithdevicetoken:)) method.
- In watchOS, call the [registerForRemoteNotifications()](https://developer.apple.com/documentation/watchkit/wkapplication/registerforremotenotifications()) method of [WKExtension](https://developer.apple.com/documentation/watchkit/wkextension) to request the device token. Upon successful registration, you receive the token in your extension delegate’s [didRegisterForRemoteNotifications(withDeviceToken:)](https://developer.apple.com/documentation/watchkit/wkapplicationdelegate/didregisterforremotenotifications(withdevicetoken:)) method.

- 在 iOS 和 tvOS 上，调用 [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication) 的 [registerForRemoteNotifications()](https://developer.apple.com/documentation/uikit/uiapplication/registerforremotenotifications()) 方法来请求设备令牌。注册成功后，你会在应用委托的 [application(_:didRegisterForRemoteNotificationsWithDeviceToken:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/application(_:didregisterforremotenotificationswithdevicetoken:)) 方法中收到该令牌。
- 在 macOS 上，调用 [NSApplication](https://developer.apple.com/documentation/appkit/nsapplication) 的 [registerForRemoteNotifications()](https://developer.apple.com/documentation/appkit/nsapplication/registerforremotenotifications()) 方法来请求设备令牌。注册成功后，你会在应用委托的 [application(_:didRegisterForRemoteNotificationsWithDeviceToken:)](https://developer.apple.com/documentation/appkit/nsapplicationdelegate/application(_:didregisterforremotenotificationswithdevicetoken:)) 方法中收到该令牌。
- 在 watchOS 上，调用 [WKExtension](https://developer.apple.com/documentation/watchkit/wkextension) 的 [registerForRemoteNotifications()](https://developer.apple.com/documentation/watchkit/wkapplication/registerforremotenotifications()) 方法来请求设备令牌。注册成功后，你会在扩展委托的 [didRegisterForRemoteNotifications(withDeviceToken:)](https://developer.apple.com/documentation/watchkit/wkapplicationdelegate/didregisterforremotenotifications(withdevicetoken:)) 方法中收到该令牌。

In addition to handling successful registrations with APNs, prepare your app to handle unsuccessful registrations by implementing the [application(_:didFailToRegisterForRemoteNotificationsWithError:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/application(_:didfailtoregisterforremotenotificationswitherror:)) method. Registration might fail if the user’s device isn’t connected to the network, if the APNs server is unreachable for any reason, or if the app doesn’t have the proper code-signing entitlement. When a failure occurs, set a flag and try to register again at a later time.

除了处理向 APNs 注册成功的情况，还要实现 [application(_:didFailToRegisterForRemoteNotificationsWithError:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/application(_:didfailtoregisterforremotenotificationswitherror:)) 方法，以便处理注册失败。如果用户的设备没有联网、APNs 服务器因任何原因无法访问，或者应用没有正确的代码签名授权，注册都可能失败。发生失败时，设置一个标志，并在稍后再次尝试注册。

The code snippet below shows a sample implementation of the iOS app delegate methods needed to register for remote notifications and receive the corresponding token. The `sendDeviceTokenToServer` method is a custom method that the app uses to send the data to its provider server.

下面的代码片段展示了注册远程通知并接收对应令牌所需的 iOS 应用委托方法的示例实现。`sendDeviceTokenToServer` 是应用用来把数据发送到其提供者服务器的自定义方法。

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    UIApplication.shared.registerForRemoteNotifications()
    return true
}


func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    self.sendDeviceTokenToServer(data: deviceToken)
}


func application(_ application: UIApplication,
                 didFailToRegisterForRemoteNotificationsWithError
                 error: Error) {
    // Try again later.
}
```

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // 应用启动后的自定义位置。
    UIApplication.shared.registerForRemoteNotifications()
    return true
}


func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    self.sendDeviceTokenToServer(data: deviceToken)
}


func application(_ application: UIApplication,
                 didFailToRegisterForRemoteNotificationsWithError
                 error: Error) {
    // 稍后再试。
}
```

> **Important**
>
> Never cache device tokens in local storage. APNs issues a new token when the user restores a device from a backup, when the user installs your app on a new device, and when the user reinstalls the operating system. You get an up-to-date token each time you ask the system to provide the token.

> **重要**
>
> 切勿把设备令牌缓存在本地存储中。用户从备份恢复设备、在新设备上安装你的应用，或重新安装操作系统时，APNs 都会签发新的令牌。每次向系统请求令牌，你都会得到最新的令牌。

### 1.3 Forward tokens to your provider server - 将令牌转发到提供者服务器

Upon receiving a device token, open a network connection from your app to your provider server. Securely forward the device token and any other information you need to identify the specific user to your server. For example, you might include the user’s login name or something that connects them to your service. Encrypt any information you send over the network.

收到设备令牌后，从你的应用向提供者服务器建立网络连接。把设备令牌，以及识别该用户所需的其他信息，安全地转发到服务器。例如，可以附上用户的登录名，或能把该用户关联到你的服务的其他信息。经网络发送的任何信息都要加密。

On your provider server, store tokens in a secure place where you can access them to send notifications. When generating notifications, your server must be able to send notifications to specific devices. So, if you have notifications linked to a user’s account, store device tokens with the user’s account information. Because a user can have multiple devices, prepare your app to handle multiple device tokens.

在提供者服务器上，把令牌存放在可以用来发送通知的安全位置。生成通知时，服务器必须能够把通知发到特定设备。因此，如果通知与某个用户账户相关联，就把设备令牌和该用户的账户信息存放在一起。由于一个用户可以拥有多台设备，请让你的应用能够处理多个设备令牌。

For information about how to send payloads and device tokens to APNs, see [Sending notification requests to APNs](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns).

有关如何把负载和设备令牌发送到 APNs 的信息，请参阅《[向 APNs 发送通知请求](https://developer.apple.com/documentation/usernotifications/sending-notification-requests-to-apns)》。

# See also - 其他参考

## Server tasks - 服务器任务

### Generating a remote notification - 生成远程通知

Send notifications to the user’s device with a JSON payload.

携带 JSON 负载向用户的设备发送通知。

### Pushing background updates to your App - 向你的应用推送后台更新

Deliver notifications that wake your app and update it in the background.

投递能唤醒你的应用并在后台更新它的通知。

### Establishing a connection to Apple Push Notification service (APNs) - 建立与 Apple 推送通知服务（APNs）的连接

Secure your communications with APNs to send API requests.

确保与 APNs 的通信安全，以便发送 API 请求。
