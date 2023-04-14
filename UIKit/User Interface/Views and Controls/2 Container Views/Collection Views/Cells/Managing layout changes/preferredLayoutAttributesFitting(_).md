# preferredLayoutAttributesFitting(_:)

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620132-preferredlayoutattributesfitting](https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620132-preferredlayoutattributesfitting)

>__Framework__
>
> UIKit

Gives the cell a chance to modify the attributes provided by the layout object.

使单元格有机会修改布局对象提供的属性。

## Declaration 声明

```
func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
```

## Parameters 参数

- **layoutAttributes**

	The attributes provided by the layout object. These attributes represent the values that the layout intends to apply to the cell.
	
	布局对象提供的属性。这些属性表示布局要应用于单元格的值。

## Return Value 返回值

The final attributes to apply to the cell.

要应用于单元格的最终属性。

## Discussion 讨论

The default implementation of this method adjusts the size values to accommodate changes made by a self-sizing cell. Subclasses can override this method and use it to adjust other layout attributes too. If you override this method and want the cell size adjustments, call super first and make your own modifications to the returned attributes.

此方法的默认实现会调整大小值，以适应自调整大小的单元格所做的更改。子类可以重写此方法，并使用它来调整其他布局属性。如果重写此方法并希望调整单元格大小，请首先调用 super 然后对返回的属性进行自己的修改。

# See Also 其它参考

## Managing layout changes - 管理布局修改

### [func apply(UICollectionViewLayoutAttributes)](https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620139-apply)

Applies the specified layout attributes to the view.

将指定的布局属性应用于视图。

### [func willTransition(from: UICollectionViewLayout, to: UICollectionViewLayout)](https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620140-willtransition)

Tells your view that the layout object of the collection view is about to change.

### [func didTransition(from: UICollectionViewLayout, to: UICollectionViewLayout)](https://developer.apple.com/documentation/uikit/uicollectionreusableview/1620129-didtransition)

Tells your view that the layout object of the collection view changed.
