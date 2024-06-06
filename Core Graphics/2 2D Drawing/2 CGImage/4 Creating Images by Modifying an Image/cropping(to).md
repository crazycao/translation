# cropping(to:)

原文链接：[https://developer.apple.com/documentation/coregraphics/cgimage/1454683-cropping](https://developer.apple.com/documentation/coregraphics/cgimage/1454683-cropping)

Creates a bitmap image using the data contained within a subregion of an existing bitmap image.

使用现有位图图像的子区域中包含的数据创建位图图像。

> iOS 2.0+
iPadOS 2.0+
macOS 10.4+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+
watchOS 2.0+

```
func cropping(to rect: CGRect) -> CGImage?
```

## Parameters

- rect

	A rectangle specifying the portion of the image to keep.
	
	指定要保留的图像部分的矩形。

## Return Value

A CGImage object that specifies a subimage of the image. If the `rect` parameter defines an area that is not in the image, returns `NULL`.

指定图像的子图像的 CGImage 对象。如果 `rect` 参数定义的区域不在图像中，则返回 `NULL`。

## Discussion

Cropping removes content around the designated rectangle; it cuts out the desired area of the input image and returns an image of the cropped size.

裁剪将删除指定矩形周围的内容；它剪切出输入图像的期望区域并返回剪切尺寸的图像。

**Figure 1** Cropping an image - **图 1** 裁剪一张图片
![Butterfly photo with background cropped out](https://docs-assets.developer.apple.com/published/5efd7a9444/91ca02df-25f3-49ab-a099-ffb162bb6c97.png)

[cropping(to:)](https://developer.apple.com/documentation/coregraphics/cgimage/1454683-cropping) performs the following tasks to create the subimage:

- It calls the [CGRectIntegral(_:)](https://developer.apple.com/documentation/coregraphics/1456348-cgrectintegral) function to adjust the `rect` parameter to integral bounds.

- It intersects the `rect` with a rectangle whose origin is `(0,0)` and size is equal to the size of the image specified by the `image` parameter.

- It reads the pixels within the resulting rectangle, treating the first pixel within as the origin of the subimage.

[cropping(to:)](https://developer.apple.com/documentation/coregraphics/cgimage/1454683-cropping) 执行以下任务来创建子图像：

- 它调用 [CGRectIntegral(_:)](https://developer.apple.com/documentation/coregraphics/1456348-cgrectintegral) 函数将 `rect` 参数到整数边界。
- 它将 `rect` 与一个原点为 `(0,0)`、大小等于 `image` 参数指定的图像大小的矩形进行交集运算。
- 它读取结果矩形内的像素，将其中的第一个像素视为子图像的原点。

If `W` and `H` are the width and height of image, respectively, then the point `(0,0)` corresponds to the first pixel of the image data. The point `(W–1, 0)` is the last pixel of the first row of the image data, while `(0, H–1)` is the first pixel of the last row of the image data and `(W–1, H–1)` is the last pixel of the last row of the image data.

如果 `W` 和 `H` 分别是图像的宽度和高度，那么点 `(0,0)` 对应于图像数据的第一个像素。点 `(W-1, 0)` 是图像数据第一行的最后一个像素，而点 `(0, H-1)` 是图像数据最后一行的第一个像素，点 `(W-1, H-1)` 是图像数据最后一行的最后一个像素。

> **Important** **重要**
>
> Be sure to specify the subrectangle's coordinates relative to the original image's full size, even if the UIImageView shows only a scaled version.
> 
> 即使 `UIImageView` 只显示了缩放版本的图像，也要确保指定子矩形的坐标是相对于原始图像的全尺寸的。

The resulting image retains a reference to the original image, which means you may release the original image after calling this function. In Swift, you do not need to release the original image reference explicitly.

结果图像保留了对原始图像的引用，这意味着你在调用这个函数后可以释放原始图像。在 Swift 中，你不需要显式地释放原始图像的引用。

**Listing 1** Cropping an image using CGImageCreateWithImageInRect - **代码 1** 实用 CGImageCreateWithImageInRect 切割图像

```
func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage? 
{    
    let imageViewScale = max(inputImage.size.width / viewWidth,
                             inputImage.size.height / viewHeight)


    // Scale cropRect to handle images larger than shown-on-screen size
    // 处理比屏幕显示大小更大的图像时，需要对 cropRect 进行缩放
    let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                          y:cropRect.origin.y * imageViewScale,
                          width:cropRect.size.width * imageViewScale,
                          height:cropRect.size.height * imageViewScale)


    // Perform cropping in Core Graphics
    在 Core Graphics 中执行裁剪操作
    guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
    else {
        return nil
    }


    // Return image to UIImage
    // 将图像返回为 UIImage
    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
    return croppedImage
}
```

If you already use CIImage, or if you are post-processing images as CIImage data in Core Image, such as chaining together multiple filters to the cropped result, it may be more efficient to crop CIImage directly in the Core Image framework using the CICrop filter; in this case, use the convenience function cropped(to:).

如果你已经在使用 `CIImage`，或者你在 Core Image 中将图像作为 `CIImage` 数据进行后处理，比如将多个滤镜链在裁剪结果上，那么直接在 Core Image 框架中使用 `CICrop` 滤镜裁剪 `CIImage` 可能会更高效；在这种情况下，使用便利函数 [cropped(to:)](https://developer.apple.com/documentation/coreimage/ciimage/1437833-cropped)。

# See Also - 其他参考

## Creating Images by Modifying an Image - 通过修改图像创建图像

### [func masking(CGImage) -> CGImage?](https://developer.apple.com/documentation/coregraphics/cgimage/1456337-masking)

Creates a bitmap image from an existing image and an image mask.

从现有图像和图像蒙版创建位图图像。

### [func copy(maskingColorComponents: [CGFloat]) -> CGImage?](https://developer.apple.com/documentation/coregraphics/cgimage/1454358-copy)

Creates a bitmap image by masking an existing bitmap image with the provided color values.

通过使用提供的颜色值对现有的位图图像进行蒙版处理，创建一个位图图像。