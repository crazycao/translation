# preferredInterfaceOrientationForPresentation

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontroller/1621438-preferredinterfaceorientationfor](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621438-preferredinterfaceorientationfor)

The interface orientation to use when presenting the view controller.

展示视图控制器时使用的界面方向。

> iOS 6.0+
> 
> iPadOS 6.0+
> 
> Mac Catalyst 13.1+

## Declaration - 声明

```
var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { get }
```

## Return Value - 返回值

The interface orientation with which to present the view controller.

要展示的视图控制器的界面方向。

## Discussion - 讨论

The system calls this method when presenting the view controller full screen. When your view controller supports two or more orientations but the content appears best in one of those orientations, override this method and return the preferred orientation.

系统全屏展示视图控制器时调用此方法。如果视图控制器支持两个或多个方向，但内容在其中一个方向上显示得最好，请重写此方法并返回首选方向。

If your view controller implements this method, your view controller’s view is shown in the preferred orientation (although it can later be rotated to another supported rotation). If you do not implement this method, the system presents the view controller using the current orientation of the status bar.

如果视图控制器实现此方法，则视图控制器的视图将以首选方向显示（尽管稍后可以将其旋转到另一个支持的旋转方向）。如果未实现此方法，系统将使用状态栏的当前方向显示视图控制器。

# See Also - 其他参考

## Configuring the view rotation settings - 配置视图旋转设置

### var [shouldAutorotate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621419-shouldautorotate): Bool 【Deprecated】

A Boolean value that indicates whether the view controller's contents should autorotate.

指示视图控制器的内容是否应自动旋转的布尔值。

### var [supportedInterfaceOrientations](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621435-supportedinterfaceorientations): UIInterfaceOrientationMask

The interface orientations that the view controller supports.

视图控制器支持的界面方向。

### class func [attemptRotationToDeviceOrientation()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621400-attemptrotationtodeviceorientati) 【Deprecated】

Attempts to rotate all windows to the orientation of the device.

尝试将所有窗口旋转到设备的方向。


