# Making a view into a drop destination - 将视图变为放置目标

原文地址：
[https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drop_destination](https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drop_destination)

Adopt drop interaction APIs to selectively consume dragged content.

采用放置交互 API 来有选择地消费拖动内容。

> iOS 11.0+
iPadOS 11.0+

# Overview 概览

By implementing a drop interaction delegate ([UIDropInteractionDelegate](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate)) for a view, you enable that view to accept dropped items.

通过为视图实现放置交互代理（[UIDropInteractionDelegate](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate)），您可以使该视图在应用程序中接受放置项。

> **Note** **注意**
>
> The `UITextView`, `UITableView`, and `UICollectionView` classes each provide their own, specialized support for consuming drag items. See these classes for more information.
>
> `UITextView`、`UITableView` 和 `UICollectionView` 类分别提供了它们自己的专门支持来使用放置项。有关更多信息，请参阅这些类。

## Enable a view as a drop destination - 将视图作为为放置目标

Any instance or subclass of `UIView` can act as a drop destination. Your first steps to make this happen are:

1. Create a drop interaction (a [UIDropInteraction](https://developer.apple.com/documentation/uikit/uidropinteraction) instance).
2. Specify the drop interaction’s delegate (an object that conforms to the [UIDropInteractionDelegate](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate) protocol).
3. Add the interaction to the view’s interactions property.

任何 `UIView` 的实例或子类都可以作为放置目标。实现此功能的第一步是：

1. 创建一个放置交互（[UIDropInteraction](https://developer.apple.com/documentation/uikit/uidropinteraction) 实例）。
2. 指定放置交互的代理（符合 [UIDropInteractionDelegate](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate) 协议的对象）。
3. 将交互添加到视图的 [interactions](https://developer.apple.com/documentation/uikit/uiview/2891054-interactions) 属性中。

Here’s how to do this:

以下是如何实现这一点的示例：

```
func customEnableDropping(on view: UIView, dropInteractionDelegate: UIDropInteractionDelegate) {
    let dropInteraction = UIDropInteraction(delegate: dropInteractionDelegate)
    view.addInteraction(dropInteraction)
}
```

## Consider accepting the drag items - 考虑接受拖动项

When the user moves the touch point of a drag session over a drop destination, you can immediately refuse it, or you can tell the system to continue its conversation with your delegate object. Provide your response as follows:

当用户将拖动会话的触摸点移动到放置目标上时，您可以立即拒绝它，或者告诉系统继续与您的委托对象进行交流。您可以按以下方式提供响应：

```
func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
	// Ensure the drop session has an object of the appropriate type
	// 确保放置会话具有适当类型的对象
	return session.canLoadObjects(ofClass: UIImage.self)
}
```

This example assumes that your drop destination can consume only `UIImage` objects. The method implementation tests for this type in the return statement. You can also use this method to refuse a drop session based on the state of your app. The drop session is a system-managed object that conforms to the [UIDropSession](https://developer.apple.com/documentation/uikit/uidropsession) protocol. You can access a drop session for information about the items being dropped.

此示例假设您的放置目标只能消费 `UIImage` 对象。方法实现在返回语句中测试该类型。您还可以使用此方法根据应用程序的状态拒绝放置会话。放置会话是一个由系统管理的对象，其遵循 [UIDropSession](https://developer.apple.com/documentation/uikit/uidropsession) 协议。您可以访问放置会话以获取有关被放置项的信息。

The [dropInteraction(:canHandle:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890887-dropinteraction) method is your app’s only chance to respond to the system’s question about whether your app will consider accepting the items. For example, you might preemptively reject a drop session if it contains no data representations your app can consume, or if consuming dragged items is inappropriate given your app state. Your app’s definitive opportunity to accept or reject dropped items is in your implementation of the [dropInteraction(:sessionDidUpdate:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890888-dropinteraction) protocol method.

[dropInteraction(:canHandle:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890887-dropinteraction) 方法是您的应用程序考虑系统关于是否愿意接受这些项的问题的唯一机会。例如，如果放置会话不包含您的应用程序可以消费的数据呈现，或者在给定应用程序状态下使用拖动项是不适当的，您可以事先拒绝放置会话。您的应用程序接受或拒绝被放置项的决定性机会是在您实现的 [dropInteraction(:sessionDidUpdate:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890888-dropinteraction) 协议方法中。

## Provide the required drop proposal - 提供必要的放置建议

For a view to be eligible to accept the data from a drop session, you **must** implement the [dropInteraction(_:sessionDidUpdate:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890888-dropinteraction) protocol method. In your implementation, return a drop proposal—a [UIDropProposal](https://developer.apple.com/documentation/uikit/uidropproposal) object that specifies the drop operation type, a constant from the [UIDropOperation](https://developer.apple.com/documentation/uikit/uidropoperation) enumeration.

要使视图有资格接受来自放置会话的数据，您**必须**实现 [dropInteraction(_:sessionDidUpdate:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890888-dropinteraction) 协议方法。在您的实现中，返回一个放置建议（一个 [UIDropProposal](https://developer.apple.com/documentation/uikit/uidropproposal) 对象，该对象指定放置操作类型，操作类型是 [UIDropOperation](https://developer.apple.com/documentation/uikit/uidropoperation) 枚举中的一个常量）。

Provide a drop proposal like this:

可以像这样提供放置建议：

```
func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    // Propose to the system to copy the item from the source app
    // 建议系统从源应用程序复制项目
    return UIDropProposal(operation: .copy)
}
```

If your app instead opts to refuse the dropped items, return the [UIDropOperation.cancel](https://developer.apple.com/documentation/uikit/uidropoperation/cancel) constant.

如果您的应用程序选择拒绝被放置项，可以返回 [UIDropOperation.cancel](https://developer.apple.com/documentation/uikit/uidropoperation/cancel) 常量。

The system calls this protocol method when the user has moved the touch point of a drag session over a drop-enabled view — as long as the view didn’t already reject the drop by returning `false ` in its [dropInteraction(_:canHandle:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890887-dropinteraction) method (see [Consider accepting the drag items](https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drop_destination#2903627)).

当用户将拖动会话的触摸点移动到启用了放置的视图上时，系统会调用此协议方法——前提是视图没有在其 [dropInteraction(_:canHandle:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890887-dropinteraction) 方法中返回 `false` 拒绝放置（请参阅《[考虑接受拖动项](https://developer.apple.com/documentation/uikit/drag_and_drop/making_a_view_into_a_drop_destination#2903627)》）。

## Consume the data in the drag items - 消费拖动项中的数据

The final step of the conversation between the drop interaction delegate and the system is when your app consumes the data the user has dragged from the source app. Here, your drop interaction delegate asks the drop session to load its drag items:

放置交互委托与系统之间的对话的最后一步是您的应用程序消费用户从源应用程序拖动的数据。在这里，您的放置交互委托要求放置会话加载其拖动项：

```
func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    // Consume drag items (in this example, of type `UIImage`).
    // 消费拖动项（在本示例中为 `UIImage` 类型）。
    session.loadObjects(ofClass: UIImage.self) { imageItems in
        let images = imageItems as! [UIImage]
        self.imageView.image = images.first
    }
    // Perform additional UI updates as needed.
    // 根据需要执行其他 UI 更新。
}
```

The [dropInteraction(_:performDrop:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890889-dropinteraction) method is a destination app’s only opportunity to request representations of drag items. Receiving the items is potentially time-consuming and proceeds asynchronously. Don’t wait within this method to receive items; instead, return from this method quickly.

[dropInteraction(_:performDrop:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890889-dropinteraction) 方法是目标应用程序请求拖动项呈现的唯一机会。接收这些项可能是耗时的，并以异步方式进行。不要在此方法中等待接收项目；而是尽快从此方法返回。

> **Note**
>
> If you don’t employ the [loadObjects(ofClass:completion:)](https://developer.apple.com/documentation/uikit/uidropsession/2891058-loadobjects) convenience method as shown above, which automatically employs the main thread, explicitly dispatch UI work to the main thread. For example, you can use the `DispatchQueue.main.async` function.
> 
> 如果您不使用上述所示的 [loadObjects(ofClass:completion:)](https://developer.apple.com/documentation/uikit/uidropsession/2891058-loadobjects) 便利方法（该方法自动使用主线程），请明确将 UI 工作调度到主线程。例如，可以使用 `DispatchQueue.main.async` 函数。

## Understand a drop destination in context - 在上下文中了解放置目标

When the touch point for a drop session moves over a view that you’ve configured as a drop destination, the system initiates a conversation with the drop interaction delegate. This conversation gives your app opportunities to accept or reject the drop, to prepare for consuming the drag items, and to update your model and UI, as shown here:

当放置会话的触摸点移动到您配置为放置目标的视图上时，系统会与放置交互委托启动对话。这个对话给了您的应用程序机会来接受或拒绝放置，为消费拖动项做准备，并更新您的模型和UI，如下所示：

![APIs for consuming data from drag items in a drop destination](https://docs-assets.developer.apple.com/published/71ab889a73/df925141-2567-4fdf-b2b5-7c04c2051a46.png)

The figure above depicts the steps for consuming a drag item, in context:

1. The user moves their finger onscreen so the touch point of a drag session is within a configured view in your app. The system instantiates a drop session (an object that conforms to the [UIDropSession](https://developer.apple.com/documentation/uikit/uidropsession) protocol, not shown in the figure) for managing the drop activity.
2. The system calls the drop interaction delegate’s [dropInteraction(_:canHandle:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890887-dropinteraction) protocol method. Check whether your app can, and opts to, consume the drag items.
3. The system calls the delegate’s [dropInteraction(_:sessionDidEnter:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890880-dropinteraction) protocol method. Prepare to consume the drag items.
4. The system calls the delegate’s [dropInteraction(_:sessionDidUpdate:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890888-dropinteraction) protocol method. Your implementation **must** return a [UIDropProposal](https://developer.apple.com/documentation/uikit/uidropproposal) object, or the system ends the session.
5. If the user confirms their intent to complete the drop, the system calls the delegate’s asynchronous [dropInteraction(_:performDrop:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890889-dropinteraction) protocol method. This a destination app’s only opportunity to request representations of drag items.

上图描述了在上下文中消费拖动项的步骤：

1. 用户在屏幕上移动手指，使拖动会话的触摸点位于您应用程序的一个配置视图中。系统为管理放置活动实例化一个放置会话（一个符合 [UIDropSession](https://developer.apple.com/documentation/uikit/uidropsession) 协议的对象，在图中未显示）。
2. 系统调用放置交互委托的 [dropInteraction(_:canHandle:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890887-dropinteraction) 协议方法。检查您的应用程序是否可以且选择消费拖动项。
3. 系统调用委托的 [dropInteraction(_:sessionDidEnter:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890880-dropinteraction) 协议方法。准备消费拖动项。
4. 系统调用委托的 [dropInteraction(_:sessionDidUpdate:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890888-dropinteraction) 协议方法。您的实现**必须**返回一个 [UIDropProposal](https://developer.apple.com/documentation/uikit/uidropproposal) 对象，否则系统将结束会话。
5. 如果用户确认完成放置的意图，系统将调用委托的异步 [dropInteraction(_:performDrop:)](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate/2890889-dropinteraction) 协议方法。这是目标应用程序请求拖动项呈现的唯一机会。

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