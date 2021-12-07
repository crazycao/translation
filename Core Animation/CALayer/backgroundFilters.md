# backgroundFilters

原文地址：[https://developer.apple.com/documentation/quartzcore/calayer/1410827-backgroundfilters?changes=la_11_3](https://developer.apple.com/documentation/quartzcore/calayer/1410827-backgroundfilters?changes=la_11_3)

An array of Core Image filters to apply to the content immediately behind the layer. Animatable.

一组直接应用于图层背后的内容的 Core Image 过滤器。可以动画化。

# Declaration 声明

`var backgroundFilters: Any? { get set }`

# Discussion

Background filters affect the content behind the layer that shows through into the layer itself. Typically this content belongs to the superlayer that acts as the parent of the layer. These filters do not affect the content of the layer itself, including the layer’s background color and border.

背景过滤器会影响透过图层自身展示出来的，图层背后的内容。通常，该内容属于这个图层的父图层。这些过滤器不会影响图层自身的内容，包括背景色和边框。

The default value of this property is `nil`.

该属性的默认值是 `nil`。

Changing the inputs of the [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter?changes=la_11_3) object directly after it is attached to the layer causes undefined behavior. In macOS, it is possible to modify filter parameters after attaching them to the layer but you must use the layer’s  [setValue(_:forKeyPath:)](https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue?changes=la_11_3) method to do so. In addition, you must assign a name to the filter so that you can identify it in the array. For example, to change the `inputRadius` parameter of the filter, you could use code similar to the following:

在 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter?changes=la_11_3) 对象附着到图层后直接更改其输入会导致未定义的行为。在 macOS 中，可以在过滤器参数附着到图层后修改过滤器参数，但必须使用图层的 [setValue(_:forKeyPath:)](https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue?changes=la_11_3) 方法进行修改。另外，你必须给过滤器指定一个名字，才能在数组中定位到它。例如，要更改过滤器的 `inputRadius` 参数，可以使用如下代码：

```
let layer = CALayer()
         
if let filter = CIFilter(name:"CIGaussianBlur") {
    filter.name = "myFilter"
    layer.backgroundFilters = [filter]
    layer.setValue(1,
                   forKeyPath: "backgroundFilters.myFilter.inputRadius")
}
```

You use the layer's [masksToBounds](https://developer.apple.com/documentation/quartzcore/calayer/1410896-maskstobounds?changes=la_11_3) to control the extent of its background filter's effect.

你可以使用图层的 [masksToBounds](https://developer.apple.com/documentation/quartzcore/calayer/1410896-maskstobounds?changes=la_11_3)  属性控制其背景过滤器的效果的范围。

Listing 2 shows how to create two overlapping text layers, background and foreground. A Gaussian blur filter is added to the foreground layer's `backgroundFilters` array and its `masksToBounds` is set to `true`:

代码2显示了如何创建两个重叠的文本层：背景和前景。将高斯模糊过滤器添加到前景层的 `backgroundFilters` 数组中，并将其 `masksToBounds` 属性设置为 `true`：

代码2显示了如何创建两个重叠的文本层：背景和前景。[CIAdditionCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAdditionCompositing) 用于在背景上合成前景。

**Listing 2** Blurring layers with background filters **代码2：**使用背景过滤器模糊图层

```
view.layer = CALayer()
view.layerUsesCoreImageFilters = true
     
let background = CATextLayer()
background.string = "background"
background.backgroundColor = NSColor.red.cgColor
background.alignmentMode = kCAAlignmentCenter
background.fontSize = 96
background.frame = CGRect(x: 10, y: 10, width: 640, height: 160)
     
let foreground = CATextLayer()
foreground.string = "foreground"
foreground.backgroundColor = NSColor.blue.cgColor
foreground.alignmentMode = kCAAlignmentCenter
foreground.fontSize = 48
foreground.opacity = 0.5
foreground.frame = CGRect(x: 20, y: 20, width: 600, height: 60)
foreground.masksToBounds = true
     
if let blurFilter = CIFilter(name: "CIGaussianBlur",
                             withInputParameters: [kCIInputRadiusKey: 2]) {
    foreground.backgroundFilters = [blurFilter]
}
     
view.layer?.addSublayer(background)
background.addSublayer(foreground)
```

Figure 1 shows the result: the background layer is only blurred where it is overlapped by the foreground layer.

图1 展示了结果：背景层只在其被前景层覆盖的部分变得模糊。

**Figure 1** Background filter effect with mask to bounds **图1** 带有遮罩边界的背景过滤效果
![Background filter effect with mask to bounds](https://docs-assets.developer.apple.com/published/999cb9071c/57122c4e-e0ed-4e7f-8ef2-3f54a7a4d6b7.png)

However, if the foreground layer's `masksToBounds` is set to `false`, the entire background layer is blurred as illustrated in Figure 2.

但是，如果前景层的 `masksToBounds` 属性设置成 `false`，整个背景层都会变得模糊，如 图2 所示。

**Figure 2** Background filter effect without mask to bounds **图2** 不带遮罩边界的背景过滤效果
![Background filter effect without mask to bounds](https://docs-assets.developer.apple.com/published/999cb9071c/6428eea9-2c81-45ae-97bc-ee529d04b58b.png)

# Special Considerations 特别注意事项

This property is not supported on layers in iOS.

iOS中的图层不支持此属性。


# See Also

## Layer Filters

### var [filters](https://developer.apple.com/documentation/quartzcore/calayer/1410901-filters?changes=la_11_3): [Any]?

An array of Core Image filters to apply to the contents of the layer and its sublayers. Animatable.

### var [compositingFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410748-compositingfilter?changes=la_11_3): Any?
A CoreImage filter used to composite the layer and the content behind it. Animatable.

### var [backgroundFilters](https://developer.apple.com/documentation/quartzcore/calayer/1410827-backgroundfilters?changes=la_11_3): [Any]?

An array of Core Image filters to apply to the content immediately behind the layer. Animatable.

### var [minificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410898-minificationfilter?changes=la_11_3): CALayerContentsFilter

The filter used when reducing the size of the content.

### var [minificationFilterBias](https://developer.apple.com/documentation/quartzcore/calayer/1410775-minificationfilterbias?changes=la_11_3): Float

The bias factor used by the minification filter to determine the levels of detail.

### var [magnificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3): CALayerContentsFilter
The filter used when increasing the size of the content.