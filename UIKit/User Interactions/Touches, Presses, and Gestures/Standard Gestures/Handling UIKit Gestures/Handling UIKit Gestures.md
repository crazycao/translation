# Handling UIKit Gestures

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures)

>__Framework__
>
> UIKit

Use gesture recognizers to simplify touch handling and create a consistent user experience.

使用手势识别器简化触摸处理并创建一致的用户体验。

## Overview 概览

Gesture recognizers are the simplest way to handle touch or press events in your views. You can attach one or more gesture recognizers to any view. Gesture recognizers encapsulate all of the logic needed to process and interpret incoming events for that view and match them to a known pattern. When a match is detected, the gesture recognizer notifies its assigned target object, which can be a view controller, the view itself, or any other object in your app.

手势识别器是处理视图中的触摸或按下事件的最简单方法。可以将一个或多个手势识别器添加到任何视图。手势识别器封装了为该视图处理和解释传入事件所需的所有逻辑，并将它们与已知模式相匹配。当检测到匹配时，手势识别器会通知其指定的目标对象，该对象可以是视图控制器、视图本身或应用程序中的任何其他对象。

Gesture recognizers use the target-action design pattern to send notifications. When the [UITapGestureRecognizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer) object detects a single-finger tap in the view, it calls an action method of the view’s view controller, which you use to provide a response.

手势识别器使用目标动作设计模式发送通知。当 [UITapgestureRecognitizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer) 对象检测到视图中的单指点击时，它将调用视图的视图控制器的动作方法，你可以使用该方法提供响应。

Figure 1 Gesture recognizer notifying its target 图1 手势识别器通知它的目标

![A diagram demonstrating how a gesture recognizer links user interactions with your view controller action methods.](https://docs-assets.developer.apple.com/published/7c21d852b9/0c8c5e29-c846-4a16-988b-3d809eafbb6b.png)

Gesture recognizers come in two types: discrete and continuous. A **discrete gesture recognizer** calls your action method exactly once after the gesture is recognized. After its initial recognition criteria are met, a **continuous gesture recognizer** performs calls your action method many times, notifying you whenever the information in the gesture's event changes. For example, a [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer) object calls your action method each time the touch position changes.

手势识别器有两种类型：离散的和连续的。一个**离散的手势识别器**在手势被识别后只会调用你的动作方法一次。而**连续的手势识别器**满足初始识别条件后，会多次调用您的动作方法，并在手势事件中的信息发生变化时通知您。例如，每次触摸位置更改时，[UIPangestureRecognitor](https://developer.apple.com/documentation/uikit/uipangesturerecognizer) 对象都会调用您的动作方法。

Interface Builder includes objects for each of the standard UIKit gesture recognizers. It also includes a custom gesture recognizer object that you can use to represent your custom [UIGestureRecognizer](https://developer.apple.com/documentation/uikit/uigesturerecognizer) subclasses.

Interface Builder 包含了所有标准 UIKit 手势识别器的对象。它还包含一个自定义手势识别器对象，可用于表示自定义 [UIgestureRecognitor](https://developer.apple.com/documentation/uikit/uigesturerecognizer) 子类。

## Configuring a gesture recognizer 配置手势识别器

To configure a gesture recognizer:

1. In your storyboard, drag the gesture recognizer onto your view.
2. Implement an action method to be called when the gesture is recognized; see Listing 1.
3. Connect your action method to the gesture recognizer.

要配置手势识别器：

1. 在你的故事板中，将手势识别器拖到视图上。
2. 实现一个当手势被识别时要调用的动作方法；见 代码1。
3. 把动作方法连接到手势识别器上。

You can create this connection in Interface Builder by right-clicking the gesture recognizer and connecting its Sent Action selector to the appropriate object in your interface. You can also configure the action method programmatically using the [addTarget(_:action:)](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624230-addtarget) method of the gesture recognizer.

可以在Interface Builder中创建此连接，通过右键单击手势识别器并将其 Sent Action 选择器连接到界面中的相应对象上。您也可以使用手势识别器的 [addTarget(_:action:)](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624230-addtarget) 方法以编程方式配置动作方法。

Listing 1 shows the generic format for the action method of a gesture recognizer. If you prefer, you can change the parameter type to match a specific gesture recognizer subclass.

代码1显示了手势识别器动作方法的通用格式。如果愿意，可以更改参数类型以匹配特定的手势识别器子类。

Listing 1 Gesture recognizer action methods 代码1 手势识别器动作方法

```
@IBAction func myActionMethod(_ sender: UIGestureRecognizer)
```

## Responding to Gestures 响应手势

The action method associated with a gesture recognizer provides your app’s response to that gesture. For discrete gestures, your action method is similar to the action method for a button. Once the action method is called, you perform whatever task is appropriate for that gesture. For continuous gestures, your action method can respond to the recognition of the gesture, but it can also track events before the gesture is recognized. Tracking events lets you create a more interactive experience. For example, you might use the updates from a [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer) object to reposition content in your app.

与手势识别器关联的动作方法提供了应用程序对该手势的响应。对于离散手势，您的动作方法类似于按钮的动作方法。调用动作方法后，您将执行对应该手势的任何任务。对于连续手势，您的动作方法可以响应手势的识别，但也可以在识别手势之前跟踪事件。跟踪事件可以让您创建更具交互性的体验。例如，您可以使用 [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer) 对象的更新来重新定位应用程序中的内容。

The [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) property of a gesture recognizer communicates the object’s current state of recognition. For continuous gestures, the gesture recognizer updates the value of this property from [UIGestureRecognizer.State.began](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/began) to [UIGestureRecognizer.State.changed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/changed) to [UIGestureRecognizer.State.ended](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/ended), or to [UIGestureRecognizer.State.cancelled](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/cancelled). Your action methods use this property to determine an appropriate course of action. For example, you might use the began and changed states to make temporary changes to your content, use the ended state to make those changes permanent, and use the cancelled state to discard the changes. Always check the value of the [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) property of a gesture recognizer before taking actions.

手势识别器的 [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) 属性传达对象的当前识别状态。对于连续手势，手势识别器会更新它的这个属性，从  [UIGestureRecognizer.State.began](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/began) 到 [UIGestureRecognizer.State.changed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/changed) 再到 [UIGestureRecognizer.State.ended](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/ended)，或者再到 [UIGestureRecognizer.State.cancelled](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/cancelled)。您的动作方法可以使用此属性来确定动作的相应过程。例如，您可以使用“开始”和“更改”状态对内容进行临时更改，使用“结束”状态使这些更改永久化，以及使用“取消”状态放弃更改。在采取行动之前，请始终检查手势识别器的  [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) 属性值。

For examples of how to handle specific types of gestures, see the following information:

有关如何处理特定类型手势的示例，请参阅以下信息：

- [Handling Tap Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_tap_gestures) 处理点击手势

- [Handling Long-Press Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_long-press_gestures) 处理长按手势

- [Handling Pan Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pan_gestures) 处理平移手势

- [Handling Swipe Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_swipe_gestures) 处理轻扫手势

- [Handling Pinch Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pinch_gestures) 处理捏合手势

- [Handling Rotation Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_rotation_gestures) 处理旋转手势

For more information about gesture recognizer states and how they affect your code, see [Implementing a Custom Gesture Recognizer](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer).

有关手势识别器状态及其如何影响代码的详细信息，请参阅《[实现自定义手势识别器](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer)》。

# Topics 主题

## Gestures 手势

- [Handling Tap Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_tap_gestures) 处理点击手势

  Use brief taps on the screen to implement button-like interactions with your content.
  
  使用屏幕上的简短点击来实现与内容的按钮式交互。

- [Handling Long-Press Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_long-press_gestures) 处理长按手势

  Detect extended duration taps on the screen, and use them to reveal contextually relevant content.
  
  检测屏幕上持续时间较长的点按，并使用它们显示上下文相关的内容。

- [Handling Pan Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pan_gestures) 处理平移手势

  Trace the movement of fingers around the screen, and apply that movement to your content.
  
  跟踪手指在屏幕上的移动，并将该移动应用于您的内容。

- [Handling Swipe Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_swipe_gestures) 处理轻扫手势

  Detect a horizontal or vertical swipe motion on the screen, and use it to trigger navigation through your content.
  
  检测屏幕上的水平或垂直滑动运动，并使用它触发内容导航。

- [Handling Pinch Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pinch_gestures) 处理捏合手势

  Track the distance between two fingers and use that information to scale or zoom your content.
  
  跟踪两个手指之间的距离，并使用该信息缩放内容。

- [Handling Rotation Gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_rotation_gestures) 处理旋转手势

  Measure the relative rotation of two fingers on the screen, and use that motion to rotate your content.
  
  测量屏幕上两个手指的相对旋转，并使用该运动旋转内容。

# See Also 其它参考

## Standard Gestures 标准手势

### [Coordinating Multiple Gesture Recognizers](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/coordinating_multiple_gesture_recognizers)

Discover how to use multiple gesture recognizers on the same view.

### class [UIHoverGestureRecognizer](https://developer.apple.com/documentation/uikit/uihovergesturerecognizer)

A discrete gesture recognizer that interprets pointer movement over a view.

### class [UILongPressGestureRecognizer](https://developer.apple.com/documentation/uikit/uilongpressgesturerecognizer)

A discrete gesture recognizer that interprets long-press gestures.

### class [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer)

A discrete gesture recognizer that interprets panning gestures.

### class [UIPinchGestureRecognizer](https://developer.apple.com/documentation/uikit/uipinchgesturerecognizer)

A discrete gesture recognizer that interprets pinching gestures involving two touches.

### class [UIRotationGestureRecognizer](https://developer.apple.com/documentation/uikit/uirotationgesturerecognizer)

A discrete gesture recognizer that interprets rotation gestures involving two touches.

### class [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer)

A discrete gesture recognizer that interprets panning gestures that start near an edge of the screen.

### class [UISwipeGestureRecognizer](https://developer.apple.com/documentation/uikit/uiswipegesturerecognizer)

A discrete gesture recognizer that interprets swiping gestures in one or more directions.

### class [UITapGestureRecognizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer)

A discrete gesture recognizer that interprets single or multiple taps.

### [Supporting Gesture Interaction in Your Apps](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/supporting_gesture_interaction_in_your_apps)

Enrich your app’s user experience by supporting standard and custom gesture interaction.
