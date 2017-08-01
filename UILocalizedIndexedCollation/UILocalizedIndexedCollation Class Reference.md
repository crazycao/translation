# UILocalizedIndexedCollation Class Reference

原文地址：
[https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation?language=objc](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation?language=objc)

> SDKs
>
> iOS 3.0+ | tvOS 9.0+
>
> Framework
>
> UIKit

An object that provides ways to organize, sort, and localize the data for a table view that has a section index.

为有节索引的列表视图提供对数据进行组织、排序、本地化的方法的对象。

# Overview 概述

Table views with section indexes are ideal for displaying and facilitating the access of data composed of many items organized by a sequential ordering scheme such as the alphabet. Users tap an index title to jump to the corresponding section. The initial table view of the Phone/Contacts application on the iPhone is an example. Note that the section titles can be different than the titles of the index. The table view’s data source uses the collation object to provide the table view with input for section titles and section index titles.

要显示和方便访问由按照一定排序方案如字母表组织起来的多个项目组成的数据，用带有节索引的列表视图是非常理想的。用户点击索引标题就会跳转到相应的节。在iPhone上的电话/通讯录的初始列表视图就是一个例子。注意节标题可以与索引标题不同。列表视图的数据源使用整理对象向列表视图提供节标题和节索引标题的输入。

To prepare the data for a section index, your table-view controller creates a indexed-collation object and then, for each model object that is to be indexed, calls [sectionForObject:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620378-sectionforobject?language=objc). This method determines the section in which each of these objects should appear and returns an integer that identifies the section. The table-view controller then puts each object in a local array for its section. For each section array, the controller calls the [sortedArrayFromArray:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620382-sortedarrayfromarray?language=objc) method to sort all of the objects in the section. The indexed-collation object is now the data store that the table-view controller uses to provide section-index data to the table view, as illustrated in Listing 1.

要为节索引准备数据，你的列表视图的控制器要先创建已索引的整理对象，然后对每一个已索引的模型对象调用 [sectionForObject:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620378-sectionforobject?language=objc) 。这个方法决定了每个对象所在的节是否应该显示并返回标识这个节的整数。列表视图的控制器然后把每个对象放入这个节的本地数组中。对于每一个节数组，控制器调用 [sortedArrayFromArray:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620382-sortedarrayfromarray?language=objc) 方法将节中的所有对象排序。已索引的整理对象现在是数据存储，列表视图的控制器用它提供节的索引数据给列表视图，如表1所示。

**Listing 1** 
Data source using indexed-collation object to provide data to table view

```
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
}
 
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}
 
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}
```

# Topics 主题

## Getting the Shared Instance 获得共享实例

### [+ currentCollation](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620384-currentcollation?language=objc)

Returns a indexed-collation instance for the current table view.

返回当前列表视图的已索引的整理实例。

## Preparing the Sections and Section Indexes 准备节和节索引

### [- sectionForObject:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620378-sectionforobject?language=objc)

Returns an integer identifying the section in which a model object belongs.

返回一个整数用于标识模型对象所属的节。

### [- sortedArrayFromArray:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620382-sortedarrayfromarray?language=objc)

Sorts the objects within a section by their localized titles.

使用本地化的标题排序一个节中的对象。

## Providing Section Index Data to the Table View 向列表视图提供节索引数据

### [sectionTitles](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620379-sectiontitles?language=objc)

Returns the list of section titles for the table view.

返回列表视图的节标题的列表。

### [sectionIndexTitles](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620383-sectionindextitles?language=objc)

Returns the list of section-index titles for the table view.

返回列表视图的节索引的标题的列表。

### [- sectionForSectionIndexTitleAtIndex:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620380-sectionforsectionindextitleatind?language=objc)

Returns the section that the table view should scroll to for the given index title.

返回按照给定的索引标题列表视图应该滚动到的节。

# Relationships 关系

## Inherits From 继承自

### [NSObject](https://developer.apple.com/documentation/objectivec/nsobject?language=objc)

# See Also 其他参考

## View 视图

### [UITableView](https://developer.apple.com/documentation/uikit/uitableview?language=objc)

A view that presents data using rows arranged in a single column.

使用排列在一列中的行来展示数据的视图。

### [UITableViewController](https://developer.apple.com/documentation/uikit/uitableviewcontroller?language=objc)

A controller object that manages a table view.

管理列表视图的控制器对象。

### [UITableViewFocusUpdateContext](https://developer.apple.com/documentation/uikit/uitableviewfocusupdatecontext?language=objc)

A context object that provides information relevant to a specific focus update from one view to another.

提供与特定焦点从一个视图更新到另一个视图相关的信息的上下文对象。