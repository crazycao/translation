# SKAdNetwork

原文地址：[https://developer.apple.com/documentation/storekit/skadnetwork](https://developer.apple.com/documentation/storekit/skadnetwork)

A class that validates advertisement-driven app installations.

验证广告驱动的应用程序安装的类。

> **Framework**
>
> iOS 11.3+
iPadOS 11.3+
Mac Catalyst 13.1+

# Declaration - 声明

```
class SKAdNetwork : NSObject
```

# Overview - 概览

> **Important** **重要**
>
> Use [AdAttributionKit](https://developer.apple.com/documentation/AdAttributionKit) for app ad campaigns on the App Store and alternative marketplaces. See the [ad attribution developer support page](https://developer.apple.com/app-store/ad-attribution/) for information on how AdAttributionKit helps advertisers measure the success of ad campaigns while helping maintain user privacy. For information on interoperability between SKAdNetwork and AdAttributionKit, see [Understanding AdAttributionKit and SKAdNetwork interoperability](https://developer.apple.com/documentation/AdAttributionKit/adattributionkit-skadnetwork-interoperability).
> 
> 在 App Store 和其他替代市场上的应用广告活动中使用 [AdAttributionKit](https://developer.apple.com/documentation/AdAttributionKit)。查看[广告归因开发者支持页面](https://developer.apple.com/app-store/ad-attribution/)，了解 AdAttributionKit 如何帮助广告主衡量广告活动的成功，并帮助保护用户隐私。有关 SKAdNetwork 和 AdAttributionKit 之间的互用性（译者注：互用性，又称互操作性，指不同的系统之间相互合作，共享信息，协同工作（即互操作）的能力）信息，请查看了解《[AdAttributionKit 和 SKAdNetwork 互用性](https://developer.apple.com/documentation/AdAttributionKit/adattributionkit-skadnetwork-interoperability)》。

The ad network API helps advertisers measure the success of ad campaigns while maintaining user privacy. The API involves three participants:

广告网络 API 帮助广告商衡量广告活动的成功与否，同时维护用户隐私。这些 API 涉及三个参与者：

- **Ad networks** that sign ads and receive install-validation postbacks after ads result in conversions
- 对广告签名并在广告带来转化后接收安装验证回传（postbacks）的
- **Source apps** that display ads provided by the ad networks
- 显示广告网络提供的广告的
- **Advertised apps** that appear in the signed ads
- 出现在已签名的广告中的**广告应用**

- **Ad networks** that sign ads and receive install-validation postbacks after ads result in conversions
- **Source apps** that display ads from the ad networks, or websites that display the ads in Safari
- **Advertised apps** that update conversion values as people engage with the app

- **广告网络**：对广告签名并接收在广告带来转化后的安装验证回传（postbacks）
- **源应用**：显示来自广告网络的广告的应用程序，或在 Safari 中显示广告的网站
- **广告应用**：用户与之互动时会更新转化价值的应用程序

Ad networks register with Apple to get an ad network ID and to use the API. Developers configure their apps to accept attributable ads from ad networks, and to receive copies of winning postbacks. For information about setup, see [Registering an ad network](https://developer.apple.com/documentation/storekit/registering-an-ad-network), [Configuring a source app](https://developer.apple.com/documentation/storekit/configuring-a-source-app), and [Configuring an advertised app](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app). For information about displaying ads in Safari, see [SKAdNetwork for Web Ads](https://developer.apple.com/documentation/SKAdNetworkforWebAds).

广告网络向苹果公司注册以获取广告网络 ID 并使用 API。开发者配置他们的应用程序以接受来自广告网络的可归因广告，并接收赢得的 postbacks 的副本。有关设置信息，请参阅《[注册广告网络](https://developer.apple.com/documentation/storekit/registering-an-ad-network)》、《[配置源应用程序](https://developer.apple.com/documentation/storekit/configuring-a-source-app)》和《[配置广告应用程序](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app)》。有关在 Safari 中显示广告的信息，请参阅《[用于 Web 广告的 SKAdNetwork](https://developer.apple.com/documentation/SKAdNetworkforWebAds)》。

The following diagram shows the path of an ad impression that wins ad attribution. The ad network serves an ad that an app or Safari web page displays. A user taps the ad and downloads the advertised app.

下图显示了赢得广告归因的广告印象路径。广告网络提供了一个广告，由应用程序或 Safari 网页显示。用户点击广告并下载了广告应用程序。

![赢得广告归因的广告印象路径](https://docs-assets.developer.apple.com/published/cfb86917a943b271b8187aff2aa2993d/media-4103236@2x.png)

Apple determines a postback data tier for the app download, and the device uses the tier later to determine the level of detail the postback can contain to ensure crowd anonymity. For more information about the postback contents and the data tiers, see [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows).

苹果确定应用程序下载的回传数据层级（tier），并且设备稍后使用该层来确定回传可以包含的详细级别（level），以确保群体匿名性（crowd anonymity）。有关回传内容和数据层级的更多信息，请参阅《[在多个转化窗口中接收回传](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows)》。

If the user launches the app within an attribution time-window, the ad impression is eligible for install-attribution postbacks. As the user engages with the app, the app updates the conversion value. Starting in iOS 16.1, apps can update conversion values during three conversion windows, which results in up to three postbacks for an ad signed using version 4. The system sends the postbacks to the ad network, and to the app’s developer if they opt in to receive postbacks.

如果用户在归因时间窗口内启动应用程序，则广告印象有资格获得安装归因回传。当用户与应用程序互动时，应用程序会更新转化值。从 iOS 16.1 开始，应用程序可以在三个转化窗口期间更新转化值，这会导致对使用版本 4 签署的广告最多发送三个回传。系统会将回传发送给广告网络，并且如果应用程序开发者选择接收回传，则也会发送给应用程序开发者。

Devices send install-validation postbacks to multiple ad networks that sign their ads using version 3 or later.

- One ad network receives a postback with a `did-win` parameter value of `true` for the ad impression that wins the ad attribution.
- Up to five other ad networks receive a postback with a `did-win` parameter value of `false` if their ad impressions qualify for the attribution, but don’t win.

设备会向多个使用版本 3 或更高版本签署其广告的广告网络发送安装验证回传。

- 一个广告网络会收到一个带有 `did-win` 参数值为 `true` 的回传，用于标识赢得广告归因的广告印象。
- 最多还会有五个其他广告网络收到一个带有 `did-win` 参数值为 `false` 的回传，表示他们的广告印象符合归因条件，但没有获胜。

The following diagram shows the path of ad impressions that qualify for, but don’t win, the ad attribution. Up to five ad networks receive a single nonwinning postback.

下图展示了符合广告归因条件但未获胜的广告印象的路径。最多有五个广告网络会收到一个单个的未获胜回传。

![符合广告归因条件但未获胜的广告印象的路径](https://docs-assets.developer.apple.com/published/62cd8fd4dc40174006c06a54c155300b/media-4103237@2x.png)

For more information about receiving ad attributions, including time-window details and other constraints, see [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks).

如果您需要更多关于接收广告归因的信息，包括时间窗口细节和其他限制，请查看《[接收广告归因和回传](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)》。

The information in the postback that Apple cryptographically signs doesn’t include user- or device-specific data. It may include values from the ad network and the advertised app if providing those values meets Apple’s privacy threshold. For more information about postback values and postback data tiers, see [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows). For more information about the contents of postbacks for each SKAdNetwork version, see [Verifying an install-validation postback](https://developer.apple.com/documentation/storekit/verifying-an-install-validation-postback).

苹果加密签名的回传信息不包括用户或设备特定的数据。如果提供这些值符合苹果的隐私门槛，回传信息可能会包括来自广告网络和广告应用的值。如果您想了解有关回传值和回传数据层级的更多信息，请参阅《[在多个转化窗口接收回传](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows)》。如果您需要了解每个 SKAdNetwork 版本的回传内容，请参阅《[验证安装验证回传](https://developer.apple.com/documentation/storekit/verifying-an-install-validation-postback)》。

## Presenting ads, updating conversion values, and receiving attribution - 展示广告、更新转化价值和接收归因

Each participant has specific responsibilities when using the ad network APIs to present ads and receive attribution.

当使用广告网络 API 展示广告和接收归因时，每个参与者都有特定的责任。

The ad network’s responsibilities are to:

1. Register and provide its ad network identifier to developers. See [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network).
2. Provide signed ads to the source app. See [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads).
3. Receive install-validation postbacks at the URL it established during registration.
4. Verify the postbacks. See [Verifying an Install-Validation Postback](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback).

广告网络的责任是：

1. 注册并向开发者提供其广告网络标识符。请参阅《[注册广告网络](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network)》。
2. 向源应用提供签名广告。请参阅《[签名和提供广告](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads)》。
3. 在注册时指定的 URL 处接收安装验证回传。
4. 验证回传。请参阅《[验证安装验证回传](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback)》。

The source app’s responsibilities are to:

1. Add the ad network identifiers to its `Info.plist`. See [Configuring a Source App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app).
2. Display ads that the ad network signs. See [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app).

源应用的责任是：

1. 将广告网络标识符添加到其 `Info.plist`。请参阅《[配置源应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app)》。
2. 显示广告网络签名的广告。请参阅《[签名和提供广告](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads)》。

The advertised app’s responsibilities are to:

1. Register an app installation by updating the conversion value when the user first launches the app by calling one of the conversion updating methods, such as [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)).
2. Optionally, continue to update the conversion value as the user engages with the app, by calling one of the conversion updating methods, such as [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)).
3. Optionally, specify a server URL in its `Info.plist` to receive a copy of the winning install-validation postback. See [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app).

广告应用的责任是：

1. 在用户首次启动应用时注册应用安装，方法是调用其中一个转化价值更新方法，如 [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))。
2. （可选）在用户使用应用时继续更新转化价值，方法是调用其中一个转化值更新方法，例如 [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))。
3. （可选）在其 `Info.plist` 中指定服务器 URL，以接收获胜的安装验证回传的副本。请参阅《[配置广告应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app)》。

Apple designs SKAdNetwork APIs to maintain user privacy. Apps don’t need to use App Tracking Transparency before calling SKAdNetwork APIs, and can call these APIs regardless of their tracking authorization status. For more information about privacy, see User Privacy and Data Use.


Apple designs SKAdNetwork APIs to maintain user privacy. Apps don’t need to use [App Tracking Transparency](https://developer.apple.com/documentation/apptrackingtransparency) before calling SKAdNetwork APIs, and can call these APIs regardless of their tracking authorization status. For more information about privacy, see [User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/).

苹果设计了 SKAdNetwork API 用以维护用户隐私。应用程序在调用 SKAdNetwork API 之前不需要使用 [App Tracking Transparency](https://developer.apple.com/documentation/apptrackingtransparency)，并且可以不管其跟踪授权状态而调用这些 API。有关隐私的更多信息，请参阅《[用户隐私和数据使用](https://developer.apple.com/app-store/user-privacy-and-data-use/)》。

> **Note**
>
> The SKAdNetwork APIs have no effect, return empty strings, or return values that indicate unavailability when you call the APIs from a compatible iPad or iPhone app running in macOS or visionOS, from a Mac app built with Mac Catalyst, or from an App Clip’s code. For more information about App Clips, see [Choosing the right functionality for your App Clip](https://developer.apple.com/documentation/app_clips/choosing_the_right_functionality_for_your_app_clip).
> 
> 当您从在 macOS 或 visionOS 上运行的兼容 iPad 或 iPhone 应用程序，从使用 Mac Catalyst 构建的 Mac 应用程序，或从 App Clip 的代码调用 SKAdNetwork APIs 时，这些 API 不会产生任何效果，返回空字符串，或返回指示不可用性的值。有关轻应用，请参见《[为轻应用选择正确的功能](https://developer.apple.com/documentation/app_clips/choosing_the_right_functionality_for_your_app_clip)》。

# Topics - 主题
## Essentials - 要素

### [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads) - 签名和提供广告

Advertise apps by signing and providing StoreKit-rendered ads or view-through ads.

通过签署并提供 StoreKit 渲染型广告或浏览型广告查看来宣传应用。

### [Receiving Ad Attributions and Postbacks](https://developer.apple.com/documentation/storekit/skadnetwork/receiving_ad_attributions_and_postbacks) - 接收广告归因和回传

Learn about timeframes and priorities for ad impressions that result in ad attributions, and how additional impressions qualify for postbacks.

了解带来广告归因的广告印象的时间框架和优先级，以及其他印象如何符合回传条件。

### [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows) - 在多个转化窗口中接收回传

Learn about the data that postbacks may contain in each conversion window.

了解在每个转化窗口中的回传可能包含的数据。

### [SKAdNetwork Release Notes](https://developer.apple.com/documentation/storekit/skadnetwork/skadnetwork_release_notes) - SKAdNetwork 发布说明

Learn about the features in each SKAdNetwork version.

了解每个 SKAdNetwork 版本的功能。

## Registering Ad Networks and Configuring Apps - 注册广告网络和配置应用程序

### [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network) - 注册广告网络

Register your ad network with Apple to use the install-validation APIs for your ad campaigns.

向 Apple 注册你的广告网络，以便对你的广告活动使用安装验证 API。

### [Configuring a Source App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app) - 配置源应用

Configure a source app to participate in ad campaigns.

配置源应用以参与广告活动。

### [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app) - 配置广告应用

Prepare an advertised app to participate in ad campaigns.

准备广告应用以参与广告活动。

### property list key [SKAdNetworkItems](https://developer.apple.com/documentation/bundleresources/information_property_list/skadnetworkitems)

An array of dictionaries containing a list of ad network identifiers.

包含广告网络标识符列表的字典数组。

### property list key [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/bundleresources/information_property_list/nsadvertisingattributionreportendpoint)

The URL where Private Click Measurement and SKAdNetwork send attribution information.

私人点击测量 和 SKAdNetwork 发送归因信息的URL。

## Signing StoreKit-Rendered Ads - 签名 StoreKit 渲染型广告

### [Generating the Signature to Validate StoreKit-Rendered Ads](https://developer.apple.com/documentation/storekit/skadnetwork/generating_the_signature_to_validate_storekit-rendered_ads) - 生成签名以验证 StoreKit 渲染型广告

Initiate install validation by displaying a StoreKit-rendered ad with signed parameters.

通过显示带有签名参数的 StoreKit 渲染型广告来启动安装验证。

### [Ad Network Install-Validation Keys](https://developer.apple.com/documentation/storekit/skadnetwork/ad_network_install-validation_keys) - 广告网络安装验证 KEY

Specify key values that validate and associate an app installation with an ad campaign.

指定验证应用程序安装并将其与广告活动关联的键值。

## Signing View-Through Ads - 签名浏览型广告

### [Generating the Signature to Validate View-Through Ads](https://developer.apple.com/documentation/storekit/skadnetwork/generating_the_signature_to_validate_view-through_ads) - 生成签名以验证浏览型广告

Initiate install validation by displaying a view-through ad with signed parameters.

通过显示带有签名参数的浏览型广告来启动安装验证。

### class [SKAdImpression](https://developer.apple.com/documentation/storekit/skadimpression)

A class that defines an ad impression for a view-through ad.

定义浏览型广告的广告印象的类。

### class func [startImpression(SKAdImpression, completionHandler: ((Error?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/3727304-startimpression)

Indicates that your app is presenting a view-through ad to the user.

表示你的 App 正在向用户展示浏览型广告。

### class func [endImpression(SKAdImpression, completionHandler: ((Error?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/3727303-endimpression)

Indicates that your app is no longer presenting a view-through ad to the user.

表示你的 App 不再向用户展示浏览型广告。

## Providing Conversion Information - 提供转化信息

### class func [updatePostbackConversionValue(Int, coarseValue: SKAdNetwork.CoarseConversionValue, lockWindow: Bool, completionHandler: (((any Error)?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))

Updates the fine and coarse conversion values and indicates whether to send the postback before the conversion window ends, and calls a completion handler if the update fails.

更新精细和粗略转化价值，并指示在转化窗口结束之前是否发送回传，如果更新失败则调用完成处理程序。

### class func [updatePostbackConversionValue(Int, coarseValue: SKAdNetwork.CoarseConversionValue, completionHandler: (((any Error)?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:))

Updates the fine and coarse conversion values, and calls a completion handler if the update fails.

更新精细和粗略转化价值，并在更新失败时调用完成处理程序。

### struct [CoarseConversionValue](https://developer.apple.com/documentation/storekit/skadnetwork/coarseconversionvalue)

Coarse values to use for updating conversion values.

用于更新转化价值的粗略值。

### class func [updatePostbackConversionValue(Int, completionHandler: ((Error?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/3919928-updatepostbackconversionvalue)

Verifies the first launch of an advertised app and on subsequent calls, updates the conversion value or calls a completion hander if the update fails.

验证广告应用的首次启动和后续调用，更新转化值 或 在更新失败时调用完成处理程序。

## Verifying Postbacks - 验证回传

### [Verifying an Install-Validation Postback](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback) - 验证“安装验证”回传

Verify that a postback you receive after an ad conversion is cryptographically signed by Apple.

验证你收到的回传，该回传在广告转化被苹果加密后收到。

## Testing Ad Attributions and Postbacks - 测试广告归因和回传

### [Testing Ad Attributions with a Downloaded Profile](https://developer.apple.com/documentation/storekit/skadnetwork/testing_ad_attributions_with_a_downloaded_profile) - 使用下载的配置文件测试广告稿归因

Reduce the time window for ad attributions and inspect postbacks using a proxy during testing.

减少广告归因的时间窗口，并在测试期间使用代理检查回传。

### [Testing and Validating Ad Impression Signatures and Postbacks for SKAdNetwork](https://developer.apple.com/documentation/storekittest/testing_and_validating_ad_impression_signatures_and_postbacks_for_skadnetwork) - 测试和验证SKAdNetwork 的广告印象签名和回传

Validate your ad impressions and test your postbacks by creating unit tests using the StoreKit Test framework.

通过使用 StoreKit Test 框架创建单元测试，验证广告印象并测试回传。

## Deprecated - 已弃用

### class func [registerAppForAdNetworkAttribution()](https://developer.apple.com/documentation/storekit/skadnetwork/2943654-registerappforadnetworkattributi) 【Deprecated】

Verifies the first launch of an app installed as a result of an ad.

验证一个程序作为广告的结果被安装后的首次启动。

### class func [updateConversionValue(Int)](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue) 【Deprecated】

Updates the conversion value and verifies the first launch of an app installed as a result of an ad.

更新转化值，并验证一个程序作为广告的结果被安装后的首次启动。

# Relationships - 关系

## Inherits From
[NSObject](https://developer.apple.com/documentation/objectivec/nsobject)

# See Also - 其他参考

## Ad Network Attribution - 广告网络归因

### class [SKAdNetwork](https://developer.apple.com/documentation/storekit/skadnetwork)

A class that validates advertisement-driven app installations.

验证广告驱动的应用程序安装的类。

### class [SKAdImpression](https://developer.apple.com/documentation/storekit/skadimpression)

A class that defines an ad impression for a view-through ad.

定义通过广告查看的广告印象的类。

### enum [SKANError.Code](https://developer.apple.com/documentation/storekit/skanerror/code)

Constants that indicate the type of error for an ad network attribution operation.

指示广告网络归因操作的错误类型的常量。

### struct [SKANError](https://developer.apple.com/documentation/storekit/skanerror)

An error that an ad network attribution operation returns.

广告网络归因操作返回的错误。

### let [SKANErrorDomain](https://developer.apple.com/documentation/storekit/skanerrordomain): String

A string that identifies the SKAdNetwork error domain.

标识 SKAdNetwork 错误域的字符串。
