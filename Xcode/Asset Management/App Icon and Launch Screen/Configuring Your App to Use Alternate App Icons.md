# Configuring Your App to Use Alternate App Icons 
# 配置你的 app 以使用备用应用图标

原文地址：[https://developer.apple.com/documentation/xcode/asset_management/configuring_your_app_to_use_alternate_app_icons/](https://developer.apple.com/documentation/xcode/asset_management/configuring_your_app_to_use_alternate_app_icons/)

> Availability
> 
> iOS 15.0+ | iPadOS 15.0+ | Xcode 13.0+

Add alternate app icons to your app, and let people choose which icon to display.

向你的 app 添加备用应用图标，并让人们选择要显示哪一个。

【[Download](https://docs-assets.developer.apple.com/published/0f1e983cf9/ConfiguringYourAppToUseAlternateAppIcons.zip)】

# Overview - 概览

The sample code project demonstrates how to configure your app so that people can change the icon that appears on the Home screen, in Spotlight, and elsewhere in the system.

示例代码项目演示了如何配置应用程序，以便人们可以更改主屏幕、Spotlight 和系统中其他地方显示的图标。

People select an alternate icon in the app interface from a collection that you provide.

人们从你提供的集合中选择 app 界面上的备用图标。

# Add Icon Assets for the Alternate Icons - 为备用图标添加图标资源

For each alternate app icon, the project requires multiple image files that vary in size. The project organizes these files through icon assets under the asset catalog.

对于每个备用 app 图标，该项目需要多个大小不同的图像文件。项目通过资源目录下的图标资源来组织这些文件。

The system picks the correct icon image for the current context and target device from the set of options under each icon asset. This ensures that the appearance of the alternate icon remains consistent.

系统从每个图标资源下的一组图片选项中为当前上下文和目标设备选择正确的图标图像。这样可以确保备用图标的外观保持一致。

For information on configuring app icons in the asset catalog, see [Configuring Your App Icon](https://developer.apple.com/documentation/xcode/configuring-your-app-icon).

有关在资产目录中配置 app 图标的信息，请参阅《[配置应用程序图标](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)》。

For design guidance, see [Human Interface Guidelines > App Icon](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon).

有关设计指南，请参阅[《人机界面指南》>《应用程序图标》](https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/app-icon)

# Configure the Asset Catalog Compiler - 配置 Asset 目录编译器

The system gathers information about the app’s icons from the app’s information property list file under the top-level key [CFBundleIcons](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons). Xcode adds entries to this file for the icons the project specifies through build settings under `Asset Catalog Compiler` - `Options`.

系统从应用程序的信息属性列表文件的顶级键 [CFBundleIcons](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons) 下收集有关应用程序图标的信息。Xcode 将通过 `Asset Catalog Compiler` - `Options` 下的构建设置 指定的图标条目添加到此文件中。

For each icon asset that the project specifies by name in the build setting `Alternate App Icon Sets`, Xcode adds an entry under the key [CFBundleAlternateIcons](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons/cfbundlealternateicons).

在项目构建设置 `Alternate App Icon Sets` 中按名称指定的每个图标资源，Xcode 会对应每个资源在 [CFBundleAlternateIcons](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons/cfbundlealternateicons) 键下添加一个条目。

Xcode enters the name of the primary app icon asset specified in the build setting `Primary App Icon Set Name` under the key [CFBundlePrimaryIcon](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons/cfbundleprimaryicon). This setting is also available through the `App Icons and Launch Images` section of the `General` pane.

Xcode 在 [CFBundlePrimaryIcon](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons/cfbundleprimaryicon) 键下的 `Primary App Icon Set Name` 构建设置项中指定主 app 图标资源的名称。也可以通过  `General` 操作板的 `App Icons and Launch Images` 部分进行设置。

For more information on build settings, see [Build Settings Reference](https://developer.apple.com/documentation/xcode/build-settings-reference).

# Change the App’s Icon

When people select an alternate icon in the app interface, the app calls [setAlternateIconName(_:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/2806818-setalternateiconname) with the name of the new icon. This tells the system to display the new icon for this app. The system automatically displays an alert notifying people of the change. Passing `nil` displays the app’s primary icon.

当人们在 app 界面中选择一个备用图标时，应用程序会调用 [setAlternateIconName(_:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/2806818-setalternateiconname) 并传入新图标的名称。这会告诉系统显示此图标为应用程序的新图标。系统会自动显示一个弹窗，通知人们该更改。传入 `nil` 则显示应用程序的主图标。

```
UIApplication.shared.setAlternateIconName(iconName) { (error) in
    if let error = error {
        print("Failed request to update the app’s icon: \(error)")
    }
}
```

The current icon’s name is available through the property [alternateIconName](https://developer.apple.com/documentation/uikit/uiapplication/2806808-alternateiconname).

当前图标名称可以通过 [alternateIconName](https://developer.apple.com/documentation/uikit/uiapplication/2806808-alternateiconname) 属性获取到。

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
