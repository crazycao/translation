# addClip()

原文地址：
[https://developer.apple.com/documentation/uikit/uibezierpath/1624341-addclip](https://developer.apple.com/documentation/uikit/uibezierpath/1624341-addclip)

Uses the clipping path of the current graphics context to intersect the region that the path encloses, and makes the resulting shape the current clipping path.

使用当前图形上下文的裁剪路径与路径所围闭的区域进行交集操作，并将生成的形状作为当前的裁剪路径。

> iOS 3.2+
iPadOS 3.2+
Mac Catalyst 13.1+
tvOS 9.0+
watchOS 2.0+
visionOS 1.0+

```
func addClip()
```

# Discussion - 讨论

This method modifies the visible drawing area of the current graphics context. After calling it, subsequent drawing operations result in rendered content only if they occur within the fill area of the specified path.

这个方法修改了当前图形上下文的可见绘制区域。调用它之后，只有在指定路径的填充区域内进行的后续绘图操作才会产生渲染内容。

> **Important** **重要**
>
> If you need to remove the clipping region to perform subsequent drawing operations, you must save the current graphics state (using the [saveGState()](https://developer.apple.com/documentation/coregraphics/cgcontext/1456156-savegstate) function) before calling this method. When you no longer need the clipping region, you can then restore the previous drawing properties and clipping region using the [restoreGState()](https://developer.apple.com/documentation/coregraphics/cgcontext/1455391-restoregstate) function.
> 
> 如果你需要移除裁剪区域以执行后续的绘图操作，你必须在调用这个方法之前保存当前的图形状态（使用 [saveGState()](https://developer.apple.com/documentation/coregraphics/cgcontext/1456156-savegstate) 函数）。当你不再需要裁剪区域时，你可以使用 [restoreGState()](https://developer.apple.com/documentation/coregraphics/cgcontext/1455391-restoregstate) 函数来恢复之前的绘图属性和裁剪区域。

The usesEvenOddFillRule property is used to determine whether the even-odd or non-zero rule is used to determine the area enclosed by the path.

[usesEvenOddFillRule](https://developer.apple.com/documentation/uikit/uibezierpath/1624360-usesevenoddfillrule) 属性用于确定是使用奇偶规则还是非零规则来确定路径所围闭的区域。

