# Configuring your app icon
# 配置你的应用图标

原文地址：[https://developer.apple.com/documentation/xcode/configuring-your-app-icon](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)

> Availability
> 
> iOS 15.0+ | iPadOS 15.0+ | Xcode 13.0+

Add variations of your app icon to represent your app in places such as Settings, search results, and the App Store.

添加应用图标的变体，用于在设置、搜索结果和应用商店等位置显示。

# Overview - 概览

Every app has a distinct app icon that communicates the app’s purpose and makes the app easy to recognize throughout the system. Apps require multiple variations of the app icon to look great in different contexts. Configure your app icon variations by using an app icon set in your project’s asset catalog.

每个应用程序都有一个独特的应用程序图标，用于传达应用程序的目的，并使得应用程序易于在整个系统中被识别。应用程序需要应用程序图标的多种变体，才能在不同的上下文中看起来很棒。通过使用项目的资产目录中的应用程序图标集合配置应用程序图标变体。

## Create an app icon set - 创建应用图标 set

When you create your project from a template, it automatically includes a default asset catalog (`Assets.xcassets`) that contains the `AppIcon` set.

当您从模板创建项目时，它会自动包含一个默认的资产目录（`Assets.xcassets`），其中包含 `AppIcon` 集合。

If you don’t have a default asset catalog or existing `AppIcon` set or you want to provide an alternate, you can add an app icon set to an asset catalog manually.

如果你没有默认的资产目录或现有的 `AppIcon` 集合，或者您想提供备用的，可以手动将应用程序图标集合添加到资产目录中。

1. In the `Project` navigator, select an asset catalog.
2. Click the `Add` button (`+`) at the bottom of the outline view.
3. In the pop-up menu, choose a platform, and select `[OS] App Icon`. Xcode creates a new app icon set with the name `AppIcon`.

>

1. 在“项目”导航器中，选择一个资产目录。
2. 单击轮廓视图底部的“添加”按钮（`+`）。
3. 在弹出菜单中，选择一个平台，然后选择 `[OS] App Ion`。Xcode 会创建一个名为 `AppIcon` 的新应用程序图标集合。

## Specify app icon variations - 指定应用程序图标变体

Variations of your app icon appear throughout the system in places like the Home screen, Settings, and search results. Specify these variations in the `AppIcon` set.

应用程序图标的变体会出现在整个系统的主屏幕、设置和搜索结果等位置。在 `AppIcon` 集合中指定这些变体。

1. In the `Project` navigator, select the asset catalog with the `AppIcon` set.
2. In the Finder, drag variations of the app icon to the wells in the detail area that match their resolutions and use cases.

>

1. 在“项目”导航器中，选择具有 `AppIcon` 集合的资产目录。
2. 在 `Finder` 中，将应用程序图标的变体拖动到详情区域中与其分辨率和使用场景相匹配的格子里。

![Screenshot of an asset catalog in Xcode. In the outline view, an app icon set with the name AppIcon is selected. The detail area shows multiple wells with labels that describe the required image dimensions, resolutions, and usages.](https://docs-assets.developer.apple.com/published/2b825183171bb4709e9902b378918ee3/configuring-your-app-icon-1@2x.png)

For tvOS apps, the asset catalog contains an `App Icon & Top Shelf Image` folder with the different app icon and launch image sets.

对于 tvOS 应用程序，资产目录包含一个 `App Icon & Top Shelf Image` 文件夹，其中包含不同的应用程序图标集合和启动图像集合。

For watchOS apps, the project contains separate asset catalogs that contain an AppIcon set for the iOS app and the WatchKit app targets.

对于 watchOS 应用程序，该项目包含单独的资产目录，其中包含 iOS 应用程序和 WatchKit 应用程序目标的 `AppIcon` 集合。

For the app icon metrics, see the following pages in the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines):

有关应用程序图标的标准，参见《[人机交互指南](https://developer.apple.com/design/human-interface-guidelines)》中的以下页面：

- [iOS App Icon](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon)
- [macOS App Icon](https://developer.apple.com/design/human-interface-guidelines/macos/icons-and-images/app-icon)
- [tvOS App Icon](https://developer.apple.com/design/human-interface-guidelines/tvos/icons-and-images/app-icon)
- [watchOS App Icon](https://developer.apple.com/design/human-interface-guidelines/watchos/visual/app-icon)

## Specify an App Store icon - 指定应用商店图标

If you distribute your app through the App Store, you must provide a specific version of your app icon to represent your app on the App Store. In the `Project` navigator, select the asset catalog and add the App Store icon to the App Store well in the app icon set. The location of the icon is different depending on the platform.

如果您通过应用商店分发应用程序，则必须提供应用程序图标的特定版本，以便在应用商店中代表您的应用程序。在“项目”导航器中，选择资产目录，并将 App Store 图标添加到应用程序图标集合中的 App Store 空格中。图标的位置因平台而异。

|Platform|App Store icon location|
|:-:|:-:|
|iOS|Drag an icon to the “App Store iOS” well. </br>拖动图标到 `App Store iOS` 空格中。|
|iMessage|For the iOS target, drag an icon to the “App Store iOS” well in the AppIcon set. For the MessagesExtension target, drag an icon to the “Messages App Store” well in the iMessage App Icon set. </br>对于 iOS 目标，将图标拖动到 AppIcon 集合中的 `App Store iOS` 中。对于 MessagesExtension 目标，将图标拖动到 iMessage App icon 集合中的 `Messages App Store` 中。|
|Sticker Pack|Drag an icon to the “App Store iOS” well and the “Messages App Store” well. </br>将图标拖到 `App Store iOS` 空格和 `Messages App Store` 空格中。|
|macOS|Drag an icon to the “App Store - 2x” well. </br>将图标拖动到 `App Store - 2x` 空格中。|
|tvOS|Drag the front, middle, and back icons to the “App Icon - App Store” set in the `App Icon & Top Shelf Image` folder. </br>将前面、中间和后面的图标拖动到 `App Icon&Top Shelf Image` 文件夹中 `App Icon-App Store` 合集中。|
|watchOS|For the iOS target, drag an icon to the “App Store iOS” well. For the WatchKit App target, drag an icon to the “Apple Watch App Store” well. </br>对于 iOS 目标，将图标拖动到 `App Store iOS` 空格中。对于 WatchKit 应用程序目标，将图标拖动到 `Apple Watch App Store` 空格中。|

## Change the default app icon set - 更改默认应用程序图标集

If you don’t create your project from a template, or you want to change your default app icon set, specify which app icon set to use in your target’s build settings.

如果您不是从模板创建项目，或者您想更改默认应用程序图标集，请指定要在目标的构建设置中使用的应用程序图标集合。

1. In the Project navigator, select the project and in the project editor, select the target.
2. In the “App Icons and Launch Images” section of the General pane, choose the app icon set from the App Icons Source pop-up menu.

>

1. 在“项目”导航器中选择项目，然后在项目编辑器中选择目标。
2. 在“通用”窗格的 `App Icons and Launch Images` 部分，从 `App Icons Source` 弹出菜单中选择应用程序图标集合。

![Screenshot of target settings with the General tab selected. The App Icons and Launch Images section shows a field with the name App Icons Source that lists the name of the app icon set to use from the asset catalog.](https://docs-assets.developer.apple.com/published/39e1c1a2560bb05b63f934daa21f76c3/configuring-your-app-icon-2@2x.png)

If you don’t select the “Include all app icon assets” option, Xcode only includes the app icon set you specify in the App Icons Source pop-up menu when it builds your app. You might leave this option unselected if you want to use a different icon for the Debug and Release builds of your app without including the Debug icon in your Release app bundle. You can specialize the app icon for the Debug and Release configurations by modifying the “Primary App Icon Set Name” build setting in the Build Settings tab.

如果您没有选择 `Include all app icon assets` 选项，Xcode 在构建应用程序时只包括您在 `App Icons Source` 弹出菜单中指定的应用程序图标集合。如果要为应用程序的调试和发布版本使用不同的图标，而不在发布应用程序捆绑包中包含调试图标，则可以不选中此选项。您可以通过修改 `Build Settings` 选项卡中的 `Primary App Icon Set Name` 构建设置，将应用程序图标专门用于“调试”和“发布”配置。

Xcode also includes any additional app icon sets you specify under the “Alternate App Icon Sets” build setting. Include any icon sets your app can select using [setAlternateIconName(_:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/2806818-setalternateiconname) or use in App Store product pages.

Xcode 还会包含您在 `Alternate App Icon Sets` 构建设置下指定的任何其他应用图标集合。包含应用程序可以用 [setAlternateIconName(_:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/2806818-setalternateiconname) 方法选择的或在应用商店产品页面中使用的任何图标集。

For information on configuring tests that use icons in App Store Connect, see [Product Page Optimization](https://developer.apple.com/app-store/product-page-optimization).

有关在 App Store Connect 中配置使用图标的测试的信息，请参阅《[产品页面优化](https://developer.apple.com/app-store/product-page-optimization)》。

# See Also - 其他参考

## App Icon and Launch Screen - App 图标和启动屏幕

### [Configuring Your App Icon](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)

Add variations of your app icon to represent your app in places such as Settings, search results, and the App Store.

添加应用图标的变体，用于在设置、搜索结果和应用商店等位置显示。

### [Configuring Your App to Use Alternate App Icons]((https://developer.apple.com/documentation/xcode/asset_management/configuring_your_app_to_use_alternate_app_icons/))

Add alternate app icons to your app, and let people choose which icon to display.

向你的 app 添加备用应用图标，并让人们选择要显示哪一个。

### [Specifying Your App’s Launch Screen](https://developer.apple.com/documentation/xcode/specifying-your-apps-launch-screen)

Make your iOS app launch experience faster and more responsive by customizing a launch screen.

通过定制启动屏幕，让您的iOS应用程序启动体验更快、响应更快。
