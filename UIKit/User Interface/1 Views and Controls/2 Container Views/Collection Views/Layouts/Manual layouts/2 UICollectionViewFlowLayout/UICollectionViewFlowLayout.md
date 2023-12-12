# UICollectionViewFlowLayout

原文地址：
[https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)

>__Framework__
>
>UIKit
> 
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+


A layout object that organizes items into a grid with optional header and footer views for each section.
   
用于将项目组织到网格中的布局对象，每个 section 都具有可选的页眉和页脚视图。

# Declaration 声明
```
@MainActor class UICollectionViewFlowLayout : UICollectionViewLayout
```

# Overview 概览

A flow layout is a type of collection view layout. Items in the collection view flow from one row or column (depending on the scrolling direction) to the next, with each row containing as many cells as will fit. Cells can be the same sizes or different sizes.

流式布局是一种 collection 视图布局。Collection 视图中的项目从一行或列（取决于滚动方向）流向下一行或列，每行包含尽可能多的单元格。单元格大小可以相同，也可以不同。

A flow layout works with the collection view’s delegate object to determine the size of items, headers, and footers in each section and grid. That delegate object must conform to the [UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout) protocol. Use of the delegate allows you to adjust layout information dynamically. For example, you use a delegate object to specify different sizes for items in the grid. If you don’t provide a delegate, the flow layout uses the default values you set in the properties of this class.

流式布局与 collection 视图的委托对象配合使用，以确定每个部分和网格中项目、页眉和页脚的大小。该委托对象必须遵守 [UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout) 协议。使用委托可以动态调整布局信息。例如，可以使用委托对象为网格中的项目指定不同的大小。如果没有提供委托，则流式布局将使用在此类的属性中设置的默认值。

Flow layouts lay out their content using a fixed distance in one direction and a scrollable distance in the other. For example, in a vertically scrolling grid, the width of the grid content is constrained to the width of the corresponding collection view while the height of the content adjusts dynamically to match the number of sections and items in the grid. The layout scrolls vertically by default, but you can configure the scrolling direction using the [scrollDirection](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617720-scrolldirection) property.

流式布局使用在一个方向上固定距离，在另一个方向上可滚动距离的方式来布局其内容。例如，在垂直滚动的网格中，网格内容的宽度约束为相应 collection 视图的宽度，而内容的高度则动态调整，以匹配网格中的 section 数和项目数。默认情况下，布局垂直滚动，但您可以使用 [scrollDirection](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617720-scrolldirection) 属性配置滚动方向。

Each section in a flow layout can have its own custom header and footer. To configure the header or footer for a view, configure the size of the header or footer to be non-zero. Implement the appropriate delegate methods or assign appropriate values to the [headerReferenceSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617710-headerreferencesize) and [footerReferenceSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617703-footerreferencesize) properties. If the header or footer size is 0, the corresponding view isn’t added to the collection view.

流式布局中的每个 section 都可以有自己的自定义页眉和页脚。要为视图配置页眉或页脚，请将页眉或页脚的大小配置为非零。实现适当的委托方法，或为 [headerReferenceSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617710-headerreferencesize) 和 [footerReferenceSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617703-footerreferencesize) 属性分配适当的值。如果页眉或页脚大小为0，则不会将相应的视图添加到 collection 视图中。

# Topics 主题

## Configuring the Flow Layout - 配置流式布局

### protocol [UICollectionViewDelegateFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewdelegateflowlayout)

The methods that let you coordinate with a flow layout object to implement a grid-based layout.

用于与流式布局对象协作以实现基于网格的布局的方法。

## Configuring the Scroll Direction - 配置滚动方向

### var [scrollDirection](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617720-scrolldirection): UICollectionView.ScrollDirection

The scroll direction of the grid.

网格的滚动方向。

### enum [UICollectionView.ScrollDirection](https://developer.apple.com/documentation/uikit/uicollectionview/scrolldirection)

Constants that indicate the direction of scrolling for the layout.

表示布局滚动方向的常量。

## Configuring Item Spacing - 配置项目间距

### var [minimumLineSpacing](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617717-minimumlinespacing): CGFloat

The minimum spacing to use between lines of items in the grid.

网格中项目行之间的最小距离。

### var [minimumInteritemSpacing](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617706-minimuminteritemspacing): CGFloat

The minimum spacing to use between items in the same row.

同一行中的项目之间的最小距离。

### var [itemSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617711-itemsize): CGSize

The default size to use for cells.

单元格的默认大小。

### var [estimatedItemSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617709-estimateditemsize): CGSize

The estimated size of cells in the collection view.

Collection 视图中的单元格的估计大小。

### class let [automaticSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1779556-automaticsize): CGSize

A placeholder size for self-sizing cells.

自调整大小的单元格的占位符大小。

### var [sectionInset](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617714-sectioninset): UIEdgeInsets

The margins used to lay out content in a section.

在 section 中布局内容的边距。

### var [sectionInsetReference](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/2921645-sectioninsetreference): UICollectionViewFlowLayout.SectionInsetReference

The boundary that section insets are defined in relation to.

Section 内边距被定义的相对边界。

### enum [UICollectionViewFlowLayout.SectionInsetReference](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/sectioninsetreference)

Constants that describe the reference point of the section insets.

描述 section 内边距的参考点的常量。

## Configuring Headers and Footers
### var headerReferenceSize: CGSize
The default sizes to use for section headers.
### var footerReferenceSize: CGSize
The default sizes to use for section footers.
### Flow Layout Supplementary Views
Constants that specify the types of supplementary views that can be presented using a flow layout.
## Pinning Headers and Footers
### var sectionHeadersPinToVisibleBounds: Bool
A Boolean value that indicates whether headers pin to the top of the collection view bounds during scrolling.
### var sectionFootersPinToVisibleBounds: Bool
A Boolean value that indicates whether footers pin to the bottom of the collection view bounds during scrolling.


# Relationships
## Inherits From
### UICollectionViewLayout

# See Also 其它参考

## Manual Layouts - 管理布局

### Customizing Collection View Layouts
Customize a view layout by changing the size of cells in the flow or implementing a mosaic style.

### class UICollectionViewLayout
An abstract base class for generating layout information for a collection view.

### class UICollectionViewTransitionLayout
A special type of layout object that lets you implement behaviors when changing from one layout to another in your collection view.

### class UICollectionViewLayoutAttributes
A layout object that manages the layout-related attributes for a given item in a collection view.

### class UICollectionViewFlowLayoutInvalidationContext
A set of properties for determining whether to recompute the size of items or their position in the layout.

