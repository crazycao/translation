# Choosing a receipt validation technique
# 选择收据验证技术

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/choosing_a_receipt_validation_technique](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/choosing_a_receipt_validation_technique)

> Technology
>
> StoreKit

Select the type of receipt validation, on the device or on your server, that works for your app.

选择适用于应用程序的收据验证类型，在设备上或在服务器上。

## Overview - 概览

> **Note** **注意**
>
> The receipt isn’t necessary if you use [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction) to validate the app download, or [Transaction](https://developer.apple.com/documentation/storekit/transaction) to validate in-app purchases. Only use the receipt if your app uses the [Original API for In-App Purchase](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase), or needs the receipt to validate the app download because it can’t use `AppTransaction`.
> 
> 如果您使用 [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction) 验证应用下载，或使用 [Transaction](https://developer.apple.com/documentation/storekit/transaction) 验证应用内购买，收据并不是必须的。只有当您的 APP 使用[原始 API](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase) 进行应用内购买时，或者因为无法使用 `AppTransaction` 而需要收据来验证应用程序下载时，才会使用收据。

An App Store receipt provides a record of the sale of an app and any purchases the person makes within the app. You can authenticate purchased content by adding receipt validation code to your app or server. Receipt validation requires an understanding of secure coding techniques to employ a solution that’s secure and unique to your app.

应用商店收据提供了应用程序的销售记录以及用户在应用程序内进行的所有购买。您可以通过向应用程序或服务器添加收据验证代码来验证购买的内容。收据验证需要了解安全编码技术，以使用安全且独特的解决方案。

## Choose a validation technique - 选择验证技术

There are two ways to verify a receipt’s authenticity:

有两种方法可以验证收据的真实性：

- Locally, on the device. Validating receipts locally requires code that reads and validates a binary file that Apple encodes and signs as a PKCS #7 container. For more information, see [Validating receipts on the device](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device).
- 在设备上本地验证。在本地验证收据需要读取和验证二进制文件的代码，该二进制文件由 Apple 编码并签名作为PKCS #7 容器。有关详细信息，请参阅《[验证设备上的收据](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device)》。

- On your server with the App Store. Validating receipts with the App Store requires secure connections between your app and your server, and between your server and the App Store. For more information, see [Validating receipts with the App Store](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store).
- 在服务器上通过 App Store 验证。使用 App Store 验证收据需要在 APP 和服务器之间以及服务器和App Store之间建立安全连接。有关详细信息，请参阅《[使用App Store验证收据](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store)》。

Compare the approaches and determine the method that best fits your app and your infrastructure. You can also choose to implement both approaches. For managing auto-renewable subscriptions, see the following table for the key advantages that server-side receipt validation provides over on-device receipt validation:

比较这些方法并确定最适合您的应用程序和基础架构的方法。您也可以选择同时实现这两种方法。对于管理自动续订订阅，请参阅下表了解服务器端收据验证相对于设备收据验证的主要优势：

|Capability|On-device validation|Server-side validation|
|:-:|:-:|:-:|
|Validates authenticity of receipt</br>验证收据的真实性|Yes|Yes|
|Includes subscription renewal transactions</br>包含续订交易|Yes|Yes|
|Includes additional subscription information</br>包含附加订阅信息|No|Yes|
|Resistant to device clock change</br>抗设备时钟变化|No|Yes|

Receipts contain non-consumable in-app purchases, auto-renewable subscriptions, and non-renewing subscriptions indefinitely. Consumable in-app purchases remain in the receipt until you call [finishTransaction(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction). You may choose to maintain and manage records of consumable in-app purchases on your server.

收据包含非消耗品的应用内购买、自动续订订阅和无限期不续订订阅。在调用 [finishTransaction(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction) 之前，消耗品的应用内购买也将保留在收据中。您可以选择在服务器上维护和管理应用内消耗品购买记录。

## Get the latest receipt - 获取最近的收据

The App Store updates receipts immediately after completed purchases. When you call [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) from your server, the App Store returns the latest transaction information, regardless of the contents of the receipt you send in the request.

App Store 在完成购买后会立即更新收据。当您从服务器调用 [verifyReceipt](https://developer.apple.com/documentation/appstorereceipts/verifyreceipt) 时，无论您在请求中发送的收据内容如何，App Store 都会返回最新的交易信息。

On the device, the system updates the receipt immediately when it has an internet connection, and any of the following occur:

在设备上，当系统连接到互联网时，以及出现以下任何情况时，系统都会立即更新收据：

- The customer completes an in-app purchase.
- 客户完成应用内购买。

- The app launches its transaction observer ([SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver)) and has unfinished transactions or subscription renewals.
- 应用程序启动了其交易观察者（[SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver)），并有未完成的交易或订阅续订。

- The app calls [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions) or [restoreCompletedTransactions(withApplicationUsername:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505992-restorecompletedtransactions) to restore transactions.
- 应用程序调用 [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions) 或 [restoreCompletedTransactions(withApplicationUsername:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505992-restorecompletedtransactions) 来还原交易。

- The app sends a request to [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) to get a receipt if the receipt is invalid or missing.
- 如果收据无效或丢失，应用程序将向 [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) 发送请求以获取收据。

Transactions can also occur at times when the app isn’t running. When necessary, call [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions) to ensure the receipt you’re working with is up-to-date. For example, if a customer purchases an auto-renewable subscription on another device, call this method to get those transactions and update the receipt.

应用程序未运行时也可能发生交易。必要时，调用 [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions) 以确保您使用的收据是最新的。例如，如果客户在其他设备上购买了自动续订订阅，请调用此方法获取这些交易并更新收据。

To ensure that your app receives all transactions, add the transaction observer, [add(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506042-add), at app launch time. For more information, see [Setting Up the Transaction Observer for the Payment Queue](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue).

为了确保您的应用程序接收所有交易，请在应用程序启动时调用 [add(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506042-add) 方法添加交易观察者。有关详细信息，请参阅《[为支付队列设置交易观察者](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue)》。

> Related Sessions from WWDC 2018
>
> Session 705: Engineering Subscriptions

# See Also - 其他参考

## Purchase Validation - 购买验证

### [Validating receipts with the App Store](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store)

Verify transactions with the App Store on a secure server.

在安全的服务器上验证与 App Store 的交易。

### var [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/bundle/1407276-appstorereceipturl): URL?

The file URL for the bundle’s App Store receipt.

包里的 App Store 收据的文件地址。

### class [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest)

A request to the App Store to get the app receipt, which represents the user’s transactions with your app.

向应用商店请求获取 APP 收据，该收据代表用户与 APP 的交易。