# Mediation Debugger

链接地址：[https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger](https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger)

Mediation Debugger is a suite of testing tools. These tools help you integrate and launch faster with MAX. You can use them to confirm the validity of network integrations. This ensures that you can successfully load and show ads, among other things.

中介调试器是一套测试工具。这些工具可以帮助您更快地与 MAX 集成和启动。您可以使用它们来确认网络集成的有效性。这确保了你可以成功地加载和显示广告，以及其他事情。

There are four sections in the Mediation Debugger:

中介调试器这篇文章分为四个部分：

- Integration Status: Use this to confirm that you have successfully completed the network integration.
- 集成状态：使用此项确认您已成功完成网络集成。
- Testing with Test Ads: Use this to load and show ads from networks by using each network’s test mode.
- 使用测试广告进行测试：通过使用每个网络的测试模式从网络加载和显示广告。
- Testing with Live Ads: Use this to load and show ads from networks by using your waterfall configuration.
- 使用实时广告测试：通过使用你的瀑布配置从网络加载和显示广告。
- Sharing the Mediation Debugger: Use this to generate a copy of your integration checklist that you can send to reviewers before you launch.
- 共享中介调试器：使用此项生成集成清单的副本，可以在启动之前发送给审阅者。

![App Info, MAX, MAX Consent Flow, Privacy, Ads](https://dash.applovin.com/documentation/static/1053/67411f61106bfa8a6898e20481037005.jpg) ![Incomplete Integrations, Completed Integrations](https://dash.applovin.com/documentation/static/1053/6fe69c825a8c782f4ff2ce9478f299b0.jpg)

## Displaying the Mediation Debugger - 显示中介调试器

To display the Mediation Debugger, make the following call:

要显示中介调试器，请进行以下调用：

```
[[ALSdk shared] showMediationDebugger];
```

## Integration Status - 集成状态

The Mediation Debugger displays the integration status of the MAX-mediated network adapters and/or SDKs found in your app. It flags integration issues associated with each network (such as a mismatch between the network SDK and adapter version, or missing SKAdNetwork IDs).

中介调试器显示在应用程序中找到的 MAX 中介网络适配器和/或 SDK 的集成状态。它标记与每个网络相关的集成问题（例如网络 SDK 和适配器版本之间的不匹配，或者缺少 SKAdNetwork ID）。

It displays the integration status of mediated networks in three sections: Completed Integrations, Incomplete Integrations, and Missing Integrations.

它将中介网络的集成状态显示为三个部分：完整集成、不完整集成和缺失集成。

- **Completed Integrations**: You have successfully integrated these ad networks into your app.
- **完整集成**：您已成功将这些广告网络整合到您的应用程序中。
- **Incomplete Integrations**: These ad networks have one or more issues you need to fix before you can integrate them successfully into your app. Tap on the cell for more information. You can find integration instructions in the [Preparing Mediated Networks](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters) section of this documentation.
- **不完全集成**：这些广告网络有一个或多个问题需要解决，然后才能将其成功集成到应用程序中。点击单元格了解更多信息。您可以在本文档的《[准备中介网络](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters)》部分中找到集成说明。
- **Missing Integrations**: You have not integrated these ad networks into your app.
- **缺少集成**：您尚未将这些广告网络集成到应用程序中。

## Testing with Test Ads - 使用测试广告进行测试

After you successfully integrate your mediated networks, AppLovin recommends that you validate your integration by loading and showing those networks’ test ads.

成功集成中介网络后，AppLovin 建议您通过加载并显示这些网络的测试广告来验证你的集成。

> **Note**: Some mediated networks may have requirements that you must meet before you can load ads. For example, the SDK may require enough time to fully initialize (this is true, for instance, for AdColony, Tapjoy, and Vungle). If you do not allow sufficient time, this might cause no fill errors. AppLovin recommends that you load ads during the window from 2–5 seconds after you initialize the SDK.
> 
> **注意**：在加载广告之前，某些被中介的网络可能需要满足一些要求。例如，SDK 可能需要足够的时间来完全初始化（例如，对于 AdColony、Tapjoy 和 Vungle 来说，都是这样的）。如果没有足够的时间，这可能会导致未填充错误。AppLovin 建议您在初始化SDK 后的 2-5 秒后在窗口中加载广告。

To use the Test Ads feature,

1. Select a mediated network that you have successfully integrated, under the **Completed Integrations** section.
2. Tap **Enable** under **Test Ad**.
3. Restart the application so the mediated SDK initializes with test ad credentials.
4. Select the mediated network again to enter the test-ads view seen below:

要使用测试广告功能，

1. 在 **Completed Integrations** 部分下，选择已成功集成的中介网络。
2. 点击 **Test Ad** 下的 **Enable** 按钮。
3. 重新启动应用程序，以便中介的 SDK 使用测试广告凭据初始化。
4. 再次选择中介网络，进入测试广告视图，如下所示：

![Test Ads](https://dash.applovin.com/documentation/static/1053/18b98007e3e2ce0d2e0f62b328a14176.png)

## Testing with Live Ads - 使用实时广告测试

The Mediation Debugger allows you to view and test ads using your Ad Units’ waterfall configurations.

中介调试器允许您使用广告单元的瀑布配置查看和测试广告。

> **Warning**: If you test with live traffic, some networks might flag this as fraudulent activity. You might also experience issues getting filled due to your waterfall configuration or the network’s targeting parameters. We strongly suggest that you test with live ads when you validate the integration.
> 
> **警告**：如果您使用实时流量进行测试，某些网络可能会将其标记为欺诈活动。由于瀑布配置或网络的目标参数，您可能还会遇到填充问题。我们强烈建议您在验证集成时使用实时广告进行测试。

To begin, select the **View Ad Units** cell, which displays the list of Ad Units associated with your app. Select an Ad Unit from that list to view the waterfall configuration from the MAX Ad Unit section.

首先，选择 **View Ad Units** 单元，该单元显示与应用程序关联的广告单元列表。从该列表中选择一个广告单元，查看来自 MAX 广告单元的瀑布配置。

> **Note**: Country and LAT (Limit Ad Traffic) targeting rules apply to your device when you view and test live Ad Units.
> 
> **注意**：当您查看和测试实时广告单元时，国家和LAT（限制广告流量）定位规则会应用于您的设备。

![Ad Units](https://dash.applovin.com/documentation/static/1053/2a6b757964dbd01157ad2a3a826672cb.png)

### Full Waterfall - 全瀑布

Select an ad unit from the Ad Units list and click the Load button to request an ad for the Ad Unit.

从广告单元列表中选择广告单元，然后单击 Load 按钮为广告单元请求广告。

![INTER: Info, Bidding Networks. Tap to load an ad.](https://dash.applovin.com/documentation/static/1053/2e2829c57866483d43223eb078da501b.png)

### Single Ad Source - 单个广告源

You can also select one of the mediated networks for the ad unit to be the only ad source for ad requests. To do so, click one of the networks in the Bidding Networks list for that ad unit. This isolates that network in the list. Next, click the Load button to request an ad from that network for the Ad Unit.

您还可以为广告单元选择一个中介网络，作为广告请求的唯一广告源。为此，请单击该广告单元的 Bidding Networks 列表中的一个网络。这将隔离列表中的网络。接下来，单击 Load 按钮，从该网络请求广告单元的广告。

![INTER: Info, Bidding networks. AppLovin ad loaded. Show.](https://dash.applovin.com/documentation/static/1053/a2de8751a32458d37da189a046ea5e2c.png)

### Within the App - 在应用程序内

Starting in SDK version 10.0.1, you can use the Mediation Debugger to force live ads from selected networks within your app’s natural environment. To begin, select the **Select Live Network** cell and follow the instructions on the screen.

从 SDK 版本10.0.1开始，您可以使用中介调试器在应用程序自然环境中从选定网络强制播放实时广告。首先，选择 **Select Live Network** 单元并按照屏幕上的说明操作。

> **Warning**: This feature is not available when test mode is enabled. Several networks consider live ads on test devices to be fraudulent traffic. AppLovin recommends that you use test ads to validate your integration. You can use this feature to monitor live traffic.
> 
> 警告：启用测试模式时，此功能不可用。一些网络认为测试设备上的实时广告是欺诈性流量。AppLovin 建议您使用测试广告来验证您的集成。您可以使用此功能监视实时流量。

## Sharing the Mediation Debugger - 共享中介调试器

Quality reviewers may ask you to share a copy of your Mediation Debugger output before you push your apps live. This ensures that your integration is healthy and ready to go live.

质量审查人员可能会要求您在推送应用程序上线之前共享调解调试器输出的副本。这可以确保您的集成是健康的，并且可以投入使用。

To share your Mediation Debugger output, click the share button at the top right of the Mediation Debugger home screen and complete the action using your preferred method.

要共享您的中介调试器输出，请单击中介调试器主屏幕右上角的共享按钮，并使用首选方法完成操作。

![MAX Mediation Debugger. App Info, MAX.](https://dash.applovin.com/documentation/static/1053/1c2ea176e432fb6cb60e0710e4cc8898.png)



