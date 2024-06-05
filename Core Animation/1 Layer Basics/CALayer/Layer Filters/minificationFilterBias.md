# minificationFilterBias

原文地址：[https://developer.apple.com/documentation/quartzcore/calayer/1410775-minificationfilterbias?changes=la_11_3](https://developer.apple.com/documentation/quartzcore/calayer/1410775-minificationfilterbias?changes=la_11_3)

The bias factor used by the minification filter to determine the levels of detail.

缩小过滤器用于确定细节级别的偏差系数。

# Declaration 声明

`var minificationFilterBias: Float { get set }`

# Discussion

This value is used by the [minificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410898-minificationfilter?changes=la_11_3) when it is set to [trilinear](https://developer.apple.com/documentation/quartzcore/calayercontentsfilter/1410978-trilinear?changes=la_11_3).

当 [minificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410898-minificationfilter?changes=la_11_3) 设置为 [trilinear](https://developer.apple.com/documentation/quartzcore/calayercontentsfilter/1410978-trilinear?changes=la_11_3) 时，将使用这个值。

The default value of this property is `0.0`.

这个属性的默认值是 `0.0`。

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

### var [magnificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3): CALayerContentsFilter
The filter used when increasing the size of the content.