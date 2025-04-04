# UIImagePNGRepresentation

原文地址：
[https://developer.apple.com/documentation/uikit/1624096-uiimagepngrepresentation?language=objc](https://developer.apple.com/documentation/uikit/1624096-uiimagepngrepresentation?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 2.0+ | iPadOS 2.0+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Returns a data object that contains the specified image in PNG format.

以 PNG 格式返回包含指定图像的数据对象。

# Declaration 声明
```
NSData * UIImageJPEGRepresentation(UIImage *image, CGFloat compressionQuality);
```

# Parameters 参数
## image
The original image data.

原始图像数据。

# Return Value 返回值
A data object containing the PNG data, or `nil` if there was a problem generating the data. This function may return `nil` if the image has no data or if the underlying `CGImageRef` contains data in an unsupported bitmap format.

包含 PNG 数据的 data 对象，如果生成数据时出现问题则是 `nil`。如果 image 中没有数据，或者底层的 `CGImageRef` 包含不支持的位图格式的数据，此函数也可能返回 `nil`。

# Discussion 讨论
If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.

如果 image 对象的底层图像数据已经清除，调用这个方法会强制将数据重新加载到内存中。

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
