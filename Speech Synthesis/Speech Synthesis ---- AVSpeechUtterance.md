# Speech Synthesis ---- AVSpeechUtterance

原文地址：
[https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc)

# AVSpeechUtterance

A chunk of text to be spoken, along with parameters that affect its speech.

一块要说文本，连同影响其语音的参数。

# Overview 概述

An `AVSpeechUtterance` object is the basic unit of speech synthesis.

`AVSpeechUtterance`对象是语音合成的基本单元。

To synthesize speech, you must:

要合成语音，你必须：

1. Create an `AVSpeechUtterance` instance containing the text to be spoken. (See [Creating an Utterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance#1668645?language=objc).)
2. (Optional) Change its voice, rate, or other parameters. (See [Configuring Utterance Speech](https://developer.apple.com/documentation/avfoundation/avspeechutterance#1668693?language=objc).)
3. Pass the utterance to an [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc) instance to begin speech (or enqueue the utterance to be spoken later if the synthesizer is already speaking).

>

1. 创建一个包含要说的文本的`AVSpeechUtterance`实例。（见《[Creating an Utterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance#1668645?language=objc)》。）
2. （可选）改变其声音、速度或其他参数。（见《[Configuring Utterance Speech](https://developer.apple.com/documentation/avfoundation/avspeechutterance#1668693?language=objc)》。）
3. 将语句传递给一个[AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer?language=objc)实例以开始播放语音（或者如果合成器已经正在说话时就将要说的语句放入队列）。

You may choose whether and how to split a body of text into multiple utterances for speech. Because an utterance can control speech parameters, you can split text into sections that require different parameters. For example, you can emphasize a sentence by increasing the pitch and decreasing the rate of that utterance relative to others, or you can introduce pauses between sentences by putting each one into an utterance with a leading or trailing delay. Because the speech synthesizer sends messages to its delegate as it starts or finishes speaking an utterance, you can create an utterance for each meaningful unit in a longer text in order to be notified as its speech progresses.

你可以选择是否及如何将一些文本拆分成多个语句来转成语音。因为语句可以控制语音参数，你可以将文本拆分成需要不同参数的部分。例如，你可以通过增加音高并降低其他语句的速度来强调一个句子，或者可以通过在每个语句的之前或之后放入延迟来引入停顿。因为语音合成器在开始或结束朗读一个语句的时候会发送消息到其代理，为长文本中每个有意义的单元创建一个语句，以便随着其语音进展得到通知。

# Topics

## Creating an Utterance 创建一个语句

 [- initWithString:](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619684-initwithstring?language=objc)

Initializes an utterance object with text to be spoken.

用要说的文本初始化一个语句对象。

[+ speechUtteranceWithString:](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619668-speechutterancewithstring?language=objc)

Creates an utterance object with text to be spoken.

用要说的文本创建一个语句对象。

[- initWithAttributedString:](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1648776-initwithattributedstring?language=objc)

[+ speechUtteranceWithAttributedString:](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1649801-speechutterancewithattributedstr?language=objc)

[AVSpeechSynthesisIPANotationAttribute](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisipanotationattribute?language=objc)

## Configuring Utterance Speech 配置语句语音

[pitchMultiplier](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619683-pitchmultiplier?language=objc)

The baseline pitch at which the utterance will be spoken.

语句被说出的底线音调。

[postUtteranceDelay](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619694-postutterancedelay?language=objc)

The amount of time a speech synthesizer will wait after the utterance is spoken before handling the next queued utterance.

在已说完的语句之后，在处理下一条已排队的语句之前，语音合成器将等待的时间。

[preUtteranceDelay](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619679-preutterancedelay?language=objc)

The amount of time a speech synthesizer will wait before actually speaking the utterance upon beginning to handle it.

当开始处理语句的时候，在实际说出它之前，语音合成器将等待的时间。

[rate](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619708-rate?language=objc)

The rate at which the utterance will be spoken.

语句将被说出的速度。

[voice](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619710-voice?language=objc)

The voice used to speak the utterance.

用于说出语句的声音。

[volume](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619687-volume?language=objc)

The volume used when speaking the utterance.

在说出语句时使用的音量。

## Accessing Utterance Text 访问语句文本

[speechString](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619702-speechstring?language=objc)

The text to be spoken in the utterance.

在语句中被说出的文本。

[attributedSpeechString](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1648723-attributedspeechstring?language=objc)

## Speech Rate Constants 语音速度常量

Allowed rates for synthesized speech.

合成的语音能用的速度。

[AVSpeechUtteranceMinimumSpeechRate](https://developer.apple.com/documentation/avfoundation/avspeechutteranceminimumspeechrate?language=objc)

The minimum allowed speech rate.

最低允许的语音速度。

[AVSpeechUtteranceMaximumSpeechRate](https://developer.apple.com/documentation/avfoundation/avspeechutterancemaximumspeechrate?language=objc)

The maximum allowed speech rate.

最高允许的语音速度。

[AVSpeechUtteranceDefaultSpeechRate](https://developer.apple.com/documentation/avfoundation/avspeechutterancedefaultspeechrate?language=objc)

The default rate at which an utterance is spoken unless its `rate` property is changed.

语句被说出的默认速度，除非它的`rate`属性被改变了。

# Relationships 关系

## Inherits From

NSObject

## Conforms To

NSCopying, NSSecureCoding

# See Also 其他参见

## Spoken Text Attributes 口语文本属性

[AVSpeechSynthesisVoice](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice?language=objc)

A distinct voice for use in speech synthesis.

在语音合成中使用的独特的声音。
