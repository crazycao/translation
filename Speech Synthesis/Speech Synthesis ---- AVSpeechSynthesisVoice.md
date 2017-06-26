# Speech Synthesis ---- AVSpeechSynthesisVoice

原文地址：
[https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice?language=objc](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice?language=objc)

# AVSpeechSynthesisVoice

A distinct voice for use in speech synthesis.

语音合成中使用的独特的声音。

# Overview

Voices are distinguished primarily by language, locale, and quality.

声音主要由语言、地域和质量来区分。

You can use this class to select a voice appropriate to the language of text to be spoken, or to select a voice exhibiting a particular local variant of that language (such as Australian or South African English).

你可以使用这个类来选择一个声音以适应文本的语言，或者选择一个声音来展现该语言的特殊地域变体（如澳大利亚英语或南非英语）。

To select a voice for use in speech, obtain an `AVSpeechSynthesisVoice` instance using one of the methods in [Finding Voices](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice#1668668?language=objc), and then set it as the value of the [voice](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619710-voice?language=objc) property on an [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) instance containing text to be spoken.

要在语音中选择使用的声音，使用 [Finding Voices](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice#1668668?language=objc) 中的一个方法获得一个`AVSpeechSynthesisVoice`实例，然后在包含要说的文本的 [AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc) 实例中将其设置为 [voice](https://developer.apple.com/documentation/avfoundation/avspeechutterance/1619710-voice?language=objc) 属性的值。

# Topics 标题

## Finding Voices 找到声音

[+ voiceWithIdentifier:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619711-voicewithidentifier?language=objc)

[+ voiceWithLanguage:](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619699-voicewithlanguage?language=objc)

Returns a voice object for the specified language and locale.

为特定的语言和地域返回一个声音对象。

[+ speechVoices](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619697-speechvoices?language=objc)

Returns all available speech voices.

返回所有可用的语音声音。

[AVSpeechSynthesisVoiceIdentifierAlex](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoiceidentifieralex?language=objc)

[AVSpeechSynthesisVoiceQuality](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoicequality?language=objc)

## Identifying Voices 辨认声音

[identifier](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619670-identifier?language=objc)

[name](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619669-name?language=objc)

[quality](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619688-quality?language=objc)

## Working with Language Codes 用语言代码工作

[+ currentLanguageCode](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619707-currentlanguagecode?language=objc)

Returns the code for the user’s current locale.

返回用户当前地域的代码。

[language](https://developer.apple.com/documentation/avfoundation/avspeechsynthesisvoice/1619698-language?language=objc)

A BCP-47 code identifying the voice’s language and locale.

辨别声音的语言和地域的 BCP-47 代码。

# Relationships 关系

## Inherits From

NSObject

##Conforms To

NSSecureCoding

# See Also 其他参考

## Spoken Text Attributes 口语文本属性

[AVSpeechUtterance](https://developer.apple.com/documentation/avfoundation/avspeechutterance?language=objc)

A chunk of text to be spoken, along with parameters that affect its speech.

一块要说文本，连同影响其语音的参数。

