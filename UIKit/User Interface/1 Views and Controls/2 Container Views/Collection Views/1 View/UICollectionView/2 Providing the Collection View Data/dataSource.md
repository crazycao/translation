# dataSource

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview/1618091-datasource](https://developer.apple.com/documentation/uikit/uicollectionview/1618091-datasource)

The object that provides the data for the collection view.

为集合视图提供数据的对象。

> iOS 6.0+
iPadOS 6.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+

**iOS, iPadOS, Mac Catalyst**

```
weak var dataSource: (any UICollectionViewDataSource)? { get set }
```

**visionOS**

```
weak var dataSource: UICollectionViewDataSource? { get set }
```

# Discussion - 讨论

The data source must adopt the [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) protocol. The collection view maintains a weak reference to the data source object.

数据源必须采用 [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) 协议。集合视图持有对数据源对象的弱引用。

# See Also

## Providing the collection view data - 提供集合视图数据

### class [UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)

The object you use to manage data and provide cells for a collection view.

用来为集合视图管理数据和提供单元格的对象。

#### protocol [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)

The methods adopted by the object you use to manage data and provide cells for a collection view.

用来为集合视图管理数据和提供单元格的对象所采用的方法。

### [Building High-Performance Lists and Collection Views](https://developer.apple.com/documentation/uikit/uiimage/building_high-performance_lists_and_collection_views) - 构建高性能列表和集合视图

Improve the performance of lists and collections in your app with prefetching and image preparation.

通过预取和图像准备，提高应用程序中列表和集合的性能。
