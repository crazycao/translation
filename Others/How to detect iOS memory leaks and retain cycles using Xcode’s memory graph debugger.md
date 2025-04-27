# How to detect iOS memory leaks and retain cycles using Xcode’s memory graph debugger - 如何使用 Xcode Memory Graph Debugger 检测 iOS 内存泄漏和循环引用


原文地址：[https://doordash.engineering/2019/05/22/ios-memory-leaks-and-retain-cycle-detection-using-xcodes-memory-graph-debugger/](https://doordash.engineering/2019/05/22/ios-memory-leaks-and-retain-cycle-detection-using-xcodes-memory-graph-debugger/) 

作者：Vince Chau

At DoorDash we are consistently making an effort to increase our user experience by increasing our app's stability. A major part of this effort is to prevent, fix and remove any retain cycles and memory leaks in our large codebase. In order to detect and fix these issues, we have found the Memory Graph Debugger to be quick and easy to use. After significantly increasing our OOM-free session rate on our Dasher iOS app, we would like to share some tips on avoiding and fixing retain cycles as well as a quick introduction using Xcode’s memory graph debugger for those who are not familiar.

在 DoorDash 公司（位于旧金山，是美国最大的外卖公司），我们一直在努力通过提高应用程序的稳定性来提高用户体验。这项工作的主要部分是防止、修复和消除庞大的代码库中的任何循环引用和内存泄漏。为了检测和修复这些问题，我们发现内存图调试器（Memory Graph Debugger）用起来简单又快捷。在大幅提高Dasher iOS 应用程序的无 OOM 会话率之后，我们想分享一些避免和修复循环引用的技巧，以及使用 Xcode 内存图调试器的快速介绍，供不熟悉的用户使用。

If pinpointing root causes of problematic memory is interesting to you, check out our new blog post [Examining Problematic Memory in C/C++ Applications with BPF, perf, and Memcheck](https://doordash.engineering/2021/04/01/examining-problematic-memory-with-bpf-perf-and-memcheck/) for a detailed explanation of how memory works.

如果您对找出问题内存的根本原因感兴趣，请查看我们的新博客文章《[使用 BPF、perf 和 Memcheck 检查 C/C++ 应用程序中的问题内存](https://doordash.engineering/2021/04/01/examining-problematic-memory-with-bpf-perf-and-memcheck/)》了解内存如何工作的详细说明。

## I. What are retain cycles and memory leaks? - 什么是循环引用和内存泄漏？

A **memory leak** in iOS is when an amount of allocated space in memory cannot be deallocated due to retain cycles. Since Swift uses Automatic Reference Counting (ARC), a **retain cycle** occurs when two or more objects hold strong references to each other. As a result these objects retain each other in memory because their retain count would never decrement to 0, which would prevent `deinit` from ever being called and memory from being freed.

iOS 中的**内存泄漏**是指在内存中分配的由于循环引用而无法释放的空间量。由于 Swift 使用自动引用计数（ARC），当两个或多个对象彼此持有强引用时，就会发生**循环引用**。因为这些对象在内存中互相持有，所以它们的引用计数永远不会减少到0，这将导致 `deinit` 方法不会被调用且内存不会被释放。

## II. Why should we care about memory leaks? - 为什么我们要关注内存泄漏？

Memory leaks increase the memory footprint incrementally in your app, and when it reaches a certain threshold the operating system (iOS) this triggers a memory warning. If that memory warning is not handled, your app would be force-killed, which is an **OOM (Out of memory) crash**. As you can see, memory leaks can be very problematic if a substantial leak occurs because after using your app for a period of time, the app would crash.

内存泄漏会逐渐增加应用程序中的内存占用量，当它达到某个阈值时，操作系统（iOS）会触发内存警告。如果不处理内存警告，您的应用程序将被强制终止，这就是 **OOM（内存不足）崩溃**。正如你所看到的，如果发生大量泄漏，内存泄漏可能会非常严重，因为在使用一段时间后，应用程序就会崩溃。

In addition, memory leaks can introduce **side effects** in your app. Typically this happens when observers are retained in memory when they should have been deallocated. These leaked observers would still listen to notifications and when triggered the app would be prone to unpredictable behaviors or crashes. In the next section we will go over an introduction to Xcode's memory graph debugger and later use it find memory leaks in a sample app.

此外，内存泄漏可能会在应用程序中引入**副作用**。通常情况下，这发生在观察者本应被释放却被保留在内存中的时候。这些被泄漏的观察者仍然会听取通知，而在被触发时，应用程序很容易出现不可预测的行为或崩溃。在下一节中，我们将介绍 Xcode 的内存图调试器，稍后将使用它在示例应用程序中查找内存泄漏。

## III. Introduction to Xcode’s Memory Graph Debugger - Xcode 内存图调试器的介绍

To open, run your app (In this case I am running a demo app) and then tap on the 3-node button in between the visual debugger and location simulator button. This will take a memory snapshot of the current state of your app.

要打开内存图调试器，请运行您的应用程序（在本例中，我正在运行一个演示应用程序），然后点击视觉调试器和位置模拟器按钮之间的有三个点的按钮。这将获取应用程序当前状态的内存快照。

![The memory graph debugger button](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-04-at-3.45.45-PM.png)

The left panel shows you the objects in memory for this snapshot followed by the number of instances of each class next to it's name.

左侧面板显示此快照的内存中的对象，每个类名称旁边都跟着它的实例数。

ex: (MainViewController(1))

![The classes in-memory in Xcode](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-04-at-3.46.57-PM.png)

Signifies that there is only one `MainViewController` in memory at the time of the snapshot, followed by the address of that instance in memory below.

图中显示快照时内存中只有一个 `MainViewController`，后面是该实例在内存中的地址。

**If you select an object on the left panel, you will see the chain of references that keep the selected object in memory.** For example, selecting `0x7f85204227c0` under `MainViewController` would show us a graph like this:

**如果你在左侧面板上选择一个对象，你将看到将选定对象保存在内存中的引用链。**例如，在 `MainViewController` 下选择 `0x7f85204227c0` 将显示如下图表：

![The memory graph with the strong referencing and unknown referencing](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-04-at-3.47.53-PM.png)

- The **bold lines** mean there is a **strong reference** to the object it points to.
- The **light gray lines** mean there is an **unknown reference** (could be weak or strong) to the object it points to.
- Tapping an instance from the left panel will only show you the chain of references that is keeping the selected object in memory. But it will not show you what references that the selected object has references to.
- **粗线**表示这是对它指向的对象的**强引用**。
- **浅灰色线**表示这是对它指向的对象的**未知引用**（可能是 weak 或 strong）。
- 从左侧面板点击一个实例只会显示将选定对象保存在内存中的引用链。但它不会显示选定对象引用了哪些引用。

For example, to verify that there is no retain cycle in the objects which `MainViewController` has a strong reference to, you would need to look at your codebase to identify the referenced objects, and then individually select each of the object graphs to check if there is a retain cycle.

例如，要验证 `MainViewController` 强引用的对象中没有循环引用，你需要查看代码库找到被引用的对象，然后单独选择每个对象图以检查是否存在循环引用。

In addition, the memory graph debugger can auto-detect simple memory leaks and prompt you warnings such as this purple `! ` mark. Tapping it would show you the leaked instances on the left panel.

此外，内存图调试器可以自动检测简单的内存泄漏，并提示警告，如紫色 `! ` 标记。点击它将在左侧面板上显示泄漏的实例。

![The retain cycles automatically detected by Xcode](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-04-at-3.49.26-PM.png)

**Please note that the Xcode’s auto-detection does not always catch every memory leak, and oftentimes you will have to find them yourself.** In the next section, I will explain the approach to using the memory graph debugger for debugging.

**请注意，Xcode 的自动检测并不总能捕捉到每一个内存泄漏，通常情况下，你必须自己找到它们。**在下一节中，我将解释使用内存图调试器进行调试的方法。

## IV. The approach to using the Memory Graph Debugger - 使用内存图调试器的方法

A useful approach for catching memory leaks is running the app through some core flows and taking a memory snapshot for the first and subsequent iterations.

捕捉内存泄漏的一个有用方法是运行应用程序通过一些核心流程操作，并为第一次和后续迭代拍摄内存快照。

1. Run through a core flow/feature and leave it, then repeat this several times and take a memory snapshot of the app. Take a look at what objects are in-memory and how much of each instance exists per object.
2. Check for these signs of a retain cycle/memory leak:
	- In the left panel do you see any objects/classes/views and etc on the list that should not be there or should have been deallocated?
	- Are there increasingly more of the same instance of a class that is kept in memory? ex: `MainViewController (1)` becomes `MainViewController (5)` after going through the flow 4 more iterations?
	- Look at the Debug Navigator on the left panel, do you notice an increase in Memory? Is the app now consuming a greater amount of megabytes (MB) than before despite returning to the original state
3. If you have found an instance that shouldn’t be in memory anymore, you have found a leaked instance of an object.
4. Tap on that leaked instance and use the object graph to track down the object that is retaining it in memory.
5. You may need to keep navigating the object graphs as you track down what is the parent node that is keeping the chain of objects in memory.
6. Once you believe you found the parent node, look at the code for that object and figure out where the circular strong referencing is coming from and fix it.

>

1. 运行一个核心流程或功能并离开它，然后重复几次并拍摄应用程序的内存快照。看看内存中有哪些对象，每个对象中有多少实例。
2. 检查循环引用/内存泄漏的这些表征：
	- 在左边的面板中，你是否看到列表中有任何不应该存在或应该被释放的对象/类/视图等？
	- 内存中保存的类的同一实例是否越来越多？例如：`MainViewController(1)`在经过流程4次迭代后变成 `MainViewControl(5)`？
	- 查看左侧面板上的调试导航器，你注意到内存增加了吗？尽管恢复到原始状态，应用程序现在是否比以前消耗了更多的兆字节（MB）
3. 如果你发现了一个不应该再存在于内存中的实例，那么你就发现了对象的泄漏实例。
4. 点击泄漏的实例，并使用对象图追踪将其保留在内存中的对象。
5. 你可能需要继续导航对象图以跟踪保持内存中对象链的父节点。
6. 一旦你确信找到了父节点，请查看该对象的代码，找出循环强引用的来源并修复它。

In the next section, I will go through an example of common use cases of code that I’ve personally seen that causes retain cycles. To follow along, please download this sample project called [LeakyApp](https://github.com/chauvincent/LeakyApp-iOS).

在下一节中，我将介绍我个人看到的导致循环引用的代码的常见用例示例。要继续，请下载这个名为 [LeakyApp](https://github.com/chauvincent/LeakyApp-iOS) 的示例项目。

## V. Fixing memory leaks with an example - 通过例子修正内存泄漏

Once you have downloaded the same Xcode project, run the app. We will go through one example using the memory graph debugger.

下载相同的 Xcode 项目后，运行应用程序。我们将做一个使用内存图调试器的示范。

1. Once the app is running you will see three buttons. We will go through one example so tap on “Leaky Controller”
2. This will present the `ObservableViewController` which is just an empty view with a navigation bar.
3. Tap on the back navigation item.
4. Repeat this a few times.
5. Now take a memory snapshot.

>

1. 应用程序运行后，您将看到三个按钮。我们将做一个示范。那么，点击“Leaky Controller”。
2. 这将显示 `ObservableViewController`，它只是一个带有导航栏的空视图。
3. 轻触返回导航键。
4. 重复几次。
5. 现在拍摄一个内存快照。

After taking a memory snapshot, you will see something like this:

拍摄内存快照后，你将看到像这样的内容：

![Snapshot of the retain cycles and leaked instances of the classes](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-04-at-3.51.25-PM.png)

Since we repeated this flow several times, once we return back to the main screen `MainViewController` the observable view controller should have been deallocated if there were no memory leaks. However, we see `ObservableViewController (25)` in the left panel, which means we have 25 instances of that view controller still in memory! Also note that Xcode did not recognize this as a memory leak!

由于我们多次重复这个流程，一旦我们返回主屏幕 `MainViewController`，如果没有内存泄漏，那么 `ObservableViewController` 应该已经被释放。然而，我们在左侧面板中看到了 `ObservableViewController(25)`，这意味着我们有25个视图控制器的实例仍在内存中！还要注意的是，Xcode 没有将此识别为内存泄漏！

Now, tap on  `ObservableViewController (25)`. You will see the object graph and it would look similar to this:

现在，点击 `ObservableViewController(25)`。你将看到对象图，它看起来像这样：

![Closure holding a strong referencing causing a memory leak](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-04-at-3.52.57-PM.png)

As you can see, it shows a Swift closure context, retaining `ObservableViewController` in memory. This closure is retained in memory by `__NSObserver`. Now let’s go to the code and fix this leak.

如你所见，它显示了一个 Swift 闭包上下文，是它将 `ObservableViewController` 保留在内存中。此闭包由 `__NSObserver` 在内存中持有。现在让我们查看代码并修复此漏洞。

Now we go to the file `ObservableViewController.swift`. At first glance, we have a pretty common use case:
[https://gist.github.com/chauvincent/33cf83b0894d9bb12d38166c15dd84a5](https://gist.github.com/chauvincent/33cf83b0894d9bb12d38166c15dd84a5)
We are registering an observer in `viewDidLoad` and removing self as an observer in `deinit`. However, there is one tricky usage of code here:
[https://gist.github.com/chauvincent/b191414d54ba4cbb04614b1f85ac2e24](https://gist.github.com/chauvincent/b191414d54ba4cbb04614b1f85ac2e24) .
We are passing a function as a closure! **Doing this captures self strongly by default.** You may refer back to the object graph as proof that this is the case. `NotificationCenter` seems to keep a strong reference to the closure, and the `handleNotification` function holds a strong reference to `self`, keeping this `UIViewController` and objects it holds strong references to in memory!

现在我们来到文件 `ObservableViewController.swift`。乍一看，我们有一个非常常见的使用案例：
```
extension Notification.Name {
    static let SomethingToObserveNotification = Notification.Name(rawValue: "SomethingToObserverNotification")
}

class ObservableViewController: UIViewController {

	// MARK: - Init
	deinit {
	    NotificationCenter.default.removeObserver(self)
	}
	
	// MARK: - View Life Cycle
	override func viewDidLoad() {
	    super.viewDidLoad()
	    addObservers()
	}
	
	// MARK: - Add Observers
	private func addObservers() {
	    NotificationCenter.default.addObserver(
	        forName: .SomethingToObserveNotification,
	        object: nil,
	        queue: .main,
	        completion: handleNotification
	    )
	}
	
	private func handleNotification(_ notification: Notification) {
	    // No-op but there is a leak in this controller!
	}
}
```

我们在 `viewDidLoad` 中注册了一个观察者，并在 `deinit` 中删除自己作为观察者的身份。然而，这里有一个令人头大的代码用法：

```
NotificationCenter.default.addObserver(
  forName: .SomethingToObserverNotification, 
  object: nil, 
  queue: .main, 
  using: handleNotification
)
```

我们正在传递一个函数作为闭包！**默认情况下，这样做会捕获 `self`，造成强引用。**你可以回到对象图来证明这种情况。`NotificationCenter` 似乎保留了对闭包的强引用，而 `handleNotification` 函数持有了对 `self` 的强引用，这让 `UIViewController` 及其强引用持有的对象都保留在了内存中！

We can simply fix this by not passing a function as a closure and adding `weak self` to the capture list:
https://gist.github.com/chauvincent/a35a8f08c7dd4fc183ab2bd5b2ba5e6d

我们可以简单的这样修正，不要传递函数作为闭包，并将 `weak self` 添加到捕获列表中：

```
NotificationCenter.default.addObserver(
  forName: .SomethingToObserveNotification, 
  object: nil, 
  queue: .main) { [weak self] notification in
    self?.handleNotification(notification)
 }
```

Now rebuild the app and re-run that flow several times and verify that the object has now been deallocated by taking a memory snapshot.

现在 rebuild 应用程序并重新运行该流程几次，并通过拍摄内存快照验证对象是否已被释放。

You should see something like this where `ObservableViewController` is nowhere on the list after you have exited the flow!

你应该可以看到，在你退出该流程后，`ObservableViewController` 不再在列表中了！

![Snapshot of the memory graph after fixing the memory leak](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-13-at-10.58.46-PM.png)

The memory leak has been fixed! 🎉 Feel free to test out the other examples in the `LeakyApp` repo, and read through the comments. I have included comments in each file explaining the causes of each retain cycle/memory leak.

内存泄漏已经修复！🎉 请随意测试 `LeakyApp` 中的其他示例，并通读评论。我在每个文件中都添加了注释，解释每个循环引用/内存泄漏的原因。


## VI. Additional tips to avoid retain cycles - 避免循环引用的提示

1. Keep in mind that using a function as a closure keeps a strong reference by default. If you have to pass in a function as a closure and it causes a retain cycle, you can make an extension or operator overload to break strong reference. I won’t be going over this topic but there are many resources online for this.
2. When using views that have action handlers through closures, be careful to not reference the view inside its own closure! And if you do, you must use the capture list to keep a weak reference to that view, with the closure that the view has a strong reference to.

	For example, we may have some reusable view like this:
	[https://gist.github.com/chauvincent/b2da3c76b0b811c947487ef3bf171d5a](https://gist.github.com/chauvincent/b2da3c76b0b811c947487ef3bf171d5a)
	
	In the caller, we have some presentation code like this:
	[https://gist.github.com/chauvincent/c049136b236c8b358d81ad16168a0243](https://gist.github.com/chauvincent/c049136b236c8b358d81ad16168a0243)
	
	This is a retain cycle here because `someModalVC`’s `actionHandler` captures a strong reference to `someModalVC`. Meanwhile `someModalVC` holds a strong reference to the `actionHandler`.

	To fix this:
	[https://gist.github.com/chauvincent/fe868818e9be6f61cf3bc032539ff3a8](https://gist.github.com/chauvincent/fe868818e9be6f61cf3bc032539ff3a8)

	We need to make sure the reference to `someModalVC` is weak by updating the capture list with `[weak someModalVC]` in to break the retain cycle.

3. When you are declaring properties on your objects and you have a variable that is a protocol type, be sure to add a class constraint and declare it as weak if needed! This is because the compiler will give you an error by default if you do not add a class constraint.  Although It is pretty well known that the delegate in the delegation pattern is supposed to be weak, but keep in mind that this rule still applies for other abstractions and design patterns, or any protocol variables you declare.

	For example, here we a stubbed out clean swift pattern:
	[https://gist.github.com/chauvincent/8882082ea1280c722955b4803ca6854b](https://gist.github.com/chauvincent/8882082ea1280c722955b4803ca6854b)
	[https://gist.github.com/chauvincent/15f52e6908a70ea36d099a16d2d660e2](https://gist.github.com/chauvincent/15f52e6908a70ea36d099a16d2d660e2)
	
	Here, we need the `OrdersListPresenter`’s `view` property must be a weak reference or else we will have a strong circular reference from the `View -> Interacter -> Presenter -> View`. However when updating that property to `weak var view: OrdersListDisplayLogic` we will get a compiler error.
	
	![Errors from not adding a class-bound protocol while making a reference weak](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-13-at-11.09.14-PM.png)
 
	This compiler error may look discouraging to some when declaring a protocol-typed variable as weak! But in this case, you have to fix this by adding a class constraint to the protocol!
	
	[https://gist.github.com/chauvincent/bbc2c2fc42df62bad61a9d4c49b0290e](https://gist.github.com/chauvincent/bbc2c2fc42df62bad61a9d4c49b0290e)

>

1. 请记住，使用函数作为闭包在默认情况下会保持强引用。如果你不得不将函数作为闭包传递，并且它导致了循环引用，你可以使用扩展或运算符重载来中断强引用。我不继续讨论这个话题，网上有很多关于这个的资源。
2. 当使用具有通过闭包的操作处理程序的视图时，请注意不要在自己的闭包中引用视图！如果这样做，则必须使用捕获列表来保持对该视图的弱引用，而该视图强引用这个闭包。

	例如，我们有一些像这样的可重用视图：
	```
	class SomeModalViewController: UIViewController {
	    var actionHandler: (() -> Void)?
	
	    @IBAction func onTappedAction(_ sender: Any) {
	        actionHandler?()
	    }
	}
	```
	
	在调用者中，我们有一些像这样的代码：
	```
	let someModalVC = SomeModalViewController()
	someModalVC.actionHandler = {
	    someModalVC.dismiss(animated: true, completion: nil)
	}
	present(someModalVC, animated: true, completion: nil)
	```
	
	这里是一个循环引用，因为 `someModalVC` 的 `actionHandler` 捕获了一个对 `someModalVC` 的强引用。同时 `someModalVC` 持有了对 `actionHandler ` 的强引用。
	
	这样修正：
	```
	let someModalVC = SomeModalViewController()
	someModalVC.actionHandler = { [weak someModalVC] in
	    someModalVC?.dismiss(animated: true, completion: nil)
	}
	present(someModalVC, animated: true, completion: nil)
	```
	
	我们需要通过使用 `[weak someModalVC] in` 更新捕获列表以确保对 `someModalVC` 是弱引用，来打破循环引用。
	
3. 当你在对象上声明属性，并且您有一个协议类型的变量时，请确保添加一个类约束，并在需要时将其声明为弱约束！这是因为如果您不添加类约束，编译器将在默认情况下给您一个错误。尽管众所周知，委托模式中的委托应该是弱引用，但请记住，此规则仍然适用于其他抽象和设计模式，或你声明的任何协议变量。

	例如，这里我们有一个简单的swift模式：
	
	```
	protocol OrdersListDisplayLogic {}
	protocol OrdersListBusinessLogic {}
	protocol OrdersListPresentationLogic {}
	
	class OrdersListViewController: OrdersListDisplayLogic {
	    var interactor: OrdersListBusinessLogic 
	    ...
	}
	
	class OrdersListInteractor: OrdersListBusinessLogic {
	    var presenter: OrdersListPresentationLogic
	    ...
	}
	
	class OrdersListPresenter: OrdersListPresentationLogic {
	    var view: OrdersListDisplayLogic
	    ...
	}
	```
	
	```
	// In some builder class:
	let view = OrdersListViewController()
	let interactor = OrdersListInteractor()
	let presenter = OrdersListPresenter()
	view.interactor = interactor
	interactor.presenter = presenter
	presenter.view = view
	```
	
	这里，我们需要 `OrdersListPresenter` 的 `view` 属性必须是弱引用，否则我们将有一个来自 `View->Interacter->Presenter->View` 的强循环引用。然而，当将该属性更新为 `weak var view: OrdersListDisplayLogic` 时，我们将得到一个编译器错误。

	![Errors from not adding a class-bound protocol while making a reference weak](https://doordash.engineering/wp-content/uploads/2019/05/Screen-Shot-2019-05-13-at-11.09.14-PM.png)
	
	当将协议类型变量声明为弱变量时，这个编译器错误可能会让一些人灰心！而在这种情况下，你必须通过向协议添加类约束来解决这个问题！
	
	```
	protocol OrdersListDisplayLogic: class {}

	class OrdersListPresenter: OrdersListPresentationLogic {
	    weak var view: OrdersListDisplayLogic?
	    ...
	}
	```
	
Overall, I have found using Xcode Memory Graph Debugger to be a quick and easy way to find and fix retain cycles and memory leaks! I hope you find this information useful and keep these tips in mind regularly as you develop! Thanks!

总的来说，我发现使用 Xcode 内存图调试器是一种快速简便的查找和修复循环引用和内存泄漏的方法！我希望这些信息对你有用，并在你的开发过程中经常记住这些提示！谢谢！