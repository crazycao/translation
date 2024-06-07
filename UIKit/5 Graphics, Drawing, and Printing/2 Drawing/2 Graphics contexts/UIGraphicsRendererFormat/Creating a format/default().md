# default()

原文地址：
[https://developer.apple.com/documentation/uikit/uigraphicsrendererformat](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat)

Returns a format that represents the highest fidelity that the current device supports.

返回一个格式，该格式代表当前设备支持的最高保真度。

> iOS 10.0+
iPadOS 10.0+
Mac Catalyst 13.1+
tvOS 10.0–11.0 Deprecated
visionOS 1.0+

```
class func `default`() -> Self
```

## Return Value

An initialized format.

一个已经初始化好的格式。

## Discussion

The returned format object always represents the device's highest fidelity, regardless of the actual fidelity currently employed by the device. A graphics renderer uses this method to create a format at initialization time if you use an initializer that does not have a format argument.

返回的格式对象总是代表设备的最高保真度，无论设备当前实际使用的保真度如何。如果你使用的初始化器没有格式参数，图形渲染器会在初始化时使用此方法创建一个格式。

This property doesn't always return a format that's optimized for the current configuration of the main screen. If you're rendering content for immediate display, it's recommended that you use [preferred()](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/2928214-preferred) instead of this property.

此属性并不总是返回一个针对主屏幕当前配置优化的格式。如果你正在渲染用于立即显示的内容，建议你使用 [preferred()](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/2928214-preferred) 方法，而不是这个属性。

# See Also - 其他参考
## Creating a format - 创建一个格式

### [class func preferred() -> Self](https://developer.apple.com/documentation/uikit/uigraphicsrendererformat/2928214-preferred)

Returns the most suitable format for the main screen’s current configuration.

返回最适合主屏幕当前配置的格式。