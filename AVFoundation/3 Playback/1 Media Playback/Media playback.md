# Media playback

原文地址：[https://developer.apple.com/documentation/avfoundation/media-playback](https://developer.apple.com/documentation/avfoundation/media-playback)

Manage the playback of media assets and interstitial content, independent of how you present that content in your interface.

管理媒体资源和插播内容的播放，而不依赖于你在界面中呈现该内容的方式。

# Overview 概述

You use a player to manage the playback and timing of a media asset, for example starting and stopping playback, and seeking to a particular time. A player manages the playback of a single media asset at a time. The framework also provides a queue player that queues media assets to play sequentially.

你可以使用播放器管理媒体资源的播放和时序，例如启动与停止播放、跳转到特定时间点等操作。一个播放器在同一时间仅能管理单个媒体资源的播放。该框架还提供了一种队列播放器，可将多个媒体资源加入队列以实现顺序播放。

> **Note** **注意事项**
> 
> When you use AVFoundation, Apple may collect metrics to help improve the framework.
> 
> 使用 AVFoundation 框架时，苹果公司可能会收集相关指标数据，以帮助改进该框架。

You create an instance of `AVPlayerItem` to play a media asset. A player item manages the timing and presentation state of an asset played by the player. A player item also contains player item tracks that correspond to the tracks in the asset. You direct the output of a player to a specialized Core Animation layer, a player layer, or a synchronized layer.

你需要创建一个 `AVPlayerItem` 实例来播放媒体资源。播放器项目实例负责管理由播放器播放的媒体资源的时序和呈现状态，同时还包含与媒体资源中的轨道相对应的播放器项轨道。你可以将播放器的输出定向到专用的 Core Animation 图层、播放器层或同步层。

> **Important** **重要提示**
>
> You must call the `VTRegisterProfessionalVideoWorkflowVideoDecoders()` function if your app requires Afterburner accelerated playback and decoding of ProRes and ProRes RAW video files.
> 
> 如果你的应用需要通过 Afterburner 技术对 ProRes 和 ProRes RAW 视频文件进行加速播放和解码，则必须调用 `VTRegisterProfessionalVideoWorkflowVideoDecoders()` 函数。

