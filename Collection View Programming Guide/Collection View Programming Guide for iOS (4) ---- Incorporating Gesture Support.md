# Collection View Programming Guide for iOS (4) ---- Incorporating Gesture Support

原文地址：
[https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/IncorporatingGestureSupport/IncorporatingGestureSupport.html#//apple_ref/doc/uid/TP40012334-CH4-SW1](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/IncorporatingGestureSupport/IncorporatingGestureSupport.html#//apple_ref/doc/uid/TP40012334-CH4-SW1)

# 4 Incorporating Gesture Support - 加入手势支持

You can add greater interactivity to your collection views through the use of gesture recognizers. Add a gesture recognizer to a collection view, and use it to trigger actions when those gestures occur. For a collection view, there are two types of actions that you might likely want to implement:

通过使用手势识别器你可以添加大量的交互到你的 collection view。先添加一个手势识别器到 collection view，然后当这些手势发生时用它来触发操作。对于 collection view，有两种操作你可能想要实现：

- You want to trigger changes to the collection view’s layout information.
- You want to manipulate cells and views directly.
- 你想要触发对 collection view 的布局的改变。
- 你想要直接操作 cell 和 view。


You should always attach your gesture recognizers to the collection view itself — not to a specific cell or view. The `UICollectionView` class is a descendant of `UIScrollView`, so attaching your gesture recognizers to the collection view is less likely to interfere with the other gestures that must be tracked. In addition, because the collection view has access to your data source and your layout object, you still have access to all the information you need to manipulate cells and views appropriately.

你应该总是把手势识别器添加到 collection view 自己身上 —— 而不是特定的 cell 或 view。`UICollectionView` 是 `UIScrollView` 的子类，所以添加手势识别器到 collection view 上不可能妨碍其他必须跟踪的手势。另外，由于 collection view 有权限访问你的数据源和布局对象，你仍然有权访问你要用来正确操作 cell 和 view 的所有信息。

## 4.1 Using a Gesture Recognizer to Modify Layout Information - 使用手势识别器修改布局信息

A gesture recognizer offers an easy way to modify layout parameters dynamically. For example, you might use a pinch gesture recognizer to change the spacing between items in a custom layout. The process for configuring such a gesture recognizer is relatively simple.

手势识别器提供了一个简单的方式动态修改布局参数。例如，你可以使用一个 pinch 手势识别器改变自定义布局中的 item 之间的间隔。配置这样一个手势识别器的过程也相当简单。

1. Create the gesture recognizer.
2. Attach the gesture recognizer to the collection view.
3. Use the handler method of the gesture recognizer to update the layout parameters and invalidate the layout object.

>

1. 创建一个手势识别器。
2. 将这个手势识别器添加到 collection view。
3. 使用手势识别器的 handler 方法更新布局参数并使布局对象失效。

You create a gesture recognizer using the same `alloc/init` process that you use for all objects. During initialization, you specify the target object and action method to call when the gesture is triggered. You then call the collection view’s [addGestureRecognizer:](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) method to attach it to the view. Most of the actual work happens in the action method you specify at initialization time.

你使用完全相同的 `alloc/init` 过程创建手势识别器，你创建所有对象都是用的这个过程。在初始化期间，你指定当手势别触发时调用的 target 对象和 action 方法。然后你调用 collection view 的 [addGestureRecognizer:](https://developer.apple.com/documentation/uikit/uiview/1622496-addgesturerecognizer) 方法把它添加到视图上。大部分的实际工作都发生在你初始化时指定的 action 方法中。

Listing 4-1 shows an example of an action method that is called by a pinch gesture recognizer attached to a collection view. In this example, the pinch data is used to change the distance between cells in a custom layout. The layout object implements the custom `updateSpreadDistance` method, which validates the new distance value and stores it for use during the layout process later. The action method then invalidates the layout and forces it to update the position of items based on the new value.

表 4-1 展示了一个由添加到 collection view 的 pinch 手势识别器调用的 action 方法。在这个例子中，pinch 数据用于改变自定义布局中 cell 的距离。布局对象实现了自定义的 `updateSpreadDistance` 方法，这个方法会使新的距离值生效并储存这个值以便之后在布局过程中使用。然后 action 方法会使布局失效，并强制布局基于新值更新 item 的位置。

Listing 4-1  Using a gesture recognizer to change layout values - 使用手势识别器改变布局值

```
- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
    if ([sender numberOfTouches] != 2)
        return;
 
   // Get the pinch points.
   CGPoint p1 = [sender locationOfTouch:0 inView:[self collectionView]];
   CGPoint p2 = [sender locationOfTouch:1 inView:[self collectionView]];
 
   // Compute the new spread distance.
    CGFloat xd = p1.x - p2.x;
    CGFloat yd = p1.y - p2.y;
    CGFloat distance = sqrt(xd*xd + yd*yd);
 
   // Update the custom layout parameter and invalidate.
   MyCustomLayout* myLayout = (MyCustomLayout*)[[self collectionView] collectionViewLayout];
   [myLayout updateSpreadDistance:distance];
   [myLayout invalidateLayout];
}
```

For more information about creating gesture recognizers and attaching them to views, see `Event Handling Guide for iOS`.

关于创建手势识别器并将他们添加到视图的更多信息，参见 `Event Handling Guide for iOS`。

## 4.2 Working with Default Gesture Behaviors - 用默认手势行为工作

The `UICollectionView` class listens for single taps to initiate its delegate methods for highlighting and selecting. If you want to add custom tap or long-press gestures to a collection view, configure the values of your gesture recognizer to be different than the values the collection view already uses. For example, you might configure a tap gesture recognizer to respond only to double-taps.

`UICollectionView` 类监听单击以启动关于高亮和选中的代理方法。如果你想要添加自定义 tap 或长按手势到 collection view，把你的手势识别器的值设置成与 collection view 已使用的值不同。例如，你可以配置一个只响应双击的 tap 手势识别器。

Listing 4-2 shows how you might make the collection view respond to your gesture instead of listening for cell selection/highlighting. Because the collection view does not use a gesture recognizer to initiate its delegate methods, your custom gesture recognizer gets priority over the default selection listeners by delaying the registering of other touch events by setting the [delaysTouchesBegan](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624234-delaystouchesbegan) property of your gesture recognizer to `YES` or cancelling touch events by setting the [cancelsTouchesInView](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624218-cancelstouchesinview) property of your gesture recognizer to `YES`. Whenever a tap is registered, it will first check to see if your gesture recognizer should have priority or not. If the input is not valid for your gesture recognizer, then the delegate methods will be called as normal.

表 4-2 展示了你可能如何让 collection view 响应你的手势而不是监听 cell 的选中/高亮。因为 collection view 没有使用手势识别器初始化它的 delegate 方法，你自定义的手势识别器要通过设置你的手势识别器的 [delaysTouchesBegan](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624234-delaystouchesbegan) 属性为 `YES` 来延迟注册其他 touch 事件，或者通过设置你的手势识别器的 [cancelsTouchesInView](https://developer.apple.com/documentation/uikit/uigesturerecognizer/1624218-cancelstouchesinview) 属性为 `YES` 来取消 touch 事件，这样才能让你的自定义手势识别器获得比默认选中监听器更高的优先级。无论何时注册 tap，它都将首先检查你的手势识别器是否有优先级。如果输入信号对你的手势识别器无效，那么然后 delegate 方法将正常调用。

Listing 4-2  Prioritizing your gesture recognizer - 优先考虑你的手势识别器

```
UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
tapGesture.delaysTouchesBegan = YES;
tapGesture.numberOfTapsRequired = 2;
[self.collectionView addGestureRecognizer:tapGesture];
```

## 4.3 Manipulating Cells and Views - 操作 cell 和 view

How you use a gesture recognizer to manipulate cells and views depends on the types of manipulations you plan to make. Simple insertions and deletions can be performed inside the action method of a standard gesture recognizer. But if you plan more complex manipulations, you probably need to define a custom gesture recognizer to track the touch events yourself.

你如何使用一个手势识别器操作 cell 和 view，取决于你计划执行的操作的类型。简单的插入和删除可以在标准手势识别器的 action 方法中执行。但是如果你想要更复杂的操作，你可能需要定义一个自定义的手势识别器以便自己跟踪 touch 事件。

One type of manipulation that requires a custom gesture recognizer to move a cell in your collection view from one location to another. The most straightforward way to move a cell is to delete it (temporarily) from the collection view, use the gesture recognizer to drag around a visual representation of that cell, and then insert the cell at its new location when the touch events end. All of this requires managing the touch events yourself, working closely with the layout object to determine the new insertion location, manipulating the data source changes, and then inserting the item at the new location.

有一种操作，需要自定义手势识别器将你的 collection view 中的 cell 从一个位置移动到另一个位置。最直接的移动 cell 的方法是从 collection view 删除它（暂时的），使用手势识别器拖动这个 cell 的视觉外观，然后当 touch 事件结束时把这个 cell 插入到它的新位置。所有这些需要你自己管理 touch 事件，紧密的与决定新的插入位置的布局对象合作，操作数据源的变化，然后插入 item 到新的位置。

For more information about creating custom gesture recognizers, see _Event Handling Guide for iOS_.

关于创建自定义手势识别器的更多信息，参见 _Event Handling Guide for iOS_ 。