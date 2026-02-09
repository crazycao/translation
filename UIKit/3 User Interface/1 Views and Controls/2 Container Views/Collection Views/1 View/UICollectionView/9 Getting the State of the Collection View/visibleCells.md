# visibleCells

原文地址：[https://developer.apple.com/documentation/uikit/uicollectionview/visiblecells](https://developer.apple.com/documentation/uikit/uicollectionview/visiblecells)

An array of visible cells currently displayed by the collection view.

集合视图当前显示的可见单元格数组。

> iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.1+ | tvOS | visionOS 1.0+

```
@MainActor
var visibleCells: [UICollectionViewCell] { get }
```

## Return Value 返回值

An array of UICollectionViewCell objects. If no cells are visible, this method returns an empty array.

一个 UICollectionViewCell 对象数组。如果没有可见的单元格，此方法返回一个空数组。

## Discussion

This method returns the complete list of visible cells displayed by the collection view.

此方法返回集合视图显示的完整可见单元格列表。

# See Also 另请参阅

## Related Documentation 相关文档

### var indexPathsForVisibleItems: [IndexPath]

An array of the visible items in the collection view.

集合视图中可见项的数组。

## Getting the state of the collection view 获取集合视图的状态

### var numberOfSections: Int

The number of sections displayed by the collection view.

集合视图显示的段数。

### func numberOfItems(inSection: Int) -> Int

Fetches the count of items in the specified section.

获取指定段中的项数。