# clip(to:)

原文链接：[https://developer.apple.com/documentation/coregraphics/cgcontext/1454716-clip](https://developer.apple.com/documentation/coregraphics/cgcontext/1454716-clip)

Sets the clipping path to the intersection of the current clipping path with the area defined by the specified rectangle.

将裁剪路径设置为当前裁剪路径与指定矩形定义的区域的交集。

> iOS 2.0+
iPadOS 2.0+
macOS 10.0+
Mac Catalyst 13.1+
tvOS 9.0+
watchOS 2.0+
visionOS 1.0+


```
func clip(to rect: CGRect)
```

## Parameters

- rect

	The location and dimensions of the rectangle, in user space, to be used in determining the new clipping path.

	用于确定新裁剪路径的矩形的位置和尺寸，这些都是在用户空间中定义的。

## Discussion

This function sets the specified graphics context’s clipping region to the area which intersects both the current clipping path and the specified rectangle.

这个函数将指定的图形上下文的裁剪区域设置为当前裁剪路径和指定矩形的交集区域。

After determining the new clipping path, the function resets the context’s current path to an empty path.

在确定新的裁剪路径后，该函数将上下文的当前路径重置为一个空路径。