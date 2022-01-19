# Handling Pan Gestures

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pan_gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pan_gestures)

>__Framework__
>
> UIKit

Trace the movement of fingers around the screen, and apply that movement to your content.

跟踪手指在屏幕上的移动，并将该移动应用于您的内容。

## Overview 概览

A pan gesture occurs any time the user moves one or more fingers around the screen. A screen-edge pan gesture is a specialized pan gesture that originates from the edge of the screen. Use the [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer) class for pan gestures and the [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer) class for screen-edge pan gestures.

每当用户在屏幕上移动一个或多个手指时，就会出现 pan 手势。Screen-edge Pan 手势是一种从屏幕边缘开始的特殊 pan 手势。使用 [UIPanGestureRecognizer](https://developer.apple.com/documentation/uikit/uipangesturerecognizer) 类检测 pan 手势，而使用 [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer) 类检测 screen-edge pan 手势。

You can attach a gesture recognizer in one of these ways:

您可以通过以下方式之一添加手势识别器：

- Programmatically. Call the [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) method of your view.

  编程方式。调用视图的  [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) 方法。
  
- In Interface Builder. Drag the appropriate object from the library and drop it onto your view.

  在界面生成器中。从库中拖动适当的对象并将其放到视图中。

![A diagram demonstrating a single-finger pan gesture](https://docs-assets.developer.apple.com/published/7c21d852b9/92edf0c4-8d94-469b-b81d-c00a20e74f5e.png)

Use pan gesture recognizers for tasks that require you to track the movement of the user’s fingers onscreen. You might use a pan gesture recognizer to drag objects around in your interface or update their appearance based on the position of the user’s finger. Pan gestures are continuous, so your action method is called whenever the touch information changes, giving you a chance to update your content.

对于需要在屏幕上跟踪用户手指移动的任务，请使用 pan 手势识别器。您可以使用 pan 手势识别器在界面中拖动对象，或根据用户手指的位置更新其外观。Pan 手势是连续的，因此每当触摸信息发生变化时都会调用动作方法，让您有机会更新内容。

A pan gesture recognizer enters the [UIGestureRecognizer.State.began](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/began) state as soon as the required amount of initial movement is achieved. After that initial change, subsequent changes cause the gesture recognizer to enter the [UIGestureRecognizer.State.changed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/changed) state. When the user’s fingers lift from the screen, the gesture recognizer enters the [UIGestureRecognizer.State.ended](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/ended) state.

当达到所需初始移动量时，pan 手势识别器就会进入 [UIGestureRecognizer.State.began](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/began) 状态。该初始变化以后，后续的变化则会让手势识别器进入 [UIGestureRecognizer.State.changed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/changed) 状态。当用户的所有手指从屏幕上抬起时，手势识别器进入 [UIGestureRecognizer.State.ended](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/ended) 状态。

To simplify tracking, use the pan gesture recognizer’s [translation(in:)](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621207-translation) method to get the distance that the user’s finger has moved from the original touch location. At the beginning of the gesture, a pan gesture recognizer stores the initial point of contact for the user’s fingers. (If the gesture involves multiple fingers, the gesture recognizer uses the center point of the set of touches.) Each time the fingers move, the [translation(in:)](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621207-translation) method reports the distance from the original location.

为了简化跟踪，请使用 pan 手势识别器的 [translation(in:)](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621207-translation) 方法获取用户的手指从原始触摸位置移动的距离。在手势开始时，pan 手势识别器会存储用户手指的初始接触点。（如果手势涉及多个手指，手势识别器将使用触摸集合的中心点。）每次手指移动， [translation(in:)](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621207-translation) 方法都会报告到原始位置的距离。

Listing 1 shows an action method used to drag a view around the screen. When the gesture begins, this method saves the initial position of the view. It then updates the position of the view based on the movement of the user's fingers.

清单1展示了一个用于在屏幕上拖动视图的操作方法。当手势开始时，此方法保存视图的初始位置。然后，它根据用户手指的移动更新视图的位置。

**Listing 1** Dragging a view around the screen **清单1** 在屏幕上拖动视图

```
var initialCenter = CGPoint()  // The initial center point of the view.
@IBAction func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {   
   guard gestureRecognizer.view != nil else {return}
   let piece = gestureRecognizer.view!
   // Get the changes in the X and Y directions relative to
   // the superview's coordinate space.
   let translation = gestureRecognizer.translation(in: piece.superview)
   if gestureRecognizer.state == .began {
      // Save the view's original position. 
      self.initialCenter = piece.center
   }
      // Update the position for the .began, .changed, and .ended states
   if gestureRecognizer.state != .cancelled {
      // Add the X and Y translation to the view's original position.
      let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
      piece.center = newCenter
   }
   else {
      // On cancellation, return the piece to its original location.
      piece.center = initialCenter
   }
}
```

If the code for your pan gesture recognizer is not called, check to see if the following conditions are true, and make corrections as needed:

如果 pan 手势识别器的代码未调用，请检查以下条件是否正确，并根据需要进行更正：

- The [isUserInteractionEnabled](https://developer.apple.com/documentation/uikit/uiview/1622577-isuserinteractionenabled) property of the view is set to true. Image views and labels set this property to false by default.
  
  视图的 [isUserInteractionEnabled](https://developer.apple.com/documentation/uikit/uiview/1622577-isuserinteractionenabled) 属性已经被设为 true。Image 视图和 label 视图中将该属性的默认值为 false。

- The number of touches is between the values specified in the [minimumNumberOfTouches](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621210-minimumnumberoftouches) and [maximumNumberOfTouches](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621208-maximumnumberoftouches) properties.

  触摸点的数量介于 [minimumNumberOfTouches](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621210-minimumnumberoftouches) 属性和 [maximumNumberOfTouches](https://developer.apple.com/documentation/uikit/uipangesturerecognizer/1621208-maximumnumberoftouches) 属性指定的值之间。

- For a [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer) object, the [edges](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer/1614142-edges) property is configured and touches start at the appropriate edge.

  对于 [UIScreenEdgePanGestureRecognizer](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer) 对象，已经配置好 [edges](https://developer.apple.com/documentation/uikit/uiscreenedgepangesturerecognizer/1614142-edges) 属性，并且从相应的边缘开始触摸。

# See Also 其它参考

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

