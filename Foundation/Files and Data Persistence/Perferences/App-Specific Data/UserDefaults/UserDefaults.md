# UserDefaults


An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.

一个用户默认数据库的接口，您可以在应用程序的不同启动之间持久地存储键值对。

原文地址：[https://developer.apple.com/documentation/foundation/userdefaults](https://developer.apple.com/documentation/foundation/userdefaults)

> iOS 2.0+
iPadOS 2.0+
Mac Catalyst 13.0+
macOS 10.0+
tvOS 9.0+
visionOS 1.0+
watchOS 2.0+

```
class UserDefaults : NSObject
```

# Overview 概览

The UserDefaults class provides a programmatic interface for interacting with the defaults system. The defaults system allows an app to customize its behavior to match a user’s preferences. For example, you can allow users to specify their preferred units of measurement or media playback speed. Apps store these preferences by assigning values to a set of parameters in a user’s defaults database. The parameters are referred to as defaults because they’re commonly used to determine an app’s default state at startup or the way it acts by default.

UserDefaults 类提供了一个编程接口，用于与默认系统进行交互。默认系统允许应用程序根据用户的偏好自定义其行为。例如，您可以允许用户指定其首选的测量单位或媒体播放速度。应用程序通过将值分配给用户默认数据库中的一组参数来存储这些偏好设置。这些参数被称为默认值，因为它们通常用于确定应用程序在启动时的默认状态或默认操作方式。

At runtime, you use UserDefaults objects to read the defaults that your app uses from a user’s defaults database. UserDefaults caches the information to avoid having to open the user’s defaults database each time you need a default value. When you set a default value, it’s changed synchronously within your process, and asynchronously to persistent storage and other processes.

在运行时，您可以使用 UserDefaults 对象从用户的默认数据库中读取应用程序使用的默认值。UserDefaults 会缓存信息，以避免每次需要默认值时都打开用户的默认数据库。当您设置默认值时，在您的进程内会同步更改，而在持久存储和其他进程中会异步更改。

> **Important** **重要**
>
> Don’t try to access the preferences subsystem directly. Modifying preference property list files may result in loss of changes, delay of reflecting changes, and app crashes. To configure preferences, use the defaults command-line utility in macOS instead.
> 
> 不要直接访问偏好设置子系统。修改偏好设置属性列表文件可能会导致更改丢失、延迟反映更改以及应用程序崩溃。要配置偏好设置，请在 macOS 中使用 `defaults` 命令行实用程序。

With the exception of managed devices in educational institutions, a user’s defaults are stored locally on a single device, and persisted for backup and restore. To synchronize preferences and other data across a user’s connected devices, use [NSUbiquitousKeyValueStore](https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore) instead.

除了教育机构中的受管理设备外，用户的默认设置会在单个设备上本地存储，并进行备份和恢复。要在用户连接的设备之间同步偏好设置和其他数据，请改用 [NSUbiquitousKeyValueStore](https://developer.apple.com/documentation/foundation/nsubiquitouskeyvaluestore)。

> **Important** **重要**
>
> This API has the potential of being misused to access device signals to try to identify the device or user, also known as fingerprinting. Regardless of whether a user gives your app permission to track, fingerprinting is not allowed. When you use this API in your app or third-party SDK (an SDK not provided by Apple), declare your usage and the reason for using the API in your app or third-party SDK’s `PrivacyInfo.xcprivacy` file. For more information, including the list of valid reasons for using the API, see [Describing use of required reason API](https://developer.apple.com/documentation/bundleresources/describing-use-of-required-reason-api).
> 
> 此 API 有可能被滥用来访问设备信号以尝试识别设备或用户，也称为指纹识别。无论用户是否允许您的应用跟踪，都不允许进行指纹识别。当您在应用程序或第三方 SDK（非 Apple 提供的 SDK）中使用此 API 时，请在您的应用程序或第三方 SDK 的 `PrivacyInfo.xcprivacy` 文件中声明您的使用情况和使用此 API 的原因。有关更多信息，包括使用此 API 所需原因的列表，请参阅《[描述所需原因 API](https://developer.apple.com/documentation/bundleresources/describing-use-of-required-reason-api)》。

## Storing Default Objects - 存储默认对象

The UserDefaults class provides convenience methods for accessing common types such as floats, doubles, integers, Boolean values, and URLs. These methods are described in [Setting Default Values](https://developer.apple.com/documentation/foundation/userdefaults#1664798).

UserDefaults 类提供了用于访问常见类型的便捷方法，如浮点数、双精度浮点数、整数、布尔值和 URL。这些方法在《[设置默认值](https://developer.apple.com/documentation/foundation/userdefaults#1664798)》中进行了描述。

A default object must be a property list—that is, an instance of (or for collections, a combination of instances of) `NSData`, `NSString`, `NSNumber`, `NSDate`, `NSArray`, or `NSDictionary`. If you want to store any other type of object, you should typically archive it to create an instance of `NSData`.

默认对象必须是属性列表，即 `NSData`、`NSString`、`NSNumber`、`NSDate`、`NSArray` 或 `NSDictionary` 的实例（或实例的组合）。如果您想存储任何其他类型的对象，通常应将其归档以创建 `NSData` 的实例。

Values returned from UserDefaults are immutable, even if you set a mutable object as the value. For example, if you set a mutable string as the value for `“MyStringDefault”`, the string you later retrieve using the [string(forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1416700-string) method will be immutable. If you set a mutable string as a default value and later mutate the string, the default value won’t reflect the mutated string value unless you call [set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414067-set) again.

从 UserDefaults 返回的值是不可变的，即使您将可变对象设置为值。例如，如果您将可变字符串设置为 `“MyStringDefault”` 的值，稍后使用 [string(forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1416700-string) 方法检索的字符串将是不可变的。如果您将可变字符串设置为默认值，然后更改该字符串，除非再次调用 [set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414067-set)，否则默认值不会反映已更改的字符串值。

For more details, see [Preferences and Settings Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i).

有关更多详情，请参阅《[偏好和设置编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i)》。

## Persisting File References - 持久化文件引用

A file URL specifies a location in the file system. If you use the [set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414194-set) method to store the location for a particular file and the user moves that file, your app may not be able to locate that file on next launch. To store a reference to a file by its file system identity, you can instead create NSURL bookmark data using the [bookmarkData(options:includingResourceValuesForKeys:relativeTo:)](https://developer.apple.com/documentation/foundation/nsurl/1417795-bookmarkdata) method and persist it using the [set(_:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414194-set) method. You can then use the [URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:](https://developer.apple.com/documentation/foundation/nsurl/1572035-urlbyresolvingbookmarkdata) method to resolve the bookmark data stored in user defaults to a file URL.

文件 URL 表示文件系统中的某个位置。如果您使用 [set(:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414194-set) 方法存储特定文件的位置，而用户移动了该文件，您的应用程序可能无法在下次启动时定位该文件。为了通过其文件系统标识存储对文件的引用，您可以使用[bookmarkData(options:includingResourceValuesForKeys:relativeTo:)](https://developer.apple.com/documentation/foundation/nsurl/1417795-bookmarkdata) 方法创建 NSURL 书签数据，并使用 [set(:forKey:)](https://developer.apple.com/documentation/foundation/userdefaults/1414194-set) 方法持久化它。然后，您可以使用 [URLByResolvingBookmarkData:options:relativeToURL:bookmarkDataIsStale:error:](https://developer.apple.com/documentation/foundation/nsurl/1572035-urlbyresolvingbookmarkdata) 方法将存储在用户偏好设置中的书签数据解析为文件 URL。

## Responding to Defaults Changes - 响应默认值更改

You can use key-value observing to be notified of any updates to a particular default value. You can also register as an observer for [didChangeNotification](https://developer.apple.com/documentation/foundation/userdefaults/1408206-didchangenotification) on the default notification center in order to be notified of all updates to a local defaults database.

您可以使用键-值观察（Key-Value Observing）来接收有关特定默认值更新的通知。您还可以在默认通知中心上注册为 [didChangeNotification](https://developer.apple.com/documentation/foundation/userdefaults/1408206-didchangenotification) 的观察者，以便接收有关本地默认数据库所有更新的通知。

For more details, see [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) and [Notification Programming Topics](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Notifications/Introduction/introNotifications.html#//apple_ref/doc/uid/10000043i).

若需了解更多详细信息，请参阅《[键值观察编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i)》和《[通知编程主题](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Notifications/Introduction/introNotifications.html#//apple_ref/doc/uid/10000043i)》。

## Using Defaults in Managed Environments - 在受管理环境中使用默认值

If your app supports managed environments, you can use UserDefaults to determine which preferences are managed by an administrator for the benefit of the user. In a managed environment, such as a computer lab or classroom, an administrator or teacher can configure the systems by establishing a set of default preferences for users. If a preference is managed in this manner (as determined by the methods described in [Accessing Managed Environment Keys](https://developer.apple.com/documentation/foundation/userdefaults#1664949)), your app should prevent users from editing that preference by disabling or hiding controls.

如果您的应用程序支持受管理环境，您可以使用 UserDefaults 来确定管理员为方便用户而管理的偏好设置。在受管理环境中，如计算机实验室或教室，管理员或教师可以通过为用户建立一组默认偏好设置来配置系统。如果以这种方式管理了偏好设置（由《[访问受管理环境的键](https://developer.apple.com/documentation/foundation/userdefaults#1664949)》中描述的方法确定），您的应用程序应该通过禁用或隐藏控件来防止用户编辑该偏好设置。

For more details, see [Mobile Device Management Protocol Reference](https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/MobileDeviceManagementProtocolRef/1-Introduction/Introduction.html#//apple_ref/doc/uid/TP40017387).

若需了解更多详细信息，请参阅《[移动设备管理协议参考](https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/MobileDeviceManagementProtocolRef/1-Introduction/Introduction.html#//apple_ref/doc/uid/TP40017387)》。

An app running on a device managed by an educational institution can use the iCloud key-value store to share small amounts of data with other instances of itself on the user’s other devices. For example, a textbook app might store the current page number being read by the user so that other instances of the app can open to the same page when launched.

在由教育机构管理的设备上运行的应用程序可以使用 iCloud 键值存储与用户其他设备上的应用程序实例共享少量数据。例如，教科书应用程序可以存储用户正在阅读的当前页码，以便在启动时其他应用程序实例可以打开到同一页。

For more information, see [Storing Preferences in iCloud](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/StoringPreferenceDatainiCloud/StoringPreferenceDatainiCloud.html#//apple_ref/doc/uid/10000059i-CH7) in [Preferences and Settings Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i).

有关更多信息，请参阅《[偏好和设置编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/Introduction/Introduction.html#//apple_ref/doc/uid/10000059i)》中的《[在 iCloud 中存储偏好](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/UserDefaults/StoringPreferenceDatainiCloud/StoringPreferenceDatainiCloud.html#//apple_ref/doc/uid/10000059i-CH7)》。

## Sandbox Considerations - 沙盒注意事项

A sandboxed app cannot access or modify the preferences for any other app, with the following exceptions:

- App extensions on macOS and iOS
- Other apps in your application group on macOS

经过沙盒化的应用程序无法访问或修改任何其他应用程序的偏好设置，但有以下几个例外情况：

- macOS 和 iOS 上的应用扩展
- macOS 上您应用程序组中的其他应用

Adding a third-party app’s domain using the [addSuite(named:)](https://developer.apple.com/documentation/foundation/userdefaults/1410294-addsuite) method doesn’t allow your app to access to that app’s preferences. Attempting to access or modify another app’s preferences doesn’t result in an error; instead, macOS reads and writes files located within your app’s container, rather than the actual preference files for the other application.

使用 [addSuite(named:)](https://developer.apple.com/documentation/foundation/userdefaults/1410294-addsuite) 方法添加第三方应用程序的域，并不能让您的应用程序访问该应用程序的偏好设置。尝试访问或修改另一个应用程序的偏好设置不会导致错误；相反，macOS 会读取和写入位于您应用程序容器内的文件，而不是其他应用程序的实际偏好设置文件。

## Thread Safety - 线程安全

The UserDefaults class is thread-safe.

UserDefaults 类是线程安全的。

# See Also 其它参考

## Networking - 网络

[Bonjour](https://developer.apple.com/documentation/foundation/bonjour) （译者注：Bonjour是苹果为基于组播域名服务(multicast DNS)的开放性零设置网络标准所起的名字，能自动发现IP网络上的电脑、设备和服务。）

Advertise services for easy discovery on local networks, or discover services advertised by others.

易于在本地网络上发现的广告服务，或发现其他人的广告的服务。