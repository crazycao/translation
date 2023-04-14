# moveItem(at:to:)

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618059-moveitem](https://developer.apple.com/documentation/uikit/uicollectionview/1618059-moveitem)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Moves an item from one location to another in the collection view.
   
将项目从集合视图中的一个位置移动到另一个位置。

## Declaration 声明
```
func moveItem(
    at indexPath: IndexPath,
    to newIndexPath: IndexPath
)
```

## Parameters 参数

- **indexPaths**
	
	The index path of the item you want to move.  This parameter must not be `nil`.
	
	想要移动的项目的索引路径。此参数不能为 `nil`。
	
- **newIndexPath**

	The index path of the item’s new location. This parameter must not be `nil`.
	
	项目的新位置的索引路径。此参数不能为 `nil`。

## Discussion 讨论

Use this method to reorganize existing data items. You might do this when you rearrange the items within your data source object or in response to user interactions with the collection view. You can move items between sections or within the same section. The collection view updates the layout as needed to account for the move, animating cells into position as needed.

使用此方法重新组织现有数据项。当您重新排列数据源对象中的项目或响应用户与集合视图的交互时，您可能会这样做。您可以在 section 之间或同一 section 内移动项目。集合视图根据需要更新布局，以考虑移动，并根据需要将单元格动画化设置到适当位置。

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
