# UIGraphicsBeginImageContext

原文地址：
[https://developer.apple.com/documentation/uikit/1623922-uigraphicsbeginimagecontext?language=objc](https://developer.apple.com/documentation/uikit/1623922-uigraphicsbeginimagecontext?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Creates a bitmap-based graphics context and makes it the current context.

创建一个基于位图的图形上下文，并使其成为当前上下文。

# Declaration 声明
```
void UIGraphicsBeginImageContext(CGSize size);
```

# Parameters 参数

## size 尺寸

The size of the new bitmap context. This represents the size of the image returned by the `UIGraphicsGetImageFromCurrentImageContext` function.

新的位图上下文的尺寸。表示 `UIGraphicsGetImageFromCurrentImageContext` 函数返回的图像的大小。

# Discussion 讨论

This function is equivalent to calling the [UIGraphicsBeginImageContextWithOptions](https://developer.apple.com/documentation/uikit/1623912-uigraphicsbeginimagecontextwitho?language=objc) function with the opaque parameter set to `NO` and a scale factor of `1.0`.

这个函数等价于调用 [UIGraphicsBeginImageContextWithOptions](https://developer.apple.com/documentation/uikit/1623912-uigraphicsbeginimagecontextwitho?language=objc) 函数，并将不透明参数设置成 `NO` 且将缩放因子设置成 `1.0`。

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
