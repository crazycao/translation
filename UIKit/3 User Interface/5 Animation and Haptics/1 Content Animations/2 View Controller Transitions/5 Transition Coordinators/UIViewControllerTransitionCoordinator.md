# UIViewControllerTransitionCoordinator

原文链接：[https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator)

A set of methods that provides support for animations associated with a view controller transition.

在视图控制器转场动画同时运行指定的动画。

> iOS
iPadOS
Mac Catalyst
tvOS
visionOS

```
@MainActor
protocol UIViewControllerTransitionCoordinator : UIViewControllerTransitionCoordinatorContext
```


## Overview 概述

Typically, you don’t adopt this protocol in your own classes. When you present or dismiss a view controller, UIKit creates a transition coordinator object automatically and assigns it to the view controller’s [transitionCoordinator](https://developer.apple.com/documentation/uikit/uiviewcontroller/transitioncoordinator) property. That transition coordinator object is ephemeral and lasts for the duration of the transition animation.

通常情况下，您无需在自己的类中遵循此协议。当您展示（present）或关闭（dismiss）视图控制器时，UIKit 会自动创建一个转场协调器对象，并将其赋值给视图控制器的 [transitionCoordinator](https://developer.apple.com/documentation/uikit/uiviewcontroller/transitioncoordinator) 属性。该转场协调器对象是临时的，仅在转场动画期间存在。

You can use a transition coordinator object to perform tasks that are related to a transition but that are separate from what the animator objects are doing. During a transition, the animator objects are responsible for putting the new view controller content onscreen, but there may be other visual elements that need to be displayed too. For example, a presentation controller might want to animate the appearance or disappearance of decoration views that are separate from the view controller content. In that case, it uses the transition coordinator to perform those animations.

您可以使用转场协调器对象执行与转场相关、但与动画器对象所执行操作相独立的任务。在转场过程中，动画器对象负责将新视图控制器的内容显示到屏幕上，但可能还存在其他需要显示的视觉元素。例如，展示控制器（presentation controller）可能需要对与视图控制器内容相独立的装饰视图（decoration views）执行显示或消失动画。这种情况下，它可以通过转场协调器来执行这些动画。

The transition coordinator works with the animator objects to ensure that any extra animations are performed in the same animation group as the transition animations. Having the animations in the same group means that they execute at the same time and can all respond to timing changes provided by an interactive animator object. These timing adjustments happen automatically and don’t require any extra code on your part.

转场协调器会与动画器对象协同工作，确保所有额外动画都与转场动画在同一个动画组中执行。将动画放入同一组意味着它们会同时运行，并且都能响应交互式动画器对象提供的时序变化。这些时序调整会自动进行，无需您编写额外代码。

Using the transition coordinator to handle view hierarchy animations is preferred over making those same changes in the [viewWillAppear(_:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/viewwillappear(_:)) or similar methods of your view controllers. The blocks you register with the methods of this protocol are guaranteed to execute at the same time as the transition animations. More importantly, the transition coordinator provides important information about the state of the transition, such as whether it was canceled, to your animation blocks through the [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext) object.

相比在视图控制器的 [viewWillAppear(_:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/viewwillappear(_:)) 或类似方法中执行视图层级动画，更推荐使用转场协调器来处理这类动画。通过此协议的方法注册的 block，能保证与转场动画同时执行。更重要的是，转场协调器会通过 [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext) 对象，向您的动画代码块提供转场状态的重要信息（例如转场是否已被取消）。

In addition to registering animations to perform during the transition, you can call the [notifyWhenInteractionEnds(_:)](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/notifywheninteractionends(_:)) method to register a block to clean up animations associated with an interactive transition. Cleaning up is particularly important when the user cancels a transition interactively. When a cancellation occurs, you need to return to the original view hierarchy state as it existed before the transition.

除了注册要在转场期间执行的动画外，您还可以调用 [notifyWhenInteractionEnds(_:)](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/notifywheninteractionends(_:)) 方法注册一个 block，用于清理与交互式转场相关的动画。当用户以交互方式取消转场时，清理工作尤为重要。发生取消操作时，您需要将视图层级恢复到转场前的原始状态。

Because the transition coordinator is in effect only during a transition, UIKit releases the object when the transition finishes and the final callback is made.

由于转场协调器仅在转场期间有效，因此当转场完成且最后一个回调执行后，UIKit 会释放该对象。

# Topics 主题

## Responding to view controller transition progress 响应视图控制器转场进度

### func [animate(alongsideTransition: ((any UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((any UIViewControllerTransitionCoordinatorContext) -> Void)?) -> Bool](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/animate(alongsidetransition:completion:))
Runs the specified animations at the same time as the view controller transition animations.

在视图控制器转场动画同时运行指定的动画。

[Required]

### func [animateAlongsideTransition(in: UIView?, animation: ((any UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((any UIViewControllerTransitionCoordinatorContext) -> Void)?) -> Bool](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/animatealongsidetransition(in:animation:completion:))

Runs the specified animations in a view that’s outside of the designated container view.

在指定容器视图之外的视图中运行指定的动画。

[Required]

### func [notifyWhenInteractionChanges((any UIViewControllerTransitionCoordinatorContext) -> Void)](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/notifywheninteractionchanges(_:))

Registers a block to be executed when a transition changes from interactive to non-interactive.

注册一个代码块，当转场从交互状态变为非交互状态时执行该代码块。

[Required]

### func [notifyWhenInteractionEnds((any UIViewControllerTransitionCoordinatorContext) -> Void)](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/notifywheninteractionends(_:))

Registers a block to be executed when a transition changes from interactive to non-interactive.

注册一个代码块，当转场从交互状态变为非交互状态时执行该代码块。

[Required]【Deprecated】


# See Also 其他参考

## Transition coordinators 转场协调器

### protocol [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext)

A set of methods that provides information about an in-progress view controller transition.

一组提供有关正在进行的视图控制器转场相关信息的方法。
