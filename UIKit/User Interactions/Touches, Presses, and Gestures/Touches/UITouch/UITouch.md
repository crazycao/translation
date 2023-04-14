# UITouch

原文地址：
[https://developer.apple.com/documentation/uikit/uitouch](https://developer.apple.com/documentation/uikit/uitouch)

An object representing the location, size, movement, and force of a touch occurring on the screen.

表示屏幕上触摸的位置、大小、移动和力度的对象。

> iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.1+ | tvOS 9.0+

## Declaration 声明

```
@MainActor class UITouch : NSObject
```

## Overview 概览

You access touch objects through `UIEvent` objects passed into responder objects for event handling. A touch object includes accessors for:

你可以通过传递到响应者对象以进行事件处理的 `UIEvent` 对象来访问触摸对象。触摸对象中包括以下信息的访问接口：

- The view or window in which the touch occurred
- The location of the touch within the view or window
- The approximate radius of the touch
- The force of the touch (on devices that support 3D Touch or Apple Pencil)

- 发生触摸的视图或窗口
- 触摸在视图或窗口中的位置
- 触摸的近似半径
- 触摸力（在支持 3D touch 或 Apple Pencil 的设备上）

A touch object also contains a timestamp indicating when the touch occurred, an integer representing the number of times the user tapped the screen, and the phase of the touch in the form of a constant that describes whether the touch began, moved, or ended, or whether the system canceled the touch.

触摸对象还包含一个指示触摸发生时间的时间戳，一个表示用户点击屏幕的次数的整数，和以常量形式表示的触摸阶段，该常量描述触摸是开始、移动还是结束，或者系统是否取消了触摸。

To learn how to work with swipes, read [Handling Swipe and Drag Gestures](https://developer.apple.com/library/archive/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/multitouch_background/multitouch_background.html#//apple_ref/doc/uid/TP40009541-CH5-SW21) in [Event Handling Guide for UIKit Apps](https://developer.apple.com/library/archive/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/index.html#//apple_ref/doc/uid/TP40009541).

要了解如何使用滑动，请阅读《[UIKit应用程序事件处理指南](https://developer.apple.com/library/archive/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/index.html#//apple_ref/doc/uid/TP40009541)》中的《[处理滑动和拖动手势](https://developer.apple.com/library/archive/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/multitouch_background/multitouch_background.html#//apple_ref/doc/uid/TP40009541-CH5-SW21)》一节。

A touch object persists throughout a multi-touch sequence. You may store a reference to a touch while handling a multi-touch sequence, as long as you release that reference when the sequence ends. If you need to store information about a touch outside of a multi-touch sequence, copy that information from the touch.

触摸对象在多点触摸序列中持续存在。你可以在处理多点触摸序列时存储对触摸的引用，只要在序列结束时释放该引用即可。如果你需要在多点触摸序列之外存储关于触摸的信息，请从触摸对象中复制该信息。

The `gestureRecognizers` property of a touch contains the gesture recognizers currently handling the touch. Each gesture recognizer is an instance of a concrete subclass of `UIGestureRecognizer`.

触摸的 `gestureRecognizers` 属性包含当前处理该触摸的手势识别器。每个手势识别器都是 `UIGestureRecognizer` 的具体子类的实例。

# Topics - 主题

## Getting the location of a touch - 获取触摸的位置

### `func location(in: UIView?) -> CGPoint`

Returns the current location of the touch in the coordinate system of the given view.

返回给定视图坐标系中触摸的当前位置。

### `func previousLocation(in: UIView?) -> CGPoint`

Returns the previous location of the touch in the coordinate system of the given view.

返回触摸在给定视图的坐标系中的前一个位置。

### `var view: UIView?`

The view to which touches are being delivered, if any.

正在传递触摸的视图（如果有）。

### `var window: UIWindow?`

The window in which the touch initially occurred.

最初发生触摸的 windows。

### `var majorRadius: CGFloat`

The radius (in points) of the touch.

触摸的半径（以点为单位）。

### `var majorRadiusTolerance: CGFloat`

The tolerance (in points) of the touch’s radius.

触摸半径的公差（以点为单位）。

### `func preciseLocation(in: UIView?) -> CGPoint`

Returns a precise location for the touch, when available.

返回触摸的精确位置（如果可用）。

### `func precisePreviousLocation(in: UIView?) -> CGPoint`

Returns a precise previous location for the touch, when available.

返回触摸的前一个精确位置（如果可用）。

## Getting touch attributes - 获取触摸的属性

### `var tapCount: Int`

The number of times the finger was tapped for this given touch.

对于这个给定的触摸，手指被点击的次数。

### `var timestamp: TimeInterval`

The time when the touch occurred or when it was last mutated.

触摸发生的时间或上次发生变化的时间。

### `var type: UITouch.TouchType`

The type of the touch.

触摸的类型。

### `enum UITouch.TouchType`

The type of touch received.

接收到的触摸类型。

### `var phase: UITouch.Phase`

The phase of the touch.

触摸的阶段。

### `enum UITouch.Phase`

The phase of a touch event.

触摸事件的阶段。

### `var force: CGFloat`

The force of the touch, where a value of 1.0 represents the force of an average touch (predetermined by the system, not user-specific).

触摸的力量大小，其中值 1.0 表示平均的触摸力量（由系统预先定义，而不是用户特定的）。

### `var maximumPossibleForce: CGFloat`

The maximum possible force for a touch.

触摸的最大可能力。

### `var altitudeAngle: CGFloat`

The altitude (in radians) of the stylus.

手写笔的高度（以弧度为单位）。

### `func azimuthAngle(in: UIView?) -> CGFloat`

Returns the azimuth angle (in radians) of the stylus.

返回手写笔的方位角（以弧度为单位）。

### `func azimuthUnitVector(in: UIView?) -> CGVector`

Returns a unit vector that points in the direction of the azimuth of the stylus.

返回指向手写笔方位角方向的单位向量。

## Managing estimated touch attributes - 管理估计触摸属性

### `var estimatedProperties: UITouch.Properties`

A set of touch properties whose values contain only estimates.

一组触摸属性，其值仅包含估计值。

### `var estimatedPropertiesExpectingUpdates: UITouch.Properties`

The set of touch properties for which updated values are expected in the future.

预计在未来更新值的触摸属性集。

### `struct UITouch.Properties`

A bit mask of touch properties that may get updated.

可能会更新的触摸属性的位掩码。

### `var estimationUpdateIndex: NSNumber?`

An index number that lets you correlate an updated touch with the original touch.

一个索引号，可让你将更新后的触摸与原始的触摸相关联。

## Getting a touch object’s gesture recognizers - 获取触摸对象的手势识别器

### `var gestureRecognizers: [UIGestureRecognizer]?`

The gesture recognizers that are receiving the touch object.

接收触摸对象的手势识别器。

## Working with touch events in SpriteKit - 在 SpriteKit 中处理触摸事件

### `func location(in: SKNode) -> CGPoint`

Returns the current location of the touch in the coordinate system of the given node.

返回给定节点坐标系中触摸的当前位置。

### `func previousLocation(in: SKNode) -> CGPoint`

Returns the previous location of the touch in the coordinate system of the given node.

返回给定节点坐标系中触摸的前一个位置。

# See Also 其它参考

## Touches 触摸

###  [Handling touches in your view](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view) - 在视图中处理触摸

Use touch events directly on a view subclass if touch handling is intricately linked to the view’s content.

如果触摸处理与视图的内容有错综复杂的连接，则直接在视图子类上使用触摸事件。

### [Handling input from Apple Pencil](https://developer.apple.com/documentation/uikit/pencil_interactions/handling_input_from_apple_pencil) - 处理来自 Apple Pencil 的输入

Learn how to detect and respond to touches from Apple Pencil.

了解如何检测和响应 Apple Pencil 的触摸。

### [Tracking the force of 3D Touch events](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/tracking_the_force_of_3d_touch_events) - 跟踪 3D Touch 事件的力度

Manipulate your content based on the force of touches.

根据触摸力度操纵内容。

### [Illustrating the Force, Altitude, and Azimuth Properties of Touch Input](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/illustrating_the_force_altitude_and_azimuth_properties_of_touch_input) - 说明触摸输入的力、高度和方位特性

Capture Apple Pencil and touch input in views.

在视图中捕获 Apple Pencil 和触摸输入。

### [Leveraging Touch Input for Drawing Apps](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/leveraging_touch_input_for_drawing_apps) - 利用触摸输入的绘图 app

Capture touches as a series of strokes and render them efficiently on a drawing canvas.

将触摸捕捉为一系列笔划，并在画布上高效地渲染它们。

### class [UITouch](https://developer.apple.com/documentation/uikit/uitouch)

An object representing the location, size, movement, and force of a touch occurring on the screen.

表示屏幕上发生的触摸的位置、大小、移动和力度的对象。
