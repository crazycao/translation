App Programming Guide for iOS




# 6 Inter-App Communication App内部通信

Apps communicate only indirectly with other apps on a device. You can use AirDrop to share files and data with other apps. You can also define a custom URL scheme so that apps can send information to your app using URLs.

App只能间接与设备上的其他app通信。你可以使用AirDrop共享文件和数据给其他app。你也可以定义一个自定义的URL Scheme，让其他app可以使用URL发送信息给你的app。

> **Note:** You can also send files between apps using a [UIDocumentInteractionController](https://developer.apple.com/reference/uikit/uidocumentinteractioncontroller) object or a document picker. For information about adding support for a document interaction controller, see [Document Interaction Programming Topics for iOS](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010403). For information about using a document picker to open files, see [Document Picker Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentPickerProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40014451).

> **注意：** 你也可以使用 [UIDocumentInteractionController](https://developer.apple.com/reference/uikit/uidocumentinteractioncontroller) 对象或者文档采集器在app之间发送文件。 关于添加文档交互控制器的支持的信息，参见《 [Document Interaction Programming Topics for iOS](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010403) 》。关于使用文档采集器打开文件的信息，参见《 [Document Picker Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/DocumentPickerProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40014451) 》。

## 6.1 Supporting AirDrop 支持AirDrop

AirDrop lets you share photos, documents, URLs, and other types of data with nearby devices. AirDrop takes advantage of peer-to-peer networking to find nearby devices and connect to them.

AirDrop让你与附近的设备共享照片，文档，URL，及其他类型的数据。AirDrop利用点对点（P2P）网络找到附近的设备并与他们连接。

###6.1.1 Sending Files and Data to Another App 发送文件和数据给另一个app

To send files and data using AirDrop, use a [UIActivityViewController](https://developer.apple.com/reference/uikit/uiactivityviewcontroller) object to display an activity sheet from your user interface using. When creating this view controller, you specify the data objects that you want to share. The view controller displays only those activities that support the specified data. For AirDrop, you can specify images, strings, URLs, and several other types of data. You can also pass custom objects that adopt the [UIActivityItemSource](https://developer.apple.com/reference/uikit/uiactivityitemsource) protocol.

要使用AirDrop发送文件和数据，需要使用 [UIActivityViewController](https://developer.apple.com/reference/uikit/uiactivityviewcontroller) 对象在用户使用的界面上显示一个活动表。当创建这个视图控制器时，你要指定想要分享的数据对象。这个视图控制器只会显示支持这个指定对象的活动。对于AirDrop，你可以指定图像、字符串、URL以及其他类型的数据。你也可以传递采用了 [UIActivityItemSource](https://developer.apple.com/reference/uikit/uiactivityitemsource) 协议的自定义对象。

To display an activity view controller, you can use code similar to that shown in Listing 6-1. The activity view controller automatically uses the type of the specified object to determine what activities to display in the activity sheet. You do not have to specify the AirDrop activity explicitly. However, you can prevent the sheet from displaying specific types using the view controller’s [excludedActivityTypes](https://developer.apple.com/reference/uikit/uiactivityviewcontroller/1622009-excludedactivitytypes) property. When displaying an activity view controller on iPad, you must use a popover.

要显示活动视图控制器，你可以使用类似于表6-1中展示的代码。活动视图控制器自动使用指定对象的类型决定在活动表中显示哪些活动。你不用明确的指定AirDrop活动。但是你可以使用视图控制器的[excludedActivityTypes](https://developer.apple.com/reference/uikit/uiactivityviewcontroller/1622009-excludedactivitytypes) 属性让某些指定类型不在表中显示。当在iPad上显示活动视图控制器时，你必须使用一个popover。

**Listing 6-1**  Displaying an activity sheet on iPhone

	- (void)displayActivityControllerWithDataObject:(id)obj {
	   UIActivityViewController* vc = [[UIActivityViewController alloc]
	                                initWithActivityItems:@[obj] applicationActivities:nil];
	    [self presentViewController:vc animated:YES completion:nil];
	}

For more information about using the activity view controller, see [UIActivityViewController Class Reference](https://developer.apple.com/reference/uikit/uiactivityviewcontroller). For a complete list of activities and the data types they support, see [UIActivity Class Reference](https://developer.apple.com/reference/uikit/uiactivity).

关于使用活动视图控制器的更多信息，参见 [UIActivityViewController Class Reference](https://developer.apple.com/reference/uikit/uiactivityviewcontroller)。完整的活动列表以及它们支持的数据类型，参见 [UIActivity Class Reference](https://developer.apple.com/reference/uikit/uiactivity)。

###6.1.2 Receiving Files and Data Sent to Your App 接收发送到你的app的文件和数据

To receive files sent to your app using AirDrop, do the following:

要接收使用AirDrop发送到你的app的文件，要做这些事：

- In Xcode, declare support for the document types your app is capable of opening.
- In your app delegate, implement the [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) method. Use that method to receive the data that was sent by the other app.
- Be prepared to look for files in your app’s *Documents/Inbox* directory and move them out of that directory as needed.
- 在Xcode中，声明你的app能支持打开的文档类型。
- 在你的app代理中，实现 [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) 方法。使用这个方法接收由其他app发来的数据。
- 准备好在app的 *Documents/Inbox* 目录里查看文件，如果有必要就把它们移动到其他目录。

The Info tab of your Xcode project contains a Document Types section for specifying the document types your app supports. At a minimum, you must specify a name for your document type and one or more UTIs that represent the data type. For example, to declare support for PNG files, you would include public.png as the UTI string. iOS uses the specified UTIs to determine if your app is eligible to open a given document.

Xcode工程的*Info*标签包含了一个*Document Types*部分，可以指定你的app支持的文档类型。至少你必须指定一个文档类型的名字，以及一个或多个表示该数据类型的UTI（唯一标识符）。例如，要声明支持PNG文件，你需要包含 *public.png* 作为UTI字符串。iOS使用指定的UTI决定app是否有资格打开给出的文档。

After transferring an eligible document to your app’s container, iOS launches your app (if needed) and calls the *application:openURL:sourceApplication:annotation:* method of its app delegate. If your app is in the foreground, you should use this method to open the file and display it to the user. If your app is in the background, you might decide only to note that the file is there so that you can open it later. Because files transferred via AirDrop are encrypted using data protection, you cannot open files unless the device is currently unlocked.

在把有资格的文档传到你app的容器中之后，iOS启动你的app（如果需要）并调用app代理的*application:openURL:sourceApplication:annotation:*方法。如果你的app正在前台，你需要使用这个方法打开文件并显示给用户。如果你的app正在后台，你可能决定只是通知用户文件已经在这里了可以稍后打开。因为通过AirDrop传输的文件是使用数据保护编码的，除非设备当前已解锁，否则你无法打开这些文件。

Files transferred to your app using AirDrop are placed in your app’s *Documents/Inbox* directory. Your app has permission to read and delete files in this directory but it does not have permission to write to files. If you plan to modify the file, you must move it out of the *Inbox* directory before doing so. It is recommended that you delete files from the *Inbox* directory when you no longer need them.

使用AirDrop传输到你的app的文件被放在你的app的 *Documents/Inbox* 目录下。你的app有权限阅读和删除这个文件夹中的文件，但是没有权限写入这些文件。如果你想要修改这个文件，你必须在修改之前将它从 *Inbox* 文件夹移出来。当你不需要这些文件时，推荐你将它们从 *Inbox* 目录删除。

For more information about supporting document types in your app, see [Document-Based App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011149).

关于在app中支持文档类型的更多信息，参见《[Document-Based App Programming Guide for iOS](https://developer.apple.com/library/content/documentation/DataManagement/Conceptual/DocumentBasedAppPGiOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011149)》。

##6.2 Using URL Schemes to Communicate with Apps 使用URL Scheme与App通信

A URL scheme lets you communicate with other apps through a protocol that you define. To communicate with an app that implements such a scheme, you must create an appropriately formatted URL and ask the system to open it. To implement support for a custom scheme, you must declare support for the scheme and handle incoming URLs that use the scheme.

>**Note:** Apple provides built-in support for the http, mailto, tel, and sms URL schemes among others. It also supports http–based URLs targeted at the Maps, YouTube, and iPod apps. The handlers for these schemes are fixed and cannot be changed. If your URL type includes a scheme that is identical to one defined by Apple, the Apple-provided app is launched instead of your app. For information about the schemes supported by apple, see [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

###6.2.1 Sending a URL to Another App

When you want to send data to an app that implements a custom URL scheme, create an appropriately formatted URL and call the [openURL:](https://developer.apple.com/reference/uikit/uiapplication/1622961-openurl) method of the app object. The openURL: method launches the app with the registered scheme and passes your URL to it. At that point, control passes to the new app.

The following code fragment illustrates how one app can request the services of another app (“todolist” in this example is a hypothetical custom scheme registered by an app):

	NSURL *myURL = [NSURL URLWithString:@"todolist://www.acme.com?Quarterly%20Report#200806231300"];
	[[UIApplication sharedApplication] openURL:myURL];

If your app defines a custom URL scheme, it should implement a handler for that scheme as described in Implementing Custom URL Schemes. For more information about the system-supported URL schemes, including information about how to format the URLs, see [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

###6.2.2 Implementing Custom URL Schemes

If your app can receive specially formatted URLs, you should register the corresponding URL schemes with the system. Apps often use custom URL schemes to vend services to other apps. For example, the Maps app supports URLs for displaying specific map locations.

####6.2.2.1 Registering Custom URL Schemes

To register a URL type for your app, include the CFBundleURLTypes key in your app’s Info.plist file. The CFBundleURLTypes key contains an array of dictionaries, each of which defines a URL scheme the app supports. Table 6-1 describes the keys and values to include in each dictionary.

**Table 6-1**  Keys and values of the CFBundleURLTypes property

| **Key**            | **Value**                                |
| ------------------ | ---------------------------------------- |
| CFBundleURLName    | A string containing the abstract name of the URL scheme. To ensure uniqueness, it is recommended that you specify a reverse-DNS style of identifier, for example, com.acme.myscheme.The string you specify is also used as a key in your app’s InfoPlist.strings file. The value of the key is the human-readable scheme name. |
| CFBundleURLSchemes | An array of strings containing the URL scheme names—for example, http, mailto, tel, and sms. |

>**Note:** If more than one third-party app registers to handle the same URL scheme, there is currently no process for determining which app will be given that scheme.

####6.2.2.2 Handling URL Requests

An app that has its own custom URL scheme must be able to handle URLs passed to it. All URLs are passed to your app delegate, either at launch time or while your app is running or in the background. To handle incoming URLs, your delegate should implement the following methods:

- Use the [application:willFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623032-application) and [application:didFinishLaunchingWithOptions:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622921-application) methods to retrieve information about the URL and decide whether you want to open it. If either method returns a NO/a, your app’s URL handling code is not called.
- Use the [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) method to open the file.

If your app is not running when a URL request arrives, it is launched and moved to the foreground so that it can open the URL. The implementation of your application:willFinishLaunchingWithOptions: or application:didFinishLaunchingWithOptions: method should retrieve the URL from its options dictionary and determine whether the app can open it. If it can, return a YES/a and let your application:openURL:sourceApplication:annotation: (or application:handleOpenURL:) method handle the actual opening of the URL. (If you implement both methods, both must return a YES/a before the URL can be opened.) Figure 6-1 shows the modified launch sequence for an app that is asked to open a URL.

**Figure 6-1**  Launching an app to open a URL
![Figure 6-1](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_open_url_2x.png)

If your app is running but is in the background or suspended when a URL request arrives, it is moved to the foreground to open the URL. Shortly thereafter, the system calls the delegate’s application:openURL:sourceApplication:annotation: to check the URL and open it. Figure 6-2 shows the modified process for moving an app to the foreground to open a URL.

**Figure 6-2**  Waking a background app to open a URL
![Figure 6-2](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/app_bg_open_url_2x.png)

>**Note:** Apps that support custom URL schemes can specify different launch images to be displayed when launching the app to handle a URL. For more information about how to specify these launch images, see Displaying a Custom Launch Image When a URL is Opened.

All URLs are passed to your app in an [NSURL](https://developer.apple.com/reference/foundation/nsurl) object. It is up to you to define the format of the URL, but the NSURL class conforms to the RFC 1808 specification and therefore supports most URL formatting conventions. Specifically, the class includes methods that return the various parts of a URL as defined by RFC 1808, including the user, password, query, fragment, and parameter strings. The “protocol” for your custom scheme can use these URL parts for conveying various kinds of information.

In the implementation of [application:openURL:sourceApplication:annotation:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623073-application) shown in Listing 6-2, the passed-in URL object conveys app-specific information in its query and fragment parts. The delegate extracts this information—in this case, the name of a to-do task and the date the task is due—and with it creates a model object of the app. This example assumes that the user is using a Gregorian calendar. If your app supports non-Gregorian calendars, you need to design your URL scheme accordingly and be prepared to handle those other calendar types in your code.

**Listing 6-2**  Handling a URL request based on a custom scheme

	- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
	        sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	    if ([[url scheme] isEqualToString:@"todolist"]) {
	        ToDoItem *item = [[ToDoItem alloc] init];
	        NSString *taskName = [url query];
	        if (!taskName || ![self isValidTaskString:taskName]) { // must have a task name
	            return NO;
	        }
	        taskName = [taskName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	 
	        item.toDoTask = taskName;
	        NSString *dateString = [url fragment];
	        if (!dateString || [dateString isEqualToString:@"today"]) {
	            item.dateDue = [NSDate date];
	        } else {
	            if (![self isValidDateString:dateString]) {
	                return NO;
	            }
	            // format: yyyymmddhhmm (24-hour clock)
	            NSString *curStr = [dateString substringWithRange:NSMakeRange(0, 4)];
	            NSInteger yeardigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(4, 2)];
	            NSInteger monthdigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(6, 2)];
	            NSInteger daydigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(8, 2)];
	            NSInteger hourdigit = [curStr integerValue];
	            curStr = [dateString substringWithRange:NSMakeRange(10, 2)];
	            NSInteger minutedigit = [curStr integerValue];
	 
	            NSDateComponents *dateComps = [[NSDateComponents alloc] init];
	            [dateComps setYear:yeardigit];
	            [dateComps setMonth:monthdigit];
	            [dateComps setDay:daydigit];
	            [dateComps setHour:hourdigit];
	            [dateComps setMinute:minutedigit];
	            NSCalendar *calendar = [s[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	            NSDate *itemDate = [calendar dateFromComponents:dateComps];
	            if (!itemDate) {
	                return NO;
	            }
	            item.dateDue = itemDate;
	        }
	 
	        [(NSMutableArray *)self.list addObject:item];
	        return YES;
	    }
	    return NO;
	}

Be sure to validate the input you get from URLs passed to your app; see [Validating Input and Interprocess Communication](https://developer.apple.com/library/content/documentation/Security/Conceptual/SecureCodingGuide/Articles/ValidatingInput.html#//apple_ref/doc/uid/TP40007246) in [Secure Coding Guide](https://developer.apple.com/library/content/documentation/Security/Conceptual/SecureCodingGuide/Introduction.html#//apple_ref/doc/uid/TP40002415) to find out how to avoid problems related to URL handling. To learn about URL schemes defined by Apple, see [Apple URL Scheme Reference](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

###6.2.3 Displaying a Custom Launch Image When a URL is Opened 当打开URL时显示自定义的启动图像

Apps that support custom URL schemes can provide a custom launch image for each scheme. When the system launches your app to handle a URL and no relevant snapshot is available, it displays the launch image you specify. To specify a launch image, provide a PNG image whose name uses the following naming conventions:

*\<basename>-\<url_scheme>\<other_modifiers>.png*

In this naming convention, basename represents the base image name specified by the *UILaunchImageFile* key in your app’s *Info.plist* file. If you do not specify a custom base name, use the string *Default*. The *<url_scheme>* portion of the name is your URL scheme name. To specify a generic launch image for the *myapp* URL scheme, you would include an image file with the name *Default-myapp@2x.png* in the app’s bundle. (The @2x modifier signifies that the image is intended for Retina displays. If your app also supports standard resolution displays, you would also provide a *Default-myapp.png* image.)

For information about the other modifiers you can include in launch image names, see the description of the *UILaunchImageFile* name key in [Information Property List Key Reference](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247).

#7 Performance Tips 性能提示

At each step in the development of your app, consider the implications of your design choices on the overall performance of your app. Power usage and memory consumption are extremely important considerations for iOS apps, and there are many other considerations as well. The following sections describe the factors you should consider throughout the development process.

##7.1 Reduce Your App’s Power Consumption 降低你App的能量消耗

Power consumption on mobile devices is always an issue. The power management system in iOS conserves power by shutting down any hardware features that are not currently being used. You can help improve battery life by optimizing your use of the following features:

- The CPU
- Wi-Fi, Bluetooth, and baseband (EDGE, 3G) radios
- The Core Location framework
- The accelerometers
- The disk

The goal of your optimizations should be to do the most work you can in the most efficient way possible. You should always optimize your app’s algorithms using Instruments. But even the most optimized algorithm can still have a negative impact on a device’s battery life. You should therefore consider the following guidelines when writing your code:

- Avoid doing work that requires polling. Polling prevents the CPU from going to sleep. Instead of polling, use the [NSRunLoop](https://developer.apple.com/reference/foundation/runloop) or [NSTimer](https://developer.apple.com/reference/foundation/nstimer) classes to schedule work as needed.
- Leave the [idleTimerDisabled](https://developer.apple.com/reference/uikit/uiapplication/1623070-isidletimerdisabled) property of the shared [UIApplication](https://developer.apple.com/reference/uikit/uiapplication) object set to a NO/a whenever possible. The idle timer turns off the device’s screen after a specified period of inactivity. If your app does not need the screen to stay on, let the system turn it off. If your app experiences side effects as a result of the screen being turned off, you should modify your code to eliminate the side effects rather than disable the idle timer unnecessarily.
- Coalesce work whenever possible to maximize idle time. It generally takes less power to perform a set of calculations all at once than it does to perform them in small chunks over an extended period of time. Doing small bits of work periodically requires waking up the CPU more often and getting it into a state where it can perform your tasks.
- Avoid accessing the disk too frequently. For example, if your app saves state information to the disk, do so only when that state information changes, and coalesce changes whenever possible to avoid writing small changes at frequent intervals.
- Do not draw to the screen faster than is needed. Drawing is an expensive operation when it comes to power. Do not rely on the hardware to throttle your frame rates. Draw only as many frames as your app actually needs.
- If you use the [UIAccelerometer](https://developer.apple.com/reference/uikit/uiaccelerometer) class to receive regular accelerometer events, disable the delivery of those events when you do not need them. Similarly, set the frequency of event delivery to the smallest value that is suitable for your needs. For more information, see [Event Handling Guide for iOS](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009541).

The more data you transmit to the network, the more power must be used to run the radios. In fact, accessing the network is the most power-intensive operation you can perform. You can minimize that time by following these guidelines:

- Connect to external network servers only when needed, and do not poll those servers.
- When you must connect to the network, transmit the smallest amount of data needed to do the job. Use compact data formats, and do not include excess content that simply is ignored.
- Transmit data in bursts rather than spreading out transmission packets over time. The system turns off the Wi-Fi and cell radios when it detects a lack of activity. When it transmits data over a longer period of time, your app uses much more power than when it transmits the same amount of data in a shorter amount of time. When using the [NSURLSession](https://developer.apple.com/reference/foundation/urlsession) class to enqueue multiple upload or download tasks, enqueue those items together rather than waiting for one to finish before starting the next one. The system manages automatically executes queued tasks when it is most efficient to do so. 
- Connect to the network using the Wi-Fi radios whenever possible. Wi-Fi uses less power and is preferred over cellular radios.
- If you use the Core Location framework to gather location data, disable location updates as soon as you can and set the distance filter and accuracy levels to appropriate values. Core Location uses the available GPS, cell, and Wi-Fi networks to determine the user’s location. Although Core Location works hard to minimize the use of these radios, setting the accuracy and filter values gives Core Location the option to turn off hardware altogether in situations where it is not needed. For more information, see [Location and Maps Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009497).

The Instruments app includes several instruments for gathering power-related information. You can use these instruments to gather general information about power consumption and to gather specific measurements for hardware such as the Wi-Fi and Bluetooth radios, GPS receiver, display, and CPU. You can also enable Energy Diagnostics Logging on a device to gather information. For information about using Instruments to gather power-related data, see [Instruments User Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/index.html#//apple_ref/doc/uid/TP40004652). For information about how to enable Energy Diagnostics Logging on a device, see [Instruments Help](https://help.apple.com/instruments).

##7.2 Use Memory Efficiently 有效的使用内存

Apps are encouraged to use as little memory as possible so that the system may keep more apps in memory or dedicate more memory to foreground apps that truly need it. There is a direct correlation between the amount of free memory available to the system and the relative performance of your app. Less free memory means that the system is more likely to have trouble fulfilling future memory requests.

To ensure there is always enough free memory available, you should minimize your app’s memory usage and be responsive when the system asks you to free up memory.

###7.2.1 Observe Low-Memory Warnings 监控低内存警告

When the system dispatches a low-memory warning to your app, respond immediately. Low-memory warnings are your opportunity to remove references to objects that you do not need. Responding to these warnings is crucial because apps that fail to do so are more likely to be terminated. The system delivers memory warnings to your app using the following APIs:

- The [applicationDidReceiveMemoryWarning:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623063-applicationdidreceivememorywarni) method of your app delegate.
- The [didReceiveMemoryWarning](https://developer.apple.com/reference/uikit/uiviewcontroller/1621409-didreceivememorywarning) method of your UIViewController classes.
- The [UIApplicationDidReceiveMemoryWarningNotification](https://developer.apple.com/reference/foundation/nsnotification.name/1622920-uiapplicationdidreceivememorywar) notification.
- Dispatch sources of type [DISPATCH_SOURCE_TYPE_MEMORYPRESSURE](https://developer.apple.com/reference/dispatch/dispatch_source_type_memorypressure). This technique is the only one that you can use to distinguish the severity of the memory pressure.

Upon receiving any of these warnings, your handler method should respond by immediately freeing up any unneeded memory. Use the warnings to clear out caches and release images. If you have large data structures that are not being used, write those structures to disk and release the in-memory copies of the data.

If your data model includes known purgeable resources, you can have a corresponding manager object register for the UIApplicationDidReceiveMemoryWarningNotification notification and remove strong references to its purgeable resources directly. Handling this notification directly avoids the need to route all memory warning calls through the app delegate.

>**Note:** You can test your app’s behavior under low-memory conditions using the Simulate Memory Warning command in iOS Simulator.

###7.2.2 Reduce Your App’s Memory Footprint 减少App占用的内存空间

Starting off with a low footprint gives you more room for expanding your app later. Table 7-1 lists some tips on how to reduce your app’s overall memory footprint.

**Table 7-1**  Tips for reducing your app’s memory footprint

| **Tip**                                  | **Actions to take**                      |
| ---------------------------------------- | ---------------------------------------- |
| Eliminate memory leaks.                  | Because memory is a critical resource in iOS, your app should never have memory leaks. Use the Instruments app to track down leaks in your code, both in Simulator and on actual devices. For more information on using Instruments, see [Instruments User Guide](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/index.html#//apple_ref/doc/uid/TP40004652). |
| Make resource files as small as possible. | Files reside on disk but must be loaded into memory before they can be used. Compress all image files to make them as small as possible. (To compress PNG images—the preferred image format for iOS apps—use the pngcrush tool.) You can make property list files smaller by writing them out in a binary format using the [NSPropertyListSerialization](https://developer.apple.com/reference/foundation/nspropertylistserialization) class. |
| Use Core Data or SQLite for large data sets. | If your app manipulates large amounts of structured data, store it in a Core Data persistent store or in a SQLite database instead of in a flat file. Both Core Data and SQLite provides efficient ways to manage large data sets without requiring the entire set to be in memory all at once. |
| Load resources lazily.                   | You should never load a resource file until it is actually needed. Prefetching resource files may seem like a way to save time, but this practice actually slows down your app right away. In addition, if you end up not using the resource, loading it wastes memory for no good purpose. |

###7.2.3 Allocate Memory Wisely 谨慎的分配内存

Table 7-2 lists tips for improving memory usage in your app.

**Table 7-2**  Tips for allocating memory

| **Tip**                          | **Actions to take**                      |
| -------------------------------- | ---------------------------------------- |
| Impose size limits on resources. | Avoid loading a large resource file when a smaller one will do. Instead of using a high-resolution image, use one that is appropriately sized for iOS-based devices. If you must use large resource files, find ways to load only the portion of the file that you need at any given time. For example, rather than load the entire file into memory, use the mmap and munmap functions to map portions of the file into and out of memory. For more information about mapping files into memory, see a target="_self" File-System Performance Guidelines/a. |
| Avoid unbounded problem sets.    | Unbounded problem sets might require an arbitrarily large amount of data to compute. If the set requires more memory than is available, your app may be unable to complete the calculations. Your apps should avoid such sets whenever possible and work on problems with known memory limits. |

For detailed information about ARC and memory management, see [Transitioning to ARC Release Notes](https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226).

##7.3 Tune Your Networking Code 调节你的网络代码

The networking stack in iOS includes several interfaces for communicating over the radio hardware of iOS devices. The main programming interface is the CFNetwork framework, which builds on top of BSD sockets and opaque types in the Core Foundation framework to communicate with network entities. You can also use the [NSStream](https://developer.apple.com/reference/foundation/nsstream) classes in the Foundation framework and the low-level BSD sockets found in the Core OS layer of the system.

For information about how to use the CFNetwork framework for network communication, see [CFNetwork Programming Guide](https://developer.apple.com/library/content/documentation/Networking/Conceptual/CFNetwork/Introduction/Introduction.html#//apple_ref/doc/uid/TP30001132) and [CFNetwork Framework Reference](https://developer.apple.com/reference/cfnetwork). For information about using the NSStream class, see [Foundation Framework Reference](https://developer.apple.com/reference/foundation).

###7.3.1 Tips for Efficient Networking 高效网络的建议

Implementing code to receive or transmit data across the network is one of the most power-intensive operations on a device. Minimizing the amount of time spent transmitting or receiving data helps improve battery life. To that end, you should consider the following tips when writing your network-related code:

- For protocols you control, define your data formats to be as compact as possible.
- Avoid using chatty protocols.
- Transmit data packets in bursts whenever you can.

Cellular and Wi-Fi radios are designed to power down when there is no activity. Depending on the radio, though, doing so can take several seconds. If your app transmits small bursts of data every few seconds, the radios may stay powered up and continue to consume power, even when they are not actually doing anything. Rather than transmit small amounts of data more often, it is better to transmit a larger amount of data once or at relatively large intervals.

When communicating over the network, packets can be lost at any time. Therefore, when writing your networking code, you should be sure to make it as robust as possible when it comes to failure handling. It is perfectly reasonable to implement handlers that respond to changes in network conditions, but do not be surprised if those handlers are not called consistently. For example, the Bonjour networking callbacks may not always be called immediately in response to the disappearance of a network service. The Bonjour system service immediately invokes browsing callbacks when it receives a notification that a service is going away, but network services can disappear without notification. This situation might occur if the device providing the network service unexpectedly loses network connectivity or the notification is lost in transit.

###7.3.2 Using Wi-Fi 使用Wi-Fi

If your app accesses the network using the Wi-Fi radios, you must notify the system of that fact by including the UIRequiresPersistentWiFi key in the app’s Info.plist file. The inclusion of this key lets the system know that it should display the network selection dialog if it detects any active Wi-Fi hot spots. It also lets the system know that it should not attempt to shut down the Wi-Fi hardware while your app is running.

To prevent the Wi-Fi hardware from using too much power, iOS has a built-in timer that turns off the hardware completely after 30 minutes if no running app has requested its use through the UIRequiresPersistentWiFi key. If the user launches an app that includes the key, iOS effectively disables the timer for the duration of the app’s life cycle. As soon as that app quits or is suspended, however, the system reenables the timer.

>**Note:** Note that even when *UIRequiresPersistentWiFi* has a value of true, it has no effect when the device is idle (that is, screen-locked). The app is considered inactive, and although it may function on some levels, it has no Wi-Fi connection.

For more information on the *UIRequiresPersistentWiFi* key and the keys of the Info.plist file, see [The Information Property List File](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/ExpectedAppBehaviors/ExpectedAppBehaviors.html#//apple_ref/doc/uid/TP40007072-CH3-SW5).

###7.3.3 The Airplane Mode Alert 飞行模式警告

If your app launches while the device is in airplane mode, the system may display an alert to notify the user of that fact. The system displays this alert only when all of the following conditions are met:

- Your app’s information property list (*Info.plist*) file contains the *UIRequiresPersistentWiFi* key and the value of that key is set to true.
- Your app launches while the device is currently in airplane mode.
- Wi-Fi on the device has not been manually reenabled after the switch to airplane mode.

##7.4 Improve Your File Management 提升你的文件管理

Minimize the amount of data you write to the disk. File operations are relatively slow and involve writing to the flash drive, which has a limited lifespan. Some specific tips to help you minimize file-related operations include:

- Write only the portions of the file that changed, and aggregate changes when you can. Avoid writing out the entire file just to change a few bytes.
- When defining your file format, group frequently modified content together to minimize the overall number of blocks that need to be written to disk each time.
- If your data consists of structured content that is randomly accessed, store it in a Core Data persistent store or a SQLite database, especially if the amount of data you are manipulating could grow to more than a few megabytes.

Avoid writing cache files to disk. The only exception to this rule is when your app quits and you need to write state information that can be used to put your app back into the same state when it is next launched.

##7.5 Make App Backups More Efficient 让App备份更有效

Backups occur wirelessly via iCloud or when the user syncs the device with iTunes. During backups, files are transferred from the device to the user’s computer or iCloud account. The location of files in your app sandbox determines whether or not those files are backed up and restored. If your application creates many large files that change regularly and puts them in a location that is backed up, backups could be slowed down as a result. As you write your file-management code, you need to be mindful of this fact.

###7.5.1 App Backup Best Practices App备份的最佳实践

You do not have to prepare your app in any way for backup and restore operations. Devices with an active iCloud account have their app data backed up to iCloud at appropriate times. For devices that are plugged into a computer, iTunes performs an incremental backup of the app’s data files. However, iCloud and iTunes do not back up the contents of the following directories:

- \<Application_Home>/AppName.app
- \<Application_Data>/Library/Caches
- \<Application_Data>/tmp

To prevent the syncing process from taking a long time, be selective about where you place files inside your app’s home directory. Apps that store large files can slow down the process of backing up to iTunes or iCloud. These apps can also consume a large amount of a user's available storage, which may encourage the user to delete the app or disable backup of that app's data to iCloud. With this in mind, you should store app data according to the following guidelines:

- Critical data should be stored in the <Application_Data>/Documents directory. Critical data is any data that cannot be recreated by your app, such as user documents and other user-generated content.

- Support files include files your application downloads or generates and that your application can recreate as needed. The location for storing your application’s support files depends on the current iOS version.

  - In iOS 5.1 and later, store support files in the <Application_Data>/Library/Application Support directory and add the [NSURLIsExcludedFromBackupKey](https://developer.apple.com/reference/foundation/urlresourcekey/1408756-isexcludedfrombackupkey) attribute to the corresponding NSURL object using the [setResourceValue:forKey:error:](https://developer.apple.com/reference/foundation/nsurl/1413819-setresourcevalue) method. (If you are using Core Foundation, add the [kCFURLIsExcludedFromBackupKey](https://developer.apple.com/reference/corefoundation/kcfurlisexcludedfrombackupkey) key to your CFURLRef object using the [CFURLSetResourcePropertyForKey](https://developer.apple.com/reference/corefoundation/1541607-cfurlsetresourcepropertyforkey) function.) Applying this attribute prevents the files from being backed up to iTunes or iCloud. If you have a large number of support files, you may store them in a custom subdirectory and apply the extended attribute to just the directory.
  - In iOS 5.0 and earlier, store support files in the <Application_Data>/Library/Caches directory to prevent them from being backed up. If you are targeting iOS 5.0.1, see [How do I prevent files from being backed up to iCloud and iTunes?](https://developer.apple.com/library/content/qa/qa1719/_index.html#//apple_ref/doc/uid/DTS40011342) for information about how to exclude files from backups.

- Cached data should be stored in the <Application_Data>/Library/Caches directory. Examples of files you should put in the Caches directory include (but are not limited to) database cache files and downloadable content, such as that used by magazine, newspaper, and map apps. Your app should be able to gracefully handle situations where cached data is deleted by the system to free up disk space.

- Temporary data should be stored in the <Application_Data>/tmp directory. Temporary data comprises any data that you do not need to persist for an extended period of time. Remember to delete those files when you are done with them so that they do not continue to consume space on the user's device.

Although iTunes backs up the app bundle itself, it does not do this during every sync operation. Apps purchased directly from a device are backed up when that device is next synced with iTunes. Apps are not backed up during subsequent sync operations, though, unless the app bundle itself has changed (because the app was updated, for example).

For additional guidance about how you should use the directories in your app, see [File System Programming Guide](https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010672).

###7.5.2 Files Saved During App Updates 在App更新时保存文件

When a user downloads an app update, iTunes installs the update in a new app directory. It then moves the user’s data files from the old installation over to the new app directory before deleting the old installation. Files in the following directories are guaranteed to be preserved during the update process:

- \<Application_Data>/Documents
- \<Application_Data>/Library

Although files in other user directories may also be moved over, you should not rely on them being present after an update.

##7.6 Move Work off the Main Thread 将工作移出主线程

Be sure to limit the type of work you do on the main thread of your app. The main thread is where your app handles touch events and other user input. To ensure that your app is always responsive to the user, you should never use the main thread to perform long-running or potentially unbounded tasks, such as tasks that access the network. Instead, you should always move those tasks onto background threads. The preferred way to do so is to use Grand Central Dispatch (GCD) or [NSOperation](https://developer.apple.com/reference/foundation/nsoperation) objects to perform tasks asynchronously.

Moving tasks into the background leaves your main thread free to continue processing user input, which is especially important when your app is starting up or quitting. During these times, your app is expected to respond to events in a timely manner. If your app’s main thread is blocked at launch time, the system could kill the app before it even finishes launching. If the main thread is blocked at quitting time, the system could similarly kill the app before it has a chance to write out crucial user data.

For more information about using GCD, operation objects, and threads, see [Concurrency Programming Guide](https://developer.apple.com/library/content/documentation/General/Conceptual/ConcurrencyProgrammingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008091).