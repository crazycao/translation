# endInteractiveMovement()


原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618082-endinteractivemovement](https://developer.apple.com/documentation/uikit/uicollectionview/1618082-endinteractivemovement)

Ends interactive movement tracking and moves the target item to its new location.

结束交互式移动跟踪并将目标项目移动到其新位置。

> iOS 9.0+
iPadOS 9.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+


```
func endInteractiveMovement()
```

## Discussion 

Call this method upon the successful completion of movement tracking for a item. For example, when using a gesture recognizer to track user interactions, call this method upon the successful completion of the gesture. Calling this method lets the collection view know to end tracking and move the item to its new location permanently. The collection view responds by calling the [collectionView(_:moveItemAt:to:)](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource/1618064-collectionview) method of its data source to ensure that your data structures are updated.

在成功完成项目的移动跟踪后调用此方法。例如，当使用手势识别器来跟踪用户交互时，在手势成功完成后调用此方法。调用此方法可以使集合视图知道结束跟踪并将项目永久移动到其新位置。集合视图通过调用其数据源的 [collectionView(_:moveItemAt:to:)](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource/1618064-collectionview) 方法进行响应，以确保更新数据结构。


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

