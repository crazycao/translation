# animate(alongsideTransition:completion:)

原文链接：[https://developer.apple.com/documentation/UIKit/UIViewControllerTransitionCoordinator/animate(alongsideTransition:completion:)](https://developer.apple.com/documentation/UIKit/UIViewControllerTransitionCoordinator/animate(alongsideTransition:completion:))

Runs the specified animations at the same time as the view controller transition animations.

在视图控制器转场动画同时运行指定的动画。

> iOS
iPadOS
Mac Catalyst
tvOS
visionOS

```
@MainActor
func animate(
    alongsideTransition animation: ((any UIViewControllerTransitionCoordinatorContext) -> Void)?,
    completion: ((any UIViewControllerTransitionCoordinatorContext) -> Void)? = nil
) -> Bool
```

[Required]


## Parameters 参数

- **animation**

	A block containing the animations you want to perform. These animations run in the same context as the transition animations and therefore have the same default attributes. You may specify `nil` for this parameter.
	
	一个包含你想要执行的动画的 block。这些动画与转场动画在同一上下文中运行，因此具有相同的默认属性。你可以为此参数指定 `nil`。

	The block has no return value and takes the following parameter:
	
	该 block 没有返回值，且接受以下参数：

	- context

		The contextual information for performing the animations. Use this object to get the animation-related information, including the container view in which to run your animations. For more information, see [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext).
		
		执行动画的上下文信息。使用此对象可获取与动画相关的信息，包括运行动画的容器视图。有关更多信息，请参阅 [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext)。

	The animation you specify must take place in a view descended from the container view.
	
	你指定的动画必须在容器视图的子视图中进行。

- **completion**

	The block of code to execute after the transition finishes. You may specify `nil` for this parameter. The block has no return value and takes the following parameter:
	
	转场完成后要执行的 block。你可以为此参数指定 `nil`。该 block 没有返回值，且接受以下参数：

	- context

		The contextual information for performing the animations. Use this object to get the animation-related information, including the container view in which to run your animations. For more information, see [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext).
		
		执行动画的上下文信息。使用此对象可获取与动画相关的信息，包括运行动画的容器视图。有关更多信息，请参阅 [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext)。

## Return Value 返回值

`true` if the animations were successfully queued to run or `false` if they were not.

如果动画已成功排队等待运行，则为 `true`；否则为 `false`。

## Discussion 讨论

Use this method to perform animations that aren’t handled by the animator objects themselves. All of the animations you specify must occur inside the animation context’s container view (or one of its descendants). Use the `containerView` property of the context object to get the container view. To perform animations in a view that doesn’t descend from the container view, use the [animateAlongsideTransition(in:animation:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/animatealongsidetransition(in:animation:completion:)) method instead.

使用此方法执行动画控制器对象本身不处理的动画。您指定的所有动画都必须在动画上下文的容器视图（或其任一子视图）内发生。可通过上下文对象的 `containerView` 属性获取该容器视图。若要在并非容器视图子视图的视图中执行动画，请改用 [animateAlongsideTransition(in:animation:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator/animatealongsidetransition(in:animation:completion:)) 方法。

The animations in the `animation` parameter are normally performed concurrently with the view controller transition animations. That behavior applies when the animator object’s [animateTransition(using:)](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/animatetransition(using:)) method is implemented using UIView-based animations. If the animator object uses Core Animation to animate the layer contents directly, your animations are run shortly after the `animateTransition:` method returns.

`animation` 参数中的动画通常与视图控制器转场动画同时执行。当动画控制器对象的 [animateTransition(using:)](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/animatetransition(using:)) 方法是通过基于 UIView 的动画实现时，会应用此行为。如果动画控制器对象使用核心动画（Core Animation）直接对图层内容进行动画处理，则您的动画会在 `animateTransition:` 方法返回后不久运行。

This method returns `false` when the block in the `animation` parameter can’t be queued to run. The completion block can still run even when this method returns `false`.

当 `animation` 参数中的代码块无法排入运行队列时，此方法会返回 `false`。即使此方法返回 `false`，完成 block 仍可能运行。

# See Also - 其他参考

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



