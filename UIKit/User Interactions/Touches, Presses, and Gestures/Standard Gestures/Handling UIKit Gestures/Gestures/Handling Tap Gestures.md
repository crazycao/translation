# Handling Tap Gestures

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_tap_gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_tap_gestures)

>__Framework__
>
> UIKit

Use brief taps on the screen to implement button-like interactions with your content.

使用屏幕上的简短点击来实现与内容的按钮式交互。

## Overview 概览

Tap gestures detect one or more fingers touching the screen briefly. The fingers involved in these gestures must not move significantly from the initial touch points, and you can configure the number of times the fingers must touch the screen. For example, you might configure tap gesture recognizers to detect single taps, double taps, or triple taps.

Tap 手势检测一个或多个手指短时间触摸屏幕的行为。这些手势中涉及的手指不得从初始触摸点明显移动，您可以配置手指必须触摸屏幕的次数。例如，您可以将 tap 手势识别器配置为检测单击、双击或三击。

You can attach a gesture recognizer in one of these ways:

您可以通过以下方式之一添加手势识别器：

- Programmatically. Call the [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) method of your view.

  编程方式。调用视图的  [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) 方法。
  
- In Interface Builder. Drag the appropriate object from the library and drop it onto your view.

  在界面生成器中。从库中拖动适当的对象并将其放到视图中。

![A diagram showing a single-finger tap gesture](https://docs-assets.developer.apple.com/published/7c21d852b9/14d1769c-c081-4c4a-9466-e5dca8a2e053.png)

A [UITapGestureRecognizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer) object provides event handling capabilities similar to those of a button—it detects a tap in its view and reports that tap to your action method. Tap gestures are discrete, so your action method is called only when the tap gesture is recognized successfully. You can configure a tap gesture recognizer to require any number of taps—for example, single taps or double taps—before your action method is called.

[UITapGestureRecognizer](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer) 对象提供的事件处理能力与按钮类似——它在视图中检测到点击并将点击报告给 action 方法。Tap 手势是离散的，因此只有在成功识别 tap 手势时才会调用 action 方法。您可以将 tap 手势识别器配置为在调用 action 方法之前必须有若干次数的轻触，例如，单击或双击。

Listing 1 shows an action method that responds to a successful tap in a view by animating that view to a new location. Always check the gesture recognizer’s [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) property before taking any actions, even for a discrete gesture recognizer.

清单1展示了一个 action 方法，它在响应视图中的成功点击时，将视图通过动画移动到新位置。在执行任何操作之前，始终检查手势识别器的 [state](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1619998-state) 属性，即使这是一个离散的手势识别器。


**Listing 1** Handling a tap gesture **清单1** 处理 tap 手势

```
@IBAction func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
   guard gestureRecognizer.view != nil else { return }
        
   if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
      let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
         gestureRecognizer.view!.center.x += 100
         gestureRecognizer.view!.center.y += 100
      })
      animator.startAnimation()
   }
}
```

If the code for your tap gesture recognizer is not called, check to see if the following conditions are true, and make corrections as needed:

如果 tap 手势识别器的代码未调用，请检查以下条件是否正确，并根据需要进行更正：

- The [isUserInteractionEnabled](https://developer.apple.com/documentation/uikit/uiview/1622577-isuserinteractionenabled) property of the view is set to true. Image views and labels set this property to false by default.
  
  视图的 [isUserInteractionEnabled](https://developer.apple.com/documentation/uikit/uiview/1622577-isuserinteractionenabled) 属性已经被设为 true。Image 视图和 label 视图中将该属性的默认值为 false。

- The number of taps was equal to the number specified in the [numberOfTapsRequired](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer/1623581-numberoftapsrequired) property.

  触摸的次数等于 [numberOfTapsRequired](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer/1623581-numberoftapsrequired) 属性指定的值。

- The number of fingers was equal to the number specified in the [numberOfTouchesRequired](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer/1623580-numberoftouchesrequired) property.

  触摸的手指数等于 [numberOfTouchesRequired](https://developer.apple.com/documentation/uikit/uitapgesturerecognizer/1623580-numberoftouchesrequired) 属性指定的值。

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

