# Receiving ad attributions and postbacks
# 接收广告归因和回传

原文地址：[https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)

Learn about timeframes and priorities for ad impressions that result in ad attributions, and how additional impressions qualify for postbacks.

了解带来广告归因的广告印象的时间框架和优先级，以及其他展示如何符合回传条件。

# Overview - 概览

Ad networks receive attributions in the form of install-validation postbacks. Before an ad network can receive a postback, the following events need to occur within limited time-windows:

- Ad networks sign and present ads in the form of StoreKit-rendered ads, view-through ads, or attributable web ads. StoreKit records the ad impressions.
- Users install the advertised app.
- Users launch the app.
- The app updates the conversion values when the user first launches the app, and continues to update it as needed.

广告网络以安装验证回传的形式接收归因。需要在有限的时间窗口内发生以下事件，广告才网络能够接收到回传：

- 广告网络签署并展示广告，包括 StoreKit 渲染的广告、视图展示广告或可归因的网络广告。StoreKit 记录广告印象。
- 用户安装广告宣传的应用程序。
- 用户启动应用程序。
- 应用程序在用户首次启动应用程序时更新转化价值，并根据需要持续更新。

If all these events occur within their respective time-windows, the ad impression qualifies for an install-validation postback. The following table shows the time-windows for the events:

如果所有这些事件在各自的时间窗口内发生，广告印象就有资格获得安装验证回传。以下表格显示了各事件的时间窗口：

Event</br>事件|Time-window</br>时间窗口
|:-:|:-:|
The ad network presents a StoreKit-rendered ad.</br>广告网络展示 StoreKit 渲染的广告。|The user has 30 days to install the app.</br>用户有 30 天时间安装应用程序。
The ad network presents a view-through ad.</br>广告网络展示视图展示广告。|The user has 24 hours to install the app.</br>用户有 24 小时安装应用程序。
The user taps an attributable web ad.</br>用户点击可归因的网络广告。|The user has 30 days to install the app.</br>用户有 30 天时间安装应用程序。
The user installs the app.</br>用户安装应用程序。|The user has 60 days to launch the app.</br>用户有 60 天时间启动应用程序。
The user launches the app and the app calls any conversion update method, such as `updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)`。</br>用户启动应用程序，并应用调用任何转化值更新方法，例如 `updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)`。|The device has 60 days after the user installs the app to send the first conversion value update.</br>设备在用户安装应用程序后有 60 天时间发送第一个转化值更新。
The user launches the app and the app calls a conversion update method, such as `updatePostbackConversionValue(_:completionHandler:)` for ads signed with version 3 or earlier.</br>用户启动应用程序并应用调用转化值更新方法，例如对于使用版本 3 或更早版本签署的广告调用 `updatePostbackConversionValue(_:completionHandler:)`。|For ads signed with version 3 or earlier, the device sends install-validation postbacks 0–24 hours after a 24-hour timer expires following the final call to update the conversion value. The total delay from the final conversion update to receiving the postback is 24–48 hours.</br>对于使用版本 3 或更早版本签署的广告，在最后一次调用更新转化值后的 24 小时计时器到期后 0–24 小时内，设备发送安装验证回传。从最终转化值更新到接收回传的总延迟为 24–48 小时。

The minimum elapsed time between an ad impression and the time the ad network receives an install-validation postback is 24 to 48 hours. To reduce that time to 5 to 10 minutes during testing, see [Testing ad attributions with a downloaded profile](https://developer.apple.com/documentation/storekit/testing-ad-attributions-with-a-downloaded-profile).

广告印象和广告网络接收安装验证回传之间的最小时间间隔为 24 到 48 小时。为了在测试期间将这段时间缩短到 5 到 10 分钟，请参阅《[通过下载配置文件进行广告归因测试](https://developer.apple.com/documentation/storekit/testing-ad-attributions-with-a-downloaded-profile)》。

Devices send one or more postbacks depending on the SKAdNetwork and iOS versions:

- For ads signed with SKAdNetwork 1 through 2.2, devices send a single, winning postback.
- Starting in iOS 14.6 for ads signed with version 3.0 or later, devices send a single winning postback, and up to five nonwinning postbacks.
- Starting in iOS 15, devices also send a copy of the winning postback to the advertised app’s developer, if the developer opts in to receive it.
- Starting in iOS 16.1 for ads signed using SKAdNetwork 4, devices can send up to three postbacks for the winning ad attribution, in three conversion windows.

设备会根据 SKAdNetwork 和 iOS 版本发送一个或多个回传：

- 对于使用SKAdNetwork 1 至 2.2 签名的广告，设备发送一个获胜的回传。
- 从 iOS 14.6 开始，对于使用 3.0 或更高版本签名的广告，设备发送一个获胜的回传和多达五个非获胜的回传。
- 从 iOS 15 开始，设备还会将获胜的回传副本发送给广告应用的开发者，如果开发者选择接收。
- 从 iOS 16.1 开始，对于使用 SKAdNetwork 4 签名的广告，设备可以在三个转化窗口中发送多达三个获胜广告归因的回传。

Time-windows for events apply equally to winning and nonwinning postbacks.

事件的时间窗口同样适用于获胜和非获胜的回传。

# Receive a winning postback - 接收获胜的回传

When multiple ad impressions qualify for install-validation postbacks, a device sends the winning postback to the ad network based on the following rules:

- In versions 1 through 2.1, the attribution goes to the most recent ad impression.
- Starting in version 2.2, the attribution goes to the most recent ad impression with the highest `fidelity-type` value.

当多个广告印象符合安装验证回传的条件时，设备根据以下规则向广告网络发送获胜的回传：

- 在版本 1 至 2.1 中，归因归属于最近的广告印象。
- 从版本 2.2 开始，归因归属于具有最高 `fidelity-type` 值的最近广告印象。

The ad presentation option defines the `fidelity-type` value:

- StoreKit-rendered ads have the highest `fidelity-type` value of `1`.
- View-through ads have a `fidelity-type` value of `0`.

广告印象选项定义了 `fidelity-type` 值：

- StoreKit 渲染的广告的拥有最高 `fidelity-type` 值，为 `1`。
- 视图展示广告的 `fidelity-type` 值为 `0`。

Indicate the `fidelity-type` when you generate the ad signature. Recorded ad impressions with a `fidelity-type` of `1` always take precedence over those with a `fidelity-type` of `0`. For example, if users see a StoreKit-rendered ad followed by a view-through ad for the same app, the StoreKit-rendered ad takes precedence over the view-through ad, despite the view-through ad being more recent. The source app can display StoreKit-rendered ads using an `SKOverlay` or `SKStoreProductViewController`; the `fidelity-type` value is `1` in either case. For information about the fidelity of ads that an ad network presents on a Safari web page using the [SKAdNetwork for Web Ads](https://developer.apple.com/documentation/SKAdNetworkforWebAds) API, see [signature](https://developer.apple.com/documentation/SKAdNetworkforWebAds/signature).

在生成广告签名时，请指定 `fidelity-type`。`fidelity-type` 为 `1` 的广告印象始终优先于 `fidelity-type` 为 `0` 的广告被记录。例如，如果用户看到同一应用的 StoreKit 渲染广告，然后是视图展示广告，StoreKit 渲染广告将优先于视图展示广告，尽管视图展示广告更为接近。源应用可以使用 `SKOverlay` 或 `SKStoreProductViewController` 显示 StoreKit 渲染的广告；在任何情况下，`fidelity-type` 的值均为 `1`。有关广告网络在Safari网页上使用[用于 web 广告的 SKAdNetwork](https://developer.apple.com/documentation/SKAdNetworkforWebAds) API 展示的广告保真度的信息，请参阅《[签名](https://developer.apple.com/documentation/SKAdNetworkforWebAds/signature)》。

In version 3 and later, the system indicates winning postbacks with a `did-win` parameter of value `true`.

在版本 3 及更高版本中，系统使用值为 `true` 的 `did-win` 参数表示获胜的回传。

# Receive a nonwinning postback - 接收非获胜回传

Starting in iOS 14.6, devices can send multiple postbacks to ad networks that sign ads using version 3 or later. The system indicates nonwinning postbacks with a `did-win` parameter of value `false`. These postbacks don’t include `conversion-value` or `source-app-id`.

从 iOS 14.6 开始，设备可以向使用版本 3 或更高版本签署广告的广告网络发送多个回传。系统使用值为 `false` 的 `did-win` 参数指示非获胜的回传。这些回传不包含 `conversion-value` 或 `source-app-id`。

Each ad network can receive only one install-validation postback, winning or not winning. If you receive the winning postback, you don’t receive any nonwinning postbacks even if your ads have multiple qualifying ad impressions.

每个广告网络只能接收一个安装验证回传，无论是获胜还是非获胜。如果您收到获胜的回传，即使您的广告有多个符合条件的广告印象，您也不会收到任何非获胜的回传。

Up to five ad networks receive one nonwinning postback each. The system orders the recorded ad impressions using recency and `fidelity-type`, with the most recent ad views and highest `fidelity-type` taking precedence. Devices send nonwinning postbacks for the top five ad impressions from different ad networks that qualify for ad attribution.

最多有五个广告网络分别接收一个非获胜的回传。系统根据时间和 `fidelity-type` 类型对记录的广告印象进行排序，最近的广告印象和最高 `fidelity-type` 优先。设备为符合广告归因条件的来自不同广告网络的前五个广告印象发送非获胜的回传。

# Opt in to receive a copy of the winning postback - 选择接收获胜回传的副本

Starting in iOS 15, devices can send a copy of the winning install-validation postback to the developer of the advertised app. Developers opt in to receive the postback by specifying a server endpoint in their app’s `Info.plist` file. For more information about opting in and specifying the endpoint, see [Configuring an advertised app](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app).

从 iOS 15 开始，设备可以将获胜的安装验证回传的副本发送给广告应用的开发者。开发者通过在其应用的 `Info.plist` 文件中指定服务器接口选择接收回传。有关选择接收并指定接口的更多信息，请参阅《[配置广告应用](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app)》。

The postback that developers receive is an exact copy of the winning install-validation postback that the device sends to the ad network. The device sends the postback to developers at the same time it sends the winning postback to the ad network. To verify the postback, see [Verifying an install-validation postback](https://developer.apple.com/documentation/storekit/verifying-an-install-validation-postback).

开发者收到的回传是设备发送给广告网络的获胜安装验证回传的精确副本。设备在将获胜回传发送给广告网络的同时，也会将回传同时发送给开发者。要验证回传，请参阅《[验证安装验证回传](https://developer.apple.com/documentation/storekit/verifying-an-install-validation-postback)》。

# Limit view-through ad impressions - 限制视图广告印象

StoreKit records a maximum of 15 view-through ad impressions per source app before discarding the oldest one. The recorded ad impressions may advertise various products, and are each eligible to become pending attributions until they expire (after 24 hours).

StoreKit 在丢弃最旧的视图广告印象之前，会记录每个源应用的最多 15 次视图广告印象。记录的广告印象可能宣传各种产品，并且每个广告印象都有资格成为待处理归因，直到过期（24小时后）。

# Test ad impressions and postbacks - 测试广告印象和回传

Use the [StoreKit Test](https://developer.apple.com/documentation/StoreKitTest) framework to validate your ad impressions and test your postbacks by creating unit tests. For more information, see [SKAdTestSession](https://developer.apple.com/documentation/StoreKitTest/SKAdTestSession) and [Testing and validating ad impression signatures and postbacks for SKAdNetwork](https://developer.apple.com/documentation/StoreKitTest/testing-and-validating-ad-impression-signatures-and-postbacks-for-skadnetwork).

使用 [StoreKit Test](https://developer.apple.com/documentation/StoreKitTest) 框架通过创建单元测试来验证您的广告印象并测试您的回传。有关更多信息，请参阅 [SKAdTestSession](https://developer.apple.com/documentation/StoreKitTest/SKAdTestSession) 和《[测试和验证用于 SKAdNetwork 的广告印象签名和回传](https://developer.apple.com/documentation/StoreKitTest/testing-and-validating-ad-impression-signatures-and-postbacks-for-skadnetwork)》。

# See Also - 其他参考

## Essentials - 要素

### [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads) - 签名和提供广告

Advertise apps by signing and providing StoreKit-rendered ads or view-through ads.

通过签署并提供 StoreKit 渲染型广告或浏览型广告查看来宣传应用。

### [Receiving Ad Attributions and Postbacks](https://developer.apple.com/documentation/storekit/skadnetwork/receiving_ad_attributions_and_postbacks) - 接收广告归因和回传

Learn about timeframes and priorities for ad impressions that result in ad attributions, and how additional impressions qualify for postbacks.

了解带来广告归因的广告印象的时间框架和优先级，以及其他印象如何符合回传条件。

### [SKAdNetwork Release Notes](https://developer.apple.com/documentation/storekit/skadnetwork/skadnetwork_release_notes) - SKAdNetwork 发布说明

Learn about the features in each SKAdNetwork version.

了解每个 SKAdNetwork 版本的功能。
