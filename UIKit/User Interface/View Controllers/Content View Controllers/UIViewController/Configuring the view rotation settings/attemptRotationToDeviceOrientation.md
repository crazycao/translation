# attemptRotationToDeviceOrientation

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontroller/1621400-attemptrotationtodeviceorientati](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621400-attemptrotationtodeviceorientati)

Attempts to rotate all windows to the orientation of the device.

尝试将所有窗口旋转到设备的方向。

> iOS 6.0–16.0 Deprecated
> 
> iPadOS 6.0–16.0 Deprecated
> 
> Mac Catalyst 13.1–16.0 Deprecated

## Declaration - 声明

```
class func attemptRotationToDeviceOrientation()

```

## Discussion - 讨论

Some view controllers may want to use app-specific conditions to determine what interface orientations are supported. If your view controller does this, when those conditions change, your app should call this class method. The system immediately attempts to rotate to the new orientation.

某些视图控制器可能希望使用 app 特定的条件来确定支持哪些界面方向。如果您的视图控制器执行此操作，当这些条件变化时，您的应用程序要调用这个类方法。系统立即尝试旋转到新的方向。

# See Also - 其他参考

## Configuring the view rotation settings - 配置视图旋转设置

### var [shouldAutorotate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621419-shouldautorotate): Bool 【Deprecated】

A Boolean value that indicates whether the view controller's contents should autorotate.

指示视图控制器的内容是否应自动旋转的布尔值。

### var [supportedInterfaceOrientations](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621435-supportedinterfaceorientations): UIInterfaceOrientationMask

The interface orientations that the view controller supports.

视图控制器支持的界面方向。

### var [preferredInterfaceOrientationForPresentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621438-preferredinterfaceorientationfor): UIInterfaceOrientation

The interface orientation to use when presenting the view controller.

展示视图控制器时使用的界面方向。

### class func [attemptRotationToDeviceOrientation()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621400-attemptrotationtodeviceorientati) 【Deprecated】

Attempts to rotate all windows to the orientation of the device.

尝试将所有窗口旋转到设备的方向。


