# AVPlayer

原文地址：[https://developer.apple.com/documentation/avfoundation/avplayer](https://developer.apple.com/documentation/avfoundation/avplayer)

An object that provides the interface to control the player’s transport behavior.

一个提供接口以控制播放器传输行为的对象。

> iOS 4.0+
iPadOS 4.0+
Mac Catalyst 13.1+
macOS 10.7+
tvOS 9.0+
visionOS 1.0+
watchOS 1.0+

```
@MainActor
class AVPlayer
```

# Overview 概述

A player is a controller object that manages the playback and timing of a media asset. Use an instance of [AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer) to play local and remote file-based media, such as QuickTime movies and MP3 audio files, as well as audiovisual media served using HTTP Live Streaming.

播放器（Player）是一种控制器对象，用于管理媒体资源的播放与时序。通过 [AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer) 实例，可播放本地及远程的基于文件的媒体（如 QuickTime 影片、MP3 音频文件），也可播放通过 HTTP 直播流（HTTP Live Streaming）传输的视听媒体。

Use a player object to play a single media asset. You can reuse the player instance to play additional media assets using its [replaceCurrentItem(with:)](https://developer.apple.com/documentation/avfoundation/avplayer/replacecurrentitem(with:)) method, but it manages the playback of only a single media asset at a time. The framework also provides a subclass called [AVQueuePlayer](https://developer.apple.com/documentation/avfoundation/avqueueplayer) that you can use to manage the playback of a queue of media assets.

使用单个播放器对象可播放一个媒体资源。你可以通过其 [replaceCurrentItem(with:)](https://developer.apple.com/documentation/avfoundation/avplayer/replacecurrentitem(with:)) 方法复用该播放器实例，以播放其他媒体资源，但同一时间它仅能管理一个媒体资源的播放。该框架还提供了名为 [AVQueuePlayer](https://developer.apple.com/documentation/avfoundation/avqueueplayer) 的子类，可用于管理媒体资源队列的播放（即按顺序播放多个媒体资源）。

You use an AVPlayer to play media assets, which AVFoundation represents using the [AVAsset](https://developer.apple.com/documentation/avfoundation/avasset) class. AVAsset only models the _static_ aspects of the media, such as its duration or creation date, and on its own, isn’t suitable for playback with an AVPlayer. To play an asset, you create an instance of its _dynamic_ counterpart found in AVPlayerItem. This object models the timing and presentation state of an asset played by an instance of AVPlayer. See the [AVPlayerItem](https://developer.apple.com/documentation/avfoundation/avplayeritem) reference for more details.

AVPlayer 用于播放媒体资源，而在 AVFoundation 框架中，媒体资源由 [AVAsset](https://developer.apple.com/documentation/avfoundation/avasset) 类表示。AVAsset 仅对媒体的 _静态_ 属性进行建模（如媒体时长、创建日期），其本身并不适合直接通过 AVPlayer 播放。若要播放某一媒体资源，需创建其对应的 _动态_ 对应物 —— 可在 AVPlayerItem 中找到。该对象会对 AVPlayer 实例所播放媒体资源的时序与呈现状态进行建模。更多详情请参阅 [AVPlayerItem](https://developer.apple.com/documentation/avfoundation/avplayeritem) 参考文档。

AVPlayer is a dynamic object whose state continuously changes. There are two approaches you can use to observe a player’s state:

- **General State Observations**: You can use key-value observing (KVO) to observe state changes to many of the player’s dynamic properties, such as its [currentItem](https://developer.apple.com/documentation/avfoundation/avplayer/currentitem) or its playback [rate](https://developer.apple.com/documentation/avfoundation/avplayer/rate).
- **Timed State Observations**: KVO works well for general state observations, but isn’t intended for observing continuously changing state like the player’s time. AVPlayer provides two methods to observe time changes:
	- [addPeriodicTimeObserver(forInterval:queue:using:)](https://developer.apple.com/documentation/avfoundation/avplayer/addperiodictimeobserver(forinterval:queue:using:))
	- [addBoundaryTimeObserver(forTimes:queue:using:)](https://developer.apple.com/documentation/avfoundation/avplayer/addboundarytimeobserver(fortimes:queue:using:))

AVPlayer 是一种状态会持续变化的动态对象。有两种方法可以观察播放器状态：

- **常规状态观察（General State Observations）**：你可以使用键值观察（KVO，Key-Value Observing） 来观察播放器诸多动态属性的状态变化，例如其 [currentItem](https://developer.apple.com/documentation/avfoundation/avplayer/currentitem)（当前播放项）或 playback [rate](https://developer.apple.com/documentation/avfoundation/avplayer/rate)（播放速率）。
- **时序状态观察（Timed State Observations）**：KVO 适用于常规状态观察，但并不适用于观察播放器时间这类持续变化的状态。AVPlayer 提供了两种方法来观察时间变化：
	- [addPeriodicTimeObserver(forInterval:queue:using:)](https://developer.apple.com/documentation/avfoundation/avplayer/addperiodictimeobserver(forinterval:queue:using:))（添加周期性时间观察者）
	- [addBoundaryTimeObserver(forTimes:queue:using:)](https://developer.apple.com/documentation/avfoundation/avplayer/addboundarytimeobserver(fortimes:queue:using:))（添加边界时间观察者）

These methods let you observe time changes either periodically or by boundary, respectively. As changes occur, invoke the callback block or closure you supply to these methods to give you the opportunity to take some action such as updating the state of your player’s user interface.

这两种方法分别允许你按周期或按边界观察时间变化。当变化发生时，会调用你向这些方法提供的回调块（block）或闭包（closure），使你有机会执行一些操作，例如更新播放器用户界面的状态。

[AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer) and [AVPlayerItem](https://developer.apple.com/documentation/avfoundation/avplayeritem) are nonvisual objects, meaning that on their own they’re unable to present an asset’s video onscreen. There are two primary approaches you use to present your video content onscreen:

- **AVKit**: The best way to present your video content is with the AVKit framework’s [AVPlayerViewController](https://developer.apple.com/documentation/AVKit/AVPlayerViewController) class in iOS and tvOS, or the [AVPlayerView](https://developer.apple.com/documentation/AVKit/AVPlayerView) class in macOS. These classes present the video content, along with playback controls and other media features giving you a full-featured playback experience.
- **AVPlayerLayer**: When building a custom interface for your player, use [AVPlayerLayer](https://developer.apple.com/documentation/avfoundation/avplayerlayer). You can set this layer a view’s backing layer or add it directly to the layer hierarchy. Unlike AVPlayerView and AVPlayerViewController, a player layer doesn’t present any playback controls—it only presents the visual content onscreen. It’s up to you to build the playback transport controls to play, pause, and seek through the media.

[AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer) 和 [AVPlayerItem](https://developer.apple.com/documentation/avfoundation/avplayeritem) 均为非可视化对象，这意味着它们自身无法在屏幕上呈现资源的视频内容。在屏幕上呈现视频内容主要有两种方式：

- **AVKit**：呈现视频内容的最佳方式是使用 AVKit 框架提供的类：在 iOS 和 tvOS 中使用 [AVPlayerViewController](https://developer.apple.com/documentation/AVKit/AVPlayerViewController) 类，在 macOS 中使用 [AVPlayerView](https://developer.apple.com/documentation/AVKit/AVPlayerView) 类。这些类不仅能呈现视频内容，还会附带播放控制控件及其他媒体功能，为你提供一套功能完整的播放体验。
- **AVPlayerLayer**：当你需要为播放器构建自定义界面时，可以使用 [AVPlayerLayer](https://developer.apple.com/documentation/avfoundation/avplayerlayer)。你可以将该图层设为某个视图的底层图层，或直接将其添加到图层层级结构中。与 AVPlayerView 和 AVPlayerViewController 不同，AVPlayerLayer 不提供任何播放控制控件 —— 它仅负责在屏幕上呈现可视化内容。播放、暂停、媒体进度定位（seek）等播放控制控件，均需由你自行构建。

Alongside the visual content presented with AVKit or AVPlayerLayer, you can also present animated content synchronized with the player’s timing using [AVSynchronizedLayer](https://developer.apple.com/documentation/avfoundation/avsynchronizedlayer). Use a synchronized layer pass along player timing to its layer subtree. You can use AVSynchronizedLayer to build custom effects in Core Animation, such as animated lower thirds or video transitions, and have them play in sync with the timing of the player’s current AVPlayerItem.

除了通过 AVKit 或 AVPlayerLayer 呈现的可视化内容外，你还可以使用 [AVSynchronizedLayer](https://developer.apple.com/documentation/avfoundation/avsynchronizedlayer) 呈现与播放器时序同步的动画内容。使用同步图层可以将播放器的时序信息传递给它的子图层树。你可以借助 AVSynchronizedLayer 在 Core Animation 中构建自定义效果，例如动态字幕条、视频转场动画等，并让这些效果与播放器当前 AVPlayerItem 的时序保持同步播放。

