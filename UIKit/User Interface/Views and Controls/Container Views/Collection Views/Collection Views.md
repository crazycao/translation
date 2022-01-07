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

- class [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)

   An object that manages an ordered collection of data items and presents them using customizable layouts.
   
   一种对象，用于管理数据项的有序集合，并使用可自定义的布局显示这些数据项。
   
- class [UICollectionViewController](https://developer.apple.com/documentation/uikit/uicollectionviewcontroller)

   A view controller that specializes in managing a collection view.
   
   专门管理集合视图的视图控制器。

## Data 数据

## Cell 单元格

## Layouts 布局

## Selection Management 选中管理

## Drag and Drop 拖动和放下


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
