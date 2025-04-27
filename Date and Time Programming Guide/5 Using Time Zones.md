# Using Time Zones 使用时区

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtTimeZones.html#//apple_ref/doc/uid/20000185-BBCBDGID](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtTimeZones.html#//apple_ref/doc/uid/20000185-BBCBDGID)

Time zones can create numerous problems for applications. Consider the following situation. You are in New York and it is `12:30 AM`. You have an application that displays all of the Major League Baseball games that happen tomorrow. Because tomorrow is different depending on the time zone, situations like this must be carefully accounted for. Fortunately, a little planning and the assistance of the `NSTimeZone` class ease this task considerably.

时区可能会给应用程序带来许多问题。考虑以下情况：你身处纽约，时间是`凌晨 12:30`。你有一个应用程序，它会显示明天所有的美国职业棒球大联盟（Major League Baseball）比赛。由于根据不同的时区，“明天” 的定义也不同，像这样的情况必须仔细考虑。幸运的是，只要做一些规划，并借助 `NSTimeZone` 类的帮助，就能大大减轻这项任务的难度。

`NSTimeZone` is an abstract class that defines the behavior of time zone objects. Time zone objects represent geopolitical regions. Consequently, these objects have region names. Time zone objects also represent a temporal offset, either plus or minus, from Greenwich Mean Time (GMT) and an abbreviation (such as PST).

`NSTimeZone` 是一个抽象类，它定义了时区对象的行为。时区对象代表了地缘政治区域。因此，这些对象都有区域名称。时区对象还代表了与格林威治标准时间（GMT）的时间偏移量（正数或负数），以及一个缩写（如 PST）。

## 1 Creating Time Zones 创建时区

Time zones affect the values of date components that are calculated by calendar objects for a given `NSDate` object. You can create an `NSTimeZone` object and use it to set the time zone of an `NSCalendar` object. By default, `NSCalendar` uses the default time zone for the application—or process—when the calendar object is created. Unless the default time zone has been otherwise set, it is the time zone set in System Preferences.

时区会影响日历对象为给定的 `NSDate` 对象计算出的日期组件的值。你可以创建一个 `NSTimeZone` 对象，并使用它来设置 `NSCalendar` 对象的时区。默认情况下，`NSCalendar` 在创建日历对象时会使用应用程序（或进程）的默认时区。除非另行设置了默认时区，否则默认时区就是在 “系统偏好设置” 中设置的时区。

In most cases, the user’s default time zone should be used when creating date objects. There are cases when it may be necessary to use arbitrary time zones. For example, the user may want to specify that an appointment is in Greenwich Mean Time, because it is during her business trip to London next week. `NSTimeZone` provides several class methods to make time zone objects: [timeZoneWithName:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneWithName:), [timeZoneWithAbbreviation:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneWithAbbreviation:), and [timeZoneForSecondsFromGMT:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneForSecondsFromGMT:). In most cases [timeZoneWithName:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneWithName:) provides the most accurate time zone, as it adjusts for daylight saving time, the trade-off is that you must know more precisely the location you are creating a time zone for.

在大多数情况下，创建日期对象时应使用用户的默认时区。但也存在需要使用任意时区的情况。例如，用户可能希望指定某个约会是在格林威治标准时间，因为那是她下周去伦敦出差期间的安排。`NSTimeZone` 提供了几个类方法来创建时区对象：[timeZoneWithName:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneWithName:)、[timeZoneWithAbbreviation:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneWithAbbreviation:) 和 [timeZoneForSecondsFromGMT:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneForSecondsFromGMT:)。在大多数情况下，[timeZoneWithName:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/timeZoneWithName:) 方法能提供最准确的时区，因为它会考虑夏令时的调整，其代价是你必须更精确地知道要为哪个位置创建时区。

For a complete list of time zone names known to the system, you can use the `knownTimeZoneNames` class method:

要获取系统已知的时区名称的完整列表，可以使用 `knownTimeZoneNames` 类方法：

```
NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
```

## 2 Application Default Time Zone 应用程序的默认时区

You can set the default time zone within your application using [setDefaultTimeZone:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/setDefaultTimeZone:). You can access this default time zone at any time with the `defaultTimeZone` class method. With the `localTimeZone` class method you can get a time zone object that automatically updates itself to reflect changes to the default time zone.

你可以使用 [setDefaultTimeZone:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSTimeZoneClassCluster/Description.html#//apple_ref/occ/clm/NSTimeZone/setDefaultTimeZone:) 方法在应用程序中设置默认时区。你可以随时使用 `defaultTimeZone` 类方法访问这个默认时区。使用 `localTimeZone` 类方法，你可以获取一个时区对象，该对象会自动更新自身以反映默认时区的变化。

## 3 Creating Dates with Time Zones 使用时区创建日期

Time zones play an important part in determining when dates take place. Consider a simple calendar application that keeps track of appointments. For example, say you live in Chicago and you have a dentist appointment coming up at `10:00 AM` on Tuesday. You will be in New York for Sunday and Monday, however. When you created that appointment it was done with the mindset of an absolute time. That time is `10:00 AM Central Time`; when you go to New York, the time should be presented as `11:00` AM because you are in a different time zone, but it is the same absolute time. On the other hand, if you create an appointment to wake up and exercise every morning at `7:00 AM`, you do not want your alarm to go off at `1:00 PM` simply because you are on a business trip to Dublin—or at `5:00 AM` because you are in Los Angeles.

时区在确定日期的具体时间方面起着重要作用。考虑一个简单的日历应用程序，它用于记录约会安排。例如，假设你住在芝加哥，有一个周二`上午 10 点`的牙医预约。然而，你周日和周一将在纽约。当你创建这个约会时，是以绝对时间的概念来设定的。这个时间是`美国中部时间上午 10 点`；当你到了纽约，显示的时间应该是`上午 11 点`，因为你处于不同的时区，但这是同一个绝对时间。另一方面，如果你设定了一个每天`早上 7 点`起床锻炼的约会，你肯定不希望仅仅因为你在都柏林出差，闹钟就在`下午 1 点`响，或者因为你在洛杉矶，闹钟就在`早上 5 点`响。

`NSDate` objects store dates in absolute time. For example, the date object created in Listing 16 represents `4:00 PM CDT`, `5:00 EDT`, and so on.

`NSDate` 对象以绝对时间存储日期。例如，代码 16 中创建的日期对象表示`美国中部夏令时（CDT）下午 4 点`、`美国东部夏令时（EDT）下午 5 点`等等。

**** 16  Creating a date from components using a specific time zone

**代码 16** 使用特定时区从组件创建日期

```
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
[gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CDT"]];
NSDateComponents *timeZoneComps = [[NSDateComponents alloc] init];
[timeZoneComps setHour:16];
//specify whatever day, month, and year is appropriate
//指定合适的日、月和年
NSDate *date = [gregorian dateFromComponents:timeZoneComps];
```

If you need to create a date that is independent of timezone, you can store the date as an `NSDateComponents` object—as long as you store some reference to the corresponding calendar.

如果你需要创建一个与时区无关的日期，可以将日期存储为一个 `NSDateComponents` 对象，前提是你要存储对相应日历的一些引用。

In iOS, `NSDateComponents` objects can contain a calendar, a timezone, and a date object. You can therefore store the calendar along with the components. If you use the `date` method of the `NSDateComponents` class to access the date, make sure that the associated timezone is up-to-date.

在 iOS 中，`NSDateComponents` 对象可以包含一个日历、一个时区和一个日期对象。因此，你可以将日历与组件一起存储。如果你使用 `NSDateComponents` 类的 `date` 方法来访问日期，请确保相关的时区是最新的。

## 4 Time Zones and Daylight Saving Time 时区和夏令时

The NSTimeZone class also provides a number of instance methods to determine information about daylight saving time:

- [isDaylightSavingTime](https://developer.apple.com/documentation/foundation/nstimezone/1387191-daylightsavingtime) determines whether daylight saving time is currently in effect.
- [daylightSavingTimeOffset](https://developer.apple.com/documentation/foundation/nstimezone/1387235-daylightsavingtimeoffset) determines the current daylight saving time offset. For most time zones this is either zero or one.
- [nextDaylightSavingTimeTransition](https://developer.apple.com/documentation/foundation/nstimezone/1387183-nextdaylightsavingtimetransition) determines when the next daylight saving time transition occurs.

`NSTimeZone` 类还提供了许多实例方法来确定与夏令时相关的信息：

- [isDaylightSavingTime](https://developer.apple.com/documentation/foundation/nstimezone/1387191-daylightsavingtime) 方法用于确定当前夏令时是否生效。
- [daylightSavingTimeOffset](https://developer.apple.com/documentation/foundation/nstimezone/1387235-daylightsavingtimeoffset) 方法用于确定当前的夏令时偏移量。对于大多数时区，这个值要么是 0，要么是 1。
- [nextDaylightSavingTimeTransition](https://developer.apple.com/documentation/foundation/nstimezone/1387183-nextdaylightsavingtimetransition) 方法用于确定下一次夏令时转换的时间。

There are also similarly named methods for determining this information for specific dates. If you are keeping track of events and appointments in your application, you can use this information to remind the user of upcoming daylight saving time transitions.

也有一些名称类似的方法可用于确定特定日期的这些信息。如果你在应用程序中记录事件和约会安排，可以使用这些信息来提醒用户即将到来的夏令时转换。