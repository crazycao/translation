# What Are Cocoa Bindings? 什么是 Cocoa 绑定？

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/WhatAreBindings.html#//apple_ref/doc/uid/20002372-CJBEJBHH](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/WhatAreBindings.html#//apple_ref/doc/uid/20002372-CJBEJBHH)

In the simplest functional sense, the Cocoa bindings technology provides a means of keeping model and view values synchronized without you having to write a lot of “glue code.” It allows you to establish a mediated connection between a view and a piece of data, “binding” them such that a change in one is reflected in the other.

从最简单的功能层面来说，Cocoa 绑定技术提供了一种让模型和视图的值保持同步的方式，无需你编写大量 “粘合代码”。它允许你在视图和一段数据之间建立一种中介连接，将它们 “绑定” 起来，这样一方的变化就能反映在另一方。

This article describes what the technology offers and how it makes writing applications easier. It also introduces the idea that rather than completely reimplementing an existing application to make use of bindings, you can incorporate bindings in stages.

本文将介绍这项技术能提供什么，以及它如何让应用程序的编写变得更轻松。同时还会提出一种思路：不必为了使用绑定而彻底重写现有应用程序，你可以分阶段融入绑定功能。

This article also describes on a conceptual level how Cocoa bindings work, and the design patterns you should adopt. It gives a brief overview of the Model-View-Controller design pattern, and why it is beneficial. It then gives a conceptual overview of how the main technologies that underpin Cocoa bindings—key-value coding, key-value observing, and key-value binding—work, and how they inter-relate. The article finally explains the role of the controller classes that Cocoa bindings provide and why you should use them.

本文还将从概念层面描述 Cocoa 绑定的工作原理，以及你应该采用的设计模式。它简要概述了模型-视图-控制器（MVC）设计模式及其优势，然后从概念上介绍支撑 Cocoa 绑定的主要技术——键值编码、键值观察和键值绑定——的工作方式及其相互关系。最后，本文将解释 Cocoa 绑定提供的控制器类的作用以及使用它们的原因。

[How Do Bindings Work?](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH) describes the supporting technologies in greater detail.

《[绑定如何工作？](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH)》将更详细地描述这些支持技术。

## 1 The Advantages of Using Bindings 使用绑定的优势

The Cocoa bindings technology offers a way to increase the functionality and consistency of your application while at the same time decreasing the amount of code you have to write and maintain. It takes care of most aspects of user interface management for you by allowing you to off load the work of custom glue code onto reusable pre-built controllers. It helps you build polished, easy-to-use applications that leverage object relationships, provide sortable tables, and include intelligent selection management.

Cocoa 绑定技术能增加应用程序的功能和一致性，同时减少你需要编写和维护的代码量。它通过让你将自定义粘合代码的工作转移到可重用的预制控制器上，为你处理用户界面管理的大部分方面。它帮助你构建精致、易用的应用程序，这些应用程序能利用对象关系、提供可排序的表格，并包含智能的选择管理功能。

Typically you do not need to completely rewrite your application in order to adopt Cocoa bindings. For example, it is likely that you can factor out User Preferences to be managed by Cocoa bindings without affecting the rest of an application. You will find it easier to make use of Cocoa bindings if your application adopts the recommended design patterns.

通常，你不必为了采用 Cocoa 绑定而彻底重写应用程序。例如，你可以将用户偏好设置抽离出来，由 Cocoa 绑定管理，而不影响应用程序的其他部分。如果你的应用程序采用了推荐的设计模式，使用 Cocoa 绑定会变得更容易。

## 2 The Model-View-Controller Design Pattern 模型-视图-控制器（MVC）设计模式

Cocoa applications generally adopt the Model-View-Controller (MVC) design pattern. When you develop a Cocoa application, you typically use model, view, and controller objects, each of which performs a different function. Model objects represent data and are typically saved to a file or some other permanent data store. View objects display model attributes. Controller objects act as go-betweens, to make sure that what a view displays is consistent with the corresponding model value and that any updates a user makes to a value in a view are propagated to the model. An understanding of the MVC design pattern is essential to fully understand and leverage Cocoa bindings. If you need to know more, read “The Model-View-Controller Design Pattern.”

Cocoa 应用程序通常采用模型-视图-控制器（MVC）设计模式。当你开发 Cocoa 应用程序时，通常会使用模型、视图和控制器对象，每个对象都有不同的功能。模型对象代表数据，通常会保存到文件或其他永久性数据存储中。视图对象显示模型的属性。控制器对象充当中间媒介，确保视图显示的内容与相应的模型值一致，并且用户在视图中对值所做的任何更新都能传递到模型。要充分理解和利用 Cocoa 绑定，理解 MVC 设计模式至关重要。如果想了解更多，可阅读《模型-视图-控制器设计模式》（本章节）。

If you adopt the MVC design pattern, much of your application code is easier to reuse and extend—you can reuse model and view classes in different applications. Much of the implementation of a controller object consists of what is commonly referred to as “glue code.” Glue code is the code that keeps the model values and views synchronized, and is unique to each application. It is typically tedious and cumbersome to write, contributes little to the fundamental function of the application, but you must do it well to provide a good user experience.

如果采用 MVC 设计模式，应用程序的大部分代码会更易于重用和扩展——你可以在不同的应用程序中重用模型和视图类。控制器对象的大部分实现由通常称为 “粘合代码” 的部分组成。粘合代码是用于保持模型值和视图同步的代码，并且每个应用程序的粘合代码都是独特的。编写粘合代码通常繁琐又麻烦，对应用程序的基本功能贡献甚微，但要提供良好的用户体验，就必须把它写好。

Figure 1  Controllers provide glue code 图 1 控制器提供粘合代码
![2-1](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/glue_2x.png)

Cocoa bindings replace much of the glue code with reusable controllers and provide an infrastructure that allows you to connect the user interface with an application’s data.

Cocoa 绑定用可重用的控制器替代了大部分粘合代码，并提供了一个基础设施，让你能将用户界面与应用程序的数据连接起来。

Cocoa uses a number of terms that are commonly used in computer science. To avoid misunderstanding, they are defined in the “Terminology” section of [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) with their particular meaning in the context of Cocoa bindings.

Cocoa 使用了一些计算机科学中常用的术语。为避免误解，《[键值编码编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i)》的《术语》部分对这些术语在 Cocoa 绑定语境中的特定含义进行了定义。

## 3 What Is a Binding? 什么是绑定？

A binding is an attribute of one object that may be bound to a property in another such that a change in either one is reflected in the other. For example, the “value” binding of a text field might be bound to the `temperature` attribute of a particular model object. More typically, one binding might specify that a controller object “presents” a model object and another binding might specify that the value of a text field be tied to the `temperature` property of the object presented by the controller.

绑定是一个对象的某个属性，它可以与另一个对象的某个属性绑定，这样两者中任何一方的变化都会反映在另一方。例如，文本字段的 “value” 绑定可能绑定到某个模型对象的 `temperature` 属性。更典型的情况是，一个绑定可能指定控制器对象 “呈现” 某个模型对象，而另一个绑定可能指定文本字段的值与该控制器所呈现对象的 `temperature` 属性相关联。

Although the following examples concentrate on simple cases, bindings are not restricted to the display of textual or numeric values. Among other things, a binding might specify the color in which text should be displayed, whether a view is hidden or not, or what message and arguments should be sent when a button is pressed.

尽管以下示例主要关注简单情况，但绑定并不局限于显示文本或数值。比如，绑定可以指定文本的显示颜色、视图是否隐藏、或者按钮被按下时应发送的消息和参数等。

### 3.1 A Simple Example 一个简单示例

Take as an example a very simple application in which the values in a text field and a slider are kept synchronized. Consider first an implementation that does not use bindings. The text field and slider are connected directly to each other using target-action, where each is the other’s target and the action is takeFloatValueFrom: as shown in Figure 2. (If you do not understand this, you should read Getting Started With Cocoa.)

以一个非常简单的应用程序为例，该应用程序要保持文本字段和滑块的值同步。首先考虑不使用绑定的实现方式。文本字段和滑块通过目标-动作机制直接连接，彼此互为目标，动作是 `takeFloatValueFrom:`，如图 2 所示。（如果不理解这一点，你应该阅读《[Cocoa 入门](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/Introduction/Introduction.html)》。）

Figure 2  A simple Cocoa application 图 2 一个简单的 Cocoa 应用程序

![2-2](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/slider_2x.png)

This example illustrates the dynamism of the Cocoa environment—the values of two user interface objects are kept synchronized without writing any code, even without compiling. It also serves to illustrate the target-action design pattern (for more details, read The Target-Action Paradigm).

这个示例展示了 Cocoa 环境的动态性——两个用户界面对象的值无需编写任何代码（甚至无需编译）就能保持同步。它也用于说明目标-动作设计模式（更多细节请阅读《目标-动作范式》）。

The major flaw from which this example suffers is that, as it is, it has almost no real-world application. In order to find out the value to which either the slider or the text field has been set, and update a model attribute accordingly, you need connections to the text field and slider, and have to write some code. You typically use a controller that is connected to both (using outlets) and to which both are connected (using target-action), as illustrated in Figure 3.

这个示例存在一个主要缺陷：就目前而言，它几乎没有实际应用价值。为了获知滑块或文本字段被设置的值，并相应地更新模型属性，你需要与文本字段和滑块建立连接，还得编写一些代码。通常，你会使用一个控制器，它通过出口（outlet）与两者连接，同时两者也通过目标-动作机制与它连接，如图 3 所示。

Figure 3  Slider example using target-action 图 3 使用目标-动作的滑块示例

![2-3](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/slidertargetaction_2x.png)

When a user moves the slider, it sends an action message to its target (the controller). The controller in turn updates the value in the model, and synchronizes the user interface (the text field and the slider). Although this example is not particularly difficult, the situation becomes more complex if you use more complicated models and displays, especially if you use, for example, table views that allow multiple selections, or if a value may be displayed in a different window. And you have to write all the code to support this functionality.

当用户移动滑块时，滑块会向其目标（控制器）发送一个动作消息。控制器随后更新模型中的值，并同步用户界面（文本字段和滑块）。虽然这个示例并不特别复杂，但如果使用更复杂的模型和显示方式，情况就会变得复杂，尤其是当使用允许多选的表格视图，或者某个值可能在不同窗口中显示时。而且，你必须编写所有代码来支持这些功能。

Cocoa bindings uses prebuilt controller objects (subclasses of NSController) and supporting technologies to keep values synchronized automatically. The application design for an implementation of the slider example that uses bindings is shown in Figure 4.

Cocoa 绑定使用预制的控制器对象（NSController 的子类）和支持技术来自动保持值的同步。使用绑定实现的滑块示例的应用程序设计如图 4 所示。

Figure 4  Slider demonstration using bindings 图 4 使用绑定的滑块演示

![2-4](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/sliderbindings_2x.png)

Note that this implementation does not use the target-action pattern. The slider does not send an action message to the controller. Instead, as the slider moves, it informs the controller directly that the value of its content’s number has changed and what the value is. The controller updates the model and in turn informs the text field and slider that the value they are displaying has changed. (In examples as simple as this controllers are not really necessary, however in most cases they are.) The mechanisms used to relay information are explained later in this article and in greater detail in [How Do Bindings Work?](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH), but it is important to appreciate that in most cases you will not have to write any glue code.

注意，这种实现不使用目标-动作模式。滑块不会向控制器发送动作消息。相反，当滑块移动时，它会直接通知控制器其内容的数值已更改以及具体数值。控制器更新模型，进而通知文本字段和滑块它们所显示的值已更改。（在这么简单的示例中，控制器实际上并非必需，但在大多数情况下是需要的。）传递信息的机制将在本文后面以及《[绑定如何工作？](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH)》中详细解释，但重要的是要明白，在大多数情况下，你不必编写任何粘合代码。

### 3.2 Binding Options 绑定选项

Many bindings allow you to specify options to customize their behavior. There are three types of option: value transformers, placeholders, and other parameters.

许多绑定允许你指定选项来自定义其行为。有三种类型的选项：值转换器、占位符和其他参数。

A value transformer, as its name implies, applies a transformation to a value. A value transformer may also allow reverse transformations. The Foundation framework provides the abstract NSValueTransformer class and several convenient transformers, including one that negates a value—that is, it turns a Boolean `YES` into `NO` (and vice versa). You can also implement your own transformers.

值转换器，顾名思义，是对值进行转换的工具。值转换器也可以进行反向转换。Foundation 框架提供了抽象的 NSValueTransformer 类和几个便捷的转换器，包括一个用于取反值的转换器——它能将布尔值 `YES` 转换为 `NO`，反之亦然。你也可以实现自己的转换器。

To see how transformers might be useful, suppose that in the previous example the number in the model represents temperature in degrees Fahrenheit, but that you want to display the value in Celsius. You could implement a reversible value transformer that converts values from one scale to the other. If you then specify it as the transformer option for the text field and slider, as shown in Figure 5, the user interface displays the temperature in Celsius, and any new values entered using the slider or text field converted to Fahrenheit.

为了了解转换器的用处，假设在前面的示例中，模型中的数字表示华氏温度，但你希望以摄氏温度显示。你可以实现一个可逆的值转换器，将温度值从一种刻度转换为另一种刻度。然后，如图 5 所示，将其指定为文本字段和滑块的转换器选项，用户界面就会以摄氏温度显示温度，并且通过滑块或文本字段输入的任何新值都会转换为华氏温度。

Figure 5  Displaying temperature using transformers 图 5 使用转换器显示温度

![2-5](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/temperaturetransformers_2x.png)

To learn more about transformers read [Value Transformer Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html#//apple_ref/doc/uid/10000175i) (the article also shows an implementation of the Fahrenheit to Celsius transformer).

要了解更多关于转换器的内容，请阅读《[值转换器编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html#//apple_ref/doc/uid/10000175i)》（该指南还展示了一个华氏温度到摄氏温度转换器的实现）。

Placeholder options allow you to specify what a view should display: if the value of the property to which it is bound is `null` (`nil`); if there is no selection; if there is a multiple selection; or if for some other reason the value is not applicable.

占位符选项允许你指定视图在以下情况应显示的内容：绑定的属性值为 `null`（`nil`）；没有选择项；有多个选择项；或者由于其他原因该值不适用。

In addition to value transformers and placeholders, some bindings offer a variety of other options, such as whether the value of the binding is updated as edits are made to the user interface item, or whether the editable state of a user interface item is automatically configured based on the controller’s selection. For a complete list of all the binding options available, see [Cocoa Bindings Reference](https://developer.apple.com/library/archive/documentation/Cocoa/Reference/CocoaBindingsRef/CocoaBindingsRef.html#//apple_ref/doc/uid/10000189i).

除了值转换器和占位符，一些绑定还提供了各种其他选项，例如绑定的值是否在对用户界面对象进行编辑时更新，或者用户界面对象的可编辑状态是否根据控制器的选择自动配置。有关所有可用绑定选项的完整列表，请参见《[Cocoa 绑定参考](https://developer.apple.com/library/archive/documentation/Cocoa/Reference/CocoaBindingsRef/CocoaBindingsRef.html#//apple_ref/doc/uid/10000189i)》。

### 3.3 Extending the MVC Design Pattern 扩展 MVC 设计模式

The Cocoa bindings architecture extends the traditional Cocoa MVC configuration, where there is a single custom-built controller that manages the user interface. It provides a set of reusable controller classes that inherit from an abstract superclass, NSController. In a bindings-based application there may be several controllers—your own (such as an NSWindowController subclass, managing a document’s user interface) and others that are subclasses of NSController and manage different parts of the user interface. You might also create your own subclasses of the standard Application Kit controller classes—in particular you might subclass NSArrayController to customize sorting and filtering behavior.

Cocoa 绑定架构扩展了传统的 Cocoa MVC 配置，在传统配置中，有一个自定义构建的控制器来管理用户界面。它提供了一组可重用的控制器类，这些类继承自抽象超类 NSController。在基于绑定的应用程序中，可能有多个控制器——你自己的控制器（例如管理文档用户界面的 NSWindowController 子类）和其他属于 NSController 子类并管理用户界面不同部分的控制器。你也可以创建标准 Application Kit 控制器类的自定义子类，特别是可以子类化 NSArrayController 来自定义排序和筛选行为。

Other figures in this document present a convenient shorthand. Although the NSController instance is conceptually bound directly to its model object, in most situations the binding will be “indirect,” to a variable in your document object, as shown in Figure 6.

本文档中的其他图采用了一种简洁的表示法。尽管从概念上讲，NSController 实例直接绑定到其模型对象，但在大多数情况下，绑定是 “间接” 的，绑定到文档对象中的变量，如图 6 所示。

Figure 6  Typical bindings configuration using existing controller 图 6 使用现有控制器的典型绑定配置

![2-6](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/bindings_controller_2x.png)


## 4 Supporting Technologies 支持技术

Cocoa bindings rely primarily on two other technologies, key-value coding (KVC) and key-value observing (KVO). Bindings themselves are established using key-value binding (KVB) as illustrated in Figure 7. In practice you typically need to understand these technologies only if you want to create your own custom view with bindings. If you want to use bindings, the only requirement that is imposed on you is that your model classes must be compliant with key-value coding conventions for any properties to which you want to bind.

Cocoa 绑定主要依赖另外两项技术：键值编码（KVC）和键值观察（KVO）。绑定本身是通过键值绑定（KVB）建立的，如图 7 所示。实际上，通常只有在你想创建自己的带绑定的自定义视图时，才需要了解这些技术。如果只想使用绑定，对你的唯一要求是，对于要绑定的任何属性，你的模型类必须符合键值编码约定。

### 4.1 Key-Value Binding 键值绑定

A binding is established with a `bind:toObject:withKeyPath:options:` message which tells the receiver to keep its specified attribute synchronized—modulo the options—with the value of the property identified by the key path of the specified object. The receiver must watch for relevant changes in the object to which it is bound and react to those changes. The receiver must also inform the object of changes to the bound attribute. After a binding is established there are therefore two aspects to keeping the model and views synchronized: responding to user interaction with views, and responding to changes in model values.

通过 `bind:toObject:withKeyPath:options:` 消息建立绑定，该消息告诉接收者根据选项，使其指定的属性与由指定对象的键路径标识的属性值保持同步。接收者必须监视它所绑定对象的相关变化，并对这些变化做出反应。接收者还必须将绑定属性的变化通知给该对象。因此，建立绑定后，保持模型和视图同步有两个方面：响应用户与视图的交互，以及响应模型值的变化。

Figure 7  Bindings established using key-value binding 图 7 使用键值绑定建立绑定

![2-7](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/key_value_bindings_2x.png)

In a view-initiated update a value changed in the user interface is passed to the controller, which in turn pushes the new value onto the model. To preserve the abstraction required to allow this to work with any controller or model object, the system uses a common access protocol—key-value coding.

在视图发起的更新中，用户界面中更改的值会传递给控制器，控制器再将新值推送到模型。为了保持所需的抽象性（以便能与任何控制器或模型对象一起工作），系统使用一种通用的访问协议——键值编码。

In a model-initiated update models notify controllers, and controllers notify views, of changes to values in which interest has been registered using a common protocol—key-value observing. Note that a model-initiated update can be triggered by direct manipulation of the model—for example by a Scripted Apple event—or as the result of a view-initiated update—a change to the temperature made by editing the Celsius field must be propagated back to the slider.

在模型发起的更新中，模型会通知控制器，控制器会通知视图那些已注册感兴趣的值的变化，这使用的是一种通用协议——键值观察。注意，模型发起的更新可以由对模型的直接操作触发（例如通过脚本化的 Apple 事件），也可以由视图发起的更新触发——通过摄氏温度字段编辑的温度变化必须传播回滑块。

### 4.2 Key-Value Coding 键值编码

Key-value coding is a mechanism whereby you can access a property in an object using the property’s name as a string—the “key.” You can also use key paths to follow relationships between objects. For example, given an `Employee` class with an attribute `firstName`, you could retrieve an employee’s first name using key-value coding with the key `firstName`. If `Employee` has a relationship called “manager” to another Employee, you could retrieve an employee’s manager’s first name using key-value coding with the key path manager.firstName. For more details, see [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i).

键值编码是一种机制，通过这种机制，你可以使用属性的名称（以字符串的形式，即 “键”）访问对象中的属性。你也可以使用键路径来跟踪对象之间的关系。例如，假设有一个 `Employee` 类，它有一个 `firstName` 属性，你可以使用键值编码，通过键 `firstName` 获取员工的名字。如果 `Employee` 与另一个 `Employee` 有一个名为 “manager” 的关系，你可以使用键路径 `manager.firstName`，通过键值编码获取某个员工经理的名字。更多细节请参见《[键值编码编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i)》。

Recall that a binding specifies the key path to a property to which a given attribute is bound. If the value in the slider or the text field is changed, it uses key-value coding—using the key path specified by the binding as the key—to communicate that change directly to the controller, as illustrated in Figure 8. Note that the arrows in this figure represent the direction in which messages are sent and in which information flows. The new value is passed from the user interface widget to the controller, and from the controller to the model.

回想一下，绑定指定了要绑定到的属性的键路径。如果滑块或文本字段中的值发生变化，它会使用键值编码——以绑定指定的键路径作为键——将该变化直接传达给控制器，如图 8 所示。注意，图中的箭头表示消息发送的方向和信息流动的方向。新值从用户界面对象传递到控制器，再从控制器传递到模型。

Figure 8  Using key-value-coding to update values 图 8 使用键值编码更新值

![2-8](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/key_value_coding_2x.png)

### 4.3 Key-Value Observing 键值观察

Key-value observing is a mechanism whereby an object can register with another to be notified of changes to the value of a property. When one object is bound to another object, it registers itself as an observer of the relevant property of that object. In the current example, the text field and slider register as observers of the temperature property of the controller’s content, as illustrated in Figure 9.

键值观察是一种机制，通过这种机制，一个对象可以向另一个对象注册，以接收属性值变化的通知。当一个对象绑定到另一个对象时，它会将自己注册为该对象相关属性的观察者。在当前示例中，文本字段和滑块注册为控制器内容的 `temperature` 属性的观察者，如图 9 所示。

Figure 9  Key-value observing—registering observers 图 9 键值观察——注册观察者

![2-9](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/key_value_observe_register_2x.png)

Note that the arrows shown in Figure 9 indicate direction of observation, not of data flow. Observation is a “passive” process (akin to registering to receive notifications from an NSNotificationCenter). When a value changes, the observed object sends a message to interested observers to notify them, as illustrated in Figure 10. The arrows in Figure 10 show the direction in which messages are sent.

注意，图 9 中显示的箭头表示观察的方向，而不是数据流的方向。观察是一个 “被动” 过程（类似于向 NSNotificationCenter 注册接收通知）。当值发生变化时，被观察的对象会向感兴趣的观察者发送消息以通知它们，如图 10 所示。图 10 中的箭头显示消息发送的方向。

Figure 10  Key-value observing—notification of observers 图 10 键值观察——通知观察者

![2-10](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/key_value_observing_notify_2x.png)

## 5 Why Are NSControllers Useful? 为什么 NSController 很有用？

Bindings can, in principle, be made between almost any two objects, provided that they are KVC-compliant and KVO-compliant. A view could bind directly to a model object. Bindings-based applications, however, use controller objects to manage individual model objects and collections of model objects and to interface to the user preferences system.

原则上，只要两个对象符合 KVC 和 KVO 规范，它们之间几乎可以建立绑定。视图可以直接绑定到模型对象。然而，基于绑定的应用程序使用控制器对象来管理单个模型对象和模型对象集合，并与用户偏好设置系统交互。

It is possible to make bindings directly to your model objects or to controllers that do not inherit from NSController—however you lose (or must reimplement) functionality provided by the Application Kit’s controller objects.

虽然可以直接绑定到模型对象，或者不继承自 NSController 的控制器，但这样会失去（或者必须重新实现）Application Kit 控制器对象提供的功能。

- NSController instances manage their current selection and placeholder values. This allows a view to display an appropriate value if the controller’s selection is null, or if there is a multiple selection.

- NSController 实例管理它们当前选择的项目和占位符值。这允许视图在控制器的选择为空或者存在多个选择时显示适当的值。

- NSController (and Application Kit user interface elements that support binding) implements the NSEditor and NSEditorRegistration protocols. The NSEditorRegistration protocol provides a means for an editor (a view) to inform a controller when it has uncommitted changes. The NSEditor protocol provides a means for requesting that the receiver commit or discard any pending edits.

- NSController（以及支持绑定的 Application Kit 用户界面对象）实现了 NSEditor 和 NSEditorRegistration 协议。NSEditorRegistration 协议提供了一种让编辑器（视图）通知控制器它有未提交的更改的方式。NSEditor 协议提供了一种请求接收者提交或放弃任何未决编辑的方式。
	
	For example, if a user is typing in a text field and then clicks a button, the controller ensures that the model object is updated with the complete contents of the text field before the button action takes place.
	
	例如，如果用户正在文本字段中输入，然后点击了一个按钮，控制器会确保在按钮动作执行之前，模型对象已用文本字段的完整内容更新。

	Although the methods are typically invoked on user interface elements by a controller they can also be sent to a controller, for example in response to a user’s attempt to save a document or quit an application.
	
	尽管这些方法通常由控制器在用户界面对象上调用，但也可以发送给控制器，例如响应用户尝试保存文档或退出应用程序的操作。

### 5.1 NSController Classes NSController类

NSController is an abstract class. Its concrete subclasses are NSObjectController, NSUserDefaultsController, NSArrayController, and NSTreeController. NSObjectController manages a single object and provides the functionality discussed so far. NSUserDefaultsController provides a convenient interface to the preferences system.

NSController 是一个抽象类。它的具体子类有 NSObjectController、NSUserDefaultsController、NSArrayController 和 NSTreeController。NSObjectController 管理单个对象，并提供了到目前为止讨论的功能。NSUserDefaultsController 提供了一个方便的接口来访问偏好设置系统。

NSArrayController and NSTreeController manage collections of model objects and track the current selection. The collection controllers also allow you to add objects to, and remove objects from, the content collection. The objects that the collection controllers manage don’t even have to be in an array—your container can implement suitable methods (“indexed accessor” methods, defined in the NSKeyValueCoding protocol) to present the values to the controller as if they were in an array.

NSArrayController 和 NSTreeController 管理模型对象的集合，并跟踪当前的选择。集合控制器还允许你向内容集合添加对象和从内容集合中移除对象。集合控制器管理的对象甚至不必在数组中——你的容器可以实现适当的方法（《NSKeyValueCoding 协议》中定义的 “索引访问器” 方法），以数组的形式向控制器呈现这些值。

## 6 What Can You Bind? 可以绑定什么？

You can make bindings for most of the Application Kit view classes, such as NSButton and NSTableView. Using an array controller, for example, you can bind the contents of a pop-up menu to objects in an array. The remainder of this article presents an example that is moderately complex. Although the details are intentionally left vague it nevertheless serves to illustrate a number of points, and provides examples of more complex bindings.

你可以为大多数 Application Kit 视图类创建绑定，例如 NSButton 和 NSTableView。例如，使用数组控制器，你可以将弹出菜单的内容绑定到数组中的对象。本文的其余部分将介绍一个中等复杂程度的示例。尽管有意模糊了细节，但它仍然说明了一些要点，并提供了更复杂绑定的示例。

### 6.1 Real-World Example 实际示例

Consider a game application in which the user manages a number of combatants, from which they can select one as an attacker. A combatant can carry three weapons, one of which is selected at any time. In the application, the list of combatants is shown in a table view, the window’s title shows the attacker’s name, and a pop-up menu shows the currently selected weapon, as shown in Figure 11.

考虑一个游戏应用程序，用户可以管理多个战斗人员，并从中选择一个作为攻击者。一个战斗人员可以携带三种武器，任何时候只能选择其中一种。在该应用程序中，战斗人员列表显示在表格视图中，窗口的标题显示攻击者的名字，弹出菜单显示当前选择的武器，如图 11 所示。

Figure 11  User interface for Combatants application 图 11 战斗人员应用程序的用户界面

![2-11](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/combatant_app_2x.png)

Combatants are represented by instances of the Combatant class. In the Combatant class, each weapon is referenced as a separate instance variable, as shown in Figure 12. By implementing suitable “indexed” accessor methods (defined by the key-value coding protocol), however, the Combatant class can allow an array controller to access the weapons as if they were in an array.

战斗人员由 Combatant 类的实例表示。在 Combatant 类中，每种武器作为单独的实例变量引用，如图 12 所示。然而，通过实现适当的 “索引” 访问器方法（由键值编码协议定义），Combatant 类可以允许数组控制器像访问数组中的元素一样访问这些武器。

Figure 12  Combatant class 图 12 Combatant 类

![2-12](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/combatant_class_2x.png)

When the user chooses an attacker from the table view, the window title is updated to reflect the attacker’s name, and the title of the pop-up menu is updated to reflect the attacker’s selected weapon. When the user activates the pop-up its contents are created dynamically from the set of weapons carried by the combatant. When the user selects a menu item, the combatant’s selected weapon is set to that corresponding to that menu item. If a different attacker is selected, the pop-up, selection and window title update accordingly.

当用户从表格视图中选择一个攻击者时，窗口标题会更新以反映攻击者的名字，弹出菜单的标题会更新以反映攻击者当前选择的武器。当用户激活弹出菜单时，其内容会根据战斗人员携带的武器动态创建。当用户选择一个菜单项时，战斗人员的选中武器会被设置为与该菜单项对应的武器。如果选择了不同的攻击者，弹出菜单、选择和窗口标题都会相应更新。

Figure 13 illustrates how the user interface of the Combatants application can be implemented using bindings. The table view is bound to an array controller that manages an array of combatants. The window title is bound to the name of the selected combatant. The pop-up menu retrieves its list of items from an array controller bound to the attacker’s weapons “array,” and its selection is bound to the attacker’s selected weapon.

图 13 说明了如何使用绑定实现战斗人员应用程序的用户界面。表格视图绑定到一个管理战斗人员数组的数组控制器。窗口标题绑定到所选战斗人员的名字。弹出菜单从一个绑定到攻击者武器 “数组” 的数组控制器中获取其菜单项列表，其选择绑定到攻击者的选中武器。

Figure 13  Combatants application managed by bindings 图 13 由绑定管理的战斗人员应用程序


![2-13](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/art/combatants_bindings_2x.png)

This example illustrates a number of points:

这个示例说明了几个要点：

- In an application you can use more than one controller object.
- Different aspects of a user interface element may be bound to different controllers.
- You can use your own custom model classes.

- 在一个应用程序中可以使用多个控制器对象。
- 用户界面对象的不同方面可以绑定到不同的控制器。
- 可以使用自己的自定义模型类。

Finally, it should be emphasized that the example requires no actual code to set up the user interface—the controllers and bindings can all be created in Interface Builder. This represents a considerable reduction in programming effort compared with the traditional target-action based approach.

最后需要强调的是，设置这个示例的用户界面不需要实际编写任何代码——所有控制器和绑定都可以在 Interface Builder 中创建。与传统的基于目标-动作的方法相比，这大大减少了编程工作量。




















