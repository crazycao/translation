# intrinsicContentSize

原文地址：
[https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)

>__Framework__
>
> UIKit
> 
> iOS 6.0+
iPadOS 6.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+

The natural size for the receiving view, considering only properties of the view itself.

接收视图的自然大小，考虑仅视图本身属性。

## Declaration 声明

```
var intrinsicContentSize: CGSize { get }
```

## Discussion 讨论

Custom views typically have content that they display of which the layout system is unaware. Setting this property allows a custom view to communicate to the layout system what size it would like to be based on its content. This intrinsic size must be independent of the content frame, because there’s no way to dynamically communicate a changed width to the layout system based on a changed height, for example.

布局系统通常不知晓自定义视图要显示的内容。设置此属性允许自定义视图向布局系统传达其基于内容希望的大小。这种固有大小必须独立于内容的 frame，例如，因为无法动态地向基于更改的高度的布局系统通知更改的宽度。

If a custom view has no intrinsic size for a given dimension, it can use [noIntrinsicMetric](https://developer.apple.com/documentation/uikit/uiview/1622486-nointrinsicmetric) for that dimension.

如果自定义视图对于给定维度没有固有大小，可以为该维度使用 [noIntrinsicMetric](https://developer.apple.com/documentation/uikit/uiview/1622486-nointrinsicmetric)。

# See Also 其它参考

## Measuring in Auto Layout - 在自动布局中测量

### `func systemLayoutSizeFitting(CGSize) -> CGSize`

Returns the optimal size of the view based on its current constraints.

返回基于当前约束的视图的最佳大小。

### `func systemLayoutSizeFitting(CGSize, withHorizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize`

Returns the optimal size of the view based on its constraints and the specified fitting priorities.

### `var intrinsicContentSize: CGSize`

The natural size for the receiving view, considering only properties of the view itself.

考虑仅视图本身属性的接收视图的自然大小。

### `func invalidateIntrinsicContentSize()`

Invalidates the view’s intrinsic content size.

使视图的固有内容大小无效。

### `func contentCompressionResistancePriority(for: NSLayoutConstraint.Axis) -> UILayoutPriority`

Returns the priority with which a view resists being made smaller than its intrinsic size.

返回视图抵抗被压缩到比其固有大小还小的优先级。

### `func setContentCompressionResistancePriority(UILayoutPriority, for: NSLayoutConstraint.Axis)`

Sets the priority with which a view resists being made smaller than its intrinsic size.

设置视图抵抗被压缩到比其固有大小还小的优先级。

### `func contentHuggingPriority(for: NSLayoutConstraint.Axis) -> UILayoutPriority`

Returns the priority with which a view resists being made larger than its intrinsic size.

返回视图抵抗被拉伸到比其固有大小还大的优先级。

### `func setContentHuggingPriority(UILayoutPriority, for: NSLayoutConstraint.Axis)`

Sets the priority with which a view resists being made larger than its intrinsic size.

设置视图抵抗被拉伸到比其固有大小还大的优先级。
