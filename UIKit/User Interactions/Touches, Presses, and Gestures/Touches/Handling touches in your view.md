# Handling touches in your view

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view)

Use touch events directly on a view subclass if touch handling is intricately linked to the view’s content.

如果触摸处理与视图的内容有错综复杂的联系，则直接在视图子类上使用触摸事件。

## Overview 概览

If you don’t plan to use gesture recognizers with a custom view, you can handle touch events directly from the view itself. Because views are responders, they can handle Multi-Touch events and many other types of events. When UIKit determines that a touch event occurred in a view, it calls the view’s [touchesBegan(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan), [touchesMoved(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621107-touchesmoved), or [touchesEnded(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621084-touchesended) method. You can override these methods in your custom views and use them to provide a response to touch events.

如果您不打算在自定义视图中使用手势识别器，可以直接处理来自视图本身的触摸事件。因为视图是响应者，所以它们可以处理多点触摸事件和许多其他类型的事件。当 UIKit 确定某个视图中发生了触摸事件时，它会调用该视图的 [touchesBegan(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan)、[touchesMoved(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621107-touchesmoved) 或 [touchesEnded(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621084-touchesended) 方法。您可以在自定义视图中重写这些方法，并使用它们来提供对触摸事件的响应。

The methods you override in your views (or in any responder) to handle touches correspond to different phases of the touch event-handling process. For example, the following image illustrates the different phases of a touch event. When a finger (or Apple Pencil) touches the screen, UIKit creates a [UITouch](https://developer.apple.com/documentation/uikit/uitouch) object, sets the touch location to the appropriate point, and sets its `phase` property to `UITouch.Phase.began`. When the same finger moves around the screen, UIKit updates the touch location and changes the `phase` property of the touch object to `UITouch.Phase.moved`. When the user lifts the finger from the screen, UIKit changes the `phase` property to `UITouch.Phase.ended` and the touch sequence ends.

您在视图（或任何响应者）中重写的处理触摸的方法对应于触摸事件处理过程的不同阶段。例如，下图说明了触摸事件的不同阶段。当手指（或 Apple Pencil）触摸屏幕时，UIKit 会创建一个 [UITouch](https://developer.apple.com/documentation/uikit/uitouch) 对象，将触摸位置设置为适当的点，并将其 `phase` 属性设置为 `UITouch.Phase.began`。当同一手指在屏幕上移动时，UIKit 会更新触摸位置，并将触摸对象的 `phase` 属性更改为`UITouch.phase.moved`。当用户从屏幕上抬起手指时，UIKit 会将 `phase` 属性更改为 `UITouch.Phase.ended`，并且结束触摸序列。

![A touch begins when the user's finger touches the screen. The system updates the touch when the user's finger moves or the touch parameters change. The touch ends when the user lifts the same finger from the screen. If an interruption such as an incoming call occurs, the system cancels any active touches.](https://docs-assets.developer.apple.com/published/7c21d852b9/08b952fe-6f46-41eb-8b8a-4830c1d48842.png)

Similarly, the system may cancel an ongoing touch sequence at any time; for example, when an incoming phone call interrupts the app. When it does, UIKit notifies your view by calling the [touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled) method. You use that method to perform any needed cleanup of your view’s data structures.

类似地，系统可能在任何时间取消正在进行的触摸序列；例如，当来电中断应用程序时。当它这么做时，UIKit 通过调用 [touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled) 方法通知您的视图。您可以使用该方法对视图的数据结构执行任何必要的清理。

UIKit creates a new `UITouch` object for each new finger that touches the screen. The touches themselves are delivered with the current `UIEvent` object. UIKit distinguishes between touches originating from a finger and from Apple Pencil, and you can treat each of them differently.

UIKit 为每个触摸屏幕的新手指创建一个新的 UITouch 对象。触摸本身与当前 `UIEvent` 对象一起传递。UIKit 可以区分来自手指和来自 Apple Pencil 的触摸，您可以区别对待它们。

> **Important** **重要**
>
> In its default configuration, a view receives only the first `UITouch` object associated with an event, even if more than one finger is touching the view. To receive the additional touches, you must set the view’s `isMultipleTouchEnabled` property to `true`. You can also configure this property in Interface Builder using the Attributes inspector.
> 
> 在默认配置中，视图仅接收与事件关联的第一个 UITouch 对象，即使不止一个手指正在触摸视图。要接收其他触摸，必须将视图的 `isMultipleTouchEnabled` 属性设置为 `true`。您还可以在 Interface Builder  中使用 Attributes 检查器配置此属性。

# Topics - 主题

## Advanced touch handling - 进阶触摸处理

### [Implementing a Multi-Touch app](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/implementing_a_multi-touch_app) - 实现多点触控 app

Learn how to create a simple app that handles multitouch input.

了解如何创建一个处理多点触摸输入的简单 app。

### [Getting high-fidelity input with coalesced touches](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/getting_high-fidelity_input_with_coalesced_touches) - 通过合并触摸获得高保真度输入

Learn how to support high-precision touches in your app.

了解如何在 app 中支持高精度触摸。

### [Minimizing latency with predicted touches](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/minimizing_latency_with_predicted_touches) - 通过预测触摸最小化延迟

Create a smooth and responsive drawing experience using UIKit’s predictions for touch locations.

使用 UIKit 对触摸位置的预测，创建流畅、快速的绘图体验。

# See Also 其它参考

## Touches 触摸

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
