# Table Views ---- UITableView

原文地址：
[https://developer.apple.com/documentation/uikit/uitableview?language=objc](https://developer.apple.com/documentation/uikit/uitableview?language=objc)

>SDKs
>
>iOS 2.0+ | tvOS 9.0+
>
>Framework
>
>UIKit


# UITableView

A view that presents data using rows arranged in a single column.

使用排成一列的行显示数据的视图。

# Overview 概述

A table view displays a list of items in a single column. UITableView is a subclass of [UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview?language=objc), which allows users to scroll through the table, although UITableView allows vertical scrolling only. The cells comprising the individual items of the table are [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell?language=objc) objects; UITableView uses these objects to draw the visible rows of the table. Cells have content—titles and images—and can have, near the right edge, accessory views. Standard accessory views are disclosure indicators or detail disclosure buttons; the former leads to the next level in a data hierarchy and the latter leads to a detailed view of a selected item. Accessory views can also be framework controls, such as switches and sliders, or can be custom views. Table views can enter an editing mode where users can insert, delete, and reorder rows of the table.

Table view 在一个单独的列中显示了一系列的项目。UITableView 是[UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview?language=objc)的子类，它允许用户滚动 table，尽管 UITableView 只允许垂直滚动。构成table的独立项目的 cell 是 [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell?language=objc) 对象；UITableView 使用这些对象绘制 table 的可见的行。Cell 有内容——标题和图像——并且在右边缘附近可以有附件视图。标准的附件视图是披露指示器或详情披露按钮；前者引导到下一个数据层级，后者引导到选中项目的详细的视图。附件视图也可以是框架控件，如开关和滑块，或者可以是自定义视图。Table view 可以进入编辑模式，这该模式下用户可以插入、删除和重新排序 table 中的行。

A table view is made up of zero or more sections, each with its own rows. Sections are identified by their index number within the table view, and rows are identified by their index number within a section. Any section can optionally be preceded by a section header, and optionally be followed by a section footer.

一个 table view 有零个或多个节，每一个节都有自己的行。节由它们在 table view 中的序号标识，而行由它们在节中的序号标识。任何一个节都可以可选的在前面放一个节头，并可选的在后面放一个节脚。

Table views can have one of two styles, [UITableViewStylePlain](https://developer.apple.com/documentation/uikit/uitableviewstyle/uitableviewstyleplain?language=objc) and [UITableViewStyleGrouped](https://developer.apple.com/documentation/uikit/uitableviewstyle/uitableviewstylegrouped?language=objc). When you create a UITableView instance you must specify a table style, and this style cannot be changed. In the plain style, section headers and footers float above the content if the part of a complete section is visible. A table view can have an index that appears as a bar on the right hand side of the table (for example, "A" through "Z"). You can touch a particular label to jump to the target section. The grouped style of table view provides a default background color and a default background view for all cells. The background view provides a visual grouping for all cells in a particular section. For example, one group could be a person's name and title, another group for phone numbers that the person uses, and another group for email accounts and so on. See the Settings application for examples of grouped tables. Table views in the grouped style cannot have an index.

Table view 有两种样式，[UITableViewStylePlain](https://developer.apple.com/documentation/uikit/uitableviewstyle/uitableviewstyleplain?language=objc) 和 [UITableViewStyleGrouped](https://developer.apple.com/documentation/uikit/uitableviewstyle/uitableviewstylegrouped?language=objc)。当你创建 UITableView 实例时你必须指定一个 table 样式，并且这个样式不能改变。在简介样式中，节头和脚浮在内容之上，如果完整的节的部分是可见的。一个 table view 可以有一个索引显示在列表的右边（例如，从“A”到“Z”）。你可以点击特定的标签跳转到目标节。分组样式的 table view 为所有 cell 提供默认的背景色和默认背景视图。背景视图为一个特定节中的所有 cell 提供可视化的分组。例如，一个分组可能是人名和标题，另一个分组是这个人使用的电话号码，另一个分组是邮箱账户，等等。Settings 应用就是一个分组列表的例子。在分组样式中的 table view 没有序号。

Many methods of UITableView take [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath?language=objc) objects as parameters and return values. UITableView declares a category on NSIndexPath that enables you to get the represented row index ([row](https://developer.apple.com/documentation/foundation/nsindexpath/1614853-row?language=objc)
 property) and section index ([section](https://developer.apple.com/documentation/foundation/nsindexpath/1528298-section?language=objc) property), and to construct an index path from a given row index and section index ([indexPathForRow:inSection:](https://developer.apple.com/documentation/foundation/nsindexpath/1614934-indexpathforrow?language=objc) method). Especially in table views with multiple sections, you must evaluate the section index before identifying a row by its index number.

UITableView 的许多方法都采用了 [NSIndexPath](https://developer.apple.com/documentation/foundation/nsindexpath?language=objc) 对象作为参数和返回值。UITableView 在 NSIndexPath 上声明了一个分类让你可以获得相应的行号（[row](https://developer.apple.com/documentation/foundation/nsindexpath/1614853-row?language=objc) 属性）和节号（[section](https://developer.apple.com/documentation/foundation/nsindexpath/1528298-section?language=objc) 属性），并可以通过给定的行号和节号构造一个index path（[indexPathForRow:inSection:](https://developer.apple.com/documentation/foundation/nsindexpath/1614934-indexpathforrow?language=objc) 方法）。特别是在有多个节的 table view 中，你在通过序号识别一行之前必须先评判节号。

A UITableView object must have an object that acts as a data source and an object that acts as a delegate; typically these objects are either the application delegate or, more frequently, a custom [UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller?language=objc) object. The data source must adopt the [UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource?language=objc) protocol and the delegate must adopt the 
[UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate?language=objc) protocol. The data source provides information that UITableView needs to construct tables and manages the data model when rows of a table are inserted, deleted, or reordered. The delegate manages table row configuration and selection, row reordering, highlighting, accessory views, and editing operations.

UITableView 对象必须有一个作为数据源的对象和一个作为代理的对象；通常这些对象是应用的代理或者更多情况是一个自定义的 [UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller?language=objc) 对象。数据源必须采用 [UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource?language=objc) 协议而代理必须采用 [UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate?language=objc) 协议。数据源提供 UITableView 构造列表所需的的信息并在插入、删除或重排列表中的行时管理数目模型。代理管理了列表行配置和选择，行重拍，高亮，附加视图，以及编辑操作。

When sent a [setEditing:animated:](https://developer.apple.com/documentation/uikit/uitableview/1614876-setediting?language=objc) message (with a first parameter of YES), the table view enters into editing mode where it shows the editing or reordering controls of each visible row, depending on the [editingStyle](https://developer.apple.com/documentation/uikit/uitableviewcell/1623234-editingstyle?language=objc) of each associated UITableViewCell. Clicking on the insertion or deletion control causes the data source to receive a [tableView:commitEditingStyle:forRowAtIndexPath:](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614871-tableview?language=objc) message. You commit a deletion or insertion by calling [deleteRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614960-deleterowsatindexpaths?language=objc) or [insertRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614879-insertrowsatindexpaths?language=objc), as appropriate. Also in editing mode, if a table-view cell has its [showsReorderControl](https://developer.apple.com/documentation/uikit/uitableviewcell/1623243-showsreordercontrol?language=objc) property set to YES, the data source receives a [tableView:moveRowAtIndexPath:toIndexPath:](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614867-tableview?language=objc) message. The data source can selectively remove the reordering control for cells by implementing [tableView:canMoveRowAtIndexPath:](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614927-tableview?language=objc).

当收到一个 [setEditing:animated:](https://developer.apple.com/documentation/uikit/uitableview/1614876-setediting?language=objc) 消息（第一个参数是YES），列表视图进入编辑模式，它将根据每一个可见行相关的 UITableViewCell 的 [editingStyle](https://developer.apple.com/documentation/uikit/uitableviewcell/1623234-editingstyle?language=objc) 展示其编辑或重排控件。点击插入或删除控件会导致数据源收到一条 [tableView:commitEditingStyle:forRowAtIndexPath:](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614871-tableview?language=objc) 消息。你在适当的时候通过调用 [deleteRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614960-deleterowsatindexpaths?language=objc) 或 [insertRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614879-insertrowsatindexpaths?language=objc) 提交一个删除或插入操作。在编辑模式，如果列表视图的cell将其 [showsReorderControl](https://developer.apple.com/documentation/uikit/uitableviewcell/1623243-showsreordercontrol?language=objc) 参数设置成YES，数据源也会收到 [tableView:moveRowAtIndexPath:toIndexPath:](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614867-tableview?language=objc) 消息。数据源可以通过实现 [tableView:canMoveRowAtIndexPath:](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614927-tableview?language=objc) 选择性的移除cell的重排控件。

UITableView caches table-view cells for visible rows. You can create custom [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell?language=objc) objects with content or behavioral characteristics that are different than the default cells; [A Closer Look at Table View Cells](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7) explains how.

UITableView 为可见的行缓存了表视图的cell。你可以创建自定义的带有与默认cell不同的内容或行为特征的 [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell?language=objc) 对象；[A Closer Look at Table View Cells](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7) 解释了如何做。

UITableView overrides the [layoutSubviews](https://developer.apple.com/documentation/uikit/uiview/1622482-layoutsubviews?language=objc) method of UIView so that it calls [reloadData](https://developer.apple.com/documentation/uikit/uitableview/1614862-reloaddata?language=objc) only when you create a new instance of UITableView or when you assign a new data source. Reloading the table view clears current state, including the current selection. However, if you explicitly call reloadData, it clears this state and any subsequent direct or indirect call to layoutSubviews does not trigger a reload.

UITableView 重载了 UIView 的 [layoutSubviews](https://developer.apple.com/documentation/uikit/uiview/1622482-layoutsubviews?language=objc) 方法，因此仅当你创建一个新的 UITableView 实例或当你设置一个新的数据源的时候它会调用 [reloadData](https://developer.apple.com/documentation/uikit/uitableview/1614862-reloaddata?language=objc) 。重新加载列表视图会清除包括当前选中在内的当前状态。但是，如果你显示的调用 reloadData，它会清除这个状态，而随后直接或间接的对 layoutSubviews 的调用都不会再触发重新加载。

## State Preservation 状态保存

If you assign a value to a table view’s [restorationIdentifier](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621499-restorationidentifier?language=objc) property, it attempts to preserve the currently selected rows and the first visible row. The table’s data source may adopt the [UIDataSourceModelAssociation](https://developer.apple.com/documentation/uikit/uidatasourcemodelassociation?language=objc)
 protocol, which provides a way to identify a row’s contents independent of that row’s position in the table. If the table’s data source adopts the [UIDataSourceModelAssociation](https://developer.apple.com/documentation/uikit/uidatasourcemodelassociation?language=objc)
 protocol, the data source will be consulted when saving state to convert the index paths for the top visible row and any selected cells to identifiers. During restoration, the data source will be consulted to convert those identifiers back to index paths and reestablish the top visible row, and reselect the cells. If the table’s data source does not implement the [UIDataSourceModelAssociation](https://developer.apple.com/documentation/uikit/uidatasourcemodelassociation?language=objc) protocol, the scroll position will be saved and restored directly, as will the index paths for selected cells.
 
For more information about how state preservation and restoration works, see [App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007072).

For more information about appearance and behavior configuration, see [Table Views](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/UIKitUICatalog/UITableView.html#//apple_ref/doc/uid/TP40012857-UITableView).

# Topics 主题

## Initializing a UITableView Object 初始化 UITableView 对象

### [- initWithFrame:style:](https://developer.apple.com/documentation/uikit/uitableview/1614886-initwithframe?language=objc)

Initializes and returns a table view object having the given frame and style.

初始化并返回一个给定框架和样式的列表视图对象。

### [- initWithCoder:](https://developer.apple.com/documentation/uikit/uitableview/1614859-initwithcoder?language=objc)

## Providing the Table View Data 提供列表视图数据

### [dataSource](https://developer.apple.com/documentation/uikit/uitableview/1614955-datasource?language=objc)

The object that acts as the data source of the table view.

作为列表视图的数据源的对象。

### [UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource?language=objc)

The UITableViewDataSource protocol is adopted by an object that mediates the application’s data model for a [UITableView](https://developer.apple.com/documentation/uikit/uitableview?language=objc) object. The data source provides the table-view object with the information it needs to construct and modify a table view.

UITableViewDataSource 协议由为 [UITableView](https://developer.apple.com/documentation/uikit/uitableview?language=objc) 协调应用程序的数据模型的对象遵守。数据源向列表视图对象提供构建所需的信息并修改列表视图。

### [UITableViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uitableviewdatasourceprefetching?language=objc)

A protocol that provides advance warning of the data requirements for a table view, allowing the triggers of asynchronous data load operations.

为列表视图提供数据需求的事前警告的协议，允许异步数据加载操作的触发器。

## Customizing the Table View Behavior 自定义列表视图行为

### [delegate](https://developer.apple.com/documentation/uikit/uitableview/1614894-delegate?language=objc)

The object that acts as the delegate of the table view.

作为列表视图的代理的对象。

### [UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate?language=objc)

The delegate of a [UITableView](https://developer.apple.com/documentation/uikit/uitableview?language=objc) object must adopt the UITableViewDelegate protocol. Optional methods of the protocol allow the delegate to manage selections, configure section headings and footers, help to delete and reorder cells, and perform other actions.

[UITableView](https://developer.apple.com/documentation/uikit/uitableview?language=objc) 对象的协议必须遵守 UITableViewDelegate 协议。协议的可选方法允许代理管理选中，配置节头部和脚部，帮助删除和重排 cell，以及执行其他操作。

## Configuring a Table View 配置列表视图

### [style](https://developer.apple.com/documentation/uikit/uitableview/1614913-style?language=objc)

Returns the style of the table view.

返回列表视图的样式。

### [- numberOfRowsInSection:](https://developer.apple.com/documentation/uikit/uitableview/1614952-numberofrowsinsection?language=objc)

Returns the number of rows (table cells) in a specified section.

返回指定节中（列表cell）的行数。

### [numberOfSections](https://developer.apple.com/documentation/uikit/uitableview/1614924-numberofsections?language=objc)

The number of sections in the table view.

列表视图中的节数。

### [rowHeight](https://developer.apple.com/documentation/uikit/uitableview/1614852-rowheight?language=objc)

The height of each row (that is, table cell) in the table view.

在列表视图中每一个（列表cell）行的高度。

### [separatorStyle](https://developer.apple.com/documentation/uikit/uitableview/1614909-separatorstyle?language=objc)

The style for table cells used as separators.

给列表cell用作分隔线的样式；

### [separatorColor](https://developer.apple.com/documentation/uikit/uitableview/1614984-separatorcolor?language=objc)

The color of separator rows in the table view.

列表视图中分隔线行的颜色。

### [separatorEffect](https://developer.apple.com/documentation/uikit/uitableview/1614865-separatoreffect?language=objc)

The effect applied to table separators.

应用于列表分隔线的效果。

### [backgroundView](https://developer.apple.com/documentation/uikit/uitableview/1614986-backgroundview?language=objc)

The background view of the table view.

列表视图的背景视图。

### [separatorInset](https://developer.apple.com/documentation/uikit/uitableview/1614851-separatorinset?language=objc)

Specifies the default inset of cell separators.

指定cell分隔线的默认缩进。

### [separatorInsetReference](https://developer.apple.com/documentation/uikit/uitableview/2887517-separatorinsetreference?language=objc)（Beta iOS 11.0+）

An indicator of how the separator inset value should be interpreted.

分隔线缩进值应该如何解释的指示器。

### [UITableViewSeparatorInsetReference](https://developer.apple.com/documentation/uikit/uitableviewseparatorinsetreference?language=objc)（Beta iOS 11.0+）

Constants indicating how to interpret the separator inset value of a table view.

指示如何解释列表视图的分隔线缩进值的常量。

### [cellLayoutMarginsFollowReadableWidth](https://developer.apple.com/documentation/uikit/uitableview/1614849-celllayoutmarginsfollowreadablew?language=objc)

A Boolean value that indicates whether the cell margins are derived from the width of the readable content guide.

指示cell边距是否来自于可读内容指导的宽度的布尔值。

## Creating Table View Cells 创建列表视图的cell

### [- registerNib:forCellReuseIdentifier:](https://developer.apple.com/documentation/uikit/uitableview/1614937-registernib?language=objc)

Registers a nib object containing a cell with the table view under a specified identifier.

注册一个 nib 对象，包含在指定标识下列表视图的cell。

### [- registerClass:forCellReuseIdentifier:](https://developer.apple.com/documentation/uikit/uitableview/1614888-registerclass?language=objc)

Registers a class for use in creating new table cells.

为了创建新的列表cell注册一个类。

### [- dequeueReusableCellWithIdentifier:forIndexPath:](https://developer.apple.com/documentation/uikit/uitableview/1614878-dequeuereusablecellwithidentifie?language=objc)

Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.

根据指定的重用标识返回一个可重用的列表视图cell对象，并将其添加到列表。

### [- dequeueReusableCellWithIdentifier:](https://developer.apple.com/documentation/uikit/uitableview/1614891-dequeuereusablecellwithidentifie?language=objc)

Returns a reusable table-view cell object located by its identifier.

根据它的标识定位返回一个可重用的列表视图cell对象。

## Accessing Header and Footer Views 访问头部视图和脚部视图

### [- registerNib:forHeaderFooterViewReuseIdentifier:](https://developer.apple.com/documentation/uikit/uitableview/1614921-registernib?language=objc)

Registers a nib object containing a header or footer with the table view under a specified identifier.

注册一个 nib 对象，包含在指定标识下列表视图的头部或脚部。

### [- registerClass:forHeaderFooterViewReuseIdentifier:](https://developer.apple.com/documentation/uikit/uitableview/1614964-registerclass?language=objc)

Registers a class for use in creating new table header or footer views.

注册一个类用于创建新的列表头部或脚部视图。

### [- dequeueReusableHeaderFooterViewWithIdentifier:](https://developer.apple.com/documentation/uikit/uitableview/1614975-dequeuereusableheaderfootervieww?language=objc)

Returns a reusable header or footer view located by its identifier.

返回一个由其标识定位的可重用的头部或脚部视图。

### [tableHeaderView](https://developer.apple.com/documentation/uikit/uitableview/1614904-tableheaderview?language=objc)

Returns an accessory view that is displayed above the table.

返回一个显示在列表之前的附加视图。

### [tableFooterView](https://developer.apple.com/documentation/uikit/uitableview/1614976-tablefooterview?language=objc)

Returns an accessory view that is displayed below the table.

返回一个显示在列表之后的附加视图。

### [sectionHeaderHeight](https://developer.apple.com/documentation/uikit/uitableview/1614863-sectionheaderheight?language=objc)

The height of section headers in the table view.

列表视图中节头部的高度。

### [sectionFooterHeight](https://developer.apple.com/documentation/uikit/uitableview/1614846-sectionfooterheight?language=objc)

The height of section footers in the table view.

列表视图中节脚部的高度。

### [- headerViewForSection:](https://developer.apple.com/documentation/uikit/uitableview/1614965-headerviewforsection?language=objc)

Returns the header view associated with the specified section.

返回关联到指定节的头部视图。

### [- footerViewForSection:](https://developer.apple.com/documentation/uikit/uitableview/1614972-footerviewforsection?language=objc)

Returns the footer view associated with the specified section.

返回关联到指定节的脚部视图。

## Accessing Cells and Sections 访问Cell和节

### [- cellForRowAtIndexPath:](https://developer.apple.com/documentation/uikit/uitableview/1614983-cellforrowatindexpath?language=objc)

Returns the table cell at the specified index path.

返回指定索引路径上的列表cell。

### [- indexPathForCell:](https://developer.apple.com/documentation/uikit/uitableview/1614881-indexpathforcell?language=objc)

Returns an index path representing the row and section of a given table-view cell.

返回表示给定列表视图cell的行和节的索引路径。

### [- indexPathForRowAtPoint:](https://developer.apple.com/documentation/uikit/uitableview/1614874-indexpathforrowatpoint?language=objc)

Returns an index path identifying the row and section at the given point.

返回在给定点标识行和节的索引路径。

### [- indexPathsForRowsInRect:](https://developer.apple.com/documentation/uikit/uitableview/1614991-indexpathsforrowsinrect?language=objc)

An array of index paths each representing a row enclosed by a given rectangle.

一组索引路径，每个索引路径都表示一个由给定矩形围住的行。

### [visibleCells](https://developer.apple.com/documentation/uikit/uitableview/1614896-visiblecells?language=objc)

The table cells that are visible in the table view.

在列表视图中可见的列表cell。

### [indexPathsForVisibleRows](https://developer.apple.com/documentation/uikit/uitableview/1614885-indexpathsforvisiblerows?language=objc)

An array of index paths each identifying a visible row in the table view.

一组索引路径，每一个路径标识列表视图中的一个可见行。

## Estimating Element Heights 估算元素高度

### [estimatedRowHeight](https://developer.apple.com/documentation/uikit/uitableview/1614925-estimatedrowheight?language=objc)

The estimated height of rows in the table view.

列表中的行的估算高度。

### [estimatedSectionHeaderHeight](https://developer.apple.com/documentation/uikit/uitableview/1614957-estimatedsectionheaderheight?language=objc)

The estimated height of section headers in the table view.

列表中的节头部的估算高度。

### [estimatedSectionFooterHeight](https://developer.apple.com/documentation/uikit/uitableview/1614979-estimatedsectionfooterheight?language=objc)

The estimated height of section footers in the table view.

列表中的节脚部的估算高度。

## Scrolling the Table View 滚动列表视图

### [- scrollToRowAtIndexPath:atScrollPosition:animated:](https://developer.apple.com/documentation/uikit/uitableview/1614997-scrolltorowatindexpath?language=objc)

Scrolls through the table view until a row identified by index path is at a particular location on the screen.

滚动列表视图，直到由索引路径标识的行停在屏幕中的特殊位置。

### [- scrollToNearestSelectedRowAtScrollPosition:animated:](https://developer.apple.com/documentation/uikit/uitableview/1614910-scrolltonearestselectedrowatscro?language=objc)

Scrolls the table view so that the selected row nearest to a specified position in the table view is at that position.

滚动列表视图，以致行列表视图中最接近于特定位置的选中行停在这个位置上。

## Managing Selections 管理选中

### [indexPathForSelectedRow](https://developer.apple.com/documentation/uikit/uitableview/1615000-indexpathforselectedrow?language=objc)

An index path identifying the row and section of the selected row.

标识选中行的行号和节号的索引路径。

### [indexPathsForSelectedRows](https://developer.apple.com/documentation/uikit/uitableview/1614864-indexpathsforselectedrows?language=objc)

The index paths representing the selected rows.

表示多个选中行的索引路径数组。

### [- selectRowAtIndexPath:animated:scrollPosition:](https://developer.apple.com/documentation/uikit/uitableview/1614875-selectrowatindexpath?language=objc)

Selects a row in the table view identified by index path, optionally scrolling the row to a location in the table view.

选中列表视图中由索引路径标识的一行，可选的将该行滚动到列表视图中的某个位置。

### [- deselectRowAtIndexPath:animated:](https://developer.apple.com/documentation/uikit/uitableview/1614989-deselectrowatindexpath?language=objc)

Deselects a given row identified by index path, with an option to animate the deselection.

取消选中由索引路径标识的给定行，带有一个动画取消选中的选项。

### [allowsSelection](https://developer.apple.com/documentation/uikit/uitableview/1614911-allowsselection?language=objc)

A Boolean value that determines whether users can select a row.

决定用户是否可以选中一行的布尔值。

### [allowsMultipleSelection](https://developer.apple.com/documentation/uikit/uitableview/1614938-allowsmultipleselection?language=objc)

A Boolean value that determines whether users can select more than one row outside of editing mode.

决定用户是否可以在编辑模式之外选中超过一行的布尔值。

### [allowsSelectionDuringEditing](https://developer.apple.com/documentation/uikit/uitableview/1614889-allowsselectionduringediting?language=objc)

A Boolean value that determines whether users can select cells while the table view is in editing mode.

决定当列表视图在编辑模式时用户是否可以选择cell的布尔值。

### [allowsMultipleSelectionDuringEditing](https://developer.apple.com/documentation/uikit/uitableview/1614944-allowsmultipleselectionduringedi?language=objc)

A Boolean value that controls whether users can select more than one cell simultaneously in editing mode.

控制在编辑模式下用户是否可以选择超过一行的布尔值。

## Inserting, Deleting, and Moving Rows and Sections 插入、删除和移动行和节

### [- insertRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614879-insertrowsatindexpaths?language=objc)

Inserts rows in the table view at the locations identified by an array of index paths, with an option to animate the insertion.

将多个行插入到列表视图中由一组索引路径标识的位置，带有一个动画插入的选项。

### [- deleteRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614960-deleterowsatindexpaths?language=objc)

Deletes the rows specified by an array of index paths, with an option to animate the deletion.

删除由一组索引路径指定的行，带有一个动画删除的选项。

### [- moveRowAtIndexPath:toIndexPath:](https://developer.apple.com/documentation/uikit/uitableview/1614987-moverowatindexpath?language=objc)

Moves the row at a specified location to a destination location.

移动指定位置的行到目标位置。

### [- insertSections:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614892-insertsections?language=objc)

Inserts one or more sections in the table view, with an option to animate the insertion.

在列表视图中插入一个或多个节，带有一个动画插入的选项。

### [- deleteSections:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614922-deletesections?language=objc)

Deletes one or more sections in the table view, with an option to animate the deletion.

在列表视图中插入一个或多个节，带有一个动画删除的选项。

### [- moveSection:toSection:](https://developer.apple.com/documentation/uikit/uitableview/1614940-movesection?language=objc)

Moves a section to a new location in the table view.

移动一节到列表视图中新的位置。

### [- performBatchUpdates:completion:](https://developer.apple.com/documentation/uikit/uitableview/2887515-performbatchupdates?language=objc)(Beta iOS 11.0+)

Animates multiple insert, delete, reload, and move operations as a group.

动画执行作为一组的多个插入、删除、重新加载和移动操作。

### [- beginUpdates](https://developer.apple.com/documentation/uikit/uitableview/1614908-beginupdates?language=objc)

Begins a series of method calls that insert, delete, or select rows and sections of the table view.

开始一串方法调用，插入、删除或选中列表视图中的行和节。

### [- endUpdates](https://developer.apple.com/documentation/uikit/uitableview/1614890-endupdates?language=objc)

Concludes a series of method calls that insert, delete, select, or reload rows and sections of the table view.

结束一串插入、删除、选中或重新加列表视图中的行和节的方法调用。

## Managing Drag Interactions 管理拖动交互

### [dragDelegate](https://developer.apple.com/documentation/uikit/uitableview/2897362-dragdelegate?language=objc)(Beta iOS 11.0+)

The delegate object that manages the dragging of items from the table view.

管理从列表视图拖动项目的代理对象。

### [UITableViewDragDelegate](https://developer.apple.com/documentation/uikit/uitableviewdragdelegate?language=objc)(Beta iOS 11.0+)

The interface for initiating drags from a table view.

从列表视图开始拖动的接口。

### [hasActiveDrag](https://developer.apple.com/documentation/uikit/uitableview/2897381-hasactivedrag?language=objc)(Beta iOS 11.0+)

A Boolean value indicating whether rows were lifted from the table view and have not yet been dropped.

指示是否有一些行已经从列表视图中拿起而尚未被放下的布尔值。

### [dragInteractionEnabled](https://developer.apple.com/documentation/uikit/uitableview/2909064-draginteractionenabled?language=objc)(Beta iOS 11.0+)

A Boolean value indicating whether the table view supports drags and drops between apps.

指示列表视图是否支持在app之间拖动和丢下的布尔值。

## Managing Drop Interactions 管理放下交互

### [dropDelegate](https://developer.apple.com/documentation/uikit/uitableview/2897372-dropdelegate?language=objc)(Beta iOS 11.0+)

The delegate object that manages the dropping of content into the table view.

管理放下内容到列表视图中的代理对象。

### [UITableViewDropDelegate](https://developer.apple.com/documentation/uikit/uitableviewdropdelegate?language=objc)(Beta iOS 11.0+)

The interface for handling drops in a table view.

在列表视图中处理放下的接口。

### [hasActiveDrop](https://developer.apple.com/documentation/uikit/uitableview/2897323-hasactivedrop?language=objc)(Beta iOS 11.0+)

## Managing the Editing of Table Cells 管理列表cell的编辑

### [editing](https://developer.apple.com/documentation/uikit/uitableview/1615001-editing?language=objc)

A Boolean value that determines whether the table view is in editing mode.

决定列表视图是否在编辑模式中的布尔值。

### [- setEditing:animated:](https://developer.apple.com/documentation/uikit/uitableview/1614876-setediting?language=objc)

Toggles the table view into and out of editing mode.

让列表视图进入和退出编辑模式。

## Reloading the Table View 重新加载列表视图

### [hasUncommittedUpdates](https://developer.apple.com/documentation/uikit/uitableview/2891097-hasuncommittedupdates?language=objc)(Beta iOS 11.0+)

A Boolean value indicating whether the table view contains drop placeholders or is reordering its rows as part of handling a drop.

指示列表视图是否包含放下预置内容或作为处理放下的一部分正在重排序其行的布尔值。

### [- reloadData](https://developer.apple.com/documentation/uikit/uitableview/1614862-reloaddata?language=objc)

Reloads the rows and sections of the table view.

重新加载列表视图的行和节。

### [- reloadRowsAtIndexPaths:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614935-reloadrowsatindexpaths?language=objc)

Reloads the specified rows using an animation effect.

使用动画效果重新加载指定的行。

### [- reloadSections:withRowAnimation:](https://developer.apple.com/documentation/uikit/uitableview/1614954-reloadsections?language=objc)

Reloads the specified sections using a given animation effect.

使用给定的动画效果重新加载指定的节。

### [- reloadSectionIndexTitles](https://developer.apple.com/documentation/uikit/uitableview/1614954-reloadsections?language=objc)

Reloads the items in the index bar along the right side of the table view.

重新加载在列表视图的右边的索引栏中的项目。

## Accessing Drawing Areas of the Table View 访问列表视图的绘制区域

### [- rectForSection:](https://developer.apple.com/documentation/uikit/uitableview/1614951-rectforsection?language=objc)

Returns the drawing area for a specified section of the table view.

返回列表视图的指定节的绘制区域。

### [- rectForRowAtIndexPath:](https://developer.apple.com/documentation/uikit/uitableview/1614974-rectforrowatindexpath?language=objc)

Returns the drawing area for a row identified by index path.

返回由索引路径标识的行的绘制区域。

### [- rectForFooterInSection:](https://developer.apple.com/documentation/uikit/uitableview/1614999-rectforfooterinsection?language=objc)

Returns the drawing area for the footer of the specified section.

返回特定节的脚部的绘制区域。

### [- rectForHeaderInSection:](https://developer.apple.com/documentation/uikit/uitableview/1614872-rectforheaderinsection?language=objc)

Returns the drawing area for the header of the specified section.

返回特定节头部的绘制区域。

## Prefetching Data 获取数据

If your table view relies on an expensive data loading process, you can improve your user experience by prefetching data before it is needed for display. Assign an object that conforms to the [UITableViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uitableviewdatasourceprefetching?language=objc) protocol to the [prefetchDataSource](https://developer.apple.com/documentation/uikit/uitableview/1771763-prefetchdatasource?language=objc) property to receive notifications of when to prefetch data for cells.

如果你的列表视图依赖于一个高耗费的数据加载过程，你可以在需要显示之前通过预取数据提升用户体验。将一个遵从 [UITableViewDataSourcePrefetching](https://developer.apple.com/documentation/uikit/uitableviewdatasourceprefetching?language=objc) 协议的对象赋值给 [prefetchDataSource](https://developer.apple.com/documentation/uikit/uitableview/1771763-prefetchdatasource?language=objc) 属性以接收何时为cell预取数据的通知。

### [prefetchDataSource](https://developer.apple.com/documentation/uikit/uitableview/1771763-prefetchdatasource?language=objc)

The object that acts as the prefetching data source for the table view, receiving notifications of upcoming cell data requirements.

为列表视图作为预取数据源的对象，接收即将到来的cell数据需求的通知。

## Configuring the Table Index 配置列表索引

### [sectionIndexMinimumDisplayRowCount](https://developer.apple.com/documentation/uikit/uitableview/1614903-sectionindexminimumdisplayrowcou?language=objc)

The number of table rows at which to display the index list on the right edge of the table.

在列表右边显示索引名单的列表行数。

### [sectionIndexColor](https://developer.apple.com/documentation/uikit/uitableview/1614915-sectionindexcolor?language=objc)

The color to use for the table view’s index text.

用于列表视图的索引文本的颜色。

### [sectionIndexBackgroundColor](https://developer.apple.com/documentation/uikit/uitableview/1614918-sectionindexbackgroundcolor?language=objc)

The color to use for the background of the table view’s section index while not being touched.

用于当没有触碰时列表视图的节索引的背景的颜色。

### [sectionIndexTrackingBackgroundColor](https://developer.apple.com/documentation/uikit/uitableview/1614992-sectionindextrackingbackgroundco?language=objc)

The color to use for the table view’s index background area.

用于列表视图的索引背景区域的颜色。

## Managing Focus 管理焦点

### [remembersLastFocusedIndexPath](https://developer.apple.com/documentation/uikit/uitableview/1614858-rememberslastfocusedindexpath?language=objc)

A Boolean value that indicates whether the table view should automatically return the focus to the cell at the last focused index path.

指示列表视图是否应该自动的返回焦点到在最后聚焦的索引路径的cell的布尔值。

## Constants 常量

### [UITableViewStyle](https://developer.apple.com/documentation/uikit/uitableviewstyle?language=objc)

The style of the table view.

列表视图的样式。

### [UITableViewScrollPosition](https://developer.apple.com/documentation/uikit/uitableviewscrollposition?language=objc)

The position in the table view (top, middle, bottom) to which a given row is scrolled.

列表视图中的滚动到的给定行的位置（顶部、中间、底部）。

### [UITableViewRowAnimation](https://developer.apple.com/documentation/uikit/uitableviewrowanimation?language=objc)

The type of animation when rows are inserted or deleted.

当行被插入或删除时的动画的类型。

### [Section Index Icons](https://developer.apple.com/documentation/uikit/uitableview/section_index_icons?language=objc)

Requests icon to be shown in the section index of a table view.

请求icon显示在列表视图的节索引中。

### [Default Dimension](https://developer.apple.com/documentation/uikit/uitableview/default_dimension?language=objc)

The default value for a given dimension.

给定维度的默认值。

## Notifications 通知

### [UITableViewSelectionDidChangeNotification](https://developer.apple.com/documentation/uikit/uitableviewselectiondidchangenotification?language=objc)

Posted when the selected row in the posting table view changes.

当列表视图中选中的行变化时会发送。

# Relationships 关系

## Inherits From 继承自

[UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview?language=objc)

## Conforms To 遵从

[NSCoding](https://developer.apple.com/documentation/foundation/nscoding?language=objc), [UIDataSourceTranslating](https://developer.apple.com/documentation/uikit/uidatasourcetranslating?language=objc)

# See Also 其他参考

## View 视图

### [UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller?language=objc)

A controller object that manages a table view.

管理列表视图的控制器对象。

### [UITableViewFocusUpdateContext](https://developer.apple.com/documentation/uikit/uitableviewfocusupdatecontext?language=objc)

A context object that provides information relevant to a specific focus update from one view to another.

提供与特定焦点从一个视图更新到另一个相关的信息的上下文对象。

### [UILocalizedIndexedCollation](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation?language=objc)

An object that provides ways to organize, sort, and localize the data for a table view that has a section index.

为有节索引的列表视图提供组织、排序和本地化数据的方法的对象。
