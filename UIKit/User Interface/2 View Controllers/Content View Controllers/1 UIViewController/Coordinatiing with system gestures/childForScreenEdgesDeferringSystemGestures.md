# childForScreenEdgesDeferringSystemGestures

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontroller/2887511-childforscreenedgesdeferringsyst](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887511-childforscreenedgesdeferringsyst)

Returns the child view controller that should be queried to see if its gestures should take precedence.

返回子视图控制器，将向其查询其手势是否应优先。

> iOS 11.0+
iPadOS 11.0+
Mac Catalyst 13.1+
visionOS 1.0+ Beta

## Declaration - 声明

```
var childForScreenEdgesDeferringSystemGestures: UIViewController? { get }

```

## Discussion - 讨论

When implementing a container view controller, override this method if one of your child view controllers defines screen-edge gestures that should take precedence over the system gestures. UIKit then uses the [preferredScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys) property of the returned child view controller to determine which screen edges have competing gesture recognizers.

当实现容器视图控制器时，如果其中一个子视图控制器定义了应优先于系统手势的屏幕边缘手势，请重写此方法。然后，UIKit 将使用返回的子视图控制器的 [preferredScreenEdgesDeferringSystemGestures](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys) 属性来确定哪些屏幕边缘具有竞争的手势识别器。

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


