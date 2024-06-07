# Handling Pinch Gestures

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pinch_gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures/handling_pinch_gestures)

>__Framework__
>
> UIKit

Track the distance between two fingers and use that information to scale or zoom your content.

跟踪两个手指之间的距离，并使用该信息缩放内容。

## Overview 概览

A pinch gesture is a continuous gesture that tracks the distance between the first two fingers that touch the screen. Use the [UIPinchGestureRecognizer](https://developer.apple.com/documentation/uikit/uipinchgesturerecognizer) class to detect pinch gestures.

Pinch 手势是跟踪触摸屏幕的前两个手指之间的距离的连续手势。使用 [UIPinchGestureRecognizer](https://developer.apple.com/documentation/uikit/uipinchgesturerecognizer) 类检测 pinch 手势。

You can attach a gesture recognizer in one of these ways:

您可以通过以下方式之一添加手势识别器：

- Programmatically. Call the [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) method of your view.

  编程方式。调用视图的  [addGestureRecognizer(_:)](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) 方法。
  
- In Interface Builder. Drag the appropriate object from the library and drop it onto your view.

  在界面生成器中。从库中拖动适当的对象并将其放到视图中。

![A diagram demonstrating how two fingers can trigger a pinch gesture](https://docs-assets.developer.apple.com/published/7c21d852b9/46733a3e-1a59-4ca3-acb3-dc14958374a7.png)

A pinch gesture recognizer reports changes to the distance between two fingers touching the screen. Pinch gestures are continuous, so your action method is called each time the distance between the fingers changes. The distance between the fingers is reported as a scale factor. At the beginning of the gesture, the scale factor is 1.0. As the distance between the two fingers increases, the scale factor increases proportionally. Similarly, the scale factor decreases as the distance between the fingers decreases. Pinch gestures are used most commonly to change the size of objects or content onscreen. For example, map views use pinch gestures to change the zoom level of the map.

Pinch 手势识别器报告触摸屏幕的两个手指之间距离的变化。Pinch 手势是连续的，因此每次手指之间的距离改变时都会调用您的动作方法。手指之间的距离报告为比例因子。在手势开始时，比例因子为1.0。随着两个手指之间的距离增加，比例因子也按比例增加。类似地，比例因子随着手指之间的距离减小而减小。Pinch 手势最常用于更改屏幕上对象或内容的大小。例如，地图视图使用 pinch 手势更改地图的缩放级别。

A pinch gesture recognizer enters the [UIGestureRecognizer.State.began](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/began) state only after the distance between the two fingers changes for the first time. After that initial change, subsequent changes to the distance put the gesture recognizer into the [UIGestureRecognizer.State.changed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/changed) state and update the scale factor. When the user’s fingers lift from the screen, the gesture recognizer enters the [UIGestureRecognizer.State.ended](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/ended) state.

Pinch 手势识别器仅在两个手指之间的距离第一次改变后才进入 [UIGestureRecognizer.State.began](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/began) 状态。在初始更改之后，对距离的后续更改会将手势识别器放入[UIGestureRecognizer.State.changed](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/changed) 状态，并更新比例因子。当用户的手指从屏幕上抬起时，手势识别器进入 [UIGestureRecognizer.State.ended](https://developer.apple.com/documentation/uikit/uigesturerecognizer/state/ended) 状态。

> **Important** 
>
> Take care when applying a pinch gesture recognizer’s scale factor to your content, or you might get unexpected results. Because your action method may be called many times, you cannot simply apply the current scale factor to your content. If you multiply each new scale value by the current value of your content, which has already been scaled by previous calls to your action method, your content will grow or shrink exponentially. Instead, cache the original value of your content, apply the scale factor to that original value, and apply the new value back to your content. Alternatively, reset the scale factor to `1.0` after applying each new change.
> 
> **重要**
> 
> 在把 pinch 手势识别器的比例因子应用到你的内容上时要小心，否则可能会得到意外的结果。因为 action 方法可能会被多次调用，所以不能简单地将当前比例因子应用于内容。如果将每个新的缩放值乘以内容的当前缩放值（该值已通过先前对 action 方法的调用进行缩放），则内容将以指数方式增长或收缩。相反，应该缓存内容的原始值，并将比例因子应用于该原始值，再将新值应用回内容。或者，在应用每个新的变更之后，都将比例因子重置为 `1.0`。

Listing 1 demonstrates how to resize a view linearly using a pinch gesture recognizer. This action method applies the current scale factor to the view’s transform and then resets the gesture recognizer’s [scale](https://developer.apple.com/documentation/uikit/uipinchgesturerecognizer/1622235-scale) property to `1.0`. Resetting the scale factor causes the gesture recognizer to report only the amount of change since the value was reset, which results in linear scaling of the view.

清单1演示了如何使用 pinch 手势识别器线性调整视图大小。该 action 方法将当前比例因子应用于视图的变换，然后将手势识别器的  [scale](https://developer.apple.com/documentation/uikit/uipinchgesturerecognizer/1622235-scale) 属性重置为 `1.0`。重置比例因子会导致手势识别器仅报告自重置值以来的更改量，从而实现了视图的线性缩放。

**Listing 1** Scaling a view **清单1** 缩放视图

```
@IBAction func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {   
   guard gestureRecognizer.view != nil else { return }

   if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
      gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform.
                    scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))!
      gestureRecognizer.scale = 1.0
   }
}
```

If the code for your pinch gesture recognizer is not called, or is not working correctly, check to see if the following conditions are true, and make corrections as needed:

如果 pinch 手势识别器的代码未调用或工作不正常，请检查以下条件是否正确，并根据需要进行更正：

- The [isUserInteractionEnabled](https://developer.apple.com/documentation/uikit/uiview/1622577-isuserinteractionenabled) property of the view is set to true. Image views and labels set this property to false by default.
  
  视图的 [isUserInteractionEnabled](https://developer.apple.com/documentation/uikit/uiview/1622577-isuserinteractionenabled) 属性已经被设为 true。Image 视图和 label 视图中将该属性的默认值为 false。

- At least two fingers are touching the screen.

  至少有两个手指正在触摸屏幕。

- You are applying scale factors to your content correctly. Exponential growth of a value happens when you simply apply the scale factor to the current value.

  正确的将缩放因子应用到了内容上。当你简单的将比例影子应用于一个值时，这个值会出现指数增长。

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

