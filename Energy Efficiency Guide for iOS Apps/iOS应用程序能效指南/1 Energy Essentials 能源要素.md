
# Energy Essentials 能源要素

原文：
[https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/index.html#//apple_ref/doc/uid/TP40015243-CH3-SW1](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/index.html#//apple_ref/doc/uid/TP40015243-CH3-SW1)

# 1 Energy Efficiency and the User Experience 能效和用户体验

A great user experience requires:

好的用户体验需要：

- **Great battery life.** Users expect all-day battery life on their iOS devices. 

  **电池续航时间很长**。用户希望他们的设备全天都有点。

- **Awesome speed.** iOS is designed to provide great performance during complex operations—and to make your app fly.

  **惊人的速度**。iOS 可以在复杂的操作中提供出色的性能。

- **Responsiveness.** Too many resources being consumed at once can result in a laggy interface that’s slow to respond to user input. 

  **快速响应**。同时消耗太多资源会导致用户输入的响应变慢。

- **Cool device.** As more apps use more resources, the system works harder and faster, and the physical temperature of a device gradually rises. When this occurs, the system takes steps to cool down to a more acceptable level.

  **凉设备**。随着使用更多的，设备会升温；系统会采取措施降温。

## 1.1 iOS Energy-Saving Technologies iOS 节能技术

### 1.1.1 Integrated Hardware and Software  集成硬件和软件

iOS integrates with advanced hardware features such as a power efficient CPU, accelerated graphics, and wireless antennas. Hardware and software work together to deliver an optimized user experience that’s great for battery life.

iOS 设备集成了优秀的软件和硬件，如节能CPU、图形加速和无线天线。硬件和软件协同工作，提供优化的用户体验，将大大延长电池寿命。

### 1.1.2 Intelligent App Management 智能应用管理

iOS apps have a life cycle that’s managed by the system. When a user finishes interacting with an app, the app is placed into a background state, where activity is throttled and the app may be suspended. Apps generating high CPU usage for extended periods of time while running in the background may be terminated by the system, if necessary.

iOS 应用的生命周期由系统管理。当用户完成与应用程序的交互，让应用程序将进入后台状态时，应用程序的活动将被挂起。如果需要，系统可能会终止在后台运行的长时间高CPU占用率的应用程序。

### 1.1.3 Network Operation Deferral 网络操作延迟

APIs let you designate criteria that indicate when and how often a network operation should be deferred, how long it can be deferred, and under what circumstances. The system uses this information to defer the operation until an energy efficient time.

支持通过 API 控制网络操作应该延迟的时间和频率、可以延迟多长时间以及在什么情况下延迟。系统使用这些信息将操作推迟到一个高能效的时间执行。

### 1.1.4 Task Prioritization 任务优先级

Tasks that affect the user, such as downloading and playing music, take priority over background and discretionary work. Quality of service class APIs allow you to assign priority levels to the work your app performs, giving you fine-grained control over task prioritization.

影响用户的任务，如下载和播放音乐，优先级高于后台任务和便宜行事的任务。服务质量类 API 允许您为应用程序执行的工作分配优先级，使您能够对任务优先级进行细粒度控制。

### 1.1.5 Developer Tools 开发者工具

Xcode and Instruments help you identify and address energy problems as you develop your app, rather than after those problems are encountered by users.

Xcode 和 Instruments 有助于在开发阶段就发现和解决能源问题，而不是在用户遇到这些问题之后。

## 1.2 Your Obligation as a Developer 开发者的责任

Even small inefficiencies in apps add up, significantly affecting battery life, performance, and responsiveness. As an app developer, you have an obligation to make sure your app runs as efficiently as possible. Use recommended APIs so the system can make smart decisions about how best to manage your app and the resources it uses. Whenever possible, batch and reduce network operations, and avoid unnecessary updates to the user interface. Power-intensive operations should be under the user’s control. If a user is playing a graphics-heavy game, for example, the user should not be surprised if the activity consumes power. Strive to make your app absolutely idle when it is not responding to user input.

即使是应用程序中一点点的低效率行为，也会显著影响电池寿命、性能和响应能力。作为一名应用程序开发人员，您有义务确保您的应用程序尽可能高效地运行。使用推荐的API，以便系统能够智能地决定如何最好地管理应用程序及其使用的资源。尽可能批量处理和减少网络操作，避免对用户界面进行不必要的更新。消耗大量电力的操作应由用户控制。例如，如果用户正在玩有大量图形的游戏，用户应该不会对电量的消耗感到惊讶。当你的应用程序不响应用户输入时，努力使它完全空闲。

By adhering to recommended guidelines, you can make big contributions to the overall energy efficiency of the platform and the satisfaction of your users.

坚持遵守推荐的指导原则，您将为平台的整体能效和用户满意度做出巨大贡献。

# 2 Fundamental Concepts 基本概念

There’s no single solution for conserving energy on a device. Numerous technologies and operations influence how energy is used:

在设备上没有单一的节能解决方案。许多技术和操作影响能源的使用：

- **CPU.** The CPU is a major consumer of energy. Periods of high CPU use rapidly drain a user’s battery. Your app uses the CPU for almost everything it does, and it should do so wisely—by doing work only when necessary through batching, scheduling, and prioritizing.

  **CPU。**CPU 是能源的主要消耗者。一段时间的高 CPU 使用会迅速耗尽用户的电池。你的应用程序几乎在做任何事情时都在使用 CPU，应该这样做才明智——通过批处理、调度和优先级控制，让 CPU 只在必要时才工作。

- **Device wake.** iOS devices rely on sleep for great battery life. Whenever a device wakes, there is a high overhead cost, as the screen and other resources must be powered up. Your app, especially when operating in the background, should be as idle as possible and avoid waking the device with push notifications or other activity unless absolutely necessary.

  **设备唤醒。**iOS 通过睡眠来延长电池使用时间。每当设备唤醒时，都会有很高的开销，因为屏幕和其他资源必须通电。你的应用程序，尤其是在后台运行时，应该尽可能空闲，除非绝对必要，否则避免使用推送通知或其他活动唤醒设备。

- **Networking operations.** Most iOS apps perform networking operations. When networking occurs, components such as cellular radios and Wi-Fi power up and use energy. By batching and reducing transactions, compressing data, and appropriately handling errors, your app can make significant contributions to energy conservation.

  **网络操作。**大部分iOS应用程序都要执行网络操作。联网时，蜂窝无线电和Wi-Fi等组件会通电并使用电能。通过成批处理和减少事务、压缩数据以及适当处理错误，您的应用程序可以为节能做出重大贡献。
  
- **Graphics, animations, and video.** Every time your app’s content updates on screen, it uses energy to produce those pixels. Animations and videos can be especially taxing. Unexpected and unnecessary content updates also drain power. Your app should avoid updating content when its interface isn’t visible to the user. Also, follow recommended guidelines under _Graphics and Animation_ in _iOS Human Interface Guidelines_.

  **图形、动画和视频。**每次应用程序的内容在屏幕上更新时，都要使用电能来产生这些像素。动画和视频可能尤其费电。意外和不必要的内容更新也会消耗电力。当用户看不到应用程序的界面时，应用程序应避免更新内容。此外，请遵循《iOS人机界面指南》中《图形和动画》部分的推荐指导原则。

- **Location.** Many apps make location requests in order to log a user’s physical activity or provide environment-based alerts. Energy use increases with greater precision and longer location requests. Your app should reduce accuracy and duration of location activity whenever possible. Stop location requests when no longer needed.

  **定位。**许多应用程序发出位置请求以记录用户的身体活动，或者提供基于环境的提醒。能源使用会随着更高的精度和更长的定位请求而增加。你的应用程序应该尽可能减少定位活动的精度和持续时间。不再需要定位时停止位置请求。

- **Motion.** Continuous unwarranted requests for accelerometer, gyroscope, magnetometer, and other motion data waste energy. Request motion updates only when necessary, and stop updates when data is no longer needed.

  **运动。**对加速计、陀螺仪、磁强计和其他运动数据的不必要的连续请求浪费了能量。仅在必要时请求运动更新，并在不再需要时停止更新。

- **Bluetooth.** High periods of Bluetooth activity can drain the battery of the iOS device and the Bluetooth device. Whenever possible, batch and buffer Bluetooth activity, and reduce polling for data. 

  **蓝牙。**长时间的蓝牙活动可能会耗尽iOS设备和蓝牙设备的电池电量。只要有可能，对蓝牙活动进行批处理和缓存，并减少对数据的轮询。

## 2.1 Energy and Power 能量与功率

Energy and power are two separate but related concepts. Power is an instantaneous measurement (watts) of energy required at any given point in time (Figure 2-1). Energy is a measurement of power used (joules) over a period of time (watt hours).

能量与功率是两个独立但相关的概念。**功率**是对任何给定时间点所需能量的瞬时测量（瓦特）。**能量**是对一段时间内（瓦时）所用功率的测量（焦耳）。

Energy and power are two separate but related concepts. Power is an instantaneous measurement (watts) of energy required at any given point in time (Figure 2-1). Energy is a measurement of power used (joules) over a period of time (watt hours). Energy is finite. It’s stored in the battery and dissipates over time as more power is required.

能量和功率是两个独立但相关的概念。**功率**是任何给定时间点所需能量的瞬时测量值（瓦特）（图2-1）。**能量**是一段时间（瓦时）内所用功率的测量值（焦耳）。能量是有限的。它储存在电池中，随着时间的推移会消耗更多所需的电能。

By being aware of energy and taking it into account while developing your app, you can proactively take measures that make your code more efficient. As more apps improve efficiency, users will have batteries that last much longer, in addition to cooler and quieter devices.

只要在开发应用程序时意识到能量并将其考虑在内，您就可以主动采取措施，使代码更高效。随着越来越多的应用程序提高效率，用户除了拥有更凉爽、更安静的设备外，还将拥有更耐用的电池。

**Figure 2-1** Energy is power over time  **图 2-1** 随着时间推移的电能消耗
![Figure 2-1](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9kZXZlbG9wZXIuYXBwbGUuY29tL2xpYnJhcnkvYXJjaGl2ZS9kb2N1bWVudGF0aW9uL1BlcmZvcm1hbmNlL0NvbmNlcHR1YWwvRW5lcmd5R3VpZGUtaU9TL0FydC8yLTFfZW5lcmd5LWlzLXBvd2VyLW92ZXItdGltZV8yeC5wbmc?x-oss-process=image/format,png)


## 2.2 CPU Usage and Power Draw CPU 使用与功耗

CPU usage is expensive. As more CPU is used, more power draw occurs, more energy is used, and the device’s battery drains faster. Power draw varies based on the device, processor, resources, and so on, but Table 2-1 provides a rough comparison of varying CPU usage against an idle state.

CPU 的使用是昂贵的。越多的 CPU 被使用，越多的功率被消耗，越多的能量被使用，设备的电池消耗越快。功率消耗因设备、处理器、资源等而异，表 2-1 提供了不同 CPU 使用率与空闲状态下的粗略比较。

The majority of techniques and recommendations throughout this document result in less usage of the CPU.

本文档中的大多数技术和建议都会减少CPU的使用。

**Table 2-1** Example of idle vs. CPU power draw  **表 2-1** 空闲与CPU功耗对比示例

|Idle | 10x greater power draw over sleep|
|:-:|:--:|
|1% CPU use </br> 1% 的 CPU 使用| 10% greater power draw over idle </br> 比空闲时多了 10% 的功耗|
|10% CPU use </br> 10% 的 CPU 使用| 2x power draw over idle </br> 空闲时 2 倍的功耗|
|100% CPU use </br> 100% 的 CPU 使用| 10x power draw over idle </br> 空闲时 10 倍的功耗|

## 2.3 Fixed Cost and Dynamic Cost 固定开销和动态开销

iOS is very good at getting a device into a low power state when it’s not being used. Even at the microsecond scale, such as between keystrokes, the system is able to power down resources that aren’t being used.

iOS 非常擅长让设备在不使用时进入低功耗状态。即使在微秒级，比如击键之间，系统也能够关闭未使用的资源。

At idle, very little power is drawn and energy impact is low. When tasks are actively occurring, system resources are being used and those resources require energy. However, sporadic tasks can cause the device to enter an intermediate state—neither idle nor active—when the device isn’t doing anything. There may not be enough time during these intermediate states for the device to reach absolute idle before the next task executes. When this occurs, energy is wasted and the user’s battery drains faster.

在空闲时，消耗的功率很小，对能量的影响很小。当任务正在积极执行时，就在使用系统资源，而这些资源需要能量。但是，当设备不执行任何操作时，零星任务可能会导致设备进入中间状态，既不是空闲状态，也不是活动状态。在这些中间状态期间，可能没有足够的时间让设备在执行下一个任务之前达到绝对空闲。当这种情况发生时，能量就被浪费了，用户的电池消耗得更快。

Tasks your app performs have a dynamic cost—how much energy your app uses by doing actual work. They also have a fixed cost—how much energy is used by bringing the system and various resources up in order for your app to do work, and back down after that work is complete. When lots of sporadic work is occurring, there are dynamic costs and a significant fixed cost too, as resources may never get the chance to reach true idle between the sporadic tasks. This situation results in a lot of energy being used for a relatively small amount of actual work. See Figure 2-2.

你的应用程序执行的任务会动态地消耗你的应用程序在实际工作中消耗的能量。他们也有一个固定的成本，即为了让你的应用程序工作而启动系统和各种资源所消耗的能量，然后在工作完成后再启动。当大量的零星工作发生时，会有动态成本和显著的固定成本，因为资源可能永远不会有机会在零星任务之间达到真正的空闲状态。这种情况导致大量的能量被用于相对较少的实际工作。见图2-2。

Tasks your app performs have a dynamic cost—how much energy your app uses by doing actual work. They also have a fixed cost—how much energy is used by bringing the system and various resources up in order for your app to do work, and back down after that work is complete. When lots of sporadic work is occurring, there are dynamic costs and a significant fixed cost too, as resources may never get the chance to reach true idle between the sporadic tasks. This situation results in a lot of energy being used for a relatively small amount of actual work. See Figure 2-2.

应用程序执行的任务有**动态开销**——使用多少能量取决于实际的工作。同时也有**固定开销**——使用多少能量取决于为了让你的应用程序工作所增加的系统和各种资源，它们会在工作完成后回落。当大量的零星工作发生时，会有一定的动态成本和显著的固定成本，因为资源可能永远不会有机会在零星任务之间达到真正的空闲状态。这种情况导致大量的能量被用于相对较少的实际工作。见图 2-2。

> **IMPORTANT** **重要**
>
> Networking has a high fixed cost in iOS. Whenever networking occurs, cellular radios and Wi-Fi must power up. In anticipation of additional work, these resources remain running—and consume energy—for prolonged periods, even after your work is complete.
> 
> 在iOS中，联网具有较高的固定开销。无论何时联网，蜂窝无线电和 Wi-Fi 都必须通电。预计到会有额外的工作，这些资源会持续运行长时间并消耗能量，即使在您的工作完成之后也是如此。

**Figure 2-2** Fixed vs. dynamic energy costs **图 2-2** 固定的和动态的能量消耗
![Figure 2-2](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9kZXZlbG9wZXIuYXBwbGUuY29tL2xpYnJhcnkvYXJjaGl2ZS9kb2N1bWVudGF0aW9uL1BlcmZvcm1hbmNlL0NvbmNlcHR1YWwvRW5lcmd5R3VpZGUtaU9TL0FydC8yLTJfZml4ZWQtdnMtZHluYW1pYy1lbmVyZ3ktY29zdF8yeC5wbmc?x-oss-process=image/format,png)

## 2.4 Trading Dynamic Cost for Fixed Cost 用动态开销替代固定开销

Your app can avoid sporadic work by batching tasks and performing them less frequently. For example, instead of performing a series of sequential tasks on the same thread, distribute those same tasks simultaneously across multiple threads, as shown in Figure 2-3. Each time the CPU is accessed, memory, caches, buses, and so forth must be powered up. By batching activity, components can be powered up once and used over a shorter period of time.

你的应用程序可以通过分批处理任务并减少执行频率来避免零星工作。例如，不要在同一个线程上执行一系列连续的任务，而是将这些相同的任务同时分布在多个线程上，如图 2-3 所示。每次访问CPU时，内存、缓存、总线等都必须通电。通过批处理活动，这些组件可以通电一次并在较短的时间内完成使用。

This strategy incurs a greater up-front dynamic cost—more work is done at a given time, requiring more power. In exchange, you get a dramatic reduction in fixed cost, which results in tremendous energy savings over time. You app draws more power, but it does so more efficiently and over less time. This lets the CPU get back to idle and other components to power down much more quickly.

这种策略会带来更大的前期动态开销——在给定的时间完成更多的工作，需要更大的功率。而作为交换，您可以大幅降低固定开销，这会随着时间的推移带来巨大的能源节约。你的应用程序消耗了更多的能量，但这样做效率更高且时间更短。这让 CPU 得以回到空闲状态，而其他组件也更快地断电。

As you develop your app, think holistically about its behavior, and try to reduce fixed costs wherever possible.

在开发应用程序时，请全面考虑其行为，并尽可能降低固定开销。

**Figure 2-3** Use multithreading to trade power for energy **图 2-3** 使用多线程以功率换能量

![Figure 2-3](https://imgconvert.csdnimg.cn/aHR0cHM6Ly9kZXZlbG9wZXIuYXBwbGUuY29tL2xpYnJhcnkvYXJjaGl2ZS9kb2N1bWVudGF0aW9uL1BlcmZvcm1hbmNlL0NvbmNlcHR1YWwvRW5lcmd5R3VpZGUtaU9TL0FydC8yLTNfbXVsdGktdGhyZWFkaW5nLXBvd2VyXzJ4LnBuZw?x-oss-process=image/format,png)