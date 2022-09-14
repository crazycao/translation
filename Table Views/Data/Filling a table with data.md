# Filling a table with data 在表里填充数据

原文地址：
[https://developer.apple.com/documentation/uikit/views_and_controls/table_views/filling_a_table_with_data](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/filling_a_table_with_data)


Create and configure cells for your table dynamically using a data source object, or provide them statically from your storyboard.

使用数据源对象动态的创建和配置表的单元格，或从故事板静态的提供单元格。

## Overview 概览

Table views are data-driven elements of your interface. You provide your app’s data, along with the views needed to render each piece of that data onscreen, using a data source object (an object that adopts the `UITableViewDataSource` protocol). The table view arranges your views onscreen and works with your data source object to keep that data up to date.

表视图是界面的数据驱动元素。您使用数据源对象（采用 `UITableViewDataSource` 协议的对象）提供应用程序的数据和在屏幕上呈现每个数据所需的视图。表视图在屏幕上排列视图，并与数据源对象一起使用，以使数据保持最新。

Table views organize your data into rows and sections. Rows display individual data items, and sections group related rows together. Sections aren’t required, but they’re a good way to organize data that’s already hierarchical. For example, the Contacts app displays the name of each contact in a row, and groups rows into sections based on the first letter of the person’s last name.

表视图将数据组织为行和节。行显示单个数据项，节将相关行分组在一起。节不是必需的，但它们是组织已经分层的数据的好方法。例如，“联系人”应用程序在一行中显示每个联系人的姓名，并根据每个人姓氏的第一个字母将行分组为多个部分。

![Illustration showing the Contacts app. Sections in the main table of the Contacts app correspond to letters of the alphabet. Rows correspond to individual contacts. ](https://docs-assets.developer.apple.com/published/0e083c5df8/tableview-basics@2x.png)

## Provide the numbers of rows and sections - 提供行和节的数量

Before it appears onscreen, a table view asks you to specify the total number of rows and sections. Your data source object provides this information using two methods:

在显示在屏幕上之前，表视图要求您指定行和节的总数。数据源对象使用两种方法提供此信息：

```
func numberOfSections(in tableView: UITableView) -> Int  // Optional （可选）
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
```

In your implementations of these methods, return the row and section counts as quickly as possible. Doing so might require you to structure your data in a way that makes it easy to retrieve the row and section information. For example, consider using arrays to manage your table’s data. Arrays are good tools for organizing both sections and rows because they match the natural organization of the table view itself.

在这些方法的实现中，尽快返回行和节的数量。这样做可能需要您以便于检索行和节信息的方式来构造数据。例如，考虑使用数组来管理表的数据。数组是组织节和行的好工具，因为它们与表视图本身的自然组织相匹配。

The example code below shows an implementation of the data source methods that return the number of rows and sections in a multisection table. In this table, each row displays a string, so the implementation stores an array of strings for each section. To manage the sections, the implementation uses an array (called `hierarchicalData`) of arrays. To get the number of sections, the data source returns the number of items in the `hierarchicalData` array. To get the number of rows in a specific section, the data source returns the number of items in the respective child array.

下面的示例代码显示了数据源方法的实现，这些方法返回多节表中的行数和节数。在该表中，每行显示一个字符串，因此该实现中为每个节存储了一个字符串数组。为了管理节，该实现使用了数组的数组（代码中的 `hierarchicalData`）。要获取节数，数据源将返回 `hierarchicalData` 数组中的项数。要获取特定节中的行数，数据源返回相应子数组中的项目数。

```
var hierarchicalData = [[String]]() 
 
override func numberOfSections(in tableView: UITableView) -> Int {
   return hierarchicalData.count
}
   
override func tableView(_ tableView: UITableView, 
                        numberOfRowsInSection section: Int) -> Int {
   return hierarchicalData[section].count
}
```

## Define the appearance of rows - 定义行的外观

You define the appearance of your table’s rows in your storyboard file using cells. A cell is a `UITableViewCell` object that acts like a template for the rows of your table. Cells are views, and they can contain any subviews that you need to display your content. You can add labels, image views, and other views to their content area and arrange those views using constraints.

您可以使用单元格在 storyboard 文件中定义表格行的外观。单元格是一个 `UITableViewCell` 对象，它就像是表中的行的模板。单元格是视图，它们可以包含显示内容所需的任何子视图。可以将标签、图像视图和其他视图添加到其内容区域，并使用约束排列这些视图。

When you add a table view to your app’s interface, it includes one prototype cell for you to configure. To add more prototype cells, select the table view and update its `Prototype Cells` attribute. Each cell has a style, which defines its appearance. You may select one of the standard styles provided by UIKit, or define your own custom styles.

当您将表视图添加到应用程序界面时，它包含了一个原型单元格供您配置。要添加更多原型单元格，请选择表视图并更新其 `Prototype Cells` 属性。每个单元格都有一个样式，用于定义其外观。您可以选择 UIKit 提供的标准样式之一，或者定义自己的自定义样式。

The following illustration shows a table with two prototype cells, each of which uses one of the standard cell styles.

下图显示了一个包含两个原型单元的表格，每个原型单元使用一种标准单元样式。

![Illustration showing a table with two prototype cells in the Xcode storyboard editor.](https://docs-assets.developer.apple.com/published/b2a42cb85b/3148901@2x.png)

In your storyboard file, perform the following actions for each prototype cell:

在 storyboard 文件中，对每个原型单元执行以下操作：

- Set the cell style to `custom`, or set it to one of the standard cell styles.
- Assign a nonempty string to the cell’s Identifier attribute.
- For custom cells, add views and constraints to the cell.
- Specify the class of custom cells in the Identity inspector.

- 将单元格样式设置为 `custom`，或将其设置为标准单元格样式之一。
- 给单元格的标识符属性设置一个非空字符串。
- 对于自定义单元格，要添加视图和约束。
- 在标识检查器中指定自定义单元格的类。

When creating a cell with custom views, define a subclass of `UITableViewCell` to manage those views. In your subclass, add outlets for the custom views that display your app’s data, and connect those outlets to the actual views in your storyboard file. You’ll need these outlets to configure the cell at runtime

创建具有自定义视图的单元格时，请定义 `UITableViewCell ` 的子类来管理这些视图。在子类中，为显示 app 数据的自定义视图添加 outlet，并将这些 outlet 连接到 storyboard 文件中的实际视图。您将需要这些 outlet 在运行时配置单元格。

For more information about how to configure the appearance of your cells, see `Configuring the cells for your table`.

有关如何配置单元格外观的详细信息，请参阅《为表配置单元格》。

## Create and configure cells for each row - 为每行创建和配置单元格

Before a table view appears onscreen, it asks its data source object to provide cells for the rows in or near the visible portion of the table. Your data source object’s `tableView(_:cellForRowAt:)` method must respond quickly. Implement this method with the following pattern:

在表视图出现在屏幕上之前，它要求其数据源对象为表的可见部分中或附近的行提供单元格。数据源对象的 `tableView(_:cellForRowAt:)` 方法必须快速响应。使用以下模式实现此方法：

1. Call the table view’s `dequeueReusableCell(withIdentifier:for:)` method to retrieve a cell object.
2. Configure the cell’s views with your app’s custom data.
3. Return the cell to the table view.

>

1. 调用表视图的 `dequeueReusableCell(withIdentifier:for:)` 方法来检索单元格对象。
2. 使用 app 的自定义数据来配置单元格视图。
3. 将单元格返回到表视图。

For standard cell styles, `UITableViewCell` contains properties with the views you need to configure. For custom cells, you add views to your cell at design time and outlets to access them.

对于标准单元格样式，`UITableViewCell` 包含需要配置的视图的属性。对于自定义单元，您可以在设计时将视图添加到单元中，并通过 outlet 访问它们。

The example code below shows a version of the data source method that configures a cell containing a single text label. The cell uses the `Basic` style, one of the standard cell styles. For Basic-style cells, the `textLabel` property of `UITableViewCell` contains a label view that you configure with your data.

下面的示例代码显示了一个版本的数据源方法，该方法配置了包含单个文本标签的单元格。单元使用标准单元样式之一的 `Base` 样式。对于 `Basic` 样式的单元格，`UITableViewCell` 的 `textLabel` 属性包含用来配置数据的标签视图。

```
override func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   // Ask for a cell of the appropriate type. 
   // 获取适当类型的单元格
   let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyleCell", for: indexPath)
        
   // Configure the cell’s contents with the row and section number.
   // 用行数和节数配置单元格的内容。
   // The Basic cell style guarantees a label view is present in textLabel.
   // Base 单元格样式保证标签视图出现在 textLabel 中
   cell.textLabel!.text = "Row \(indexPath.row)"
   return cell
}
```

Table views don’t ask you to create cells for each of the table’s rows. Instead, table views manage cells lazily, asking you only for those cells that are in or near the visible portion of the table. Creating cells lazily reduces the amount of memory the table uses. However, it also means your data source object must create cells quickly. Don’t use your `tableView(_:cellForRowAt:)` method to load your table’s data or perform lengthy operations.

表视图不要求您为表的每一行创建单元格。相反，表视图会懒散地管理单元格，只要求您创建表的可见部分中或附近的单元格。懒散的创建单元格会减少表使用的内存量。但是，这也意味着数据源对象必须快速创建单元格。不要使用 `tableView(_:cellForRowAt:)` 方法加载表的数据或执行长时间的操作。

> **Note** **注意**
>
> In addition to using the standard cell styles, you can define custom cells that contain any views you want. For detailed information about configuring your cells, see `Configuring the cells for your table`.
> 
> 除了使用标准单元样式之外，还可以定义包含任何你想要的视图的自定义单元格。有关配置单元格的详细信息，请参阅《为表配置单元格》。

## Prefetch data to improve performance - 预取数据以提高性能

Scrolling performance for table views is critical. If fetching the data for your table involves an expensive operation, such as fetching it from a database, use a prefetching data source object—an object that adopts the `UITableViewDataSourcePrefetching` protocol—to begin loading that data asynchronously before it scrolls into view.

表视图的滚动性能至关重要。如果为表提取数据涉及昂贵的操作，例如从数据库中提取数据，请使用预取数据源对象（采用 `UITableViewDataSourcePrefetching` 协议的对象）在数据滚动到视图之前开始异步加载该数据。

For information about how to implement a prefetching data source, see `UITableViewDataSourcePrefetching`.

关于如何实现预取数据源的信息，请参阅 `UITableViewDataSourcePrefetching`。

## Specify data statically in the storyboard - 在故事板中静态指定数据

Use static tables to save time during prototyping or when your table’s contents never change. With static tables, you specify all of your table’s data up front in your storyboard file; you don’t implement a data source object. At runtime, UIKit loads that data from your storyboard and manages it for you. Because you can’t change the data in static tables at runtime, use them sparingly in your shipping apps.

使用静态表可以在原型设计期间或在表内容从未更改时节省时间。对于静态表，您可以在  storyboard 文件中预先指定表的所有数据；您不需要实现数据源对象。在运行时，UIKit 从故事板加载数据并对其管理。因为您无法在运行时更改静态表中的数据，所以在发布的应用程序中应谨慎使用它们。

Configure static tables in your storyboard file:

在你的 storyboard 文件中配置静态表：

1. Add a `UITableViewController` object to your storyboard.
2. Select the table view controller’s table view.
3. Change the table view’s `Content` attribute (in the Attributes inspector) to `Static Cells`.
4. Specify the number of sections for your table using the table view’s `Sections` attribute.
5. Set the `Row` attribute of each section to the number of rows you want.
6. Configure each cell with the views and content you want.

>

1. 将 `UITableViewController` 对象添加到 storyboard。
2. 选中表视图控制器的表视图。
3. 将表视图的 `Content` 属性（在 Attributes 检查器中）改为 `Static Cells`。
4. 使用表视图的 `Sections` 属性指定表的节数。
5. 将每个节的 `Row` 属性设置为所需的行数。
6. 使用所需的视图和内容配置每个单元格。

> **Important** **重要**
>
> Table views with static data require a `UITableViewController` object to manage that data.
> 
> 具有静态数据的表视图需要 `UITableViewController` 对象来管理该数据。
>
> Don’t use static data if there’s a chance you might want to update your table view’s content in the future. It’s a programmer error to assign a data source object to a `UITableViewController` whose table view contains static data.
> 
> 如果将来可能需要更新表视图的内容，请不要使用静态数据。将数据源对象分配给表视图包含静态数据的 `UITableViewController` 是一个程序员错误。

