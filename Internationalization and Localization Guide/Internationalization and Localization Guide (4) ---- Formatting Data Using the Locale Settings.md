# Internationalization and Localization Guide (4) ---- Formatting Data Using the Locale Settings

原文地址：
[https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingLocaleData/InternationalizingLocaleData.html](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingLocaleData/InternationalizingLocaleData.html)

# 4 Formatting Data Using the Locale Settings - 使用定位设置格式化数据

Different countries and regions have different conventions for formatting numerical and time-based information. Locale settings provide information about the formats used by the current user and must be considered when writing code that handles user-facing data types. The user sets the locale by choosing a region in Settings on iOS devices and System Preferences on a Mac. The user can also change locale settings while the app is running. Therefore, if you manipulate data objects in your code and then present them to the user, use the locale APIs to format the data correctly.

不同的国家和地区在格式化数字的和基于时间的信息上有不同的习俗。定位设置提供了关于当前用户使用的并且当撰写处理面向用户的数据类型的代码时必须考虑的格式信息。用户通过在 iOS 设备上的 Settings 应用和 Mac 上的 System Preferences 应用中选择地区来设置定位。用户也可以在 APP 运行中修改定位设置。因此，如果你在代码中操作了数据对象，然后再把它们展示给用户，要正确的使用定位 API 来格式化数据。

You do not need to know how to format data in all the different locales. You can use preset styles that automatically generate locale-sensitive formats. You can use custom formats as long as you convert them to locale-sensitive formats before presenting them to users. This chapter explains how to write locale-sensitive code.

你不需要知道在所有不同的定位是如何格式化数据的。你可以预设样式自动生成定位敏感的格式。你可以使用自定义的格式，也可以在把它们展示给用户之前把它们转换成定位敏感的格式。本章解释了如何编写定位敏感的代码。

## 4.1 About Locale Formats - 关于定位格式

Locales represent the formatting choices for a particular user, not the user’s preferred language. These are often the same but can be different. For example, a native English speaker who lives in Germany might select English as the language and Germany as the region. Text appears in English but dates, times, and numbers follow German formatting rules. The day precedes the month and a 24-hour clock represents times, as shown in Table 4-1.

定位代表了一个特定用户的格式选择，而不是用户偏好的语言。它们通常是一样的，但也可能不同。例如，一个本地的说英语的人生活在德国，他就可能选择英语作为语言而选择德国作为地区。文本就会以英语出现，但日期、时间和数字都会遵从德语格式规则。日期在月份之前，并且以24小时展示时间，如表 4-1 所示。

Table 4-1  Data formats in United States and Germany  - 美国和德国的数据格式

|Language (Region)|Dates|Times|Numbers|
|:-:|:-:|:-:|:-:|
|English (United States)|Sunday, January 5, 2014 </br> 1/5/14|7:08:09 AM PST</br>7:08 AM|1,234.56 </br> $4,567.89|
|English (Germany)|Sunday 5 January 2014</br>05/01/14|07:08:09 PST</br>07:08|1.234,56</br>€4.567,89|

On a Mac, you can preview modified locale preferences in System Preferences. When you choose a geographic region from the Region pop-up menu, samples of the date, time, and number formats appear. This screenshot shows sample data formats when English is the language and Japan is the region:

在 Mac 上，你可以在 System Preferences 中预览修改后的定位偏好。当你从 Region 弹出菜单中选择一个地理区域，日期、时间和数字的格式示例就会出现。这个截图展示了选择语言为英语且地区为日本的示例数据格式：

![mac_region_settings_english_japan_2x.png](images/mac_region_settings_english_japan_2x.png)

Mac users can also customize the formats of dates, times, and numbers by clicking the Advanced button, as described in [Reviewing Language and Region Preferences on Your Mac](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/SpecifyingPreferences/SpecifyingPreferences.html#//apple_ref/doc/uid/10000171i-CH12-SW3).

Mac 用户可以自定义日期、时间和数字的格式，只要点击 Advanced 按钮，如《[Reviewing Language and Region Preferences on Your Mac](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/SpecifyingPreferences/SpecifyingPreferences.html#//apple_ref/doc/uid/10000171i-CH12-SW3)》中所述。

## 4.2 Using the Locale Object - 使用定位对象

An NSLocale object encapsulates information about the formatting standards of a particular region. When you format user-facing text, you pass an NSLocale object representing the user’s selected region. The NSLocale class provides class methods for obtaining the user’s locale object and other information about supported locales.

Getting the User’s Locale
You can obtain the user’s locale using either the currentLocale or autoupdatingCurrentLocale class methods in the NSLocale class.

If you use the currentLocale method, the property values of the returned object are guaranteed not to change. Therefore, use the currentLocale method if you want to perform operations that need to be consistent.

If you use the autoupdatingCurrentLocale method, the property values can change when the user changes the region settings. However, you are not notified if the returned object changes.

To observe locale preference changes, read Registering for Locale and Time Zone Changes.

tip icon
Tip: The system settings are not the same as the user’s settings. Don’t use the systemLocale class method to get the user’s locale.

Getting Information About a Locale
Use the objectForKey: instance method in the NSLocale class to access information about a locale. For example, pass the NSLocaleUsesMetricSystem key to this method to get a Boolean number that determines whether the locale uses the metric system:

NSNumber *metricSystem = [[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem];
Pass the NSLocaleCurrencySymbol key to get a string representation of the locale’s currency symbol:

NSString *currencySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
For a complete list of locale property keys, see NSLocale Component Keys.

Getting Localized Language and Dialect Names
The identifiers that specify languages and dialects in APIs and folder names—for example, de-CH, en-AU, and pt-PT—shouldn’t be displayed to users. To get a human-readable, localized language or dialect name, use the displayNameForKey:value: method in the NSLocale class, passing NSLocaleIdentifier as the key parameter.

To get the localized name for languages and dialects

Get the language that the app is using.
NSString *languageID = [[NSBundle mainBundle] preferredLocalizations].firstObject;
The returned string is a language ID that identifies a written language or dialect, as described in Language and Locale IDs.
Get the associated locale object.
NSLocale *locale = [NSLocale localeWithLocaleIdentifier:languageID];
If you pass the language ID as the locale ID parameter, a locale for the language is returned. For example, if you pass de-CH as the language, the Switzerland locale is returned.
Get the localized language name.
NSString *localizedString = [locale displayNameForKey:NSLocaleIdentifier value:languageID];
The format of the string is [Language] ([Dialect]). For example, if the language ID is de-CH, the localized language string is “Deutsch (Schweiz).” If the language ID is de, the localized language string is “Deutsch.”

Getting Language-Specific Quotes
Beginning and ending quotes, which vary in different languages, can be obtained from the locale object. Use the same technique, described in Getting Localized Language and Dialect Names, to obtain the default locale for the language, and then use the locale component keys to obtain the language-specific quotes.

To create a string that uses locale-sensitive quotes

Get the language that the app is using.
NSString *languageID = [[NSBundle mainBundle] preferredLocalizations].firstObject;
Get the associated locale object.
NSLocale *locale = [NSLocale localeWithLocaleIdentifier:languageID];
Get the beginning and ending symbols for quotes from the locale object.
bQuote = [locale objectForKey:NSLocaleQuotationBeginDelimiterKey];
eQuote = [locale objectForKey:NSLocaleQuotationEndDelimiterKey];
Format a string using the locale-sensitive quotes.
quotedString = [NSString stringWithFormat:@"%@%@%@", bQuote, myText, eQuote];
Table 4-2 shows the results when myText is “@iPhone”for different regions.

Table 4-2  Quotes in China, France, and Japan
Region

quotedString = @"%@iPhone%@"

China

“iPhone”

France

../Art/french_iphone.svg

Japan

../Art/japanese_iphone.svg

Formatting Strings
If available, use the alternative, locale-sensitive NSString method for user-facing text. There are locale-sensitive methods for creating strings with formats, changing the case, obtaining ranges within a string, and comparing strings.

Creating Formatted Strings
At a minimum, use the localizedStringWithFormat: method in the NSString class, not the stringWithFormat: method to format user-facing text. A simple fix to existing code is to replace occurrences of the stringWithFormat: method with the alternate localizedStringWithFormat: method throughout your code, as in:

NSString *localizedString = [NSString localizedStringWithFormat:@"%3.2f", myNumber];
This method uses the system locale. To specify the user’s locale preference, pass [NSLocale currentLocale] as the locale parameter to either the initWithFormat:locale: or initWithFormat:locale:arguments: method. For best results, use data-specific formatter objects and preset styles, described in Formatting Dates and Times and Formatting Numbers.

Changing the Case of Strings
The process of changing the case in strings is not the same for all languages. Use these locale-sensitive NSString methods to change the case:

uppercaseStringWithLocale:
lowercaseStringWithLocale:
capitalizedStringWithLocale:
If you pass nil as the locale parameter, the system locale is used, which is incorrect. To specify the user’s locale preference, pass [NSLocale currentLocale] as the locale parameter.

Formatting Dates and Times
You use the NSDateFormatter class to create localized string representations of NSDate objects that are also locale-sensitive. NSDateFormatter objects are often attached directly to text fields in an Interface Builder file, but if you create NSDateFormatter objects programmatically, be sure to use methods that return localized string representations.

Note: The NSDateFormatter class is not thread-safe. See Threading Programming Guide for details.

Using Preset Date and Time Styles
To obtain a localized string representation of a date and time using a preset style, use the localizedStringFromDate:dateStyle:timeStyle: class method in the NSDateFormatter class:

NSString *localizedDateTime = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
For example, specify a medium style to abbreviate text—such as “Jun 10, 2013”—by passing NSDateFormatterMediumStyle as the style parameter. Specify a short style for numerical only representations—such as “6/10/13” or “11:03 AM”—by passing NSDateFormatterShortStyle as the style parameter. Table 4-3 shows the results of using preset formats when English is the language and United States is the region.

Table 4-3  Preset date and time styles in English for the United States
Style

Date

Time

Description

Short

6/10/13

11:03 AM

Numeric only

Medium

Jun 10, 2013

11:03:15 AM

Abbreviated text

Long

June 10, 2013

11:03:15 AM PDT

Full text

Full

Friday, June 10, 2013

11:03:15 AM Pacific Daylight Time

Complete details

No Style

Output suppressed

Table 4-4 shows the results of passing NSDateFormatterMediumStyle for the date style and NSDateFormatterShortStyle for the time style for different languages and regions.

Table 4-4  Preset date and time styles in different languages and regions
Language (Region)

Medium style

Short style

English (United States)

Jun 6, 2013

10:14 AM

French (France)

6 Jun 2013

10:14

Chinese (China)

../Art/chinese_date_year.svg

../Art/chinese_time.svg

Video: WWDC 2013 Making Your App World-Ready: Data Formatting > Preset Date Styles

Using Custom Date and Time Styles
Use custom date and time styles only when the preset styles don’t meet your needs. However, convert your custom format to a locale-sensitive format before getting string representations of the date and time. The dateFormatFromTemplate:options:locale: class method in the NSDateFormatter class rearranges the given template to adhere to the specified locale.

To get a localized string representation of a date and time using a custom style

Create an NSDateFormatter object.
NSDateFormatter *dateFormatter = [NSDateFormatter new];
Use the dateFormatFromTemplate:options:locale: class method to get a localized format string from a template that you provide.
NSString *localeFormatString = [NSDateFormatter dateFormatFromTemplate:@"dMMM" options:0 locale:dateFormatter.locale];
The template parameter of the dateFormatFromTemplate:options:locale: method should adhere to Unicode Technical Standard #35, described in Use Format Strings to Specify Custom Formats. For example, the template @”dMMM” specifies that the day of the month and abbreviation for the month should be in the format string. The order of the symbols and any non-symbol characters in the template are ignored.
Set the format of the NSDateFormatter instance to the locale-sensitive format string.
dateFormatter.dateFormat = localeFormatString;
Use the stringFromDate: method to get a localized string representation of the date.
NSString *localizedString = [dateFormatter stringFromDate:[NSDate date]];
For example, if you don’t convert the @“MMM d” string to a locale-sensitive format, the results are not localized, as shown in the second column in Table 4-5.

Table 4-5  Non-localized and localized date formats in different regions
Language (Region)

Date using format string

“MMM d”

Date using template

“dMMM”

English (United States)

Nov 13

Nov 13

French (France)

nov. 13

13 nov.

Chinese (China)

../Art/chinese_date_incorrect.svg

../Art/chinese_date.svg

Video: WWDC 2013 Making Your App World-Ready: Date Formatting > Custom Date and Time Styles

Parsing Localized Date Strings
The user enters dates using localized formats, so parse input strings accordingly. Use an NSDateFormatter object to convert a localized string to a date object. Set the date formatter’s style using one of the preset styles. (Use a template format string only if a preset style doesn’t work.) Also, allow the date formatter to use heuristics when parsing the string.

To convert a localized date string to a date object

Create a date formatter object.
NSDateFormatter *dateFormatter = [NSDateFormatter new];
Set the formatter’s style to a preset style.
dateFormatter.dateStyle = NSDateFormatterMediumStyle;
Replace NSDateFormatterMediumStyle with the style you expect the user to enter.
If the input string is not expected to contain a time, set the time style to none.
dateFormatter.timeStyle = NSDateFormatterNoStyle;
Set the leniency to YES (enables the heuristics).
dateFormatter.lenient = YES];
Convert the string to a date object.
NSDate *date = [dateFormatter dateFromString:inputString];
For example, if the locale is United States, the input string is 9/3/14, and the preset style is NSDateFormatterShortStyle, the date is interpreted as 2014-09-03 07:00:00 +0000. However, if the locale is Germany, the date becomes 2014-03-09 08:00:00 +0000.

Formatting Numbers
Locale settings affect the format of numbers—such as the decimal, thousands separator, currency, and percentage symbols. For example, the number 1,234.56 is formatted as 1.234,56 in Italy. So use the NSNumberFormatter class to create localized string representations of NSNumber objects.

Note: The NSNumberFormatter class is not thread-safe. See Threading Programming Guide for details.

Using Preset Number Styles
To obtain a localized string representation of a number using a preset style, use the localizedStringFromNumber:numberStyle: class method in the NSNumberFormatter class:

NSString *localizedString = [NSNumberFormatter localizedStringFromNumber:myNumber numberStyle:NSNumberFormatterDecimalStyle];
Table 4-6 lists the preset styles available and compares United States preset formats to other regions.

Table 4-6  Preset number styles in different languages and regions
Style

Formatted string,

English (United States)

Formatted string,

Language (Region)

Decimal

1,234.56

1.234,56

Italian (Italy)

Currency

$1,234.56

../Art/chinese_currency.svg

Chinese (China)

Percent

123,456%

../Art/arabic_percent.svg

Arabic (Egypt)

Scientific

1.23456E+03

1,23456E3

Italian (Italy)

Spell Out

one thousand two hundred thirty-four point five six

../Art/chinese_spellout.svg

Chinese (China)

Video: WWDC 2013 Making Your App World-Ready: Number Formatting

Parsing Localized Number Strings
The user may enter numbers using localized formats, so parse these input strings accordingly. Use an NSNumberFormatter object to convert a string to a number object. Set the number formatter’s style using one of the preset styles. Also, allow the number formatter to use heuristics when parsing the string.

To convert a localized number string to a number object

Create a number formatter object.
NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
Set the formatter’s style to a preset style.
numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
Replace NSNumberFormatterDecimalStyle with the style you expect the user to enter.
Set the leniency to YES (enables the heuristics).
numberFormatter.lenient = YES;
Convert the string to a number object.
NSNumber *number = [numberFormatter numberFromString:inputString];
Computing Dates Using Calendars
The NSCalendar class encapsulates all the regional differences and complexities of calendars, shown in Table 4-7. The era changes more frequently in some calendars than others—for example, the era in the Japanese calendar changes with each new emperor. The number of months per year can be 12 or 13. The length of a month can vary from year to year. Even in the Gregorian calendar, the first day of the week can be Saturday, Sunday, or Monday. NSCalendar objects know about time zones and which regions observe daylight savings time. Calendar calculations—such as the third Tuesday of the month—depend on the user’s calendar and region.

Table 4-7  Variations in regional calendars
Calendar unit

Possible values

Year

2011, 1432, 2554, 5771

Era

AD, Heisei

Number of months per year

12, 13, variable

Lengths of months

From 5 to 31 days

First day of week

Saturday, Sunday, Monday

When years change

../Art/japanese_years_change.svg

Therefore, use the NSCalendar class for all calendrical calculations such as computing the number of days in a month, computing delta values, and getting components of a date. You can use an NSDate object for internal calculations but use an NSCalendar object for computations of user-facing dates.

To get the calendar for the user’s locale, use the currentCalendar class method in NSCalendar class:

NSCalendar *currentCalendar = [NSCalendar currentCalendar];
Use an NSDateComponents object to access the calendar units of a date.

To get the components of a date

Create an NSDateComponents object.
NSDateComponents *components = [[NSCalendar currentCalendar]
    components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSEraCalendarUnit
    fromDate:[NSDate date]];
Access the values for day, month, year, and era.
NSInteger day = [components day];
NSInteger month = [components month];
NSInteger year = [components year];
NSInteger era = [components era];
tip icon
Tip: Any time you fetch or set the year, also fetch or set the era. Era is not required for the Gregorian calendar, but it is for several other calendars.

For more information on using the NSCalendar and NSDateComponents classes, read Date and Time Programming Guide or watch WWDC 2013: Solutions to Common Date and Time Challenges.

Registering for Locale and Time Zone Changes
To receive notification of locale changes, add your object as an observer of the NSCurrentLocaleDidChangeNotification notification:

[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
To receive notification of time zone changes, observe the NSSystemTimeZoneDidChangeNotification notification. For example, if the user is traveling, the time zone might change while your app is running. A long time may elapse since the last time your app was active.

Implement the change notification method to reformat and display all user-facing dates, times, and numbers using the user’s new locale settings.