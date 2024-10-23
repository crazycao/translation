# systemLayoutSizeFitting(_:)

原文地址：
[https://developer.apple.com/documentation/uikit/uiview/1622624-systemlayoutsizefitting/](https://developer.apple.com/documentation/uikit/uiview/1622624-systemlayoutsizefitting/)

>__Framework__
>
> UIKit

Returns the optimal size of the view based on its current constraints.

返回基于当前约束的视图的最佳大小。

## Declaration 声明

```
func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize
```

## Parameters 参数

- **targetSize**

	The size that you prefer for the view. To obtain a view that is as small as possible, specify the constant `layoutFittingCompressedSize`. To obtain a view that is as large as possible, specify the constant `layoutFittingExpandedSize`.
	
	视图所需的大小。要获得尽可能小的视图，请指定常量 `layoutFittingCompressedSize`。要获得尽可能大的视图，请指定常量`layoutFittingExpandedSize`。

## Return Value 返回值

The optimal size for the view.

视图的最佳大小。

## Discussion 讨论

This method returns a size value for the view that optimally satisfies the view's current constraints and is as close to the value in the targetSize parameter as possible. This method does not actually change the size of the view.

此方法为视图返回一个大小值，该值以最佳方式满足视图的当前约束，并尽可能接近 `targetSize` 参数中的值。此方法实际上不会更改视图的大小。

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

设置视图抵抗从其固有大小被缩小的优先级。

### `func contentHuggingPriority(for: NSLayoutConstraint.Axis) -> UILayoutPriority`

Returns the priority with which a view resists being made larger than its intrinsic size.

返回视图抵抗从其固有大小被放大的优先级。

### `func setContentHuggingPriority(UILayoutPriority, for: NSLayoutConstraint.Axis)`

Sets the priority with which a view resists being made larger than its intrinsic size.

设置视图抵抗从其固有大小被放大的优先级。
