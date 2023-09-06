# Creating Custom Presentations

原文地址：[https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/DefiningCustomPresentations.html#//apple_ref/doc/uid/TP40007457-CH25-SW1)

UIKit separates the content of your view controllers from the way that content is presented and displayed onscreen. Presented view controllers are managed by an underlying presentation controller object, which manages the visual style used to display the view controller’s view. A presentation controller may do the following:

UIKit 将视图控制器的内容与内容在屏幕上的呈现和显示方式分开处理。呈现的视图控制器由底层呈现控制器对象管理，该对象管理用于显示视图控制器视图的视觉样式。呈现控制器可以执行以下操作：

- Set the size of the presented view controller.
- Add custom views to change the visual appearance of the presented content.
- Supply transition animations for any of its custom views.
- Adapt the visual appearance of the presentation when changes occur in the app’s environment.

- 设置显示的视图控制器的大小。
- 添加自定义视图以更改显示内容的视觉外观。
- 为其任何自定义视图提供过渡动画。
- 当应用程序的环境发生变化时，调整演示文稿的视觉外观。

UIKit provides presentation controllers for the standard presentation styles. When you set the presentation style of a view controller to `UIModalPresentationCustom` and provide an appropriate transitioning delegate, UIKit uses your custom presentation controller instead.

UIKit 为标准呈现样式提供呈现控制器。当您将视图控制器的呈现样式设置为 `UIModalPresentationCustom` 并提供适当的转场委托时，UIKit 将使用您的自定义呈现控制器。

## The Custom Presentation Process 自定义呈现过程

When you present a view controller whose presentation style is `UIModalPresentationCustom`, UIKit looks for a custom presentation controller to manage the presentation process. As the presentation progresses, UIKit calls methods of the presentation controller, giving it opportunities to set up any custom views and animate them into position.

当您呈现一个呈现样式为 `UIModalPresentationCustom` 的视图控制器时，UIKit 会寻找自定义的呈现控制器来管理呈现过程。随着呈现的进行，UIKit 调用呈现控制器的方法，使其有机会设置任何自定义视图并将其动画化。

A presentation controller works alongside any animator objects to implement the overall transition. The animator objects animate the view controller’s contents onto the screen and the presentation controller handles everything else. Normally, your presentation controller animates its own views, but you can also override the presentation controller’s presentedView method and let the animator objects animate all or some of those views.

During a presentation, UIKit:

Calls the presentationControllerForPresentedViewController:presentingViewController:sourceViewController: method of the transitioning delegate to retrieve your custom presentation controller

Asks the transitioning delegate for the animator and interactive animator objects, if any

Calls your presentation controller’s presentationTransitionWillBegin method

Your implementation of this method should add any custom views to the view hierarchy and configure the animations for those views.

Gets the presentedView from your presentation controller

The view returned by this method is animated into position by the animator objects. Normally, this method returns the root view of the presented view controller. Your presentation controller can replace that view with a custom background view, as needed. If you do specify a different view, you must embed the root view of the presented view controller into your view hierarchy.

Performs the transition animations

The transition animations include the main ones created by the animator objects and any animations you configured to run alongside the main animations. For information on the transition animations, see The Transition Animation Sequence.

During the animation process, UIKit calls the containerViewWillLayoutSubviews and containerViewDidLayoutSubviews methods of your presentation controller so that you can adjust the layout of your custom views as needed.

Calls the presentationTransitionDidEnd: method when the transition animations finish

During a dismissal, UIKit:

Gets your custom presentation controller from the currently visible view controller

Asks the transitioning delegate for the animator and interactive animator objects, if any

Calls your presentation controller’s dismissalTransitionWillBegin method

Your implementation of this method should add any custom views to the view hierarchy and configure the animations for those views .

Gets the already presentedView from your presentation controller

Performs the transition animations

The transition animations include the main ones created by the animator objects and any animations you configured to run alongside the main animations. For information on the transition animations, see The Transition Animation Sequence.

During the animation process, UIKit calls the containerViewWillLayoutSubviews and containerViewDidLayoutSubviews methods of your presentation controller so that you can remove any custom constraints.

Calls the dismissalTransitionDidEnd: method when the transition animations finish

During the presentation process, The frameOfPresentedViewInContainerView and presentedView methods of your presentation controller may be called several times, so your implementations should return quickly. Also, your implementation of your presentedView method should not try to set up the view hierarchy. The view hierarchy should already be configured by the time the method is called.

演示控制器与任何动画师对象一起工作，以实现整体过渡。动画师对象将视图控制器的内容动画化到屏幕上，演示控制器处理其他一切。通常，演示文稿控制器会为其自己的视图设置动画，但也可以覆盖演示文稿控制器的presentView方法，并让动画师对象为所有或部分视图设置动画。



在演示过程中，UIKit：



调用转换委托的presentationControllerForPresentedViewController:presentingViewController:sourceViewController:方法来检索自定义演示控制器



向过渡代理询问动画师和交互式动画师对象（如果有）



调用演示控制器的presentationTransitionWillBegin方法



此方法的实现应将任何自定义视图添加到视图层次结构中，并为这些视图配置动画。



从演示控制器获取presentView



此方法返回的视图由动画师对象设置动画，使其就位。通常，此方法返回所呈现的视图控制器的根视图。您的演示文稿控制器可以根据需要将该视图替换为自定义背景视图。如果指定了不同的视图，则必须将所呈现的视图控制器的根视图嵌入到视图层次结构中。



执行过渡动画



过渡动画包括由动画师对象创建的主要动画，以及配置为与主要动画一起运行的任何动画。有关过渡动画的信息，请参见过渡动画序列。



在动画过程中，UIKit调用演示控制器的containerViewWillLayoutSubview和containerViewDidLayoutSubviews方法，以便您可以根据需要调整自定义视图的布局。



在过渡动画完成时调用presentationTransitionDidEnd:方法



在解雇期间，UIKit：



从当前可见的视图控制器获取自定义演示文稿控制器



向过渡代理询问动画师和交互式动画师对象（如果有）



调用演示文稿控制器的dissenalTransitionWillBegin方法



此方法的实现应将任何自定义视图添加到视图层次结构中，并为这些视图配置动画。



从演示控制器获取已演示的视图



执行过渡动画



过渡动画包括由动画师对象创建的主要动画，以及配置为与主要动画一起运行的任何动画。有关过渡动画的信息，请参见过渡动画序列。



在动画过程中，UIKit会调用演示控制器的containerViewWillLayoutSubviews和containerViewDidLayoutSubviews方法，以便删除任何自定义约束。



当过渡动画完成时调用dissolalTransitionDidEnd:方法



在演示过程中，演示控制器的frameOfPresentedViewInContainerView和presentedView方法可能会被调用多次，因此您的实现应该很快返回。此外，您的presentedView方法的实现不应试图设置视图层次结构。在调用该方法时，视图层次结构应该已经配置好了。