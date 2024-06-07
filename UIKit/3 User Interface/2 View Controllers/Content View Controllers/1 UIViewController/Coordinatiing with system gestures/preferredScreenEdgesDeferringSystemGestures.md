# preferredScreenEdgesDeferringSystemGestures

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887512-preferredscreenedgesdeferringsys)

The screen edges for which you want your gestures to take precedence over the system gestures.

您希望在屏幕的哪个边缘让您的手势优先于系统手势。

> iOS 11.0+
iPadOS 11.0+
Mac Catalyst 13.1+
visionOS 1.0+ Beta

## Declaration - 声明

```
var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { get }

```

## Discussion - 讨论

Normally, the screen-edge gestures defined by the system take precedence over any gesture recognizers that you define. The system uses its gestures to implement system-level behaviors, such as to display Control Center.

通常情况下，由系统定义的屏幕边缘手势优先于您定义的任何手势识别器。系统使用它的手势来实现系统级行为，例如显示控制中心。

Whenever possible, you should allow the system gestures to take precedence. However, immersive apps can use this property to allow app-defined gestures to take precedence over the system gestures. You do that by overriding this property and returning the screen edges for which your gestures should take precedence.

您应该尽可能地允许系统手势优先执行。然而，沉浸式应用程序可以使用此属性，使应用程序定义的手势优先于系统手势。您可以通过覆盖此属性并返回您希望手势优先的屏幕边缘来实现这一点。

If you change the edges preferred by your view controller, update the value of this property and call the [setNeedsUpdateOfScreenEdgesDeferringSystemGestures()](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887507-setneedsupdateofscreenedgesdefer) method to notify the system that the edges have changed.

如果您更改了视图控制器首选的边缘，请更新此属性的值，并调用 [setNeedsUpdateOfScreenEdgesDeferringSystemGestures()](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887507-setneedsupdateofscreenedgesdefer) 方法，以通知系统边缘已更改。

For information on showing and hiding the visual indicator for returning to the Home Screen, see [prefersHomeIndicatorAutoHidden](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887510-prefershomeindicatorautohidden).

有关显示和隐藏返回主屏幕的视觉指示器的信息，请参阅 [prefersHomeIndicatorAutoHidden](https://developer.apple.com/documentation/uikit/uiviewcontroller/2887510-prefershomeindicatorautohidden)。


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


