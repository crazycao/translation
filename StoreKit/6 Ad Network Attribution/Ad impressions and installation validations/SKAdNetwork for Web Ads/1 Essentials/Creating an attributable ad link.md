# Creating an attributable ad link
# 创建可归因的广告链接

原文地址：[https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link)

Create click-through web ads that attribute App Store app installations to your ad network.

创建点击跳转的网络广告，将 App Store 应用安装归因于您的广告网络。

# Overview - 概览

The web provides a broad platform for advertising apps to a wide audience. In iOS 16.1 and later, ad networks can use the [SKAdNetwork for Web Ads](https://developer.apple.com/documentation/skadnetworkforwebads) API to get [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork) attributions for App Store app installations that originate from web ads in Safari.

网络为向广泛受众广告应用提供了一个宽广的平台。在 iOS 16.1 及更高版本中，广告网络可以使用 [SKAdNetwork for Web Ads](https://developer.apple.com/documentation/skadnetworkforwebads) API 来获取源自 Safari 中的网络广告的 App Store 应用安装的 [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork) 归因。

## Register an ad network - 注册广告网络

Before creating an attributable ad link, you need to register your ad network with Apple. For information, see [Registering an ad network](https://developer.apple.com/documentation/StoreKit/registering-an-ad-network).

在创建可归因广告链接之前，你需要在苹果注册你的广告网络。更多信息参见《[注册广告网络](https://developer.apple.com/documentation/StoreKit/registering-an-ad-network)》。

## Create a link with the expected format - 创建一个符合预期格式的链接

To receive app-installation attribution from a web ad, provide a specialized link that directs a person to download the advertised app from the App Store. The link needs to be in the following format:

为了从网络广告中接收应用安装的归因信息，请提供一个专门的链接，引导用户从 App Store 下载所宣传的应用。链接需要采用以下格式：

```
<a href="https://apps.apple.com/app/id{itunes_item_id}" 
attributionDestination="https://example.com" 
attributionSourceNonce="t8naKxXHTzuTJhNfljADPQ">
</a>
```

Provide the following values to retrieve the full [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork) attribution information when a person clicks the ad:

- `{itunes_item_id}`
	- The App Store ID of the app that the ad impression advertises.
- `attributionDestination`
	- The effective top-level domain and one more preceding domain component (eTLD+1) representation of the ad network that seeks ad attribution. This value needs to match the `source_domain` value in the request and response for [Get a Signed Web Ad Impression Payload](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.).
- `attributionSourceNonce`
	- A Base64URL-encoded representation of a one-time UUID value that you generate for each ad impression.

当用户点击广告时，请提供以下值以检索完整的 [SKAdNetwork](https://developer.apple.com/documentation/StoreKit/SKAdNetwork) 归因信息：

- `{itunes_item_id}`
	- 广告印象所宣传的应用的 App Store ID。
- `attributionDestination`
	- 寻求广告归因的广告网络的有效顶级域和一个更早的域组件（eTLD+1）表示。此值需要与《[获取签名的网络广告印象负载](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.)》的请求和响应中的 `source_domain` 值匹配。
- `attributionSourceNonce`
	- 每次广告印象生成的一次性 UUID 值的 Base64URL 编码表示。

The `attributionSourceNonce` in a web ad link, the `source_nonce` in an [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest), and the `nonce` in an [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) all represent the same UUID, but the encoding varies.

网络广告链接中的 `attributionSourceNonce`、[AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest) 中的 `source_nonce` 和 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) 中的 `nonce` 都代表相同的 UUID，但编码方式不同。

To generate an `attributionSourceNonce` for a web ad, Base64URL-encode the raw bytes of the UUID. Don’t encode a string representation of the UUID or lowercase the encoded UUID. The device uses the same encoding as `attributionSourceNonce` for the `source_nonce` value in the [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest). However, you use the dash-separated string representation of the UUID for the `nonce` value in an [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse).

要为网络广告生成 `attributionSourceNonce`，只需要对 UUID 的原始字节进行 Base64URL 编码。不要对 UUID 的字符串表示进行编码或将编码后的 UUID 转换为小写。设备在 [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest) 中的 `source_nonce` 值中使用与 `attributionSourceNonce` 相同的编码。然而，在 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) 中的 `nonce` 值中，您应使用 UUID 的短横线分隔的字符串表示。

## Use the link in a web ad - 在网络广告中使用链接

Add the link to an advertisement or an app promotion on the webpage where you want people to encounter it. You can cover the entire advertisement with the link or include it as a pure hyperlink to the App Store.

将链接添加到您希望用户遇到的网页上的广告或应用推广中。您可以使用链接覆盖整个广告，也可以将其作为纯超链接包含在指向 App Store 的链接中。

## Implement the signed web ad impression endpoint - 实现已签名的网络广告印象接口

When a person clicks the web ad, their device generates an [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest) using the information from the web ad link. The device then sends a request to the [Get a Signed Web Ad Impression Payload](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.) endpoint with the ad-impression request in the request body.

当用户点击网络广告时，他们的设备使用来自网络广告链接的信息生成一个 [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest)。然后，设备将请求发送到[获取已签名的网络广告印象负载](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.)的接口，并在请求体中包含广告印象（ad-impression）请求。

> **Important** **重要**
>
> The device doesn’t follow an HTTP redirect when it sends the request to the [Get a Signed Web Ad Impression Payload](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.) endpoint at the attributionDestination URL.
> 
> 当设备将请求发送到 attributionDestination URL 的[获取已签名的网络广告印象负载](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.)接口时，设备不会遵循 HTTP 重定向。

On your server, implement the [Get a Signed Web Ad Impression Payload](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.) endpoint to return an [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse). For an example of the response format, see [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse).

在您的服务器上，实现[获取已签名的网络广告印象负载](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.)接口，以返回一个 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse)。有关响应格式的示例，请参阅 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse)。

For more information about generating the signature in your response, see [Generating a signature for attributable web ads](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads).

有关在响应中生成签名的更多信息，请参阅《[为可归因网络广告生成签名](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads)》。