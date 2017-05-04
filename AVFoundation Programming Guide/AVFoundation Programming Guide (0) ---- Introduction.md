# AVFoundation Programming Guide 

原文地址：
[https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html)

# 0 About AVFoundation - AVFoundation概述

AVFoundation is one of several frameworks that you can use to play and create time-based audiovisual media. It provides an Objective-C interface you use to work on a detailed level with time-based audiovisual data. For example, you can use it to examine, create, edit, or reencode media files. You can also get input streams from devices and manipulate video during realtime capture and playback. Figure I-1 shows the architecture on iOS.

`AVFoundation`是可以用它来播放和创建基于时间的视听媒体的几个框架之一。它提供了详细到基于时间的视听数据的Objective-C接口。例如，你可以用它来检查，创建，编辑或重新编码媒体文件。您也可以从设备得到输入流和在实时捕捉回放过程中操控视频。图I-1显示了iOS上的架构。

**Figure I-1**  AVFoundation stack on iOS - iOS上的AVFoundation栈
![img](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/frameworksBlockDiagram_2x.png)

[Figure I-2](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/#//apple_ref/doc/uid/TP40010188-CH1-SW5) shows the corresponding media architecture on OS X.

[图I-2](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/#//apple_ref/doc/uid/TP40010188-CH1-SW5)显示了OS X上相相应的媒体架构：

**Figure I-2**  AVFoundation stack on OS X - OS X上的AVFoundation栈
![img](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/frameworksBlockDiagramOSX_2x.png)

You should typically use the highest-level abstraction available that allows you to perform the tasks you want.

通常，您应该使用可用的最高级的抽象接口，执行所需的任务。

- If you simply want to play movies, use the AVKit framework.
- On iOS, to record video when you need only minimal control over format, use the UIKit framework ([UIImagePickerController](https://developer.apple.com/reference/uikit/uiimagepickercontroller)).
- 如果你只是想播放电影，使用`AVKit`框架。
- 在iOS上，要录制视频，当在格式上只需要最少的控制时，使用`UIKit`框架。([UIImagePickerController](https://developer.apple.com/reference/uikit/uiimagepickercontroller))。

Note, however, that some of the primitive data structures that you use in AV Foundation—including time-related data structures and opaque objects to carry and describe media data—are declared in the Core Media framework.

但是请注意，某些在`AV Foundation`中使用的原始数据结构——包括时间相关的数据结构和传递和描述媒体数据的不透明数据对象——是在`Core Media framework`声明的。

## 0.1 At a Glance 摘要

There are two facets to the AVFoundation framework—APIs related to video and APIs related just to audio. The older audio-related classes provide easy ways to deal with audio. They are described in the *Multimedia Programming Guide*, not in this document.

`AVFoundation`框架包含两个方面——视频相关的APIs和音频相关的APIs。旧的音频相关类提供了简便的方法来处理音频。他们在《*Multimedia Programming Guide*》中介绍，不在这个文档中。

- To play sound files, you can use `AVAudioPlayer`.
- To record audio, you can use `AVAudioRecorder`.
- 要播放声音文件，你可以使用[AVAudioPlayer](https://developer.apple.com/reference/avfoundation/avaudioplayer)。
- 要记录音频，你可以使用[AVAudioRecorder](https://developer.apple.com/reference/avfoundation/avaudiorecorder)。

You can also configure the audio behavior of your application using `AVAudioSession`; this is described in *Audio Session Programming Guide*.

你也可以使用[AVAudioSession](https://developer.apple.com/reference/avfoundation/avaudiosession)配置你的程序中的音频行为；这在《[*Audio Session Programming Guide*](https://developer.apple.com/library/content/documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007875)》中有介绍。

### 0.1.1 Representing and Using Media with AVFoundation - 用 AVFoundation 表示和使用媒体

The primary class that the AV Foundation framework uses to represent media is `AVAsset`. The design of the framework is largely guided by this representation. Understanding its structure will help you to understand how the framework works. An `AVAsset` instance is an aggregated representation of a collection of one or more pieces of media data (audio and video tracks). It provides information about the collection as a whole, such as its title, duration, natural presentation size, and so on. `AVAsset` is not tied to particular data format. `AVAsset` is the superclass of other classes used to create asset instances from media at a URL (see [Using Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1)) and to create new compositions (see [Editing](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/#//apple_ref/doc/uid/TP40010188-CH1-SW1)).

`AV Foundation`框架用来表示媒体的主要类是[AVAsset](https://developer.apple.com/reference/avfoundation/avasset)。框架的设计多半由这个表示引导。了解它的结构将有助于您了解该框架是如何工作的。一个`AVAsset`实例是一个或多个片段的媒体数据（音频和视频轨道）的集合的聚集表示。它作为一个整体提供了关于这个集合的信息，如它的名称，持续时长，自然表现大小等。 `AVAsset`不依赖于特定的数据格式。`AVAsset`是用于从某个URL上的媒体创建asset实例（见《[使用Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1)》）和用于创建新的作品（见《[Ed编辑iting](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/#//apple_ref/doc/uid/TP40010188-CH1-SW1)》）的其他类的父类。

Each of the individual pieces of media data in the asset is of a uniform type and called a *track*. In a typical simple case, one track represents the audio component, and another represents the video component; in a complex composition, however, there may be multiple overlapping tracks of audio and video. Assets may also have metadata.

Asset中媒体数据的每个独立片段，都是一个统一的类型，把这个类型称为“*轨道*”。在一个典型的简单案例中，一个轨道代表这个音频组件，另一个代表视频组件；然而复杂的作品中，有可能是多个重叠的音频和视频轨道。Assets也可能有元数据。

A vital concept in AV Foundation is that initializing an asset or a track does not necessarily mean that it is ready for use. It may require some time to calculate even the duration of an item (an MP3 file, for example, may not contain summary information). Rather than blocking the current thread while a value is being calculated, you ask for values and get an answer back asynchronously through a callback that you define using a [block]().

在`AV Foundation`中一个非常重要的概念是：初始化一个 asset 或者一个轨道并不一定意味着它已经准备好可以使用。这可能需要一些时间来计算一个项目的持续时间（例如一个MP3文件，其中可能不包含摘要信息）。为了避免在计算一个值的时候阻塞当前线程，你最好请求这个值，并且通过你定义的一个[block]()回调来异步获取返回。

>**Relevant Chapters:** [Using Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1), [Time and Media Representations](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/06_MediaRepresentations.html#//apple_ref/doc/uid/TP40010188-CH2-SW1)
>**相关章节：** [Using Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1), [Time and Media Representations](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/06_MediaRepresentations.html#//apple_ref/doc/uid/TP40010188-CH2-SW1)

#### 0.1.1.1 Playback 播放

AVFoundation allows you to manage the playback of asset in sophisticated ways. To support this, it separates the presentation state of an asset from the asset itself. This allows you to, for example, play two different segments of the same asset at the same time rendered at different resolutions. The presentation state for an asset is managed by a *player item* object; the presentation state for each track within an asset is managed by a *player item track* object. Using the player item and player item tracks you can, for example, set the size at which the visual portion of the item is presented by the player, set the audio mix parameters and video composition settings to be applied during playback, or disable components of the asset during playback.

`AVFoundation`允许你用更精确的方式来管理asset的播放。为了支持这一点，它将一个asset的呈现状态从asset自身中分离出来。例如允许你在不同的分辨率下同时播放同一个asset中的两个不同的片段。Asset的呈现状态是由*player item*对象管理的；asset中的每个轨道的呈现状态是由*player item track*对象管理的。例如，使用*player item*和*player item tracks*，你可以设置被播放器呈现的项目中可视部分的尺寸，设置应用于播放期间的音频混合参数和视频组合设定，或者在播放期间的禁用asset的组件。

You play player items using a *player* object, and direct the output of a player to the Core Animation layer. You can use a *player queue* to schedule playback of a collection of player items in sequence.

你可以使用一个*player*对象来播放播放器项目，并且直接输出一个播放器给核心动画层。你可以使用一个*player queue*给安排一个集合中的*player items*按顺序播放。

>**Relevant Chapter:** [Playback](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/TP40010188-CH3-SW1)
>
>**相关章节：** [Playback](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/TP40010188-CH3-SW1)

#### 0.1.1.2 Reading, Writing, and Reencoding Assets 对asset进行读、写和重编吗

AVFoundation allows you to create new representations of an asset in several ways. You can simply reencode an existing asset, or—in iOS 4.1 and later—you can perform operations on the contents of an asset and save the result as a new asset.

`AVFoundation`允许你用几种方式创建asset的新的表现形式。你可以简单的将已经存在的asset重新编码，或者——在iOS4.1以及之后的版本中——你可以在一个asset的内容中执行一些操作并且将结果保存为一个新的asset。

You use an *export session* to reencode an existing asset into a format defined by one of a small number of commonly-used presets. If you need more control over the transformation, in iOS 4.1 and later you can use an *asset reader* and *asset writer* object in tandem to convert an asset from one representation to another. Using these objects you can, for example, choose which of the tracks you want to be represented in the output file, specify your own output format, or modify the asset during the conversion process.

你可以使用*export session*将一个现有的asset重新编码为一个小数字，这个小数字是常用的预先设定好的一些小数字中的一个。如果在转换中你需要更多的控制，在iOS4.1已经以后的版本中，你可以使用 asset reader 和 asset writer 对象串联的一个一个的转换。例如你可以使用这些对象选择在输出的文件中想要表示的轨道，指定你自己的输出格式，或者在转换过程中修改这个asset。

To produce a visual representation of the waveform, you use an asset reader to read the audio track of an asset.

**Relevant Chapter:** [Using Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1)

#### Thumbnails

To create thumbnail images of video presentations, you initialize an instance of `AVAssetImageGenerator` using the asset from which you want to generate thumbnails. `AVAssetImageGenerator` uses the default enabled video tracks to generate images. 

**Relevant Chapter:** [Using Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1)

#### Editing

AVFoundation uses *compositions* to create new assets from existing pieces of media (typically, one or more video and audio tracks). You use a mutable composition to add and remove tracks, and adjust their temporal orderings. You can also set the relative volumes and ramping of audio tracks; and set the opacity, and opacity ramps, of video tracks. A composition is an assemblage of pieces of media held in memory. When you export a composition using an *export session*, it’s collapsed to a file. 

You can also create an asset from media such as sample buffers or still images using an *asset writer*. 

**Relevant Chapter:** [Editing](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/03_Editing.html#//apple_ref/doc/uid/TP40010188-CH8-SW1)

#### Still and Video Media Capture

Recording input from cameras and microphones is managed by a *capture session*. A capture session coordinates the flow of data from input devices to outputs such as a movie file. You can configure multiple inputs and outputs for a single session, even when the session is running. You send messages to the session to start and stop data flow.

In addition, you can use an instance of a *preview layer* to show the user what a camera is recording.

**Relevant Chapter:** [Still and Video Media Capture](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/04_MediaCapture.html#//apple_ref/doc/uid/TP40010188-CH5-SW2)

### Concurrent Programming with AVFoundation

Callbacks from AVFoundation—invocations of [blocks](), [key-value observers](), and [notification]() handlers—are not guaranteed to be made on any particular thread or queue. Instead, AVFoundation invokes these handlers on threads or queues on which it performs its internal tasks. 

There are two general guidelines as far as notifications and threading:

- UI related notifications occur on the main thread.
- Classes or methods that require you create and/or specify a queue will return notifications on that queue.

Beyond those two guidelines (and there are exceptions, which are noted in the reference documentation) you should not assume that a notification will be returned on any specific thread.

If you’re writing a multithreaded application, you can use the `NSThread` method `isMainThread` or `[[NSThread currentThread] isEqual:<#A stored thread reference#>]` to test whether the invocation thread is a thread you expect to perform your work on. You can redirect messages to appropriate threads using methods such as `performSelectorOnMainThread:withObject:waitUntilDone:` and `performSelector:onThread:withObject:waitUntilDone:modes:`. You could also use `dispatch_async` to “bounce” to your blocks on an appropriate queue, either the main queue for UI tasks or a queue you have up for concurrent operations. For more about concurrent operations, see *Concurrency Programming Guide*; for more about blocks, see *Blocks Programming Topics*. The *AVCam-iOS: Using AVFoundation to Capture Images and Movies* sample code is considered the primary example for all AVFoundation functionality and can be consulted for examples of thread and queue usage with AVFoundation.

## Prerequisites

AVFoundation is an advanced Cocoa framework. To use it effectively, you must have:

- A solid understanding of fundamental Cocoa development tools and techniques
- A basic grasp of [blocks]()
- A basic understanding of [key-value coding]() and [key-value observing]()
- For playback, a basic understanding of Core Animation (see *Core Animation Programming Guide* or, for basic playback, the *AVKit Framework Reference*.

## See Also

There are several AVFoundation examples including two that are key to understanding and implementation Camera capture functionality:

- *AVCam-iOS: Using AVFoundation to Capture Images and Movies* is the canonical sample code for implementing any program that uses the camera functionality. It is a complete sample, well documented, and covers the majority of the functionality showing the best practices.
- *AVCamManual: Extending AVCam to Use Manual Capture API* is the companion application to AVCam. It implements Camera functionality using the manual camera controls. It is also a complete example, well documented, and should be considered the canonical example for creating camera applications that take advantage of manual controls.
- *RosyWriter* is an example that demonstrates real time frame processing and in particular how to apply filters to video content. This is a very common developer requirement and this example covers that functionality.
- *AVLocationPlayer: Using AVFoundation Metadata Reading APIs* demonstrates using the metadata APIs.