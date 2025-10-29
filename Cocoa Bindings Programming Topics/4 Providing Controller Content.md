# Providing Controller Content 提供控制器内容

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/CntrlContent.html#//apple_ref/doc/uid/TP40002147-BCICADHC](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/CntrlContent.html#//apple_ref/doc/uid/TP40002147-BCICADHC)

Controllers require content to manipulate and there are a number of options for setting this content. It can be done programmatically, through bindings, or automatically in response to actions configured in Interface Builder. This article describes the various methods of setting and modifying a controller’s content.

控制器需要内容来进行操作，设置内容有多种方式。可以通过编程方式、绑定方式，或者响应在 Interface Builder 中配置的动作自动完成。本文介绍了设置和修改控制器内容的各种方法。

## 1 Setting the Content of a Controller 设置控制器的内容

NSObjectController and its subclasses are initialized with the method `initWithContent:`, passing a content object or `nil` if you intend to use the content bindings. You can explicitly set the content of an existing controller using the `setContent:` method. It is far more common to provide content for controllers by establishing a binding to one of their exposed Controller Content bindings.

NSObjectController 及其子类通过 `initWithContent:` 方法初始化；如果打算使用内容绑定，则传入一个内容对象或传入 `nil`。你可以使用 `setContent:` 方法显式设置现有控制器的内容。更常见的做法是，通过为控制器暴露的 “控制器内容” 绑定建立绑定来提供内容。

NSObjectController exposes a single binding for content called `contentObject`. You can establish a binding from `contentObject` to any object that is key-value-coding and key-value-observing compliant for the keys that you intend to have the controller operate on.

NSObjectController 暴露了一个名为 `contentObject` 的内容绑定。你可以将 `contentObject` 绑定到任何对象，只要该对象中你希望控制器操作的键符合键值编码和键值观察规范。

The collection controllers expose additional bindings: `contentArray`, `contentSet`, and `contentArrayForMultipleSelection`.

集合控制器公开了更多绑定：`contentArray`、`contentSet` 和 `contentArrayForMultipleSelection`。

The `contentArray` binding is bound to an NSArray or an object that implements the appropriate array indexed accessor methods. Similarly the `contentSet` binding is bound to an NSSet object or an object that implements the appropriate set indexed accessor methods. The indexed accessor patterns are described in Indexed Accessor Patterns for To-Many Properties in the [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i).

`contentArray` 绑定到一个 NSArray 或实现了适当数组索引访问器方法的对象。类似地，`contentSet` 绑定到一个 NSSet 对象或实现了适当集合索引访问器方法的对象。索引访问器模式在《[键值编码编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i)》的《一对多属性的索引访问器模式》中描述。

The `contentArrayForMultipleSelection` bindings is a special binding that is enabled only after establishing the `contentArray` or `contentSet` binding. The `contentArrayForMultipleSelection` binding is used as a fallback for the content of the controller when the contentArray or contentSet bindings return the multiple values marker. It allows you to use a different object and key path as the collection content in these cases and is often used when implementing a master-detail style interface.

`contentArrayForMultipleSelection` 绑定是一种特殊绑定，仅在建立 `contentArray` 或 `contentSet` 绑定后才启用。当 `contentArray` 或 `contentSet` 绑定返回多值标记时，`contentArrayForMultipleSelection` 绑定用作控制器内容的备用。它允许你在这些情况下使用不同的对象和键路径作为集合内容，通常在实现主-从样式界面时使用。

For example, Figure 1 shows a typical master-detail interface. The array controller that provides the list of activities is designated as the master controller and the names of the activities are displayed in the table view on the left. A second array controller is the detail controller and provides the names of members displayed in the table view on the right.

例如，图 1 显示了一个典型的主-从界面。提供活动列表的数组控制器被指定为主控制器，活动名称显示在左侧的表格视图中。第二个数组控制器是从控制器，提供显示在右侧表格视图中的成员名称。

Figure 1  Master-detail interface with and without contentArrayForMultipleSelection 图 1 启用和未启用 contentArrayForMultipleSelection 的主-从界面

![4-1](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/contentarrayform_2x.png)

The detail array controller’s `contentArray` binding is bound to the master array controller object with the key path `selection.members`. The `value` binding of the column in the detail table view is bound to the detail array controller’s arrangedObjects.name key path. When a single activity is selected in the master table view, the detail table view displays the names of the to-many members relationship.

从数组控制器的 `contentArray` 绑定到主数组控制器对象，键路径为 `selection.members`。从表格视图中列的 `value` 绑定到从数组控制器的 `arrangedObjects.name` 键路径。当在主表格视图中选择单个活动时，从表格视图显示一对多 `members` 关系的名称。

However, what happens if the master table view is configured to allow multiple selection? If only the detail array controller’s `contentArray` is bound, the detail table view is empty. While this is logical, it isn’t necessarily the desired results. A better option might be to display a unique list of the members in the selected activities. This is where the `contentArrayForMultipleSelection` binding and the key-value coding collection operators come into play.

但是，如果主表格视图配置为允许多选，会发生什么情况？如果仅绑定从数组控制器的 `contentArray`，从表格视图将为空。虽然这在逻辑上是合理的，但不一定是期望的结果。更好的选择可能是显示所选活动中成员的唯一列表。这就是 `contentArrayForMultipleSelection` 绑定和键值编码集合运算符发挥作用的地方。

By establishing a binding from `contentArrayForMultipleSelection` to the master array controller using the key path `selection.@distinctUnionOfArrays.members`, the detail table view will be populated with the names of the users in all the selected activities. Because the `@distinctUnionOfArrays` operator was used, members that are common to both activities do not appear as duplicate names in the detail table view.

通过将 `contentArrayForMultipleSelection` 绑定到主数组控制器（使用键路径 `selection.@distinctUnionOfArrays.members`），从表格视图将填充所有所选活动中的用户名称。由于使用了 `@distinctUnionOfArrays` 运算符，两个活动共有的成员不会在从表格视图中显示为重复名称。

Note that when the master array controller has a multiple selection the detail array controller’s add and remove buttons are disabled. The buttons’ enabled bindings are bound to the detail array controller’s `canAdd` and `canRemove` methods. The detail array controller automatically knows that it is unable to add and remove items to the composite array and updates the `canAdd` and `canRemove` state, causing the buttons to be disabled.

请注意，当主数组控制器有多个选择时，从数组控制器的 “添加” 和 “删除” 按钮将被禁用。按钮的 `enabled` 绑定到从数组控制器的 `canAdd` 和 `canRemove` 方法。从数组控制器自动知道它无法向复合数组添加和删除项目，并更新 `canAdd` 和 `canRemove` 状态，导致按钮被禁用。

## 2 Traversing Tree Content with an NSTreeController 使用 NSTreeController 遍历树内容

An NSTreeController requires that you describe how it should traverse the tree of objects, by specifying a child key path. This key path can be set programmatically using the NSTreeController method setChildrenKeyPath: or specified in the tree controller’s inspector panel in Interface Builder.

All child objects for the tree must be key-value-coding compliant for the same child key path. If necessary you should implement accessor methods in your model classes, or categories on those classes, that map the child key to the appropriate class-specific method name.

An optional count key path can be specified that, if provided, returns the number of child objects available. The count key path is set programmatically using the setCountKeyPath: method, or in the controller’s inspector panel in Interface Builder. Your model objects are expected to update the value of the count key path in a key-value-observing compliant method.

> Warning: Providing the count key path to an NSTreeController instance disables the add:, addChild:, remove:, removeChild:, or insert: methods.

You can optionally provide a leaf key path that specifies a key in your model object that returns YES if the object is a leaf node, and NO if it is not. Providing this key path prevents the NSTreeController from having to determine if a child object is a leaf node by examining the child object and as a result improve performance. The leaf key path is set programmatically using the setLeafKeyPath: method, or in the controller’s inspector panel in Interface Builder. This key path affects how an NSOutlineView or NSBrowser bound to the tree controller displays disclosure triangles:

- If the leaf key path for the model object returns YES, the outline view or browser does not show a disclosure triangle.
- If the leaf key path for the model object returns NO, then it always shows the disclosure triangle.
- If no leaf key path is configured for the controller, then the count or child key path of the model is queried to determine how many child objects are present. If there are 0 child objects, the disclosure triangle is not displayed, otherwise it is.

## 3 Specifying the Class of a Controller’s Content 指定控制器内容的类

In order for a controller to create new content objects automatically or in response to the target-action methods, it must know the appropriate class to use.

Controllers can be configured in one of two modes: object mode or entity mode. In object mode the content class is specified by the method setObjectClass: or in the controller inspector panel in Interface Builder. If the controller is configured in entity mode, the class is determined by the name of the entity or by the relationship that the entity defines for the key. The entity name is set using setEntityName: or in the controller inspector panel in Interface Builder.

If the controller is in object mode, the method newObject is used to create new objects. The default implementation simply allocates a new object of the class specified by objectClass or the entityName and sends the object a standard init message with no arguments. If your content objects require more complex initialization, you can subclass the appropriate controller class and override the newObject method.

An NSObjectController expects the content object to be of the class specified by the object class or entity name. When using the NSArrayController and NSTreeController the object class refers to the individual content objects, rather than the collection that holds the objects. In both cases the collections are expected to be key-value-coding compatible with arrays or sets, depending on the binding providing the content for the controller.

You are not restricted to having content of a single object class. You can create and insert objects of any class using one of the programmatic manipulation methods discussed in Programmatically Modifying a Controller’s Contents.

## 4 Automatically Prepares Content 自动准备内容

NSObjectController and its classes provide support for automatically creating content for a controller when it is loaded from a nib file. This is typically configured in the controller inspector in Interface Builder by enabling the “Automatically Prepares Content” option. When this option is enabled, the controller creates and populates the content object or content collection when the controller is loaded from a nib file by calling the controller’s prepareContent method.

For example, when an NSObjectController that has an object class of NSMutableDictionary is loaded from a nib and automatically prepares content is selected, the content of the object controller will be set to a newly instantiated, empty NSMutableDictionary instance.

Similarly, if an NSArrayController that has an object class of Activity is loaded, the content is set to a newly instantiated NSMutableArray containing a single instance of Activity. NSTreeController acts the same way.

If the controller that is loaded is in entity mode, then the data corresponding to the entity name is fetched and is filtered using the controller’s configured filter predicate.

## 5 Programmatically Modifying a Controller’s Contents 以编程方式修改控制器的内容

When you modify a controller’s content object the only restriction is that you must do it in a key-value-observing compliant manner so that the controller is informed of the changes. NSObjectController and its subclasses provide a number of methods that allow you to modify the contents of a controller programmatically.

NSObjectController offers the addObject: and removeObject: methods. When used with an NSObjectController, they are synonymous with the setContent: method, passing the parameter object or nil respectively.

The addObject: and removeObject: methods have somewhat different behavior for NSArrayController. In this case their behavior is the same as NSArray's addObject: and removeObject: methods. Unlike NSArray’s implementations, these methods inform the array controller of the changes so that they can be reflected in the user interface.

NSArrayController extends the basic add and remove functionality with the following methods:

```
- (void)addObjects:(NSArray *)objects;
- (void)removeObjects:(NSArray *)objects;
 
- (void)removeObjectsAtArrangedObjectIndexes:(NSIndexSet *)indexes;
- (void)removeObjectAtArrangedObjectIndex:(unsigned int)index;
 
- (void)insertObjects:(NSArray *)objects atArrangedObjectIndexes:(NSIndexSet *)indexes;
- (void)insertObject:(id)object atArrangedObjectIndex:(unsigned int)index;
```

The addObjects: and removeObjects: methods add or remove the objects passed as parameters from the collection. The method removeObjectsAtArrangedObjectIndexes: method iterates through the passed indexes, removing each object from the collection. The method removeObjectAtArrangedObjectIndex: removes the single object at the specified index.

The insertObjects:atArrangedObjectIndexes: iterates through the array of objects passed as the first parameter, inserting each object into the arranged collection at the corresponding index in the NSIndexSet. Similarly, the insertObject:atArrangedObjectIndex: method inserts the single object specified as the first parameter into the collection at the specified index.

NSTreeController provides four additional methods that operate in a similar fashion, but use NSIndexPaths to specify the location in the collection rather than simple indexes:

```
-(void)removeObjectsAtArrangedObjectIndexPaths:(NSArray *)indexPaths;
-(void)removeObjectAtArrangedObjectIndexPath:(NSIndexPath *)indexPath;
 
-(void)insertObject:(id)object atArrangedObjectIndexPath:(NSIndexPath *)indexPath;
-(void)insertObjects:(NSArray *)objects atArrangedObjectIndexPaths:(NSArray *)indexPath;
```

> Note: NSArrayController and NSTreeController are optimized for insertions and deletions made with these methods. Using these methods can provide a performance increase over modifying the model objects directly and relying on key-value observing.

## 6 Modifying Controller Content by Target-Action

In addition to the programmatic add, insert, and remove methods, the controller classes implement several target-action methods for modifying the controller’s content. These methods are typically configured as the actions for buttons in Interface Builder.

Note: In OS X v10.4 the target-action methods are deferred so that the error mechanism can provide feedback as a sheet.

NSObjectController provides the following target-action methods:

- (void)add:(id)sender;
- (void)remove:(id)sender;
The add: method creates a new content object using the controller’s newObject method and sets it as the content object of the controller if there is currently no content. The remove: method sets the content object to nil.

NSArrayController overrides NSObjectController’s add: and remove: methods and adds the following method:

- (void)insert:(id)sender;
With an array controller add: creates a new object using the controller’s newObject method and appends it to the controller’s content collection. The remove: method removes the currently selected objects in the array controller from the collection. The insert: method creates a new object using the controller’s newObject method, and inserts it after the current selection.

When the controller is in entity mode the remove semantics are dependent on the configuration of the binding and on the entities definition of the relationship. A remove may result in the current selection being removed from a relationship or being removed from the object graph entirely.

NSTreeController adds the following methods:

- (void)addChild:(id)sender;
- (void)insertChild:(id)sender;
The addChild: method creates and inserts a new object at the end of the tree controller’s collection. The insertChild: method inserts a new child object relative to the current selection.

Again, the semantics are slightly different if the controller is in entity mode. The add: and insert: actions use the newObject method to create the object that is added to the collection. In object mode the addChild:, and insertChild: create objects of the class specified by objectClass, but do not use the newObject method to do so. In entity mode or if the parent object is a managed object subclass, the entity defines the class of object created for and newObject is never called.

In order to enable and disable the target-action buttons as appropriate, the object controller classes provide several methods that return Boolean values indicating which actions are currently possible, taking into account the controller’s current selection and configuration.

//NSObjectController
- (BOOL)canAdd;
- (BOOL)canRemove;
- (BOOL)isEditable;
 
//NSArrayController
- (BOOL)canInsert;
 
//NSTreeController
- (BOOL)canAddChild;
- (BOOL)canInsertChild;
The enabled binding of controls are typically bound to the controller using one of these methods. As the controller’s selection changes the values returned by these methods are updated and the bound user interface items are automatically enabled or disabled as appropriate.

## 7 De-coupling a Controller from its Content Bindings

In order to programmatically de-couple a controller from a content object that is bound to contentObject, contentArray or contentSet, you must break the binding connection and set the controller’s content to nil.

    [theController unbind:@"contentArray"];
    [theController setContent:nil];







