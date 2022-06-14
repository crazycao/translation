# Processing a Transaction
# 处理交易

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction)

> Technology
>
> StoreKit

Register a transaction queue observer to get and handle transaction updates from the App Store.

注册交易队列观察者以从 App Store 获取和处理交易更新。

# Overview - 概览

Implementing an in-app purchase flow can be divided into three stages. You first retrieve the product information, then send a payment request by adding it to the payment queue. Finally, your app delivers the products for successful transactions. This article details the steps performed by your app and the App Store in the last stage, as highlighted in Figure 1.

实施应用内购买流程可分为三个阶段。您首先检索产品信息，然后通过将其添加到支付队列来发送付款请求。最后，您的应用程序为成功的交易提供产品。本文详细介绍了应用程序和 App Store 在最后一个阶段执行的步骤，如图1所示。

The App Store calls the transaction queue observer after it processes the payment request. Your app then records information about the purchase for future launches, downloads the purchased content, and marks the transaction as finished.

App Store 在处理付款请求后调用交易队列观察者。然后，你的应用程序会记录有关购买的信息以备将来发布、下载购买的内容，并将交易标记为完成。

**Figure 1** Complete the purchase process by monitoring the transaction queue to deliver products 

**图1** 通过监视交易队列以交付产品来完成购买流程

![A flow chart depicting the steps of the in-app purchase process. The delivering content stage is diagrammed as three steps between your app and the App Store. First, the App Store processes the payment; next, the App Store calls your app's transaction queue observer; and finally, your app delivers the purchased product.](https://docs-assets.developer.apple.com/published/5f67d2690b/IAPPG-migration-1@2x.png)

## Monitor Transactions in the Queue - 在队列中监视交易

The transaction queue plays a central role in letting your app communicate with the App Store through the StoreKit framework. You add work to the queue that the App Store needs to act on, such as a payment request to be processed. When the transaction’s state changes, such as when a payment request succeeds, StoreKit calls the app’s transaction queue observer. You decide which class acts as the observer. In very small apps, you could handle all the StoreKit logic in the app delegate, including observing the transaction queue. In most apps, however, you create a separate class that handles this observer logic along with the rest of your app’s store logic. The observer must conform to the [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) protocol.

交易队列在让您的应用程序通过 StoreKit 框架与 App Store 通信方面起着核心作用。您将工作添加到 App Store 需要处理的队列中，例如待处理的付款请求。当交易状态发生变化时，例如付款请求成功时，StoreKit 会调用应用程序的交易队列观察者。由您来决定哪个类作为观察者。在非常小的应用程序中，您可以在 app delegate 中处理所有 StoreKit 逻辑，包括观察事务队列。然而，在大多数应用程序中，您会创建一个单独的类来处理此观察者逻辑以及应用程序的其余存储逻辑。观察者必须遵守 [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) 协议。

By adding an observer, your app does not need to constantly poll the status of its active transactions. Your app uses the transaction queue for payment requests, to download Apple-hosted content, and to find out that subscriptions have been renewed.

通过添加观察者，您的应用程序无需不断轮询其活跃交易的状态。你的应用程序使用交易队列进行支付请求，下载苹果托管的内容，以及发现订阅已续费。

Always register a transaction queue observer as soon as your app is launched, as shown below. For more guidance, see [Setting Up the Transaction Observer for the Payment Queue](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue).

请始终在应用程序启动后立即注册事务队列观察者，如下所示。有关更多指导，请参阅《[设置支付队列的交易观察者](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue)》。

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    /* ... */
    SKPaymentQueue.default().add(observer)
    return true
}
```

Make sure that the observer is ready to handle a transaction at any time, not only after you add a transaction to the queue. For example, if a user buys something in your app right before going into a tunnel, your app may not be able to deliver the purchased content if there is no network connection. The next time your app launches, StoreKit calls your transaction queue observer again and your app should handle the transaction and deliver the purchased content. Similarly, if your app fails to mark a transaction as finished, StoreKit calls the observer every time your app launches until the transaction finishes.

确保观察者随时准备好处理事务，而不仅仅是在将事务添加到队列之后。例如，如果用户在进入隧道之前在你的应用程序中购买了某些内容，如果隧道里没有网络，那么你的应用程序可能无法交付购买的内容。下次应用程序启动时，StoreKit 会再次调用您的交易队列观察者，您的应用程序应该处理交易并交付购买的内容。同样，如果应用程序未能将事务标记为已完成，则 StoreKit 会在每次应用程序启动时调用观察者，直到事务完成。

Implement the [paymentQueue(_:updatedTransactions:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue) method on your transaction queue observer. StoreKit calls this method when the status of a transaction changes, such as when a payment request has been processed. The transaction status tells you what action your app needs to perform, as described in Table 1.

在您的交易队列观察者上实现 [paymentQueue(_:updatedTransactions:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue) 方法。当交易状态发生更改时，例如付款请求已经被处理时，StoreKit 会调用此方法。交易状态告诉您应用程序需要执行什么操作，如表1所述。

**Table 1** Transaction statuses and corresponding actions 

**表1** 交易状态和相应动作

|Status</br>状态|Action to take in your app</br>在你的app内采取的动作|
|:-:|:-:|
|SKPaymentTransactionState.purchasing|Update your UI to reflect the in-progress status, and wait to be called again.</br>更新UI以反映进行中状态，并等待再次调用。|
|SKPaymentTransactionState.deferred|Update your UI to reflect the deferred status, and wait to be called again.</br>更新UI以反映延迟状态，并等待再次调用。|
|SKPaymentTransactionState.failed|Use the value of the `error` property to present a message to the user. For a list of error constants, see [SKErrorDomain](https://developer.apple.com/documentation/storekit/skerrordomain).</br>使用 `error` 属性的值向用户显示消息。有关错误常量的列表，请参阅 [SKErrorDomain](https://developer.apple.com/documentation/storekit/skerrordomain)。|
|SKPaymentTransactionState.purchased|Provide the purchased functionality, typically by unlocking features or delivering content.</br>通常通过解锁功能或交付内容来提供购买的功能。|
|SKPaymentTransactionState.restored|Restore the previously purchased functionality.</br>恢复先前购买的功能。|

Transactions in the queue can change state in any order. Your app needs to be ready to work on any active transaction at any time. Act on every transaction according to its transaction state, as in this example:

队列中的交易可以按任何顺序更改状态。您的应用程序需要随时准备好处理任何活跃的交易。根据每个交易的交易状态对其进行操作，如下例所示：

```
func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
     for transaction in transactions {
     switch transaction.transactionState {
          // Call the appropriate custom method for the transaction state.
     case .purchasing: showTransactionAsInProgress(transaction, deferred: false)
     case .deferred: showTransactionAsInProgress(transaction, deferred: true)
     case .failed: failedTransaction(transaction)
          case .purchased: completeTransaction(transaction)
     case .restored: restoreTransaction(transaction)
          // For debugging purposes.
     @unknown default: print("Unexpected transaction state \(transaction.transactionState)")
    }
     }
}
```

## Update the App's UI to Reflect Transaction Changes - 更新 App 的 UI 以反映交易变化

To keep your user interface up to date while waiting, the transaction queue observer can implement optional methods from the [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) protocol as follows:

为了在等待时保持最新的用户界面，交易队列观察者可以从 [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) 协议中实现如下可选方法：

- StoreKit calls the [paymentQueue(_:removedTransactions:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1505994-paymentqueue) method when it removes transactions from the queue. In your implementation of this method, remove the corresponding items from your app’s UI.
- StoreKit calls the [paymentQueueRestoreCompletedTransactionsFinished(_:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506101-paymentqueuerestorecompletedtran) or [paymentQueue(_:restoreCompletedTransactionsFailedWithError:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506063-paymentqueue) methods when it finishes restoring transactions, depending on whether there was an error. In your implementation of these methods, update your app’s UI to reflect the success or failure.

- StoreKit 从队列中删除交易时，会调用 [paymentQueue(_:removedTransactions:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1505994-paymentqueue) 方法。在这个方法的实现中，请从 app 的 UI 中删除相应的项目。
- StoreKit 完成恢复交易操作时，根据是否出错，会调用 [paymentQueueRestoreCompletedTransactionsFinished(_:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506101-paymentqueuerestorecompletedtran) 或 [paymentQueue(_:restoreCompletedTransactionsFailedWithError:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506063-paymentqueue) 方法。在这些方法的实现中，请更新你 app 的 UI 以反映成功或者失败。

For successfully processed transactions, your app should validate the receipt associated with the transaction to verify the items purchased by the user and unlock content accordingly. For more information on validating receipts server-side, see [Validating Receipts with the App Store](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store).

对于成功处理的交易，您的 App 应该验证与交易关联的收据，以验证用户购买的项目并相应的解锁内容。有关服务端验证收据的更多信息，请参阅《[通过 App Store 验证收据](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/validating_receipts_with_the_app_store)》。


# See Also - 其他参考

## Purchases - 购买

### [Requesting a Payment from the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/requesting_a_payment_from_the_app_store?language=objc) - 请求从 App Store 付款

Submit a payment request to the App Store when a user selects a product to buy.

当用户选择要购买的产品时，向 App Store 提交付款请求。

### [Processing a Transaction](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/processing_a_transaction?language=objc) - 处理交易

Register a transaction queue observer to get and handle transaction updates from the App Store.

注册交易队列观察者以从 App Store 获取和处理交易更新。

### [SKPayment](https://developer.apple.com/documentation/storekit/skpayment?language=objc)

A request to the App Store to process payment for additional functionality offered by your app.

向 App Store 发出的请求，用于处理对应用提供的附加功能的付款。

### [SKMutablePayment](https://developer.apple.com/documentation/storekit/skmutablepayment?language=objc)

A mutable request to the App Store to process payment for additional functionality offered by your app.

向 App Store 发出的一个可变请求，用于处理对应用提供的附加功能的付款。

### [SKPaymentTransaction](https://developer.apple.com/documentation/storekit/skpaymenttransaction?language=objc)

An object in the payment queue.

支付队列中的对象。
