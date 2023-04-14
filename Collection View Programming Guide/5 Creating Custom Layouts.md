# 5 Creating Custom Layouts - 创建自定义布局

原文地址：
[https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html#//apple_ref/doc/uid/TP40012334-CH5-SW1](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CreatingCustomLayouts/CreatingCustomLayouts.html#//apple_ref/doc/uid/TP40012334-CH5-SW1)

> **目录**
> 
> - 5.1 Subclassing UICollectionViewLayout
> - 5.1 子类化 UICollectionViewLayout
> 	- 5.1.1 Understanding the Core Layout Process
> 	- 5.1.1 了解核心布局过程
> 	- 5.1.2 Creating Layout Attributes
> 	- 5.1.2 创建布局属性
> 	- 5.1.3 Preparing the Layout
> 	- 5.1.3 准备布局
> 	- 5.1.4 Providing Layout Attributes for Items in a Given Rectangle
> 	- 5.1.4 为给定矩形中的项目提供布局属性
> 	- 5.1.5 Providing Layout Attributes On Demand
> 	- 5.1.5 按需提供布局属性
> 	- 5.1.6 Connecting Your Custom Layout for Use
> 	- 5.1.6 连接自定义布局以供使用
> - 5.2 Making Your Custom Layouts More Engaging
> - 5.2 让你的自定义布局更具吸引力
> 	- 5.2.1 Elevating Content Through Supplementary Views
>	- 5.2.1 通过补充视图提升内容
> 	- 5.2.2 Including Decoration Views in Your Custom Layouts
> 	- 5.2.2 在自定义布局中包含装饰视图
> 	- 5.2.3 Making Insertion and Deletion Animations More Interesting
> 	- 5.2.3 让插入和删除动画更有趣
> 	- 5.2.4 Improving the Scrolling Experience of Your Layout
>	- 5.2.4 改善布局的滚动体验
> - 5.3 Tips for Implementing Your Custom Layouts
> - 5.3 实现自定义布局的提示

Before you start building custom layouts, consider whether doing so is really necessary. The [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) class provides a significant amount of behavior that has already been optimized for efficiency and that can be adapted in several ways to achieve many different types of standard layouts. The only times to consider implementing a custom layout are in the following situations:

在开始构建自定义布局之前，请考虑是否确实需要这样做。[UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) 类提供了大量的行为，这些行为已经针对效率进行了优化，并可以通过多种方式对这些行为进行调整，以实现许多不同类型的标准布局。只有在以下情况下才能考虑实现自定义布局：

- The layout you want looks nothing like a grid or a line-based breaking layout (a layout in which items are placed into a row until it’s full, then continue on to the next line until all items are placed) or necessitates scrolling in more than one direction.
- 您所需的布局看起来与网格或基于行的分隔布局（一种布局，在该布局中，项目被放置到一行中，直到其已满，然后继续到下一行，直到所有项目都被放置）完全不同，或者需要在多个方向上滚动。
- You want to change all of the cell positions frequently enough that it would be more work to modify the existing flow layout than to create a custom layout.
- 您希望足够频繁地更改所有单元格位置，修改现有的流布局相比创建自定义布局需要做更多的工作。

The good news is that, from an API perspective, implementing a custom layout is not difficult. The hardest part is performing the calculations needed to determine the positions of items in the layout. When you know the locations of those items, providing that information to the collection view is straightforward.

好消息是，从API的角度来看，实现自定义布局并不困难。最困难的部分是执行确定布局中项目位置所需的计算。当您知道这些项目的位置时，向集合视图提供这些信息很简单。

## 5.1 Subclassing UICollectionViewLayout - 子类化 UICollectionViewLayout

For custom layouts, you want to subclass [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout), which provides you with a fresh starting point for your design. Only a handful of methods provide the core behavior for your layout object and are required in your implementation. The rest of the methods are there for you to override as needed to tweak the layout behavior. The core methods handle the following crucial tasks:

对于自定义布局，您需要子类化 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)，这为您的设计提供了一个新的起点。只有少数方法为布局对象提供核心行为，并且在实现中是必需的。其余的方法可以根据需要覆盖，以调整布局行为。核心方法处理以下关键任务：

- Specify the size of the scrollable content area.
- 指定可滚动内容区域的大小。
- Provide attribute objects for the cells and views that make up your layout so that the collection view can position each cell and view.
- 为构成布局的单元格和视图提供属性对象，以便集合视图可以定位每个单元格和视图。

Although you can create a functional layout object that implements just the core methods, your layout is likely to be more engaging if you implement several of the optional methods as well.

虽然您可以创建一个只实现核心方法的功能的布局对象，但如果您还实现了几个可选方法，那么您的布局可能会更吸引人。

The layout object uses information provided by its data source to create the collection view’s layout. Your layout communicates with the data source by calling methods on the [collectionView](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617751-collectionview) property, which is accessible in all of the layout’s methods. Keep in mind what your collection view knows and doesn’t know during the layout process. Because the layout process is under way, the collection view cannot track the layout or positioning of views. So even though the layout object will not restrict you from calling any of the collection view’s methods, refrain from relying on the collection view for anything other than the data necessary to compute your layout.

布局对象使用其数据源提供的信息来创建集合视图的布局。您的布局通过调用 [collectionView](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617751-collectionview) 属性上的方法与数据源通信，该属性可在布局的所有方法中访问。在布局过程中，请注意集合视图知道什么和不知道什么。因为布局过程正在进行，所以集合视图无法跟踪视图的布局或位置。因此，即使布局对象不会限制您调用集合视图的任何方法，也不要依赖集合视图获取计算布局所需的数据以外的任何其他数据。

### 5.1.1 Understanding the Core Layout Process - 了解核心布局过程

The collection view works directly with your custom layout object to manage the overall layout process. When the collection view determines that it needs layout information, it asks your layout object to provide it. For example, the collection view asks for layout information when it is first displayed or is resized. You can also tell the collection view to update its layout explicitly by calling the [invalidateLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617728-invalidatelayout) method of the layout object. That method throws away the existing layout information and forces the layout object to generate new layout information.

集合视图直接与自定义布局对象一起工作，以管理整个布局过程。当集合视图确定需要布局信息时，它会要求您的布局对象提供布局信息。例如，集合视图在首次显示或调整大小时会要求提供布局信息。您还可以通过调用布局对象的 [invalidateLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617728-invalidatelayout) 方法明确地通知集合视图更新其布局。该方法丢弃现有布局信息，并强制布局对象生成新的布局信息。

> **Note:** Be careful not to confuse the layout object’s [invalidateLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617728-invalidatelayout) method with the collection view’s [reloadData](https://developer.apple.com/documentation/uikit/uicollectionview/1618078-reloaddata) method. Calling the [invalidateLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617728-invalidatelayout) method does not necessarily cause the collection view to throw out its existing cells and subviews. Rather, it forces the layout object to recompute all of its layout attributes as is necessary when moving and adding or deleting items. If data within the data source has changed, the [reloadData](https://developer.apple.com/documentation/uikit/uicollectionview/1618078-reloaddata) method is appropriate. Regardless of how you initiate a layout update, the actual layout process is the same.
> 
> **注意：**注意不要将布局对象的 [invalidateLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617728-invalidatelayout) 方法与集合视图的 [reloadData](https://developer.apple.com/documentation/uikit/uicollectionview/1618078-reloaddata) 方法混淆。调用 [invalidateLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617728-invalidatelayout) 方法不一定会导致集合视图抛出其现有单元格和子视图。相反，它强制布局对象在移动和增删项目时重新计算其所有布局属性。如果数据源中的数据已更改，则 [reloadData](https://developer.apple.com/documentation/uikit/uicollectionview/1618078-reloaddata) 方法是合适的。无论您如何启动布局更新，实际的布局过程都是相同的。

During the layout process, the collection view calls specific methods of your layout object. These methods are your chance to calculate the position of items and to provide the collection view with the primary information it needs. Other methods may be called, too, but these methods are always called during the layout process in the following order:

在布局过程中，集合视图调用布局对象的特定方法。这些方法使您有机会计算项目的位置，并为集合视图提供所需的主要信息。也可能会调用其他方法，但在布局过程中始终按以下顺序调用这些方法：

- Use the [prepareLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617752-preparelayout) method to perform the up-front calculations needed to provide layout information.
- Use the [collectionViewContentSize](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617796-collectionviewcontentsize) method to return the overall size of the entire content area based on your initial calculations.
- Use the [layoutAttributesForElementsInRect:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617769-layoutattributesforelementsinrec) method to return the attributes for cells and views that are in the specified rectangle.

- 使用 [prepareLayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617752-preparelayout) 方法执行提供布局信息所需的前期计算。
- 使用 [collectionViewContentSize](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617796-collectionviewcontentsize) 方法根据初始计算返回整个内容区域的总大小。
- 使用 [layoutAttributesForElementsInRect:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617769-layoutattributesforelementsinrec) 方法返回指定矩形中单元格和视图的属性。

Figure 5-1 illustrates how you can use the preceding methods to generate your layout information.

图5-1说明了如何使用前面的方法生成布局信息。

Figure 5-1  Laying out your custom content 图 5-1 布局你的自定义内容

![https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_process_2x.png](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/cv_layout_process_2x.png)

The `prepareLayout` method is your opportunity to perform whatever calculations are needed to determine the position of the cells and views in the layout. At a minimum, you should compute enough information in this method to be able to return the overall size of the content area, which you return to the collection view in step 2.

`prepareLayout` 方法为您提供了执行确定布局中单元格和视图位置所需的任何计算的机会。至少，您应该在该方法中计算足够的信息，以便能够返回内容区域的总大小，并在步骤2中返回到集合视图。

The collection view uses the content size to configure its scroll view appropriately. For instance, if your computed content size expands past the bounds of the current device’s screen both vertically and horizontally, the scroll view adjusts to allow scrolling in both directions simultaneously. Unlike the `UICollectionViewFlowLayout`, it does not by default adjust the layout of content to scroll in only one direction.

集合视图使用内容大小来适当配置其滚动视图。例如，如果计算出的内容大小在垂直和水平方向上扩展超过当前设备屏幕的边界，则滚动视图将进行调整，以允许同时在两个方向上滚动。与 `UICollectionViewFlowLayout` 不同，默认情况下，它不会调整内容的布局以仅在一个方向上滚动。

Based on the current scroll position, the collection view then calls your `layoutAttributesForElementsInRect:` method to ask for the attributes of the cells and views in a specific rectangle, which may or may not be the same as the visible rectangle. After returning that information, the core layout process is effectively complete.

然后，集合视图根据当前滚动位置调用 `layoutAttributesForElementsInRect:` 方法，以获取特定矩形中的单元格和视图的属性，该矩形可能与可见矩形相同，也可能不相同。返回该信息后，核心布局过程就有效地完成了。

After layout finishes, the attributes of your cells and views remain the same until you or the collection view invalidates the layout. Calling the `invalidateLayout` method of your layout object causes the layout process to begin again, starting with a new call to the `prepareLayout` method. The collection view can also invalidate your layout automatically during scrolling. If the user scrolls its content, the collection view calls the layout object’s [shouldInvalidateLayoutForBoundsChange:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617781-shouldinvalidatelayoutforboundsc) method and invalidates the layout if that method returns `YES`.

布局完成后，单元格和视图的属性保持不变，直到您或集合视图使布局无效。调用布局对象的 `invalidateLayout` 方法会导致布局过程再次开始，再重新开始调用 `prepareLayout` 方法。集合视图还可以在滚动期间自动使布局无效。如果用户滚动其内容，则集合视图调用布局对象的 [shouldInvalidateLayoutForBoundsChange:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617781-shouldinvalidatelayoutforboundsc) 方法，如果该方法返回 `YES`，则使布局无效。

> **Note:** It is useful to remember that calling the invalidateLayout method does not begin the layout update process immediately. The method merely marks the layout as being inconsistent with the data and in need of being updated. During the next view update cycle, the collection view checks to see whether its layout is dirty and updates it if it is. In fact, you can call the invalidateLayout method multiple times in quick succession without triggering an immediate layout update each time.
> 
> **注意：**请记住，调用invalidateLayout方法不会立即开始布局更新过程。该方法仅将布局标记为与数据不一致并且需要更新。在下一个视图更新周期中，集合视图会检查其布局是否已损坏，如果已损坏，则会进行更新。事实上，您可以快速连续多次调用invalidateLayout方法，而无需每次立即触发布局更新。

### 5.1.2 Creating Layout Attributes - 创建布局属性

The attributes objects that your layout is responsible for are instances of the [UICollectionViewLayoutAttributes](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes) class. These instances can be created in a variety of different methods in your app. When your app is not dealing with thousands of items, it makes sense to create these instances while preparing the layout, because the layout information can be cached and referenced rather than computed on the fly. If the costs of computing all the attributes up front outweighs the benefits of caching in your app, it is just as easy to create attributes in the moment when they are requested.

布局负责的属性对象是 [UICollectionViewLayoutAttributes](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes) 类的实例。这些实例可以在应用程序中以各种不同的方法创建。当您的应用程序不处理数千个项目时，在准备布局时创建这些实例是有意义的，因为布局信息可以缓存和引用，而不是动态计算。如果预先计算所有属性的成本超过了在应用程序中缓存的好处，那么在请求时创建属性同样容易。

Regardless, when creating new instances of the `UICollectionViewLayoutAttributes` class, use one of the following class methods:

无论如何，在创建 `UICollectionViewLayoutAttributes` 类的新实例时，请使用以下类方法之一：

- [layoutAttributesForCellWithIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes/1617759-layoutattributesforcellwithindex)
- [layoutAttributesForSupplementaryViewOfKind:withIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes/1617801-init)
- [layoutAttributesForDecorationViewOfKind:withIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes/1617786-layoutattributesfordecorationvie)

You must use the correct class method based on the type of the view being displayed because the collection view uses that information to request the appropriate type of view from the data source object. Using the incorrect method causes the collection view to create the wrong views in the wrong places and your layout does not appear as intended.

必须根据所显示视图的类型使用正确的类方法，因为集合视图使用该信息从数据源对象请求适当类型的视图。使用不正确的方法会导致集合视图在错误的位置创建错误的视图，并且布局不会按预期显示。

After creating each attributes object, set the relevant attributes for the corresponding view. At a minimum, set the size and position of the view in the layout. In cases where the views of your layout overlap, assign a value to the [zIndex](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes/1617768-zindex) property to ensure a consistent ordering of the overlapping views. Other properties let you control the visibility or appearance of the cell or view and can be changed as needed. If the standard attributes class does not suit your app’s needs, you can subclass and expand it to store other information about each view. When subclassing layout attributes, it’s required that you implement the [isEqual:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSObject/Description.html#//apple_ref/occ/instm/NSObject/isEqual:) method for comparing your custom attributes because the collection view uses this method for some of its operations.

创建每个属性对象后，为相应视图设置相关属性。至少，在布局中设置视图的大小和位置。如果布局的视图重叠，请为 [zIndex](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes/1617768-zindex) 属性指定一个值，以确保重叠视图的顺序一致。其他属性允许您控制单元格或视图的可见性或外观，并且可以根据需要进行更改。如果标准属性类不适合您的应用程序的需要，您可以对其进行子类化并扩展以存储有关每个视图的其他信息。在对布局属性进行子类化时，需要实现 [isEqual:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSObject/Description.html#//apple_ref/occ/instm/NSObject/isEqual:) 方法来比较自定义属性，因为集合视图在某些操作中使用此方法。

For more information about layout attributes, see [UICollectionViewLayoutAttributes Class Reference](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes).

有关布局属性的详细信息，请参阅《[UICollectionViewLayoutAttributes类参考](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes)》。

### 5.1.3 Preparing the Layout
At the beginning of the layout cycle, the layout object calls prepareLayout before beginning the layout process. This method is your chance to calculate information that later informs your layout. The prepareLayout method is not required to implement a custom layout but is provided as an opportunity to make initial calculations if necessary. After this method is called, your layout must have enough information to calculate the collection view’s content size, the next step in the layout process. The information, however, can range from this minimum requirement to creating and storing all the layout attributes objects your layout will use. Use of the prepareLayout method is subject to the infrastructure of your app and to what makes sense to compute up front versus what to compute upon request. For an example of what the prepareLayout method might look like, see Preparing the Layout.

### 5.1.4 Providing Layout Attributes for Items in a Given Rectangle
During the final step of the layout process, the collection view calls your layout object’s layoutAttributesForElementsInRect: method. The purpose of this method is to provide layout attributes for every cell and every supplementary or decoration view that intersects the specified rectangle. For a large scrollable content area, the collection view may just ask for the attributes of items in the portion of that content area that is currently visible. In Figure 5-2, the currently visible content that your layout object needs to create attribute objects for is cells 6 through 20 along with the second header view. You must be prepared to provide layout attributes for any portion of your collection view content area. Such attributes might be used to facilitate animations for inserted or deleted items.

Figure 5-2  Laying out only the visible views

Because the layoutAttributesForElementsInRect: method is called after your layout object’s prepareLayout method, you should already have most of the information you need in order to return or create the required attributes. The implementation of your layoutAttributesForElementsInRect: method follows these steps:

Iterate over the data generated by the prepareLayout method to either access cached attributes or create new ones.
Check the frame of each item to see whether it intersects the rectangle passed to the layoutAttributesForElementsInRect: method.
For each intersecting item, add a corresponding UICollectionViewLayoutAttributes object to an array.
Return the array of layout attributes to the collection view.
Depending on how you manage your layout information, you might create UICollectionViewLayoutAttributes objects in your prepareLayout method or wait and do it in your layoutAttributesForElementsInRect: method. While forming an implementation that matches the needs of your application, keep in mind the benefits of caching layout information. Computing new layout attributes repeatedly for cells is an expensive operation, one that can have noticeably detrimental effects on your app’s performance. That said, when the amount of items your collection view manages is large, it may make more sense (for performance) to create the layout attributes when requested. It’s simply a matter of figuring out which strategy makes most sense for your app.

Note: Layout objects also need to be able to provide layout attributes on demand for individual items. The collection view might request that information outside of the normal layout process for several reasons, including to create appropriate animations. For more information about providing layout attributes on demand, see Providing Layout Attributes On Demand.
For a specific example of how one might implement layoutAttributesForElementsInRect:, see Providing Layout Attributes.

### 5.1.5 Providing Layout Attributes On Demand
The collection view periodically asks your layout object to provide attributes for individual items outside of the formal layout process. For example, the collection view asks for this information when configuring insertion and deletion animations for an item. Your layout object must be prepared to provide the layout attributes for each cell, supplementary view, and decoration view it supports. You do this by overriding the following methods:

layoutAttributesForItemAtIndexPath:
layoutAttributesForSupplementaryViewOfKind:atIndexPath:
layoutAttributesForDecorationViewOfKind:atIndexPath:
Your implementation of these methods should retrieve the current layout attributes for the given cell or view. Every custom layout object is expected to implement the layoutAttributesForItemAtIndexPath: method. If your layout does not contain any supplementary views, you do not need to override the layoutAttributesForSupplementaryViewOfKind:atIndexPath: method. Similarly, if it does not contain decoration views, you do not need to override the layoutAttributesForDecorationViewOfKind:atIndexPath: method. When returning attributes, you should not update the layout attributes. If you need to change the layout information, invalidate the layout object and let it update that data during a subsequent layout cycle.

### 5.1.6 Connecting Your Custom Layout for Use
There are two ways to link your custom layout to the collection view: programmatically or through storyboards. The collection view links to its layout through a writable property, collectionViewLayout. To set the layout to your custom implementation, set your collection view’s layout property to an instance of your custom layout object. Listing 5-1 shows the line of code needed.

Listing 5-1  Linking your custom layout
self.collectionView.collectionViewLayout = [[MyCustomLayout alloc] init];
Otherwise, from your storyboard, open the Document Outline panel and select your collection view (it is listed in the drop-down menu for your controller). With the collection view selected, open the Attributes inspector in the Utilities pane, and underneath the section labeled Collection View change the Layout option from Flow to Custom. The option beneath it changes from Scroll Direction to Class, and you can now select your custom layout class.

## 5.2 Making Your Custom Layouts More Engaging

Providing layout attributes for each cell and view during the layout process is required, but there are other behaviors that can improve the user experience with your custom layout. Implementing these behaviors is optional but recommended.

### 5.2.1 Elevating Content Through Supplementary Views
Supplementary views are separate from the collection view’s cells and have their own set of layout attributes. Like cells, these views are provided by the data source object, but their purpose is to enhance the main content of your app. For example, the UICollectionViewFlowLayout uses supplementary views for section headers and footers. Another app could use supplementary views to give each cell its own text label to display information about that cell. Like collection view cells, supplementary views undergo a recycling process to optimize the amount of resources used by the collection view. Therefore, all supplementary views used in your app should be subclassed from the UICollectionReusableView class.

The steps for adding supplementary views to your layouts are as follows:

Register your supplementary view to the collection view’s layout object using either the registerClass:forSupplementaryViewOfKind:withReuseIdentifier: or registerNib:forSupplementaryViewOfKind:withReuseIdentifier: method.
In your data source, implement collectionView:viewForSupplementaryElementOfKind:atIndexPath:. Because these views are reusable, call dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath: to dequeue, or create, a new reusable view and set any necessary data before returning it.
Create layout attributes objects for your supplementary views just as you do for cells.
Include these layout attributes objects in the array of attributes returned by the layoutAttributesForElementsInRect: method.
Implement the layoutAttributesForSupplementaryViewOfKind:atIndexPath: method to return the attributes object for the specified supplementary view whenever queried.
The process for creating the attributes objects for supplementary views in your custom layout is nearly identical to the process for cells, but differs in that a custom layout can have multiple types of supplementary views but is restricted to one type of cell. This is because supplementary views are meant to enhance the main content and are therefore separate from it. There are many ways in which an app’s content can be supplemented, and so each of the supplementary view’s methods specifies which kind of view is being addressed to distinguish it from the others and allow your layout to compute its attributes correctly based on its type. When registering a supplementary view for use, the string you provide is used by the layout object to distinguish the view from others. For an example of incorporating supplementary views into your custom layout, see Incorporating Supplementary Views.

### 5.2.2 Including Decoration Views in Your Custom Layouts
Decoration views are visual adornments that enhance the appearance of your collection view layouts. Unlike cells and supplementary views, decoration views provide visual content only and are thus independent of the data source. You can use them to provide custom backgrounds, fill in the spaces around cells, or even obscure cells if you want. Decoration views are defined and managed solely by the layout object and do not interact with the collection view’s data source object.

To add decoration views to your layouts, do the following:

Register your decoration view with the layout object using the registerClass:forDecorationViewOfKind: or registerNib:forDecorationViewOfKind: method. Although this approach is similar to registering cells and supplementary views, remember that registering decoration views occurs within the layout object, not within the data source.
In your layout object’s layoutAttributesForElementsInRect: method, create attributes for your decoration views just as you do for your cells and supplementary views.
Implement the layoutAttributesForDecorationViewOfKind:atIndexPath: method in your layout object and return the attributes for your decoration views when asked.
Optionally, implement the initialLayoutAttributesForAppearingDecorationElementOfKind:atIndexPath: and finalLayoutAttributesForDisappearingDecorationElementOfKind:atIndexPath: methods to handle animations for the appearance and disappearance of your decoration views. For more information, see Making Insertion and Deletion Animations More Interesting
The creation process for decoration views is different from the process for cells and supplementary views. Registering a class or nib file is all you have to do to ensure that decoration views are created when they are needed. Because they are purely visual, decoration views are not expected to need any configuration beyond what is already done in the provided nib file or by the object’s initWithFrame: method. For this reason, when a decoration view is needed, the collection view creates it for you and applies the attributes provided by the layout object. Any decoration views should still be a subclass of UICollectionReusableView because the layout object employs a recycling mechanism for its decoration views.

Note: When creating the attributes for your decoration views, don’t forget to take into account the zIndex property. You can use the zIndex attribute to layer your decoration views behind (or, if you prefer, in front of) the displayed cells and supplementary views.

### 5.2.3 Making Insertion and Deletion Animations More Interesting - 让插入和删除动画更有趣

Inserting and deleting cells and views poses an interesting challenge during layout. Inserting a cell can cause the layout for other cells and views to change. Even though the layout object knows how to animate existing cells and views from their current locations to new locations, it has no current location for the cell being inserted. Rather than insert the new cell without animations, the collection view asks the layout object to provide a set of initial attributes to use for the animation. Similarly, when a cell is deleted, the collection view asks the layout object to provide a set of final attributes to use for the endpoint of any animations.

在布局过程中，插入和删除单元格和视图是一个有趣的挑战。插入单元格会导致其他单元格和视图的布局发生更改。尽管布局对象知道如何将现有单元格和视图从当前位置动画化到新位置，但它没有插入单元格的当前位置。集合视图要求布局对象提供一组用于动画的初始属性，而不是插入没有动画的新单元格。类似地，当删除单元格时，集合视图要求布局对象提供一组最终属性，以用于任何动画的端点。

To understand how initial attributes work, it helps to see an example. The starting layout (Figure 5-3) shows a collection view that initially contains only three cells. When a new cell is inserted, the collection view asks the layout object to provide initial attributes for the cell being inserted. In this case, the layout object sets the initial position of the cell to the middle of the collection view and sets its alpha value to 0 to hide it. During the animations, this new cell appears to fade in and move from the center of the collection view to its final position in the lower-right corner.

要了解初始属性是如何工作的，请看一个示例。起始布局（图5-3）显示了最初仅包含三个单元格的集合视图。插入新单元格时，集合视图会要求布局对象为要插入的单元格提供初始属性。在这种情况下，布局对象将单元格的初始位置设置为集合视图的中间，并将其alpha值设置为0以隐藏它。在动画过程中，此新单元格似乎会淡入并从集合视图的中心移动到右下角的最终位置。

**Figure 5-3**  Specifying the initial attributes for an item appearing onscreen **图5-3** 指定屏幕上显示的项目的初始属性

![https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/custom_insert_animations_2x.png](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/custom_insert_animations_2x.png)

Listing 5-2 shows the code you might use to specify the initial attributes for the inserted cell from Figure 5-3. This method sets the position of the cell to the center of the collection view and makes it transparent. The layout object would then provide the final position and alpha for the cell as part of the normal layout process.

代码 5-2 显示了用于为图 5-3 中插入的单元格指定初始属性的代码。此方法将单元格的位置设置为集合视图的中心，并使其透明。布局对象随后将提供单元的最终位置和alpha，作为正常布局过程的一部分。

**Listing 5-2**  Specifying the initial attributes for an inserted cell **代码 5-2** 指定插入单元格的初始属性

```
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
   UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
   attributes.alpha = 0.0;
 
   CGSize size = [self collectionView].frame.size;
   attributes.center = CGPointMake(size.width / 2.0, size.height / 2.0);
   return attributes;
}
```

> **Note:** Listing 5-2 would animate all cells when one is inserted, so the three cells that were already present before the fourth was inserted would also pop out from the center of the collection view. To animate only the cell being inserted, check to see if the index path of the item matches the index path of an item passed to the [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates) method and only perform the animation if a match is found. Otherwise, return the attributes returned by calling the super method of [initialLayoutAttributesForAppearingItemAtIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617789-initiallayoutattributesforappear).

> **注意：**当插入一个单元格时，代码 5-2 将为所有单元格设置动画，因此在插入第四个单元格之前已经存在的三个单元格也将从集合视图的中心弹出。若要仅对插入的单元格设置动画，请检查项目的索引路径是否与传递给 [prepareForCollectionViewUpdates:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617784-prepareforcollectionviewupdates) 方法的项目索引轨迹匹配，并仅在找到匹配项时执行动画。否则，返回通过调用父类的 [initialLayoutAttributesForAppearingItemAtIndexPath:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617789-initiallayoutattributesforappear) 方法返回的属性。

The process for handling deletions is identical to the process for insertions except that you specify the final attributes instead of the initial attributes. From the previous example, if you used the same attributes that you used when inserting the cell, deleting the cell would cause it to fade out while moving to the center of the collection view. There are six methods available to you within the `UICollectionViewLayout` class—two separate methods (for initial and final attributes) for items, supplementary views, and decoration views.

处理删除的过程与插入的过程相同，只是指定了最终属性而不是初始属性。在上一个示例中，如果使用的属性与插入单元格时使用的属性相同，则删除单元格将导致其在移动到集合视图中心时淡出。`UICollectionViewLayout` 类中有六种方法可供您使用——用于项目、补充视图和装饰视图各有两种不同的方法（用于初始属性和最终属性）。

### 5.2.4 Improving the Scrolling Experience of Your Layout - 改善布局的滚动体验

Your custom layout object can influence the scrolling behavior of the collection view to create a better user experience. When scrolling-related touch events end, the scroll view determines the final resting place of the scrolling content based on the current speed and deceleration rate in effect. When the collection view knows that location, it asks its layout object if the location should be modified by calling its [targetContentOffsetForProposedContentOffset:withScrollingVelocity:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617729-targetcontentoffset) method. Because it calls this method while the underlying content is still moving, your custom layout can affect the final resting point of the scrolling content.

自定义布局对象可以影响集合视图的滚动行为，以创建更好的用户体验。当滚动相关的触摸事件结束时，滚动视图基于当前速度和有效的减速率确定滚动内容的最终静止位置。当集合视图知道该位置时，它通过调用其 [targetContentOffsetForProposedContentOffset:withScrollingVelocity:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617729-targetcontentoffset) 方法来询问其布局对象是否应修改该位置。因为它在底层内容仍在移动时调用此方法，所以自定义布局可能会影响滚动内容的最终静止点。

Figure 5-4 demonstrates how you might use your layout object to change the scrolling behavior of the collection view. Suppose the collection view offset starts at `(0, 0)` and the user swipes left. The collection view computes where the scrolling would naturally stop and provides that value as the “proposed” content offset value. Your layout object might change the proposed value to ensure that when scrolling stops, an item is centered precisely in the visible bounds of the collection view. This new value becomes the target content offset and is what you return from your [targetContentOffsetForProposedContentOffset:withScrollingVelocity:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617729-targetcontentoffset) method.

图 5-4 演示了如何使用布局对象来更改集合视图的滚动行为。假设集合视图偏移从 `(0, 0)` 开始，用户向左滑动。集合视图计算滚动自然停止的位置，并将该值作为“建议的”内容偏移值提供。布局对象可能会更改建议的值，以确保当滚动停止时，项目精确地位于集合视图可见边界的中心。此新值将成为目标内容偏移量，就是您从 [targetContentOffsetForProposedContentOffset:withScrollingVelocity:](https://developer.apple.com/documentation/uikit/uicollectionviewlayout/1617729-targetcontentoffset) 方法返回的值。

**Figure 5-4**  Changing the proposed content offset to a more appropriate value **图 5-4** 将建议的内容偏移量更改为更合适的值

![https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/custom_target_scroll_offset_2x.png](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/Art/custom_target_scroll_offset_2x.png)

## 5.3 Tips for Implementing Your Custom Layouts

Here are some tips and suggestions for implementing your custom layout objects:

Consider using the prepareLayout method to create and store the UICollectionViewLayoutAttributes objects you need for later. The collection view is going to ask for layout attribute objects at some point, so in some cases it makes sense to create and store them up front. This is especially true if you have a relatively small number of items (several hundred) or the actual layout attributes for those items change infrequently.
If your layout needs to manage thousands of items, though, you need to weigh the benefits of caching versus recomputing. For variable-size items whose layout changes infrequently, caching generally eliminates the need to recompute complex layout information regularly. For large numbers of fixed-size items, it may just be simpler to compute attributes on demand. And for items whose attributes change frequently, you might be recomputing all the time anyway so caching may just take up extra space in memory.

Avoid subclassing UICollectionView. The collection view has little or no appearance of its own. Instead, it pulls all of its views from your data source object and all of the layout-related information from the layout object. If you are trying to lay out items in three dimensions, the proper way to do it is to implement a custom layout that sets the 3D transform of each cell and view appropriately.
Never call the visibleCells method of UICollectionView from the layoutAttributesForElementsInRect: method of your custom layout object. The collection view knows nothing of where items are positioned, other than what the layout object tells it. So asking for the visible cells is just going to forward the request to your layout object.
Your layout object should always know the location of items in the content area and should be able to return the attributes of those items at any time. In most cases, it should do this on its own. In a limited number of cases, the layout object might rely on information in the data source to position items. For example, a layout that displays items on a map might retrieve the map location of each item from the data source.