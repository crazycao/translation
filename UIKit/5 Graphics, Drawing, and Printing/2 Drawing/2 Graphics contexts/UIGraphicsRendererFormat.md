# UIGraphicsRendererFormat

原文地址：
[https://developer.apple.com/documentation/uikit/uigraphicsrendererformat](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat)

An abstract base class for creating graphics renderers.

用于创建图形渲染器的抽象基类。

> iOS 10.0+
iPadOS 10.0+
Mac Catalyst 13.1+
tvOS 10.0+
visionOS 1.0+

```
class UIGraphicsRendererFormat : NSObject
```

## Overview - 概览

Create a `UIGraphicsRendererFormat` object, or one of its subclasses ([UIGraphicsImageRendererFormat](https://developer.apple.com/documentation/uikit/uigraphicsimagerendererformat) and [UIGraphicsPDFRendererFormat](https://developer.apple.com/documentation/uikit/uigraphicspdfrendererformat)), and use it to construct a graphics renderer by providing the format object as a parameter in a [UIGraphicsRenderer](https://developer.apple.com/documentation/uikit/uigraphicsrenderer) subclass intializer.

创建一个 `UIGraphicsRendererFormat` 对象，或者它的子类（[UIGraphicsImageRendererFormat](https://developer.apple.com/documentation/uikit/uigraphicsimagerendererformat) 和 [UIGraphicsPDFRendererFormat](https://developer.apple.com/documentation/uikit/uigraphicspdfrendererformat)），并通过在 [UIGraphicsRenderer](https://developer.apple.com/documentation/uikit/uigraphicsrenderer) 子类初始化器中提供格式对象作为参数来构造图形渲染器。

The graphics renderer uses the format object you provided to configure any context objects ([UIGraphicsRendererContext](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext)) it creates as part of the rendering process.

图形渲染器使用你提供的格式对象来配置任何上下文对象（[UIGraphicsRendererContext](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext)），它将成为渲染过程的一部分。

If you use a graphics renderer initializer that doesn’t require a format argument, the renderer creates a format object using the [default()](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/1648550-default) class method.

如果你使用的图形渲染器初始化器不需要格式参数，那么渲染器将使用 [default()](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/1648550-default) 类方法创建一个格式对象。

The renderer format object contains properties that represent the immutable aspects of the renderer’s configuration. This means that repeated uses of a single graphics renderer object will always use the same format object.

渲染器格式对象包含代表渲染器配置的不可变方面的属性。这意味着单个图形渲染器对象的重复使用将始终使用相同的格式对象。