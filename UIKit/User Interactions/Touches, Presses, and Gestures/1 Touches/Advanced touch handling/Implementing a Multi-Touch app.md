# Implementing a Multi-Touch app

原文地址：
[https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/implementing_a_multi-touch_app](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/handling_touches_in_your_view/implementing_a_multi-touch_app)

Learn how to create a simple app that handles multitouch input.

学习如何创建一个处理多点触控输入的简单应用。

## Overview 概览

Consider the app shown in the following image, where a single main view that draws a gray circle at each touch location. When a touch ends, the circle disappears. When the user’s fingers move, the underlying circles move with them.

请注意以下图像中显示的应用程序，其中有一个单一的主视图，在每个触摸位置绘制一个灰色圆圈。当触摸结束时，圆圈消失。当用户的手指移动时，底部的圆圈也会随之移动。

![A screenshot from an app that draws gray circles on the screen at multiple touch points simultaneously.](https://docs-assets.developer.apple.com/published/7c21d852b9/50ef0383-bae9-400a-b2be-9352693dc60e.png)

The creation of this app begins with the Single View app template in Xcode. This type of app has a single view controller whose view — in this case, a custom subclass of UIView called `TouchableView` — fills the screen. The view contains only a label initially, but the app programmatically adds subviews later. The following image shows the storyboard for the view controller.

可以从 Xcode 中的 Single View app 模板开始创建这个应用程序。这种类型的应用程序有一个单一的视图控制器，其视图（在本例中是一个名为 `TouchableView` 的自定义 UIView 子类）填充整个屏幕。该视图最初只包含一个标签，但应用程序稍后会以编程方式添加子视图。以下图像显示了视图控制器的故事板（Storyboard）。

![A screenshot of a storyboard in Interface Builder showing a single view controller, whose view is of the custom type TouchableView.](https://docs-assets.developer.apple.com/published/6409052c4a/3004385~dark@2x.png)

## Implement the TouchableView class - 实现 TouchableView 类
The TouchableView class overrides the inherited `touchesBegan(_:with:)`, `touchesMoved(_:with:)`, `touchesEnded(_:with:)`, and `touchesCancelled(_:with:)` methods. These methods handle the creation and management of subviews that draw the gray circles at each touch location. Specifically, these methods do the following:

TouchableView 类重写了继承的 `touchesBegan(:with:)`、`touchesMoved(:with:)`、`touchesEnded(:with:)` 和 `touchesCancelled(:with:)` 方法。这些方法处理在每个触摸位置创建和管理绘制灰色圆圈的子视图。具体而言，这些方法执行以下操作：

- The `touchesBegan(_:with:)` method creates a new subview at the location of each touch event.
- `touchesBegan(_:with:)` 方法在每个触点的位置创建一个新的子视图。

- The `touchesMoved(_:with:)` method updates the position of the subview associated with each touch.
- `touchesMoved(_:with:)` 方法更新与每个触点相关联的子视图的位置。

- The `touchesEnded(_:with:)` and `touchesCancelled(_:with:)` methods remove the subview associated with each touch that ended.
- `touchesEnded(:with:)` 和 `touchesCancelled(:with:)` 方法移除每个结束的触点所关联的子视图。

The following code shows the main implementation of the `TouchableView` class and its touch handling methods. Each method iterates through the touches and performs the needed actions. The `touchViews` dictionary uses the UITouch objects as keys to retrieve the subviews the user is manipulating onscreen.

以下代码展示了 `TouchableView` 类及其触摸处理方法的主要实现。每个方法遍历触摸集合并执行所需的操作。`touchViews` 字典使用 UITouch 对象作为键来检索用户正在屏幕上操作的子视图。

```
class TouchableView: UIView {
   var touchViews = [UITouch:TouchSpotView]() 
 
   override init(frame: CGRect) {
      super.init(frame: frame)
      isMultipleTouchEnabled = true
   }
 
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      isMultipleTouchEnabled = true
   }
 
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
         createViewForTouch(touch: touch)
      }
   }
 
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
         let view = viewForTouch(touch: touch) 
         // Move the view to the new location.
         let newLocation = touch.location(in: self)
         view?.center = newLocation
      }
   }
 
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
         removeViewForTouch(touch: touch)
      }
   }
 
   override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
         removeViewForTouch(touch: touch)
      }
   }
  
   // Other methods. . . 
}
```

Several helper methods handle creation, management, and disposal of the subviews, as shown in the following code. The createViewForTouch method creates a new TouchSpotView object and adds it to the TouchableView object, animating the view to its full size. The removeViewForTouch method removes the corresponding subview and updates the class data structures. The viewForTouch method is a convenience method for retrieving the view associated with a given touch event.

有几个辅助方法来处理子视图的创建、管理和销毁，如下面的代码所示。`createViewForTouch` 方法创建一个新的 `TouchSpotView` 对象，并将其添加到 `TouchableView` 对象中，再将视图动画显示到期完整大小。`removeViewForTouch` 方法移除相应的子视图，并更新类的数据结构。`viewForTouch` 方法是一个用于检索与给定触点相关联的便捷方法。

```
func createViewForTouch( touch : UITouch ) {
   let newView = TouchSpotView()
   newView.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
   newView.center = touch.location(in: self)
 
   // Add the view and animate it to a new size.
   addSubview(newView)
   UIView.animate(withDuration: 0.2) {
      newView.bounds.size = CGSize(width: 100, height: 100)
   }
 
   // Save the views internally
   touchViews[touch] = newView
}
 
func viewForTouch (touch : UITouch) -> TouchSpotView? {
   return touchViews[touch]
}
 
func removeViewForTouch (touch : UITouch ) {
   if let view = touchViews[touch] {
      view.removeFromSuperview()
      touchViews.removeValue(forKey: touch)
   }
}
```

## Implement the TouchSpotView class - 实现 TouchSpotView 类
The `TouchSpotView` class (shown in the following code) represents the custom subviews that draw the gray circles onscreen. `TouchSpotView` maintains its circular shape by setting the `cornerRadius` property of the layer each time its `bounds` property changes.

`TouchSpotView` 类（如下面的代码所示）代表在屏幕上绘制灰色圆圈的自定义子视图。`TouchSpotView` 通过在其 `bounds` 属性更改时设置图层的 `cornerRadius` 属性来保持其圆形形状。

```
class TouchSpotView : UIView {
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = UIColor.lightGray
   }
 
   // Update the corner radius when the bounds change.
   override var bounds: CGRect {
      get { return super.bounds }
      set(newBounds) {
         super.bounds = newBounds
         layer.cornerRadius = newBounds.size.width / 2.0
      }
   }
}
```

# See Also - 其他参考

## Advanced touch handling - 高级触摸处理

### Getting high-fidelity input with coalesced touches - 获取具有合并触摸的高保真度输入

Learn how to support high-precision touches in your app.

了解如何在应用程序中支持高精度触摸。

### Minimizing latency with predicted touches - 通过预测触摸来减少延迟

Create a smooth and responsive drawing experience using UIKit’s predictions for touch locations.

使用 UIKit 的触摸位置预测功能创建流畅且响应灵敏的绘图体验。
