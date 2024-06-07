# UIGraphicsImageRenderer

原文地址：
[https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer)

A graphics renderer for creating Core Graphics-backed images.

用于创建 Core graphics 支持的图像的图形渲染器。

> iOS 10.0+
iPadOS 10.0+
Mac Catalyst 13.1+
tvOS 10.0+
visionOS 1.0+

```
class UIGraphicsImageRenderer : UIGraphicsRenderer
```

##  Overview 概览

You can use image renderers to accomplish drawing tasks, without having to handle configuration such as color depth and image scale, or manage Core Graphics contexts. You initialize an image renderer with parameters such as image output dimensions and format. You then use one or more of the drawing functions to render images that share these properties.

你可以使用图像渲染器来完成绘图任务，无需处理颜色深度和图像比例等配置，也无需管理 Core Graphics 上下文。你可以使用图像输出尺寸和格式等参数初始化一个图像渲染器。然后，你可以使用一个或多个绘图函数来渲染具有这些属性的图像。

To render an image:

1. Optionally, create a UIGraphicsImageRendererFormat object to specify nondefault parameters the renderer should use to create its context.

2. Instantiate a UIGraphicsImageRenderer object, providing the dimensions of the output image and a format object. The renderer uses default values for the current device if you don’t provide format object, as demonstrated in [Creating a graphics image renderer](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863642).

3. Choose one of the rendering methods depending on the output you desire: [image(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649230-image) returns a UIImage object; [jpegData(withCompressionQuality:actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649234-jpegdata) returns a JPEG-encoded Data object; and [pngData(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649233-pngdata) returns a PNG-encoded Data object.

4. Execute your chosen method, providing Core Graphics drawing instructions as the closure argument, as shown in [Creating an image with an image renderer](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863643). [Using blend mode](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863644) demonstrates some of the more advanced rendering features you can use in your drawing instructions.

5. Optionally, you can use Core Graphics drawing code within the drawing instructions you provide to the rendering method, as shown in [Using Core Graphics rendering functions](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863645).

要渲染一个图像：

1. （可选）创建一个 `UIGraphicsImageRendererFormat` 对象，以指定渲染器在创建其上下文时应使用的非默认参数。
2. 实例化一个 `UIGraphicsImageRenderer` 对象，提供输出图像的尺寸和格式对象。如果你没有提供格式对象，渲染器将使用当前设备的默认值，如《[创建图形图像渲染器](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863642)》中所示。
3. 根据你需要的输出选择一个渲染方法：[image(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649230-image) 返回一个 `UIImage` 对象；[jpegData(withCompressionQuality:actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649234-jpegdata) 返回一个 JPEG 编码的 `Data` 对象；[pngData(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649233-pngdata) 返回一个 PNG 编码的 `Data` 对象。
4. 执行你选择的方法，提供 Core Graphics 绘图指令作为闭包参数，如《[使用图像渲染器创建图像](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863643)》中所示。《[使用混合模式](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863644)》演示了你可以在绘图指令中使用的一些更高级的渲染特性。
5. （可选）你可以在提供给渲染方法的绘图指令中使用 Core Graphics 绘图代码，如《[使用 Core Graphics 渲染函数](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer#2863645)》中所示。

After initializing an image renderer, you can use it to draw multiple images with the same configuration. An image renderer keeps a cache of Core Graphics contexts, so reusing the same renderer can be more efficient than creating new renderers.

在初始化图像渲染器后，你可以使用它来绘制具有相同配置的多个图像。图像渲染器会保持一个 Core Graphics 上下文的缓存，因此重用相同的渲染器可能比创建新的渲染器更高效。

## Creating a graphics image renderer - 创建图形图像渲染器

Create an image renderer, providing the size of the output image:

创建一个图像渲染器，并指定输出图像的尺寸：

```
let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
```

You can instead use one of the other `UIGraphicsImageRenderer` initializers to specify a renderer format ([UIGraphicsImageRendererFormat](https://developer.apple.com/documentation/uikit/uigraphicsimagerendererformat)) in addition to the size. This allows you to configure the underlying Core Graphics context for wide color and retina images.

你也可以使用 `UIGraphicsImageRenderer` 的其他初始化器之一来指定渲染器格式（[UIGraphicsImageRendererFormat](https://developer.apple.com/documentation/uikit/uigraphicsimagerendererformat)）以及尺寸。这允许你配置底层的 Core Graphics 上下文，以便处理宽色域和视网膜图像。

If you don’t provide a format, the renderer uses the [default()](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/1648550-default) format, which creates a context best suited for the current device.

如果你没有提供格式，渲染器将使用 [default()](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/1648550-default) 格式，该格式将创建最适合当前设备的上下文。

## Creating an image with an image renderer - 使用图像渲染器创建图像

Use the [image(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649230-image) method to create an image (`UIImage` object) with an image renderer. This method takes a closure that represents the drawing actions. Within this closure, the renderer creates a Core Graphics context using the parameters provided during renderer initialization, and sets this Core Graphics context to be the current context.

使用 [image(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649230-image) 方法通过图像渲染器创建一个图像（`UIImage` 对象）。此方法接受一个表示绘画动作的闭包。在这个闭包内，渲染器使用在渲染器初始化期间提供的参数来创建一个 Core Graphics 上下文，并设置此 Core Graphics 上下文为当前上下文。

```
let image = renderer.image { (context) in
  UIColor.darkGray.setStroke()
  context.stroke(renderer.format.bounds)
  UIColor(colorLiteralRed: 158/255, green: 215/255, blue: 245/255, alpha: 1).setFill()
  context.fill(CGRect(x: 1, y: 1, width: 140, height: 140))
}
```

The drawing actions closure takes a single argument of type `UIGraphicsImageRendererContext`. This provides access to some high-level drawing functions, such as [fill(_:)](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648554-fill), through the `UIGraphicsRendererContext` superclass.

绘画动作的闭包接受一个类型为 `UIGraphicsImageRendererContext` 的单一参数。通过 `UIGraphicsRendererContext` 超类，它提供了对一些高级绘画函数（如 [fill(_:)](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648554-fill)）的访问。

The above code creates the following image:

上面的代码创建了这样的图像：

![Image showing a blue square in the top left of a larger white squares](https://docs-assets.developer.apple.com/published/9b9f8b7055/2605ede9-d612-48d5-9e44-bb042fde7cbd.png)

In addition to the [image(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649230-image) method that creates an `UIImage` object, `UIGraphicsImageRenderer` also has [jpegData(withCompressionQuality:actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649234-jpegdata) and [pngData(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649233-pngdata) methods that create `Data` objects containing the image encoded as a JPEG or a PNG respectively. All three methods take the same approach as detailed here, accepting a block that represents the drawing actions.

除了使用 [image(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649230-image) 方法创建 `UIImage` 对象外，`UIGraphicsImageRenderer` 还有 [jpegData(withCompressionQuality:actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649234-jpegdata) 和 [pngData(actions:)]([pngData(actions:)](https://developer.apple.com/documentation/uikit/uigraphicsimagerenderer/1649233-pngdata)) 方法，它们分别创建包含以 JPEG 或 PNG 编码的图像的 `Data` 对象。这三种方法都采取了如上所述的相同方法，接受一个表示绘画动作的块。

## Using blend mode - 使用混合模式

The utility methods on `UIGraphicsImageRendererContext` also offer a variant that accepts a [CGBlendMode](https://developer.apple.com/documentation/coregraphics/cgblendmode) value. This value determines how to combine the pixel values when painting.

`UIGraphicsImageRendererContext` 上的实用方法也提供了一个接受 [CGBlendMode](https://developer.apple.com/documentation/coregraphics/cgblendmode) 值的变体。这个值决定了绘画时如何合并像素值。

```
let image = renderer.image { (context) in
  UIColor.darkGray.setStroke()
  context.stroke(renderer.format.bounds)
  UIColor(colorLiteralRed: 158/255, green: 215/255, blue: 245/255, alpha: 1).setFill()
  context.fill(CGRect(x: 1, y: 1, width: 140, height: 140))
  UIColor(colorLiteralRed: 145/255, green: 211/255, blue: 205/255, alpha: 1).setFill()
  context.fill(CGRect(x: 60, y: 60, width: 140, height: 140), blendMode: .multiply)
}
```

This code draws a second square, using a blend mode of multiply. The following image shows the result.

这段代码绘制了一个使用乘法混合模式的第二个正方形。下图展示了结果。

![Image showing two overlapping squares, one blue, the other turquoise, in the top-left and bottom-right of a white background square respectively.](https://docs-assets.developer.apple.com/published/9b9f8b7055/ecacce0a-1b55-4d20-9f43-aa13678e1980.png)

## Using Core Graphics rendering functions - 使用 Core Graphics 渲染方法

The `UIGraphicsImageRendererContext` available in the image closure has a [cgContext](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648560-cgcontext) property, which allows you to use Core Graphics rendering functions directly. For example, the following code demonstrates how to add a circle to the image:

在图像闭包中可用的 `UIGraphicsImageRendererContext` 有一个 [cgContext](https://developer.apple.com/documentation/uikit/uigraphicsrenderercontext/1648560-cgcontext) 属性，允许你直接使用 Core Graphics 渲染函数。例如，下面的代码演示了如何向图像添加一个圆形：

```
let image = renderer.image { (context) in
  UIColor.darkGray.setStroke()
  context.stroke(renderer.format.bounds)
  UIColor(colorLiteralRed: 158/255, green: 215/255, blue: 245/255, alpha: 1).setFill()
  context.fill(CGRect(x: 1, y: 1, width: 140, height: 140))
  UIColor(colorLiteralRed: 145/255, green: 211/255, blue: 205/255, alpha: 1).setFill()
  context.fill(CGRect(x: 60, y: 60, width: 140, height: 140), blendMode: .multiply)
  
  UIColor(colorLiteralRed: 203/255, green: 222/255, blue: 116/255, alpha: 0.6).setFill()
  context.cgContext.fillEllipse(in: CGRect(x: 60, y: 60, width: 140, height: 140))
}
```

This code uses the [fillEllipse(in:)](https://developer.apple.com/documentation/coregraphics/cgcontext/1454371-fillellipse) method on `CGContext` to draw a green circle on the blue and turquoise squares image; the following image shows the result.

这段代码使用 `CGContext` 的 [fillEllipse(in:)](https://developer.apple.com/documentation/coregraphics/cgcontext/1454371-fillellipse) 方法在蓝色和绿色的正方形图像上绘制一个绿色的圆；下图展示了结果。

![An image showing two overlapping squares and an overlaid green circle.](https://docs-assets.developer.apple.com/published/9b9f8b7055/61d24798-b328-4685-8a29-a74e896d0f38.png)