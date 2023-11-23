# Restoring purchased products
# 恢复已购买的产品

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/restoring_purchased_products](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/restoring_purchased_products)

> Technology
>
> StoreKit

Give users functionality that restores their purchases in your app to maintain access to purchased content.

为用户提供功能，使其可以在您的应用中恢复其购买，以保持对已购买内容的访问。

## Overview - 概览

Users sometimes need to restore purchased content, such as when they upgrade to a new phone. Include some mechanism in your app, such as a Restore Purchases button, to let them restore their purchases.

用户有时需要恢复已购买的内容，例如当他们升级到新手机时。在您的应用中包含一些机制，例如“恢复购买”按钮，让用户可以恢复他们的购买。

> **Important** **重要**
>
> Don’t automatically restore purchases, especially when your app launches. Restoring purchases prompts for the user’s App Store credentials, which interrupts the flow of your app.
> 
> 不要自动恢复购买，特别是在应用启动时。恢复购买会提示用户输入他们的 App Store 凭据，这会打断您应用的流程。

In most cases, you only need to refresh the app receipt and deliver the products on the receipt. The refreshed receipt contains a record of the user’s purchases in the app, from any device the user’s App Store account is logged into. However, an app might require an alternative approach under the given circumstances:

在大多数情况下，您只需要刷新应用的收据并交付收据中的产品。刷新后的收据包含了用户在应用中的购买记录，来自用户的 App Store 账户登录的任何设备。然而，在特定情况下，应用可能需要采取其他方法：

- You use Apple-hosted content — Restore completed transactions to give your app the transaction objects it uses to download the content.
- You need to support your app on devices where the app receipt isn’t available — Restore completed transactions instead.
- Your app uses non-renewing subscriptions — Your app is responsible for the restoration process.

- 使用苹果托管内容——恢复已完成的交易，以便您的应用获取用于下载内容的交易对象。
- 需要在没有应用收据的设备上支持您的应用——恢复已完成的交易。
- 您的应用使用非续订订阅——您的应用负责恢复过程。

Refreshing a receipt doesn’t create new transactions; it requests the latest copy of the receipt from the App Store. Refresh the receipt only once; refreshing it multiple times in a row has the same result.

刷新收据不会创建新的交易；它只是从 App Store 请求最新的收据副本。只刷新一次收据即可；连续多次刷新将得到相同的结果。

Restoring completed transactions creates a new transaction for each previously completed transaction, essentially replaying history for your transaction queue observer. Your app maintains its own state to keep track of why it’s restoring completed transactions and how to handle them. Restoring multiple times creates multiple restored transactions for each completed transaction.

恢复已完成的交易会为每个先前已完成的交易创建一个新的交易，从而重新播放您的交易队列观察器的历史记录。您的应用需要维护自己的状态，以跟踪为何恢复已完成的交易以及如何处理它们。多次执行恢复操作会为每个已完成的交易创建多个恢复的交易。

> **Note** **注意**
>
> If the user attempts to purchase a product that they’ve already purchased, the App Store creates a regular transaction instead of a restore transaction, but the user isn’t charged again for the product. Unlock the content for these transactions the same way you do for original transactions.
> 
> 如果用户尝试购买他们已经购买过的产品，App Store 会创建一个常规交易而不是恢复交易，但用户不会再次被收费。解锁这些交易的内容的方式与原始交易相同。

Give the user an appropriate level of control over the content that’s downloaded again. For example, don’t automatically download three years of daily newspapers or hundreds of megabytes of game levels at the same time.

给用户适当的控制权来决定要重新下载的内容。例如，不要自动下载三年的日报或数百兆字节的游戏关卡。

## Refresh the app receipt - 刷新 App 收据

Create a receipt refresh request, set a delegate, and start the request. The request supports optional properties for obtaining receipts in various states, such as expired receipts, during testing. For details, see the [init(receiptProperties:)](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest/1506038-init) method of [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest).

创建一个收据刷新请求，设置代理并开始请求。该请求支持可选属性，用于在测试期间获取各种状态的收据，例如过期的收据。有关详细信息，请参阅 [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) 的 [init(receiptProperties:)](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest/1506038-init) 方法。

```
let refresh = SKReceiptRefreshRequest()
refresh.delegate = self
refresh.start()
```

## Restore completed transactions - 恢复已完成的交易

Your app starts restoring completed transactions by calling the [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions) method of [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue). This call sends a request to the App Store to restore all of your app’s completed transactions. If your app sets a value for the [applicationUsername](https://developer.apple.com/documentation/storekit/skmutablepayment/1506088-applicationusername) property of its payment requests, use the [restoreCompletedTransactions(withApplicationUsername:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505992-restorecompletedtransactions) method to provide the same information when restoring the transactions.

您的应用程序通过调用 [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue) 的 [restoreCompletedTransactions()](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions) 方法开始恢复已完成的交易。此调用向 App Store 发送请求，以恢复您的应用程序的所有已完成交易。如果您的应用程序为其支付请求设置了 [applicationUsername](https://developer.apple.com/documentation/storekit/skmutablepayment/1506088-applicationusername) 属性的值，请在恢复交易时使用 [restoreCompletedTransactions(withApplicationUsername:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505992-restorecompletedtransactions) 方法提供相同的信息。

The App Store generates a new transaction to restore each previously completed transaction. The restored transaction refers to the original transaction. Instances of [SKPaymentTransaction](https://developer.apple.com/documentation/storekit/skpaymenttransaction) have an [original](https://developer.apple.com/documentation/storekit/skpaymenttransaction/1411284-original) property, and the entries in the receipt have an [original_transaction_id](https://developer.apple.com/documentation/appstorereceipts/original_transaction_id) field value.

App Store 为每个先前已完成的交易生成一个新的交易来进行恢复。恢复的交易引用原始交易。[SKPaymentTransaction](https://developer.apple.com/documentation/storekit/skpaymenttransaction) 实例具有一个 [original](https://developer.apple.com/documentation/storekit/skpaymenttransaction/1411284-original) 属性，并且收据中的条目具有一个 [original_transaction_id](https://developer.apple.com/documentation/appstorereceipts/original_transaction_id) 字段值。

> **Note** **注意**
>
> The date fields have slightly different meanings for restored purchases. For details, see the `purchase_date` and `original_purchase_date` fields in the [responseBody.Receipt.In_app](https://developer.apple.com/documentation/appstorereceipts/responsebody/receipt/in_app).
> 
> 对于恢复的购买，日期字段具有稍微不同的含义。有关详细信息，请参阅 [responseBody.Receipt.In_app](https://developer.apple.com/documentation/appstorereceipts/responsebody/receipt/in_app) 中的 `purchase_date` 和 `original_purchase_date` 字段。

StoreKit calls the transaction queue observer with a status of [SKPaymentTransactionState.restored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/restored) for each restored transaction, as described in [Processing a transaction](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction). The action you take depends on your app’s design.

StoreKit 对于每个恢复的交易，会调用交易队列观察器，并将状态设置为 [SKPaymentTransactionState.restored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/restored)，如 [Processing a transaction](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction) 中所述。具体如何操作取决于您的应用程序的设计。

If your app uses the app receipt and doesn’t have Apple-hosted content, this code isn’t needed because your app doesn’t restore completed transactions. Finish any restored transactions immediately.

如果您的应用程序使用应用程序收据并且没有苹果托管内容，则不需要此代码，因为您的应用程序不会恢复已完成的交易。立即完成任何恢复的交易。

If your app uses the app receipt and has Apple-hosted content, let the user select which products to restore before starting the restoration process. During restoration, download the user-selected content before finishing those transactions, and finish any other transactions immediately.

如果您的应用程序使用应用程序收据并且有苹果托管内容，在开始恢复过程之前，让用户选择要恢复的产品。在恢复过程中，在完成这些交易之前下载用户选择的内容，并立即完成其他交易。

```
let productIDsToRestore: [String]() = <# From the user #>
let transaction: SKPaymentTransaction = <# Current transaction #>

guard let identifier = transaction.transactionIdentifier else { customError() }
if productIDsToRestore.contains(identifier) {
// Re-download the Apple-hosted content 重新下载苹果托管的内容
}

SKPaymentQueue.default().finishTransaction(transaction)
```

If your app doesn’t use the app receipt, it examines all completed transactions as it restores them. It uses a similar code path to the original purchase logic to make the product available and then finishes the transaction. Apps with more than a few products, especially products with associated content, let the user select which products to restore instead of restoring everything. These apps keep track of which completed transactions to process as they restore them, and which transactions to ignore by finishing them immediately without restoring them.

如果您的应用程序不使用应用程序收据，在恢复过程中它会检查所有已完成的交易。它使用类似于原始购买逻辑的代码路径，使产品可用，然后完成交易。拥有多个产品，特别是带有相关内容的产品的应用程序，会让用户选择要恢复的产品，而不是恢复所有产品。这些应用程序在恢复过程中跟踪要处理的已完成交易，并通过立即完成交易而不进行恢复来忽略某些交易。


# See Also - 其他参考

## Providing access to previously purchased products - 提供对先前购买的产品的访问

### class [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest)

A request to the App Store to get the app receipt, which represents the user’s transactions with your app.

向 App Store 发送请求以获取应用收据，该收据代表用户与您的应用程序的交易。

### class [SKRequest](https://developer.apple.com/documentation/storekit/skrequest)

An abstract class that represents a request to the App Store.

一个表示向App Store发送请求的抽象类。

### class [SKPaymentTransaction](https://developer.apple.com/documentation/storekit/skpaymenttransaction)

An object in the payment queue.

支付队列中的一个对象。

### func [SKTerminateForInvalidReceipt()](https://developer.apple.com/documentation/storekit/1620081-skterminateforinvalidreceipt)

Terminates an app if the license to use the app has expired.

如果应用的许可证已过期，终止应用。






