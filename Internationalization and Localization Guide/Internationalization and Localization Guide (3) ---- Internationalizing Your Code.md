# Internationalization and Localization Guide (3) ---- Internationalizing Your Code

原文地址：
[https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourCode/InternationalizingYourCode.html#//apple_ref/doc/uid/10000171i-CH4-SW1](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourCode/InternationalizingYourCode.html#//apple_ref/doc/uid/10000171i-CH4-SW1)

# 3 Internationalizing Your Code - 国际化你的代码

In addition to internationalizing your user interface, write code that handles text in multiple languages. First store international text in strings files similar to the strings files used by base internationalization in [Internationalizing the User Interface](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html#//apple_ref/doc/uid/10000171i-CH3-SW3). Also use language and locale-sensitive APIs for enumerating, searching, and sorting text in your code. Use standard text views for displaying and parsing text input as well. Let these APIs handle the complexity of different writing and input systems for you.

除了将你的用户界面国际化，还要写出处理多语言文本的代码。首先以字符串文件的方式保存国际化文本，类似于在《[Internationalizing the User Interface](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html#//apple_ref/doc/uid/10000171i-CH3-SW3)》中用于基础国际化的字符串文件。在你的代码中也会使用语言和位置敏感的 API 进行枚举、查找和排序。也会使用标准文本视图显示和粘贴文本输入。让这些 API 为你处理不同拼写和输入系统的复杂性。

## 3.1 Separating User-Facing Text from Your Code - 将面向用户的文本与你的代码分离

All user-facing text supplied by your app programmatically needs to be localized—that is, user-facing text that is not contained in `.storyboard` or `.xib` files, such as error messages, needs to be translated into the current language before it’s presented to the user. iOS and OS X provide a mechanism to retrieve localized text from strings files at runtime. In your code, replace strings containing user-facing text with the return value of an `NSLocalizedString` macro. When you export localizations, Xcode searches your code for the macros and includes the strings files in the exported localization file for translation. When you import localizations, Xcode adds the strings files, used by your code, to your Xcode project.

由你的 App 编程提供的所有面向用户的文本需要被本地化 —— 也就是，没有包含在 `.storyboard` 或 `.xib` 文件中的文本，比如错误消息，需要在展示给用户之前被翻译成当前语言。iOS 和 OS X 提供了一个机制在运行时从字符串文件中取回本地化的文本。在你的代码中，将包含面向用户的文本的字符串替换成一个 `NSLocalizedString` 宏的返回值。当你导出本地化时，Xcode 在你的代码中查找这个宏，并在导出的本地化文件中包含字符串文件以便翻译。当你导入本地化时，Xcode 添加被你的代码使用到的字符串文件到你的 Xcode 工程。

For example, instead of using the `@"26.22 miles"` string in your code, use:

例如，在你的代码中替换掉对 `@26.22 miles` 字符串的使用，使用：

	NSLocalizedString(@"RunningDistance", @"distance for a marathon")

where `@"RunningDistance"` is the key for text that is retrieved from a localized strings file. The `@"distance for a marathon"` parameter is a comment about the key-value pair stored in the strings file as a hint to localizers. If you want different behavior, use one of the other `NSLocalizedString` macros that take more parameters, described in _Foundation Functions Reference_.

在这里 `@"RunningDistance"` 是从已本地化的字符串文件中取回文本的 key。`@"distance for a marathon"` 参数是一个对储存在字符串文件中的键值对的评论，作为对本地化这的提示。如果你想要不同的行为，使用具有更多参数的其他 `NSLocalizedString` 宏，如《_Foundation Functions Reference_》中所述。

> **Tip:** Don’t overload keys or compose phrases from multiple keys. Some languages have gender articles, adjective endings, and completely different word order.   Instead, add a separate key-value pair to the strings file for all unique phrases.
>
>	**提示：**不要重载 key 或合成语法。某些语言有性别特色，形容词词尾，以及完全不同的拼写顺序。想反，可以为所有独立的语法添加与字符串文件分离键值对。
>
> For example, replace these key-value pairs:
> 
> 例如，替换这些键值对：
>
	/* Go to next page/chapter */
	"GoToNext" = "Go to next %@";
	"chapter" = "chapter";
	"page" = "page";
>
> with separate key-value pairs for each phrase:
> 
> 为每个语句使用单独的键值对：
>
	/* Go to next chapter */
	"GoToNextChapter" = "Go to next chapter";
	/* Go to next page */
	"GoToNextPage" = "Go to next page";

> Don’t put numbers in localizable strings because different regions can use different numbers.
> 
> 不要把数字放入可本地化的字符串中，因为不同的地区可以使用不同的数字。

You don’t need to store all your key-value pairs in the same strings files. You can use other `NSLocalizedString` macros to create separate strings files and optionally, store them in different bundles. For more information on `NSLocalizedString` macros, read [String Resources](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html#//apple_ref/doc/uid/10000051i-CH6) in [Resource Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/Introduction/Introduction.html#//apple_ref/doc/uid/10000051i).

你不需要存储所有键值对到相同的字符串文件。你也可以使用其他 `NSLocalizedString` 宏创建单独的字符串文件，并且可以选择性的把它们保存到不同的包里。关于 `NSLocalizedString` 宏的更多信息，请阅读《[Resource Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/Introduction/Introduction.html#//apple_ref/doc/uid/10000051i)》中的《[String Resources](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/Strings/Strings.html#//apple_ref/doc/uid/10000051i-CH6)》。

To retrieve a localized string from a strings file, rather than adding it to a strings file, use the [localizedStringForKey:value:table:](https://developer.apple.com/documentation/foundation/bundle/1417694-localizedstring) method in the [NSBundle](https://developer.apple.com/documentation/foundation/nsbundle) class. When the strings file corresponding to the specified table is not in your project, the `NSLocalizedString` macros and the [localizedStringForKey:value:table:](https://developer.apple.com/documentation/foundation/bundle/1417694-localizedstring) method return the value parameter as the localized string.

要从字符串文件中取回一个已本地化的字符串，而不是把它添加到字符串文件，使用 [NSBundle](https://developer.apple.com/documentation/foundation/nsbundle) 类的 [localizedStringForKey:value:table:](https://developer.apple.com/documentation/foundation/bundle/1417694-localizedstring) 方法。当指定 table 所对应的字符串文件不在你的工程中，`NSLocalizedString` 宏和 [localizedStringForKey:value:table:](https://developer.apple.com/documentation/foundation/bundle/1417694-localizedstring) 方法会返回 value 参数作为本地化的字符串。

Later, when you import localizations, as described in [Importing Localizations](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html#//apple_ref/doc/uid/10000171i-CH5-SW4), the localized strings files are added to your project. (Alternatively, you can generate the development language strings files from NSLocalizedString macros directly, as described in [Creating Strings Files for User-Facing Text in Your Code](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/MaintaingYourOwnStringsFiles/MaintaingYourOwnStringsFiles.html#//apple_ref/doc/uid/10000171i-CH19-SW1).)

然后，当你导入本地化，如《[Importing Localizations](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html#//apple_ref/doc/uid/10000171i-CH5-SW4)》中所述，已本地化的字符串文件会被添加到你的工程。（或者，你可以直接从 `NSLoalizedString` 宏生成开发语言字符串文件，如《[Creating Strings Files for User-Facing Text in Your Code](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/MaintaingYourOwnStringsFiles/MaintaingYourOwnStringsFiles.html#//apple_ref/doc/uid/10000171i-CH19-SW1)》中所述。）

If your strings contain plurals of nouns or units of measurement, read [Handling Noun Plurals and Units of Measurement](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html#//apple_ref/doc/uid/10000171i-CH5-SW10) for how to extend this mechanism for languages that have different plural rules.

如果你的字符串包含复数名词或者度量单位，阅读《[Handling Noun Plurals and Units of Measurement](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html#//apple_ref/doc/uid/10000171i-CH5-SW10)》了解如何为有不同复数规则的语言扩展这个机制。

## 3.2 Using Unicode Strings - 使用 Unicode 字符串

For all user-facing text, use string objects—instances of [NSString](https://developer.apple.com/documentation/foundation/nsstring), [NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring), and their subclasses—that support Unicode. Unicode is a standard for encoding characters from all the world’s writing systems. String objects encapsulate a Unicode string encoded in UTF-16 format. What the user sees as a character may be represented and encoded as multiple characters in a Unicode string. Therefore, use string methods that manipulate composed character sequences, not individual characters in a string. Use the appropriate string APIs for iteration, searching, and sorting too. Use standard views and controls that display Unicode string objects correctly.

对于所有面向用户的文本，使用字符串对象 —— [NSString](https://developer.apple.com/documentation/foundation/nsstring)、[NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring) 及它们的子类的实例 —— 它们支持 Unicode。Unicode 是一个为全世界的书写系统的文字编码的标准。字符串对象包含了一个以 UTF-16 格式编码的 Unicode 字符串。用户看到的一个字符在 Unicode 字符串中可能被表示或编码成多个字符。因此，使用操作成组的字符序列而不是字符串中的单个字符的字符串方法。也要使用合适的字符串 API 迭代、查找和排序。使用标准视图和空间将会正确的显示 Unicode 字符串对象。

For comprehensive documentation on string objects, read [String Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/introStrings.html#//apple_ref/doc/uid/10000035i).

关于字符串对象的全面文档，请阅读《[String Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/introStrings.html#//apple_ref/doc/uid/10000035i)》。

### 3.2.1 Accessing Characters in Strings - 在字符串中访问字符

The [NSString](https://developer.apple.com/documentation/foundation/nsstring) class handles the complexity of character encoding for you by allowing you to access character clusters or ranges. Use the [rangeOfComposedCharacterSequenceAtIndex:](https://developer.apple.com/documentation/foundation/nsstring/1416036-rangeofcomposedcharactersequence) and [rangeOfComposedCharacterSequencesForRange:](https://developer.apple.com/documentation/foundation/nsstring/1410993-rangeofcomposedcharactersequence) methods to ensure that you don’t split user characters in a string and break the text. These methods return a range within a string that represents the user character.

[NSString](https://developer.apple.com/documentation/foundation/nsstring) 类通过允许你访问字符数组或范围，为你处理了字符编码的复杂方面。使用 [rangeOfComposedCharacterSequenceAtIndex:](https://developer.apple.com/documentation/foundation/nsstring/1416036-rangeofcomposedcharactersequence) 和 [rangeOfComposedCharacterSequencesForRange:](https://developer.apple.com/documentation/foundation/nsstring/1410993-rangeofcomposedcharactersequence) 方法确保你不会分离字符串中的用户字符而破坏文本。这些方法会返回一个表示用户特征的的范围。

For example, Table 3-1 shows the numeric representation of user characters in UTF-16 and UTF-32 encoding. Note that the user characters have different lengths no matter what encoding format you use.

例如，表 3-1 展示了以 UTF-16 和 UTF-32 编码的用户字符的数字表示。注意用户字符有不同的长度，不管你使用的什么编码格式。

Table 3-1  Unicode Encoding of User Characters - 用户字符的 Unicode 编码

|User Character|UTF-16|UTF-32
|:-:|:-:|:-:|
|![chinese_string_table.svg](images/chinese_string_table.svg)|D85E DFFD|27BFD|
|![korean_string_table.svg](images/korean_string_table.svg)|1100 1161 11A8|01100 01161 011A8|

> **Video:** [WWDC 2013 Making Your App World-Ready: International Text > Composed Character Sequences](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=47:30,48:20)
> 
> **视频:** [WWDC 2013 让你的 App 准备好面向世界：国际文本 > 组合的字符序列](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=47:30,48:20)

#### 3.2.1.1 Enumerating Strings - 枚举字符串

Enumerate strings by composed character sequence, word, sentence, or paragraph, not individual characters in a string. To enumerate a string by composed character sequence, use the [enumerateSubstringsInRange:options:usingBlock:](https://developer.apple.com/documentation/foundation/nsstring/1416774-enumeratesubstringsinrange) method and pass [NSStringEnumerationByComposedCharacterSequences](https://developer.apple.com/documentation/foundation/nsstring.enumerationoptions/1407290-bycomposedcharactersequences) as the options parameter. To enumerate a string by word (skipping over punctuation), pass [NSStringEnumerationByWords](https://developer.apple.com/documentation/foundation/nsstringenumerationoptions/nsstringenumerationbywords) as the options parameter.

用组合的字符序列、单词、句子或段落枚举字符串，而不是字符串中的单个字符。要用组合的字符序列枚举一个字符串，使用 [enumerateSubstringsInRange:options:usingBlock:](https://developer.apple.com/documentation/foundation/nsstring/1416774-enumeratesubstringsinrange) 方法，并传入 [NSStringEnumerationByComposedCharacterSequences](https://developer.apple.com/documentation/foundation/nsstring.enumerationoptions/1407290-bycomposedcharactersequences) 作为选项参数。要用单词枚举一个字符串（跳过标点），传入 [NSStringEnumerationByWords](https://developer.apple.com/documentation/foundation/nsstringenumerationoptions/nsstringenumerationbywords)
作为选项参数。

For example, if you pass [NSStringEnumerationByComposedCharacterSequences](https://developer.apple.com/documentation/foundation/nsstring.enumerationoptions/1407290-bycomposedcharactersequences) to the [enumerateSubstringsInRange:options:usingBlock:](https://developer.apple.com/documentation/foundation/nsstring/1416774-enumeratesubstringsinrange) method, it returns the user characters, as in the composed character sequences:

例如，如果你把 [NSStringEnumerationByComposedCharacterSequences](https://developer.apple.com/documentation/foundation/nsstring.enumerationoptions/1407290-bycomposedcharactersequences) 传给 [enumerateSubstringsInRange:options:usingBlock:](https://developer.apple.com/documentation/foundation/nsstring/1416774-enumeratesubstringsinrange) 方法，它会按照组合的字符序列返回用户字符：

![chinese_string_table.svg](images/chinese_string_table.svg) </br>
![korean_string_table.svg](images/korean_string_table.svg)

If the string is

如果字符串是

![enumerating_strings.svg](images/enumerating_strings.svg)

and you pass [NSStringEnumerationByWords](https://developer.apple.com/documentation/foundation/nsstringenumerationoptions/nsstringenumerationbywords) as the options parameter, the following words are returned:

并且如果你传入 [NSStringEnumerationByWords](https://developer.apple.com/documentation/foundation/nsstringenumerationoptions/nsstringenumerationbywords) 
作为 options 参数，将会返回下列文字：

![enumerating_word_1.svg](images/enumerating_word_1.svg) </br>
![enumerating_word_2.svg](images/enumerating_word_2.svg) </br>
![enumerating_word_3.svg](images/enumerating_word_3.svg) </br>
![enumerating_word_4.svg](images/enumerating_word_4.svg)

Notice that spaces and punctuation are not included in the words.

注意空格和标点没有包含在句子中。

> **Video:** [WWDC 2013 Making Your App World-Ready: International Text > String APIs: Iteration](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=48:21,49:28)
>
> **视频：** [WWDC 2013 让你的 App 准备好面向世界 > 字符串 API：迭代](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=48:21,49:28)

#### 3.2.1.2 Searching Strings - 查找字符串

To search the contents of a string or verify the presence of a string within a string using locale-sensitive comparison algorithms, use the [rangeOfString:options:range:locale:](https://developer.apple.com/documentation/foundation/nsstring/1417348-rangeofstring) method, passing the current locale as the locale parameter. The constants you can combine and pass as the options parameter are:

要使用地区敏感的比较算法查找字符串的内容或者验证字符串中的字符串是否存在，使用 [rangeOfString:options:range:locale:](https://developer.apple.com/documentation/foundation/nsstring/1417348-rangeofstring) 方法，传入当前地区作为 locale 参数。你可以使用并传入作为 options 参数的常量有：

[NSCaseInsensitiveSearch](https://developer.apple.com/documentation/foundation/nsstringcompareoptions/nscaseinsensitivesearch)

Case-insensitive search. For example, `‘B’` is the same as `‘b’`.

大小写不敏感的搜索。例如，认为`‘B’`与`‘b’`是相同的。

[NSDiacriticInsensitiveSearch](https://developer.apple.com/documentation/foundation/nsstring.compareoptions/1412313-diacriticinsensitive)

Ignores diacritic marks. For example, `‘ö’` is equal to `‘o’`.

忽略变音符标记。例如，认为`‘ö’`与`‘o’`是相等的。

[NSBackwardsSearch](https://developer.apple.com/documentation/foundation/nsstring.compareoptions/1415204-backwards)

Search backwards. (The default is forwards.)

从后往前搜索。（默认是从前往后。）

[NSAnchoredSearch](https://developer.apple.com/documentation/foundation/nsstringcompareoptions/nsanchoredsearch)

Search at the starting point.

从一个开始点搜索。

For example, if you are searching for user text in a string, pass the [NSCaseInsensitiveSearch](https://developer.apple.com/documentation/foundation/nsstringcompareoptions/nscaseinsensitivesearch) and [NSDiacriticInsensitiveSearch](https://developer.apple.com/documentation/foundation/nsstring.compareoptions/1412313-diacriticinsensitive) constants as the options parameter to the [rangeOfString:options:range:locale:](https://developer.apple.com/documentation/foundation/nsstring/1417348-rangeofstring) method. Typically, searching text is a case and diacritic insensitive operation, but sorting text is case and diacritic sensitive.

例如，如果你在一个字符串中搜索用户文本，给 [rangeOfString:options:range:locale:](https://developer.apple.com/documentation/foundation/nsstring/1417348-rangeofstring) 方法传入 [NSCaseInsensitiveSearch](https://developer.apple.com/documentation/foundation/nsstringcompareoptions/nscaseinsensitivesearch) 和 [NSDiacriticInsensitiveSearch](https://developer.apple.com/documentation/foundation/nsstring.compareoptions/1412313-diacriticinsensitive) 常量作为 options 参数。一般，搜索文本是一个大小写和变音符不敏感操作，但排序文本就是一个大小写和变音符敏感操作。

#### 3.2.1.3 Sorting Strings - 排序字符串

For text you display to users, use locale-sensitive APIs for sorting and comparing strings. Different languages and regions have different sort order standards. For example, in French the diacritics are significant, and in English they are not. In some languages multiple letters are combined and affect the sort order.

对于你显示给用户的文本，使用地区敏感的 API 搜索和比较字符串。不同的语言和区域有不同的排序标准。例如，在法语中变音符是重要的，而在英语中不是。在某些语言中，多个字母是联合的并影响排序。

To use the locale-sensitive comparison algorithms, use the [localizedStandardCompare:](https://developer.apple.com/documentation/foundation/nsstring/1409742-localizedstandardcompare) method which produces the same results as the Finder.

要使用地区敏感的比较算法，使用 [localizedStandardCompare:](https://developer.apple.com/documentation/foundation/nsstring/1409742-localizedstandardcompare) 方法，它会产生与 Finder 相同的结果。

If you don’t want the same results as the Finder, use the [compare:options:range:locale:](https://developer.apple.com/documentation/foundation/nsstring/1414561-compare) method, passing the current locale as the locale parameter, or the [localizedCompare:](https://developer.apple.com/documentation/foundation/nsstring/1416999-localizedcompare) method.

如果你不想要与 Finder 相同的结果，使用 [compare:options:range:locale:](https://developer.apple.com/documentation/foundation/nsstring/1414561-compare) 方法并传入当前地区作为 locale 参数，或使用 [localizedCompare:](https://developer.apple.com/documentation/foundation/nsstring/1416999-localizedcompare) 方法。

Don’t use the [localizedCaseInsensitiveCompare:](https://developer.apple.com/documentation/foundation/nsstring/1417333-localizedcaseinsensitivecompare) method for sorting.

不要使用 [localizedCaseInsensitiveCompare:](https://developer.apple.com/documentation/foundation/nsstring/1417333-localizedcaseinsensitivecompare) 方法进行排序。

> **Video:** [WWDC 2013 Making Your App World-Ready: International Text > String APIs: Sorting](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=51:15,51:50)
> 
> **视频：** [WWDC 2013 让你的 App 准备好面向世界 > 字符串API：排序](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=51:15,51:50)
 
#### 3.2.1.4 Displaying Text - 显示字符串

Use standard views and controls that handle the complexity of Unicode text layout and display for you. Characters in a string do not directly correspond to text rendered on the screen. What appears on the screen is a sequence of glyphs. A glyph is the smallest displayable unit in a font. A glyph may represent one character, more than one character, or part of a character. The mapping of characters to glyphs is not simple—it can be many-to-many. In addition, the order and position of glyphs in a line is complex. The standard views and controls even lay out bidirectional text properly for you—for example, the order of characters in a string containing an English word followed by a Hebrew word is not the same order used to lay out the text in a view, as described in [Handling Bidirectional Text](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/SupportingRight-To-LeftLanguages/SupportingRight-To-LeftLanguages.html#//apple_ref/doc/uid/10000171i-CH17-SW4).

使用标准视图和控件可以处理复杂的 Unicode 文本，为你进行布局和显示。字符串中的字符不会直接对应到在屏幕中渲染的文本。在屏幕中出现的是一串象形符号。字符到象形符号之间并不是简单的映射 —— 它可能是多对多的。另外，象形符号在一行中的顺序和位置也是复杂的。标准视图和控件甚至可以为你正确的布局两个方向的文本 —— 例如，一个包含希伯来语单词和英语单词的字符串中的字符顺序就以不同的顺序在视图中布局文本，如 [Handling Bidirectional Text](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/SupportingRight-To-LeftLanguages/SupportingRight-To-LeftLanguages.html#//apple_ref/doc/uid/10000171i-CH17-SW4) 中所述。

If you need to write custom display code, use the appropriate low-level text APIs. To learn about the text classes for iOS, read [Text Programming Guide for iOS](https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009542) and for Mac, read [Text Layout Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/TextLayout/TextLayout.html#//apple_ref/doc/uid/10000158i).

如果你需要编写自定义显示代码，使用合适的低级文本 API。要学习 iOS 上的文本类，阅读《[Text Programming Guide for iOS](https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009542)》，而 Mac 上的文本类，阅读《[Text Layout Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/TextLayout/TextLayout.html#//apple_ref/doc/uid/10000158i)》。

#### 3.2.1.5 Parsing Text Input - 粘贴文本输入

The user might enter text in any language and format. iOS and OS X can recognize the language the user is typing and provide the appropriate keyboard options. If you are parsing text as the user enters it, keep in mind that there’s a many-to-many mapping from keyboard characters to language characters.

用户可能以任何语言和格式输入文本。iOS 和 OS X 可以识别用户正在输入的语言，并提供合适的键盘选项。如果你在用户输入时粘贴文本，始终记住从键盘字符到语言字符有一个多对多的映射。

##### 3.2.1.5.1 Parsing Language Characters - 粘贴语言字符

For some languages, the user doesn’t enter text one character at a time. That is, keys the user presses on a keyboard don’t necessarily correspond to characters in the language. In French, the user adds an accent at the insertion point by choosing it from a pop-up menu. In Japanese and Chinese languages, the user enters phonetic representations and selects a candidate from the candidate list to confirm the marked text. In both cases, preliminary text is inserted first and then converted to final text when the user confirms it.

对于某些语言，用户不会一次输入一个文本字符。也就是说，用户在键盘上按下的键不一定对应该语言中的字符。在法语中，用户可以通过从弹出菜单选择将口音添加到插入点。在日语和汉语中，用户输入拼音并从候选列表中选择一个候选词确认想要的文本。在这两个例子中，都是首先插入一个初步的文本，然后当用户确认时在转换成最终的文本。

> **Video:** [WWDC 2013 Making Your App World-Ready: International Text > Text Input](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=54:33,56:02)
> 
> **视频：** [WWDC 2013 让你的 App 准备好面向世界：国际化文本 > 文本输入](http://devstreaming.apple.com/videos/wwdc/2013/219xax4xjor8i6b9h77lafay32/219/ref.mov#t=54:33,56:02)

##### 3.2.1.5.2 Determining When the User Confirms Marked Text (iOS Only) - 当用户确认想要的文本时再决定（仅 iOS）

To determine if the user confirmed marked text, send [markedTextRange](https://developer.apple.com/documentation/uikit/uitextinput/1614489-markedtextrange) to a text view. If this method returns an empty string, the user confirmed some entered text.

要决定用户是否确认想要的文本，把 [markedTextRange](https://developer.apple.com/documentation/uikit/uitextinput/1614489-markedtextrange) 发送到文本视图。如果该方法返回一个空字符串，用户就已经确认了一些输入的文本。

##### 3.2.1.5.3 Determining the Typed Language (iOS Only) - 决定输入的语言（仅 iOS）

To get the language that the user is currently typing, use the [textInputMode](https://developer.apple.com/documentation/uikit/uiresponder/1621133-textinputmode) property in the [UIResponder](https://developer.apple.com/documentation/uikit/uiresponder) class, as in:

要获得用户当前输入的语言，使用 [UIResponder](https://developer.apple.com/documentation/uikit/uiresponder) 类的 [textInputMode](https://developer.apple.com/documentation/uikit/uiresponder/1621133-textinputmode) 属性，如：

```
NSString *languageID = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
```

The returned string is a language ID, as described in [Language and Locale IDs](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html#//apple_ref/doc/uid/10000171i-CH15-SW1), that identifies a written language or dialect.

返回的字符串是一个语言 ID，描述见《[Language and Locale IDs](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html#//apple_ref/doc/uid/10000171i-CH15-SW1)》，这标识了书写的语言或方言。

To get the set of languages that the user enables:

要获得用户启用的语言集合使用如下方法：

```
NSArray *languages = [[[UIApplication sharedApplication] textInputMode] activeInputModes];
```

where the returned array contains instances of the [UITextInputMode](https://developer.apple.com/documentation/uikit/uitextinputmode) class.

这里返回的数组包含了 [UITextInputMode](https://developer.apple.com/documentation/uikit/uitextinputmode) 类的实例。

## 3.3 Detecting Personal Names, Mailing Addresses, and Phone Numbers - 检测用户名、邮箱地址和电话号码

Worldwide, the format of personal names, mailing addresses, and phone numbers varies considerably. Personal names have many different formats including different ordering of the components. For example, in Asian countries, the family name is followed by the given name with no spaces between. The format of mailing addresses depends on the country. Phone numbers have different amounts of digits and punctuation between them. To handle varying input formats in your text views, use Interface Builder to add data detectors to your text views. A data detector identifies addresses and phone numbers in many different international formats and optionally turns them into links.

世界范围内的，人名、邮箱和电话号码的格式都相当不同。人名有不同的格式，包括组成部分的不同顺序。例如，在亚洲国家，姓后面跟着名，中间没有空格。邮件地址的格式取决于国家。电话号码有大量不同的数字和标点。要在你的文本视图中处理不同的输入格式，使用 Interface Builder 添加数据探测器到你的文本视图。数据探测是会识别多种不同语言的地址和电话号码，并可选的将其换成链接。

To detect this type of data in strings programmatically, read [NSDataDetector Class Reference](https://developer.apple.com/documentation/foundation/nsdatadetector).

如果要编程探测字符串中的数据的格式，阅读 [NSDataDetector Class Reference](https://developer.apple.com/documentation/foundation/nsdatadetector)。

## 3.4 Getting the Current Language - 获取当前语言

To get the language that the app is using from the main application bundle, use the [preferredLocalizations](https://developer.apple.com/documentation/foundation/bundle/1413220-preferredlocalizations) method in the [NSBundle](https://developer.apple.com/documentation/foundation/bundle) class:

要从主应用包中获取 App 正在使用的语言。使用 [NSBundle](https://developer.apple.com/documentation/foundation/bundle) 类中的 [preferredLocalizations](https://developer.apple.com/documentation/foundation/bundle/1413220-preferredlocalizations) 方法。

```
NSString *languageID = [[NSBundle mainBundle] preferredLocalizations].firstObject;
```
