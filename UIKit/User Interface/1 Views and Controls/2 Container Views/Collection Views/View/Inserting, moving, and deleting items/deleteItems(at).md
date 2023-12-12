# deleteItems(at:)

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618060-deleteitems](https://developer.apple.com/documentation/uikit/uicollectionview/1618060-deleteitems)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Deletes the items at the specified index paths.
   
删除指定索引路径上的项目。

## Declaration 声明
```
func deleteItems(at indexPaths: [IndexPath])
```

## Parameters 参数

- **indexPaths**
	
	An array of `NSIndexPath` objects, each of which contains a section index and item index for the item you want to delete from the collection view. This parameter must not be `nil`.
	
	`NSIndexPath` 对象的数组，每个对象都包含一个节索引和项索引，用于指定想要从集合视图中删除的单元格的位置。此参数不能为 `nil`。

## Discussion 讨论

Use this method to remove items from the collection view. You might do this when you remove the items from your data source object or in response to user interactions with the collection view. The collection view updates the layout of the remaining items to account for the deletions, animating the remaining items into position as needed.

使用此方法可从集合视图中删除项目。当从数据源对象中删除项目时，或者响应用户与集合视图的交互时，您可能会这样做。集合视图将更新剩余项目的布局以删除，并根据需要将剩余项目动画化设置到适当位置。

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
