# magnificationFilter

原文地址：[https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3](https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3)

The filter used when increasing the size of the content.

增加内容大小时使用的滤波器。

# Declaration 声明

`var magnificationFilter: CALayerContentsFilter { get set }`

# Discussion

The possible values for this property are listed in [Scaling Filters](https://developer.apple.com/documentation/quartzcore/calayer/scaling_filters?changes=la_11_3).

这个属性的可能值列在 [Scaling Filters](./Scaling%20Filters.md) 中。

The default value of this property is [linear](https://developer.apple.com/documentation/quartzcore/calayercontentsfilter/1410850-linear?changes=la_11_3).

这个属性的默认值是 [linear](./Scaling%20Filters.md).

Figure 1 shows the difference between linear and nearest filtering when a 10 x 10 point image of a circle is magnified by a scale of 10.

图1 展示了当一个 10x10 的圆形图像放大10倍时，线性滤波和最近滤波之间的差异。

Figure 1 Circle with different magnification filters

图1：使用了不同放大滤波器的圆形

![Circle with different magnification filters](https://docs-assets.developer.apple.com/published/999cb9071c/789af79b-2db9-42ce-b9f2-4125d32aed3b.png)

The circle on the left uses linear and the circle on the right uses nearest.

左边的圆形使用了线性滤波，而右边的圆形使用了最近滤波。

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