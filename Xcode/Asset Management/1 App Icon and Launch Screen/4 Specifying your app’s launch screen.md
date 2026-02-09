# Specifying your app’s launch screen 
# 指定应用程序的启动屏幕

原文地址：[https://developer.apple.com/documentation/Xcode/specifying-your-apps-launch-screen](https://developer.apple.com/documentation/Xcode/specifying-your-apps-launch-screen)

Make your iOS app launch experience faster and more responsive by customizing a launch screen.

通过自定义启动屏幕，让你的 iOS 应用启动体验更快速、响应更灵敏。

# Overview - 概览

Every iOS app must provide a _launch screen_, a screen that displays while your app launches. The launch screen appears instantly when your app starts up and is quickly replaced with the app’s first screen.

每款 iOS 应用都必须提供 _启动屏幕_ ，这是应用启动过程中显示的界面。启动屏幕会在应用启动时立即出现，并很快被应用的首个界面替换。

You create a launch screen for your app in your Xcode project in one of two ways:

- Information property list
- User interface file

你可以在 Xcode 项目中通过以下两种方式之一为应用创建启动屏幕：

- 信息属性列表（Info.plist）
- 用户界面文件（Storyboard/XIB）

To make the app launch experience as seamless as possible, create a launch screen with basic views that closely resemble the first screen of your app.
For guidelines about designing a launch screen, see [Launching](https://developer.apple.com/design/human-interface-guidelines/patterns/launching/) in the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/guidelines/overview).

为了让应用启动体验尽可能流畅自然，请使用与应用首个界面高度相似的基础视图来设计启动屏幕。有关启动屏幕的设计规范，请参阅《[人机界面指南](https://developer.apple.com/design/human-interface-guidelines/guidelines/overview)》中的 “[启动](https://developer.apple.com/design/human-interface-guidelines/patterns/launching/)” 部分。

# Configure a launch screen in an information property list 在信息属性列表中配置启动屏幕

For apps with simple user interfaces, using the information property list in your app provides a quick and straightforward method to configure your launch screen.

对于用户界面简单的应用，在应用中使用信息属性列表是一种快速、直观的启动屏幕配置方式。

1. In the settings for your target, select the `Info` tab.
2. In the `Custom iOS Target Properties` section, expand the `Launch Screen` key.
3. Click the Add button (`+`), type in `UILaunchScreen`, and press `Return` to add the launch screen key to the property list. If the `UILaunchScreen` key is already present, you can skip this step.
4. Select the `UILaunchScreen` key, click the `Add` button (`+`), and add additional keys to specify configuration options for your launch screen.

![Screenshot of the information property list section named Launch Screen. The UILaunchScreen key is nested under Launch Screen. A new row is nested under UILaunchScreen to indicate where to add additional keys. 信息属性列表中名为 Launch Screen 区域的截图。UILaunchScreen 键嵌套在 Launch Screen 下方，UILaunchScreen 下方有一行新行，用于指示添加更多子键的位置。](images/specifying-your-apps-launch-screen-2@2x.png)

1. 在目标的设置中，选择 `Info`（信息）标签页。
2. 在 `Custom iOS Target Properties`（自定义 iOS 目标属性）区域，展开 `Launch Screen`（启动屏幕）键。
3. 点击添加按钮（`+`），输入 `UILaunchScreen`，然后按下 `Return`（回车键），将启动屏幕键添加到属性列表中。如果 `UILaunchScreen` 键已存在，可以跳过此步骤。
4. 选中 `UILaunchScreen` 键，点击添加按钮（`+`），添加更多子键以指定启动屏幕的配置选项。

Define the appearance of the launch screen by specifying a combination of launch screen options from the possible keys in [UILaunchScreen](https://developer.apple.com/documentation/BundleResources/Information-Property-List/UILaunchScreen).

通过从 [UILaunchScreen](https://developer.apple.com/documentation/BundleResources/Information-Property-List/UILaunchScreen) 支持的键中指定启动屏幕的选项组合，来定义启动屏幕的外观。

# Configure a launch screen storyboard 配置启动屏幕故事板

Alternatively, you can configure your launch screen in a user interface file, a file with a `.storyboard` file extension. A launch screen storyboard contains basic UIKit views, and uses size classes and Auto Layout constraints to support different device sizes and resolutions.

另外，你也可以在用户界面文件（扩展名为 `.storyboard` 的文件）中配置启动屏幕。启动屏幕故事板包含基础的 UIKit 视图，并使用 Size Classes 和自动布局约束（Auto Layout constraints）来适配不同的设备尺寸与分辨率。

Follow these guidelines when creating a launch screen storyboard:

- Use only UIKit classes.
- Use a single root view that’s a UIView or UIViewController object.
- Don’t make any connections to your code, for example, don’t add actions or outlets.
- Don’t use deprecated views such as UIWebView.
- Don’t use any custom classes.
- Don’t use runtime attributes.

创建启动屏幕故事板时，请遵循以下规范：

- 仅使用 UIKit 类。
- 使用单个根视图，该视图为 `UIView` 或 `UIViewController` 对象。
- 不要与代码建立任何关联，例如，不要添加动作（action）或输出口（outlet）。
- 不要使用已废弃的视图，例如 `UIWebView`。
- 不要使用任何自定义类。
- 不要使用运行时属性。

If you create your iOS app from a storyboard template, Xcode adds a default launch screen file, called `LaunchScreen.storyboard`, to your project. Edit `LaunchScreen.storyboard` to configure your launch screen.

如果你从故事板模板创建 iOS 应用，Xcode 会自动在项目中添加一个默认的启动屏幕文件，名为 `LaunchScreen.storyboard`
。编辑该文件即可配置你的启动屏幕。

If your project doesn’t contain a default launch screen file, add a launch screen file and set the launch screen file for the target in the project editor.

如果项目中没有默认的启动屏幕文件，请添加启动屏幕文件，并在项目编辑器中为 target 设置该启动屏幕文件。

1. Choose `File` > `New` > `File from Template`.
2. Under `User Interface`, select `Launch Screen`, and click `Next`.
3. Give the launch screen file a name, choose a location, select the target that you want to add the file to, and click `Create`.
4. In the settings for your target, select the `General` tab and find the “`App Icons and Launch Screen`” section.
5. From the `Launch Screen File` pop-up menu, choose the new launch screen file.

![Screenshot of target settings with the General tab selected. The App Icons and Launch Screen section shows a field with the name Launch Screen File that lists the name of the launch screen storyboard file to use. 选中 General 标签页的目标设置截图：App Icons and Launch Screen 区域中显示 Launch Screen File 字段，该字段列出了要使用的启动屏幕故事板文件名称。](images/specifying-your-apps-launch-screen-3@2x.png)

1. 选择菜单栏 `File` > `New` > `File from Template`（从模板创建文件）。
2. 在 `User Interface`（用户界面）分类下，选择 `Launch Screen`（启动屏幕），然后点击 `Next`（下一步）。
3. 为启动屏幕文件命名，选择存放位置，勾选需要添加到的 target，然后点击 `Create`（创建）。
4. 在目标的设置中，选择 `General`（通用）标签页，找到 `App Icons and Launch Screen`（应用图标与启动屏幕）区域。
5. 在 `Launch Screen File`（启动屏幕文件）下拉菜单中，选择新建的启动屏幕文件。

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
