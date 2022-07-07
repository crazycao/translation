# viewWillTransition(to:with:)

原文链接：[https://developer.apple.com/documentation/uikit/uicontentcontainer/1621466-viewwilltransition](https://developer.apple.com/documentation/uikit/uicontentcontainer/1621466-viewwilltransition)

Notifies the container that the size of its view is about to change.

通知容器其视图的大小即将更改。

> iOS 8.0+ | iPadOS 8.0+ | Mac Catalyst 13.1+ | tvOS 9.0+

Required.

## Declaration - 声明

```
func viewWillTransition(
    to size: CGSize,
    with coordinator: UIViewControllerTransitionCoordinator
)
```

## Parameters - 参数

- `size`
	
	The new size for the container’s view.
	
	容器视图的新大小。

- `coordinator`

	The transition coordinator object managing the size change. You can use this object to animate your changes or get information about the transition that is in progress.

	管理大小更改的转换协调器对象。可以使用此对象设置更改的动画或获取有关正在进行的转换的信息。

## Discussion - 讨论

UIKit calls this method before changing the size of a presented view controller’s view. You can override this method in your own objects and use it to perform additional tasks related to the size change. For example, a container view controller might use this method to override the traits of its embedded child view controllers. Use the provided coordinator object to animate any changes you make.

UIKit在更改显示的视图控制器视图的大小之前调用此方法。您可以在自己的对象中重写此方法，并使用它执行与大小更改相关的其他任务。例如，容器视图控制器可以使用此方法覆盖其嵌入的子视图控制器的特性。使用提供的协调器对象设置你制作的更改动画。

If you override this method in your custom view controllers, always call `super` at some point in your implementation so that UIKit can forward the size change message appropriately. View controllers forward the size change message to their views and child view controllers. Presentation controllers forward the size change to their presented view controller.

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


