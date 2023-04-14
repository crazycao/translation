# CAEmitterCell

原文地址：[https://developer.apple.com/documentation/quartzcore/caemittercell](https://developer.apple.com/documentation/quartzcore/caemittercell)

> iOS 5.0+
iPadOS 5.0+
macOS 10.6+
Mac Catalyst 13.1+
tvOS 9.0+

The definition of a particle emitted by a `CAEmitterLayer`.

被 `CAEmitterLayer` 发射的粒子的定义。

## Declaration 声明

```
class CAEmitterCell : NSObject
```

## Overview 概览

The `CAEmitterCell` class represents one source of particles being emitted by a [CAEmitterLayer](https://developer.apple.com/documentation/quartzcore/caemitterlayer) object. An emitter cell defines the direction and properties of the emitted particles. Emitter cells can have an array of sub-cells, which lets the particles themselves emit particles.

`CAEmitterCell` 类表示由 [CAEmitterLayer](https://developer.apple.com/documentation/quartzcore/caemitterlayer) 对象发射的粒子的一个源。发射器单元定义被发射粒子的方向和属性。发射器单元可以有一个子单元数组，让粒子本身发射粒子。

# Topics 主题

## Providing Emitter Cell Content 提供发射器单元内容

- var [contents](https://developer.apple.com/documentation/quartzcore/caemittercell/1522109-contents): Any?

	An object that provides the contents of the layer. Animatable.
	
	提供图层的内容的对象。可设置动画。
	
- var [contentsRect](https://developer.apple.com/documentation/quartzcore/caemittercell/1522124-contentsrect): CGRect

	A rectangle (in the unit coordinate space) that specifies the portion of [contents](https://developer.apple.com/documentation/quartzcore/caemittercell/1522109-contents) that the receiver should draw. Animatable.
	
	指定接收器应该绘制 [contents](https://developer.apple.com/documentation/quartzcore/caemittercell/1522109-contents) 的哪个部分的矩形（在单位坐标空间中）。可设置动画。
	
- var [emitterCells](https://developer.apple.com/documentation/quartzcore/caemittercell/1521866-emittercells): [CAEmitterCell]?

	An optional array containing the sub-cells of this cell.
	
	包含该单元的子单元的数组。可选。

## Setting Emitter Cell Visual Attributes 设置发射器单元的可见属性

- var isEnabled: Bool

	A Boolean value indicating whether or not cells from this emitter are rendered.
	
	一个布尔值，指示是否渲染来自该发射器的单元。
	
- var color: CGColor?

	The color of each emitted object. Animatable.
	
	每个被发射的对象的颜色。可设置动画。
	
- var redRange: Float

	The amount by which the red color component of the cell can vary. Animatable.
	
	该单元中红色成分的变化范围。可设置动画。
	
- var greenRange: Float

	The amount by which the green color component of the cell can vary. Animatable.
	
	该单元中绿色成分的变化范围。可设置动画。

- var blueRange: Float

	The amount by which the blue color component of the cell can vary. Animatable.
	
	该单元中蓝色成分的变化范围。可设置动画。

- var alphaRange: Float

	The amount by which the alpha component of the cell can vary. Animatable.
	
	该单元中 alpha 成分的变化范围。可设置动画。
	
- var redSpeed: Float

	The speed, in seconds, at which the red color component changes over the lifetime of the cell. Animatable.
	
	红色成分在单元的寿命中的变化速度，以秒为单位。可设置动画。
	
- var greenSpeed: Float

	The speed, in seconds, at which the green color component changes over the lifetime of the cell. Animatable.
	
	绿色成分在单元的寿命中的变化速度，以秒为单位。可设置动画。
	
- var blueSpeed: Float

	The speed, in seconds, at which the blue color component changes over the lifetime of the cell. Animatable.
	
	蓝色成分在单元的寿命中的变化速度，以秒为单位。可设置动画。

- var alphaSpeed: Float

	The speed, in seconds, at which the alpha component changes over the lifetime of the cell. Animatable.
	
	alpha 成分在单元的寿命中的变化速度，以秒为单位。可设置动画。
	
- var magnificationFilter: String

	The filter used when increasing the size of the content.
	
	增加内容尺寸时使用的滤镜。
	
- var minificationFilter: String

	The filter used when reducing the size of the content.
	
	减少内容尺寸时使用的滤镜。
	
- var minificationFilterBias: Float

	The bias factor used by the minification filter to determine the levels of detail.
	
	给缩小滤镜用于确定详细程度的偏差因子。
	
- var scale: CGFloat

	Specifies the scale factor applied to the cell. Animatable.
	
	指定应用于单元的缩放因子。可设置动画。
	
- var scaleRange: CGFloat

	Specifies the range over which the scale value can vary. Animatable.
	
	指定 scale 值可变化的范围。可设置动画。
	
- var contentsScale: CGFloat

	The scale factor of the cell contents.
	
	单元内容的缩放因子。
	
- var name: String?

	The name of the cell.
	
	单元的名字。
	
- var style: [AnyHashable : Any]?

	An optional dictionary containing additional style values that are not explicitly defined by the receiver.
	
	一个可选字典，包含接收器未明确定义的其他样式值。

## Setting Emitter Cell Motion Attributes 设置发射器单元运动属性

- var spin: CGFloat

	The rotational velocity, measured in radians per second, to apply to the cell. Animatable.
	
	应用于 cell 的旋转速度，以弧度每秒为单位测量。可设置动画。
	
- var spinRange: CGFloat

	The amount by which the spin of the cell can vary over its lifetime. Animatable.
	
	cell 的旋转在其寿命内的变化范围。可设置动画。
	
- var emissionLatitude: CGFloat

	The latitudinal orientation of the emission angle. Animatable.
	
	发射角度的纬度方向。可设置动画。
	
- var emissionLongitude: CGFloat

	The longitudinal orientation of the emission angle. Animatable.
	
	发射角度的经度方向。可设置动画。
	
- var emissionRange: CGFloat

	The angle, in radians, defining a cone around the emission angle. Animatable.
	
	以弧度为单位的角度，定义一个围绕发射角度的圆锥体。可设置动画。
	
## Setting Emitter Cell Temporal Attributes 设置发射器单元时间属性

- var lifetime: Float

	The lifetime of the cell, in seconds. Animatable.
	
	cell 的寿命，以秒为单位。可设置动画。
	
- var lifetimeRange: Float

	The mean value by which the lifetime of the cell can vary. Animatable.
	
	cell 的寿命可变化的平均值。可设置动画。
	
- var birthRate: Float

	The number of emitted objects created every second. Animatable.
	
	每秒创建的发射对象的数量。可设置动画。
	
- var scaleSpeed: CGFloat

	The speed at which the scale changes over the lifetime of the cell. Animatable.
	
	cell 的生命周期内 scale 变化的速度。可设置动画。
	
- var velocity: CGFloat

	The initial velocity of the cell. Animatable.
	
	cell 的初始速度。可设置动画。
	
- var velocityRange: CGFloat

	The amount by which the velocity of the cell can vary. Animatable.
	
	cell 的速度的变化范围。可设置动画。
	
- var xAcceleration: CGFloat

	The x component of an acceleration vector applied to cell.
	
	应用于 cell 的加速度的 x 分量。
	
- var yAcceleration: CGFloat

	The y component of an acceleration vector applied to cell.
	
	应用于 cell 的加速度的 y 分量。
	
- var zAcceleration: CGFloat

	The z component of an acceleration vector applied to cell.
	
	应用于 cell 的加速度的 z 分量。

## Using Key-Value Coding Extensions 使用键值编码扩展

- class func defaultValue(forKey: String) -> Any?

	Returns the default value of the property with the specified key.
	
	返回指定 key 对应的属性的默认值。
	
- func shouldArchiveValue(forKey: String) -> Bool

	Returns a Boolean value indicating whether the value for a given key should be archived.

	返回一个布尔值，该值指示给定 key 的值是否要存档。

# Relationships 关系

## Inherits From 继承自

- [NSObject](https://developer.apple.com/documentation/objectivec/nsobject)

## Conforms To 遵从

- [CAMediaTiming](https://developer.apple.com/documentation/quartzcore/camediatiming)
- [NSSecureCoding](https://developer.apple.com/documentation/foundation/nssecurecoding)

# See Also 其他参考

## Particle Systems 粒子系统

- class [CAEmitterLayer](https://developer.apple.com/documentation/quartzcore/caemitterlayer)

	A layer that emits, animates, and renders a particle system.

	发射、设置动画和渲染粒子系统的图层。










