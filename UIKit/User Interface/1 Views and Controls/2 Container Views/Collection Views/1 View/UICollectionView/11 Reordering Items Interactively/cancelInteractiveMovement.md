# cancelInteractiveMovement()


原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618076-cancelinteractivemovement](https://developer.apple.com/documentation/uikit/uicollectionview/1618076-cancelinteractivemovement)

Ends interactive movement tracking and returns the target item to its original location.

结束交互式移动跟踪并将目标项目放回其初始位置。

> iOS 9.0+
iPadOS 9.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+


```
func cancelInteractiveMovement()
```

## Discussion 

Call this method to cancel movement tracking and return the item to its original location. For example, when using a gesture recognizer to track interactions, call this method when the gesture is cancelled. Calling this method lets the collection view know to end the tracking process and return the item to its original location.

调用此方法可取消移动跟踪并将项目返回到其原始位置。例如，当使用手势识别器来跟踪交互时，请在取消手势时调用此方法。调用此方法可以使集合视图知道结束跟踪过程并将项目返回到其原始位置。

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

