# indexPathsForVisibleItems

原文地址：[https://developer.apple.com/documentation/uikit/uicollectionview/indexpathsforvisibleitems](https://developer.apple.com/documentation/uikit/uicollectionview/indexpathsforvisibleitems)

An array of the visible items in the collection view.

集合视图中可见项的数组。

> iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.1+ | tvOS | visionOS 1.0+

```
@MainActor
var indexPathsForVisibleItems: [IndexPath] { get }
```

## Discussion 讨论

The value of this property is an unsorted array of `NSIndexPath` objects, each of which corresponds to a visible cell in the collection view. This array doesn’t include any supplementary views that are currently visible. If there are no visible items, the value of this property is an empty array.

此属性的值是一个未排序的 `NSIndexPath` 对象数组，每个对象对应集合视图中的一个可见单元格。此数组不包括当前可见的任何补充视图。如果没有可见项，此属性的值为空数组。

# See Also 另请参阅

## Related Documentation 相关文档

### var visibleCells: [UICollectionViewCell]

An array of visible cells currently displayed by the collection view.

集合视图当前显示的可见单元格数组。

## Locating items and views in the collection view 在集合视图中定位项和视图

### func indexPathForItem(at: CGPoint) -> IndexPath?

Gets the index path of the item at the specified point in the collection view.

获取集合视图中指定点处项的索引路径。

### func indexPath(for: UICollectionViewCell) -> IndexPath?

Gets the index path of the specified cell.

获取指定单元格的索引路径。

### func cellForItem(at: IndexPath) -> UICollectionViewCell?

Gets the cell object at the index path you specify.

获取你指定的索引路径处的单元格对象。

### func indexPathsForVisibleSupplementaryElements(ofKind: String) -> [IndexPath]

Gets the index paths of all visible supplementary views of the specified type.

获取指定类型的所有可见补充视图的索引路径。

### func supplementaryView(forElementKind: String, at: IndexPath) -> UICollectionReusableView?

Gets the supplementary view at the specified index path.

获取指定索引路径处的补充视图。

### func visibleSupplementaryViews(ofKind: String) -> [UICollectionReusableView]

Gets an array of the visible supplementary views of the specified kind.

获取指定类型的可见补充视图数组。