# Generating a remote notification - 生成远程通知



原文地址：
[https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server)

Send notifications to the user’s device with a JSON payload.

携带 JSON 负载向用户的设备发送通知。

# Overview 概述

Remote notifications convey important information to the user in the form of a JSON payload. The payload specifies the types of user interactions (alert, sound, or badge) that you want performed, and includes any custom data your app needs to respond to the notification.

远程通知以 JSON 负载的形式向用户传递重要信息。该负载指定了您希望执行的用户交互类型（弹出提醒、播放声音或应用图标上的标记），并包含任何您的应用需要响应通知的自定义数据。

![An illustration showing four partial screenshots that demonstrate different types of user interactions for a notification: displaying an alert, playing a sound, badging the app’s icon, and silent (no interaction).](https://docs-assets.developer.apple.com/published/ed88623c58/6e028a3e-2eee-48a2-a5fc-44da97b7d7de.png)

A basic remote notification payload includes Apple-defined keys and their custom values. You may also add custom keys and values specific to your notifications. Apple Push Notification service (APNs) refuses a notification if the total size of its payload exceeds the following limits:

基本的远程通知负载包括苹果定义的键和其自定义的值。您还可以添加特定于您的通知的自定义键和值。如果通知负载的总大小超过以下限制，苹果推送通知服务（APNs）将拒绝该通知：

- For Voice over Internet Protocol (VoIP) notifications, the maximum payload size is 5 KB (5120 bytes).
- For all other remote notifications, the maximum payload size is 4 KB (4096 bytes).

- 对于 Voice over Internet Protocol（VoIP）通知，最大负载大小为 5 KB（5120 字节）。
- 对于所有其他远程通知，最大负载大小为 4 KB（4096 字节）。

## Create the JSON payload - 创建 JSON 负载

Specify the payload for a remote notification using a JSON dictionary. Inside this dictionary, include an `aps` key whose value is a dictionary containing one or more additional Apple-defined keys, listed in Table 1. You can include keys instructing the system to display an alert, play a sound, or badge your app’s icon. You can also instruct the system to handle the notification silently in the background. For more information, see [Pushing background updates to your App](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app).

使用 JSON 字典来指定远程通知的负载。在该字典中，包括一个名为 `aps` 的键，其值是一个包含一个或多个额外的苹果定义键的字典，列在表 1 中。您可以包括一些键来指示系统显示提醒、播放声音或为应用图标添加标记。您还可以指示系统在后台静默处理通知。有关更多信息，请参阅《[将后台更新推送到您的应用程序](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app)》。

In addition to the Apple-defined keys, you may add custom keys to your payload to deliver small amounts of data to your app, notification service app extension, or notification content app extension. Your custom keys must have values with primitive types, such as dictionary, array, string, number, or Boolean. Custom keys are available in the `userInfo` dictionary of the `UNNotificationContent` object delivered to your app.

除了苹果定义的键之外，您还可以向负载中添加自定义键，以向您的应用、通知服务应用扩展或通知内容应用扩展传递少量数据。您的自定义键必须具有原始类型的值，例如字典、数组、字符串、数字或布尔值。自定义键在传递给应用程序的 `UNNotificationContent` 对象的 `userInfo` 字典中可用。

Typically, you use custom keys to help your code process the notification. For example, you might include an identifier string that your code can use to look up app-specific data. Add `app-specific` keys as peers of the `aps` dictionary.

通常，您可以使用自定义键来帮助您的代码处理通知。例如，您可以包括一个标识符字符串，供代码使用以查找特定于应用的数据。在 `aps` 字典的同级添加一个特定于应用的键即可。

Listing 1 shows a notification payload that displays an alert message inviting the user to play a game. If the `category` key identifies a previously registered `UNNotificationCategory` object, the system adds action buttons to the alert. For example, the category here includes a play action to start the game immediately. The custom gameID key contains an identifier that the app can use to retrieve the game invitation.

代码 1 显示了一个通知负载，其中显示一个提醒消息邀请用户玩游戏。如果 `category` 键标识了先前注册的 `UNNotificationCategory` 对象，系统将在提醒中添加操作按钮。例如，这里的 `category` 包括一个 play 操作，以立即开始游戏。自定义的 `gameID` 键包含一个标识符，应用程序可以使用它来检索游戏邀请。

**Listing 1** A remote notification payload for showing an alert - **代码 1** 一个展示提醒的远程通知负载

```
{
   "aps" : {
      "alert" : {
         "title" : "Game Request",
         "subtitle" : "Five Card Draw",
         "body" : "Bob wants to play poker"
      },
      "category" : "GAME_INVITATION"
   },
   "gameID" : "12345678"
}
```

Listing 2 shows a notification payload that badges the app’s icon and plays a sound. The specified sound file must be on the user’s device already, either in the app’s bundle or in the `Library/Sounds` folder of the app’s container. The `messageID` key contains app-specific information for identifying the message that caused the notification.

代码 2 显示了一个通知负载，它为应用程序的图标添加了标记，并播放了声音。指定的声音文件必须已经存在于用户的设备上，可以是应用程序的 bundle 里或应用程序容器的 `Library/Sounds` 文件夹中。`messageID` 键包含特定于应用的信息，用于标识引起通知的消息。

**Listing 2** A remote notification payload for playing a sound - **代码 2** 一个播放声音的远程通知负载

```
{
   "aps" : {
      "badge" : 9,
      "sound" : "bingbong.aiff"
   },
   "messageID" : "ABCDEFGHIJ"
}
```

For more information about creating sounds for your notifications, see [UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound).

关于为您的通知创建声音的更多信息，参见 [UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound)。

> **Important** **重要**
>
> Don’t include customer information or any sensitive data, like a credit card number, in a notification’s payload. If you must include customer information or sensitive data, encrypt it before adding it to the payload. You can use a notification service app extension to decrypt the data on the user’s device. For more information, see [Modifying content in newly delivered notifications](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications).
> 
> 在通知的负载中不要包含客户信息或任何敏感数据，例如信用卡号码。如果必须包含客户信息或敏感数据，请在将其添加到负载之前进行加密。您可以使用通知服务应用扩展在用户设备上解密数据。有关更多信息，请参阅《[修改新收到的通知中的内容](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications)》。

## Localize your alert messages - 本地化您的提醒消息

There are two ways to localize the content of remote notifications:

有两种方法可以对远程通知的内容进行本地化：

- Include localized strings directly in the payload.
- Add localized message strings in your app bundle, and let the system choose which strings to display.

- 直接在负载中包含已本地化的字符串。
- 在应用程序包中添加已本地化的消息字符串，让系统选择要显示的字符串。

Placing localized strings directly into the payload gives you more flexibility, but requires you to track the user’s preferred language on your provider server. Because your provider server supplies the strings, it must know which language to use. On the user’s device, you can retrieve the user’s preferred languages by examining the `preferredLanguages` property of `NSLocale`. Your app can then forward that information to your server.

将已本地化的字符串直接放入负载中可以提供更大的灵活性，但需要在提供者服务器上跟踪用户的首选语言。因为提供者服务器需要提供字符串，所以它必须知道使用哪种语言。在用户的设备上，您可以通过检查 `NSLocale` 的 `preferredLanguages` 属性来获取用户的首选语言。然后，您的应用程序可以将该信息转发给服务器。

If the text of your notification messages is predetermined, you can store your message strings in the Localizable.strings file of your app bundle and use the `title-loc-key`, `subtitle-loc-key`, and `loc-key` payload keys to specify which strings you want to display. Your localized strings may contain placeholders so that you can insert content dynamically into the final string. Listing 3 shows an example of a payload with a message derived from an app-provided string. The `loc-args` key contains an array of replacement variables to substitute into the string.

如果通知消息的文本是预先确定的，您可以将消息字符串存储在应用程序包的 `Localizable.strings` 文件中，并使用 `title-loc-key`、`subtitle-loc-key` 和 `loc-key` 负载键来指定要显示的字符串。您的本地化字符串可以包含占位符，以便可以将内容动态插入最终的字符串中。代码 3 显示了一个示例负载，其中的消息内容则来自应用程序提供的字符串。`loc-args` 键包含一个替换变量的数组，用于替换字符串中的内容。

**Listing 3** A remote notification payload with localized content - **代码 3** 一个带有已本地化的内容的远程通知负载

```
{
   "aps" : {
      "alert" : {
         "loc-key" : "GAME_PLAY_REQUEST_FORMAT",
         "loc-args" : [ "Shelly", "Rick"]
      }
   }
}
```

For more information about the keys you use for localized content, see Table 2.

关于本地化内容用到的键的更多信息，参见 表 2。

## Payload key reference - 负载的键参考

Table 1 lists the keys that you may include in the `aps` dictionary. To interact with the user, include the `alert`, `badge`, or `sound` keys. Don’t add your own custom keys to the `aps` dictionary; APNs ignores custom keys. Instead, add your custom keys as peers of the aps dictionary, as shown in Listing 1.

表 1 列出了您可以在 `aps` 字典中包含的键。要与用户交互，请包括 `alert`、`badge` 或 `sound` 键。不要将自定义键添加到 `aps` 字典中，因为 APNs 会忽略自定义键。相反，将您的自定义键添加为 `aps` 字典的同级，就像代码 1 中展示的那样。

**Table 1** Keys to include in the aps dictionary

|Key|Value type|Description|
|:-:|:-:|:-:|
|alert|Dictionary (or String)|The information for displaying an alert. A dictionary is recommended. If you specify a string, the alert displays your string as the body text. For a list of dictionary keys, see Table 2.
|badge|Number|The number to display in a badge on your app’s icon. Specify `0` to remove the current badge, if any.
|sound|String|The name of a sound file in your app’s main bundle or in the `Library/Sounds` folder of your app’s container directory. Specify the string “default” to play the system sound. Use this key for regular notifications. For critical alerts, use the `sound` dictionary instead. For information about how to prepare sounds, see [UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound).
|sound|Dictionary|A dictionary that contains sound information for critical alerts. For regular notifications, use the sound string instead.
|thread-id|String|An app-specific identifier for grouping related notifications. This value corresponds to the `threadIdentifier` property in the `UNNotificationContent` object.
|category|String|The notification’s type. This string must correspond to the `identifier` of one of the `UNNotificationCategory` objects you register at launch time. See [Declaring your actionable notification types](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types).
|content-available|Number|The background notification flag. To perform a silent background update, specify the value `1` and don’t include the `alert`, `badge`, or `sound` keys in your payload. See [Pushing background updates to your App](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app).
|mutable-content|Number|The notification service app extension flag. If the value is 1, the system passes the notification to your notification service app extension before delivery. Use your extension to modify the notification’s content. See [Modifying content in newly delivered notifications](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications).
|target-content-id|String|The identifier of the window brought forward. The value of this key will be populated on the `UNNotificationContent` object created from the push payload. Access the value using the `UNNotificationContent` object’s `targetContentIdentifier` property.
|interruption-level|String|The importance and delivery timing of a notification. The string values “passive”, “active”, “time-sensitive”, or “critical” correspond to the [UNNotificationInterruptionLevel](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel) enumeration cases.
|relevance-score|Number|The relevance score, a number between `0` and `1`, that the system uses to sort the notifications from your app. The highest score gets featured in the notification summary. See [relevanceScore](https://developer.apple.com/documentation/usernotifications/unnotificationcontent/3821031-relevancescore).</br>If your remote notification updates a Live Activity, you can set any `Double` value; for example, `25`, `50`, `75`, or `100`.
|filter-criteria|String|The criteria the system evaluates to determine if it displays the notification in the current `Focus`. For more information, see [SetFocusFilterIntent](https://developer.apple.com/documentation/appintents/setfocusfilterintent).
|stale-date|Number|The UNIX timestamp that represents the date at which a `Live Activity` becomes stale, or out of date. For more information, see [Displaying live data with Live Activities](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities).
|content-state|Dictionary|The updated or final content for a Live Activity. The content of this dictionary must match the data you describe with your custom [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) implementation. For more information, see Updating and ending your Live Activity with ActivityKit push notifications.
|timestamp|Number|The UNIX timestamp that marks the time when you send the remote notification that updates or ends a Live Activity. For more information, see Updating and ending your Live Activity with ActivityKit push notifications.
|event|String|The string that describes whether you update or end an ongoing Live Activity with the remote push notification. To update the Live Activity, use update. To end the Live Activity, use end. For more information, see Updating and ending your Live Activity with ActivityKit push notifications.
|dismissal-date|Number|The UNIX timestamp that represents the date at which the system ends a Live Activity and removes it from the Dynamic Island and the Lock Screen. For more information, see Updating and ending your Live Activity with ActivityKit push notifications.

**表 1** 可以放入 aps 字典的键

|键|值类型|描述
|:-:|:-:|:-:|
|alert|Dictionary (or String)|用于显示提醒的信息。推荐使用字典类型。如果您指定一个字符串，提醒将以您的字符串作为正文文本显示。有关字典键的列表，请参见表 2。
|badge|Number|要在应用程序图标上显示的标记数。如果需要，指定 `0` 来清除当前的标记。
|sound|String|在您的应用程序的 main bundle 或应用程序容器目录的 `Library/Sounds` 文件夹中的声音文件的名称。如果要播放系统声音，请指定字符串 "default"。在常规通知中使用此键。对于关键提醒，请使用 `sound` 字典。关于如何准备声音的信息，请参阅 [UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound)。
|sound|Dictionary|一个包含关键提醒声音信息的字典。对于常规通知，请使用声音字符串。
|thread-id|String|用于分组相关通知的应用程序特定标识符。该值对应于 `UNNotificationContent` 对象中的 `threadIdentifier` 属性。
|category|String|通知的类型。此字符串必须与您在启动时注册的 `UNNotificationCategory` 对象其中之一的 `identifier` 相对应。请参阅《[声明您的可操作通知类型](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types)》。
|content-available|Number|后台通知标志。要执行静默后台更新，请指定值为 `1`，并且在负载中不包括 `alert`、`badge` 或 `sound` 键。请参阅将《[后台更新推送到您的应用程序](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app)》。
|mutable-content|Number|通知服务应用扩展标志。如果值为 `1`，系统会在发送之前将通知传递给您的通知服务应用扩展。使用您的扩展来修改通知的内容。请参阅《[修改新收到的通知中的内容](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications)》。
|target-content-id|String|被放到前面的窗口的标识符。此键的值将填充在从推送负载创建的 `UNNotificationContent` 对象上。可以使用 `UNNotificationContent` 对象的 `targetContentIdentifier` 属性访问该值。
|interruption-level|String|通知的重要性和发送时机。字符串值 "passive"、"active"、"time-sensitive" 或 "critical" 对应于 [UNNotificationInterruptionLevel](https://developer.apple.com/documentation/usernotifications/unnotificationinterruptionlevel) 枚举的不同情况。
|relevance-score|Number|相关性分数是系统用来对您的应用程序的通知进行排序的一个介于 `0` 和 `1` 之间的数字。分数最高的通知会在通知摘要中显示。请参阅 [relevanceScore](https://developer.apple.com/documentation/usernotifications/unnotificationcontent/3821031-relevancescore)。</br>如果您的远程通知更新了实时活动，您可以设置任意的 `Double` 值，例如 `25`、`50`、`75` 或 `100`。
|filter-criteria|String|系统决定是否要在当前 Focus 中显示通知的评估标准。更多相关信息参见 [SetFocusFilterIntent](https://developer.apple.com/documentation/appintents/setfocusfilterintent)。
|stale-date|Number|UNIX 时间戳，表示实时活动变得陈旧或过期。更多相关信息请参阅《[使用实时活动显示实时数据](https://developer.apple.com/documentation/activitykit/displaying-live-data-with-live-activities)》。
|content-state|Dictionary|实时活动的更新内容或最终内容。此字典的内容必须与您使用自定义 [ActivityAttributes](https://developer.apple.com/documentation/activitykit/activityattributes) 实现描述的数据相匹配。更多相关信息请参阅《使用 ActivityKit 推送通知更新和结束实时活动》。
|timestamp|Number|UNIX 时间戳，标记您发送更新或结束实时活动的远程通知的时间。更多相关信息请参阅《使用 ActivityKit 推送通知更新和结束实时活动》。
|event|String|描述您是使用远程推送通知更新还是结束正在进行的实时活动的字符串。要更新实时活动，请使用 "update"。要结束实时活动，请使用 "end"。更多相关信息请参阅《使用 ActivityKit 推送通知更新和结束实时活动》
|dismissal-date|Number|UNIX 时间戳，表示系统结束实时活动并将其从 Dynamic Island 和 Lock Screen 中移除的日期。有关更多信息，请参阅《使用 ActivityKit 推送通知更新和结束实时活动》。

Table 2 lists the keys that you may include in the `alert` dictionary. Use these strings to specify the title and message to include in the alert banner.

表 2 列出了您可以在 `alert` 字典中包含的键。使用这些字符串来指定要在提醒横幅中包含的标题和消息。

**Table 2** Keys to include in the alert dictionary

|Key|Value type|Description
|:-:|:-:|:-:|
|title|String|The title of the notification. Apple Watch displays this string in the short look notification interface. Specify a string that’s quickly understood by the user.
|subtitle|String|Additional information that explains the purpose of the notification.
|body|String|The content of the alert message.
|launch-image|String|The name of the launch image file to display. If the user chooses to launch your app, the contents of the specified image or storyboard file are displayed instead of your app’s normal launch image.
|title-loc-key|String|The key for a localized title string. Specify this key instead of the title key to retrieve the title from your app’s Localizable.strings files. The value must contain the name of a key in your strings file.
|title-loc-args|Array of strings|An array of strings containing replacement values for variables in your title string. Each %@ character in the string specified by the title-loc-key is replaced by a value from this array. The first item in the array replaces the first instance of the %@ character in the string, the second item replaces the second instance, and so on.
|subtitle-loc-key|String|The key for a localized subtitle string. Use this key, instead of the subtitle key, to retrieve the subtitle from your app’s Localizable.strings file. The value must contain the name of a key in your strings file.
|subtitle-loc-args|Array of strings|An array of strings containing replacement values for variables in your title string. Each %@ character in the string specified by subtitle-loc-key is replaced by a value from this array. The first item in the array replaces the first instance of the %@ character in the string, the second item replaces the second instance, and so on.
|loc-key|String|The key for a localized message string. Use this key, instead of the body key, to retrieve the message text from your app’s Localizable.strings file. The value must contain the name of a key in your strings file.
|loc-args|Array of strings|An array of strings containing replacement values for variables in your message text. Each %@ character in the string specified by loc-key is replaced by a value from this array. The first item in the array replaces the first instance of the %@ character in the string, the second item replaces the second instance, and so on.

**表 2** 可以放入 alert 字典的键

|键|值类型|描述
|:-:|:-:|:-:|
|title|String|通知的标题。Apple Watch 在短通知界面中显示此字符串。请指定一个用户能够快速理解的字符串。
|subtitle|String|额外的信息，用于解释通知的目的。
|body|String|提示信息的内容。
|launch-image|String|要显示的启动图像文件的名称。如果用户选择启动您的应用程序，将显示指定图像或 storyboard 文件的内容，而不是您应用程序的正常启动图像。
|title-loc-key|String|用于本地化标题字符串的键。指定此键而不指定 `title` 键，将从您应用程序的 `Localizable.strings` 文件中检索标题。该值必须包含您的 strings 文件中的键名。
|title-loc-args|Array of strings|一个包含替换值的字符串数组，用于替换标题字符串中的变量。在 `title-loc-key` 指定的字符串中，每个 `%@` 字符都将被该数组中的一个值替换。数组中的第一项将替换字符串中的第一个 `%@` 字符，第二项将替换第二个 `%@` 字符，依此类推。
|subtitle-loc-key|String|用于本地化副标题字符串的键。指定此键而不指定 `subtitle` 键，将从您的应用程序的 `Localizable.strings` 文件中检索副标题。该值必须包含您字符串文件中的键名。
|subtitle-loc-args|Array of strings|一个包含替换值的字符串数组，用于替换副标题字符串中的变量。在 `subtitle-loc-key` 指定的字符串中，每个 `%@` 字符都将被该数组中的一个值替换。数组中的第一项将替换字符串中的第一个 `%@` 字符，第二项将替换第二个 `%@` 字符，依此类推。
|loc-key|String|用于本地化消息字符串的键。指定此键而不指定 `body` 键，将从您的应用程序的 `Localizable.strings` 文件中检索副标题。该值必须包含您字符串文件中的键名。
|loc-args|Array of strings|一个包含替换值的字符串数组，用于替换消息字符串中的变量。在 `loc-key` 指定的字符串中，每个 `%@` 字符都将被该数组中的一个值替换。数组中的第一项将替换字符串中的第一个 `%@` 字符，第二项将替换第二个 `%@` 字符，依此类推。

Table 3 lists the keys that you may include in the `sound` dictionary. Use these keys to configure the sound for a critical alert.

表 3 列出了您可以在 `sound` 字典中包含的键。使用这些键来配置关键提醒的声音。

**Table 3** Keys to include in the sound dictionary

|Key|Value type|Description
|:-:|:-:|:-:|
|critical|Number|The critical alert flag. Set to `1` to enable the critical alert.
|name|String|The name of a sound file in your app’s main bundle or in the `Library/Sounds` folder of your app’s container directory. Specify the string “default” to play the system sound. For information about how to prepare sounds, see [UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound).
|volume|Number|The volume for the critical alert’s sound. Set this to a value between `0` (silent) and `1` (full volume).

**表 3** 可以放入 sound 字典的键

|键|值类型|描述
|:-:|:-:|:-:|
|critical|Number|关键提醒标志。将其设置为 `1` 以启用关键提醒。
|name|String|在您的应用程序的 main bundle 或应用程序容器目录的 `Library/Sounds` 文件夹中的声音文件的名称。如果要播放系统声音，请指定字符串 "default"。关于如何准备声音的信息，请参阅 [UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound)。
|volume|Number|关键提醒的声音音量。将其设置为介于 `0`（静音）和 `1`（最大音量）之间的值。

The figure below shows the default placement of the title, subtitle, and body content in a banner notification. To customize the appearance of alerts, use a notification content app extension as described in [Customizing the Appearance of Notifications](https://developer.apple.com/documentation/usernotificationsui/customizing_the_appearance_of_notifications).

下图显示了横幅通知中标题、副标题和正文内容的默认放置方式。要自定义提醒的外观，请使用通知内容应用扩展，如《[自定义通知外观](https://developer.apple.com/documentation/usernotificationsui/customizing_the_appearance_of_notifications)》中所述。

![A partial screenshot showing the default presentation for the title, subtitle, and body fields of a notification.](https://docs-assets.developer.apple.com/published/c9831909b2/2953614@2x.png)

# See Also - 其他参考

## Server Tasks - 服务器任务

###  Generating a remote notification - 生成远程通知

Send notifications to the user’s device with a JSON payload.

携带 JSON 负载向用户的设备发送通知。

### Sending notification requests to APNs - 向 APNs 发送通知请求

Transmit your remote notification payload and device token information to Apple Push Notification service (APNs).

将您的远程通知负载和设备令牌信息传输到苹果推送通知服务（APNs）。

### Handling notification responses from APNs - 处理来自 APNs 的通知响应

Respond to the status codes that the APNs servers return.

响应 APNs 服务器返回的状态代码。

### Delivering a notification with Apple Push Notification service - 使用苹果推送通知服务传递通知

Understand the factors that determine the delivery of a push notification with APNs.

了解决定使用APN发送推送通知的因素。

### Pushing background updates to your App - 推送后台更新到您的应用程序

Deliver notifications that wake your app and update it in the background.

发送在后台唤醒您的应用程序并进行更新的通知。
