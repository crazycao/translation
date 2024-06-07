# drawAtPoint:

原文地址：
[https://developer.apple.com/documentation/uikit/uiimage/1624132-drawatpoint?language=objc](https://developer.apple.com/documentation/uikit/uiimage/1624132-drawatpoint?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Draws the image at the specified point in the current context.

在当前上下文的指定点绘制图像。

# Declaration 声明
```
- (void)drawAtPoint:(CGPoint)point;
```

# Parameters 参数
## point
The point at which to draw the top-left corner of the image.

绘制图像左上角的点的位置。

# Discussion 讨论
This method draws the entire image in the current graphics context, respecting the image’s orientation setting. In the default coordinate system, images are situated down and to the right of the specified point. This method respects any transforms applied to the current graphics context, however.

此方法根据图像的方向设置，在当前图形上下文中绘制整个图像。在默认坐标系中，图像位于指定点的右下方。但是，此方法遵从应用于当前图形上下文的任何变换。

This method draws the image at full opacity using the [kCGBlendModeNormal](https://developer.apple.com/documentation/coregraphics/cgblendmode/kcgblendmodenormal?language=objc) blend mode.

此方法使用 [kCGBlendModeNormal](https://developer.apple.com/documentation/coregraphics/cgblendmode/kcgblendmodenormal?language=objc) 混合模式以完全不透明度绘制图像（译者注：即 alpha = 1.0，而不是消除 alpha 通道）。

# See Also 其它参考

## Drawing Images 绘制图像

### [- drawAtPoint:](https://developer.apple.com/documentation/uikit/uiimage/1624132-drawatpoint?language=objc)
Draws the image at the specified point in the current context.

### [- drawAtPoint:blendMode:alpha:](https://developer.apple.com/documentation/uikit/uiimage/1624095-drawatpoint?language=objc)
Draws the entire image at the specified point using the custom compositing options.

### [- drawInRect:](https://developer.apple.com/documentation/uikit/uiimage/1624092-drawinrect?language=objc)
Draws the entire image in the specified rectangle, scaling it as necessary to fit.

### [- drawInRect:blendMode:alpha:](https://developer.apple.com/documentation/uikit/uiimage/1624101-drawinrect?language=objc)
Draws the entire image in the specified rectangle using the specified compositing options.

### [- drawAsPatternInRect:](https://developer.apple.com/documentation/uikit/uiimage/1624144-drawaspatterninrect?language=objc)
Draws a tiled Quartz pattern using the receiver’s contents as the tile pattern.
