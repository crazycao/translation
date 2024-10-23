# setContentCompressionResistancePriority(_:for:)

原文地址：
[https://developer.apple.com/documentation/uikit/uiview/1622526-setcontentcompressionresistancep](https://developer.apple.com/documentation/uikit/uiview/1622526-setcontentcompressionresistancep)

>__Framework__
>
> UIKit
> 
> iOS 6.0+
iPadOS 6.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+

Sets the priority with which a view resists being made smaller than its intrinsic size.

设置视图抵抗被压缩到比其固有大小还小的优先级。

## Declaration 声明

```
func setContentCompressionResistancePriority(
    _ priority: UILayoutPriority,
    for axis: NSLayoutConstraint.Axis
)
```

## Parameters 参数

- **priority**

	The new priority.
	
	新的优先级。

- **axis**

	The axis for which the compression resistance priority should be set.
	
	设置抗压缩优先级的轴。


## Discussion 讨论

Custom views should set default values for both orientations on creation, based on their content, typically to `UILayoutPriorityDefaultLow` or `UILayoutPriorityDefaultHigh`. When creating user interfaces, the layout designer can modify these priorities for specific views when the overall layout design requires different tradeoffs than the natural priorities of the views being used in the interface.

自定义视图在创建时应根据其内容为两个方向设置默认值，通常为 `UILayoutPriorityDefaultLow` 或 `UILayoutPriorityDefaultHigh`。在创建用户界面时，布局设计师可以根据整体布局设计所需的不同权衡来修改这些视图的优先级，以使其与界面中使用的视图的自然优先级不同。

Subclasses should not override this method.

子类不应重载该方法。

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
