# VNInstanceMaskObservation

原文地址：[https://developer.apple.com/documentation/vision/vninstancemaskobservation](https://developer.apple.com/documentation/vision/vninstancemaskobservation)

An observation that contains an instance mask that labels instances in the mask.

一个包含实例遮罩的观测结果，已经对遮罩中的实例加了标签。

> iOS 17.0+
iPadOS 17.0+
Mac Catalyst 17.0+
macOS 14.0+
tvOS 17.0+
visionOS 1.0+

```
class VNInstanceMaskObservation
```


## Topics

### Accessing Instances 访问实例

- var [allInstances](https://developer.apple.com/documentation/vision/vninstancemaskobservation/allinstances): IndexSet

	The collection that contains all instances, excluding the background.
	
	包含所有实例的集合（不含背景）。

- var [instanceMask](https://developer.apple.com/documentation/vision/vninstancemaskobservation/instancemask): CVPixelBuffer

	The resulting mask that represents all instances.
	
	表示所有实例的最终遮罩。

### Creating a Mask 创建遮罩

- func generateMask(forInstances: IndexSet) throws -> CVPixelBuffer

	Creates a low-resolution mask from the instances you specify.

- func generateMaskedImage(ofInstances: IndexSet, from: VNImageRequestHandler, croppedToInstancesExtent: Bool) throws -> CVPixelBuffer

	Creates a high-resolution image where everything becomes transparent black, except for the instances you specify.

- func generateScaledMaskForImage(forInstances: IndexSet, from: VNImageRequestHandler) throws -> CVPixelBuffer

	Creates a high-resolution mask where everything becomes transparent black, except for the instances you specify.
