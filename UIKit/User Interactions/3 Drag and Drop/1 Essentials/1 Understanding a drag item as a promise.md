# Understanding a drag item as a promise - 将拖动项理解为 promise

原文地址：
[https://developer.apple.com/documentation/uikit/drag_and_drop/understanding_a_drag_item_as_a_promise](https://developer.apple.com/documentation/uikit/drag_and_drop/understanding_a_drag_item_as_a_promise)

Use drag items to convey data representation promises between a source app and a destination app.

使用拖动项目在源应用程序和目标应用程序之间传递数据呈现 promises。

> iOS 11.0+
iPadOS 11.0+

## Overview 概览

When a user drags an onscreen visual representation of an item in your app, such as a photo, a Maps location, a Calendar event, or a text selection, your app associates the underlying data with a drag item. The drag item, in turn, uses an `item provider`. Your app populates the item provider’s [registeredTypeIdentifiers](https://developer.apple.com/documentation/foundation/nsitemprovider/1403923-registeredtypeidentifiers) array with uniform type identifiers (UTIs).

当用户在您的应用程序中拖动屏幕上的物品的视觉呈现时，比如照片、地图位置、日历事件或文本选择，您的应用程序会将底层数据与拖动项关联起来。拖动项反过来使用了一个“项目提供者”。您的应用程序会将统一类型标识符（UTI）填入项目提供者的 [registeredTypeIdentifiers](https://developer.apple.com/documentation/foundation/nsitemprovider/1403923-registeredtypeidentifiers) 数组。

![A drag item with its contained item provider and array of uniform type identifiers](https://docs-assets.developer.apple.com/published/71ab889a73/54c378c1-9b5c-4ae6-9e92-f65a76917d86.png)

The array of UTIs constitutes the source app’s promise about the specific data representations it can deliver, on request, to a destination app. The term promise means that, at the time your app constructs a drag item, it commits to providing certain data representations but doesn’t yet perform the work to create them. Although it appears to the user that the item itself is being dragged, the drag item instead consists of promises along with a preview image that remains under the user’s touch point onscreen.

UTI数组构成了源应用程序关于它可以按请求交付给目标应用程序的特定数据呈现的 promise。Promise 这个术语意味着，在您的应用程序构建拖动项目时，它承诺提供某些数据呈现，但尚未执行创建它们的工作。尽管对用户而言，似乎是在拖动物品本身，但实际上拖动项目由 promise 和预览图像组成，在屏幕上保持在用户的触摸点下方。

The portion of your app that constructs the drag item is the drag interaction delegate ([UIDragInteractionDelegate](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate)). On the destination side, an app’s drop interaction delegate ([UIDropInteractionDelegate](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate)) interacts with the drag item to consume promised data.

你的 app 中构建拖动项目的部分是拖动交互代理（[UIDragInteractionDelegate](https://developer.apple.com/documentation/uikit/uidraginteractiondelegate)）。在目标 app 侧，应用程序的放置交互代理（[UIDropInteractionDelegate](https://developer.apple.com/documentation/uikit/uidropinteractiondelegate)）与拖动项目交互以使用 promise 的数据。

This table shows the protocols you implement to support constructing or consuming a drag item, depending on whether a view in your app is acting as a source or destination:

下表显示了您要实现的协议，以支持构建或使用拖动项，具体取决于您的应用程序中的视图是作为源还是目标：

Drag-and-drop role|Protocol|Your implementation
|:-:|:-:|:-:|
Source app|[NSItemProviderWriting](https://developer.apple.com/documentation/foundation/nsitemproviderwriting)|Register UTIs|
Destination app|[NSItemProviderReading](https://developer.apple.com/documentation/foundation/nsitemproviderreading)|Request items

The following classes automatically support these protocols: `NSString`, `NSAttributedString`, `NSURL`, `UIColor`, and `UIImage`.

下面几个类自动支持了这些协议：`NSString`、`NSAttributedString`、`NSURL`、`UIColor`、`UIImage`。


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