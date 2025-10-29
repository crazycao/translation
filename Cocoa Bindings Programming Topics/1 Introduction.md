# Introduction to Cocoa Bindings Programming Topics Cocoa 绑定编程主题介绍

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/CocoaBindings.html](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/CocoaBindings.html)

Cocoa bindings is a collection of technologies you can use in your applications to fully implement a Model-View-Controller paradigm where models encapsulate application data, views display and edit that data, and controllers mediate between the two. Cocoa bindings reduces the code dependencies between models, views and controllers, supports multiple ways of viewing your data, and automatically synchronizes views when models change. Cocoa bindings provides extensible controllers, protocols for models and views to adopt, and additions to classes in Foundation and the Application Kit. You can eliminate most of your glue code by using bindings available in Interface Builder to connect controllers with models and views.

Cocoa 绑定是一组可在应用程序中使用的技术，借助它可以全面实现模型-视图-控制器（Model-View-Controller）范式 —— 其中，模型封装应用程序数据，视图显示和编辑这些数据，控制器则在两者之间起到中介作用。Cocoa 绑定减少了模型、视图和控制器之间的代码依赖，支持以多种方式查看数据，并且能在模型发生变化时自动同步视图。它提供了可扩展的控制器、供模型和视图遵循的协议，以及对 Foundation 和 Application Kit 中类的扩展。通过使用 Interface Builder 中可用的绑定功能来连接控制器与模型、视图，你可以省去大部分粘合代码。

## 1 Who Should Read This Document 谁应该阅读本文档

Cocoa bindings is ideal for developers writing new applications who have some familiarity with Cocoa, and for developers of existing applications who want to simply clean up or eliminate their existing glue code. In most cases, Cocoa bindings can be used to replace traditional Cocoa mechanisms such as target-action, delegation, and some data source protocols. However, great care has been taken to ensure that both approaches can be used side by side within the same application.

Cocoa 绑定非常适合两类开发者：一是编写新应用程序且对 Cocoa 有一定了解的开发者；二是希望简化、清理现有应用程序中 “粘合代码” 或彻底移除这些代码的开发者。在大多数情况下，Cocoa 绑定可用于替代传统的 Cocoa 机制，例如目标-动作（target-action）、委托（delegation）以及部分数据源协议。不过，经过精心设计，这两种方式能够在同一应用程序中并存使用。

This document assumes that you have read [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i), [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) and [Value Transformer Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html#//apple_ref/doc/uid/10000175i).

本文档假定你已阅读《[键值编码编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i)》《[键值观察编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i)》和《[值转换器编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html#//apple_ref/doc/uid/10000175i)》。

> **Important:** Cocoa bindings is available to Cocoa Objective-C applications running OS X version 10.3 and later.
> 
> **重要提示：**Cocoa 绑定适用于运行 OS X 10.3 及更高版本的 Cocoa Objective-C 应用程序。


## 2 Organization of This Document 本文档的组织结构

The following articles cover key concepts in understanding how Cocoa bindings works:

以下文章涵盖了理解 Cocoa 绑定工作原理的关键概念：

- What Are Cocoa Bindings? describes the advantages that Cocoa bindings offers developers; provides a brief summary of how they work; and what design patterns you should use to adopt the technology.
- 《什么是 Cocoa 绑定？》阐述了 Cocoa 绑定为开发者带来的优势，简要概述了其工作方式，以及采用该技术时应使用的设计模式。
- How Do Bindings Work? describes in detail the technologies supporting Cocoa bindings and how they interact.
- 《绑定如何工作？》详细介绍了支持 Cocoa 绑定的技术及其交互方式。
- User Defaults and Bindings describes the role of the NSUserDefaultsController and how it works with NSUserDefaults.
- 《用户默认设置与绑定》说明了 NSUserDefaultsController 的作用以及它如何与 NSUserDefaults 协同工作。
- Providing Controller Content describes how to set and modify the content of NSObjectController and its subclasses.
- 《提供控制器内容》介绍了如何设置和修改 NSObjectController 及其子类的内容。
- Working With a Controller’s Selection describes how to get a controller’s selection and change the current selection.
- 《处理控制器的选择项》讲解了如何获取控制器的选择项以及更改当前选择项。
- Bindings Message Flow illustrates the flow of messages between model, view and controller objects in a bindings application.
- 《绑定消息流》展示了在使用绑定的应用程序中，模型、视图和控制器对象之间的消息传递流程。

These articles contain tasks that teach you how to use Cocoa bindings:

这些文章包含指导你使用 Cocoa 绑定的实践任务：

- Creating a Master-Detail Interface explains how to implement a basic master-detail interface where a table view is used in the master interface to display a collection of objects, and other views used in the detail interface to display the selected object in the collection.
- 《创建主-从界面》解释了如何实现基本的主 - 从界面，其中主界面使用表格视图显示一组对象，从界面使用其他视图显示该组中被选中的对象
- Displaying Images Using Bindings describes the various options when displaying images in columns and contains an example of a custom value transformer.
- 《使用绑定显示图像》描述了在列中显示图像时的各种选项，并包含一个自定义值转换器的示例。
- Implementing To-One Relationships Using Pop-Up Menus explains how to implement editable to-one relationship as pop-up menus.
- 《使用弹出菜单实现一对一关系》说明了如何将可编辑的一对一关系实现为弹出菜单。
- Filtering Using a Custom Array Controller explains how to add a search field to the master interface to filter the objects it displays.
- 《使用自定义数组控制器进行筛选》介绍了如何在主界面添加搜索字段以筛选其显示的对象。
- Controller Key-Value Observing Compliance details the properties for which the controller classes provide key-value observing change notifications.
- 《控制器键值观察合规性》详细说明了控制器类会为哪些属性提供键值观察变更通知。
- Troubleshooting Cocoa Bindings describes a number of common problems encountered with Cocoa bindings applications and provides methods for correcting the issues.
- 《Cocoa 绑定故障排除》列举了使用 Cocoa 绑定的应用程序中常见的一些问题，并提供了解决这些问题的方法。

## 3 See Also 其他参阅

There are other technologies, not fully covered in this topic, that are fundamental to how bindings work. You may want to read these topics if you want a better understanding of the underpinnings of Cocoa bindings, or if you want to use these technologies independent from bindings. For example, this topic does not explain how to use the methods defined in the key-value observing protocol. Refer to these documents for more details:

- Developing Cocoa Applications Using Bindings: A Tutorial takes you through the steps of building the familiar Currency Converter application using Cocoa bindings.
- Cocoa Bindings Reference enumerates the classes that support Cocoa bindings and provides descriptions of the bindings for each class, along with the supported options and placeholders.
- Key-Value Coding Programming Guide covers all the features of the key-value coding protocol that allows objects to indirectly access the properties of other objects.
- Key-Value Observing Programming Guide covers all the features of the key-value observing protocol that allows objects to observe changes in other objects.
- Value Transformer Programming Guide describes how to use value transformers to convert values from one type to another.
- Sort Descriptor Programming Topics describes how to use sort descriptors that specify how collections are sorted.