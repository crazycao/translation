# Basic Operators 基本运算符

> Perform operations like assignment, arithmetic, and comparison.
> 
> 执行诸如赋值、算术和比较等操作。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators)

An operator is a special symbol or phrase that you use to check, change, or combine values. For example, the addition operator (+) adds two numbers, as in let i = 1 + 2, and the logical AND operator (&&) combines two Boolean values, as in if enteredDoorCode && passedRetinaScan.






Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values can’t be changed. These are known as constants, and are used throughout Swift to make code safer and clearer in intent when you work with values that don’t need to change.

Swift 使用变量来存储和引用值，这些值通过标识符名称来识别。Swift 也广泛使用了不能改变值的变量，它们被称为常量。在处理不需要改变的值时，通过使用常量可以使 Swift 的代码更安全，目标更明确。

In addition to familiar types, Swift introduces advanced types such as tuples. Tuples enable you to create and pass around groupings of values. You can use a tuple to return multiple values from a function as a single compound value.

除了熟悉的类型，Swift 还引入了高级类型，如元组（tuples）。元组使你能够创建和传递值的分组。你可以使用元组从函数返回多个值作为单个复合值。

Swift also introduces optional types, which handle the absence of a value. Optionals say either “there is a value, and it equals x” or “there isn’t a value at all”.

Swift 还引入了可选类型，用来处理值的缺失。可选类型表示“存在一个值，它等于 x”或者“根本不存在值”。

Swift is a type-safe language, which means the language helps you to be clear about the types of values your code can work with. If part of your code requires a `String`, type safety prevents you from passing it an `Int` by mistake. Likewise, type safety prevents you from accidentally passing an optional `String` to a piece of code that requires a non-optional `String`. Type safety helps you catch and fix errors as early as possible in the development process.

Swift 是一种类型安全的语言，这意味着这种语言帮助你明确你的代码可以处理的值的类型。如果你的代码的一部分需要一个 `String`，类型安全性防止你误将 `Int` 传入。同样，类型安全性防止你意外地将可选的 `String` 传递给需要非可选 `String` 的代码片段。类型安全性帮助你尽早在开发过程中捕获并修复错误。

## 1 Constants and Variables - 常量和变量

Constants and variables associate a name (such as `maximumNumberOfLoginAttempts` or `welcomeMessage`) with a value of a particular type (such as the number `10` or the string `"Hello"`). The value of a _constant_ can’t be changed once it’s set, whereas a _variable_ can be set to a different value in the future.

常量和变量将一个名称（例如 `maximumNumberOfLoginAttempts` 或 `welcomeMessage`）与特定类型的值（例如数字 `10` 或字符串 `"Hello"`）关联起来。一旦设定，**常量**的值就不能改变，而**变量**在未来可以设定为不同的值。

### 1.1 Declaring Constants and Variables - 声明常量和变量

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

### 1.2 Type Annotations - 类型注解

You can provide a type annotation when you declare a constant or variable, to be clear about the kind of values the constant or variable can store. Write a type annotation by placing a colon after the constant or variable name, followed by a space, followed by the name of the type to use.

您可以在声明常量或变量时提供类型注解，以明确指定常量或变量可以存储的值的类型。通过在常量或变量名称后放置一个冒号，后面跟着一个空格，再跟着要使用的类型名称来编写类型注解。

This example provides a type annotation for a variable called `welcomeMessage`, to indicate that the variable can store `String` values:

以下示例为名为 `welcomeMessage` 的变量提供了一个类型注解，以指示该变量可以存储 `String` 值：

```
var welcomeMessage: String
```

The colon in the declaration means “…of type…,” so the code above can be read as:

声明中的冒号表示“...的类型是...”，因此上面的代码可以解读为：

“Declare a variable called `welcomeMessage` that’s of type `String`.”

“声明一个名为 `welcomeMessage` 的变量，其类型为 `String`。”

The phrase “of type `String`” means “can store any `String` value.” Think of it as meaning “the type of thing” (or “the kind of thing”) that can be stored.

短语“`String` 类型”表示“可以存储任何 `String` 值”。将其视为表示“可以存储的类型”（或“可以存储的种类”）。

The `welcomeMessage` variable can now be set to any string value without error:

现在，`welcomeMessage` 变量可以设置为任何字符串值而不会出错：

```
welcomeMessage = "Hello"
```

You can define multiple related variables of the same type on a single line, separated by commas, with a single type annotation after the final variable name:

您可以在单行上使用逗号将多个相关变量定义为相同的类型，并在最后一个变量名称后添加一个类型注释：


```
var red, green, blue: Double
```

> **Note** **说明**
>
> It’s rare that you need to write type annotations in practice. If you provide an initial value for a constant or variable at the point that it’s defined, Swift can almost always infer the type to be used for that constant or variable, as described in [Type Safety and Type Inference](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Type-Safety-and-Type-Inference). In the `welcomeMessage` example above, no initial value is provided, and so the type of the `welcomeMessage` variable is specified with a type annotation rather than being inferred from an initial value.
> 
> 在实践中，很少需要编写类型注解。如果在定义常量或变量时提供初始值，Swift 几乎总是可以推断出用于该常量或变量的类型，如《[类型安全和类型推断](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Type-Safety-and-Type-Inference)》中所述。在上面的 `welcomeMessage` 示例中，未提供初始值，因此 `welcomeMessage` 变量的类型通过类型注解指定，而不是从初始值推断出来。

### 1.3 Naming Constants and Variables 命名常量和变量

Constant and variable names can contain almost any character, including Unicode characters:

常量和变量的名称可以包含几乎任何字符，包括 Unicode 字符：

```
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```

Constant and variable names can’t contain whitespace characters, mathematical symbols, arrows, private-use Unicode scalar values, or line- and box-drawing characters. Nor can they begin with a number, although numbers may be included elsewhere within the name.

常量和变量的名称不能包含空格字符、数学符号、箭头、私有使用的 Unicode 标量值，或线条和方框绘制字符。它们也不能以数字开头，尽管数字可能出现在名称的其他位置。

Once you’ve declared a constant or variable of a certain type, you can’t declare it again with the same name, or change it to store values of a different type. Nor can you change a constant into a variable or a variable into a constant.

一旦您声明了某种类型的常量或变量，就不能再使用相同的名称重新声明它，也不能将其更改为存储不同类型的值。您也不能将常量更改为变量，或将变量更改为常量。

> **Note** **注意**
>
> If you need to give a constant or variable the same name as a reserved Swift keyword, surround the keyword with backticks (`) when using it as a name. However, avoid using keywords as names unless you have absolutely no choice.
> 
> 如果您需要给常量或变量赋予与保留的 Swift 关键字相同的名称，请在使用名称时用反引号（`）将关键字括起来。但是，除非别无选择，否则避免使用关键字作为名称。

You can change the value of an existing variable to another value of a compatible type. In this example, the value of `friendlyWelcome` is changed from "Hello!" to "Bonjour!":

您可以将现有变量的值更改为兼容类型的另一个值。在此示例中，将 `friendlyWelcome` 的值从 "Hello!" 更改为了 "Bonjour!"：

```
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome is now "Bonjour!"
// friendlyWelcome 现在是 "Bonjour!"
```

Unlike a variable, the value of a constant can’t be changed after it’s set. Attempting to do so is reported as an error when your code is compiled:

与变量不同，常量在设置后无法更改其值。在尝试更改常量值时，编译代码时会报告错误：

```
let languageName = "Swift"
languageName = "Swift++"
// This is a compile-time error: languageName cannot be changed.
// 这是一个编译时错误：languageName 无法更改。
```

### 1.4 Printing Constants and Variables 打印常量和变量

You can print the current value of a constant or variable with the `print(_:separator:terminator:)` function:

您可以使用 `print(_:separator:terminator:)` 函数打印常量或变量的当前值：

```
print(friendlyWelcome)
// Prints "Bonjour!"
// 打印 "Bonjour!"
```

The `print(_:separator:terminator:)` function is a global function that prints one or more values to an appropriate output. In Xcode, for example, the `print(_:separator:terminator:)` function prints its output in Xcode’s “console” pane. The separator and terminator parameter have default values, so you can omit them when you call this function. By default, the function terminates the line it prints by adding a line break. To print a value without a line break after it, pass an empty string as the terminator — for example, `print(someValue, terminator: "")`. For information about parameters with default values, see [Default Parameter Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions#Default-Parameter-Values).

`print(:separator:terminator:)` 函数是一个全局函数，用于将一个或多个值打印到适当的输出。例如，在 Xcode 中，`print(:separator:terminator:)` 函数会将其输出打印在 Xcode 的“控制台”窗格中。分隔符和终止符参数具有默认值，因此在调用此函数时可以省略它们。默认情况下，该函数通过添加换行符来终止它所打印的行。要在打印值后不添加换行符，请将空字符串作为终止符传递——例如，`print(someValue, terminator: "")`。有关具有默认值的参数的信息，请参阅[默认参数值](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions#Default-Parameter-Values)。

Swift uses string interpolation to include the name of a constant or variable as a placeholder in a longer string, and to prompt Swift to replace it with the current value of that constant or variable. Wrap the name in parentheses and escape it with a backslash before the opening parenthesis:

Swift 使用字符串插值将常量或变量的名称作为占位符包含在较长字符串中，并提示 Swift 用当前该常量或变量的值替换它。将名称括在括号中，并在开括号之前用反斜杠对其进行转义：

```
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// Prints "The current value of friendlyWelcome is Bonjour!"
// 打印 "The current value of friendlyWelcome is Bonjour!"
```

> **Note** **说明**
>
> All options you can use with string interpolation are described in [String Interpolation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#String-Interpolation).
> 
> 所有可用于字符串插值的选项均在《[字符串插值](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#String-Interpolation)》中进行了描述。

## 2 Comments - 注释

Use comments to include nonexecutable text in your code, as a note or reminder to yourself. Comments are ignored by the Swift compiler when your code is compiled.

使用注释在代码中包含非可执行文本，作为给自己的说明或提醒。当编译您的代码时，Swift 编译器会忽略注释。

Comments in Swift are very similar to comments in C. Single-line comments begin with two forward-slashes (`//`):

Swift 中的注释与 C 中的注释非常相似。单行注释以两个斜杠（`//`）开头：

```
// This is a comment.
// 这是一个注释。
```

Multiline comments start with a forward-slash followed by an asterisk (`/*`) and end with an asterisk followed by a forward-slash (`*/`):

多行注释以斜杠后跟一个星号（`/*`）开始，以星号后跟一个斜杠（`*/`）结束：

```
/* This is also a comment
but is written over multiple lines. */
/* 这也是一个注释
但是可以跨多行书写。 */
```

Unlike multiline comments in C, multiline comments in Swift can be nested inside other multiline comments. You write nested comments by starting a multiline comment block and then starting a second multiline comment within the first block. The second block is then closed, followed by the first block:

与 C 中的多行注释不同，Swift 中的多行注释可以嵌套在其他多行注释中。您可以通过在一个多行注释块内开始第二个多行注释块来编写嵌套注释。然后关闭第二个块，紧接着关闭第一个块：

```
/* This is the start of the first multiline comment.
    /* This is the second, nested multiline comment. */
This is the end of the first multiline comment. */
/* 这是第一个多行注释的开始。
    /* 这是第二个嵌套的多行注释。 */
这是第一个多行注释的结束。 */
```

Nested multiline comments enable you to comment out large blocks of code quickly and easily, even if the code already contains multiline comments.

嵌套的多行注释使您能够快速轻松地注释掉大块的代码，即使代码已经包含多行注释。

## 3 Semicolons 分号

Unlike many other languages, Swift doesn’t require you to write a semicolon (`;`) after each statement in your code, although you can do so if you wish. However, semicolons are required if you want to write multiple separate statements on a single line:

与许多其他语言不同，Swift 不要求您在代码中的每个语句后面写分号（`;`），尽管如果您愿意的话可以这样做。然而，如果您想要在单行上写多个独立的语句，那么分号是必需的：

```
let cat = "🐱"; print(cat)
// Prints "🐱"
// 输出 "🐱"
```

## 4 Integers - 整数

Integers are whole numbers with no fractional component, such as `42` and `-23`. Integers are either signed (positive, zero, or negative) or unsigned (positive or zero).

整数是没有小数部分的数字，例如 `42` 和 `-23`。整数可以是有符号的（正数、零或负数）或无符号的（正数或零）。

Swift provides signed and unsigned integers in 8, 16, 32, and 64 bit forms. These integers follow a naming convention similar to C, in that an 8-bit unsigned integer is of type `UInt8`, and a 32-bit signed integer is of type `Int32`. Like all types in Swift, these integer types have capitalized names.

Swift 提供了带符号和无符号的 8、16、32 和 64 位整数形式。这些整数遵循类似于 C 的命名约定，即 8 位无符号整数的类型是 `UInt8`，32 位有符号整数的类型是 `Int32`。与 Swift 中的所有类型一样，这些整数类型的名称是大写的。

### 4.1 Integer Bounds - 整数边界

You can access the minimum and maximum values of each integer type with its `min` and `max` properties:

您可以使用 `min` 和 `max` 属性访问每种整数类型的最小值和最大值：

```
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8 // minValue 等于 0，类型为 UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8 // maxValue 等于 255，类型为 UInt8
```

The values of these properties are of the appropriate-sized number type (such as `UInt8` in the example above) and can therefore be used in expressions alongside other values of the same type.

这些属性的值是适当大小的数字类型（例如上面示例中的 `UInt8`），因此可以与相同类型的其他值一起用于表达式中。

### 4.2 Int - 整型

In most cases, you don’t need to pick a specific size of integer to use in your code. Swift provides an additional integer type, `Int`, which has the same size as the current platform’s native word size:

在大多数情况下，并不需要选择代码中使用的整数类型的大小。Swift 提供了另一个整数类型 `Int`，它的大小与当前平台的本机文字大小相同：

- On a 32-bit platform, `Int` is the same size as `Int32`.
- On a 64-bit platform, `Int` is the same size as `Int64`.
- 在 32 位平台上，`Int` 的大小与 `Int32` 相同。
- 在 64 位平台上，`Int` 的大小与 `Int64` 相同。

Unless you need to work with a specific size of integer, always use `Int` for integer values in your code. This aids code consistency and interoperability. Even on 32-bit platforms, Int can store any value between `-2,147,483,648` and `2,147,483,647`, and is large enough for many integer ranges.

除非您需要使用特定大小的整数，否则在代码中的整数值始终使用 `Int`。这有助于代码的一致性和互操作性。即使在 32 位平台上，Int 可以存储任何值介于 `-2,147,483,648` 和 `2,147,483,647` 之间，并且对于许多整数范围来说足够大。

### 3.1 UInt - 无符号整型

Swift also provides an unsigned integer type, `UInt`, which has the same size as the current platform’s native word size:

Swift 还提供了无符号整数类型 `UInt`，其大小与当前平台的本机文字大小相同：

- On a 32-bit platform, UInt is the same size as `UInt32`.
- On a 64-bit platform, UInt is the same size as `UInt64`.
- 在 32 位平台上，UInt 的大小与 `UInt32` 相同。
- 在 64 位平台上，UInt 的大小与 `UInt64` 相同。

> **Note**
>
> Use `UInt` only when you specifically need an unsigned integer type with the same size as the platform’s native word size. If this isn’t the case, `Int` is preferred, even when the values to be stored are known to be nonnegative. A consistent use of `Int` for integer values aids code interoperability, avoids the need to convert between different number types, and matches integer type inference, as described in [Type Safety and Type Inference](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Type-Safety-and-Type-Inference).
> 
> **注意**
> 
> 仅在特别需要与平台本机文字大小相同的无符号整数类型时使用 `UInt`。如果不是这种情况，最好使用 `Int`，即使要存储的值已知为非负数。对整数值一致使用 `Int` 有助于代码互操作性，避免在不同数字类型之间进行转换，并与整数类型推断匹配，如《[类型安全和类型推断](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Type-Safety-and-Type-Inference)》中所述。

## 5 Floating-Point Numbers - 浮点数

Floating-point numbers are numbers with a fractional component, such as `3.14159`, `0.1`, and `-273.15`.

浮点数是带有小数部分的数字，例如 `3.14159`、`0.1` 和 `-273.15`。

Floating-point types can represent a much wider range of values than integer types, and can store numbers that are much larger or smaller than can be stored in an `Int`. Swift provides two signed floating-point number types:

浮点类型可以表示比整数类型更广泛范围的值，并且可以存储比 `Int` 类型能够存储的更大或更小的数字。Swift 提供了两种有符号浮点数类型：

- `Double` represents a 64-bit floating-point number.
- `Float` represents a 32-bit floating-point number.
- `Double` 表示 64 位浮点数。
- `Float` 表示 32 位浮点数。

> **Note**
>
> Double has a precision of at least 15 decimal digits, whereas the precision of Float can be as little as 6 decimal digits. The appropriate floating-point type to use depends on the nature and range of values you need to work with in your code. In situations where either type would be appropriate, Double is preferred.
> 
> `Double` 的精度至少为 15 位小数，而 `Float` 的精度可能只有 6 位小数。要使用的适当浮点类型取决于您在代码中需要处理的值的性质和范围。在使用两种类型都可以的情况下，首选 `Double`。

## 6 Type Safety and Type Inference - 类型安全和类型推断

Swift is a type-safe language. A type safe language encourages you to be clear about the types of values your code can work with. If part of your code requires a `String`, you can’t pass it an `Int` by mistake.

Swift 是一种类型安全的语言。类型安全语言鼓励您明确指定代码可以处理的值的类型。如果您的代码的某一部分需要一个字符串（`String`），您不能错误地传递一个整数（`Int`）。

Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process.

由于 Swift 是类型安全的，在编译代码时会执行类型检查，并将任何不匹配的类型标记为错误。这使您能够在开发过程中尽早捕获并修复错误。

Type-checking helps you avoid errors when you’re working with different types of values. However, this doesn’t mean that you have to specify the type of every constant and variable that you declare. If you don’t specify the type of value you need, Swift uses type inference to work out the appropriate type. Type inference enables a compiler to deduce the type of a particular expression automatically when it compiles your code, simply by examining the values you provide.

类型检查帮助您在处理不同类型的值时避免错误。但这并不意味着您必须为声明的每个常量和变量指定类型。如果您没有指定所需的值的类型，Swift 将使用类型推断来确定适当的类型。类型推断使编译器能够在编译代码时自动根据您提供的值来简单的推断特定表达式的类型。

Because of type inference, Swift requires far fewer type declarations than languages such as C or Objective-C. Constants and variables are still explicitly typed, but much of the work of specifying their type is done for you.

由于有类型推断，Swift 需要的类型声明比诸如 C 或 Objective-C 等语言要少得多。常量和变量仍然是显式类型的，但大部分指定它们的类型的工作已经为您完成。

Type inference is particularly useful when you declare a constant or variable with an initial value. This is often done by assigning a literal value (or literal) to the constant or variable at the point that you declare it. (A literal value is a value that appears directly in your source code, such as `42` and `3.14159` in the examples below.)

类型推断在您声明具有初始值的常量或变量时特别有用。通常通过在声明时将字面值（或文本）赋给常量或变量来完成此操作。 （字面值是直接出现在源代码中的值，例如下面示例中的 `42` 和 `3.14159`。）

For example, if you assign a literal value of `42` to a new constant without saying what type it is, Swift infers that you want the constant to be an `Int`, because you have initialized it with a number that looks like an integer:

例如，如果将字面值 `42` 分配给一个新常量而不说明它的类型，Swift 推断您希望该常量是一个 `Int`，因为您用看起来像整数的数字对其进行了初始化：

```
let meaningOfLife = 42
// meaningOfLife is inferred to be of type Int
// meaningOfLife 被推断为 Int 类型
```

Likewise, if you don’t specify a type for a floating-point literal, Swift infers that you want to create a `Double`:

同样，如果不为浮点字面值指定类型，Swift 推断您想要创建一个 `Double`：

```
let pi = 3.14159
// pi is inferred to be of type Double
// pi 被推断为 Double 类型
```

Swift always chooses `Double` (rather than `Float`) when inferring the type of floating-point numbers.

Swift 总是在推断浮点数类型时选择 `Double`（而不是 `Float`）。

If you combine integer and floating-point literals in an expression, a type of `Double` will be inferred from the context:

如果在一个表达式中既有整数又有浮点数字面值，将从上下文中推断出 `Double` 类型：

```
let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double
// anotherPi 也被推断为 Double 类型
```

The literal value of `3` has no explicit type in and of itself, and so an appropriate output type of `Double` is inferred from the presence of a floating-point literal as part of the addition.

字面值 `3` 本身没有明确的类型，因此从加法中存在浮点数字面值的推断出适当的输出类型为 `Double`。

## 7 Numeric Literals -  数字字面值

Integer literals can be written as:

整数字面值可以写成：

- A decimal number, with no prefix
- A binary number, with a `0b` prefix
- An octal number, with a `0o` prefix
- A hexadecimal number, with a `0x` prefix
- 十进制数，没有前缀
- 二进制数，带有 `0b` 前缀
- 八进制数，带有 `0o` 前缀
- 十六进制数，带有 `0x` 前缀

All of these integer literals have a decimal value of 17:

所有这些整数字面值的十进制值都是 `17`：

```
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation // 二进制表示的 17
let octalInteger = 0o21           // 17 in octal notation // 八进制表示的 17
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation // 十六进制表示的 17
```

Floating-point literals can be decimal (with no prefix), or hexadecimal (with a `0x` prefix). They must always have a number (or hexadecimal number) on both sides of the decimal point. Decimal floats can also have an optional exponent, indicated by an uppercase or lowercase `e`; hexadecimal floats must have an exponent, indicated by an uppercase or lowercase `p`.

浮点数字面值可以是十进制（没有前缀）或十六进制（带有 `0x` 前缀）。它们必须始终在小数点的两侧都有一个数字（或十六进制数字）。十进制浮点数还可以具有可选的指数，以大写或小写的 `e` 表示；十六进制浮点数必须具有指数，以大写或小写的 `p` 表示。

For decimal numbers with an exponent of x, the base number is multiplied by 10ˣ:

对于带有 `x` 指数的十进制数，基数将乘以 `10ˣ`：

- `1.25e2` means `1.25 x 10²`, or `125.0`.
- `1.25e-2` means `1.25 x 10⁻²`, or `0.0125`.

- `1.25e2` 表示 `1.25 x 10²`，或 `125.0`。
- `1.25e-2` 表示 `1.25 x 10⁻²`，或 `0.0125`。

For hexadecimal numbers with an exponent of `x`, the base number is multiplied by `2ˣ`:

对于带有 `x` 指数的十六进制数，基数将乘以 `2ˣ`：

- `0xFp2` means `15 x 2²`, or `60.0`.
- `0xFp-2` means `15 x 2⁻²`, or `3.75`.

- `0xFp2` 表示 `15 x 2²`，或 `60.0`。
- `0xFp-2` 表示 `15 x 2⁻²`，或 `3.75`。

All of these floating-point literals have a decimal value of `12.1875`:

所有这些浮点数字面值都具有十进制值 12.1875`：

```
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

Numeric literals can contain extra formatting to make them easier to read. Both integers and floats can be padded with extra zeros and can contain underscores to help with readability. Neither type of formatting affects the underlying value of the literal:

数字字面值可以包含额外的格式，以使其更易阅读。整数和浮点数都可以用额外的零填充，并且可以包含下划线以帮助阅读。这些格式化方式都不会影响字面值的基本值：

```
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

## 8 Numeric Type Conversion - 数字类型转换

Use the `Int` type for all general-purpose integer constants and variables in your code, even if they’re known to be nonnegative. Using the default integer type in everyday situations means that integer constants and variables are immediately interoperable in your code and will match the inferred type for integer literal values.

在代码中，对于所有一般用途的整数常量和变量，请使用 `Int` 类型，即使已知它们是非负的。在日常情况下使用默认整数类型意味着整数常量和变量在您的代码中是立即可互操作的，并且将与整数字面值的推断类型匹配。

Use other integer types only when they’re specifically needed for the task at hand, because of explicitly sized data from an external source, or for performance, memory usage, or other necessary optimization. Using explicitly sized types in these situations helps to catch any accidental value overflows and implicitly documents the nature of the data being used.

仅在特定任务需要时使用其他整数类型，比如因为来自外部来源的显式大小数据，或出于性能、内存使用或其他必要的优化考虑。在这些情况下使用显式大小类型有助于捕获任何意外值溢出，并隐含地记录所使用数据的性质。

### 8.1 Integer Conversion - 整数转换

The range of numbers that can be stored in an integer constant or variable is different for each numeric type. An `Int8` constant or variable can store numbers between `-128` and `127`, whereas a `UInt8` constant or variable can store numbers between `0` and `255`. A number that won’t fit into a constant or variable of a sized integer type is reported as an error when your code is compiled:

每种数字类型可以存储的数字范围都不同。`Int8` 常量或变量可以存储 `-128` 到 `127` 之间的数字，而 `UInt8` 常量或变量可以存储 `0` 到 `255` 之间的数字。如果一个数字无法适应指定大小的整数类型的常量或变量，则在编译代码时将报告错误：

```
let cannotBeNegative: UInt8 = -1
// UInt8 can't store negative numbers, and so this will report an error
// UInt8 不能存储负数，因此这将报告错误
let tooBig: Int8 = Int8.max + 1
// Int8 can't store a number larger than its maximum value,
// and so this will also report an error
// Int8 无法存储大于其最大值的数字，
// 因此这也将报告错误
```

Because each numeric type can store a different range of values, you must opt in to numeric type conversion on a case-by-case basis. This opt-in approach prevents hidden conversion errors and helps make type conversion intentions explicit in your code.

由于每种数字类型可以存储不同范围的值，您必须逐个案例选择加入数字类型转换。这种主动选择方法可以防止隐藏的转换错误，并有助于在代码中显式地展示类型转换意图。

To convert one specific number type to another, you initialize a new number of the desired type with the existing value. In the example below, the constant `twoThousand` is of type `UInt16`, whereas the constant `one` is of type `UInt8`. They can’t be added together directly, because they’re not of the same type. Instead, this example calls `UInt16(one)` to create a new `UInt16` initialized with the value of `one`, and uses this value in place of the original:

要将一种特定数字类型转换为另一种，您可以使用现有值初始化所需类型的新数字。在下面的示例中，常量 `twoThousand` 是 `UInt16` 类型，而常量 `one` 是 `UInt8` 类型。它们不能直接相加，因为它们不是相同类型。取而代之的是，该示例调用 `UInt16(one)` 来创建一个新的 `UInt16`，其值为 `one` 的值，并将此值用于原始值的位置：

```
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

Because both sides of the addition are now of type `UInt16`, the addition is allowed. The output constant (`twoThousandAndOne`) is inferred to be of type `UInt16`, because it’s the sum of two `UInt16` values.

因为加法两侧现在都是 `UInt16` 类型，所以允许相加。输出常量（`twoThousandAndOne`）被推断为 `UInt16` 类型，因为它是两个 `UInt16` 值的和。

`SomeType(ofInitialValue)` is the default way to call the initializer of a Swift type and pass in an initial value. Behind the scenes, `UInt16` has an initializer that accepts a `UInt8` value, and so this initializer is used to make a new `UInt16` from an existing `UInt8`. You can’t pass in any type here, however — it has to be a type for which `UInt16` provides an initializer. Extending existing types to provide initializers that accept new types (including your own type definitions) is covered in [Extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions).

`SomeType(ofInitialValue)` 是调用 Swift 类型的初始化程序并传递初始值的默认方式。在幕后，`UInt16` 有一个接受 `UInt8` 值的初始化程序，从而此初始化程序可以从现有的 `UInt8` 创建一个新的 `UInt16`。但是在这里您不能传递任意类型 — 它必须是 `UInt16` 提供初始化程序的类型。扩展现有类型以提供接受新类型的初始化程序（包括您自己的类型定义）的方法在《[扩展](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions)》中有所涵盖。

### 8.2 Integer and Floating-Point Conversion - 整数和浮点数的转换

Conversions between integer and floating-point numeric types must be made explicit:

整数和浮点数之间的转换必须明确指定：

```
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
// pi 等于 3.14159，并被推断为 Double 类型
```

Here, the value of the constant `three` is used to create a new value of type `Double`, so that both sides of the addition are of the same type. Without this conversion in place, the addition would not be allowed.

在这里，常量 `three` 的值用于创建一个新的 `Double` 类型的值，以使加法两侧类型相同。如果没有进行这种转换，加法将不被允许。

Floating-point to integer conversion must also be made explicit. An integer type can be initialized with a `Double` or `Float` value:

浮点数到整数的转换也必须明确指定。整数类型可以用 `Double` 或 `Float` 值初始化：

```
let integerPi = Int(pi)
// integerPi equals 3, and is inferred to be of type Int
// integerPi 等于 3，并被推断为 Int 类型
```

Floating-point values are always truncated when used to initialize a new integer value in this way. This means that `4.75` becomes `4`, and `-3.9` becomes `-3`.

以这种方式用于初始化新整数值时，浮点数值总是被截断。这意味着 `4.75` 变为 `4`，`-3.9` 变为 `-3`。

> **Note** **注意**
>
> The rules for combining numeric constants and variables are different from the rules for numeric literals. The literal value `3` can be added directly to the literal value `0.14159`, because number literals don’t have an explicit type in and of themselves. Their type is inferred only at the point that they’re evaluated by the compiler.
> 
> 组合数字常量和变量的规则与数字字面值的规则不同。字面值 `3` 可以直接添加到字面值 `0.14159`，因为数字字面值本身没有显式类型。它们的类型仅在编译器评估它们时推断。

## 9 Type Aliases - 类型别名

Type aliases define an alternative name for an existing type. You define type aliases with the `typealias` keyword.

类型别名为现有类型定义了一个替代名称。您可以使用 `typealias` 关键字定义类型别名。

Type aliases are useful when you want to refer to an existing type by a name that’s contextually more appropriate, such as when working with data of a specific size from an external source:

在处理来自外部来源的特定大小数据时，当您希望使用更具上下文意义的名称引用现有类型时，类型别名就非常有用：

```
typealias AudioSample = UInt16
```

Once you define a type alias, you can use the alias anywhere you might use the original name:

一旦定义了类型别名，您可以在任何可能使用原始名称的地方使用该别名：

```
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound is now 0
// maxAmplitudeFound 现在是 0
```

Here, `AudioSample` is defined as an alias for `UInt16`. Because it’s an alias, the call to `AudioSample.min` actually calls `UInt16.min`, which provides an initial value of `0` for the `maxAmplitudeFound` variable.

在这里，`AudioSample` 被定义为 `UInt16` 的别名。因为它是一个别名，对 `AudioSample.min` 的调用实际上调用了 `UInt16.min`，为 `maxAmplitudeFound` 变量提供了初始值 `0`。

## 10 Booleans - 布尔值

Swift has a basic _Boolean_ type, called `Bool`. Boolean values are referred to as _logical_, because they can only ever be true or false. Swift provides two Boolean constant values, `true` and `false`:

Swift 有一个基本的 _布尔（Boolean）_ 类型，叫做 `Bool`。布尔值指 _逻辑_ 上的值，因为它们只能是真或者假。Swift提供了两个布尔常量值，`true` 和 `false`：

```
let orangesAreOrange = true
let turnipsAreDelicious = false
```

The types of `orangesAreOrange` and `turnipsAreDelicious` have been inferred as Bool from the fact that they were initialized with Boolean literal values. As with `Int` and `Double` above, you don’t need to declare constants or variables as `Bool` if you set them to `true` or `false` as soon as you create them. Type inference helps make Swift code more concise and readable when it initializes constants or variables with other values whose type is already known.

`orangesAreOrange` 和 `turnipsAreDelicious` 的类型会被推断为 `Bool`，因为它们的初始值是布尔字面量。就像之前提到的 `Int` 和 `Double` 一样，如果你创建变量的时候给它们赋值 `true` 或者 `false`，那你不需要将常量或者变量声明为 `Bool` 类型。类型推断有助于使 Swift 代码在使用已知类型的其他值初始化常量或变量时更简洁和可读。

Boolean values are particularly useful when you work with conditional statements such as the `if` statement:

当您处理条件语句（如 `if` 语句）时，布尔值特别有用：

```
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// Prints "Eww, turnips are horrible."
// 输出 "Eww, turnips are horrible."
```

Conditional statements such as the `if` statement are covered in more detail in [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow).

条件语句，例如 `if` 语句，在《[控制流](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)》中有更详细的介绍。

Swift’s type safety prevents non-Boolean values from being substituted for `Bool`. The following example reports a compile-time error:

如果你在需要使用 `Bool` 类型的地方使用了非布尔值，Swift 的类型安全机制会报错。下面的例子会报告一个编译时错误：

```
let i = 1
if i {
    // this example will not compile, and will report an error
    // 这个示例将无法编译，并报告一个错误
}
```

However, the alternative example below is valid:

然而，下面的例子是合法的：

```
let i = 1
if i == 1 {
    // this example will compile successfully
    // 这个例子会编译成功
}
```

The result of the `i == 1` comparison is of type `Bool`, and so this second example passes the type-check. Comparisons like `i == 1` are discussed in [Basic Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators).

`i == 1` 比较的结果是 `Bool` 类型，因此第二个示例通过了类型检查。像 `i == 1` 这样的比较在《[基本运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators)》中有讨论。

As with other examples of type safety in Swift, this approach avoids accidental errors and ensures that the intention of a particular section of code is always clear.

与 Swift 中其他类型安全示例一样，这种方法避免了意外错误，并确保代码中这一部分的意图始终是清晰的。

## 11 Tuples - 元组

_Tuples_ group multiple values into a single compound value. The values within a tuple can be of any type and don’t have to be of the same type as each other.

_元组_ 把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型。

In this example, `(404, "Not Found")` is a tuple that describes an _HTTP status code_. An HTTP status code is a special value returned by a web server whenever you request a web page. A status code of `404 Not Found` is returned if you request a webpage that doesn’t exist.

在这个例子中，(404, "Not Found") 是一个描述 _HTTP 状态码_ 的元组。HTTP 状态码是 Web 服务器在您请求网页时返回的特殊值。如果您请求一个不存在的网页，将返回 `404 Not Found` 状态码。

```
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
// http404Error 的类型是 (Int, String)，其值等于 (404, "Not Found")
```

The `(404, "Not Found")` tuple groups together an `Int` and a `String` to give the HTTP status code two separate values: a number and a human-readable description. It can be described as “a tuple of type `(Int, String)`”.

`(404, "Not Found")` 元组将一个 `Int` 和一个 `String` 组合在一起，为 HTTP 状态码提供了两个单独的值：一个数字和一个人类可读的描述。它可以被描述为“一个 `(Int, String)` 类型的元组”。

You can create tuples from any permutation of types, and they can contain as many different types as you like. There’s nothing stopping you from having a tuple of type `(Int, Int, Int)`, or `(String, Bool)`, or indeed any other permutation you require.

您可以从任何类型的排列组合创建元组，它们可以包含任意多种不同类型。您可以拥有 `(Int, Int, Int)` 类型的元组，或 `(String, Bool)` 类型的元组，或者您需要的任何其他排列组合。

You can decompose a tuple’s contents into separate constants or variables, which you then access as usual:

您可以将元组的内容分解为单独的常量或变量，然后像平常一样访问它们：

```
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
// 输出 "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
// 输出 "The status message is Not Found"
```

If you only need some of the tuple’s values, ignore parts of the tuple with an underscore (`_`) when you decompose the tuple:

如果您只需要元组的部分值，在分解元组时可以使用下划线(`_`)忽略元组的一部分：

```
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"
// 输出“The status code is 404”
```

Alternatively, access the individual element values in a tuple using index numbers starting at zero:

此外，你还可以通过下标来访问元组中的单个元素，下标从零开始：

```
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
// 输出“The status code is 404”
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
// 输出 "The status message is Not Found"
```

You can name the individual elements in a tuple when the tuple is defined:

当定义元组时，您可以为元组中的各个元素命名：

```
let http200Status = (statusCode: 200, description: "OK")
```

If you name the elements in a tuple, you can use the element names to access the values of those elements:

如果已为元组中的元素命名，您可以使用元素名称访问这些元素的值：

```
print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
// 输出 "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"
// 输出 "The status message is OK"
```

Tuples are particularly useful as the return values of functions. A function that tries to retrieve a web page might return the `(Int, String)` tuple type to describe the success or failure of the page retrieval. By returning a tuple with two distinct values, each of a different type, the function provides more useful information about its outcome than if it could only return a single value of a single type. For more information, see [Functions with Multiple Return Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions#Functions-with-Multiple-Return-Values).

元组特别适合作为函数的返回值。一个尝试检索网页的函数可能会返回 `(Int, String)` 类型的元组，以描述页面检索的成功或失败。通过返回一个具有两个不同类型值的元组，函数提供了关于其结果的更有用信息，而不仅仅返回单一类型的单个值。有关更多信息，请参阅《[具有多个返回值的函数](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions#Functions-with-Multiple-Return-Values)》。

> **Note** **说明**
>
> Tuples are useful for simple groups of related values. They’re not suited to the creation of complex data structures. If your data structure is likely to be more complex, model it as a class or structure, rather than as a tuple. For more information, see [Structures and Classes](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures).
> 
> 元组适用于简单的相关值组。它们不适合用于创建复杂的数据结构。如果您的数据结构可能更复杂，请使用为类或结构为其建模，而不是元组。有关更多信息，请参阅《[结构体和类](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures)》。

## 12 Optionals - 可选类型

You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value of a specified type, and you can unwrap the optional to access that value, or there isn’t a value at all.

在值可能缺失的情况下，您可以使用可选类型。可选类型表示两种可能性：要么存在指定类型的值，您可以解析可选类型以访问该值，要么根本没有值。

As an example of a value that might be missing, Swift’s `Int` type has an initializer that tries to convert a `String` value into an `Int` value. However, only some strings can be converted into integers. The string `"123"` can be converted into the numeric value `123`, but the string `"hello, world"` doesn’t have a corresponding numeric value. The example below uses the initializer to try to convert a `String` into an `Int`:

举个可能缺失的值的例子，Swift 的 `Int` 类型有一个初始化方法，试图将 `String` 值转换为 `Int` 值。然而，只有一些字符串可以转换为整数。字符串 `"123"` 可以转换为数值 `123`，但字符串 `"hello, world"` 没有对应的数值。下面的示例使用初始化程序尝试将一个 `String` 转换为一个 `Int`：

```
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// The type of convertedNumber is "optional Int"
// convertedNumber 的类型是 "可选 Int"
```

Because the initializer in the code above might fail, it returns an _optional_ `Int`, rather than an `Int`.

因为上面代码中的初始化程序可能失败，它返回一个 _可选_ `Int`，而不是一个 `Int`。

To write an optional type, you write a question mark (`?`) after the name of the type that the optional contains — for example, the type of an optional `Int` is `Int?`. An optional `Int` always contains either some `Int` value or no value at all. It can’t contain anything else, like a `Bool` or `String` value.

要写一个可选类型，您可以在可选包含的类型名称后面写一个问号（`?`）——例如，可选 `Int` 的类型是 `Int?`。一个可选 `Int` 总是包含一些 `Int` 值或根本没有值。它不能包含其他任何东西，比如 `Bool` 或 `String` 值。

### 12.1 nil

You set an optional variable to a valueless state by assigning it the special value `nil`:

通过将特殊值 `nil` 赋给可选变量，您可以将其设置为无值状态：

```
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
// serverResponseCode 包含实际的 Int 值 404
serverResponseCode = nil
// serverResponseCode now contains no value
// serverResponseCode 现在不包含任何值
```

If you define an optional variable without providing a default value, the variable is automatically set to `nil`:

如果您定义一个可选变量而没有提供默认值，该变量会自动设置为 `nil`：

```
var surveyAnswer: String?
// surveyAnswer is automatically set to nil
// surveyAnswer 会自动设置为 nil
```

You can use an `if` statement to find out whether an optional contains a value by comparing the optional against `nil`. You perform this comparison with the “equal to” operator (`==`) or the “not equal to” operator (`!=`).

您可以使用 `if` 语句通过将可选变量与 `nil` 进行比较来查找可选变量是否包含值。您可以使用“等于”运算符（`==`）或“不等于”运算符（`!=`）进行此比较。

If an optional has a value, it’s considered as “not equal to” `nil`:

如果可选变量包含值，则被视为“不等于” `nil`：

```
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)


if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// Prints "convertedNumber contains some integer value."
// 输出 "convertedNumber 包含一些整数值。"
```

You can’t use `nil` with non-optional constants or variables. If a constant or variable in your code needs to work with the absence of a value under certain conditions, declare it as an optional value of the appropriate type. A constant or variable that’s declared as a non-optional value is guaranteed to never contain a `nil` value. If you try to assign `nil` to a non-optional value, you’ll get a compile-time error.

您不能在非可选常量或变量中使用 `nil`。如果您的代码中的常量或变量需要在特定条件下处理值的缺失，将其声明为适当类型的可选值。声明为非可选值的常量或变量保证永远不会包含 `nil` 值。如果尝试将 `nil` 赋给非可选值，将在编译时出现错误。

This separation of optional and non-optional values lets you explicitly mark what information can be missing, and makes it easier to write code that handle missing values. You can’t accidentally treat an optional as if it were non-optional because this mistake produces an error at compile time. After you unwrap the value, none of the other code that works with that value needs to check for `nil`, so there’s no need to repeatedly check the same value in different parts of your code.

可选值和非可选值的区分使您能够明确标记哪些信息可能缺失，并更容易编写处理缺失值的代码。您不会意外地将可选值作为非可选值，因为此操作会在编译时产生错误。在解包值后，处理该值的其他代码无需检查 `nil`，因此无需在代码的不同部分重复检查相同的值。

When you access an optional value, your code always handles both the `nil` and non-`nil` case. There are several things you can do when a value is missing, as described in the following sections:

当访问可选值时，您的代码始终要处理 `nil` 和非 `nil` 情况。当值缺失时，您可以执行以下几种操作，如下所述：

- Skip the code that operates on the value when it’s `nil`.
- Propagate the `nil` value, by returning `nil` or using the `?.` operator described in [Optional Chaining](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining).
- Provide a fallback value, using the `??` operator.
- Stop program execution, using the `!` operator.

- 在值为 `nil` 时跳过操作该值的代码。
- 通过返回 `nil` 或使用 `?.` 运算符传递 `nil` 值，如《[可选链](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining)》中所述。
- 使用 `??` 运算符提供备用值。
- 使用 `!` 运算符停止程序执行。

> **Note** **说明**
>
> In Objective-C, `nil` is a pointer to a nonexistent object. In Swift, `nil` isn’t a pointer — it’s the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types.
> 
> 在 Objective-C 中，`nil` 是指向不存在对象的指针。在 Swift 中，`nil` 不是指针 —— 它是某种类型的值的缺失。任何类型的可选值都可以设置为 `nil`，而不仅仅是对象类型。

### 12.2 Optional Binding - 可选绑定

You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with `if`, `guard`, and `while` statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action. For more information about `if`, `guard`, and `while` statements, see [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow).

你可以使用可选绑定来查找可选型是否包含值；如果包含值，则将该值作为临时常量或变量提取出来。可选绑定可以与 `if`、`guard` 和 `while` 语句一起使用，以检查可选型中是否有值，并将该值提取为常量或变量，作为单个操作的一部分。有关 `if`、`guard` 和 `while` 语句的更多信息，请参阅《[控制流](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)》。

Write an optional binding for an `if` statement as follows:

按照下面的方式编写 `if` 语句的可选绑定：

```
if let <#constantName#> = <#someOptional#> {
   <#statements#>
}
```

You can rewrite the possibleNumber example from the [Optionals](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals) section to use optional binding rather than forced unwrapping:

您可以重写《[可选类型](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Optionals)》部分中的 `possibleNumber` 示例，使用可选绑定而不是强制解包：

```
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}
// Prints "The string "123" has an integer value of 123"
// 输出 "The string "123" has an integer value of 123"
```

This code can be read as:

这段代码可以理解为：

“If the optional `Int` returned by `Int(possibleNumber)` contains a value, set a new constant called `actualNumber` to the value contained in the optional.”

“如果由 `Int(possibleNumber)` 返回的可选 `Int` 包含一个值，则将一个名为 `actualNumber` 的新常量设置为可选型中包含的值。”

If the conversion is successful, the `actualNumber` constant becomes available for use within the first branch of the if statement. It has already been initialized with the value contained within the optional, and has the corresponding non-optional type. In this case, the type of `possibleNumber` is `Int?`, so the type of `actualNumber` is `Int`.

如果转换成功，`actualNumber` 常量将在 `if` 语句的第一个分支内可用。它已经被初始化为可选型中包含的值，并具有相应的非可选类型。在此情况下，`possibleNumber` 的类型是 `Int?`，因此 `actualNumber` 的类型是 `Int`。

If you don’t need to refer to the original, optional constant or variable after accessing the value it contains, you can use the same name for the new constant or variable:

如果在访问可选值包含的值后不需要引用原始的可选常量或变量，您可以为新常量或变量使用相同的名称：

```
let myNumber = Int(possibleNumber)
// Here, myNumber is an optional integer
// 这里，myNumber 是一个可选整数
if let myNumber = myNumber {
    // Here, myNumber is a non-optional integer
    // 这里，myNumber 是一个非可选整数
    print("My number is \(myNumber)")
}
// Prints "My number is 123"
// 输出 "My number is 123"
```

This code starts by checking whether `myNumber` contains a value, just like the code in the previous example. If `myNumber` has a value, the value of a new constant named `myNumber` is set to that value. Inside the body of the if statement, writing `myNumber` refers to that new non-optional constant. Writing `myNumber` before or after the if statement refers to the original optional integer constant.

这段代码首先检查 `myNumber` 是否包含一个值，就像前面示例中的代码一样。如果 `myNumber` 有一个值，新常量 `myNumber` 的值将设置为该值。在 `if` 语句的主体内写 `myNumber` 将引用该新的非可选常量。在 `if` 语句之前或之后写 `myNumber` 将引用原始的可选整数常量。

Because this kind of code is so common, you can use a shorter spelling to unwrap an optional value: Write just the name of the constant or variable that you’re unwrapping. The new, unwrapped constant or variable implicitly uses the same name as the optional value.

由于这种代码非常常见，您可以使用更短的拼写来解包一个可选值：只需写出您要解包的常量或变量的名称。新的解包后的常量或变量隐式地使用与可选值相同的名称。

```
if let myNumber {
    print("My number is \(myNumber)")
}
// Prints "My number is 123"
// 输出 "My number is 123"
```

You can use both constants and variables with optional binding. If you wanted to manipulate the value of `myNumber` within the first branch of the `if` statement, you could write `if var myNumber` instead, and the value contained within the optional would be made available as a variable rather than a constant. Changes you make to `myNumber` inside the body of the `if` statement apply only to that local variable, not to the original, optional constant or variable that you unwrapped.

您可以在可选绑定中使用常量和变量。如果您想要在 `if` 语句的第一个分支内操作 `myNumber` 的值，可以写成 `if var myNumber`，这样可选型中包含的值将作为变量而不是常量提供。您在 `if` 语句的主体内对 `myNumber` 所做的更改仅适用于该本地变量，而不适用于您解包的原始可选常量或变量。

You can include as many optional bindings and Boolean conditions in a single `if` statement as you need to, separated by commas. If any of the values in the optional bindings are `nil` or any Boolean condition evaluates to `false`, the whole `if` statement’s condition is considered to be `false`. The following if statements are equivalent:

您可以在单个 `if` 语句中包含尽可能多的可选绑定和布尔条件，用逗号分隔。如果可选绑定中的任何值为 `nil`，或者任何布尔条件求值为 `false`，则整个 `if` 语句的条件将被视为 `false`。以下 `if` 语句是等效的：

```
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"
// 输出 "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"
// 输出 "4 < 42 < 100"
```

Constants and variables created with optional binding in an `if` statement are available only within the body of the `if` statement. In contrast, the constants and variables created with a `guard` statement are available in the lines of code that follow the `guard` statement, as described in [Early Exit](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#Early-Exit).

在 `if` 语句中使用可选绑定创建的常量和变量仅在 `if` 语句体内可用。相比之下，使用 `guard` 语句创建的常量和变量在 `guard` 语句后的代码行中可用，如《[提前退出](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#Early-Exit)》中所述。

### 12.3 Providing a Fallback Value - 提供备用值

Another way to handle a missing value is to supply a default value using the nil-coalescing operator (`??`). If the optional on the left of the `??` isn’t `nil`, that value is unwrapped and used. Otherwise, the value on the right of `??` is used. For example, the code below greets someone by name if one is specified, and uses a generic greeting when the name is `nil`.

处理缺失值的另一种方法是使用空合并运算符（`??`）提供一个默认值。如果 `??` 左侧的可选值不为 `nil`，则解包并使用该值。否则，使用 `??` 右侧的值。例如，下面的代码根据指定的名称向某人打招呼，当名称为 `nil` 时使用通用的问候语。

```
let name: String? = nil
let greeting = "Hello, " + (name ?? "friend") + "!"
print(greeting)
// Prints "Hello, friend!"
// 输出 "Hello, friend!"
```

For more information about using `??` to provide a fallback value, see [Nil-Coalescing Operator](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Nil-Coalescing-Operator).

有关使用 `??` 提供备用值的更多信息，请参阅《[空合并运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Nil-Coalescing-Operator)》。

### 12.4 Force Unwrapping - 强制解包

When `nil` represents an unrecoverable failure, such as a programmer error or corrupted state, you can access the underlying value by adding an exclamation mark (`!`) to the end of the optional’s name. This is known as force unwrapping the optional’s value. When you force unwrap a non-`nil` value, the result is its unwrapped value. Force unwrapping a `nil` value triggers a runtime error.

当 `nil` 表示无法恢复的失败，例如程序员错误或损坏状态时，您可以通过在可选名称的末尾添加感叹号（`!`）来访问基础值。这被称为强制解包可选值。当您强制解包一个非 `nil` 值时，结果是其解包的值。强制解包 `nil` 值会触发运行时错误。

The `!` is, effectively, a shorter spelling of `fatalError(_:file:line:)`. For example, the code below shows two equivalent approaches:

感叹号（`!`）实际上是 `fatalError(_:file:line:)` 的一种简写。例如，下面的代码展示了两种等效的做法：

```
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

let number = convertedNumber!

guard let number = convertedNumber else {
    fatalError("The number was invalid")
}
```

Both versions of the code above depend on `convertedNumber` always containing a value. Writing that requirement as part of the code, using either of the approaches above, lets your code check that the requirement is true at runtime.

上面的两个版本的代码都依赖于 `convertedNumber` 始终包含一个值。通过将该要求作为代码的一部分写入，并使用上述任一方法，您的代码可以在运行时检查该要求是否为真。

For more information about enforcing data requirements and checking assumptions at runtime, see [Assertions and Preconditions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Assertions-and-Preconditions).

有关强制执行数据要求和在运行时检查假设的更多信息，请参阅《[断言和前提条件](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Assertions-and-Preconditions)》。

### 12.5 Implicitly Unwrapped Optionals - 隐式解包可选类型

As described above, optionals indicate that a constant or variable is allowed to have “no value”. Optionals can be checked with an `if` statement to see if a value exists, and can be conditionally unwrapped with optional binding to access the optional’s value if it does exist.

如上所述，可选类型表示常量或变量可以“没有值”。可选类型可以通过 `if` 语句进行检查，以查看是否存在值，并可以通过可选绑定进行条件解包，以访问可选值（如果存在）。

Sometimes it’s clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it’s useful to remove the need to check and unwrap the optional’s value every time it’s accessed, because it can be safely assumed to have a value all of the time.

有时，从程序结构中可以清楚地看出，在设置值后，可选类型将始终具有一个值。在这些情况下，消除每次访问时检查和解包可选值的需求是可行的，因为可以安全地假定它始终具有值。

These kinds of optionals are defined as implicitly unwrapped optionals. You write an implicitly unwrapped optional by placing an exclamation point (`String!`) rather than a question mark (`String?`) after the type that you want to make optional. Rather than placing an exclamation point after the optional’s name when you use it, you place an exclamation point after the optional’s type when you declare it.

这种类型的可选类型被定义为隐式解包可选类型。您可以通过在要使其可选的类型后面放置感叹号（`String!`）而不是问号（`String?`）来编写隐式解包的可选类型。在使用时不是在可选名称后面放置感叹号，而是在声明时在可选类型后面放置感叹号。

Implicitly unwrapped optionals are useful when an optional’s value is confirmed to exist immediately after the optional is first defined and can definitely be assumed to exist at every point thereafter. The primary use of implicitly unwrapped optionals in Swift is during class initialization, as described in [Unowned References and Implicitly Unwrapped Optional Properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting#Unowned-References-and-Implicitly-Unwrapped-Optional-Properties).

隐式解包可选类型在以下情况下非常有用：当在可选类型首次定义后立即确认存在值，并且可以确定在此后的每个点上都存在值时。在 Swift 中，隐式解包可选类型的主要用途是在类初始化期间，如《[无主引用和隐式解包可选属性](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting#Unowned-References-and-Implicitly-Unwrapped-Optional-Properties)》中所述。

Don’t use an implicitly unwrapped optional when there’s a possibility of a variable becoming `nil` at a later point. Always use a normal optional type if you need to check for a `nil` value during the lifetime of a variable.

不要在变量有可能在以后变为 `nil` 的情况下使用隐式解包可选类型。如果需要在变量的生命周期内检查 `nil` 值，请始终使用普通可选类型。

An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a non-optional value, without the need to unwrap the optional value each time it’s accessed. The following example shows the difference in behavior between an optional string and an implicitly unwrapped optional string when accessing their wrapped value as an explicit `String`:

隐式解包可选类型在幕后是普通可选类型，但也可以像非可选值一样使用，无需每次访问时解包可选值。下面的示例展示了在明确知道包装值是 `String` 时，访问可选字符串和隐式解包可选字符串之间行为的差异：

```
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // Requires explicit unwrapping // 需要显式解包

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // Unwrapped automatically // 自动解包
```

You can think of an implicitly unwrapped optional as giving permission for the optional to be force-unwrapped if needed. When you use an implicitly unwrapped optional value, Swift first tries to use it as an ordinary optional value; if it can’t be used as an optional, Swift force-unwraps the value. In the code above, the optional value `assumedString` is force-unwrapped before assigning its value to implicitString because `implicitString` has an explicit, non-optional type of `String`. In code below, `optionalString` doesn’t have an explicit type so it’s an ordinary optional.

你可以将隐式解包可选类型视为在需要时允许强制解包可选值的许可。当你使用隐式解包可选值时，Swift 首先尝试将其用作普通可选值；如果无法将其用作可选值，Swift 将强制解包该值。在上面的代码中，可选值 `assumedString` 在赋值给 `implicitString` 之前被强制解包，因为 `implicitString` 具有显式的非可选类型 `String`。在下面的代码中，`optionalString` 没有显式类型，因此它是普通可选值。

```
let optionalString = assumedString
// The type of optionalString is "String?" and assumedString isn't force-unwrapped.
// optionalString 的类型为 "String?"，assumedString 没有被强制解包。
```

If an implicitly unwrapped optional is `nil` and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you write an exclamation point to force unwrap a normal optional that doesn’t contain a value.

如果隐式解包可选值为 `nil`，并尝试访问其包装值，将触发运行时错误。结果与尝试强制解包不包含值的普通可选值时写感叹号完全相同。

You can check whether an implicitly unwrapped optional is `nil` the same way you check a normal optional:

你可以像检查普通可选值一样检查隐式解包可选值是否为 `nil`：

```
if assumedString != nil {
    print(assumedString!)
}
// Prints "An implicitly unwrapped optional string."
// 输出 "An implicitly unwrapped optional string."
```

You can also use an implicitly unwrapped optional with optional binding, to check and unwrap its value in a single statement:

你还可以使用隐式解包可选值与可选绑定一起使用，以在单个语句中检查并解包其值：

```
if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."
// 输出 "An implicitly unwrapped optional string."
```

## 13 Error Handling - 错误处理

You use error handling to respond to error conditions your program may encounter during execution.

您使用错误处理来响应程序在执行过程中可能遇到的错误情况。

In contrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.

与可选类型不同，可选类型使用值的存在或不存在来传达函数的成功或失败，而错误处理允许您确定失败的根本原因，并在必要时将错误传播到程序的另一部分。

When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately.

当函数遇到错误条件时，它会抛出一个错误。然后该函数的调用者可以捕获错误并做出适当的响应。

```
func canThrowAnError() throws {
    // this function may or may not throw an error
    // 这个函数可能会也可能不会抛出一个错误
}
```

A function indicates that it can throw an error by including the `throws` keyword in its declaration. When you call a function that can throw an error, you prepend the `try` keyword to the expression.

一个函数通过在声明中包含 `throws` 关键字来指示它可能会抛出错误。当您调用一个可能会抛出错误的函数时，您需要在表达式前加上 `try` 关键字。

Swift automatically propagates errors out of their current scope until they’re handled by a `catch` clause.

Swift会自动将错误传播到当前作用域之外，直到被 `catch` 子句处理。

```
do {
    try canThrowAnError()
    // no error was thrown
    // 没有抛出错误
} catch {
    // an error was thrown
    // 抛出了错误
}
```

A `do` statement creates a new containing scope, which allows errors to be propagated to one or more `catch` clauses.

`do` 语句创建一个新的包含作用域，允许错误被传播到一个或多个 `catch` 子句。

Here’s an example of how error handling can be used to respond to different error conditions:

以下是一个示例，说明了如何使用错误处理来应对不同的错误情况：

```
func makeASandwich() throws {
    // ...
}


do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
```

In this example, the `makeASandwich()` function will throw an error if no clean dishes are available or if any ingredients are missing. Because `makeASandwich()` can throw an error, the function call is wrapped in a `try` expression. By wrapping the function call in a `do` statement, any errors that are thrown will be propagated to the provided `catch` clauses.

在这个例子中，如果没有干净的餐具可用或任何原料缺失，`makeASandwich()` 函数将抛出错误。由于 `makeASandwich()` 可能会抛出错误，函数调用被包装在一个 `try` 表达式中。通过将函数调用包装在 `do` 语句中，任何抛出的错误将传播到提供的 `catch` 子句。

If no error is thrown, the `eatASandwich()` function is called. If an error is thrown and it matches the `SandwichError.outOfCleanDishes` case, then the `washDishes()` function will be called. If an error is thrown and it matches the `SandwichError.missingIngredients` case, then the `buyGroceries(_:)` function is called with the associated `[String]` value captured by the catch pattern.

如果没有抛出错误，则调用 `eatASandwich()` 函数。如果抛出错误且匹配 `SandwichError.outOfCleanDishes` 情况，则将调用 `washDishes()` 函数。如果抛出错误且匹配 `SandwichError.missingIngredients` 情况，则使用捕获的关联 `[String]` 值调用 `buyGroceries(_:)` 函数。

Throwing, catching, and propagating errors is covered in greater detail in [Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling).

抛出、捕获和传播错误在《[错误处理](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling)》中有更详细的介绍。

## 14 Assertions and Preconditions - 断言和先决条件

_Assertions_ and _preconditions_ are checks that happen at runtime. You use them to make sure an essential condition is satisfied before executing any further code. If the Boolean condition in the assertion or precondition evaluates to `true`, code execution continues as usual. If the condition evaluates to `false`, the current state of the program is invalid; code execution ends, and your app is terminated.

_断言_和_先决条件_是在运行时发生的检查。您可以使用它们来确保在执行任何进一步的代码之前满足一个重要条件。如果断言或先决条件中的布尔条件评估为真，则代码执行会像往常一样继续。如果条件评估为假，则程序的当前状态无效；代码执行终止，您的应用程序被终止。

You use assertions and preconditions to express the assumptions you make and the expectations you have while coding, so you can include them as part of your code. Assertions help you find mistakes and incorrect assumptions during development, and preconditions help you detect issues in production.

您使用断言和先决条件来表达您在编码过程中所做的假设和期望，这样您可以将它们作为代码的一部分包含在内。断言帮助您在开发过程中找到错误和不正确的假设，而先决条件则帮助您检测生产环境中的问题。

In addition to verifying your expectations at runtime, assertions and preconditions also become a useful form of documentation within the code. Unlike the error conditions discussed in [Error Handling](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Error-Handling) above, assertions and preconditions aren’t used for recoverable or expected errors. Because a failed assertion or precondition indicates an invalid program state, there’s no way to catch a failed assertion. Recovering from an invalid state is impossible. When an assertion fails, at least one piece of the program’s data is invalid — but you don’t know why it’s invalid or whether an additional state is also invalid.

除了在运行时验证您的期望之外，断言和先决条件还成为代码中的一种有用的文档形式。与上文《[错误处理](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/thebasics#Error-Handling)》中的错误条件不同，断言和先决条件不用于可恢复或预期的错误。因为失败的断言或前提条件表示程序状态无效，所以无法捕获失败的断言。从无效状态中恢复是不可能的。当一个断言失败时，程序的至少一个数据项是无效的 — 但您不知道为什么它是无效的，或者是否还有其他状态也是无效的。

Using assertions and preconditions isn’t a substitute for designing your code in such a way that invalid conditions are unlikely to arise. However, using them to enforce valid data and state causes your app to terminate more predictably if an invalid state occurs, and helps make the problem easier to debug. When assumptions aren’t checked, you might not notice this kind problem until much later when code elsewhere starts failing visibly, and after user data has been silently corrupted. Stopping execution as soon as an invalid state is detected also helps limit the damage caused by that invalid state.

使用断言和先决条件并不是设计以确保无效条件不可能出现的代码的替代方法。然而，使用它们来强制执行有效的数据和状态，可以使应用在出现无效状态时更可预测地终止，并有助于使问题更容易调试。当假设未经检查时，您可能直到很久以后的某个时候，当其他地方的代码开始明显失败，并且用户数据已被悄悄损坏，才会注意到这个问题。在检测到无效状态后立即停止执行还有助于限制由该无效状态造成的损害。

The difference between assertions and preconditions is in when they’re checked: Assertions are checked only in debug builds, but preconditions are checked in both debug and production builds. In production builds, the condition inside an assertion isn’t evaluated. This means you can use as many assertions as you want during your development process, without impacting performance in production.

断言和先决条件之间的区别在于它们何时被检查：断言仅在 debug 构建中进行检查，但前提条件在 debug 和 production 构建中都进行检查。在 production 构建中，断言中的条件不会被评估。这意味着您可以在开发过程中使用任意数量的断言，而不会影响生产环境中的性能。

### 14.1 Debugging with Assertions - 使用断言进行调试

You write an assertion by calling the `assert(_:_:file:line:)` function from the Swift standard library. You pass this function an expression that evaluates to `true` or `false` and a message to display if the result of the condition is `false`. For example:

您可以通过从 Swift 标准库中调用 `assert(_:_:file:line:)` 函数来编写断言。您向此函数传递一个评估为 `true` 或 `false` 的表达式以及一个在条件结果为 `false` 时显示的消息。例如：

```
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 isn't >= 0.
// 此断言失败，因为 -3 不大于等于 0。
```

In this example, code execution continues if `age >= 0` evaluates to `true`, that is, if the value of age is nonnegative. If the value of `age` is negative, as in the code above, then `age >= 0` evaluates to `false`, and the assertion fails, terminating the application.

在这个示例中，如果 `age >= 0` 评估为 `true`，即 age 的值为非负数，则代码执行将继续。如果 `age` 的值为负数，如上面的代码所示，那么 `age >= 0` 评估为 `false`，断言失败，终止应用程序。

You can omit the assertion message — for example, when it would just repeat the condition as prose.

您可以省略断言消息，例如，当它只是对条件的重复时。

```
assert(age >= 0)
```

If the code already checks the condition, you use the `assertionFailure(_:file:line:)` function to indicate that an assertion has failed. For example:

如果代码已经检查了条件，您可以使用 `assertionFailure(_:file:line:)` 函数来指示断言失败。例如：

```
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}
```

### 14.2 Enforcing Preconditions - 强制先决条件

Use a precondition whenever a condition has the potential to be `false`, but must definitely be `true` for your code to continue execution. For example, use a precondition to check that a subscript isn’t out of bounds, or to check that a function has been passed a valid value.

当某个条件有可能为假，但必须绝对为真才能使您的代码继续执行时，请使用先决条件。例如，使用先决条件来检查下标是否超出范围，或者检查函数是否传递了有效值。

You write a precondition by calling the `precondition(_:_:file:line:)` function. You pass this function an expression that evaluates to `true` or `false` and a message to display if the result of the condition is `false`. For example:

您可以通过调用 `precondition(_:_:file:line:)` 函数来编写先决条件。您向此函数传递一个评估为 `true` 或 `false` 的表达式以及一个在条件结果为 `false` 时显示的消息。例如：

```
// In the implementation of a subscript...
// 在下标的实现中...
precondition(index > 0, "Index must be greater than zero.")
```

You can also call the `preconditionFailure(_:file:line:)` function to indicate that a failure has occurred — for example, if the default case of a `switch` was taken, but all valid input data should have been handled by one of the `switch`’s other cases.

您也可以调用 `preconditionFailure(_:file:line:)` 函数来指示发生了失败——例如，如果 `switch` 语句采用了默认情况，但所有有效的输入数据应该已被 `switch` 的其他情况处理。



> **Note** **注意**
>
> If you compile in unchecked mode (`-Ounchecked`), preconditions aren’t checked. The compiler assumes that preconditions are always `true`, and it optimizes your code accordingly. However, the `fatalError(_:file:line:)` function always halts execution, regardless of optimization settings.
> 
> 如果以 unchecked 模式（`-Ounchecked`）进行编译，则不会检查先决条件。编译器假定前提条件始终为真，并相应地优化您的代码。然而，`fatalError(_:file:line:)` 函数始终会停止执行，不受优化设置的影响。
>
> You can use the `fatalError(_:file:line:)` function during prototyping and early development to create stubs for functionality that hasn’t been implemented yet, by writing `fatalError("Unimplemented")` as the stub implementation. Because fatal errors are never optimized out, unlike assertions or preconditions, you can be sure that execution always halts if it encounters a stub implementation.
> 
> 您可以在原型设计和早期开发过程中使用 `fatalError(_:file:line:)` 函数来为尚未实现的功能创建存根，方法是写上 `fatalError("Unimplemented")` 作为存根实现。由于致命错误永远不会被优化掉，与断言或先决条件不同，您可以确保如果遇到存根实现，执行总是会停止。



 