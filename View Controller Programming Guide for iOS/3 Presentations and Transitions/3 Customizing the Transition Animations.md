# Customizing the Transition Animations 自定义转场动画

原文地址：[https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html#//apple_ref/doc/uid/TP40007457-CH16-SW1](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html#//apple_ref/doc/uid/TP40007457-CH16-SW1)

Transition animations provide visual feedback about changes to your app’s interface. UIKit provides a set of standard transition styles to use when presenting view controllers, and you can supplement the standard transitions with custom transitions of your own.

转场动画提供了有关应用程序界面更改的视觉反馈。UIKit 提供了一组标准转场样式在呈现视图控制器时使用，你也可以通过自己的自定义转场来补充标准转场。

## The Transition Animation Sequence 转场动画序列

A transition animation swaps the contents of one view controller for the contents of another. There are two types of transitions: presentations and dismissals. A presentation transition adds a new view controller to your app’s view controller hierarchy, whereas a dismissal transition removes one or more view controllers from the hierarchy.

转场动画将一个视图控制器的内容交换为另一个视图控件的内容。有两种类型的转场：presentations 和 dismissals。Presentation 转场会将一个新的视图控制器添加到应用程序的视图控制器层次结构中，而 dismissal 转场则会从层次结构中删除一个或多个视图控制器。

It takes many objects to implement a transition animation. UIKit provides default versions of all of the objects involved in transitions, and you can customize all of them or only a subset. If you choose the right set of objects, you should be able to create your animations with only a small amount of code. Even animations that include interactions can be implemented easily if you take advantage of the existing code that UIKit provides.

实现一个转场动画需要许多对象。UIKit 提供了转场中涉及的所有对象的默认版本，您可以自定义所有对象或仅自定义一个子集。如果您选择了正确的对象集，您应该能够只使用少量代码创建动画。如果利用 UIKit 提供的现有代码，即使是包含交互的动画也可以很容易地实现。

### The Transitioning Delegate 转场代理

The transitioning delegate is the starting point for transition animations and custom presentations. The transitioning delegate is an object that you define and that conforms to the [UIViewControllerTransitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate) protocol. Its job is to provide UIKit with the following objects:

转场代理是转场动画和自定义 presentation 的起点。转换代理是您定义的一个对象，它遵守 [UIViewControllerTransitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate) 协议。它的工作是为 UIKit 提供以下对象：

- **Animator objects.** An animator object is responsible for creating the animations used to reveal or hide a view controller’s view. The transitioning delegate can supply separate animator objects for presenting and dismissing the view controller. Animator objects conform to the [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning) protocol.

- **动画器对象。** 动画器对象负责创建用于显示或隐藏视图控制器视图的动画。转场代理可以提供单独的动画器对象，用于显示和解除视图控制器。动画器对象遵守 [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning) 协议。

- **Interactive animator objects.** An interactive animator object drives the timing of custom animations using touch events or gesture recognizers. Interactive animator objects conform to the [UIViewControllerInteractiveTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning) protocol.

	The easiest way to create an interactive animator is to subclass [UIPercentDrivenInteractiveTransition](https://developer.apple.com/documentation/uikit/uipercentdriveninteractivetransition) class and add event-handling code to your subclass. That class controls the timing of animations created using your existing animator objects. If you create your own interactive animator, you must render each frame of the animation yourself.
	
- **交互式动画器对象。**交互式动画器对象使用触摸事件或手势识别器来驱动自定义动画的开始时机。交互式动画器对象遵守 [UIViewControllerInteractiveTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning) 协议。

	创建交互式动画器的最简单方法是创建 [UIPercentDrivenInteractiveTransition](https://developer.apple.com/documentation/uikit/uipercentdriveninteractivetransition) 类的子类，并将事件处理代码添加到子类中。该类控制使用现有动画器对象创建的动画的时机。如果你创建自己的交互式动画器，则必须自己渲染动画的每一帧。

- **Presentation controller.** A presentation controller manages the presentation style while the view controller is onscreen. The system provides presentation controllers for the built-in presentation styles and you can provide custom presentation controllers for your own presentation styles. For more information about creating a custom presentation controller, see [Creating Custom Presentations](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1).

- **Presentation 控制器。** Presentation 控制器管理当视图控制器在屏幕上时的 presentation 样式。系统提供内置的 presentation 样式的 presentation 控制器，您也可以为自定义的 presentation 控制器提供自己的 presentation 样式。有关创建自定义 presentation 控制器的详细信息，请参见《[创建自定义 Presentations](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1)》。

Assigning a transitioning delegate to the [transitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621421-transitioningdelegate) property of a view controller tells UIKit that you want to perform a custom transition or presentation. Your delegate can be selective about which objects it provides. If you do not provide animator objects, UIKit uses the standard transition animation in the view controller’s [modalTransitionStyle](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621388-modaltransitionstyle) property.

将转场代理分配给视图控制器的 [transitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621421-transitioningdelegate) 属性，告诉 UIKit 您想要执行自定义转场或 presentation。您的代理可以选择提供哪些对象。如果您不提供动画器对象，UIKit 将使用视图控制器的 [modalTransitionStyle](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621388-modaltransitionstyle) 属性中的标准过渡动画。

Figure 10-1 shows the relationship of the transitioning delegate and animator objects to the presented view controller. The presentation controller is used only when the view controller’s [modalPresentationStyle](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621355-modalpresentationstyle) property is set to [UIModalPresentationCustom](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/custom).

图10-1展示了将转场代理与 presented 的视图控制器的动画器对象之间的关系。仅当视图控制器的 modalPresentationStyle](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621355-modalpresentationstyle) 属性设置为 [UIModalPresentationCustom](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle/custom) 时，才会使用 presentation 控制器。

**Figure 10-1** The custom presentation and animator objects **图 10-1** 自定义 presentation 和动画器对象

![image: ../Art/VCPG_custom-presentation-and-animator-objects_10-1_2x.png](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_custom-presentation-and-animator-objects_10-1_2x.png)

For information about how to implement your transitioning delegate, see [Implementing the Transitioning Delegate](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html#//apple_ref/doc/uid/TP40007457-CH16-SW15). For more information about the methods of the transitioning delegate object, see [UIViewControllerTransitioningDelegate Protocol Reference](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate).

有关如何实现转场代理的信息，请参阅《[实现转场代理](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html#//apple_ref/doc/uid/TP40007457-CH16-SW15)》。有关转场代理对象的方法的更多信息，请参阅《[UIViewControllerTransitioningDelegate 协议参考](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)》。

### The Custom Animation Sequence 自定义动画序列

When the [transitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621421-transitioningdelegate) property of a presented view controller contains a valid object, UIKit presents that view controller using the custom animator objects you provide. As it prepares a presentation, UIKit calls the [animationControllerForPresentedController:presentingController:sourceController:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622037-animationcontroller) method of your transitioning delegate to retrieve the custom animator object. If an object is available, UIKit performs the following steps:

当 presented 的视图控制器的 [transitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621421-transitioningdelegate) 属性包含有效对象时，UIKit 会使用您提供的自定义动画器对象来 present 该视图控制器。在准备 presentation 时，UIKit 调用转场代理的 [animationControllerForPresentedController:presentingController:sourceController:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622037-animationcontroller) 方法来检索自定义动画器对象。如果对象可用，UIKit 将执行以下步骤：

1. UIKit calls the transitioning delegate’s [interactionControllerForPresentation:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622050-interactioncontrollerforpresenta) method to see if an interactive animator object is available. If that method returns `nil`, UIKit performs the animations without user interactions.

2. UIKit calls the [transitionDuration:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622032-transitionduration) method of the animator object to get the animation duration.

3. UIKit calls the appropriate method to start the animations:
	- For non-interactive animations, UIKit calls the [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) method of the animator object.
	- For interactive animations, UIKit calls the [startInteractiveTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning/1622028-startinteractivetransition) method of the interactive animator object.

4. UIKit waits for an animator object to call the [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) method of the context transitioning object.

	Your custom animator calls this method after its animations finish, typically in the animation’s completion block. Calling this method ends the transition and lets UIKit know that it can call the completion handler of the [presentViewController:animated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-presentviewcontroller) method and call the animator object’s own [animationEnded:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622059-animationended) method.

>

1. UIKit 调用转场代理的 [interactionControllerForPresentation:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622050-interactioncontrollerforpresenta) 方法来查看交互式动画器对象是否可用。如果该方法返回 `nil`，UIKit 将在没有用户交互的情况下执行动画。

2. UIKit 调用动画器对象的 [transitionDuration:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622032-transitionduration) 方法来获取动画持续时间。

3. UIKit调用适当的方法来开始动画：
	- 对于非交互式动画，UIKit 会调用动画器对象的 [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) 方法。
	- 对于交互式动画，UIKit 会调用交互式动画器对象的 [startInteractiveTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning/1622028-startinteractivetransition) 方法。

4. UIKit 等待动画器对象调用上下文转场对象的 [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) 方法。

	自定义动画器在动画完成后调用此方法，通常是在动画的完成 block 中。调用此方法将结束转场，并使 UIKit 知道它可以调用 [presentViewController:animated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-presentviewcontroller) 方法的完成处理程序，并调用动画器对象自己的 [animationEnded:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622059-animationended) 方法。

When dismissing a view controller, UIKit calls the [animationControllerForDismissedController:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622047-animationcontroller) method of your transitioning delegate and performs the following steps:

在 dismiss 视图控制器时，UIKit 会调用转场代理的 [animationControllerForDismissedController:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622047-animationcontroller) 方法，并执行一下步骤：

1. UIKit calls the transitioning delegate’s [interactionControllerForDismissal:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622030-interactioncontrollerfordismissa) method to see if an interactive animator object is available. If that method returns `nil`, UIKit performs the animations without user interactions.

2. UIKit calls the [transitionDuration:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622032-transitionduration) method of the animator object to get the animation duration.

3. UIKit calls the appropriate method to start the animations:
	- For non-interactive animations, UIKit calls the [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) method of the animator object.
	- For interactive animations, UIKit calls the [startInteractiveTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning/1622028-startinteractivetransition) method of the interactive animator object.

4. UIKit waits for an animator object to call the [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) method of the context transitioning object.

	Your custom animator calls this method after its animation finishes, typically in the animation’s completion block. Calling this method ends the transition and lets UIKit know that it can call the completion handler of the [dismissViewControllerAnimated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621505-dismissviewcontrolleranimated) method and call the animator object’s own [animationEnded:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622059-animationended) method.

>

1. UIKit 调用转场代理的 [interactionControllerForDismissal:](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate/1622030-interactioncontrollerfordismissa) 方法，以查看交互式动画器对象是否可用。如果该方法返回 `nil`，UIKit 将在没有用户交互的情况下执行动画。

2. UIKit 调用动画器对象的 [transitionDuration:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622032-transitionduration) 方法来获取动画持续时间。

3. UIKit调用适当的方法来开始动画：
	- 对于非交互式动画，UIKit 会调用动画器对象的 [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) 方法。
	- 对于交互式动画，UIKit 会调用交互式动画器对象的 [startInteractiveTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning/1622028-startinteractivetransition) 方法。

4. UIKit 等待动画器对象调用上下文转场对象的 [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) 方法。

	自定义动画器在动画完成后调用此方法，通常是在动画的完成 block 中。调用此方法将结束转场，并使 UIKit 知道它可以调用 [dismissViewControllerAnimated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621505-dismissviewcontrolleranimated) 方法的完成处理程序，并调用动画器对象自己的 [animationEnded:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622059-animationended) 方法。

> **IMPORTANT** **重要**
>
> Calling the [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) method at the end of your animations is required. UIKit does not end the transition process, and thereby return control to your app, until you call that method.
> 
> 在你的动画末尾必须调用 [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) 方法。UIKit 直到您调用这个方法以后，才会终止转场过程从而将控制权还给您的 APP。

### The Transitioning Context Object 转场上下文对象

Before a transition animation begins, UIKit creates a transitioning context object and fills it with information about how to perform the animations. The transitioning context object is an important part for your code. It implements the [UIViewControllerContextTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning) protocol and stores references to the view controllers and views involved in the transition. It also stores information about how you should perform the transition, including whether the animation is interactive. Your animator objects need all of this information to set up and execute the actual animations.

在转场动画开始之前，UIKit 会创建一个转场上下文对象，并在其中填充有关如何执行动画的信息。转场上下文对象是代码的重要组成部分。它实现 [UIViewControllerContextTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning) 协议，并存储对转场中涉及的视图控制器和视图的引用。它还存储有关应该如何执行转场的信息，包括动画是否是交互式的。动画器对象需要所有这些信息来设置和执行实际的动画。

> **IMPORTANT** **重要**
>
> When setting up custom animations, always use the objects and data in the transitioning context object rather than any cached information you manage yourself. Transitions can happen in a variety of conditions, some of which might change the animation parameters. The transitioning context object is guaranteed to have the correct information you need to perform the animations, whereas your cached information might be stale by the time your animator’s methods are called.
> 
> 在设置自定义动画时，请始终使用转场上下文对象中的对象和数据，而不是您自己管理的任何缓存信息。转场可能发生在各种条件下，其中一些条件可能会更改动画参数。转场上下文对象保证持有执行动画所需的正确信息，而在调用动画器的方法时，您缓存的信息可能已经过时。

Figure 10-2 shows how the transition context object interacts with other objects. Your animator object receives the object in its [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) method. The animations you create should take place inside the provided container view. For example, when presenting a view controller, add its view as a subview of the container view. The container view might be the window or a regular view but it is always configured to run your animations.

图10-2显示了转场上下文对象如何与其他对象交互。动画器对象在其 [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) 方法中接收对象。您创建的动画应该在提供的容器视图中进行。例如，当 presenting 视图控制器时，将其视图添加为容器视图的子视图。容器视图可能是窗口或常规视图，但它始终被配置为用来运行您的动画。

**Figure 10-2** The transitioning context object **图 10-2** 转场上下文对象

![image: ../Art/VCPG_transitioning-context-object_10-2_2x.png](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_transitioning-context-object_10-2_2x.png)

For more information about the transitioning context object, see [UIViewControllerContextTransitioning Protocol Reference](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning).

有关转场上下文对象的更多信息，请参阅《[UIViewControllerContextTransitioning 协议参考](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning)》。

### The Transition Coordinator 转场协调器

For both the built-in transitions and your custom transitions, UIKit creates a transition coordinator object to facilitate any extra animations that you might need to perform. Aside from the presentation and dismissal of a view controller, transitions can occur when an interface rotation occurs or when the frame of a view controller changes. All of these transitions represent changes to the view hierarchy. The transition coordinator is a way to track those changes and animate your own content at the same time. To access the transition coordinator, get the object in the [transitionCoordinator](https://developer.apple.com/documentation/uikit/uiviewcontroller/1619294-transitioncoordinator) property of the affected view controller. A transition coordinator exists only for the duration of the transition.

无论是内置转场和自定义转场，UIKit 都会创建一个转场协调器对象，以方便您执行任何可能需要执行的额外动画。除了视图控制器的 presentation 和 dismissal 之外，当界面发生旋转或视图控制器的框架发生变化时，也可能发生转场。所有这些转场都表示对视图层次结构的更改。转场协调器是一种跟踪这些更改并同时为自己的内容设置动画的方法。要访问转场协调器，请获取受影响的视图控制器的 [transitionCoordinator](https://developer.apple.com/documentation/uikit/uiviewcontroller/1619294-transitioncoordinator) 属性中的对象。转场协调器仅在转场期间存在。

Figure 10-3 shows the relationship of the transition coordinator to the view controllers involved in a presentation. Use the transition coordinator to get information about the transition and to register animation blocks that you want performed at the same time as the transition animations. Transition coordinator objects conform to the [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext) protocol, which provides timing information, information about the animation’s current state, and the views and view controllers involved in the transition. When your animation blocks are executed, they similarly receive a context object with the same information.

图10-3显示了转场协调器与 presentation 中涉及的视图控制器之间的关系。使用转场协调器可以获取有关转场的信息，并注册希望与转场动画同时执行的动画 block。转场协调器对象遵守 [UIViewControllerTransitionCoordinatorContext](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext) 协议，该协议提供时机信息、有关动画当前状态的信息以及转场中涉及的视图和视图控制器。执行动画 block 时，它们同样会接收到具有相同信息的上下文对象。

**Figure 10-3** The transition coordinator objects  **图 10-3** 转场协调器对象

![image: ../Art/VCPG_transition-coordinator-objects_10-3_2x.png](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_transition-coordinator-objects_10-3_2x.png)

For more information about the transition coordinator object, see [UIViewControllerTransitionCoordinator Protocol Reference](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator). For information about the contextual information that you can use to configure your animations, see [UIViewControllerTransitionCoordinatorContext Protocol Reference](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext).

有关转场协调器对象的更多信息，请参阅《[UIViewControllerTransitionCoordinator 协议参考](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinator)》。有关可用于配置动画的上下文信息的信息，请参阅《[UIViewControllerTransitionCoordinatorContext 协议参考](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioncoordinatorcontext)》。

## Presenting a View Controller Using Custom Animations 使用自定义动画 present 视图控制器

To present a view controller using custom animations, do the following in an action method of your existing view controllers:

要使用自定义动画 present 视图控制器，请在已有的视图控制器的操作方法中执行以下操作：

1. Create the view controller that you want to present.
2. Create your custom transitioning delegate object and assign it to the view controller’s [transitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621421-transitioningdelegate) property. The methods of your transitioning delegate should create and return your custom animator objects when asked.
3. Call the [presentViewController:animated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-presentviewcontroller) method to present the view controller.

>

1. 创建要 present 的视图控制器。
2. 创建自定义转场代理对象，并将其分配给视图控制器的 [transitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621421-transitioningdelegate) 属性。转场代理的方法应该在被要求时创建并返回自定义动画器对象。
3. 调用 [presentViewController:animated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-presentviewcontroller) 方法来 present 视图控制器。

When you call the [presentViewController:animated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-presentviewcontroller) method, UIKit initiates the presentation process. Presentations start during the next run loop iteration and continue until your custom animator calls the [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) method. Interactive transitions allow you to process touch events while the transition is ongoing, but noninteractive transitions run for the duration specified by the animator object.

当您调用 [presentViewController:animated:completion:](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-presentviewcontroller) 方法时，UIKit 会初始化 presentation 过程。Presentation 从下一次运行循环迭代开始，一直持续到您的自定义动画器调用 [completeTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrollercontexttransitioning/1622042-completetransition) 方法时。交互式转场允许您在转场进行时处理触摸事件，但非交互式转换仅在动画器对象指定的持续时间内运行。

## Implementing the Transitioning Delegate 实现转场代理

The purpose of the transitioning delegate is to create and return your custom objects. Listing 10-1 shows how simple the implementation of your transitioning methods can be. This example creates and returns a custom animator object. Most of the actual work is handled by the animator object itself.

转场代理的目的是创建和返回自定义对象。代码10-1显示了转场方法的实现有多简单。这个例子创建并返回一个自定义的动画器对象。大多数实际工作都是由动画器对象自身处理的。

**Listing 10-1** Creating an animator object **代码10-1** 创建动画器对象

```
- (id<UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
    MyAnimator* animator = [[MyAnimator alloc] init];
    return animator;
}
```

The other methods of your transitioning delegate can be as simple as the one in the preceding listing. You can also incorporate custom logic to return different animator objects based on the current state of your app. For more information about the methods of the transitioning delegate, see [UIViewControllerTransitioningDelegate Protocol Reference](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate).

转场代理的其他方法可以和前面代码中的方法一样简单。您还可以结合自定义逻辑，根据应用程序的当前状态返回不同的动画器对象。有关转场代理方法的更多信息，请参阅《[UIViewControllerTransitioningDelegate 协议参考](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)》。

## Implementing Your Animator Objects 实现动画器对象

An animator object is any object that adopts the [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning) protocol. An animator object creates animations that execute over a fixed period of time. The key to an animator object is its [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) method, which you use to create the actual animations. The animation process is roughly divided into the following segments:

动画器对象是指采用  [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning) 协议的任何对象。动画器对象创建在固定时间段内执行的动画。动画器对象的关键是其 [animateTransition:](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning/1622061-animatetransition) 方法，用于创建实际动画。动画过程大致分为以下几个部分：

1. Getting the animation parameters.
2. Creating the animations using Core Animation or `UIView` animation methods.
3. Cleaning up and completing the transition.

>

1. 获取动画参数。
2. 使用 Core Animation 或 `UIView` 动画方法创建动画。
3. 清理并完成转场。

### Getting the Animation Parameters 获取动画参数

The context transitioning object passed to your `animateTransition:` method contains the data to use when performing your animations. Never use your own cached information or fetch information from your view controllers when you can get more up-to-date information from the context transitioning object. Presenting and dismissing view controllers sometimes involves objects outside of your view controllers. For example, a custom presentation controller might add a background view as part of a presentation. The context transitioning object takes extra views and objects into account and provides you with the correct views to animate.

传递给 `animateTransition:` 方法的上下文转场对象中包含执行动画时要使用的数据。当您可以从上下文转场对象中获取更多最新信息时，千万不要使用自己的缓存信息或从视图控制器中获取信息。显示和取消显示视图控制器有时会涉及视图控制器之外的对象。例如，自定义演示控制器可能会添加背景视图作为演示的一部分。上下文转场对象会考虑更多的视图和对象，并为您提供正确的视图以设置动画。

- Call the `viewControllerForKey:` method twice to get the "from” and “to” view controller’s involved in the transition. Never assume that you know which view controllers are taking part in a transition. UIKit might change the view controllers while adapting to a new trait environment or in response to a request from your app.

- 调用 `viewControllerForKey:` 方法两次，以获取转场中涉及的 “from” 和 “to” 视图控制器。永远不要假设您知道哪些视图控制器正在参与转场。在适应新环境或者响应 app 请求时，UIKit 可能改变视图控制器。

- Call the `containerView` method to get the superview for the animations. Add all key subviews to this view. For example, during a presentation, add the presented view controller’s view to this view.

- 调用 `containerView` 方法来获取动画的父视图。将所有关键子视图添加到此视图上。例如，在 presentation 期间，将 presented 的视图控制器的视图添加到此视图中。

- Call the `viewForKey:` method to get the view to be added or removed. A view controller’s view might not be the only one added or removed during a transition. A presentation controller might insert views into the hierarchy that must also be added or removed. The `viewForKey:` method returns the root view that contains everything you need to add or remove.

- 调用 `viewForKey:` 方法来获取要添加或删除的视图。视图控制器的视图可能不是在转场过程中添加或删除的唯一视图。Presentation 控制器可能会将一些视图插入层次结构中，这些视图也必须添加或删除。`viewForKey:` 方法返回包含需要添加或删除的所有内容的根视图。

- Call the `finalFrameForViewController:` method to get the final frame rectangle for the view being added or removed.

- 调用 `finalFrameForViewController:` 方法来获取要添加或删除的视图的最终框架矩形。

The context transitioning object uses “from” and “to” nomenclature to identify the view controllers, views, and frame rectangles involved in a transition. The “from” view controller is always the one whose view is onscreen at the beginning of the transition, and the “to” view controller is the one whose view will be visible at the end of the transition. As you can see in Figure 10-4 , the “from” and “to” view controllers swap positions between a presentation and a dismissal.

上下文转场对象使用 “from” 和 “to” 命名法来标识转换中涉及的视图控制器、视图和框架矩形。“from” 视图控制器始终是在转场开始时其视图在屏幕上的控制器，而 “to” 视图控制器是在转场结束时其视图可见的控制器。如图10-4所示，“from” 和 “to” 视图控制器在 presentation 和 dismissal 之间交换位置。

**Figure 10-4** The from and to objects **图10-4** from 和 to 对象

![image: ../Art/VCPG_from-and-to-objects_10-4_2x.png](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_from-and-to-objects_10-4_2x.png)

Swapping the values makes it easier to write a single animator that handles both presentations and dismissals. When you design your animator, all you have to do is include a property to know whether it is animating a presentation or dismissal. The only required difference between the two is the following:

交换这两个值可以很容易地编写一个同时处理 presentation 和 dismissal 的动画器。当你设计你的动画器时，你所要做的就是包括一个属性，以知道它是在动画 presentation 还是 dismissal。两者之间唯一需要的区别如下：

- For a presentation, add the “to” view to the container view hierarchy.
- For a dismissal, remove the “from” view from the container view hierarchy.

- 对于 presentation，请将 “to” 视图添加到容器视图层次结构中。
- 对于 dismissal，请从容器视图层次结构中删除 “from” 视图。

### Creating the Transition Animations 创建转场动画

During a typical presentation, the view belonging to the presented view controller is animated into place. Other views may be animated as part of your presentation, but the main target of your animations is always the view being added to the view hierarchy.

在典型的 presentation 过程中，属于 presented 的视图控制器的视图以动画的形式放入。其他视图可能会作为 presentation 的一部分添加动画，但动画的主要目标始终是添加到视图层次结构中的视图。

When animating the main view, the basic actions you take to configure your animations are the same. You fetch the objects and data you need from the transitioning context object and use that information to create your actual animations.

设置主视图动画时，配置动画所采取的基本操作是相同的。您可以从转场上下文对象中获取所需的对象和数据，并使用这些信息来创建实际的动画。

- Presentation animations:
	- Use the `viewControllerForKey:` and `viewForKey:` methods to retrieve the view controllers and views involved in the transition.
	- Set the starting position of the “to” view. Set any other properties to their starting values as well.
	- Get the end position of the “to” view from the `finalFrameForViewController:` method of the context transitioning context.
	- Add the “to” view as a subview of the container view.
	- Create the animations.
		- In your animation block, animate the “to” view to its final location in the container view. Set any other properties to their final values as well.
		- In the completion block, call the `completeTransition:` method, and perform any other cleanup.

- Presentation 动画：
	- 使用 `viewControllerForKey:` 和 `viewForKey:` 方法检索转场中涉及的视图控制器和视图。
	- 设置 “to” 视图的起始位置。将任何其他属性也设置为其起始值。
	- 从上下文转场上下文的 `finalFrameForViewController:` 方法获取 “to” 视图的结束位置。
	- 将 “to” 视图添加为容器视图的子视图。
	- 创建动画。
		- 在动画 block 中，将 “to” 视图设置为其在容器视图中的最终位置。将任何其他属性也设置为其最终值。
		- 在完成 block 中，调用 `completeTransition:` 方法，并执行任何其他清理。

- Dismissal animations:
	- Use the `viewControllerForKey:` and `viewForKey:` methods to retrieve the view controllers and views involved in the transition.
	- Compute the end position of the “from” view. This view belongs to the presented view controller that is now being dismissed.
	- Add the “to” view as a subview of the container view.
	- During a presentation, the view belonging to the presenting view controller is removed when the transition completes. As a result, you must add that view back to the container during a dismissal operation.
	- Create the animations.
		- In your animation block, animate the “from” view to its final location in the container view. Set any other properties to their final values as well.
		- In the completion block, remove the “from” view from your view hierarchy and call the completeTransition: method. Perform any other cleanup as needed.

- Dismissal 动画：
	- 使用 `viewControllerForKey:` 和 `viewForKey:` 方法检索转场中涉及的视图控制器和视图。
	- 计算 “from” 视图的结束位置。此视图属于 presented 的视图控制器，该视图控制器现在正在被 dismissed。
	- 将 “to” 视图添加为容器视图的子视图。
	- 在 presentation 期间，属于 presenting 视图控制器的视图在转场完成时被移除。因此，必须在 dismissal 操作期间将该视图添加回容器。
	- 创建动画。
		- 在动画 block 中，将 “from” 视图设置为其在容器视图中的最终位置。将任何其他属性也设置为其最终值。
		- 在完成 block 中，从视图层次结构中删除 “from” 视图，并调用 `completeTransition:` 方法。根据需要执行任何其他清理。

Figure 10-5 shows a custom presentation and dismissal transition that animates its view diagonally. During a presentation, the presented view starts offscreen and animates diagonally up and to the left until it is visible. During a dismissal, the view reverses its direction and animates down and to the right until it is offscreen once again.

图10-5显示了一个自定义的 presentation 和 dismissal 转场，它给视图设置了一个对角线方向的动画。在 presentation 过程中， presented 的视图从屏幕外开始，向左上角动画进入，直到可见为止。在 dismissal 过程中，视图会反转方向并向右下移动，直到它再次离开屏幕。

**Figure 10-5** A custom presentation and dismissal **图 10-5** 自定义 presentation 和 dismissal

![image: ../Art/VCPG_custom-presentation-and-dismissal_10-5_2x.png](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_custom-presentation-and-dismissal_10-5_2x.png)

Listing 10-2 shows how you would implement the transitions shown in Figure 10-5. After retrieving the objects needed for the animation, the `animateTransition:` method computes the frame rectangle of the affected view. During a presentation, the presented view is represented by the `toView` variable. In a dismissal, the dismissed view is represented by the `fromView` variable. The `presenting` property is a custom property on the animator object itself that the transitioning delegate sets to an appropriate value when it creates the animator.

代码 10-2 展示了如何实现图 10-5 中所示的转场。在检索动画所需的对象后，`animateTransition:` 方法将计算受影响视图的框架矩形。在 presentation 过程中，演示的视图由 `toView` 变量表示。在 dismissal 过程中，被 dismissed 的视图由 `fromView` 变量表示。`presenting ` 属性是动画器对象本身的自定义属性，转场代理在创建动画器时将其设置为适当的值。

**Listing 10-2** Animations for implementing a diagonal presentation and dismissal **代码 10-2** 实现对角线 presentation 和 dismissal 的动画

```
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // Get the set of relevant objects.
    // 获取相关对象集。
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext
            viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC   = [transitionContext
            viewControllerForKey:UITransitionContextToViewControllerKey];
 
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
 
    // Set up some variables for the animation.
    // 为动画设置一些变量。
    CGRect containerFrame = containerView.frame;
    CGRect toViewStartFrame = [transitionContext initialFrameForViewController:toVC];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect fromViewFinalFrame = [transitionContext finalFrameForViewController:fromVC];
 
    // Set up the animation parameters.
    // 设置动画参数。
    if (self.presenting) {
        // Modify the frame of the presented view so that it starts
        // offscreen at the lower-right corner of the container.
        // 修改 presented 的视图的框架，使其从屏幕外容器右下角开始。
        toViewStartFrame.origin.x = containerFrame.size.width;
        toViewStartFrame.origin.y = containerFrame.size.height;
    }
    else {
        // Modify the frame of the dismissed view so it ends in
        // the lower-right corner of the container view.
        //  修改被 dismissed 的视图的框架，使其在屏幕外容器右下角结束。
        fromViewFinalFrame = CGRectMake(containerFrame.size.width,
                                      containerFrame.size.height,
                                      toView.frame.size.width,
                                      toView.frame.size.height);
    }
 
    // Always add the "to" view to the container.
    // And it doesn't hurt to set its start frame.
    // 始终要添加 “to” 视图到容器上。并且最好设定上它的开始框架。
    [containerView addSubview:toView];
    toView.frame = toViewStartFrame;
 
    // Animate using the animator's own duration value.
    // 使用动画器自己的 duration 值执行动画。
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         if (self.presenting) {
                             // Move the presented view into position.
                             // 将 presented 的视图移动到相应位置。
                             [toView setFrame:toViewFinalFrame];
                         }
                         else {
                             // Move the dismissed view offscreen.
                             // 将被 dismissed 的视图移动到屏幕外。
                             [fromView setFrame:fromViewFinalFrame];
                         }
                     }
                     completion:^(BOOL finished){
                         BOOL success = ![transitionContext transitionWasCancelled];
 
                         // After a failed presentation or successful dismissal, remove the view.
                         // 在 presentation 失败或 dismissal 取消后，请删除该视图。
                         if ((self.presenting && !success) || (!self.presenting && success)) {
                             [toView removeFromSuperview];
                         }
 
                         // Notify UIKit that the transition has finished
                         // 通知 UIKit 转场完成了。
                         [transitionContext completeTransition:success];
                     }];
 
}
```

### Cleaning Up After the Animations 在动画之后清理

At the end of a transition animation, it is critical that you call the `completeTransition:` method. Calling that method tells UIKit that the transition is complete and that the user may begin to use the presented view controller. Calling that method also triggers a cascade of other completion handlers, including the one from the `presentViewController:animated:completion:` method and the animator object’s own `animationEnded:` method. The best place to call the `completeTransition:` method is in the completion handler of your animation block.

在转场动画结束时，调用 `completeTransition:` 方法至关重要。调用该方法告诉 UIKit 转场已完成，用户可以开始使用 presented 的视图控制器。调用该方法还会触发其他完成处理程序的连锁反应，包括 `presentViewController:animated:complete:` 方法和动画器对象自己的 `animationEnded:` 方法。调用 `completeTransition:` 方法的最佳位置是在动画 block 的完成处理程序中。

Because transitions can be canceled, you should use the return value of the `transitionWasCancelled` method of the context object to determine what cleanup is required. When a presentation is canceled, your animator must undo any modifications it made to the view hierarchy. A successful dismissal requires similar actions.

因为转场可以取消，所以应该使用上下文对象的 `transitionWasCancelled` 方法的返回值来确定需要进行哪些清理。取消 presentation 时，动画器必须撤消对视图层次结构所做的任何修改。成功的 dismissal 需要采取类似的行动。

## Adding Interactivity to Your Transitions 为转场添加交互

The easiest way to make your animations interactive is to use a `UIPercentDrivenInteractiveTransition` object. A `UIPercentDrivenInteractiveTransition` object works with your existing animator objects to control the timing of their animations. It does this using a completion percentage value that you provide. All you have to do is set up the event-handling code needed to compute that completion percentage value and update it as each new event arrives.

使动画具有交互性的最简单方法是使用 `UIPercentDrivenInteractiveTransition` 对象。`UIPercentDrivenInteractiveTransition` 对象与现有的动画器对象一起工作，以控制其动画的时机。它使用您提供的完成百分比值来实现这一点。您所要做的就是设置用于计算完成百分比值的事件处理代码，并在每个新事件到达时更新它。

You can use a `UIPercentDrivenInteractiveTransition` class with or without subclassing. If you subclass, use the init method of your subclass (or the `startInteractiveTransition:` method) to perform a one-time setup of your event-handling code. After that, use your custom event-handling code to compute a new completion percentage value and call the `updateInteractiveTransition:` method. When your code determines that the transition should complete, call the `finishInteractiveTransition` method.

可以使用 `UIPercentDrivenInteractiveTransition` 的子类，也可以不使用子类。如果您是子类，请使用子类的 `init` 方法（或 `startInteractiveTransition:` 方法）来一次性设置事件处理代码。之后，使用自定义事件处理代码计算新的完成百分比值，并调用 `updateInteractiveTransition:` 方法。当代码确定转场应该完成时，调用 `finishInteractiveTransition` 方法。

Listing 10-3 shows a custom implementation of the `startInteractiveTransition:` method of a `UIPercentDrivenInteractiveTransition` subclass. This method sets up a pan-gesture recognizer to track touch events and installs that gesture recognizer on the container view for the animations. It also saves a reference to the transition context for later use.

代码 10-3 显示了 `UIPercentDrivenInteractiveTransition` 子类的 `startInteractiveTransition` 方法的自定义实现。此方法设置了平移手势识别器来跟踪触摸事件，并将该手势识别器安装在动画的容器视图上。它还保存了转场转换上下文的引用，以供以后使用。

**Listing 10-3** Configuring a percent-driven interactive animator **代码 10-3** 配置按百分比驱动的交互式动画器

```
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
   // Always call super first.
   // 始终首先调用 super 方法。
   [super startInteractiveTransition:transitionContext];
 
   // Save the transition context for future reference.
   // 保存转场上下文，未来用到。
   self.contextData = transitionContext;
 
   // Create a pan gesture recognizer to monitor events.
   // 创建一个平移手势识别器来检测事件。
   self.panGesture = [[UIPanGestureRecognizer alloc]
                        initWithTarget:self action:@selector(handleSwipeUpdate:)];
   self.panGesture.maximumNumberOfTouches = 1;
 
   // Add the gesture recognizer to the container view.
   // 把手势识别器添加到容器视图上。
   UIView* container = [transitionContext containerView];
   [container addGestureRecognizer:self.panGesture];
}
```

A gesture recognizer calls its action method for each new event that arrives. Your implementation of the action method can use the gesture recognizer’s state information to determine whether the gesture succeeded, failed, or is still in progress. At the same time, you can use the latest touch event information to compute a new percentage value for the gesture.

手势识别器在每个新事件到达时调用其动作方法。动作方法的实现可以使用手势识别器的状态信息来确定手势是成功、失败还是仍在进行中。同时，您可以使用最新的触摸事件信息来计算手势的新百分比值。

Listing 10-4 shows the method called by the pan gesture recognizer configured in Listing 10-3. As new events arrive, this method uses the vertical travel distance to compute the completion percentage of the animation. When the gesture ends, the method finishes the transition.

代码 10-4 展示了代码 10-3 中配置的平移手势识别器所调用的方法。随着新事件的到来，此方法使用垂直行进距离来计算动画的完成百分比。当手势结束时，该方法将完成转场。

**Listing 10-4** Using events to update the animation progress **代码 10-4** 使用事件更新动画进度

```
-(void)handleSwipeUpdate:(UIGestureRecognizer *)gestureRecognizer {
    UIView* container = [self.contextData containerView];
 
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        // Reset the translation value at the beginning of the gesture.
        // 在手势开始时重置 translation 值。
        [self.panGesture setTranslation:CGPointMake(0, 0) inView:container];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // Get the current translation value.
        // 获取当前 translation 值。
        CGPoint translation = [self.panGesture translationInView:container];
 
        // Compute how far the gesture has travelled vertically,
        //  relative to the height of the container view.
        // 计算手势在垂直方向上行进的距离相对于容器视图的高度的比例。
        CGFloat percentage = fabs(translation.y / CGRectGetHeight(container.bounds));
 
        // Use the percentage value to update the interactive animator.
        // 使用 percentage 值更新交互式动画器。
        [self updateInteractiveTransition:percentage];
    }
    else if (gestureRecognizer.state >= UIGestureRecognizerStateEnded) {
        // Finish the transition and remove the gesture recognizer.
        // 完成转场并移除手势识别器。
        [self finishInteractiveTransition];
        [[self.contextData containerView] removeGestureRecognizer:self.panGesture];
    }
}
```

> **NOTE** **注意**
>
> The value you compute represents the completion percentage for the entire length of the animation. For interactive animations, you might want to avoid nonlinear effects such as initial velocities, damping values, and nonlinear completion curves in the animations themselves. Such effects tend to decouple the touch location of events from the movement of any underlying views.
> 
> 计算的值代表了完成整个动画长度的百分比。对于交互式动画，可能需要避免动画本身中的非线性效果，例如初始速度、阻尼值和非线性完成曲线。这样的效果往往会将事件的触摸位置与任何潜在视图的移动解耦。

## Creating Animations that Run Alongside a Transition 创建与转场同时运行的动画

View controllers involved in a transition can perform additional animations on top of any presentation or transition animations. For example, a presented view controller might animate its own view hierarchy during the transition and add motion effects or other visual feedback while the transition occurs. Any object can create animations, as long as it is able to access the `transitionCoordinator` property of the presented or presenting view controller. The transition coordinator exists only while a transition is in progress.

转场中涉及的视图控制器可以在任何 presentation 或转场动画之上执行附加动画。例如， presented 的视图控制器可能会在转场期间为其自己的视图层次设置动画，并在转场发生时添加运动效果或其他视觉反馈。任何对象都可以创建动画，只要它能够访问 presented 或 presenting 视图控制器的 `transitionCoordinator` 属性即可。只有在进行转场时，转场协调器才存在。

To create animations, call `the animateAlongsideTransition:completion:` or `animateAlongsideTransitionInView:animation:completion:` method of the transition coordinator. The blocks you provide are stored until the transition animations begin, at which point they are executed along with the rest of the transition animations.

若要创建动画，请调用转场协调器的 `animateAlonsideTransition:completion:` 或 `animateAlongideTransitionInView:animation:completion:` 方法。您提供的 block 将被存储，直到转场动画开始，此时它们将与其他转场动画一起执行。

## Using a Presentation Controller with Your Animations 在动画中使用 presentation 控制器

For custom presentations, you can provide your own presentation controller to give the presented view controller a custom appearance. Presentation controllers manage any custom chrome that is separate from the view controller and its contents. For example, a dimming view placed behind the view controller’s view would be managed by a presentation controller. The fact that it does not manage a specific view controller’s view means that you can use the same presentation controller with any view controller in your app.

对于自定义 presentations，您可以提供自己的 presentation 控制器，为 presented 视图控制器提供自定义外观。Presentation 控制器管理任何自定义 chrome，它与视图控制器及其内容是分离的。例如，放置在视图控制器的视图后面的调光视图将由 presentation 控制器管理。事实上，它不管理特定视图控制器的视图，这意味着您可以将同一 presentation 控制器与应用程序中的任何视图控制器一起使用。

You provide a custom presentation controller from the transitioning delegate of the presented view controller. (The `modalTransitionStyle` property of the view controller must be `UIModalPresentationCustom`.) The presentation controller operates in parallel with any animator objects. As the animator objects animate the view controller’s view into place, the presentation controller animates any additional views into place. At the end of a transition, the presentation controller has an opportunity to perform any final adjustments to the view hierarchy.

您可以从 presented 视图控制器的转场代理中提供自定义 presentation 控制器。（视图控制器的 `modalTransitionStyle` 属性必须是 `UIModalPresentationCustom`。）Presentation 控制器与任何动画器对象并行运作。当动画器对象将视图控制器的视图动画化到适当位置时，presentation 控制器将任何其他视图动画化到位。在转场结束时，presentation 控制器有机会对视图层次结构执行任何最终调整。

For information about how to create a custom presentation controller, see [Creating Custom Presentations](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1).

有关如何创建自定义 presentation 控制器的信息，请参见《[创建自定义 Presentations](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1)》。