# responseBody【弃用】

原文地址：[https://developer.apple.com/documentation/appstorereceipts/responsebody](https://developer.apple.com/documentation/appstorereceipts/responsebody)

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
- **environment** _string_

	The environment the system generates the receipt for.
  
	系统生成收据的环境。
	
	 _Possible Values: Sandbox, Production_
  
- **is_retryable** _boolean_

	An indicator when an error occurs during the request. A value of 1 indicates a temporary issue; retry validation for this receipt at a later time. A value of 0 indicates an unresolvable issue; don’t retry validation for this receipt. This is applicable only to status codes 21100–21199.
	
	在请求过程中发生错误时的指示器。值为 1 表示临时问题；稍后再尝试验证该收据。值为 0 表示无法解决的问题；不要再次尝试验证该收据。这仅适用于状态码 21100-21199。

- **latest_receipt** _byte_

	The latest Base64-encoded app receipt. This only returns for receipts that contain auto-renewable subscriptions.
	
	最新的 Base64 编码的应用收据。这仅适用于包含自动续订订阅的收据。

- **latest_receipt_info** _[responseBody.Latest_receipt_info]_

	An array that contains all in-app purchase transactions. This excludes transactions for consumable products that your app marks as finished.
	
	一个包含所有应用内购买交易的数组。但不包括您的应用标记为已完成的可消耗产品的交易。
	
- **pending_renewal_info** _[responseBody.Pending_renewal_info]_

	In the JSON file, an array where each element contains the pending renewal information for each auto-renewable subscription the product_id identifies. This only returns for app receipts that contain auto-renewable subscriptions.
	
	在 JSON 文件中，存在一个数组，其中每个元素包含由 product_id 标识的每个自动续订订阅的待续订信息。这仅适用于包含自动续订订阅的应用程序收据。
	
- **receipt** _responseBody.Receipt_

	A JSON representation of the receipt that you send for verification.
	
	一个用于验证的收据的JSON表示形式。
	
- **status** _status_

	Either 0 if the receipt is valid, or a status code if there’s an error. The status code reflects the status of the app receipt as a whole. See [status](https://developer.apple.com/documentation/appstorereceipts/status) for possible status codes and descriptions.
	
	如果收据有效，则为 0；如果存在错误，则为状态码。状态码反映了整个应用程序收据的状态。请参阅《[状态](https://developer.apple.com/documentation/appstorereceipts/status)》以获取可能的状态码和描述。

## Discussion - 讨论

The [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) endpoint returns this response.

[verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) 接口返回这个响应。

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