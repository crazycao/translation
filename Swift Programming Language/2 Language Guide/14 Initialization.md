# Initialization 初始化

> Set the initial values for a type’s stored properties and perform one-time setup.
> 
> 为一个类型的存储属性设置初始值，并执行一次性的设置操作。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization)

_Initialization_ is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.

_初始化_ 是为使用类、结构体或枚举的实例做准备的过程。这个过程包括为该实例上的每个存储属性设置初始值，并在新实例准备好使用之前执行任何其他所需的设置或初始化操作。

You implement this initialization process by defining _initializers_, which are like special methods that can be called to create a new instance of a particular type. Unlike Objective-C initializers, Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.

您可以通过定义 _初始化器_ 来实现这个初始化过程，这些初始化器类似于可以调用来创建特定类型的新实例的特殊方法。与Objective-C初始化器不同，Swift初始化器不返回值。它们的主要作用是确保类型的新实例在第一次使用之前被正确初始化。

Instances of class types can also implement a _deinitializer_, which performs any custom cleanup just before an instance of that class is deallocated. For more information about deinitializers, see [Deinitialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization).

class 类型的实例也可以实现 _反初始化器_，它在 class 的实例被释放之前执行任何自定义清理。有关反初始化器的更多信息，请参见《[反初始化](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/deinitialization)》。

## 1 Setting Initial Values for Stored Properties 设置存储属性的初始值

Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state.

在创建类或结构的实例之前，类和结构必须将它们所有存储的属性设置为适当的初始值。存储的属性不能处于不确定状态。

You can set an initial value for a stored property within an initializer, or by assigning a default property value as part of the property’s definition. These actions are described in the following sections.

可以在初始化器中为存储属性设置初始值，也可以在属性定义时分配默认属性值。下面几节将介绍这些操作。

> **Note**
>
> When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
> 
> **注意**
> 
> 当您为存储属性分配默认值或在初始化器中设置其初始值时，将直接设置该属性的值，而不会调用任何属性观察器。

## 2 Initializers 初始化器

Initializers are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the `init` keyword:

调用初始化器来创建特定类型的新实例。在最简单的形式中，初始化器就像一个没有参数的实例方法，使用 `init` 关键字编写：

```
init() {
    // perform some initialization here
    // 在这里执行一些初始化
}
```

The example below defines a new structure called Fahrenheit to store temperatures expressed in the Fahrenheit scale. The Fahrenheit structure has one stored property, `temperature`, which is of type `Double`:

下面的例子定义了一个叫做华氏温度的新结构来存储以华氏温标表示的温度。华氏结构有一个存储属性，`temperature`，它的类型是 `Double`：

```
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"
// //打印“默认温度为32.0°f ”
```

The structure defines a single initializer, `init`, with no parameters, which initializes the stored temperature with a value of `32.0` (the freezing point of water in degrees Fahrenheit).

该结构定义了一个没有参数的初始化器 `init`，它将存储的温度初始化为`32.0`（以华氏度为单位的水的冰点）。

## 3 Default Property Values
You can set the initial value of a stored property from within an initializer, as shown above. Alternatively, specify a default property value as part of the property’s declaration. You specify a default property value by assigning an initial value to the property when it’s defined.

Note

If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance, as described later in this chapter.

You can write the Fahrenheit structure from above in a simpler form by providing a default value for its temperature property at the point that the property is declared:

struct Fahrenheit {
    var temperature = 32.0
}
