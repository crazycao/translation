# Implementing Modern Collection Views
# 实现新式的 Collection 视图

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)

> **Availability**
>
> iOS 14.0+ | iPadOS 14.0+ | macOS 10.15.1+ | Xcode 12.3+

Bring compositional layouts to your app and simplify updating your user interface with diffable data sources.
   
将合成布局放入应用程序中，并使用 diffable 数据源简化用户界面更新。

[Download](https://docs-assets.developer.apple.com/published/db5c8c5121/ImplementingModernCollectionViews.zip)

# Overview 概览

Collection views let you present a set of data in flexible visual arrangements. This sample app shows how to create various types of layouts and manage data in collection views. The sample focuses on two key technologies:

Collection 视图允许您以灵活的视觉排列方式呈现一组数据。这个示例 app 展示了如何创建各种类型的布局和管理集合视图中的数据。本示例重点介绍两项关键技术：

- Compositional layout, a type of collection view layout that’s composable, flexible, and fast, letting you build any kind of visual arrangement for your content.
- Diffable data source, a specialized type of data source that provides the behavior you need to simply and efficiently manage updates to your collection view’s data and user interface.

- 组合布局，一种集合视图布局，可组合、灵活、快速，让您可以为你的内容构建任何形式的视觉布局。
- Diffable data source，是一种特殊类型的数据源，它提供了简单高效地管理集合视图数据和用户界面更新所需的行为。

## Configure the Sample Code Project - 配置示例代码工程

To run the sample code project in Xcode, first choose whether to view the examples in iOS or macOS.

要在 Xcode 中运行示例代码工程，首先选择是在 iOS 还是 macOS 中查看示例。

To view examples in iOS:

要在iOS中查看示例，请执行以下操作：

1. Choose the Modern Collection Views target.
2. In the Scheme menu, choose an iOS simulator to run the app.

>

1. 选择 Modern Collection Views 这个 target。
2. 在 Scheme 菜单中，选择一个 iOS 模拟器来运行程序。

To view examples in macOS:

要在 macOS 中查看示例，请执行以下操作：

1. Choose the Modern Collection Views Mac target.
2. In the Scheme menu, choose My Mac.
3. In Build Settings for the target, under Signing & Capabilities > Signing Certificate, choose Sign to Run Locally.
4. Run the app, and navigate to the examples from the Example menu.

>

1. 选择 Modern Collection Views Mac 这个 target。
2. 在 Scheme 菜单中，选择 My Mac。
3. 在这个 target 的 Build Settings 中，在 Signing & Capabilities > Signing Certificate 下面，选择 Sign to Run Locally。
4. 运行这个 app，并且从 Example 菜单导航到示例。

The code examples shown here are from the iOS target, but you can find macOS-equivalent examples in the `.swift` files for the macOS target.

这里显示的代码示例来自 iOS target，但您可以在 macOS target 的 `.swift` 文件中找到与 macOS 等效的示例。

## Create a Grid Layout - 创建网格布局
The Grid example shows how to create a grid layout by using fractional sizing to make a row of five equally sized items. It creates a horizontal group with items that are each 20% of the width of the group by using `.fractionalWidth(0.2)`. Each row of five items is repeated multiple times in a single section to create a grid.

Grid 示例演示了如何通过使用分数尺寸来创建网格布局，可以使五个大小相等的项目成为一行。它创建了一个水平组，通过使用 `.fractionalWidth(0.2)` 令其中每个项目的宽度为组宽度的20%。每个五个项目的行在一个部分中重复多次，从而创建出网格。

```
let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                     heightDimension: .fractionalHeight(1.0))
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                      heightDimension: .fractionalWidth(0.2))
let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                 subitems: [item])

let section = NSCollectionLayoutSection(group: group)

let layout = UICollectionViewCompositionalLayout(section: section)
return layout
```

## Add Spacing Around Items - 在 item 周围添加间距

The Inset Items Grid example builds on the layout from the Grid example, showing how to add spacing around items by using the [contentInsets](https://developer.apple.com/documentation/uikit/nscollectionlayoutitem/3199084-contentinsets) property. Here, this property applies even spacing around the edges of each item.

Inset Items Grid 示例基于 Grid 示例中的布局构建，展示了如何使用 [contentInsets](https://developer.apple.com/documentation/uikit/nscollectionlayoutitem/3199084-contentinsets) 属性在 item 周围添加间距。在这里，此属性在每个 item 的边缘周围应用了均匀的间距。

```
let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                     heightDimension: .fractionalHeight(1.0))
let item = NSCollectionLayoutItem(layoutSize: itemSize)
item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
```

## Create a Column Layout - 创建列布局

The Two-Column Grid example shows how to create a two-column layout by making a group with the exact number of items specified in the `count` parameter of [horizontal(layoutSize:subitem:count:)](https://developer.apple.com/documentation/uikit/nscollectionlayoutgroup/3213854-horizontal). This approach simplifies specifying exactly how many items a group contains. In this case, the `count` parameter takes precedence over `itemSize`, and item size is computed automatically to fit the specified number of items.

Two-Column Grid 示例展示了如何通过在 [horizontal(layoutSize:subitem:count:)](https://developer.apple.com/documentation/uikit/nscollectionlayoutgroup/3213854-horizontal) 方法的 `count` 参数中指定确切的 item 数量来创建两列布局。这种方法简化了精确指定一个组包含多少 item 的过程。在这种情况下，`count` 参数优先于 `itemSize` 参数，并且自动计算 item 大小以适合指定数量的项目。

```
let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                     heightDimension: .fractionalHeight(1.0))
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                      heightDimension: .absolute(44))
let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
let spacing = CGFloat(10)
group.interItemSpacing = .fixed(spacing)
```

## Display Distinct Layouts Per Section - 每个部分显示不同的布局

The Distinct Sections example shows how to display different layout arrangements in different sections of the same collection view layout. Creating a layout with different sections requires a compositional layout with a section provider. The code in the section provider accesses the section’s index (`sectionIndex`) to determine which section it’s configuring, and displays a different layout for each section.

Distinct Sections 示例展示了如何在同一 collection 视图布局的不同 section 中显示不同的布局安排。创建具有不同 section 的布局需要一个带有 section provider 的组合布局。Section provider 中的代码会访问 section 的索引（`sectionIndex`），以确定它正在配置哪个 section，并为每个 section 显示不同的布局。

```
let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
    layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

    guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
    let columns = sectionLayoutKind.columnCount

    // The group auto-calculates the actual item width to make
    // the requested number of columns fit, so this widthDimension is ignored.
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                         heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

    let groupHeight = columns == 1 ?
        NSCollectionLayoutDimension.absolute(44) :
        NSCollectionLayoutDimension.fractionalWidth(0.2)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: groupHeight)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    return section
}
return layout
```

# See Also 其它参考



