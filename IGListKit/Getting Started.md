# Getting Started

原文地址：[https://instagram.github.io/IGListKit/getting-started.html](https://instagram.github.io/IGListKit/getting-started.html)

This guide provides a brief overview for how to get started using `IGListKit`.

这个指南提供了如何开始使用 `IGListKit` 的简要概述。

## Creating your first list - 创建第一个列表

After installing IGListKit, creating a new list is easy.

在安装了 IGListKit，创建一个新列表是非常容易的。

### Creating a section controller - 创建一个section controller

Creating a new section controller is simple. Subclass [IGListSectionController](https://instagram.github.io/IGListKit/Classes/IGListSectionController.html) and override at least `cellForItemAtIndex:` and `sizeForItemAtIndex:`.

创建一个新的 section controller 很简单。只需继承 [IGListSectionController](https://instagram.github.io/IGListKit/Classes/IGListSectionController.html) 并至少重写 `cellForItemAtIndex:` 和 `sizeForItemAtIndex:` 方法。

Take a look at `LabelSectionController` for an example section controller that handles a String and configures a single cell with a `UILabel`.

请参考 `LabelSectionController`，这是一个示例 section controller，用于处理字符串并配置单个带有 `UILabel` 的单元格。

```
class LabelSectionController: ListSectionController {
  override func sizeForItem(at index: Int) -> CGSize {
    return CGSize(width: collectionContext!.containerSize.width, height: 55)
  }

  override func cellForItem(at index: Int) -> UICollectionViewCell {
    return collectionContext!.dequeueReusableCell(of: MyCell.self, for: self, at: index)
  }
}
```

### Creating the UI - 创建 UI

After creating at least one section controller, you must create a `UICollectionView` and [IGListAdapter](https://instagram.github.io/IGListKit/Classes/IGListAdapter.html).

在创建至少一个 section controller 后，您必须创建一个 `UICollectionView` 和 [IGListAdapter](https://instagram.github.io/IGListKit/Classes/IGListAdapter.html)。

```
let layout = UICollectionViewFlowLayout()
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

let updater = ListAdapterUpdater()
let adapter = ListAdapter(updater: updater, viewController: self)
adapter.collectionView = collectionView
```

> **Note:** This example is done within a `UIViewController` and uses both a stock `UICollectionViewFlowLayout` and [IGListAdapterUpdater](https://instagram.github.io/IGListKit/Classes/IGListAdapterUpdater.html). You can use your own layout and updater if you need advanced features!
> 
> **注意：**此示例在一个 `UIViewController` 中完成，并使用了标准的 `UICollectionViewFlowLayout` 和 [IGListAdapterUpdater](https://instagram.github.io/IGListKit/Classes/IGListAdapterUpdater.html)。如果需要高级功能，您可以使用自定义的布局和更新器！

### Connecting the data source - 连接数据源

The last step is the [IGListAdapter](https://instagram.github.io/IGListKit/Classes/IGListAdapter.html)'s data source and returning some data.

最后一步是设置 [IGListAdapter](https://instagram.github.io/IGListKit/Classes/IGListAdapter.html) 的数据源并返回一些数据。

```
func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
  // this can be anything!
  return [ "Foo", "Bar", 42, "Biz" ]
}

func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
  if object is String {
    return LabelSectionController()
  } else {
    return NumberSectionController()
  }
}

func emptyView(for listAdapter: ListAdapter) -> UIView? {
  return nil
}
```

After you have created the data source you need to connect it to the [IGListAdapter](https://instagram.github.io/IGListKit/Classes/IGListAdapter.html) by setting its `dataSource` property:

在创建数据源之后，您需要通过设置其 `dataSource` 属性将其连接到 [IGListAdapter](https://instagram.github.io/IGListKit/Classes/IGListAdapter.html)：

```
adapter.dataSource = self
```

You can return an array of any type of data, as long as it conforms to [IGListDiffable](https://instagram.github.io/IGListKit/Protocols/IGListDiffable.html).

您可以返回任何类型的数据数组，只要它符合 [IGListDiffable](https://instagram.github.io/IGListKit/Protocols/IGListDiffable.html) 协议即可。

### Immutability - 不可变性

The data should be immutable. If you return mutable objects that you will be editing later, `IGListKit` will not be able to diff the models accurately. This is because the instances have already been changed. Thus, the updates to the objects would be lost. Instead, always return a newly instantiated, immutable object and implement IGListDiffable.

数据应该是不可变的。如果返回可变对象，而您稍后将对其进行编辑，`IGListKit` 将无法准确地对模型进行差异比较。这是因为实例已经发生了更改。因此，对对象的更新将会丢失。相反，请始终返回一个新实例化的不可变对象，并实现 [IGListDiffable](https://instagram.github.io/IGListKit/Protocols/IGListDiffable.html) 接口。

## Diffing - 比对

`IGListKit` uses an algorithm adapted from a paper titled [A technique for isolating differences between files](http://dl.acm.org/citation.cfm?id=359467&dl=ACM&coll=DL) by Paul Heckel. This algorithm uses a technique known as the longest common subsequence to find a minimal diff between collections in linear time O(n). It finds all inserts, deletes, updates, and moves between arrays of data.

`IGListKit` 使用一种改编自 Paul Heckel 的论文《[A technique for isolating differences between files](http://dl.acm.org/citation.cfm?id=359467&dl=ACM&coll=DL)》的算法。该算法使用一种称为最长公共子序列的技术，在线性时间复杂度 O(n) 下找到集合之间的最小差异。它可以找到数据数组之间的所有插入、删除、更新和移动操作。

To add custom, diffable models, you need to conform to the [IGListDiffable](https://instagram.github.io/IGListKit/Protocols/IGListDiffable.html) protocol and implement `diffIdentifier()` and `isEqual(toDiffableObject:)`.

要添加自定义的可比对模型，您需要遵循 [IGListDiffable](https://instagram.github.io/IGListKit/Protocols/IGListDiffable.html) 协议并实现 `diffIdentifier()` 和 `isEqual(toDiffableObject:)` 方法。

> **Note:** an object’s `diffIdentifier()` should never change. If an object mutates it’s `diffIdentifer()` the behavior of `IGListKit` is undefined (and almost assuredly undesirable).
> 
> **注意：**对象的 `diffIdentifier()` 不应更改。如果对象改变了其 `diffIdentifier()`，`IGListKit` 的行为将是未定义的（几乎肯定是不希望的）。

For an example, consider the following model:

举个例子，假设有以下模型：

```
class User {
  let primaryKey: Int
  let name: String
  // implementation, etc
}
```

The user’s `primaryKey` uniquely identifies user data, and the `name` is just the value for that user.

用户的 `primaryKey` 唯一标识了用户数据，而 `name` 只是改用户的值。

Let’s say a server returns a `User` object that looks like this:

假设服务器返回一个看起来像这样的 `User` 对象：

```
let shayne = User(primaryKey: 2, name: "Shayne")
```

But sometime after the client receives shayne, someone changes their name:

但在客户端接收到 `shayne` 之后的某个时候，有人更改了他们的名字：

```
let ann = User(primaryKey: 2, name: "Ann")
```

Both `shayne` and `ann` represent the same _unique_ data because they share the same `primaryKey`, but they are not _equal_ because their names are different.

`shayne` 和 `ann` 代表相同的_唯一_数据，因为它们共享相同的 `primaryKey`，但它们并_不相等_，因为它们的名字不同。

To represent this in `IGListKit`’s diffing, add and implement the `IGListDiffable` protocol:

为了在 `IGListKit` 的比对中表示这一点，添加并实现 `IGListDiffable` 协议：

```
extension User: ListDiffable {
  func diffIdentifier() -> NSObjectProtocol {
    return primaryKey
  }

  func isEqual(toDiffableObject object: Any?) -> Bool {
    if let object = object as? User {
      return name == object.name
    }
    return false
  }
}
```

The algorithm will skip updating two `User` objects that have the same `primaryKey` and `name`, even if they are different instances! You now avoid unnecessary UI updates in the collection view even when providing new instances.

即使它们是不同的实例，算法也会跳过更新具有相同 `primaryKey` 和 `name` 的两个 `User` 对象！现在，即使提供新实例，您也可以避免集合视图中不必要的 UI 更新。

> **Note:** Remember that `isEqual(toDiffableObject:)` should return `false` when you want to reload the cells in the corresponding section controller.
> 
> **注意：**请记住，当您希望重新加载相应 section controller 中的单元格时，`isEqual(toDiffableObject:)` 应该返回 `false`。

### Diffing outside of IGListKit - 在 IGListKit 之外进行比对

If you want to use the diffing algorithm outside of `IGListAdapter` and `UICollectionView`, you can! The diffing algorithm was built with the flexibility to be used with any models that conform to `IGListDiffable`.

如果您想在 `IGListAdapter` 和 `UICollectionView` 之外使用比对算法，您也可以做到！比对算法具有灵活性，可以与符合 `IGListDiffable` 的任何模型一起使用。

```
let result = ListDiff(oldArray: oldUsers, newArray: newUsers, .equality)
```

With this you have all of the deletes, reloads, moves, and inserts! There’s even a function to generate `NSIndexPath` results.

通过这个方法，您可以得到所有的删除、重新加载、移动和插入操作！甚至有一个函数可以生成 `NSIndexPath` 结果。

## Advanced Features - 高级功能

### Working Range - 工作范围

A working range is a range of section controllers who aren’t yet visible, but are near the screen. Section controllers are notified of their entrance and exit to this range. This concept lets your section controllers prepare content before they come on screen (e.g. download images).

工作范围是一组尚未显示但接近屏幕的 section controller 范围。Section controller 会在它们进入和退出这个范围时收到通知。这个概念允许您的 section controller 在它们出现在屏幕上之前准备内容（例如下载图片）。

The `IGListAdapter` must be initialized with a range value in order to work. This value is a multiple of the visible height or width, depending on the scroll-direction.

为了使 `IGListAdapter` 起作用，必须使用一个范围值来初始化。这个值是可见高度或宽度的倍数，取决于滚动方向。

```
let adapter = ListAdapter(updater: ListAdapterUpdater(),
                   viewController: self,
                 workingRangeSize: 1) // 1 before/after visible objects
```

![working-range](https://raw.githubusercontent.com/Instagram/IGListKit/main/Resources/workingrange.png)

You can set the weak `workingRangeDelegate` on a section controller to receive events.

您可以在 section controller 上设置 weak `workingRangeDelegate` 来接收事件。

### Supplementary Views - 补充视图

Adding supplementary views to section controllers is as simple as setting the (weak) `supplementaryViewSource` and implementing the `IGListSupplementaryViewSource` protocol. This protocol works nearly the same as returning and configuring cells.

向 section controller 添加补充视图就像设置 (weak) `supplementaryViewSource` 并实现 `IGListSupplementaryViewSource` 协议一样简单。这个协议几乎与返回和配置单元格的方式相同。

### Display Delegate - 显示代理

Section controllers can set the weak `displayDelegate` delegate to an object, including `self`, to receive display events about a section controller and individual cells.

Section controller 可以将 weak `displayDelegate` 代理设置为一个对象，包括 `self`，以接收关于 section controller 和单个单元格的显示事件。

### Custom Updaters - 自定义更新器

The default `IGListAdapterUpdater` should handle any `UICollectionView` update that you need. However, if you find the functionality lacking, or want to perform updates in a very specific way, you can create an object that conforms to the `IGListUpdatingDelegate` protocol and initialize a new `IGListAdapter` with it.

默认的 `IGListAdapterUpdater` 应该处理您需要的任何 `UICollectionView` 更新。但是，如果您发现功能不足，或者想以非常特定的方式执行更新，您可以创建一个符合 `IGListUpdatingDelegate` 协议的对象，并使用它初始化一个新的 `IGListAdapter`。

Check out the updater `IGListReloadDataUpdater` (used in unit tests) for an example.

查看更新器 `IGListReloadDataUpdater`（在单元测试中使用）以获取示例。







