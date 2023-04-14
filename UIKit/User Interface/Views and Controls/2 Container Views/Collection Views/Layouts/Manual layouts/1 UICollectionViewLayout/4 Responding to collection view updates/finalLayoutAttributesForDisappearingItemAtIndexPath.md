# finalLayoutAttributesForDisappearingItemAtIndexPath:

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617740-finallayoutattributesfordisappea?language=objc](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617740-finallayoutattributesfordisappea?language=objc)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Retrieves the final layout information for an item that is about to be removed from the collection view.
   
检索将要从集合视图中删除的项的最终布局信息。

# Declaration 声明
```
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath;
```

# Parameters 参数

- itemIndexPath

	The index path of the item being deleted.
	
	正在删除的项目的索引路径。

# Return Value 返回值

A layout attributes object that describes the position of the cell to use as the end point for animating its removal.

描述要用作其移除动画的终点的单元格位置的布局属性对象。

# Discussion 讨论

This method is called after the [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates?language=objc) method and before the [finalizeCollectionViewUpdates](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc) method for any items that are about to be inserted. Your implementation should return the layout information that describes the initial position and state of the item. The collection view uses this information as the starting point for any animations. (The end point of the animation is the item’s new location in the collection view.) If you return nil, the layout object uses the item’s final attributes for both the start and end points of the animation.

This method is called after the [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates?language=objc) method and before the [finalizeCollectionViewUpdates](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc) method for any items that are about to be deleted. Your implementation should return the layout information that describes the final position and state of the item. The collection view uses this information as the end point for any animations. (The starting point of the animation is the item’s current location.) If you return nil, the layout object uses the same attributes for both the start and end points of the animation.

对于将要删除的任何项目，会在 [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates?language=objc) 方法之后和 [finalizeCollectionViewUpdates](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc) 方法之前调用此方法。您的实现应该返回描述项目的最终位置和状态的布局信息。集合视图使用此信息作为任何动画的终点。（动画的起点是项目的当前位置。）如果返回 `nil`，布局对象将对动画的起点和终点使用相同的属性。

The default implementation of this method returns `nil`.

此方法的默认实现返回 `nil`。