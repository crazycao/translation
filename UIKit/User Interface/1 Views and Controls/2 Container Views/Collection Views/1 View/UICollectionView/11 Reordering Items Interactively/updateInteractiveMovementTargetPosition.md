# updateInteractiveMovementTargetPosition(_:)


原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618019-begininteractivemovementforitem](https://developer.apple.com/documentation/uikit/uicollectionview/1618019-begininteractivemovementforitem)

Updates the position of the item within the collection view’s bounds.

更新项目在集合视图边界内的位置。

> iOS 9.0+
iPadOS 9.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+


```
func updateInteractiveMovementTargetPosition(_ targetPosition: CGPoint)
```

## Parameters

- **targetPosition**

	The position of the item in the collection view’s coordinate system.
	
	项目在集合视图的坐标系中的位置。

## Discussion 

When moving an item interactively, use this method to provide the collection view with the item’s new position. When using a gesture recognizer to track user interactions with the item, call this method each time the gesture recognizer reports a location change. The collection view uses the new point to determine if the item needs to be repositioned and if the current layout needs to be updated.

以交互方式移动项目时，请使用此方法为集合视图提供项目的新位置。当使用手势识别器跟踪用户与项目的交互时，每次手势识别器报告位置更改时都调用此方法。集合视图使用新点来确定项目是否需要重新定位以及当前布局是否需要更新。

For each position change, the collection view reports the change to the [collectionView(_:targetIndexPathForMoveFromItemAt:toProposedIndexPath:)](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate/1618052-collectionview) method of its delegate.

对于每次位置更改，集合视图都会将更改报告给其代理的 [collectionView(_:targetIndexPathForMoveFromItemAt:toProposedIndexPath:)](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate/1618052-collectionview) 方法。


# See Also

## Reordering items interactively - 以交互方式重新排序项目

### func beginInteractiveMovementForItem(at: IndexPath) -> Bool

Initiates the interactive movement of the item at the specified index path.

开始指定位置的项目的交互式移动。

### func updateInteractiveMovementTargetPosition(CGPoint)

Updates the position of the item within the collection view’s bounds.

更新项目在集合视图边界内的位置。

### func endInteractiveMovement()

Ends interactive movement tracking and moves the target item to its new location.

结束交互式移动跟踪并将目标项目移动到其新位置。

### func cancelInteractiveMovement()

Ends interactive movement tracking and returns the target item to its original location.

结束交互式移动跟踪并将目标项目放回其初始位置。

