# performBatchUpdates(_:completion:)

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618045-performbatchupdates](https://developer.apple.com/documentation/uikit/uicollectionview/1618045-performbatchupdates)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Animates multiple insert, delete, reload, and move operations as a group.
   
将多个插入、删除、重新加载和移动操作作为一组动画。

## Declaration 声明
```
func performBatchUpdates(
    _ updates: (() -> Void)?,
    completion: ((Bool) -> Void)? = nil
)
```

## Parameters 参数

- **updates**

	The block that performs the relevant insert, delete, reload, or move operations.
	
	执行相关插入、删除、重新加载或移动操作的 block。

- **completion**

	A completion handler block to execute when all of the operations finish. This block takes a single `Boolean` parameter that contains the value `true` if all of the related animations completed successfully or false if they were interrupted. This parameter may be nil.
	
	完成句柄 block 将在所有操作完成时执行。该 block 带有一个布尔类型的参数，如果所有相关动画都成功完成，参数的值是 `true`，否则如果被打断则是 `false`。此参数（completion）可能是 `nil`。

## Discussion 讨论

You can use this method in cases where you want to make multiple changes to the collection view in one single animated operation, as opposed to in several separate animations. You might use this method to insert, delete, reload, or move cells or use it to change the layout parameters associated with one or more cells. Use the block passed in the updates parameter to specify all of the operations you want to perform.

如果希望在单个动画操作中对集合视图进行多次更改，而不是在多个单独的动画中，则可以使用此方法。可以使用此方法插入、删除、重新加载或移动单元格，也可以用它来更改与一个或多个单元格关联的布局参数。使用 `updates` 参数中传递的 block 指定要执行的所有操作。

If the collection view’s layout isn’t up to date before you call this method, a reload may occur. To avoid problems, you should update your data model inside the `updates` block or ensure the layout is updated before you call `performBatchUpdates(_:completion:)`.

如果在调用此方法之前集合视图的布局不是最新的，则可能会发生重新加载。为避免出现问题，应在 `updates` block 中更新数据模型，或确保在调用 `performBatchUpdates(_:completion:)` 之前更新布局。

Deletes are processed before inserts in batch operations. This means the indexes for the deletions are processed relative to the indexes of the collection view’s state before the batch operation, and the indexes for the insertions are processed relative to the indexes of the state after all the deletions in the batch operation.

在批处理操作中，删除操作会在插入操作之前处理。这意味着，删除操作的索引是相对于在批处理操作之前的集合视图状态的索引，而插入操作的索引是相对于在批处理操作中所有删除执行之后的集合视图状态的索引。

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
