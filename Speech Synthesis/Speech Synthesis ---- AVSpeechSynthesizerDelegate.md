# Speech Synthesis ---- AVSpeechSynthesizerDelegate

原文地址：
[https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate?language=objc](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate?language=objc)

# AVSpeechSynthesizerDelegate

Methods you can implement to respond to events that occur during speech synthesis.

你可以实现的方法，用以响应语音合成过程中发生的事件。

# Overview 概述

All methods in this protocol are optional. An [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc) object sends messages to its delegate for three categories of events:

协议中的所有方法都是可选的。[AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc)对象会针对下面三种事件发送消息到它的代理：

- When speech pauses or resumes
- When the synthesizer starts or finishes speaking a block of text (as encapsulated by an [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) object)
- As the synthesizer produces each individual unit of speech
- 当语音暂停或恢复
- 当合成器开始或完成朗读一个文本块（被概括成一个 [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) 对象）
- 当合成器产生语音的每一个独立单元时

For the third case, you can implement the [speechSynthesizer:willSpeakRangeOfSpeechString:utterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619681-speechsynthesizer?language=objc) method to provide a user interface in which each word is visibly highlighted as it is spoken.

对于第三种情况，你可以实现 [speechSynthesizer:willSpeakRangeOfSpeechString:utterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619681-speechsynthesizer?language=objc) 方法提供一个用户界面，在这个界面里面随着说出的语音高亮显示每一个单词。

# Topics 标题

## Responding to Speech Synthesis Events 响应语音合成事件

[speechSynthesizer:didCancelSpeechUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619678-speechsynthesizer?language=objc)

Tells the delegate when the synthesizer has canceled speaking an utterance.

当合成器已经取消了朗读一个语句时告知代理。

[speechSynthesizer:didContinueSpeechUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619677-speechsynthesizer?language=objc)

Tells the delegate when the synthesizer has resumed speaking an utterance after being paused.

当合成器在暂停之后恢复朗读一个语句时告知代理。

[speechSynthesizer:didFinishSpeechUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619700-speechsynthesizer?language=objc)

Tells the delegate when the synthesizer has finished speaking an utterance.

当合成器完成对一个语句的朗读时告知代理。

[speechSynthesizer:didPauseSpeechUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619675-speechsynthesizer?language=objc)

Tells the delegate when the synthesizer has paused while speaking an utterance.

当合成器在正在朗读一个语句时暂停下来时告知代理。

[speechSynthesizer:didStartSpeechUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619701-speechsynthesizer?language=objc)

Tells the delegate when the synthesizer has begun speaking an utterance.

当合成器开始朗读一个语句时告知代理。

[speechSynthesizer:willSpeakRangeOfSpeechString:utterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate/1619681-speechsynthesizer?language=objc)

Tells the delegate when the synthesizer is about to speak a portion of an utterance’s text.

当合成器将要朗读一个语句的文本的一部分时告知代理。

# Relationships 关系

## Inherits From

NSObject

# See Also 其他参考

## Speech Synthesis Controls

[AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc)

An object that produces synthesized speech from text utterances and provides controls for monitoring or controlling ongoing speech.

一个从文本语句中产生合成的语音并为监控正在进行的语音提供控制的对象。