# Using responders and the responder chain to handle events

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events)

Learn how to handle events that propagate through your app.

了解如何处理通过应用程序传播的事件。

## Overview 概览

Apps receive and handle events using responder objects. A responder object is any instance of the [UIResponder]() class, and common subclasses include [UIView](), [UIViewController](), and [UIApplication](). Responders receive the raw event data and must either handle the event or forward it to another responder object. When your app receives an event, UIKit automatically directs that event to the most appropriate responder object, known as the _first responder_.

应用程序使用响应对象接收和处理事件。响应对象是 UIResponder 类的任何实例，常见的子类包括 UIView、UIViewController 和 UIApplication。响应者接收原始事件数据，必须要么处理该事件，要么将其转发给另一个响应对象。当您的应用程序接收到事件时，UIKit 会自动将该事件定向到最合适的响应对象，即“_第一响应者_”。

Unhandled events are passed from responder to responder in the active responder chain, which is the dynamic configuration of your app’s responder objects. The following image shows the responders in an app whose interface contains a label, a text field, a button, and two background views. The diagram also shows how events move from one responder to the next, following the responder chain.

未处理的事件会在活动响应者链中从一个响应者传递到另一个响应者，而活动响应者链是您的应用程序响应对象的动态配置。下面的图像显示了一个应用程序中的响应者，其界面包含一个标签、一个文本、一个按钮和两个背景视图。该图还显示了事件如何沿着响应者链从一个响应者移动到下一个响应者。

![A flow diagram: On the left, a sample app contains a label (UILabel), a text field for the user to input text (UITextField), and a button (UIButton) to  press after entering text in the field. On the right, the flow diagram shows how, after the user pressed the button, the event moves through the responder chain — from UIView, to UIViewController, to UIWindow, UIApplication, and finally to UIApplicationDelegate.](https://docs-assets.developer.apple.com/published/7c21d852b9/f17df5bc-d80b-4e17-81cf-4277b1e0f6e4.png)

If the text field doesn’t handle an event, UIKit sends the event to the text field’s parent UIView object, followed by the root view of the window. From the root view, the responder chain diverts to the owning view controller before directing the event to the window. If the window can’t handle the event, UIKit delivers the event to the UIApplication object, and possibly to the app delegate if that object is an instance of UIResponder and not already part of the responder chain.

如果文本字段无法处理事件，UIKit 将事件发送给文本的父 UIView 对象，然后发送给窗口的根视图。从根视图开始，响应者链会在指向窗口之前转向拥有的视图控制器。如果窗口无法处理该事件，UIKit 将事件传递给 UIApplication 对象，如果该对象是 UIResponder 的实例且尚未包含在响应者链中，则可能还会传递给应用程序委托对象。

## Determine an event’s first responder - 决定事件的第一响应者

UIKit designates an object as the first responder to an event based on the type of that event. Event types include:

UIKit 根据事件的类型将某个对象指定为该事件的第一响应程序。事件类型包括：

Event type|First responder
:-:|:-:
Touch events|The view in which the touch occurred.
Press events|The object that has focus.
Shake-motion events|The object that you (or UIKit) designate.
Remote-control events|The object that you (or UIKit) designate.
Editing menu messages|The object that you (or UIKit) designate.

事件类型|第一响应者
:-:|:-:
触摸事件|发生触摸的视图。
按压事件|具有焦点的对象。
摇晃事件|您（或 UIKit）指定的对象。
远程控制事件|您（或 UIKit）指定的对象。
编辑菜单消息|您（或 UIKit）指定的对象。

> **Note** **注意**
>
> Motion events related to the accelerometers, gyroscopes, and magnetometer don’t follow the responder chain. Instead, Core Motion delivers those events directly to the designated object. For more information, see [Core Motion Framework](https://developer.apple.com/library/archive/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/CoreServicesLayer/CoreServicesLayer.html#//apple_ref/doc/uid/TP40007898-CH10-SW27).
> 
> 与加速计、陀螺仪和磁力计相关的运动事件不遵循响应者链。相反，Core Motion 将这些事件直接传递给指定的对象。如需更多信息，请参阅《Core Motion Framework（核心运动框架）》。

Controls communicate directly with their associated target object using action messages. When the user interacts with a control, the control sends an action message to its target object. Action messages aren’t events, but they may still take advantage of the responder chain. When the target object of a control is `nil`, UIKit starts from the target object and traverses the responder chain until it finds an object that implements the appropriate action method. For example, the UIKit editing menu uses this behavior to search for responder objects that implement methods with names like `cut(_:)`, `copy(_:)`, or `paste(_:)`.

控件使用操作消息直接与其关联的目标对象进行通信。当用户与控件交互时，控件会向其目标对象发送一个操作消息。操作消息并不是事件，但它们仍然可以利用响应者链。当控件的目标对象为 `nil` 时，UIKit 会从目标对象开始遍历响应者链，直到找到一个实现了适当的操作方法的对象。例如，UIKit 的编辑菜单使用此行为来搜索实现了像 `cut(:)`, `copy(:)`, 或 `paste(_:)` 这样命名的方法的响应对象。

Gesture recognizers receive touch and press events before their view does. If a view’s gesture recognizers fail to recognize a sequence of touches, UIKit sends the touches to the view. If the view doesn’t handle the touches, UIKit passes them up the responder chain. For more information about using gesture recognizer’s to handle events, see [Handling UIKit gestures](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_uikit_gestures).

手势识别器在视图之前接收触摸和按压事件。如果视图的手势识别器无法识别一系列的触摸，UIKit 会将这些触摸事件发送给视图。如果视图无法处理这些触摸事件，UIKit 会将其传递给响应者链上的下一个响应对象。关于如何使用手势识别器来处理事件的更多信息，请参阅《Handling UIKit gestures（处理UIKit手势）》。

## Determine which responder contained a touch event - 确定哪个响应者包含了触摸事件

UIKit uses view-based hit-testing to determine where touch events occur. Specifically, UIKit compares the touch location to the bounds of view objects in the view hierarchy. The `hitTest(_:with:)` method of UIView traverses the view hierarchy, looking for the deepest subview that contains the specified touch, which becomes the first responder for the touch event.

UIKit 使用基于视图的命中测试（hit-testing）来确定触摸事件发生的位置。具体而言，UIKit 将触摸位置与视图层次结构中的视图对象边界进行比较。UIView 的 `hitTest(_:with:)` 方法遍历视图层次结构，寻找包含指定触摸位置的最深子视图，该视图将成为触摸事件的第一响应者。

> **Note** **注意**
>
> If a touch location is outside of a view’s bounds, the `hitTest(_:with:)` method ignores that view and all of its subviews. As a result, when a view’s `clipsToBounds` property is `true`, subviews outside of that view’s bounds aren’t returned even if they happen to contain the touch. For more information about the hit-testing behavior, see the discussion of the `hitTest(_:with:)` method in `UIView`.
> 
> 如果触摸位置在视图的边界之外，`hitTest(_:with:)` 方法将忽略该视图及其所有子视图。因此，当视图的 `clipsToBounds` 属性为 `true` 时，即使某些子视图包含触摸，超出该视图边界的子视图也不会被返回。有关命中测试行为的更多信息，请参阅 UIView 中 `hitTest(_:with:)` 方法的讨论部分。

When a touch occurs, UIKit creates a UITouch object and associates it with a view. As the touch location or other parameters change, UIKit updates the same UITouch object with the new information. The only property that doesn’t change is the view. (Even when the touch location moves outside the original view, the value in the touch’s view property doesn’t change). When the touch ends, UIKit releases the UITouch object.

当发生触摸时，UIKit 会创建一个 UITouch 对象并将其与一个视图关联起来。随着触摸位置或其他参数的变化，UIKit 会更新同一个 UITouch 对象的信息。唯一不会改变的属性是视图（即使触摸位置移出了原始视图，触摸对象的 view 属性的值也不会改变）。当触摸结束时，UIKit 会释放 UITouch 对象。

## Alter the responder chain - 更改响应者链

You can alter the responder chain by overriding the `next` property of your responder objects. When you do this, the next responder is the object that you return.

您可以通过重写响应者对象的 `next` 属性来修改响应者链。这样做的话，下一个响应者就是您返回的对象。

Many UIKit classes already override this property and return specific objects, including:

许多 UIKit 类已经重写了这个属性并返回特定的对象，包括：

- UIView objects. If the view is the root view of a view controller, the next responder is the view controller; otherwise, the next responder is the view’s superview.
- UIView 对象。如果视图是视图控制器的根视图，则下一个响应者是视图控制器；否则，下一个响应者是视图的父视图。

- UIViewController objects.
	- If the view controller’s view is the root view of a window, the next responder is the window object.
	- If the view controller was presented by another view controller, the next responder is the presenting view controller.
- UIViewController 对象。
	- 如果视图控制器的视图是窗口的根视图，则下一个响应者是窗口对象。
	- 如果视图控制器是由另一个视图控制器呈现的，则下一个响应者是呈现视图控制器的视图控制器。

- UIWindow objects. The window’s next responder is the UIApplication object.
- UIWindow对象。窗口的下一个响应者是 UIApplication 对象。

- UIApplication object. The next responder is the app delegate, but only if the app delegate is an instance of UIResponder and isn’t a view, view controller, or the app object itself.
- UIApplication对象。下一个响应者是应用程序委托（app delegate），但前提是应用程序委托是 UIResponder 的实例，并且不是视图、视图控制器或应用程序对象本身。

# See Also - 其他参考

## Essentials - 要素

### class [UIResponder](https://developer.apple.com/documentation/uikit/uiresponder)

An abstract interface for responding to and handling events.

一个用于响应和处理事件的抽象接口。

### class [UIEvent](https://developer.apple.com/documentation/uikit/uievent)

An object that describes a single user interaction with your app.

描述用户与您的应用程序进行的单个交互的对象。