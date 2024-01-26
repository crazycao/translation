# UNNotificationResponse

原文地址：
[https://developer.apple.com/documentation/usernotifications/unnotificationresponse](https://developer.apple.com/documentation/usernotifications/unnotificationresponse)

The user’s response to an actionable notification.

用户对可操作通知的响应。

> iOS 10.0+
iPadOS 10.0+
macOS 10.14+
Mac Catalyst 13.1+
watchOS 3.0+
visionOS 1.0+

```
class UNNotificationResponse : NSObject
```

# Overview 概述

When the user interacts with a delivered notification, the system delivers a `UNNotificationResponse` object to your app so that you can process the response. Users can interact with delivered notifications in many ways. If the notification’s category had associated action buttons, they can select one of those buttons. Users can also dismiss the notification without selecting one of your actions and they can open your app. A response object tells you which option the user selected.

当用户与已发送的通知进行交互时，系统会将 `UNNotificationResponse` 对象传递给您的应用程序，以便您可以处理用户的响应。用户可以以多种方式与已发送的通知进行交互。如果通知的类型有关联的操作按钮，用户可以选择其中一个按钮。用户还可以在不选择任何操作的情况下关闭通知，或者打开您的应用程序。响应对象会告诉您用户选择了哪个选项。

You don’t create `UNNotificationResponse` objects yourself. Instead, the shared user notification center object creates them and delivers them to the [userNotificationCenter(_:didReceive:withCompletionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter) method of its delegate object. Use that method to extract any needed information from the response object and take appropriate action.

您不需要自己创建 `UNNotificationResponse` 对象。相反，共享的用户通知中心对象会创建并将其传递给其代理对象的 [userNotificationCenter(_:didReceive:withCompletionHandler:)](https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter) 方法。使用该方法从响应对象中提取所需的信息并采取适当的操作。

For more information about responding to actions, see [Handling notifications and notification-related actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions).

有关响应操作的更多信息，请参阅《[处理通知和与通知相关的操作](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)》。

# Topics - 主题

## Getting the Response Information - 获取响应信息

### var [actionIdentifier](https://developer.apple.com/documentation/usernotifications/unnotificationresponse/1649548-actionidentifier): String

The identifier string of the action that the user selected.

用户选择的操作的标识符字符串。

### var [notification](https://developer.apple.com/documentation/usernotifications/unnotificationresponse/1649549-notification): UNNotification

The notification to which the user responded.

用户响应的通知。

### var [targetScene](https://developer.apple.com/documentation/usernotifications/unnotificationresponse/3255096-targetscene): UIScene?

The scene where the system reflects the user’s response to a notification.

系统反映用户对通知响应的场景。

### let [UNNotificationDefaultActionIdentifier](https://developer.apple.com/documentation/usernotifications/unnotificationdefaultactionidentifier): String

An action that indicates the user opened the app from the notification interface.

表示用户从通知界面打开应用程序的操作。

### let [UNNotificationDismissActionIdentifier](https://developer.apple.com/documentation/usernotifications/unnotificationdismissactionidentifier): String

The action that indicates the user explicitly dismissed the notification interface.

表示用户明确关闭通知界面的操作。

# See Also - 其他参考
## Notification responses - 通知响应
### [Handling notifications and notification-related actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions) - 处理通知和与通知相关的操作

Respond to user interactions with the system’s notification interfaces, including handling your app’s custom actions.

对用户与系统通知界面的交互做出响应，包括处理应用程序的自定义操作。

## class [UNTextInputNotificationResponse](https://developer.apple.com/documentation/usernotifications/untextinputnotificationresponse)

The user’s response to an actionable notification, including any custom text that the user typed or dictated.

用户对可操作通知的响应，包括用户输入或口述的任何自定义文本。