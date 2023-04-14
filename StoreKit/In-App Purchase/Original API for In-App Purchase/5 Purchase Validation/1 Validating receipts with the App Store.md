# Validating receipts with the App Store
# 使用 App Store 验证收据

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store)

> Technology
>
> StoreKit

Verify transactions with the App Store on a secure server.

在安全的服务器上使用 App Store 验证交易。

## Overview - 概览

An App Store receipt is a binary encrypted file signed with an Apple certificate. In order to read the contents of the encrypted file, you need to pass it through the [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) endpoint. The endpoint’s response includes a readable JSON body. Communication with the App Store is structured as JSON dictionaries, as defined in RFC 4627. Binary data is Base64-encoded, as defined in RFC 4648. Validate receipts with the App Store through a secure server. For information on establishing a secure network connection with the App Store, see [Preventing Insecure Network Connections](https://developer.apple.com/documentation/security/preventing_insecure_network_connections).

App Store 收据是用 Apple 证书签名的二进制加密文件。为了读取加密文件的内容，需要将其传递给 [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) 端点。端点的响应包括一个可读的 JSON 体。如 RFC 4627 中所定义，与 App Store 的通信结构为 JSON 字典。二进制数据是 Base64 编码的，如 RFC 4648 中所定义。通过安全服务器使用 App Store 验证收据。有关与 App Store 建立安全网络连接的信息，请参阅《[防止不安全网络连接](https://developer.apple.com/documentation/security/preventing_insecure_network_connections)》。

> **Warning** **警告**
>
> Don’t call the App Store server `verifyReceipt` endpoint from your app. You can’t build a trusted connection between a user’s device and the App Store directly, because you don’t control either end of that connection, which makes it susceptible to a machine-in-the-middle attack.
> 
> 不要从应用程序调用 App Store 服务器 `verifyReceipt` 端点。你无法直接在用户的设备和 App Store 之间建立可信连接，因为你无法控制连接的任何一端，这使得它容易受到中间机器的攻击。

## Fetch the receipt data - 获取收据数据

The app receipt is always present in the production environment on devices running macOS, iOS, and iPadOS. The app receipt is also always present in TestFlight on devices running macOS. In the sandbox environment and in StoreKit Testing in Xcode, the app receipt is present only after the tester makes the first in-app purchase. If the app calls [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) or [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions), the app receipt is present only if the app has at least one in-app purchase.

在运行 macOS、iOS 和 iPadOS 的设备上，应用收据始终显示在生产环境中。在运行 macOS 的设备上，应用收据也始终显示在 TestFlight 中。在沙盒环境和 Xcode 中的 StoreKit 测试中，只有在测试人员进行第一次应用内购买后，才会出现应用收据。如果应用程序调用 [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) 或[restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions)，则仅当应用程序至少有一次应用内购买时，才会显示应用程序收据。

To retrieve the receipt data from the app on the device, use the [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/bundle/1407276-appstorereceipturl) method of [NSBundle](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSBundle/Description.html#//apple_ref/occ/cl/NSBundle) to locate the app’s receipt, and encode the data in Base64. Send this Base64-encoded data to your server.

要从设备上的应用程序检索收据数据，请使用 [NSBundle](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSBundle/Description.html#//apple_ref/occ/cl/NSBundle) 的 [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/bundle/1407276-appstorereceipturl) 方法定位应用程序的收据，并将数据按 Base64 编码。将此 Base64 编码数据发送到服务器。

```
// Get the receipt if it's available.
if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
    FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

    do {
        let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
        print(receiptData)

        let receiptString = receiptData.base64EncodedString(options: [])

        // Read receiptData.
    }
    catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
}
```

## Send the receipt data to the app store - 将收据数据发送到应用商店

On your server, create a JSON object with the `receipt-data`, `password`, and `exclude-old-transactions` keys detailed in [requestBody](https://developer.apple.com/documentation/appstorereceipts/requestbody).

在服务器上，创建一个JSON对象，并添加 `receipt-data`、`password` 和 `exclude-old-transactions` 三个键，如  [requestBody](https://developer.apple.com/documentation/appstorereceipts/requestbody) 中描述的。

Submit this JSON object as the payload of an HTTP POST request. Use the test environment URL `https://sandbox.itunes.apple.com/verifyReceipt` when testing your app in the sandbox and while your application is in review. Use the production URL `https://buy.itunes.apple.com/verifyReceipt` when your app is live in the App Store. For more information on these endpoints, see [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt).

提交此 JSON 对象作为 HTTP POST 请求的有效负载。在沙盒中测试应用程序时，以及在审核应用程序时使用测试环境 URL：https://sandbox.itunes.apple.com/verifyReceipt。当您的应用程序在 App Store 中运行时，使用生产 URL：`https://buy.itunes.apple.com/verifyReceipt`。有关这些端点的更多信息，请参阅 [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt)。

> **Important** **重要**
>
> Verify your receipt first with the production URL; then verify with the sandbox URL if you receive a `21007` status code. This approach ensures you don’t have to switch between URLs while your application is tested, reviewed by App Review, or live in the App Store.
> 
> 首先使用生产 URL 验证收据；如果收到 `21007` 状态代码再使用沙盒 URL 验证。这种方法可以确保在应用程序测试、App Review 审核或在 App Store 中运行时，您不必在URL之间切换。

## Parse the response - 解析响应

The App Store’s response payload is a JSON object that contains the keys and values detailed in [responseBody](https://developer.apple.com/documentation/appstorereceipts/responsebody).

App Store的响应负载是一个 JSON 对象，包含 [responseBody](https://developer.apple.com/documentation/appstorereceipts/responsebody) 中详细描述的键和值。

The `in_app` array contains the non-consumable, non-renewing subscription, and auto-renewable subscription items previously purchased by the user. Check the values in the response for these in-app purchase types to verify transactions as needed.

`in_app` 数组中包含用户以前购买的非消耗品、不可续订和自动续订订阅项目。检查响应中这些应用内购买类型的值，以根据需要验证交易。

For auto-renewable subscription items, parse the response to get information about the currently active subscription period. When you validate the receipt for a subscription, `latest_receipt` contains the latest encoded receipt, which is the same as the value for receipt-data in the request, and `latest_receipt_info` contains all the transactions for the subscription, including the initial purchase and subsequent renewals but not including any restores.

对于自动续订订阅项目，分析响应以获取有关当前活动订阅期的信息。验证订阅的收据时，`latest_receipt` 包含最新编码的收据，该收据与请求中收据数据的值相同，`latest_receipt_info` 包含订阅的所有事务，包括初始购买和后续续订，但不包括任何恢复。

You can use these values to check whether an auto-renewable subscription has expired. Use these values along with the `expiration_intent` subscription field to get the reason for expiration.

您可以使用这些值检查自动续订订阅是否已过期。将这些值与 `expiration_intent` 订阅字段一起使用以获取过期原因。


# See Also

## Purchase Validation - 购买校验

### [Choosing a receipt validation technique](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/choosing_a_receipt_validation_technique) - 选择一种收据校验技术

Select the type of receipt validation, on the device or on your server, that works for your app.

在设备或服务器上选择适用于应用程序的收据验证类型。

### var [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/bundle/1407276-appstorereceipturl): URL?

The file URL for the bundle’s App Store receipt.

包里的 App Store 收据文件 URL。

### class [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest)

A request to the App Store to get the app receipt, which represents the user’s transactions with your app.

向应用商店请求获取应用收据，该收据代表用户与应用的交易。

## Related Documentation

### App Store Receipts - App Store 收据

Validate app and in-app purchase receipts with the App Store.

通过 App Store 校验应用程序和应用内购买收据。







