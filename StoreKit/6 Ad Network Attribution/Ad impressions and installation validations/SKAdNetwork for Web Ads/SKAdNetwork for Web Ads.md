# SKAdNetwork for Web Ads
# 供 Web 广告使用的 SKAdNetwork

原文地址：[https://developer.apple.com/documentation/SKAdNetworkforWebAds](https://developer.apple.com/documentation/SKAdNetworkforWebAds)

Attribute app-install campaigns that originate on the web.

对源自网络的应用安装活动进行归因。

> SKAdNetwork for Web Ads 1.0+

# Overview - 概览

The SKAdNetwork for Web Ads API enables advertisers to measure the success of ad campaigns that initiate on the web, while maintaining user privacy. In iOS 16.1 and later, ad networks can use this API to get [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork) attributions for web ad clicks in Safari that lead to app installations from the App Store.

SKAdNetwork for Web Ads API 使广告商能够衡量在网站上启动的广告活动是否成功，同时保护用户隐私。在 iOS 16.1 及更高版本中，广告网络可以使用此 API 获取 Safari 中导致 App Store 应用安装的网络广告点击的 [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork) 归因。

To use the API, follow these steps:

1. Register your ad network; see [Registering an ad network](https://developer.apple.com/documentation/StoreKit/registering-an-ad-network).
2. Configure and display your web ad link; see [Creating an attributable ad link](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link).
3. Implement an endpoint to provide a signed web ad payload that the advertised app uses to attribute app installations to your ad campaign; see [Generating a signature for attributable web ads](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads).
4. Validate any attributions you receive; see [Verifying an install-validation postback](https://developer.apple.com/documentation/StoreKit/verifying-an-install-validation-postback).

要使用该API，请遵从以下步骤：

1. 注册您的广告网络；请参阅《[注册广告网络](https://developer.apple.com/documentation/StoreKit/registering-an-ad-network)》。
2. 配置并展示您的网络广告链接；请参阅《[创建可归因广告链接](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link)》。
3. 实现一个接口来提供一个经过签名的网络广告负载，广告应用可以使用它将应用安装归因给您的广告活动；请参阅《[为可归因网络广告生成签名](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads)》。
4. 验证您收到的任何归因；请参阅《[验证安装验证回传](https://developer.apple.com/documentation/StoreKit/verifying-an-install-validation-postback)》。

For more information about the ad network API, see [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork).

有关广告网络 API 的更多信息，请参阅 [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork)。

> **Note** **注意**
>
> Ad networks can only use this API to get attributions for web ad clicks in Safari; the API doesn’t get attributions for web ad clicks in SFSafariViewController or WKWebView.
> 
> 广告网络只能使用此 API 获取 Safari 中的网络广告点击的归因；该 API 不会获取 SFSafariViewController 或 WKWebView 中的网络广告点击的归因。

# Topics - 主题
## Essentials - 要素

### [Creating an attributable ad link](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link) - 创建可归因广告链接

Create click-through web ads that attribute App Store app installations to your ad network.

创建网络广告，可通过点击将 App Store 应用安装归因给您的广告网络。

## Receiving a request for a web ad payload - 接收对网络广告负载的请求

### [Get a Signed Web Ad Impression Payload](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.) - 获取已签名的网络广告印象负载

An endpoint you provide to receive requests from devices to serve signed ad interactions.

提供一个接口以接收设备请求，以便提供已签名的广告交互。

### object [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest)

The request body that devices send to fetch the web ad impression from the ad network’s server.

设备发送的请求体，用于从广告网络服务器获取网络广告印象。

## Providing the web ad signature and response - 提供网络广告签名和响应

### [Generating a signature for attributable web ads](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads) - 生成可归因网络广告的签名

Initiate install-validation by providing the signed parameters for an attributable web ad.

通过提供可归因网络广告的已签名参数来启动安装验证。

### object [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse)

The response you provide that contains a signed payload for a clicked web ad.

您提供的响应，包含一个已签名的点击网络广告的负载。

### object [signature](https://developer.apple.com/documentation/skadnetworkforwebads/signature)

The key-value pairs that ad networks use to cryptographically sign a web ad.

广告网络用于对网络广告进行加密签名的键值对。