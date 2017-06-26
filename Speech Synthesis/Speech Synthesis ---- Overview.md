# Speech Synthesis 语音合成

原文地址：
[https://developer.apple.com/documentation/avfoundation/speech_synthesis?language=objc](https://developer.apple.com/documentation/avfoundation/speech_synthesis?language=objc)


>__Framework__
>
>AVFoundation
>
>__SDKs__
>
>iOS 7.0+ | tvOS 9.0+ | watchOS 2.0+

# Speech Synthesis 语音合成

Convert text to spoken audio.

将文本转换成口语音频。

# Overview 概述

The Speech Synthesis framework manages voices and speech synthesis for iOS, tvOS, and watchOS. (To perform text-to-speech tasks in macOS, use the 
[NSSpeechSynthesizer](https://developer.apple.com/documentation/appkit/nsspeechsynthesizer?language=objc)
class.) Synthesizing speech requires two main steps:

Speech Synthesis 框架为 iOS、tvOS 和 watchOS 管理了声音和语音合成。（要在 macOS 上执行 文本到语音 的任务，请使用[NSSpeechSynthesizer](https://developer.apple.com/documentation/appkit/nsspeechsynthesizer?language=objc)类。）合成语音需要两个主要的步骤：

1. Create one or more [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) objects containing text to be spoken. Optionally, configure speech parameters (such as voice and rate) for each utterance.
2. Pass utterances to a [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc) object to produce spoken audio. Optionally, use that object to control or respond to ongoing speech.

>

1. 创建一个或多个包含要说的文本的 [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) 对象。可以选择性的为每句话配置语音参数（如声音和速率）。
2. 给每个语句传递一个 [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc) 对象以产生口语音频。可以选择性的使用这个对象控制或响应正在进行的语音。

# Topics 标题

## Spoken Text Attributes 口语文本属性

### [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc)

A chunk of text to be spoken, along with parameters that affect its speech.

一块要说文本，连同影响其语音的参数。

### [AVSpeechSynthesisVoice](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice?language=objc)

A distinct voice for use in speech synthesis.

语音合成中使用的独特的声音。

## Speech Synthesis Controls 语音合成控制

### [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc)

An object that produces synthesized speech from text utterances and provides controls for monitoring or controlling ongoing speech.

一个从文本语句中产生合成的语音并为监控正在进行的语音提供控制的对象。

### [AVSpeechSynthesizerDelegate](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate?language=objc)

Methods you can implement to respond to events that occur during speech synthesis.

你可以实现的方法，用以响应语音合成过程中发生的事件。