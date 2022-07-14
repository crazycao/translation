# Getting Started

链接地址：[https://dash.applovin.com/documentation/mediation/max/get-started-with-max](https://dash.applovin.com/documentation/mediation/max/get-started-with-max)

This guide shows you how to start monetizing your mobile app with MAX in seven easy steps, incorporating best practices to help you automate daily tasks and maximize revenue.

本指南向您展示了如何通过七个简单的步骤开始用MAX赚钱，并结合最佳实践来帮助您自动化日常任务并最大限度地增加收入。

## Step 1. Create an Account - 第一步：创建账户

To get started with MAX, open [dash.applovin.com](https://dash.applovin.com/), click **Sign Up for a New Account**, and enter your account information. MAX then asks you to authenticate your account so you can complete the signup process.

要开始学习 MAX，请 [dash.applovin.com](https://dash.applovin.com/)，单击**Sign Up for a New Account**，然后输入您的帐户信息。然后，MAX要求您验证您的帐户，以便您可以完成注册过程。

Some accounts may need to be approved by AppLovin to complete the account setup. If your account requires approval, review [the account approval process](https://support.applovin.com/hc/en-us/articles/4403932494989-What-is-the-Account-Approval-Process-).

某些帐户可能需要获得 AppLovin 的批准才能完成帐户设置。如果您的帐户需要批准，请查看[帐户批准流程](https://support.applovin.com/hc/en-us/articles/4403932494989-What-is-the-Account-Approval-Process-)。

If you encounter issues with setting up your account, visit the [New Account FAQ](https://support.applovin.com/hc/en-us/sections/4403763509261-New-Accounts-).

如果您在设置帐户时遇到问题，请访问[新帐户常见问题解答](https://support.applovin.com/hc/en-us/sections/4403763509261-New-Accounts-)。

### Setting Up Payment Information - 设置付款信息
AppLovin pays you directly for impressions served from the AppLovin Exchange or AppLovin Bidding (AppDiscovery). Set up your [payment information](https://dash.applovin.com/o/billing/accounts/) in the **Account** section in the left nav under **Payments > Info**.

AppLovin 直接向您支付 AppLovin Exchange 或 AppLovin Bidding（AppDiscovery）提供的印象费用。在左侧导航的**Payments > Info**下的**Account**部分中设置[付款信息](https://dash.applovin.com/o/billing/accounts/) 。

If you have questions about setting up payment or tax forms, please review the [AppLovin Monetization Payment FAQ](https://support.applovin.com/hc/en-us/articles/4403801592461-FAQ-AppLovin-Monetization-Payment).

如果您对设置付款或税务表格有疑问，请查看 [AppLovin 货币化付款常见问题解答](https://support.applovin.com/hc/en-us/articles/4403801592461-FAQ-AppLovin-Monetization-Payment)。

## Step 2: Create an Ad Unit - 第二步：创建广告单元

To create an ad unit, navigate to **MAX** in the left-hand nav and click [Ad Units](https://dash.applovin.com/o/mediation/ad_units/580541) under **Mediation > Manage**.

要创建广告单元，请导航到左侧导航栏中的 **MAX**，然后单击 **Mediation > Manage** 下的 **[Ad Units](https://dash.applovin.com/o/mediation/ad_units/580541)**。

### Add Your App - 添加 App

To add your app, first choose the platform (Android, FireOS, or iOS).

要添加应用程序，首先选择平台（Android、FireOS或iOS）。

Next, enter your app’s name and app store ID in the input box. If your app is live in an app store, it populates within the dropdown to be selected.

接下来，在输入框中输入应用的名称和应用商店ID。如果你的应用程序位于应用商店中，则会在要选择的下拉列表中填充。

If your app is not yet live, you can manually add it to MAX. To do this, click **Manually Add Your Package Name**, then type in your app’s package name, with the casing matching exactly what you have in your app code.

如果你的应用程序尚未上线，你可以手动将其添加到 MAX。为此，请单击 **Manually Add Your Package Name**，然后键入你的应用程序的软件包名称，大小写与你的应用程序代码中的内容完全匹配。

### Add Your Ad Unit - 添加广告单元

After you add your app, add your ad unit by selecting a format and giving your ad unit a name. **AppLovin strongly recommends that you use a single ad unit ID for each format within an app. This ensures an ad is always cached and avoids unnecessary app/user bandwidth usage.**

添加应用程序后，通过选择格式并为广告单元命名来添加广告单元。**AppLovin强烈建议您对应用程序中的每种格式使用单个广告单元ID。这样可以确保始终缓存广告，并避免不必要的应用程序/用户带宽使用。**

After you add your app, you see the networks available to set up in the waterfall. If this is your first time setting up your account, bypass this for now—you will have an opportunity to build the waterfall later. If you are already monetizing with MAX, skip to [Step 6](https://dash.applovin.com/documentation/mediation/max/get-started-with-max#step-6:-set-up-your-waterfall) below to learn how to set up the waterfall.

添加应用程序后，您可以在瀑布中看到可以设置的网络。如果这是您第一次设置您的帐户，那么暂时不要使用它，稍后您将有机会构建瀑布。如果您已经在使用 MAX 赚钱，请跳到下面的[第6步](https://dash.applovin.com/documentation/mediation/max/get-started-with-max#step-6:-set-up-your-waterfall)，学习如何设置瀑布。

You need your ad unit ID for the integration process. You can find it on the [Ad Units](https://dash.applovin.com/o/mediation/ad_units/580541) page.

集成过程需要您的广告单元ID。你可以在 [Ad Units](https://dash.applovin.com/o/mediation/ad_units/580541) 页面上找到它。

## Step 3: Integrate the AppLovin SDK and Networks - 第三步：集成 AppLovin SDK 和网络

MAX supports many [networks](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters) across bidding and traditional connections. There are also custom options allowing you to work with unsupported networks. Before you integrate a network, you must create an account with the network, register your app/ad unit, and be approved to serve ads.

MAX 支持竞价投标的和传统连接的许多网络。还有一些自定义选项允许您使用不受支持的网络。在整合网络之前，你必须在网络上创建一个帐户，注册你的应用程序/广告单元，并获得提供广告的批准。

> **Note:** Need help with creating a network account? Choose your platform in the contents navigation of this documentation and review the Mediated Network Guides.
> 
> **注意：**创建网络帐户需要帮助吗？在本文档的内容导航中选择您的平台，并查看中介网络指南。

### Download and Integrate the AppLovin SDK - 下载和集成 AppLovin SDK

Choose your platform to get access to the latest AppLovin SDK and integration instructions: Adobe AIR, Android, Cordova, Flutter, [iOS](https://dash.applovin.com/documentation/mediation/ios/getting-started/integration), React Native, Unity, Unreal

选择您的平台以访问最新的AppLovin SDK和集成说明：Adobe AIR、Android、Cordova、Flatter、[iOS](https://dash.applovin.com/documentation/mediation/ios/getting-started/integration)、React Native、Unity、Unreal

When you integrate the AppLovin SDK, make sure to do the following. You can find platform-specific instructions above.

集成 AppLovin SDK 时，请确保执行以下操作。您可以在上面找到特定平台的说明。

1. Add the SDK Key to initialize the AppLovin SDK. You can find the key in the [Keys](https://dash.applovin.com/o/account#keys) section under **Account > General**.
2. Initialize the SDK at app startup to allow the AppLovin SDK enough time to fully cache ad assets which results in a better user experience.
3. Enable [Ad Review](https://dash.applovin.com/documentation/mediation/ad-review/creative-review) to monitor creative from AppLovin and networks from the MAX Dashboard.
4. For iOS, enable the App Transparency Tracking (ATT) consent flow programmatically or by using your app’s `Info.plist`. See [Enabling MAX Consent Flow](https://dash.applovin.com/documentation/mediation/ios/getting-started/consent-flow#enabling-max-consent-flow) for more details.

>

1. 添加 SDK 密钥以初始化 AppLovin SDK。您可以在 **Account > General** 下的 [Keys](https://dash.applovin.com/o/account#keys) 部分中找到密钥。
2. 在应用程序启动时初始化 SDK，使 AppLovin SDK 有足够的时间完全缓存广告资产，从而获得更好的用户体验。
3. 启用 [Ad Review](https://dash.applovin.com/documentation/mediation/ad-review/creative-review) 以从 MAX Dashboard 监控 AppLovin 和 networks 的创建。
4. 对于 iOS，通过编程或使用 `Info.plist` 文件启用 App Transparency Tracking (ATT) 同意流。有关更多详细信息，请参阅 [Enabling MAX Consent Flow](https://dash.applovin.com/documentation/mediation/ios/getting-started/consent-flow#enabling-max-consent-flow)。

### Integrating Supported Networks - 集成支持的网络

To mediate supported networks through MAX, download the SDK directly from the network and follow their integration instructions. Network adapters, supported SDK versions, and further instructions for each platform are here: Adobe AIR, Android, Cordova, Flutter-Android, Flutter-iOS, [iOS](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters), React Native, Unity, Unreal

要通过 MAX 中介受支持的网络，请直接从网络下载 SDK，并遵循其集成说明。网络适配器、支持的SDK版本以及每个平台的进一步说明都可以在这里找到：Adobe AIR、Android、Cordova、Flatter Android、Flatter iOS、[iOS](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters)、React Native、Unity、Unreal

### Integrating Unsupported (Custom) Networks - 集成不支持的（自定义）网络

You can mediate unsupported networks through a custom SDK or JS tag connection. Because these networks are not officially supported, AppLovin will not be able to troubleshoot issues. Work directly with the network to build network adapters and/or tags by following these instructions and test thoroughly to ensure the connection works as expected: Adobe AIR, Android, Cordova, Flutter, [iOS](https://dash.applovin.com/documentation/mediation/ios/mediation-setup/custom-sdk), React Native, Unity, Unreal

您可以通过自定义 SDK 或 JS 标记连接来中介不受支持的网络。由于这些网络没有得到官方支持，AppLovin将无法解决问题。直接与网络合作，按照以下说明构建网络适配器和/或标签，并进行彻底测试，以确保连接按预期工作：Adobe AIR、Android、Cordova、Flatter、[iOS](https://dash.applovin.com/documentation/mediation/ios/mediation-setup/custom-sdk)、React Native、Unity、Unreal

> **Note:** AppLovin recommends that you limit your use of custom JS network tags as most tags are not optimized for mobile and may lead to failover issues. Review [these best practices](https://dash.applovin.com/documentation/mediation/ios/mediation-setup/jstag#custom-js-tag-network-integration-guide) before you use them.
> 
> **注意：**AppLovin建议您限制使用自定义 JS 网络标记，因为大多数标记未针对移动设备进行优化，可能会导致故障转移问题。在使用这些最佳做法之前，请先查看 [这些最佳实践](https://dash.applovin.com/documentation/mediation/ios/mediation-setup/jstag#custom-js-tag-network-integration-guide)。

## Step 4: Test Your Integration - 第四步：测试你的集成

After you integrate the AppLovin SDK and networks, you can validate your integration before you go live. MAX has many developer-friendly testing tools to help you test and launch successfully.

> **Note:** If you encounter issues with your integration that MAX testing tools don’t address, contact your account team or [escalate a ticket](https://support.applovin.com/hc/en-us/requests/new) to the AppLovin Support Team. Please include the demo app implementation, the MAX SDK’s [verbose logs](https://support.applovin.com/hc/en-us/articles/4413218413325-How-to-enable-verbose-logging-in-the-AppLovin-SDK) , and your Mediation Debugger screenshot.

### Demo App - 演示程序

The Demo App shows you how to integrate MAX in your mobile apps. You can use the demo app code as a blueprint for your integration.

You also can integrate network SDKs and can monitor the callbacks that MAX makes to the app that notify you of events for each ad format. This helps you verify that you have completed the integration successfully.

Use [Test Mode](https://dash.applovin.com/o/mediation/test_modes) in parallel with this Demo App to load/show ads during the testing process. You can learn more at the MAX Demo App documentation page: Adobe AIR, Android, Cordova, Flutter, [iOS](https://dash.applovin.com/documentation/mediation/ios/testing-networks/demo-app), React Native, Unity, Unreal

### Mediation Debugger - 中介调试器

Mediation Debugger is an AppLovin SDK feature that validates and displays the status of all ad networks that MAX mediates. Use it to check if your network is successfully integrated using test or live ads before your app goes live.
Many publishers who use MAX incorporate this feature into their debug builds or live apps. This helps their QA teams to confirm integration or to identify issues.
You can read more about Mediation Debugger here: Adobe AIR, Android, Cordova, Flutter, [iOS](https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger), React Native, Unity, Unreal

### Test Mode - 测试模式

You can also use Test Mode, within the MAX Dashboard, to verify that you have successfully integrated specific ad networks by ensuring you get network fill when testing. To use Test Mode, enter your Identifier for Advertisers (IDFA) or Google Advertising ID (GAID) from your testing device and select a network to receive test ads from that network.

> **Note:** Test Mode can take up to twenty minutes the first time you activate it. However each subsequent network change should be instant.

Do not use Test Mode with live traffic as some networks will detect that you are testing and will no-fill on those ad requests. Use the Mediation Debugger along with Test Mode to ensure that you can successfully launch your app with MAX.

You can read more about Test Mode here: Adobe AIR, Android, Cordova, Flutter, [iOS](https://dash.applovin.com/documentation/mediation/ios/testing-networks/test-mode), React Native, Unity, Unreal

### Creative Debugger - 创造性调试器

Creative Debugger captures ad creative details for AppLovin and your networks and allows you to report problematic ads to MAX. AppLovin recommends that you incorporate Creative Debugger into your test environments, QA processes, and support ticket systems for users to easily identify and escalate these ads.

You can read more about Creative Debugger here: Adobe AIR, Android, Cordova, Flutter, [iOS](https://dash.applovin.com/documentation/mediation/ios/testing-networks/creative-debugger), React Native, Unity, Unreal

### Pre-Launch Checklist - 启动前检查清单

To launch successfully, AppLovin recommends that you follow the best practices documented in our [Getting Started with MAX](https://dash.applovin.com/documentation/mediation/max/get-started-with-max) and [Integration](https://dash.applovin.com/documentation/mediation/max/integrate) pages.

要成功启动，AppLovin 推荐你遵从我们《[Getting Started with MAX](https://dash.applovin.com/documentation/mediation/max/get-started-with-max)》和《[Integration](https://dash.applovin.com/documentation/mediation/max/integrate)》页所写的最佳实践。

You can also use this quick checklist to help you validate your MAX integration before your app launch:

您还可以使用此快速检查表（checklist）帮助您在应用程序启动前验证 MAX 的集成：

1. Set the relevant privacy flags before you start requesting ads.

	在开始请求广告之前，请设置相关的隐私标志。

	To learn more about privacy flags, see the information here: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.

2. Listen for the AppLovin SDK initialized event before you initialize the SDK. Set the SDK key and initialize the MAX SDK as soon as your app launches.

	初始化SDK之前，请先监听 AppLovin SDK 的 initialized 事件。设置 SDK 密钥，并在应用程序启动后立即初始化 MAX SDK。

	To learn more about the intialization process, see the information here: Adobe AIR, Android, Cordova, iOS, React Native, Unity.
	
3. After you successfully initialize the AppLovin SDK, start loading ads for Interstitial and Rewarded ad formats. **This ensures that you have ample time to catch the winning bid before you show an ad**.

	成功初始化 AppLovin SDK 后，开始加载插屏广告和激励广告。这可以确保您在显示广告之前有足够的时间获取中标广告。

	To learn more about Interstitial ads, see the information here: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.

	To learn more about Rewarded Ads, see the information here: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.
	
	
4. When an Interstitial or Rewarded ad fails to load or fails to display, retry with exponentially higher delays up to a maximum delay. **If you fail to implement this step, you may miss impression opportunities and may lower revenue.**

	当插屏广告或激励广告加载失败或展示失败时，请以指数级增加的延迟重试，直至达到最大延迟。如果您未能实施此步骤，您可能会错过印象机会（给用户留下印象的机会，即用户看到广告的机会），并可能降低收入。
	
	To see sample code with this retry logic, read one of these pages: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.

5. When a user dismisses an Interstitial or Rewarded ad, load the next ad right away. **If you fail to implement this step, you may miss impression opportunities and may lower revenue.**

	当用户关闭一个插屏广告或激励广告时，请立即加载下一个广告。如果您未能实施这一步骤，您可能会错过印象机会，并可能降低收入。
	
	To see sample code with this loading logic, read one of these pages: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.

6. Keep the banner unit on screen at all times in order to optimize performance for higher CPMs and better user experience. MAX will control the refresh rate for optimal results. **If you hide the banner behind content, networks will invalidate impressions based on their viewability rules.**

	始终将横幅单元保持在屏幕上，以优化性能，获得更高的 CPM 和更好的用户体验。MAX 将控制刷新率以获得最佳结果。如果您将横幅隐藏在内容后面，网络将根据其可视性规则使印象无效（即不计入有效展示次数。）。
	
	To learn more about banners, see the information here: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.

	To learn more about MRECs, see the information here: Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal.
	
7. If you do not use MAX Unity Integration Manager, review “Preparing Mediated Networks” (Adobe AIR, Android, Cordova-Android, Cordova-iOS, [iOS](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters), React Native-Android, React Native-iOS, Unity, Unreal) and use the Mediation Debugger (Adobe AIR, Android, Cordova, iOS, React Native, Unity, Unreal) feature to validate that you have all of the necessary configuration for each network.

	如果未使用 MAX Unity Integration Manager，请查看“[准备中介网络](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters)”，并使用[中介调试器](https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger)功能验证您是否具有每个网络的所有必要配置。
	
> **Warning:** To avoid issues, if you mediate a network SDK that you previously used for mediation (for example, if you transition from AdMob Mediation to MAX-mediated AdMob), create a new application ID or delete active Mediation Groups. If you reuse a mediator’s app ID this will cause crashes and discrepancies.
>
> **警告：**为避免出现问题，如果要以前用于中介的网络SDK（例如，从 AdMob 中介 过渡到 MAX 中介的 AdMob）进行中介，请创建新的应用程序ID或删除当前活跃的 Mediation Groups。如果重用中介的应用程序ID，则会导致崩溃和异常。

## Step 5: Connect Your Networks - 第五步：连接你的网络

After you successfully validate your integration, return to the MAX Dashboard and connect your networks. This allows you to pull in network data for real-time bidding for supported bidding networks and CPM updating for most supported traditional networks.

成功验证集成后，返回 MAX Dashboard 并连接你的网络。这允许您拉入网络数据，用于支持的投标网络的实时投标，以及大多数支持的传统网络的 CPM 更新。

### Supported Networks - 支持的网络

First, navigate to **MAX** in the left-hand nav and click [Networks](https://dash.applovin.com/o/mediation/networks/580541) under **Mediation > Manage**. Connect all the networks that you want to mediate. Then click **Connect**, enter the requested network credentials or API key, and click **Save**.

首先，在左侧导航栏中导航到 **MAX**，然后单击  **Mediation > Manage** 下的 [Networks](https://dash.applovin.com/o/mediation/networks/580541)。连接所有要中介的网络。然后单击连接，输入请求的网络凭据或 API 密钥，然后单击 **Save**。

The status icon is a green checkmark when you successfully connect that network. The icon is red or yellow if you must take any further action.

成功连接该网络时，状态图标为绿色复选标记。如果您必须采取任何进一步行动，则图标为红色或黄色。

AppLovin demand is enabled by default and you do not need to do anything to connect it.

默认情况下，AppLovin 需要处于启用状态，您无需执行任何操作即可连接它。

### Custom Networks - 自定义网络

If you have a custom SDK or JS tag network, scroll to the bottom of the **Networks** page and click [Click here to add a Custom Network](https://dash.applovin.com/o/mediation/networks/580541/customNetwork/create). Then add your network tag or adapter class name to complete the setup. Custom networks are not eligible for in-app bidding or Auto CPM.

如果您有自定义 SDK 或 JS 标记网络，请滚动到 **Networks** 页面的底部，点击[单击此处添加自定义网络](https://dash.applovin.com/o/mediation/networks/580541/customNetwork/create)。然后添加网络标记或适配器类名以完成设置。自定义网络没有资格进行应用内竞价或自动 CPM。

You still need to activate your network within your ad unit waterfall. That’s covered in the next section.

你仍然需要在你的广告单元瀑布中激活你的网络。这将在下一节中介绍。

You can read more about connecting networks [here](https://dash.applovin.com/documentation/mediation/ui-max/ad-units/enable-networks).

你可以在[这里](https://dash.applovin.com/documentation/mediation/ui-max/ad-units/enable-networks)阅读更多关于连接网络的信息。

## Step 6: Set Up Your Waterfall - 第六步：设置你的瀑布

You configure waterfalls at the ad unit level. Both bidding and traditional networks compete by highest CPM to serve an impression. This competition maximizes your overall revenue, ensuring you’re paid the most money for each ad opportunity.

您可以在广告单元级别配置瀑布。竞价和传统网络一起竞争最高的 CPM，以提供印象广告。这场竞争使你的整体收入最大化，确保你为每个广告机会获得最多的报酬。

> **Note:** If you want to programmatically manage your waterfall, review the [Ad Unit Management API](https://dash.applovin.com/documentation/mediation/features/ad-unit-automation-api) documentation.
> 
> **注意：**如果您想以编程方式管理瀑布，请查看《[广告单元管理 API](https://dash.applovin.com/documentation/mediation/features/ad-unit-automation-api)》文档。

### Default Waterfall - 默认瀑布

The Default Waterfall is your primary waterfall for monetization. After you set up your ad partners, waterfall management is automated through a combination of in-app bidding and CPM updating.

默认瀑布是确定广告价值的主要瀑布。在你设置了你的广告合作伙伴之后，瀑布自动通过应用内竞价和CPM更新的组合进行管理。

To set up your default waterfall, navigate to the [Ad Units](https://dash.applovin.com/o/mediation/ad_units/580541) page, select an ad unit, then scroll down to the **Default Waterfall** which includes all supported networks, categorized by Bidder Networks and Other (traditionally-mediated) Networks. Only enable networks for which you’ve successfully integrated the SDK and that you have connected to MAX.

要设置默认瀑布，请导航到 [Ad Units](https://dash.applovin.com/o/mediation/ad_units/580541) 页面，选择一个广告单元，然后向下滚动到 **Default Waterfall**，其中包括所有受支持的网络，按投标人网络和其他（传统中介）网络分类。只能启用已成功集成 SDK 且已连接到 MAX 的网络。

1. Expand the desired network by clicking the down-arrow to the right of the network name. Add the required network IDs, then toggle **Status** to on.
	- For non-bidding networks, set a CPM price. Manually enter the floor price or historical CPM of the network. If you have Auto CPM enabled, it will update automatically to align with the network reported CPM. Use the Network Comparison report to validate the MAX CPM Price and Network CPM price match.
2. Add custom JS/SDK or [direct sold](https://dash.applovin.com/documentation/mediation/features/direct-sold) instances to the waterfall if applicable.
3. Click Save.

>

1. 单击网络名称右侧的向下箭头，展开所需的网络。添加所需的网络 ID，然后将 **Status** 切换为“开启”。
	- 对于非投标网络，设置 CPM 价格。手动输入网络的最低价格或历史 CPM。如果您启用了自动 CPM，它将自动更新以与网络报告的CPM对齐。使用网络比较报告验证 MAX CPM 价格和网络 CPM 价格是否匹配。
2. 如果适用，将自定义 JS/SDK 或[直销](https://dash.applovin.com/documentation/mediation/features/direct-sold)实例添加到瀑布中。
3. 点击“保存”。

### Custom Waterfalls - 自定义瀑布

Custom waterfalls are for advanced MAX users. They allow you to use advanced targeting and waterfall segmentation to filter ads to specific audiences. For example, you can use these waterfalls to tailor monetization for users with limit ad tracking (LAT) enabled or high value users with strong ad engagement. Ineligible traffic will continue to use the Default Waterfall configuration.

自定义瀑布适用于高级 MAX 用户。它们允许您使用高级目标定位和瀑布分割来过滤针对特定受众的广告。例如，您可以使用这些瀑布为启用限制广告跟踪（LAT）的用户或具有强大广告参与度的高价值用户量身定制确定广告价值。不合格的流量将继续使用默认的瀑布配置。

Learn more about some of the uses of advanced targeting and waterfall segmentation [here](https://www.applovin.com/blog/using-waterfall-segmentation-to-optimize-user-targeting/).

在[这里](https://www.applovin.com/blog/using-waterfall-segmentation-to-optimize-user-targeting/)了解有关高级目标定位和瀑布分割的一些用法的更多信息。

To create a custom waterfall, click **Create New Waterfall** at the top of the **Default Waterfall**. Name your waterfall and select the device targeting (if applicable). If you collect user or device information and pass it to AppLovin as [keywords](https://dash.applovin.com/documentation/mediation/ios/getting-started/data-passing), you can target those keywords by using **Show Advanced Targeting Options**.

要创建自定义瀑布，请单击默认瀑布顶部的 **Create New Waterfall**。命名瀑布并选择设备目标（如果适用）。如果您收集用户或设备信息并将其作为[关键字](https://dash.applovin.com/documentation/mediation/ios/getting-started/data-passing)传递给 AppLovin，则可以使用 **Show Advanced Targeting Options** 以这些关键字为目标定位。

MAX copies your network configurations from the Default Waterfall as the base for your custom waterfall. You can edit them after they are copied.

MAX 可以从默认瀑布复制网络配置，作为自定义瀑布的基础。您可以在复制后对其进行编辑。

You can read more about Waterfall Segmentation [here](https://dash.applovin.com/documentation/mediation/features/waterfall-segmentation).

你可以在[这里](https://dash.applovin.com/documentation/mediation/features/waterfall-segmentation)阅读更多关于瀑布分割的内容。

### Best Practices - 最佳实践

- Use at least six to eight networks with strong global demand (such as Google or Facebook) to mediate in addition to AppLovin when you begin to establish baseline revenue and performance.
- 当你开始建立基准收入和业绩时，除了 AppLovin 外，至少使用6到8个强大全球需求的网络（如谷歌或脸书）进行中介。
- Prioritize bidding networks whenever possible to reduce manual waterfall maintenance and latency.
- 尽可能优先考虑竞价网络，以减少手动瀑布维护和延迟。
- As you scale, you’ll find that CPMs can vary greatly depending on the geographical mix of your app. Identify the biggest revenue opportunities based on these countries and add networks with strong regional demand (our account teams are happy to make a reccomentation). Build geo-based waterfalls targeting those networks to specific countries to optimize for growth.
- 当你扩张时，你会发现 CPM 可能会因应用程序的地域组合而有很大差异。基于这些国家确定最大的收入机会，并添加具有强大区域需求的网络（我们的客户团队很乐意再次介绍）。建立基于地理位置的瀑布，针对特定国家的网络优化增长。
- Use the [Network Comparison report](https://dash.applovin.com/o/mediation/network_comparison_report) to validate that network CPMs are aligned with CPMs reported in MAX. This is important to ensure networks compete with accurate information in the unified auction and you do not lose money.
- 使用[网络比较报告](https://dash.applovin.com/o/mediation/network_comparison_report)来验证网络 CPM 是否与 MAX 中报告的 CPM 一致。这对于确保网络在统一拍卖中与准确的信息竞争非常重要，确保您不会赔钱。
- Always [A/B test](https://dash.applovin.com/documentation/mediation/features/ab-test) new partners or pricing in the waterfall before you push changes to your entire audience. By A/B testing first, you validate if the change will result in net-positive results. This helps you optimize your waterfall with confidence.
- 在将更改推给整个受众之前，始终在瀑布中对新的合作伙伴或定价 [A/B 测试](https://dash.applovin.com/documentation/mediation/features/ab-test)。首先通过 A/B 测试，验证更改是否会导致正向结果。这有助于您自信地优化瀑布。
- To maximize the number of bidders from the AppLovin Exchange competing for your ad inventory, add AppLovin to your `app-ads.txt` file. To learn more about how to set up `app-ads.txt` click [here](https://support.applovin.com/hc/en-us/articles/4403932935053-Implementing-app-ads-txt).
- 为了最大限度地增加 AppLovin Exchange 竞购您的广告库存的投标人数量，请将 AppLovin 添加到您的 `app-ads.txt` 文件中。要了解有关如何设置 `app-ads.txt` 的更多信息，请单击[此处](https://support.applovin.com/hc/en-us/articles/4403932935053-Implementing-app-ads-txt)。

## Step 7: Analyze Your Performance - 分析你的表现

To help you analyze your performance, there are several tools and reports available in MAX in the **Analyze** section in the left nav, which are highlighted below. You can download reports directly from the UI or schedule them to be emailed to you on a regular basis.

AppLovin also offers reporting APIs for MAX revenue and user level data to plug into your MMP of choice. To learn more, read the [Revenue Reporting API](https://dash.applovin.com/documentation/mediation/reporting-api/max-ad-revenue) documentation.

All UI reports allow you to save reporting views for quick retrieval in the future. A best practice in saving reports is to use the preset time periods instead of custom time periods to always populate most recent data.

With UI reports’ Compare Mode you can compare current performance against historical data and can visualize trends.

### Performance Reporting - 表现报告

Use this report to understand revenue performance at a glance. The charts help you visualize revenue trends and identify areas that are helping or hindering growth. For deeper analysis, try using **Advanced Reporting** or **User Activity Reporting**.

### Advanced Reporting - 高级报告
Advanced Reporting enables you to track deeper insights into your app inventory. Use this report to analyze the performance of your waterfall and find opportunities such as new or optimized pricing in a certain country, or see which networks are under-performing and may need to be removed.In addition to saving this report, you can also schedule it to be emailed to you and others on a regular basis.

You can add columns to the reports by clicking the checkmark next to a report filter and/or add a value in the filter field. Depending on the combination of filters you include in the report, you’ll see different metrics populate.

Here are a few ways you can look at Advanced Reporting:

- **Ad Inventory Performance** Add **Application**, **Ad Unit Name**, and **Ad Type** to get a breakdown of ad inventory performance including total impressions, revenue, and display rate, which is the percentage of time a cached ad is displayed.
- **Network Performance** Add **Network** to the report to view network performance by ad unit. In addition to top level metrics like impressions and CPM, you’ll see two new metrics: fill rate and win rate. Fill rate shows how often a network can fill an ad and win rate is how often a bidding network wins an auction against other bidding networks.
- **Waterfall Performance** Add **Waterfall** to your report and filter to one ad unit name to view the performance of any active waterfalls you’re running for an ad unit. Add **Country** to the report for a more granular view. Use this view to best analyze waterfall performance and identify opportunities to improve yield.

### User Activity Report

Use the **User Activity** report to understand ad engagement for each ad format. You can track the number of daily active users, ARPDAU, and impressions users see. This tool is ideal for anyone who doesn’t have a MMP to connect to the MAX user revenue reporting API.