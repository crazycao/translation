# requestBody【弃用】

原文地址：[https://developer.apple.com/documentation/appstorereceipts/requestbody](https://developer.apple.com/documentation/appstorereceipts/requestbody)

> App Store Receipts 1.0–1.7 Deprecated

The JSON contents you submit with the request to the App Store.

你提交给 App Store 的请求的 JSON 内容。

> **Deprecated** **弃用**
>
> The [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) endpoint is deprecated.
> 
>  [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) 接口已弃用。

# Properties

- **receipt-data** _byte_

  **(Required)** The Base64-encoded receipt data.
  
  **（必须）** Base64 加密的收据数据。
  
- **password** _string_

  Your app’s shared secret, which is a hexadecimal string. The password is required for receipts that include subscriptions, and strongly recommended otherwise. For more information about the shared secret, see [Generate a shared secret to verify receipts](https://help.apple.com/app-store-connect/#/devf341c0f01).
  
  你的应用程序的共享密钥，它是一个十六进制字符串。对于包含订阅的收据，共享密钥是必需的；其他情况也强烈推荐使用共享密钥。有关共享密钥的更多信息，请参阅《[生成共享密钥以验证收据](https://help.apple.com/app-store-connect/#/devf341c0f01)》。

- **exclude-old-transactions** _boolean_

  Set this value to `true` for the response to include only the latest renewal transaction for any subscriptions. Use this field only for app receipts that contain auto-renewable subscriptions.
  
  将此值设置为 `true`，以便响应只包含任何订阅的最新续订交易。仅在包含自动续订订阅的应用收据中使用此字段。

## Discussion - 讨论

To receive a decoded receipt for validation, send a request with the encoded receipt data and app password to the App Store. For receipts that contain auto-renewable subscriptions, optionally include an exclusion flag. Send this JSON data using the `HTTP POST` request method.

为了接收解码后的收据进行验证，发送一个请求，包括编码后的收据数据和应用密码到 App Store。对于包含自动续订订阅的收据，可以选择性地包含一个排除标志。使用 `HTTP POST` 请求方法发送这个 JSON 数据。

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