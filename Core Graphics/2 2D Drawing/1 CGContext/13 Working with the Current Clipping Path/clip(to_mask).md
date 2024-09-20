# clip(to:mask:)

原文链接：[https://developer.apple.com/documentation/coregraphics/cgcontext/1456497-clip](https://developer.apple.com/documentation/coregraphics/cgcontext/1456497-clip)

Maps a mask into the specified rectangle and intersects it with the current clipping area of the graphics context.

将掩码映射到指定的矩形，并将其与图形上下文的当前裁剪区域进行交集。

> iOS 2.0+
iPadOS 2.0+
Mac Catalyst 13.1+
macOS 10.4+
tvOS 9.0+
visionOS 1.0+
watchOS 2.0+


```
func clip(to rect: CGRect, mask: CGImage)
```

## Parameters

- rect

	The rectangle to map the mask parameter to.
	
	将掩码参数映射到的矩形区域。

- mask

	An image or an image mask. If mask is an image, then it must be in the DeviceGray color space, may not have an alpha component, and may not be masked by an image mask or masking color.

	一个图像或图像掩码。如果掩码是一个图像，那么它必须在 DeviceGray 色彩空间中，不可以有 alpha 组件，且不能被图像掩码或掩色进行遮盖。


## Discussion

If the mask parameter is an image mask, then Core Graphics clips in a manner identical to the behavior seen with the [draw(in:image:)](https://developer.apple.com/documentation/coregraphics/1454845-cgcontextdrawimage) function —the mask indicates an area to be left unchanged when drawing. The source samples of the image mask determine which points of the clipping area are changed, acting as an "inverse alpha" value. If the value of a source sample in the image mask is S, then the corresponding point in the current clipping area is multiplied by an alpha value of (1–S). For example, if S is 1 then the point in the clipping area becomes transparent. If S is 0, the point in the clipping area is unchanged.

如果掩码参数是一个图像掩码，那么 Core Graphics 的裁剪方式与 [draw(in:image:)](https://developer.apple.com/documentation/coregraphics/1454845-cgcontextdrawimage) 函数的行为完全相同——掩码指示了在绘图时应保持不变的区域。图像掩码的源样本决定了裁剪区域的哪些点被改变，它们起到了"反向 alpha"值的作用。如果图像掩码中的源样本值为 S，那么当前裁剪区域中对应的点会被一个 alpha 值为 (1–S) 的值所乘。例如，如果 S 为 1，那么裁剪区域中的点变为透明。如果 S 为 0，裁剪区域中的点保持不变。

If the mask parameter is an image, then mask acts like an alpha mask and is blended with the current clipping area. The source samples of mask determine which points of the clipping area are changed. If the value of the source sample in mask is S, then the corresponding point in the current clipping area is multiplied by an alpha of S. For example, if S is 0, then the point in the clipping area becomes transparent. If S is 1, the point in the clipping area is unchanged.

如果掩码参数是一个图像，那么该掩码就像一个 alpha 掩码，并与当前的裁剪区域进行混合。掩码的源样本决定了裁剪区域的哪些点被改变。如果掩码中的源样本值为 S，那么当前裁剪区域中对应的点会被一个 alpha 值为 S 的值所乘。例如，如果 S 为 0，那么裁剪区域中的点变为透明。如果 S 为 1，裁剪区域中的点保持不变。