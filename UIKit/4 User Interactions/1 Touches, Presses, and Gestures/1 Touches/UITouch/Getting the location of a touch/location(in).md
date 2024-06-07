# location(in:)

原文地址：
[https://developer.apple.com/documentation/uikit/uitouch/1618116-location](https://developer.apple.com/documentation/uikit/uitouch/1618116-location)

Returns the current location of the touch in the coordinate system of the given view.

返回给定视图坐标系中触摸的当前位置。

> iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.1+ | tvOS 9.0+

## Declaration 声明

```
func location(in view: UIView?) -> CGPoint
```

## Parameters 参数

- **view**

	The view object in whose coordinate system you want the touch located. A custom view that is handling the touch may specify `self` to get the touch location in its own coordinate system. Pass `nil` to get the touch location in the window’s coordinates.
	
	想要触摸位于其坐标系中的视图对象。正在处理触摸的自定义视图可以指定 `self` 以在其自己的坐标系中获得触摸位置。传递 `nil` 以获取窗口坐标中的触摸位置。

## Return Value 返回值

A point specifying the location of the receiver in view.

指明 receiver 在视图中的位置的点。

## Discussion 讨论

This method returns the current location of a UITouch object in the coordinate system of the specified view. Because the touch object might have been forwarded to a view from another view, this method performs any necessary conversion of the touch location to the coordinate system of the specified view.

此方法返回 `UITouch` 对象在指定视图的坐标系中的当前位置。因为触摸对象可能已经从另一个视图转发到视图，所以该方法会执行触摸位置到指定视图的坐标系的任何必要转换。

# See Also - 其他参考

## Getting the location of a touch - 获取触摸的位置

### `func location(in: UIView?) -> CGPoint`

Returns the current location of the touch in the coordinate system of the given view.

返回给定视图坐标系中触摸的当前位置。

### `func previousLocation(in: UIView?) -> CGPoint`

Returns the previous location of the touch in the coordinate system of the given view.

返回触摸在给定视图的坐标系中的前一个位置。

### `var view: UIView?`

The view to which touches are being delivered, if any.

正在传递触摸的视图（如果有）。

### `var window: UIWindow?`

The window in which the touch initially occurred.

最初发生触摸的 windows。

### `var majorRadius: CGFloat`

The radius (in points) of the touch.

触摸的半径（以点为单位）。

### `var majorRadiusTolerance: CGFloat`

The tolerance (in points) of the touch’s radius.

触摸半径的公差（以点为单位）。

### `func preciseLocation(in: UIView?) -> CGPoint`

Returns a precise location for the touch, when available.

返回触摸的精确位置（如果可用）。

### `func precisePreviousLocation(in: UIView?) -> CGPoint`

Returns a precise previous location for the touch, when available.

返回触摸的前一个精确位置（如果可用）。
