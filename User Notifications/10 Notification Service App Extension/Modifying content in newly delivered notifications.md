# Modifying content in newly delivered notifications - 修改新收到的通知中的内容

原文地址：
[https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications)

Modify the payload of a remote notification before it’s displayed on the user’s iOS device.

在用户的 iOS 设备上显示通知之前，修改远程通知的有效载荷。

# Overview 概述

You may want to modify the content of a remote notification on a user’s iOS device if you need to:

如果您需要执行以下操作之一，您可能希望在用户的 iOS 设备上修改远程通知的内容：

- Decrypt data sent in an encrypted format.
- Download images or other media attachments whose size would exceed the maximum payload size.
- Update the notification’s content, perhaps by incorporating data from the user’s device.

- 解密以加密格式发送的数据。
- 下载大小超过最大有效载荷大小的图像或其他媒体附件。
- 更新通知的内容，例如通过合并来自用户设备的数据。

Modifying a remote notification requires a notification service app extension, which you include inside your iOS app bundle. The app extension receives the contents of your remote notifications before the system displays them to the user, giving you time to update the notification payload. You control which notifications your extension handles.

修改远程通知需要使用通知服务应用扩展，您需要将其包含在 iOS 应用程序包中。应用扩展在系统将远程通知显示给用户之前就会收到远程通知的内容，从而给您足够的时间来更新通知的有效载荷。您可以控制应用扩展处理那些通知。

> **Important** **重要**
>
> Notification service app extensions only operate on remote notifications configured in the system to display an alert to the user. If alerts are disabled for your app, or if the payload specifies only the playing of a sound or the badging of an icon, the extension isn’t employed.
> 
> 通知服务应用扩展仅在系统中配置为向用户显示弹窗的远程通知上运行。如果您的应用禁用了通知弹窗功能，或者如果有效载荷仅指定播放声音或更改 icon 角标，则不会使用应用扩展。


## Add a service app extension to your project - 将服务应用扩展添加到你的工程中

A notification service app extension ships as a separate bundle inside your iOS app. To add this extension to your app:

通知服务应用扩展作为一个独立的捆绑包随同您的 iOS 应用一起发布。将该扩展添加到您的 App 中的步骤如下：

1. Select File > New > Target in Xcode.
2. Select the Notification Service Extension target from the iOS > Application section.
3. Click Next.
4. Specify a name and other configuration details for your app extension.
5. Click Finish.

>

1. 在 XCode 中选中 File > New > Target 。
2. 从 iOS > Application 部分中选中 Notification Service Extension 目标。
3. 点击 Next。
4. 为您的应用扩展指定名称和其他具体配置。
5. 点击 Finish。

## Implement your extension's handler methods - 实现您的扩展处理方法

The notification service app extension template provided by Xcode includes a default implementation for you to modify.

Xcode 提供的通知服务应用扩展模板中包含了一个默认的实现供您修改。

- Use the [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) method to create a new [UNMutableNotificationContent](https://developer.apple.com/documentation/usernotifications/unmutablenotificationcontent) object with the updated content.
- Use the [serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) method to terminate any payload-modification tasks that are still running.
- 使用 [didReceive(_:withContentHandler:)](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648229-didreceive) 方法创建一个带有更新后的内容的 [UNMutableNotificationContent](https://developer.apple.com/documentation/usernotifications/unmutablenotificationcontent) 对象。
- 使用 [serviceExtensionTimeWillExpire()](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension/1648227-serviceextensiontimewillexpire) 方法终止仍在运行的有效载荷修改任务。

Your `didReceive(_:withContentHandler:)` method has only about 30 seconds to modify the payload and call the provided completion handler. If your code takes longer than that, the system calls the `serviceExtensionTimeWillExpire()` method, at which point you must return whatever you can to the system immediately. If you fail to call the completion handler from either method, the system displays the original contents of the notification.

您的 `didReceive(_:withContentHandler:)` 方法只有大约 30 秒的时间来修改有效载荷并调用提供的完成处理程序。如果您的代码执行时间超过这个限制，系统将调用 `serviceExtensionTimeWillExpire()` 方法，此时您必须立即返回任何可用的内容给系统。如果您在这两个方法中都未调用完成处理程序，系统将显示原始通知的内容。

Listing 1 shows an implementation of the [UNNotificationServiceExtension](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension) object that decrypts the contents of a secret message delivered using a remote notification. The `didReceive(_:withContentHandler:)` method decrypts the data and returns a modified version of the notification’s content if it’s successful. If it’s unsuccessful, or if time expires, the extension returns content indicating that the data is still encrypted.

清单1 展示了一个实现了 [UNNotificationServiceExtension](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension) 对象的示例，它会解密使用远程通知传递的秘密消息的内容。`didReceive(_:withContentHandler:)` 方法会解密数据并在成功时返回修改后的通知内容。如果解密失败或时间超过限制，扩展将返回指示数据仍然加密的内容。

**Listing 1** Decrypting data contained in a remote notification  **清单1** 解密远程通知中包含的数据

```
// Storage for the completion handler and content.
// 存储完成句柄和内容
var contentHandler: ((UNNotificationContent) -> Void)?
var bestAttemptContent: UNMutableNotificationContent?
// Modify the payload contents.
// 修改有效载荷内容
override func didReceive(_ request: UNNotificationRequest,
         withContentHandler contentHandler: 
         @escaping (UNNotificationContent) -> Void) {
   self.contentHandler = contentHandler
   self.bestAttemptContent = (request.content.mutableCopy() 
         as? UNMutableNotificationContent)
   
   // Try to decode the encrypted message data.
   // 尝试解码加密的消息数据。
   let encryptedData = bestAttemptContent?.userInfo["ENCRYPTED_DATA"]
   if let bestAttemptContent = bestAttemptContent {
      if let data = encryptedData as? String {
         let decryptedMessage = self.decrypt(data: data)
        bestAttemptContent.body = decryptedMessage
      }
      else {
         bestAttemptContent.body = "(Encrypted)"
      }
      
      // Always call the completion handler when done.
      // 完成时始终调用完成句柄。
      contentHandler(bestAttemptContent)
   }
}
    
// Return something before time expires.
// 在超时之前返回一些东西。
override func serviceExtensionTimeWillExpire() {
   if let contentHandler = contentHandler, 
      let bestAttemptContent = bestAttemptContent {
         
      // Mark the message as still encrypted.   
      // 标记消息仍然是加密的。
      bestAttemptContent.subtitle = "(Encrypted)"
      bestAttemptContent.body = ""
      contentHandler(bestAttemptContent)
   }
}
```

## Configure the payload for the remote notification - 配置远程通知的有效载荷

The system executes your notification service app extension only when a remote notification’s payload contains the following information:

仅当远程通知的有效载荷包含以下信息时，系统才会执行您的通知服务应用扩展：

- The payload must include the `mutable-content` key with a value of `1`.
- The payload must include an alert dictionary with title, subtitle, or body information.

- 有效载荷必须包含 `mutable-content` 键，并将其值设置为 `1`。
- 有效载荷必须包含一个带有标题、副标题或正文信息的 `alert` 字典。

Listing 2 shows the JSON data for a notification payload containing encrypted data. The `mutable-content` flag is set so that the user’s device knows to run the corresponding service app extension, the code for which is shown in .

清单2 是一个包含加密数据的通知有效载荷的 JSON 数据示例。设置了 `mutable-content` 标志以让用户的设备知道运行相应的服务应用扩展，其代码显示在示例中。

**Listing 2** Specifying the remote notification payload **清单2** 指定远程通知有效载荷

```
{
   "aps" : {
      "category" : "SECRET",
      "mutable-content" : 1,
      "alert" : {
         "title" : "Secret Message!",
         "body"  : "(Encrypted)"
     },
   },
   "ENCRYPTED_DATA" : "Salted__·öîQÊ$UDì_¶Ù∞èΩ^¬%gq∞NÿÒQùw"
}
```

# See Also - 其他参考
## Notification service app extension - 通知服务应用扩展
### class UNNotificationServiceExtension

An object that modifies the content of a remote notification before it’s delivered to the user.

用于在将远程通知发送给用户之前修改其内容的对象。