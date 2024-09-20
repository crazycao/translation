# CGBlendMode

原文链接：[https://developer.apple.com/documentation/coregraphics/cgblendmode](https://developer.apple.com/documentation/coregraphics/cgblendmode)

Compositing operations for images.

图像的合成操作。

> iOS 2.0+
iPadOS 2.0+
Mac Catalyst 13.0+
macOS 10.4+
tvOS 9.0+
visionOS 1.0+
watchOS 2.0+


```
enum CGBlendMode : Int32, @unchecked Sendable
```

## Overview

These blend mode constants represent the Porter-Duff blend modes. The symbols in the equations for these blend modes are:

这些混合模式常数代表的是 Porter-Duff 混合模式。在混合模式方程中的符号含义如下：

`R` is the premultiplied result

`R` 是预乘结果

`S` is the source color, and includes alpha

`S` 是包含 alpha 值的源颜色

`D` is the destination color, and includes alpha

`D` 是包含 alpha 值的目标颜色

`Ra`, `Sa`, and `Da` are the alpha components of `R`, `S`, and `D`

`Ra`、`Sa` 和 `Da` 是 `R`、`S` 和 `D` 的 alpha 值

You can find more information on blend modes, including examples of images produced using them, and many mathematical descriptions of the modes, in _PDF Reference, Fourth Edition, Version 1.5, Adobe Systems, Inc_. If you are a former QuickDraw developer, it may be helpful for you to think of blend modes as an alternative to transfer modes

你可以在《PDF Reference, Fourth Edition, Version 1.5, Adobe Systems, Inc》中找到更多关于混合模式的信息，包括使用它们生成的图像示例，以及许多混合模式的数学描述。如果你曾是 QuickDraw 的开发者，将混合模式理解为传输模式的替代可能会对你有所帮助。

For examples of using blend modes see "Setting Blend Modes" and "Using Blend Modes With Images" in [Quartz 2D Programming Guide](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/Introduction/Introduction.html#//apple_ref/doc/uid/TP30001066).

关于如何使用混合模式的示例，参见《[Quartz 2D 编程指南](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/Introduction/Introduction.html#//apple_ref/doc/uid/TP30001066)》中的 "设置混合模式" 和 "与图像一起使用混合模式"。


# Topics

## Constants

### case normal （Sketch：正常）

Paints the source image samples over the background image samples.

将源图像采样绘制在背景图像采样上。

### case multiply （Sketch：正片叠底）

Multiplies the source image samples with the background image samples. This results in colors that are at least as dark as either of the two contributing sample colors.

将源图像采样与背景图像采样相乘。这会导致结果颜色至少与两个贡献采样颜色中的任一颜色一样暗。(结果色是较暗的颜色。）

### case screen （Sketch：滤色）

Multiplies the inverse of the source image samples with the inverse of the background image samples, resulting in colors that are at least as light as either of the two contributing sample colors.

将源图像采样的倒数与背景图像采样的倒数相乘，结果颜色至少与两个贡献采样颜色中的任一颜色一样亮。(结果色是较亮的颜色。）

### case overlay （Sketch：叠加）

Either multiplies or screens the source image samples with the background image samples, depending on the background color. The result is to overlay the existing image samples while preserving the highlights and shadows of the background. The background color mixes with the source image to reflect the lightness or darkness of the background.

根据背景颜色，将源图像采样与背景图像采样进行 multiply 或者 screen 混合。结果是在保留背景的高光和阴影的同时覆盖现有的图像样本。背景颜色与源图像混合，反映出背景的明亮或暗淡。

### case darken （Sketch：变暗）

Creates the composite image samples by choosing the darker samples (either from the source image or the background). The result is that the background image samples are replaced by any source image samples that are darker. Otherwise, the background image samples are left unchanged.

通过选择较暗的样本（来自源图像或背景）来创建复合图像样本。结果是，任何比背景图像样本暗的源图像样本都会替换背景图像样本。否则，背景图像样本保持不变。

### case lighten （Sketch：变亮）

Creates the composite image samples by choosing the lighter samples (either from the source image or the background). The result is that the background image samples are replaced by any source image samples that are lighter. Otherwise, the background image samples are left unchanged.

通过选择较亮的样本（来自源图像或背景）来创建复合图像样本。结果是，任何比背景图像样本亮的源图像样本都会替换背景图像样本。否则，背景图像样本保持不变。

### case colorDodge （Sketch：提亮）

Brightens the background image samples to reflect the source image samples. Source image sample values that specify black do not produce a change.

根据源图像采样来增亮背景图像采样。源图像采样值中为黑色的点不会带来变化。

### case colorBurn （Sketch：加暗）

Darkens the background image samples to reflect the source image samples. Source image sample values that specify white do not produce a change.

根据源图像采样来使背景图像采样变暗。源图像采样值中为白色的点不会带来变化。

### case softLight （Sketch：柔光）

Either darkens or lightens colors, depending on the source image sample color. If the source image sample color is lighter than 50% gray, the background is lightened, similar to dodging. If the source image sample color is darker than 50% gray, the background is darkened, similar to burning. If the source image sample color is equal to 50% gray, the background is not changed. Image samples that are equal to pure black or pure white produce darker or lighter areas, but do not result in pure black or white. The overall effect is similar to what you’d achieve by shining a diffuse spotlight on the source image. Use this to add highlights to a scene.

根据源图像样本颜色，要么使颜色变暗，要么使颜色变亮。如果源图像样本颜色比50%的灰度亮，背景会变亮，类似于减淡处理。如果源图像样本颜色比50%的灰度暗，背景会变暗，类似于加深处理。如果源图像样本颜色等于50%的灰度，背景不会改变。等于纯黑或纯白的图像样本会产生较暗或较亮的区域，但不会产生纯黑或白。整体效果类似于在源图像上照射一盏漫反射聚光灯。这种方法可以用来给场景添加高光。

### case hardLight （Sketch：强光）

Either multiplies or screens colors, depending on the source image sample color. If the source image sample color is lighter than 50% gray, the background is lightened, similar to screening. If the source image sample color is darker than 50% gray, the background is darkened, similar to multiplying. If the source image sample color is equal to 50% gray, the source image is not changed. Image samples that are equal to pure black or pure white result in pure black or white. The overall effect is similar to what you’d achieve by shining a harsh spotlight on the source image. Use this to add highlights to a scene.

根据源图像样本颜色，要么进行颜色相乘，要么进行颜色屏幕混合。如果源图像样本颜色比50%的灰度亮，背景会变亮，类似于屏幕混合。如果源图像样本颜色比50%的灰度暗，背景会变暗，类似于颜色相乘。如果源图像样本颜色等于50%的灰度，源图像不会改变。等于纯黑或纯白的图像样本会产生纯黑或白。整体效果类似于在源图像上照射一盏强烈的聚光灯。这种方法可以用来给场景添加高光。

### case difference （Sketch：差集）

Subtracts either the source image sample color from the background image sample color, or the reverse, depending on which sample has the greater brightness value. Source image sample values that are black produce no change; white inverts the background color values.

根据哪个样本的亮度值更大，要么从背景图像样本颜色中减去源图像样本颜色，要么反过来。黑色的源图像样本值不会产生变化；白色会反转背景颜色值。

### case exclusion （Sketch：排除）

Produces an effect similar to that produced by [CGBlendMode.difference](https://developer.apple.com/documentation/coregraphics/cgblendmode/difference), but with lower contrast. Source image sample values that are black don’t produce a change; white inverts the background color values.

产生的效果类似于 [CGBlendMode.difference](https://developer.apple.com/documentation/coregraphics/cgblendmode/difference) 产生的效果，但对比度较低。黑色的源图像样本值不会产生变化；白色会反转背景颜色值。

### case hue （Sketch：色相）

Uses the luminance and saturation values of the background with the hue of the source image.

使用背景的亮度和饱和度值，以及源图像的色调。

### case saturation （Sketch：饱和度）

Uses the luminance and hue values of the background with the saturation of the source image. Areas of the background that have no saturation (that is, pure gray areas) don’t produce a change.

使用背景的亮度和色调值，以及源图像的饱和度。背景中没有饱和度的区域（即，纯灰色区域）不会产生变化。

### case color （Sketch：颜色）

Uses the luminance values of the background with the hue and saturation values of the source image. This mode preserves the gray levels in the image. You can use this mode to color monochrome images or to tint color images.

使用背景的亮度值，以及源图像的色调和饱和度值。这种模式保留了图像中的灰度级别。你可以使用这种模式来给单色图像上色，或给彩色图像着色。

### case luminosity （Sketch：明度）

Uses the hue and saturation of the background with the luminance of the source image. This mode creates an effect that is inverse to the effect created by [CGBlendMode.color](https://developer.apple.com/documentation/coregraphics/cgblendmode/color).

使用背景的色调和饱和度，以及源图像的亮度。这种模式创建的效果与 [CGBlendMode.color](https://developer.apple.com/documentation/coregraphics/cgblendmode/color) 创建的效果相反。

### case clear

`R = 0`

### case copy

`R = S`

### case sourceIn

`R = S*Da`

### case sourceOut

`R = S*(1 - Da)`

### case sourceAtop

`R = S*Da + D*(1 - Sa)`

### case destinationOver

`R = S*(1 - Da) + D`

### case destinationIn

`R = D*Sa`

### case destinationOut

`R = D*(1 - Sa)`

### case destinationAtop

`R = S*(1 - Da) + D*Sa`

### case xor

`R = S*(1 - Da) + D*(1 - Sa)`. This XOR mode is only nominally related to the classical bitmap XOR operation, which is not supported by Core Graphics

`R = S*(1 - Da) + D*(1 - Sa)`。这种异或模式只是名义上与经典的位图异或操作相关，而后者并不被 Core Graphics 支持。（在图形处理中，XOR模式通常用于创建两个图像的并集，并排除二者的重叠部分。在Core Graphics中，XOR模式实际上是一个更复杂的混合模式，它基于源图像和背景图像的颜色值来创建新的颜色。）

### case plusDarker

`R = MAX(0, 1 - ((1 - D) + (1 - S)))`

### case plusLighter

`R = MIN(1, S + D)`

# Relationships

## Conforms To

[Sendable](https://developer.apple.com/documentation/swift/sendable)

# See Also

## Managing a Graphics Context - 管理图形上下文

### func flush()

Forces all pending drawing operations in a window context to be rendered immediately to the destination device.

将所有在窗口上下文中待处理的绘图操作强制立即渲染到目标设备。

### func synchronize()

Marks a window context for update.

将窗口上下文标记为需要更新。

### func setBlendMode(CGBlendMode)

Sets how sample values are composited by a graphics context.

设置图形上下文如何混合采样值。

### func setRenderingIntent(CGColorRenderingIntent)

Sets the rendering intent in the current graphics state.

设置当前图形状态中的渲染意图。