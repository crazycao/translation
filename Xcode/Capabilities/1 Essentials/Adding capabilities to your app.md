# Adding capabilities to your app 为你的应用添加能力

原文地址：[https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app](https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app)

Configure your target to include and customize capabilities that provide access to Apple’s app services.

配置目标，使其包含并自定义用于访问 Apple 应用服务的能力。

## 1. Overview - 概览

A _capability_ grants your app access to an _app service_ that Apple provides, such as CloudKit, Game Center, or In-App Purchase. To use some app services, you need to add a capability to your target in Xcode to configure the app service correctly. Xcode may edit the [Entitlements](https://developer.apple.com/documentation/bundleresources/entitlements) and Information Property List files, add related frameworks, and configure your signing assets.

能力（capability）让应用可以访问 Apple 提供的应用服务（app service），例如 CloudKit、Game Center 或应用内购买（In-App Purchase）。要使用某些应用服务，需要在 Xcode 中为目标添加一项能力，才能正确配置该服务。Xcode 可能会编辑[Entitlements（授权）](https://developer.apple.com/documentation/bundleresources/entitlements)文件和[Information Property List（信息属性列表）](https://developer.apple.com/documentation/bundleresources/information-property-list)文件、添加相关框架，并配置签名资产。

Some app services — such as Game Center and In-App Purchase — require additional configuration in App Store Connect and your developer account. For example, to provide directions for other apps using the Maps cabability, you [upload a geographic coverage file](https://developer.apple.com/help/app-store-connect/manage-submissions-to-app-review/upload-a-geographic-coverage-file/) in App Store Connect.

部分应用服务——例如 Game Center 和应用内购买——还需要在 App Store Connect 和开发者账户中做额外配置。例如，若要借助地图（Maps）能力为其他应用提供路线，需要在 App Store Connect 中[上传地理覆盖文件](https://developer.apple.com/help/app-store-connect/manage-submissions-to-app-review/upload-a-geographic-coverage-file/)。

The platform, and whether you’re a member of the Apple Developer Program, may limit the capabilities available to your app. For the supported capabilities, go to the Reference section of [Developer Account Help](https://developer.apple.com/help/account/) — for example, go to [Supported capabilities (iOS)](https://developer.apple.com/help/account/reference/supported-capabilities-ios) for the capabilities available to iOS apps.

目标平台，以及你是否为 Apple Developer Program（Apple 开发者计划）成员，都可能限制应用可用的能力。要查看支持的能力，请前往《[开发者账户帮助](https://developer.apple.com/help/account/)》的 Reference（参考）部分。例如，iOS 应用可用的能力见 《[Supported capabilities (iOS)（iOS 支持的能力）](https://developer.apple.com/help/account/reference/supported-capabilities-ios)》。

Before you begin, add your Apple Account to settings and assign the project to a team in the project editor so that Xcode can create a provisioning profile for your app. For iOS, iPadOS, tvOS, visionOS, and watchOS apps, run your app on a device to register the device and create a development provisioning profile. For more information, see [Running your app on simulated or physical devices](https://developer.apple.com/documentation/xcode/running-your-app-on-simulated-or-physical-devices).

开始之前，请在设置中添加你的 Apple 账户，并在项目编辑器中把项目分配给某个团队，以便 Xcode 为应用创建描述文件。对于 iOS、iPadOS、tvOS、visionOS 和 watchOS 应用，请在设备上运行应用，以注册该设备并创建开发描述文件。更多信息，请参阅《[在模拟器或真机上运行你的应用](https://developer.apple.com/documentation/xcode/running-your-app-on-simulated-or-physical-devices)》。

> **Important**
>
> Use the default automatic signing when you create a project from a template. If you manually sign your app, you need to perform the capability configuration steps yourself.

> **重要**
>
> 从模板创建项目时，请使用默认的自动签名。如果手动为应用签名，则需要自行完成能力的配置步骤。

## 2. Add a capability - 添加一项能力

You add capabilities to your app using the Signing & Capabilities pane of the project editor.

在项目编辑器的 Signing & Capabilities（签名与能力）面板中为应用添加能力。

In the Project navigator, select the project — the root group with the same name as your app — and in the project editor that appears on the right, select the appropriate target in the sidebar and then click the Signing & Capabilities tab.

在项目导航器中，选择项目——即与应用同名的根分组——然后在右侧出现的项目编辑器中，于边栏选择相应目标，再点按 Signing & Capabilities 标签页。

![A screenshot of Xcode showing the project editor with the Signing & Capabilities tab open. The project is selected in the Project navigator, a target is selected in the project editor sidebar, and the Signing & Capabilities tab is selected in the toolbar showing a Location capability added below.
一张 Xcode 截图，显示已打开 Signing & Capabilities 标签页的项目编辑器。项目导航器中选中了项目，项目编辑器边栏中选中了一个目标，工具栏中选中了 Signing & Capabilities 标签页，下方已添加 Location（定位）能力。](https://developer.apple.com/tutorials/images/com.apple.Xcode/signing-capabilities@2x.png)

Optionally, select a build configuration (All, Debug, or Release). For example, if you want to add the capability to the Debug configuration only, select Debug; otherwise, select All.

可以选择一个构建配置（All、Debug 或 Release）。例如，如果只想把该能力加到 Debug 配置，就选择 Debug；否则选择 All。

In the Signing & Capabilities toolbar, click the Capability button (+) to open the Capabilities library (or choose Editor > Add Capability). The Capabilities library displays only the capabilities available to the target platform and your program membership. Select a capability in the list to view its description on the right. Use the filter field in the toolbar to find a capability quickly.

在 Signing & Capabilities 工具栏中，点按 Capability（能力）按钮（+）打开能力库（也可以选择 Editor > Add Capability）。能力库只显示目标平台和你的计划成员资格所支持的能力。在列表中选择一项能力，即可在右侧查看其说明。使用工具栏中的过滤栏可以快速找到某项能力。

![A screenshot of the Capabilities library with the Apple Pay capability selected in the sidebar on the left and information about Apple Pay displayed in the detail area on the right.
一张能力库的截图：左侧边栏中选中了 Apple Pay 能力，右侧详情区域显示 Apple Pay 的相关信息。](https://developer.apple.com/tutorials/images/com.apple.Xcode/capabilities-library@2x.png)

To add a capability to the target, double-click the capability in the sidebar or drag the capability from the library to the Signing & Capabilities pane. The capability appears below the Signing section. If there are more configuration steps, the capability expands to show additional controls (see Perform additional configuration steps below). To remove a capability, click the trash icon in the upper-right corner of the capability in the Signing & Capabilities pane.

要将能力添加到目标，请在边栏中双击该能力，或将其从能力库拖到 Signing & Capabilities 面板。该能力会出现在 Signing（签名）部分下方。如果还有更多配置步骤，能力区域会展开并显示额外控件（见下方“执行额外的配置步骤”）。要移除一项能力，请点按 Signing & Capabilities 面板中该能力右上角的废纸篓图标。

![A screenshot of Xcode showing the project editor with the Signing & Capabilities tab open and additional configuration options for the Associated Domains capability below.
一张 Xcode 截图，显示已打开 Signing & Capabilities 标签页的项目编辑器，下方是 Associated Domains（关联域名）能力的额外配置选项。](https://developer.apple.com/tutorials/images/com.apple.Xcode/additional-configuration@2x.png)

If errors appear in the Signing section, read the message and correct the problem. For example, the bundle ID (CFBundleIdentifier) that appears in the Bundle Identifier field under Signing needs to be unique. The default value for the bundle ID is the organization identifier concatenated with the app name that you enter when creating a project.

如果 Signing 部分出现错误，请阅读提示并修正问题。例如，Signing 下方 Bundle Identifier（套装标识符）栏中显示的套装 ID（CFBundleIdentifier）必须唯一。套装 ID 的默认值，是创建项目时输入的组织标识符与应用名称拼接而成。

## 3. Perform additional configuration steps - 执行额外的配置步骤

For some capabilities, you may need to perform additional configuration steps in Xcode, your developer account, or App Store Connect. For other capabilities, you may need to write some code.

对于某些能力，你可能还需要在 Xcode、开发者账户或 App Store Connect 中完成额外的配置步骤。对于另一些能力，你可能需要编写一些代码。

For more guidance on specific capabilities, see the table below:

有关各项能力的更多说明，请参见下表：

| Capability | Additional information |
| --- | --- |
| App Groups | [Configuring app groups](https://developer.apple.com/documentation/xcode/configuring-app-groups) |
| App Sandbox | [Configuring the macOS App Sandbox](https://developer.apple.com/documentation/xcode/configuring-the-macos-app-sandbox) |
| Apple Pay | [Configuring Apple Pay support](https://developer.apple.com/documentation/xcode/configuring-apple-pay-support) |
| Associated Domains | [Configuring an associated domain](https://developer.apple.com/documentation/xcode/configuring-an-associated-domain) |
| Background Modes | [Configuring background execution modes](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes) |
| ClassKit | [Enabling ClassKit in your app](https://developer.apple.com/documentation/classkit/enabling-classkit-in-your-app) |
| Family Controls | [Configuring Family Controls](https://developer.apple.com/documentation/xcode/configuring-family-controls) |
| Fonts | [Configuring custom fonts](https://developer.apple.com/documentation/xcode/configuring-custom-fonts) |
| Game Controllers | [Configuring game controllers](https://developer.apple.com/documentation/xcode/configuring-game-controllers) |
| Group Activities | [Configuring Group Activities](https://developer.apple.com/documentation/xcode/configuring-group-activities) |
| Hardened Runtime | [Configuring the hardened runtime](https://developer.apple.com/documentation/xcode/configuring-the-hardened-runtime) |
| HealthKit | [Configuring HealthKit access](https://developer.apple.com/documentation/xcode/configuring-healthkit-access) |
| HomeKit | [Configuring HomeKit access](https://developer.apple.com/documentation/xcode/configuring-homekit-access) |
| iCloud | [Configuring iCloud services](https://developer.apple.com/documentation/xcode/configuring-icloud-services) |
| In-App Purchase | [Configuring in-app purchases](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/overview-for-configuring-in-app-purchases) |
| Keychain Sharing | [Configuring keychain sharing](https://developer.apple.com/documentation/xcode/configuring-keychain-sharing) |
| Maps | [Configuring Maps support](https://developer.apple.com/documentation/xcode/configuring-maps-support) |
| Media Device Discovery | [Configuring media device discovery](https://developer.apple.com/documentation/xcode/configuring-media-device-discovery) |
| Network Extensions | [Configuring network extensions](https://developer.apple.com/documentation/xcode/configuring-network-extensions) |
| On-Demand Install Capable | [Creating an App Clip with Xcode](https://developer.apple.com/documentation/appclip/creating-an-app-clip-with-xcode) |
| Push Notifications | [Registering your app with APNs](https://developer.apple.com/documentation/usernotifications/registering-your-app-with-apns) |
| Sign in with Apple | [Configuring Sign in with Apple support](https://developer.apple.com/documentation/xcode/configuring-sign-in-with-apple) |
| Siri | [Configuring Siri support](https://developer.apple.com/documentation/xcode/configuring-siri-support) |
| Wallet | [Configuring Wallet support](https://developer.apple.com/documentation/xcode/configuring-wallet-support) |

| 能力 | 其他信息 |
| --- | --- |
| App Groups（应用组） | [配置应用组](https://developer.apple.com/documentation/xcode/configuring-app-groups) |
| App Sandbox（App 沙盒） | [配置 macOS App 沙盒](https://developer.apple.com/documentation/xcode/configuring-the-macos-app-sandbox) |
| Apple Pay | [配置 Apple Pay 支持](https://developer.apple.com/documentation/xcode/configuring-apple-pay-support) |
| Associated Domains（关联域名） | [配置关联域名](https://developer.apple.com/documentation/xcode/configuring-an-associated-domain) |
| Background Modes（后台模式） | [配置后台执行模式](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes) |
| ClassKit | [在你的应用中启用 ClassKit](https://developer.apple.com/documentation/classkit/enabling-classkit-in-your-app) |
| Family Controls（家人控制） | [配置家人控制](https://developer.apple.com/documentation/xcode/configuring-family-controls) |
| Fonts（字体） | [配置自定义字体](https://developer.apple.com/documentation/xcode/configuring-custom-fonts) |
| Game Controllers（游戏控制器） | [配置游戏控制器](https://developer.apple.com/documentation/xcode/configuring-game-controllers) |
| Group Activities（群组活动） | [配置群组活动](https://developer.apple.com/documentation/xcode/configuring-group-activities) |
| Hardened Runtime（强化运行时） | [配置强化运行时](https://developer.apple.com/documentation/xcode/configuring-the-hardened-runtime) |
| HealthKit | [配置 HealthKit 访问权限](https://developer.apple.com/documentation/xcode/configuring-healthkit-access) |
| HomeKit | [配置 HomeKit 访问权限](https://developer.apple.com/documentation/xcode/configuring-homekit-access) |
| iCloud | [配置 iCloud 服务](https://developer.apple.com/documentation/xcode/configuring-icloud-services) |
| In-App Purchase（应用内购买） | [配置应用内购买](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/overview-for-configuring-in-app-purchases) |
| Keychain Sharing（钥匙串共享） | [配置钥匙串共享](https://developer.apple.com/documentation/xcode/configuring-keychain-sharing) |
| Maps（地图） | [配置地图支持](https://developer.apple.com/documentation/xcode/configuring-maps-support) |
| Media Device Discovery（媒体设备发现） | [配置媒体设备发现](https://developer.apple.com/documentation/xcode/configuring-media-device-discovery) |
| Network Extensions（网络扩展） | [配置网络扩展](https://developer.apple.com/documentation/xcode/configuring-network-extensions) |
| On-Demand Install Capable（支持按需安装） | [使用 Xcode 创建轻 App（App Clip）](https://developer.apple.com/documentation/appclip/creating-an-app-clip-with-xcode) |
| Push Notifications（推送通知） | [向 APNs 注册你的应用](https://developer.apple.com/documentation/usernotifications/registering-your-app-with-apns) |
| Sign in with Apple（通过 Apple 登录） | [配置“通过 Apple 登录”支持](https://developer.apple.com/documentation/xcode/configuring-sign-in-with-apple) |
| Siri | [配置 Siri 支持](https://developer.apple.com/documentation/xcode/configuring-siri-support) |
| Wallet（钱包） | [配置钱包支持](https://developer.apple.com/documentation/xcode/configuring-wallet-support) |
