# Control Flow 控制流

> Structure code with branches, loops, and early exits.
> 
> 带有分支、循环和提前退出的结构代码。

原文地址：[https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow)

Swift provides a variety of control flow statements. These include `while` loops to perform a task multiple times; `if`, `guard`, and `switch` statements to execute different branches of code based on certain conditions; and statements such as `break` and `continue` to transfer the flow of execution to another point in your code. Swift provides a `for-in` loop that makes it easy to iterate over arrays, dictionaries, ranges, strings, and other sequences. Swift also provides `defer` statements, which wrap code to be executed when leaving the current scope.

Swift 提供了多种控制流语句。其中包括用于多次执行某项任务的 `while` 循环；用于根据特定条件执行不同代码分支的 `if`、`guard` 和 `switch` 语句；以及用于将程序执行流程转移到代码中其他位置的 `break`、`continue` 等语句。Swift 中的 `for-in` 循环能轻松遍历数组、字典、区间、字符串及其他序列。此外，Swift 还提供了 `defer` 语句，该语句可包裹一段代码，使其在离开当前作用域时执行。

Swift’s `switch` statement is considerably more powerful than its counterpart in many C-like languages. Cases can match many different patterns, including interval matches, tuples, and casts to a specific type. Matched values in a `switch` case can be bound to temporary constants or variables for use within the case’s body, and complex matching conditions can be expressed with a `where` clause for each case.

Swift 中的 `switch` 语句比许多类 C 语言中的同类语句功能强大得多。它的分支可以匹配多种不同的模式，包括区间匹配、元组匹配以及向特定类型的强制转换（类型强转匹配）。`switch` 分支中匹配到的值，可绑定为临时常量或变量，供该分支的代码块内部使用；并且每个分支都可以通过 `where` 子句来表达复杂的匹配条件。

## 1 For-In Loops - For-In 循环

You use the `for-in` loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string.

你可以使用 `for-in` 循环遍历一个序列，例如数组中的元素、数字区间或字符串中的字符。

This example uses a `for-in` loop to iterate over the items in an array:

以下示例使用 `for-in` 循环遍历数组中的元素：

```
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!
```

You can also iterate over a dictionary to access its key-value pairs. Each item in the dictionary is returned as a `(key, value)` tuple when the dictionary is iterated, and you can decompose the `(key, value)` tuple’s members as explicitly named constants for use within the body of the `for-in` loop. In the code example below, the dictionary’s keys are decomposed into a constant called `animalName`, and the dictionary’s values are decomposed into a constant called `legCount`.

你也可以使用 `for-in` 循环遍历字典，以访问其键值对。遍历字典时，每个元素会以 `(key, value)` 元组的形式返回；你可以将 `(key, value)` 元组的成员分解为指定名称的常量，供 `for-in` 循环的代码块内部使用。在下面的代码示例中，字典的键被分解为名为 `animalName` 的常量，字典的值被分解为名为 `legCount` 的常量：

```
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs 
// ants have 6 legs
// spiders have 8 legs
// 猫有4条腿
// 蚂蚁有6条腿
// 蜘蛛有8条腿
```

The contents of a `Dictionary` are inherently unordered, and iterating over them doesn’t guarantee the order in which they will be retrieved. In particular, the order you insert items into a Dictionary doesn’t define the order they’re iterated. For more about arrays and dictionaries, see [Collection Types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes).

字典的内容本质上是无序的，遍历字典无法保证获取元素的顺序。尤其是，你向字典中插入元素的顺序，并不决定遍历它们的顺序。关于数组和字典的更多内容，请参阅《[集合类型](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes)》。

You can also use `for-in` loops with numeric ranges. This example prints the first few entries in a five-times table:

你还可以使用 `for-in` 循环遍历数字区间。以下示例打印 “5 的乘法表” 的前几项：

```
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
// 1乘5等于5
// 2乘5等于10
// 3乘5等于15
// 4乘5等于20
// 5乘5等于25
```

The sequence being iterated over is a range of numbers from `1` to `5`, inclusive, as indicated by the use of the closed range operator (`...`). The value of `index` is set to the first number in the range (`1`), and the statements inside the loop are executed. In this case, the loop contains only one statement, which prints an entry from the five-times table for the current value of index. After the statement is executed, the value of index is updated to contain the second value in the range (`2`), and the `print(_:separator:terminator:)` function is called again. This process continues until the end of the range is reached.

这里遍历的序列是 “从 1 到 5 的闭区间”（包含 `1` 和 `5`），由闭区间运算符 `...` 标识。循环开始时，`index` 被赋值为区间的第一个数字（`1`），随后执行循环内部的语句。在这个例子中，循环仅包含一条语句，输出当前 `index` 对应的 5 的乘法表项。语句执行完成后，`index` 更新为区间的下一个数字（`2`），再次调用 `print(_:separator:terminator:)` 函数。这个过程会持续到遍历完区间的最后一个数字。

In the example above, `index` is a constant whose value is automatically set at the start of each iteration of the loop. As such, `index` doesn’t have to be declared before it’s used. It’s implicitly declared simply by its inclusion in the loop declaration, without the need for a `let` declaration keyword.

在上面的示例中，`index` 是一个常量，其值会在每次循环迭代开始时自动设置。因此，`index` 无需在使用前声明。它只需包含在循环声明中即可被隐式声明，不需要使用 `let` 声明关键字。

If you don’t need each value from a sequence, you can ignore the values by using an underscore in place of a variable name.

如果不需要序列中的每个值，可以用下划线代替变量名来忽略这些值。

```
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"
// 输出："3 的 10 次方是 59049"
```

The example above calculates the value of one number to the power of another (in this case, `3` to the power of `10`). It multiplies a starting value of `1` (that is, `3` to the power of `0`) by `3`, ten times, using a closed range that starts with `1` and ends with `10`. For this calculation, the individual counter values each time through the loop are unnecessary — the code simply executes the loop the correct number of times. The underscore character (`_`) used in place of a loop variable causes the individual values to be ignored and doesn’t provide access to the current value during each iteration of the loop.

上面的示例计算一个数的另一个数次幂（这里是 `3` 的 `10` 次方）。它使用从 `1` 到 `10` 的闭区间，将初始值 `1`（即 `3` 的 `0` 次方）乘以 `3`，共乘 `10` 次。对于这个计算，循环中每次的计数器具体值并不重要 —— 代码只需执行正确的循环次数即可。用下划线（`_`）代替循环变量会忽略各个具体值，且在每次循环迭代时无法访问当前值。

In some situations, you might not want to use closed ranges, which include both endpoints. Consider drawing the tick marks for every minute on a watch face. You want to draw 60 tick marks, starting with the 0 minute. Use the half-open range operator (`..<`) to include the lower bound but not the upper bound. For more about ranges, see [Range Operators](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Range-Operators).

在某些情况下，你可能不想使用包含两个端点的闭区间。例如，给表盘上的每分钟绘制刻度线时，需要绘制 60 个刻度，从 0 分钟开始。这时可以使用半开区间运算符（`..<`），它包含下界但不包含上界。有关区间的更多信息，请参见《[区间运算符](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/basicoperators#Range-Operators)》。

```
let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
    // 每分钟绘制一个刻度线（共 60 次）
}
```

Some users might want fewer tick marks in their UI. They could prefer one mark every `5` minutes instead. Use the `stride(from:to:by:)` function to skip the unwanted marks.

有些用户可能希望界面中的刻度线更少，比如每 `5` 分钟一个刻度。可以使用 `stride(from:to:by:)` 函数跳过不需要的刻度。

```
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    // 每 5 分钟绘制一个刻度线（0、5、10、15……45、50、55）
}
```

Closed ranges are also available, by using `stride(from:through:by:)` instead:

也可以使用 `stride(from:through:by:)` 来创建闭区间：

```
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
    // 每 3 小时绘制一个刻度线（3、6、9、12）
}
```

The examples above use a `for-in` loop to iterate ranges, arrays, dictionaries, and strings. However, you can use this syntax to iterate any collection, including your own classes and collection types, as long as those types conform to the [Sequence](https://developer.apple.com/documentation/swift/sequence) protocol.

上面的示例使用 `for-in` 循环来遍历区间、数组、字典和字符串。不过，只要遵循 [Sequence](https://developer.apple.com/documentation/swift/sequence) 协议，这种语法也可用于遍历任何集合，包括你自己定义的类和集合类型。

## 2 While Loops - While 循环

A `while` loop performs a set of statements until a condition becomes `false`. These kinds of loops are best used when the number of iterations isn’t known before the first iteration begins. Swift provides two kinds of `while` loops:

`while` 循环会执行一系列语句，直到条件变为 `false` 为止。这种类型的循环最适合在第一次迭代开始前未知迭代次数的场景。Swift 提供了两种 `while` 循环：

- `while` evaluates its condition at the start of each pass through the loop.
- `repeat-while` evaluates its condition at the end of each pass through the loop.

- `while` 在每次循环迭代开始时评估其条件。
- `repeat-while` 在每次循环迭代结束时评估其条件。

### 2.1 While

A `while` loop starts by evaluating a single condition. If the condition is `true`, a set of statements is repeated until the condition becomes `false`.

`while` 循环首先评估单个条件。如果条件为 `true`，则重复执行一系列语句，直到条件变为 `false`。

Here’s the general form of a `while` loop:

`while` 循环的一般形式如下：

```
while <#condition#> {
   <#statements#>
}
```

This example plays a simple game of Snakes and Ladders (also known as Chutes and Ladders):

下面的示例演示了一个简单的 “蛇梯棋”（也称为 “滑梯与梯子”）游戏：

![](./images/5-2-snakesAndLadders@2x.png)

The rules of the game are as follows:

- The board has 25 squares, and the aim is to land on or beyond square 25.
- The player’s starting square is “square zero”, which is just off the bottom-left corner of the board.
- Each turn, you roll a six-sided dice and move by that number of squares, following the horizontal path indicated by the dotted arrow above.
- If your turn ends at the bottom of a ladder, you move up that ladder.
- If your turn ends at the head of a snake, you move down that snake.

游戏规则如下：

- 棋盘有 25 个方格，目标是落在第 25 个方格上或超过它。
- 玩家的起始位置是 “第 0 格”，位于棋盘左下角外侧。
- 每一轮，玩家掷一个六面骰子，并按照上方虚线箭头指示的水平路径移动相应的方格数。
- 如果回合结束时落在梯子底部，则沿梯子上移。
- 如果回合结束时落在蛇头，则沿蛇下移。

The game board is represented by an array of `Int` values. Its size is based on a constant called `finalSquare`, which is used to initialize the array and also to check for a win condition later in the example. Because the players start off the board, on “square zero”, the board is initialized with 26 zero Int values, not 25.

棋盘由一个 `Int` 类型的数组表示。其大小取决于一个名为 `finalSquare` 的常量，该常量用于初始化数组，稍后也用于检查获胜条件。由于玩家从棋盘外的 “第 0 格” 开始，因此数组初始化时包含 26 个 0（而非 25 个）。

```
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
```

Some squares are then set to have more specific values for the snakes and ladders. Squares with a ladder base have a positive number to move you up the board, whereas squares with a snake head have a negative number to move you back down the board.

然后为一些方格设置特定值以表示蛇和梯子。梯子底部所在的方格用正数表示上移的方格数，而蛇头所在的方格用负数表示下移的方格数。

```
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
```

Square 3 contains the bottom of a ladder that moves you up to square 11. To represent this, `board[03]` is equal to `+08`, which is equivalent to an integer value of `8` (the difference between `3` and `11`). To align the values and statements, the unary plus operator (`+i`) is explicitly used with the unary minus operator (`-i`) and numbers lower than `10` are padded with zeros. (Neither stylistic technique is strictly necessary, but they lead to neater code.)

第 3 格是一个梯子的底部，可将玩家移至第 11 格。为表示这一点，`board[03]` 被设为 `+08`，相当于整数 `8`（即 `3` 到 `11` 的差值）。为了使数值和语句对齐，对正数显式使用了一元加号运算符（`+i`），与一元减号运算符（`-i`）对应，且小于 `10` 的数字前补了 `0`。（这两种风格技巧并非必需，但能让代码更整洁。）

```
var square = 0
var diceRoll = 0
while square < finalSquare {
    // roll the dice
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    // 按掷出的点数移动
    square += diceRoll
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        // 如果仍在棋盘上，根据蛇或梯子上下移动
        square += board[square]
    }
}
print("Game over!")
```

The example above uses a very simple approach to dice rolling. Instead of generating a random number, it starts with a `diceRoll` value of `0`. Each time through the `while` loop, diceRoll is incremented by one and is then checked to see whether it has become too large. Whenever this return value equals `7`, the dice roll has become too large and is reset to a value of `1`. The result is a sequence of `diceRoll` values that’s always `1`, `2`, `3`, `4`, `5`, `6`, `1`, `2` and so on.

上面的示例使用了一种非常简单的掷骰子方式。它没有生成随机数，而是从 `diceRoll` 为 `0` 开始。每次进入 `while` 循环时，`diceRoll` 加 `1`，然后检查是否过大。当 `diceRoll` 等于 `7` 时，说明掷出的点数过大，重置为 `1`。结果是 `diceRoll` 的值序列始终为 `1`、`2`、`3`、`4`、`5`、`6`、`1`、`2`，依此类推。

After rolling the dice, the player moves forward by `diceRoll` squares. It’s possible that the dice roll may have moved the player beyond square 25, in which case the game is over. To cope with this scenario, the code checks that `square` is less than the `board` array’s `count` property. If `square` is valid, the value stored in `board[square]` is added to the current square value to move the player up or down any ladders or snakes.

掷完骰子后，玩家向前移动 `diceRoll` 个方格。有可能骰子的点数使玩家超过了第 25 格，这种情况下游戏结束。为应对这种情况，代码会检查 `square` 是否小于 `board` 数组的 `count` 属性。如果 `square` 有效，则将 `board[square]` 中存储的值加到当前 `square` 上，使玩家沿梯子上移或沿蛇下移。

> **Note**
>
> If this check isn’t performed, `board[square]` might try to access a value outside the bounds of the `board` array, which would trigger a runtime error.
> 
> 注意：如果不执行此检查，`board[square]` 可能会尝试访问 `board` 数组边界外的值，从而触发运行时错误。

The current `while` loop execution then ends, and the loop’s condition is checked to see if the loop should be executed again. If the player has moved on or beyond square number `25`, the loop’s condition evaluates to `false` and the game ends.

随后当前 `while` 循环执行结束，并检查循环条件以确定是否应再次执行循环。如果玩家已移动到第 25 格或超过它，循环条件的评估结果为 `false`，游戏结束。

A `while` loop is appropriate in this case, because the length of the game isn’t clear at the start of the `while` loop. Instead, the loop is executed until a particular condition is satisfied.

在这种情况下使用 `while` 循环是合适的，因为游戏的时长在 `while` 循环开始时并不明确。相反，循环会一直执行，直到满足特定条件。

### 2.2 Repeat-While

The other variation of the `while` loop, known as the `repeat-while` loop, performs a single pass through the loop block first, before considering the loop’s condition. It then continues to repeat the loop until the condition is `false`.

`while` 循环的另一种变体是 `repeat-while` 循环，它先执行一次循环块，然后再考虑循环条件。之后继续重复循环，直到条件为 `false`。

> **Note**
>
> The `repeat-while` loop in Swift is analogous to a `do-while` loop in other languages.
> 
> 注意：Swift 中的 `repeat-while` 循环类似于其他语言中的 `do-while` 循环。

Here’s the general form of a `repeat-while` loop:

`repeat-while` 循环的一般形式如下：

```
repeat {
   <#statements#>
} while <#condition#>
```

Here’s the Snakes and Ladders example again, written as a `repeat-while` loop rather than a `while` loop. The values of `finalSquare`, `board`, `square`, and `diceRoll` are initialized in exactly the same way as with a `while` loop.

下面再次给出 “蛇梯棋” 示例，这次使用 `repeat-while` 循环而非 `while` 循环。`finalSquare`、`board`、`square` 和 `diceRoll` 的初始化方式与 `while` 循环版本完全相同。

```
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

In this version of the game, the first action in the loop is to check for a ladder or a snake. No ladder on the board takes the player straight to square 25, and so it isn’t possible to win the game by moving up a ladder. Therefore, it’s safe to check for a snake or a ladder as the first action in the loop.

在这个版本的游戏中，循环中的第一个操作是检查梯子或蛇。棋盘上没有能让玩家直接到达第 25 格的梯子，因此不可能通过上移梯子获胜。因此，在循环中首先检查蛇或梯子是安全的。

At the start of the game, the player is on “square zero”. `board[0]` always equals `0` and has no effect.

游戏开始时，玩家在 “第 0 格”。`board[0]` 始终为 `0`，没有任何影响。

```
repeat {
    // move up or down for a snake or ladder
    // 根据蛇或梯子上下移动
    square += board[square]
    // roll the dice
    // 掷骰子
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    // 按掷出的点数移动
    square += diceRoll
} while square < finalSquare
print("Game over!")
```

After the code checks for snakes and ladders, the dice is rolled and the player is moved forward by `diceRoll` squares. The current loop execution then ends.

代码检查完蛇和梯子后，掷骰子并让玩家向前移动 `diceRoll` 个方格。随后当前循环执行结束。

The loop’s condition (`while square < finalSquare`) is the same as before, but this time it’s not evaluated until the end of the first run through the loop. The structure of the `repeat-while` loop is better suited to this game than the `while` loop in the previous example. In the `repeat-while` loop above, `square += board[square]` is always executed _immediately_ after the loop’s while condition confirms that `square` is still on the board. This behavior removes the need for the array bounds check seen in the `while` loop version of the game described earlier.

循环条件（`while square <finalSquare`）与之前相同，但这次直到第一次循环执行完毕后才会评估。`repeat-while` 循环的结构比前例中的 `while` 循环更适合这个游戏。在上面的 `repeat-while` 循环中，`square += board[square]` 总是在循环的 `while` 条件确认 `square` 仍在棋盘上之后 _立即_ 执行。这种行为消除了前文中 `while` 循环版本中对数组边界检查的需求。



