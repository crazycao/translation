# Emitter Render Order

原文地址：[https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_render_order](https://developer.apple.com/documentation/quartzcore/caemitterlayer/emitter_render_order)

These constants specify the order that emitter cells are composited. They are used by the [renderMode](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522104-rendermode) property.

这些常量指定了发射器单元的合成顺序。它们由 [renderMode](https://developer.apple.com/documentation/quartzcore/caemitterlayer/1522104-rendermode) 属性使用。

# Topics

## Constants

- static let unordered: CAEmitterLayerRenderMode

	Particles are rendered unordered. This mode uses source-over compositing.
	
	粒子的渲染是无序的。此模式使用 source-over 合成。
	
- static let oldestFirst: CAEmitterLayerRenderMode

	Particles are rendered oldest first. This mode uses source-over compositing.
	
	首先渲染最古老的粒子。此模式使用 source-over 合成。
	
- static let oldestLast: CAEmitterLayerRenderMode

	Particles are rendered oldest last. This mode uses source-over compositing.
	
	最后渲染最古老的粒子。此模式使用 source-over 合成。
	
- static let backToFront: CAEmitterLayerRenderMode

	Particles are rendered from back to front, sorted by z-position. This mode uses source-over compositing.
	
	粒子从后向前渲染，按z位置排序。此模式使用 source-over 合成。
	
- static let additive: CAEmitterLayerRenderMode

	The particles are rendered using source-additive compositing.

	粒子使用 source-additive 合成进行渲染。
