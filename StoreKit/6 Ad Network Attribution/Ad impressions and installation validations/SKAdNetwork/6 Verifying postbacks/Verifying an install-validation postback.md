# Verifying an install-validation postback
# 验证安装验证回传

原文地址：[https://developer.apple.com/documentation/StoreKit/verifying-an-install-validation-postback](https://developer.apple.com/documentation/StoreKit/verifying-an-install-validation-postback)

Ensure the validity of a postback you receive after an ad conversion by verifying its cryptographic signature.

通过验证其加密签名，确保您在广告转化后收到的回传数据的有效性。

# Overview - 概览

Install-validation postbacks contain data that validate an ad conversion. You need to verify the postback signature to make sure it’s signed by Apple before you count the conversion. Follow these steps to validate the postback:

1. Receive the postback at a URL you configure.
2. Respond to the postback when you receive it.
3. Check the postback version.
4. Recreate the byte array from the postback parameters in the version-specific order.
5. Verify Apple’s signature.
6. Count only unique postbacks with signatures you verify. For version 3 and later, check the `did-win` parameter to learn whether the postback represents a winning attribution.

安装验证回传中包含用来验证广告转化的数据。在计算转化之前，您需要验证回传的签名确保它是由苹果签名的。按照以下步骤验证回传：

1. 在您配置的 URL 上接收回传数据。
2. 收到回传后进行回应。
3. 检查回传版本。
4. 根据特定版本的顺序从回传参数重新创建字节数组。
5. 验证苹果的签名。
6. 仅对您验证过签名的唯一回传数据计数。对于版本 3 及更高版本，请检查 `did-win` 参数以了解回传是否代表获胜的归因。

## Receive the postback - 接收回传

Devices send install-validation postbacks to ad networks and developers within a defined timeframe after a user installs and launches an advertised app. Ad networks receive postbacks at the URL they provide when they register to use SKAdNetwork. Developers who opt in receive copies of winning postbacks at the URL they configure in the app’s property list key, `doc://com.apple.documentation/documentation/bundleresources/information_property_list/nsadvertisingattributionreportendpoint`. For more information about setting up your postback URL, see [Registering an ad network](https://developer.apple.com/documentation/storekit/registering-an-ad-network) and [Configuring an advertised app](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app).

设备在用户安装和启动广告应用程序后的指定时间范围内向广告网络和开发人员发送安装验证回传数据。广告网络在注册 SKAdNetwork 时提供的 URL 上接收回传数据。选择接收回传数据的开发人员在应用程序的属性列表键中配置的 URL 上接收获胜回传数据的副本，`doc://com.apple.documentation/documentation/bundleresources/information_property_list/nsadvertisingattributionreportendpoint`。有关设置回传 URL 的更多信息，请参阅《[注册广告网络](https://developer.apple.com/documentation/storekit/registering-an-ad-network)》和《[配置广告程序](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app)》。

For more information about the timeframe for receiving attribution, see [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks). Starting with version 4, you may receive postbacks in three conversion windows. For more information, see [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows).

有关接收归因的时间范围的更多信息，请参阅《[接收广告归因和回传数据](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)》。从版本 4 开始，您可能会在三个转化窗口中接收回传数据。有关更多信息，请参阅《[在多个转化窗口中接收回传数据](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows)》。

## Respond to the postback - 响应回传数据

When you receive a postback, respond with an HTTP status code `200 OK`. If the device doesn’t receive the `200` status code, it attempts to send the postback up to nine times over a maximum of 9 days.

当您收到回传数据时，请以 HTTP 状态码 `200 OK` 做出回应。如果设备未收到 `200` 状态码，则会在最多 9 天内最多尝试发送回传数据达 9 次。

## Check the postback version number - 检查回传数据的版本号

Postbacks contain a `version` parameter, starting with SKAdNetwork 2. Use the version number to follow the version-specific instructions for verifying a postback signature. For a description of all the parameters in a postback, see [Identifying the parameters in install-validation postbacks](https://developer.apple.com/documentation/storekit/identifying-the-parameters-in-install-validation-postbacks).

从 SKAdNetwork 2 开始，回传数据包含一个 `version` 参数。根据版本号按照特定版本的说明来验证回传数据签名。有关回传数据中所有参数的描述，请参阅《[识别安装验证回传数据中的参数](https://developer.apple.com/documentation/storekit/identifying-the-parameters-in-install-validation-postbacks)》。

The postback version you receive depends on the version number the ad network uses to sign the ad, the iOS version on the device, and the SDK version that the source app uses. Expect to receive the same version number in the postback as the ad network uses to sign the ad if the device runs the latest iOS version, and the source app uses the latest SDK. For more information about version dependencies, see [SKAdNetwork release notes](https://developer.apple.com/documentation/storekit/skadnetwork-release-notes). For more information about signing, see [Signing and providing ads](https://developer.apple.com/documentation/storekit/signing-and-providing-ads).

您收到的回传数据版本取决于广告网络用于签署广告的版本号、设备上运行的 iOS 版本以及源应用使用的 SDK 版本。如果设备运行最新的 iOS 版本，源应用使用最新的 SDK，则预计会收到与广告网络用于签署广告相同的版本号。有关版本依赖性的更多信息，请参阅《[SKAdNetwork 发行说明](https://developer.apple.com/documentation/storekit/skadnetwork-release-notes)》。有关签名的更多信息，请参阅《[签署和提供广告](https://developer.apple.com/documentation/storekit/signing-and-providing-ads)》。

## Recreate the byte array from the postback parameters - 根据回传参数重新创建字节数组

To confirm that Apple sent the postback request, you need to verify Apple’s signature in the postback’s `attribution-signature` parameter. First, decode the signature with Apple’s public key. Next, compare the decoded signature to a byte array that you recreate using the postback parameters. To create the byte array, build a UTF-8 string by combining the parameter values with invisible separators, ‘`\u2063`’, in an exact version-specific order.

为了确认苹果发送了回传请求，您需要验证回传数据的 `attribution-signature` 参数中的苹果签名。首先，使用苹果的公钥解码签名。接下来，将解码后的签名与使用回传参数重新创建的字节数组进行比较。要创建字节数组，请按照精确版本特定的顺序将参数值与不可见分隔符 '`\u2063`' 组合成一个 UTF-8 字符串。

Use the version-specific instructions that correspond to the postback’s version:

- For version 3-specific instructions and postback examples, see [Combining parameters for SKAdNetwork 3 postbacks](https://developer.apple.com/documentation/storekit/combining-parameters-for-skadnetwork-3-postbacks).
- For earlier versions, see [Combining parameters for previous SKAdNetwork postback versions](https://developer.apple.com/documentation/storekit/combining-parameters-for-previous-skadnetwork-postback-versions).



根据回传的版本使用相应的版本特定说明：

- 对于版本 3 的特定说明和回传示例，请参阅《[为 SKAdNetwork 3 回传组合参数](https://developer.apple.com/documentation/storekit/combining-parameters-for-skadnetwork-3-postbacks)》。
- 对于早期版本，请参阅《[为以前的 SKAdNetwork 回传版本组合参数](https://developer.apple.com/documentation/storekit/combining-parameters-for-previous-skadnetwork-postback-versions)》。

For a version 4 postback, combine the postback parameter values in this order:

对于版本 4 的回传，请按照以下顺序组合回传参数值：

- `version`
- `ad-network-id`
- `source-identifier```
- `app-id`
- `transaction-id`
- `redownload` (Use the strings “`true`” or “`false`” to represent the Boolean value of the redownload parameter)（使用字符串“`true`”或“`false`”表示重新下载参数的布尔值）
- `source-app-id` (or `source-domain` for web ads)（或 Web 广告的 `source-domain`） 
- `fidelity-type`
- `did-win`
- `postback-sequence-index`

For web ads, the postback may include a `source-domain` instead of a `source-app-id`.

对于 Web 广告，回传可能包括 `source-domain`，而不是 `source-app-id`。

The combined string doesn’t include all of the postback parameters. Include `source-app-id` only if you receive it in the postback. The signature doesn’t include `conversion-value` or `coarse-conversion-value`, even if either is present in the postback. Postbacks that win the attribution have a `did-win` value of `true`. Postbacks that don’t win the attribution have a `did-win` value of `false`, and don’t include `source-app-id`.

组合字符串不会包括所有回传参数。仅在回传中收到 `source-app-id` 时才包括它。签名不包括 `conversion-value` 或 `coarse-conversion-value`，即使其中一个存在于在回传中。获胜归因的回传 `did-win` 值为 `true`。未赢得归因的回传数据 `did-win` 值为 `false`，并且不包括 `source-app-id`。

The following example of the UTF-8 string includes `source-app-id`:

以下是包含 `source-app-id` 的 UTF-8 字符串示例：

```
version + '\u2063' + ad-network-id + '\u2063' + source-identifier + '\u2063' + app-id + '\u2063' + transaction-id + '\u2063' + redownload + '\u2063' + source-app-id + '\u2063' + fidelity-type + '\u2063' + did-win + '\u2063' + postback-sequence-index
```

The following example of the UTF-8 string for a web ad includes `source-domain`:

以下是包含 `source-domain` 的用于 Web 广告的 UTF-8 字符串示例：

```
version + '\u2063' + ad-network-id + '\u2063' + source-identifier + '\u2063' + app-id + '\u2063' + transaction-id + '\u2063' + redownload + '\u2063' + source-domain + '\u2063' + fidelity-type + '\u2063' + did-win + '\u2063' + postback-sequence-index
```

The following example is a first postback from a web ad, in a high postback data tier. Notice that the `source-identifier` contains four digits, and the postback contains the fine-grained `conversion-value`.

以下示例是来自 Web 广告的第一个回传数据，在高回传数据层级中。请注意，`source-identifier` 包含四位数字，并且回传数据包含精细的 `conversion-value`。

```
{
  "version": "4.0",
  "ad-network-id": "com.example",
  "source-identifier": "5239",
  "app-id": 525463029,
  "transaction-id": "6aafb7a5-0170-41b5-bbe4-fe71dedf1e30",
  "redownload": false,
  "source-domain": "example.com", 
  "fidelity-type": 1, 
  "did-win": true,
  "conversion-value": 63,
  "postback-sequence-index": 0,
  "attribution-signature": "MEUCIGRmSMrqedNu6uaHyhVcifs118R5z/AB6cvRaKrRRHWRAiEAv96ne3dKQ5kJpbsfk4eYiePmrZUU6sQmo+7zfP/1Bxo="
}
```

The following example is a first postback that results from a web ad, in a low postback data tier. Notice that the `source-identifier` contains two digits, and the postback includes a `coarse-conversion-value`.

以下示例是来自 Web 广告的第一个回传数据，在低回传层级中。请注意，`source-identifier` 包含两位数字，并且回传包含 `coarse-conversion-value`。

```
{
  "version": "4.0",
  "ad-network-id": "com.example",
  "source-identifier": "39",
  "app-id": 525463029,
  "transaction-id": "6aafb7a5-0170-41b5-bbe4-fe71dedf1e31",
  "redownload": false,
  "source-domain": "example.com", 
  "fidelity-type": 1, 
  "did-win": true,
  "coarse-conversion-value": "high",
  "postback-sequence-index": 0,
  "attribution-signature": "MEUCIQD4rX6eh38qEhuUKHdap345UbmlzA7KEZ1bhWZuYM8MJwIgMnyiiZe6heabDkGwOaKBYrUXQhKtF3P/ERHqkR/XpuA="
}
```

The `attribution-signature` value in both examples is a verified signature. Use the parameter values and signature in the examples to test your code. For more information about the postback data tiers and the parameters available in each tier, see [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows).

这两个示例中的 `attribution-signature` 值是经过验证的签名。使用示例中的参数值和签名来测试您的代码。有关回传层级以及每个层级中可用参数的更多信息，请参阅《[在多个转化窗口中接收回传](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows)》。

## Verify Apple’s signature - 验证苹果的签名

Copy Apple’s public key, below, which you need for the remaining steps. Apple’s NIST P-256 public key that you use to verify signatures for versions 2.1 and later is:

复制下面的苹果公钥，您需要它来进行剩余的步骤。苹果的 NIST P-256 公钥如下，用于验证 2.1 及更高版本的签名：

```
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEWdp8GPcGqmhgzEFj9Z2nSpQVddayaPe4FMzqM9wib1+aHaaIzoHoLN9zW4K8y4SPykE3YVK3sVqW6Af0lfx3gg==
```

To verify a signature for version 1 or 2, get the version-appropriate public key from SKAdNetwork release notes.

要验证版本 1 或 2 的签名，请从 SKAdNetwork 发布说明中获取适用于该版本的公钥。

Then, complete these steps:

1. Decode Apple’s public key, which appears as a Base64-encoded string above. The result is a byte array.
2. Create an X.509 standard public key from the byte array.
3. Decode Apple’s signature string value from its Base64 format.
4. Verify Apple’s signed value from the attribution-signature parameter in the postback against the UTF-8 string you create by combining the postback parameters. Use Apple’s public key and a SHA-256 hash using the Elliptic Curve Digital Signature Algorithm (ECDSA).

然后，完成以下步骤：

1. 解码苹果的公钥，它出现为上面的 Base64 编码字符串。结果将是一个字节数组。
2. 从字节数组创建一个 X.509 标准公钥。
3. 从其 Base64 格式中解码苹果签名字符串值。
4. 使用椭圆曲线数字签名算法（ECDSA）和 SHA-256 哈希，将苹果的签名值与您通过合并回传参数创建的 UTF-8 字符串进行验证。

If your verification passes, the postback is valid.

如果您的验证通过，那么回传是有效的。

> **Important** **重要**
>
> If the `attribution-signature` fails your verification, consider the postback message invalid. Don’t use it to count a conversion.
> 
> 如果 `attribution-signature` 未通过您的验证，请认定回传消息无效。不要将其用于计算转化。

For version 3 and later, valid postbacks with a did-win value of true represent an ad attribution.

对于版本 3 及更高版本，用带有 `did-win` 值为 `true` 的有效回传代表广告归因。

## Count unique messages only - 仅计算唯一消息

Use the `transaction-id` value to ensure you’re counting unique ad conversions. If you receive more than one ad-conversion message with the same `transaction-id`, discard the duplicate message.

使用 `transaction-id` 值来确保您只计算唯一的广告转化。如果您收到具有相同 `transaction-id` 的多条广告转化消息，请丢弃重复的消息。

## Receive a postback during testing - 在测试过程中接收回传

In test scenarios, the postback always contains the `source-app-id` and `conversion-value` parameters with values of `0`. To trigger test scenarios, use a development-signed source app with an [SKStoreProductParameterAdNetworkSourceAppStoreIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteradnetworksourceappstoreidentifier) value equal to `0`.

在测试场景中，回传始终包含 `source-app-id` 和 `conversion-value` 参数，其值为 `0`。要触发测试场景，请使用一个由开发人员签名的源应用，其 [SKStoreProductParameterAdNetworkSourceAppStoreIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteradnetworksourceappstoreidentifier) 值等于 `0`。


# Topics - 主题

## SKAdNetworks 3 and earlier postbacks - SKAdNetworks 3 和更早的回传

### [Combining parameters for SKAdNetwork 3 postbacks](https://developer.apple.com/documentation/storekit/combining-parameters-for-skadnetwork-3-postbacks) - SKAdNetwork 3 回传的组成参数

Recreate the byte array for version 3 postbacks that win and don’t win attribution.

重新创建版本 3 回传的字节数组，以区分获胜和未获胜的归因。

### Combining parameters for previous SKAdNetwork postback versions - 更早 SKAdNetwork 版本的组成参数

Recreate the byte array for versions 2.2 or earlier.

重新创建版本 2.2 或更早的字节数组。

# See Also - 其他参考

## Verifying postbacks - 验证回传

### [Identifying the parameters in install-validation postbacks](https://developer.apple.com/documentation/storekit/identifying-the-parameters-in-install-validation-postbacks) - 识别安装验证回传数据中的参数

Learn about the postback parameters in all SKAdNetwork versions.

学习所有 SKAdNetwork 版本中的回传参数。