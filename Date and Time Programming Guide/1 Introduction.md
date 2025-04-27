# About Dates and Times 关于日期和时间

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/DatesAndTimes.html#//apple_ref/doc/uid/10000039-SW1](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/DatesAndTimes.html#//apple_ref/doc/uid/10000039-SW1)

Date and time objects allow you to store references to particular instances in time. You can use date and time objects to perform calculations and comparisons that account for the corner cases of date and time calculations.

日期和时间对象允许你存储对特定时间点的引用。考虑到日期和时间计算中的特殊情况，你可以使用日期和时间对象来进行计算和比较。

![Art/iCal.png](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Art/iCal.png)

## 1 At a Glance 概览

There are three main classes used for working with dates and times.

用于处理日期和时间的类主要有三个。

- [NSDate](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSDateClassCluster/Description.html#//apple_ref/occ/cl/NSDate) allows you to represent an absolute point in time.
- [NSCalendar](https://developer.apple.com/documentation/foundation/nscalendar) allows you to represent a particular calendar, such as a Gregorian or Hebrew calendar. It provides the interface for most date-based calculations and allows you to convert between `NSDate` objects and `NSDateComponents` objects.
- [NSDateComponents](https://developer.apple.com/documentation/foundation/nsdatecomponents) allows you to represent the components of a particular date, such as hour, minute, day, year, and so on.

- [NSDate](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSDateClassCluster/Description.html#//apple_ref/occ/cl/NSDate) 允许你表示一个绝对的时间点。
- [NSCalendar](https://developer.apple.com/documentation/foundation/nscalendar) 允许你表示特定的日历，如公历或希伯来日历。它提供了大多数基于日期的计算的接口，并允许你在 `NSDate` 对象和 `NSDateComponents` 对象之间进行转换。
- [NSDateComponents](https://developer.apple.com/documentation/foundation/nsdatecomponents) 允许你表示特定日期的各个组成部分，如小时、分钟、天、年等。

In addition to these classes, [NSTimeZone](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/cl/NSTimeZone) allows you to represent a geopolitical region’s time zone information. It eases the task of working across different time zones and performing calculations that may be affected by daylight savings time transitions.

除了这些类之外，[NSTimeZone](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/cl/NSTimeZone) 允许你表示一个地理政治区域的时区信息。它简化了跨不同时区工作的任务，以及执行可能受夏令时转换影响的计算。

### 1.1 Creating and Using Date Objects to Represent Absolute Points in Time 创建和使用日期对象来表示绝对时间点

Date objects represent dates and times in Cocoa. Date objects allow you to store absolute points in time which are meaningful across locales, calendars and timezones.

在 Cocoa 中，日期对象用于表示日期和时间。日期对象允许你存储在不同地区、日历和时区都有意义的绝对时间点。

> Relevant Chapters: [Dates](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtDates.html#//apple_ref/doc/uid/20000183-BCIDBADB)
> 
> 相关章节：《[日期](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtDates.html#//apple_ref/doc/uid/20000183-BCIDBADB)》

### 1.2 Working with Calendars and Date Components 使用日历和日期组件

Date components allow you to break a date down into the various parts that comprise it, such as day, month, year, hour, and so on. Calendars represent a particular form of reckoning time, such as the Gregorian calendar or the Chinese calendar. Calendar objects allow you to convert between date objects and date component objects, as well as from one calendar to another.

日期组件允许你将一个日期分解为组成它的各个部分，如日、月、年、小时等。日历表示一种特定的计时方式，如公历或中国农历。日历对象允许你在日期对象和日期组件对象之间进行转换，也可以在不同的日历之间进行转换。

> Relevant Chapters: [Calendars, Date Components, and Calendar Units](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW1)
> 
> 相关章节：《[日历、日期组件和日历单位](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW1)》

### 1.3 Performing Date and Time Calculations 执行日期和时间计算

Calendars and date components allow you to perform calculations such as the number of days or hours between two dates or finding the Sunday in the current week. You can also add components to a date or check when a date falls.

日历和日期组件允许你执行一些计算，如计算两个日期之间的天数或小时数，或者找出当前周的星期日。你还可以向一个日期添加组件或检查某个日期是星期几。

> Relevant Chapters: [Performing Calendar Calculations](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW1)
>
> 相关章节：《[执行日历计算](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW1)》

### 1.4 Working with Different Time Zones 处理不同的时区

Time zone objects allow you to present absolute times as local—that is, wall clock—time. In addition to time offsets, they also keep track of daylight saving time differences. Proper use of time zone objects can avoid issues such as miscalculation of elapsed time due to daylight saving time transitions or the user moving to a different time zone.

时区对象允许你将绝对时间表示为本地时间，即墙上时钟显示的时间。除了时间偏移量之外，它们还跟踪夏令时的差异。正确使用时区对象可以避免一些问题，例如由于夏令时转换或用户移动到不同时区而导致的时间计算错误。

> Relevant Chapters: [Using Time Zones](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtTimeZones.html#//apple_ref/doc/uid/20000185-BBCBDGID)
> 
> 相关章节：《[使用时区](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtTimeZones.html#//apple_ref/doc/uid/20000185-BBCBDGID)》

### 1.5 Special Considerations for Historical Dates 历史日期的特殊考虑

Dates in the past have a number of edge cases that do not exist for contemporary dates. These include issues such as dates that do not exist in a particular calendar—such as the lack of the year 0 in the Gregorian calendar— or calendar transitions—such as the Julian to Gregorian transition in the Middle Ages. There are also eras with seemingly backward time flow—such as BCE dates in the Gregorian calendar.

过去的日期有许多现代日期不存在的边缘情况。这些问题包括在特定日历中不存在的日期——如公历中没有公元 0 年，或者日历的转换——如中世纪从儒略历到公历的转换。还有一些时代似乎时间是倒流的，如公历中的公元前日期。

> Relevant Chapters: [Historical Dates](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtHist.html#//apple_ref/doc/uid/TP40010240-SW1)
> 
> 相关章节：《[历史日期](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtHist.html#//apple_ref/doc/uid/TP40010240-SW1)》

## 2 How to Use this Document 如何使用本文档

If your application keeps track of dates and times, read from [Dates](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtDates.html#//apple_ref/doc/uid/20000183-BCIDBADB) to [Using Time Zones](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtTimeZones.html#//apple_ref/doc/uid/20000185-BBCBDGID). The `NSDate`, `NSCalendar`, `NSDateComponents`, and `NSTimeZone` classes described in these chapters work together to store, compare, and manipulate dates and times.

如果你的应用程序要跟踪日期和时间，请从《[日期](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtDates.html#//apple_ref/doc/uid/20000183-BCIDBADB)》部分读到《[使用时区](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtTimeZones.html#//apple_ref/doc/uid/20000185-BBCBDGID)》部分。这些章节中描述的 `NSDate`、`NSCalendar`、`NSDateComponents` 和 `NSTimeZone` 类共同作用来存储、比较和操作日期和时间。

If your application deals with dates in the past—particularly prior to the early 1900s, also read [Historical Dates](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtHist.html#//apple_ref/doc/uid/TP40010240-SW1) to learn about some of the issues that can arise when dealing with dates in the past.

如果你的应用程序处理过去的日期，特别是 1900 年早期之前的日期，还请阅读《[历史日期](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtHist.html#//apple_ref/doc/uid/TP40010240-SW1)》部分，以了解处理过去日期时可能出现的一些问题。

## 3 See Also 其他参阅

If you display dates and times to users or create dates from user input, read:

- [Data Formatting Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029i), which explains how to create and format user-readable strings from date objects, and how to create date objects from formatted strings.
Next

如果你要向用户显示日期和时间或根据用户输入创建日期，请阅读：

- 《[数据格式化指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029i)》，其中解释了如何从日期对象创建和格式化用户可读的字符串，以及如何从格式化字符串创建日期对象。