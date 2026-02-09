# Creating your app icon using Icon Composer
# 使用 Icon Composer 制作应用图标

原文地址：[https://developer.apple.com/documentation/xcode/creating-your-app-icon-using-icon-composer](https://developer.apple.com/documentation/xcode/creating-your-app-icon-using-icon-composer)

Use Icon Composer to stylize your app icon for different platforms and appearances.
使用 Icon Composer 为不同平台和外观制作你的应用图标。

# Overview - 概览

Use Icon Composer to create a single multilayer file that you can add to your Xcode project to represent your Liquid Glass app icon everywhere your app icon appears across iOS, iPadOS, macOS, watchOS, and the App Store. Use your favorite design tool to create the artwork for your app icon, but save some design decisions for Icon Composer, where you can refine the dynamic properties of Liquid Glass and customize variants of your app icon for different platforms and appearances.

使用 Icon Composer（图标编辑器）创建一个单层多层文件，将其添加到 Xcode 项目后，即可在 iOS、iPadOS、macOS、watchOS 以及 App Store 等所有显示应用图标的场景中，用它来呈现你的 Liquid Glass 应用图标。你可以使用自己喜欢的设计工具制作应用图标的素材，但将一些设计决策留给 Icon Composer，在该工具里，你能优化 Liquid Glass 的动态属性，并为不同平台和外观定制应用图标的变体。

![A screenshot of Icon Composer that shows a group selected in the sidebar, iOS, macOS platform and mono appearance selected in the canvas, and Liquid Glass settings in the Appearance inspector. The canvas shows the icon over a custom background image with 50% blur and translucency Liquid Glass settings.](./images/icon-composer-hero-overview@2x.png)

Before building your app, add the Icon Composer file to your Xcode project to include it in your app’s bundle. The system automatically renders your app icon for the different platforms, appearances, and sizes from your single Icon Composer file. If your app supports previous releases (in the `Minimum Deployments` settings in the target’s `General` pane) that don’t have the same icon and widget style appearances and Liquid Glass material, Xcode automatically generates app icon images at build time for those releases from the Icon Composer file.

在构建应用之前，将 Icon Composer 文件添加到 Xcode 项目中，以将其包含在应用的 bundle 中。系统会自动从你的单个 Icon Composer 文件为不同平台、外观和尺寸渲染应用图标。如果你的应用支持之前的版本（在目标的【通用】窗格中的【最低部署】设置中），这些版本的图标和小组件样式外观以及 Liquid Glass 材质都不相同，Xcode 会在构建时从 Icon Composer 文件为这些版本自动生成应用图标图像。

> **Important** **重要**
>
> If you add an Icon Composer file to your Xcode project, it replaces any existing icon asset catalog that you previously used to represent your app icon. Xcode automatically generates a similar-looking version of the Liquid Glass icon for previous releases. If you want your existing icon to appear in previous releases, continue to use asset catalogs to represent your app icon.
>
> 如果你将 Icon Composer 文件添加到 Xcode 项目中，它会替换你之前用于表示应用图标的任何现有图标资产目录。Xcode 会为之前的版本自动生成外观相似的 Liquid Glass 图标版本。如果你希望现有图标在之前的版本中显示，请继续使用资产目录来表示应用图标。

To learn more, see the following resources:

- For guidance on designing your app icon, see Human Interface Guidelines > Foundations > App icons.
- For converting older app icons to use the Liquid Glass material, see Adopting Liquid Glass > App icons.
- For more information on Liquid Glass and Icon Composer, watch Say hello to the new look of app icons and Create icons with Icon Composer.
- For tvOS and visionOS targets that still use an AppIcon asset catalog, see Configuring your app icon using an asset catalog.

To learn more, see the following resources:

- For guidance on designing your app icon, see [Human Interface Guidelines > Foundations > App icons](https://developer.apple.com/design/Human-Interface-Guidelines/app-icons).
- For converting older app icons to use the Liquid Glass material, see [Adopting Liquid Glass > App icons](https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass).
- For more information on Liquid Glass and Icon Composer, watch [Say hello to the new look of app icons](https://developer.apple.com/videos/play/wwdc2025/220/) and [Create icons with Icon Composer](https://developer.apple.com/videos/play/wwdc2025/361/).
- For tvOS and visionOS targets that still use an AppIcon asset catalog, see [Configuring your app icon using an asset catalog](https://developer.apple.com/documentation/xcode/configuring-your-app-icon).

要了解更多信息，请参阅以下资源：

- 有关设计应用图标的指导，请参阅[《人机界面指南》> 基础 > 应用图标](https://developer.apple.com/design/Human-Interface-Guidelines/app-icons)。
- 有关将旧的应用图标转换为使用 Liquid Glass 材质的说明，请参阅[《采用 Liquid Glass》> 应用图标](https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass)。
- 有关 Liquid Glass 和 Icon Composer 的更多信息，请观看《[跟应用图标的全新外观打个招呼](https://developer.apple.com/videos/play/wwdc2025/220/)》和《[用 Icon Composer 制作图标](https://developer.apple.com/videos/play/wwdc2025/361/)》。
- 对于仍使用 AppIcon 资产目录的 tvOS 和 visionOS 目标，请参阅《[使用资产目录配置应用图标](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)》。