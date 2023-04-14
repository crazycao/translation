# emitterCells

原文地址：[https://developer.apple.com/documentation/quartzcore/caemittercell/1521866-emittercells](https://developer.apple.com/documentation/quartzcore/caemittercell/1521866-emittercells)

> iOS 5.0+
iPadOS 5.0+
macOS 10.6+
Mac Catalyst 13.1+
tvOS 9.0+

An optional array containing the sub-cells of this cell.

包含该单元的子单元的可选数组。

## Declaration 声明

```
var emitterCells: [CAEmitterCell]? { get set }
```

## Discussion 讨论

When specified, each particle emitted by the cell acts as an emitter for each of the cell's sub-cells. The emission point is the current particle position and the emission angle is relative to the current direction of the particle.

当该属性被指定时，单元发射的每个粒子都会充当子单元的发射器。发射点是当前粒子的位置，发射角度是相对于粒子的当前方向。

The default value of this property is `nil`.

该属性的默认值为 `nil`。

The following code shows how you can create a firework style effect using sub-cells. The `fireworkCell` has an emission longitude of one quarter turn anti-clockwise to emit particles upwards. It emits `trailCell` instances which have a slight [yAcceleration](https://developer.apple.com/documentation/quartzcore/caemittercell/1522077-yacceleration) that simulates gravity.

下面的代码显示了如何使用子单元创建焰火样式的效果。`fireworkCell` 的发射经度为逆时针四分之一圈，以向上发射粒子。它发射 `trailCell` 实例，这些实例具有模拟重力的轻微 [yAcceleration](https://developer.apple.com/documentation/quartzcore/caemittercell/1522077-yacceleration)。

Note that the scale and color of `fireworkCell` are inherited by `trailCell`.

请注意，`fireworkCell` 的比例和颜色由 `trailCell` 继承。

**Listing 1** Creating particle trails **代码 1** 创建粒子轨迹

```
let image = UIImage(named: "RadialGradient.png")!.cgImage
    
let emitterLayer = CAEmitterLayer()
    
emitterLayer.emitterPosition = CGPoint(x: 512, y: 512)
    
let fireworkCell = CAEmitterCell()
fireworkCell.color = UIColor.red.cgColor
fireworkCell.birthRate = 3
fireworkCell.lifetime = 10
fireworkCell.velocity = 100
fireworkCell.scale = 0.05
fireworkCell.emissionLongitude = -CGFloat.pi * 0.5
fireworkCell.emissionRange = -CGFloat.pi * 0.25
fireworkCell.contents = image
    
let trailCell = CAEmitterCell()
trailCell.yAcceleration = 20
trailCell.birthRate = 10
trailCell.lifetime = 3
trailCell.contents = image
    
fireworkCell.emitterCells = [trailCell]
emitterLayer.emitterCells = [fireworkCell]
    
view.layer.addSublayer(emitterLayer)
```

# See Also 其他参考

## Providing Emitter Cell Content 提供发射器单元内容

- var [contents](https://developer.apple.com/documentation/quartzcore/caemittercell/1522109-contents): Any?

	An object that provides the contents of the layer. Animatable.
	
	提供图层的内容的对象。可设置动画。
	
- var [contentsRect](https://developer.apple.com/documentation/quartzcore/caemittercell/1522124-contentsrect): CGRect

	A rectangle (in the unit coordinate space) that specifies the portion of [contents](https://developer.apple.com/documentation/quartzcore/caemittercell/1522109-contents) that the receiver should draw. Animatable.
	
	指定接收器应该绘制 [contents](https://developer.apple.com/documentation/quartzcore/caemittercell/1522109-contents) 的哪个部分的矩形（在单位坐标空间中）。可设置动画。
	
- var [emitterCells](https://developer.apple.com/documentation/quartzcore/caemittercell/1521866-emittercells): [CAEmitterCell]?

	An optional array containing the sub-cells of this cell.
	
	包含该单元的子单元的可选数组。










