# beginInteractiveMovementForItem(at:)

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618019-begininteractivemovementforitem](https://developer.apple.com/documentation/uikit/uicollectionview/1618019-begininteractivemovementforitem)

Initiates the interactive movement of the item at the specified index path.
   
开始指定位置的项目的交互式移动。

> iOS 9.0+
iPadOS 9.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+

```
func beginInteractiveMovementForItem(at indexPath: IndexPath) -> Bool
```

## Parameters

- **indexPath**

	The index path of the item you want to move.
	
	你想要移动的项目的索引路径。

## Return Value

`true` if it is possible to move the item or `false` if the item is not allowed to move.

如果该项目可以移动就返回 `true`，否则不允许移动返回 `false`。

## Discussion 

Call this method when you want to begin the interactive movement of an item from its current location to a new location within the same collection view. When using a gesture recognizer to track movements of the item, call this method from your handler method when the gesture recognition process begins. When interactions with the item end, you must call either the [endInteractiveMovement()](https://developer.apple.com/documentation/uikit/uicollectionview/1618082-endinteractivemovement) or [cancelInteractiveMovement()](https://developer.apple.com/documentation/uikit/uicollectionview/1618076-cancelinteractivemovement) method to inform the collection view of that fact.

当您想要开始将项目从其当前位置交互式移动到同一集合视图中的新位置时，请调用此方法。 当使用手势识别器跟踪项目的移动时，请在手势识别过程开始时从处理程序方法中调用此方法。 当与项目交互结束时，您必须调用 [endInteractiveMovement()](https://developer.apple.com/documentation/uikit/uicollectionview/1618082-endinteractivemovement) 或 [cancelInteractiveMovement()](https://developer.apple.com/documentation/uikit/uicollectionview/1618076-cancelinteractivemovement) 方法来通知集合视图该事实。

When you call this method, the collection view consults its delegate to make sure the item can be moved. If the data source does not support the movement of the item, this method returns `false`.

当您调用此方法时，集合视图会咨询其代理以确保可以移动该项目。 如果数据源不支持该项目的移动，则此方法返回 `false`。

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

