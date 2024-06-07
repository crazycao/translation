# clip(to:)

原文地址：
[https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648549-clip](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648549-clip)

Sets the clipping mask for the drawing context to the specified rectangle.

将绘图上下文的裁剪蒙版设置为指定的矩形。

> iOS 10.0+
iPadOS 10.0+
Mac Catalyst 13.1+
tvOS 10.0+
visionOS 1.0+

```
func clip(to rect: CGRect)
```

## Parameters

- rect

	The rectangle to which the drawing context is clipped, specified in the Core Graphics coordinate space with values in points.
	
	绘图上下文被裁剪的矩形，以点为单位，在 Core Graphics 坐标空间中指定。

## Discussion

To restrict the active drawing area to the specified rectangle, call this method before executing drawing commands.

要将活动绘图区域限制在指定的矩形内，执行绘图命令之前请调用此方法。

To use a more complex shape as a clipping mask, use the [clip(to:mask:)](https://developer.apple.com/documentation/coregraphics/cgcontext/1456497-clip) method on the underlying Core Graphics context, accessed through the [cgContext](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648560-cgcontext) property.

如果要使用更复杂的形状作为裁剪蒙版，可以在底层的 Core Graphics 上下文中使用 [clip(to:mask:)](https://developer.apple.com/documentation/coregraphics/cgcontext/1456497-clip) 方法，通过 [cgContext](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648560-cgcontext) 属性进行访问。