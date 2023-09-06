# Implementing a custom gesture recognizer - 实现自定义手势识别器

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer)

Discover when and how to build your own gesture recognizers.

了解何时以及如何构建自己的手势识别器。

## Overview 概览

When the built-in UIKit gesture recognizers don’t provide the behavior you want, you can define custom gesture recognizers. UIKit defines highly configurable gesture recognizers to handle touch sequences for taps, long presses, pans, swipes, rotations, and pinches. For other touch sequences, or to handle gestures that involve button presses, you can define a custom gesture recognizer.

当内置的 UIKit 手势识别器无法提供你想要的行为时，你可以定义自定义手势识别器。UIKit 定义了高度可配置的手势识别器，用于处理轻击、长按、平移、轻扫、旋转和捏合等触摸序列。对于其他触摸序列，或者要处理涉及按钮按下的手势，你可以定义一个自定义的手势识别器。

You might also use a custom gesture recognizer to simplify the event-handling code in your app. For example, the [Leveraging Touch Input for Drawing Apps ](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/leveraging_touch_input_for_drawing_apps)sample uses a gesture recognizer to capture input and display it onscreen, as shown in the following image.

你还可以使用自定义手势识别器来简化应用程序中的事件处理代码。例如，“[利用触摸输入的绘图应用程序](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/leveraging_touch_input_for_drawing_apps)”示例使用手势识别器来捕获输入并在屏幕上显示，如下图所示。

![A screenshot from an app which uses a custom gesture recognizer to allow a user to draw on the screen.](https://docs-assets.developer.apple.com/published/7c21d852b9/1dac7b87-cd89-4bb7-aa19-7110bb17987e.png)

To define a custom gesture recognizer, subclass UIGestureRecognizer (or one of its subclasses). At the top of your source file, import the `UIGestureRecognizerSubclass.h` header file (for Objective-C) or the UIKit.UIGestureRecognizerSubclass module (for Swift), as shown in the following code. This file defines the methods and properties that you must override to implement your custom gesture recognizer.

要定义一个自定义手势识别器，可以子类化 UIGestureRecognizer（或它的一个子类）。在源文件的顶部，导入 `UIGestureRecognizerSubclass.h` 头文件（Objective-C）或 `UIKit.UIGestureRecognizerSubclass` 模块（Swift），如下面的代码所示。该文件定义了你必须重写以实现自定义手势识别器的方法和属性。

```
import UIKit
import UIKit.UIGestureRecognizerSubclass
```

In your custom subclass, implement whatever methods you need to process events. For example, if your gesture consists of touch events, implement the `touchesBegan(_:with:)`, `touchesMoved(_:with:)`, `touchesEnded(_:with:)`, and `touchesCancelled(_:with:)` methods. Use incoming events to update the state property of your gesture recognizer. UIKit uses the gesture recognizer states to coordinate interactions with other objects in your interface.

在你的自定义子类中，实现你需要处理事件的方法。例如，如果你的手势由触摸事件组成，可以实现 `touchesBegan(_:with:)`、`touchesMoved(_:with:)`、`touchesEnded(_:with:)` 和 `touchesCancelled(_:with:)` 方法。使用传入的事件更新手势识别器的状态属性。UIKit 使用手势识别器的状态来协调与界面中其他对象的交互。

# Topics - 主题

## Creating Custom Gesture Recognizers - 创建自定义手势识别器

### [About the Gesture Recognizer State Machine](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/about_the_gesture_recognizer_state_machine) - 关于手势识别器状态机

Learn about the states and transitions of the state machine that underlies gesture recognizers.

学习手势识别器背后的状态机的状态和转换。

### [Implementing a Discrete Gesture Recognizer](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/implementing_a_discrete_gesture_recognizer) - 实现离散手势识别器

If your gesture involves a specific pattern of events, consider implementing a discrete gesture recognizer for it.

如果您的手势涉及特定的事件模式，请考虑为其实现一个离散手势识别器。

### [Implementing a Continuous Gesture Recognizer](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/implementing_a_continuous_gesture_recognizer) - 实现连续手势识别器

For gestures that do not easily match a specific pattern, or when you want to use a gesture recognizer to gather touch input, create a continuous gesture recognizer.

对于不容易匹配特定模式的手势，或者当您想要使用手势识别器来收集触摸输入时，请创建一个连续手势识别器。

# See Also - 其他参考

## Custom gestures 自定义手势

### class [UIGestureRecognizer](https://developer.apple.com/documentation/uikit/uigesturerecognizer)

The base class for concrete gesture recognizers.

具体手势识别器的基类。

### protocol [UIGestureRecognizerDelegate](https://developer.apple.com/documentation/uikit/uigesturerecognizerdelegate)

A set of methods implemented by the delegate of a gesture recognizer to fine-tune an app’s gesture-recognition behavior.

由手势识别器的委托实现的一组方法，用于优化应用程序的手势识别行为。

### [Supporting Gesture Interaction in Your Apps](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/supporting_gesture_interaction_in_your_apps) - 在应用程序中支持手势交互

Enrich your app’s user experience by supporting standard and custom gesture interaction.

通过支持标准和自定义手势交互，增强应用程序的用户体验。