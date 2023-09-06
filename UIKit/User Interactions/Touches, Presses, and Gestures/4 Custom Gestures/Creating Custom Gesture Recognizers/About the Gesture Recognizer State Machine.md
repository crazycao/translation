# About the Gesture Recognizer State Machine - 关于手势识别器状态机

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/about_the_gesture_recognizer_state_machine](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/about_the_gesture_recognizer_state_machine)

Learn about the states and transitions of the state machine that underlies gesture recognizers.

学习手势识别器背后的状态机的状态和转换。

## Overview 概览

Gesture recognizers are driven by a state machine, which UIKit uses to ensure the proper handling of events. The state machine determines several important behaviors:

手势识别器由状态机驱动，UIKit 使用该状态机来确保正确处理事件。状态机确定了几个重要的行为：

- Whether a continuous gesture recognizer is allowed to enter the `UIGestureRecognizer.State.began` state
- 连续手势识别器是否允许进入 `UIGestureRecognizer.State.began` 状态

- Whether a discrete gesture recognizer is allowed to enter the `UIGestureRecognizer.State.ended` state
- 离散手势识别器是否允许进入 `UIGestureRecognizer.State.ended` 状态

- When calls to attached action handlers occur
- 附加的动作处理程序调用的时机

When implementing a custom gesture recognizer, you must update its state machine at appropriate times. A gesture recognizer always starts in the `UIGestureRecognizer.State.possible` state, which indicates that it is ready to start processing events. From that state, discrete and continuous gesture recognizers follow different paths until they reach the `UIGestureRecognizer.State.ended`, `UIGestureRecognizer.State.failed`, or `UIGestureRecognizer.State.cancelled` state. A gesture recognizer remains in one of those final states until the current event sequence ends, at which point UIKit resets the gesture recognizer and returns it to the `UIGestureRecognizer.State.possible` state.

在实现自定义手势识别器时，您必须在适当的时机更新其状态机。手势识别器始终从 `UIGestureRecognizer.State.possible` 状态开始，表示它已准备好开始处理事件。从该状态开始，离散和连续手势识别器遵循不同的路径，直到达到 `UIGestureRecognizer.State.ended`、`UIGestureRecognizer.State.failed` 或 `UIGestureRecognizer.State.cancelled` 状态。手势识别器将保持在这些最终状态之一，直到当前事件序列结束，此时 UIKit 会重置手势识别器并将其返回到 `UIGestureRecognizer.State.possible` 状态。

## Managing State Transitions for a Discrete Gesture Recognizer 管理离散手势识别器的状态转换

When implementing a discrete gesture recognizer, you change the `state` property to one of two possible values: `UIGestureRecognizer.State.ended` or `UIGestureRecognizer.State.failed`. Figure 1 shows the state diagram for these transitions. When incoming events successfully match your gesture, change the state to `UIGestureRecognizer.State.ended`. When events do not match your intended gesture, change the state to `UIGestureRecognizer.State.failed` as soon as you detect the failure.

在实现离散手势识别器时，您可以将 `state` 属性更改为两个可能的值之一：`UIGestureRecognizer.State.ended` 或 `UIGestureRecognizer.State.failed`。图1显示了这些转换的状态图。当传入事件成功匹配您的手势时，将状态更改为`UIGestureRecognizer.State.ended`。当事件不符合您预期的手势时，在检测到失败时立即将状态更改为`UIGestureRecognizer.State.failed`。

**Figure 1** The states of a discrete gesture **图1** 离散手势的状态

![The states of a discrete gesture.](https://docs-assets.developer.apple.com/published/7c21d852b9/9ce946b4-9661-4a40-86bc-2f78abf3a8b1.png)

When your gesture recognizer transitions to the `UIGestureRecognizer.State.ended` state, UIKit calls the action methods of any associated target objects. UIKit does not call any action methods when the gesture recognizer transitions to the `UIGestureRecognizer.State.failed` state.

当您的手势识别器转换到 `UIGestureRecognizer.State.ended` 状态时，UIKit 会调用与之关联的目标对象的动作方法。当手势识别器转换到 `UIGestureRecognizer.State.failed` 状态时，UIKit 不会调用任何动作方法。

For an example of how to implement a discrete gesture recognizer, see [Implementing a Discrete Gesture Recognizer](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/implementing_a_discrete_gesture_recognizer).

有关如何实现离散手势识别器的示例，请参阅《[实现离散手势识别器](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/implementing_a_discrete_gesture_recognizer)》。

## Managing State Transitions for a Continuous Gesture Recognizer 管理连续手势识别器的状态转换

Figure 2 shows the state diagram for a continuous gesture recognizer. The state transitions you make can be broken down into three general phases:

图2显示了连续手势识别器的状态图。您进行的状态转换可以分为三个一般阶段：

1. The initial event sequence moves the gesture recognizer to the `UIGestureRecognizer.State.began` or `UIGestureRecognizer.State.failed` state.
2. Subsequent events move the gesture recognizer to the `UIGestureRecognizer.State.changed` or `UIGestureRecognizer.State.cancelled` state.
3. A final event moves the gesture recognizer to the `UIGestureRecognizer.State.ended` state.

>

1. 初始事件序列将手势识别器转换到 `UIGestureRecognizer.State.began` 或 `UIGestureRecognizer.State.failed` 状态。
2. 后续事件将手势识别器转换到 `UIGestureRecognizer.State.changed` 或 `UIGestureRecognizer.State.cancelled` 状态。
3. 最后一个事件将手势识别器转换到 `UIGestureRecognizer.State.ended` 状态。

**Figure 2** The states of a continuous gesture **图2** 连续手势的状态

![The states of continuous gesture](https://docs-assets.developer.apple.com/published/7c21d852b9/86fa3739-c97b-44cc-b51d-0215697660b7.png)

When your gesture recognizer is in the `UIGestureRecognizer.State.possible` state, if the initial event sequence does not match your gesture, move your gesture recognizer to the `UIGestureRecognizer.State.failed` state immediately. UIKit normally permits only one gesture recognizer at a time to notify its client. Moving your custom gesture recognizer to the failed state gives other gesture recognizers an opportunity to handle their gestures.

当您的手势识别器处于 `UIGestureRecognizer.State.possible` 状态时，如果初始事件序列与您的手势不匹配，请立即将手势识别器转换到 `UIGestureRecognizer.State.failed` 状态。UIKit 通常只允许一个手势识别器通知其客户端。将自定义手势识别器转换到失败状态为其他手势识别器提供了处理它们手势的机会。

If the initial event sequence matches your gesture, move your gesture recognizer to the `UIGestureRecognizer.State.began` state. For any subsequent events, repeatedly move your gesture recognizer to the `UIGestureRecognizer.State.changed` state to indicate that the event information has changed. (Always set the gesture recognizer's `state` property to `UIGestureRecognizer.State.changed` for each new event, even if the property is already set to that value. Setting that property triggers calls to the associated action methods.) When an event indicates the successful completion of your gesture, change the state to `UIGestureRecognizer.State.ended`. However, if an event indicates the unsuccessful completion of your gesture, change the state to `UIGestureRecognizer.State.cancelled`.

如果初始事件序列与您的手势匹配，请将手势识别器转换到 `UIGestureRecognizer.State.began` 状态。对于任何后续事件，请重复将手势识别器转换到 `UIGestureRecognizer.State.changed` 状态，以指示事件信息已更改。（对于每个新事件，始终将手势识别器的 `state` 属性设置为 `UIGestureRecognizer.State.changed`，即使属性已经设置为该值。设置该属性会触发对关联的动作方法的调用。）当事件指示成功完成您的手势时，将状态更改为 `UIGestureRecognizer.State.ended`。然而，如果事件指示了您的手势未能成功完成，将状态更改为 `UIGestureRecognizer.State.cancelled`。

When your gesture recognizer transitions to the `UIGestureRecognizer.State.began`, `UIGestureRecognizer.State.changed`, or `UIGestureRecognizer.State.ended` states, UIKit calls the action methods of any associated targets. UIKit does not call any action methods when your gesture recognizer transitions to other states.

当您的手势识别器转换到 `UIGestureRecognizer.State.began`、`UIGestureRecognizer.State.changed` 或 `UIGestureRecognizer.State.ended` 状态时，UIKit 会调用与之关联的目标对象的动作方法。当手势识别器转换到其他状态时，UIKit 不会调用任何动作方法。

For an example of how to implement a continuous gesture recognizer, see [Implementing a Continuous Gesture Recognizer](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/implementing_a_continuous_gesture_recognizer).

有关如何实现连续手势识别器的示例，请参阅《[实现连续手势识别器](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/implementing_a_custom_gesture_recognizer/implementing_a_continuous_gesture_recognizer)》。

## Handling Cancellation 处理取消

Cancellation of a gesture occurs automatically when the current event sequence is interrupted by a system event, such as an incoming phone call. You can also cancel a gesture programmatically based on event information or on conditions in your app. Cancellation prevents the gesture recognizer from performing tasks that the user didn't intend.

当前事件序列被系统事件（例如来电）中断时，手势的取消会自动发生。您还可以根据事件信息或应用程序中的条件以编程方式取消手势。取消操作可以防止手势识别器执行用户不打算进行的任务。

When the system cancels a gesture, UIKit calls the `touchesCancelled(_:with:)` or `pressesCancelled(_:with:)` method of your gesture recognizer. When that happens, move your gesture recognizer to the `UIGestureRecognizer.State.cancelled` state immediately. When you move your gesture recognizer to the `UIGestureRecognizer.State.cancelled` state, UIKit calls the gesture recognizer's action methods one final time before resetting it.

当系统取消手势时，UIKit 会调用手势识别器的 `touchesCancelled(:with:)` 或 `pressesCancelled(:with:) 方法`。在这种情况下，立即将手势识别器转换到 `UIGestureRecognizer.State.cancelled` 状态。当您将手势识别器转换到 `UIGestureRecognizer.State.cancelled` 状态时，UIKit 在重置手势识别器之前最后一次调用手势识别器的动作方法。

## Resetting the Gesture Recognizer State Machine 重置手势识别器的状态机

Implement the `reset()` method and use it to return your gesture recognizer to its initial configuration. For example, use this method to return your gesture recognizer's custom properties to their starting values. Before delivering events in a new event sequence, UIKit calls the `reset()` method of every gesture recognizer that received touches or is in the `UIGestureRecognizer.State.failed`, `UIGestureRecognizer.State.cancelled`, or `UIGestureRecognizer.State.ended` state. In addition to calling the `reset()` method, UIKit automatically changes each gesture recognizer’s state property back to `UIGestureRecognizer.State.possible` so that it can respond to new event sequences.

实现 `reset()` 方法并使用它将手势识别器恢复到初始配置。例如，使用此方法将手势识别器的自定义属性返回到其初始值。在提供新的事件序列之前，UIKit 会调用接收了触摸或处于 `UIGestureRecognizer.State.failed`、`UIGestureRecognizer.State.cancelled` 或 `UIGestureRecognizer.State.ended` 状态的每个手势识别器的 `reset()` 方法。除了调用 `reset()` 方法外，UIKit 还会自动将每个手势识别器的状态属性更改回 `UIGestureRecognizer.State.possible`，以便它可以响应新的事件序列。

# See Also - 其他参考

## Creating Custom Gesture Recognizers - 创建自定义手势识别器

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