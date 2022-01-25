# Dispatch Source 调度源

原文链接：[https://developer.apple.com/documentation/dispatch/dispatch_source?language=objc](https://developer.apple.com/documentation/dispatch/dispatch_source?language=objc)

An object that coordinates the processing of specific low-level system events, such as file-system events, timers, and UNIX signals.
	
协调特定低级系统事件（如文件系统事件、计时器和UNIX信号）处理的对象。

## Topics 主题

### Creating a Dispatch Source

- [dispatch\_source\_create]()

	Creates a new dispatch source to monitor low-level system events.

- [dispatch\_source\_t]()

	An object that coordinates the processing of specific low-level system events, such as file-system events, timers, and UNIX signals.

- [dispatch\_source\_type\_t]()

	An identifier for the type of system object being monitored by a dispatch source.

### Managing Event Handlers

- [dispatch\_source\_set\_registration\_handler\_f]()

	Sets the registration handler function for the given dispatch source.

- [dispatch\_source\_set\_registration\_handler]()

	Sets the registration handler block for the given dispatch source.

- [dispatch\_source\_set\_event\_handler\_f]()

	Sets the event handler function for the given dispatch source.

- [dispatch\_source\_set\_event\_handler]()

	Sets the event handler block for the given dispatch source.

- [dispatch\_source\_set\_cancel\_handler\_f]()

	Sets the cancellation handler function for the given dispatch source.

- [dispatch\_source\_set\_cancel\_handler]()
	
	Sets the cancellation handler block for the given dispatch source.

### Getting Dispatch Source Attributes

- [dispatch\_source\_get\_data]()

	Returns pending data for the dispatch source.

- [dispatch\_source\_get\_mask]()

	Returns the mask of events monitored by the dispatch source.

- [dispatch\_source\_get\_handle]()

	Returns the underlying system handle associated with the specified dispatch source.

- [dispatch\_source\_merge\_data]()

	Merges data into a dispatch source and submits its event handler block to its target queue.

- [dispatch\_source\_proc\_flags\_t]()

	Events related to a process.

- [dispatch\_source\_vnode\_flags\_t]()

	Events involving a change to a file system object.

- [dispatch\_source\_mach\_send\_flags\_t]()

	Mach-related events.

- [dispatch\_source\_memorypressure\_flags\_t]()

	Memory pressure events.

### Managing Timer Parameters

- [dispatch\_source\_set\_timer]()

	Sets a start time, interval, and leeway value for a timer source.

- [dispatch\_source\_timer\_flags\_t]()

	Flags to use when configuring a timer dispatch source.

### Canceling a Dispatch Source

- [dispatch\_source\_cancel]()

	Asynchronously cancels the dispatch source, preventing any further invocation of its event handler block.

- [dispatch\_source\_testcancel]()

	Tests whether the given dispatch source has been canceled.