# generateScaledMaskForImage(forInstances:from:)

原文地址：[https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatescaledmaskforimage(forinstances:from:)](https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatescaledmaskforimage(forinstances:from:))

Creates a high-resolution mask where everything becomes transparent black, except for the instances you specify.

创建一个高分辨率遮罩，其中除指定实例外的所有内容均变为透明黑色。

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

## Return Value 返回值

The pixel buffer that contains the image.

包含图像的像素缓冲区。


