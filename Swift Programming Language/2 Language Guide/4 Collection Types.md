# Collection Types 集合类型

> Organize data using arrays, sets, and dictionaries.
> 
> 使用数组、集合和字典管理数据。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes/](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes/)

Swift provides three primary _collection types_, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.

Swift 提供了三种主要的 **集合类型** 用于存储值的集合，分别称为数组、集合和字典。**数组**是有序的值集合。 **集合**是无序的唯一值集合。**字典**是无序的键值对关联集合。  

![](images/4-1-CollectionTypes_intro@2x.png)

Arrays, sets, and dictionaries in Swift are always clear about the types of values and keys that they can store. This means that you can’t insert a value of the wrong type into a collection by mistake. It also means you can be confident about the type of values you will retrieve from a collection.

在 Swift 中，数组、集合和字典始终明确其可存储的值和键的类型。这意味着您不会误将错误类型的值插入集合中，也意味着您可以确信从集合中检索到的值的类型。  

> **Note**
>
> Swift’s array, set, and dictionary types are implemented as _generic collections_. For more about generic types and collections, see [Generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics).
> 
> **注意**  
> Swift 的数组、集合和字典类型是作为 **泛型集合** 实现的。有关泛型类型和集合的更多信息，请参阅《[泛型](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics)》。

## 1 Mutability of Collections 集合的可变性

If you create an array, a set, or a dictionary, and assign it to a variable, the collection that’s created will be mutable. This means that you can change (or mutate) the collection after it’s created by adding, removing, or changing items in the collection. If you assign an array, a set, or a dictionary to a constant, that collection is immutable, and its size and contents can’t be changed.

如果创建一个数组、集合或字典并将其赋值给变量，那么创建的集合是可变的。这意味着可以在创建集合后通过添加、删除或更改集合中的元素来修改（或改变）该集合。如果将数组、集合或字典赋值给常量，则该集合是不可变的，其大小和内容均无法更改。

> **Note**
>
> It’s good practice to create immutable collections in all cases where the collection doesn’t need to change. Doing so makes it easier for you to reason about your code and enables the Swift compiler to optimize the performance of the collections you create.
> 
> **注意**
> 
> 在集合无需更改的所有情况下，创建不可变集合是一种良好实践。这样做不仅有助于更轻松地理解代码逻辑，还能让 Swift 编译器优化所创建集合的性能。

## 2 Arrays 数组

An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.

数组在有序列表中存储相同类型的值。同一个值可以在数组的不同位置多次出现。

> **Note**
>
> Swift’s Array type is bridged to Foundation’s NSArray class.
>
> For more information about using Array with Foundation and Cocoa, see [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730).
> 
> **注意**
> 
> Swift 的 Array 类型与 Foundation 框架的 NSArray 类相互桥接。
>
> 有关结合 Foundation 和 Cocoa 使用 Array 的更多信息，请参阅 “Array 与 NSArray 之间的桥接”。

### 2.1 Array Type Shorthand Syntax 数组类型的简写语法

The type of a Swift array is written in full as `Array<Element>`, where `Element` is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as `[Element]`. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of an array.

Swift 数组的完整类型写法是 `Array<Element>`，其中 `Element` 是数组允许存储的值的类型。你也可以将数组类型简写为 `[Element]`。尽管这两种形式在功能上完全相同，但简写形式更受青睐，并且在本指南中提及数组类型时都会使用这种形式。

### 2.2 Creating an Empty Array 创建空数组 

You can create an empty array in Swift using two approaches. If the context already provides type information, such as a function argument or an already typed variable or constant, you can use an empty array literal, which is written as `[]` (an empty pair of square brackets):

在 Swift 中，有两种创建空数组的方法。如果上下文已提供类型信息（例如函数参数、已声明类型的变量或常量），可以使用空数组字面量，其写法为 `[]`（一对空方括号）：  

```
var someInts: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items.")
// Prints "someInts is of type [Int] with 0 items."
// 输出："someInts 是 [Int] 类型，包含 0 个元素。"
```

Alternatively, you can create an empty array of a certain type using explicit initializer syntax, by writing the element type in square brackets followed by parentheses — for example, `[Int]()` in the following:

另外，也可以使用显式初始化语法创建特定类型的空数组，即在方括号中写入元素类型后接圆括号——例如以下代码中的 `[Int]()`： 

```
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
// Prints "someInts is of type [Int] with 0 items."
// 输出："someInts 是 [Int] 类型，包含 0 个元素。"
```

Both approaches produce the same result. However, an empty array literal is shorter and usually easier to read.

这两种方法的结果相同。不过，空数组字面量更简洁，通常也更易读。  

In both cases, you can use the empty array literal (`[]`) to reassign an empty array to an existing variable:

在上述两种情况下，都可以使用空数组字面量 `[]` 向现有变量重新赋值一个空数组：  

```
someInts.append(3)
// someInts now contains 1 value of type Int
// someInts 现在包含 1 个 Int 类型的值
someInts = []
// someInts is now an empty array, but is still of type [Int]
// someInts 现在是一个空数组，但仍然是 [Int] 类型
```

### 2.3 Creating an Array with a Default Value 使用默认值创建数组

Swift’s Array type also provides an initializer for creating an array of a certain size with all of its values set to the same default value. You pass this initializer a default value of the appropriate type (called `repeating`): and the number of times that value is repeated in the new array (called `count`):

Swift 的 Array 类型还提供了一个初始化器，用于创建指定大小且所有值都设置为相同默认值的数组。你需要向这个初始化器传递一个适当类型的默认值（称为 `repeating`）和该值在新数组中重复的次数（称为 `count`）：

```
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
// threeDoubles 的类型为 [Double]，值为 [0.0, 0.0, 0.0]
```

### 2.4 Creating an Array by Adding Two Arrays Together 通过相加两个数组创建新数组

You can create a new array by adding together two existing arrays with compatible types with the addition operator (`+`). The new array’s type is inferred from the type of the two arrays you add together:

你可以使用加法运算符（`+`）将两个类型兼容的现有数组合并，从而创建一个新数组。新数组的类型会从相加的两个数组的类型中推断出来：

```
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
// anotherThreeDoubles 的类型为 [Double]，值为 [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
// sixDoubles 推断为 [Double] 类型，值为 [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```

### 2.5 Creating an Array with an Array Literal 使用数组字面量创建数组

You can also initialize an array with an array literal, which is a shorthand way to write one or more values as an array collection. An array literal is written as a list of values, separated by commas, surrounded by a pair of square brackets:

你还可以使用数组字面量初始化数组，这是一种将一个或多个值编写为数组集合的简写方式。数组字面量写作由逗号分隔的值列表，并用一对方括号括起来：

```
[<#value 1#>, <#value 2#>, <#value 3#>]
```

The example below creates an array called `shoppingList` to store `String` values:

下面的示例创建了一个名为 `shoppingList` 的数组，用于存储 `String` 值：

```
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList has been initialized with two initial items
// shoppingList 已使用两个初始项初始化
```

The `shoppingList` variable is declared as “an array of string values”, written as `[String]`. Because this particular array has specified a value type of `String`, it’s allowed to store `String` values only. Here, the `shoppingList` array is initialized with two `String` values (`"Eggs"` and `"Milk"`), written within an array literal.

`shoppingList` 变量被声明为 “字符串值的数组”，写作 `[String]`。由于这个特定数组指定了值的类型是 `String`，因此它只能存储 `String` 值。在这里，`shoppingList` 数组使用两个 `String` 值（`"Eggs"` 和 `"Milk"`）进行初始化，这些值写在数组字面量中。

> **Note** **注意**
>
> The `shoppingList` array is declared as a variable (with the `var` introducer) and not a constant (with the `let` introducer) because more items are added to the shopping list in the examples below.
> 
> `shoppingList` 数组被声明为变量（使用 `var` 关键字）而非常量（使用 `let` 关键字），因为在下面的示例中会向购物清单中添加更多项目。

In this case, the array literal contains two `String` values and nothing else. This matches the type of the `shoppingList` variable’s declaration (an array that can only contain `String` values), and so the assignment of the array literal is permitted as a way to initialize `shoppingList` with two initial items.

在这种情况下，数组字面量只包含两个 `String` 值，没有其他内容。这与 `shoppingList` 变量声明的类型（只能包含 `String` 值的数组）匹配，因此允许将数组字面量赋值作为用两个初始项初始化 `shoppingList` 的方式。

Thanks to Swift’s type inference, you don’t have to write the type of the array if you’re initializing it with an array literal containing values of the same type. The initialization of shoppingList could have been written in a shorter form instead:

得益于 Swift 的类型推断，如果使用包含相同类型值的数组字面量初始化数组，则不必编写数组的类型。`shoppingList` 的初始化可以用更简短的形式编写：

```
var shoppingList = ["Eggs", "Milk"]
```

Because all values in the array literal are of the same type, Swift can infer that `[String]` is the correct type to use for the `shoppingList` variable.

因为数组字面量中的所有值都属于同一类型，Swift 可以推断 `[String]` 是 `shoppingList` 变量应使用的正确类型。

### 2.6 Accessing and Modifying an Array 访问和修改数组

You access and modify an array through its methods and properties, or by using subscript syntax.

你可以通过数组的方法和属性，或使用下标语法来访问和修改数组。

To find out the number of items in an array, check its read-only `count` property:

要查看数组中的项目数量，请检查其只读属性 `count`：

```
print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."
// 输出 "The shopping list contains 2 items."
```

Use the Boolean `isEmpty` property as a shortcut for checking whether the `count` property is equal to `0`:

使用布尔值属性 `isEmpty` 作为检查 `count` 属性是否等于 `0` 的快捷方式：

```
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}
// Prints "The shopping list isn't empty."
// 输出 "The shopping list isn't empty."
```

You can add a new item to the end of an array by calling the array’s `append(_:)` method:

你可以通过调用数组的 `append(_:)` 方法将新项添加到数组末尾：

```
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes
// shoppingList 现在包含3个项目，有人要做煎饼啦（作者幽默的解释为何购物清单里多了“面粉”这个物品，加入面粉是因为要做煎饼，与代码逻辑无关）
```

Alternatively, append an array of one or more compatible items with the addition assignment operator (`+=`):

或者，使用加法赋值运算符（`+=`）追加一个或多个兼容类型的项目组成的数组：

```
shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
// shoppingList 现在包含4个项目
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items
// shoppingList 现在包含7个项目
```

Retrieve a value from the array by using _subscript syntax_, passing the index of the value you want to retrieve within square brackets immediately after the name of the array:

通过**下标语法**从数组中检索值，在数组名称后立即使用方括号传递要检索的值的索引：

```
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"
// firstItem 等于 "Eggs"
```

> **Note** **注意**
>
> The first item in the array has an index of `0`, not `1`. Arrays in Swift are always zero-indexed.
> 
> 数组中的第一个项目索引为 `0`，而不是 `1`。在 Swift 中，数组始终使用零索引。

You can use subscript syntax to change an existing value at a given index:

你可以使用下标语法更改给定索引处的现有值：

```
shoppingList[0] = "Six eggs"
// the first item in the list is now equal to "Six eggs" rather than "Eggs"
// 列表中的第一个项目现在等于 "Six eggs" 而不是 "Eggs"
```

When you use subscript syntax, the index you specify needs to be valid. For example, writing `shoppingList[shoppingList.count] = "Salt"` to try to append an item to the end of the array results in a runtime error.

使用下标语法时，指定的索引需要有效。例如，采用 `shoppingList [shoppingList.count] = "Salt"` 的写法尝试向数组末尾追加项目会导致运行时错误。

You can also use subscript syntax to change a range of values at once, even if the replacement set of values has a different length than the range you are replacing. The following example replaces `"Chocolate Spread"`, `"Cheese"`, and `"Butter"` with `"Bananas"` and `"Apples"`:

你还可以使用下标语法一次更改一系列值，即使替换的一组值的长度与要替换的范围不同。以下示例将 `"Chocolate Spread"`、`"Cheese"` 和 `"Butter"` 替换为 `"Bananas"` 和 `"Apples"`：

```
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList now contains 6 items
// shoppingList 现在包含6个项目
```

To insert an item into the array at a specified index, call the array’s `insert(_:at:)` method:

要在数组的指定索引处插入项目，请调用数组的 `insert(_:at:)` 方法：

```
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list
// shoppingList 现在包含7个项目
// "Maple Syrup" 现在是列表中的第一个项目
```

This call to the `insert(_:at:)` method inserts a new item with a value of `"Maple Syrup"` at the very beginning of the shopping list, indicated by an index of `0`.

此处调用 `insert(_:at:)` 方法在购物清单的最开头（索引 `0` 处）插入一个值为 `"Maple Syrup"` 的新项。

Similarly, you remove an item from the array with the `remove(at:)` method. This method removes the item at the specified index and returns the removed item (although you can ignore the returned value if you don’t need it):

同样，使用 `remove(at:)` 方法从数组中移除项目。此方法会移除指定索引处的项目并返回被移除的项目（如果不需要，可忽略返回值）：

```
let mapleSyrup = shoppingList.remove(at: 0)
// the item that was at index 0 has just been removed
// shoppingList now contains 6 items, and no Maple Syrup
// the mapleSyrup constant is now equal to the removed "Maple Syrup" string
// 索引0处的项目已被移除
// shoppingList 现在包含6个项目，且没有Maple Syrup
// mapleSyrup 常量现在等于被移除的 "Maple Syrup" 字符串
```

> **Note** **注意**
>
> If you try to access or modify a value for an index that’s outside of an array’s existing bounds, you will trigger a runtime error. You can check that an index is valid before using it by comparing it to the array’s `count` property. The largest valid index in an array is `count - 1` because arrays are indexed from zero — however, when `count` is `0` (meaning the array is empty), there are no valid indexes.
> 
> 如果尝试访问或修改数组现有边界之外的索引处的值，将触发运行时错误。你可以通过将索引与数组的 `count` 属性进行比较来检查索引是否有效。数组中最大的有效索引是 `count - 1`，因为数组从 0 开始索引；但是，当 `count` 为 `0` 时（意味着数组为空），没有有效索引。

Any gaps in an array are closed when an item is removed, and so the value at index `0` is once again equal to "Six eggs":

移除项目后，数组中的任何空位都会被闭合，因此索引 `0` 处的值会再次等于 `"Six eggs"`：

```
firstItem = shoppingList[0]
// firstItem is now equal to "Six eggs"
// firstItem 现在等于 "Six eggs"
```

If you want to remove the final item from an array, use the `removeLast()` method rather than the `remove(at:)` method to avoid the need to query the array’s `count` property. Like the `remove(at:)` method, `removeLast()` returns the removed item:

如果要从数组中移除最后一个项目，可以使用 `removeLast()` 方法，而不是 `remove(at:)` 方法，以避免查询数组的 `count` 属性。与 `remove(at:)` 方法一样，`removeLast()` 会返回被移除的项目：

```
let apples = shoppingList.removeLast()
// the last item in the array has just been removed
// shoppingList now contains 5 items, and no apples
// the apples constant is now equal to the removed "Apples" string
// 数组中的最后一个项目已被移除
// shoppingList 现在包含5个项目，且没有apples
// apples 常量现在等于被移除的 "Apples" 字符串
```

### 2.7 Iterating Over an Array 遍历数组

You can iterate over the entire set of values in an array with the `for-in` loop:

你可以使用 `for-in` 循环遍历数组中的所有值：

```
for item in shoppingList {
    print(item)
}
// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas
```

If you need the integer index of each item as well as its value, use the `enumerated()` method to iterate over the array instead. For each item in the array, the `enumerated()` method returns a tuple composed of an integer and the item. The integers start at zero and count up by one for each item; if you enumerate over a whole array, these integers match the items’ indices. You can decompose the tuple into temporary constants or variables as part of the iteration:

如果需要每个项目的整数索引及其值，可以改用 `enumerated()` 方法遍历数组。对于数组中的每个项目，`enumerated()` 方法会返回一个由整数和项目组成的元组。整数从 0 开始，每个项目递增 1；如果遍历整个数组，这些整数与项目的索引匹配。你可以在迭代过程中将元组分解为临时常量或变量：

```
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas
```

For more about the `for-in` loop, see [For-In](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#For-In-Loops) Loops.

有关 `for-in` 循环的更多信息，请参阅《[For-In 循环](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow#For-In-Loops)》。

## 3 Set 集合

A _set_ stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.

**集合**是一种存储相同类型不同值的集合，其中的值没有定义顺序。当元素的顺序不重要，或者你需要确保一个元素只出现一次时，可以使用集合而不是数组。

> **Note** **注意**
>
> Swift’s `Set` type is bridged to Foundation’s `NSSet` class.
> 
> Swift 的 `Set` 类型与 Foundation 的 `NSSet` 类相关联。
>
> For more information about using Set with Foundation and Cocoa, see [Bridging Between Set and NSSet](https://developer.apple.com/documentation/swift/set#2845530).
> 
> 有关将 Set 与 Foundation 和 Cocoa 配合使用的更多信息，请参阅《[Set 与 NSSet 之间的桥接](https://developer.apple.com/documentation/swift/set#2845530)》。


### 3.1 Hash Values for Set Types 集合类型的哈希值

A type must be hashable in order to be stored in a set — that is, the type must provide a way to compute a hash value for itself. A hash value is an `Int` value that’s the same for all objects that compare equally, such that if `a == b`, the hash value of `a` is equal to the hash value of `b`.

要存储在集合中，类型必须是可哈希的 —— 也就是说，该类型必须能为自身计算出一个哈希值。哈希值是一个 `Int` 值 —— 对于所有比较结果相等的对象，它们的哈希值都相同 —— 如果 `a == b`，那么 `a` 的哈希值等于 `b` 的哈希值。

All of Swift’s basic types (such as String, Int, Double, and Bool) are hashable by default, and can be used as set value types or dictionary key types. Enumeration case values without associated values (as described in Enumerations) are also hashable by default.

Note

You can use your own custom types as set value types or dictionary key types by making them conform to the Hashable protocol from the Swift standard library. For information about implementing the required hash(into:) method, see Hashable. For information about conforming to protocols, see Protocols.

