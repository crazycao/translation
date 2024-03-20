# UICollectionViewDataSource

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewdatasource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)

The methods adopted by the object you use to manage data and provide cells for a collection view.

用来为集合视图管理数据和提供单元格的对象所采用的方法。

> iOS 6.0+
iPadOS 6.0+
Mac Catalyst 13.0+
tvOS 9.0+
visionOS 1.0+

```
@MainActor
protocol UICollectionViewDataSource
```

# Overview - 概览

A data source object manages the data in your collection view. It represents your app’s data model and vends information to the collection view as needed. It also creates and configures the cells and supplementary views that the collection view uses to display your data.

数据源对象管理集合视图中的数据。它代表您的应用程序的数据模型，并根据需要向集合视图提供信息。它还创建和配置集合视图用于显示数据的单元格和补充视图。

A collection view data source must conform to the UICollectionViewDataSource protocol. You can use a UICollectionViewDiffableDataSource object as your data source object, which already conforms to this protocol.

集合视图的数据源对象必须遵循 `UICollectionViewDataSource` 协议。您可以使用一个UICollectionViewDiffableDataSource对象作为您的数据源对象，该对象已经符合了这个协议。

Alternatively, you can create a custom data source object by adopting the UICollectionViewDataSource protocol. At a minimum, all data source objects must implement the collectionView(_:numberOfItemsInSection:) and collectionView(_:cellForItemAt:) methods. These methods are responsible for returning the number of items in the collection view along with the items themselves. The remaining methods of the protocol are optional and only needed if your collection view organizes items into multiple sections or provides headers and footers for a given section.

When you configure the collection view object, assign your data source to its dataSource property. For more information about how a collection view works with its data source to present content, see UICollectionView.

