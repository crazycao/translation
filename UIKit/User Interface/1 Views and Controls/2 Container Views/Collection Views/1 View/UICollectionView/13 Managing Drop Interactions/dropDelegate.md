# dropDelegate

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/2897491-dropdelegate](https://developer.apple.com/documentation/uikit/uicollectionview/2897491-dropdelegate)

The delegate object that manages the dropping of items into the collection view.

管理将项目拖放到集合视图中的代理对象。

> iOS 11.0+
iPadOS 11.0+
Mac Catalyst 13.1+
visionOS 1.0+

**iOS, iPadOS, Mac Catalyst**

```
weak var dropDelegate: (any UICollectionViewDropDelegate)? { get set }
```

**visionOS**

```
weak var dropDelegate: UICollectionViewDropDelegate? { get set }
```


# See Also

## Managing drop interactions - 管理拖放交互

### protocol UICollectionViewDropDelegate

The interface for handling drops in a collection view.

用于处理集合视图中的 drop 的接口。

### var hasActiveDrop: Bool

A Boolean value that indicates whether the collection view is currently tracking a drop session.

一个布尔值，指示集合视图当前是否正在跟踪 drop 会话。

### var reorderingCadence: UICollectionView.ReorderingCadence

The speed at which items in the collection view are reordered to show potential drop locations.

集合视图中的项目重新排序以显示潜在放置位置的速度。

### enum UICollectionView.ReorderingCadence

Constants indicating the speed at which collection view items are reorganized during a drop.

指示在 drop 期间重新组织集合视图项目的速度的常量。

