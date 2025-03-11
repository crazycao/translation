# Strings and Characters 字符串和字符

> Store and manipulate text.
> 
> 存储和处理文本。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters)

A _string_ is a series of characters, such as "hello, world" or "albatross". Swift strings are represented by the `String` type. The contents of a `String` can be accessed in various ways, including as a collection of `Character` values.

**字符串**是一系列字符，例如 “hello, world” 或 “albatross”。Swift 中的字符串由 `String` 类型表示。可以通过多种方式访问 `String` 的内容，包括将其视为 `Character` 值的集合。

Swift’s `String` and `Character` types provide a fast, Unicode-compliant way to work with text in your code. The syntax for string creation and manipulation is lightweight and readable, with a string literal syntax that’s similar to C. String concatenation is as simple as combining two strings with the + operator, and string mutability is managed by choosing between a constant or a variable, just like any other value in Swift. You can also use strings to insert constants, variables, literals, and expressions into longer strings, in a process known as string interpolation. This makes it easy to create custom string values for display, storage, and printing.

Swift 的 `String` 和 `Character` 类型提供了一种快速的符合 Unicode 标准的方式在代码中处理文本。字符串创建和操作的语法简洁易读，其字符串字面量语法与 C 语言类似。字符串拼接就像使用 `+` 运算符将两个字符串组合在一起一样简单，并且如同 Swift 中的其他任何值一样，通过选择使用常量或变量来管理字符串的可变性。你还可以将常量、变量、字面量和表达式插入到更长的字符串中，这个过程称为字符串插值。这使得创建用于显示、存储和打印的自定义字符串值变得轻而易举。

Despite this simplicity of syntax, Swift’s `String` type is a fast, modern string implementation. Every string is composed of encoding-independent Unicode characters, and provides support for accessing those characters in various Unicode representations.

尽管语法简单，但 Swift 的 `String` 类型是一种快速的现代字符串实现方式。每个字符串都由与编码无关的 Unicode 字符组成，并支持以各种 Unicode 表示形式访问这些字符。

> **Note** **注意**
>
> Swift’s `String` type is bridged with Foundation’s `NSString` class. Foundation also extends `String` to expose methods defined by `NSString`. This means, if you import Foundation, you can access those `NSString` methods on `String` without casting.
> 
> Swift 的 `String` 类型与 Foundation 框架中的 `NSString` 类是桥接的。Foundation 框架还将 `String` 扩展到了 `NSString` 定义的公开方法。这意味着，如果你导入了 Foundation 框架，无需进行类型转换，就可以在 `String` 上调用这些 `NSString` 方法。
>
> For more information about using `String` with Foundation and Cocoa, see [Bridging Between String and NSString](https://developer.apple.com/documentation/swift/string#2919514).
> 
> 有关在 Foundation 和 Cocoa 中使用 `String` 的更多信息，请参阅《[String与NSString之间的桥接](https://developer.apple.com/documentation/swift/string#2919514)》。

## 1 String Literals 字符串字面量

You can include predefined `String` values within your code as _string literals_. A string literal is a sequence of characters surrounded by double quotation marks (`"`).

在代码中，你可以将预定义的 `String` 值以 **字符串字面量** 的形式包含进来。字符串字面量是由双引号（`"`）包围的一系列字符。

Use a string literal as an initial value for a constant or variable:

你可以使用字符串字面量作为常量或变量的初始值，例如：

```
let someString = "Some string literal value"
```

Note that Swift infers a type of `String` for the `someString` constant because it’s initialized with a string literal value.

请注意，Swift 会为 `someString` 常量推断出 `String` 类型，因为它是用字符串字面量值初始化的。

### 1.1 Multiline String Literals 多行字符串字面量

If you need a string that spans several lines, use a multiline string literal — a sequence of characters surrounded by three double quotation marks:

如果你需要一个跨越多行的字符串，可以使用多行字符串字面量，即由三个双引号包围的一系列字符：

```
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
```

A multiline string literal includes all of the lines between its opening and closing quotation marks. The string begins on the first line after the opening quotation marks (`"""`) and ends on the line before the closing quotation marks, which means that neither of the strings below start or end with a line break:

多行字符串字面量包含其开始和结束引号之间的所有行。字符串从开始引号（`"""`）后的第一行开始，到结束引号前的那一行结束，这意味着以下两个字符串的开头和结尾都没有换行符：

```
let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""
```

When your source code includes a line break inside of a multiline string literal, that line break also appears in the string’s value. If you want to use line breaks to make your source code easier to read, but you don’t want the line breaks to be part of the string’s value, write a backslash (`\`) at the end of those lines:

当你的源代码在多行字符串字面量中包含换行符时，该换行符也会出现在字符串的值中。如果你想使用换行符使源代码更易读，但又不希望换行符成为字符串值的一部分，可以在这些行的末尾写一个反斜杠（`\`）：

```
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
```

To make a multiline string literal that begins or ends with a line feed, write a blank line as the first or last line. For example:

要创建一个以换行符开始或结束的多行字符串字面量，可以将第一行或最后一行写一个空行。例如：

```
let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
```

A multiline string can be indented to match the surrounding code. The whitespace before the closing quotation marks (`"""`) tells Swift what whitespace to ignore before all of the other lines. However, if you write whitespace at the beginning of a line in addition to what’s before the closing quotation marks, that whitespace is included.

多行字符串可以缩进以匹配周围的代码。结束引号（`"""`）之前的空白字符告诉 Swift 忽略其他所有行之前的哪些空白。但是，如果你在一行的开头除了结束引号之前的空白之外还写了其他空白，那么这些空白将被包含在字符串中。

![](https://docs.swift.org/swift-book/images/org.swift.tspl/multilineStringWhitespace@2x.png)

In the example above, even though the entire multiline string literal is indented, the first and last lines in the string don’t begin with any whitespace. The middle line has more indentation than the closing quotation marks, so it starts with that extra four-space indentation.

在上面的示例中，尽管整个多行字符串字面量都被缩进了，但字符串中的第一行和最后一行开头没有任何空白。中间那一行的缩进比结束引号更多，所以它以额外的四个空格缩进开始。

### 1.2 Special Characters in String Literals 字符串字面量中的特殊字符

String literals can include the following special characters:

字符串字面量可以包含以下特殊字符：

- The escaped special characters `\0` (null character), `\\` (backslash), `\t` (horizontal tab), `\n` (line feed), `\r` (carriage return), `\"` (double quotation mark) and `\'` (single quotation mark)

- An arbitrary Unicode scalar value, written as `\u{n}`, where `n` is a 1–8 digit hexadecimal number (Unicode is discussed in [Unicode](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#Unicode) below)

- 转义后的特殊字符：`\0`（空字符）、`\\`（反斜杠）、`\t`（水平制表符）、`\n`（换行符）、`\r`（回车符）、`\"`（双引号）和 `\'`（单引号）。

- 任意 Unicode 标量值，写为 `\u{n}`，其中 `n` 是一个 1 到 8 位的十六进制数（Unicode 将在下文《[Unicode](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#Unicode)》部分讨论）。

The code below shows four examples of these special characters. The `wiseWords` constant contains two escaped double quotation marks. The `dollarSign`, `blackHeart`, and `sparklingHeart` constants demonstrate the Unicode scalar format:

下面的代码展示了这些特殊字符的四个示例。`wiseWords` 常量包含两个转义的双引号。`dollarSign`、`blackHeart` 和 `sparklingHeart` 常量展示了 Unicode 标量格式：

```
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
```

Because multiline string literals use three double quotation marks instead of just one, you can include a double quotation mark (`"`) inside of a multiline string literal without escaping it. To include the text `"""` in a multiline string, escape at least one of the quotation marks. For example:

由于多行字符串字面量使用三个双引号而不是一个，所以你可以在多行字符串字面量中包含双引号（`"`）而无需转义。要在多行字符串中包含文本 `"""`，至少要转义其中一个引号。例如：

```
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
```

### 1.3 Extended String Delimiters 扩展字符串分隔符

You can place a string literal within extended delimiters to include special characters in a string without invoking their effect. You place your string within quotation marks (`"`) and surround that with number signs (`#`). For example, printing the string literal `#"Line 1\nLine 2"#` prints the line feed escape sequence (`\n`) rather than printing the string across two lines.

你可以将字符串字面量放在扩展分隔符内，以便在字符串中包含特殊字符而不触发其特殊效果。将字符串放在引号（`"`）内，再用井号（`#`）包围。例如，打印字符串字面量 `#"Line 1\nLine 2"#` 会打印换行转义序列（`\n`），而不是将字符串分两行打印。

If you need the special effects of a character in a string literal, match the number of number signs within the string following the escape character (`\`). For example, if your string is `#"Line 1\nLine 2"#` and you want to break the line, you can use `#"Line 1\#nLine 2"#` instead. Similarly, `###"Line1\###nLine2"###` also breaks the line.

如果你需要字符串字面量中某个字符的特殊效果，在转义字符（`\`）之后，让字符串内的井号数量与扩展分隔符的井号数量匹配。例如，如果你的字符串是 `#"Line 1\nLine 2"#`，而你想换行，可以使用 `#"Line 1\#nLine 2"#`。同样，`###"Line1\###nLine2"###` 也会换行。

String literals created using extended delimiters can also be multiline string literals. You can use extended delimiters to include the text """ in a multiline string, overriding the default behavior that ends the literal. For example:

使用扩展分隔符创建的字符串字面量也可以是多行字符串字面量。你可以使用扩展分隔符在多行字符串中包含文本 `"""`，覆盖默认的结束字面量的行为。例如：

```
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
```

## 2 Initializing an Empty String 初始化空字符串

To create an empty `String` value as the starting point for building a longer string, either assign an empty string literal to a variable or initialize a new `String` instance with initializer syntax:

若要创建一个空的 `String` 值，作为构建更长字符串的起始点，你既可以将空字符串字面量赋值给变量，也可以使用初始化器语法初始化一个新的 `String` 实例：

```
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other
```

```
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化器语法
// 这两个字符串均为空，且彼此等价
```

Find out whether a `String` value is empty by checking its Boolean `isEmpty` property:

通过检查其布尔类型的 `isEmpty` 属性，可以判断一个 `String` 值是否为空：

```
if emptyString.isEmpty {
    print("Nothing to see here")
}
// Prints "Nothing to see here"
// 打印 "Nothing to see here"
```

## 3 String Mutability 字符串的可变性

You indicate whether a particular `String` can be modified (or _mutated_) by assigning it to a variable (in which case it can be modified), or to a constant (in which case it can’t be modified):

通过将字符串赋值给变量（此时字符串可修改）或常量（此时字符串不可修改），来表明特定 `String` 是否能够被修改（或**变更**）：

```
var variableString = "Horse"
variableString += " and carriage"
// variableString is now "Horse and carriage"
// variableString 现在是 "Horse and carriage"

let constantString = "Highlander"
constantString += " and another Highlander"
// this reports a compile-time error - a constant string cannot be modified
// 这会报告一个编译时错误 - 常量字符串不能被修改
```

> **Note** **注意**
>
> This approach is different from string mutation in Objective-C and Cocoa, where you choose between two classes (`NSString` and `NSMutableString`) to indicate whether a string can be mutated.
> 
> 这种方式与 Objective-C 和 Cocoa 中的字符串变更方式不同，在 Objective-C 和 Cocoa 中，你需要在两个类（`NSString` 和 `NSMutableString`）之间做出选择，以此来表明字符串是否可变更。

## 4 Strings Are Value Types 字符串是值类型

Swift’s `String` type is a _value type_. If you create a new `String` value, that `String` value is copied when it’s passed to a function or method, or when it’s assigned to a constant or variable. In each case, a new copy of the existing `String` value is created, and the new copy is passed or assigned, not the original version. Value types are described in [Structures and Enumerations Are Value Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures#Structures-and-Enumerations-Are-Value-Types).

Swift 的 `String` 类型是 **值类型**。当你创建一个新的 `String` 值，并将其传递给函数或方法，或者赋值给常量或变量时，这个 `String` 值会被复制。在上述每种情况下，都会创建现有 `String` 值的一个新副本，并传递或赋值这个新副本，而非原始版本。值类型在《[结构体和枚举是值类型](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/classesandstructures#Structures-and-Enumerations-Are-Value-Types)》中有详细描述。

Swift’s copy-by-default `String` behavior ensures that when a function or method passes you a `String` value, it’s clear that you own that exact `String` value, regardless of where it came from. You can be confident that the string you are passed won’t be modified unless you modify it yourself.

Swift 默认复制 `String` 的行为可以确保当函数或方法传递给你一个 `String` 值时，明确你拥有的就是这个特定的 `String` 值，无论它源自何处。你可以放心，传递给你的字符串不会被修改，除非你自己去修改它。

Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary. This means you always get great performance when working with strings as value types.

在底层，Swift 编译器会优化字符串的使用，只有在绝对必要时才会进行实际的复制操作。这意味着，在将字符串作为值类型使用时，你总能获得出色的性能。

## 5 Working with Characters 处理字符

You can access the individual `Character` values for a String by iterating over the string with a `for-in` loop:

你可以通过 `for-in` 循环遍历字符串，从而访问字符串中的各个 `Character` 值：

```
for character in "Dog!🐶" {
    print(character)
}
// D
// o
// g
// !
// 🐶
```

The `for-in` loop is described in [For-In Loops](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#For-In-Loops).

`for-in` 循环在《[for-in 循环](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#For-In-Loops)》部分有详细介绍。

Alternatively, you can create a stand-alone `Character` constant or variable from a single-character string literal by providing a `Character` type annotation:

另外，你可以通过提供 `Character` 类型注解，从单字符字符串字面量创建一个独立的 `Character` 常量或变量：

```
let exclamationMark: Character = "!"
```

`String` values can be constructed by passing an array of `Character` values as an argument to its initializer:

通过将 `Character` 值的数组作为参数传递给 `String` 的初始化器，可以构造 `String` 值：

```
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// Prints "Cat!🐱"
// 打印 "Cat!🐱"
```

## 6 Concatenating Strings and Characters 拼接字符串和字符

`String` values can be added together (or concatenated) with the addition operator (`+`) to create a new `String` value:

`String` 值可以使用加法运算符（`+`）相加（即拼接），以创建一个新的 `String` 值：

```
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome now equals "hello there"
// welcome 现在等于 "hello there"
```

You can also append a `String` value to an existing `String` variable with the addition assignment operator (`+=`):

你还可以使用加法赋值运算符（`+=`）将一个 `String` 值追加到现有 `String` 变量中：

```
var instruction = "look over"
instruction += string2
// instruction now equals "look over there"
// instruction 现在等于 "look over there"
```

You can append a `Character` value to a `String` variable with the `String` type’s `append()` method:

你可以使用 `String` 类型的 `append()` 方法将一个 `Character` 值追加到 `String` 变量中：

```
let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome now equals "hello there!"
// welcome 现在等于 "hello there!"
```

> **Note** **注意**
>
> You can’t append a `String` or `Character` to an existing `Character` variable, because a `Character` value must contain a single character only.
> 
> 你不能将 `String` 或 `Character` 追加到现有的 `Character` 变量中，因为 `Character` 值必须仅包含单个字符。

If you’re using multiline string literals to build up the lines of a longer string, you want every line in the string to end with a line break, including the last line. For example:

如果你使用多行字符串字面量来构建一个更长字符串的各行内容，你需要让字符串中的每一行（包括最后一行）都以换行符结尾。例如：

```
let badStart = """
    one
    two
    """
let end = """
    three
    """
print(badStart + end)
// Prints two lines:
// one
// twothree
// 打印两行：
// one
// twothree

let goodStart = """
    one
    two

    """
print(goodStart + end)
// Prints three lines:
// one
// two
// three
// 打印三行：
// one
// two
// three
```

In the code above, concatenating `badStart` with `end` produces a two-line string, which isn’t the desired result. Because the last line of `badStart` doesn’t end with a line break, that line gets combined with the first line of `end`. In contrast, both lines of `goodStart` end with a line break, so when it’s combined with `end` the result has three lines, as expected.

在上述代码中，将 `badStart` 与 `end` 拼接会生成一个两行的字符串，这并非预期结果。因为 `badStart` 的最后一行没有以换行符结尾，所以该行与 `end` 的第一行合并了。相比之下，`goodStart` 的两行都以换行符结尾，所以当它与 `end` 合并时，结果如预期般有三行。

## 7 String Interpolation 字符串插值

_String interpolation_ is a way to construct a new `String` value from a mix of constants, variables, literals, and expressions by including their values inside a string literal. You can use string interpolation in both single-line and multiline string literals. Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (`\`):

**字符串插值** 是一种通过在字符串字面量中包含常量、变量、字面量和表达式的值，从而构建新 `String` 值的方法。你可以在单行和多行字符串字面量中使用字符串插值。插入到字符串字面量中的每个项都用一对括号括起来，并以反斜杠（`\`）作为前缀：

```
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"
// message 为 "3 times 2.5 is 7.5"
```

In the example above, the value of `multiplier` is inserted into a string literal as `\(multiplier)`. This placeholder is replaced with the actual value of `multiplier` when the string interpolation is evaluated to create an actual string.

在上述示例中，`multiplier` 的值以 `\(multiplier)` 的形式插入到字符串字面量中。当对字符串插值进行求值以创建实际字符串时，此占位符会被 `multiplier` 的实际值替换。

The value of `multiplier` is also part of a larger expression later in the string. This expression calculates the value of `Double(multiplier) * 2.5` and inserts the result (`7.5`) into the string. In this case, the expression is written as `\(Double(multiplier) * 2.5)` when it’s included inside the string literal.

`multiplier` 的值也是字符串后面一个更大表达式的一部分。此表达式计算 `Double(multiplier) * 2.5` 的值，并将结果（`7.5`）插入到字符串中。在这种情况下，当该表达式包含在字符串字面量中时，写为 `\(Double(multiplier) * 2.5)`。

You can use extended string delimiters to create strings containing characters that would otherwise be treated as a string interpolation. For example:

你可以使用扩展字符串分隔符来创建包含原本会被视为字符串插值的字符的字符串。例如：

```
print(#"Write an interpolated string in Swift using \(multiplier)."#)
// Prints "Write an interpolated string in Swift using \(multiplier)."
// 打印 "Write an interpolated string in Swift using \(multiplier)."
```

To use string interpolation inside a string that uses extended delimiters, match the number of number signs after the backslash to the number of number signs at the beginning and end of the string. For example:

要在使用扩展字符串分隔符的字符串中使用字符串插值，需使反斜杠后面的井号数量与字符串开头和结尾的井号数量相匹配。例如：

```
print(#"6 times 7 is \#(6 * 7)."#)
// Prints "6 times 7 is 42."
// 打印 "6 times 7 is 42."
```

> **Note** **注意**
>
> The expressions you write inside parentheses within an interpolated string can’t contain an unescaped backslash (`\`), a carriage return, or a line feed. However, they can contain other string literals.
> 
> 在插值字符串的括号内编写的表达式不能包含未转义的反斜杠（`\`）、回车符或换行符。但是，它们可以包含其他字符串字面量。


## 8 Unicode 统一码

_Unicode_ is an international standard for encoding, representing, and processing text in different writing systems. It enables you to represent almost any character from any language in a standardized form, and to read and write those characters to and from an external source such as a text file or web page. Swift’s String and Character types are fully Unicode-compliant, as described in this section.

**统一码** 是一种国际标准，用于对不同书写系统中的文本进行编码、表示和处理。它使你能够以标准化形式表示几乎任何语言的任意字符，并可在诸如文本文件或网页等外部来源中读写这些字符。如本节所述，Swift 的 `String` 和 `Character` 类型完全符合统一码标准。

### 8.1 Unicode Scalar Values 统一码标量值

Behind the scenes, Swift’s native `String` type is built from Unicode scalar values. A Unicode scalar value is a unique 21-bit number for a character or modifier, such as `U+0061` for `LATIN SMALL LETTER A` (`"a"`), or `U+1F425` for `FRONT-FACING BABY CHICK` (`"🐥"`).

在底层，Swift 的原生 `String` 类型由统一码标量值构建而成。一个统一码标量值是一个字符或修饰符所对应的唯一的 21 位数字，例如，`U+0061` 代表 `小写拉丁字母 A`（`"a"`），`U+1F425` 代表 `正面的小鸡`（`"🐥"`）。

Note that not all 21-bit Unicode scalar values are assigned to a character — some scalars are reserved for future assignment or for use in UTF-16 encoding. Scalar values that have been assigned to a character typically also have a name, such as `LATIN SMALL LETTER A` and `FRONT-FACING BABY CHICK` in the examples above.

请注意，并非所有 21 位的统一码标量值都分配给了字符 —— 有些标量保留用于未来分配或在 UTF-16 编码中使用。已分配给字符的标量值通常也有名称，比如上述示例中的 `小写拉丁字母 A` 和 `正面的小鸡`。

### 8.2 Extended Grapheme Clusters 扩展字形簇

Every instance of Swift’s `Character` type represents a single _extended grapheme cluster_. An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.

Swift 的 `Character` 类型的每个实例都代表一个 **扩展字形簇**。扩展字形簇是由一个或多个统一码标量组成的序列，这些标量（组合在一起）可生成一个人类可读的字符。

Here’s an example. The letter `é` can be represented as the single Unicode scalar `é` (`LATIN SMALL LETTER E WITH ACUTE`, or `U+00E9`). However, the same letter can also be represented as a pair of scalars — a standard letter `e` (`LATIN SMALL LETTER E`, or `U+0065`), followed by the `COMBINING ACUTE ACCENT` scalar (`U+0301`). The `COMBINING ACUTE ACCENT` scalar is graphically applied to the scalar that precedes it, turning an `e` into an `é` when it’s rendered by a Unicode-aware text-rendering system.

举个例子，字母 `é` 可以用单个统一码标量 `é`（`带急性重音的小写拉丁字母 E`，即 `U+00E9`）来表示。然而，同样的字母也可以用一对标量来表示：一个标准字母 `e`（`小写拉丁字母 E`，即 `U+0065`），后面跟着 `组合急性重音` 标量（`U+0301`）。`组合急性重音` 标量在图形上应用于它前面的标量，当由支持统一码的文本渲染系统进行渲染时，会将 `e` 变成 `é`。

In both cases, the letter `é` is represented as a single Swift `Character` value that represents an extended grapheme cluster. In the first case, the cluster contains a single scalar; in the second case, it’s a cluster of two scalars:

在这两种情况下，字母 `é` 都由单个 Swift `Character` 值表示，该值代表一个扩展字形簇。在第一种情况下，该簇包含单个标量；在第二种情况下，它是由两个标量组成的簇：

```
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
// eAcute is é, combinedEAcute is é
```

```
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面跟着 ́
// eAcute 是 é，combinedEAcute 是 é
```

Extended grapheme clusters are a flexible way to represent many complex script characters as a single `Character` value. For example, Hangul syllables from the Korean alphabet can be represented as either a precomposed or decomposed sequence. Both of these representations qualify as a single `Character` value in Swift:

扩展字形簇是一种灵活的方式，可将许多复杂的文字字符表示为单个 `Character` 值。例如，韩语字母中的音节既可以用预组合序列表示，也可以用分解序列表示。在 Swift 中，这两种表示形式都可视为单个 `Character` 值：

```
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed is 한, decomposed is 한
```

```
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed 是 한，decomposed 是 한
```

Extended grapheme clusters enable scalars for enclosing marks (such as `COMBINING ENCLOSING CIRCLE`, or `U+20DD`) to enclose other Unicode scalars as part of a single `Character` value:

扩展字形簇使得用于封闭标记的标量（如 `组合封闭圆圈`，即 `U+20DD`）能够将其他统一码标量封闭起来，作为单个 `Character` 值的一部分：

```
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute is é⃝
// enclosedEAcute 是 é⃝
```

Unicode scalars for regional indicator symbols can be combined in pairs to make a single `Character` value, such as this combination of `REGIONAL INDICATOR SYMBOL LETTER U` (`U+1F1FA`) and `REGIONAL INDICATOR SYMBOL LETTER S` (`U+1F1F8`):

区域指示符的统一码标量可以成对组合，形成单个 `Character` 值，例如 `区域指示符字母 U`（`U+1F1FA`）和 `区域指示符字母 S`（`U+1F1F8`）的这种组合：

```
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS is 🇺🇸
// regionalIndicatorForUS 是 🇺🇸
```

## 9 Counting Characters 计算字符数

To retrieve a count of the `Character` values in a string, use the `count` property of the string:

若要获取字符串中 `Character` 值的数量，可以使用字符串的 `count` 属性：

```
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// Prints "unusualMenagerie has 40 characters"
// 打印 "unusualMenagerie has 40 characters"
```

Note that Swift’s use of extended grapheme clusters for `Character` values means that string concatenation and modification may not always affect a string’s character count.

需要注意的是，Swift 使用扩展字形簇来表示 `Character` 值，这意味着字符串的拼接和修改并不总是会影响字符串的字符数。

For example, if you initialize a new string with the four-character word `cafe`, and then append a `COMBINING ACUTE ACCENT` (`U+0301`) to the end of the string, the resulting string will still have a character count of `4`, with a fourth character of `é`, not `e`:

例如，如果你用四个字符的单词 `cafe` 初始化一个新字符串，然后在字符串末尾追加一个 `组合急性重音`（`U+0301`），得到的字符串字符数量仍然是 `4`，第四个字符会变成 `é`，而不是 `e`：

```
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in cafe is 4"
// 打印 "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in café is 4"
// 打印 "the number of characters in café is 4"
```

> **Note** **注意**
>
> Extended grapheme clusters can be composed of multiple Unicode scalars. This means that different characters — and different representations of the same character — can require different amounts of memory to store. Because of this, characters in Swift don’t each take up the same amount of memory within a string’s representation. As a result, the number of characters in a string can’t be calculated without iterating through the string to determine its extended grapheme cluster boundaries. If you are working with particularly long string values, be aware that the `count` property must iterate over the Unicode scalars in the entire string in order to determine the characters for that string.
> 
> 扩展字形簇可以由多个 Unicode 标量组成。这意味着不同的字符，以及同一字符的不同表示形式，在存储时可能需要不同大小的内存。因此，在 Swift 中，字符串中每个字符在其表示形式中占用的内存量并不相同。结果是，若不遍历字符串以确定其扩展字形簇的边界，就无法计算字符串中的字符数量。如果你处理的是特别长的字符串值，要注意 `count` 属性必须遍历整个字符串中的 Unicode 标量，才能确定该字符串中的字符数量。
>
> The count of the characters returned by the `count` property isn’t always the same as the `length` property of an `NSString` that contains the same characters. The `length` of an `NSString` is based on the number of 16-bit code units within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the string.
> 
> `count` 属性返回的字符数量，并不总是与包含相同字符的 `NSString` 的 `length` 属性值相同。`NSString` 的 `length` 是基于字符串的 UTF-16 表示形式中的 16 位代码单元数量，而不是字符串中的 Unicode 扩展字形簇数量计算得出的。

## 10 Accessing and Modifying a String 访问和修改字符串

You access and modify a string through its methods and properties, or by using subscript syntax.

你可以通过字符串的方法和属性，或者使用下标语法来访问和修改字符串。

### 10.1 String Indices 字符串索引

Each `String` value has an associated _index type_, `String.Index`, which corresponds to the position of each `Character` in the string.

每个 `String` 值都有一个关联的 **索引类型**，`String.Index`，它对应字符串中每个 `Character` 的位置。

As mentioned above, different characters can require different amounts of memory to store, so in order to determine which `Character` is at a particular position, you must iterate over each Unicode scalar from the start or end of that `String`. For this reason, Swift strings can’t be indexed by integer values.

如前文所述，不同的字符存储所需的内存量可能不同，因此为了确定特定位置的 `Character`，你必须从该 `String` 的开头或结尾遍历每个 Unicode 标量。正因如此，Swift 字符串不能用整数值进行索引。

Use the `startIndex` property to access the position of the first `Character` of a `String`. The `endIndex` property is the position after the last character in a `String`. As a result, the `endIndex` property isn’t a valid argument to a string’s subscript. If a `String` is empty, `startIndex` and `endIndex` are equal.

使用 `startIndex` 属性可以访问一个 `String` 中第一个 `Character` 的位置。`endIndex` 属性表示 `String` 中最后一个字符之后的位置。所以，`endIndex` 属性不能作为字符串下标的有效参数。如果字符串为空，`startIndex` 和 `endIndex` 相等。

You access the indices before and after a given index using the `index(before:)` and `index(after:)` methods of `String`. To access an index farther away from the given index, you can use the `index(_:offsetBy:)` method instead of calling one of these methods multiple times.

你可以使用 `String` 的 `index(before:)` 和 `index(after:)` 方法来访问给定索引之前和之后的索引。若要访问距离给定索引更远的索引，可以使用 `index(_:offsetBy:)` 方法，而无需多次调用前面的方法。

You can use subscript syntax to access the `Character` at a particular `String` index.

你可以使用下标语法来访问特定 `String` 索引处的 `Character`。

```
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a
```

Attempting to access an index outside of a string’s range or a `Character` at an index outside of a string’s range will trigger a runtime error.

尝试访问字符串范围之外的索引，或者访问字符串范围之外索引处的 `Character`，会触发运行时错误。

```
greeting[greeting.endIndex] // Error
greeting.index(after: greeting.endIndex) // Error
```

Use the indices property to access all of the indices of individual characters in a string.

使用 `indices` 属性可以访问字符串中各个字符的所有索引。

```
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "
// 打印 "G u t e n   T a g ! "
```

> **Note** **注意**
>
> You can use the `startIndex` and `endIndex` properties and the `index(before:)`, `index(after:)`, and `index(_:offsetBy:)` methods on any type that conforms to the `Collection` protocol. This includes `String`, as shown here, as well as collection types such as `Array`, `Dictionary`, and `Set`.
> 
> 你可以在任何遵循 `Collection` 协议的类型上使用 `startIndex` 和 `endIndex` 属性，以及 `index(before:)`、`index(after:)` 和 `index(_:offsetBy:)` 方法。这里以 `String` 为例，其他集合类型如 `Array`、`Dictionary` 和 `Set` 也适用。

### 10.2 Inserting and Removing 插入和删除

To insert a single character into a string at a specified index, use the `insert(_:at:)` method, and to insert the contents of another string at a specified index, use the `insert(contentsOf:at:)` method.

若要在字符串的指定索引处插入单个字符，可使用 `insert(_:at:)` 方法；若要在指定索引处插入另一个字符串的内容，可使用 `insert(contentsOf:at:)` 方法。

```
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"
// welcome 现在等于 "hello!"

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"
// welcome 现在等于 "hello there!"
```

To remove a single character from a string at a specified index, use the `remove(at:)` method, and to remove a substring at a specified range, use the `removeSubrange(_:)` method:

若要从字符串的指定索引处删除单个字符，可使用 `remove(at:)` 方法；若要删除指定范围的子字符串，可使用 `removeSubrange(_:)` 方法：

```
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there"
// welcome 现在等于 "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome now equals "hello"
// welcome 现在等于 "hello"
```

> **Note**
>
> You can use the `insert(_:at:)`, `insert(contentsOf:at:)`, `remove(at:)`, and `removeSubrange(_:)` methods on any type that conforms to the `RangeReplaceableCollection` protocol. This includes `String`, as shown here, as well as collection types such as `Array`, `Dictionary`, and `Set`.
> 
> 你可以在任何遵循 `RangeReplaceableCollection` 协议的类型上使用 `insert(_:at:)`、`insert(contentsOf:at:)`、`remove(at:)` 和 `removeSubrange(_:)` 方法。这里以 `String` 为例，其他集合类型如 `Array`、`Dictionary` 和 `Set` 也适用。

## 11 Substrings 子字符串

When you get a substring from a string — for example, using a subscript or a method like `prefix(_:)` — the result is an instance of [Substring](https://developer.apple.com/documentation/swift/substring), not another string. Substrings in Swift have most of the same methods as strings, which means you can work with substrings the same way you work with strings. However, unlike strings, you use substrings for only a short amount of time while performing actions on a string. When you’re ready to store the result for a longer time, you convert the substring to an instance of `String`. For example:

当你从一个字符串中获取子字符串时，例如使用下标或者像 `prefix(_:)` 这样的方法，得到的结果是 [Substring](https://developer.apple.com/documentation/swift/substring) 类型的实例，而不是另一个字符串。在 Swift 中，子字符串拥有大部分和字符串相同的方法，这意味着你可以像使用字符串一样使用子字符串。不过，和字符串不同的是，你通常只在对字符串执行操作的短时间内使用子字符串。当你需要长期保存结果时，就要把这个子字符串转换为 `String` 类型的实例。示例如下：

```
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"
// beginning 是 "Hello"

// Convert the result to a String for long-term storage.
// 将结果转换为 String 类型以便长期存储
let newString = String(beginning)
```

Like strings, each substring has a region of memory where the characters that make up the substring are stored. The difference between strings and substrings is that, as a performance optimization, a substring can reuse part of the memory that’s used to store the original string, or part of the memory that’s used to store another substring. (Strings have a similar optimization, but if two strings share memory, they’re equal.) This performance optimization means you don’t have to pay the performance cost of copying memory until you modify either the string or substring. As mentioned above, substrings aren’t suitable for long-term storage — because they reuse the storage of the original string, the entire original string must be kept in memory as long as any of its substrings are being used.

和字符串一样，每个子字符串也有一块内存区域来存储组成它的字符。字符串和子字符串的区别在于，为了优化性能，子字符串可以复用存储原始字符串的部分内存，或者复用存储另一个子字符串的部分内存。（字符串也有类似的优化，但如果两个字符串共享内存，它们就是相等的）。这种性能优化意味着在你修改字符串或者子字符串之前，不需要承担复制内存带来的性能开销。正如前面提到的，子字符串不适合长期存储，因为它们复用了原始字符串的存储空间，只要它的任何一个子字符串还在使用，整个原始字符串就必须保留在内存中。

In the example above, `greeting` is a string, which means it has a region of memory where the characters that make up the string are stored. Because `beginning` is a substring of `greeting`, it reuses the memory that `greeting` uses. In contrast, `newString` is a string — when it’s created from the substring, it has its own storage. The figure below shows these relationships:

在上面的例子里，`greeting` 是一个字符串，这意味着它有一块内存区域用来存储组成这个字符串的字符。因为 `beginning` 是 `greeting` 的子字符串，它复用了 `greeting` 所使用的内存。相比之下，`newString` 是一个字符串，当它从子字符串创建时，就有了自己独立的存储空间。下面的图展示了这些关系：

![](https://docs.swift.org/swift-book/images/org.swift.tspl/stringSubstring@2x.png)


> **Note** **注意**
>
> Both `String` and `Substring` conform to the `StringProtocol` protocol, which means it’s often convenient for string-manipulation functions to accept a `StringProtocol` value. You can call such functions with either a `String` or `Substring` value.
> 
> `String` 和 `Substring` 都遵循 `StringProtocol` 协议，这意味着在编写字符串操作函数时，让这些函数接受 `StringProtocol` 类型的值通常会很方便。你可以使用 `String` 或者 `Substring` 类型的值来调用这些函数。

## 12 Comparing Strings 字符串比较

Swift provides three ways to compare textual values: string and character equality, prefix equality, and suffix equality.

Swift 提供了三种比较文本值的方式：字符串和字符相等性比较、前缀相等性比较以及后缀相等性比较。

### 12.1 String and Character Equality 字符串和字符相等性

String and character equality is checked with the “equal to” operator (`==`) and the “not equal to” operator (`!=`), as described in [Comparison Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Comparison-Operators):

字符串和字符的相等性通过 “等于” 运算符（`==`）和 “不等于” 运算符（`!=`）来检查，如《[比较运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Comparison-Operators)》中所述：

```
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"
// 打印 “These two strings are considered equal”
```

Two `String` values (or two `Character` values) are considered equal if their extended grapheme clusters are _canonically equivalent_. Extended grapheme clusters are canonically equivalent if they have the same linguistic meaning and appearance, even if they’re composed from different Unicode scalars behind the scenes.

如果两个 `String` 值（或两个 `Character` 值）的扩展字形簇是 **规范等价** 的，则它们被视为相等。即使扩展字形簇在底层由不同的 Unicode 标量组成，但只要它们具有相同的语言含义和外观，就被认为规范等价。

For example, `LATIN SMALL LETTER E WITH ACUTE` (`U+00E9`) is canonically equivalent to `LATIN SMALL LETTER E` (`U+0065`) followed by `COMBINING ACUTE ACCENT` (`U+0301`). Both of these extended grapheme clusters are valid ways to represent the character `é`, and so they’re considered to be canonically equivalent:

例如，`带重音符号的小写拉丁字母 e`（`U+00E9`）与 `小写拉丁字母 e`（`U+0065`）后跟 `组合重音符号`（`U+0301`）是规范等价的。这两个扩展字形簇都是表示字符 `é` 的有效方式，因此它们被视为规范等价：

```
// "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
// “Voulez-vous un café?” 使用带重音符号的小写拉丁字母 e
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
// “Voulez-vous un café?” 使用小写拉丁字母 e 和组合重音符号
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"
// 打印 “These two strings are considered equal”
```

Conversely, `LATIN CAPITAL LETTER A` (`U+0041`, or `"A"`), as used in English, is not equivalent to `CYRILLIC CAPITAL LETTER A` (`U+0410`, or `"А"`), as used in Russian. The characters are visually similar, but don’t have the same linguistic meaning:

相反，英语中使用的 `大写拉丁字母 A`（`U+0041`，即 `"А"`）与俄语中使用的 `大写西里尔字母 А`（`U+0410`，即 `"А"`）并不等效。这两个字符在视觉上相似，但语言含义不同：

```
let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters aren't equivalent.")
}
// Prints "These two characters aren't equivalent."
// 打印 “These two characters aren't equivalent.”
```

> **Note** **注意**
> 
> String and character comparisons in Swift aren’t locale-sensitive.
> 
> Swift 中的字符串和字符比较不区分地域设置。

### 12.2 Prefix and Suffix Equality 前缀和后缀相等性

To check whether a string has a particular string prefix or suffix, call the string’s `hasPrefix(_:)` and `hasSuffix(_:)` methods, both of which take a single argument of type `String` and return a Boolean value.

要检查一个字符串是否具有特定的字符串前缀或后缀，可以调用字符串的 `hasPrefix(_:)` 和 `hasSuffix(_:)` 方法，这两个方法都接受一个 `String` 类型的参数并返回一个布尔值。

The examples below consider an array of strings representing the scene locations from the first two acts of Shakespeare’s _Romeo and Juliet_:

以下示例假设有一个字符串数组，该数组表示莎士比亚《罗密欧与朱丽叶》前两幕的场景位置：

```
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
```

You can use the `hasPrefix(_:)` method with the `romeoAndJuliet` array to count the number of scenes in Act 1 of the play:

你可以对 `romeoAndJuliet` 数组使用 `hasPrefix(_:)` 方法来统计该剧第一幕中的场景数量：

```
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"
// 打印 “There are 5 scenes in Act 1”
```

Similarly, use the `hasSuffix(_:)` method to count the number of scenes that take place in or around Capulet’s mansion and Friar Lawrence’s cell:

同样，可以使用 `hasSuffix(_:)` 方法来统计发生在凯普莱特府邸或附近以及劳伦斯神父密室的场景数量：

```
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// Prints "6 mansion scenes; 2 cell scenes"
// 打印 “6 mansion scenes; 2 cell scenes”
```

> **Note** ****
>
> The `hasPrefix(_:)` and `hasSuffix(_:)` methods perform a character-by-character canonical equivalence comparison between the extended grapheme clusters in each string, as described in [String and Character Equality](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#String-and-Character-Equality).
> 
> `hasPrefix(_:)` 和 `hasSuffix(_:)` 方法会对每个字符串中的扩展字形簇按照《[字符串和字符相等性](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#String-and-Character-Equality)》中所述进行逐个字符的规范等价比较。

## 13 Unicode Representations of Strings 字符串的 Unicode 表示形式

When a Unicode string is written to a text file or some other storage, the Unicode scalars in that string are encoded in one of several Unicode-defined _encoding forms_. Each form encodes the string in small chunks known as _code units_. These include the UTF-8 encoding form (which encodes a string as 8-bit code units), the UTF-16 encoding form (which encodes a string as 16-bit code units), and the UTF-32 encoding form (which encodes a string as 32-bit code units).

当一个 Unicode 字符串被写入文本文件或其他存储介质时，该字符串中的 Unicode 标量会以几种 Unicode 定义的 **编码形式** 之一进行编码。每种形式都将字符串编码为称为 **代码单元** 的小块。这些编码形式包括 UTF-8 编码形式（将字符串编码为 8 位代码单元）、UTF-16 编码形式（将字符串编码为 16 位代码单元）以及 UTF-32 编码形式（将字符串编码为 32 位代码单元）。

Swift provides several different ways to access Unicode representations of strings. You can iterate over the string with a `for-in` statement, to access its individual `Character` values as Unicode extended grapheme clusters. This process is described in [Working with Characters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#Working-with-Characters).

Swift 提供了几种不同的方式来访问字符串的 Unicode 表示形式。你可以使用 `for-in` 语句遍历字符串，以 Unicode 扩展字形簇的形式访问其各个 `Character` 值。这个过程在《[处理字符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters#Working-with-Characters)》部分有描述。

Alternatively, access a `String` value in one of three other Unicode-compliant representations:

另外，还可以通过以下三种符合 Unicode 标准的表示形式之一来访问 `String` 值：

- A collection of UTF-8 code units (accessed with the string’s `utf8` property)
- A collection of UTF-16 code units (accessed with the string’s `utf16` property)
- A collection of 21-bit Unicode scalar values, equivalent to the string’s UTF-32 encoding form (accessed with the string’s `unicodeScalars` property)
- 一个 UTF-8 代码单元集合（通过字符串的 `utf8` 属性访问）
- 一个 UTF-16 代码单元集合（通过字符串的 `utf16` 属性访问）
- 一个 21 位 Unicode 标量值集合，等同于字符串的 UTF-32 编码形式（通过字符串的 `unicodeScalars` 属性访问）

Each example below shows a different representation of the following string, which is made up of the characters `D`, `o`, `g`, `‼` (`DOUBLE EXCLAMATION MARK`, or Unicode scalar `U+203C`), and the `🐶` character (`DOG FACE`, or Unicode scalar `U+1F436`):

以下每个示例展示了由字符 `D`、`o`、`g`、`‼`（`双感叹号`，即 Unicode 标量 `U+203C`）和🐶字符（`狗脸`，即 Unicode 标量 `U+1F436`）组成的字符串的不同表示形式：

```
let dogString = "Dog‼🐶"
```

### 13.1 UTF-8 Representation UTF-8 表示形式

You can access a UTF-8 representation of a `String` by iterating over its `utf8` property. This property is of type `String.UTF8View`, which is a collection of unsigned 8-bit (`UInt8`) values, one for each byte in the string’s UTF-8 representation:

你可以通过遍历 `String` 的 `utf8` 属性来访问其 UTF-8 表示形式。此属性的类型为 `String.UTF8View`，它是一个无符号 8 位（`UInt8`）值的集合，字符串的 UTF-8 表示形式中的每个字节对应一个值：

![utf-8](https://docs.swift.org/swift-book/images/org.swift.tspl/UTF8@2x.png)

```
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 226 128 188 240 159 144 182 "
```

In the example above, the first three decimal `codeUnit` values (`68`, `111`, `103`) represent the characters `D`, `o`, and `g`, whose UTF-8 representation is the same as their ASCII representation. The next three decimal `codeUnit` values (`226`, `128`, `188`) are a three-byte UTF-8 representation of the `DOUBLE EXCLAMATION MARK` character. The last four `codeUnit` values (`240`, `159`, `144`, `182`) are a four-byte UTF-8 representation of the `DOG FACE` character.

在上述示例中，前三个十进制 `codeUnit` 值（`68`、`111`、`103`）表示字符 `D`、`o` 和 `g`，它们的 UTF-8 表示形式与 ASCII 表示形式相同。接下来的三个十进制 `codeUnit` 值（`226`、`128`、`188`）是`双感叹号`字符的三字节 UTF-8 表示形式。最后四个 `codeUnit` 值（`240`、`159`、`144`、`182`）是`狗脸`字符的四字节 UTF-8 表示形式。

### 13.2 UTF-16 Representation UTF-16 表示形式

You can access a UTF-16 representation of a `String` by iterating over its `utf16` property. This property is of type `String.UTF16View`, which is a collection of unsigned 16-bit (`UInt16`) values, one for each 16-bit code unit in the string’s UTF-16 representation:

你可以通过遍历 `String` 的 `utf16` 属性来访问其 UTF-16 表示形式。此属性的类型为 `String.UTF16View`，它是一个无符号 16 位（`UInt16`）值的集合，字符串的 UTF-16 表示形式中的每个 16 位代码单元对应一个值：

![utf-16](https://docs.swift.org/swift-book/images/org.swift.tspl/UTF16@2x.png)

```
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 55357 56374 "
```

Again, the first three `codeUnit` values (`68`, `111`, `103`) represent the characters `D`, `o`, and `g`, whose UTF-16 code units have the same values as in the string’s UTF-8 representation (because these Unicode scalars represent ASCII characters).

同样，前三个 `codeUnit` 值（`68`、`111`、`103`）表示字符 `D`、`o` 和 `g`，它们的 UTF-16 代码单元值与字符串的 UTF-8 表示形式中的值相同（因为这些 Unicode 标量表示 ASCII 字符）。

The fourth `codeUnit` value (`8252`) is a decimal equivalent of the hexadecimal value `203C`, which represents the Unicode scalar `U+203C` for the `DOUBLE EXCLAMATION MARK` character. This character can be represented as a single code unit in UTF-16.

第四个 `codeUnit` 值（`8252`）是十六进制值 `203C` 的十进制等效值，它表示 `双感叹号` 字符的 Unicode 标量 `U+203C`。这个字符在 UTF-16 中可以用单个代码单元表示。

The fifth and sixth `codeUnit` values (`55357` and `56374`) are a UTF-16 surrogate pair representation of the `DOG FACE` character. These values are a high-surrogate value of `U+D83D` (decimal value `55357`) and a low-surrogate value of `U+DC36` (decimal value `56374`).

第五个和第六个 `codeUnit` 值（`55357` 和 `56374`）是 `狗脸` 字符的 UTF-16 代理对表示形式。这些值分别是高代理值 `U+D83D`（十进制值 `55357`）和低代理值 `U+DC36`（十进制值 `56374`）。

### 13.3 Unicode Scalar Representation Unicode 标量表示形式

You can access a Unicode scalar representation of a `String` value by iterating over its `unicodeScalars` property. This property is of type `UnicodeScalarView`, which is a collection of values of type `UnicodeScalar`.

你可以通过遍历 `String` 的 `unicodeScalars` 属性来访问其 Unicode 标量表示形式。此属性的类型为 `UnicodeScalarView`，它是一个 `UnicodeScalar` 类型值的集合。

Each `UnicodeScalar` has a `value` property that returns the scalar’s 21-bit value, represented within a `UInt32` value:

每个 `UnicodeScalar` 都有一个 `value` 属性，该属性返回标量的 21 位值，以 `UInt32` 值表示：

```
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 128054 "
```

The value properties for the first three `UnicodeScalar` values (`68`, `111`, `103`) once again represent the characters `D`, `o`, and `g`.

前三个 `UnicodeScalar` 值的 `value` 属性（`68`、`111`、`103`）依然表示字符 `D`、`o` 和 `g`。

The fourth `codeUnit` value (`8252`) is again a decimal equivalent of the hexadecimal value `203C`, which represents the Unicode scalar `U+203C` for the `DOUBLE EXCLAMATION MARK` character.

第四个 `codeUnit` 值（`8252`）同样是十六进制值 `203C` 的十进制等效值，它表示 `双感叹号` 字符的 Unicode 标量 `U+203C`。

The `value` property of the fifth and final `UnicodeScalar`, `128054`, is a decimal equivalent of the hexadecimal value `1F436`, which represents the Unicode scalar `U+1F436` for the `DOG FACE` character.

第五个也是最后一个 `UnicodeScalar` 的 `value` 属性值 `128054`，是十六进制值 `1F436` 的十进制等效值，它表示 `狗脸` 字符的 Unicode 标量 `U+1F436`。

As an alternative to querying their `value` properties, each `UnicodeScalar` value can also be used to construct a new `String` value, such as with string interpolation:

除了查询它们的 `value` 属性外，每个 `UnicodeScalar` 值还可用于构造一个新的 `String` 值，例如通过字符串插值：

```
for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}
// D
// o
// g
// ‼
// 🐶
```

