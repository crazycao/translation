# initialLayoutAttributesForAppearingItemAtIndexPath:

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617789-initiallayoutattributesforappear](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617789-initiallayoutattributesforappear)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Retrieves the starting layout information for an item being inserted into the collection view.
   
检索正在插入集合视图中的项目的起始布局信息。

# Declaration 声明
```
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath;
```

# Parameters 参数

- itemIndexPath

	The index path of the item being inserted. You can use this path to locate the item in the collection view’s data source.
	
	正在插入的项目的索引路径。可以使用此路径在集合视图的数据源中查找该项目。

# Return Value 返回值

A layout attributes object that describes the position at which to place the corresponding cell.

描述放置相应单元格的位置的布局属性对象。

# Discussion 讨论

This method is called after the [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates?language=objc) method and before the [finalizeCollectionViewUpdates](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc) method for any items that are about to be inserted. Your implementation should return the layout information that describes the initial position and state of the item. The collection view uses this information as the starting point for any animations. (The end point of the animation is the item’s new location in the collection view.) If you return nil, the layout object uses the item’s final attributes for both the start and end points of the animation.

对于将要插入的任何项目，会在 [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates?language=objc) 方法之后和 [finalizeCollectionViewUpdates](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc) 方法之前调用此方法。您的实现应该返回描述项目的初始位置和状态的布局信息。集合视图使用此信息作为任何动画的起点。（动画的终点是项目在集合视图中的新位置。）如果返回 `nil`，布局对象将使用项目的最终属性作为动画的起点和终点。

The default implementation of this method returns `nil`.

此方法的默认实现返回 `nil`。