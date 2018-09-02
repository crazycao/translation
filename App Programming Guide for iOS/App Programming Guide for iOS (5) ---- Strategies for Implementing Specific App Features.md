App Programming Guide for iOS (5) ---- Strategies for Implementing Specific App Features

原文链接：[https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforImplementingYourApp/StrategiesforImplementingYourApp.html#//apple_ref/doc/uid/TP40007072-CH5-SW1](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforImplementingYourApp/StrategiesforImplementingYourApp.html#//apple_ref/doc/uid/TP40007072-CH5-SW1)

<span id=5>
#5 Strategies for Implementing Specific App Features - 实现特定 APP 功能的策略

Different apps have different needs but some behaviors are common to many types of app. The following sections provide guidance about how to implement specific types of features in your app.

不同的 APP 有不同的需求，但是某些行为对许多类型的 APP 都是通用的。下面的章节为如何在你的 APP 中实现特定类型的功能提供了指南。

<span id=5.1>
##5.1 Privacy Strategies - 隐私策略

Protecting a user’s privacy is an important consideration in the design of an app. Privacy protection includes protecting the user’s data, including the user’s identity and personal information. The system frameworks already provide privacy controls for managing data such as contacts but your app should take steps to protect the data that you use locally.

在 APP 的设计中保护用户的隐私是非常重要的考虑点。隐私保护包括保护用户的数据，包括用户的身份和个人信息。系统框架已经为管理如通讯录这样的数据提供了隐私控制，但是你应该采取措施保护你在本地使用的数据。

<span id=5.1.1>
### 5.1.1 Protecting Data Using On-Disk Encryption - 使用磁盘加密保护数据

Data protection uses built-in hardware to store files in an encrypted format on disk and to decrypt them on demand. While the user’s device is locked, protected files are inaccessible, even to the app that created them. The user must unlock the device (by entering the appropriate passcode) before an app can access one of its protected files.

数据保护使用嵌入硬件在硬盘上以加密格式存储文件，并按需要解密它们。当用户设备锁住时，受保护的文件是不可访问的，即使是创建它们的 APP 也不行。在 APP 可以访问它的一个受保护文件之前，用户必须解锁设备（通过输入正确的密码）。

Data protection is available on most iOS devices and is subject to the following requirements:

在大多数 iOS 设备上数据保护都是可用的，并且符合下列要求：

- The file system on the user’s device must support data protection. Most devices support this behavior.
- The user must have an active passcode lock set for the device.
- 在用户设备上的文件系统必须支持数据保护。大部分设备支持该行为。
- 用户必须为设备设置一个有效的密码锁。

To protect a file, you add an attribute to the file indicating the desired level of protection. Add this attribute using either the `NSData` class or the `NSFileManager` class. When writing new files, you can use the [writeToFile:options:error:](https://developer.apple.com/reference/foundation/nsdata/1414800-write) method of `NSData `with the appropriate protection value as one of the write options. For existing files, you can use the [setAttributes:ofItemAtPath:error:](https://developer.apple.com/reference/foundation/filemanager/1413667-setattributes) method of `NSFileManager` to set or change the value of the [NSFileProtectionKey](https://developer.apple.com/reference/foundation/nsfileprotectionkey). When using these methods, specify one of the following protection levels for the file:

要保护一个文件，你需要添加一个属性到文件中，表明期望的保护等级。使用 `NSData` 类或 `NSFileManager` 类添加这个属性。当写新文件时，你可以使用 `NSData` 的 [writeToFile:options:error:](https://developer.apple.com/reference/foundation/nsdata/1414800-write) 方法，传入适当的保护值作为一个写选项。对于已存在的文件，你可以使用 `NSFileManager` 的 [setAttributes:ofItemAtPath:error:](https://developer.apple.com/reference/foundation/filemanager/1413667-setattributes) 方法来设置或者修改 [NSFileProtectionKey](https://developer.apple.com/reference/foundation/nsfileprotectionkey) 的值。当使用这些方法时，为该文件指定下列保护等级之一。

- No protection — The file is encrypted but is not protected by the passcode and is available when the device is locked. Specify the [NSDataWritingFileProtectionNone](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1616757-nofileprotection) option (`NSData`) or the [NSFileProtectionNone](https://developer.apple.com/reference/foundation/nsfileprotectionnone) attribute (`NSFileManager`).
- Complete — The file is encrypted and inaccessible while the device is locked. Specify the [NSDataWritingFileProtectionComplete](https://developer.apple.com/reference/foundation/nsdatawritingoptions/nsdatawritingfileprotectioncomplete) option (`NSData`) or the [NSFileProtectionComplete](https://developer.apple.com/reference/foundation/fileprotectiontype/1616200-complete) attribute (`NSFileManager`).
- Complete unless already open — The file is encrypted. A closed file is inaccessible while the device is locked. After the user unlocks the device, your app can open the file and use it. If the user locks the device while the file is open, though, your app can continue to access it. Specify the [NSDataWritingFileProtectionCompleteUnlessOpen](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1616278-completefileprotectionunlessopen) option (`NSData`) or the [NSFileProtectionCompleteUnlessOpen](https://developer.apple.com/reference/foundation/fileprotectiontype/1617188-completeunlessopen) attribute (`NSFileManager`).
- Complete until first login — The file is encrypted and inaccessible until after the device has booted and the user has unlocked it once. Specify the [NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1617028-completefileprotectionuntilfirst) option (`NSData`) or the [NSFileProtectionCompleteUntilFirstUserAuthentication](https://developer.apple.com/reference/foundation/fileprotectiontype/1616633-completeuntilfirstuserauthentica) attribute (`NSFileManager`).

- 不保护 —— 文件是加密的，但是没有受到密码保护，并且当设备锁住时仍可用。指定 [NSDataWritingFileProtectionNone](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1616757-nofileprotection) 选项（`NSData`）或者 [NSFileProtectionNone](https://developer.apple.com/reference/foundation/nsfileprotectionnone) 属性（`NSFileManager`）。
- 完整 —— 文件是加密的，并且当设备锁住时不可访问。指定 [NSDataWritingFileProtectionComplete](https://developer.apple.com/reference/foundation/nsdatawritingoptions/nsdatawritingfileprotectioncomplete) 选项（`NSData`）或者 [NSFileProtectionComplete](https://developer.apple.com/reference/foundation/fileprotectiontype/1616200-complete) 属性（`NSFileManager`）。
- 完整除非已经打开 —— 文件是加密的。当设备锁住时关闭的文件不可访问。在用户解锁设备之后，你的 APP 可以打开该文件并使用它。如果用户在文件已打开时锁住设备，那么，你的 APP 可以继续访问它。指定 [NSDataWritingFileProtectionCompleteUnlessOpen](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1616278-completefileprotectionunlessopen) 选项（`NSData`）或 [NSFileProtectionCompleteUnlessOpen](https://developer.apple.com/reference/foundation/fileprotectiontype/1617188-completeunlessopen) 属性（`NSFileManager`）。
- 完整直到第一次登录 —— 文件是加密的并且不可访问的，直到设备已经启动并且用户已经解锁它一次。指定 [NSDataWritingFileProtectionCompleteUntilFirstUserAuthentication](https://developer.apple.com/reference/foundation/nsdata.writingoptions/1617028-completefileprotectionuntilfirst) 选项（`NSData`）或者 [NSFileProtectionCompleteUntilFirstUserAuthentication](https://developer.apple.com/reference/foundation/fileprotectiontype/1616633-completeuntilfirstuserauthentica) 属性（`NSFileManager`）。

If you protect a file, your app must be prepared to lose access to that file. When complete file protection is enabled, your app loses the ability to read and write the file’s contents when the user locks the device. You can track changes to the state of protected files using one of the following techniques:

如果你保护一个文件，你的 APP 必须准备好失去该文件的访问权。当完整文件保护被启用，你的 APP 在用户锁上设备时会失去读写文件内容的能力。你可以使用以下技术之一来跟踪受保护文件的这个状态：

- The app delegate can implement the [applicationProtectedDataWillBecomeUnavailable:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623019-applicationprotecteddatawillbeco) and [applicationProtectedDataDidBecomeAvailable:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623044-applicationprotecteddatadidbecom) methods.
- Any object can register for the [UIApplicationProtectedDataWillBecomeUnavailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623058-uiapplicationprotecteddatawillbe) and [UIApplicationProtectedDataDidBecomeAvailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623039-uiapplicationprotecteddatadidbec) notifications.
- Any object can check the value of the [protectedDataAvailable](https://developer.apple.com/reference/uikit/uiapplication/1622925-isprotecteddataavailable) property of the shared `UIApplication` object to determine whether files are currently accessible.

- APP 代理可以实现 [applicationProtectedDataWillBecomeUnavailable:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623019-applicationprotecteddatawillbeco) 和 [applicationProtectedDataDidBecomeAvailable:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623044-applicationprotecteddatadidbecom) 方法。
- 任何对象都可以注册 [UIApplicationProtectedDataWillBecomeUnavailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623058-uiapplicationprotecteddatawillbe) 和 [UIApplicationProtectedDataDidBecomeAvailable](https://developer.apple.com/reference/foundation/nsnotification.name/1623039-uiapplicationprotecteddatadidbec) 通知。
- 任何对象可以检查共享的 `UIApplication` 对象的 [protectedDataAvailable](https://developer.apple.com/reference/uikit/uiapplication/1622925-isprotecteddataavailable) 属性值以确定文件当前是否可访问的。

For new files, it is recommended that you enable data protection before writing any data to them. If you are using the `writeToFile:options:error:` method to write the contents of an [NSData](https://developer.apple.com/reference/foundation/nsdata) object to disk, this happens automatically. For existing files, adding data protection replaces an unprotected file with a new protected version.

对于新文件，推荐在写入任何数据之前开启数据保护。如果你使用 `writeToFile:options:error:` 方法将 [NSData](https://developer.apple.com/reference/foundation/nsdata) 对象的内容写入硬盘，这会自动发生。对于已存在的文件，添加数据保护会把未保护文件替换成一个新的受保护的版本。

<span id=5.1.2>
### 5.1.2 Identifying Unique Users of Your App - 识别 APP 的唯一用户

You should identify a user of your app only when doing so offers a clear benefit to that user. In cases where you only need to differentiate one user of your app from another, iOS provides identifiers that can help you do that. However, if you need a higher level of security, you might need to do more work on your own. For example, an app that provides financial services would likely want to prompt the user for login credentials to ensure that the user is authorized to access a specific account.

你应该识别你的 APP 的用户，只有在这么做时，才可以给该用户提供明确的好处。在你只需要把你的 APP 的一个用户与另一个区分开时，iOS 提供了标识符可以帮你实现。但是，如果你需要更高级的保证，你可能需要自己做更多的工作。例如，提供金融服务的 APP 可能希望提示用户输入登录凭证，以确保用户被授权访问某个特定账户。

> **Important:** When identifying a user, always be transparent about what you intend to do with any information you obtain. It is not acceptable to identify a user so that you can track them surreptitiously.
> 
> **重要：** 当标识一个用户时，对你想要用获取到的任何信息做的事情总是保持公开透明。不接受通过标识一个用户来偷偷跟踪他们。

Here are some common scenarios that might require you to identify a user, along with solutions for how to implement them.

下面是一些可能需要你识别用户的常见场景，以及如何实现它们的解决方案。

- **You want to link a user to a specific account on your server.** Include a login screen that requires the user to enter their account information securely. Always protect the account information you gather from the user by storing it in an encrypted form.
- **You want to differentiate instances of your app running on different devices.** Use the [identifierForVendor](https://developer.apple.com/reference/uikit/uidevice/1620059-identifierforvendor) property of the `UIDevice` class to obtain an ID that differentiates a user on one device from users on other devices. This technique does now allow you to identify specific users. A single user can have multiple devices, each with a different ID value.
- **You want to identify a user for the purposes of advertising.** Use the [advertisingIdentifier](https://developer.apple.com/reference/adsupport/asidentifiermanager/1614151-advertisingidentifier) property of the `ASIdentifierManager` class to obtain an ID for the user.

- **你想要把用户链接到你服务器上的某个特定账户。** 包含一个登录屏幕，要求用户安全的输入他们的账户信息。总是保护你从用户那里获取的账户信息，通过已加密的形式储存它。
- **你想要区分你的 APP 运行在不同设备上的的实例。** 使用 `UIDevice` 类的 [identifierForVendor](https://developer.apple.com/reference/uikit/uidevice/1620059-identifierforvendor) 属性获取一个 ID，这个 ID 可以将一个设备上的用户与其他设备上的用户区分开。这个技术限制允许你标识特定用户。一个用户可以有多个设备，每个都有不同的 ID 值。 
- **你想要因为广告意图标识用户。** 使用 `ASIdentifierManager` 类的 [advertisingIdentifier](https://developer.apple.com/reference/adsupport/asidentifiermanager/1614151-advertisingidentifier) 属性为用户获取一个 ID。

Because users are allowed to run apps on all of their iOS devices, Apple does not provide a way to identify the same user on multiple devices. If you need to identify a specific user, you must provide your own solution using universally unique IDs (UUIDs), a login account, or some other type of identification system.

因为用户可以在他们所有的 iOS 设备上运行 APP，苹果也没有提供标识多个设备上同一个用户的方法。如果你需要标识特定的用户，你必须提供你自己的解决方案，使用通用唯一ID（UUID）、登录账户或其他类型的识别系统。

<span id=5.2>
## 5.2 Respecting Restrictions - 尊重限制

Users can set restrictions that specify the ratings of media they want to consume in apps. If your app plays media or modifies its behavior based on restrictions, you need to determine the current settings and respond when the settings change.

用户可以设置限制，以指定他们希望在 APP 中消费的多媒体的评级。如果用户播放多媒体或修改他基于限制的行为，你需要确定当前设置并响应当设置变化时做出响应。

To get the current settings, get the shared [standardUserDefaults](https://developer.apple.com/reference/foundation/userdefaults/1416603-standard) object and use the [objectForKey:](https://developer.apple.com/reference/foundation/nsuserdefaults/1410095-objectforkey) method to view the values for the following keys:

要获取当前限制，获取共享的 [standardUserDefaults](https://developer.apple.com/reference/foundation/userdefaults/1416603-standard) 对象并使用 [objectForKey:](https://developer.apple.com/reference/foundation/nsuserdefaults/1410095-objectforkey) 方法查看下列 key 的值：

| **Media rating key**                     | **Value**                                | 
| ---------------------------------------- | ---------------------------------------- |
| ` com.apple.content-rating.ExplicitBooksAllowed` | `Boolean`. If the value of this key is a `NO`, explicit books are not allowed. </br> 如果这个 key 的值是 `NO`，明确的图书是不允许的。 |
| `com.apple.content-rating.ExplicitMusicPodcastsAllowed` | `Boolean`. If the value of this key is a `NO`, explicit music, movies, and podcasts are not allowed. </br> 如果这个 key 的值是 `NO`，明确的音乐、电影和播客是不允许的。 | 
| `com.apple.content-rating.AppRating`       | `NSNumber`. The value of this key ranges from 0 to 1000. An app whose rating is higher than the current key value is not allowed. </br> 这个 key 的值从 0 到 1000。评级高于当前 key 值的 APP 是不允许的。 |                                      
| `com.apple.content-rating.MovieRating`     | `NSNumber`. The value of this key ranges from 0 to 1000. A movie whose rating is higher than the current key value is not allowed. </br> 这个 key 的值从 0 到 1000。评级高于当前 key 值的电影是不被允许的。 |                                          
| `com.apple.content-rating.TVShowRating`    | `NSNumber`. The value of this key ranges from 0 to 1000. A TV show whose rating is higher than the current key value is not allowed. </br> 这个 key 的值从 0 到 1000。评级高于当前 key 值的电视节目是不被允许的。 |                                          

> **Note:** If `objectForKey:` returns `nil` for a specific key, it means that information about this particular restriction is not available. In this case, your app can use its own policies to determine appropriate ratings.
> 
> **注意：**  如果 `objectForKey:` 对指定的 key 返回 `nil`，意味着关于这个特定限制的信息不可用。在这种情况下，你的 APP  可以使用它自己的策略决定适当的评级。

To detect when the user makes a change to a restriction, register for the notification [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification). The shared `standardUserDefaults` object sends this notification to your app when it detects a change to a preference located in one of the persistent domains.

要检测用户什么时候修改了限制，请注册 [NSUserDefaultsDidChangeNotification](https://developer.apple.com/reference/foundation/userdefaults/1408206-didchangenotification) 通知。共享的 `standardUserDefaults` 对象会在它检测到位于某个持久域的偏好改变时，发送这个通知到你的 APP。

App ratings are defined for the us country code and are universally applied. Table 5-1 shows the value associated with each US app rating.

APP 评级是为美国国家代码定义的，并且被普遍接受。表 5-1 展示了关于每个美国 APP 评级的值。

**Table 5-1**  App ratings - APP 评级

| **Rating name** | **Numerical value** |
| --------------- | ------------------- |
| 4+              | 100                 |
| 9+              | 200                 |
| 12+             | 300                 |
| 17+             | 600                 |

Movie and TV ratings vary by country. If a country or region doesn’t specify a rating system for movies or TV shows, your app should use its own policies to determine appropriate ratings. Although most regions define movie ratings, only a few define TV show ratings.

电影和电视的评级在每个国家都不同。如果一个国家或地区没有为电影和电视指定评级系统，你的 APP 应该使用自己的策略决定适当的评级。尽管大部分区域都定义了电影评级，只有少数定义了电视评级。

A region can define several rating levels, each of which is associated with a name that describes the rating and a number in the range of 0 to 1000. For example, the US uses the string “G” and the number 100 to specify the lowest movie rating level.

一个区域可以定义若干评级等级，每一个都有一个描述该评级的名字和一个 0 到 1000 之间的数字。例如，美国使用字符串 “G” 和数字 100 指定最低的电影评级等级。

Even if your app doesn’t play media, you might want to map your own rating system to a movie or TV show rating system. For example, a game might enable certain features only when the US movie rating “R” is allowed. To view the current list of ratings, download this document’s companion file (the link is near the top of the page).

即使你的 APP 不播放多媒体，你可能也想要把你自己的评级系统与电影或电视评级系统对应起来。例如，一个游戏可能只有在美国电影评级为 “R” 被允许时才开启某些功能。要查看当前的评级列表，下载本文的附件（链接在本页的顶部附近：[下载链接](https://developer.apple.com/library/archive/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/iOS%20App%20Programming%20Guide%20Companion%20Files.zip)）

<span id=5.3>
## 5.3 Supporting Multiple Versions of iOS - 支持iOS的多个版本

An app that supports the latest version of iOS plus one or more earlier versions must use runtime checks to prevent the use of newer APIs on older versions of iOS. Runtime checks prevent your app from crashing when it tries to use a feature that is not available on the current operating system.

支持 iOS 最新版本的前一个或更早版本的 APP 必须使用运行时检查以避免在 iOS 的旧版本上使用了新的 API。如果 APP 尝试使用当前操作系统上不可用的功能，运行时检查可以避免你的 APP 崩溃。

There are several types of checks that you can make:

你可以做下面几种检查：

- To determine whether a class exists, see if its `Class` object is `nil`. The linker returns nil for any unknown class objects, making it possible to use a conditional check similar to the following:
- 要确定一个类是否存在，看它的 `Class` 对象是不是 `nil`。对于任何未知类对象，连接器都会返回 `nil`，这就有可能使用一个像下面这样的条件检查：

>
	if ([UIPrintInteractionController class]) {
	   // Create an instance of the class and use it.
	}
	else {
	   // The print interaction controller is not available so use an alternative technique.
	}	
	
- To determine whether a method is available on an existing class, use the [instancesRespondToSelector:](https://developer.apple.com/reference/objectivec/nsobject/1418555-instancesrespondtoselector) class method or the [respondsToSelector:](https://developer.apple.com/reference/objectivec/nsobjectprotocol/1418583-responds) instance method.
- 要确定一个方法在一个已存在的类上是否可用，使用 [instancesRespondToSelector:]((https://developer.apple.com/reference/objectivec/nsobject/1418555-instancesrespondtoselector)) 类方法或者 [responsToSelector:](https://developer.apple.com/reference/objectivec/nsobjectprotocol/1418583-responds) 实例方法。

- To determine whether a C-based function is available, perform a Boolean comparison of the function name to NULL. If the symbol is not NULL, you can call the function. For example:
- 要确定一个基于 C 的函数是否可用，只要把函数名与 `NULL` 做一个布尔比较就行。如果这个符号不是 `NULL`，你就可以调用这个函数。例如：

>
	if (UIGraphicsBeginPDFPage != NULL) {
   		UIGraphicsBeginPDFPage();
	}

For more information and examples of how to write code that supports multiple deployment targets, see [SDK Compatibility Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Introduction/Introduction.html#//apple_ref/doc/uid/10000163i).

关于如何写支持多部署目标的代码的更多信息和例子，参见 [SDK Compatibility Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/cross_development/Introduction/Introduction.html#//apple_ref/doc/uid/10000163i)。

<span id=5.4>
##5.4 Preserving Your App’s Visual Appearance Across Launches 保持贯穿启动过程App视觉可见

Even if your app supports background execution, it cannot run forever. At some point, the system might need to terminate your app to free up memory for the current foreground app. However, the user should never have to care if an app is already running or was terminated. From the user’s perspective, quitting an app should just seem like a temporary interruption. When the user returns to an app, that app should always return the user to the last point of use, so that the user can continue with whatever task was in progress. This behavior provides a better experience for the user and with the state restoration support built in to UIKit is relatively easy to achieve.

The state preservation system in UIKit provides a simple but flexible infrastructure for preserving and restoring the state of your app’s view controllers and views. The job of the infrastructure is to drive the preservation and restoration processes at the appropriate times. To do that, UIKit needs help from your app. Only you understand the content of your app, and so only you can write the code needed to save and restore that content. And when you update your app’s UI, only you know how to map older preserved content to the newer objects in your interface.

There are three places where you have to think about state preservation in your app:

- Your app delegate object, which manages the app’s top-level state
- Your app’s view controller objects, which manage the overall state for your app’s user interface
- Your app’s custom views, which might have some custom data that needs to be preserved

UIKit allows you to choose which parts of your user interface you want to preserve. And if you already have custom code for handling state preservation, you can continue to use that code and migrate portions to the UIKit state preservation system as needed.

<span id=5.4.1>
###5.4.1 Enabling State Preservation and Restoration in Your App 在App中开启状态保持和恢复

State preservation and restoration is not an automatic feature and apps must opt-in to use it. Apps indicate their support for the feature by implementing the following methods in their app delegate:

- [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application)
- [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application)

Normally, your implementations of these methods just return a YES/a to indicate that state preservation and restoration can occur. However, apps that want to preserve and restore their state conditionally can return a NO/a in situations where the operations should not occur. For example, after releasing an update to your app, you might want to return a NO/a from your [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method if your app is unable to usefully restore the state from a previous version.

<span id=5.4.2>
###5.4.2 The Preservation and Restoration Process 保持和恢复过程

State preservation and restoration is an opt-in feature and works with the help of your app. Your app identifies objects that should be preserved and UIKit does the work of preserving and restoring those objects at appropriate times. Because UIKit handles so much of the process, it helps to understand what it does behind the scenes so that you know how your custom code fits into the overall scheme.

When thinking about state preservation and restoration, it helps to separate the two processes first. UIKit preserves your app’s state at appropriate times, such as when your app moves from the foreground to the background. When UIKit determines new state information is needed, it looks at your app’s views and view controllers to see which ones should be preserved. For each of those objects, UIKit writes preservation-related data to an encrypted on-disk file. The next time your app launches from scratch, UIKit looks for that file and, if it is present, uses it to try and restore your app’s state. Because the file is encrypted, state preservation and restoration only happens when the device is unlocked.

During the restoration process, UIKit uses the preserved data to reconstitute your interface but the creation of actual objects is handled by your code. Because your app might load objects from a storyboard file automatically, only your code knows which objects need to be created and which might already exist and can simply be returned. After creating each object, UIKit initializes them with the preserved state information.

During the preservation and restoration process, your app has a handful of responsibilities.

- During preservation, your app is responsible for:

  - Telling UIKit that it supports state preservation.
  - Telling UIKit which view controllers and views should be preserved.
  - Encoding relevant data for any preserved objects.

- During restoration, your app is responsible for:

  - Telling UIKit that it supports state restoration.
  - Providing (or creating) the objects that are requested by UIKit.
  - Decoding the state of your preserved objects and using it to return the object to its previous state.

Of your app’s responsibilities, the most significant are telling UIKit which objects to preserve and providing those objects during subsequent launches. Those two behaviors are where you should spend most of your time when designing your app’s preservation and restoration code. They are also where you have the most control over the actual process. To understand why that is the case, it helps to look at an example.

Figure 5-1 shows the view controller hierarchy of a tab bar interface after the user has interacted with several of the tabs. As you can see, some of the view controllers are loaded automatically as part of the app’s main storyboard file but some of the view controllers were presented or pushed onto the view controllers in different tabs. Without state restoration, only the view controllers from the main storyboard file would be restored during subsequent launches. By adding support for state restoration to your app, you can preserve all of the view controllers.

**Figure 5-1**  A sample view controller hierarchy
![Figure 5-1](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_hierarchy_initial_2x.png)

UIKit preserves only those objects that have an assigned restoration identifier. A restoration identifier is a string that identifies the view or view controller to UIKit and your app. The value of this string is significant only to your code but the presence of this string tells UIKit that it needs to preserve the tagged object. During the preservation process, UIKit walks your app’s view controller hierarchy and preserves all objects that have a restoration identifier. If a view controller does not have a restoration identifier, that view controller and all of its views and child view controllers are not preserved. Figure 5-2 shows an updated version of the previous view hierarchy, now with restoration identifies applied to most (but not all) of the view controllers.

**Figure 5-2**  Adding restoration identifies to view controllers
![Figure 5-2](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_hierarchy_preserve_2x.png)

Depending on your app, it might or might not make sense to preserve every view controller. If a view controller presents transitory information, you might not want to return to that same point on restore, opting instead to return the user to a more stable point in your interface.

For each view controller you choose to preserve, you also need to decide how you want to restore it later. UIKit offers two ways to recreate objects. You can let your app delegate recreate it or you can assign a restoration class to the view controller and let that class recreate it. A restoration class implements the [UIViewControllerRestoration](https://developer.apple.com/reference/uikit/uiviewcontrollerrestoration) protocol and is responsible for finding or creating a designated object at restore time. Here are some tips for when to use each one:

- **If the view controller is always loaded from your app’s main storyboard file at launch time, do not assign a restoration class.** Instead, let your app delegate find the object or take advantage of UIKit’s support for implicitly finding restored objects.
- **For view controllers that are not loaded from your main storyboard file at launch time, assign a restoration class.** The simplest option is to make each view controller its own restoration class.

During the preservation process, UIKit identifies the objects to save and writes each affected object’s state to disk. Each view controller object is given a chance to write out any data it wants to save. For example, a tab view controller saves the identity of the selected tab. UIKit also saves information such as the view controller’s restoration class to disk. And if any of the view controller’s views has a restoration identifier, UIKit asks them to save their state information too.

The next time the app is launched, UIKit loads the app’s main storyboard or nib file as usual, calls the app delegate’s [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) method, and then tries to restore the app’s previous state. The first thing it does is ask your app to provide the set of view controller objects that match the ones that were preserved. If a given view controller had an assigned restoration class, that class is asked to provide the object; otherwise, the app delegate is asked to provide it.

<span id=5.4.3>
###5.4.3 Flow of the Preservation Process 保持过程流

Figure 5-3 shows the high-level events that happen during state preservation and shows how the objects of your app are affected. Before preservation even occurs, UIKit asks your app delegate if it should occur by calling the [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application) method. If that method returns a YES/a, UIKit begins gathering and encoding your app’s views and view controllers. When it is finished, it writes the encoded data to disk.

**Figure 5-3**  High-level flow interface preservation
![Figure 5-3](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/save_process_simple_2x.png)

The next time your app launches, the system automatically looks for a preserved state file, and if present, uses it to restore your interface. Because this state information is only relevant between the previous and current launch cycles of your app, the file is typically discarded after your app finishes launching. The file is also discarded any time there is an error restoring your app. For example, if your app crashes during the restoration process, the system automatically throws away the state information during the next launch cycle to avoid another crash.

<span id=5.4.4>
###5.4.4 Flow of the Restoration Process 恢复过程流

Figure 5-4 shows the high-level events that happen during state restoration and shows how the objects of your app are affected. After the standard initialization and UI loading is complete, UIKit asks your app delegate if state restoration should occur at all by calling the [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method. This is your app delegate’s opportunity to examine the preserved data and determine if state restoration is possible. If it is, UIKit uses the app delegate and restoration classes to obtain references to your app’s view controllers. Each object is then provided with the data it needs to restore itself to its previous state.

**Figure 5-4**  High-level flow for restoring your user interface
![Figure 5-4](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/restoration_process_simple_2x.png)

Although UIKit helps restore the individual view controllers, it does not automatically restore the relationships between those view controllers. Instead, each view controller is responsible for encoding enough state information to return itself to its previous state. For example, a navigation controller encodes information about the order of the view controllers on its navigation stack. It then uses this information later to return those view controllers to their previous positions on the stack. Other view controllers that have embedded child view controllers are similarly responsible for encoding any information they need to restore their children later.

>**Note:** Not all view controllers need to encode their child view controllers. For example, tab bar controllers do not encode information about their child view controllers. Instead, it is assumed that your app follows the usual pattern of creating the appropriate child view controllers prior to creating the tab bar controller itself.

Because you are responsible for recreating your app’s view controllers, you have some flexibility to change your interface during the restoration process. For example, you could reorder the tabs in a tab bar controller and still use the preserved data to return each tab to its previous state. Of course, if you make dramatic changes to your view controller hierarchy, such as during an app update, you might not be able to use the preserved data.

<span id=5.4.5>
###5.4.5 What Happens When You Exclude Groups of View Controllers? 当你移除整组的视图控制器时会发生什么？

When the restoration identifier of a view controller is nil, that view controller and any child view controllers it manages are not preserved automatically. For example, in Figure 5-5, because a navigation controller did not have a restoration identifier, it and all of its child view controllers and views are omitted from the preserved data.

**Figure 5-5**  Excluding view controllers from the automatic preservation process
![Figure 5-5](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_caveats_2x.png)

Even if you decide not to preserve view controllers, that does not mean all of those view controllers disappear from the view hierarchy altogether. At launch time, your app might still create the view controllers as part of its default setup. For example, if any view controllers are loaded automatically from your app’s storyboard file, they would still appear, albeit in their default configuration, as shown in Figure 5-6.

**Figure 5-6**  Loading the default set of view controllers
![Figure 5-6](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/state_vc_caveats_2_2x.png)

Something else to realize is that even if a view controller is not preserved automatically, you can still encode a reference to that view controller and preserve it manually. In Figure 5-5, the three child view controllers of the first navigation controller have restoration identifiers, even though there parent navigation controller does not. If your app delegate (or any preserved object) encodes a reference to those view controllers, their state is preserved. Even though their order in the navigation controller is not saved, you could still use those references to recreate the view controllers and install them in the navigation controller during subsequent launch cycles.

<span id=5.4.6>
###5.4.6 Checklist for Implementing State Preservation and Restoration 实现状态保持和恢复的核对清单

Supporting state preservation and restoration requires modifying your app delegate and view controller objects to encode and decode the state information. If your app has any custom views that also have preservable state information, you need to modify those objects too.

When adding state preservation and restoration to your code, use the following list to remind you of the code you need to write.

- (Required) Implement the [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application) and [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) methods in your app delegate; see Enabling State Preservation and Restoration in Your App.
- (Required) Assign restoration identifiers to each view controller you want to preserve by assigning a non empty string to their [restorationIdentifier](https://developer.apple.com/reference/uikit/uiviewcontroller/1621499-restorationidentifier) property; see Marking Your View Controllers for Preservation. If you want to save the state of specific views too, assign non empty strings to their [restorationIdentifier](https://developer.apple.com/reference/uikit/uiview/1622494-restorationidentifier) properties; see Preserving the State of Your Views.
- (Required) Show your app’s window from the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) method of your app delegate. The state restoration machinery needs the window so that it can restore scroll positions and other relevant bits of your app’s interface.
- Assign restoration classes to the appropriate view controllers. (If you do not do this, your app delegate is asked to provide the corresponding view controller at restore time.) See Restoring Your View Controllers at Launch Time.
- (Recommended) Encode and decode the state of your views and view controllers using the [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621461-encoderestorablestatewithcoder) and [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621429-decoderestorablestate) methods of those objects; see Encoding and Decoding Your View Controller’s State.
- Encode and decode any version information or additional state information for your app using the [application:willEncodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623099-application) and [application:didDecodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623006-application) methods of your app delegate; see Preserving Your App’s High-Level State.
- Objects that act as data sources for table views and collection views should implement the [UIDataSourceModelAssociation](https://developer.apple.com/reference/uikit/uidatasourcemodelassociation) protocol. Although not required, this protocol helps preserve the selected and visible items in those types of views. See Implementing Preservation-Friendly Data Sources.

<span id=5.4.7>
###5.4.7 Enabling State Preservation and Restoration in Your App 在App中启用状态保持和恢复

State preservation and restoration is not an automatic feature and apps must opt-in to use it. Apps indicate their support for the feature by implementing the following methods in their app delegate:

- [application:shouldSaveApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623089-application)
- [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application)

Normally, your implementations of these methods just return a YES/a to indicate that state preservation and restoration can occur. However, apps that want to preserve and restore their state conditionally can return a NO/a in situations where the operations should not occur. For example, after releasing an update to your app, you might want to return a NO/a from your [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method if your app is unable to usefully restore the state from a previous version.

<span id=5.4.8>
###5.4.8 Preserving the State of Your View Controllers 保持视图控制器的状态

Preserving the state of your app’s view controllers should be your main goal. View controllers define the structure of your user interface. They manage the views needed to present that interface and they coordinate the getting and setting of the data that backs those views. To preserve the state of a single view controller, you must do the following:

- (Required) Assign a restoration identifier to the view controller; see Marking Your View Controllers for Preservation.
- (Required) Provide code to create or locate new view controller objects at launch time; see Restoring Your View Controllers at Launch Time.
- (Optional) Implement the [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621461-encoderestorablestatewithcoder) and [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621429-decoderestorablestate) methods to encode and restore any state information that cannot be recreated during a subsequent launch; see Encoding and Decoding Your View Controller’s State.

<span id=5.4.8.1>
####5.4.8.1 Marking Your View Controllers for Preservation 为保持标记视图控制器

UIKit preserves only those view controllers whose [restorationIdentifier](https://developer.apple.com/reference/uikit/uiviewcontroller/1621499-restorationidentifier) property contains a valid string object. For view controllers that you know you want to preserve, set the value of this property when you initialize the view controller object. If you load the view controller from a storyboard or nib file, you can set the restoration identifier there.

Choosing an appropriate value for restoration identifiers is important. During the restoration process, your code uses the restoration identifier to determine which view controller to retrieve or create. If every view controller object is based on a different class, you can use the class name for the restoration identifier. However, if your view controller hierarchy contains multiple instances of the same class, you might need to choose different names based on each view usage.

When it asks you to provide a view controller, UIKit provides you with the restoration path of the view controller object. A restoration path is the sequence of restoration identifiers starting at the root view controller and walking down the view controller hierarchy to the current object. For example, imagine you have a tab bar controller whose restoration identifier is TabBarControllerID, and the first tab contains a navigation controller whose identifier is NavControllerID and whose root view controller’s identifier is MyViewController. The full restoration path for the root view controller would be TabBarControllerID/NavControllerID/MyViewController.

The restoration path for every object must be unique. If a view controller has two child view controllers, each child must have a different restoration identifier. However, two view controllers with different parent objects may use the same restoration identifier because the rest of the restoration path provides the needed uniqueness. Some UIKit view controllers, such as navigation controllers, automatically disambiguate their child view controllers, allowing you to use the same restoration identifiers for each child. For more information about the behavior of a given view controller, see the corresponding class reference.

At restore time, you use the provided restoration path to determine which view controller to return to UIKit. For more information on how you use restoration identifiers and restoration paths to restore view controllers, see Restoring Your View Controllers at Launch Time.

<span id=5.4.8.2>
####5.4.8.2 Restoring Your View Controllers at Launch Time 在启动时恢复你的视图控制器

During the restoration process, UIKit asks your app to create (or locate) the view controller objects that comprise your preserved user interface. UIKit adheres to the following process when trying to locate view controllers:

1. **If the view controller had a restoration class, UIKit asks that class to provide the view controller.** UIKit calls the [viewControllerWithRestorationIdentifierPath:coder:](https://developer.apple.com/reference/uikit/uiviewcontrollerrestoration/1616859-viewcontrollerwithrestorationide) method of the associated restoration class to retrieve the view controller. If that method returns nil, it is assumed that the app does not want to recreate the view controller and UIKit stops looking for it.
2. **If the view controller did not have a restoration class, UIKit asks the app delegate to provide the view controller.** UIKit calls the [application:viewControllerWithRestorationIdentifierPath:coder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623062-application) method of your app delegate to look for view controllers without a restoration class. If that method returns nil, UIKit tries to find the view controller implicitly.
3. **If a view controller with the correct restoration path already exists, UIKit uses that object.** If your app creates view controllers at launch time (either programmatically or by loading them from a resource file) and assigns restoration identifiers to them, UIKit finds them implicitly through their restoration paths.
4. **If the view controller was originally loaded from a storyboard file, UIKit uses the saved storyboard information to locate and create it.** UIKit saves information about a view controller’s storyboard inside the restoration archive. At restore time, it uses that information to locate the same storyboard file and instantiate the corresponding view controller if the view controller was not found by any other means.

It is worth noting that if you specify a restoration class for a view controller, UIKit does not try to find your view controller implicitly. If the viewControllerWithRestorationIdentifierPath:coder: method of your restoration class returns nil, UIKit stops trying to locate your view controller. This gives you control over whether you really want to create the view controller. If you do not specify a restoration class, UIKit does everything it can to find the view controller for you, creating it as necessary from your app’s storyboard files.

If you choose to use a restoration class, the implementation of your viewControllerWithRestorationIdentifierPath:coder: method should create a new instance of the class, perform some minimal initialization, and return the resulting object. Listing 5-1 shows an example of how you might use this method to load a view controller from a storyboard. Because the view controller was originally loaded from a storyboard, this method uses the [UIStateRestorationViewControllerStoryboardKey](https://developer.apple.com/reference/uikit/uistaterestorationviewcontrollerstoryboardkey) key to get the storyboard from the archive. Note that this method does not try to configure the view controller’s data fields. That step occurs later when the view controller’s state is decoded.

**Listing 5-1**  Creating a new view controller during restoration

	+ (UIViewController*) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents
	                      coder:(NSCoder *)coder {
	   MyViewController* vc;
	   UIStoryboard* sb = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
	   if (sb) {
	      vc = (PushViewController*)[sb instantiateViewControllerWithIdentifier:@"MyViewController"];
	      vc.restorationIdentifier = [identifierComponents lastObject];
	      vc.restorationClass = [MyViewController class];
	   }
	    return vc;
	}

Reassigning the restoration identifier and restoration class, as in the preceding example, is a good habit to adopt when creating new view controllers. The simplest way to restore the restoration identifier is to grab the last item in the identifierComponents array and assign it to your view controller.

For objects that were already loaded from your app’s main storyboard file at launch time, do not create a new instance of each object. Instead, implement the application:viewControllerWithRestorationIdentifierPath:coder: method of your app delegate and use it to return the appropriate objects or let UIKit find those objects implicitly.

<span id=5.4.8.3>
####5.4.8.3 Encoding and Decoding Your View Controller’s State 编码和解码你的视图控制器状态

For each object slated for preservation, UIKit calls the object’s [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621461-encoderestorablestatewithcoder) method to give it a chance to save its state. During the decode process, a matching call to the [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiviewcontroller/1621429-decoderestorablestate) method is made to decode that state and apply it to the object. The implementation of these methods is optional, but recommended, for your view controllers. You can use them to save and restore the following types of information:

- References to any data being displayed (not the data itself)
- For a container view controller, references to its child view controllers
- Information about the current selection
- For view controllers with a user-configurable view, information about the current configuration of that view.

In your encode and decode methods, you can encode any values supported by the coder, including other objects. For all objects except views and view controllers, the object must adopt the [NSCoding](https://developer.apple.com/reference/foundation/nscoding) protocol and use the methods of that protocol to write its state. For views and view controllers, the coder does not use the methods of the NSCoding protocol to save the object’s state. Instead, the coder saves the restoration identifier of the object and adds it to the list of preservable objects, which results in that object’s encodeRestorableStateWithCoder: method being called.

The encodeRestorableStateWithCoder: and decodeRestorableStateWithCoder: methods of your view controllers should always call super at some point in their implementation. Calling super gives the parent class a chance to save and restore any additional information. Listing 5-2 shows a sample implementation of these methods that save a numerical value used to identify the specified view controller.

**Listing 5-2**  Encoding and decoding a view controller’s state.
	- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
	   [super encodeRestorableStateWithCoder:coder];
	 
	   [coder encodeInt:self.number forKey:MyViewControllerNumber];
	}
	 
	- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
	   [super decodeRestorableStateWithCoder:coder];
	 
	   self.number = [coder decodeIntForKey:MyViewControllerNumber];
	}

Coder objects are not shared during the encode and decode process. Each object with preservable state receives its own coder that it can use to read or write data. The use of unique coders means that you do not have to worry about key namespace collisions among your own objects. However, you must still avoid using some special key names that UIKit provides. Specifically, each coder contains the [UIApplicationStateRestorationBundleVersionKey](https://developer.apple.com/reference/uikit/uiapplicationstaterestorationbundleversionkey) and [UIApplicationStateRestorationUserInterfaceIdiomKey](https://developer.apple.com/reference/uikit/uiapplicationstaterestorationuserinterfaceidiomkey) keys, which provide information about the bundle version and current user interface idiom. Coders associated with view controllers may also contain the [UIStateRestorationViewControllerStoryboardKey](https://developer.apple.com/reference/uikit/uistaterestorationviewcontrollerstoryboardkey) key, which identifies the storyboard from which that view controller originated.

For more information about implementing your encode and decode methods for your view controllers, see [UIViewController Class Reference](https://developer.apple.com/reference/uikit/uiviewcontroller).

<span id=5.4.9>
###5.4.9 Preserving the State of Your Views 保持视图的状态

If a view has state information worth preserving, you can save that state with the rest of your app’s view controllers. Because they are usually configured by their owning view controller, most views do not need to save state information. The only time you need to save a view’s state is when the view itself can be altered by the user in a way that is independent of its data or the owning view controller. For example, scroll views save the current scroll position, which is information that is not interesting to the view controller but which does affect how the view presents itself.

To designate that a view’s state should be saved, you do the following:

- Assign a valid string to the view’s [restorationIdentifier](https://developer.apple.com/reference/uikit/uiview/1622494-restorationidentifier) property.
- Use the view from a view controller that also has a valid restoration identifier.
- For table views and collection views, assign a data source that adopts the [UIDataSourceModelAssociation](https://developer.apple.com/reference/uikit/uidatasourcemodelassociation) protocol.

As with view controllers, assigning a restoration identifier to a view tells the system that the view object has state that your app wants to save. The restoration identifier can also be used to locate the view later.

Like view controllers, views define methods for encoding and decoding their custom state. If you create a view with state worth saving, you can use these methods to read and write any relevant data.

<span id=5.4.9.1>
####5.4.9.1 UIKit Views with Preservable State 可保持状态的UIKit视图

In order to save the state of any view, including both custom and standard system views, you must assign a restoration identifier to the view. Views without a restoration identifier are not added to the list of preservable objects by UIKit.

The following UIKit views have state information that can be preserved:

- [UICollectionView](https://developer.apple.com/reference/uikit/uicollectionview)
- [UIImageView](https://developer.apple.com/reference/uikit/uiimageview)
- [UIScrollView](https://developer.apple.com/reference/uikit/uiscrollview)
- [UITableView](https://developer.apple.com/reference/uikit/uitableview)
- [UITextField](https://developer.apple.com/reference/uikit/uitextfield)
- [UITextView](https://developer.apple.com/reference/uikit/uitextview)
- [UIWebView](https://developer.apple.com/reference/uikit/uiwebview)

Other frameworks may also have views with preservable state. For information about whether a view saves state information and what state it saves, see the reference for the corresponding class.

<span id=5.4.9.2>
####5.4.9.2 Preserving the State of a Custom View 保持自定义视图的状态

If you are implementing a custom view that has restorable state, implement the [encodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiview/1622516-encoderestorablestatewithcoder) and [decodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiview/1622638-decoderestorablestatewithcoder) methods and use them to encode and decode that state. Use those methods to save only the data that cannot be easily reconfigured by other means. For example, use these methods to save data that is modified by user interactions with the view. Do not use these methods to save the data being presented by the view or any data that the owning view controller can configure easily.

Listing 5-3 shows an example of how to preserve and restore the selection for a custom view that contains editable text. In the example, the range is accessible using the selectionRange and setSelectionRange: methods, which are custom methods the view uses to manage the selection. Encoding the data only requires writing it to the provided coder object. Restoring the data requires reading it and applying it to the view.

**Listing 5-3**  Preserving the selection of a custom text view

	// Preserve the text selection
	- (void) encodeRestorableStateWithCoder:(NSCoder *)coder {
	    [super encodeRestorableStateWithCoder:coder];
	 
	    NSRange range = [self selectionRange];
	    [coder encodeInt:range.length forKey:kMyTextViewSelectionRangeLength];
	    [coder encodeInt:range.location forKey:kMyTextViewSelectionRangeLocation];
	}
	 
	// Restore the text selection.
	- (void) decodeRestorableStateWithCoder:(NSCoder *)coder {
	   [super decodeRestorableStateWithCoder:coder];
	   if ([coder containsValueForKey:kMyTextViewSelectionRangeLength] &&
	           [coder containsValueForKey:kMyTextViewSelectionRangeLocation]) {
	      NSRange range;
	      range.length = [coder decodeIntForKey:kMyTextViewSelectionRangeLength];
	      range.location = [coder decodeIntForKey:kMyTextViewSelectionRangeLocation];
	      if (range.length > 0)
	         [self setSelectionRange:range];
	   }
	}

<span id=5.4.9.3>
####5.4.9.3 Implementing Preservation-Friendly Data Sources 实现友好保持的数据源

Because the data displayed by a table or collection view can change, both classes save information about the current selection and visible cells only if their data source implements the [UIDataSourceModelAssociation](https://developer.apple.com/reference/uikit/uidatasourcemodelassociation) protocol. This protocol provides a way for a table or collection view to identify the content it contains without relying on the index path of that content. Thus, regardless of where the data source places an item during the next launch cycle, the view still has all the information it needs to locate that item.

In order to implement the UIDataSourceModelAssociation protocol successfully, your data source object must be able to identify items between subsequent launches of the app. This means that any identification scheme you devise must be invariant for a given piece of data. This is essential because the data source must be able to retrieve the same piece of data for the same identifier each time it is requested. Implementing the protocol itself is a matter of mapping from a data item to its unique ID and back again.

Apps that use Core Data can implement the protocol by taking advantage of object identifiers. Each object in a Core Data store has a unique object identifier that can be converted into a URI and used to locate the object later. If your app does not use Core Data, you need to devise your own form of unique identifiers if you want to support state preservation for your views.

>**Note:** Remember that implementing the UIDataSourceModelAssociation protocol is only necessary to preserve attributes such as the current selection in a table or collection view. This protocol is not used to preserve the actual data managed by your data source. It is your app’s responsibility to ensure that its data is saved at appropriate times.

<span id=5.4.10>
###5.4.10 Preserving Your App’s High-Level State 保持App的高级状态

In addition to the data preserved by your app’s view controllers and views, UIKit provides hooks for you to save any miscellaneous data needed by your app. Specifically, the UIApplicationDelegate protocol includes the following methods for you to override:

- [application:willEncodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623099-application)
- [application:didDecodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623006-application)

If your app contains state that does not live in a view controller, but that needs to be preserved, you can use the preceding methods to save and restore it. The application:willEncodeRestorableStateWithCoder: method is called at the very beginning of the preservation process so that you can write out any high-level app state, such as the current version of your user interface. The application:didDecodeRestorableStateWithCoder: method is called at the end of the restoration state so that you can decode any data and perform any final cleanup that your app requires.

<span id=5.4.11>
###5.4.11 Tips for Saving and Restoring State Information 保存和恢复状态信息的诀窍

As you add support for state preservation and restoration to your app, consider the following guidelines:

- **Encode version information along with the rest of your app’s state.** During the preservation process, it is recommended that you encode a version string or number that identifies the current revision of your app’s user interface. You can encode this state in the [application:willEncodeRestorableStateWithCoder:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623099-application) method of your app delegate. When your app delegate’s [application:shouldRestoreApplicationState:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622987-application) method is called, you can retrieve this information from the provided coder and use it to determine if state preservation is possible.
- **Do not include objects from your data model in your app’s state.** Apps should continue to save their data separately in iCloud or to local files on disk. Never use the state restoration mechanism to save that data. Preserved interface data may be deleted if problems occur during a restore operation. Therefore, any preservation-related data you write to disk should be considered purgeable.
- **The state preservation system expects you to use view controllers in the ways they were designed to be used.** The view controller hierarchy is created through a combination of view controller containment and by presenting one view controller from another. If your app displays the view of a view controller by another means—for example, by adding it to another view without creating a containment relationship between the corresponding view controllers—the preservation system will not be able to find your view controller to preserve it.
- **Remember that you might not want to preserve all view controllers.** In some cases, it might not make sense to preserve a view controller. For example, if the user left your app while it was displaying a view controller to change the user’s password, you might want to cancel the operation and restore the app to the previous screen. In such a case, you would not preserve the view controller that asks for the new password information.
- **Avoid swapping view controller classes during the restoration process.** The state preservation system encodes the class of the view controllers it preserves. During restoration, if your app returns an object whose class does not match (or is not a subclass of) the original object, the system does not ask the view controller to decode any state information. Thus, swapping out the old view controller for a completely different one does not restore the full state of the object.
- **The system automatically deletes an app’s preserved state when the user force quits the app.** Deleting the preserved state information when the app is killed is a safety precaution. (As a safety precaution, the system also deletes preserved state if the app crashes twice during launch.) If you want to test your app’s ability to restore its state, you should not use the multitasking bar to kill the app during debugging. Instead, use Xcode to kill the app or kill the app programmatically by installing a temporary command or gesture to call exit on demand.

<span id=5.5>
##5.5 Tips for Developing a VoIP App 开发VoIP App的诀窍

A Voice over Internet Protocol (VoIP) app allows the user to make phone calls using an Internet connection instead of the device’s cellular service. In iOS 8 and later, you can use the Apple Push Notification service (APNs) and the APIs of the PushKit framework to create a VoIP app. Relying on push notifications to enable VoIP functionality means that your app doesn’t have to maintain a persistent network connection to the associated service or configure a socket for VoIP usage. When a VoIP push notification arrives, your app is given time to handle the notification, even if the app is currently terminated.

>**Note:** VoIP push notifications are sent only to devices running iOS 8 or later. If you need to support devices that run earlier versions of iOS, you’re responsible for maintaining a compatible implementation.

As with any background audio app, the audio session for a VoIP app must be configured properly to ensure the app works smoothly with other audio-based apps. Because audio playback and recording for a VoIP app are not used all the time, it is especially important that you create and configure your app’s audio session object only when it’s needed. For example, you would create the audio session to notify the user of an incoming call or while the user was actually on a call. As soon as the call ends, you would then remove strong references to the audio session and give other audio apps the opportunity to play their audio.

For information about how to configure and manage an audio session for a VoIP app, see [Audio Session Programming Guide](https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007875). To learn more about using VoIP push notifications and the PushKit APIs to create a VoIP app, see [Energy Efficiency Guide for iOS Apps](https://developer.apple.com/library/content/documentation/Performance/Conceptual/EnergyGuide-iOS/index.html#//apple_ref/doc/uid/TP40015243).

There are several requirements for implementing a VoIP app:

1. Enable the Voice over IP background mode for your app. (Because VoIP apps involve audio content, it is recommended that you also enable the Audio and AirPlay background mode.) You enable background modes in the Capabilities tab of your Xcode project.
2. Use PushKit APIs to register to receive VoIP push notifications and handle incoming notifications.
3. Configure your audio session to handle transitions to and from active use.
4. To ensure a better user experience on iPhone, use the Core Telephony framework to adjust your behavior in relation to cell-based phone calls; see [Core Telephony Framework Reference](https://developer.apple.com/reference/coretelephony).
5. To ensure good performance for your VoIP app, use the System Configuration framework to detect network changes and allow your app to sleep as much as possible.
6. Request a VoIP Services certificate to allow your notification server to connect to the VoIP service.

Enabling the VoIP background mode lets the system know that it should allow the app to run in the background as needed to manage its network sockets. This key also permits your app to play background audio (although enabling the Audio and AirPlay mode is still encouraged). An app that supports this mode is also relaunched in the background immediately after system boot to ensure that the VoIP services are always available.

<span id=5.5.1>
###5.5.1 Using the Reachability Interfaces to Improve the User Experience 使用Reachability接口提升用户体验

Because VoIP apps rely heavily on the network, they should use the reachability interfaces of the System Configuration framework to track network availability and adjust their behavior accordingly. The reachability interfaces allow an app to be notified whenever network conditions change. For example, a VoIP app could close its network connections when the network becomes unavailable and recreate them when it becomes available again. The app could also use those kinds of changes to keep the user apprised about the state of the VoIP connection.

To use the reachability interfaces, you must register a callback function with the framework and use it to track changes. To register a callback function:

1. Create a [SCNetworkReachabilityRef](https://developer.apple.com/reference/systemconfiguration/scnetworkreachability) structure for your target remote host.
2. Assign a callback function to your structure (using the [SCNetworkReachabilitySetCallback](https://developer.apple.com/reference/systemconfiguration/1514903-scnetworkreachabilitysetcallback) function) that processes changes in your target’s reachability status.
3. Add that target to an active run loop of your app (such as the main run loop) using the [SCNetworkReachabilityScheduleWithRunLoop](https://developer.apple.com/reference/systemconfiguration/1514894-scnetworkreachabilityschedulewit) function.

Adjusting your app’s behavior based on the availability of the network can also help improve the battery life of the underlying device. Letting the system track the network changes means that your app can let itself go to sleep more often.

For more information about the reachability interfaces, see [System Configuration Framework Reference](https://developer.apple.com/reference/systemconfiguration).
