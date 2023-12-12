# Customizing Collection View Layouts
# 自定义集合视图布局

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts/customizing_collection_view_layouts?language=objc](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/layouts/customizing_collection_view_layouts?language=objc)

> **Availability**
>
> iOS 12.0+ | iPadOS 12.0+ | Xcode 13+

Customize a view layout by changing the size of cells in the flow or implementing a mosaic style.
   
通过更改流中单元格的大小或实现马赛克样式来自定义视图布局。

[Download](https://docs-assets.developer.apple.com/published/0a6eabcfe9/CustomizingCollectionViewLayouts.zip)

## Overview 概览

To lay out `UICollectionView` cells in a simple grid, you can use [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout?language=objc) directly. For more flexibility, you can subclass [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout?language=objc) to create advanced layouts.

要在简单网格中布局 `UICollectionView` 单元格，可以直接使用 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout?language=objc)。为了获得更大的灵活性，可以将 [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout?language=objc) 子类化以创建高级布局。

This sample app demonstrates two custom layout subclasses:

此示例应用程序演示了两个自定义布局子类：

- `ColumnFlowLayout` — A `UICollectionViewFlowLayout` subclass that arranges cells in a list format for narrow screens, or as a grid for wider screens. See “For a Simple Grid, Size Cells Dynamically,” below.

- `ColumnFlowLayout` —— 一个 `UICollectionViewFlowLayout` 子类，它以列表格式排列窄屏幕的单元格，或以网格形式排列宽屏幕的单元格。请参阅下面的《对于简单网格，动态调整单元格大小》。

- `MosaicLayout` — A `UICollectionViewLayout` subclass that lays out cells in a mosaic-style, nonconforming grid. See “For a Complex Grid, Define Cell Sizes Explicitly,” below.

- `MosaicLayout` —— 一个 `UICollectionViewLayout` 子类，它以马赛克样式的大小不一的网格布局单元格。请参阅下面的《对于复杂网格，明确定义单元格大小》。

The app opens to the Friends view controller, which uses a column flow layout to display a list of people. Tapping any cell takes you to the Feed view controller, which uses a mosaic layout to display photos from the user’s photo library.

该应用程序将打开 Friends 视图控制器，该控制器使用按列流布局显示人员列表。点击任意单元格将转到 Feed 视图控制器，该控制器使用马赛克布局显示用户照片库中的照片。

Tapping the cloud icon to the right of the navigation bar demonstrates batched animations for inserting, deleting, moving, and reloading items in the collection view. For more information, see “Perform Batch Updates,” below. Using pull-to-refresh on the collection view resets the data.

点击导航栏右侧的云图标，演示在集合视图中插入、删除、移动和重新加载项目的批处理动画。有关详细信息，请参阅下面的《执行批更新》。使用下拉刷新集合视图将重置数据。

## For a Simple Grid, Size Cells Dynamically 对于简单网格，动态调整单元格大小

`ColumnFlowLayout` is a subclass of [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout?language=objc) that uses the size of the collection view to determine the width of its cells. If only one cell fits comfortably horizontally, the layout arranges the cells to occupy the entire width of the collection view. Otherwise, the layout displays multiple columns of cells with a fixed width.

`ColumnFlowLayout` 是 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout?language=objc) 的子类，它使用集合视图的大小来确定其单元格的宽度。如果只有一个单元格可以舒适地水平放置，则布局将排列单元格以占据集合视图的整个宽度。否则，布局将显示具有固定宽度的多列单元格。

In practice, on iPhone devices in portrait mode, `ColumnFlowLayout` displays a single vertical column of cells. In landscape mode, or on an iPad, it displays a grid layout.

实际上，在处于纵向模式的 iPhone 设备上，`ColumnFlowLayout` 显示单个垂直的单元格列。在横向模式或 iPad 上，它显示网格布局。

Use the [prepareLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617752-preparelayout?language=objc) function to compute the available screen width of the device and set the [itemSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617711-itemsize?language=objc) property accordingly.

使用 [prepareLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617752-preparelayout?language=objc) 函数计算设备的可用屏幕宽度，并相应地设置 [itemSize](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout/1617711-itemsize?language=objc) 属性。

```
override func prepare() {
    super.prepare()

    guard let collectionView = collectionView else { return }
    
    let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
    let maxNumColumns = Int(availableWidth / minColumnWidth)
    let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
    
    self.itemSize = CGSize(width: cellWidth, height: cellHeight)
    self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
    self.sectionInsetReference = .fromSafeArea
}
```

## For a Complex Grid, Define Cell Sizes Explicitly - 对于复杂网格，明确定义单元格大小

If you need more customization than is possible with a subclass of [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout?language=objc), subclass [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout?language=objc) instead.

如果您需要比 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout?language=objc) 的子类更多的定制，请改用 [UICollectionViewLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout?language=objc) 子类。

`MosaicLayout` is a `UICollectionViewLayout` subclass that displays an arbitrary number of cells with differing sizes and aspect ratios. The `FeedViewController` class uses a mosaic layout to display images from the user’s photo library. Cells are organized into rows in one of four styles, from a single cell to multiple cells in varying layouts.

`MosaicLayout` 是一个 `UICollectionViewLayout` 子类，它显示任意数量的具有不同大小和纵横比的单元格。`FeedViewController` 类使用马赛克布局来显示用户照片库中的图像。单元格按四种样式之一组织成行，从单个单元格到不同布局的多个单元格。

Images showing a row of four rectangles, each representing a mosaic style. On the left, a single cell. Second from left, two equal-size cells. Third from left, one cell occupying two-thirds of the area, and two stacked cells to the left of the larger cell. Last, one cell occupying two-thirds of the area, and two stacked cells to the right of the larger cell.

显示一行四个矩形的图像，每个矩形代表马赛克样式。最左边是一个单独的单元格。从左起第二个，有两个大小相等的单元格。从左起第三个，有一个单元格占据三分之二的面积，另两个堆叠单元格位于较大单元格的左侧。最后，一个单元格占据三分之二的面积，另两个堆叠单元格位于较大单元格的右侧。

![https://docs-assets.developer.apple.com/published/b2a7d54673/rendered2x-1635530608.png](https://docs-assets.developer.apple.com/published/b2a7d54673/rendered2x-1635530608.png)

### Calculate Cell Dimensions 计算单元格尺寸

The [prepareLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617752-preparelayout?language=objc) method is called whenever a layout is invalidated. Override this method to calculate the position and size of every cell, as well as the total dimensions for the entire layout.

每当布局无效时，就会调用 [prepareLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617752-preparelayout?language=objc) 方法。重写此方法以计算每个单元格的位置和大小，以及整个布局的总尺寸。

```
override func prepare() {
    super.prepare()
    
    guard let collectionView = collectionView else { return }

    // Reset cached information.
    // 重置缓存的信息。
    cachedAttributes.removeAll()
    contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
    
    // For every item in the collection view:
    //  - Prepare the attributes.
    //  - Store attributes in the cachedAttributes array.
    //  - Combine contentBounds with attributes.frame.
    // 为集合视图中的每个项目：
    // - 准备属性。
    // - 把属性存到 cachedAttributes 数组中。
    // - 把 contentBounds 与 attributes.frame 结合起来。
    let count = collectionView.numberOfItems(inSection: 0)
    
    var currentIndex = 0
    var segment: MosaicSegmentStyle = .fullWidth
    var lastFrame: CGRect = .zero
    
    let cvWidth = collectionView.bounds.size.width
    
    while currentIndex < count {
        let segmentFrame = CGRect(x: 0, y: lastFrame.maxY + 1.0, width: cvWidth, height: 200.0)
        
        var segmentRects = [CGRect]()
        switch segment {
        case .fullWidth:
            segmentRects = [segmentFrame]
            
        case .fiftyFifty:
            let horizontalSlices = segmentFrame.dividedIntegral(fraction: 0.5, from: .minXEdge)
            segmentRects = [horizontalSlices.first, horizontalSlices.second]
            
        case .twoThirdsOneThird:
            let horizontalSlices = segmentFrame.dividedIntegral(fraction: (2.0 / 3.0), from: .minXEdge)
            let verticalSlices = horizontalSlices.second.dividedIntegral(fraction: 0.5, from: .minYEdge)
            segmentRects = [horizontalSlices.first, verticalSlices.first, verticalSlices.second]
            
        case .oneThirdTwoThirds:
            let horizontalSlices = segmentFrame.dividedIntegral(fraction: (1.0 / 3.0), from: .minXEdge)
            let verticalSlices = horizontalSlices.first.dividedIntegral(fraction: 0.5, from: .minYEdge)
            segmentRects = [verticalSlices.first, verticalSlices.second, horizontalSlices.second]
        }
        
        // Create and cache layout attributes for calculated frames.
        // 为计算好的 frame 创建和缓存布局属性。
        for rect in segmentRects {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
            attributes.frame = rect
            
            cachedAttributes.append(attributes)
            contentBounds = contentBounds.union(lastFrame)
            
            currentIndex += 1
            lastFrame = rect
        }

        // Determine the next segment style.
        // 确定下一个 segment 样式
        switch count - currentIndex {
        case 1:
            segment = .fullWidth
        case 2:
            segment = .fiftyFifty
        default:
            switch segment {
            case .fullWidth:
                segment = .fiftyFifty
            case .fiftyFifty:
                segment = .twoThirdsOneThird
            case .twoThirdsOneThird:
                segment = .oneThirdTwoThirds
            case .oneThirdTwoThirds:
                segment = .fiftyFifty
            }
        }
    }
}
```

### Provide the Content Size 提供内容尺寸

Override the [collectionViewContentSize](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617796-collectionviewcontentsize?language=objc) property, providing a size for the collection view.

重写 [collectionViewContentSize](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617796-collectionviewcontentsize?language=objc) 属性，为集合视图提供一个尺寸。

```
override var collectionViewContentSize: CGSize {
    return contentBounds.size
}
```

### Define the Layout Attributes 定义布局属性

Override [layoutAttributesForElementsInRect:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617769-layoutattributesforelementsinrec?language=objc), defining the layout attributes for a geometric region. The collection view calls this function periodically to display items, which is known as _querying by geometric region_.

重写 [layoutAttributesForElementsInRect:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617769-layoutattributesforelementsinrec?language=objc)，定义几何区域的布局属性。集合视图定期调用此函数以显示项目，这称为 _按几何区域查询_。

```
override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributesArray = [UICollectionViewLayoutAttributes]()
    
    // Find any cell that sits within the query rect.
    // 找到在查询矩形内的任意单元格
    guard let lastIndex = cachedAttributes.indices.last,
          let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }
    
    // Starting from the match, loop up and down through the array until all the attributes
    // have been added within the query rect.
    // 从匹配项开始，在数组中上下循环，直到所有属性都添加到查询矩形中。
    for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
        guard attributes.frame.maxY >= rect.minY else { break }
        attributesArray.append(attributes)
    }
    
    for attributes in cachedAttributes[firstMatchIndex...] {
        guard attributes.frame.minY <= rect.maxY else { break }
        attributesArray.append(attributes)
    }
    
    return attributesArray
}
```

Also provide the layout attributes for a specific item by implementing [layoutAttributesForItemAtIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617797-layoutattributesforitematindexpa?language=objc). The collection view calls this function periodically to display one particular item, which is known as _querying by index path_.

还可以通过实现 [layoutAttributesForItemAtIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617797-layoutattributesforitematindexpa?language=objc) 为特定项目提供布局属性。集合视图周期性地调用此函数以显示一个特定项目，即 _按索引路径查询_。

```
override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.item]
}
```

Because these functions are called often, they can affect the performance of your app. To make them as efficient as possible, follow the example code as closely as you can.

因为这些函数经常被调用，它们会影响应用程序的性能。为了使它们尽可能高效，请尽可能地遵循示例代码。

### Handle Bounds Changes 处理边界更改

The [shouldInvalidateLayoutForBoundsChange:](https://developer.apple.com/documentation/appkit/nscollectionviewlayout/1531047-shouldinvalidatelayoutforboundsc?language=objc) function is called for every bounds change from the collection view, or whenever its size or origin changes. This function is also called frequently during scrolling. The default implementation returns false, or, if the size and origin change, it returns true.

[shouldInvalidateLayoutForBoundsChange:](https://developer.apple.com/documentation/appkit/nscollectionviewlayout/1531047-shouldinvalidatelayoutforboundsc?language=objc) 函数在集合视图中的每次边界更改时调用，或在其大小或原点更改时调用。滚动期间也经常调用此函数。默认实现返回false，如果大小和原点发生变化，则返回true。

```
override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionView = collectionView else { return false }
    return !newBounds.size.equalTo(collectionView.bounds.size)
}
```

For optimum performance, this sample performs a binary search inside [layoutAttributesForElementsInRect:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617769-layoutattributesforelementsinrec?language=objc) instead of a linear search of the attributes it needs for each element in a given bounds area.

为了获得最佳性能，此示例在 [layoutAttributesForElementsInRect:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617769-layoutattributesforelementsinrec?language=objc) 中对给定边界区域中每个元素所需的属性执行二进制搜索，而不是进行线性搜索。

## Perform Batch Updates 执行批量更新

Tapping the top-right button in the navigation bar triggers the collection view to perform a batch update of multiple animated operations (insert, delete, move, and reload) of its collection view cells all at the same time.

点击导航栏右上角的按钮会触发集合视图对其集合视图单元格同时执行多个动画操作（插入、删除、移动和重新加载）的批量更新。

Within a call to [performBatchUpdates:completion:](https://developer.apple.com/documentation/uikit/uicollectionview/1618045-performbatchupdates?language=objc), the system simultaneously animates all insert, delete, move, and reload operations. In this sample, the app batches updates by processing an array of `PersonUpdate` objects, each of which encapsulates one update:

在对 [performBatchUpdates:completion:](https://developer.apple.com/documentation/uikit/uicollectionview/1618045-performbatchupdates?language=objc) 的调用中，系统会同时设置所有插入、删除、移动和重新加载操作的动画。在此示例中，应用程序通过处理 `PersonUpdate` 对象数组来批量更新，每个对象封装一个更新：

- insert with a `Person` object and insertion index.
- delete with an index.
- move from one index to another.
- reload with an index.

- 插入 `Person` 对象和插入索引。
- 使用索引删除。
- 从一个索引移动到另一个索引。
- 使用索引重新加载。

First, the reload operations are performed without animation because no cell movement is involved:

首先，重新加载操作是在没有动画的情况下执行的，因为不涉及单元移动：

```
// Perform any cell reloads without animation because there is no movement.
// 由于没有移动，执行单元格重新加载时不显示动画。
UIView.performWithoutAnimation {
    collectionView.performBatchUpdates({
        for update in remoteUpdates {
            if case let .reload(index) = update {
                people[index].isUpdated = true
                collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }
    })
}
```

Next, the remaining operations are animated:

接下来，对其余操作设置动画：

```
// Animate all other update types together.
// 对所有其他更新类型一起制作动画。
collectionView.performBatchUpdates({
    var deletes = [Int]()
    var inserts = [(person:Person, index:Int)]()

    for update in remoteUpdates {
        switch update {
        case let .delete(index):
            collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
            deletes.append(index)
            
        case let .insert(person, index):
            collectionView.insertItems(at: [IndexPath(item: index, section: 0)])
            inserts.append((person, index))
            
        case let .move(fromIndex, toIndex):
            // Updates that move a person are split into an addition and a deletion.
            // 移动 person 的更新分为一个添加和一个删除。
            collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                    to: IndexPath(item: toIndex, section: 0))
            deletes.append(fromIndex)
            inserts.append((people[fromIndex], toIndex))
            
        default: break
        }
    }
    
    // Apply deletions in descending order.
    // 按降序应用删除。
    for deletedIndex in deletes.sorted().reversed() {
        people.remove(at: deletedIndex)
    }
    
    // Apply insertions in ascending order.
    // 按升序应用插入。
    let sortedInserts = inserts.sorted(by: { (personA, personB) -> Bool in
        return personA.index <= personB.index
    })
    for insertion in sortedInserts {
        people.insert(insertion.person, at: insertion.index)
    }
    
    // The update button is enabled only if the list still has people in it.
    // 只有当列表中仍有 person 时，才会启用更新按钮。
    navigationItem.rightBarButtonItem?.isEnabled = !people.isEmpty
})
```







