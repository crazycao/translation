# UICollectionViewDropDelegate

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate)

The interface for handling drops in a collection view.

用于处理集合视图中的 drop 的接口。

> iOS 11.0+
iPadOS 11.0+
Mac Catalyst 13.1+
visionOS 1.0+

```
@MainActor
protocol UICollectionViewDropDelegate
```

# Overview - 概览

Implement this protocol in the object that you use to incorporate dropped data into your collection view. The only required method of this protocol is the [collectionView(_:performDropWith:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) method, but you can implement other methods as needed to customize the drop behavior of your collection view.

在用于将 drop 的数据合并到集合视图中的对象中实现此协议。此协议唯一需要的方法是 [collectionView(_:performDropWith:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) 方法，但您可以根据需要实现其他方法来自定义集合视图的放置行为。

Assign your custom delegate object to the [dropDelegate](https://developer.apple.com/documentation/uikit/uicollectionview/2897491-dropdelegate) property of your collection view.

将自定义委托对象指定给集合视图的 [dropDelegate](https://developer.apple.com/documentation/uikit/uicollectionview/2897491-dropdelegate) 属性。

# Topics - 主题

## Declaring support for handling drops - 声明支持处理拖放

### func [collectionView(UICollectionView, canHandle: any UIDropSession) -> Bool](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897386-collectionview)

Asks your delegate whether the collection view can accept a drop with the specified type of data.

询问您的代理是否允许集合视图接受具有指定数据类型的拖放操作。

## Incorporating the dropped data - 将拖放的数据合并到集合视图中

### func [collectionView(UICollectionView, performDropWith: any UICollectionViewDropCoordinator)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) 

Tells your delegate to incorporate the drop data into the collection view.【Required】

告诉您的委托将拖放数据合并到集合视图中。【必须的】

## Tracking the drag movements - 跟踪拖动过程

### func [collectionView(UICollectionView, dropSessionDidUpdate: any UIDropSession, withDestinationIndexPath: IndexPath?) -> UICollectionViewDropProposal](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897375-collectionview)

Tells your delegate that the position of the dragged data over the collection view changed.

告诉您的代理拖动的数据在集合视图上的位置发生了变化。

### func [collectionView(UICollectionView, dropSessionDidEnter: any UIDropSession)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897329-collectionview)

Notifies you when dragged content enters the collection view’s bounds rectangle.

在拖动内容进入集合视图的边界矩形时通知您。

### func [collectionView(UICollectionView, dropSessionDidExit: any UIDropSession)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897416-collectionview)

Notifies you when dragged content exits the collection view’s bounds rectangle.

在拖动内容离开集合视图的边界矩形时通知您。

### func [collectionView(UICollectionView, dropSessionDidEnd: any UIDropSession)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897291-collectionview)

Notifies you when the drag operation ends.

在拖动操作结束时通知您。

## Providing a custom preview - 提供自定义预览

### func [collectionView(UICollectionView, dropPreviewParametersForItemAt: IndexPath) -> UIDragPreviewParameters?](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2921636-collectionview)

Returns custom information about how to display the item at the specified location during the drop.

返回有关如何在指定位置显示项目的自定义信息，用于拖放操作。

# See Also - 其他参考

## Drag and drop - 拖和放

### [Supporting Drag and Drop in Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/supporting_drag_and_drop_in_collection_views) - 支持在集合视图中的拖和放

Initiate drags and handle drops from a collection view.

从集合视图发起拖动并处理拖放。

### protocol [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate)

The interface for initiating drags from a collection view.

用于从集合视图发起拖动的接口。

#### protocol [UICollectionViewDropCoordinator](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator)

An interface for coordinating your custom drop-related actions with the collection view.

用于将自定义拖放相关操作与集合视图协调的接口。

### class [UICollectionViewDropPlaceholder](https://developer.apple.com/documentation/uikit/uicollectionviewdropplaceholder)

A placeholder for an item dropped on a collection view.

集合视图中放置项的占位符。

### class [UICollectionViewDropProposal](https://developer.apple.com/documentation/uikit/uicollectionviewdropproposal)

Your proposed solution for handling a drop in a collection view.

您处理集合视图中放置操作的建议解决方案。

### protocol [UICollectionViewDropItem](https://developer.apple.com/documentation/uikit/uicollectionviewdropitem)

The data associated with an item being dropped into the collection view.

与放置到集合视图中的项目相关联的数据。

### protocol [UICollectionViewDropPlaceholderContext](https://developer.apple.com/documentation/uikit/uicollectionviewdropplaceholdercontext)

An object that contains information about a placeholder in the collection view.

包含有关集合视图中占位符的信息的对象。

### protocol [UIDataSourceTranslating](https://developer.apple.com/documentation/uikit/uidatasourcetranslating)

An advanced interface for managing a data source object.

用于管理数据源对象的高级接口。

### class [UICollectionViewPlaceholder](https://developer.apple.com/documentation/uikit/uicollectionviewplaceholder)

A placeholder for an item dragged or dropped on a collection view.

集合视图中被拖动或放置的项的占位符。

