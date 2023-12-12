# Supporting Dark Mode in Your Interface - 在界面中支持深色模式

原文链接：[https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface)

Update colors, images, and behaviors so that your app adapts automatically when Dark Mode is active.

更新颜色、图像和行为，以便您的应用在深色模式活跃时自动适应。

# Overview - 概述

In macOS and iOS, users can choose to adopt a system-wide light or dark appearance. The dark appearance, known as Dark Mode, implements an interface style that many apps already adopt. Users choose the aesthetic they prefer, and can also choose to toggle their interface based on ambient lighting conditions or a specific schedule.

在 macOS 和 iOS 中，用户可以选择采用系统范围的浅色或深色外观。深色外观（称为“深色模式”）实现了许多应用程序已经采用的界面风格。用户可以选择自己喜欢的审美，还可以选择根据环境照明条件或特定时间表切换界面。

![A system displaying a dark appearance in the Calendar app and in the documentation viewer of Xcode.](https://docs-assets.developer.apple.com/published/0e3a3e3521/3003257@2x.png)

All apps should support both light and dark interface styles, but might perform better with a specific appearance in some places. For example, you might always adopt a light appearance for printed content.

所有应用程序都应支持浅色和深色界面样式，但在某些地方使用特定外观可能会表现更好。例如，您可能始终对打印内容采用浅色外观。

Before you change your code, turn on Dark Mode and see how your app responds. The system does a lot of the work for you, and if your app uses standard views and controls, you might not need to make many changes. Standard views and controls automatically update their appearance to match the current interface style. If you already use color and image assets, you can add dark variants without changing your code.

在更改代码之前，请打开深色模式并查看您的应用程序如何响应。系统为您做了很多工作，如果您的应用程序使用标准视图和控件，您可能不需要进行很多更改。标准视图和控件会自动更新其外观以匹配当前的界面风格。如果您已经使用颜色和图像资源，则可以添加深色变体，而无需更改代码。

![An image of the General pane of the System Preferences app in macOS, which is where users enable Dark Mode.](https://docs-assets.developer.apple.com/published/d93130655c/3013532@2x.png)

## Choose Adaptive Colors for Your UI - 为您的 UI 选择自适应颜色

Choose colors that adapt automatically to the underlying interface style. Light and dark interfaces use very different color palettes. Colors that work well in a light appearance may be hard to see in a dark appearance, and vice versa. An adaptive color object returns different color values for different interface styles.

选择自动适应底层界面风格的颜色。浅色和深色界面使用非常不同的调色板。在浅色外观中效果良好的颜色在深色外观中可能很难看，反之亦然。自适应颜色对象针对不同的界面样式返回不同的颜色值。

There are two ways to create adaptive color objects:

有两种方法可以创建自适应颜色对象：

- Choose semantic colors instead of fixed color values. When configuring UI elements, choose colors with names like `labelColor`. These semantic colors convey the intended use of the color, rather than specific color values. When you use them for their intended purpose, they render with color values appropriate for the current settings. For a complete list of semantic color names, see [NSColor](https://developer.apple.com/documentation/appkit/nscolor) and [UIColor](https://developer.apple.com/documentation/uikit/uicolor).
- 选择语义颜色而不是固定颜色值。配置 UI 元素时，选择名称类似于 `标签颜色` 的颜色。这些语义颜色传达颜色的预期用途，而不是特定的颜色值。当您将它们用于预期目的时，它们会使用适合当前设置的颜色值进行渲染。有关语义颜色名称的完整列表，请参阅 [NSColor](https://developer.apple.com/documentation/appkit/nscolor) 和 [UIColor](https://developer.apple.com/documentation/uikit/uicolor)。

- Define custom colors in your asset catalog. When you need a specific color, create it as a color asset. In your asset, specify different color values for both light and dark appearances. You can also specify high-contrast versions of your colors.
- 在资产目录中定义自定义颜色。当您需要特定颜色时，将其创建为颜色资源。在您的资源中，为浅色和深色外观指定不同的颜色值。您还可以指定颜色的高对比度版本。

You configure custom color assets using Xcode’s asset editor. Add a `Color Set` asset to your project and configure the appearance variants you want to modify. Use the `Any Appearance` variant to specify the color value to use on older systems that do not support Dark Mode.

您可以使用 Xcode 的资源编辑器配置自定义颜色资源。将 `Color Set` 资源添加到您的项目并配置要修改的外观变体。使用 `Any Appearance` 变体指定要在不支持深色模式的旧系统上使用的颜色值。

![An image showing the appearance options for adding color slots for light and dark content.](https://docs-assets.developer.apple.com/published/37cfd16eda/3013533@2x.png)

To load a color value from an asset catalog, load the color by name:

要从资产目录加载颜色值，请按名称加载颜色：

```
// macOS
let aColor = NSColor(named: NSColor.Name("customControlColor"))


// iOS
let aColor = UIColor(named: "customControlColor")
```

When you create a color object from a color asset, you do not have to recreate that object when the current appearance changes. Each time you set the fill or stroke color for drawing, the color object loads the color variant that matches the current environment settings. The same is true for semantic colors such as `labelColor`, which adapt automatically to the current environment. By contrast, color objects you create using fixed component values do not adapt; you must create a new color object instead.

当您从颜色资源创建颜色对象时，当前外观更改时不必重新创建该对象。每次设置绘图的填充或描边颜色时，颜色对象都会加载与当前环境设置相匹配的颜色变体。对于诸如 `labelColor` 之类的语义颜色也是如此，它会自动适应当前环境。相比之下，使用固定组件值创建的颜色对象不会适应；您必须创建一个新的颜色对象。

> **Note** **注意**
>
> For the user's content, always preserve colors that the user explicitly chooses. For example, a painting app should not try to change colors that the user applies to their canvas. Use adaptable colors primarily in the views and controls for your app’s chrome.
> 
> 对于用户的内容，始终保留用户明确选择的颜色。例如，绘画应用程序不应尝试更改用户应用于画布的颜色。主要在应用程序的镶边的视图和控件中使用自适应颜色。

## Create Images for All Appearances - 为所有外观创建图像

Make sure the images in your interface look good in both light and dark appearances. Interfaces use images in many places, including in buttons, image views, and custom views and controls. If an image is difficult to see when changing appearances, provide a new image asset that looks good in the other appearance. Better yet, use a symbol image or template image, which define only the shape to render and therefore do not require separate images for light, dark, and high-contrast environments.

确保界面中的图像在浅色和深色外观下都看起来不错。界面在许多地方使用图像，包括按钮、图像视图以及自定义视图和控件。如果更改外观时图像难以看清，请提供在其他外观下看起来不错的新图像资源。更好的做法是，使用符号图像或模板图像，它们仅定义要渲染的形状，因此不需要针对亮、暗和高对比度环境的单独图像。

For information about configuring images for both light and dark interfaces, see [Providing images for different appearances](https://developer.apple.com/documentation/uikit/uiimage/providing_images_for_different_appearances).

有关为浅色和深色界面配置图像的信息，请参阅《[提供不同外观的图像](https://developer.apple.com/documentation/uikit/uiimage/providing_images_for_different_appearances)》。

## Update Custom Views Using Specific Methods - 使用特定方法更新自定义视图

When the user changes the system appearance, the system automatically asks each window and view to redraw itself. During this process, the system calls several well-known methods for both macOS and iOS, listed in the following table, to update your content. The system updates the trait environment before calling these methods, so if you make all of your appearance-sensitive changes in these methods, your app updates itself correctly.

当用户更改系统外观时，系统会自动要求每个窗口和视图重绘自身。在此过程中，系统会调用下表列出的几种适用于 macOS 和 iOS 的众所周知的方法来更新您的内容。系统在调用这些方法之前会更新特征环境，因此，如果您在这些方法中进行所有外观敏感的更改，您的应用程序会正确更新自身。


|Class|Appropriate methods|
|:-:|:-:|
|NSView|updateLayer()</br>draw(\_:)</br>layout()</br>updateConstraints()|
|UIView|traitCollectionDidChange(\_:)</br>layoutSubviews()</br>draw(\_:)</br>updateConstraints()</br>tintColorDidChange()|
|UIViewController|traitCollectionDidChange(\_:)</br>updateViewConstraints()</br>viewWillLayoutSubviews()</br>viewDidLayoutSubviews()|
|UIPresentationController|traitCollectionDidChange(\_:)</br>containerViewWillLayoutSubviews()</br>containerViewDidLayoutSubviews()|

If you make appearance-sensitive changes outside of these methods, your app may not draw its content correctly for the current environment. The solution is to move your code into these methods. For example, instead of setting the background color of an NSView object’s layer at creation time, move that code to your view’s `updateLayer()` method instead, as shown in the code example below. Setting the background color at creation time might seem appropriate, but because CGColor objects don’t adapt, setting it at creation time leaves the view with a fixed background color that never changes. Moving your code to `updateLayer()` refreshes that background color whenever the environment changes.

如果您在这些方法之外进行外观敏感的更改，您的应用程序可能无法针对当前环境正确绘制其内容。解决方案是将您的代码移至这些方法中。例如，不要在创建时设置 NSView 对象图层的背景颜色，而是将该代码移动到视图的 `updateLayer()` 方法中，如下面的代码示例所示。在创建时设置背景颜色似乎是合适的，但由于 CGColor 对象不会适配，因此在创建时设置背景颜色会使视图具有永远不会改变的固定背景颜色。移动代码到 `updateLayer()` 中以便每当环境发生变化时都会刷新背景颜色。

```
override func updateLayer() {
   self.layer?.backgroundColor = NSColor.textBackgroundColor.cgColor


   // Other updates.
}
```

If your app has code that’s not part of an NSView and can’t use the preferred methods listed above, it can observe the app’s [effectiveAppearance](https://developer.apple.com/documentation/appkit/nsapplication/2967171-effectiveappearance) property and update [current](https://developer.apple.com/documentation/appkit/nsappearance/1531945-current) manually.

如果您的应用程序包含不属于 NSView 的代码并且无法使用上面列出的首选方法，则它可以观察应用程序的 [effectiveAppearance](https://developer.apple.com/documentation/appkit/nsapplication/2967171-effectiveappearance) 属性并手动更新 [current](https://developer.apple.com/documentation/appkit/nsappearance/1531945-current)。

```
// Use a property to keep a reference to the key-value observation object.
// 使用属性可以保留对键值观测对象的引用。
var observation: NSKeyValueObservation?


func applicationDidFinishLaunching(_ aNotification: Notification) {
    observation = NSApp.observe(\.effectiveAppearance) { (app, _) in
        app.effectiveAppearance.performAsCurrentDrawingAppearance {
            // Invoke your non-view code that needs to be aware of the
            // change in appearance.
            // 调用需要注意外观变化的非视图代码。
        }
    }
}
```

## Choose Visual-Effect Materials Based on the Intended Usage - 根据用途选择视觉效果材料

Visual-effect views add transparency to your background views, which gives your UI more visual depth than if the backgrounds were opaque. To ensure that your content remains visible, visual-effect views blur the background content subtly and add vibrancy effects to adjust the colors of your foreground content automatically. The system updates these effects dynamically, ensuring that your app's content remains visible when the underlying content changes.

视觉效果视图为您的背景视图添加透明度，与背景不透明相比，这为您的 UI 提供了更多的视觉深度。为了确保您的内容保持可见，视觉效果视图会巧妙地模糊背景内容，并添加活力效果以自动调整前景内容的颜色。系统动态更新这些效果，确保当底层内容发生变化时应用程序的内容仍然可见。

Use visual-effect views in your interface as container views, and add subviews to them to represent your foreground content. Configure each visual-effect view with the material or effects that are appropriate for the appearance you want:

在界面中使用视觉效果视图作为容器视图，并向其中添加子视图以表示前景内容。使用适合您想要的外观的材质或效果配置每个视觉效果视图：

- In macOS, configure an [NSVisualEffectView](https://developer.apple.com/documentation/appkit/nsvisualeffectview) with the appropriate material based on how you use that view in your interface. For example, when using a visual-effect view as the background for a sidebar interface, configure it with the [NSVisualEffectView.Material.sidebar](https://developer.apple.com/documentation/appkit/nsvisualeffectview/material/sidebar) material.

- 在 macOS 中，根据您在界面中使用该视图的方式用适当的材质配置 [NSVisualEffectView](https://developer.apple.com/documentation/appkit/nsvisualeffectview)。例如，当使用视觉效果视图作为侧边栏界面的背景时，请为其配置 [NSVisualEffectView.Material.sidebar](https://developer.apple.com/documentation/appkit/nsvisualeffectview/material/sidebar) 材质。

- In iOS, configure a [UIVisualEffectView](https://developer.apple.com/documentation/uikit/uivisualeffectview) with specific vibrancy and blur effects to create the appearance you want. Blur effects define the apparent thickness of the background view, and vibrancy effects adjust the appearance for specific types of content to ensure that they remain visible. For example, when your view contains labels, choose the [UIVibrancyEffectStyle.label](https://developer.apple.com/documentation/uikit/uivibrancyeffectstyle/label) style or one of the other label-related vibrancy options.

- 在 iOS 中，使用特定的活力和模糊效果配置 [UIVisualEffectView](https://developer.apple.com/documentation/uikit/uivisualeffectview) 以创建您想要的外观。模糊效果定义背景视图的表观厚度，而活力效果则调整特定类型内容的外观，以确保它们保持可见。例如，当您的视图包含标签时，请选择 [UIVibrancyEffectStyle.label](https://developer.apple.com/documentation/uikit/uivibrancyeffectstyle/label) 样式或其他与标签相关的活力选项之一。

> **Important** **重要**
> 
> Do not use deprecated materials, such as [NSVisualEffectView.Material.light](https://developer.apple.com/documentation/appkit/nsvisualeffectview/material/light), in macOS 10.14 and later because those materials do not adapt to Dark Mode. Instead, choose newer materials that adapt correctly to the environment.
> 
> 不要在 macOS 10.14 及更高版本中使用已弃用的材质，例如 [NSVisualEffectView.Material.light](https://developer.apple.com/documentation/appkit/nsvisualeffectview/material/light)，因为这些材质不适应深色模式。相反，应选择能够正确适应环境的新型材料。

## Opt Out Only as Needed - 仅根据需要选择退出

Make every effort to adopt both light and dark appearances in your apps. If supporting one appearance makes no sense for all or part of your app, you can opt out of appearance changes in the appropriate windows or views. For example, you might always use a light appearance for your app's printing views.

尽一切努力在您的应用程序中采用浅色和深色外观。如果支持一种外观对您的应用程序的全部或部分没有意义，您可以选择在适当的窗口或视图中不进行外观更改。例如，您可能始终对应用程序的打印视图使用浅色外观。

You can configure all or part of your interface to opt out of a specific appearance. You can also adopt a specific appearance for your entire app. For more information, see the following:

您可以配置全部或部分界面以选择退出特定外观。您还可以为整个应用程序采用特定的外观。有关详细信息，请参阅以下内容：

- [Choosing a Specific Appearance for Your macOS App](https://developer.apple.com/documentation/appkit/nsappearancecustomization/choosing_a_specific_appearance_for_your_macos_app)

- [为您的 macOS 应用程序选择特定的外观](https://developer.apple.com/documentation/appkit/nsappearancecustomization/choosing_a_specific_appearance_for_your_macos_app)

- [Choosing a Specific Interface Style for Your iOS App](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface/choosing_a_specific_interface_style_for_your_ios_app)

- [为您的 iOS 应用程序选择特定的界面风格](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface/choosing_a_specific_interface_style_for_your_ios_app)

## Avoid Expensive Tasks During Appearance Transitions - 在外观转换期间避免昂贵的任务

When the user toggles between light and dark interfaces, the system asks your app to redraw all of its content. Although the system manages the drawing process, it relies on your custom code at several points during that process. Your code must be as quick as possible and not perform tasks unrelated to the appearance change. In macOS, AppKit usually creates transition animations during appearance changes, but it aborts those animations if your app takes too long to redraw itself.

当用户在浅色和深色界面之间切换时，系统会要求您的应用程序重绘其所有内容。尽管系统管理绘图过程，但它在该过程中的多个点依赖于您的自定义代码。您的代码必须尽可能快，并且不执行与外观更改无关的任务。在 macOS 中，AppKit 通常会在外观更改期间创建过渡动画，但如果您的应用需要很长时间才能重绘自身，它会中止这些动画。


# Topics - 主题

## Appearance Support - 外观支持

### [Choosing a Specific Appearance for Your macOS App](https://developer.apple.com/documentation/appkit/nsappearancecustomization/choosing_a_specific_appearance_for_your_macos_app) - 为您的 macOS 应用程序选择特定的外观

Adopt a specific appearance for your windows, views, or app when it is inappropriate to support both light and dark variants.

当不适合同时支持浅色和深色变体时，为您的窗口、视图或应用程序采用特定的外观。

### [Choosing a Specific Interface Style for Your iOS App](https://developer.apple.com/documentation/uikit/appearance_customization/supporting_dark_mode_in_your_interface/choosing_a_specific_interface_style_for_your_ios_app) - 为您的 iOS 应用程序选择特定的界面风格

Adopt a specific interface style for your views, view controllers, or app when it is inappropriate to support both light and dark variants.

当不适合同时支持浅色和深色变体时，为您的视图、视图控制器或应用程序采用特定的界面样式。

## Images - 图像

### [Providing images for different appearances](https://developer.apple.com/documentation/uikit/uiimage/providing_images_for_different_appearances) - 提供不同外观的图像

Supply image resources appropriate for light and dark appearances and for high-contrast environments.

提供适合明暗外观以及高对比度环境的图像资源。

### [Configuring and displaying symbol images in your UI](https://developer.apple.com/documentation/uikit/uiimage/configuring_and_displaying_symbol_images_in_your_ui) - 在 UI 中配置和显示符号图像

Create scalable images that integrate with your app’s text, and adjust the appearance of those images dynamically.

创建与应用程序文本集成的可扩展图像，并动态调整这些图像的外观。








