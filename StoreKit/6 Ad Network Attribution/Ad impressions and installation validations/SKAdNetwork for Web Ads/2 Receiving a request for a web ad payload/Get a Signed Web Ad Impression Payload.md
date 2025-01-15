# Get a Signed Web Ad Impression Payload
# 获取已签名的网络广告印象负载

原文地址：[https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.)

An endpoint you provide to receive requests from devices to serve signed ad interactions.

您提供的接口，用于接收设备请求，提供已签名的广告交互。

> SKAdNetwork for Web Ads 1.0+

## URL

```
POST https://example.com/.well-known/skadnetwork/get-signed-payload
```

## HTTP Body

- AdImpressionRequest

	- The request that devices send to this endpoint, asking for the web ad impression from the ad network’s server.
	- 设备发送到该接口的请求，请求从广告网络服务器获取网络广告印象。
	
		> Content-Type: application/json

## Response Codes

- `200`
	- OK

- AdImpressionResponse

	- The response you provide that contains a signed payload for the clicked web ad.
	- 您提供的包含对点击的网络广告签名负载的响应。

		> Content-Type: application/json

## Mentioned in

- [Creating an attributable ad link](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link)
- [Generating a signature for attributable web ads](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads)

# Discussion - 讨论

You implement this endpoint on your server to provide signed SKAdNetwork ad payloads for web ads that users tap. The device calls this endpoint when a user taps an SKAdNetwork-attributable web ad.

您在服务器上实现此接口，为用户点击的网络广告提供已签名的 SKAdNetwork 广告负载。当用户点击可归因于 SKAdNetwork 的网络广告时，设备会调用此接口。

To receive requests at this endpoint, your server needs to support the Transport Layer Security (TLS) 1.2 protocol or later.

为了在此接口接收请求，您的服务器需要支持传输层安全性（TLS）1.2 或更高版本的协议。

The following is an example of an AdImpressionRequest payload:

以下是一个 AdImpressionRequest 负载的示例：

```
{
    "source_domain": "example.com",
    "source_engagement_type": "click_to_App_Store",
    "source_nonce": "t8naKxXHTzuTJhNfljADPQ",
    "version": "4.0"
}
```

A corresponding AdImpressionResponse to send in response to this payload is as follows:

对该负载作出响应的相应 AdImpressionResponse 如下所示：

```
{
    "version": "4.0",
    "ad_network_id": "com.apple.test-1",
    "source_identifier": 3120,
    "itunes_item_id": 525463029,
    "nonce": "b7c9da2b-15c7-4f3b-9326-135f9630033d",
    "source_domain": "example.com",
    "timestamp": 1676057605705,
    "signature": "MEUCID/KZzaGxpa9jv9P1thWn8cHzcDq8ebDWEoarV1JrjNcAiEA6d9IqYErxFCrD96oR0rRftjVW6PRx37MC9QPS88OeE4="
}
```

> **Important**
>
> The `attributionSourceNonce` in a web ad, the `source_nonce` in an [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest), and the `nonce` in an [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) all represent the same UUID, but the encoding varies.
> 
> 网络广告链接中的 `attributionSourceNonce`、[AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest) 中的 `source_nonce` 和 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) 中的 `nonce` 都代表相同的 UUID，但编码方式不同。

The device uses the same encoding as `attributionSourceNonce` for the `source_nonce` value in the [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest). However, you use the dash-separated string representation of the UUID for the `nonce` value in an [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse).

设备在 [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest) 中的 `source_nonce` 值中使用与 `attributionSourceNonce` 相同的编码。然而，在 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) 中的 `nonce` 值中，您应使用 UUID 的短横线分隔的字符串表示。

# See Also - 其他参考

## Receiving a request for a web ad payload - 接收对网络广告负载的请求

### object [AdImpressionRequest](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionrequest)

The request body that devices send to fetch the web ad impression from the ad network’s server.

设备发送的用于从广告网络服务器获取网络广告印象的请求体。