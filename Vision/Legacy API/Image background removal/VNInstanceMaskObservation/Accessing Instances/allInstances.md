# allInstances

原文地址：[https://developer.apple.com/documentation/vision/vninstancemaskobservation/allinstances](https://developer.apple.com/documentation/vision/vninstancemaskobservation/allinstances)

The collection that contains all instances, excluding the background.

包含所有实例的集合（不含背景）。（注：实际上是 instanceLabel 的 Range，用于判断找到了几个主体，然后就可以从 1 开始往后遍历。）

> iOS 17.0+
iPadOS 17.0+
Mac Catalyst 17.0+
macOS 14.0+
tvOS 17.0+
visionOS 1.0+

```
var allInstances: IndexSet { get }
```

## See Also 其他参考

### Accessing Instances 访问实例

- var [allInstances](https://developer.apple.com/documentation/vision/vninstancemaskobservation/allinstances): IndexSet

	The collection that contains all instances, excluding the background.
	
	包含所有实例的集合（不含背景）。

- var [instanceMask](https://developer.apple.com/documentation/vision/vninstancemaskobservation/instancemask): CVPixelBuffer

	The resulting mask that represents all instances.
	
	表示所有实例的最终遮罩。
	
