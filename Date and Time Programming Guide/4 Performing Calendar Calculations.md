# Performing Calendar Calculations 执行日历计算

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW1](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW1)

`NSDate` provides the absolute scale and epoch for dates and times, which can then be rendered into a particular calendar for calendrical calculations or user display. To perform calendar calculations, you typically need to get the component elements of a date, such as the year, the month, and the day. You should use the provided methods for dealing with calendrical calculations because they take into account corner cases like daylight savings time starting or ending and leap years.

`NSDate` 提供了一个绝对的时间刻度和纪元，用于表示日期和时间，并将它们渲染到特定的日历中，以进行日历计算或用于用户显示。要进行日历计算，你通常需要获取日期的各个组成部分，例如年、月和日。你应该使用提供的方法来处理日历计算，因为这些方法考虑到了诸如夏令时开始或结束以及闰年等特殊情况。

## 1 Adding Components to a Date 向日期添加组件

You use the `dateByAddingComponents:toDate:options:` method to add components of a date (such as hours or months) to an existing date. You can provide as many components as you wish. Listing 9 shows how to calculate a date an hour and a half in the future.

你可以使用 `dateByAddingComponents:toDate:options:` 方法将日期的组件（如小时或月）添加到现有日期上。你可以根据需要提供任意数量的组件。代码 9 展示了如何计算一个半小时后的日期。

**Listing 9**  An hour and a half from now

**代码 9** 一个半小时后

```
NSDate *today = [[NSDate alloc] init];
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
[offsetComponents setHour:1];
[offsetComponents setMinute:30];
// Calculate when, according to Tom Lehrer, World War III will end
// 根据汤姆·莱勒的说法，计算第三次世界大战何时结束
NSDate *endOfWorldWar3 = [gregorian dateByAddingComponents:offsetComponents toDate:today options:0];
```

Components to add can be negative. Listing 10 shows how you can get the Sunday in the current week (using a Gregorian calendar).

要添加的组件可以是负数。代码 10 展示了如何获取当前周的星期日（使用公历）。

**Listing 10**  Getting the Sunday in the current week

**代码 10** 获取当前周的周日

```
NSDate *today = [[NSDate alloc] init];
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
 
// Get the weekday component of the current date
// 获取当前日期的星期组件
NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
 
/*
Create a date components to represent the number of days to subtract from the current date.
The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question. (If today is Sunday, subtract 0 days.)
创建一个日期组件，用于表示要从当前日期减去的天数。
在公历中，周日的星期值为 1，因此从要减去的天数中减去 1。（如果今天是周日，则减去 0 天。）
*/
NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
[componentsToSubtract setDay:(0 - ([weekdayComponents weekday] - 1))];
 
NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:today options:0];
 
/*
Optional step:
beginningOfWeek now has the same hour, minute, and second as the original date (today).
To normalize to midnight, extract the year, month, and day components and create a new date from those components.
可选步骤：
此时，beginningOfWeek 的小时、分钟和秒与原始日期（今天）相同。
要将时间归一化为午夜，提取年、月和日组件，并根据这些组件创建一个新的日期。
*/
NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:beginningOfWeek];
beginningOfWeek = [gregorian dateFromComponents:components];
```

Sunday is not the beginning of the week in all locales. Listing 11 illustrates how you can calculate the first moment of the week (as defined by the calendar's locale):

在所有地区，周日并非都是一周的开始。代码 11 展示了如何计算一周的起始时刻（由日历所在地区定义）：

**Listing 11**  Getting the beginning of the week

**代码 11** 获取一周的开始

```
NSDate *today = [[NSDate alloc] init];
NSDate *beginningOfWeek = nil;
BOOL ok = [gregorian rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek interval:NULL forDate:today];
```

## 2 Determining Temporal Differences 确定时间差

There are a few ways to calculate the amount of time between dates. Depending on the context in which the calculation is made, the user likely expects different behavior. Whichever calculation you use, it should be clear to the user how the calculation is being performed. Since Cocoa implements time according to the NTP standard, these methods ignore leap seconds in the calculation. You use `components:fromDate:toDate:options:` to determine the temporal difference between two dates in units other than seconds (which you can calculate with the `NSDate` method `timeIntervalSinceDate:`). Listing 12 shows how to get the number of months and days between two dates using a Gregorian calendar.

有几种方法可以计算日期之间的时间量。根据计算的上下文，用户可能期望不同的结果。无论使用哪种计算方法，都应该让用户清楚计算是如何进行的。由于 Cocoa 根据 NTP 标准实现时间，这些方法在计算时会忽略闰秒。你可以使用 `components:fromDate:toDate:options:` 方法来确定两个日期之间以秒以外的单位表示的时间差（计算秒差可以使用 `NSDate` 的 `timeIntervalSinceDate:` 方法）。代码 12 展示了如何使用公历计算两个日期之间的月数和天数。

**Listing 12**  Getting the difference between two dates

**代码 12** 获取两个日期之间的差值

```
NSDate *startDate = ...;
NSDate *endDate = ...;
 
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
 
NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
 
NSDateComponents *components = [gregorian components:unitFlags fromDate:startDate  toDate:endDate options:0];
NSInteger months = [components month];
NSInteger days = [components day];
```

This method handles overflow as you may expect. If the `fromDate:` and `toDate:` parameters are a year and 3 days apart and you ask for only the days between, it returns an `NSDateComponents` object with a value of `368` (or `369` in a leap year) for the day component. However, this method truncates the results of the calculation to the smallest unit supplied. For instance, if the `fromDate:` parameter corresponds to `Jan 14, 2010 at 11:30 PM` and the `toDate:` parameter corresponds to `Jan 15, 2010 at 8:00 AM`, there are only 8.5 hours between the two dates. If you ask for the number of days, you get `0`, because 8.5 hours is less than 1 day. There may be situations where this should be 1 day. You have to decide which behavior your users expect in a particular case. If you do need to have a calculation that returns the number of days, calculated by the number of midnights between the two dates, you can use a category to `NSCalendar` similar to the one in Listing 13.

该方法会按预期处理溢出情况。如果 `fromDate:` 和 `toDate:` 参数相隔一年零 3 天，而你只询问这两个日期之间的天数，它会返回一个 `NSDateComponents` 对象，其日期组件的值为 `368`（闰年为 `369`）。不过，该方法会将计算结果截断为所提供的最小单位。例如，如果 `fromDate:` 参数对应 `2010 年 1 月 14 日晚上 11:30`，而 `toDate:` 参数对应 `2010 年 1 月 15 日上午 8:00`，这两个日期之间只有 8.5 小时。如果你询问天数，会得到 `0`，因为 8.5 小时不足一天。但在某些情况下，这可能应该算作 1 天。你必须根据具体情况判断用户期望的结果。如果你确实需要计算两个日期之间相隔的天数（以午夜的数量计算），可以使用类似于代码 13 中的 `NSCalendar` 分类。

**Listing 13**  Days between two dates, as the number of midnights between

**代码 13** 两个日期之间相隔的天数（以午夜数量计算）

```
@implementation NSCalendar (MySpecialCalculations)
- (NSInteger)daysWithinEraFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
     NSInteger startDay=[self ordinalityOfUnit:NSDayCalendarUnit inUnit: NSEraCalendarUnit forDate:startDate];
     NSInteger endDay=[self ordinalityOfUnit:NSDayCalendarUnit  inUnit: NSEraCalendarUnit forDate:endDate];
     return endDay - startDay;
}
@end
```

This approach works for other calendar units by specifying a different `NSCalendarUnit` value for the `ordinalityOfUnit:` parameter. For example, you can calculate the number of years based on the number of times `Jan 1, 12:00 AM` is present between.

通过为 `ordinalityOfUnit:` 参数指定不同的 `NSCalendarUnit` 值，这种方法也适用于其他日历单位。例如，你可以根据两个日期之间出现 `1 月 1 日凌晨 12:00` 的次数来计算年数。

Do not use this method for comparing second differences because it overflows `NSInteger` on 32-bit platforms. This method is only valid if you stay within the same era (in the Gregorian Calendar this means that both dates must be CE or both must be BCE). If you do need to compare dates across an era boundary you can use something similar to the category in Listing 14.

不要使用此方法来比较秒差，因为在 32 位平台上它会导致 `NSInteger` 溢出。只有在同一纪元内使用此方法才有效（在公历中，这意味着两个日期必须都为公元后或都为公元前）。如果你确实需要比较跨越纪元边界的日期，可以使用类似于代码 14 中的分类。

**Listing 14**  Days between two dates in different eras

**代码 14** 不同纪元中两个日期之间相隔的天数

```
@implementation NSCalendar (MyOtherMethod)
- (NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
     NSCalendarUnit units = NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
     NSDateComponents *comp1 = [self components:units fromDate:startDate];
     NSDateComponents *comp2 = [self components:units fromDate endDate];
     [comp1 setHour:12];
     [comp2 setHour:12];
     NSDate *date1 = [self dateFromComponents: comp1];
     NSDate *date2 = [self dateFromComponents: comp2];
     return [[self components:NSDayCalendarUnit fromDate:date1 toDate:date2 options:0] day];
}
@end
```

This method creates components from the given dates, and then normalizes the time and compares the two dates. This calculation is more expensive than comparing dates within an era. If you do not need to cross era boundaries use the technique shown in Listing 13 instead.

此方法会根据给定的日期创建组件，然后对时间进行归一化处理并比较这两个日期。这种计算比比较同一纪元内的日期成本更高。如果你不需要跨越纪元边界，建议使用代码 13 中所示的技术。

## 3 Checking When a Date Falls 检查日期所属范围

If you need to determine if a date falls within the current week (or any unit for that matter) you can make use of the `NSCalendar` method `rangeOfUnit:startDate:interval:forDate:`. Listing 15 shows a method that determines if a given date falls within this week. The week in this case is defined as the period between Sunday at midnight to the following Saturday just before midnight (in the Gregorian calendar).

如果你需要确定某个日期是否在当前周（或其他单位）内，可以使用 `NSCalendar` 的 `rangeOfUnit:startDate:interval:forDate:` 方法。代码 15 展示了一个用于判断给定日期是否在本周的方法。在这种情况下，一周定义为从周日午夜到下一个周六午夜前的时间段（在公历中）。

**Listing 15**  Determining whether a date is this week

**代码 15** 判断日期是否在本周

```
- (BOOL)isDateThisWeek:(NSDate *)date {
     NSDate *start;
     NSTimeInterval extends;
     NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
     NSDate *today = [NSDate date];
     BOOL success = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&start interval:&extends forDate:today];
     if(!success) {
         return NO;
     }
 
     NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
     NSTimeInterval dayStartInSecs = [start timeIntervalSinceReferenceDate];
 
     return dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs + extends)
}
```

This code uses `NSTimeInterval` values for the date to test and the start of the week and uses those to determine whether the date is this week.

这段代码使用 `NSTimeInterval` 值来表示要测试的日期和一周的开始时间，并据此判断该日期是否在本周内。

## 4 Week-Based Calendars 基于周的日历

A week-based calendar is defined by the weeks of a year. Instead of the year, month, and day of a date, a week-based calendar is defined by the week-year, the week number, and a weekday.

基于周的日历是根据一年中的周来定义的。与普通日历使用年、月和日来定义日期不同，基于周的日历使用周所在的年份、周数和星期几来定义。

However, this can be complicated when the first week of the calendar overlaps the last week of the previous year’s calendar. In this case there are two important properties of the calendar:

1. What is the first day of the week?
2. How many days does a week near the beginning of the year have to have within the ordinary calendar year for it to be considered the first week in the week-based calendar year?

然而，当日历的第一周与上一年日历的最后一周重叠时，情况会变得复杂。在这种情况下，日历有两个重要属性：

1. 一周的第一天是哪一天？
2. 一年开始附近的一周，在普通日历年内至少需要包含多少天，才能被视为基于周的日历年度的第一周？

A week-based calendar's first day of the year is on the first day of the week. The first week is preferred to be the week containing Jan 1 if that week satisfies the defined answer for the second point above.

基于周的日历的一年从一周的第一天开始。如果包含 1 月 1 日的那一周满足上述第二个问题的定义，那么这一周将被优先视为第一周。

For example, suppose the first day of the week is defined as Monday, in a week-based calendar interpretation of the Gregorian calendar. Consider the 2009/2010 transition shown in Table 1 and Table 2:

例如，假设在对公历进行基于周的日历解释时，将一周的第一天定义为周一。考虑表 1 和表 2 所示的 2009/2010 过渡情况：

**Table 1**  December 2009 Calendar  **表 1** 2009年12月日历

Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
20|21|22|23|24|25|26|
27|28|29|30|31

**Table 2**  January 2010 Calendar  **表 2** 2010年1月日历

Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
 | | | | |1|2|
3|4|5|6|7|8|9|
10|11|12|13|14|15|16

Since the first day of the week is Monday, the 2010 week-based calendar year can begin either December 28 or January 4. That is, December 30, 2009 (ordinary) could be December 30, 2010 (week-based).

由于一周的第一天是周一，2010 年基于周的日历年度可能从 12 月 28 日或 1 月 4 日开始。也就是说，2009 年 12 月 30 日（普通日期）可能是 2010 年 12 月 30 日（基于周的日期）。

To choose between these two possibilities, there is the second criterion. Week Dec 28 - Jan 3 has 3 days in 2010. Week Jan 4-Jan 10 has 7 days in 2010.

为了在这两种可能性中做出选择，需要参考第二个标准。12 月 28 日 - 1 月 3 日这一周在 2010 年有 3 天。1 月 4 日 - 1 月 10 日这一周在 2010 年有 7 天。

If the minimum number of days in a first week is defined as 1 or 2 or 3, the week of Dec 28 satisfies the first week criteria and would be week 1 of the week-based calendar year 2010. Otherwise, the week of Jan 4 is the first week.

如果将第一周的最少天数定义为 1、2 或 3 天，那么 12 月 28 日所在的那一周满足第一周的标准，将成为 2010 年基于周的日历年度的第 1 周。否则，1 月 4 日所在的那一周为第一周。

As another example, suppose you wanted to define a week-based calendar such that the first week of the calendar year begins with the first occurrence of a specific weekday.

再举一个例子，假设你想定义一个基于周的日历，使得日历年度的第一周从特定星期几的首次出现开始。

In Table 2 Monday January 4 is the first Monday of the ordinary year, so the week-based calendar begins on that day. What you are requesting then is that the first week of your week-based calendar is entirely within the new ordinary year or that the minimum number of days in first week is 7.

在表 2 中，2010 年 1 月 4 日周一是普通年份的第一个周一，因此基于周的日历从这一天开始。你所要求的实际上是基于周的日历的第一周完全在新的普通年份内，或者第一周的最少天数为 7 天。

The `NSYearForWeekOfYearCalendarUnit` is the year number of a week-based calendar interpretation of the calendar you're working with, where the two properties of the week-based calendar discussed in above correspond to these two `NSCalendar` properties: `firstWeekday` and `minimumDaysInFirstWeek`.

`NSYearForWeekOfYearCalendarUnit` 是你所使用日历的基于周的日历解释中的年份编号，上述基于周的日历的两个属性分别对应 `NSCalendar` 的两个属性：`firstWeekday` 和 `minimumDaysInFirstWeek`。

> **Warning:** Mixing and matching week-based calendar constants (`NSWeekOfMonthCalendarUnit`, `NSWeekOfYearCalendarUnit`, and `NSYearForWeekOfYearCalendarUnit`) with other week-oriented calendar constants (defined in the `Calendar Units` constants) will result in errors. Specifically, the calendar component `NSYearCalendarUnit` defines the ordinary calendar year, not the year in a week-based calendar. Using an `NSCalendar` with a calendar year and a weekday when using a calendar created using the week-based calendar constants results in ambiguous dates.
> 
> **警告：**将基于周的日历常量（`NSWeekOfMonthCalendarUnit`、`NSWeekOfYearCalendarUnit` 和 `NSYearForWeekOfYearCalendarUnit`）与其他面向周的日历常量（在`日历单位`常量中定义）混合使用会导致错误。具体来说，日历组件 `NSYearCalendarUnit` 定义的是普通日历年份，而不是基于周的日历中的年份。当使用基于周的日历常量创建的日历，同时指定日历年和星期几时，会导致日期不明确。