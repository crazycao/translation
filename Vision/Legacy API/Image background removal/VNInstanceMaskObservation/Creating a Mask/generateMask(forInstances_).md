# generateMask(forInstances:)

原文地址：[https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatemask(forinstances:)](https://developer.apple.com/documentation/vision/vninstancemaskobservation/generatemask(forinstances:))

Creates a low-resolution mask from the instances you specify.

根据你指定的实例创建低分辨率的遮罩。

> iOS 17.0+
iPadOS 17.0+
Mac Catalyst 17.0+
macOS 14.0+
tvOS 17.0+
visionOS 1.0+

```
func generateMask(forInstances instances: IndexSet) throws -> CVPixelBuffer
```

## Parameters 参数

- instances

	The collection of instances.
	
	实例的集合

## Return Value 返回值

The pixel buffer that contains the image.

包含图像的像素缓冲区。


