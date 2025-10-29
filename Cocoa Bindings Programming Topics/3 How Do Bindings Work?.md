# How Do Bindings Work? 绑定的工作原理是什么？

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH)

This article provides a conceptual explanation of how Cocoa bindings work. It describes:

本文从概念上解释了 Cocoa 绑定的工作原理，内容包括：

- How connections between model and controller, and controller and view, are established using key-value binding
- Unbinding
- The NSEditor and NSEditorRegistration protocols
- The technologies that Cocoa bindings use to support communication between the model, view, and controller, namely key-value coding, and key-value observing
- How the various technologies interact

- 如何通过键值绑定建立模型与控制器、控制器与视图之间的连接
- 解除绑定
- NSEditor 和 NSEditorRegistration 协议
- Cocoa 绑定用于支持模型、视图和控制器之间通信的技术，即键值编码和键值观察
- 各种技术之间如何交互

You should already be familiar with the concepts presented in What Are Cocoa Bindings?.

你应该已经熟悉《什么是 Cocoa 绑定？》中介绍的概念。


## 1 Overview of the Supporting Technologies 支持技术概述

This section presents an overview of the technologies that make Cocoa bindings work and how they interact. They are discussed in greater detail in the following sections.

Cocoa bindings rely on other technologies—key-value coding (KVC) and key-value observing (KVO)—to communicate changes between objects, and on key-value binding (KVB) to bind a value in one object to a property in another. Cocoa bindings also use two protocols—NSEditor and NSEditorRegistration—that help to ensure that any pending edits are either discarded or committed before user interface elements are disposed of.

To understand how these technologies work together, consider a drawing application that allows the user to draw graphic objects such as circles and rectangles on screen. Among other properties, a graphic object has a shadow that may be offset a variable distance from the center of the graphic at an arbitrary angle. An inspector displays the offset and angle of the selected graphic object’s shadow in a pair of text fields and a custom view—a joystick—as shown in Figure 1.

Figure 1  Example drawing application

The implementation of the inspector is illustrated in Figure 2. Both the text fields and the joystick are bound to the selection of an NSArrayController. The controller’s contentArray is bound to an array of Graphic objects. A Graphic has instance variables to represent its shadow’s angle in radians and its offset from its center.

Figure 2  Bindings for example graphics application

The text fields’ values are bound to the angle and offset of the graphic object’s shadow; the joystick provides a graphical representation of angle and offset. The angle in the text field is displayed in degrees, and the angle used internally by the joystick is specified in radians. The bindings for both of these specify a reversible value transformer that converts between radians and degrees.

The complete sequence of events that occurs when a user edits a value in the angle text field is illustrated in Figure 3.

Figure 3  The complete edit cycle

The user enters a new value in the Angle text field. The text field uses the NSEditorRegistration protocol to indicate that an edit has begun, and when it is complete. The text field’s binding specifies a reversible radians-to-degrees value transformer, so the new value is converted to radians.
Using KVC, through the controller the view updates the model object’s shadowAngle variable.
Through KVO, the model informs the controller that an update has been made to its shadowAngle variable.
Through KVO, the controller informs the joystick and the angle text field that an update has been made to its content’s shadowAngle variable.
Notice that the Offset text field was not involved in the cycle in any way. Cocoa bindings impose no more overhead than is necessary.

The next sections explain in greater detail how bindings are established and how the underlying technologies operate.

## 2 The Supporting Technologies in Detail 支持技术详情

This section first describes the technologies that support bindings and shows how they play their parts. It also explains what steps you must take in order to take advantage of these technologies.

### 2.1 Establishing Bindings with Key-Value Binding 通过键值绑定建立绑定

Key-value binding is used to establish bindings. The NSKeyValueBindingCreation informal protocol declares methods to establish and remove bindings between objects. In addition, it provides a means for a class to advertise the bindings that it exposes.

In most cases you need to use bind:toObject:withKeyPath:options:, and then only when you establish bindings programatically. Use of the unbind: is discussed in Unbinding. The other methods—the class method exposeBinding: and the instance methods exposedBindings and valueClassForBinding:—are useful only in an Interface Builder palette.

### 2.2 NSEditor/NSEditorRegistration

Together the NSEditorRegistration and NSEditor protocols allow views to notify a controller that an edit is underway and to ensure that any pending edits are committed as and when necessary.

The NSEditorRegistration informal protocol is implemented by controllers to provide an interface for a view—the editor—to inform the controller when it has uncommitted changes. When an edit is initiated, the view sends the controller an objectDidBeginEditing: message. When the edit is complete (for example when the user presses Return) the view sends an objectDidEndEditing: message.

The controller is responsible for tracking which editors have uncommitted changes and requesting that they commit or discard any pending edits when appropriate—for example, if the user closes the window or quits the application. The request takes the form of a commitEditing or discardEditing message, defined by the NSEditor informal protocol. NSController provides an implementation of this protocol, as do the Application Kit user interface elements that support binding.

### 2.3 Key-Value Coding 键值编码

Key-value coding (KVC) provides a unified way to access an object’s properties by name (key) without requiring use of custom accessor methods. The NSKeyValueCoding protocol specifies among others two methods, valueForKey: and setValue:forKey:, that give access to an object’s property with a specified name. In addition, the methods setValue:forKeyPath: and valueForKeyPath: give access to properties across relationships using key paths of the form relationship.property, for example, content.lastName.

A binding for a given property specifies an object and a key path to a property of that object. Given this information, the bound object can use key-value coding—specifically setValue:forKeyPath:—to update the object to which it is bound without having to hard-code an accessor method, as illustrated in Figure 4.

Figure 4  Key-value coding in Cocoa bindings

Since Cocoa bindings rely on KVC, your model and controller objects must be KVC-compliant for other objects to be able to bind to them. To support KVC you simply have to follow a set of conventions for naming your accessor methods, briefly summarized here:

- For an attribute or to-one relationship named <key>, implement methods named <key> and, if the attribute is read-write, set<Key>:—the case is important.
- For a to-many relationship implement either a method named <key> or both countOf<Key> and objectIn<Key>AtIndex:. The latter pair is useful if the related objects are not stored in an array. It is up to you to retrieve an appropriate value for the specified index—it does not matter how the value is derived. For a mutable to-many relationship, you should also implement either set<Key> (if you implemented <key>) or insertObject:in<Key>AtIndex: and removeObjectFrom<Key>AtIndex:.

For full details of all the methods declared by the NSKeyValueCoding protocol, see Key-Value Coding Programming Guide.

### 2.4 Key-Value Observing 键值观察

KVO is a mechanism that allows an object to register to receive notifications of changes to values in other objects. To register, an observer sends the object it wants to observe an addObserver:forKeyPath:options:context: message that specifies:

The object that is observing (very often self)
The key path to observe (for example, selection.name)
What information will be sent on notification (for example, old value and new value)
Optionally, contextual information to be sent back on notification (for example, a flag to indicate what binding is being affected)
An observed object communicates changes directly to observers by sending them an observeValueForKeyPath:ofObject:change:context: message (defined by the NSKeyValueObserving informal protocol)—there is no independent notifier object akin to NSNotificationCenter. Figure 5 illustrates how a change to a model value (the shadow angle) is communicated to views using KVO.

Figure 5  Key-value observing in Cocoa bindings

The message is sent to observers for every change to an observed property, independently of how the change was triggered. (Note that the protocol itself makes no assumptions about what the observer actually does with the information.)

One other important aspect of KVO is that you can register the value of a key as being dependent on the value of one or more others. A change in the value associated with one of the “master” keys triggers a change notification for the dependent key’s value. For example, the drawing bounds of a graphic object may be dependent on the offset and angle of the associated shadow. If either of those values changes, any objects observing the drawing bounds must be notified.

The main requirement to make use of KVO is that your model objects be KVO-compliant. In most cases this actually requires no effort—the runtime system adds support automatically. By default, all invocations of KVC methods result in observer notifications. You can also implement manual support—see Key-Value Observing Programming Guide for more details.

### 2.5 Unbinding 解除绑定

Typically the only reason you would explicitly unbind an object is if you modify the user interface programatically and want to remove a binding. If you change an objects binding’s values it should first clear any preexisting values.

If you implement a custom view or controller with custom bindings, you should ensure that it clears any bindings before it is deallocated—in particular it should release any objects that were retained for the specified binding in the bind:toObject:withKeyPath:options: method and should deregister as an observer of any objects for which it registered as an observer. It may be convenient to implement this logic in an unbind: method that you then call as the first step in dealloc.

## 3 Bindings in More Detail 更详细的绑定

This section examines bindings in more detail. It decomposes—from the perspective of a custom view, a joystick—what happens when a binding is established. This serves two purposes: it makes explicit what code is involved in establishing a binding and responding to changes, and it gives a conceptual overview of how to create your own bindings-enabled views.

本节更详细地探讨绑定。它从自定义视图（操纵杆）的角度分解了建立绑定时发生的情况。这有两个目的：明确建立绑定和响应变化所涉及的代码，以及从概念上概述如何创建自己的支持绑定的视图。

A binding specifies what aspect of one object should be bound to what property in another, such that a change in either is reflected in the other. For a given binding, an object therefore records the target object for the binding, the associated key path, and any options that were specified.

绑定指定一个对象的哪个方面应该绑定到另一个对象的哪个属性，以便一方的变化会反映在另一方。因此，对于特定的绑定，对象会记录绑定的目标对象、相关的键路径以及指定的任何选项。

You can establish bindings easily in Interface Builder using the Bindings pane of the Info window. In Interface Builder, the angle binding for a joystick that displays the offset and angle of graphics object’s shadow might look like Figure 6.

你可以在 Interface Builder 中使用信息窗口的 “绑定” 面板轻松建立绑定。在 Interface Builder 中，显示图形对象阴影偏移量和角度的操纵杆的角度绑定可能如图 6 所示。

Figure 6  Bindings for a joystick’s angle in Interface Builder 图 6 Interface Builder 中操纵杆角度的绑定

![3-6](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/joystick_ib_inspector.png)

Establishing this binding in Interface Builder is equivalent to programatically sending this message to the joystick:

在 Interface Builder 中建立此绑定相当于以编程方式向操纵杆发送以下消息：

```
[joystick bind:@"angle" toObject:GraphicController withKeyPath:@"selection.shadowAngle" options:options];
```

The arguments have the following meanings:

参数的含义如下：

**@"angle"**

Identifies an attribute whose value can be bound to the value of a property in another object. Note that the binding name need not necessarily correspond to the name of an actual instance variable.

标识一个属性，其值可以绑定到另一个对象的某个属性的值。请注意，绑定名称不一定必须与实际实例变量的名称对应。

**GraphicController**

The object containing the bound-to property.

包含被绑定属性的对象。

**@"selection.shadowAngle"**

The key path that identifies the bound-to property.

标识被绑定属性的键路径。

**options**

A dictionary that specifies any options such as placeholders, or in this case, a value transformer.

指定任何选项（如占位符）的字典，或者（在这个例子中）是一个值转换器。

The information defined by the arguments can be stored in the bound object (in this case the joystick) as instance variables, as discussed next.

参数定义的信息可以作为实例变量存储在被绑定的对象（在这个例子中是操纵杆）中，如下所述。

This example, and those that follow, assume that the joystick is represented by the class Joystick with instance variables as defined in the interface shown in Listing 1.

本示例及后续示例假设操纵杆由 Joystick 类表示，其实例变量如清单 1 中定义的接口所示。

Listing 1  Interface for the Joystick class 清单 1 Joystick 类的接口

```
@interface Joystick : NSView
{
    float angle;
    id observedObjectForAngle;
    NSString *observedKeyPathForAngle;
    NSValueTransformer *angleValueTransformer;
    // ...
}
```

In its `bind:toObject:withKeyPath:options:` method an object must as a minimum do the following:

在其 `bind:toObject:withKeyPath:options:` 方法中，对象至少必须执行以下操作：

- Determine which binding is being set
- Record what object it is being bound to using what keypath and with what options
- Register as an observer of the keypath of the object to which it is bound so that it receives notification of changes

- 确定正在设置哪个绑定
- 记录它要绑定到的对象、使用的键路径以及使用的选项
- 注册为它所绑定对象的键路径的观察者，以便接收变化通知

The code sample in Listing 2 shows a partial implementation of Joystick’s `bind:toObject:withKeyPath:options:` method dealing with just the `angle` binding.

清单 2 中的代码示例显示了 Joystick 的 `bind:toObject:withKeyPath:options:` 方法的部分实现，仅处理 `angle` 绑定的部分。

Listing 2  Partial implementation of the bind:toObject:withKeyPath:options method for the Joystick class 清单 2 Joystick 类的 bind:toObject:withKeyPath:options 方法的部分实现

```
static void *AngleBindingContext = (void *)@"JoystickAngle";
 
- (void)bind:(NSString *)binding
 toObject:(id)observableObject
 withKeyPath:(NSString *)keyPath
 options:(NSDictionary *)options
{
 // Observe the observableObject for changes -- note, pass binding identifier
 // as the context, so you get that back in observeValueForKeyPath:...
 // This way you can easily determine what needs to be updated.
 // 观察 observableObject 的变化 —— 注意，传递绑定标识符
 // 作为上下文，这样你可以在 observeValueForKeyPath:... 中获取它
 // 这样你可以轻松确定需要更新什么。
 
if ([binding isEqualToString:@"angle"])
 {
    [observableObject addObserver:self
                   forKeyPath:keyPath
                  options:0
                  context:AngleBindingContext];
 
    // Register what object and what keypath are
    // associated with this binding
    // 注册与该绑定相关联的对象和键路径
    observedObjectForAngle = [observableObject retain];
    observedKeyPathForAngle = [keyPath copy];
 
    // Record the value transformer, if there is one
    // 记录值转换器（如果有的话）
    angleValueTransformer = nil;
    NSString *vtName = [options objectForKey:@"NSValueTransformerName"];
    if (vtName != nil)
    {
        angleValueTransformer = [NSValueTransformer
            valueTransformerForName:vtName];
    }
 }
 // Implementation continues...
 // 实现继续...
```
 
This partial implementation does not record binding options other than a value transformer (although it may simply be that the binding does not allow for them). It nevertheless illustrates the basic principles of establishing a binding. Notice in particular the contextual information passed in the `addObserver:forKeyPath:options:context:` message; this is returned in the `observeValueForKeyPath:ofObject:change:context:` method and can be used to determine which binding is affected by the value update.

这个部分实现没有记录除值转换器之外的绑定选项（尽管可能只是该绑定不允许其他选项）。尽管如此，它还是说明了建立绑定的基本原理。特别要注意在 `addObserver:forKeyPath:options:context:` 消息中传递的上下文信息；该信息会在 `observeValueForKeyPath:ofObject:change:context:` 方法中返回，可用于确定哪个绑定受值更新的影响。

## 4 Responding to Changes 响应变化

As noted earlier, there are two aspects to change management—responding to view-initiated changes that must be propagated ultimately to the model, and responding to model-initiated changes that must be reflected in the view. This section illustrates both, and shows how KVC and KVO play their parts.

如前所述，变更管理有两个方面 —— 响应必须最终传播到模型的视图发起的变化，以及响应必须反映在视图中的模型发起的变化。本节将举例说明这两个方面，并展示 KVC 和 KVO 如何发挥作用。

### 4.1 View-Initiated Updates 视图发起的更新

Recall that the joystick was bound to the controller with the following method:

回想一下，操纵杆通过以下方法绑定到控制器：

```
[joystick bind:@"angle" toObject:GraphicController withKeyPath:@"selection.shadowAngle" options:options];
```

From the perspective of view-initiated updates the method can be interpreted as follows:

从视图发起的更新的角度来看，该方法可以解释为：

**bind: @"angle"**

	If whatever is associated with angle changes,

	如果与 angle 相关联的任何内容发生变化，

**toObject: GraphicController**

	tell the specified object (GraphicController) that

	告诉指定的对象（GraphicController）

**withKeyPath: @"selection.shadowAngle"**

	the value of its (the GraphicController’s) selection.shadowAngle has changed

	其（GraphicController 的）selection.shadowAngle 的值已发生变化

**options: options**

	using any of these options that may be appropriate.

	使用任何可能适用的这些选项。

If the value associated with angle changes—typically when a user clicks or drags the mouse within the view—the joystick should pass the new value to the controller using KVC, as illustrated in Figure 4. The joystick should therefore respond to user input as follows:

如果与 angle 相关联的值发生变化（通常是当用户在视图内点击或拖动鼠标时），操纵杆应该使用 KVC 将新值传递给控制器，如图 4 所示。因此，操纵杆应该按如下方式响应用户输入：

- Determine new values for angle and offset
- Update its own display as appropriate
- Communicate new values to the controller to which it is bound

- 确定角度和偏移量的新值
- 适当地更新自己的显示
- 将新值传达给它所绑定的控制器

Listing 3 shows a partial implementation of an update method for the Joystick class. The excerpt deals just with the angle binding. It illustrates the use of key-value coding to communicate the new value (transformed by the value transformer if appropriate) to the observed object.

清单 3 显示了 Joystick 类的更新方法的部分实现。该摘录仅处理角度绑定，说明了如何使用键值编码将新值（如果适用，通过值转换器转换）传达给被观察的对象。

Listing 3  Update method for the Joystick class 清单 3 Joystick 类的更新方法

```
-(void)updateForMouseEvent:(NSEvent *)event
{
    float newAngleDegrees;
    // calculate newAngleDegrees...
    // 计算 newAngleDegrees...
 
    [self setAngle:newAngleDegrees];
 
    if (observedObjectForAngle != nil)
    {
        NSNumber *newControllerAngle = nil;
 
        if (angleValueTransformer != nil)
        {
            newControllerAngle =
                [angleValueTransformer reverseTransformedValue:
                    [NSNumber numberWithFloat:newAngleDegrees]];
        }
        else
        {
            newControllerAngle = [NSNumber numberWithFloat:newAngleDegrees];
        }
        [observedObjectForAngle setValue: newControllerAngle
                  forKeyPath: observedKeyPathForAngle];
    }
    // ...
}
```

Note that this example omits several important details, such as editor registration and checking that the value transformer allows reverse transformations.

请注意，此示例省略了几个重要细节，例如编辑器注册和检查值转换器是否允许反向转换。

### 4.2 Model-Initiated Updates 模型发起的更新

Recall again that the joystick was bound to the controller with the following method:

再次回想一下，操纵杆通过以下方法绑定到控制器：

```
[joystick bind:@"angle" toObject:GraphicController withKeyPath:@"selection.shadowAngle" options:options];
```

From the perspective of model-initiated updates the method can be interpreted as follows:

从模型发起的更新的角度来看，该方法可以解释为：

**toObject: GraphicController**

	If the GraphicController’s
	
	如果 GraphicController 的

**withKeyPath:@"selection.shadowAngle"**

	selection.shadowAngle changes
	
	selection.shadowAngle 发生变化，

**bind:@"angle"**

	update whatever is associated with the exposed angle key
	
	更新与公开的 angle 键相关联的任何内容

**options:options**

	using the options specified (for example, using a value transformer).
	
	使用指定的选项（例如使用值转换器）。

The receiver therefore registered as an observer of the specified object’s key path (`selection.shadowAngle`) in its `bind:toObject:withKeyPath:options:` method, as was shown in Listing 2. Observed objects notify their observers by sending them an `observeValueForKeyPath:ofObject:change:context:` message. Listing 4 shows a partial implementation for the Joystick class for handling the observer notifications that result.

因此，接收者在其 `bind:toObject:withKeyPath:options:` 方法中注册为指定对象的键路径（`selection.shadowAngle`）的观察者，如清单 2 所示。被观察的对象通过向观察者发送 `observeValueForKeyPath:ofObject:change:context:` 消息来通知它们。清单 4 显示了 Joystick 类处理由此产生的观察者通知的部分实现。

The fundamental requirement of the `observeValueForKeyPath:ofObject:change:context:` method is that the value associated with the relevant attribute is updated. This excerpt also shows how it can capture placeholder information that might be used in the display method to give visual feedback to the user, in this case using an instance variable that indicates that for some reason the angle is “bad.”

`observeValueForKeyPath:ofObject:change:context:` 方法的基本要求是更新与相关属性相关联的值。此摘录还展示了它如何捕获可能在显示方法中用于向用户提供视觉反馈的占位符信息，在这个例子中，使用一个实例变量来指示角度因某种原因 “无效”。

Listing 4  Observing method for the Joystick class 清单 4 Joystick 类的观察方法

```
- (void)observeValueForKeyPath:(NSString *)keyPath
              ofObject:(id)object
            change:(NSDictionary *)change
               context:(void *)context
{
    // You passed the binding identifier as the context when registering
    // as an observer--use that to decide what to update...
    // 注册为观察者时，你将绑定标识符作为上下文传递——使用它来决定更新什么...
 
    if (context == AngleObservationContext)
    {
        id newAngle = [observedObjectForAngle
            valueForKeyPath:observedKeyPathForAngle];
        if ((newAngle == NSNoSelectionMarker) ||
            (newAngle == NSNotApplicableMarker) ||
            (newAngle == NSMultipleValuesMarker))
        {
            badSelectionForAngle = YES;
        }
        else
        {
            badSelectionForAngle = NO;
            if (angleValueTransformer != nil)
            {
                newAngle = [angleValueTransformer
                    transformedValue:newAngle];
            }
            [self setValue:newAngle forKey:@"angle"];
        }
    }
    // ...
 
    [self setNeedsDisplay:YES];
}
```

In most controls the display method alters the visual representation depending on the current selection.

在大多数控件中，显示方法会根据当前选择改变视觉表现。












