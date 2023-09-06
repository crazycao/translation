# UIEvent

原文地址：
[https://developer.apple.com/documentation/uikit/uievent](https://developer.apple.com/documentation/uikit/uievent)

An object that describes a single user interaction with your app.

描述用户与您的应用程序进行的单个交互的对象。

> iOS 2.0+
iPadOS 2.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+ Beta

```
@MainActor
class UIEvent : NSObject
```

## Overview 概览

Apps can receive many different types of events, including touch events, motion events, remote-control events, and press events. Touch events are the most common and are delivered to the view in which the touch originally occurred. Motion events are UIKit triggered and are separate from the motion events reported by the Core Motion framework. Remote-control events allow a responder object to receive commands from an external accessory or headset so that it can manage audio and video — for example, playing a video or skipping to the next audio track. Press events represent interactions with a game controller, Apple TV remote, or other device that has physical buttons. You can determine the type of an event using the `type` and `subtype` properties.

应用程序可以收到许多不同类型的事件，包括触摸事件、运动事件、远程控制时间和按键事件。触摸事件是最常见的事件类型，它被传递给最初发生触摸的视图。运动事件是由 UIKit 触发的，并且与 Core Motion 框架报告的运动事件是分开的。远程控制事件允许响应者对象从外部配件或二级接收命令，以便管理音频和视频——例如播放视频或跳到下一个音轨。按键事件表示与游戏控制器、Apple TV 遥控器或其他有物理按钮的设备的交互。你可以使用 `type` 和 `subtype` 属性来确定事件的类型。

A touch event object contains the touches (that is, the fingers on the screen) that have some relation to the event. A touch event object may contain one or more touches, and each touch is represented by a UITouch object. When a touch event occurs, the system routes it to the appropriate responder and calls the appropriate method, such as `touchesBegan(_:with:)`. The responder then uses the touches to determine an appropriate course of action.

触摸事件对象中包含与该事件相关联的触点（即屏幕上的手指）。一个触摸事件对象可能包含一个或多个触点，每一个触点都由一个 UITouch 对象表示。当触摸事件发生时，系统将其路由到适当的响应者，并调用相应的方法，例如 `touchesBegain(_:with:)`。然后响应者使用这些触点来确定适当的操作方式。

During a multitouch sequence, UIKit reuses the same UIEvent object when delivering updated touch data to your app. You should never retain an event object or any object returned from an event object. If you need to retain data outside of the responder method you use to process that data, copy that data from the UITouch or UIEvent object to your local data structures.

在多点触控序列中，UIKit 会重用同一个 UIEvent 对象，将更新后的触摸数据发给你的 App。你永远不应该持有事件对象或从事件对象返回的任何对象。如果你需要在响应者方法之外保留数据，请将数据从 UITouch 或 UIEvent 对象中复制到你的本地数据结构中。

For more information on how to handle events in your UIKit app, see [Event Handling Guide for UIKit Apps](https://developer.apple.com/library/archive/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/index.html#//apple_ref/doc/uid/TP40009541).

关于如何在你的 UIKit 应用程序中处理事件的更多信息，参见《[UIKit 应用程序事件处理指南](https://developer.apple.com/library/archive/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/index.html#//apple_ref/doc/uid/TP40009541)》。

# Topics - 主题

## Getting the touches for an event - 从事件中获取触点

### var allTouches: Set<UITouch>?

All touches associated with the event.

### func touches(for: UIView) -> Set<UITouch>?

Returns the touch objects from the event that belong to the specified given view.

### func touches(for: UIWindow) -> Set<UITouch>?

Returns the touch objects from the event that belong to the specified window.

### func coalescedTouches(for: UITouch) -> [UITouch]?

Returns all of the touches associated with the specified main touch.

### func predictedTouches(for: UITouch) -> [UITouch]?

Returns an array of touches that are predicted to occur for the specified touch.

## Getting event attributes - 获取事件属性

### var timestamp: TimeInterval

The time when the event occurred.

## Getting the event type - 获取事件类型

### var type: UIEvent.EventType

Returns the type of the event.

### enum UIEvent.EventType

Constants that specify the general type of an event.

### var subtype: UIEvent.EventSubtype

Returns the subtype of the event.

### enum UIEvent.EventSubtype

Constants that specify the subtype of the event in relation to its general type.

## Getting the touches for a gesture recognizer - 获取手势识别器的触点

### func touches(for: UIGestureRecognizer) -> Set<UITouch>?

Returns the touch objects that are being delivered to the specified gesture recognizer.

## Getting the button mask - 获取按钮掩码

### var buttonMask: UIEvent.ButtonMask

A bit mask that represents which input-device buttons are pressed for the current event.

一个位掩码，表示当前事件中哪些输入设备按钮被按下。

### struct UIEvent.ButtonMask

Constants that indicate which input-device buttons are pressed.

## Getting the modifier flags 获取修改器标识

### var modifierFlags: UIKeyModifierFlags

The set of modifier keys that are pressed for the current event.

### struct UIKeyModifierFlags

Constants that indicate which modifier keys are pressed.