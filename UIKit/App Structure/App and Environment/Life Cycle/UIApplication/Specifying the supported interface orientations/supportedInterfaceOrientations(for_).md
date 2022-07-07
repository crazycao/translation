# supportedInterfaceOrientations(for:)

原文链接：[https://developer.apple.com/documentation/uikit/uiapplication/1623091-supportedinterfaceorientations](https://developer.apple.com/documentation/uikit/uiapplication/1623091-supportedinterfaceorientations)

Returns the default set of interface orientations to use for the view controllers in the specified window.

返回用于指定窗口中视图控制器的界面方向的默认集合。

> iOS 6.0+
> 
> iPadOS 6.0+
> 
> Mac Catalyst 13.1+

## Declaration - 声明

```
func supportedInterfaceOrientations(for window: UIWindow?) -> UIInterfaceOrientationMask
```

## Parameters - 参数

- `window`

	The window whose default interface orientations you want to retrieve.
	
	要检索其默认界面方向的窗口。

## Return Value - 返回值

A bit mask specifying which orientations are supported. See [UIInterfaceOrientationMask](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask) for valid bit-mask values. The value returned by this method must not be `0`.

指定支持哪些方向的位掩码。有效的位掩码值参见 [UIInterfaceOrientationMask](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask)。此方法返回的值一定不会为 `0`。

## Discussion - 讨论

Starting in iOS 8, you should employ the [UITraitCollection](https://developer.apple.com/documentation/uikit/uitraitcollection) and [UITraitEnvironment](https://developer.apple.com/documentation/uikit/uitraitenvironment) APIs, and size class properties as used in those APIs, instead of using this method or otherwise writing your app in terms of interface orientation.

从iOS 8开始，您应该使用 [UITraitCollection](https://developer.apple.com/documentation/uikit/uitraitcollection) 和[UITraitEnvironment](https://developer.apple.com/documentation/uikit/uitraitenvironment) API，以及这些API中使用的 size class 属性，根据界面方向编写应用程序，而不是使用这个方法或其他方法。

This method returns the default interface orientations for the app. These orientations are used only for view controllers that do not specify their own. If your app delegate implements the [application(_:supportedInterfaceOrientationsFor:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application) method, the system does not call this method.

此方法返回应用程序的默认界面方向。这些方向仅用于未指定自己方向的视图控制器。如果您的应用程序委托实现了 [application(_:supportedInterfaceOrientationsFor:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application) 方法，则系统不会调用此方法。

The default implementation of this method returns the app’s default set of supported interface orientations, as you define them in the [UISupportedInterfaceOrientations](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/iPhoneOSKeys.html#//apple_ref/doc/uid/TP40009252-SW10) key of the `Info.plist` file in your Xcode project. If the file does not contain that key, this method returns all interface orientations for the iPad idiom and returns all interface orientations except the portrait upside-down orientation for the iPhone idiom.

此方法的默认实现返回应用程序支持的界面方向的默认集合，也就是您在 Xcode 项目中的 `Info.plist` 文件的 [UISupportedInterfaceOrientations](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/iPhoneOSKeys.html#//apple_ref/doc/uid/TP40009252-SW10) 键中定义的值。如果文件不包含该键，此方法将在 iPad 上是返回所有界面方向，而在 iPhone 上时返回除纵向倒置方向以外的所有界面方向。


