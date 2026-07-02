# TN3187: Migrating to the UIKit scene-based life cycle
# TN3187: 迁移到基于 UIKit Scene 的生命周期

原文地址：
[https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle](https://developer.apple.com/documentation/technotes/tn3187-migrating-to-the-uikit-scene-based-life-cycle)

Update your app to receive scene-based life-cycle events and manage your user interface using scene objects and methods.

更新你的应用，以接收基于场景的生命周期事件，并使用场景对象和方法来管理你的用户界面。

# Overview 概览

A scene represents an instance of your app’s user interface. In a document-based app, such as a text editor, each open document can be displayed in its own scene, enabling users to work on multiple documents side by side.

**场景** 代表应用用户界面的一个实例。在基于文档的应用（如文本编辑器）中，每个打开的文档都可以在独立的场景中显示，让用户能够同时处理多个文档。

In iOS 18.4, iPadOS 18.4, Mac Catalyst 18.4, tvOS 18.4, visionOS 2.4 and later, UIKit logs the following message for apps that haven’t adopted the scene-based life-cycle:

在 iOS 18.4、iPadOS 18.4、Mac Catalyst 18.4、tvOS 18.4、visionOS 2.4 及更高版本中，UIKit 会对未采用基于场景的生命周期的应用输出以下日志信息：

```
This process does not adopt UIScene lifecycle. 
This will become an assert in a future version.
```

```
此进程未采用 UIScene 生命周期。
该问题将在未来系统版本中变为断言错误。
```

In iOS 26, iPadOS 26, Mac Catalyst 26, tvOS 26, visionOS 26 , the log message has been updated to:

在 iOS 26、iPadOS 26、Mac Catalyst 26、tvOS 26、visionOS 26 中，该日志信息已更新为：

```
UIScene lifecycle will soon be required. 
Failure to adopt will result in an assert in the future.
```

```
UIScene 生命周期即将成为必需项。
未采用将在未来触发断言错误。
```

In the next major release following iOS 26, UIScene lifecycle will be required when building with the latest SDK; otherwise, your app won’t launch. While supporting multiple scenes is encouraged, only adoption of scene life-cycle is required.

在 iOS 26 之后的下一个重大版本中，使用最新 SDK 构建应用时，必须采用 UIScene 生命周期，否则应用将无法启动。尽管我们鼓励支持多场景，但系统仅强制要求接入场景生命周期。

This guide will help you add scene support to your app so you can receive scene-specific life-cycle events from UIKit and manage your user interface using scene objects and methods. For more information about how to configure scene support, see [Specifying the scenes your app supports](https://developer.apple.com/documentation/UIKit/specifying-the-scenes-your-app-supports).

本指南将帮助你为应用添加场景支持，从而接收 UIKit 下发的场景专属生命周期事件，并通过场景对象与方法管理用户界面。有关如何配置场景支持的更多信息，请参阅《[指定你的应用所支持的场景](https://developer.apple.com/documentation/UIKit/specifying-the-scenes-your-app-supports)》。

# Determine if your app should migrate 确定你的应用是否需要迁移

Migrate to the scene-based life-cycle if your app meets either of the following conditions:

- The [UIApplicationSceneManifest](https://developer.apple.com/documentation/BundleResources/Information-Property-List/UIApplicationSceneManifest) key is missing from your [Info.plist](https://developer.apple.com/documentation/BundleResources/Information-Property-List) or it has no specified configurations.
- You haven’t implemented the [application(_:configurationForConnecting:options:)](https://developer.apple.com/documentation/UIKit/UIApplicationDelegate/application(_:configurationForConnecting:options:)) method in your app delegate.

如果你的应用满足以下任一条件，请迁移到基于场景的生命周期：

- 你的 [Info.plist](https://developer.apple.com/documentation/BundleResources/Information-Property-List) 文件中缺少 [UIApplicationSceneManifest](https://developer.apple.com/documentation/BundleResources/Information-Property-List/UIApplicationSceneManifest) 键，或者该键未指定任何配置。
- 你尚未在应用委托中实现 [application(_:configurationForConnecting:options:)](https://developer.apple.com/documentation/UIKit/UIApplicationDelegate/application(_:configurationForConnecting:options:)) 方法。

# Understand the scene-based life-cycle 理解基于场景的生命周期

A scene contains the windows and view controllers for presenting one instance of your UI. UIKit manages each instance of your app’s UI using a `UIWindowScene` object.

场景包含用于展示单个用户界面实例的窗口和视图控制器。UIKit 会使用 `UIWindowScene` 对象来管理应用用户界面的每个实例。

You can specify a `UIWindowScene` object by including the class name for the scene in the Info.plist scene manifest.

你可以通过在 Info.plist 的场景配置清单中加入场景的类名来指定 `UIWindowScene` 对象。

Alternatively, you can specify the class name when creating a `UISceneConfiguration` object in your app delegate’s `application(:configurationForConnecting:options:)` method. When the user interacts with your app, the system creates an appropriate scene object based on the configuration data you provided. To request a scene programmatically, call the `activateSceneSession(for:errorHandler:)` method of `UIApplication`.

或者，你也可以在应用委托的 `application(_:configurationForConnecting:options:)` 方法中创建 `UISceneConfiguration` 对象时指定对应的类名。当用户与你的应用交互时，系统会根据你提供的配置数据创建合适的场景对象。若要以代码方式请求场景，可调用 `UIApplication` 的 `activateSceneSession(for:errorHandler:)` 方法。

In a scene-based app:

- UIKit usually creates a UIWindowScene object instead of a UIScene object. When configuring your app’s scene support, specify UIWindowScene objects instead of UIScene objects.
- Use CPTemplateApplicationScene if your app is adopting scenes for CarPlay. To learn how to add a CarPlay scene see [Displaying Content in CarPlay](https://developer.apple.com/documentation/CarPlay/displaying-content-in-carplay).
- UISceneSession contains a unique identifier and the configuration details of the scene.
- UISceneDelegate and UIWindowSceneDelegate both handle scene-specific life-cycle events.
- UISceneConfiguration defines how to create and configure scenes.

在基于场景的应用中：

- UIKit 通常会创建 `UIWindowScene` 对象，而非 `UIScene` 对象。在配置应用的场景支持时，请指定 `UIWindowScene` 对象，而非 `UIScene` 对象。
- 如果你的应用为 CarPlay 接入场景，请使用 `CPTemplateApplicationScene`。有关如何添加 CarPlay 场景的详情，请参阅《[在 CarPlay 中展示内容](https://developer.apple.com/documentation/CarPlay/displaying-content-in-carplay)》。
- `UISceneSession` 包含场景的唯一标识符和配置详情。
- `UISceneDelegate` 和 `UIWindowSceneDelegate` 均用于处理场景专属的生命周期事件。
- `UISceneConfiguration` 定义了如何创建和配置场景。

Unlike the `UIApplicationDelegate` object, which manages a single app-wide life-cycle, the scene-based life-cycle divides your app’s overall life cycle into two components:

- The application life cycle, such as when your app process launches.
- The life cycle of when an app has UI visible on screen, embodied by a scene.

与管理应用全局单一生命周期的 `UIApplicationDelegate` 对象不同，基于场景的生命周期将应用的整体生命周期分为两部分：

- 应用生命周期：例如应用进程启动时。
- 应用在屏幕上显示用户界面时的生命周期：由场景来体现。

# Adopt the scene-based life cycle 采用基于场景的生命周期

The simplest way to configure your app’s scenes is to add a `UIApplicationSceneManifest` key with a scene configuration in the Info.plist file.

配置应用场景最简单的方式，是在 Info.plist 文件中添加带有场景配置的 `UIApplicationSceneManifest` 键。

Apps that require dynamic scene configurations, such as supporting multiple scenes, customizing scenes based on user activities, or handling different scene roles can implement the `application(_:configurationForConnecting:options:)` method in the app delegate.

需要动态场景配置的应用，例如支持多场景、基于用户活动自定义场景，或处理不同场景角色，可以在应用委托中实现 `application(_:configurationForConnecting:options:)` 方法。

# Configure the Info.plist for scene support 为场景支持配置 Info.plist 文件

To configure your Info.plist for scene support, you should add a `UIApplicationSceneManifest` key with a scene configuration:

1. Open your Xcode project.
2. Select your app target.
3. Navigate to the `General` settings for your app target.
4. Select “Scene manifest” in the Deployment Info section.
5. Edit the Info.plist file and add a UIApplicationSceneManifest key

要为场景支持配置你的 Info.plist 文件，你需要添加 `UIApplicationSceneManifest` 键并配置对应的场景信息：

1. 打开你的 Xcode 项目。
2. 选择你的应用目标（app target）。
3. 进入该应用目标的 `General`(通用) 设置页面。
4. 在 `Deployment Info`(部署信息) 区域选择 “Scene manifest”(场景配置清单)。
5. 编辑 Info.plist 文件，添加 `UIApplicationSceneManifest` 键。

For example:

例如：

```
<key>UIApplicationSceneManifest</key>
<dict>
    <key>UIApplicationSupportsMultipleScenes</key>
    <false/> 
    <key>UISceneConfigurations</key>
    <dict>
        <key>UIWindowSceneSessionRoleApplication</key>
        <array>
            <dict>
                <key>UISceneConfigurationName</key>
                <string>Default Configuration</string>
                <key>UISceneDelegateClassName</key>
                <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                <key>UISceneStoryboardFile</key>
                <string>Main</string> 
            </dict>
        </array>
    </dict>
</dict>
```

> **Note** **注意**
>
> Supporting multiple scenes is optional. Adopting multiple scenes may require restructuring your app to make your data model more scene-specific. Consider whether your app’s user experience would benefit from it before supporting multiple scenes.
> 
> 支持多场景为可选配置。启用多场景可能需要重构你的应用，使数据模型更贴合场景专属的特性。在决定支持多场景前，请评估该功能是否能为你的应用用户体验带来实际价值。

To support multiple scenes, include the `UIApplicationSupportsMultipleScenes` key with its Boolean value set to `true`, which indicates that the app supports two or more scenes simultaneously. Each `UISceneConfiguration` should have a unique configuration name when supporting multiple scenes.

若要支持多场景，需将 `UIApplicationSceneManifest` 下的 `UIApplicationSupportsMultipleScenes` 键的布尔值设为 `true`，表示应用支持同时运行两个或更多场景。支持多场景时，每个 `UISceneConfiguration` 都应配置唯一的配置名称。

# Provide scene configurations from your app delegate for dynamic configuration 从应用委托提供场景配置以实现动态配置

Implement the `application(_:configurationForConnecting:options:)` method in your app delegate if you don’t include scene-configuration data in your app’s Info.plist file or if your app requires dynamic scene configuration—such as, loading different scenes based on user activity or session specific data.

如果你的应用未在 Info.plist 文件中包含场景配置数据，或应用需要动态场景配置（例如基于用户活动或会话专属数据加载不同场景），请在应用委托中实现 `application(_:configurationForConnecting:options:)` 方法。

```
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {


        // Each UISceneConfiguration have a unique configuration name.
        // The configuration name is a app-specific name
        // you use to identify the scene, and it corresponds to entries
        // in the `Info.plist` scene manifest.
        // 每个 UISceneConfiguration 都应有唯一的配置名称。
        // 配置名称是你用于标识场景的应用专属名称，
        // 它与 Info.plist 场景配置清单中的条目一一对应。
        var configurationName: String!
    
        switch options.userActivities.first?.activityType {
        case UserActivity.GalleryOpenInspectorActivityType:
            // Create a photo inspector window scene.
            // 创建照片检视器窗口场景
            configurationName = "Inspector Configuration"
        default:
            // Create a default gallery window scene.
            // 创建默认的图库窗口场景
            configurationName = "Default Configuration"
        }
        
        return UISceneConfiguration(
            name: configurationName,
            sessionRole: connectingSceneSession.role
        )
    }
}
```

In this example, through the use of a unique `NSUserActivity.activityType`, the app can distinguish which new scene to create.

在此示例中，应用通过唯一的 `NSUserActivity.activityType` 来区分需要创建的新场景类型。

To learn more about how to configure your app for different scene types and customize scene behavior, see [Specifying the scenes your app supports](https://developer.apple.com/documentation/UIKit/specifying-the-scenes-your-app-supports), and for more information about how to create multiple windows programmatically, see [Supporting multiple windows on iPad](https://developer.apple.com/documentation/UIKit/supporting-multiple-windows-on-ipad).

如需了解如何为不同场景类型配置应用、自定义场景行为，请参阅《[指定你的应用所支持的场景](https://developer.apple.com/documentation/UIKit/specifying-the-scenes-your-app-supports)》；如需了解如何通过代码创建多窗口，请参阅《[在 iPad 上支持多窗口](https://developer.apple.com/documentation/UIKit/supporting-multiple-windows-on-ipad)》。

If your root view controller is loaded from the storyboard, ensure that the storyboard name is provided in the `UISceneConfigurations` key in the Info.plist scene manifest. The system automatically configures your window scene and its root view controller.

如果你的根视图控制器从故事板（Storyboard）加载，请确保在 Info.plist 场景配置清单的 `UISceneConfigurations` 键中指定故事板名称。系统会自动配置你的窗口场景及其根视图控制器。

If your window’s root view controller is loaded programmatically, use `scene(_:willConnectTo:options:)` to create a `UIWindow` and associate it with the specified scene object.

如果你的窗口根视图控制器通过代码加载，请使用 `scene(_:willConnectTo:options:)` 方法创建 `UIWindow` 并将其关联到指定的场景对象。

```
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Confirm the scene is a window scene in iOS or iPadOS.
        // 确认该场景是 iOS 或 iPadOS 中的窗口场景
        guard let windowScene = scene as? UIWindowScene else { return }
                
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = YourRootViewController()
        window?.makeKeyAndVisible()
    }
}
```

This example uses a `UIResponder` subclass conforming to the `UIWindowSceneDelegate` protocol called `SceneDelegate` to create the app’s primary window scene. For more information about how to prepare your app at launch time, see [Responding to the launch of your app](https://developer.apple.com/documentation/UIKit/responding-to-the-launch-of-your-app).

此示例使用一个遵循 `UIWindowSceneDelegate` 协议的 UIResponder 子类（名为 SceneDelegate）来创建应用的主窗口场景。如需了解如何在应用启动时完成初始化准备，请参阅《[响应应用的启动](https://developer.apple.com/documentation/UIKit/responding-to-the-launch-of-your-app)》。

# Migrate app life-cycle logic 迁移应用生命周期逻辑

Move your app’s existing life-cycle methods from `UIApplicationDelegate` to `UISceneDelegate`:

将应用现有的生命周期方法从 UIApplicationDelegate 迁移到 UISceneDelegate：

UIApplicationDelegate|UISceneDelegate
:-:|:-:
applicationDidBecomeActive(_:)|sceneDidBecomeActive(_:)
applicationWillResignActive(_:)|sceneWillResignActive(_:)
applicationDidEnterBackground(_:)|sceneDidEnterBackground(_:)
applicationWillEnterForeground(_:)|sceneWillEnterForeground(_:)

Migrating to a scene-based life-cycle modernizes your app and helps it to take full advantage of iOS multitasking features. After adopting scene-based life-cycle ensure to test your app in Split View, Slide Over, and Stage Manager on iPad.

迁移到基于场景的生命周期可使你的应用现代化，并帮助其充分利用 iOS 的多任务功能。采用基于场景的生命周期后，请务必在 iPad 上通过分屏视图（Split View）、侧拉视图（Slide Over）和台前调度（Stage Manager） 测试你的应用。

To learn how to respond to state transitions within your app, see [Managing your app’s life cycle](https://developer.apple.com/documentation/UIKit/managing-your-app-s-life-cycle).

如需了解如何在应用内响应状态切换，请参阅《[管理应用的生命周期](https://developer.apple.com/documentation/UIKit/managing-your-app-s-life-cycle)》。

# Revision History 修订历史

- 2025-06-23 Added information about the requirements in the major release following iOS 26.
- 2025-05-05 First published.

- 2025 年 06 月 23 日 添加关于 iOS 26 之后重大版本中相关要求的说明。
- 2025 年 05 月 05 日 首次发布。





