# Emitter Shape

原文地址：[https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_shape](https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_shape)

The emission shape is a one, two or three dimensional shape that defines where the emitted particles originate. The shapes are defined by a subset of [emitterPosition](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522289-emitterposition), [emitterZPosition](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522169-emitterzposition), [emitterSize](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521869-emittersize) and [emitterDepth](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521844-emitterdepth) properties.

发射形状是一种一维、二维或三维形状，用于定义发射粒子的来源。形状由 [emitterPosition](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522289-emitterposition)、[emitterZPosition](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522169-emitterzposition)，[emitterSize](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521869-emittersize) 和 [emitterDepth](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1521844-emitterdepth) 属性的子集定义。

# Topics

## Constants

- static let point: CAEmitterLayerEmitterShape

	Particles are emitted from a single point at `(emitterPosition.x, emitterPosition.y, emitterZPosition)`.
	
	粒子从位于 `(emitterPosition.x, emitterPosition.y, emitterZPosition)` 处的单个点发射。
	
- static let line: CAEmitterLayerEmitterShape

	Particles are emitted along a line from `(emitterPosition.x - emitterSize.width/2, emitterPosition.y, emitterZPosition)` to `(emitterPosition.x + emitterSize.width/2, emitterPosition.y, emitterZPosition)`.
	
	粒子沿着从 `(emitterPosition.x - emitterSize.width/2, emitterPosition.y, emitterZPosition)` 到 `(emitterPosition.x + emitterSize.width/2, emitterPosition.y, emitterZPosition)` 的直线发射。
	
- static let rectangle: CAEmitterLayerEmitterShape

	Particles are emitted from a rectangle with opposite corners `[emitterPosition.x - emitterSize.width/2, emitterPosition.y - emitterSize.height/2, emitterZPosition]`, `[emitterPosition.x + emitterSize.width/2, emitterPosition.y + emitterSize.height/2, emitterZPosition]`.
	
	粒子从以 `[emitterPosition.x-emitterSize.width/2, emitterPosition.y-emitterSize.height/2, emiterZPosition]`，`[emitterPosition.x+emitterSize.width/2, emitterPosition.y+emitterSize.height/2, emiterZPposition]` 为对角的矩形发射。
	
- static let cuboid: CAEmitterLayerEmitterShape

	Particles are emitted from a cuboid (3D rectangle) with opposite corners: `[emitterPosition.x - emitterSize.width/2, emitterPosition.y - emitterSize.height/2, emitterZPosition - emitterDepth/2]`, `[emitterPosition.x + emitterSize.width/2, emitterPosition.y + emitterSize.height/2, emitterZPosition+emitterDepth/2]`.
	
	粒子从以 `[emitterPosition.x-emitterSize.width/2，emitterPosition.y-emitterSize.height/2，emiterZPosition-emitterDepth/2]`，`[emitterPosition.x+emitterSize.width/2、emitterPosition.y+emitterSize.height-2，emitterZPosition+emitterDepth/2]` 为相反角的长方体（3D矩形）发射。
	
- static let circle: CAEmitterLayerEmitterShape

	Particles are emitted from a circle centered at `(emitterPosition.x, emitterPosition.y, emitterZPosition)` of radius `emitterSize.width`.
	
	粒子从以 `emitterSize.width` 为半径、以 `(emitterPosition.x, emitterPosition.y, emitterZPosition)` 为圆心的圆发射。
	
- static let sphere: CAEmitterLayerEmitterShape

	Particles are emitted from a sphere centered at `(emitterPosition.x, emitterPosition.y, emitterZPosition)` of radius `emitterSize.width`.

	粒子从以 `emitterSize.width` 为半径、以 `(emitterPosition.x, emitterPosition.y, emitterZPosition)` 为中心的球体发射。








