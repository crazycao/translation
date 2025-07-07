# Enumerations 枚举

> Model custom types that define a list of possible values.
> 
> 对自定义类型进行建模，定义可能取值列表。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations)

An _enumeration_ defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.

**枚举** 为一组相关的值定义了一个公共类型，使你能够在代码中以类型安全的方式处理这些值。

If you are familiar with C, you will know that C enumerations assign related names to a set of integer values. Enumerations in Swift are much more flexible, and don’t have to provide a value for each case of the enumeration. If a value (known as a _raw value_) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type.

如果你熟悉 C 语言，你会知道 C 的枚举为一组整数值分配了相关的名称。Swift 中的枚举更加灵活，不必为枚举的每个用例（case）都提供一个值。如果为每个枚举用例提供了一个值（称为**原始值**），那么这个值可以是字符串、字符，或者是任何整数或浮点类型的值。

Alternatively, enumeration cases can specify _associated values_ of any type to be stored along with each different case value, much as unions or variants do in other languages. You can define a common set of related cases as part of one enumeration, each of which has a different set of values of appropriate types associated with it.

另外，枚举用例还可以指定与其一起存储的任意类型的**关联值**，这与其他语言中的联合体（union）或变体（variant）类似。你可以将一组常见的相关用例定义为一个枚举的一部分，每个用例都有一组适当类型的不同值与之关联。

Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial case value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality.

在 Swift 中，枚举是一等公民类型。它们拥有许多传统上仅由类支持的特性，例如计算属性（computed properties）可以提供关于枚举当前值的额外信息，实例方法（instance methods）可以提供与枚举所表示的值相关的功能。枚举还可以定义初始化器（initializers）来提供一个初始用例值；可以通过扩展（extensions）来扩展其功能，超越其原始实现；还可以遵循协议（protocols）以提供标准功能。

For more about these capabilities, see [Properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties), [Methods](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods), [Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization), [Extensions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions), and [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols).

有关这些特性的更多信息，请参见《[属性](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties)》、《[方法](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods)》、《[初始化](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization)》、《[扩展](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions)》和《[协议](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols)》。

# 1 Enumeration Syntax 枚举语法

You introduce enumerations with the `enum` keyword and place their entire definition within a pair of braces:

你可以使用 `enum` 关键字来引入枚举类型，并将其整个定义放在一对花括号内：

```
enum SomeEnumeration {
    // enumeration definition goes here
    // 枚举定义放在这里。
}
```

Here’s an example for the four main points of a compass:

以下是一个示例，表示指南针四个主要方位：

```
enum CompassPoint {
    case north
    case south
    case east
    case west
}
```

The values defined in an enumeration (such as `north`, `south`, `east`, and `west`) are its _enumeration cases_. You use the `case` keyword to introduce new enumeration cases.

枚举中定义的值（如 `north`、`south`、`east` 和 `west`）称为 **枚举用例**。你使用 `case` 关键字来引入新的枚举用例。

> **Note** **注意**
>
> Swift enumeration cases don’t have an integer value set by default, unlike languages like C and Objective-C. In the `CompassPoint` example above, `north`, `south`, `east` and `west` don’t implicitly equal `0`, `1`, `2` and `3`. Instead, the different enumeration cases are values in their own right, with an explicitly defined type of `CompassPoint`.
> 
> 与 C 和 Objective-C 等语言不同，Swift 的枚举用例默认没有设置整数值。在上述 `CompassPoint` 示例中，`north`、`south`、`east` 和 `west` 并不会隐式地等同于 `0`、`1`、`2` 和 `3`。相反，不同的枚举用例本身就是值，其类型会显式定义为 `CompassPoint`。

Multiple cases can appear on a single line, separated by commas:

多个用例可以出现在同一行，并用逗号分隔：

```
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

Each enumeration definition defines a new type. Like other types in Swift, their names (such as `CompassPoint` and `Planet`) start with a capital letter. Give enumeration types singular rather than plural names, so that they read as self-evident:

每个枚举定义都会定义一个新类型。与 Swift 中的其他类型一样，它们的名称（如 `CompassPoint` 和 `Planet`）以大写字母开头。为枚举类型命名时使用单数形式而非复数形式，使其含义一目了然：

```
var directionToHead = CompassPoint.west
```

The type of `directionToHead` is inferred when it’s initialized with one of the possible values of `CompassPoint`. Once `directionToHead` is declared as a `CompassPoint`, you can set it to a different `CompassPoint` value using a shorter dot syntax:

当使用 `CompassPoint` 的某个可能值对 `directionToHead` 进行初始化时，其类型会被推断出来。一旦 `directionToHead` 被声明为 `CompassPoint` 类型，你就可以使用更简短的点语法将其设置为不同的 `CompassPoint` 值：

```
directionToHead = .east
```

The type of `directionToHead` is already known, and so you can drop the type when setting its value. This makes for highly readable code when working with explicitly typed enumeration values.

已经知道了 `directionToHead` 的类型，就可以在设置其值时省略类型。在使用显式类型化的枚举值时，这使得代码具有很高的可读性。

# 2 Matching Enumeration Values with a Switch Statement 使用 switch 语句匹配枚举值

You can match individual enumeration values with a `switch` statement:

你可以通过 `switch` 语句匹配单个枚举值：

```
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
// 输出 "Watch out for penguins"
```

You can read this code as:

这段代码可以理解为：

“Consider the value of `directionToHead`. In the case where it equals `.north`, print "Lots of planets have a north". In the case where it equals `.south`, print "Watch out for penguins".”

“考虑 `directionToHead` 的值。当它等于 `.north` 时，打印‘许多行星都有北极’；当它等于 `.south` 时，打印‘小心企鹅’……” 以此类推。

…and so on.

以此类推。

As described in [Control Flow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow), a `switch` statement must be exhaustive when considering an enumeration’s cases. If the case for `.west` is omitted, this code doesn’t compile, because it doesn’t consider the complete list of `CompassPoint` cases. Requiring exhaustiveness ensures that enumeration cases aren’t accidentally omitted.

如《[控制流](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)》所述，当使用 `switch` 语句处理枚举用例时，必须覆盖所有情况。如果省略 `.west` 的 case 分支，代码将无法编译，因为它没有考虑 `CompassPoint` 的所有枚举用例。必须穷举所有情况，以确保不会意外遗漏枚举用例。

When it isn’t appropriate to provide a case for every enumeration case, you can provide a `default` case to cover any cases that aren’t addressed explicitly:

当不需要为每个枚举用例都提供 case 分支时，可以使用 `default` 分支覆盖未显式处理的所有情况：

```
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"
// 输出 "Mostly harmless"
```

# 3 Iterating over Enumeration Cases 遍历枚举用例

For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing `: CaseIterable` after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:

对于某些枚举，获取其所有用例的集合会很有用。要实现这一点，可在枚举名称后添加 `: CaseIterable`。Swift 会将所有用例的集合作为枚举类型的 `allCases` 属性暴露出来。示例如下：

```
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"
```

In the example above, you write `Beverage.allCases` to access a collection that contains all of the cases of the `Beverage` enumeration. You can use `allCases` like any other collection — the collection’s elements are instances of the enumeration type, so in this case they’re `Beverage` values. The example above counts how many cases there are, and the example below uses a `for-in` loop to iterate over all the cases.

在上述示例中，通过 `Beverage.allCases` 访问包含 `Beverage` 枚举的所有用例的集合。`allCases` 可像其他集合一样使用 —— 集合中的元素是枚举类型的实例，因此在这个例子中它们是 `Beverage` 类型的值。上面的示例计算了用例数量，下面的示例则使用 `for-in` 循环遍历所有用例：

```
for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
```

The syntax used in the examples above marks the enumeration as conforming to the `CaseIterable` protocol. For information about protocols, see [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols).

上述示例中使用的语法标记枚举遵循了 `CaseIterable` 协议。有关协议的信息，请参阅《[协议](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols)》。


# 4 Associated Values 关联值

The examples in the previous section show how the cases of an enumeration are a defined (and typed) value in their own right. You can set a constant or variable to `Planet.earth`, and check for this value later. However, it’s sometimes useful to be able to store values of other types alongside these case values. This additional information is called an _associated value_, and it varies each time you use that case as a value in your code.

上一节中的示例展示了枚举的 case 本身就是一个已定义（且有类型）的值。你可以将一个常量或变量设置为 `Planet.earth`，并在以后检查该值。然而，有时能够将其他类型的值与这些用例值一起存储是很有用的。这个附加信息称为 **关联值**，每次在代码中将该用例作为值使用时，它都会变化。

You can define Swift enumerations to store associated values of any given type, and the value types can be different for each case of the enumeration if needed. Enumerations similar to these are known as _discriminated unions_, _tagged unions_, or _variants_ in other programming languages.

你可以定义 Swift 枚举来存储任何给定类型的关联值，并且如果需要，枚举的每个用例的值类型可以不同。类似这样的枚举在其他编程语言中被称为 **区分联合**、**标记联合** 或 **变体**。

For example, suppose an inventory tracking system needs to track products by two different types of barcode. Some products are labeled with 1D barcodes in UPC format, which uses the numbers 0 to 9. Each barcode has a number system digit, followed by five manufacturer code digits and five product code digits. These are followed by a check digit to verify that the code has been scanned correctly:

例如，假设库存跟踪系统需要通过两种不同类型的条形码跟踪产品。一些产品标有 UPC 格式的 1D 条形码，它使用数字 0 到 9。每个条形码有一个数字系统位，后跟五个制造商代码位和五个产品代码位。随后是一个校验位，用于验证代码已被正确扫描：

![](./images/8-4-barcode_UPC@2x.png)

Other products are labeled with 2D barcodes in QR code format, which can use any ISO 8859-1 character and can encode a string up to 2,953 characters long:

其他产品标有 QR 码格式的 2D 条形码，它可以使用任何 ISO 8859-1 字符，并且可以编码长达 2,953 个字符的字符串：

![](./images/8-4-barcode_QR@2x.png)

It’s convenient for an inventory tracking system to store UPC barcodes as a tuple of four integers, and QR code barcodes as a string of any length.

库存跟踪系统将 UPC 条形码存储为四个整数的元组，将 QR 码条形码存储为任意长度的字符串，这很方便。

In Swift, an enumeration to define product barcodes of either type might look like this:

在 Swift 中，定义任一类型产品条形码的枚举可能如下所示：

```
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

This can be read as:

这可以理解为：

“Define an enumeration type called `Barcode`, which can take either a value of `upc` with an associated value of type `(Int, Int, Int, Int)`, or a value of `qrCode` with an associated value of type `String`.”

“定义一个名为 `Barcode` 的枚举类型，它可以采用关联值的类型为 `(Int, Int, Int, Int)` 的 `upc`，也可以采用关联值的类型为 `String` 的 `qrCode`。”

This definition doesn’t provide any actual `Int` or `String` values — it just defines the type of associated values that `Barcode` constants and variables can store when they’re equal to `Barcode.upc` or `Barcode.qrCode`.

此定义不提供任何实际的 `Int` 或 `String` 值，它只是定义了当 `Barcode` 常量和变量等于 `Barcode.upc` 或 `Barcode.qrCode` 时可以存储的关联值的类型。

You can then create new barcodes using either type:

然后，你可以使用任一类型创建新的条形码：

```
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
```

This example creates a new variable called `productBarcode` and assigns it a value of `Barcode.upc` with an associated tuple value of `(8, 85909, 51226, 3)`.

此示例创建一个名为 `productBarcode` 的新变量，并为其分配 `Barcode.upc` 值，其关联的元组值为 `(8, 85909, 51226, 3)`。

You can assign the same product a different type of barcode:

你可以为同一产品分配不同类型的条形码：

```
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
```

At this point, the original `Barcode.upc` and its integer values are replaced by the new `Barcode.qrCode` and its string value. Constants and variables of type `Barcode` can store either a `.upc` or a `.qrCode` (together with their associated values), but they can store only one of them at any given time.

此时，原始的 `Barcode.upc` 及其整数值将被新的 `Barcode.qrCode` 及其字符串值取代。`Barcode` 类型的常量和变量可以存储 `.upc` 或 `.qrCode`（以及它们的关联值），但在任何时候它们只能存储其中一个。

You can check the different barcode types using a switch statement, similar to the example in [Matching Enumeration Values with a Switch Statement](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations#Matching-Enumeration-Values-with-a-Switch-Statement). This time, however, the associated values are extracted as part of the switch statement. You extract each associated value as a constant (with the `let` prefix) or a variable (with the `var` prefix) for use within the `switch` case’s body:

你可以使用 switch 语句检查不同的条形码类型，这与《[使用 switch 语句匹配枚举值](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations#Matching-Enumeration-Values-with-a-Switch-Statement)》中的示例类似。然而，这一次，关联值作为 switch 语句的一部分被提取。你将每个关联值提取为常量（使用 `let` 前缀）或变量（使用 `var` 前缀），以便在 `switch` 的 case 主体中使用：

```
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

If all of the associated values for an enumeration case are extracted as constants, or if all are extracted as variables, you can place a single `let` or `var` annotation before the case name, for brevity:

如果某个枚举用例的所有关联值都被提取为常量，或者都被提取为变量，为简洁起见，你可以在 case 名称前放置单个 `let` 或 `var` 注释：

```
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

When you’re matching just one case of an enumeration — for example, to extract its associated value — you can use an `if-case` statement instead of writing a full switch statement. Here’s what it looks like:

当你仅匹配枚举的一个用例时（例如，提取其关联值），你可以使用 `if-case` 语句而不是编写完整的 switch 语句。如下所示：

```
if case .qrCode(let productCode) = productBarcode {
    print("QR code: \(productCode).")
}
```

Just like in the switch statement earlier, the `productBarcode` variable is matched against the pattern `.qrCode(let productCode)` here. And as in the switch case, writing `let` extracts the associated value as a constant. For more information about `if-case` statements, see [Patterns](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#Patterns).

就像前面的 switch 语句一样，这里将 `productBarcode` 变量与模式 `.qrCode (let productCode)` 进行匹配。与 switch case 中一样，编写 `let` 会将关联值提取为常量。有关 `if-case` 语句的更多信息，请参见《[模式](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#Patterns)》。

# 5 Raw Values 原始值

The barcode example in [Associated Values](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations#Associated-Values) shows how cases of an enumeration can declare that they store associated values of different types. As an alternative to associated values, enumeration cases can come prepopulated with default values (called _raw values_), which are all of the same type.

在《[关联值](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations#Associated-Values)》部分的条形码示例中，枚举用例展示了如何声明存储不同类型的关联值。作为关联值的替代方案，枚举用例可以预先填充默认值（称为 **原始值**），且这些原始值的类型必须一致。

Here’s an example that stores raw ASCII values alongside named enumeration cases:

以下是一个将命名枚举用例与 ASCII 原始值关联存储的示例：

```
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```

Here, the raw values for an enumeration called `ASCIIControlCharacter` are defined to be of type `Character`, and are set to some of the more common ASCII control characters. `Character` values are described in [Strings and Characters](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters).

在此示例中，名为 `ASCIIControlCharacter` 的枚举将原始值定义为 `Character` 类型，并设置为一些常见的 ASCII 控制字符。`Character` 值的详细说明见《[字符串和字符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/stringsandcharacters)》。

Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.

原始值可以是字符串、字符，或任意整数或浮点数类型。每个原始值在枚举声明中必须唯一。

Although you can use both raw values and associated values to give an enumeration an additional value, it’s important to understand the difference between them. You pick the raw value for an enumeration case when you define that enumeration case in your code, such as the three ASCII codes above. The raw value for a particular enumeration case is always the same. In contrast, you pick associated values when you create a new constant or variable using one of the enumeration’s cases, and you can pick a different value each time you do so.

尽管既可以使用原始值也可以使用关联值为枚举提供附加值，但理解两者的区别至关重要。当你在代码中定义枚举用例，如果枚举用例的原始值始终保持不变，需要给该枚举用例采用原始值，例如上述三个 ASCII 码。相比之下，当使用枚举用例创建新的常量或变量时，需要选择关联值，并且每次使用时都可以为其赋予不同的值。

## 5.1 Implicitly Assigned Raw Values 隐式分配的原始值

When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift automatically assigns the values for you.

当使用存储整数或字符串原始值的枚举时，不必为每个用例显式分配原始值。若未显式分配，Swift 会自动为其赋值。

For example, when integers are used for raw values, the implicit value for each case is one more than the previous case. If the first case doesn’t have a value set, its value is `0`.

例如，当使用整数作为原始值时，每个用例的隐式值比前一个用例大 1。若第一个用例未设置值，则其值为 `0`。

The enumeration below is a refinement of the earlier `Planet` enumeration, with integer raw values to represent each planet’s order from the sun:

以下枚举是对之前 `Planet` 枚举的改进，使用整数原始值表示每个行星与太阳的距离顺序：

```
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

In the example above, `Planet.mercury` has an explicit raw value of `1`, `Planet.venus` has an implicit raw value of `2`, and so on.

在上述示例中，`Planet.mercury` 的显式原始值为 `1`，`Planet.venus` 的隐式原始值为 `2`，依此类推。

When strings are used for raw values, the implicit value for each case is the text of that case’s name.

当使用字符串作为原始值时，每个用例的隐式值为该用例的名称文本。

The enumeration below is a refinement of the earlier `CompassPoint` enumeration, with string raw values to represent each direction’s name:

以下枚举是对之前 `CompassPoint` 枚举的改进，使用字符串原始值表示每个方向的名称：

```
enum CompassPoint: String {
    case north, south, east, west
}
```

In the example above, `CompassPoint.south` has an implicit raw value of `"south"`, and so on.

在上述示例中，CompassPoint.south 的隐式原始值为 `"south"`，依此类推。

You access the raw value of an enumeration case with its `rawValue` property:

通过 `rawValue` 属性访问枚举 case 的原始值：

```
let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"
```

## 5.2 Initializing from a Raw Value 从原始值初始化

If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called `rawValue`) and returns either an enumeration case or `nil`. You can use this initializer to try to create a new instance of the enumeration.

如果定义具有原始值类型的枚举，枚举会自动获得一个初始化器。该初始化器接受原始值类型的值（参数名为 `rawValue`），并返回枚举用例或 `nil`。可使用此初始化器尝试创建枚举的新实例。

This example identifies Uranus from its raw value of `7`:

以下示例通过原始值 `7` 识别天王星：

```
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus
// possiblePlanet 类型为 Planet?，值为 Planet.uranus
```

Not all possible `Int` values will find a matching planet, however. Because of this, the raw value initializer always returns an optional enumeration case. In the example above, `possiblePlanet` is of type `Planet?`, or “optional `Planet`.”

然而，并非所有 `Int` 值都能匹配行星。因此，原始值初始化器始终返回可选枚举 case。在上述示例中，`possiblePlanet` 的类型为 `Planet?`，即 “可选 `Planet`”。

> **Note** **注意**
>
> The raw value initializer is a failable initializer, because not every raw value will return an enumeration case. For more information, see [Failable Initializers](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Failable-Initializers).
> 
> 原始值初始化器是可失败初始化器，因为并非每个原始值都会返回枚举用例。更多信息请参见《[可失败初始化器](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations#Failable-Initializers)》。

If you try to find a planet with a position of `11`, the optional `Planet` value returned by the raw value initializer will be `nil`:

如果尝试查找位置为 `11` 的行星，原始值初始化器返回的可选 `Planet` 值将为 `nil`：

```
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"
```

This example uses optional binding to try to access a planet with a raw value of `11`. The statement `if let somePlanet = Planet(rawValue: 11)` creates an optional `Planet`, and sets `somePlanet` to the value of that optional `Planet` if it can be retrieved. In this case, it isn’t possible to retrieve a planet with a position of `11`, and so the `else` branch is executed instead.

此示例使用可选绑定尝试访问原始值为 `11` 的行星。语句 `if let somePlanet = Planet(rawValue: 11)` 创建一个可选 `Planet`，若能检索到该值，则将 `somePlanet` 设置为该可选 `Planet` 的值。在此例中，无法检索位置为 `11` 的行星，因此执行 `else` 分支。

# 6 Recursive Enumerations 递归枚举

A _recursive enumeration_ is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing `indirect` before it, which tells the compiler to insert the necessary layer of indirection.

**递归枚举** 是指一个或多个枚举用例的关联值包含枚举自身实例的枚举。通过在枚举用例前编写 `indirect` 表明其为递归用例，这会告知编译器插入必要的间接层。

For example, here is an enumeration that stores simple arithmetic expressions:

例如，以下枚举存储简单的算术表达式：

```
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

You can also write `indirect` before the beginning of the enumeration to enable indirection for all of the enumeration’s cases that have an associated value:

也可在枚举开头编写 `indirect`，为所有包含关联值的枚举用例启用间接层：

```
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

This enumeration can store three kinds of arithmetic expressions: a plain number, the addition of two expressions, and the multiplication of two expressions. The `addition` and `multiplication` cases have associated values that are also arithmetic expressions — these associated values make it possible to nest expressions. For example, the expression `(5 + 4) * 2` has a number on the right-hand side of the multiplication and another expression on the left-hand side of the multiplication. Because the data is nested, the enumeration used to store the data also needs to support nesting — this means the enumeration needs to be recursive. The code below shows the `ArithmeticExpression` recursive enumeration being created for `(5 + 4) * 2`:

该枚举可存储三种算术表达式：纯数字、两个表达式的加法、两个表达式的乘法。`addition` 和 `multiplication` 用例的关联值也是算术表达式，这使得表达式可以嵌套。例如，表达式 `(5 + 4) * 2` 中，乘法右侧是数字，左侧是另一个表达式。由于数据是嵌套的，存储数据的枚举也需要支持嵌套 —— 这意味着枚举必须是递归的。以下代码展示了为 `(5 + 4) * 2` 创建的 `ArithmeticExpression` 递归枚举：

```
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
```

A recursive function is a straightforward way to work with data that has a recursive structure. For example, here’s a function that evaluates an arithmetic expression:

递归函数是处理递归结构数据的直观方式。例如，以下函数用于计算算术表达式的值：

```
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// Prints "18"
```

This function evaluates a plain number by simply returning the associated value. It evaluates an addition or multiplication by evaluating the expression on the left-hand side, evaluating the expression on the right-hand side, and then adding them or multiplying them.

该函数通过直接返回关联值来计算纯数字；计算加法或乘法时，先计算左侧表达式和右侧表达式的值，再进行加法或乘法运算。

> **Beta Software** **测试版**
>
> This documentation contains preliminary information about an API or technology in development. This information is subject to change, and software implemented according to this documentation should be tested with final operating system software.
> 
> 本文档包含有关开发中 API 或技术的初步信息。该信息可能会更改，根据本文档实现的软件应使用最终操作系统软件进行测试。
>
> Learn more about using [Apple’s beta software](https://developer.apple.com/support/beta-software/).
> 
> 了解更多关于使用《[Apple 测试版软件](https://developer.apple.com/support/beta-software/)》的信息。
