# Core Haptics

Compose and play haptic patterns to customize your iOS app’s haptic feedback.

组合并播放触觉模式，定制您的 iOS 应用程序的触觉反馈。

原文地址：[https://developer.apple.com/documentation/CoreHaptics](https://developer.apple.com/documentation/CoreHaptics)

> iOS 13.0+
iPadOS 13.0+
Mac Catalyst 13.0+
tvOS 14.0+
visionOS 1.0+

# Overview

Core Haptics lets you add customized haptic and audio feedback to your app. Use haptics to engage users physically, with tactile and audio feedback that gets attention and reinforces actions. Some system-provided interface elements—like pickers, switches, and sliders—automatically provide haptic feedback as users interact with them. With Core Haptics, you extend this functionality by composing and combining haptics beyond the default patterns.

Core Haptics 允许您为应用程序添加定制的触觉和音频反馈。使用触觉来让用户在身体上参与，通过触觉和音频反馈吸引注意力并强化操作。一些系统提供的界面元素，如选择器、开关和滑块，在用户与它们交互时会自动提供触觉反馈。通过 Core Haptics，您可以通过组合和结合超出默认模式的触觉来扩展此功能。

Your app can play custom haptic patterns crafted from basic building blocks called haptic events (CHHapticEvent). Events can be transient, like the feedback you get from toggling a switch, or continuous, like the vibration or sound from a ringtone. You can use transient and continuous patterns independently, or build your pattern from precise combinations of the two. Another type of haptic event allows you to play customized audio content as part of your pattern.

您的应用程序可以播放由称为触觉事件（CHHapticEvent）的基本构建块构建的自定义触觉模式。事件可以是瞬时的，例如从切换开关获得的反馈，也可以是持续的，例如来自铃声的振动或声音。您可以独立使用瞬时和持续模式，或者从两者的精确组合构建您的模式。另一种类型的触觉事件允许您播放自定义的音频内容作为模式的一部分。