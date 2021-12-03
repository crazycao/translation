# compositingFilter

原文地址：[https://developer.apple.com/documentation/quartzcore/calayer/1410748-compositingfilter?changes=la_11_3](https://developer.apple.com/documentation/quartzcore/calayer/1410748-compositingfilter?changes=la_11_3)

A CoreImage filter used to composite the layer and the content behind it. Animatable.

用于合成图层及其背后的内容的 Core Image 过滤器。可以动画化。

# Declaration 声明

`var compositingFilter: Any? { get set }`

# Discussion

The default value of this property is `nil`, which causes the layer to use source-over compositing. Although you can use any Core Image filter as a layer's compositing filter, for best results, use those in the [CICategoryCompositeOperation](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW71) category.

该属性的默认值是 `nil`，这会导致图层使用源覆盖合成。尽管您可以使用任何 Core Image 过滤器作为图层层的合成过滤器，但为了获得最佳效果，请使用  [CICategoryCompositeOperation](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW71) 类别中的过滤器。

In macOS, it is possible to modify the filter’s parameters after attaching it to the layer but you must use the layer’s [setValue(_:forKeyPath:)](https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue?changes=la_11_3)  method to do so. For example, to change the `inputRadius` parameter of the filter, you could use code similar to the following:

在 macOS 中，可以在过滤器参数附着到图层后修改过滤器参数，但必须使用图层的 [setValue(_:forKeyPath:)](https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue?changes=la_11_3) 方法进行修改。例如，要更改过滤器的 `inputRadius` 参数，可以使用如下代码：

```
let layer = CALayer()
         
if let filter = CIFilter(name:"CIGaussianBlur") {
    filter.name = "myFilter"
    layer.backgroundFilters = [filter]
    layer.setValue(1,
                   forKeyPath: "backgroundFilters.myFilter.inputRadius")
}
```
Changing the inputs of the  [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter?changes=la_11_3) object directly after it is attached to the layer causes undefined behavior.

在 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter?changes=la_11_3) 对象附着到图层后直接更改其输入会导致未定义的行为。

Listing 2 shows how to create two overlapping text layers, background and foreground. [CIAdditionCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAdditionCompositing) is used to composite the foreground over the background.

代码2显示了如何创建两个重叠的文本层：背景和前景。[CIAdditionCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAdditionCompositing) 用于在背景上合成前景。

**Listing 2** Compositing layers with Addition Compositing **代码2：**使用“添加合成”合成图层

```
view.layer = CALayer()
view.layerUsesCoreImageFilters = true
     
let background = CATextLayer()
background.string = "background"
background.foregroundColor = NSColor.gray.cgColor
background.backgroundColor = NSColor.darkGray.cgColor
background.alignmentMode = kCAAlignmentCenter
background.fontSize = 96
background.frame = CGRect(x: 10, y: 10, width: 640, height: 160)
     
let foreground = CATextLayer()
foreground.string = "foreground"
foreground.foregroundColor = NSColor.lightGray.cgColor
foreground.backgroundColor = NSColor.darkGray.cgColor
foreground.alignmentMode = kCAAlignmentCenter
foreground.fontSize = 48
foreground.opacity = 0.5
foreground.frame = CGRect(x: 20, y: 20, width: 600, height: 60)
foreground.masksToBounds = false
     
if let compositingFilter = CIFilter(name: "CIAdditionCompositing") {
    foreground.compositingFilter = compositingFilter
}
     
view.layer?.addSublayer(background)
background.addSublayer(foreground)
```

Figure 1 shows the result: the identical background colors of the two layers are added together so that a brighter gray is produced where the layers overlap.

图1 展示了结果：两个图层的相同背景色被添加在一起，因此在图层重叠处产生了更亮的灰色。

**Figure 1** Addition compositing filter **图1** “添加合成”过滤器

![Addition compositing filter](https://docs-assets.developer.apple.com/published/999cb9071c/e9632734-c82a-498c-873d-f1553ddae959.png)

Figure 2 shows the default result when the foreground layer's compositing filter is nil or [CISourceOverCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceOverCompositing).

图2 展示了前景图层的合成过滤器是 `nil` 或 [CISourceOverCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceOverCompositing) 时的默认结果。

**Figure 2** Default compositing filter **图2** 默认合成过滤器

![Default compositing filter](https://docs-assets.developer.apple.com/published/999cb9071c/c2e6bdfa-902c-4747-bb14-f61475dc5713.png)



# Special Considerations 特别注意事项

This property is not supported on layers in iOS.

iOS中的图层不支持此属性。


# See Also

## Layer Filters

### var [filters](https://developer.apple.com/documentation/quartzcore/calayer/1410901-filters?changes=la_11_3): [Any]?

An array of Core Image filters to apply to the contents of the layer and its sublayers. Animatable.

### var [backgroundFilters](https://developer.apple.com/documentation/quartzcore/calayer/1410827-backgroundfilters?changes=la_11_3): [Any]?

An array of Core Image filters to apply to the content immediately behind the layer. Animatable.

### var [minificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410898-minificationfilter?changes=la_11_3): CALayerContentsFilter

The filter used when reducing the size of the content.

### var [minificationFilterBias](https://developer.apple.com/documentation/quartzcore/calayer/1410775-minificationfilterbias?changes=la_11_3): Float

The bias factor used by the minification filter to determine the levels of detail.

### var [magnificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3): CALayerContentsFilter
The filter used when increasing the size of the content.