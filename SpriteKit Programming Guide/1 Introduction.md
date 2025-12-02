# About SpriteKit 关于 SpriteKit

原文地址：[https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013043-CH1-SW1](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013043-CH1-SW1)

> **Important** This document is retired because the content has been migrated to SpriteKit reference.
>
> **重要提示**：本文档已被弃用，其内容已迁移至 SpriteKit 参考文档。

SpriteKit provides a graphics rendering and animation infrastructure that you can use to animate arbitrary textured images, or _sprites_. SpriteKit uses a traditional rendering loop where the contents of each frame are processed before the frame is rendered. Your game determines the contents of the scene and how those contents change in each frame. SpriteKit does the work to render frames of animation efficiently using the graphics hardware. SpriteKit is optimized so that the positions of sprites can be changed arbitrarily in each frame of animation.

SpriteKit 提供了一个图形渲染和动画基础结构，你可以用它来为任意带有纹理的图片（或称为“_精灵_”）制作动画。SpriteKit 使用传统的渲染循环，每一帧的内容在渲染之前都会被处理。你的游戏决定了场景的内容以及每一帧中这些内容如何变化。SpriteKit 利用图形硬件高效地渲染动画帧。SpriteKit 经过优化，可以让你在每一帧中任意改变精灵的位置。

SpriteKit also provides other functionality that is useful for games, including basic sound playback support and physics simulation. In addition, Xcode provides built-in support for SpriteKit so that you can create complex special effects and texture atlases directly in Xcode. This combination of framework and tools makes SpriteKit a good choice for games and other apps that require similar kinds of animation. For other kinds of user-interface animation, use Core Animation instead.

SpriteKit 还提供了其他对游戏有用的功能，包括基础的声音播放支持和物理仿真功能。此外，Xcode 原生支持 SpriteKit，因此你可以直接在 Xcode 中创建复杂的特效和纹理图集。框架和工具的结合使得 SpriteKit 成为游戏及其他需要类似动画效果应用的良好选择。如果需要制作其他类型的用户界面动画，应该使用 Core Animation。

> **Important**: This is a preliminary document that includes descriptions of OS X technology in development. This information is subject to change, and software implemented according to this document should be tested with final operating system software and final documentation.
>
> **重要提示**：本文件为初步文档，包含了关于正在开发中的 OS X 技术的描述。这些信息可能会发生变化，根据本文件开发的软件应在正式版的操作系统和最终文档下进行测试。

![../Art/update_loop_2x.png](./images/update_loop_2x.png)

# 1 At a Glance 

SpriteKit is available on iOS and OS X. It uses the graphics hardware available on the hosting device to composite 2D images at high frame rates. SpriteKit supports many different kinds of content, including:

SpriteKit 可用于 iOS 和 OS X。它利用宿主设备上的图形硬件以高帧率合成 2D 图像。SpriteKit 支持多种不同类型的内容，包括：

- Untextured or textured rectangles (sprites)
- Text
- Arbitrary CGPath-based shapes
- Video

- 无纹理或带纹理的矩形（精灵）
- 文本
- 任意基于 CGPath 的形状
- 视频

SpriteKit also provides support for cropping and other special effects; you can apply these effects to all or a portion of your content. You can animate or change these elements in each frame. You can also attach physics bodies to these elements so that they properly support forces and collisions.

SpriteKit 还支持裁剪和其他特效；你可以将这些效果应用于全部或部分内容。你可以在每一帧中为这些元素制作动画或改变它们。你还可以为这些元素添加物理体，使它们能够正确支持力和碰撞。

Because SpriteKit supports a rich rendering infrastructure and handles all of the low-level work to submit drawing commands to OpenGL, you can focus your efforts on solving higher-level design problems and creating great gameplay.

由于 SpriteKit 提供了丰富的渲染基础设施，并且处理了所有底层向 OpenGL 提交绘图命令的工作，你可以将精力集中在解决更高层次的设计问题和创造出色的游戏体验上。

## 1.1 Sprite Content is Drawn by Presenting Scenes Inside a Sprite View 精灵内容通过在精灵视图中呈现场景来绘制

Animation and rendering is performed by an `SKView` object. You place this view inside a window, then render content to it. Because it is a view, its contents can be combined with other views in the view hierarchy.

由 `SKView` 对象执行动画和渲染。你可以将此视图放在窗口中，然后渲染内容到它上面。由于它是一个视图，它的内容可以与视图层级中的其他视图结合在一起。

Content in your game is organized into scenes, which are represented by `SKScene` objects. A scene holds sprites and other content to be rendered. A scene also implements per-frame logic and content processing. At any given time, the view presents one scene. As long as a scene is presented, its animation and per-frame logic are automatically executed.

你的游戏中的内容被组织到场景中，每个场景由 `SKScene` 对象表示。一个场景包含需要渲染的精灵和其他内容。场景还实现了每帧的逻辑和内容处理。在任何时刻，视图都只展示一个场景。只要场景被展示，其动画和每帧的逻辑就会被自动执行。

To create a game using SpriteKit, you either subclasses the `SKScene` class or create a scene delegate to perform major game-related tasks. For example, you might create separate scene classes to display a main menu, the gameplay screen, and content displayed after the game ends. You can easily use a single `SKView` object in your window and switch between different scenes. When you switch scenes, you can use the `SKTransition` class to animate between the two scenes.

使用 SpriteKit 创建游戏时，你可以继承 `SKScene` 类或者创建一个场景委托来执行主要的游戏相关任务。例如，你可以创建不同的场景类来显示主菜单、游戏画面以及游戏结束后展示的内容。你可以很方便地在窗口中只用一个 `SKView` 对象，并在不同场景间切换。当你切换场景时，可以使用 `SKTransition` 类在两个场景之间添加动画过渡效果。

> **Relevant Chapters**: [Jumping into SpriteKit](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/GettingStarted/GettingStarted.html#//apple_ref/doc/uid/TP40013043-CH2-SW1), [SpriteKit Best Practices](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/DesigningGameswithSpriteKit/DesigningGameswithSpriteKit.html#//apple_ref/doc/uid/TP40013043-CH7-SW1)
>
>相关章节：《[SpriteKit 入门](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/GettingStarted/GettingStarted.html#//apple_ref/doc/uid/TP40013043-CH2-SW1)》，《[SpriteKit 最佳实践](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/DesigningGameswithSpriteKit/DesigningGameswithSpriteKit.html#//apple_ref/doc/uid/TP40013043-CH7-SW1)》


## 1.2 A Node Tree Defines What Appears in a Scene 节点树定义了场景中显示的内容

The `SKScene` class is a descendant of the `SKNode` class. When using SpriteKit, nodes are the fundamental building blocks for all content, with the scene object acting as the root node for a tree of node objects. The scene and its descendants determine which content is drawn and how it is rendered.

`SKScene` 类是 `SKNode` 类的子类。在使用 SpriteKit 时，节点是所有内容的基本构建单元，而场景对象作为节点树的根节点。场景及其子节点共同决定了哪些内容被绘制以及如何渲染。

Each node’s position is specified in the coordinate system defined by its parent. A node also applies other properties to its content and the content of its descendants. For example, when a node is rotated, all of its descendants are rotated also. You can build a complex image using a tree of nodes and then rotate, scale, and blend the entire image by adjusting the topmost node’s properties.

每个节点的位置都是在其父节点定义的坐标系统中指定的。一个节点还会将其它属性应用于自身内容及其所有子节点。例如，当一个节点被旋转时，它的所有子节点也会跟着一起旋转。你可以使用节点树来构建复杂的图像，并通过调整最上层节点的属性，实现整个图像的旋转、缩放以及混合等操作。

The `SKNode` class does not draw anything, but it applies its properties to its descendants. Each kind of drawable content is represented by a distinct subclass in SpriteKit. Some other node subclasses do not draw content of their own, but modify the behavior of their descendants. For example, you can use an `SKEffectNode` object to apply a Core Image filter to an entire subtree in the scene. By precisely controlling the structure of the node tree, you determine the order in which nodes are rendered.

`SKNode` 类本身不绘制任何内容，但会将自身属性应用给它的子节点。SpriteKit 中的每种可绘制内容，都由其特定的子类表示。有些节点子类本身不绘制内容，而是通过修改其子节点的行为来实现。例如，`SKEffectNode` 对象可以对场景中的整个子树应用 Core Image 滤镜。通过精确控制节点树的结构，你可以决定节点的渲染顺序。

All node objects are responder objects, descending either from `UIResponder` or `NSResponder`, so you can subclass any node class and create new classes that accept user input. The view class automatically extends the responder chain to include the scene’s node tree.

所有的节点对象都是响应者对象，继承自 `UIResponder` 或 `NSResponder`，因此你可以对任意节点类进行子类化，以创建可以响应用户输入的新类。视图类会自动扩展响应链，将场景的节点树包含在内。

> Relevant Chapters: [Working with Sprites](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Sprites/Sprites.html#//apple_ref/doc/uid/TP40013043-CH9-SW8), [Building Your Scene](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Nodes/Nodes.html#//apple_ref/doc/uid/TP40013043-CH3-SW1)
>
> 相关章节：《[使用精灵](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Sprites/Sprites.html#//apple_ref/doc/uid/TP40013043-CH9-SW8)》，《[构建你的场景](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Nodes/Nodes.html#//apple_ref/doc/uid/TP40013043-CH3-SW1)》

## 1.3 Textures Hold Reusable Graphical Data 纹理保存可复用的图像数据

Textures are shared images used to render sprites. Always use textures whenever you need to apply the same image to multiple sprites. Usually you create textures by loading image files stored in your app bundle. However, SpriteKit can also create textures for you at runtime from other sources, including Core Graphics images or even by rendering a node tree into a texture.

纹理是用于渲染精灵的共享图片。当你需要将同一图片应用于多个精灵时，应始终使用纹理。通常，你可以通过加载应用包内的图片文件创建纹理。但 SpriteKit 也能在运行时通过其他来源来为你创建纹理，包括 Core Graphics 图片甚至通过将节点树渲染为一个纹理。

SpriteKit simplifies texture management by handling the lower-level code required to load textures and make them available to the graphics hardware. Texture management is automatically managed by SpriteKit. However, if your game uses a large number of images, you can improve its performance by taking control of parts of the process. Primarily, you do this by telling SpriteKit explicitly to load a texture.

SpriteKit 通过处理加载纹理和让图像硬件可用所需的底层代码，简化了纹理管理。纹理管理由 SpriteKit 自动处理。不过，如果你的游戏用到了大量图片，你可以主动控制部分流程来提升性能。主要方式是，显式的让 SpriteKit 加载纹理。

A _texture atlas_ is a group of related textures that are used together in your game. For example, you might use a texture atlas to store all of the textures needed to animate a character or all of the tiles needed to render the background of a gameplay level. SpriteKit uses texture atlases to improve rendering performance.

_纹理图集_ 是一组相关联的纹理，通常在游戏中一起使用。例如，你可以使用纹理图集来存储某个角色动画所需的全部纹理，或是某一关背景所需的所有图块。SpriteKit 通过使用纹理图集提升渲染性能。

> Relevant Chapters: [Working with Sprites](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Sprites/Sprites.html#//apple_ref/doc/uid/TP40013043-CH9-SW8)
>
> 相关章节：《[使用精灵](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Sprites/Sprites.html#//apple_ref/doc/uid/TP40013043-CH9-SW8)》

## 1.4 Nodes Execute Actions to Animate Content 节点通过执行动作来实现内容动画

A scene’s contents are animated using _actions_. Every action is an object, defined by the `SKAction` class. You tell nodes to execute actions. Then, when the scene processes frames of animation, the actions are executed. Some actions are completed in a single frame of animation, while other actions apply changes over multiple frames of animation before completing. The most common use for actions is to animate changes to the node’s properties. For example, you can create actions that move a node, scale or rotate it, or make it transparent. However, actions can also change the node tree, play sounds, or even execute custom code.

场景的内容通过 _动作_ 来实现动画。每个动作都是一个由 `SKAction` 类定义的对象。你可以让节点执行某个动作，然后在场景处理每一帧动画时，这些动作就会被依次执行。有些动作会在一帧内完成，而有些则会跨多帧生效。最常用的场景是动画化节点属性的变化，例如可以创建移动、缩放、旋转或透明化节点的动作。此外，动作还能改变节点树结构、播放音效，甚至运行自定义代码等。

Actions are very useful, but you can also combine actions to create more complex effects. You can create groups of actions that run simultaneously or sequences where actions run sequentially. You can cause actions to automatically repeat.

动作非常实用，而且你还可以将它们组合，形成更复杂的效果。你可以让一组动作同时进行，也可以让一系列动作顺序依次执行。还可以让动作自动循环。

Scenes can also perform custom per-frame processing. You override the methods of your scene subclass to perform additional game tasks. For example, if a node needs to be moved every frame, you might adjust its properties directly every frame instead of using an action to do so.

场景还可以执行自定义的逐帧处理。你可以重写场景子类中的方法，以完成其他游戏相关任务。例如，当某个节点每帧都需要移动时，你可以直接在每一帧修改它的属性，而不是用动作来完成。

> Relevant Chapters: [Adding Actions to Nodes](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/AddingActionstoSprites/AddingActionstoSprites.html#//apple_ref/doc/uid/TP40013043-CH11-SW1), [Advanced Scene Processing](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Actions/Actions.html#//apple_ref/doc/uid/TP40013043-CH4-SW1)
>
> 相关章节：《[向节点添加动作](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/AddingActionstoSprites/AddingActionstoSprites.html#//apple_ref/doc/uid/TP40013043-CH11-SW1)》，《[高级场景处理](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Actions/Actions.html#//apple_ref/doc/uid/TP40013043-CH4-SW1)》

## 1.5 Add Physics Bodies and Joints to Simulate Physics in Your Scene 为场景添加物理体和关节以模拟物理效果

Although you can control the exact position of every node in the scene, often you want these nodes to interact with each other, colliding with each other and imparting velocity changes in the process. You might also want to do things that are not handled by the action system, such as simulating gravity and other forces. To do this, you create physics bodies (`SKPhysicsBody`) and attach them to nodes in your scene. Each physics body is defined by shape, size, mass, and other physical characteristics. The scene defines global characteristics for the physics simulation in an attached `SKPhysicsWorld` object. You use the physics world to define gravity for the entire simulation, and to define the speed of the simulation.

尽管你可以精确控制场景中每个节点的位置，但通常你还希望这些节点能彼此交互、碰撞并改变速度。有时你还希望实现动作系统无法处理的物理效果，比如重力或其他外力。要实现这些，你可以创建物理体（`SKPhysicsBody`）并将其附加到节点上。每个物理体由形状、大小、质量和其它物理属性决定。场景通过关联的 `SKPhysicsWorld` 对象定义全局物理模拟属性，比如为整个物理世界模拟设置重力和速度。

When physics bodies are included in the scene, the scene simulates physics on those bodies. Some forces, such as friction and gravity, are applied automatically. Other forces can be applied automatically to multiple physics bodies by adding `SKFieldNode` objects to the scene. You can also directly affect a specific field body by modifying its velocity directly or by applying forces or impulses directly to it. The acceleration and velocity of each body is computed and the bodies collide with each other. Then, after the simulation is complete, the positions and rotations of the corresponding nodes are updated.

当场景中包含物理体时，场景会对这些物理体进行物理模拟。一些力，比如摩擦力、重力，会自动施加到物理体上。你也可以通过在场景中添加 `SKFieldNode` 对象，将其他的力自动作用到多个物理体上。你还可以通过直接修改物理体的速度，或直接施加力或冲量，从而直接控制指定物理体。每个物理体的加速度和速度都会被计算，物理体之间也会发生碰撞。然后，在模拟完成之后，节点的位置和旋转角度就会自动更新。

You have precise control over which physics effects interact with each other. For example, you can that a particular physics field node only affects a subset of the physics bodies in the scene. You also decide which physics bodies can collide with each other and separately decide which interactions cause your app to be called. You use these callbacks to add game logic. For example, your game might destroy a node when its physics body is struck by another physics body.

你可以精确控制哪些物理效果相互作用。例如，某个物理场节点可以只作用于场景中部分物理体。你还可以决定哪些物理体可以相互碰撞，并分别设置哪些交互会触发应用回调。通过这些回调，你可以完成游戏逻辑，比如当某个节点的物理体被其他物理体撞击时，将其销毁。

You can also use the physics world to find physics bodies in the scene and to connect physical bodies together using a joint (`SKPhysicsJoint`). Connected bodies are simulated together based on the kind of joint.

你还可以通过物理世界查找场景中的物理体，并通过关节（`SKPhysicsJoint`）将它们连接在一起。连接后的物理体会根据关节类型协同进行物理模拟。

> Relevant Chapter: [Simulating Physics](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Physics/Physics.html#//apple_ref/doc/uid/TP40013043-CH6-SW1)
>
> 相关章节：《[物理模拟](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Physics/Physics.html#//apple_ref/doc/uid/TP40013043-CH6-SW1)》

# 2 How to Use This Document 如何使用本指南

Read [Jumping into SpriteKit](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/GettingStarted/GettingStarted.html#//apple_ref/doc/uid/TP40013043-CH2-SW1) to get an overview of implementing a SpriteKit game. Then work through the other chapters to learn the details about SpriteKit’s features. Some chapters include suggested exercises to help you develop your understanding of SpriteKit. SpriteKit is best learned by doing; place some sprites into a scene and experiment on them!

阅读《[SpriteKit 入门](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/GettingStarted/GettingStarted.html#//apple_ref/doc/uid/TP40013043-CH2-SW1)》，了解如何实现 SpriteKit 游戏的整体流程。随后可以学习其它章节，掌握 SpriteKit 的各项特性。一些章节还提供了实践练习，帮助你加深对 SpriteKit 的理解。SpriteKit 最佳的学习方式是实践：在场景中放置一些精灵进行试验！

The final chapter, [SpriteKit Best Practices](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/DesigningGameswithSpriteKit/DesigningGameswithSpriteKit.html#//apple_ref/doc/uid/TP40013043-CH7-SW1), goes into more detail about designing a game using SpriteKit.

最后一章《[SpriteKit 最佳实践](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/DesigningGameswithSpriteKit/DesigningGameswithSpriteKit.html#//apple_ref/doc/uid/TP40013043-CH7-SW1)》更详细地介绍了基于 SpriteKit 的游戏设计要点。

# 3 Prerequisites 前置知识

Before attempting to create a game using SpriteKit, you should already be familiar with the fundamentals of app development. In particular, you should be familiar with the following concepts:

在尝试用 SpriteKit 创建游戏之前，你应该熟悉应用开发的基础知识，尤其需要了解以下内容：

- Developing apps using Xcode
- Objective-C, including support for blocks
- The view and window system

- 使用 Xcode 开发应用
- Objective-C，包括对块的支持
- 视图和窗口系统

For more information:

更多相关信息：

- On iOS, see [Start Developing iOS Apps Today (Retired)](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/RoadMapiOS-Legacy/index.html#//apple_ref/doc/uid/TP40011343).
- On OS X, see [Start Developing Mac Apps Today](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/RoadMapOSX/index.html#//apple_ref/doc/uid/TP40012262).

- 在 iOS 上，可参考《[Start Developing iOS Apps Today（已下线）](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/RoadMapiOS-Legacy/index.html#//apple_ref/doc/uid/TP40011343)》。
- 在 OS X 上，可参考《[Start Developing Mac Apps Today](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/RoadMapOSX/index.html#//apple_ref/doc/uid/TP40012262)》。

> **Note**: Although this guide describes many techniques that are useful for creating games with SpriteKit, it is not a complete guide to game design or game development.
>
> **注意**：虽然本指南介绍了许多使用 SpriteKit 开发游戏的实用技巧，但并不是完整的游戏设计或开发指导。

# 4 See Also 参见

See [SpriteKit Framework Reference](https://developer.apple.com/documentation/spritekit) when you need specific details on functions and classes in the SpriteKit framework. Some features available in SpriteKit are not described in this programming guide, but are described in the reference.

如需 SpriteKit 框架函数与类的详细信息，请参见《[SpriteKit Framework Reference](https://developer.apple.com/documentation/spritekit)》。SpriteKit 的部分功能未在本编程指南中介绍，但可在参考文档中找到。

See [About Texture Atlases](http://help.apple.com/xcode/mac/8.0/#/dev0bfaf1ab7) and [Particle Emitter Editor Guide](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-particle_emitter/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013297) for information on how to use Xcode’s built-in support for SpriteKit.

关于如何使用 Xcode 的内置 SpriteKit 支持，请参见《[关于纹理图集](http://help.apple.com/xcode/mac/8.0/#/dev0bfaf1ab7)》和《[粒子发射器编辑器指南](https://developer.apple.com/library/archive/documentation/IDEs/Conceptual/xcode_guide-particle_emitter/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013297)》。

See code:Explained Adventure for an in-depth look at a SpriteKit based game.

如需深入了解一个基于 SpriteKit 的游戏，请参阅代码：Explained Adventure。

The following samples are available only in the OS X library, but still serve as useful SpriteKit examples for iOS apps :

以下示例仅在 OS X 库中提供，但对于 iOS App 依然是很有价值的 SpriteKit 示例：

- See [Sprite Tour](https://developer.apple.com/library/archive/samplecode/Sprite_Tour/Introduction/Intro.html#//apple_ref/doc/uid/DTS40013389) for a detailed look at the `SKSpriteNode` class.
- See [SpriteKit Physics Collisions](https://developer.apple.com/library/archive/samplecode/SpriteKit_Physics_Collisions/Introduction/Intro.html#//apple_ref/doc/uid/DTS40013390) to understand the physics system in SpriteKit.

- 阅读《[Sprite Tour](https://developer.apple.com/library/archive/samplecode/Sprite_Tour/Introduction/Intro.html#//apple_ref/doc/uid/DTS40013389)》，详细了解 `SKSpriteNode` 类。
- 阅读《[SpriteKit Physics Collisions](https://developer.apple.com/library/archive/samplecode/SpriteKit_Physics_Collisions/Introduction/Intro.html#//apple_ref/doc/uid/DTS40013390)》，理解 SpriteKit 的物理系统。

