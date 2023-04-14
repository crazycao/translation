# finalizeCollectionViewUpdates

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617787-finalizecollectionviewupdates?language=objc)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+

Performs any additional animations or clean up needed during a collection view update.
   
在集合视图更新期间执行所需的任何其他动画或清理。

# Declaration 声明
```
- (void)finalizeCollectionViewUpdates;
```

# Discussion 讨论

The collection view calls this method as the last step before proceeding to animate any changes into place. This method is called within the animation block used to perform all of the insertion, deletion, and move animations so you can create additional animations using this method as needed. Otherwise, you can use it to perform any last minute tasks associated with managing your layout object’s state information.

集合视图调用此方法作为继续设置任何更改的动画之前的最后一步。此方法在用于执行所有插入、删除和移动动画的动画块中调用，因此您可以根据需要使用此方法创建其他动画。否则，您可以使用它来执行与管理布局对象的状态信息相关的任何最后一分钟任务。
