# supportedInterfaceOrientations

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontroller/1621435-supportedinterfaceorientations](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621435-supportedinterfaceorientations)

A Boolean value that indicates whether the view controller's contents should autorotate.

指示视图控制器的内容是否应自动旋转的布尔值。

> iOS 6.0+
> 
> iPadOS 6.0+
> 
> Mac Catalyst 13.1+

## Declaration - 声明

```
var supportedInterfaceOrientations: UIInterfaceOrientationMask { get }
```

## Discussion - 讨论

This property returns a bit mask that specifies which orientations the view controller supports. For more information, see UIInterfaceOrientationMask.

此属性返回一个位掩码，指定视图控制器支持的方向。有关更多信息，请参阅 [UIInterfaceOrientationMask](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask)。

When the device orientation changes, the system calls this method on the root view controller or the topmost modal view controller that fills the window. If the view controller supports the new orientation, the system rotates the window and the view controller. The system only calls this method if the view controller's [shouldAutorotate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621419-shouldautorotate) method returns `true`.

当设备方向更改时，系统会在填充窗口的根视图控制器或最顶层模态视图控制器上调用此方法。如果视图控制器支持新方向，系统将旋转窗口和视图控制器。仅当视图控制器的 [shouldAutorotate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621419-shouldautorotate)  方法返回 `true` 时，系统才会调用此方法。

Override this method to declare which orientations the view controller supports. The default value is [all](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask/1623035-all) for the iPad idiom and [allButUpsideDown](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask/1622957-allbutupsidedown) for the iPhone idiom. The value you return must not be `0`.

重写此方法以声明视图控制器支持的方向。iPad 习惯用法的默认值为 [all](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask/1623035-all)，iPhone习惯用法的默认值为 [allButUpsideDown](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask/1622957-allbutupsidedown)。返回的值不能为 `0`。

To determine whether to rotate, the system compares the view controller's supported orientations with the app's supported orientations — as determined by the `Info.plist` file or the app delegate's [application(_:supportedInterfaceOrientationsFor:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application) method — and the device's supported orientations.

为了决定是否旋转，系统将视图控制器支持的方向与应用程序支持的方向以及设备支持的方向进行比较——应用程序支持的方向由 `Info.plist` 文件或应用程序代理的 [application(_:supportedInterfaceOrientationsFor:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623107-application) 方法决定。

> **Note**
>
> All iPadOS devices support the [portraitUpsideDown](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask/1623118-portraitupsidedown) orientation. It’s best practice to enable it for the iPad idiom. iOS devices without a Home button, such as iPhone 12, don’t support this orientation. You should disable it entirely for the iPhone idiom.
> 
> **注意**
> 
> 所有 iPadOS 设备都支持 [portraitUpsideDown](https://developer.apple.com/documentation/uikit/uiinterfaceorientationmask/1623118-portraitupsidedown) 方向。在 iPad 习惯用法启用它是最佳做法。没有 Home 按钮的iOS设备（如iPhone 12）不支持此方向。对于 iPhone 习惯用法，则应该完全禁用它。

If your app supports multitasking, the system doesn’t call this method on your view controller because multitasking apps must support all orientations. You can opt out of multitasking by enabling Requires full screen on your iOS target or by not declaring support for all possible orientations within the Info.plist file.

如果你的应用程序支持多任务，系统不会在你的视图控制器上调用此方法，因为多任务应用程序必须支持所有方向。您可以通过在 iOS 目标上启用 `Requires full screen`（需要全屏）或者在 `Info.plist` 文件中不声明所有可能方向的支持来选择退出多任务处理。

For design guidance, see [Adaptivity and Layout](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/) in the iOS Human Interface Guidelines.

有关设计指南，请参阅《iOS 人机界面指南》中的《[自适应性和布局](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/)》。

# See Also - 其他参考

## Configuring the view rotation settings - 配置视图旋转设置

### var [shouldAutorotate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621419-shouldautorotate): Bool 【Deprecated】

A Boolean value that indicates whether the view controller's contents should autorotate.

指示视图控制器的内容是否应自动旋转的布尔值。

### var [preferredInterfaceOrientationForPresentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621438-preferredinterfaceorientationfor): UIInterfaceOrientation

The interface orientation to use when presenting the view controller.

展示视图控制器时使用的界面方向。

### class func [attemptRotationToDeviceOrientation()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621400-attemptrotationtodeviceorientati) 【Deprecated】

Attempts to rotate all windows to the orientation of the device.

尝试将所有窗口旋转到设备的方向。


