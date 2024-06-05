# CADisplayLink

原文地址：[https://developer.apple.com/documentation/quartzcore/cadisplaylink](https://developer.apple.com/documentation/quartzcore/cadisplaylink)

> iOS 3.1+
iPadOS 3.1+
macOS 14.0+
Mac Catalyst 13.1+
tvOS 9.0+
visionOS 1.0+

A timer object that allows your app to synchronize its drawing to the refresh rate of the display.

一个计时器对象，允许您的应用程序将其绘图与显示器的刷新率同步。

## Declaration 声明

```
class CADisplayLink : NSObject
```

## Overview 概览

Your app initializes a new display link by providing a target object and a selector to call when the system updates the screen. To synchronize your display loop with the display, your application adds it to a run loop using the [add(to:forMode:)](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621323-add) method.

您的应用程序通过提供目标对象和一个选择器来初始化一个新的显示链接，当系统更新屏幕时调用该选择器。为了将您的显示循环与显示器同步，您的应用程序使用 [add(to:forMode:)](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621323-add) 方法将其添加到运行循环中。

Once you associate the display link with a run loop, the system calls the selector on the target when the screen’s contents need to update. The target can read the display link’s [timestamp](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621257-timestamp) property to retrieve the time the system displayed the previous frame. For example, an app that displays movies might use `timestamp` to calculate which video frame to display next. An app that performs its own animations might use `timestamp` to determine where and how visible objects appear in the upcoming frame.

一旦您将显示链接与运行循环关联起来，系统在屏幕内容需要更新时会调用目标上的选择器。目标可以读取显示链接的 [timestamp](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621257-timestamp) 属性，以检索系统显示上一帧的时间。例如，一个显示电影的应用程序可以使用 `timestamp` 来计算下一个要显示的视频帧。一个执行自己动画的应用程序可以使用 `timestamp` 来确定即将到来的帧中可见对象的位置和外观。

The [duration](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621292-duration) property provides the amount of time between frames at the [maximumFramesPerSecond](https://developer.apple.com/documentation/uikit/uiscreen/2806814-maximumframespersecond). To calculate the actual frame duration, use [targetTimestamp](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1648422-targettimestamp) - [timestamp](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621257-timestamp). You can use this value in your app to calculate the frame rate of the display, the approximate time the system displays the next frame, and to adjust the drawing behavior so that the next frame is ready in time to display.

[duration](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621292-duration) 属性提供了不超过 [maximumFramesPerSecond](https://developer.apple.com/documentation/uikit/uiscreen/2806814-maximumframespersecond) 的每帧之间的时间量。要计算实际的帧持续时间，可以使用 [targetTimestamp](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1648422-targettimestamp) - [timestamp](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621257-timestamp)。您可以在您的应用程序中使用这个值来计算显示的帧率，系统显示下一帧的大致时间，以及调整绘制行为，使下一帧准备就绪以及时显示。

Your app can disable notifications by setting [isPaused](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621229-ispaused) to `true`. Also, if your app can’t provide frames in the time the system provides, you may want to choose a slower frame rate. An app with a slower but consistent frame rate appears smoother to the user than an app that skips frames. You can define the number of frames per second by setting [preferredFramesPerSecond](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1648421-preferredframespersecond).

您的应用程序可以通过将 [isPaused](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621229-ispaused) 设置为 `true` 来禁用通知。此外，如果您的应用程序无法在系统提供的时间内提供帧，您可能希望选择一个较慢的帧率。具有较慢但一致的帧率的应用程序对用户来说比跳帧的应用程序看起来更流畅。您可以通过设置 [preferredFramesPerSecond](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1648421-preferredframespersecond) 来定义每秒的帧数。

When your app finishes with a display link, call [invalidate()](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621293-invalidate) to remove it from all run loops and to disassociate it from the target.

当您的应用程序完成显示链接时，调用 [invalidate()](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1621293-invalidate) 将其从所有运行循环中移除，并将其与目标解除关联。

The code listing below shows how to create a display link and add it to the current run loop. The display link invokes the step function, which prints the target timestamp with each screen update.

此代码段展示了如何创建一个显示链接并将其添加到当前运行循环中。显示链接调用 `step` 函数，该函数在每次屏幕更新时打印目标时间戳。

```
func createDisplayLink() {
    let displaylink = CADisplayLink(target: self,
                                    selector: #selector(step))
    
    displaylink.add(to: .current,
                    forMode: .defaultRunLoopMode)
}
     
func step(displaylink: CADisplayLink) {
    print(displaylink.targetTimestamp)
}
```

You shouldn’t subclass CADisplayLink.

不应该子类化CADisplayLink。

## Preferred and Actual Frame Rates - 首选帧率和实际帧率

You control a display link’s frame rate (the number of times the system calls the selector of its target, per second) by setting [preferredFramesPerSecond](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1648421-preferredframespersecond). However, the actual frames per second may differ from the preferred value you set; actual frame rates are always a factor of the maximum refresh rate of the device. For example, if your device’s maximum refresh rate is 60 frames per second (defined by [maximumFramesPerSecond](https://developer.apple.com/documentation/uikit/uiscreen/2806814-maximumframespersecond)), actual frame rates include 15, 20, 30, and 60 frames per second. If you set a display link’s preferred frame rate to a value higher than the maximum, the actual frame rate is the maximum.

通过设置 [preferredFramesPerSecond](https://developer.apple.com/documentation/quartzcore/cadisplaylink/1648421-preferredframespersecond) 来控制显示链接的帧率（系统每秒调用其目标的选择器的次数）。然而，实际每秒帧率可能与您设置的首选值不同；实际帧率始终是设备的最大刷新率的因数。例如，如果您的设备的最大刷新率为每秒 60 帧（由 [maximumFramesPerSecond](https://developer.apple.com/documentation/uikit/uiscreen/2806814-maximumframespersecond) 定义），实际帧率包括每秒 15、20、30 和 60 帧。如果将显示链接的首选帧率设置为高于最大值的值，则实际帧率为最大值。

In iOS 15, frame rate availability can change due to the system factoring in the system policy and user preference — including Low Power Mode, critical thermal state, and accessibility settings.

在 iOS 15 中，由于系统考虑系统策略和用户偏好（包括低功耗模式、临界热状态和辅助功能设置），帧率可用性可能会发生变化。

The system rounds, to the nearest factor, preferred frame rates that aren’t a divisor of the maximum frame rate. For example, setting a preferred frame rate to either 26 or 35 frames per second on a device with a maximum refresh rate of 60 frames per second yields an actual frame rate of 30 times per second.

系统会将不是最大帧率的除数的首选帧率四舍五入到最接近的因数。例如，在具有每秒 60 帧的最大刷新率的设备上将首选帧率设置为 26 或 35 帧每秒会产生每秒 30 帧的实际帧率。

The code listing below shows how to calculate the actual frame rate by dividing 1 by your display link’s timestamp subtracted from its targetTimestamp.

下面的代码清单展示了如何通过将 1 除以您的显示链接的时间戳减去其targetTimestamp来计算实际帧率。

```
// Calculate the actual frame rate.
let actualFramesPerSecond = 1 / (displaylink.targetTimestamp - displaylink.timestamp)
```

> **Note** **注意**
>
> If your app needs more control over refresh rate to ensure smooth rendering of frames, use [CAMetalDisplayLink](https://developer.apple.com/documentation/quartzcore/cametaldisplaylink) and the information from [CAMetalLayer](https://developer.apple.com/documentation/quartzcore/cametallayer) instances to render frames.
> 
> 如果您的应用程序需要更多控制刷新率以确保帧的流畅渲染，可以使用[CAMetalDisplayLink](https://developer.apple.com/documentation/quartzcore/cametaldisplaylink) 和来自 [CAMetalLayer](https://developer.apple.com/documentation/quartzcore/cametallayer) 实例的信息来渲染帧。

# Topics 主题

## Creating a Display Link

### init(target: Any, selector: Selector)

Creates a display link for a target that calls its selector.

## Configuring a Display Link

### var duration: CFTimeInterval

The time interval between screen refresh updates.

### var preferredFrameRateRange: CAFrameRateRange

A range of frequencies your app allows for frame updates, affecting how often the system invokes your delegate’s callback.

### var preferredFramesPerSecond: Int

A frequency your app prefers for frame updates, affecting how often the system invokes your delegate’s callback.
Deprecated

### var isPaused: Bool

A Boolean value that indicates whether the system suspends the display link’s notifications to the target.

### var timestamp: CFTimeInterval
The time interval that represents when the last frame displayed.

### var targetTimestamp: CFTimeInterval
The time interval that represents when the next frame displays.


### var frameInterval: Int
The number of frames that must pass before the display link notifies the target again.
Deprecated


## Scheduling a Display Link to Send Notifications

### func add(to: RunLoop, forMode: RunLoop.Mode)
Registers the display link with a run loop.
func remove(from: RunLoop, forMode: RunLoop.Mode)
Removes the display link from the run loop for the given mode.

### func invalidate()
Removes the display link from all run loop modes.

# Relationships

## Inherits From
NSObject

# See Also

## Animation Timing

### func CACurrentMediaTime() -> CFTimeInterval
Returns the current absolute time, in seconds.

### class CAMediaTimingFunction
A function that defines the pacing of an animation as a timing curve.

### protocol CAMediaTiming
Methods that model a hierarchical timing system, allowing objects to map time between their parent and local time.

### class CAMetalDisplayLink
A class your Metal app uses to register for callbacks to synchronize its animations for a display.

### class CAMetalDisplayLink.Update
Stores information about a single update from a Metal display link instance.

### protocol CAMetalDisplayLinkDelegate
A protocol your app implements to respond to callbacks from Core Animation for a Metal display link.

## Related Documentation
Presenting content on a connected display
Fill connected displays with additional content from your app.










