# AppLovin MAX Pre-Launch Checklist

链接地址：[https://dash.applovin.com/documentation/mediation/max/get-started-with-max#pre-launch-checklist](https://dash.applovin.com/documentation/mediation/max/get-started-with-max#pre-launch-checklist)

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

	如果未使用MAX Unity Integration Manager，请查看“[准备中介网络](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters)”，并使用[中介调试器](https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger)功能验证您是否具有每个网络的所有必要配置。
	
> **Warning:** To avoid issues, if you mediate a network SDK that you previously used for mediation (for example, if you transition from AdMob Mediation to MAX-mediated AdMob), create a new application ID or delete active Mediation Groups. If you reuse a mediator’s app ID this will cause crashes and discrepancies.
>
> **警告：**为避免出现问题，如果要以前用于中介的网络SDK（例如，从 AdMob 中介 过渡到 MAX 中介的 AdMob）进行中介，请创建新的应用程序ID或删除当前活跃的 Mediation Groups。如果重用中介的应用程序ID，则会导致崩溃和异常。

