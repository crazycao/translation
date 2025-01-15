# Generating a signature for attributable web ads
# 为可归因的网络广告生成签名

原文地址：[https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads](https://developer.apple.com/documentation/skadnetworkforwebads/generating-a-signature-for-attributable-web-ads)

Initiate install-validation by providing the signed parameters for an attributable web ad.

通过提供可归因的网络广告的已签名参数来启动安装验证。

# Overview - 概览

A user’s device calls the [Get a Signed Web Ad Impression Payload](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.) endpoint on your server when a user taps the web ad that you create using the instructions in [Creating an attributable ad link](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link). To respond to the request, you need to provide the values in the [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse), which includes a cryptographic signature.

当用户点击您按照《[创建可归因广告链接](https://developer.apple.com/documentation/skadnetworkforwebads/creating-an-attributable-ad-link)》中的说明创建的网络广告时，用户设备会调用您服务器上的[获取已签名的网络广告印象负载](https://developer.apple.com/documentation/skadnetworkforwebads/get-a-signed-skadnetwork-ad-payload-for-a-web-ad.)接口。为了响应该请求，您需要提供 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) 中的值，其中包括一个加密签名。

To generate the signature, combine the required values from the signature object and cryptographically sign the resulting string. Use the ad network ID and PKCS#8 private key that you establish when registering to use the API. For more information, see [Registering an ad network](https://developer.apple.com/documentation/StoreKit/registering-an-ad-network).

要生成签名，结合签名对象中的必需值，并对生成的字符串进行加密签名。使用您在注册 API 时建立的广告网络 ID 和 PKCS#8 私钥。有关更多信息，请参阅《[注册广告网络](https://developer.apple.com/documentation/StoreKit/registering-an-ad-network)》。

## Combine the parameters - 结合参数

Create the UTF-8 string using the required signature object parameters.

使用所需的签名对象参数创建 UTF-8 字符串。

> **Important** **重要**
>
> Lowercase the string representation of the nonce from the signature object. Failing to do so results in an invalid signature. Only ads with valid signatures can get ad attributions.
> 
> 请将签名对象中 `nonce` 的字符串表示转换为小写。如果未执行此操作，将导致签名无效。只有具有有效签名的广告才能获得广告归因。

Combine the values into a UTF-8 string with an invisible separator (‘`\u2063`’) between them, in the exact order the code below shows:

按照下面的代码所示的确切顺序将这些值组合到一个 UTF-8 字符串中，在它们之间使用不可见分隔符（‘`\u2063`’）：

```
version + '\u2063' + ad_network_id + '\u2063' + source_identifier + '\u2063' + itunes_item_id + '\u2063' + nonce + '\u2063' + source_domain + '\u2063' + fidelity_type + '\u2063' + timestamp
```

## Sign the combined string - 签署合并的字符串

Sign the combined UTF-8 string with the following key and algorithm:

- Your PKCS#8 private key.
- The Elliptic Curve Digital Signature Algorithm (ECDSA) with a SHA-256 hash.

使用以下密钥和算法对合并的 UTF-8 字符串进行签名：

- 您的 PKCS#8 私钥。
- 采用 SHA-256 哈希的椭圆曲线数字签名算法（ECDSA）。

The resulting Digital Encoding Rules (DER)-formatted binary value is the signature.

生成的数字编码规则（DER）格式的二进制值即为签名。

## Encode the signature - 对签名编码

Encode the binary signature you generate into a Base64 string. The result is your ad network attribution signature. The signature string should look similar to the following:

将您生成的二进制签名编码为 Base64 字符串。结果将是您的广告网络归因签名。签名字符串应类似于以下内容：

```
MEQCIEQlmZRNfYzKBSE8QnhLTIHZZZWCFgZpRqRxHss65KoFAiAJgJKjdrWdkLUOCCjuEx2RmFS7daRzSVZRVZ8RyMyUXg==
```

For more information about Base64 encoding, see [base64EncodedString(options:)](https://developer.apple.com/documentation/foundation/data/2142853-base64encodedstring).

有关Base64编码的更多信息，请参阅[base64EncodedString(options:)](https://developer.apple.com/documentation/foundation/data/2142853-base64encodedstring)。

## Use the generated signature string - 使用生成的签名字符串

After you generate the signature, use this value in the `signature` parameter of the [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse). If the user installs and launches the advertised app, the attribution-winning ad network receives an install-validation postback. For more information about postbacks, see [Verifying an install-validation postback](https://developer.apple.com/documentation/StoreKit/verifying-an-install-validation-postback).

在生成签名后，将此值用于 [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse) 的 `signature` 参数中。如果用户安装并启动了广告应用，则归因获胜的广告网络将收到安装验证回传。有关回传的更多信息，请参阅《[验证安装验证回传](https://developer.apple.com/documentation/StoreKit/verifying-an-install-validation-postback)》。

# See Also - 其他参考

## Providing the web ad signature and response - 提供网络广告签名和响应

### object [AdImpressionResponse](https://developer.apple.com/documentation/skadnetworkforwebads/adimpressionresponse)

The response you provide that contains a signed payload for a clicked web ad.

您提供的包含了一个已签名负载的响应，用于点击的网络广告。

### object [signature](https://developer.apple.com/documentation/skadnetworkforwebads/signature)

The key-value pairs that ad networks use to cryptographically sign a web ad.

广告网络用于加密签署网络广告的键-值对。