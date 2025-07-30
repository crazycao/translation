# Positioning content relative to the safe area

# 将内容相对于安全区域进行定位

原文地址：
[https://developer.apple.com/documentation/uikit/positioning-content-relative-to-the-safe-area](https://developer.apple.com/documentation/uikit/positioning-content-relative-to-the-safe-area)

Position views so that they aren’t obstructed by other content.

对视图进行定位，使其不被其他内容遮挡。

## Overview 概览

Views are the fundamental building blocks of your app’s user interface, and the `UIView` class defines the behaviors that are common to all views. A view object renders content within its bounds rectangle, and handles any interactions with that content. The `UIView` class is a concrete class that you can instantiate and use to display a fixed background color. You can also subclass it to draw more sophisticated content. To display labels, images, buttons, and other interface elements commonly found in apps, use the view subclasses that the UIKit framework provides rather than trying to define your own.

视图是应用程序用户界面的基本构建块，`UIView` 类定义了所有视图所共有的行为。视图对象在其边界矩形内渲染内容，并处理与该内容的所有交互。`UIView` 类是一个可以实例化并用于显示固定背景色的具体类（注：与之相对的是抽象类）。你还可以将其子类化以绘制更复杂的内容。要显示应用程序中常见的标签、图像、按钮和其他界面元素，请使用 UIKit 框架提供的视图子类，而不是尝试定义自己的子类。

Because view objects are the main way your application interacts with the user, they have a number of responsibilities. Here are just a few:

因为视图对象是应用程序与用户交互的主要方式，所以它们有很多职责。以下只是其中一部分：

- Drawing and animation

	Views draw content in their rectangular area using UIKit or Core Graphics.

	You can animate some view properties to new values.

- 绘图和动画

	视图使用 UIKit 或 Core Graphics 在矩形区域中绘制内容。
	
	可以将某些视图属性动画化设置为新值。

- Layout and subview management

	Views may contain zero or more subviews.

	Views can adjust the size and position of their subviews.

	Use Auto Layout to define the rules for resizing and repositioning your views in response to changes in the view hierarchy.

- 布局和子视图管理

	视图可以包含零个或多个子视图。
	
	视图可以调整其子视图的大小和位置。
	
	使用“自动布局”定义重新调整视图大小和位置的规则，以响应视图层级中的变化。

- Event handling

	A view is a subclass of `UIResponder` and can respond to touches and other types of events.

	Views can install gesture recognizers to handle common gestures.

- 事件处理

	视图是 `UIResponder` 的子类，可以响应触摸和其他类型的事件。

	视图可以安装手势识别器来处理常见的手势。

Views can nest inside other views to create view hierarchies, which offer a convenient way to organize related content. Nesting a view creates a parent-child relationship between the nested child view (known as the subview) and the parent (known as the superview). A parent view may contain any number of subviews, but each subview has only one superview. By default, when a subview’s visible area extends outside of the bounds of its superview, no clipping of the subview’s content occurs. Use the `clipsToBounds` property to change that behavior.

视图可以嵌套在其他视图中以创建视图层级，这提供了一种方便的方式来组织相关内容。嵌套视图时会在嵌套的子视图（称为 subview）和父视图（称为 superview）之间创建父子关系。父视图可以包含任意数量的子视图，但每个子视图只有一个父视图。默认情况下，当子视图的可见区域超出其超级视图的边界时，不会对子视图的内容进行剪裁。使用 `clipToBounds` 属性可以更改该行为。

The `frame` and `bounds` properties define the geometry of each view. The `frame` property defines the origin and dimensions of the view in the coordinate system of its superview. The `bounds` property defines the internal dimensions of the view as it sees them, and its use is almost exclusive to custom drawing code. The `center` property provides a convenient way to reposition a view without changing its `frame` or `bounds` properties directly.

`frame` 和 `bounds` 属性定义了每个视图的几何图形。`frame` 属性定义视图在其父视图的坐标系中的原点和尺寸。`bounds` 属性定义视图所看到的内部尺寸，几乎仅限于自定义绘图代码中才会用到。`center` 属性提供了一种方便的方法来重新定位视图，而无需直接更改其 `frame` 或 `bounds` 属性。

For detailed information about how to use the `UIView` class, see [View Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503).

有关如何使用 `UIView` 类的详细信息，请参阅《[iOS视图编程指南](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503)》。

## Create a view - 创建视图

Normally, you create views in your storyboards by dragging them from the library to your canvas. You can also create views programmatically. When creating a view, you typically specify its initial size and position relative to its future superview. For example, the following example creates a view and places its top-left corner at the point `(10, 10)` in the superview's coordinate system (once it is added to that superview).

通常，通过将视图从库中拖动到画布中，就可以在故事板中创建视图。你还可以以编程方式创建视图。创建视图时，通常会指定其相对于未来父视图的初始大小和位置。例如，以下示例创建了一个视图，并将其左上角放置在父视图坐标系中的点 `(10, 10)` 处（一旦将其添加到该父视图中）。

```
let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
let myView = UIView(frame: rect)
```

To add a subview to another view, call the `addSubview(_:)` method on the superview. You may add any number of subviews to a view, and sibling views may overlap each other without any issues in iOS. Each call to the `addSubview(_:)` method places the new view on top of all other siblings. You can specify the relative z-order of subview by adding it using the `insertSubview(_:aboveSubview:)` and `insertSubview(_:belowSubview:)` methods. You can also exchange the position of already added subviews using the `exchangeSubview(at:withSubviewAt:)` method.

要将子视图添加到另一个视图，请再父视图上调用 `addSubview(_:)` 方法。你可以添加任意数量的子视图到一个视图中，并且在 iOS 中兄弟视图可以彼此重叠而没有任何问题。每次调用 `addSubview(_:)` 方法都会将新视图放在所有其他兄弟视图之上。你可以使用 `insertSubview(_:aboveSubview:)` 和 `insertSubview(_:belowSubview:)` 方法来添加子视图以指定它在 z 轴上的顺序。你也可以使用 `exchangeSubview(at:withSubviewAt:)` 方法交换已经添加的子视图的位置。

After creating a view, create Auto Layout rules to govern how the size and position of the view change in response to changes in the rest of the view hierarchy. For more information, see [Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853).

在创建视图以后，请创建自动布局规则以控制当视图层级的其他部分变化时该视图的尺寸和位置应该如何相应变化。更多信息，参见《[自动布局指南](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853)》。

## Draw views - 绘制视图

View drawing occurs on an as-needed basis. When a view is first shown, or when all or part of it becomes visible due to layout changes, the system asks the view to draw its contents. For views that contain custom content using UIKit or Core Graphics, the system calls the view’s `draw(_:)` method. Your implementation of this method is responsible for drawing the view’s content into the current graphics context, which is set up by the system automatically prior to calling this method. This creates a static visual representation of your view’s content that can then be displayed on the screen.

视图绘制仅根据需要而发生。当视图首次显示时，或者当由于布局更改而使其全部或部分可见时，系统会要求视图绘制其内容。对于使用 UIKit 或 Core Graphics 包含自定义内容的视图，系统会调用视图的 `draw(_:)` 方法。此方法的实现负责将视图的内容绘制到当前图形上下文中，该上下文在调用此方法之前由系统自动设置。这将创建视图内容的静态视觉表示，然后可以显示在屏幕上。

When the actual content of your view changes, it’s your responsibility to notify the system that your view needs to be redrawn. You do this by calling your view’s `setNeedsDisplay()` or `setNeedsDisplay(_:)` method of the view. These methods let the system know that it should update the view during the next drawing cycle. Because it waits until the next drawing cycle to update the view, you can call these methods on multiple views to update them at the same time.

当视图的实际内容发生更改时，你负责通知系统需要重新绘制。通过调用视图的 `setNeedsDisplay()` 或 `setNeedsDisplay(_:)` 方法来完成此操作。这些方法使系统知道它应该在下一个绘图周期中更新视图。由于会等到下一个绘图周期才更新视图，所以可以在多个视图上调用这些方法以同时更新它们。

> **Note** **注意**
>
> If you’re using OpenGL ES to do your drawing, you should use the `GLKView` class instead of subclassing UIView. For more information about how to draw using OpenGL ES, see [OpenGL ES Programming Guide](https://developer.apple.com/library/archive/documentation/3DDrawing/Conceptual/OpenGLES_ProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008793).
> 
> 如果你使用 OpenGL ES 绘制视图，你应该使用 `GLKView` 类，而不是 `UIView` 的子类。关于如何使用 OpenGL ES 绘制的更多信息，参见《[OpenGL ES 编程指南](https://developer.apple.com/library/archive/documentation/3DDrawing/Conceptual/OpenGLES_ProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008793)》。

For detailed information about the view drawing cycle and the role your views have in this cycle, see [View Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503).

有关视图的绘图周期以及视图在此周期中所扮演的角色的详细信息，请参阅《[iOS视图编程指南](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503)》。

## Animate views - 给视图设置动画

Changes to several view properties can be animated — that is, changing the property creates an animation starting at the current value and ending at the new value that you specify. The following properties of the UIView class are animatable:

对多个视图属性的更改可以被设置为动画 —— 也就是说，更改属性将创建从当前值开始到指定的新值结束的动画。`UIView` 类的以下属性可设置动画：

- frame
- bounds
- center
- transform
- alpha
- backgroundColor

To animate your changes, create a `UIViewPropertyAnimator` object and use its handler block to change the values of your view’s properties. The `UIViewPropertyAnimator` class lets you specify the duration and timing of your animations, but it performs the actual animations. You can pause a property-based animator that’s currently running to interrupt the animation and drive it interactively. For more information, see [UIViewPropertyAnimator](https://developer.apple.com/documentation/uikit/uiviewpropertyanimator).

要给更改设置动画，请创建一个 `UIViewPropertyAnimator` 对象，并使用其句柄 block 更改视图属性的值。`UIViewPropertyAnimator` 类允许你指定动画的持续时间和时间，而它来执行实际的动画。你可以暂停当前正在运行的基于属性的 animator 以中断动画，并以交互的方式启动动画。有关详细信息，请参见 [UIViewPropertyAnimator](https://developer.apple.com/documentation/uikit/uiviewpropertyanimator)。

## Threading considerations - 多线程注意事项

Manipulations to your app’s user interface must occur on the main thread. Thus, you should always call the methods of the `UIView` class from code running in the main thread of your app. The only time this may not be strictly necessary is when creating the view object itself, but all other manipulations should occur on the main thread.

必须在主线程上对应用程序用户界面进行操作。因此，您应该始终从在主线程运行的代码中调用 `UIView` 类的方法。在创建视图对象本身时，这可能不是绝对必要的，但所有其他操作都应该发生在主线程上。

## Subclassing notes - 子类说明

The `UIView` class is a key subclassing point for visual content that also requires user interactions. Although there are many good reasons to subclass `UIView`, it is recommended that you do so only when the basic `UIView` class or the standard system views do not provide the capabilities that you need. Subclassing requires more work on your part to implement the view and to tune its performance.

`UIView` 类是需要用户交互的可视化内容的关键子类化点。尽管有很多好的理由去子类化 `UIView`，但是建议你只在基础 `UIView` 类或者标准系统视图没有提供你需要的功能时才这么做。子类化需要你做更多的工作来实现视图并调整其性能。

For information about ways to avoid subclassing, see [Alternatives to subclassing](https://developer.apple.com/documentation/uikit/uiview#1652896).

关于避免子类化的更多信息，请参见《[子类化替代方案](https://developer.apple.com/documentation/uikit/uiview#1652896)》。

## Methods to override - 要重写的方法

When subclassing `UIView`, there are only a handful of methods you should override and many methods that you might override depending on your needs. Because `UIView` is a highly configurable class, there are also many ways to implement sophisticated view behaviors without overriding custom methods, which are discussed in the [Alternatives to Subclassing](https://developer.apple.com/documentation/uikit/uiview#1652896) section. In the meantime, the following list includes the methods you might consider overriding in your `UIView` subclasses:

当子类化 `UIView` 时，只有少数方法需要重写，还有许多方法你可以根据需要重写。因为 `UIView` 是一个高度可配置的类，所以它也有许多方法可以实现复杂的视图行为，而无需重写自定义方法，这在《[子类化替代方案](https://developer.apple.com/documentation/uikit/uiview#1652896)》一节中有描述。同时，以下列表中包含了你可能考虑在 `UIView` 子类中重写的方法：

- Initialization:
	- [init(frame:)](https://developer.apple.com/documentation/uikit/uiview/1622488-init) - It is recommended that you implement this method. You can also implement custom initialization methods in addition to, or instead of, this method.
	- [init(coder:)](https://developer.apple.com/documentation/foundation/nscoding/1416145-init) - Implement this method if you load your view from storyboards or nib files and your view requires custom initialization.
	- [layerClass](https://developer.apple.com/documentation/uikit/uiview/1622626-layerclass) - Use this property only if you want your view to use a different Core Animation layer for its backing store. For example, if your view uses tiling to display a large scrollable area, you might want to set the property to the `CATiledLayer` class.
- 初始化：
	- [init(frame:)](https://developer.apple.com/documentation/uikit/uiview/1622488-init) —— 建议实现此方法。你也可以实现自定义初始化方法，以补充或者替代此方法。
	- [init(coder:)](https://developer.apple.com/documentation/foundation/nscoding/1416145-init) —— 如果您从故事板或 nib 文件加载视图，并且视图需要自定义初始化，则实现此方法。
	- [layerClass](https://developer.apple.com/documentation/uikit/uiview/1622626-layerclass) —— 仅当你希望视图使用不同的核心动画层作为其后备存储时，才使用此属性。例如，如果视图使用平铺来显示大的可滚动区域，则可能需要将属性设置为 `CATiledLayer` 类。
- Drawing and printing:
	- [draw(_:)](https://developer.apple.com/documentation/uikit/uiview/1622529-draw) - Implement this method if your view draws custom content. If your view does not do any custom drawing, avoid overriding this method.
	- [draw(_:for:)](https://developer.apple.com/documentation/uikit/uiview/1621844-draw) - Implement this method only if you want to draw your view’s content differently during printing.
- 绘制和打印：
	- [draw(_:)](https://developer.apple.com/documentation/uikit/uiview/1622529-draw) —— 如果你的视图要绘制自定义内容，请实现这个方法。如果你的视图不做任何自定义绘制，避免重写这个方法。
	- [draw(_:for:)](https://developer.apple.com/documentation/uikit/uiview/1621844-draw) —— 仅当你希望在打印过程中以不同方式绘制视图的内容时，才实现此方法。
- Layout and Constraints:
	- [requiresConstraintBasedLayout](https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout) - Use this property if your view class requires constraints to work properly.
	- [updateConstraints()](https://developer.apple.com/documentation/uikit/uiview/1622512-updateconstraints) - Implement this method if your view needs to create custom constraints between your subviews.
	- [alignmentRect(forFrame:)](https://developer.apple.com/documentation/uikit/uiview/1622576-alignmentrect), [frame(forAlignmentRect:)](https://developer.apple.com/documentation/uikit/uiview/1622603-frame) - Implement these methods to override how your views are aligned to other views.
	- [didAddSubview(_:)](https://developer.apple.com/documentation/uikit/uiview/1622500-didaddsubview), [willRemoveSubview(_:)](https://developer.apple.com/documentation/uikit/uiview/1622647-willremovesubview) - Implement these methods as needed to track the additions and removals of subviews.
	- [willMove(toSuperview:)](https://developer.apple.com/documentation/uikit/uiview/1622629-willmove), [didMoveToSuperview()](https://developer.apple.com/documentation/uikit/uiview/1622433-didmovetosuperview) - Implement these methods as needed to track the movement of the current view in your view hierarchy.
- 布局和约束：
	- [requiresConstraintBasedLayout](https://developer.apple.com/documentation/uikit/uiview/1622549-requiresconstraintbasedlayout) —— 如果视图类需要约束才能正常工作，请使用此属性。
	- [updateConstraints()](https://developer.apple.com/documentation/uikit/uiview/1622512-updateconstraints) —— 如果视图需要在子视图之间创建自定义约束，请实现此方法。
	- [alignmentRect(forFrame:)](https://developer.apple.com/documentation/uikit/uiview/1622576-alignmentrect), [frame(forAlignmentRect:)](https://developer.apple.com/documentation/uikit/uiview/1622603-frame) —— 实现这些方法以覆盖视图与其他视图的对齐方式。
	- [didAddSubview(_:)](https://developer.apple.com/documentation/uikit/uiview/1622500-didaddsubview), [willRemoveSubview(_:)](https://developer.apple.com/documentation/uikit/uiview/1622647-willremovesubview) —— 根据需要实现这些方法，以跟踪子视图的添加和删除。
	-  [willMove(toSuperview:)](https://developer.apple.com/documentation/uikit/uiview/1622629-willmove), [didMoveToSuperview()](https://developer.apple.com/documentation/uikit/uiview/1622433-didmovetosuperview) —— 根据需要实现这些方法，以跟踪视图层次结构中当前视图的移动。
- Event Handling:
	- [gestureRecognizerShouldBegin(_:)](https://developer.apple.com/documentation/uikit/uiview/1622460-gesturerecognizershouldbegin) - Implement this method if your view handles touch events directly and might want to prevent attached gesture recognizers from triggering additional actions.
	- [touchesBegan(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan), [touchesMoved(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621107-touchesmoved), [touchesEnded(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621084-touchesended), [touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled) - Implement these methods if you need to handle touch events directly. (For gesture-based input, use gesture recognizers.)
- 事件处理：
	- [gestureRecognizerShouldBegin(_:)](https://developer.apple.com/documentation/uikit/uiview/1622460-gesturerecognizershouldbegin) —— 如果你的视图直接处理触摸事件，并且可能希望防止附加的手势识别器触发其他动作，则实现此方法。
	- [touchesBegan(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan), [touchesMoved(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621107-touchesmoved), [touchesEnded(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621084-touchesended), [touchesCancelled(_:with:)](https://developer.apple.com/documentation/uikit/uiresponder/1621116-touchescancelled) —— 如果需要直接处理触摸事件，则实现这些方法。（对于基于手势的输入，请使用手势识别器。）

## Alternatives to subclassing - 子类化的替代方案

Many view behaviors can be configured without the need for subclassing. Before you start overriding methods, consider whether modifying the following properties or behaviors would provide the behavior you need.

许多视图行为可以在不需要子类化的情况下进行配置。在开始重写方法之前，请考虑修改以下属性或行为是否可以提供所需的行为。

 - [addConstraint(_:)](https://developer.apple.com/documentation/uikit/uiview/1622523-addconstraint) - Define automatic layout behavior for the view and its subviews.
- [autoresizingMask](https://developer.apple.com/documentation/uikit/uiview/1622559-autoresizingmask) - Provides automatic layout behavior when the superview’s frame changes. These behaviors can be combined with constraints.
- [contentMode](https://developer.apple.com/documentation/uikit/uiview/1622619-contentmode) - Provides layout behavior for the view’s content, as opposed to the frame of the view. This property also affects how the content is scaled to fit the view and whether it is cached or redrawn.
- [isHidden](https://developer.apple.com/documentation/uikit/uiview/1622585-ishidden) or [alpha](https://developer.apple.com/documentation/uikit/uiview/1622417-alpha) - Change the transparency of the view as a whole rather than hiding or applying `alpha` to your view’s rendered content.
- [backgroundColor](https://developer.apple.com/documentation/uikit/uiview/1622591-backgroundcolor) - Set the view’s color rather than drawing that color yourself.
- Subviews - Rather than draw your content using a [draw(_:)](https://developer.apple.com/documentation/uikit/uiview/1622529-draw) method, embed image and label subviews with the content you want to present.
- Gesture recognizers - Rather than subclass to intercept and handle touch events yourself, you can use gesture recognizers to send an action to a target object.
- Animations - Use the built-in animation support rather than trying to animate changes yourself. The animation support provided by Core Animation is fast and easy to use.
- Image-based backgrounds - For views that display relatively static content, consider using a `UIImageView` object with gesture recognizers instead of subclassing and drawing the image yourself. Alternatively, you can also use a generic `UIView` object and assign your image as the content of the view’s `CALayer` object.

- [addConstraint(_:)](https://developer.apple.com/documentation/uikit/uiview/1622523-addconstraint) —— 定义视图及其子视图的自动布局行为。
- [autoresizingMask](https://developer.apple.com/documentation/uikit/uiview/1622559-autoresizingmask) —— 在父视图的框架更改时提供自动布局行为。这些行为可以与约束相结合。
- [contentMode](https://developer.apple.com/documentation/uikit/uiview/1622619-contentmode) —— 提供视图内容的布局行为，而不是视图框架。此属性还影响如何缩放内容以适应视图，以及是否缓存或重绘内容。
- [isHidden](https://developer.apple.com/documentation/uikit/uiview/1622585-ishidden) 或 [alpha](https://developer.apple.com/documentation/uikit/uiview/1622417-alpha) —— 整体更改视图的透明度，而不是将 `alpha` 隐藏或应用于视图的渲染内容。
- [backgroundColor](https://developer.apple.com/documentation/uikit/uiview/1622591-backgroundcolor) —— 设置视图的颜色，而不是自己绘制颜色。
- 子视图 —— Rather than draw your content using a [draw(_:)](https://developer.apple.com/documentation/uikit/uiview/1622529-draw) method, embed image and label subviews with the content you want to present. 不要使用 [draw(_:)](https://developer.apple.com/documentation/uikit/uiview/1622529-draw) 方法绘制内容，而是嵌入带有你想要展示的内容的 image 和 label 子视图。
- 手势识别器 —— 你可以使用手势识别器向目标对象发送动作，而不是自己拦截和处理触摸事件。
- 动画 —— 使用内置的动画支持，而不是尝试自己修改动画。Core Animation 提供的动画支持执行快速且易于使用。
- 基于图像的背景 —— 对于显示相对静态内容的视图，请考虑使用带有手势识别器的 `UIImageView` 对象，而不是自己子类化和绘制图像。或者，也可以使用通用 `UIView` 对象并将图像指定为视图的 `CALayer` 对象的内容。

Animations are another way to make visible changes to a view without requiring you to subclass and implement complex drawing code. Many properties of the `UIView` class are animatable, which means changes to those properties can trigger system-generated animations. Starting animations requires as little as one line of code to indicate that any changes that follow should be animated. For more information about animation support for views, see [Animate views](https://developer.apple.com/documentation/uikit/uiview#1652828).

动画是对视图进行可见更改的另一种方式，无需您子类化和实现复杂的绘图代码。`UIView` 类的许多属性都是可设置动画的，这意味着对这些属性的更改会触发系统生成的动画。启动动画只需要一行代码就可以指示接下来的任何更改都应该设置动画。有关视图动画支持的详细信息，请参见《[为视图设置动画](https://developer.apple.com/documentation/uikit/uiview#1652828)》。


# Topics 主题

……


