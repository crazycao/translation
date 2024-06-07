# Collection Views

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/collection_views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views)

>__Framework__
>
> UIKit

Display nested views using a configurable and highly customizable layout.

使用可配置且高度可自定义的布局显示嵌套视图。

## Overview 概览

A collection view manages an ordered set of content, such as the grid of photos in the Photos app, and presents it visually.

集合视图管理一组有序的内容，例如照片应用程序中的照片网格，并以视觉方式呈现。

![Screenshot of the Photos app on iOS showing a grid of photos displayed in the Days view.](https://docs-assets.developer.apple.com/published/2feb3d1b37/rendered2x-1627683362.png)

Collection views are a collaboration between many different objects, including:

集合视图是许多不同对象之间的协作，包括：

- Cells. A cell provides the visual representation for each piece of your content.
- 单元格。单元格为内容的每一部分提供视觉表现。

- Layouts. A layout defines the visual arrangement of the content in the collection view.
- 布局。布局定义了集合视图中内容的视觉排列。

- Your data source object. This object adopts the [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) protocol and provides the data for the collection view.
- 数据源对象。此对象采用 [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) 协议，并为集合视图提供数据。

- Your delegate object. This object adopts the [UICollectionViewDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate) protocol and manages user interactions with the collection view's contents, like selection and highlighting.
- 代理对象。此对象采用 [UICollectionViewDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate) 协议，并管理用户与集合视图内容的交互，如选择和突出显示。

- Collection view controller. You typically use a [UICollectionViewController](https://developer.apple.com/documentation/uikit/uicollectionviewcontroller) object to manage a collection view. You can use other view controllers too, but a collection view controller is required for some collection-related features to work.
- 集合视图控制器。通常使用 [UICollectionViewController](https://developer.apple.com/documentation/uikit/uicollectionviewcontroller) 对象来管理集合视图。您也可以使用其他视图控制器，但某些与集合相关的功能需要集合视图控制器才能工作。

# Topics 主题

## View 视图

### class [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)

An object that manages an ordered collection of data items and presents them using customizable layouts.
   
一种对象，用于管理数据项的有序集合，并使用可自定义的布局显示这些数据项。
   
### class [UICollectionViewController](https://developer.apple.com/documentation/uikit/uicollectionviewcontroller)

A view controller that specializes in managing a collection view.
   
专门管理集合视图的视图控制器。

## Data 数据

### [Updating Collection Views Using Diffable Data Sources](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/updating_collection_views_using_diffable_data_sources)

Streamline the display and update of data in a collection view using a diffable data source that contains identifiers.

使用包含标识符的 diffable 数据源简化集合视图中数据的显示和更新。

> **Note：**在 iOS 13 中 Apple 引入了新的 API Diffable Data Source ，让开发者可以更简单高效的实现 UITableView、UICollectionView 的局部数据刷新。在软件开发中 Diff 是一个很重要的概念，有很多应用场景，如 git 版本管理中文件变更应用；React 中虚拟 DOM 用 Diff 算法更新 UI 状态；IGListKit 通过 IGListDiff 自动计算前后两次数据源的差值，实现局部数据刷新。

### [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)

Bring compositional layouts to your app and simplify updating your user interface with diffable data sources.

将合成布局带到应用程序中，并使用 diffable 数据源简化用户界面的更新。

### [Building High-Performance Lists and Collection Views](https://developer.apple.com/documentation/uikit/uiimage/building_high-performance_lists_and_collection_views)

Improve the performance of lists and collections in your app with prefetching and image preparation.

通过预取和图像准备，提高应用程序中列表和集合的性能。

### class [UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource)

The object you use to manage data and provide cells for a collection view.

用于管理数据并为集合视图提供单元格的对象。

### protocol [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource)

The methods adopted by the object you use to manage data and provide cells for a collection view.

用于管理数据和为集合视图提供单元格的对象所采用的方法。

### protocol [UICollectionViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uicollectionviewdatasourceprefetching)

A protocol that provides advance warning of the data requirements for a collection view, allowing the triggering of asynchronous data load operations.

一种为集合视图的数据需求提供提前警告的协议，允许触发异步数据加载操作。

### struct [NSDiffableDataSourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot)

A representation of the state of the data in a view at a specific point in time.

视图中数据在特定时间点的状态表示。

### struct [NSDiffableDataSourceSectionSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesectionsnapshot)

A representation of the state of the data in a layout section at a specific point in time.

布局 section 中的数据在 特定时间点的状态表示。

## Cell 单元格

### class [UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell)

A single data item when that item is within the collection view’s visible bounds.

单个数据项，该数据项位于集合视图的可见边界内。

### class [UICollectionViewListCell](https://developer.apple.com/documentation/uikit/uicollectionviewlistcell)

A collection view cell that provides list features and default styling.

提供列表功能和默认样式的集合视图单元格。

### class [UICollectionReusableView](https://developer.apple.com/documentation/uikit/uicollectionreusableview)

A view that defines the behavior for all cells and supplementary views presented by a collection view.

定义集合视图显示的所有单元格和补充视图的行为的视图。

## Layouts 布局

### [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)

Bring compositional layouts to your app and simplify updating your user interface with diffable data sources.

将合成布局带到应用程序中，并使用 diffable 数据源简化用户界面的更新。

### [Layouts](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts)

Arrange your collection view content in a highly configurable layout.

以高度可配置的布局排列收藏视图内容。

## Selection Management 选中管理

### [Changing the Appearance of Selected and Highlighted Cells](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate/changing_the_appearance_of_selected_and_highlighted_cells)

Provide visual feedback to the user about the state of a cell and the transition between states.

向用户提供有关单元格的状态以及状态之间转换的视觉反馈。

### [Selecting Multiple Items with a Two-Finger Pan Gesture](https://developer.apple.com/documentation/uikit/uitableviewdelegate/selecting_multiple_items_with_a_two-finger_pan_gesture)

Accelerate user selection of multiple items using the multiselect gesture on table and collection views.

使用表格和集合视图上的多选手势，加快用户对多个项目的选择。

## Drag and Drop 拖动和放下

### [Supporting Drag and Drop in Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/supporting_drag_and_drop_in_collection_views)

Initiate drags and handle drops from a collection view.

从集合视图开始拖动和处理放下。

### protocol [UICollectionViewDragDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdragdelegate)

The interface for initiating drags from a collection view.

用于从集合视图开始拖动的接口。

### protocol [UICollectionViewDropDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdropdelegate)

The interface for handling drops in a collection view.

用于在集合视图中处理拖放的接口。

### protocol [UICollectionViewDropCoordinator](https://developer.apple.com/documentation/uikit/uicollectionviewdropcoordinator)

An interface for coordinating your custom drop-related actions with the collection view.

用于协调与集合视图相关的自定义放置操作的接口。

### class [UICollectionViewDropPlaceholder](https://developer.apple.com/documentation/uikit/uicollectionviewdropplaceholder)

A placeholder for an item dropped on a collection view.

放置在集合视图上的项目的占位符。

### class [UICollectionViewDropProposal](https://developer.apple.com/documentation/uikit/uicollectionviewdropproposal)

Your proposed solution for handling a drop in a collection view.

您提出的在集合视图中处理放置的解决方案。

### protocol [UICollectionViewDropItem](https://developer.apple.com/documentation/uikit/uicollectionviewdropitem)

The data associated with an item being dropped into the collection view.

与要放入集合视图的项目关联的数据。

### protocol [UICollectionViewDropPlaceholderContext](https://developer.apple.com/documentation/uikit/uicollectionviewdropplaceholdercontext)

An object that contains information about a placeholder in the collection view.

包含集合视图中的占位符信息的对象。

### protocol [UIDataSourceTranslating](https://developer.apple.com/documentation/uikit/uidatasourcetranslating)

An advanced interface for managing a data source object.

用于管理数据源对象的高级接口。

### class [UICollectionViewPlaceholder](https://developer.apple.com/documentation/uikit/uicollectionviewplaceholder)

A placeholder for an item dragged or dropped on a collection view.

在集合视图上拖动或放置的项目的占位符。

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
