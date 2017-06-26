# Speech Synthesis ---- AVSpeechSynthesizer

原文地址：
[https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc)

# AVSpeechSynthesizer

An object that produces synthesized speech from text utterances and provides controls for monitoring or controlling ongoing speech.

一个从文本语句中产生合成的语音并为监控正在进行的语音提供控制的对象。

# Overview 概述

The `AVSpeechSynthesizer` class produces synthesized speech from text on an iOS device, and provides methods for controlling or monitoring the progress of ongoing speech.

`AVSpeechSynthesizer`类在iOS设备上从文本产生合成的语音，并提供监控正在进行的语音的进度的方法。

To speak some amount of text, you must first create an [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) instance containing the text. (Optionally, you may also use the utterance object to control parameters affecting its speech, such as voice, pitch, and rate.) Then, pass it to the [speakUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619686-speakutterance?language=objc) method on a speech synthesizer instance to speak that utterance.

要说出一些文本，你必须首先创建一个包含文本的 [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) 实例。（你也可以选择性的使用语句对象控制参数影响它的语音，如声音、音调和速度。）然后，将其传递给语音合成器实例的 [speakUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619686-speakutterance?language=objc) 方法以说出那个语句。

The speech synthesizer maintains a queue of utterances to be spoken. If the synthesizer is not currently speaking, calling `speakUtterance:` begins speaking that utterance immediately (or begin waiting through its [preUtteranceDelay](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619679-preutterancedelay?language=objc) if one is set). If the synthesizer is speaking, utterances are added to a queue and spoken in the order they are received.

语音合成器维持了一个要说的语句的队列。如果合成器当前没在说话，调用`speakUtterance:`会立即开始说出那个语句（或者如果设置了 [preUtteranceDelay](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619679-preutterancedelay?language=objc) 会开始这个时间后开始）。如果合成器正在说话，语句会被添加到一个队列并按照它们被接收的顺序说出来。

After speech has begun, you can use the synthesizer object to pause or stop speech. After speech is paused, it may be continued from the point at which it left off; stopping ends speech entirely, removing any utterances yet to be spoken from the synthesizer’s queue.

在语音开始之后，你可以使用合成器对象暂停或停止语音。在语音被暂停之后，它可以从停下来的点继续；完全停止最终语音，会从合成器的队列中移除所有还没有说的语句。

You may monitor the speech synthesizer by examining its `speaking` and `paused` properties, or by setting a delegate. Messages in the [AVSpeechSynthesizerDelegate](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate?language=objc) protocol are sent as significant events occur during speech synthesis.

你可以通过检查语音合成器的`speaking`和`paused`属性监视它，或者通过代理也行。在 [AVSpeechSynthesizerDelegate](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate?language=objc) 协议中的消息会在语音合成过程中的重要事件发生时发送。

# Topics 标题

## Synthesizing Speech 合成语音

[- speakUtterance:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619686-speakutterance?language=objc)

Enqueues an utterance to be spoken.

将一条语音放入队列以说出来。

## Controlling Speech Synthesis 控制语音合成

[- continueSpeaking](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619704-continuespeaking?language=objc)

Continues speech from the point at which it left off.

从语音停下来的点继续说。

[- pauseSpeakingAtBoundary:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619689-pausespeakingatboundary?language=objc)

Pauses speech at the specified boundary constraint.

在指定的边界约束处暂停语音。

[paused](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619692-paused?language=objc)

A Boolean value that indicates whether speech has been paused.

指示语音是否被暂停的布尔值。

[speaking](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619680-speaking?language=objc)

A Boolean value that indicates whether the synthesizer is speaking.

指示合成器是否正在说话的布尔值。

[- stopSpeakingAtBoundary:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619676-stopspeakingatboundary?language=objc)

Stops all speech at the specified boundary constraint.

在指定的边界约束处停止所有语音。

[outputChannels](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1648692-outputchannels?language=objc)

## Managing the Delegate 管理代理

[delegate](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer/1619709-delegate?language=objc)

The delegate object for the speech synthesizer.

语音合成器的代理对象。

## Constants 常量

[AVSpeechBoundary](https://developer.apple.com/documentation/avfoundation/avspeechboundary?language=objc)

Constraints describing when speech may be paused or stopped.

描述语音何时可以暂停或结束的约束。

# Relationships 关系

##Inherits From

NSObject

# See Also

##Speech Synthesis Controls

[AVSpeechSynthesizerDelegate](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizerdelegate?language=objc)

Methods you can implement to respond to events that occur during speech synthesis.

你可以实现的方法，用以响应语音合成过程中发生的事件。
