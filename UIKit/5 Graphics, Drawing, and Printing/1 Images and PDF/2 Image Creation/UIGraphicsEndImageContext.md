# UIGraphicsEndImageContext

原文地址：
[https://developer.apple.com/documentation/uikit/1623933-uigraphicsendimagecontext?language=objc](https://developer.apple.com/documentation/uikit/1623933-uigraphicsendimagecontext?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Removes the current bitmap-based graphics context from the top of the stack.

从栈顶移除当前基于位图的图形上下文。

# Declaration 声明
```
void UIGraphicsEndImageContext(void);
```

# Discussion 讨论

You use this function to clean up the drawing environment put in place by the `UIGraphicsBeginImageContext` function and to remove the corresponding bitmap-based graphics context from the top of the stack. If the current context was not created using the `UIGraphicsBeginImageContext` function, this function does nothing.

使用此函数可以清理 `UIGraphicsBeginImageContext` 函数放置的图形环境，并从堆栈顶部删除相应的基于位图的图形上下文。如果当前上下文不是使用 `UIGraphicsBeginImageContext` 函数创建的，则此函数不执行任何操作。

This function may be called from any thread of your app.

可以从应用程序的任何线程调用此函数。

# See Also 其它参考

## Image Creation 创建图像

### [UIGraphicsBeginImageContext](https://developer.apple.com/documentation/uikit/1623922-uigraphicsbeginimagecontext?language=objc)
Creates a bitmap-based graphics context and makes it the current context.

### [UIGraphicsGetImageFromCurrentImageContext](https://developer.apple.com/documentation/uikit/1623924-uigraphicsgetimagefromcurrentima?language=objc)
Returns an image from the contents of the current bitmap-based graphics context.

### [UIGraphicsEndImageContext](https://developer.apple.com/documentation/uikit/1623933-uigraphicsendimagecontext?language=objc)
Removes the current bitmap-based graphics context from the top of the stack.

### [UIImageJPEGRepresentation](https://developer.apple.com/documentation/uikit/1624115-uiimagejpegrepresentation?language=objc)
Returns a data object that contains the specified image in JPEG format.

### [UIImagePNGRepresentation](https://developer.apple.com/documentation/uikit/1624096-uiimagepngrepresentation?language=objc)
Returns a data object that contains the specified image in PNG format.
