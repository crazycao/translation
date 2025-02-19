# Strings and Characters 字符串和字符

> Store and manipulate text.
> 
> 存储和处理文本。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters)

An operator is a special symbol or phrase that you use to check, change, or combine values. For example, the addition operator (`+`) adds two numbers, as in `let i = 1 + 2`, and the logical AND operator (`&&`) combines two Boolean values, as in `if enteredDoorCode && passedRetinaScan`.

运算符是一种特殊的符号或短语，用于检查、更改或组合值。例如，加法运算符（`+`）将两个数字相加，如 `let i = 1 + 2`，而逻辑与运算符（`&&`）组合两个布尔值，如 `if enteredDoorCode && passedRetinaScan`。

Swift supports the operators you may already know from languages like C, and improves several capabilities to eliminate common coding errors. The assignment operator (`=`) doesn’t return a value, to prevent it from being mistakenly used when the equal to operator (`==`) is intended. Arithmetic operators (`+`, `-`, `*`, `/`, `%` and so forth) detect and disallow value overflow, to avoid unexpected results when working with numbers that become larger or smaller than the allowed value range of the type that stores them. You can opt in to value overflow behavior by using Swift’s overflow operators, as described in [Overflow Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators#Overflow-Operators).

Swift 支持你可能从 C 等语言中已经熟悉的运算符，并改进了多项功能以消除常见的编码错误。赋值运算符（`=`）不会返回值，以防止在需要使用等于运算符（`==`）时误用它。算术运算符（`+`、`-`、`*`、`/`、`%` 等）会检测并禁止值溢出，以避免在处理超出存储类型允许值范围的数字时出现意外结果。你可以通过使用 Swift 的溢出运算符来选择启用溢出行为，如《[溢出运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators#Overflow-Operators)》章节所述。

Swift also provides range operators that aren’t found in C, such as `a..<b` and `a...b`, as a shortcut for expressing a range of values.

Swift 还提供了 C 语言中没有的范围运算符，例如 `a..<b` 和 `a...b`，作为表示值范围的快捷方式。

This chapter describes the common operators in Swift. [Advanced Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators) covers Swift’s advanced operators, and describes how to define your own custom operators and implement the standard operators for your own custom types.

本章介绍了 Swift 中的常见运算符。《[高级运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators)》章节将介绍 Swift 的高级运算符，并描述如何为自定义类型定义自己的运算符以及实现标准运算符。

##  1 Terminology 术语

Operators are unary, binary, or ternary:

运算符分为一元、二元或三元：

- **Unary** operators operate on a single target (such as `-a`). Unary _prefix_ operators appear immediately before their target (such as `!b`), and unary _postfix_ operators appear immediately after their target (such as `c!`).

- **一元** 运算符作用于单一目标（例如 `-a`）。**前缀** 一元运算符紧接在其目标之前出现（例如 `!b`），而 **后缀** 一元运算符则紧接在其目标之后出现（例如 `c!`）。

- **Binary** operators operate on two targets (such as `2 + 3`) and are _infix_ because they appear in between their two targets.

- **二元** 运算符作用于两个目标（例如 `2 + 3`），并且是 **中缀** 的，因为它们出现在两个目标之间。

- **Ternary** operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (`a ? b : c`).

- **三元** 运算符作用于三个目标。与C语言类似，Swift 只有一个三元运算符，即三元条件运算符（`a ? b : c`）。

The values that operators affect are _operands_. In the expression `1 + 2`, the `+` symbol is an infix operator and its two operands are the values `1` and `2`.

受运算符影响的值称为 **操作数**。在表达式 `1 + 2` 中，`+` 符号是一个中缀运算符，它的两个操作数是值 `1` 和 `2`。

## 2 Assignment Operator 赋值运算符

The assignment operator (`a = b`) initializes or updates the value of `a` with the value of `b`:

赋值运算符（`a = b`）用 `b` 的值来初始化或更新 `a` 的值：

```
let b = 10
var a = 5
a = b
// a is now equal to 10
// a 现在等于 10
```

If the right side of the assignment is a tuple with multiple values, its elements can be decomposed into multiple constants or variables at once:

如果赋值运算符的右侧是一个包含多个值的元组，其元素可以同时被分解为多个常量或变量：

```
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
// x 等于 1，y 等于 2
```

Unlike the assignment operator in C and Objective-C, the assignment operator in Swift doesn’t itself return a value. The following statement isn’t valid:

与 C 和 Objective-C 中的赋值运算符不同，Swift 中的赋值运算符本身不会返回值。因此，以下语句是无效的：

```
if x = y {
    // This isn't valid, because x = y doesn't return a value.
    // 这是无效的，因为 x = y 不会返回值。
}
```

This feature prevents the assignment operator (`=`) from being used by accident when the equal to operator (`==`) is actually intended. By making if `x = y` invalid, Swift helps you to avoid these kinds of errors in your code.

这一特性防止了在实际需要使用等于运算符（`==`）时意外使用了赋值运算符（`=`）。通过使 `if x = y` 无效，Swift 帮助你在代码中避免这类错误。

## 3 Arithmetic Operators 算数运算符

Swift supports the four standard arithmetic operators for all number types:

- Addition (`+`)
- Subtraction (`-`)
- Multiplication (`*`)
- Division (`/`)


```
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0
```

Swift 对所有数字类型都支持四种标准算术运算符：

- 加法（`+`）
- 减法（`-`）
- 乘法（`*`）
- 除法（`/`）

```
1 + 2       // 等于 3
5 - 3       // 等于 2
2 * 3       // 等于 6
10.0 / 2.5  // 等于 4.0
```

Unlike the arithmetic operators in C and Objective-C, the Swift arithmetic operators don’t allow values to overflow by default. You can opt in to value overflow behavior by using Swift’s overflow operators (such as `a &+ b`). See [Overflow Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators#Overflow-Operators).

与 C 和 Objective-C 中的算术运算符不同，Swift 的算术运算符默认不允许值溢出。你可以通过使用 Swift 的溢出运算符（例如 `a &+ b`）来选择启用溢出行为。详情请参阅《[溢出运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/advancedoperators#Overflow-Operators)》。

The addition operator is also supported for `String` concatenation:

```
"hello, " + "world"  // equals "hello, world"  
```

加法运算符也支持字符串连接：

```
"hello, " + "world"  // 等于 "hello, world"
```

### 3.1 Remainder Operator 取余运算符

The remainder operator (`a % b`) works out how many multiples of `b` will fit inside `a` and returns the value that’s left over (known as the **remainder**).

取余运算符（`a % b`）用于计算 `b` 能够整除 `a` 多少次，并返回剩下的值（即 **余数**）。

> **Note** **注意**
>
> The remainder operator (`%`) is also known as a _modulo operator_ in other languages. However, its behavior in Swift for negative numbers means that, strictly speaking, it’s a remainder rather than a modulo operation.
> 
> 在其他语言中，取余运算符（`%`）也被称为 **模运算符**。然而，在Swift中，它对负数的处理方式意味着它严格来说是一个取余运算，而不是模运算。

Here’s how the remainder operator works. To calculate `9 % 4`, you first work out how many `4`s will fit inside `9`:

取余运算符的工作原理如下。要计算 `9 % 4`，你首先需要计算 `4` 能够整除 `9` 多少次：

![Reminder Operator](https://docs.swift.org/swift-book/images/org.swift.tspl/remainderInteger@2x.png)

You can fit two `4`s inside `9`, and the remainder is `1` (shown in orange).

你可以在 `9` 里面放入两个 `4`，余数是 `1`（以橙色显示）。

In Swift, this would be written as:

```
9 % 4    // equals 1
```

在 Swift 中，这会写成：

```
9 % 4 // 等于 1
```

To determine the answer for `a % b`, the `%` operator calculates the following equation and returns remainder as its output:

```
a = (b x some multiplier) + remainder
```

where `some multiplier` is the largest number of multiples of b that will fit inside a.

要确定 `a % b` 的答案，`%` 运算符会计算以下方程并返回余数作为输出：

```
a = (b x 某个倍数) + 余数
```

其中，`某个倍数`是能够放入 `a` 中的 `b` 的最大倍数。

Inserting `9` and `4` into this equation yields:

```
9 = (4 x 2) + 1
```

将 `9` 和 `4` 代入此方程得到：

```
9 = (4 x 2) + 1
```

The same method is applied when calculating the remainder for a negative value of `a`:

```
-9 % 4   // equals -1
```

当计算 `a` 为负值的余数时，也使用相同的方法：

```
-9 % 4 // 等于 -1
```

Inserting `-9` and `4` into the equation yields:

```
-9 = (4 x -2) + -1
```

giving a remainder value of `-1`.

将 `-9` 和 `4` 代入方程得到：

```
-9 = (4 x -2) + -1
```

得到余数 `-1`。

The sign of b is ignored for negative values of `b`. This means that `a % b` and `a % -b` always give the same answer.

对于 `b` 为负值的情况，`b` 的符号会被忽略。这意味着 `a % b` 和 `a % -b` 总是得到相同的答案。

### 3.2 Unary Minus Operator 一元负号运算符

The sign of a numeric value can be toggled using a prefixed `-`, known as the _unary minus operator_:

```
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
```

可以使用前缀 `-`（称为 **一元负号运算符**）来切换数值的符号：

```
let three = 3
let minusThree = -three // minusThree 等于 -3
let plusThree = -minusThree // plusThree 等于 3，或者“负负得正的三”
```

The unary minus operator (`-`) is prepended directly before the value it operates on, without any white space.

一元负号运算符（`-`）直接放在它所操作的值之前，中间没有任何空格。

### 3.3 Unary Plus Operator 一元加号运算符

The unary plus operator (`+`) simply returns the value it operates on, without any change:

```
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
```

一元加号运算符（`+`）只是简单地返回它所操作的值，不做任何改变：

```
let minusSix = -6
let alsoMinusSix = +minusSix // alsoMinusSix 等于 -6
```

Although the unary plus operator doesn’t actually do anything, you can use it to provide symmetry in your code for positive numbers when also using the unary minus operator for negative numbers.

尽管一元加号运算符实际上不做任何事情，但当你对负数使用一元负号运算符时，你可以在代码中对正数使用它来保持对称性。

## 4 Compound Assignment Operators 复合赋值运算符

Like C, Swift provides compound assignment operators that combine assignment (`=`) with another operation. One example is the addition assignment operator (`+=`):

```
var a = 1
a += 2
// a is now equal to 3
```

与 C 语言类似，Swift 提供了复合赋值运算符，它将赋值（`=`）与其他操作结合起来。一个例子是加法赋值运算符（`+=`）：

```
var a = 1
a += 2
// 现在 a 等于3
```

The expression `a += 2` is shorthand for `a = a + 2`. Effectively, the addition and the assignment are combined into one operator that performs both tasks at the same time.

表达式 `a += 2` 是 `a = a + 2` 的简写。实际上，加法和赋值被组合成一个运算符，同时执行两个任务。

> **Note** **注意**
>
> The compound assignment operators don’t return a value. For example, you can’t write `let b = a += 2`.
> 
> 复合赋值运算符不返回值。例如，你不能写 `let b = a += 2`。

For information about the operators provided by the Swift standard library, see [Operator Declarations](https://developer.apple.com/documentation/swift/operator_declarations).

有关 Swift 标准库提供的运算符的信息，请参阅《[运算符声明](https://developer.apple.com/documentation/swift/operator_declarations)》。

## 5 Comparison Operators 比较运算符

Swift supports the following comparison operators:

- Equal to (`a == b`)
- Not equal to (`a != b`)
- Greater than (`a > b`)
- Less than (`a < b`)
- Greater than or equal to (`a >= b`)
- Less than or equal to (`a <= b`)

Swift 支持以下比较运算符：

- 等于（`a == b`）
- 不等于（`a != b`）
- 大于（`a > b`）
- 小于（`a < b`）
- 大于等于（`a >= b`）
- 小于等于（`a <= b`）

> **Note** **注意**
>
> Swift also provides two _identity operators_ (`===` and `!==`), which you use to test whether two object references both refer to the same object instance. For more information, see [Identity Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures#Identity-Operators).
> 
> Swift还提供了两个 **身份运算符**（`===` 和 `!==`），用于测试两个对象引用是否都指向同一个对象实例。有关更多信息，请参阅《[身份运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures#Identity-Operators)》。

Each of the comparison operators returns a Bool value to indicate whether or not the statement is true:

```
1 == 1   // true because 1 is equal to 1
2 != 1   // true because 2 isn't equal to 1
2 > 1    // true because 2 is greater than 1
1 < 2    // true because 1 is less than 2
1 >= 1   // true because 1 is greater than or equal to 1
2 <= 1   // false because 2 isn't less than or equal to 1
```

每个比较运算符都返回一个 Bool 值，以指示语句是否为真：

```
1 == 1 // 真，因为1等于1
2 != 1 // 真，因为2不等于1
2 > 1  // 真，因为2大于1
1 < 2  // 真，因为1小于2
1 >= 1 // 真，因为1大于等于1
2 <= 1 // 假，因为2不小于等于1
```

Comparison operators are often used in conditional statements, such as the if statement:

```
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".
```

比较运算符通常用于条件语句中，如 `if` 语句：

```
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".
// 打印 "hello, world"，因为name确实等于"world"。
```

For more about the if statement, see [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow).

有关if语句的更多信息，请参阅《[控制流](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)》。

You can compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. Those two values are compared, and the result of that comparison determines the overall result of the tuple comparison. If all the elements are equal, then the tuples themselves are equal. For example:

```
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
```

如果两个元组具有相同的类型和相同数量的值，则可以比较它们。元组会按从左到右的顺序逐个值进行比较，直到找到两个不相等的值为止。将这两个值进行比较，比较的结果决定了元组比较的最终结果。如果所有元素都相等，则元组本身也相等。例如：

```
(1, "zebra") < (2, "apple") // 真，因为1小于2；"zebra"和"apple"没有进行比较
(3, "apple") < (3, "bird")  // 真，因为3等于3，并且"apple"小于"bird"
(4, "dog") == (4, "dog")    // 真，因为4等于4，并且"dog"等于"dog"
```

In the example above, you can see the left-to-right comparison behavior on the first line. Because `1` is less than `2`, `(1, "zebra")` is considered less than `(2, "apple")`, regardless of any other values in the tuples. It doesn’t matter that `"zebra"` isn’t less than `"apple"`, because the comparison is already determined by the tuples’ first elements. However, when the tuples’ first elements are the same, their second elements are compared — this is what happens on the second and third line.

在上面的示例中，您可以看到第一行上的从左到右的比较行为。因为 `1` 小于 `2`，所以 `(1, "zebra")` 被认为小于 `(2, "apple")`，无论元组中的其他值是什么。 `"zebra"` 不小于 `"apple"` 并不重要，因为比较已经由元组的第一个元素决定。但是，当元组的第一个元素相同时，就会比较它们的第二个元素——这就是第二行和第三行上发生的事情。

Tuples can be compared with a given operator only if the operator can be applied to each value in the respective tuples. For example, as demonstrated in the code below, you can compare two tuples of type `(String, Int)` because both `String` and `Int` values can be compared using the `<` operator. In contrast, two tuples of type `(String, Bool)` can’t be compared with the `<` operator because the `<` operator can’t be applied to `Bool` values.

```
("blue", -1) < ("purple", 1)        // OK, evaluates to true
("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
```

只有当运算符可以应用于元组中相应位置的每个值时，才能使用给定的运算符比较元组。例如，如下面的代码所示，您可以比较两个类型为 `(String, Int)` 的元组，因为 `String` 和 `Int` 值都可以使用 `<` 运算符进行比较。相比之下，不能使用 `<` 运算符比较两个类型为 `(String, Bool)` 的元组，因为 `<` 运算符不能应用于 `Bool` 值。

```
("blue", -1) < ("purple", 1) // 可以，结果为真
("blue", false) < ("purple", true) // 错误，因为<不能比较布尔值
```

> **Note** **注意**
>
> The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
> 
> Swift 标准库包含用于少于七个元素的元组的比较运算符。要比较具有七个或更多元素的元组，您必须自己实现比较运算符。

## 6 Ternary Conditional Operator 三元条件运算符

The _ternary conditional operator_ is a special operator with three parts, which takes the form `question ? answer1 : answer2`. It’s a shortcut for evaluating one of two expressions based on whether question is true or false. If `question` is true, it evaluates `answer1` and returns its value; otherwise, it evaluates `answer2` and returns its value.

**三元条件运算符** 是一种特殊有三个部分的运算符，其形式为 `问题 ? 答案1 : 答案2`。它是根据`问题`是真还是假来评估两个表达式之一的快捷方式。如果`问题`为真，则评估`答案1`并返回其值；否则，评估`答案2`并返回其值。

The ternary conditional operator is shorthand for the code below:

```
if question {
    answer1
} else {
    answer2
}
```

三元条件运算符是以下代码的简写：

```
if question {
    answer1
} else {
    answer2
}
```

Here’s an example, which calculates the height for a table row. The row height should be `50` points taller than the content height if the row has a header, and `20` points taller if the row doesn’t have a header:

```
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90
```

以下是一个示例，它计算表格行的高度。如果行有标题，则行高应比内容高度高 `50` 点；如果没有标题，则行高应比内容高度高 `20` 点：

```
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight 等于 90
```

The example above is shorthand for the code below:

```
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight is equal to 90
```

上面的示例是以下代码的简写：

```
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight 等于 90
```

The first example’s use of the ternary conditional operator means that `rowHeight` can be set to the correct value on a single line of code, which is more concise than the code used in the second example.

第一个示例中使用三元条件运算符意味着可以在一行代码中为 `rowHeight` 设置正确的值，这比第二个示例中使用的代码更简洁。

The ternary conditional operator provides an efficient shorthand for deciding which of two expressions to consider. Use the ternary conditional operator with care, however. Its conciseness can lead to hard-to-read code if overused. Avoid combining multiple instances of the ternary conditional operator into one compound statement.

三元条件运算符为决定要考虑两个表达式中的哪一个提供了有效的简写。但是，请小心使用三元条件运算符。如果过度使用，其简洁性可能导致代码难以阅读。避免将多个三元条件运算符实例组合成一个复合语句。

## 7 Nil-Coalescing Operator 空合并运算符

The nil-coalescing operator (`a ?? b`) unwraps an optional `a` if it contains `a` value, or returns `a` default value `b` if `a` is `nil`. The expression a is always of an optional type. The expression `b` must match the type that’s stored inside `a`.

空合并运算符（`a ?? b`）用于在可选类型 `a` 包含值时解包 `a`，如果 `a` 是 `nil`，则返回默认值 `b`。表达式 `a` 总是可选类型。表达式 `b` 的类型必须与 `a` 内部存储的类型相匹配。

The nil-coalescing operator is shorthand for the code below:

```
a != nil ? a! : b
```

空合并运算符是以下代码的简写：

```
a != nil ? a! : b
```

The code above uses the ternary conditional operator and forced unwrapping (`a!`) to access the value wrapped inside a when `a` isn’t `nil`, and to return `b` otherwise. The nil-coalescing operator provides a more elegant way to encapsulate this conditional checking and unwrapping in a concise and readable form.

上面的代码使用了三元条件运算符和强制解包（`a!`）来在 `a` 非 `nil` 时访问 `a` 内部的值，否则返回 `b`。空合并运算符提供了一种更优雅的方式来封装这种条件检查和解包操作，使其更加简洁且易读。

> **Note** **注意**
>
> If the value of `a` is non-nil, the value of `b` isn’t evaluated. This is known as _short-circuit evaluation_.
> 
> 如果 `a` 的值非 `nil`，则不会计算 `b` 的值。这被称为 **短路求值**。

The example below uses the nil-coalescing operator to choose between a default color name and an optional user-defined color name:

```
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil


var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
```

下面的示例使用空合并运算符在默认颜色名称和用户定义的可选颜色名称之间进行选择：

```
let defaultColorName = "red"
var userDefinedColorName: String? // 默认为 nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 是 nil，所以 colorNameToUse 被设置为默认值 "red"
```

The `userDefinedColorName` variable is defined as an optional String, with a default value of `nil`. Because `userDefinedColorName` is of an optional type, you can use the nil-coalescing operator to consider its value. In the example above, the operator is used to determine an initial value for a String variable called `colorNameToUse`. Because `userDefinedColorName` is `nil`, the expression `userDefinedColorName ?? defaultColorName` returns the value of `defaultColorName`, or "red".

`userDefinedColorName` 变量被定义为一个可选的字符串，默认值为`nil`。由于 `userDefinedColorName` 是可选类型，你可以使用空合并运算符来处理其值。在上述示例中，该运算符用于为一个名为 `colorNameToUse` 的字符串变量确定初始值。因为 `userDefinedColorName` 为 `nil`，表达式`userDefinedColorName ?? defaultColorName` 会返回 `defaultColorName` 的值，即 “red”。
分享用中文解释一下什么是可选类型？除了空合并运算符，还有哪些运算符可以处理可选类型的值？在其他编程语言中，如何处理可选类型的值？

If you assign a non-nil value to userDefinedColorName and perform the nil-coalescing operator check again, the value wrapped inside userDefinedColorName is used instead of the default:

```
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName isn't nil, so colorNameToUse is set to "green"
```

如果你给 `userDefinedColorName` 赋一个非空值，然后再次执行空合并运算符检查，那么将使用 `userDefinedColorName` 中包装的值，而不是默认值：

```
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName?? defaultColorName
// userDefinedColorName 不为空，所以 colorNameToUse 被设置为 "green"
```

## 8 Range Operators 范围运算符

Swift includes several _range operators_, which are shortcuts for expressing a range of values.

Swift 包含多个 **范围运算符**，它们是表示一系列值的快捷方式。

### 8.1 Closed Range Operator 闭区间运算符

The _closed range operator_ (`a...b`) defines a range that runs from `a` to `b`, and includes the values `a` and `b`. The value of `a` must not be greater than `b`.

**闭区间运算符**（`a...b`）定义了一个从 `a` 到 `b` 的区间，并且包含 `a` 和 `b` 这两个值。`a` 的值不能大于 `b`。

The closed range operator is useful when iterating over a range in which you want all of the values to be used, such as with a `for-in` loop:

```
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```

当你想要遍历一个包含所有值的范围时，闭区间运算符非常有用，比如在 `for-in` 循环中：

```
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 乘以 5 等于 5
// 2 乘以 5 等于 10
// 3 乘以 5 等于 15
// 4 乘以 5 等于 20
// 5 乘以 5 等于 25
```

For more about `for-in` loops, see [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow).

有关 `for-in` 循环的更多信息，请参阅《[控制流](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)》。

### 8.2 Half-Open Range Operator 半开区间运算符

The _half-open range operator_ (`a..<b`) defines `a` range that runs from `a` to `b`, but doesn’t include `b`. It’s said to be half-open because it contains its first value, but not its final value. As with the closed range operator, the value of `a` must not be greater than `b`. If the value of `a` is equal to `b`, then the resulting range will be empty.

**半开区间运算符**（`a..<b`）定义了一个从 `a` 到 `b` 的区间，但不包含 `b`。之所以说它是半开的，是因为它包含第一个值，但不包含最后一个值。与闭区间运算符一样，`a` 的值不能大于 `b`。如果 `a` 的值等于 `b`，那么结果区间将为空。

Half-open ranges are particularly useful when you work with zero-based lists such as arrays, where it’s useful to count up to (but not including) the length of the list:

```
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack
```

当处理基于零索引的列表（如数组）时，半开区间特别有用，因为它可以方便地计数到列表的长度（但不包含该长度值）：

```
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// 第 1 个人叫 Anna
// 第 2 个人叫 Alex
// 第 3 个人叫 Brian
// 第 4 个人叫 Jack
```

Note that the array contains four items, but `0..<count` only counts as far as `3` (the index of the last item in the array), because it’s a half-open range. For more about arrays, see [Arrays](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Arrays).

请注意，数组包含四个元素，但 `0..<count` 只计数到 `3`（数组中最后一个元素的索引），因为这是一个半开区间。有关数组的更多信息，请参阅《[数组](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes#Arrays)》。

### 8.3 One-Sided Ranges 单边区间

The closed range operator has an alternative form for ranges that continue as far as possible in one direction — for example, a range that includes all the elements of an array from index `2` to the end of the array. In these cases, you can omit the value from one side of the range operator. This kind of range is called a _one-sided range_ because the operator has a value on only one side. For example:

闭区间运算符有一种用于向一个方向尽可能延伸的区间的变体形式。例如，有一个区间包含从数组索引 `2` 到数组末尾的所有元素。在这些情况下，你可以省略区间运算符一侧的值。这种区间被称为 **单边区间**，因为该运算符只有一侧有值。例如：

```
for name in names[2...] {
    print(name)
}
// Brian
// Jack


for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian
```

The half-open range operator also has a one-sided form that’s written with only its final value. Just like when you include a value on both sides, the final value isn’t part of the range. For example:

半开区间运算符也有一种单边形式，只写出其最后一个值。就像运算符两侧都有值的情况一样，最后一个值不属于该区间。例如：

```
for name in names[..<2] {
    print(name)
}
// Anna
// Alex
```

One-sided ranges can be used in other contexts, not just in subscripts. You can’t iterate over a one-sided range that omits a first value, because it isn’t clear where iteration should begin. You can iterate over a one-sided range that omits its final value; however, because the range continues indefinitely, make sure you add an explicit end condition for the loop. You can also check whether a one-sided range contains a particular value, as shown in the code below.

```
let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true
```

单边区间不仅可以用于下标，还能用于其他场景。你不能对省略了起始值的单边区间进行迭代，因为不清楚迭代应该从哪里开始。你可以对省略了结束值的单边区间进行迭代；不过，由于该区间会无限延伸，要确保为循环添加一个明确的结束条件。你还可以检查单边区间是否包含某个特定的值，如下方代码所示。

```
let range = ...5
range.contains(7)   // 假
range.contains(4)   // 真
range.contains(-1)  // 真
```

## 9 Logical Operators 逻辑运算符

_Logical operators_ modify or combine the Boolean logic values `true` and `false`. Swift supports the three standard logical operators found in C-based languages:

- Logical NOT (`!a`)
- Logical AND (`a && b`)
- Logical OR (`a || b`)

**逻辑运算符** 用于修改或组合布尔逻辑值 `true` 和 `false`。Swift 支持在基于 C 的语言中常见的三种标准逻辑运算符：

- 逻辑非运算符（`!a`）
- 逻辑与运算符（`a && b`）
- 逻辑或运算符（`a || b`）

### 9.1 Logical NOT Operator 逻辑非运算符

The _logical NOT operator_ (`!a`) inverts a Boolean value so that `true` becomes `false`, and `false` becomes `true`.

**逻辑非运算符**（`!a`）会反转布尔值，使 `true` 变为 `false`，`false` 变为 `true`。

The logical NOT operator is a prefix operator, and appears immediately before the value it operates on, without any white space. It can be read as “not `a`”, as seen in the following example:

```
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

逻辑非运算符是前缀运算符，它紧挨着要操作的值，中间没有任何空格。可以将其读作 “非 `a`”，如以下示例所示：

```
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// 输出 "ACCESS DENIED"
```

The phrase `if !allowedEntry` can be read as “if not allowed entry.” The subsequent line is only executed if “not allowed entry” is `true`; that is, if `allowedEntry` is `false`.

`if !allowedEntry` 这句话可以读作 “如果不允许进入”。只有当 “不允许进入” 为真时，即 `allowedEntry` 为假时，后续的代码行才会执行。

As in this example, careful choice of Boolean constant and variable names can help to keep code readable and concise, while avoiding double negatives or confusing logic statements.

正如这个示例所示，谨慎选择布尔常量和变量的名称有助于保持代码的可读性和简洁性，同时避免双重否定或容易引起混淆的逻辑语句。

### 9.2 Logical AND Operator 逻辑与运算符

The _logical AND operator_ (`a && b`) creates logical expressions where both values must be `true` for the overall expression to also be `true`.

**逻辑与运算符**（`a && b`）用于创建逻辑表达式，只有当两个值都为 `true` 时，整个表达式才为 `true`。

If either value is `false`, the overall expression will also be `false`. In fact, if the first value is `false`, the second value won’t even be evaluated, because it can’t possibly make the overall expression equate to `true`. This is known as _short-circuit evaluation_.

如果任何一个值为 `false`，则整个表达式也为 `false`。实际上，如果第一个值为 `false`，第二个值甚至都不会被计算，因为它不可能使整个表达式等于 `true`。这被称为 **短路求值**。

This example considers two Bool values and only allows access if both values are `true`:

```
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

此示例考虑了两个布尔值，只有当两个值都为 `true` 时才允许访问：

```
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 输出 "ACCESS DENIED"
```

### 9.3 Logical OR Operator 逻辑或运算符

The _logical OR operator_ (`a || b`) is an infix operator made from two adjacent pipe characters. You use it to create logical expressions in which only _one_ of the two values has to be true for the overall expression to be true.

**逻辑或运算符**（`a || b`）是一个中缀运算符，由两个相邻的竖线字符组成。你可以使用它来创建逻辑表达式，在这种表达式中，只要两个值中有**一个**为 `true`，整个表达式就为 `true`。

Like the Logical AND operator above, the Logical OR operator uses short-circuit evaluation to consider its expressions. If the left side of a Logical OR expression is `true`, the right side isn’t evaluated, because it can’t change the outcome of the overall expression.

与上面的逻辑与运算符一样，逻辑或运算符也使用短路求值来计算其表达式。如果逻辑或表达式的左侧为 `true`，则右侧不会被计算，因为它不会改变整个表达式的结果。

In the example below, the first Bool value (`hasDoorKey`) is `false`, but the second value (`knowsOverridePassword`) is `true`. Because one value is `true`, the overall expression also evaluates to `true`, and access is allowed:

```
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

在下面的示例中，第一个布尔值（`hasDoorKey`）为 `false`，但第二个值（`knowsOverridePassword`）为 `true`。因为有一个值为 `true`，所以整个表达式也计算为 `true`，允许访问：

```
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 输出 "Welcome!"
```

### 9.4 Combining Logical Operators

You can combine multiple logical operators to create longer compound expressions:

```
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

你可以将多个逻辑运算符组合起来，创建更长的复合表达式：

```
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 输出 "Welcome!"
```

This example uses multiple `&&` and `||` operators to create a longer compound expression. However, the `&&` and `||` operators still operate on only two values, so this is actually three smaller expressions chained together. The example can be read as:

这个示例使用了多个 `&&` 和 `||` 运算符来创建一个更长的复合表达式。不过，`&&` 和 `||` 运算符仍然只对两个值进行操作，所以实际上这是三个较小的表达式串联在一起。这个示例可以解读为：

If we’ve entered the correct door code and passed the retina scan, or if we have a valid door key, or if we know the emergency override password, then allow access.

如果我们输入了正确的门禁密码并且通过了视网膜扫描，或者我们有有效的门钥匙，又或者我们知道紧急备用密码，那么允许进入。

Based on the values of `enteredDoorCode`, `passedRetinaScan`, and `hasDoorKey`, the first two subexpressions are `false`. However, the emergency override password is known, so the overall compound expression still evaluates to `true`.

根据 `enteredDoorCode`、`passedRetinaScan` 和 `hasDoorKey` 的值，前两个子表达式为 `false`。不过，因为知道紧急备用密码，所以整个复合表达式的计算结果仍然为 `true`。

> **Note** **注意**
>
> The Swift logical operators `&&` and `||` are left-associative, meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.
> 
> Swift 中的逻辑运算符 `&&` 和 `||` 是左结合的，这意味着包含多个逻辑运算符的复合表达式会先计算最左边的子表达式。

### 9.4 Explicit Parentheses 显式使用括号

It’s sometimes useful to include parentheses when they’re not strictly needed, to make the intention of a complex expression easier to read. In the door access example above, it’s useful to add parentheses around the first part of the compound expression to make its intent explicit:

```
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

有时，即使括号并非严格必要，使用它们也很有用，这样可以让复杂表达式的意图更易于理解。在上面的门禁示例中，在复合表达式的第一部分加上括号能让其意图更明确：

```
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 输出 "Welcome!"
```

The parentheses make it clear that the first two values are considered as part of a separate possible state in the overall logic. The output of the compound expression doesn’t change, but the overall intention is clearer to the reader. Readability is always preferred over brevity; use parentheses where they help to make your intentions clear.

括号清楚地表明，前两个值在整体逻辑中被视为一个单独的可能状态。复合表达式的输出不会改变，但对于阅读者来说，整体意图更清晰了。可读性始终比简洁性更重要；在有助于明确表达意图的地方使用括号。