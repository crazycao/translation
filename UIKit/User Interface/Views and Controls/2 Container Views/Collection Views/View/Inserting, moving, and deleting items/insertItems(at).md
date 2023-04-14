# insertItems(at:)

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618097-insertitems](https://developer.apple.com/documentation/uikit/uicollectionview/1618097-insertitems)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Inserts new items at the specified index paths.
   
在指定的索引路径插入新的项目。

## Declaration 声明
```
func insertItems(at indexPaths: [IndexPath])
```

## Parameters 参数

- **indexPaths**
	
	An array of `NSIndexPath` objects, each of which contains a section index and item index at which to insert a new cell. This parameter must not be `nil`.
	
	`NSIndexPath` 对象的数组，每个对象都包含一个节索引和项索引，用于指定插入新单元格的位置。此参数不能为 `nil`。

## Discussion 讨论

Call this method to insert one or more new items into the collection view. You might do this when your data source object receives data for new items or in response to user interactions with the collection view. The collection view gets the layout information for the new cells as part of calling this method. And if the layout information indicates that the cells should appear onscreen, the collection view asks your data source to provide the appropriate views, animating them into position as needed.

调用此方法将一个或多个新项目插入集合视图。当数据源对象接收新项目的数据或响应用户与集合视图的交互时，您可能会这样做。作为调用此方法的一部分，集合视图获取新单元格的布局信息。如果布局信息指示单元格应该显示在屏幕上，则集合视图会让数据源提供适当的视图，并根据需要将其动画化放入相应位置。

You can also call this method from a block passed to the `performBatchUpdates(_:completion:)` method when you want to animate multiple separate changes into place at the same time. See the description of that method for more information.

如果要将多个单独的更改同时进行动画化，也可以从传递给 `performBatchUpdates(_:completion:)` 方法的 block 中调用此方法。有关详细信息，请参见该方法的说明。

# See Also

## Inserting, moving, and deleting Items - 插入、移动和删除项目

### [func insertItems(at: [IndexPath])](https://developer.apple.com/documentation/uikit/uicollectionview/1618097-insertitems)

Inserts new items at the specified index paths.

在指定的索引路径插入新的项目。

### [func moveItem(at: IndexPath, to: IndexPath)](https://developer.apple.com/documentation/uikit/uicollectionview/1618059-moveitem)

Moves an item from one location to another in the collection view.

将项目从集合视图中的一个位置移动到另一个位置。

### [func deleteItems(at: [IndexPath])](https://developer.apple.com/documentation/uikit/uicollectionview/1618060-deleteitems)

Deletes the items at the specified index paths.

删除指定索引路径上的项目。
