# instanceMask

原文地址：[https://developer.apple.com/documentation/vision/vninstancemaskobservation/instancemask](https://developer.apple.com/documentation/vision/vninstancemaskobservation/instancemask)

The resulting mask that represents all instances.

表示所有实例的最终遮罩。

> iOS 17.0+
iPadOS 17.0+
Mac Catalyst 17.0+
macOS 14.0+
tvOS 17.0+
visionOS 1.0+

```
var instanceMask: CVPixelBuffer { get }
```

## Discussion 讨论

A pixel can only correspond to one instance. A `0` represents the background, and all other values represent the indices of the instances.

一个像素只能对应一个实例。`0` 代表背景，其他所有值代表实例的索引。

## See Also 其他参考

### Accessing Instances 访问实例

- var [allInstances](https://developer.apple.com/documentation/vision/vninstancemaskobservation/allinstances): IndexSet

	The collection that contains all instances, excluding the background.
	
	包含所有实例的集合（不含背景）。

- var [instanceMask](https://developer.apple.com/documentation/vision/vninstancemaskobservation/instancemask): CVPixelBuffer

	The resulting mask that represents all instances.
	
	表示所有实例的最终遮罩。