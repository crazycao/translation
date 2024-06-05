# filters

原文地址：[https://developer.apple.com/documentation/quartzcore/calayer/1410901-filters?changes=la_11_3](https://developer.apple.com/documentation/quartzcore/calayer/1410901-filters?changes=la_11_3)

An array of Core Image filters to apply to the contents of the layer and its sublayers. Animatable.

应用于图层和它的子图层的 Core Image 过滤器数组。可以动画化。

# Declaration 声明

`var filters: [Any]? { get set }`

# Discussion

The filters you add to this property affect the content of the layer, including its border, filled background and sublayers. The default value of this property is `nil`.

添加到此属性的过滤器会影响图层的内容，包括其边框、填充背景和子图层。此属性的默认值为 `nil`。

Changing the inputs of the [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter?changes=la_11_3) object directly after it is attached to the layer causes undefined behavior. It is possible to modify filter parameters after attaching them to the layer but you must use the layer’s [setValue(_:forKeyPath:)](https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue?changes=la_11_3) method to do so. In addition, you must assign a name to the filter so that you can identify it in the array. For example, to change the `inputRadius` parameter of the filter, you could use code similar to the following:

在 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter?changes=la_11_3) 对象附着到图层后直接更改其输入会导致未定义的行为。在将过滤器参数附着到图层后，可以修改过滤器参数，但必须使用图层的 [setValue(_:forKeyPath:)](https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue?changes=la_11_3) 方法进行修改。此外，必须为筛选器指定一个名称，以便在数组中识别它。例如，要更改过滤器的 `inputRadius` 参数，可以使用如下代码：

```
let layer = CALayer()
         
if let filter = CIFilter(name:"CIGaussianBlur") {
    filter.name = "myFilter"
    layer.backgroundFilters = [filter]
    layer.setValue(1,
                   forKeyPath: "backgroundFilters.myFilter.inputRadius")
}
```

Listing 2 shows how to create a text layer and apply a [CIPointillize](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPointillize) filter to it.

代码2 展示了如何创建文本层并在上面应用 [CIPointillize](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIPointillize) 过滤器。

**Listing 2** Applying a pointillize filter to a text layer **代码2：**将点式过滤器应用于文本层

```
view.layer = CALayer()
view.layerUsesCoreImageFilters = true
   
let textLayer = CATextLayer()
textLayer.string = "Core Animation"
textLayer.foregroundColor = NSColor.blue.cgColor
textLayer.backgroundColor = NSColor.lightGray.cgColor
textLayer.alignmentMode = kCAAlignmentCenter
textLayer.fontSize = 100
textLayer.frame = CGRect(x: 10, y: 10, width: 700, height: 140)
    
if let filter = CIFilter(name: "CIPointillize",
                         withInputParameters: ["inputRadius": 6]) {
    textLayer.filters = [filter]
}
   
view.layer?.addSublayer(textLayer)
```

Figure 1 shows the result: a pointillist effect is added to the text.

图1 展示了结果：添加到文本上的点画效果。

**Figure 1** Text layer with applied filter **图1** 应用了过滤器的文本层

![Text layer with applied filter](https://docs-assets.developer.apple.com/published/999cb9071c/4d6e99c4-c6bb-4a02-8c16-38928c0f48c3.png)

# Special Considerations 特别注意事项

This property is not supported on layers in iOS.

iOS中的图层不支持此属性。


# See Also

## Layer Filters

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