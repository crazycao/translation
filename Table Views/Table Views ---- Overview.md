# Table Views 表视图

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/table_views?language=objc](https://developer.apple.com/documentation/uikit/views_and_controls/table_views?language=objc)

>__Framework__
>
>UIKit
>

# Table Views 表视图

Display data in a single column of customizable rows.

在仅有一列的可自定义的行中显示数据。

# Topics 主题

## View 视图

### [UITableView](https://developer.apple.com/documentation/uikit/uitableview?language=objc)

A view that presents data using rows arranged in a single column.

使用排成一列的行显示数据的视图。

### [UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller?language=objc)

A controller object that manages a table view.

管理一个table view的控制器对象。

### [UITableViewFocusUpdateContext](https://developer.apple.com/documentation/uikit/uitableviewfocusupdatecontext?language=objc)

A context object that provides information relevant to a specific focus update from one view to another.

提供与从一个视图到另一个视图的特定焦点更新相关的信息的上下文对象。

### [UILocalizedIndexedCollation](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation?language=objc)

An object that provides ways to organize, sort, and localize the data for a table view that has a section index.

为一个有节序号的table view提供组织数据、排序数据和本地化数据的对象。

## Rows 行

### [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell?language=objc)

A cell in a table view.

Table view中的一个cell。

### [UISwipeActionsConfiguration](https://developer.apple.com/documentation/uikit/uiswipeactionsconfiguration?language=objc)（Beta iOS 11+）

The set of actions to perform when swiping on rows of a table.

当在table的行上滑动时执行的操作的集合。

### [UIContextualAction](https://developer.apple.com/documentation/uikit/uicontextualaction?language=objc)（Beta iOS 11+）

An action to display when the user swipes a table row.

当用户滑动一个table行时显示的操作。

### [UITableViewRowAction](https://developer.apple.com/documentation/uikit/uitableviewrowaction?language=objc)

A single action to present when the user swipes horizontally in a table row.

当用户在一个table行上水平滑动时展示的单一操作。

### [UIContextualActionStyle](https://developer.apple.com/documentation/uikit/uicontextualactionstyle?language=objc)（Beta iOS 11+）

Constants indicating the style information that is applied to the action button.

指示应用于操作按钮的样式信息的常量。

## Headers and Footers 头部和脚部

### [UITableViewHeaderFooterView](https://developer.apple.com/documentation/uikit/uitableviewheaderfooterview?language=objc)

A reusable view that can be placed at the top or bottom of a table section to display additional information for that section.

一个可重用的视图，可以放在table节的顶部或底部以显示该节的附加信息。

## Adornments

### [UIRefreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol?language=objc)

A standard control that can initiate the refreshing of a table view’s contents.

开始刷新table view的内容的标准控件。

## Drag and Drop 拖动和放下

### [Supporting Drag and Drop in Table Views](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/supporting_drag_and_drop_in_table_views?language=objc)（Beta iOS 11+）

Initiate drags and handle drops from a table view.

从table view中开始拖动和处理放下。

### [UITableViewDragDelegate](https://developer.apple.com/documentation/uikit/uitableviewdragdelegate?language=objc)（Beta iOS 11+）

The interface for initiating drags from a table view.

开始从table view中拖动的接口。

### [UITableViewDropDelegate](https://developer.apple.com/documentation/uikit/uitableviewdropdelegate?language=objc)（Beta iOS 11+）

The interface for handling drops in a table view.

在table view中处理放下的接口。

### [UITableViewDropCoordinator](https://developer.apple.com/documentation/uikit/uitableviewdropcoordinator?language=objc)（Beta iOS 11+）

An interface for coordinating your custom drop-related actions with the table view.

用于协调table view与你自定义的放下相关操作的接口。

### [UITableViewDropProposal](https://developer.apple.com/documentation/uikit/uitableviewdropproposal?language=objc)（Beta iOS 11+）

Your proposed solution for handling a drop in a table view.

你提出的处理table view中的放下的解决方案。

### [UITableViewDropItem](https://developer.apple.com/documentation/uikit/uitableviewdropitem?language=objc)（Beta iOS 11+）

The data associated with an item being dropped into the table view.

与被放到table view中的项目相关联的数据。

### [UITableViewDropPlaceholderContext](https://developer.apple.com/documentation/uikit/uitableviewdropplaceholdercontext?language=objc)（Beta iOS 11+）

An object that you insert temporarily into the table view while waiting to receive the actual data that you plan to display.

你暂时插入到table view中等待接收你计划显示的真实数据的对象。

### [UIDataSourceTranslating](https://developer.apple.com/documentation/uikit/uidatasourcetranslating?language=objc)（Beta iOS 11+）

An advanced interface for managing a data source object.

管理数据源对象的高级接口。

# See Also 其他参考

## Container Views 容器视图

### [Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views?language=objc)

Display nested views using a configurable and highly customizable layout.

使用可配置的高度可自定义的布局显示嵌套的视图。

### [UIStackView](https://developer.apple.com/documentation/uikit/uistackview?language=objc)

A streamlined interface for laying out a collection of views in either a column or a row.

在一行或一列中布局一组视图的线型的接口。

### [UIScrollView](https://developer.apple.com/documentation/uikit/uiscrollview?language=objc)

A view that allows the scrolling and zooming of its contained views.

允许滚动和缩放它包含的视图的视图。