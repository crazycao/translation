# CAEmitterLayer

原文地址：[https://developer.apple.com/documentation/quartzcore/caemitterlayer](https://developer.apple.com/documentation/quartzcore/caemitterlayer)

> iOS 5.0+
iPadOS 5.0+
macOS 10.6+
Mac Catalyst 13.1+
tvOS 9.0+

A layer that emits, animates, and renders a particle system.

发射、设置动画和渲染粒子系统的图层。

## Declaration 声明

```
class CAEmitterLayer : CALayer
```

## Overview 概览

The particles, defined by instances of [CAEmitterCell](https://developer.apple.com/documentation/quartzcore/caemittercell), are drawn above the layer’s background color and border.

由 [CAEmitterCell](https://developer.apple.com/documentation/quartzcore/caemittercell) 实例定义的粒子绘制在图层的背景色和边界的上方。

Listing 1 shows how to set up a simple point (the default [emitterShape](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521919-emittershape) is [point](https://developer.apple.com/documentation/quartzcore/caemitterlayeremittershape/1522188-point)) particle emitter. It uses an image named `RadialGradient.png` as the cell contents and, by setting the emitter cell's [emissionRange](https://developer.apple.com/documentation/quartzcore/caemittercell/1521847-emissionrange) to `2 x pi`, the particles are emitted in all directions.

代码1 显示了如何设置一个简单的点（默认的 [发射器形状](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521919-emittershape) 是 [点](https://developer.apple.com/documentation/quartzcore/caemitterlayeremittershape/1522188-point)）粒子发射器。它使用名为 `RadialGradient.png` 的图像作为单元内容，通过将发射器单元的 [emissionRange](https://developer.apple.com/documentation/quartzcore/caemittercell/1521847-emissionrange) 设置为 `2 x pi`，粒子就可以向所有方向发射。

**Listing 1** Creating a simple particle system **代码 1** 创建简单粒子系统

```
let emitterLayer = CAEmitterLayer()
    
emitterLayer.emitterPosition = CGPoint(x: 320, y: 320)
    
let cell = CAEmitterCell()
cell.birthRate = 100
cell.lifetime = 10
cell.velocity = 100
cell.scale = 0.1
    
cell.emissionRange = CGFloat.pi * 2.0
cell.contents = UIImage(named: "RadialGradient.png")!.cgImage
    
emitterLayer.emitterCells = [cell]
    
view.layer.addSublayer(emitterLayer)
```

# Topics 主题

## Specifying Particle Emitter Cells 指定粒子发射器单元

- var [emitterCells](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521923-emittercells): [CAEmitterCell]?

	The array emitter cells attached to the layer.

	添加到图层上的发射器单元数组。

## Emitter Geometry 发射器几何体

- var [renderMode](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522104-rendermode): CAEmitterLayerRenderMode

	Defines how particle cells are rendered into the layer.
	
	定义粒子单元如何渲染到图层上。

- var [emitterPosition](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522289-emitterposition): CGPoint

	The position of the center of the particle emitter. Animatable.
	
	粒子发射器的中心点位置。可设置动画。
	
- var [emitterShape](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521919-emittershape): CAEmitterLayerEmitterShape

	Specifies the emitter shape.
	
	指定发射器形状。
	
- var [emitterZPosition](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522169-emitterzposition): CGFloat

	Specifies the center of the particle emitter shape along the z-axis. Animatable.
	
	指定粒子发射器形状在 z 轴上的中心点。可设置动画。
	
- var [emitterDepth](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521844-emitterdepth): CGFloat

	Determines the depth of the emitter shape.
	
	定义发射器形状的深度。
	
- var [emitterSize](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521869-emittersize): CGSize

	Determines the size of the particle emitter shape. Animatable.
	
	定义粒子发射器形状的大小。可设置动画。
	
## Emitter Cell Attribute Multipliers 发射器单元属性因子

Emitter cell attribute multipliers only affect newly created particles, leaving existing particles unchanged.

发射器单元属性因子仅影响新创建的粒子，而保持现有粒子不变。

For example, if your emitter has its scale multiplier set to 1 (the default) and, after it has emitted a number of particles, your code sets it to 2, particles already on screen are unaffected and remain the same size. Only newly spawned particles will be affected by the change and appear twice as large as their siblings.

例如，如果发射器的缩放倍数设置为1（默认值），并且在发射了多个粒子后，代码将其设置为2，则屏幕上已经存在的粒子将不受影响，并保持相同的大小。只有新产生的粒子才会受到更改的影响，并且看起来是其兄弟粒子的两倍大。

- var [scale](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521841-scale): Float

	Defines a multiplier applied to the cell-defined particle scale.
	
	定义应用于按单元定义的粒子的比例因子。
	
- var [seed](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522079-seed): UInt32

	Specifies the seed used to initialize the random number generator.
	
	指定用于初始化随机数生成器的种子。
	
- var [spin](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521861-spin): Float

	Defines a multiplier applied to the cell-defined particle spin. Animatable.
	
	定义应用于按单元定义的粒子的旋转因子。可设置动画。
	
- var [velocity](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522015-velocity): Float

	Defines a multiplier applied to the cell-defined particle velocity. Animatable.
	
	定义应用于按单元定义的粒子的速度因子。可设置动画。
	
- var [birthRate](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521976-birthrate): Float

	Defines a multiplier that is applied to the cell-defined birth rate. Animatable.
	
	定义应用于按单元定义的粒子的出生率因子。可设置动画。

- var [emitterMode](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522128-emittermode): CAEmitterLayerEmitterMode

	Specifies the emitter mode.
	
	指定发射器模式。
	
- var [lifetime](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522144-lifetime): Float

	Defines a multiplier applied to the cell-defined lifetime range when particles are created. Animatable.
	
	定义创建粒子时应用于按单元定义的粒子的寿命范围因子。可设置动画。
	
- var [preservesDepth](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521872-preservesdepth): Bool

	Defines whether the layer flattens the particles into its plane.
	
	定义图层是否将粒子展平到其平面中。


## Constants 常量

- [Emitter Shape](https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_shape) 

	The emission shape is a one, two or three dimensional shape that defines where the emitted particles originate. The shapes are defined by a subset of `emitterPosition`, `emitterZPosition`, `emitterSize` and `emitterDepth` properties.

	发射出的形状是一维、二维或三维形状，用于定义发射粒子的来源。形状由 `emitterPosition`、`emitterZPosition`，`emitterSize` 和 `emitterDepth` 属性的子集定义。

- [Emitter Modes](https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_modes)

	These constants specify the possible emitter modes. They are used by the `emitterMode` property.
	
	这些常量指定可能的发射器模式。它们由 `emitterMode` 属性使用。
	
- [Emitter Render Order](https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_render_order)

	These constants specify the order that emitter cells are composited. They are used by the `renderMode` property.
	
	这些常量指定发射器单元的合成顺序。它们由 `renderMode` 属性使用。


# Relationships 关系

## Inherits From 继承自

- [CALayer](https://developer.apple.com/documentation/quartzcore/calayer)

# See Also 其他参考

## Particle Systems 粒子系统

- class [CAEmitterCell](https://developer.apple.com/documentation/quartzcore/caemittercell)

	The definition of a particle emitted by a `CAEmitterLayer`.
	
	被 `CAEmitterLayer` 发射的粒子的定义。










