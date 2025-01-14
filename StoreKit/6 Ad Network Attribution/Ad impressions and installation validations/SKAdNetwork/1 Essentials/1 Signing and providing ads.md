# Signing and providing ads
# 签名和提供广告

原文地址：[https://developer.apple.com/documentation/storekit/signing-and-providing-ads](https://developer.apple.com/documentation/storekit/signing-and-providing-ads)

Advertise apps by signing and providing StoreKit-rendered ads, view-through ads, or attributable web ads.

通过签名并提供 StoreKit 渲染的广告、视图展示广告或可归因的网络广告来推广应用程序。

# Overview - 概览

SKAdNetwork supports several ways for ad networks to provide ads:

- StoreKit-rendered ads, where StoreKit displays an App Store product page as the ad impression
- View-through ads, where the ad network presents an ad in any format and reports the ad impression using the SKAdNetwork API
- Attributable web ads, where the ad network presents an ad on a Safari web page using the [SKAdNetwork for Web Ads](https://developer.apple.com/documentation/SKAdNetworkforWebAds) API

SKAdNetwork 支持广告网络提供广告的几种方式：

- StoreKit 渲染的广告，其中 StoreKit 显示 App Store 产品页面作为广告展示
- 视图展示的广告，广告网络以任何格式呈现广告，并使用 SKAdNetwork API 报告广告展示
- 可归因的网络广告，广告网络使用 [用于 web 广告的 SKAdNetwork](https://developer.apple.com/documentation/SKAdNetworkforWebAds) API 在 Safari 网页上呈现广告

To differentiate StoreKit-rendered ads from view-through ads, SKAdNetwork defines a `fidelity-type` parameter, which you include in the ad signature, and receive in the install-validation postback. Use a fidelity-type value of 1 for StoreKit-rendered ads and attributable web ads, and 0 for view-through ads. The following table compares the ad presentation options:

为了区分 StoreKit 渲染的广告和视图展示的广告，SKAdNetwork 定义了一个 `fidelity-type` 参数（译者注：可翻译为“保真度类型”），在广告签名中包含该参数，并在安装验证回传中接收。对于 StoreKit 渲染的广告和可归因的网络广告，请将 `fidelity-type` 值为 `1`，对于视图展示广告，将其值设为 `0`。以下表格比较了广告呈现选项：

Ad presentation option</br>广告呈现选项|Description</br>描述|Fidelity type</br>保真度类型|Availability</br>可用性
:-:|:-:|:-:|:-:
StoreKit-rendered ads</br>StoreKit 渲染的广告|App Store product page that StoreKit renders</br>StoreKit 渲染的 App Store 产品页面|1|All SKAdNetwork versions</br>所有 SKAdNetwork 版本
View-through ads</br>视图展示的广告|Custom, from the ad network</br>自定义，来自广告网络|0|SKAdNetwork 2.2 and later</br>SKadNetwork 2.2 及以后版本
Attributable web ads (SKAdNetwork for Web Ads)</br>可归因的网络广告（用于 web 广告的 SKAdNetwork）|Custom, from the ad network</br>自定义，来自广告网络|1|SKAdNetwork 4 and later</br>SKadNetwork 4 及以后版本

For more information about availability and versions, see [SKAdNetwork release notes](https://developer.apple.com/documentation/storekit/skadnetwork-release-notes).

有关可用性和版本信息，请参阅《[SKAdNetwork 发布说明](https://developer.apple.com/documentation/storekit/skadnetwork-release-notes)》。

The `fidelity-type` can affect which ad receives attribution when the user experiences multiple ad impressions. For more information about how `fidelity-type` and the time of the ad impression affect attributions, see [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks).

`fidelity-type` 可以影响用户在体验多个广告展示时哪个广告会被归因。有关 `fidelity-type` 和广告展示时间如何影响归因的更多信息，请参阅《[接收广告归因和回传信息](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)》。

Ad networks must cryptographically sign the ads. The signature contains information that includes a campaign identifier. If ads result in conversions, ad networks receive an install-validation postback that includes the campaign identifier. For more information about the postback, see [Verifying an install-validation postback](https://developer.apple.com/documentation/storekit/verifying-an-install-validation-postback).

广告网络必须对广告进行加密签名。签名包含的信息中包括一个活动标识符（campaign identifier）。如果广告导致转化，广告网络将收到一个包含活动标识符的安装验证回传。有关回传的更多信息，请参阅《[验证安装验证回传](https://developer.apple.com/documentation/storekit/verifying-an-install-validation-postback)》。

# Provide a StoreKit-rendered ad - 提供 StoreKit 渲染的广告

Follow these steps to display a StoreKit-rendered ad in your app:

1. Set [Ad network install-validation keys](https://developer.apple.com/documentation/storekit/ad-network-install-validation-keys) with values that represent the ad impression.
2. On the ad network’s server, generate the signature using those key values. Then, set the [SKStoreProductParameterAdNetworkAttributionSignature](https://developer.apple.com/documentation/storekit/skstoreproductparameteradnetworkattributionsignature) key with the signature value. For information about generating the signature, see [Generating the signature to validate StoreKit-rendered ads](https://developer.apple.com/documentation/storekit/generating-the-signature-to-validate-storekit-rendered-ads).
3. Call [loadProduct(withParameters:completionBlock:)](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/loadproduct(withparameters:completionblock:)) using your ad network install-validation keys to load the ad.
4. Present the ad in your app according to your app’s design. You can use either an [SKOverlay](https://developer.apple.com/documentation/storekit/skoverlay) or an [SKStoreProductViewController](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller) to display a StoreKit-rendered ad. The `fidelity-type` value of a StoreKit-rendered ad is `1` in either case.

按照以下步骤在您的应用程序中显示 StoreKit 渲染的广告：

1. 使用代表广告展示的值设置[广告网络安装验证键](https://developer.apple.com/documentation/storekit/ad-network-install-validation-keys)。
2. 在广告网络的服务器上，使用这些键值生成签名。然后，使用该签名值设置 [SKStoreProductParameterAdNetworkAttributionSignature](https://developer.apple.com/documentation/storekit/skstoreproductparameteradnetworkattributionsignature) 键的值。有关生成签名的信息，请参阅《[生成用于验证 StoreKit 渲染广告的签名](https://developer.apple.com/documentation/storekit/generating-the-signature-to-validate-storekit-rendered-ads)》。
3. 调用 [loadProduct(withParameters:completionBlock:)](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/loadproduct(withparameters:completionblock:)) 使用您的广告网络安装验证键来加载广告。
4. 根据您的应用程序设计，在您的应用程序中展示广告。您可以使用 [SKOverlay](https://developer.apple.com/documentation/storekit/skoverlay) 或 [SKStoreProductViewController](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller) 来显示一个 StoreKit 渲染的广告。无论是哪一种，StoreKit 渲染广告的 `fidelity-type` 值都为 `1`。

# Provide a view-through ad - 提供视图展示的广告

Follow these steps to provide a view-through ad:

1. Create an [SKAdImpression](https://developer.apple.com/documentation/storekit/skadimpression) instance and set its properties to represent the ad impression.
2. On the ad network’s server, generate the signature based on those properties. Then set the `signature` property in the `SKAdImpression` instance to the generated signature. For more information, see [Generating the signature to validate view-through ads](https://developer.apple.com/documentation/storekit/generating-the-signature-to-validate-view-through-ads).
3. Call [startImpression(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/startimpression(_:completionhandler:)) and then present your custom ad to the user according to your app’s design.
4. Call [endImpression(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/endimpression(_:completionhandler:)) when you finish presenting the ad.

按照以下步骤提供一个视图展示广告：

1. 创建一个 [SKAdImpression](https://developer.apple.com/documentation/storekit/skadimpression) 实例，并设置其属性以表示广告展示。
2. 在广告网络的服务器上，基于这些属性生成签名。然后将生成的签名设置为 `SKAdImpression` 实例的 `signature` 属性。有关更多信息，请参阅《[生成用于验证视图展示广告的签名](https://developer.apple.com/documentation/storekit/generating-the-signature-to-validate-view-through-ads)》。
3. 调用 [startImpression(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/startimpression(_:completionhandler:))，然后根据您的应用程序设计向用户展示您的自定义广告。
4. 当您完成展示广告时，请调用 [endImpression(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/endimpression(_:completionhandler:))。

# Provide an attributable web ad - 提供可归因的网络广告

Ad networks can sign attributable ads that websites can display in Safari. For more information, see [SKAdNetwork for Web Ads]((https://developer.apple.com/documentation/SKAdNetworkforWebAds)).

广告网络可以签署可归因广告，这些广告可以在 Safari 中被显示在网站上。有关更多信息，请参阅《[用于 web 广告的 SKAdNetwork](https://developer.apple.com/documentation/SKAdNetworkforWebAds)》。

# See Also - 其他参考

## Essentials - 要素

### [Signing and Providing Ads](https://developer.apple.com/documentation/storekit/skadnetwork/signing_and_providing_ads) - 签名和提供广告

Advertise apps by signing and providing StoreKit-rendered ads or view-through ads.

通过签署并提供 StoreKit 渲染型广告或浏览型广告查看来宣传应用。

### [Receiving Ad Attributions and Postbacks](https://developer.apple.com/documentation/storekit/skadnetwork/receiving_ad_attributions_and_postbacks) - 接收广告归因和回传

Learn about timeframes and priorities for ad impressions that result in ad attributions, and how additional impressions qualify for postbacks.

了解带来广告归因的广告展示的时间框架和优先级，以及其他展示如何符合回传条件。

### [SKAdNetwork Release Notes](https://developer.apple.com/documentation/storekit/skadnetwork/skadnetwork_release_notes) - SKAdNetwork 发布说明

Learn about the features in each SKAdNetwork version.

了解每个 SKAdNetwork 版本的功能。
