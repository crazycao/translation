# willTransition(to:with:)

原文链接：[https://developer.apple.com/documentation/uikit/uicontentcontainer/1621511-willtransition](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621511-willtransition)

Notifies the container that its trait collection changed.

通知容器其特征集合已更改。

> iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.1+ | tvOS 9.0+

Required.

## Declaration - 声明

```
func willTransition(
    to newCollection: UITraitCollection,
    with coordinator: UIViewControllerTransitionCoordinator
)
```

## Parameters - 参数

- `newCollection `
	
	The traits to be applied to the container.
	
	要应用于容器的特性。

- `coordinator`

	The transition coordinator object managing the size change. You can use this object to animate your changes or get information about the transition that is in progress.

	管理大小更改的转换协调器对象。可以使用此对象设置更改的动画或获取有关正在进行的转换的信息。

## Discussion - 讨论

UIKit calls this method before changing the current object’s traits and before calling the [traitCollectionDidChange(_:)](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) method of any affected views and view controllers. Implementors of this method can use it to adapt the interface based on the values in the `newCollection` parameter. A common use of this method is to make changes to the high-level presentation style when the current size class changes. For example, a container view controller that manages multiple child view controllers might change the number of child view controllers it displays onscreen when the size class changes. A standard view controller might use this method to change the constraints on the views it manages. Use the provided coordinator object to animate any changes you make.

UIKit 在更改当前对象的特征之前，以及在调用任何受影响视图和视图控制器的 [traitCollectionDidChange(_:)](https://developer.apple.com/documentation/uikit/uitraitenvironment/1623516-traitcollectiondidchange) 方法之前，调用此方法。此方法的实现者可以根据 `newCollection` 参数中的值来调整界面。此方法的一个常见用途是在当前 size class 更改时更改高级展示样式。例如，当 size class 更改时，管理多个子视图控制器的容器视图控制器可能会更改其在屏幕上显示的子视图控制器的数量。标准视图控制器可以使用此方法更改其管理的视图上的约束。使用提供的协调器对象设置所做更改的动画。

If you override this method in your own objects, always call `super` at some point in your implementation so that UIKit can forward the trait changes to the associated presentation controller and to any child view controllers. View controllers forward the trait change message to their child view controllers. Presentation controllers forward the trait change to their presented view controller.

如果在自定义视图控制器中重写此方法，请始终在实现中的某个点调用 `super`，以便 UIKit 可以正确地转发大小更改消息。视图控制器将大小更改消息转发给它们的视图和子视图控制器。显示控制器将大小更改转发给其显示的视图控制器。

# See Also - 其他参考

## Responding to Environment Changes - 响应环境变化

### func [viewWillTransition(to: CGSize, with: UIViewControllerTransitionCoordinator)](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621466-viewwilltransition) 【Required.】

Notifies the container that the size of its view is about to change.

通知容器其视图的大小即将更改。

### func [willTransition(to: UITraitCollection, with: UIViewControllerTransitionCoordinator)](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621511-willtransition) 【Required.】

Notifies the container that its trait collection changed.

通知容器其特征集合已更改。

## Related Documentation - 相关文档

### func [size(forChildContentContainer: UIContentContainer, withParentContainerSize: CGSize) -> CGSize](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621484-size)

Returns the size of the specified child view controller’s content.

返回指定子视图控制器的内容的大小。


