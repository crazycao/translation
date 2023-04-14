# About iOS Collection Views - 关于 iOS 中的 Collection View

原文地址：
[https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334-CH1-SW1](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40012334-CH1-SW1)

> **目录**
>
-  1. At a Glance
-  1. 扫一眼
	-  1.1. A Collection View Manages the Visual Presentation of Data-Driven Views
	-  1.1. Collection View 管理了数据驱动视图的可视化展现
	-  1.2. The Flow Layout Supports Grids and Other Line-Oriented Presentations
	-  1.2. 支持网格和其他面向行的展示的流式布局
	-  1.3. Gesture Recognizers Can Be Used for Cell and Layout Manipulations
	-  1.3. 手势识别器可以用于 Cell 和 Layout 的操作
	-  1.4. Custom Layouts Let You Go Beyond Grids
	-  1.4. 自定义布局让你超越网格
- 2. Prerequisites
- 2. 预备知识
- 3. See Also
- 3. 其它参考

A collection view is a way to present an ordered set of data items using a flexible and changeable layout. The most common use for collection views is to present items in a grid-like arrangement, but collection views in iOS are capable of more than just rows and columns. With collection views, the precise layout of visual elements is definable through subclassing and can be changed dynamically, so you can implement grids, stacks, circular layouts, dynamically changing layouts, or any type of arrangement you can imagine.

Collection view 是使用灵活可变的布局展示一组已排序的数据项目的方法。Collection view 最常见的用途是将项目展示在一个类似网格的排布中，但是 iOS 中的 collection view 可以做的不仅仅这些行和列。通过 collection view，可以通过子类化定义可见元素的精确布局，并且可以动态的改变，所以你可以实现网格、堆叠、环形布局、动态可变布局，或者你可以想象的任何类型的排布。

Collection views keep a strict separation between the data being presented and the visual elements used to present that data. In most cases, your app is solely responsible for managing the data. Your app also provides the view objects used to present that data. After that, the collection view takes your views and does all the work of positioning them onscreen. It does this work in conjunction with a layout object, which specifies the placement and visual attributes for your views and that can be subclassed to fit your app’s exact needs. Thus, you provide the data, the layout object provides the placement information, and the collection view merges the two pieces together to achieve the final appearance.

Collection view 将 正在展示的数据 和 用于展示这些数据的可见元素 严格的分开。在大多数情况下，你的app要完全负责对数据的管理。你的app也要提供用于展示这些数据的视图对象。在这之后，collection view 拿着你的视图，并完成将它们放到屏幕位置上的所有工作。它与一个布局对象联合完成这个工作，这个对象具体说明了放置的位置和你的视图的可见属性，并且你可以子类化这个对象以满足你的app的额外需求。这样，你提供数据，布局对象提供放置信息，而 collection view 则将这两部分合并以达到最终的显示效果。

## 0.1 At a Glance - 扫一眼

The standard iOS collection view classes provide all of the behavior you need to implement simple grids. You can also extend the standard classes to support custom layouts and specific interactions with those layouts.

标准的iOS collection view 类提供了你要用来实现简单网格的所有行为。你也可以扩展标准类以支持自定义布局和与那些布局的特殊交互。

### 0.1.1 A Collection View Manages the Visual Presentation of Data-Driven Views - Collection View 管理了数据驱动视图的可视化展现

A collection view facilitates the presentation of data-driven views provided by your app. The collection view’s only concern is taking your views and laying them out in a specific way. The collection view is all about the presentation and arrangement of your views and not about their content. Understanding the interactions between the collection view, its data source, the layout object, and your custom objects is crucial for using collection views in your app, particularly in smart and efficient ways.

Collection view 使得由你的app提供的数据驱动视图的展现变得非常便利。Collection view 唯一关心的事情是拿着你的视图并以特定的方式布局它们。Collection view 与你的视图的展现和排布完全相关，而与它们的内容无关。要在你的app中使用 collection view，特别是要聪明高效的使用，那最重要的是理解 collection view 与其数据源，与布局对象，以及你的自定义对象之间的交互。

> **Relevant chapters:** [Collection View Basics](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CollectionViewBasics/CollectionViewBasics.html#//apple_ref/doc/uid/TP40012334-CH2-SW1), [Designing Your Data Source and Delegate](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCellsandViews/CreatingCellsandViews.html#//apple_ref/doc/uid/TP40012334-CH7-SW1)
> 
> **相关章节：**[Collection View 基础](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CollectionViewBasics/CollectionViewBasics.html#//apple_ref/doc/uid/TP40012334-CH2-SW1), [设计你的数据源和代理](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCellsandViews/CreatingCellsandViews.html#//apple_ref/doc/uid/TP40012334-CH7-SW1)

### 0.1.2 The Flow Layout Supports Grids and Other Line-Oriented Presentations - 支持网格和其他面向行的展示的流式布局

A flow layout object is a concrete layout object provided by UIKit. You typically use the flow layout object to implement grids—that is, rows and columns of items—but the flow layout supports any type of linear flow. Because it is not just for grids, you can use the flow layout to create interesting and flexible arrangements of your content both with and without subclassing. The flow layout supports items of different sizes, variable spacing of items, custom headers and footers, and custom margins without subclassing. And subclassing allows you to tweak the behavior of the flow layout class even further.

Flow Layout 对象是由 UIKit 提供的混合布局对象。你一般会使用 flow layout 对象实现网格——也就是行和列的项目——不过 flow layout 支持所有类型的线性流。因为它并不是仅为网格设计的，你可以使用 flow layout，子类化或不子类化，创建你的内容的有趣的灵活的排布。Flow Layout 无需子类化就可以支持不同尺寸的项目，项目之间的间隙可变，自定义头部和脚部，以及自定义留白。而子类化允许你更进一步的稍微调整 flow layout 类的行为。

> **Relevant chapter:** [Using the Flow Layout](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html#//apple_ref/doc/uid/TP40012334-CH3-SW1)
> 
> **相关章节：**[使用流式布局](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html#//apple_ref/doc/uid/TP40012334-CH3-SW1)

### 0.1.3 Gesture Recognizers Can Be Used for Cell and Layout Manipulations - 手势识别器可以用于 Cell 和 Layout 的操作

Like all views, you can attach gesture recognizers to a collection view to manipulate the content of that view. Because a collection view involves the collaboration of multiple views, it helps to understand some basic techniques for incorporating gesture recognizers into your collection views. You can use gesture recognizers to tweak layout attributes or to manipulate items in a collection view.

像所有视图一样，你可以将 gesture recognizer 添加到 collection view 以操作视图的内容。因为 collection view 需要多个视图的合作，所以它有助于理解将 gesture recognizer 合并到你的 collection view 上的一些基本技术。你可以使用 gesture recognizer 稍微调整布局属性或者操作 collection view 中的项目。

> **Relevant chapter:** [Incorporating Gesture Support](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/IncorporatingGestureSupport/IncorporatingGestureSupport.html#//apple_ref/doc/uid/TP40012334-CH4-SW1)
> 
> **相关章节：**[加入手势支持](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/IncorporatingGestureSupport/IncorporatingGestureSupport.html#//apple_ref/doc/uid/TP40012334-CH4-SW1)

### 0.1.4 Custom Layouts Let You Go Beyond Grids - 自定义布局让你超越网格

You can subclass the basic layout object to implement custom layouts for your app. Even though designing a custom layout does not typically require a large amount of code, the more you understand how layouts work, the better you can design your layout objects to be efficient. The guide’s final chapter focuses on an example project with a full implementation of a custom layout.

你可以子类化基本布局对象为你的app实现自定义布局。尽管设计一个自定义布局通常不需要大量的代码，你对布局如何工作了解得越多，你就能将你的布局对象设计得约高效。本指南的最后一章聚焦在了一个含有自定义布局的完全实现的示例工程上。

> **Relevant chapters:** [Creating Custom Layouts](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html#//apple_ref/doc/uid/TP40012334-CH5-SW1), [Custom Layouts: A Worked Example](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/AWorkedExample/AWorkedExample.html#//apple_ref/doc/uid/TP40012334-CH8-SW6)
> 
> **相关章节：**[创建自定义布局](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html#//apple_ref/doc/uid/TP40012334-CH5-SW1), [自定义布局：一个可有用的示例](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/AWorkedExample/AWorkedExample.html#//apple_ref/doc/uid/TP40012334-CH8-SW6)

## 0.2 Prerequisites - 预备知识

Before reading this document, you should have a solid understanding of the role views play in iOS apps. If you are new to iOS programming and not familiar with the iOS view architecture, read [View Programming Guide for iOS](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503) before reading this book.

在阅读这篇文档之前，你应该对 iOS app 中视图所扮演的角色有充分的理解。如果你是 iOS 编程的新手，并且不熟悉 iOS 视图架构，在阅读本文之前请先阅读 [iOS视图编程指南](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009503)。

## 0.3 See Also - 其它参考

Collection views are somewhat related to table views, in that both present ordered data to the user. The implementation of a table view is similar to that of a standard collection view (one which uses the provided flow layout) in its use of index paths, cells, and view recycling. However, the visual presentation of table views is geared around a single-column layout, whereas collection views can support many different layouts. For more information about table views, see [Table View Programming Guide for iOS](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html#//apple_ref/doc/uid/TP40007451).

Collection View 与 table view 有点联系，它们都是把已排序的数据显示给用户。Table view 的实现与标准 collection view （使用给定的flow layout）非常相似，它们都使用了 index path，cell 和视图重用。然而，table view 的可见展示都是围绕着单列布局进行的，而 collection view 可以支持许多不同的布局。关于 table view 的工多信息，参见[iOS Table View 编程指南](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/AboutTableViewsiPhone/AboutTableViewsiPhone.html#//apple_ref/doc/uid/TP40007451)。