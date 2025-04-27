# Calendars, Date Components, and Calendar Units 日历，日期组件和日历单位

原文地址：[https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW1](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendars.html#//apple_ref/doc/uid/TP40003470-SW1)

Calendar objects encapsulate information about systems of reckoning time in which the beginning, length, and divisions of a year are defined. You use calendar objects to convert between absolute times and date components such as years, days, or minutes.

日历对象封装了关于时间计算系统的信息，其中定义了一年的开始、长度和划分。您可以使用日历对象在绝对时间和日期组件（如年、日或分钟）之间进行转换。

## 1 Calendar Basics 日历基础

`NSCalendar` provides an implementation of various calendars. It provides data for several different calendars, including Buddhist, Gregorian, Hebrew, Islamic, and Japanese (which calendars are supported depends on the release of the operating system—check the `NSLocale` class to determine which are supported on a given release). `NSCalendar` is closely associated with the `NSDateComponents` class, instances of which describe the component elements of a date required for calendrical computations.

`NSCalendar` 提供了对各种日历的实现。它为几种不同的日历提供数据，包括佛历、公历、希伯来历、伊斯兰历和日本历（所支持的日历取决于操作系统的版本 —— 可查看 `NSLocale` 类来确定在特定版本中支持哪些日历）。`NSCalendar` 与 `NSDateComponents` 类紧密相关，`NSDateComponents` 类的实例描述了日历计算所需的日期组成元素。

Calendars are specified by constants in `NSLocale`. You can get the calendar for the user's preferred locale most easily using the `NSCalendar` method `currentCalendar`; you can get the default calendar from any `NSLocale` object using the key `NSLocaleCalendar`. You can also create an arbitrary calendar object by specifying an identifier for the calendar you want. Listing 3 shows how to create a calendar object for the Japanese calendar and for the current user.

日历由 `NSLocale` 中的常量指定。使用 `NSCalendar` 的 `currentCalendar` 方法可以最轻松地获取用户首选地区的日历；你也可以从任何 `NSLocale` 对象中使用键 `NSLocaleCalendar` 来获取默认日历。你还可以通过指定所需日历的标识符来创建任意的日历对象。代码 3 展示了如何为日本历和当前用户创建日历对象。

**Listing 3**  Creating calendar objects

**代码 3** 创建日历对象

```
NSCalendar *currentCalendar = [NSCalendar currentCalendar];
 
NSCalendar *japaneseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSJapaneseCalendar];
 
NSCalendar *usersCalendar = [[NSLocale currentLocale] objectForKey:NSLocaleCalendar];
```

Here, `usersCalendar` and `currentCalendar` are equal, although they are different objects.

在这里，`usersCalendar` 和 `currentCalendar` 是相等的，尽管它们是不同的对象。

## 2 Date Components and Calendar Units 日期组件和日历单位

You represent the component elements of a date—such as the year, day, and hour—using an `NSDateComponents` object. An `NSDateComponents` object can hold either absolute values or quantities of units (see [Adding Components to a Date](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW3) for an example of using `NSDateComponents` to specify quantities of units). For date components objects to be meaningful, you need to know the associated calendar and purpose.

你可以使用 `NSDateComponents` 对象来表示日期的组成元素，例如年、日和小时。一个 `NSDateComponents` 对象可以保存绝对值或单位数量（有关使用 `NSDateComponents` 指定单位数量的示例，请参阅 《[向日期添加组件](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DatesAndTimes/Articles/dtCalendricalCalculations.html#//apple_ref/doc/uid/TP40007836-SW3)》）。为了使日期组件对象有意义，你需要知道相关的日历和用途。

> **iOS Note**: In iOS 4.0 and later, `NSDateComponents` objects can contain a calendar, a timezone, and a date object. This allows date components to be passed to or returned from a method and retain their meaning.
> 
> **iOS 注意事项：**在 iOS 4.0 及更高版本中，`NSDateComponents` 对象可以包含日历、时区和日期对象。这使得日期组件可以传递给方法或从方法返回，并保留其含义。

Day, week, weekday, month, and year numbers are generally 1-based, but there may be calendar-specific exceptions. Ordinal numbers, where they occur, are 1-based. Some calendars may have to map their basic unit concepts into the year/month/week/day/… nomenclature. The particular values of the unit are defined by each calendar and are not necessarily consistent with values for that unit in another calendar.

日、周、星期几、月和年的数字通常以 1 为基数，但可能存在特定日历的例外情况。序数（如果存在的话）也是以 1 为基数。某些日历可能需要将其基本单位概念映射到 年/月/周/日…… 的命名体系中。每个日历都定义了各个单位的特定值，这些值不一定与其他日历中该单位的值一致。

Listing 4 shows how you can create a date components object that you can use to create the date where the year unit is 2004, the month unit is 5, and the day unit is 6 (in the Gregorian calendar this is May 6th, 2004). You can also use it to add 2004 year units, 5 month units, and 6 day units to an existing date. The value of `weekday` is undefined since it is not otherwise specified.

代码 4 展示了如何创建一个日期组件对象，该对象可用于创建年份为 2004、月份为 5、日期为 6 的日期（在公历中，这是 2004 年 5 月 6 日）。你也可以使用它将 2004 个年份单位、5 个月份单位和 6 个日期单位添加到现有日期上。由于未另行指定，`weekday` 的值是未定义的。

**Listing 4**  Creating a date components object

**代码 4** 创建日期组件对象

```
NSDateComponents *components = [[NSDateComponents alloc] init];
[components setDay:6];
[components setMonth:5];
[components setYear:2004];
 
NSInteger weekday = [components weekday]; // Undefined (== NSUndefinedDateComponent)
```

## 3 Converting between Dates and Date Components 在日期和日期组件之间进行转换

To decompose a date into constituent components, you use the `NSCalendar` method `components:fromDate:`. In addition to the date itself, you need to specify the components to be returned in the `NSDateComponents` object. For this, the method takes a bit mask composed of [Calendar Units](https://developer.apple.com/documentation/foundation/nscalendarunit) constants. There is no need to specify any more components than those in which you are interested. Listing 5 shows how to calculate today’s day and weekday.

要将日期分解为组成组件，你可以使用 `NSCalendar` 的 `components:fromDate:` 方法。除了日期本身之外，你还需要在 `NSDateComponents` 对象中指定要返回的组件。为此，该方法接受一个由[日历单位](https://developer.apple.com/documentation/foundation/nscalendarunit)常量组成的位掩码。无需指定比你感兴趣的组件更多的内容。代码 5 展示了如何计算今天的日期和星期几。

**Listing 5**  Getting a date’s components

**代码 5** 获取日期的组件

```
NSDate *today = [NSDate date];
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDateComponents *weekdayComponents = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
NSInteger day = [weekdayComponents day];
NSInteger weekday = [weekdayComponents weekday];
```

This gives you the absolute components for a date. For example, if you ask for the year and day components for November 7, 2010, you get 2010 for the year and 7 for the day. If you instead want to know what number day of the year it is you can use the `ordinalityOfUnit:inUnit:forDate:` method of the `NSCalendar` class.

这将为你提供日期的绝对组件。例如，如果你询问 2010 年 11 月 7 日的年份和日期组件，你将得到年份为 2010，日期为 7。如果你想知道这是一年中的第几天，则可以使用 `NSCalendar` 类的 `ordinalityOfUnit:inUnit:forDate:` 方法。

It is also possible to create a date from components. You can configure an instance of `NSDateComponents` to specify the components of a date and then use the `NSCalendar` method `dateFromComponents:` to create the corresponding date object. You can provide as many components as you need (or choose to). When there is incomplete information to compute an absolute time, default values such as `0` and `1` are usually chosen by a calendar, but this is a calendar-specific choice. If you provide inconsistent information, calendar-specific disambiguation is performed (which may involve ignoring one or more of the parameters).

也可以根据组件创建日期。你可以配置一个 `NSDateComponents` 实例来指定日期的组件，然后使用 `NSCalendar` 的 `dateFromComponents:` 方法来创建相应的日期对象。你可以根据需要（或选择）提供尽可能多的组件。当计算绝对时间的信息不完整时，日历通常会选择默认值，如 `0` 和 `1`，但这是特定日历的选择。如果你提供不一致的信息，将执行特定日历的歧义消除操作（这可能涉及忽略一个或多个参数）。

Listing 6 shows how to create a date object to represent (in the Gregorian calendar) the first Monday in May, 2008.

代码 6 展示了如何创建一个日期对象来表示（在公历中）2008 年 5 月的第一个星期一。

**Listing 6**  Creating a date from components

**代码 6** 根据组件创建日期

```
NSDateComponents *components = [[NSDateComponents alloc] init];
[components setWeekday:2]; // Monday
[components setWeekdayOrdinal:1]; // The first Monday in the month
[components setMonth:5]; // May
[components setYear:2008];
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDate *date = [gregorian dateFromComponents:components];
```

To guarantee correct behavior you must make sure that the components used make sense for the calendar. Specifying “out of bounds” components—such as a day value of `-6` or February 30th in the Gregorian calendar—produce undefined behavior.

为了确保正确的行为，你必须确保所使用的组件对于该日历是有意义的。指定 “超出范围” 的组件，例如 `-6` 的日期值或公历中的 2 月 30 日，会产生未定义的行为。

You may want to create a date object without components such as years—to store your friend’s birthday, for instance. While it is not technically possible to create a yearless date, you can use date components to create a date object without a specified year, as in Listing 7.

你可能想要创建一个缺少组件的日期对象，例如缺少年——用于存储你朋友的生日。虽然从技术上讲不可能创建一个没有年份的日期，但你可以使用日期组件创建一个未指定年份的日期对象，如代码 7 所示。

**Listing 7**  Creating a yearless date

**代码 7** 创建一个没有年份的日期

```
NSDateComponents *components = [[NSDateComponents alloc] init];
[components setMonth:11];
[components setDay:7];
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDate *birthday = [gregorian dateFromComponents:components];
```

Note that `birthday` in this instance has the default value for the year, which in this case is 1 CE (though it is not guaranteed to always default to 1 CE). If you later convert this date back to components, or use an `NSDateFormatter` object to display it, make sure to not use the year value (as your friend may not appreciate being listed as that old). You can use the `NSDateFormatter` `dateFormatFromTemplate:options:locale:` method to create a yearless date formatter that adjusts to the users locale. For more information on date formatting see [Data Formatting Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029i).

请注意，在这种情况下，`birthday` 的年份具有默认值，在这种情况下是公元 1 年（不过不能保证总是默认为公元 1 年）。如果你以后将此日期转换回组件，或者使用 `NSDateFormatter` 对象来显示它，请确保不要使用年份值（因为你的朋友可能不希望被列为那么老）。你可以使用 `NSDateFormatter` 的 `dateFormatFromTemplate:options:locale:` 方法来创建一个没有年份的日期格式化器，它会根据用户的地区进行调整。有关日期格式化的更多信息，请参阅《[数据格式化指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/DataFormatting/DataFormatting.html#//apple_ref/doc/uid/10000029i)》。

> **Warning:** Mixing and matching week-based calendar constants (`NSWeekOfMonthCalendarUnit`, `NSWeekOfYearCalendarUnit`, and `NSYearForWeekOfYearCalendarUnit`) with other week-oriented calendar constants (defined in the [Calendar Units](https://developer.apple.com/documentation/foundation/nscalendarunit) constants) will result in errors. Specifically, the calendar component `NSYearCalendarUnit` defines the ordinary calendar year, not the year in a week-based calendar. Using an `NSCalendar` with a calendar year and a weekday when using a calendar created using the week-based calendar constants results in ambiguous dates.
> 
> **警告：**将基于周的日历常量（`NSWeekOfMonthCalendarUnit`、`NSWeekOfYearCalendarUnit` 和 `NSYearForWeekOfYearCalendarUnit`）与其他面向周的日历常量（在[日历单位](https://developer.apple.com/documentation/foundation/nscalendarunit)常量中定义）混合使用会导致错误。具体来说，日历组件 `NSYearCalendarUnit` 定义的是普通日历年，而不是基于周的日历中的年份。当使用基于周的日历常量创建的 `NSCalendar` 时，同时使用日历年和星期几，会导致日期不明确。

## 4 Converting from One Calendar to Another 从一种日历转换到另一种日历

To convert components of a date from one calendar to another—for example, from the Gregorian calendar to the Hebrew calendar—you first create a date object from the components using the first calendar, then you decompose the date into components using the second calendar. Listing 8 shows how to convert date components from one calendar to another.

要将日期的组件从一种日历转换为另一种日历，例如从公历转换为希伯来历，你首先使用第一种日历根据组件创建一个日期对象，然后使用第二种日历将该日期分解为组件。代码 8 展示了如何将日期组件从一种日历转换为另一种日历。

**Listing 8**  Converting date components from one calendar to another

**代码 8** 将日期组件从一种日历转换为另一种日历

```
NSDateComponents *comps = [[NSDateComponents alloc] init];
[comps setDay:6];
[comps setMonth:5];
[comps setYear:2004];
 
NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
NSDate *date = [gregorian dateFromComponents:comps];
[comps release];
[gregorian release];
 
NSCalendar *hebrew = [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
NSDateComponents *components = [hebrew components:unitFlags fromDate:date];
 
NSInteger day = [components day]; // 15
NSInteger month = [components month]; // 9
NSInteger year = [components year]; // 5764
```