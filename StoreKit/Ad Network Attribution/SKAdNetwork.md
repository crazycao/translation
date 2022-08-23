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

The ad network API helps advertisers measure the success of ad campaigns while maintaining user privacy. The API involves three participants:

广告网络 API 帮助广告商衡量广告活动的成功与否，同时维护用户隐私。这些 API 涉及三个参与者：

- **Ad networks** that sign ads and receive install-validation postbacks after ads result in conversions
- 对广告签名并在广告带来转化后接收安装验证回传（postbacks）的**广告网络**
- **Source apps** that display ads provided by the ad networks
- 显示广告网络提供的广告的**源应用**
- **Advertised apps** that appear in the signed ads
- 出现在已签名的广告中的**广告应用**

Ad networks must register with Apple, and developers must configure their apps to work with ad networks. For information about set up, see [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network), Configuring a Source App, and Configuring an Advertised App.

广告网络必须向苹果公司注册，且开发者必须配置他们的应用程序才能与广告网络协同工作。有关设置的信息，请参阅《[注册广告网络](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network)》、《[配置源应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app)》和《[配置广告应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app)》。

The following diagram describes the path of an install validation for a StoreKit-rendered ad. App A is the source app that displays an ad. App B is the advertised app that the user installs.

下图描述了 StoreKit 渲染型广告的安装验证路径。应用程序 A 是显示广告的源应用程序。应用程序 B 是用户安装的广告应用程序。

![A diagram showing a user tapping an ad for App B inside of App A, then installing and launching App B. App B calls the `updatePostbackConversionValue` method, which triggers a conversion notification and starts the timer. After the timer expires, the ad network receives the postback which it must verify. 图中显示了用户在应用程序 A 中点击应用程序 B 的广告，然后安装和启动应用程序 B。应用程序 B 调用 `updatePostbackConversionValue` 方法，该方法触发转化通知并启动计时器。定时器过期后，广告网络接收回传，并必须对其进行验证。](https://docs-assets.developer.apple.com/published/3b67140452/rendered2x-1642033157.png)

When users tap an ad, advertisers display an ad with cryptographically signed parameters that identify the ad campaign. Starting in iOS 14.5, advertisers can choose to display a custom view-through ad or a StoreKit-rendered ad. If the user installs the advertised app within an attribution time-window, the device sends an install attribution postback to the ad network.

当用户点击广告时，广告商会显示带有加密签名参数的广告，这些参数用于识别广告活动。从 iOS 14.5 开始，广告商可以选择通过广告或 StoreKit 渲染型广告显示自定义视图。如果用户在归因时间窗口内安装了广告应用，则设备会向广告网络发送安装归因回传。

Starting in iOS 14.6, devices send install-validation postbacks to multiple ad networks that sign their ads using version 3.0.

从 iOS 14.6 开始，设备向多个广告网络发送安装验证回传，这些广告网络使用 3.0 版本对其广告签名。

- One ad network receives a postback with a did-win parameter value of true for the ad impression that wins the ad attribution.
- 只有一个广告网络会收到 `did-win` 参数的值为 `true` 的回传，表示该广告印象赢得了广告归因。
- Up to five other ad networks receive a postback with a did-win parameter value of false if their ad impressions qualified for the attribution, but didn’t win.
- 其他至多五家广告网络会收到 `did-win` 参数的值为 `false` 的回传，如果他们的广告印象符合归因条件，但未获胜。

Starting in iOS 15, developers of advertised apps can opt-in to get copies of the winning postbacks that represent successful ad conversions for their app. To opt-in, configure a postback URL in your app. For more information see [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app).

从 iOS 15 开始，广告应用的开发者可以选择加入，以获得代表其应用程序成功广告转化的获胜回传的副本。要选择加入，请在应用程序中配置回传 URL。有关更多信息，请参阅《[配置广告应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app)》。

For more information about receiving attribution, including time-window details and other constraints, see [Receiving Ad Attributions and Postbacks](https://developer.apple.com/documentation/storekit/skadnetwork/receiving_ad_attributions_and_postbacks).

有关接收归因的更多信息，包括时间窗口详情和其他约束条件，请参阅《[接收广告归因和回传](https://developer.apple.com/documentation/storekit/skadnetwork/receiving_ad_attributions_and_postbacks)》。

The information in the postback that’s cryptographically signed by Apple includes the campaign ID, but doesn’t include user- or device-specific data. The postback may include a conversion value and the source app’s ID if Apple determines that providing the values meets Apple’s privacy threshold. Starting with SKAdNetwork version 3.0, postbacks include a did-win flag to indicate whether the ad network won the attribution. For more information about postbacks, see [Verifying an Install-Validation Postback](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback).

由苹果公司加密签名的回传信息中包括活动 ID，但不包括特定于用户或设备的数据。如果苹果确定提供的值符合苹果的隐私阈值，回传可以包括转化值和源应用的 ID。从 SKAdNetwork 3.0 版本开始，回传中包括一个 `did-win` 标志，以指示广告网络是否赢得归因。有关回传的更多信息，请参阅《[验证安装验证回传](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback)》。


## Presenting Ads and Receiving Attribution - 展示广告和接收归因

Each participant has specific responsibilities when using the ad network APIs to present ads and receive attribution.

当使用广告网络 API 展示广告和接收归因时，每个参与者都有特定的责任。

The ad network’s responsibilities are to:

广告网络的责任是：

1. Register and provide its ad network identifier to developers. See [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network).
2. Provide signed ads to the source app. See [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads).
3. Receive install-validation postbacks at the URL it established during registration.
4. Verify the postbacks. See [Verifying an Install-Validation Postback](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback).

>

1. 注册并向开发者提供其广告网络标识符。请参阅《[注册广告网络](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network)》。
2. 向源应用提供签名广告。请参阅《[签名和提供广告](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads)》。
3. 在注册时指定的 URL 处接收安装验证回传。
4. 验证回传。请参阅《[验证安装验证回传](https://developer.apple.com/documentation/storekit/skadnetwork/verifying_an_install-validation_postback)》。

The source app’s responsibilities are to:

源应用的责任是：

1. Add the ad network identifiers to its `Info.plist`. See [Configuring a Source App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app).
2. Display ads that the ad network signs. See [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app).

>

1. 将广告网络标识符添加到其 `Info.plist`。请参阅《[配置源应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app)》。
2. 显示广告网络签名的广告。请参阅《[签名和提供广告](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads)》。

The advertised app’s responsibilities are to:

广告应用的责任是：

1. Register an app installation by calling [registerAppForAdNetworkAttribution()](https://developer.apple.com/documentation/storekit/skadnetwork/2943654-registerappforadnetworkattributi) or [updateConversionValue(_:)](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue).
2. Optionally, update a conversion value by calling [updateConversionValue(_:)](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue).
3. Optionally, specify a server URL in its `Info.plist` to receive a copy of the winning install-validation postback. See [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app).

>

1. 通过调用 [registerAppForAdNetworkAttribution()](https://developer.apple.com/documentation/storekit/skadnetwork/2943654-registerappforadnetworkattributi) 或 [updateConversionValue(_:)](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue) 注册应用程序安装。
2. （可选）通过调用 [updateConversionValue(_:)](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue) 更新转化值。
3. （可选）在其 `Info.plist` 中指定服务器 URL，以接收获胜的安装验证回传的副本。请参阅《[配置广告应用](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app)》。

SKAdNetwork APIs are designed to maintain user privacy. Apps don’t need to use [App Tracking Transparency](https://developer.apple.com/documentation/apptrackingtransparency) before calling SKAdNetwork APIs, and can call these APIs regardless of their tracking authorization status. For more information about privacy, see [User Privacy and Data Use](https://developer.apple.com/app-store/user-privacy-and-data-use/).

SKAdNetwork API 旨在维护用户隐私。应用程序在调用 SKAdNetwork API 之前不需要使用 [App Tracking Transparency](https://developer.apple.com/documentation/apptrackingtransparency)，并且可以不管其跟踪授权状态而调用这些 API。有关隐私的更多信息，请参阅《[用户隐私和数据使用](https://developer.apple.com/app-store/user-privacy-and-data-use/)》。

> **Note**
>
> When you call APIs provided by SKAdNetwork from an App Clip’s code, these APIs have no effect, return empty strings, or return values that indicate unavailability. For more information about App Clips, see [Choosing the right functionality for your App Clip](https://developer.apple.com/documentation/app_clips/choosing_the_right_functionality_for_your_app_clip).
> 
> 当您从轻应用的代码调用 SKAdNetwork 提供的API时，这些 API 会没有效果，返回空字符串或返回指示不可用的值。有关轻应用，请参见《[为轻应用选择正确的功能](https://developer.apple.com/documentation/app_clips/choosing_the_right_functionality_for_your_app_clip)》。

# Topics - 主题
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

### class func [updatePostbackConversionValue(Int, completionHandler: ((Error?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/3919928-updatepostbackconversionvalue)

Verifies the first launch of an advertised app and on subsequent calls, updates the conversion value or calls a completion hander if the update fails.

验证广告应用的首次启动和后续调用，更新转化值 或 在更新失败时调用完成处理程序。

### class func [registerAppForAdNetworkAttribution()](https://developer.apple.com/documentation/storekit/skadnetwork/2943654-registerappforadnetworkattributi) 【Deprecated】

Verifies the first launch of an app installed as a result of an ad.

验证一个程序作为广告的结果被安装后的首次启动。

### class func [updateConversionValue(Int)](https://developer.apple.com/documentation/storekit/skadnetwork/3566697-updateconversionvalue) 【Deprecated】

Updates the conversion value and verifies the first launch of an app installed as a result of an ad.

更新转化值，并验证一个程序作为广告的结果被安装后的首次启动。

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
