# The Basics

> Work with common kinds of data and write basic syntax.
> 
> 处理常见类型的数据并编写基本语法。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics)

Swift provides many fundamental data types, including `Int` for integers, `Double` for floating-point values, `Bool` for Boolean values, and `String` for text. Swift also provides powerful versions of the three primary collection types, `Array`, `Set`, and `Dictionary`, as described in [Collection Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes).

Swift 提供了许多基本数据类型，包括用于整数的 `Int`，用于浮点数的 `Double`，用于布尔值的 `Bool`，以及用于文本的 `String`。Swift 也提供了三种强大的主要集合类型，`Array`、`Set` 和 `Dictionary`，如《[集合类型](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes)》章节所述。

Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values can’t be changed. These are known as constants, and are used throughout Swift to make code safer and clearer in intent when you work with values that don’t need to change.

Swift 使用变量来存储和引用值，这些值通过标识符名称来识别。Swift 也广泛使用了不能改变值的变量，它们被称为常量。在处理不需要改变的值时，通过使用常量可以使 Swift 的代码更安全，目标更明确。

In addition to familiar types, Swift introduces advanced types such as tuples. Tuples enable you to create and pass around groupings of values. You can use a tuple to return multiple values from a function as a single compound value.

除了熟悉的类型，Swift 还引入了高级类型，如元组（tuples）。元组使你能够创建和传递值的分组。你可以使用元组从函数返回多个值作为单个复合值。

Swift also introduces optional types, which handle the absence of a value. Optionals say either “there is a value, and it equals x” or “there isn’t a value at all”.

Swift 还引入了可选类型，用来处理值的缺失。可选类型表示“存在一个值，它等于 x”或者“根本不存在值”。

Swift is a type-safe language, which means the language helps you to be clear about the types of values your code can work with. If part of your code requires a `String`, type safety prevents you from passing it an `Int` by mistake. Likewise, type safety prevents you from accidentally passing an optional `String` to a piece of code that requires a non-optional `String`. Type safety helps you catch and fix errors as early as possible in the development process.

Swift 是一种类型安全的语言，这意味着这种语言帮助你明确你的代码可以处理的值的类型。如果你的代码的一部分需要一个 `String`，类型安全性防止你误将 `Int` 传入。同样，类型安全性防止你意外地将可选的 `String` 传递给需要非可选 `String` 的代码片段。类型安全性帮助你尽早在开发过程中捕获并修复错误。

## Constants and Variables - 常量和变量

Constants and variables associate a name (such as `maximumNumberOfLoginAttempts` or `welcomeMessage`) with a value of a particular type (such as the number `10` or the string `"Hello"`). The value of a _constant_ can’t be changed once it’s set, whereas a _variable_ can be set to a different value in the future.

常量和变量将一个名称（例如 `maximumNumberOfLoginAttempts` 或 `welcomeMessage`）与特定类型的值（例如数字 `10` 或字符串 `"Hello"`）关联起来。一旦设定，**常量**的值就不能改变，而**变量**在未来可以设定为不同的值。

## Declaring Constants and Variables - 声明常量和变量

Constants and variables must be declared before they’re used. You declare constants with the `let` keyword and variables with the `var` keyword. Here’s an example of how constants and variables can be used to track the number of login attempts a user has made:

在使用常量和变量之前，必须先声明它们。你可以使用 `let` 关键字声明常量，使用 `var` 关键字声明变量。以下是一个示例，展示了如何使用常量和变量来跟踪用户的登录尝试次数：

```
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

This code can be read as:

这段代码的含义是：

“Declare a new constant called maximumNumberOfLoginAttempts, and give it a value of 10. Then, declare a new variable called currentLoginAttempt, and give it an initial value of 0.”

“声明一个新的常量，名为 `maximumNumberOfLoginAttempts`，并赋值为 `10`。然后，声明一个新的变量，名为 currentLoginAttempt，并初始值设为 `0`。”

In this example, the maximum number of allowed login attempts is declared as a constant, because the maximum value never changes. The current login attempt counter is declared as a variable, because this value must be incremented after each failed login attempt.

在这个例子中，允许的最大登录尝试次数被声明为一个常量，因为这个最大值永远不会改变。当前的登录尝试计数器被声明为一个变量，因为每次登录失败后，这个值必须增加。

If a stored value in your code won’t change, always declare it as a constant with the `let` keyword. Use variables only for storing values that change.

如果你的代码中的存储值不会改变，总是用 `let` 关键字声明它为常量。只有需要改变的值才使用变量进行存储。

When you declare a constant or a variable, you can give it a value as part of that declaration, like the examples above. Alternatively, you can assign its initial value later in the program, as long as it’s guaranteed to have a value before the first time you read from it.

当你声明一个常量或变量时，可以在声明的同时给它赋值，就像上面的例子那样。或者，你可以在程序的后面部分给它赋初值，只要保证在第一次读取它之前，它已经被赋值。

```
var environment = "development"
let maximumNumberOfLoginAttempts: Int
// maximumNumberOfLoginAttempts has no value yet.
// maximumNumberOfLoginAttempts 还没有值。

if environment == "development" {
    maximumNumberOfLoginAttempts = 100
} else {
    maximumNumberOfLoginAttempts = 10
}
// Now maximumNumberOfLoginAttempts has a value, and can be read.
// 现在 maximumNumberOfLoginAttempts 有值了，可以被读取。
```

In this example, the maximum number of login attempts is constant, and its value depends on the environment. In the development environment, it has a value of `100`; in any other environment, its value is `10`. Both branches of the `if` statement initialize `maximumNumberOfLoginAttempts` with some value, guaranteeing that the constant always gets a value. For information about how Swift checks your code when you set an initial value this way, see [Constant Declaration](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Constant-Declaration).

在这个例子中，登录尝试的最大次数是一个常量，其值取决于环境。在开发环境中，它的值为 `100`；在任何其他环境中，其值为 `10`。`if` 语句的两个分支都用某个值初始化了 `maximumNumberOfLoginAttempts`，保证了这个常量总是有一个值。关于 Swift 如何在你以这种方式设置初始值时检查你的代码，可以参见《[常量声明](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Constant-Declaration)》一节。

You can declare multiple constants or multiple variables on a single line, separated by commas:

你可以在一行中声明多个常量或多个变量，用逗号分隔：

```
var x = 0.0, y = 0.0, z = 0.0
```

## Type Annotations - 类型注解
