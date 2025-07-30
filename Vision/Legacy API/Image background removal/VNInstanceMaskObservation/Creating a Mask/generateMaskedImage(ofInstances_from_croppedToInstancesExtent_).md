# generateMaskedImage(ofInstances:from:croppedToInstancesExtent:)

原文地址：[https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatemaskedimage(ofinstances:from:croppedtoinstancesextent:)](https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatemaskedimage(ofinstances:from:croppedtoinstancesextent:))

Creates a high-resolution image where everything becomes transparent black, except for the instances you specify.

创建一张高分辨率图像，其中除指定实例外的所有内容均变为透明黑色。

> iOS 17.0+
iPadOS 17.0+
Mac Catalyst 17.0+
macOS 14.0+
tvOS 17.0+
visionOS 1.0+

```
func generateMaskedImage(
    ofInstances instances: IndexSet,
    from requestHandler: VNImageRequestHandler,
    croppedToInstancesExtent cropResult: Bool
) throws -> CVPixelBuffer
```

## Parameters 参数

- **instances**

	The collection of instances.
	
	实例的集合
	
- **requestHandler**

	The image request callback.
	
	图像请求回调。

- **cropResult**

	A Boolean value that indicates whether to crop the image to the smallest rectangle that contains all instances.
	
	一个布尔值，用于指示是否将图像裁剪为包含所有实例的最小矩形。

## Return Value 返回值

The pixel buffer that contains the image.

包含图像的像素缓冲区。


