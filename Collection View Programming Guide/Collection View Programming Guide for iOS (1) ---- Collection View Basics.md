# Collection View Programming Guide for iOS (1) ---- Collection View Basics

原文地址：
[https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CollectionViewBasics/CollectionViewBasics.html#//apple_ref/doc/uid/TP40012334-CH2-SW1](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/CollectionViewBasics/CollectionViewBasics.html#//apple_ref/doc/uid/TP40012334-CH2-SW1)

# 1 Collection View Basics - Collection View 基础

To present its content onscreen, a collection view cooperates with many different objects. Some objects are custom and must be provided by your app. For example, your app must provide a data source object that tells the collection view how many items there are to display. Other objects are provided by UIKit and are part of the basic collection view design.

Like tables, collection views are data-oriented objects whose implementation involves a collaboration with your app’s objects. Understanding what you have to do in your code requires a little background information about how a collection view does what it does.

A Collection View Is a Collaboration of Objects

The design of collection views separates the data being presented from the way that data is arranged and presented onscreen. Although your app is strictly responsible for managing the data to be presented, its visual presentation is managed by many different objects. Table 1-1 lists the collection view classes in UIKit and organizes them by the roles they play in implementing a collection view interface. Most of the classes are designed to be used as is without any need for subclassing, so you can usually implement a collection view with very little code. And when you want to go beyond the provided behavior, you can subclass and provide that behavior.

Table 1-1  The classes and protocols for implementing collection views
Purpose
Classes/Protocols
Description
Top-level containment and management
UICollectionView
UICollectionViewController
A UICollectionView object defines the visible area for your collection view’s content. This class descends from UIScrollView and can contain a large scrollable area as needed. This class also facilitates the presentation of your data based on the layout information it receives from its layout object.
A UICollectionViewController object provides view controller–level management support for a collection view. Its use is optional.
Content management
UICollectionViewDataSource protocol
UICollectionViewDelegate protocol
The data source object is the most important object associated with the collection view and is one that you must provide. The data source manages the content of the collection view and creates the views needed to present that content. To implement a data source object, you must create an object that conforms to the UICollectionViewDataSource protocol.
The collection view delegate object lets you intercept interesting messages from the collection view and customize the view’s behavior. For example, you use a delegate object to track the selection and highlighting of items in the collection view. Unlike the data source object, the delegate object is optional.
For information about how to implement the data source and delegate objects, see Designing Your Data Source and Delegate.
Presentation
UICollectionReusableView
UICollectionViewCell
All views displayed in a collection view must be instances of the UICollectionReusableView class. This class supports a recycling mechanism in use by collection views. Recycling views (instead of creating new ones) improves performance in general and especially improves it during scrolling.
A UICollectionViewCell object is a specific type of reusable view that you use for your main data items.
Layout
UICollectionViewLayout
UICollectionViewLayoutAttributes
UICollectionViewUpdateItem
Subclasses of UICollectionViewLayout are referred to as layout objects and are responsible for defining the location, size, and visual attributes of the cells and reusable views inside a collection view.
During the layout process, a layout object creates layout attribute objects (instances of the UICollectionViewLayoutAttributes class) that tell the collection view where and how to display cells and reusable views.
The layout object receives instances of the UICollectionViewUpdateItem class whenever data items are inserted, deleted, or moved within the collection view. You never need to create instances of this class yourself.
For more information about the layout object, see The Layout Object Controls the Visual Presentation.
Flow layout
UICollectionViewFlowLayout
UICollectionViewDelegateFlowLayout protocol
The UICollectionViewFlowLayout class is a concrete layout object that you use to implement grids or other line-based layouts. You can use the class as-is or in conjunction with the flow delegate object, which allows you to customize the layout information dynamically.
Figure 1-1 shows the relationship between the core objects associated with a collection view. The collection view gets information about the cells to display from its data source. The data source and delegate objects are custom objects provided by your app and used to manage the content, including the selection and highlighting of cells. The layout object is responsible for deciding where those cells belong and for sending that information to the collection view in the form of one or more layout attribute objects. The collection view then merges the layout information with the actual cells (and other views) to create the final visual presentation.

Figure 1-1  Merging content and layout to create the final presentation

When creating a collection view interface, you first add a UICollectionView object to your storyboard or nib file. Think of the collection view as the central hub, from which all other objects emanate. After adding that object, you can begin to configure any related objects, such as the data source or delegate. All configurations are centered around the collection view itself. For example, you never create a layout object without also creating a collection view object.

Reusable Views Improve Performance

Collection views employ a view recycling program to improve efficiency. As views move offscreen, they are removed from view and placed in a reuse queue instead of being deleted. As new content is scrolled onscreen, views are removed from the queue and repurposed with new content. To facilitate this recycling and reuse, all views displayed by the collection view must descend from the UICollectionReusableView class.

Collection views support three distinct types of reusable views, each of which has a specific intended usage:

Cells present the main content of your collection view. The job of a cell is to present the content for a single item from your data source object. Each cell must be an instance of the UICollectionViewCell class, which you may subclass as needed to present your content. Cell objects provide inherent support for managing their own selection and highlight state. To actually apply a highlight to a cell, you must write some custom code. For information on implementing cell highlighting/selecting, see Managing the Visual State for Selections and Highlights.
Supplementary views display information about a section. Like cells, supplementary views are data driven. Unlike cells, supplementary views are not mandatory, and their usage and placement is controlled by the layout object being used. For example, the flow layout supports headers and footers as optional supplementary views.
Decoration views are visual adornments that are wholly owned by the layout object and are not tied to any data in your data source object. For example, a layout object might use decoration views to implement a custom background appearance.
Unlike table views, collection views impose no specific style on the cells and supplementary views provided by your data source. Instead, the basic reusable view classes are blank canvases for you to modify. For example, you can use them to build small view hierarchies, to display images, or even to draw content dynamically.

Your data source object is responsible for providing the cells and supplementary views used by its associated collection view. However, the data source never creates views directly. When asked for a view, your data source dequeues a view of the desired type using the methods of the collection view. The dequeueing process always returns a valid view, either by retrieving one from a reuse queue or by using a class, nib file, or storyboard you provide to create a new view.

For information about how to create and configure views from your data source, see Configuring Cells and Supplementary Views.

The Layout Object Controls the Visual Presentation

The layout object is solely responsible for determining the placement and visual styling of items within the collection view. Although your data source object provides the views and the actual content, the layout object determines the size, location, and other appearance-related attributes of those views. This separation of responsibilities makes it possible to change layouts dynamically without changing any of the data objects managed by your app.

The layout process used by collection views is related to, but distinct from, the layout process used by the rest of your app’s views. In other words, do not confuse what a layout object does with the layoutSubviews method used to reposition child views inside a parent view. A layout object never touches the views it manages directly because it does not actually own any of those views. Instead, it generates attributes that describe the location, size, and visual appearance of the cells, supplementary views, and decoration views in the collection view. It is then the job of the collection view to apply those attributes to the actual view objects.

There are no limits to how a layout object can affect the views in a collection view. A layout object can move some views but not others. It can move views only a little bit, or it can move them randomly around the screen. It can even reposition views without any regard for the surrounding views. For example, a layout object can stack views on top of each other if it wants. The only real limitation is how the layout object affects the visual style you want your app to have.

Figure 1-2 shows how a vertically scrolling flow layout arranges its cells and supplementary views. In a vertically scrolling flow layout, the width of the content area remains fixed and the height grows to accommodate the content. To compute the area, the layout object places views and cells one at a time, choosing the most appropriate location for each. In the case of the flow layout, the size of the cells and supplementary views are specified as properties, either on the layout object or by using a delegate. Computing the layout is just a matter of using those properties to place each view.

Figure 1-2  The layout object provides layout metrics

Layout objects control more than just the size and position of their views. The layout object can specify other view-related attributes, such as its transparency, its transform in 3D space, and its visibility (if any) above or below other views. These attributes let you create more interesting layouts. For example, you might create stacks of cells by placing the views on top of one another and changing their z-ordering, or you might use a transform to rotate them on any axis.

For detailed information about how a layout object fulfills its responsibilities to the collection view, see Creating Custom Layouts.

Collection Views Initiate Animations Automatically

Collection views build in support for animations at a fundamental level. When you insert (or delete) items or sections, the collection view automatically animates any views impacted by the change. For example, when you insert an item, items after the insertion point are usually shifted to make room for the new item. The collection view can create these animations because it detects the current position of items and can calculate their final positions after the insertion takes place. Thus, it can animate each item from its initial position to its final position.

In addition to animating insertions, deletions, and move operations, you can invalidate the layout at any time and force it to recalculate its layout attributes. Invalidating the layout does not animate items directly; when you invalidate the layout, the collection view displays the items in their newly calculated positions without animating them. Instead in a custom layout, you might use this behavior to position cells at regular intervals and create an animated effect.