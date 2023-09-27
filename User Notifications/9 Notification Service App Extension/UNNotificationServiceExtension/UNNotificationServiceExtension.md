# UNNotificationServiceExtension

原文地址：
[https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension)

An object that modifies the content of a remote notification before it’s delivered to the user.

用于在将远程通知发送给用户之前修改其内容的对象。

> iOS 10.0+
iPadOS 10.0+
macOS 10.14+
Mac Catalyst 13.1+
watchOS 6.0+
visionOS 1.0+ Beta

```
class UNNotificationServiceExtension : NSObject
```

# Overview 概述

A UNNotificationServiceExtension object provides the entry point for a notification service app extension. This object lets you customize the content of a remote notification before the system delivers it to the user. A notification service app extension doesn’t present any UI of its own. Instead, it’s launched on demand when the system delivers a notification of the appropriate type to the user’s device. You use this extension to modify the notification’s content or download content related to the extension. For example, you could use the extension to decrypt an encrypted data block or to download images associated with the notification.

`UNNotificationServiceExtension` 对象提供了通知服务应用扩展的入口点。此对象允许您在系统将远程通知传递给用户之前自定义其内容。通知服务应用扩展本身不呈现任何用户界面。相反，它是在系统将适当类型的通知传递到用户设备时按需启动的。您可以使用此扩展来修改通知的内容或下载与扩展相关的内容。例如，您可以使用该扩展来解密加密的数据块或下载与通知相关联的图像。

You don’t create `UNNotificationServiceExtension` objects yourself. Instead, the Xcode template for a notification service extension target contains a subclass for you to modify. Use the methods of that subclass to implement your app extension’s behavior. When your app recieves a remote notification for your app, the system loads your extension and calls its [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) method given the following conditions:

您不需要自己创建 UNNotificationServiceExtension 对象。相反，Xcode 的通知服务扩展模板包含一个子类供您修改。使用该子类的方法来实现您的应用扩展的行为。当您的应用接收到针对您的应用程序的远程通知时，系统会加载您的扩展并调用其 [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) 方法，需具备以下条件：

- Your app has configured the remote notification to display an alert.
- The remote notification’s `aps` dictionary includes the `mutable-content` key with the value set to `1`.

- 您的应用已配置远程通知以显示警报（Alert）。
- 远程通知的 `aps` 字典包括 `mutable-content` 键，并将其值设置为 `1`。

> **Note** **注意**
>
> You can’t modify silent notifications or those that only play a sound or badge the app’s icon.
> 
> 您无法修改静默通知或仅播放声音或修改应用程序图标的角标的通知。

The [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) method performs the main work of your extension. You use that method to make any changes to the notification’s content. That method has a limited amount of time to perform its task and execute the provided completion block. If your method doesn’t finish in time, the system calls the [serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) method to give you one last chance to submit your changes. If you don’t update the notification content before time expires, the system displays the original content.

[didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) 方法执行扩展的主要工作。您可以使用该方法对通知的内容进行任何更改。该方法有限的时间来完成任务并执行提供的完成处理 block。如果您的方法没有及时完成，系统将调用 [serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) 方法，给您最后一次机会提交更改。如果在时间到期之前未更新通知内容，系统将显示原始内容。

As for any app extension, you deliver a notification service app extension class as a bundle inside your app. The template that Xcode provides configures the `Info.plist` file automatically for this app extension type. Specifically, it sets the value of the [NSExtensionPointIdentifier](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/AppExtensionKeys.html#//apple_ref/doc/uid/TP40014212-SW15) key to `com.apple.usernotifications.service` and sets the value of the [NSExtensionPrincipalClass](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/AppExtensionKeys.html#//apple_ref/doc/uid/TP40014212-SW16) key to the name of your `UNNotificationServiceExtension` subclass.

对于任何应用扩展，您将通知服务应用扩展类作为 bundle 内置于您的应用中。Xcode提供的模板会自动为此应用扩展类型配置 `Info.plist` 文件。具体而言，它将 [NSExtensionPointIdentifier](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/AppExtensionKeys.html#//apple_ref/doc/uid/TP40014212-SW15) 键的值设置为 `com.apple.usernotifications.service`，并将 [NSExtensionPrincipalClass](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/AppExtensionKeys.html#//apple_ref/doc/uid/TP40014212-SW16) 键的值设置为您的 `UNNotificationServiceExtension` 子类的名称。

For information about how to set up and send remote notifications, see [Setting up a remote notification server](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server).

关于如何设置和发送远程通知的信息，请参阅《[设置远程通知服务器](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server)》。

## Subclassing Notes - 子类化注意事项

The Xcode templates provide a subclass of `UNNotificationServiceExtension` for you to modify. You must implement the [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) method and use it to process incoming notifications. It’s also strongly recommended that you override the [serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) method.

Xcode 模板提供了一个 `UNNotificationServiceExtension` 的子类供您修改。您必须实现 [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) 方法并使用它来处理传入的通知。强烈建议您也覆写 [serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) 方法。

# Topics - 主题

## Processing Notifications - 处理通知

### [func didReceive(UNNotificationRequest, withContentHandler: (UNNotificationContent) -> Void)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive)

Asks you to make any needed changes to the notification and notify the system when you’re done.

请对通知进行必要的更改，并在完成后通知系统。

### [func serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire)

Tells you that the system is terminating your extension.

通知您系统正在终止您的扩展。

# Relationships - 关系
## Inherits From
NSObject

# See Also - 其他参考
## Notification service app extension - 通知服务应用扩展
### Modifying content in newly delivered notifications - 修改新收到的通知中的内容

Modify the payload of a remote notification before it’s displayed on the user’s iOS device.

在用户的 iOS 设备上显示通知之前，修改远程通知的有效载荷。
