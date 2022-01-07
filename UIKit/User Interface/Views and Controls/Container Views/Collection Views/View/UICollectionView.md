# UICollectionView

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionview](https://developer.apple.com/documentation/uikit/uicollectionview)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+


An object that manages an ordered collection of data items and presents them using customizable layouts.
   
一种对象，用于管理数据项的有序集合，并使用可自定义的布局显示这些数据项。

# Declaration 声明
```
@MainActor class UICollectionView : UIScrollView
```

# Overview 概览

When you add a collection view to your user interface, your app's main job is to manage the data associated with that collection view. The collection view gets its data from the data source object, stored in the collection view’s [dataSource](https://developer.apple.com/documentation/uikit/uicollectionview/1618091-datasource) property. For your data source, you can use a [UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource) object, which provides the behavior you need to simply and efficiently manage updates to your collection view's data and user interface. Alternatively, you can create a custom data source object by adopting the [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) protocol.

将集合视图添加到用户界面时，应用程序的主要任务是管理与该集合视图关联的数据。集合视图从数据源对象获取数据，数据源对象存储在集合视图的 [dataSource](https://developer.apple.com/documentation/uikit/uicollectionview/1618091-datasource) 属性中。可以使用 [UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource) 对象作为数据源，该对象提供了简单高效地管理集合视图数据和用户界面更新所需的行为。或者，可以通过采用 [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) 协议创建自定义数据源对象。

Data in the collection view is organized into individual items, which you can group into sections for presentation. An item is the smallest unit of data you want to present. For example, in a photos app, an item might be a single image. The collection view presents items onscreen using a cell, which is an instance of the [UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell) class that your data source configures and provides.

集合视图中的数据被组织到各个项目中，再将这些项目分组到多个节（section）进行显示。项目是要显示的最小数据单位。例如，在照片应用程序中，项目可能是单个图像。集合视图使用单元格在屏幕上显示项目，单元格是按照你的数据源配置和提供的 [UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell) 类的实例。

**Figure 1** A collection view using the flow layout  **图1** 使用流式布局的集合视图
![A collection view using the flow layout](https://docs-assets.developer.apple.com/published/a84db79dea/50390428-f9f2-4cbc-bd99-1cacca4f0617.png)

In addition to its cells, a collection view can present data using other types of views. These supplementary views can be, for example, section headers and footers that are separate from the individual cells but still convey information. Support for supplementary views is optional and defined by the collection view’s layout object, which is also responsible for defining the placement of those views.

除单元格外，集合视图还可以使用其他类型的视图显示数据。例如，这些补充视图可以是独立于单元格之外但仍传递信息的节（section）页眉和页脚。对补充视图的支持是可选的，并由集合视图的布局对象定义，该对象还负责定义这些视图的放置。

Besides embedding a `UICollectionView` in your user interface, you use the methods of the collection view to ensure that the visual presentation of items matches the order in your data source object. A [UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource) object manages this process automatically. If you're using a custom data source, then whenever you add, delete, or rearrange data in your collection, you use the methods of `UICollectionView` to insert, delete, and rearrange the corresponding cells.

除了在用户界面中嵌入 `UICollectionView` 之外，还可以使用集合视图的方法来确保项目的可视化表示与数据源对象中的顺序相匹配。[UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource) 对象自动管理此过程。如果使用的是自定义数据源，则无论何时在集合中添加、删除或重新排列数据，都要使用 `UICollectionView` 的方法插入、删除和重新排列相应的单元格。

You also use the collection view object to manage the selected items, although for this behavior the collection view works with its associated [delegate](https://developer.apple.com/documentation/uikit/uicollectionview/1618033-delegate) object.

您还可以使用集合视图对象来管理所选项目，尽管集合视图会与其关联的 [delegate](https://developer.apple.com/documentation/uikit/uicollectionview/1618033-delegate) 对象一起处理这个行为。

## Layouts 布局

A layout object defines the visual arrangement of the content in the collection view. A subclass of the [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout) class, the layout object defines the organization and location of all cells and supplementary views inside the collection view. Although it defines their locations, the layout object doesn’t actually apply that information to the corresponding views. The collection view applies layout information to the corresponding views because the creation of cells and supplementary views involves coordination between the collection view and your data source object. The layout object is like another data source, except it provides visual information instead of item data.

布局对象定义集合视图中内容的视觉排列。布局对象是 [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout) 类的子类，它定义集合视图中所有单元格和补充视图的组织和位置。尽管布局对象定义了它们的位置，但实际上并没有将该信息应用到相应的视图。集合视图会将布局信息应用于相应的视图，因为单元格和补充视图的创建会涉及集合视图和数据源对象之间的协调。布局对象类似于另一个数据源，只是它提供了可视信息而不是项数据。

You typically specify a layout object when you create a collection view, but you can also change the layout of a collection view dynamically. The layout object is stored in the [collectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionview/1618047-collectionviewlayout) property. Setting this property directly updates the layout immediately, without animating the changes. If you want to animate the changes, call the [setCollectionViewLayout(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618017-setcollectionviewlayout) method instead.

通常在创建集合视图时指定布局对象，但也可以动态更改集合视图的布局。布局对象存储在 [collectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionview/1618047-collectionviewlayout) 属性中。直接设置此属性可立即更新布局，而没有布局变化的动画效果。如果要通过动画来展示这些变化，请改为调用  [setCollectionViewLayout(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618017-setcollectionviewlayout) 方法。

To create an interactive transition—one that is driven by a gesture recognizer or touch events—use the [startInteractiveTransition(to:completion:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618098-startinteractivetransition) method to change the layout object. That method installs an intermediate layout object, which works with your gesture recognizer or event-handling code to track the transition progress. When your event-handling code determines that the transition is finished, it calls the [finishInteractiveTransition()](https://developer.apple.com/documentation/uikit/uicollectionview/1618080-finishinteractivetransition) or [cancelInteractiveTransition()](https://developer.apple.com/documentation/uikit/uicollectionview/1618075-cancelinteractivetransition) method to remove the intermediate layout object and install the intended target layout object.

要创建由手势识别器或触摸事件驱动的交互式转换，请使用 [startInteractiveTransition(to:completion:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618098-startinteractivetransition) 方法更改布局对象。该方法安装一个中间布局对象，该对象与手势识别器或事件处理代码一起工作，以跟踪转换进度。当事件处理代码确定转换已完成时，它将调用  [finishInteractiveTransition()](https://developer.apple.com/documentation/uikit/uicollectionview/1618080-finishinteractivetransition) 或 [cancelInteractiveTransition()](https://developer.apple.com/documentation/uikit/uicollectionview/1618075-cancelinteractivetransition) 方法来删除中间布局对象并安装预期的目标布局对象。

For more information, see [Layouts](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts).

更多详细信息，请参见  [Layouts](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts)。

## Cells and Supplementary Views 单元格和补充视图

The collection view’s data source object provides both the content for items and the views used to present that content. When the collection view first loads its content, it asks its data source to provide a view for each visible item. The collection view maintains a queue or list of view objects that the data source has marked for reuse. Instead of creating new views explicitly in your code, you always dequeue views.

集合视图的数据源对象既提供项的内容，也提供用于表示该内容的视图。当集合视图首次加载其内容时，它会要求其数据源为每个可见项提供一个视图。集合视图维护数据源可重用的视图对象的队列或列表。与在代码中显式创建新视图不同，您可以将视图从队列中取出。

There are two methods for dequeueing views. The one you use depends on which type of view has been requested:

有两种方法可以使视图出列。使用哪种方法取决于请求的视图类型：

- Use the [dequeueReusableCell(withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618063-dequeuereusablecell) to get a cell for an item in the collection view.

  使用 [dequeueReusableCell(withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618063-dequeuereusablecell) 方法为集合视图的一个项目获取一个单元格。

- Use the [dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618068-dequeuereusablesupplementaryview) method to get a supplementary view requested by the layout object.

  使用 [dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618068-dequeuereusablesupplementaryview) 方法获取一个由布局对象请求的补充视图。

Before you call either of these methods, you must tell the collection view how to create the corresponding view if one does not already exist. For this, you must register either a class or a `nib` file with the collection view. For example, when registering cells, you use the [register(_:forCellWithReuseIdentifier:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618089-register) method to register a class or the [register(_:forCellWithReuseIdentifier:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618083-register) method to register a `nib` file. As part of the registration process, you specify the reuse identifier that identifies the purpose of the view. This is the same string you use when dequeueing the view later.

在调用这些方法之前，必须告诉集合视图如果对应视图不存在时，如何创建它。为此，必须在collection视图中注册一个类或 `nib` 文件。例如，在注册单元格时，您可以使用 [register(_:forCellWithReuseIdentifier:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618089-register) 方法注册类，或者使用 [register(_:forCellWithReuseIdentifier:)](https://developer.apple.com/documentation/uikit/uicollectionview/1618083-register) 方法注册 `nib` 文件。作为注册过程的一部分，您可以指定标识视图用途的重用标识符。这与您稍后将视图移出队列时使用的字符串相同。

After dequeueing the appropriate view in your data source method, configure its content and return it to the collection view for use. After getting the layout information from the layout object, the collection view applies it to the view and displays it.

将数据源方法中的相应视图出列后，配置其内容并将其返回到集合视图以供使用。从布局对象获取布局信息后，集合视图将其应用于视图并显示。

## Data Prefetching 数据预取

Collection views provide two prefetching techniques you can use to improve responsiveness:

集合视图提供了两种预取技术，可用于提高响应能力：

- _Cell prefetching_ prepares cells in advance of the time they are required. When a collection view requires a large number of cells simultaneously—for example, a new row of cells in grid layout—the cells are requested earlier than the time required for display. Cell rendering is therefore spread across multiple layout passes, resulting in a smoother scrolling experience. Cell prefetching is enabled by default.

  **单元格预取**在所需时间之前准备单元格。当集合视图同时需要大量单元格时（例如，网格布局中一个新行的单元格），将在需要显示之前请求这些单元格。因此，单元格渲染分布在多个布局过程中，从而获得更平滑的滚动体验。默认情况下启用单元格预取。
  
- _Data prefetching_ provides a mechanism whereby you are notified of the data requirements of a collection view in advance of the requests for cells. This is useful if the content of your cells relies on an expensive data loading process, such as a network request. Assign an object that conforms to the [UICollectionViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uicollectionviewdatasourceprefetching) protocol to the [prefetchDataSource](https://developer.apple.com/documentation/uikit/uicollectionview/1771768-prefetchdatasource) property to receive notifications of when to prefetch data for cells.

  **数据预取**提供了一种机制，通过该机制，可以在单元格请求之前通知您集合视图的数据需求。如果单元格的内容重度依赖于数据加载过程（如网络请求），则此功能非常有用。将符合 [UICollectionViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uicollectionviewdatasourceprefetching) 协议的对象分配给 [prefetchDataSource](https://developer.apple.com/documentation/uikit/uicollectionview/1771768-prefetchdatasource) 属性，以接收预取单元格数据的通知。

## Reordering Items Interactively

Collection views allow you to move items around based on user interactions. Typically, the order of items in a collection view is defined by your data source. If you allow users to reorder items, you can configure a gesture recognizer to track the user’s interactions with a collection view item and update that item’s position.
To begin the interactive repositioning of an item, call the beginInteractiveMovementForItem(at:) method of the collection view. While your gesture recognizer is tracking touch events, call the updateInteractiveMovementTargetPosition(_:) method to report changes in the touch location. When you are done tracking the gesture, call the endInteractiveMovement() or cancelInteractiveMovement() method to conclude the interactions and update the collection view.
During user interactions, the collection view invalidates its layout dynamically to reflect the current position of the item. If you do nothing, the default layout behavior repositions the items for you, but you can customize the layout animations if you want. When interactions finish, the collection view updates its data source object with the new location of the item.
The UICollectionViewController class provides a default gesture recognizer that you can use to rearrange items in its managed collection view. To install this gesture recognizer, set the installsStandardGestureForInteractiveMovement property of the collection view controller to true.

# See Also 其它参考

## Container Views 容器视图

### [Autosizing Views for Localization in iOS](https://developer.apple.com/documentation/xcode/autosizing_views_for_localization_in_ios)

Add auto layout constraints to your app to achieve localizable views.

向应用程序添加自动布局约束，以实现可本地化的视图。

### [Table Views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views)

Display data in a single column of customizable rows.

在一列可自定义的行中显示数据。

### class [UIStackView](https://developer.apple.com/documentation/uikit/uistackview)

A streamlined interface for laying out a collection of views in either a column or a row.

用于在列或行中布局视图集合的流线型界面。

### class [UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview)

A view that allows the scrolling and zooming of its contained views.

允许滚动和缩放其包含视图的视图。
