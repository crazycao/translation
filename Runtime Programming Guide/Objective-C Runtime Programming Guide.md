[Objective-C Runtime Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048-CH1-SW1)

# [Objective-C 运行时编程指南](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008048-CH1-SW1)

#0 Introduction 简介

The Objective-C language defers as many decisions as it can from compile time and link time to runtime. Whenever possible, it does things dynamically. This means that the language requires not just a compiler, but also a runtime system to execute the compiled code. The runtime system acts as a kind of operating system for the Objective-C language; it’s what makes the language work.

Objective-C语言尽可能的将许多决策从编译时和连接时延迟到运行时。只要可能，它就动态的完成工作。这意味着这种语言不仅仅需要一个编译器，还需要一个运行时系统执行已编译的代码。运行时系统对于Objective-C语言而言仿佛一种操作系统；它就是让语言工作的系统。

This document looks at the *NSObject* class and how Objective-C programs interact with the runtime system. In particular, it examines the paradigms for dynamically loading new classes at runtime, and forwarding messages to other objects. It also provides information about how you can find information about objects while your program is running.

本文关注*NSObject*类以及Objective-C程序如何与运行时系统交互。特别的，本文还特别提供了在运行时动态加载新类的和传递消息到其他对象的范例。本文也提供了管你如何在程序运行时找到对象信息的方法。

You should read this document to gain an understanding of how the Objective-C runtime system works and how you can take advantage of it. Typically, though, there should be little reason for you to need to know and understand this material to write a Cocoa application.

你阅读本文，可以获得Objective-C系统如何工作的理解，以及如何利用它。然而，一般情况下，写一个Cocoa应用并不是需要知道和理解这些材料。

##0.1 Organization of This Document 本文的结构

This document has the following chapters:

本文分为以下章节：

* [Runtime Versions and Platforms](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtVersionsPlatforms.html#//apple_ref/doc/uid/TP40008048-CH106-SW1)
* [Interacting with the Runtime](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtInteracting.html#//apple_ref/doc/uid/TP40008048-CH103-SW1)
* [Messaging](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtHowMessagingWorks.html#//apple_ref/doc/uid/TP40008048-CH104-SW1)
* [Dynamic Method Resolution](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtDynamicResolution.html#//apple_ref/doc/uid/TP40008048-CH102-SW1)
* [Message Forwarding](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtForwarding.html#//apple_ref/doc/uid/TP40008048-CH105-SW1)
* [Type Encodings](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1)
* [Declared Properties](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW1)

##0.2  See Also 其他参考

*[Objective-C Runtime Reference](https://developer.apple.com/reference/objectivec/1657527-objective_c_runtime)* describes the data structures and functions of the Objective-C runtime support library. Your programs can use these interfaces to interact with the Objective-C runtime system. For example, you can add classes or methods, or obtain a list of all class definitions for loaded classes.

*[Programming with Objective-C](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210)* describes the Objective-C language.

*[Objective-C Release Notes](https://developer.apple.com/library/content/releasenotes/Cocoa/RN-ObjectiveC/index.html#//apple_ref/doc/uid/TP40004309)* describes some of the changes in the Objective-C runtime in recent releases of OS X.

*[Objective-C Runtime Reference](https://developer.apple.com/reference/objectivec/1657527-objective_c_runtime)* 介绍了Objective-C运行时支持库的数据结构和方法。你的程序可以使用这些接口与Objective-C运行时系统交互。例如，你可以添加类或方法，或获得已加载类的所有类定义列表。

*[Programming with Objective-C](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210)* 介绍了Objective-C语言。

*[Objective-C Release Notes](https://developer.apple.com/library/content/releasenotes/Cocoa/RN-ObjectiveC/index.html#//apple_ref/doc/uid/TP40004309)* 介绍了OS X近期版本中关于Objective-C运行时部分的改动。

#1 Runtime Versions and Platforms Runtime版本和平台

There are different versions of the Objective-C runtime on different platforms.

在不同的平台上有着不同的Objective-C运行时版本。

##1.1 Legacy and Modern Versions 过去的和当前的版本

There are two versions of the Objective-C runtime—“modern” and “legacy”. The modern version was introduced with Objective-C 2.0 and includes a number of new features. The programming interface for the legacy version of the runtime is described in *Objective-C 1 Runtime Reference*; the programming interface for the modern version of the runtime is described in *[Objective-C Runtime Reference](https://developer.apple.com/reference/objectivec/1657527-objective_c_runtime)*.

Objective-C运行时有两个版本——“当前版”和“过去版”。当前版随着Objective-2.0引入，包含了许多新特性。运行时的过去版的编程接口在 *Objective-C 1 Runtime Reference* 中有介绍；运行时的当前版的编程接口在 *[Objective-C Runtime Reference](https://developer.apple.com/reference/objectivec/1657527-objective_c_runtime)* 中介绍。

The most notable new feature is that instance variables in the modern runtime are “non-fragile”:

最显著的新特性就是在当前版运行时中实例变量是“不会破碎的”：

* In the legacy runtime, if you change the layout of instance variables in a class, you must recompile classes that inherit from it.
* In the modern runtime, if you change the layout of instance variables in a class, you do not have to recompile classes that inherit from it.
* 在过去的运行时中，如果你在类中改动了实例变量的布局，你必须重编译继承它的所有类。
* 在当前的运行时中，如果你在类中改动了实例变量的布局，你不必重编译继承它的所有类。

In addition, the modern runtime supports instance variable synthesis for declared properties (see Declared Properties in *The Objective-C Programming Language*).

另外，当前的运行时支持已声明属性的实例变量组合（参见《 *The Objective-C Programming Language* 》的《Declared Properties》一节）。

##1.2 Platforms 平台

iPhone applications and 64-bit programs on OS X v10.5 and later use the modern version of the runtime.

Other programs (32-bit programs on OS X desktop) use the legacy version of the runtime.

iPhone应用和在OS X v10.5及以后版本的64位程序使用运行时的当前版本。

其他程序（OS X桌面的32位程序）使用运行时的过去版本。

#2 Interacting with the Runtime 与Runtime交互

Objective-C programs interact with the runtime system at three distinct levels: through Objective-C source code; through methods defined in the *NSObject* class of the Foundation framework; and through direct calls to runtime functions.

Objective-C程序与运行时系统在三个明显不同的层次进行交互：通过Objective-C源代码；通过定义在Foundation框架里的 *NSObject* 类中的方法；通过直接调用运行时方法。

##2.1 Objective-C Source Code Objective-C源码

For the most part, the runtime system works automatically and behind the scenes. You use it just by writing and compiling Objective-C source code.

在大多数情况下，运行时系统都在幕后自动工作。你仅通过撰写和编译Objective-C源代码使用到它。

When you compile code containing Objective-C classes and methods, the compiler creates the data structures and function calls that implement the dynamic characteristics of the language. The data structures capture information found in class and category definitions and in protocol declarations; they include the class and protocol objects discussed in Defining a Class and Protocols in *The Objective-C Programming Language*, as well as method selectors, instance variable templates, and other information distilled from source code. The principal runtime function is the one that sends messages, as described in [Messaging](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtHowMessagingWorks.html#//apple_ref/doc/uid/TP40008048-CH104-SW1). It’s invoked by source-code message expressions.

当你编译包含Objective-C类和方法的代码时，编译器创建数据结构和方法调用，实现语言的动态特性。数据结构捕获的相关信息可以在类和类别定义及协议声明中找到；在《*The Objective-C Programming Language*》 的《Defining a Class and Protocols》一章中论述了类和协议对象，以及方法选择器、实例变量模板和其他从源码中提取的信息。最重要的运行时方法是发送消息，称为[Messaging](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtHowMessagingWorks.html#//apple_ref/doc/uid/TP40008048-CH104-SW1)。它被源码消息表达式引用。

##2.2 NSObject Methods NSObject方法

Most objects in Cocoa are subclasses of the *NSObject* class, so most objects inherit the methods it defines. (The notable exception is the *NSProxy* class; see Message Forwarding for more information.) Its methods therefore establish behaviors that are inherent to every instance and every class object. However, in a few cases, the *NSObject* class merely defines a template for how something should be done; it doesn’t provide all the necessary code itself.

Cocoa中大部分对象都是*NSObject*类的子类，因此大部分对象继承了它定义的方法。（值得关注的例外是*NSProxy*类；更多信息参见Message Forwarding章节。）所以它的方法确立起了每个实例和每个类对象的内在行为。但是，在少数情况下，*NSObject*类只是定义了某些事情应该如何做的模板；它并没有提供它所需要的所有代码。

For example, the *NSObject* class defines a *description* instance method that returns a string describing the contents of the class. This is primarily used for debugging—the GDB *print-object* command prints the string returned from this method. *NSObject*’s implementation of this method doesn’t know what the class contains, so it returns a string with the name and address of the object. Subclasses of *NSObject* can implement this method to return more details. For example, the Foundation class *NSArray* returns a list of descriptions of the objects it contains.

例如，*NSObject*类定义了*description*实例方法，返回类内容的字符串描述。这个方法主要用于调试——GDB *print-object* 命令会打印这个方法返回的字符串。*NSObject*这个方法的实现并不知道这个类包含了什么，所以它返回了这个对象的地址和名称。*NSObject*的子类可以实现这个方法返回更多的详情。例如Foundation类的*NSArray*返回它包含的对象的描述列表。

Some of the *NSObject* methods simply query the runtime system for information. These methods allow objects to perform introspection. Examples of such methods are the *class* method, which asks an object to identify its class; *isKindOfClass:* and *isMemberOfClass:*, which test an object’s position in the inheritance hierarchy; *respondsToSelector:*, which indicates whether an object can accept a particular message; *conformsToProtocol:*, which indicates whether an object claims to implement the methods defined in a specific protocol; and *methodForSelector:*, which provides the address of a method’s implementation. Methods like these give an object the ability to introspect about itself.

某些 *NSObject* 方法简单的向运行时系统查询信息。这些方法允许对象做出反馈。这些方法的例子是 *class* 方法，会让对象定义自己的类；*isKindOfClass:* 和 *isMemberOfClass:* ，这两个方法可以测试对象在继承层级中的位置；*respondsToSelector:* ，这个方法可以指出一个对象是否可以接受一个特定的消息；*conformsToProtocol:* ，这个方法可以指出一个对象是否声明实现了某个特殊协议定义的方法； *methodForSelector:* ，这个方法提供了某个方法实现的地址。像这些方法给予对象内省其自身的能力。

##2.3 Runtime Functions Runtime方法

The runtime system is a dynamic shared library with a public interface consisting of a set of functions and data structures in the header files located within the directory */usr/include/objc*. Many of these functions allow you to use plain C to replicate what the compiler does when you write Objective-C code. Others form the basis for functionality exported through the methods of the *NSObject* class. These functions make it possible to develop other interfaces to the runtime system and produce tools that augment the development environment; they’re not needed when programming in Objective-C. However, a few of the runtime functions might on occasion be useful when writing an Objective-C program. All of these functions are documented in *[Objective-C Runtime Reference](https://developer.apple.com/reference/objectivec/1657527-objective_c_runtime)*.

运行时系统是一个带有公共接口的动态共享库，由一系列函数和数据结构组成，头文件放置在*/usr/include/objc*目录下。这些方法中许多允许你使用纯C语言重新获得在你编写Objective-C代码时编译器完成的工作。其他的方法成为了通过*NSObject*类方法出口的功能的基础。这些函数使得为运行时系统开发其他接口和制作增加开发环境的工具成为可能；而在用Objective-C编程时并不需要它们。但是，也有少数运行时方法可能在写Objective-C程序时偶尔有用。所有的这些方法都写在了《*[Objective-C Runtime Reference](https://developer.apple.com/reference/objectivec/1657527-objective_c_runtime)*》之中。

#3 Messaging 消息通信

This chapter describes how the message expressions are converted into *[objc_msgSend](https://developer.apple.com/reference/objectivec/1456712-objc_msgsend)* function calls, and how you can refer to methods by name. It then explains how you can take advantage of *objc_msgSend*, and how—if you need to—you can circumvent dynamic binding.

本章介绍了消息表达式如何转化为*[objc_msgSend](https://developer.apple.com/reference/objectivec/1456712-objc_msgsend)*函数调用，以及如何通过名称引用方法。然后解释了如何利用*objc_msgSend*，以及如何——如果需要这么做——能够绕开动态绑定。

##3.1 The objc_msgSend Function objc_msgSend方法

In Objective-C, messages aren’t bound to method implementations until runtime. The compiler converts a message expression,

	[receiver message]	
into a call on a messaging function, *[objc_msgSend](https://developer.apple.com/reference/objectivec/1456712-objc_msgsend)*. This function takes the receiver and the name of the method mentioned in the message—that is, the method selector—as its two principal parameters:

	objc_msgSend(receiver, selector)
Any arguments passed in the message are also handed to *[objc_msgSend](https://developer.apple.com/reference/objectivec/1456712-objc_msgsend)*:

	objc_msgSend(receiver, selector, arg1, arg2, ...)
在Objective-C中，消息直到运行时才会与方法实现绑定到一起。编译器会将一个消息表达式

```
[receiver message]	
```

转为消息方法的调用，*[objc_msgSend](https://developer.apple.com/reference/objectivec/1456712-objc_msgsend)*。这个函数将接收者和消息中提到的方法名称——也就是方法选择器——作为它的两个主要参数：

```
objc_msgSend(receiver, selector)
```

消息中传递的任意参数也可以由*[objc_msgSend](https://developer.apple.com/reference/objectivec/1456712-objc_msgsend)*处理：

```
objc_msgSend(receiver, selector, arg1, arg2, ...)
```

The messaging function does everything necessary for dynamic binding:

* It first finds the procedure (method implementation) that the selector refers to. Since the same method can be implemented differently by separate classes, the precise procedure that it finds depends on the class of the receiver.
* It then calls the procedure, passing it the receiving object (a pointer to its data), along with any arguments that were specified for the method.
* Finally, it passes on the return value of the procedure as its own return value.

>**Note:** The compiler generates calls to the messaging function. You should never call it directly in the code you write.

消息方法完成了动态绑定所需要的每一件事情:

- 它首先找到选择器所指的过程（方法实现）。由于同一个方法可以由不同的类来实现，它找到的精确过程取决于接收者的类。
- 然后，它调用这个过程，将接收对象（的数据指针）和为该方法指定的所有参数传递给这个过程。
- 最后，它将这个过程的返回值作为它自己的返回值传递过来。

> **注意：** 编译器生成对消息函数的调用。你永远不要在你写的代码中直接调用它。

The key to messaging lies in the structures that the compiler builds for each class and object. Every class structure includes these two essential elements:

* A pointer to the superclass.
* A class *dispatch table*. This table has entries that associate method selectors with the class-specific addresses of the methods they identify. The selector for the *setOrigin::* method is associated with the address of (the procedure that implements) *setOrigin::*, the selector for the *display* method is associated with *display*’s address, and so on.

When a new object is created, memory for it is allocated, and its instance variables are initialized. First among the object’s variables is a pointer to its class structure. This pointer, called *isa*, gives the object access to its class and, through the class, to all the classes it inherits from.

消息通信的关键在于编译器为每个类和对象构建的结构 。每个类结构包括下面两个基本元素：

* 父类的指针。

* 一个 *dispatch table* 。这个表的每一个条目都关联了方法选择器和每个类不同的辨识方法的具体地址。比如， *setOrigin::* 方法的选择关联到 *setOrigin::*（程序实现）的地址， *display* 方法的选择器关联到 *display* 的地址，等等。

当创建一个新的对象，为它分配了内存，它的实例变量也初始化了。对象的第一个变量就是其类结构的指针。这个指针，被称为“*isa*”，让对象可以访问它的类，以及通过这个类访问它继承的所有类。

>**Note:** While not strictly a part of the language, the *isa* pointer is required for an object to work with the Objective-C runtime system. An object needs to be “equivalent” to a *struct objc_object* (defined in *objc/objc.h*) in whatever fields the structure defines. However, you rarely, if ever, need to create your own root object, and objects that inherit from *NSObject* or *NSProxy* automatically have the *isa* variable.
>These elements of class and object structure are illustrated in Figure 3-1.

>**注意：** 虽然语法上不是严格要求，但是对象 *isa* 指针需要与Objective-C运行时系统共同工作。在这个结构定义的任何字段中，对象都需要“等价于”一个 *struct objc_object* （定义在 *objc/objc.h* 中）。然而，你几乎不会，如果真有，需要创建你自己的根对象，继承自 *NSObject* 或 *NSProxy* 的对象自动拥有了 *isa* 变量。

These elements of class and object structure are illustrated in Figure 3-1.

类和对象结构的元素图示见图3-1。

Figure 3-1  Messaging Framework

![Messaging Framework](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Art/messaging1.gif)

When a message is sent to an object, the messaging function follows the object’s *isa* pointer to the class structure where it looks up the method selector in the dispatch table. If it can’t find the selector there, *objc_msgSend* follows the pointer to the superclass and tries to find the selector in its dispatch table. Successive failures cause *objc_msgSend* to climb the class hierarchy until it reaches the *NSObject* class. Once it locates the selector, the function calls the method entered in the table and passes it the receiving object’s data structure.

当消息被发送到一个对象时，消息通信方法按照对象的 *isa* 指针找到类结构，并在dispatch表中查找方法选择器。如果没有在那里找到选择器，*objc_msgSend*按照指针找到父类，并尝试在父类的dispatch表中找到选择器。连续的失败会导致*objc_msgSend*方法按类的层级一层层往上找，直到到达*NSObject*类。一旦它定位到选择器，这个函数会调用表中的方法，并向其传递接收对象的数据结构。

This is the way that method implementations are chosen at runtime—or, in the jargon of object-oriented programming, that methods are dynamically bound to messages.

这是在运行时选择方法实现的途径——或者，按照面向对象编程的术语，这叫做方法与消息动态绑定。

To speed the messaging process, the runtime system caches the selectors and addresses of methods as they are used. There’s a separate cache for each class, and it can contain selectors for inherited methods as well as for methods defined in the class. Before searching the dispatch tables, the messaging routine first checks the cache of the receiving object’s class (on the theory that a method that was used once may likely be used again). If the method selector is in the cache, messaging is only slightly slower than a function call. Once a program has been running long enough to “warm up” its caches, almost all the messages it sends find a cached method. Caches grow dynamically to accommodate new messages as the program runs.

为了加快消息传递的速度，运行时系统缓存了使用过的选择器和方法地址。每个类有自己单独的缓存空间，可以包含继承的方法的选择器和类里面定义的方法的选择器。在查找dispatch表之前，消息通信通常首先会检查接受对象的类的缓存空间(理论上用过一次的方法很可能再次使用)。如果方法选择器在缓存中，消息通信只是比方法调用稍微慢一点点。一旦程序运行了足够长的时间让它的缓存“热”起来，几乎所有她发送的消息对可以找到一个缓存的方法。在程序运行时，缓存会动态的适应新的消息通信。

##3.2 Using Hidden Arguments 使用隐藏的参数

When *objc_msgSend* finds the procedure that implements a method, it calls the procedure and passes it all the arguments in the message. It also passes the procedure two hidden arguments:

* The receiving object
* The selector for the method

当*objc_msgSend*找到实现方法的程序，它就会调用这段程序并将消息中的所有参数传给它。它还会传递两个隐藏的参数：

- 接收的对象
- 方法的选择器

These arguments give every method implementation explicit information about the two halves of the message expression that invoked it. They’re said to be “hidden” because they aren’t declared in the source code that defines the method. They’re inserted into the implementation when the code is compiled.

这些参数给予每个方法实现关于调用它的消息表达式的两个准确的信息。它们被称为“隐藏的”是因为它们没有在定义方法的源代码中声明。它们是在代码编译时插入到实现中的。

Although these arguments aren’t explicitly declared, source code can still refer to them (just as it can refer to the receiving object’s instance variables). A method refers to the receiving object as *self*, and to its own selector as *\_cmd*. In the example below, *\_cmd* refers to the selector for the *strange* method and *self* to the object that receives a strange message.

尽管这些参数没有明确的声明，源代码仍然能引用它们（正如它可以引用接收对象的实例变量）。一个方法认为接收对象是*self*，它自己的选择器是*\_cmd*。在下面的例子中，*\_cmd*指的是*strange*方法的选择器，而*self*是接收特定消息的对象。

	- strange
	{
	    id  target = getTheReceiver();
	    SEL method = getTheMethod();
	 
	    if ( target == self || method == _cmd )
	        return nil;
	    return [target performSelector:method];
	}
*self* is the more useful of the two arguments. It is, in fact, the way the receiving object’s instance variables are made available to the method definition.

*self*在两个参数中更有用。实际上，这正是接收对象的实例变量对于消息定义可用的方法。

##3.3 Getting a Method Address 获取方法地址

The only way to circumvent dynamic binding is to get the address of a method and call it directly as if it were a function. This might be appropriate on the rare occasions when a particular method will be performed many times in succession and you want to avoid the overhead of messaging each time the method is performed.

规避动态绑定的的唯一方法是，获得方法的地址并且如果这是一个函数就直接调用它。在少数的情况下，当特定方法被连续执行了许多次时，而你想要避免每次方法执行都有消息通信的开销，这么做是合适的。

With a method defined in the *NSObject* class, *methodForSelector:*, you can ask for a pointer to the procedure that implements a method, then use the pointer to call the procedure. The pointer that *methodForSelector:* returns must be carefully cast to the proper function type. Both return and argument types should be included in the cast.

通过*NSObject*类中定义的方法，*methodForSelector:*，你可以请求到指向实现方法的程序的指针，然后使用这个指针调用这段程序。 *methodForSelector:*返回的指针必须小心的描述为适当的函数类型。返回类型和参数类型都应该包含在描述中。

The example below shows how the procedure that implements the *setFilled:* method might be called:

下面的例子展示了如何调用实现了 *setFilled:* 方法的程序：

	void (*setter)(id, SEL, BOOL);
	int i;
	 
	setter = (void (*)(id, SEL, BOOL))[target
	    methodForSelector:@selector(setFilled:)];
	for ( i = 0 ; i < 1000 ; i++ )
	    setter(targetList[i], @selector(setFilled:), YES);
The first two arguments passed to the procedure are the receiving object (*self*) and the method selector (*\_cmd*). These arguments are hidden in method syntax but must be made explicit when the method is called as a function.

传给程序的前两个参数是接收对象(*self*)和方法选择器(*\_cmd*)。这些参数在方法语法中是隐藏的，但是当方法作为一个函数被调用时必须明确的给出。

Using *methodForSelector:* to circumvent dynamic binding saves most of the time required by messaging. However, the savings will be significant only where a particular message is repeated many times, as in the *for* loop shown above.

使用 *methodForSelector:* 规避动态绑定节约了大部分消息通信所需的时间。然而，这个节约只在特定方法被重复多次调用时是有意义的，如上面展示的*for*循环中。

Note that *methodForSelector:* is provided by the Cocoa runtime system; it’s not a feature of the Objective-C language itself.

注意 *methodForSelector:* 是由Cocoa运行时系统提供的；它并不是Objective-C语言自身的特性。

#4 Dynamic Method Resolution 动态方法解析

This chapter describes how you can provide an implementation of a method dynamically.

本章介绍了如何动态的提供一个方法的实现。

##4.1 Dynamic Method Resolution 动态方法解析

There are situations where you might want to provide an implementation of a method dynamically. For example, the Objective-C declared properties feature (see Declared Properties in *The Objective-C Programming Language*) includes the *@dynamic* directive:

有时候，你可能想要动态的提供一个方法的实现。例如，Objective-C声明属性特征（参见《*The Objective-C Programming Language*》中的《Declared Properties》）包含了*@dynamic* 指令：

	@dynamic propertyName;
which tells the compiler that the methods associated with the property will be provided dynamically.

这告诉编译器关联到这个属性的方法将会动态的提供。

You can implement the methods *[resolveInstanceMethod:](https://developer.apple.com/reference/objectivec/nsobject/1418500-resolveinstancemethod)* and *[resolveClassMethod:](https://developer.apple.com/reference/objectivec/nsobject/1418889-resolveclassmethod)* to dynamically provide an implementation for a given selector for an instance and class method respectively.

你可以实现 *[resolveInstanceMethod:](https://developer.apple.com/reference/objectivec/nsobject/1418500-resolveinstancemethod)* 和 *[resolveClassMethod:](https://developer.apple.com/reference/objectivec/nsobject/1418889-resolveclassmethod)* 这两个方法分别动态的向给出的选择器提供实例方法和类方法。

An Objective-C method is simply a C function that take at least two arguments—*self* and *\_cmd*. You can add a function to a class as a method using the function *[class_addMethod](https://developer.apple.com/reference/objectivec/1418901-class_addmethod)*. Therefore, given the following function:

一个Objective-C方法可以简单的看作是一个带有至少两个参数—— *self* 和 *\_cmd*——的C函数。你可以使用 *[class_addMethod](https://developer.apple.com/reference/objectivec/1418901-class_addmethod)* 函数添加一个函数到一个类作为其方法。因此，给出以下函数：

	void dynamicMethodIMP(id self, SEL _cmd) {
	    // implementation ....
	}
you can dynamically add it to a class as a method (called *resolveThisMethodDynamically*) using *resolveInstanceMethod:* like this:

你可以使用 *resolveInstanceMethod:* 动态的将其添加到类中作为一个（名叫*resolveThisMethodDynamically*的）方法，如下：

	@implementation MyClass
	+ (BOOL)resolveInstanceMethod:(SEL)aSEL
	{
	    if (aSEL == @selector(resolveThisMethodDynamically)) {
	          class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
	          return YES;
	    }
	    return [super resolveInstanceMethod:aSEL];
	}
	@end
Forwarding methods (as described in *[Message Forwarding](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtForwarding.html#//apple_ref/doc/uid/TP40008048-CH105-SW1)*) and dynamic method resolution are, largely, orthogonal. A class has the opportunity to dynamically resolve a method before the forwarding mechanism kicks in. If *[respondsToSelector:](https://developer.apple.com/reference/objectivec/nsobjectprotocol/1418583-responds)* or *[instancesRespondToSelector:](https://developer.apple.com/reference/objectivec/nsobject/1418555-instancesrespondtoselector)* is invoked, the dynamic method resolver is given the opportunity to provide an *IMP* for the selector first. If you implement *[resolveInstanceMethod:](https://developer.apple.com/reference/objectivec/nsobject/1418500-resolveinstancemethod)* but want particular selectors to actually be forwarded via the forwarding mechanism, you return *NO* for those selectors.

消息转发（见《 *[Message Forwarding](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtForwarding.html#//apple_ref/doc/uid/TP40008048-CH105-SW1)* 》）和动态方法解析很大程度上是正交的。一个类有机会在进入转发机制之前动态的解析一个方法。如果调用了 *[respondsToSelector:](https://developer.apple.com/reference/objectivec/nsobjectprotocol/1418583-responds)* 或 *[instancesRespondToSelector:](https://developer.apple.com/reference/objectivec/nsobject/1418555-instancesrespondtoselector)* ，动态方法解析器就得到一个机会先提供为选择器提供一个 *IMP* 。如果你实现了 *[resolveInstanceMethod:](https://developer.apple.com/reference/objectivec/nsobject/1418500-resolveinstancemethod)* ，但是想要某些特别的选择器实际上通过转发机制转发，你只需要对这些选择器返回 *NO* 。

##4.2 Dynamic Loading 动态加载

An Objective-C program can load and link new classes and categories while it’s running. The new code is incorporated into the program and treated identically to classes and categories loaded at the start.

Objective-C程序可以在运行时加载和连接新的类和分类。新的代码被合并到程序中，并且与开始时加载的类和类别同样的处理。

Dynamic loading can be used to do a lot of different things. For example, the various modules in the System Preferences application are dynamically loaded.

动态加载可以用于完成许多不同的工作。例如，系统偏好应用中的各种各样的模块都是动态加载的。

In the Cocoa environment, dynamic loading is commonly used to allow applications to be customized. Others can write modules that your program loads at runtime—much as Interface Builder loads custom palettes and the OS X System Preferences application loads custom preference modules. The loadable modules extend what your application can do. They contribute to it in ways that you permit but could not have anticipated or defined yourself. You provide the framework, but others provide the code.

在Cocoa环境中，动态加载通常允许应用被自定义。其他人可以编写模块而你的程序在运行时加载它们——非常像Interface Builder加载自定义调色板和OS X系统偏好应用加载自定义偏好模块。可加载的模块扩展了应用程序可以做的事。它们通过你允许但是没有预定或者自己定义的方式贡献出来。你提供框架，而其他人提供代码。

Although there is a runtime function that performs dynamic loading of Objective-C modules in Mach-O files (*objc_loadModules*, defined in *objc/objc-load.h*), Cocoa’s *NSBundle* class provides a significantly more convenient interface for dynamic loading—one that’s object-oriented and integrated with related services. See the *[NSBundle](https://developer.apple.com/reference/foundation/nsbundle)* class specification in the Foundation framework reference for information on the *NSBundle* class and its use. See *OS X ABI Mach-O File Format Reference* for information on Mach-O files.

尽管在Mach-O文件中有执行Objective-C模块的动态加载的方法(*objc_loadModules*，定义在 *objc/objc-load.h* 文件中)，Cocoa的*[NSBundle](https://developer.apple.com/reference/foundation/nsbundle)*类提供了明显更加方便的方法实现动态加载——一个面向对象且集成了相关服务的方法。参见Foundation框架参考中的*[NSBundle](https://developer.apple.com/reference/foundation/nsbundle)*类说明以获取关于*[NSBundle](https://developer.apple.com/reference/foundation/nsbundle)*类及其使用的信息。参见《*OS X ABI Mach-O File Format Reference*》获取关于Mach-O文件的信息。

#5 Message Forwarding 消息转发

Sending a message to an object that does not handle that message is an error. However, before announcing the error, the runtime system gives the receiving object a second chance to handle the message.

发送消息到一个不处理该消息的对象是错误的。然而，在报告这个错误之前，运行时系统给予接收对象第二次机会处理这个消息。

##5.1 Forwarding 转发

If you send a message to an object that does not handle that message, before announcing an error the runtime sends the object a *forwardInvocation:* message with an *NSInvocation* object as its sole argument—the *NSInvocation* object encapsulates the original message and the arguments that were passed with it.

如果你发送消息到一个不处理该消息的对象，在报告这个错误之前，运行时系统发送了 *forwardInvocation:* 消息给这个对象，并传入一个 *NSInvocation* 对象作为唯一参数—— *NSInvocation* 对象包含了原始的消息和传入参数。

You can implement a *forwardInvocation:* method to give a default response to the message, or to avoid the error in some other way. As its name implies, *forwardInvocation:* is commonly used to forward the message to another object.

你可以实现 *forwardInvocation:* 方法给这个消息一个默认的响应，或者以一些其他方式避免这个错误。正如它的名字暗示的， *forwardInvocation:* 通常用于转发消息到另一个对象。

To see the scope and intent of forwarding, imagine the following scenarios: Suppose, first, that you’re designing an object that can respond to a message called *negotiate*, and you want its response to include the response of another kind of object. You could accomplish this easily by passing a *negotiate* message to the other object somewhere in the body of the negotiate method you implement.

想要知道转发的范围和意图，可以假象以下场景：首先，假设你设计了一个对象可以响应名为*negotiate*的消息，并且你想要它的响应能包含另一种对象的响应。你可以在你实现*negotiate*方法的身体某处通过传递*negotiate*消息到另一对象简单的实现。

Take this a step further, and suppose that you want your object’s response to a *negotiate* message to be exactly the response implemented in another class. One way to accomplish this would be to make your class inherit the method from the other class. However, it might not be possible to arrange things this way. There may be good reasons why your class and the class that implements *negotiate* are in different branches of the inheritance hierarchy.

完成这一步之后，假设你想要你的对象对*negotiate*消息的响应正好是另一个类实现的响应。实现这个的一个途径是让你的类从另一个类继承这个方法。然而，不可能这样安排事情。可能的情况是你的类和实现*negotiate*的类在不同的继承层级分支中。

Even if your class can’t inherit the *negotiate* method, you can still “borrow” it by implementing a version of the method that simply passes the message on to an instance of the other class:

即使你的类不能继承*negotiate*方法，你仍然可以“借用”它，只要实现这个方法时简单的把消息传递给另一个类的实例：

	- (id)negotiate
	{
	    if ( [someOtherObject respondsTo:@selector(negotiate)] )
	        return [someOtherObject negotiate];
	    return self;
	}
This way of doing things could get a little cumbersome, especially if there were a number of messages you wanted your object to pass on to the other object. You’d have to implement one method to cover each method you wanted to borrow from the other class. Moreover, it would be impossible to handle cases where you didn’t know, at the time you wrote the code, the full set of messages you might want to forward. That set might depend on events at runtime, and it might change as new methods and classes are implemented in the future.

这种完成工作的方法有一点笨，特别是如果有许多消息你想要你的对象传给其他对象的时候。你不得不实现一个方法涵盖你想要从其他类借来的每一个方法。此外，还有不可能处理的情况，在你写代码的时候，你可能并不知道你想要转发的消息的完整集合。这个集合可能取决于运行时的事件，它可能在未来新的方法和类实现了的时候发生改变。

The second chance offered by a *forwardInvocation:* message provides a less ad hoc solution to this problem, and one that’s dynamic rather than static. It works like this: When an object can’t respond to a message because it doesn’t have a method matching the selector in the message, the runtime system informs the object by sending it a *forwardInvocation:* message. Every object inherits a *forwardInvocation:* method from the *NSObject* class. However, *NSObject*’s version of the method simply invokes *doesNotRecognizeSelector:*. By overriding *NSObject*’s version and implementing your own, you can take advantage of the opportunity that the *forwardInvocation:* message provides to forward messages to other objects.

由 *forwardInvocation:* 消息提供的第二次机会给这个问题提供了一个通用的解决方案，这个方案是动态的而不是静态的。它是这么工作的：当一个对象无法响应一条消息时，由于对象并没有匹配消息中的选择器的方法，运行时系统就会通过发送 *forwardInvocation:* 消息给这个对象来通知它。每个对象都从 *NSObject* 类继承了 *forwardInvocation:* 方法。但是这个方法的 *NSObject* 版本只是简单的调用了 *doesNotRecognizeSelector:*。通过重写 *NSObject* 版的方法实现自己的方法，你可以利用 *forwardInvocation:* 消息提供的机会转发消息给其他对象。

To forward a message, all a *forwardInvocation:* method needs to do is:

* Determine where the message should go, and
* Send it there with its original arguments.

要转发消息， *forwardInvocation:* 方法要做的所有事情只是：

- 决定消息要去哪里，以及
- 将消息带上原始参数发送到那里。

The message can be sent with the *invokeWithTarget:* method:

消息可以使用 *invokeWithTarget:* 方法发送：

	- (void)forwardInvocation:(NSInvocation *)anInvocation
	{
	    if ([someOtherObject respondsToSelector:
	            [anInvocation selector]])
	        [anInvocation invokeWithTarget:someOtherObject];
	    else
	        [super forwardInvocation:anInvocation];
	}
The return value of the message that’s forwarded is returned to the original sender. All types of return values can be delivered to the sender, including *id*s, structures, and double-precision floating-point numbers.

转发的消息的返回值会返回到原始的发送者那里。所有类型的返回值都可以传递到发送者，包括 *id*、结构和双精度浮点型数。

A *forwardInvocation:* method can act as a distribution center for unrecognized messages, parceling them out to different receivers. Or it can be a transfer station, sending all messages to the same destination. It can translate one message into another, or simply “swallow” some messages so there’s no response and no error. A *forwardInvocation:* method can also consolidate several messages into a single response. What *forwardInvocation:* does is up to the implementor. However, the opportunity it provides for linking objects in a forwarding chain opens up possibilities for program design.

 *forwardInvocation:* 方法可以作为未知方法的分发中心，将它们打包分配给不同的接收者。或者也可以是一个中转站，将所有消息发到同一个目的地。它可以将一条消息翻译成另一条，或者简单的“吞下”某些消息没有响应也没有错误。*forwardInvocation:*方法也可以使若干消息合并成一个单独的响应。*forwardInvocation:*做什么取决于实现者。但是，它在转发链中为连接对象提供的机会为程序设计开辟了更多的机会。

>**Note:** The *forwardInvocation:* method gets to handle messages only if they don’t invoke an existing method in the nominal receiver. If, for example, you want your object to forward *negotiate* messages to another object, it can’t have a *negotiate* method of its own. If it does, the message will never reach *forwardInvocation:*.

> **注意：**  *forwardInvocation:* 方法仅在没法正常调用接收者的现有方法时处理消息。例如，如果你想要你的对象传递*negotiate*消息给另一对象，那它自己就不能有*negotiate*方法。如果它有这个方法，消息永远不会到达*forwardInvocation:*。

For more information on forwarding and invocations, see the *NSInvocation* class specification in the Foundation framework reference.

关于转发和调用的更多信息，参见Foundation框架参考中的 *NSInvocation* 类的说明。

##5.2 Forwarding and Multiple Inheritance 转发和多重继承

Forwarding mimics inheritance, and can be used to lend some of the effects of multiple inheritance to Objective-C programs. As shown in Figure 5-1, an object that responds to a message by forwarding it appears to borrow or “inherit” a method implementation defined in another class.

转发与继承类似，可以用于给Objective-C程序提供某些多重继承的效果。如图5-1所示，对象通过转发响应一个消息好像借或“继承”了定义在另一个类中的方法实现。

Figure 5-1  Forwarding
![Forwarding](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Art/forwarding.gif)

In this illustration, an instance of the Warrior class forwards a *negotiate* message to an instance of the Diplomat class. The Warrior will appear to negotiate like a Diplomat. It will seem to respond to the *negotiate* message, and for all practical purposes it does respond (although it’s really a Diplomat that’s doing the work).

在这幅插图中，Warrior类的实例转发了 *negotiate* 消息的给Diplomat类的实例。Warrior将会像Diplomat一样谈判。它似乎响应了 *negotiate* 消息，并能响应所有实际上的目的（尽管这确实是Diplomat在做这项工作）。

The object that forwards a message thus “inherits” methods from two branches of the inheritance hierarchy—its own branch and that of the object that responds to the message. In the example above, it appears as if the Warrior class inherits from Diplomat as well as its own superclass.

转发了消息的对象就这样从继承层级的两个分支“继承”了方法——它自己的分支和响应这个消息的对象的分支。在上面的例子中，就好像Warrior类继承自Diplomat类，也继承自它自己的父类。

Forwarding provides most of the features that you typically want from multiple inheritance. However, there’s an important difference between the two: Multiple inheritance combines different capabilities in a single object. It tends toward large, multifaceted objects. Forwarding, on the other hand, assigns separate responsibilities to disparate objects. It decomposes problems into smaller objects, but associates those objects in a way that’s transparent to the message sender.

转发提供了你通常想要从多重继承获得的大部分特性。但是，二者有一个重要的不同：多重继承将不同的功能结合在一个单独的对象中。它趋向于形成大的，多功能的对象。而转发则是将责任分配给不同的对象。它将问题分解成较小的对象，但是将这些对象以透明的方式关联到消息的发送者。

##5.3 Surrogate Objects 替代者对象

Forwarding not only mimics multiple inheritance, it also makes it possible to develop lightweight objects that represent or “cover” more substantial objects. The surrogate stands in for the other object and funnels messages to it.

转发不仅可以模拟多重继承，它也使得有可能开发轻量级对象来表示或“覆盖”更丰富的对象。替代者就为另一个对象而存在并向它传输消息。

The proxy discussed in “Remote Messaging” in *The Objective-C Programming Language* is such a surrogate. A proxy takes care of the administrative details of forwarding messages to a remote receiver, making sure argument values are copied and retrieved across the connection, and so on. But it doesn’t attempt to do much else; it doesn’t duplicate the functionality of the remote object but simply gives the remote object a local address, a place where it can receive messages in another application.

《 *The Objective-C Programming Language* 》的《Remote Messaging》中讨论的代理就是这样一种替代者。代理负责转发消息给远程接收者的具体细节，确保参数值已经复制并通过连接检索，等等。但是它不会试图做其他事情；它不复制远程对象的功能，而只是简单的给远程对象一个本地地址，一个可以在另一个应用中接收消息的地方。

Other kinds of surrogate objects are also possible. Suppose, for example, that you have an object that manipulates a lot of data—perhaps it creates a complicated image or reads the contents of a file on disk. Setting this object up could be time-consuming, so you prefer to do it lazily—when it’s really needed or when system resources are temporarily idle. At the same time, you need at least a placeholder for this object in order for the other objects in the application to function properly.

其他形式的替代者对象也是可能的。例如，假设你有一个对象管理了大量数据——它可能创建了一个复杂的图像或者读取了一个磁盘文件的内容。构建这个对象可能非常耗时，因此你倾向于懒加载——当它真的需要时或者当系统资源暂时闲置时才加载。同时，你至少需要一个该对象的占位符，以便程序中的其他对象能够正确的运转。

In this circumstance, you could initially create, not the full-fledged object, but a lightweight surrogate for it. This object could do some things on its own, such as answer questions about the data, but mostly it would just hold a place for the larger object and, when the time came, forward messages to it. When the surrogate’s *forwardInvocation:* method first receives a message destined for the other object, it would ensure that the object existed and would create it if it didn’t. All messages for the larger object go through the surrogate, so, as far as the rest of the program is concerned, the surrogate and the larger object would be the same.

在这种情况下，你可以在起初为它创建一个轻量级的替代者，而不是完整的对象。这个对象能够靠自己完成一些工作，例如回答关于数据的问题，但大部分时候它只是为更大的对象持有一片空间，并且在需要时转发消息过去。当替代者的 *forwardInvocation:* 方法第一次收到指定给另一个对象的消息，它会确保那个对象存在，如果不存在就创建它。所有给更大对象的消息都通过替代者传递，因此，只要关注程序的其他地方，替代者和更大的对象就是一样的。

##5.4 Forwarding and Inheritance 转发和继承

Although forwarding mimics inheritance, the *NSObject* class never confuses the two. Methods like *respondsToSelector:* and *isKindOfClass:* look only at the inheritance hierarchy, never at the forwarding chain. If, for example, a Warrior object is asked whether it responds to a *negotiate* message,

尽管转发模拟了继承， *NSObject* 类永远不会混淆二者。像 *respondsToSelector:* 和 *isKindOfClass:* 这样的方法，只关注继承层级，而不会关注转发链。例如，如果Warrior对象被询问是否可以响应 *negotiate* 消息，

	if ( [aWarrior respondsToSelector:@selector(negotiate)] )
	    ...
the answer is *NO*, even though it can receive *negotiate* messages without error and respond to them, in a sense, by forwarding them to a Diplomat. (See Figure 5-1.)

答案是 *NO*，尽管它可以接收 *negotiate* 消息而不会报错，并且在一定意义上可以通过转发给Diplomat来响应消息。（见图5-1）

In many cases, *NO* is the right answer. But it may not be. If you use forwarding to set up a surrogate object or to extend the capabilities of a class, the forwarding mechanism should probably be as transparent as inheritance. If you want your objects to act as if they truly inherited the behavior of the objects they forward messages to, you’ll need to re-implement the *respondsToSelector:* and *isKindOfClass:* methods to include your forwarding algorithm:

在多数情况下， *NO* 是正确答案。但也可能不是。如果你使用转发建立了一个替代者对象或者扩展了类的功能，转发机制可以跟继承一样透明。如果想要你的对象的表现得好像完全继承了转发消息到的对象的行为，你需要重新实现 *respondsToSelector:* 和 *isKindOfClass:* 方法以包含你的转发算法：

	- (BOOL)respondsToSelector:(SEL)aSelector
	{
	    if ( [super respondsToSelector:aSelector] )
	        return YES;
	    else {
	        /* Here, test whether the aSelector message can     *
	         * be forwarded to another object and whether that  *
	         * object can respond to it. Return YES if it can.  */
	    }
	    return NO;
	}
In addition to *respondsToSelector:* and *isKindOfClass:*, the *instancesRespondToSelector:* method should also mirror the forwarding algorithm. If protocols are used, the *conformsToProtocol:* method should likewise be added to the list. Similarly, if an object forwards any remote messages it receives, it should have a version of *methodSignatureForSelector:* that can return accurate descriptions of the methods that ultimately respond to the forwarded messages; for example, if an object is able to forward a message to its surrogate, you would implement *methodSignatureForSelector:* as follows:

除了 *respondsToSelector:* 和 *isKindOfClass:* ， *instancesRespondToSelector:* 方法也需要反映转发算法。如果使用了协议，*conformsToProtocol:* 方法同样要添加到列表中。类似的，如果一个对象转发了它收到的任何远程消息，它要有 *methodSignatureForSelector:* 的一个版本可以返回最终响应这条转发消息的方法的正确描述；例如，如果一个对象能转发消息到它的替代者，你要像这样实现 *methodSignatureForSelector:* 方法：

	- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
	{
	    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
	    if (!signature) {
	       signature = [surrogate methodSignatureForSelector:selector];
	    }
	    return signature;
	}
You might consider putting the forwarding algorithm somewhere in private code and have all these methods, *forwardInvocation:* included, call it.

你可能考虑把转发算法放到私有代码的某处，然后所有的这些方法，包括  *forwardInvocation:*，都来调用它。

>**Note:**  This is an advanced technique, suitable only for situations where no other solution is possible. It is not intended as a replacement for inheritance. If you must make use of this technique, make sure you fully understand the behavior of the class doing the forwarding and the class you’re forwarding to.

> **注意:**  这是高级技术，只适用于没有其他可能的解决方法的情况。它并不想要取代继承。如果你必须使用这个技术，确保你完全理解了进行转发的和转发到的类的行为。

The methods mentioned in this section are described in the *NSObject* class specification in the Foundation framework reference. For information on *invokeWithTarget:*, see the *NSInvocation* class specification in the Foundation framework reference.

本章所提到的方法详见Foundation框架参考中的 *NSObject* 类说明。关于 *invokeWithTarget:* 的信息，参见Foundation框架参考中的 *NSInvocation* 类说明。

#6 Type Encodings 类型编码

To assist the runtime system, the compiler encodes the return and argument types for each method in a character string and associates the string with the method selector. The coding scheme it uses is also useful in other contexts and so is made publicly available with the *@encode()* compiler directive. When given a type specification, *@encode()* returns a string encoding that type. The type can be a basic type such as an *int*, a pointer, a tagged structure or union, or a class name—any type, in fact, that can be used as an argument to the C *sizeof()* operator.

为了帮助运行时系统，编译器将每个方法的返回值类型和参数类型编码成了字符串，并把字符串与方法选择器关联起来。 它使用的编码方案在其他情况下也是有用的，因此该方案使用 *@encode()* 编译器指令设置成了公共可用的。当给定一个类型说明， *@encode()* 会返回这个类型的字符串编码。这个类型可以是基础类型如 *int*，指针，带标签的结构或联合，或者类名——实际上是可以用作C语言 *sizeof()* 运算符的参数的任何类型。

	char *buf1 = @encode(int **);
	char *buf2 = @encode(struct key);
	char *buf3 = @encode(Rectangle);
The table below lists the type codes. Note that many of them overlap with the codes you use when encoding an object for purposes of archiving or distribution. However, there are codes listed here that you can’t use when writing a coder, and there are codes that you may want to use when writing a coder that aren’t generated by *@encode()*. (See the *[NSCoder](https://developer.apple.com/reference/foundation/nscoder)* class specification in the Foundation Framework reference for more information on encoding objects for archiving or distribution.)

下表列出了类型编码。注意他们中许多与你为了归档或分发而编码一个对象时使用的代码重叠了。并且，有的代码你不能在撰写编码器时使用，而有的代码你想要用于撰写编码器时不会由 *@encode()* 产生。（关于编码对象以归档或分发的更多信息，参见Foundation框架参考中的 *[NSCoder](https://developer.apple.com/reference/foundation/nscoder)* 类说明。）

Table 6-1  Objective-C type encodings

|      Code      |                 Meaning                  |
| :------------: | :--------------------------------------: |
|       c        |                  A char                  |
|       i        |                  An int                  |
|       s        |                 A short                  |
|       l        | A long </br>l is treated as a 32-bit quantity on 64-bit programs. |
|       q        |               A long long                |
|       C        |             An unsigned char             |
|       I        |             An unsigned int              |
|       S        |            An unsigned short             |
|       L        |             An unsigned long             |
|       Q        |          An unsigned long long           |
|       f        |                 A float                  |
|       d        |                 A double                 |
|       B        |        A C++ bool or a C99 _Bool         |
|       v        |                  A void                  |
|       \*       |       A character string (char *)        |
|       @        | An object (whether statically typed or typed id) |
|       #        |          A class object (Class)          |
|       :        |         A method selector (SEL)          |
|  [array type]  |                 An array                 |
| {name=type...} |               A structure                |
| (name=type...) |                 A union                  |
|      bnum      |         A bit field of num bits          |
|     ^type      |            A pointer to type             |
|       ?        | An unknown type (among other things, this code is used for function pointers) |

>**Important:** Objective-C does not support the *long double* type. *@encode*(*long double*) returns *d*, which is the same encoding as for *double*.

> **重要：** Objective-C 不支持 *long double* 类型。*@encode*(*long double*) 返回 *d*，跟 *double* 的编码一样。

The type code for an array is enclosed within square brackets; the number of elements in the array is specified immediately after the open bracket, before the array type. For example, an array of 12 pointers to *float*s would be encoded as:

数组的类型代码被括在方括号之中；数组中元素的个数在左括号之后立即指出，在数组类型之前。例如，12个指向 *float* 的指针的数组会被编码成：

	[12^f]
Structures are specified within braces, and unions within parentheses. The structure tag is listed first, followed by an equal sign and the codes for the fields of the structure listed in sequence. For example, the structure

结构体在大括号里说明，而联合体在圆括号里。结构体的标签被列在最前面，接着是一个等号，然后结构体的每个字段的代码按顺序列出。例如，结构体

	typedef struct example {
	    id   anObject;
	    char *aString;
	    int  anInt;
	} Example;
would be encoded like this:

会被编码成这样:

	{example=@*i}

The same encoding results whether the defined type name (*Example*) or the structure tag (*example*) is passed to *@encode()*. The encoding for a structure pointer carries the same amount of information about the structure’s fields:

无论将定义的类型名称（*Example*）或者结构体标签（*example*）传给 *@encode()* 都会返回一样的结果。结构体指针的编码携带了同样数量的关于结构体字段的信息：

	^{example=@*i}
However, another level of indirection removes the internal type specification:

但是，另一层的间接寻址移除了内部类型说明：

	^^{example}
Objects are treated like structures. For example, passing the *NSObject* class name to *@encode()* yields this encoding:

对象的处理像结构体一样。例如，传递 *NSObject* 类名到 *@encode()* 会产生这样的编码：

	{NSObject=#}
The *NSObject* class declares just one instance variable, *isa*, of type Class.

 *NSObject* 类只声明了一个实例变量， *isa*，类型是Class。

Note that although the *@encode()* directive doesn’t return them, the runtime system uses the additional encodings listed in Table 6-2 for type qualifiers when they’re used to declare methods in a protocol.

注意尽管 *@encode()* 不直接返回它们，运行时系统还为类型修饰词使用了额外的编码，列在表6-2中，它们用于在协议中声明方法。

Table 6-2  Objective-C method encodings

| Code | Meaning |
| :--: | :-----: |
|  r   |  const  |
|  n   |   in    |
|  N   |  inout  |
|  o   |   out   |
|  O   | bycopy  |
|  R   |  byref  |
|  V   | oneway  |

#7 Declared Properties 声明的属性

When the compiler encounters property declarations (see Declared Properties in *The Objective-C Programming Language*), it generates descriptive metadata that is associated with the enclosing class, category or protocol. You can access this metadata using functions that support looking up a property by name on a class or protocol, obtaining the type of a property as an *@encode* string, and copying a list of a property's attributes as an array of C strings. A list of declared properties is available for each class and protocol.

当编译器遇到属性声明时（参见《*The Objective-C Programming Language*》中的《Declared Properties》），它会产生与封闭类、类别或协议相关联的描述性元数据。你可以使用方法访问该元数据，支持通过类或协议中的名字查找属性，获得以 *@encode* 字符串表示的属性类型，以及拷贝属性的标志列表作为C字符串数组。已声明的属性的列表对于每个类和协议都是可用的。

##7.1 Property Type and Functions 属性类型和方法

The *Property* structure defines an opaque handle to a property descriptor.

 *Property* 结构体定义了属性描述符的不透明句柄。

	typedef struct objc_property *Property;
You can use the functions *class_copyPropertyList* and *protocol_copyPropertyList* to retrieve an array of the properties associated with a class (including loaded categories) and a protocol respectively:

你可以使用 *class_copyPropertyList* 函数和 *protocol_copyPropertyList* 函数分别取回关联到类（包括已加载的类别）和协议的属性数组：

	objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)
	objc_property_t *protocol_copyPropertyList(Protocol *proto, unsigned int *outCount)
For example, given the following class declaration:

例如，给定以下类声明：

	@interface Lender : NSObject {
	    float alone;
	}
	@property float alone;
	@end
you can get the list of properties using:

你可以通过以下方法获得属性列表：

	id LenderClass = objc_getClass("Lender");
	unsigned int outCount;
	objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
You can use the *property_getName* function to discover the name of a property:

你可以使用 *property_getName* 函数发现属性的名称：

	const char *property_getName(objc_property_t property)
You can use the functions *class_getProperty* and *protocol_getProperty* to get a reference to a property with a given name in a class and protocol respectively:

你可以使用 *class_getProperty* 和 *protocol_getProperty* 分别获得类和协议中给定名称的属性的引用：

	objc_property_t class_getProperty(Class cls, const char *name)
	objc_property_t protocol_getProperty(Protocol *proto, const char *name, BOOL isRequiredProperty, BOOL isInstanceProperty)
You can use the *property_getAttributes* function to discover the name and the *@encode* type string of a property. For details of the encoding type strings, see *[Type Encodings](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1)*; for details of this string, see *[Property Type String](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6)* and *[Property Attribute Description Examples](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW5)*.

你可以使用 *property_getAttributes* 函数发现名称和属性的*@encode*类型字符串属性。编码类型字符串的详情，参见 *[Type Encodings](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1)*；这个字符串的详情，见 *[Property Type String](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6)* 和 *[Property Attribute Description Examples](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW5)*。

	const char *property_getAttributes(objc_property_t property)
Putting these together, you can print a list of all the properties associated with a class using the following code:

把这些放到一起，你可以使用以下代码打印一份关联到类的所有属性的列表：

	id LenderClass = objc_getClass("Lender");
	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList(LenderClass, &outCount);
	for (i = 0; i < outCount; i++) {
	    objc_property_t property = properties[i];
	    fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
	}
##7.2 Property Type String 属性类型字符串

You can use the *property_getAttributes* function to discover the name, the *@encode* type string of a property, and other attributes of the property.

你可以使用 *property_getAttributes* 函数发现属性的名称、 *@encode* 类型字符串以及属性的其他特征。

The string starts with a *T* followed by the *@encode* type and a comma, and finishes with a *V* followed by the name of the backing instance variable. Between these, the attributes are specified by the following descriptors, separated by commas:

该字符串以跟着 *@encode* 类型和逗号的 *T* 开头，最后以跟着后台实例变量的名称的 *V* 结束。在它们之间，属性由以下描述符说明，以逗号分隔：

Table 7-1  Declared property type encodings

|    Code     |                 Meaning                  |
| :---------: | :--------------------------------------: |
|      R      |  The property is read-only (readonly).   |
|      C      | The property is a copy of the value last assigned (copy). |
|      &      | The property is a reference to the value last assigned (retain). |
|      N      | The property is non-atomic (nonatomic).  |
|   G<name>   | The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,). |
|   S<name>   | The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,). |
|      D      |   The property is dynamic (@dynamic).    |
|      W      | The property is a weak reference (__weak). |
|      P      | The property is eligible for garbage collection. |
| t<encoding> | Specifies the type using old-style encoding. |

For examples, see *[Property Attribute Description Examples](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW5)*.

例子参见《*[Property Attribute Description Examples](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW5)*》。

##7.3 Property Attribute Description Examples 属性描述实例

Given these definitions:

给出这些定义：

	enum FooManChu { FOO, MAN, CHU };
	struct YorkshireTeaStruct { int pot; char lady; };
	typedef struct YorkshireTeaStruct YorkshireTeaStructType;
	union MoneyUnion { float alone; double down; };
the following table shows sample property declarations and the corresponding string returned by *property_getAttributes*:

下表展示了属性声明范例和 *property_getAttributes* 方法的响应字符串：

|           Property declaration           |           Property description           |
| :--------------------------------------: | :--------------------------------------: |
|       @property char charDefault;        |             Tc,VcharDefault              |
|     @property double doubleDefault;      |            Td,VdoubleDefault             |
|  @property enum FooManChu enumDefault;   |             Ti,VenumDefault              |
|      @property float floatDefault;       |             Tf,VfloatDefault             |
|        @property int intDefault;         |              Ti,VintDefault              |
|       @property long longDefault;        |             Tl,VlongDefault              |
|      @property short shortDefault;       |             Ts,VshortDefault             |
|     @property signed signedDefault;      |            Ti,VsignedDefault             |
| @property struct YorkshireTeaStruct structDefault; | T{YorkshireTeaStruct="pot"i"lady"c},VstructDefault |
| @property YorkshireTeaStructType typedefDefault; | T{YorkshireTeaStruct="pot"i"lady"c},VtypedefDefault |
| @property union MoneyUnion unionDefault; | T(MoneyUnion="alone"f"down"d),VunionDefault |
|   @property unsigned unsignedDefault;    |           TI,VunsignedDefault            |
| @property int (\*functionPointerDefault)(char \*); |       T^?,VfunctionPointerDefault        |
| @property id idDefault;</br>**Note: the compiler warns:** "no 'assign', 'retain', or 'copy' attribute is specified - 'assign' is assumed" |              T@,VidDefault               |
|       @property int \*intPointer;        |             T^i,VintPointer              |
|   @property void \*voidPointerDefault;   |         T^v,VvoidPointerDefault          |
| @property int intSynthEquals;（In the implementation block: @synthesize intSynthEquals=_intSynthEquals;） |           Ti,V_intSynthEquals            |
| @property(getter=intGetFoo, setter=intSetFoo:) int intSetterGetter; | Ti,GintGetFoo,SintSetFoo:,VintSetterGetter |
|   @property(readonly) int intReadonly;   |            Ti,R,VintReadonly             |
| @property(getter=isIntReadOnlyGetter, readonly) int intReadonlyGetter; |        Ti,R,GisIntReadOnlyGetter         |
|  @property(readwrite) int intReadwrite;  |             Ti,VintReadwrite             |
|     @property(assign) int intAssign;     |              Ti,VintAssign               |
|      @property(retain) id idRetain;      |              T@,&,VidRetain              |
|        @property(copy) id idCopy;        |               T@,C,VidCopy               |
|  @property(nonatomic) int intNonatomic;  |             Ti,VintNonatomic             |
| @property(nonatomic, readonly, copy) id idReadonlyCopyNonatomic; |     T@,R,C,VidReadonlyCopyNonatomic      |
| @property(nonatomic, readonly, retain) id idReadonlyRetainNonatomic; |    T@,R,&,VidReadonlyRetainNonatomic     |

#Document Revision History 文档版本历史

This table describes the changes to *Objective-C Runtime Programming Guide*.

|    Date    |                  Notes                   |
| :--------: | :--------------------------------------: |
| 2009-10-19 |      Made minor editorial changes.       |
| 2009-07-14 | Completed list of types described by property_getAttributes. |
| 2009-02-04 |     Corrected typographical errors.      |
| 2008-11-19 | New document that describes the Objective-C 2.0 runtime support library. |
