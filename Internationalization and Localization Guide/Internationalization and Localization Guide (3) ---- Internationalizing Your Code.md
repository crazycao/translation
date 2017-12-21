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

For all user-facing text, use string objects—instances of NSString, NSAttributedString, and their subclasses—that support Unicode. Unicode is a standard for encoding characters from all the world’s writing systems. String objects encapsulate a Unicode string encoded in UTF-16 format. What the user sees as a character may be represented and encoded as multiple characters in a Unicode string. Therefore, use string methods that manipulate composed character sequences, not individual characters in a string. Use the appropriate string APIs for iteration, searching, and sorting too. Use standard views and controls that display Unicode string objects correctly.

For comprehensive documentation on string objects, read String Programming Guide.

Accessing Characters in Strings
The NSString class handles the complexity of character encoding for you by allowing you to access character clusters or ranges. Use the rangeOfComposedCharacterSequenceAtIndex: and rangeOfComposedCharacterSequencesForRange: methods to ensure that you don’t split user characters in a string and break the text. These methods return a range within a string that represents the user character.

For example, Table 3-1 shows the numeric representation of user characters in UTF-16 and UTF-32 encoding. Note that the user characters have different lengths no matter what encoding format you use.

Table 3-1  Unicode Encoding of User Characters
User Character
UTF-16
UTF-32
../Art/chinese_string_table.svg
D85E DFFD
27BFD
../Art/korean_string_table.svg
1100 1161 11A8
01100 01161 011A8
Video: WWDC 2013 Making Your App World-Ready: International Text > Composed Character Sequences
Enumerating Strings
Enumerate strings by composed character sequence, word, sentence, or paragraph, not individual characters in a string. To enumerate a string by composed character sequence, use the enumerateSubstringsInRange:options:usingBlock: method and pass NSStringEnumerationByComposedCharacterSequences as the options parameter. To enumerate a string by word (skipping over punctuation), pass NSStringEnumerationByWords as the options parameter.

For example, if you pass NSStringEnumerationByComposedCharacterSequences to the enumerateSubstringsInRange:options:usingBlock: method, it returns the user characters, as in the composed character sequences:

../Art/chinese_string_table.svg
../Art/korean_string_table.svg
If the string is

../Art/enumerating_strings.svg
and you pass NSStringEnumerationByWords as the options parameter, the following words are returned:

../Art/enumerating_word_1.svg
../Art/enumerating_word_2.svg
../Art/enumerating_word_3.svg
../Art/enumerating_word_4.svg
Notice that spaces and punctuation are not included in the words.

Video: WWDC 2013 Making Your App World-Ready: International Text > String APIs: Iteration
Searching Strings
To search the contents of a string or verify the presence of a string within a string using locale-sensitive comparison algorithms, use the rangeOfString:options:range:locale: method, passing the current locale as the locale parameter. The constants you can combine and pass as the options parameter are:

NSCaseInsensitiveSearch
Case-insensitive search. For example, ‘B’ is the same as ‘b’.
NSDiacriticInsensitiveSearch
Ignores diacritic marks. For example, ‘ö’ is equal to ‘o’.
NSBackwardsSearch
Search backwards. (The default is forwards.)
NSAnchoredSearch
Search at the starting point.
For example, if you are searching for user text in a string, pass the NSCaseInsensitiveSearch and NSDiacriticInsensitiveSearch constants as the options parameter to the rangeOfString:options:range:locale: method. Typically, searching text is a case and diacritic insensitive operation, but sorting text is case and diacritic sensitive.

Sorting Strings
For text you display to users, use locale-sensitive APIs for sorting and comparing strings. Different languages and regions have different sort order standards. For example, in French the diacritics are significant, and in English they are not. In some languages multiple letters are combined and affect the sort order.

To use the locale-sensitive comparison algorithms, use the localizedStandardCompare: method which produces the same results as the Finder.

If you don’t want the same results as the Finder, use the compare:options:range:locale: method, passing the current locale as the locale parameter, or the localizedCompare: method.

Don’t use the localizedCaseInsensitiveCompare: method for sorting.

Video: WWDC 2013 Making Your App World-Ready: International Text > String APIs: Sorting
Displaying Text
Use standard views and controls that handle the complexity of Unicode text layout and display for you. Characters in a string do not directly correspond to text rendered on the screen. What appears on the screen is a sequence of glyphs. A glyph is the smallest displayable unit in a font. A glyph may represent one character, more than one character, or part of a character. The mapping of characters to glyphs is not simple—it can be many-to-many. In addition, the order and position of glyphs in a line is complex. The standard views and controls even lay out bidirectional text properly for you—for example, the order of characters in a string containing an English word followed by a Hebrew word is not the same order used to lay out the text in a view, as described in Handling Bidirectional Text.

If you need to write custom display code, use the appropriate low-level text APIs. To learn about the text classes for iOS, read Text Programming Guide for iOS and for Mac, read Text Layout Programming Guide.

Parsing Text Input
The user might enter text in any language and format. iOS and OS X can recognize the language the user is typing and provide the appropriate keyboard options. If you are parsing text as the user enters it, keep in mind that there’s a many-to-many mapping from keyboard characters to language characters.

Parsing Language Characters

For some languages, the user doesn’t enter text one character at a time. That is, keys the user presses on a keyboard don’t necessarily correspond to characters in the language. In French, the user adds an accent at the insertion point by choosing it from a pop-up menu. In Japanese and Chinese languages, the user enters phonetic representations and selects a candidate from the candidate list to confirm the marked text. In both cases, preliminary text is inserted first and then converted to final text when the user confirms it.

Video: WWDC 2013 Making Your App World-Ready: International Text > Text Input
Determining When the User Confirms Marked Text (iOS Only)

To determine if the user confirmed marked text, send markedTextRange to a text view. If this method returns an empty string, the user confirmed some entered text.

Determining the Typed Language (iOS Only)

To get the language that the user is currently typing, use the textInputMode property in the UIResponder class, as in:

NSString *languageID = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
The returned string is a language ID, as described in Language and Locale IDs, that identifies a written language or dialect.

To get the set of languages that the user enables:

NSArray *languages = [[[UIApplication sharedApplication] textInputMode] activeInputModes];
where the returned array contains instances of the UITextInputMode class.

Detecting Personal Names, Mailing Addresses, and Phone Numbers

Worldwide, the format of personal names, mailing addresses, and phone numbers varies considerably. Personal names have many different formats including different ordering of the components. For example, in Asian countries, the family name is followed by the given name with no spaces between. The format of mailing addresses depends on the country. Phone numbers have different amounts of digits and punctuation between them. To handle varying input formats in your text views, use Interface Builder to add data detectors to your text views. A data detector identifies addresses and phone numbers in many different international formats and optionally turns them into links.

To detect this type of data in strings programmatically, read NSDataDetector Class Reference.

Getting the Current Language

To get the language that the app is using from the main application bundle, use the preferredLocalizations method in the NSBundle class:

NSString *languageID = [[NSBundle mainBundle] preferredLocalizations].firstObject;