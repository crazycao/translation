# imageWithData:scale:

原文地址：
[https://developer.apple.com/documentation/uikit/uiimage/1624099-imagewithdata?language=objc](https://developer.apple.com/documentation/uikit/uiimage/1624099-imagewithdata?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 6.0+ | iPadOS 6.0+ | Mac Catalyst 13.0+ | tvOS 9.0+ | watchOS 2.0+

Creates and returns an image object that uses the specified image data and scale factor.

使用指定图像数据和缩放因子创建并返回一个 image 对象。

# Declaration 声明
```
+ (UIImage *)imageWithData:(NSData *)data 
                     scale:(CGFloat)scale;
```

# Parameters 参数
## data
The image data. This can be data from a file or data you create programmatically.

图像数据。可以是来自文件的数据或者以编程方式创建的数据。

## scale
The scale factor to use when interpreting the image data. Specifying a scale factor of 1.0 results in an image whose size matches the pixel-based dimensions of the image. Applying a different scale factor changes the size of the image as reported by the [size](https://developer.apple.com/documentation/uikit/uiimage/1624105-size?language=objc) property.

解析图像数据时使用的缩放因子。将缩放因子设置为 `1.0` 将会生成大小与图像的像素尺寸相匹配的 image 对象。使用不同的缩放因子会改变图像的 [size](https://developer.apple.com/documentation/uikit/uiimage/1624105-size?language=objc) 属性返回的尺寸（译者注：实际并没有改变图像的大小，只是改变了 size 属性的返回值）。

# Return Value 返回值
A new image object for the specified data, or `nil` if the method could not initialize the image from the specified data.

指定数据的新图像对象；如果无法从指定数据初始化图像，则为 `nil`。

# Discussion 讨论
This method does not cache the image object.

这个方法不会缓存 image 对象。

# See Also 其它参考

## Creating and Initializing Image Objects 创建初始化 Image 对象

### [+ imageWithContentsOfFile:](https://developer.apple.com/documentation/uikit/uiimage/1624123-imagewithcontentsoffile?language=objc)
Creates and returns an image object by loading the image data from the file at the specified path.

### [+ imageWithData:](https://developer.apple.com/documentation/uikit/uiimage/1624137-imagewithdata?language=objc)
Creates and returns an image object that uses the specified image data.

### [+ imageWithData:scale:](https://developer.apple.com/documentation/uikit/uiimage/1624099-imagewithdata?language=objc)
Creates and returns an image object that uses the specified image data and scale factor.

### [+ imageWithCGImage:](https://developer.apple.com/documentation/uikit/uiimage/1624126-imagewithcgimage?language=objc)
Creates and returns an image object representing the specified Quartz image.

### [+ imageWithCGImage:scale:orientation:](https://developer.apple.com/documentation/uikit/uiimage/1624124-imagewithcgimage?language=objc)
Creates and returns an image object with the specified scale and orientation factors.

### [+ imageWithCIImage:](https://developer.apple.com/documentation/uikit/uiimage/1624111-imagewithciimage?language=objc)
Creates and returns an image object that contains a Core Image object.

### [+ imageWithCIImage:scale:orientation:](https://developer.apple.com/documentation/uikit/uiimage/1624152-imagewithciimage?language=objc)
Creates and returns an image object based on a Core Image object and the specified attributes.

### [- initWithContentsOfFile:](https://developer.apple.com/documentation/uikit/uiimage/1624112-initwithcontentsoffile?language=objc)
Initializes and returns the image object with the contents of the specified file.

### [- initWithData:](https://developer.apple.com/documentation/uikit/uiimage/1624106-initwithdata?language=objc)
Initializes and returns the image object with the specified data.

### [- initWithData:scale:](https://developer.apple.com/documentation/uikit/uiimage/1624109-initwithdata?language=objc)
Initializes and returns the image object with the specified data and scale factor.

### [- initWithCGImage:](https://developer.apple.com/documentation/uikit/uiimage/1624090-initwithcgimage?language=objc)
Initializes and returns the image object with the specified Quartz image reference.

### [- initWithCGImage:scale:orientation:](https://developer.apple.com/documentation/uikit/uiimage/1624091-initwithcgimage?language=objc)
Initializes and returns an image object with the specified scale and orientation factors.

### [- initWithCIImage:](https://developer.apple.com/documentation/uikit/uiimage/1624114-initwithciimage?language=objc)
Initializes and returns an image object with the specified Core Image object.

### [- initWithCIImage:scale:orientation:](https://developer.apple.com/documentation/uikit/uiimage/1624150-initwithciimage?language=objc)
Initializes and returns an image object with the specified Core Image object and properties.
