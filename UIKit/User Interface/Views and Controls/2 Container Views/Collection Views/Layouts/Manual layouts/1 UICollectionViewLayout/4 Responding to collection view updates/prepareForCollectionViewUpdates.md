# prepareForCollectionViewUpdates:

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Notifies the layout object that the contents of the collection view are about to change.
   
通知布局对象集合视图的内容即将更改。

# Declaration 声明
```
- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems;
```

# Parameters 参数

- updateItems

	An array of [UICollectionViewUpdateItem](https://developer.apple.com/documentation/uikit/uicollectionviewupdateitem) objects that identify the changes being made.
	
	标识所做更改的 [UICollectionViewUpdateItem](https://developer.apple.com/documentation/uikit/uicollectionviewupdateitem) 对象数组。

# Discussion 讨论

When items are inserted or deleted, the collection view notifies its layout object so that it can adjust the layout as needed. The first step in that process is to call this method to let the layout object know what changes to expect. After that, additional calls are made to gather layout information for inserted, deleted, and moved items that are going to be animated around the collection view.

插入或删除项目时，集合视图会通知其布局对象，以便根据需要调整布局。该过程的第一步是调用此方法，以让布局对象知道预期的更改。之后，将进行其他调用，以收集要在集合视图周围设置动画的插入、删除和移动项目的布局信息。
