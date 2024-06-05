# UIGraphicsGetImageFromCurrentImageContext

原文地址：
[https://developer.apple.com/documentation/uikit/1623924-uigraphicsgetimagefromcurrentima?language=objc](https://developer.apple.com/documentation/uikit/1623924-uigraphicsgetimagefromcurrentima?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Returns an image from the contents of the current bitmap-based graphics context.

从当前基于位图的图形上下文的内容返回图像。

# Declaration 声明
```
UIImage * UIGraphicsGetImageFromCurrentImageContext(void);
```

# Return Value 返回值
A image object containing the contents of the current bitmap graphics context.

包含了当前位图图形上下文的内容的 image 对象。

# Discussion 讨论

You should call this function only when a bitmap-based graphics context is the current graphics context. If the current context is `nil` or was not created by a call to `UIGraphicsBeginImageContext`, this function returns `nil`.

只有当前图形上下文是基于位图的图形上下文时，才能调用此函数。如果当前上下文是 `nil`，或者不是由 `UIGraphicsBeginImageContext` 创建的上下文，这个函数都会返回 `nil`。

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
