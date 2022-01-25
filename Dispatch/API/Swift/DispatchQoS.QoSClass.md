# DispatchQoS.QoSClass

原文链接：[https://developer.apple.com/documentation/dispatch/dispatchqos/qosclass](https://developer.apple.com/documentation/dispatch/dispatchqos/qosclass)

Quality-of-service classes that specify the priorities for executing tasks.
	
创建一个新的可以提交 block 的 dispatch 队列。

## Declaration 声明

	enum DispatchQoS.QoSClass

## Overview 概述

Use quality-of-service classes to communicate the intent behind the work that your app performs. The system uses those intentions to determine the best way to execute your tasks given the available resources. For example, the system gives higher priority to threads that contain user-interactive tasks to ensure that those tasks are executed quickly. Conversely, it gives lower priority to background tasks, and may attempt to save power by executing them on more power-efficient CPU cores. The system determines how to execute your tasks dynamically based on system conditions and the tasks you schedule.

使用服务质量类来传递应用程序执行工作背后的意图。系统使用这些意图来确定在给定可用资源的情况下执行任务的最佳方式。例如，系统对包含用户交互任务的线程给予更高的优先级，以确保这些任务能够快速执行。相反，它对后台任务的优先级较低，并且可能试图通过在更省电的CPU内核上执行这些任务来节省电源。系统根据系统条件和计划的任务确定如何动态执行任务。

## Enumeration Case 枚举值

### userInteractive 用户交互

The quality-of-service class for user-interactive tasks, such as animations, event handling, or updating your app's user interface.

用户交互任务（如动画、事件处理或更新应用程序的用户界面）的服务质量类。
 
User-interactive tasks have the highest priority on the system. Use this class for tasks or queues that interact with the user or actively update your app's user interface. For example, use this for class for animations or for tracking events interactively.

用户交互任务在系统上具有最高优先级。将此类用于与用户交互或主动更新应用程序用户界面的任务或队列。例如，将该类用于动画或交互式跟踪事件。


### userInitiated 用户启动

The quality-of-service class for tasks that prevent the user from actively using your app.

阻止用户主动使用应用程序的任务的服务质量类。

User-initiated tasks are second only to user-interactive tasks in their priority on the system. Assign this class to tasks that provide immediate results for something the user is doing, or that would prevent the user from using your app. For example, you might use this quality-of-service class to load the content of an email that you want to display to the user.

用户启动的任务在系统中的优先级仅次于用户交互任务。将此类分配给为用户正在执行的操作提供即时结果的任务，或阻止用户使用您的应用程序的任务。例如，您可以使用此服务质量类加载要显示给用户的电子邮件内容。

### `default` 默认

The default quality-of-service class.

默认服务质量类。

Default tasks have a lower priority than user-initiated and user-interactive tasks, but a higher priority than utility and background tasks. Assign this class to tasks or queues that your app initiates or uses to perform active work on the user's behalf.

默认任务的优先级低于用户启动和用户交互任务，但高于实用任务和后台任务。将此类分配给应用程序初始化，或用于代表用户执行定时工作的任务或队列。

### utility 实用

The quality-of-service class for tasks that the user does not track actively.

用户不主动跟踪的任务的服务质量类。

Utility tasks have a lower priority than default, user-initiated, and user-interactive tasks, but a higher priority than background tasks. Assign this quality-of-service class to tasks that do not prevent the user from continuing to use your app. For example, you might assign this class to long-running tasks whose progress the user does not follow actively.

实用任务的优先级低于默认任务、用户启动任务和用户交互任务，但高于后台任务。将此服务质量类分配给不阻止用户继续使用您的应用程序的任务。例如，您可以将此类分配给长时间运行的任务，而用户不会主动跟踪这些任务的进度。

### background 后台

The quality-of-service class for maintenance or cleanup tasks that you create.

用于维护和清理你创建的任务的服务质量类。

Background tasks have the lowest priority of all tasks. Assign this class to tasks or dispatch queues that you use to perform work while your app is running in the background.

后台任务的优先级最低。将此类分配给当应用程序在后台运行时执行工作的任务或调度队列。

### unspecified 未指定

The absence of a quality-of-service class.

服务质量类不存在。






