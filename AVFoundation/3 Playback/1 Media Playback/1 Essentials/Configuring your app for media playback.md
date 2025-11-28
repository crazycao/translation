# Configuring your app for media playback 为媒体播放配置你的应用

原文地址：[https://developer.apple.com/documentation/avfoundation/configuring-your-app-for-media-playback](https://developer.apple.com/documentation/avfoundation/configuring-your-app-for-media-playback)

Configure apps to enable standard media playback behavior.

将应用程序配置为支持标准媒体播放行为。

# 1 Overview 概述

When you build media playback apps for iOS, tvOS, and visionOS, you need to do additional configuration to enable the expected playback behavior. Configuring the audio experience and background operations helps ensure that your app’s audio works as intended. It also enables advanced features like AirPlay streaming and Picture in Picture playback on supported platforms.

为 iOS、tvOS 和 visionOS 构建媒体播放类应用时，你需要进行额外配置，以实现预期的播放行为。配置音频体验和后台操作，有助于确保应用的音频功能按预期工作；同时，这也能在支持的平台上启用如 AirPlay 流媒体传输、画中画（Picture in Picture）播放等高级功能。

# 2 Configure the audio session 配置音频会话

Apple platforms, other than macOS which primarily leaves control to an app, provide an audio experience that the operating system manages. This enables the OS to provide a seamless audio experience to people as they switch between apps and receive high-priority audio requests such as phone or FaceTime calls.

除 macOS（其音频控制主要交由应用程序自主管理）外，苹果其他平台的音频体验均由操作系统统一管控。这一设计能确保用户在应用间切换，或接收电话、FaceTime 通话等优先级较高的音频请求时，获得无缝衔接的音频体验。

Your app uses an `AVAudioSession` to configure its audio behavior semantically, for example to have a primary purpose of playback or recording. You delegate the management of those details to the audio session, which ensures that the operating system can best manage a person’s audio experience.

你的应用通过 `AVAudioSession` 以语义化方式配置音频行为，例如明确应用的核心用途是播放音频还是录制音频。你可将音频相关的细节管理委托给音频会话，由其确保操作系统能以最优方式统筹用户的整体音频体验。

Your app automatically has an audio session that the system configures with this default behavior:

- Audio playback in your app silences other background audio
- Support for audio playback but not audio recording
- Ring/Silent switch set to silent mode in iOS silences app audio
- Locked device in iOS silences app audio

应用会自动拥有一个系统配置的音频会话，其默认行为如下：

- 应用内的音频播放会静音其他后台音频
- 支持音频播放，但不支持音频录制
- iOS 设备的响铃/静音开关切换至静音模式时，应用音频会静音
- iOS 设备锁屏后，应用音频会静音

The default audio session provides useful behavior, but typically doesn’t provide the experience and features you need when building a playback app. To add the required behavior, configure your app’s audio session category.

默认音频会话提供了有用的功能，但对于媒体播放类应用而言，通常无法满足所需的体验与特性需求。若要添加必要的行为，需配置应用的音频会话类别。

An audio session category defines the general audio behavior your app requires. AVFoundation defines several audio session categories you can use, but the one most relevant for media playback apps is `playback`. This category indicates that media playback is a central feature of your app. When you specify this category, the system doesn’t silence your app’s audio when someone sets the Ring/Silent switch to silent mode in iOS only. Enabling this category means your app can play background audio if you’re using the `Audio, AirPlay, and Picture in Picture` background mode as explained in the section below.

音频会话类别定义了应用所需的通用音频行为。AVFoundation 框架提供了多种可选用的音频会话类别，其中与媒体播放类应用最相关的是 `playback`。该类别表明媒体播放是应用的核心功能。若选用该类别，（仅）在 iOS 平台下，当用户将响铃/静音开关切换至静音模式时，系统不会静音应用音频。启用该类别后，若你按下文所述配置了【音频、AirPlay 及画中画】后台模式，应用即可支持后台音频播放。

Use an `AVAudioSession` object to configure your app’s audio session. An audio session is a singleton object you use to set the audio session [category](https://developer.apple.com/documentation/AVFAudio/AVAudioSession/category-swift.property), [mode](https://developer.apple.com/documentation/AVFAudio/AVAudioSession/mode-swift.property), and other settings. To configure the audio session for optimized playback of movies:

通过 `AVAudioSession` 对象配置应用的音频会话。音频会话是一个单例对象，用于设置音频会话的[类别](https://developer.apple.com/documentation/AVFAudio/AVAudioSession/category-swift.property)、[模式](https://developer.apple.com/documentation/AVFAudio/AVAudioSession/mode-swift.property)及其他参数。以下是针对影片优化播放体验的音频会话配置示例：

```
class PlayerModel: ObservableObject {
    
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            // Configure the app for playback of long-form movies.
            // 配置应用以支持长片影片播放
            try session.setCategory(.playback, mode: .moviePlayback)
        } catch {
            // Handle error.
            // 处理错误
        }
    }
}
```

To enable this category, activate the audio session using the `setActive(_:options:)` method.

启用该类别后，需调用 `setActive(_:options:)` 方法激活音频会话。

> **Note** **注意事项**
>
> You can activate the audio session at any time after setting its category, but it’s recommended to defer this call until your app begins audio playback. Deferring the call ensures that you don’t prematurely interrupt any other background audio that may be in progress.
> 
> 设置音频会话类别后，你可在任意时间激活会话，但建议延迟至应用开始音频播放时再调用。这样做能避免过早中断其他可能正在进行的后台音频。

Setting the category is the minimal interaction with an audio session, but other configuration options and features are available. For example, in visionOS, you customize a user’s spatial audio experience by configuring the audio session. For more information, see [AVAudioSession](https://developer.apple.com/documentation/AVFAudio/AVAudioSession).

设置类别是与音频会话的最基础交互，此外还有更多配置选项和特性可供使用。例如在 visionOS 中，你可通过配置音频会话自定义用户的空间音频体验。详细信息请参阅 [AVAudioSession](https://developer.apple.com/documentation/AVFAudio/AVAudioSession) 相关文档。

# 2 Configure the background modes 配置后台模式

The system requires you to enable certain capabilities to perform some background operations. A common capability that playback apps require is playing background audio. With this capability enabled, your app’s audio continues when people switch to another app or lock their iOS device. Your app also needs this capability to enable advanced playback features like AirPlay streaming and Picture in Picture playback on supported platforms.

应用若需执行某些后台操作，需启用相应的功能权限。播放类应用一般需要的功能权限是“后台音频播放”。启用该权限后，即使用户切换至其他应用或锁定 iOS 设备，你的应用音频仍能继续播放。同时，该权限也是在支持的平台上启用 AirPlay 流媒体传输、画中画播放等高级播放功能的必要条件。

Use Xcode to configure this capability:

1. Select your app’s target in Xcode and select the 【Signing & Capabilities】 tab.
2. Click the 【+ Capability】 button and add the 【Background Modes】 capability to the project.
3. In the 【Background Modes】 interface, select the Audio, AirPlay, and Picture in Picture option under its list of background modes.

通过 Xcode 配置该权限的步骤如下：

1. 在 Xcode 中选中你的应用目标（target），切换至【Signing & Capabilities】（签名与功能）标签页；
2. 点击【+ Capability】（添加功能）按钮，为项目添加【Background Modes】（后台模式）功能；
3. 在【Background Modes】（后台模式）配置界面中，勾选后台模式列表中的【Audio, AirPlay, and Picture in Picture】（音频、AirPlay 及画中画）选项。

![A screenshot of the Background Modes section of an Xcode target’s Signing & Capabilities tab. It shows a Background Modes heading at the top of the image and a vertical list of checkboxes below it to enable specific modes. The top checkbox is enabled to indicate that the app supports the Audio, Airplay, and Picture in Picture background mode.](https://docs-assets.developer.apple.com/published/07d502bfec5343ff4de6b766c8797007/media-4264469%402x.png)

With this mode enabled and your audio session configured, your app is ready to play background audio. In iOS, when you enable this option, your app can stream its content over AirPlay, and in iOS and tvOS it can use Picture in Picture playback.

启用该模式并完成音频会话配置后，你的应用即可支持后台音频播放。在 iOS 平台，启用该选项后应用可通过 AirPlay 流式传输内容；在 iOS 和 tvOS 平台，应用可使用画中画播放功能。