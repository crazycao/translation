# shouldAutorotate

原文链接：[https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application)

A Boolean value that indicates whether the view controller's contents should autorotate.

指示视图控制器的内容是否应自动旋转的布尔值。

> iOS 6.0–16.0 Deprecated
> 
> iPadOS 6.0–16.0 Deprecated
> 
> Mac Catalyst 13.1–16.0 Deprecated

## Declaration - 声明

```
var shouldAutorotate: Bool { get }
```

## Return Value - 返回值

`true` if the content should rotate, otherwise `false`. This method returns `true` by default.

如果内容可以旋转，返回 `true`；否则是 `false`。该方法默认返回 `true`。

## Discussion - 讨论

This method returns the total set of interface orientations supported by the app. When determining whether to rotate a particular view controller, the orientations returned by this method are intersected with the orientations supported by the root view controller or topmost presented view controller. The app and view controller must agree before the rotation is allowed.

此方法返回应用程序支持的界面方向的总集。在决定是否旋转特定视图控制器时，此方法返回的方向与根视图控制器或最顶层显示的视图控制器支持的方向相交。应用程序和视图控制器必须一致才允许旋转。

If you do not implement this method, the app uses the values in the `UIInterfaceOrientation` key of the app’s `Info.plist` as the default interface orientations.

如果未实现此方法，应用程序将使用 app 的 `Info.plist` 的 `UIInterfaceOrientation` 键中的值作为默认界面方向。

# See Also - 其他参考

## Configuring the view rotation settings - 配置视图旋转设置

### var [supportedInterfaceOrientations](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621435-supportedinterfaceorientations): UIInterfaceOrientationMask

The interface orientations that the view controller supports.

视图控制器支持的界面方向。

### var [preferredInterfaceOrientationForPresentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621438-preferredinterfaceorientationfor): UIInterfaceOrientation

The interface orientation to use when presenting the view controller.

展示视图控制器时使用的界面方向。

### class func [attemptRotationToDeviceOrientation()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621400-attemptrotationtodeviceorientati) 【Deprecated】

Attempts to rotate all windows to the orientation of the device.

尝试将所有窗口旋转到设备的方向。


