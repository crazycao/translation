# Making a view into a drag source - 将视图变为拖动源

原文地址：
[https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drag_source](https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drag_source)

Adopt drag interaction APIs to provide items for dragging.

采用拖动交互API来提供拖动项。

> iOS 11.0+
iPadOS 11.0+

# Overview 概览

By implementing a drag interaction delegate ([UIDragInteractionDelegate](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate)) for a view, you enable that view to function as a drag source in your app.

通过为视图实现拖动交互代理（[UIDragInteractionDelegate](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate)），您可以使该视图在应用程序中作为拖动源工作。

> **Note** **注意**
>
> The `UITextView`, `UITableView`, and `UICollectionView` classes each provide their own, specialized support for creating drag items. See these classes for more information.
>
> `UITextView`、`UITableView` 和 `UICollectionView` 类分别提供了它们自己的专门支持来创建拖动项。有关更多信息，请参阅这些类。

## Enable a view as a drag source - 将视图作为拖动源

Any instance or subclass of `UIView` can act as a drag source. Your first steps to make this happen are:

1. Create a drag interaction (a [UIDragInteraction](https://developer.apple.com/documentation/uikit/uidraginteraction) instance).
2. Specify the drag interaction’s delegate (an object that conforms to the [UIDragInteractionDelegate](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate) protocol).
3. Add the interaction to the view’s [interactions](https://developer.apple.com/documentation/uikit/uiview/2891054-interactions) property.

任何 `UIView` 的实例或子类都可以作为拖动源。实现此功能的第一步是：

1. 创建一个拖动交互（[UIDragInteraction](https://developer.apple.com/documentation/uikit/uidraginteraction) 实例）。
2. 指定拖动交互的代理（符合 [UIDragInteractionDelegate](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate) 协议的对象）。
3. 将交互添加到视图的 [interactions](https://developer.apple.com/documentation/uikit/uiview/2891054-interactions) 属性中。

Here’s how to do this using a custom helper method, which you’d typically call within a view controller’s [viewDidLoad()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload) method:

以下是使用自定义辅助方法完成此操作的示例，通常您会在视图控制器的 [viewDidLoad()](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload) 方法中调用它：

```
func customEnableDragging(on view: UIView, dragInteractionDelegate: UIDragInteractionDelegate) {
    let dragInteraction = UIDragInteraction(delegate: dragInteractionDelegate)
    view.addInteraction(dragInteraction)
}
```

## Create a drag item - 创建拖动项

A drag item encapsulates a source app’s promises for providing a variety of data representations for one model object.

拖动项封装了源应用程序为一个模型对象提供各种数据表示的 promise。

To create a drag item, implement the [dragInteraction(_:itemsForBeginning:)](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate/2891010-draginteraction) method in your drag interaction delegate, as shown here in a minimal form:

要创建拖动项，请在您的拖动交互代理中实现 [dragInteraction(_:itemsForBeginning:)](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate/2891010-draginteraction) 方法，如下所示：

```
func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
    // Cast to NSString is required for NSItemProviderWriting support.
    // 必须转换为 NSString 才能支持 NSItemProviderWriting。
    let stringItemProvider = NSItemProvider(object: "Hello World" as NSString)
    return [
        UIDragItem(itemProvider: stringItemProvider)
    ]
}
```

>  **Note** **注意**
>
> The cast from the Swift `String` type to the Foundation `NSString` class, in the code snippet above, is required because model objects for drag and drop must support the [NSItemProviderWriting](https://developer.apple.com/documentation/foundation/nsitemproviderwriting) protocol.
> 
> 在上面的代码片段中，从 Swift 的 `String` 类型到 Foundation 的 `NSString` 类的转换是必需的，因为拖放的模型对象必须支持 [NSItemProviderWriting](https://developer.apple.com/documentation/foundation/nsitemproviderwriting) 协议。

This implementation uses the [init(object:)](https://developer.apple.com/documentation/foundation/nsitemprovider/2888328-init) convenience initializer. When you instantiate a drag item, pass an object in your app’s native representation, or in the highest-fidelity representation you support. In general, ensure that the first element in the item provider’s [registeredTypeIdentifiers](https://developer.apple.com/documentation/foundation/nsitemprovider/1403923-registeredtypeidentifiers) array represents the highest-fidelity data your drag interaction delegate can deliver.

此实现使用了 [init(object:)](https://developer.apple.com/documentation/foundation/nsitemprovider/2888328-init) 便利初始化程序。在实例化拖动项时，传递一个使用您应用程序的本地呈现或您支持的最高保真度呈现的对象。通常情况下，确保项目提供者的 [registeredTypeIdentifiers](https://developer.apple.com/documentation/foundation/nsitemprovider/1403923-registeredtypeidentifiers) 数组中的第一个元素代表您的拖动交互代理可以提供的最高保真度数据。

To add more data representations to a drag item, as you typically would in your app, add them in fidelity order, from highest to lowest. When adding representations, you have choices:

- The best option for adding multiple data representations to a drag item, in many cases, is to adopt the [NSItemProviderWriting](https://developer.apple.com/documentation/foundation/nsitemproviderwriting) protocol in your model class. Using this protocol, you place the code for providing multiple data representations within the model class.
- You can use the [registerObject(_:visibility:)](https://developer.apple.com/documentation/foundation/nsitemprovider/2888321-registerobject) method, or related methods, from the [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) class, to explicitly register data representations.

要向拖动项添加更多数据呈现，通常您可以在您的应用程序中使用以下选项：

- 在模型类中采用 [NSItemProviderWriting](https://developer.apple.com/documentation/foundation/nsitemproviderwriting) 协议，这是在许多情况下向拖动项添加多个数据呈现的最佳选项。使用此协议，您可以将提供多个数据呈现的代码放置在模型类中。
- 您可以使用 [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) 类的 [registerObject(_:visibility:)](https://developer.apple.com/documentation/foundation/nsitemprovider/2888321-registerobject) 方法或相关方法，显式注册数据呈现。

## Understand a drag source in context - 在上下文中了解拖动源

In the [dragInteraction(_:itemsForBeginning:)](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate/2891010-draginteraction) protocol method, your source app responds to a request from the system. This request is itself triggered by the user starting to drag an item in your app’s UI. The conversation between your app and the system proceeds as shown here:

在 [dragInteraction(_:itemsForBeginning:)](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate/2891010-draginteraction) 协议方法中，您的源应用程序响应系统的请求。这个请求本身是由用户在您的应用程序 UI 中开始拖动项目触发的。您的应用程序和系统之间的对话如下图所示：

![APIs for providing drag items from a drag source](https://docs-assets.developer.apple.com/published/71ab889a73/2adedf33-7843-4275-9e8c-ade8ed08e016.png)

The figure above depicts the steps for constructing a drag item, in context:

1. The user initiates a drag activity with a long press on a view in your app, followed by moving their finger while still touching the screen. The system instantiates a drag session (an object that conforms to the [UIDragSession](https://developer.apple.com/documentation/uikit/uidragsession) protocol, not shown in the figure) for managing the drag activity.
2. The system calls the drag interaction delegate’s [dragInteraction(_:itemsForBeginning:)](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate/2891010-draginteraction) protocol method. Your delegate returns one or more drag items.
3. Finally, the system populates the drag session with your drag items, ready for the user to move the drag session to a destination.

上图描述了在上下文中构建拖动项的步骤：

1. 用户通过在您的应用程序中的视图上长按，然后在仍然触摸屏幕的情况下移动手指来启动拖动活动。系统实例化一个拖动会话（一个符合 [UIDragSession](https://developer.apple.com/documentation/uikit/uidragsession) 协议的对象，在图中未显示）来管理拖动活动。
2. 系统调用拖动交互代理的 [dragInteraction(_:itemsForBeginning:)](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate/2891010-draginteraction) 协议方法。您的代理返回一个或多个拖动项。
3. 最后，系统将您的拖动项填充到拖动会话中，准备好供用户将拖动会话移动到目标位置。

# See Also - 其他参考

## Essentials - 要素

### Understanding a drag item as a promise - 将拖动项理解为 promise

Use drag items to convey data representation promises between a source app and a destination app.

使用拖动项目在源应用程序和目标应用程序之间传递数据呈现 promises。

### [Making a view into a drag source](https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drag_source) - 将视图变为拖动源

Adopt drag interaction APIs to provide items for dragging.

采用拖动交互 API 来提供拖动项。

### [Making a view into a drop destination](https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drop_destination) - 将视图变为放置目标

Adopt drop interaction APIs to selectively consume dragged content.

采用放置交互 API 来有选择地使用拖动内容。

### [Adopting Drag and Drop in a Custom View](https://developer.apple.com/documentation/uikit/drag_and_drop/adopting_drag_and_drop_in_a_custom_view) - 在自定义视图中采用拖放

Demonstrates how to enable drag and drop for a `UIImageView` instance.

演示了如何为 `UIImageView` 实例启用拖放功能。

### [Adopting Drag and Drop in a Table View](https://developer.apple.com/documentation/uikit/drag_and_drop/adopting_drag_and_drop_in_a_table_view) - 在表视图中采用拖放

Demonstrates how to enable and implement drag and drop for a table view.

演示了如何为表视图启用和实现拖放功能。