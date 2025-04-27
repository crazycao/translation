# Dates 日期

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtDates.html#//apple_ref/doc/uid/20000183-BCIDBADB](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtDates.html#//apple_ref/doc/uid/20000183-BCIDBADB)

Date objects allow you to represent dates and times in a way that can be used for date calculations and conversions. As absolute points in time, date objects are meaningful across locales, timezones, and calendars.

日期对象允许你以一种可用于日期计算和转换的方式表示日期和时间。作为绝对的时间点，日期对象在跨地区、时区和日历时都颇具意义。

## 1 Date Fundamentals 日期基础

Cocoa represents dates and times as `NSDate` objects. `NSDate` is one of the fundamental Cocoa value objects. A date object represents an invariant point in time. Because a date is a point in time, it implies clock time as well as a day, so there is no way to define a date object to represent a day without a time.

Cocoa 将日期和时间表示为 `NSDate` 对象。`NSDate` 是 Cocoa 中的基本值对象之一。日期对象表示一个不变的时间点。因为日期是一个时间点，所以它既隐含了时钟时间，也隐含了某一天的信息，因此无法定义一个仅表示某一天而不包含时间的日期对象。

To understand how Cocoa handles dates, you must consider `NSCalendar` and `NSDateComponents` objects as well. In a nontechnical context, a point in time is usually represented by a combination of a clock time and a day on a particular calendar (such as the Gregorian or Hebrew calendar). Supporting different calendars is important for localization. In Cocoa, you use a particular calendar to decompose a date object into its date components such as year, month, day, hour, and minute. Conversely, you can use a calendar to create a date object from date components. Calendar and date component objects are described in more detail in [Calendars, Date Components, and Calendar Units](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW1).

要理解 Cocoa 是如何处理日期的，你还必须考虑 `NSCalendar` 和 `NSDateComponents` 对象。在非技术语境中，一个时间点通常由特定日历（如公历或希伯来日历）上的时钟时间和某一天组合来表示。支持不同的日历对于本地化非常重要。在 Cocoa 中，你使用特定的日历将日期对象分解为其日期组件，如年、月、日、小时和分钟。相反，你也可以使用日历根据日期组件来创建一个日期对象。关于日历和日期组件的更多详细信息，请参考《[日历、日期组件和日历单位](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW1)》。

`NSDate` provides methods for creating dates, comparing dates, and computing intervals. Date objects are immutable. The standard unit of time for date objects is floating point value typed as `NSTimeInterval` and is expressed in seconds. This type makes possible a wide and fine-grained range of date and time values, giving precision within milliseconds for dates 10,000 years apart.

`NSDate` 提供了用于创建日期、比较日期和计算时间间隔的方法。日期对象是不可变的。日期对象的标准时间单位是一个类型为 `NSTimeInterval` 的浮点数，以秒为单位表示。这种类型可以表示广泛且精细的日期和时间值范围，对于相隔 10000 年的日期，精度可以达到毫秒级别。

`NSDate` computes time as seconds relative to an absolute reference time: the first instant of January 1, 2001, Greenwich Mean Time (GMT). Dates before then are stored as negative numbers; dates after then are stored as positive numbers. The sole primitive method of `NSDate`, [timeIntervalSinceReferenceDate](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSDateClassCluster/Description.html#//apple_ref/occ/clm/NSDate/timeIntervalSinceReferenceDate) provides the basis for all the other methods in the `NSDate` interface. `NSDate` converts all date and time representations to and from `NSTimeInterval` values that are relative to the absolute reference date.

`NSDate` 将时间计算为相对于一个绝对参考时间的秒数，这个绝对参考时间是 2001 年 1 月 1 日格林威治标准时间（GMT）的第一时刻。在此之前的日期存储为负数，在此之后的日期存储为正数。`NSDate` 唯一的原始方法 —— [timeIntervalSinceReferenceDate](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSDateClassCluster/Description.html#//apple_ref/occ/clm/NSDate/timeIntervalSinceReferenceDate) 为 `NSDate` 接口中的所有其他方法提供了基础。`NSDate` 会将所有日期和时间表示形式与相对于绝对参考日期的 `NSTimeInterval` 值进行相互转换。

Cocoa implements time according to the Network Time Protocol (NTP) standard, which is based on Coordinated Universal Time.

Cocoa 根据网络时间协议（NTP）标准来实现时间，该标准基于协调世界时。

## 2 Creating Date Objects 创建日期对象

If you want a date that represents the current time, you allocate an `NSDate` object and initialize it with `init`:

如果你想要一个表示当前时间的日期，你可以分配一个 `NSDate` 对象并使用 init 方法对其进行初始化：

```
NSDate *now = [[NSDate alloc] init];
```

or use the `NSDate` class method `date` to create the date object. If you want some time other than the current time, you can use one of `NSDate`’s `initWithTimeInterval...` or `dateWithTimeInterval...` methods; typically, however, you use a more sophisticated approach employing a calendar and date components as described in [Calendar Basics](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW2).

或者使用 `NSDate` 类方法 `date` 来创建日期对象。如果你想要表示除当前时间之外的某个时间，你可以使用 `NSDate` 的 `initWithTimeInterval...` 或 `dateWithTimeInterval...` 方法之一；不过，通常情况下，你会采用一种更复杂的方法，即使用日历和日期组件，如《[日历基础](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW2)》中所述。

The `initWithTimeInterval...` methods initialize date objects relative to a particular time, which the method name describes. You specify (in seconds) how much more recent or how much more in the past you want your date object to be. To specify a date that occurs earlier than the method’s reference date, use a negative number of seconds.

`initWithTimeInterval...` 方法根据方法名描述的特定的时间来初始化日期对象。你可以指定（以秒为单位）你希望日期对象比参考时间新多少或者旧多少。要指定一个比方法的参考日期更早的日期，使用负数秒数。

Listing 1 defines two date objects. The `tomorrow` object is exactly 24 hours from the current date and time, and `yesterday` is exactly 24 hours earlier than the current date and time.

代码 1 定义了两个日期对象。`tomorrow` 对象距离当前日期和时间正好 24 小时，`yesterday` 对象比当前日期和时间正好早 24 小时。

**Listing 1**  Creating dates with time intervals 

**代码 1** 使用时间间隔创建日期

```
NSTimeInterval secondsPerDay = 24 * 60 * 60;
NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
NSDate *yesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
```

Listing 2 shows how to get new date objects with date-and-time values adjusted from existing date objects using `dateByAddingTimeInterval:`.

代码 2 展示了如何使用 `dateByAddingTimeInterval:` 方法从现有日期对象调整日期和时间值来获取新的日期对象。

**Listing 2**  Creating dates by adding a time interval

**代码 2** 通过添加时间间隔创建日期

```
NSTimeInterval secondsPerDay = 24 * 60 * 60;
NSDate *today = [[NSDate alloc] init];
NSDate *tomorrow, *yesterday;
 
tomorrow = [today dateByAddingTimeInterval:secondsPerDay];
yesterday = [today dateByAddingTimeInterval:-secondsPerDay];
```

## 3 Basic Date Calculations 基本日期计算

To compare dates, you can use the `isEqualToDate:`, `compare:`, `laterDate:`, and `earlierDate:` methods. These methods perform exact comparisons, which means they detect sub-second differences between dates. You may want to compare dates with a less fine granularity. For example, you may want to consider two dates equal if they are within a minute of each other. If this is the case, use `timeIntervalSinceDate:` to compare the two dates. The following code fragment shows how to use `timeIntervalSinceDate:` to see if two dates are within one minute (60 seconds) of each other.

要比较日期，你可以使用 `isEqualToDate:`、`compare:`、`laterDate:` 和 `earlierDate:` 方法。这些方法执行精确比较，这意味着它们可以检测到日期之间的亚秒级差异。你可能希望以较低的精度来比较日期。例如，如果两个日期相差在一分钟之内，你可能希望将它们视为相等。如果是这种情况，使用 `timeIntervalSinceDate:` 方法来比较这两个日期。下面的代码片段展示了如何使用 `timeIntervalSinceDate:` 方法来判断两个日期是否相差在一分钟（60 秒）之内。

```
if (fabs([date2 timeIntervalSinceDate:date1]) < 60) {
    // …
}
```

To obtain the difference between a date object and another point in time, send a `timeIntervalSince...` message to the date object. For example, `timeIntervalSinceNow` gives you the time, in seconds, between the current time and the receiving date object.

要获取一个日期对象与另一个时间点之间的差值，向该日期对象发送一个 `timeIntervalSince...` 消息。例如，`timeIntervalSinceNow` 方法会返回当前时间与接收消息的日期对象之间的时间差（以秒为单位）。

To get the component elements of a date, such as the day of the week, use an `NSDateComponents` object in conjunction with an `NSCalendar` object. This technique is described in [Calendar Basics](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW2).

要获取日期的组成元素，如星期几，需要结合使用 `NSDateComponents` 对象和 `NSCalendar` 对象。这种技术在 《[日历基础](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW2)》中有描述。