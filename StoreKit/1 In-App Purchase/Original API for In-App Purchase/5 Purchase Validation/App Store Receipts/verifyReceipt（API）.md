# verifyReceipt （Web Service 接口）【弃用】

原文地址：[https://developer.apple.com/documentation/appstorereceipts/verifyreceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt)

> App Store Receipts 1.0–1.7 Deprecated

> **Important** **重要**
>
> The [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) endpoint is deprecated. To validate receipts on your server, follow the steps in [Validating receipts on the device](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device) on your server. To validate in-app purchases on your server without using receipts, call the [App Store Server API](https://developer.apple.com/documentation/appstoreserverapi) to get Apple-signed transaction and subscription information for your customers, or verify the [App Transaction](https://developer.apple.com/documentation/storekit/apptransaction) and [Transaction](https://developer.apple.com/documentation/storekit/transaction) signed data that your app obtains. You can also get the same signed transaction and subscription information from the [App Store Server Notifications V2](https://developer.apple.com/documentation/appstoreservernotifications/app_store_server_notifications_v2).
> 
> [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) 接口已被弃用。要在您的服务器上验证收据，请在服务器上按照《[在设备上验证收据](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device)》的步骤进行操作。要在服务器上验证应用内购买而不使用收据，请调用 [App Store 服务器 API](https://developer.apple.com/documentation/appstoreserverapi) 来获取苹果签名的交易和订阅信息，或者验证您的应用程序获取的 [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction) 和 [Transaction](https://developer.apple.com/documentation/storekit/transaction) 签名数据。您还可以从 [App Store 服务器通知 V2 版](https://developer.apple.com/documentation/appstoreservernotifications/app_store_server_notifications_v2) 获取相同的签名交易和订阅信息。


# URL

**POST** `https://buy.itunes.apple.com/verifyReceipt`

# Sandbox URL
**POST** `https://sandbox.itunes.apple.com/verifyReceipt`

# HTTP Body
- requestBody
  
  The JSON contents you submit with the request. 你提交请求时的 JSON 内容。

  _Content-Type: application/json_
  
# Response Codes

- **200**
  **OK**
- responseBody

  _Content-Type: application/json_

## Discussion - 讨论

Validating with the App Store requires a secure connection between your app and your server, as well as code on your server to validate the receipt with the App Store. Submit an HTTP POST request with the contents detailed in [requestBody](https://developer.apple.com/documentation/appstorereceipts/requestbody) using the verifyReceipt endpoint to verify receipts with the App Store. Use the receipt fields in the [responseBody](https://developer.apple.com/documentation/appstorereceipts/responsebody) to validate app and in-app purchases.

通过 App Store 进行验证需要在你的应用和服务器之间建立安全连接，并在服务器上编写代码以使用 App Store 验证收据。使用 verifyReceipt 接口，提交 HTTP POST 请求与 App Store 验证收据，请求中包含在 [requestBody](https://developer.apple.com/documentation/appstorereceipts/requestbody) 中详细说明的内容。使用 [responseBody](https://developer.apple.com/documentation/appstorereceipts/responsebody) 中的收据字段来验证应用内购买和应用程序购买。

For more information about server-side receipt validation, see [Validating receipts with the App Store](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_with_the_app_store).

关于服务端收据校验的更多信息，参见《[使用 App Store 验证收据](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_with_the_app_store)》

## Use the sandbox URL for sandbox testing - 使用沙盒 URL 进行沙盒测试

The sandbox URL for verifying receipts is:

沙盒环境下用于验证收据的 URL 是：

**POST** `https://sandbox.itunes.apple.com/verifyReceipt`

> **Important** **重要**
>
> As a best practice, always call the production URL `https://buy.itunes.apple.com/verifyReceipt` first and proceed to verify with the sandbox URL if you receive a `21007` status code. Following this approach ensures that you don’t have to switch between URLs while your app is in testing, in review by App Review, or live in the App Store.
> 
> 作为最佳实践，始终首先调用生产环境的 URL `https://buy.itunes.apple.com/verifyReceipt`，并在收到 `21007` 状态码时切换到沙盒 URL 进行验证。遵循这种方法可以确保在应用处于测试、App Review 审核或在 App Store 上线时无需在 URL 之间切换。

## Find deprecation date in the HTTP header - 在 HTTP 头中查找弃用日期

The verifyReceipt endpoint is deprecated. The HTTP header includes the deprecation date, according to [RFC 8594](https://www.rfc-editor.org/rfc/rfc8594.html).

verifyReceipt 端点已经被弃用。根据 [RFC 8594](https://www.rfc-editor.org/rfc/rfc8594.html)，HTTP 头包含了弃用日期。(译者注：在 Response Header 中找到了 Deprecation =  "Mon, 5 Jun 2023 23:59:59 GMT"，是这个吗？然而我现在还能用。）

# See Also - 其他参考

## Deprecated - 弃用

### [Validating receipts with the App Store](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_with_the_app_store)
Verify transactions with the App Store on a secure server.

在安全的服务器上通过 App Store 校验交易。

### [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt)
Send a receipt to the App Store for verification.

将收据发送到 App Store 进行验证。

### object [requestBody](https://developer.apple.com/documentation/appstorereceipts/requestbody)【Deprecated】
The JSON contents you submit with the request to the App Store.

你提交给 App Store 的请求的 JSON 内容。

### object [responseBody](https://developer.apple.com/documentation/appstorereceipts/responsebody)【Deprecated】
The JSON data that returns in the response from the App Store.

从 App Store 返回的响应中的 JSON 数据。

### object error
Error information that returns in the response body when a request isn’t successful.

请求不成功时，在响应体中返回的错误信息。
