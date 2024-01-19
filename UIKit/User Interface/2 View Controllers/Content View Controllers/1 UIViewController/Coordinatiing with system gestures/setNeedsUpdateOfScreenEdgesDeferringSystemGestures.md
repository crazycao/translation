# setNeedsUpdateOfScreenEdgesDeferringSystemGestures()

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontroller/2887507-setneedsupdateofscreenedgesdefer](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887507-setneedsupdateofscreenedgesdefer)

Notifies the system of changes to the screen edges that defer system gestures.

通知系统屏幕边缘的变化，以延迟系统手势。

> iOS 11.0+
iPadOS 11.0+
Mac Catalyst 13.1+
visionOS 1.0+ Beta

## Declaration - 声明

```
func setNeedsUpdateOfScreenEdgesDeferringSystemGestures()

```

## Discussion - 讨论

Call this method whenever you modify the screen edges that defer system gestures, such as those that invoke Control Center, so the system can update accordingly. If the [childForScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887511-childforscreenedgesdeferringsyst) property is `nil`, the system reads the edges from the current view controller’s [preferredScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys) property; otherwise, it uses the same property on the referenced child view controller.

每当在您修改延迟系统手势（例如调用控制中心的手势）的屏幕边缘时，请调用此方法，以便系统可以相应地进行更新。如果 [childForScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887511-childforscreenedgesdeferringsyst) 属性为 `nil`，则系统将从当前视图控制器的 [preferredScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys) 属性中读取边缘；否则，它将使用被引用的子视图控制器上的相同属性。


# See Also - 其他参考

## Coordinating with system gestures - 与系统手势协调

### var [preferredScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys): UIRectEdge

The screen edges for which you want your gestures to take precedence over the system gestures.

您希望发生在哪个屏幕边缘的手势优先于系统手势。

### var [childForScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887511-childforscreenedgesdeferringsyst): UIViewController?

Returns the child view controller that should be queried to see if its gestures should take precedence.

返回需要查询查看其手势是否应优先的子视图控制器。

### func [setNeedsUpdateOfScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887507-setneedsupdateofscreenedgesdefer)()

Notifies the system of changes to the screen edges that defer system gestures.

通知系统延迟系统屏幕边缘手势的更改。

### var [prefersHomeIndicatorAutoHidden](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887510-prefershomeindicatorautohidden): Bool

A Boolean that indicates whether the system is allowed to hide the visual indicator for returning to the Home Screen.

一个布尔值，指示是否允许系统隐藏返回主屏幕的视觉指示器。

### var [childForHomeIndicatorAutoHidden](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887508-childforhomeindicatorautohidden): UIViewController?

Returns the child view controller that is consulted about its preference for displaying a visual indicator for returning to the Home screen.

返回被咨询其是否显示用于返回主屏幕的视觉指示器的首选项的子视图控制器。

### func [setNeedsUpdateOfHomeIndicatorAutoHidden](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887509-setneedsupdateofhomeindicatoraut)()

Notifies UIKit that your view controller updated its preference regarding the visual indicator for returning to the Home screen.

通知 UIKit 您的视图控制器已更新其关于返回主屏幕的视觉指示器的首选项。


