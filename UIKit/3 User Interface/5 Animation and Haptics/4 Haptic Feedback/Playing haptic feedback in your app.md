# Playing haptic feedback in your app - 在你的应用程序中播放触觉反馈

原文链接：[https://developer.apple.com/documentation/applepencil/playing-haptic-feedback-in-your-app](https://developer.apple.com/documentation/applepencil/playing-haptic-feedback-in-your-app)

Provide tactile feedback when people perform certain actions in your app.

当用户在您的应用程序中执行某些操作时提供触觉反馈。

# Overview - 概述

Haptic feedback provides a tactile response, such as a tap, that draws attention and reinforces both actions and events. While many system-provided interface elements (for example, pickers, switches, and sliders) automatically provide haptic feedback, you can add feedback to custom views and controls in your app when it’s suitable.

触觉反馈提供触觉响应，例如轻拍，这可以引起注意并加强操作和事件。虽然许多系统提供的界面元素（例如选择器、开关和滑块）会自动提供触觉反馈，但你也可以在适当的时候为应用程序中的自定义视图和控件添加反馈。

## Use feedback intentionally - 有意识地使用反馈

When providing feedback:

在提供反馈时：

- Always use feedback for its intended purpose. Don’t select a haptic because of the way it feels.
- The source of the feedback must be clear to the user. For example, the feedback must match a visual change in the user interface, or must be in response to a user action. Feedback should never come as a surprise.
- Don’t overuse feedback. Overuse can cause confusion and diminish the feedback’s significance.

- 始终将反馈用于其预期目的。不要仅仅因为触觉感受而选择触觉反馈。
- 反馈的来源必须对用户清晰可见。例如，反馈必须与用户界面的视觉变化相匹配，或者必须是对用户操作的响应。反馈不应该让用户感到意外。
- 不要过度使用反馈。过度使用可能会导致混淆并降低反馈的重要性。

For design guidance, read Human Interface Guidelines > [Playing haptics](https://developer.apple.com/design/human-interface-guidelines/playing-haptics).

有关设计指南，请阅读《人机界面指南 > [播放触觉](https://developer.apple.com/design/human-interface-guidelines/playing-haptics)》。

## Choose the type of feedback - 选择反馈的类型

SwiftUI and UIKit have different APIs for providing haptic feedback. Learn more about each style of haptic feedback and choose what makes sense for your app.

SwiftUI 和 UIKit 有不同的 API 用于提供触觉反馈。了解更多关于每种风格的触觉反馈，并选择适合您的应用程序的方式。

To learn more about different types of feedback in UIKit, read:

- [UICanvasFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UICanvasFeedbackGenerator)
- [UIImpactFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UIImpactFeedbackGenerator)
- [UISelectionFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UISelectionFeedbackGenerator)
- [UINotificationFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UINotificationFeedbackGenerator)

要了解更多关于 UIKit 中不同类型反馈的信息，请阅读：

- [UICanvasFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UICanvasFeedbackGenerator)
- [UIImpactFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UIImpactFeedbackGenerator)
- [UISelectionFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UISelectionFeedbackGenerator)
- [UINotificationFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UINotificationFeedbackGenerator)

## Associate the feedback with a view - 将反馈与视图关联

To play haptic feedback in your app, you need to add the feedback to a view.

要在应用程序中播放触觉反馈，您需要将反馈添加到一个视图中。

The following UIKit code example shows how to associate impact feedback with a view.

以下是 UIKit 代码示例，展示了如何将冲击反馈与视图关联。

Create a `UIImpactFeedbackGenerator` object. For the view parameter, pass the view to associate your feedback with.

创建一个 `UIImpactFeedbackGenerator` 对象。对于 view 参数，传入要将您的反馈与之关联的视图。

```
feedback = UIImpactFeedbackGenerator(view: view)
```

## Define when to play feedback - 定义何时播放反馈

Haptic feedback occurs in response to something, like an action or event. You need to define what to trigger feedback in response to.

触觉反馈是对某些事物的响应，比如一个操作或事件。您需要定义在何种情况下触发反馈。

Using the feedback APIs in SwiftUI and UIKit doesn’t play haptics directly. Instead, it informs the system of the event. The system then determines whether to play the haptics based on the device, the app state, the amount of battery power remaining, and other factors.

在 SwiftUI 和 UIKit 中使用反馈 API 不会直接播放触觉反馈。相反，它会通知系统有关事件。然后系统会根据设备、应用程序状态、剩余电量等因素决定是否播放触觉。

For example, haptic feedback plays only:

- On a device with hardware for haptic feedback
- When the app is running in the foreground
- When the system Haptics setting is on

例如，触觉反馈只会在以下情况下播放：

- 在具有触觉反馈硬件的设备上
- 当应用程序在前台运行时
- 当系统触觉设置打开时

Not all types of haptic feedback play on every type of device. As a general rule, trust the system to determine whether it should play feedback. Don’t check the device type or app state to conditionally trigger feedback. After you decide how you want to use feedback, always trigger it when the appropriate events occur. The system ignores any requests that it can’t fulfill.

并非所有类型的触觉反馈都会在每种类型的设备上播放。作为一般准则，信任系统来决定是否应该播放反馈。不要检查设备类型或应用程序状态来有条件地触发反馈。在决定如何使用反馈之后，始终在适当的事件发生时触发它。系统会忽略任何无法满足的请求。

## Play feedback for selection events - 播放选择事件的反馈

Use selection feedback to communicate movement through a series of discrete values. For example, you might trigger selection feedback to indicate that a UI element’s values are changing.

使用选择反馈来传达通过一系列离散值的移动。例如，您可以触发选择反馈来指示 UI 元素的值正在发生变化。

The following UIKit code example shows how to play selection feedback in response to a long-press gesture.

以下是 UIKit 代码示例，展示了如何响应长按手势播放选择反馈。

```
var feedback = UISelectionFeedbackGenerator()


override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create a selection feedback object and associate it with the view.
    // 创建一个选择反馈对象并将其与视图关联。
    feedback = UISelectionFeedbackGenerator(view: view)
    
    // Add a custom long-press gesture to the view.
    // 为视图添加自定义长按手势。
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
    longPressGesture.numberOfTouchesRequired = 2
    view.addGestureRecognizer(longPressGesture)
}


@objc
private func longPress(_ sender: UILongPressGestureRecognizer) {
    if sender.state == .began {
        // Play selection feedback to indicate a selection change.
        // 播放选择反馈以指示选择变化。
        feedback.selectionChanged(at: sender.location(in: view))
        
        // Update the UI in response to a selection change.
        // ...
        // 响应选择变化更新 UI。
        // ...
    }
}
```

## Play feedback for canvas events - 播放画布事件的反馈

Use canvas feedback to indicate when a drawing event occurs, such as an object snapping to a guide or ruler. When using Apple Pencil Pro with a compatible iPad, this type of feedback can provide a tactile response.

使用画布反馈来指示绘图事件的发生，例如对象捕捉到参考线或标尺。在使用兼容 iPad 的 Apple Pencil Pro 时，这种类型的反馈可以提供触觉响应。

The following UIKit code example shows how to use a pan gesture to drag a square, playing haptic feedback to indicate when the square aligns with a gridline on the canvas.

以下是 UIKit 代码示例，展示了如何使用平移手势拖动一个正方形，并在正方形与画布上的网格线对齐时播放触觉反馈。

Optionally, you can call the `prepare()` method to put the feedback generator in a prepared state, which can reduce latency when triggering feedback.

可选择调用 `prepare()` 方法将反馈生成器置于准备状态，这可以在触发反馈时减少延迟。

```
var gridlines: [Gridline] = []
var feedback = UICanvasFeedbackGenerator()


override func viewDidLoad() {
    super.viewDidLoad()
    configureGridlines()
    
    // Create a canvas feedback object and associate it with the view.
    // 创建一个画布反馈对象并将其与视图关联。
    feedback = UICanvasFeedbackGenerator(view: view)
    
    // Draw a basic square and add it to the view hierarchy.
    // 绘制一个基本的正方形并将其添加到视图层次结构中。
    let center = CGPoint(x: view.center.x - 50, y: view.center.y - 50)
    let square = UIView(frame: CGRect(origin: center,
                                     size: CGSize(width: 100, height: 100)))
    square.backgroundColor = .tintColor
    view.addSubview(square)
    
    // Add a pan gesture to allow dragging the square.
    // 添加平移手势以允许拖动正方形。
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragSquare(_:)))
    square.isUserInteractionEnabled = true
    square.addGestureRecognizer(panGesture)
}


@objc
private func dragSquare(_ sender: UIPanGestureRecognizer) {
    guard let square = sender.view else { return }
    
    if sender.state == .began {
        // Prepare the feedback object.
        // 准备反馈对象。
        feedback.prepare()
    }


    // Move the square in response to a pan gesture.
    // 根据平移手势移动正方形。
    let distance = sender.translation(in: view)
    square.center = CGPoint(x: square.center.x + distance.x, y: square.center.y + distance.y)
    sender.setTranslation(CGPoint.zero, in: view)
    
    // Play canvas feedback if the square aligns with one of the gridlines.
    // 如果正方形与网格线之一对齐，则播放画布反馈。
    if square.aligned(gridlines: gridlines) {
        feedback.alignmentOccurred(at: sender.location(in: view))
    }
}
```

# See Also - 其他参考

## Related reference in UIKit - 在 UIKit 中的相关参考资料

### @MainActor class [UIFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UIFeedbackGenerator)

The abstract superclass for all feedback generators.

所有反馈生成器的抽象父类。

### @MainActor class [UICanvasFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UICanvasFeedbackGenerator)

A concrete feedback generator subclass that creates haptics to indicate events on a drawing canvas.

一个具体的反馈生成器子类，用于在绘图画布上指示事件的触觉反馈。

### @MainActor class [UIImpactFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UIImpactFeedbackGenerator)

A concrete feedback generator subclass that creates haptics to simulate physical impacts.

一个具体的反馈生成器子类，用于创建触觉反馈以模拟物理冲击。

### @MainActor class [UISelectionFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UISelectionFeedbackGenerator)

A concrete feedback generator subclass that creates haptics to indicate a change in selection.

一个具体的反馈生成器子类，用于创建触觉反馈以指示选择变化。

### @MainActor class [UINotificationFeedbackGenerator](https://developer.apple.com/documentation/UIKit/UINotificationFeedbackGenerator)

A concrete feedback generator subclass that creates haptics to communicate successes, failures, and warnings.

一个具体的反馈生成器子类，用于创建触觉反馈以传达成功、失败和警告。





