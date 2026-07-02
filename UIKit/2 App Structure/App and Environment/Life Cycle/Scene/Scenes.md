# Scenes

原文链接：[https://developer.apple.com/documentation/uikit/scenes](https://developer.apple.com/documentation/uikit/scenes)

Manage multiple instances of your app's UI simultaneously, and direct resources to the appropriate instance of your UI.

同时管理应用 UI 的多个实例，并将资源分配给合适的 UI 实例。


## Overview - 概览

UIKit manages each instance of your app's UI using a [UIWindowScene](https://developer.apple.com/documentation/uikit/uiwindowscene) object. A scene contains the windows and view controllers for presenting one instance of your UI. Each scene also has a corresponding [UIWindowSceneDelegate](https://developer.apple.com/documentation/uikit/uiwindowscenedelegate) object, which you use to coordinate interactions between UIKit and your app. Scenes run concurrently with each other, sharing the same memory and app process space. As a result, a single app may have multiple scenes and scene delegate objects active at the same time.

UIKit 使用 [UIWindowScene](https://developer.apple.com/documentation/uikit/uiwindowscene) 对象管理应用 UI 的每个实例。场景包含用于呈现单个 UI 实例的窗口和视图控制器。每个场景还有对应的 [UIWindowSceneDelegate](https://developer.apple.com/documentation/uikit/uiwindowscenedelegate) 对象，用于协调 UIKit 与应用之间的交互。场景彼此并发运行，共享相同的内存和应用进程空间。因此，一个应用可以同时拥有多个活跃的场景和场景委托对象。

![An image showing two instances of the Notes app running side-by-side on iPad.](https://docs-assets.developer.apple.com/published/2ca9357918eb89b8fdb96cf9e324b12a/media-3335652%402x.png)

Manage the configuration of new scenes from your [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) object.

通过 [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate) 对象管理新场景的配置。


## Topics - 主题

### Essentials - 基础

- [Preparing your UI to run in the foreground](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-foreground)

	Configure your app to appear onscreen.

	配置你的应用以在屏幕上显示。

- [Preparing your UI to run in the background](https://developer.apple.com/documentation/uikit/preparing-your-ui-to-run-in-the-background)

	Prepare your app to be suspended.

	为应用进入挂起状态做好准备。

### Window scenes - 窗口场景

- [Supporting multiple windows on iPad](https://developer.apple.com/documentation/uikit/supporting-multiple-windows-on-ipad)

	Support side-by-side instances of your app's interface and create new windows.

	支持并排显示应用界面的多个实例，并创建新窗口。

- `protocol` [UIWindowSceneDelegate](https://developer.apple.com/documentation/uikit/uiwindowscenedelegate)

	Additional methods that you use to manage app-specific tasks occurring in a scene.

	用于管理场景中应用专属任务的附加方法。

- `class` [UIWindowScene](https://developer.apple.com/documentation/uikit/uiwindowscene)

	A scene that manages one or more windows for your app.

	为应用管理一个或多个窗口的场景。

- `class` [UIScene](https://developer.apple.com/documentation/uikit/uiscene)

	An object that represents one instance of your app's user interface.

	代表应用用户界面单个实例的对象。

- `protocol` [UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate)

	The core methods you use to respond to life-cycle events occurring within a scene.

	用于响应场景内生命周期事件的核心方法。

### Configuration - 配置

- [Specifying the scenes your app supports](https://developer.apple.com/documentation/uikit/specifying-the-scenes-your-app-supports)

	Tell the system about your app's scenes, including the objects you use to manage each scene and its initial user interface.

	向系统说明应用所支持的场景，包括用于管理每个场景的对象及其初始用户界面。

- [UIApplicationSceneManifest](https://developer.apple.com/documentation/bundleresources/information-property-list/uiapplicationscenemanifest)

	The information about the app's scene-based life-cycle support.

	关于应用基于场景的生命周期支持的信息。

- `class` [UISceneConfiguration](https://developer.apple.com/documentation/uikit/uisceneconfiguration)

	Information about the objects and storyboard for UIKit to use when creating a particular scene.

	UIKit 在创建特定场景时所使用的对象和故事板的相关信息。

- `class` [UISceneSession](https://developer.apple.com/documentation/uikit/uiscenesession)

	An object that contains information about one of your app's scenes.

	包含应用某个场景相关信息的对象。

### Activation and destruction - 激活与销毁

- `class` [UISceneActivationConditions](https://developer.apple.com/documentation/uikit/uisceneactivationconditions)

	The set of conditions that define when UIKit activates the current scene.

	定义 UIKit 激活当前场景时机的条件集合。

- `class` [ActivationRequestOptions](https://developer.apple.com/documentation/uikit/uiscene/activationrequestoptions)

	An object that contains information you want the system to use when activating the session associated with a scene.

	包含系统在激活场景关联会话时所需信息的对象。

- `class` [UIWindowSceneDestructionRequestOptions](https://developer.apple.com/documentation/uikit/uiwindowscenedestructionrequestoptions)

	An object that contains information to use when removing a window scene from your app.

	包含从应用中移除窗口场景时所需信息的对象。

- `class` [UISceneDestructionRequestOptions](https://developer.apple.com/documentation/uikit/uiscenedestructionrequestoptions)

	An object you pass to UIKit to permanently remove a scene and its associated session from your app.

	传递给 UIKit 以从应用中永久移除场景及其关联会话的对象。

### URL management - URL 管理

- `class` [UIOpenURLContext](https://developer.apple.com/documentation/uikit/uiopenurlcontext)

	A system-provided object that contains the information you need to open a single URL.

	系统提供的对象，包含打开单个 URL 所需的信息。

- `class` [OpenExternalURLOptions](https://developer.apple.com/documentation/uikit/uiscene/openexternalurloptions)

	Options you specify when asking a scene to open a URL.

	请求场景打开 URL 时指定的选项。

### Errors - 错误

- `enum` [Code](https://developer.apple.com/documentation/uikit/uisceneerror/code)

	Error codes for issues with scenes.

	场景相关问题的错误码。

- `struct` [UISceneError](https://developer.apple.com/documentation/uikit/uisceneerror)

	Errors returned during the creation or management of a scene.

	在创建或管理场景过程中返回的错误。

- `let` [UISceneErrorDomain: String](https://developer.apple.com/documentation/uikit/uisceneerrordomain)

	The domain for scene-related errors.

	场景相关错误的域标识符。

## See Also - 另请参阅

### Life cycle - 生命周期

- [Managing your app's life cycle](https://developer.apple.com/documentation/uikit/managing-your-app-s-life-cycle)

	Respond to system notifications when your app is in the foreground or background, and handle other significant system-related events.

	当应用处于前台或后台时响应系统通知，并处理其他重要的系统相关事件。

- [Responding to the launch of your app](https://developer.apple.com/documentation/uikit/responding-to-the-launch-of-your-app)

	Initialize your app's data structures, prepare your app to run, and respond to any launch-time requests from the system.

	初始化应用的数据结构，为应用运行做好准备，并响应系统在启动时发出的任何请求。

- `class` [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication)

	The centralized point of control and coordination for apps running in iOS.

	iOS 应用运行的集中控制与协调中枢。

- `protocol` [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate)

	A set of methods to manage shared behaviors for your app.

	用于管理应用共享行为的一组方法。
