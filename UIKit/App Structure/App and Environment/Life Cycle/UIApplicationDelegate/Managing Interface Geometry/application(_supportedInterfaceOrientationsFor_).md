# application(_:supportedInterfaceOrientationsFor:)

原文链接：[https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application)

Asks the delegate for the interface orientations to use for the view controllers in the specified window.

要求代理提供用于指定窗口中视图控制器的界面方向。

> iOS 6.0+
> 
> iPadOS 6.0+
> 
> Mac Catalyst 13.1+

## Declaration - 声明

```
optional func application(
    _ application: UIApplication,
    supportedInterfaceOrientationsFor window: UIWindow?
) -> UIInterfaceOrientationMask
```

## Parameters - 参数

- `application`

	Your singleton app object.

	你的单例 app 对象。

- `window`

	The window whose default interface orientations you want to retrieve.
	
	要检索其默认界面方向的窗口。

## Return Value - 返回值

A bit mask of the [UIInterfaceOrientationMask](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask) constants that indicate the orientations to use for the view controllers.

表示用于视图控制器的方向的 [UIInterfaceOrientationMask](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask)  常量位掩码。

## Discussion - 讨论

This method returns the total set of interface orientations supported by the app. When determining whether to rotate a particular view controller, the orientations returned by this method are intersected with the orientations supported by the root view controller or topmost presented view controller. The app and view controller must agree before the rotation is allowed.

此方法返回应用程序支持的界面方向的总集。在决定是否旋转特定视图控制器时，此方法返回的方向与根视图控制器或最顶层显示的视图控制器支持的方向相交。应用程序和视图控制器必须一致才允许旋转。

If you do not implement this method, the app uses the values in the `UIInterfaceOrientation` key of the app’s `Info.plist` as the default interface orientations.

如果未实现此方法，应用程序将使用 app 的 `Info.plist` 的 `UIInterfaceOrientation` 键中的值作为默认界面方向。

# See Also - 其他参考

## Managing Interface Geometry - 管理界面几何图形

### enum [UIInterfaceOrientation](https://developer.apple.com/documentation/uikit/uiinterfaceorientation)

Constants that specify the orientation of the app's user interface.

指定应用程序用户界面方向的常量。

### struct [UIInterfaceOrientationMask](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask)

Constants that specify a view controller’s supported interface orientations.

指定视图控制器支持的界面方向的常量。

### class let [invalidInterfaceOrientationException](https://developer.apple.com/documentation/uikit/uiapplication/1623015-invalidinterfaceorientationexcep): NSExceptionName

An exception that’s thrown if a view controller or the app returns an invalid set of supported interface orientations.

如果视图控制器或应用程序返回一组无效的支持界面方向，则引发异常。

