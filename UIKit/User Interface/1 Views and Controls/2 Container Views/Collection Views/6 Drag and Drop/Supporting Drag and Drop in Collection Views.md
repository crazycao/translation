# Supporting Drag and Drop in Collection Views

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/supporting_drag_and_drop_in_collection_views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/supporting_drag_and_drop_in_collection_views)

Initiate drags and handle drops from a collection view.

从集合视图启动拖放操作。

> iOS 11.0+
iPadOS 11.0+

## Overview 概览

Collection views support drag and drop through a specialized API that works with the items being displayed. To support drags, define a drag delegate object—an object that adopts the [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate) protocol—and assign it to the [dragDelegate](https://developer.apple.com/documentation/uikit/uicollectionview/2897404-dragdelegate) property of your collection view. To handle drops, define a drop delegate object—an object that adopts the UICollectionViewDropDelegate protocol—and assign it to the dropDelegate property of your collection view.

集合视图通过一个专门的 API 来支持拖放操作，该 API 与正在显示的项进行交互。要支持拖动操作，需要定义一个拖动代理对象，即采用 [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate) 协议的对象，并将其分配给集合视图的 [dragDelegate](https://developer.apple.com/documentation/uikit/uicollectionview/2897404-dragdelegate) 属性。要处理放置操作，需要定义一个放置代理对象，即采用 [UICollectionViewDropDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate) 协议的对象，并将其分配给集合视图的 [dropDelegate](https://developer.apple.com/documentation/uikit/uicollectionview/2897491-dropdelegate) 属性。

## Drag Items from the Collection View - 从集合视图中拖动项目

The collection view manages most drag-related interactions, but you need to specify which items to drag. When the drag gesture occurs, the collection view creates a drag session and calls the [collectionView(_:itemsForBeginning:at:)](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate/2897389-collectionview) method of your drag delegate object. If you return a non empty array from that method, the collection view begins dragging the items that you specify. Return an empty array when you do not allow the user to drag the items from the specified index path.

集合视图管理大部分与拖动相关的交互，但您需要指定要拖动的项目。当发生拖动手势时，集合视图会创建一个拖动会话，并调用您的拖动代理对象的 [collectionView(_:itemsForBeginning:at:)](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate/2897389-collectionview) 方法。如果您从该方法返回一个非空数组，集合视图将开始拖动您指定的项目。当不允许用户从指定的索引路径拖动项目时，请返回一个空数组。

> **Note**
> 
> Use the other methods of the [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate) protocol to manage additional drag-related interactions. For example, you can customize the appearance of the items being dragged and let the user add items to the current drag session.
> 
> 使用 [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate) 协议的其他方法来管理额外的与拖动相关的交互。例如，您可以自定义正在拖动的项目的外观，并允许用户向当前拖动会话添加项目。

In your implementation of the [collectionView(_:itemsForBeginning:at:)](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate/2897389-collectionview) method, do the following:

1. Create one or more [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) objects. Use the item providers to represent the data for your collection view’s items.
2. Wrap each item provider object in a [UIDragItem](https://developer.apple.com/documentation/uikit/uidragitem) object.
3. Consider assigning a value to the [localObject](https://developer.apple.com/documentation/uikit/uidragitem/2890981-localobject) property of each drag item. This step is optional but makes it faster to drag and drop content within the same app.
4. Return the drag items from your method.

在 [collectionView(_:itemsForBeginning:at:)](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate/2897389-collectionview) 方法的实现中，执行以下操作：

1. 创建一个或多个 [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) 对象。使用这些项目提供者来表示集合视图项目的数据。
2. 将每个项目提供者对象包装在一个 [UIDragItem](https://developer.apple.com/documentation/uikit/uidragitem) 对象中。
3. 考虑为每个拖动项的 [localObject](https://developer.apple.com/documentation/uikit/uidragitem/2890981-localobject) 属性分配一个值。此步骤是可选的，但可以使在同一应用程序中拖放内容更快。
4. 从方法中返回拖动项。

Use the provided index path to determine which items to drag. If the item is part of the set of currently selected items, the collection view automatically drags all of the selected items. If the item is not part of the current selection, the collection view adds it to the drag operation.

使用提供的索引路径来确定要拖动的项目。如果该项目是当前选中项目集合的一部分，集合视图会自动拖动所有选中项目。如果该项不是当前选择的一部分，集合视图会将其添加到拖动操作中。

For more information about initiating drags, see [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate).

有关启动拖动的更多信息，请参阅 [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate)。

## Receive Dropped Content - 接收放置的内容

When content is dragged inside its bounds, a collection view consults its drop delegate to determine whether it can receive the dragged data. Initially, the collection view calls only the [collectionView(_:canHandle:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897386-collectionview) method of the drop delegate to determine whether you can incorporate the specified data into your data source. If you can incorporate the data, the collection view begins calling other methods to determine where the data can be dropped.

当内容在集合视图的范围内被拖动时，集合视图会查询其放置委托以确定是否可以接收拖动的数据。开始时，集合视图仅调用放置委托的 [collectionView(_:canHandle:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897386-collectionview) 方法来确定是否可以将指定的数据合并到数据源中。如果可以合并数据，则集合视图开始调用其他方法来确定可以在何处放置数据。

As the user’s finger moves, the collection view tracks the potential drop location and notifies your delegate by calling its [collectionView(_:dropSessionDidUpdate:withDestinationIndexPath:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897375-collectionview) method for each change. Implementing this method is optional but recommended, because it lets the collection view display visual feedback about how dragged items will be incorporated. In your implementation, create a [UICollectionViewDropProposal](https://developer.apple.com/documentation/uikit/uicollectionviewdropproposal) object with information about how you would respond to a drop at the specified index path. For example, you might want to insert the content as a new item into your data source or you might add the data into the existing item at the specified index path. Because the method is called frequently, return your proposal as quickly as possible. If you do not implement this method, the collection view does not provide visual feedback about how it handles the drop.

随着用户手指的移动，集合视图会跟踪潜在的放置位置，并通过调用其放置委托的 [collectionView(_:dropSessionDidUpdate:withDestinationIndexPath:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897375-collectionview) 方法来通知您每个变化。实现此方法是可选的，但建议实现，因为它可以让集合视图显示关于如何合并拖动项的视觉反馈。在您的实现中，创建一个 [UICollectionViewDropProposal](https://developer.apple.com/documentation/uikit/uicollectionviewdropproposal) 对象，在该对象中添加在指定的索引路径处如何响应放置的相关信息。例如，您可能希望将内容作为新项插入到数据源中，或者您可能希望将数据添加到指定索引路径处的现有项目中。由于该方法频繁调用，请尽快返回您的建议。如果不实现此方法，集合视图将不提供关于如何处理放置的视觉反馈。

When the user commits the drop by lifting the associated finger from the screen, the collection view calls the [collectionView(_:performDropWith:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) method of your drop delegate. You must implement this method to handle the dropped data. In your implementation, fetch the dragged data, update your collection view’s data source, and insert any needed items into the collection view itself. If the items originated in the collection view itself, you can usually just rearrange the items directly using existing collection view APIs. For content that came from outside the collection view, use the [localObject](https://developer.apple.com/documentation/uikit/uidragitem/2890981-localobject) property (for content that originated inside your app) or the [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) object to fetch the data and insert it.

当用户将关联的手指从屏幕上抬起来以提交放置时，集合视图会调用放置委托的 [collectionView(_:performDropWith:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) 方法。您必须实现此方法来处理已放置的数据。在您的实现中，获取拖动的数据，更新集合视图的数据源，并将任何需要的项目插入到集合视图本身中。如果项目起源于集合视图本身，通常可以直接使用现有的集合视图 API 重新排列项。对于来自集合视图外部的内容，请使用 [localObject](https://developer.apple.com/documentation/uikit/uidragitem/2890981-localobject) 属性（对于起源在您的应用程序内部的内容）或 [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) 对象来获取数据并插入。

In your implementation of the [collectionView(_:performDropWith:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) method, do the following:

1. Iterate over the items property in the provided drop coordinator object.
2. For each item, determine how you want to handle its content:

	- If the `sourceIndexPath` of the item contains a value, the item originated in the collection view. Use a batch update to delete the item from its current location and insert it at the new index path.
	- If the `localObject` property of the drag item is set, the item originated from elsewhere in your app so you must insert an item or update an existing item.
	- If no other option is available, use the `NSItemProvider` in the drag item’s `itemProvider` property to fetch the data asynchronously and insert or update the item.

3. Update your data source and insert or move the necessary items in the collection view.

在 [collectionView(_:performDropWith:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate/2897304-collectionview) 方法的实现中，执行以下操作：

1. 对提供的放置协调器对象上的 items 的属性进行迭代。
2. 对于每个项，确定如何处理其内容：
	- 如果项目的 `sourceIndexPath` 属性包含一个值，则项目起源于集合视图。使用批量更新从当前位置删除该项，并将其插入到新的索引路径处。
	- 如果拖动项目的 `localObject` 属性已设置，则该项目起源于您的应用程序中的其他位置，因此您必须插入一个新项目或更新现有项目。
	- 如果没有其他选项可用，请使用拖动项目的 `itemProvider` 属性中的 `NSItemProvider` 异步获取数据并插入或更新项目。
3. 更新数据源并在集合视图中插入或移动必要的项目。

For items that are already local to your app, you can usually update your collection view’s data source and interface directly. For example, you might use a batch update to delete and then insert an item that originated from the collection view. When finished, call the [drop(_:toItemAt:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator/2897310-drop) method of the drop coordinator to animate the insertion of the dragged content into the collection view.

对于已存在于您的应用程序中的项目，通常可以直接更新集合视图的数据源和界面。例如，您可以使用批量更新来删除然后插入从集合视图起源的项目。完成后，调用放置协调器的 [drop(_:toItemAt:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator/2897310-drop) 方法以使拖动的内容动画插入到集合视图中。

For data that must be retrieved using an [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) object, insert a placeholder into the collection view until you are able to retrieve the actual data. Inserting a placeholder is necessary only when inserting new items into the collection view. The placeholder acts as a temporary item in the collection view, presenting the default content you want to display until the actual data becomes available. For example, you might provide a placeholder cell with a text field stating that the content is currently loading.

对于必须使用 [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) 对象检索的数据，请在将实际数据检索出来之前，在集合视图中插入一个占位符。只有在将新项目插入到集合视图中时，才需要插入占位符。占位符在集合视图中充当临时项目，展示默认内容，直到实际数据可用。例如，您可以提供一个带有文本字段的占位符单元格，指示内容当前正在加载中。

To insert a placeholder into the collection view, do the following:

1. Call the [drop(_:to:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator/2921634-drop) method of the provided [UICollectionViewDropCoordinator](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator) object to insert your placeholder cell into the collection view.
2. Begin loading the data asynchronously from the [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) object.

要将占位符插入集合视图中，请执行以下操作：

1. 调用提供的 [UICollectionViewDropCoordinator](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator) 对象的 [drop(_:to:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator/2921634-drop) 方法，将您的占位符单元格插入集合视图中。
2. 从 [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) 对象异步开始加载数据。

When the [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) object returns the actual data, commit the insertion and exchange the placeholder cell for the final cell. Specifically, call the [commitInsertion(dataSourceUpdates:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropplaceholdercontext/2897447-commitinsertion) method of the context object you received after creating the placeholder. In the block that you pass to that method, update your model object and your collection view's data source. When this method returns, the collection view automatically deletes the placeholder and inserts the final item, which causes your updated data to be reflected in a new item.

当 [NSItemProvider](https://developer.apple.com/documentation/foundation/nsitemprovider) 对象返回实际数据时，提交插入并用最终的单元格替换占位符单元格。也就是，调用您在创建占位符之后接收到的上下文对象的 [commitInsertion(dataSourceUpdates:)](https://developer.apple.com/documentation/uikit/uicollectionviewdropplaceholdercontext/2897447-commitinsertion) 方法。在传递给该方法的 block 中，更新您的模型对象和集合视图的数据源。当此方法返回时，集合视图会自动删除占位符并插入最终项目，这将导致更新的数据在新项目中反映出来。

Insert placeholders at the location specified by the `destinationIndexPath` property of the drop coordinator.

在放置协调器的 `destinationIndexPath` 属性指定的位置插入占位符。

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