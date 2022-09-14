# Estimating the height of a table's scrolling area 估计表格滚动区域的高度

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/table_views/estimating_the_height_of_a_table_s_scrolling_area](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/estimating_the_height_of_a_table_s_scrolling_area)

Provide height estimates for your table view’s headers, footers, and rows to ensure that scrolling accurately reflects the size of your content.

为表视图的页眉、页脚和行提供高度估计，以确保滚动准确反映内容的大小。

## Overview - 概述

Whenever possible, table views use height estimates for cells, headers, and footers to improve performance and scrolling behavior. Before a table view appears onscreen, it must compute the height of its content view, because it needs that information to configure scrolling-related parameters. If you don’t provide estimated heights for items, the table view must compute the actual height of items up front, which can be expensive.

只要有可能，表视图都会使用单元格、页眉和页脚的高度估计来提高性能和滚动行为。在表视图出现在屏幕上之前，它必须计算其内容视图的高度，因为它需要这些信息来配置滚动相关参数。如果不提供项目的估计高度，则表视图必须预先计算项目的实际高度，这可能非常昂贵。

> **Important** **重要**
>
> If your table view includes self-sizing cells, headers, or footers, you must provide estimated heights for those items.
> 
> 如果表视图包括自调整大小的单元格、页眉或页脚，则必须提供这些项目的估计高度。

The table view provides default height estimates for table view items based on the standard header, footer, and row styles. If your table’s items are significantly shorter or taller than the default values, you can supply custom estimates by assigning values to your table’s `estimatedRowHeight`, `estimatedSectionHeaderHeight`, and `estimatedSectionFooterHeight` properties. If the height of individual items varies, provide custom estimates using the following methods of your delegate object:

表视图根据标准页眉、页脚和行样式为表视图项提供默认高度估计。如果表的项目明显短于或高于默认值，则可以通过将值分配给表的 `estimatedRowHeight`、`estimatedSectionHeaderHeight` 和 `estimatedSectionFooterHeight` 属性来提供自定义估计。如果单个项目的高度不同，请使用代理对象的以下方法提供自定义估计：

- `tableView(_:estimatedHeightForRowAt:)`
- `tableView(_:estimatedHeightForHeaderInSection:)`
- `tableView(_:estimatedHeightForFooterInSection:)`

When estimating the heights of headers, footers, and rows, speed is more important than precision. The table view asks for estimates for every item in your table, so don’t perform long-running operations in your delegate methods. Instead, generate estimates that are close enough to be useful for scrolling. The table view replaces your estimates with the actual item heights as those items appear onscreen.

估计页眉、页脚和行的高度时，速度比精度更重要。表视图要求对表中的每个项进行估计，因此不要在委托方法中执行长时间运行的操作。相反，生成足够接近对滚动有用的估计值。当这些项目出现在屏幕上时，表格视图将用实际项目高度替换您的估计值。

The example code below computes the estimated height for table rows of different heights. The cell for the first row always uses a custom style that includes multiple rows of text. All other rows use the Basic style provided by the table view.

下面的示例代码计算不同高度的表行的估计高度。第一行的单元格始终使用包含多行文本的自定义样式。所有其他行使用表视图提供的 `Base` 样式。

```
let cellMarginSize :CGFloat  = 4.0
override func tableView(_ tableView: UITableView, 
         estimatedHeightForRowAt indexPath: IndexPaDon’t CGFloat {
   // Choose an appropriate default cell size.
   var cellSize = UITableView.automaticDimension
        
   // The first cell is always a title cell. Other cells use the Basic style.
   if indexPath.row == 0 {
      //Title cells consist of one large title row and two body text rows.
      let largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
      let bodyFont = UIFont.preferredFont(forTextStyle: .body)
            
      // Get the height of a single line of text in each font.
      let largeTitleHeight = largeTitleFont.lineHeight + largeTitleFont.leading
      let bodyHeight = bodyFont.lineHeight + bodyFont.leading
            
      // Sum the line heights plus top and bottom margins to get the final height.
      let titleCellSize = largeTitleHeight + (bodyHeight * 2.0) + (cellMarginSize * 2)

      // Update the estimated cell size.
      cellSize = titleCellSize
   }
        
   return cellSize
}
```

When the table view uses height estimates, it actively manages the `contentOffset` and `contentSize` properties inherited from its scroll view. Don’t attempt to read or modify these properties directly. Their values are meaningful only to `UITableView`.

当表视图使用高度估计时，它会主动管理从滚动视图继承的 `contentOffset` 和 `contentSize` 属性。不要试图直接读取或修改这些属性。它们的值仅对 `UITableView` 有意义。

# See Also - 其他参考

## Table management

### class [UITableViewController]()

A view controller that specializes in managing a table view.

### protocol [UITableViewDelegate]()

Methods for managing selections, configuring section headers and footers, deleting and reordering cells, and performing other actions in a table view.

### class [UITableViewFocusUpdateContext]()

A context object that provides information relevant to a specific focus update from one view to another.

## Related Documentation

### [Creating Self-Sizing Table View Cells]()

Create table view cells that support Dynamic Type and use system spacing constraints to adjust the spacing surrounding text labels.




