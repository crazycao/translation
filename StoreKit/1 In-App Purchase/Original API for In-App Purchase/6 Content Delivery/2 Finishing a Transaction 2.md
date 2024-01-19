# Finishing a Transaction
# 完成交易

原文地址：[https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/finishing_a_transaction](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/finishing_a_transaction)

> Technology
>
> StoreKit

Finish the transaction to complete the purchase process.

完成交易以完成购买流程。

# Overview - 概览

Finishing a transaction tells StoreKit that everything needed for the purchase is complete. Unfinished transactions remain in the queue until they’re finished, so you should add the transaction queue observer every time your app is launched, to enable your app to finish the transactions. Your app must finish every transaction, regardless of whether it succeeded or failed.

完成交易后，StoreKit 会知道购买所需的一切都已完成。未完成的事务会一直保留在队列中，直到它们完成，因此每次启动应用程序时，都应该添加事务队列观察者，以使应用程序能够完成事务。你的应用程序必须完成每一笔交易，不管它是成功还是失败。

Do all of the following before you finish a transaction:

在完成交易前，请执行以下所有操作：

- Persist the purchase.
- Download associated content.
- Update your app’s UI so the user can access the product.

- 持久化购买。
- 下载相关联的内容。
- 更新 App 的 UI，以便用户访问产品。

To finish the transaction, call the [finishTransaction(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction) method on the payment queue.

要完成交易，请在支付队列上调用 [finishTransaction(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction) 方法。

```
let transaction: SKPaymentTransaction = <# The current transaction #>
SKPaymentQueue.default().finishTransaction(transaction)
```

After you finish a transaction, don’t take any actions on it or do any work to deliver the product. If any work remains, your app isn’t ready to finish the transaction.

完成交易后，不要对其采取任何操作，也不要做任何交付产品的工作。如果还有工作要做，那就说明你的应用程序还没有准备好完成交易。

> **Important** **重要**
> 
> Don't try to call the [finishTransaction(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction) method before the transaction is actually completed and attempt to use some other mechanism in your app to track the transaction as unfinished. StoreKit isn’t designed to be used this way, and doing so prevents your app from downloading Apple-hosted content and can lead to other issues.
> 
> 在某个交易实际上已完成之前，不要尝试调用  [finishTransaction(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction) 方法；也请不要尝试使用 app 中的其他机制来将该交易作为未完成的状态来跟踪。StoreKit 的设计目的不是这样，这样做会阻止你的应用下载苹果托管的内容，并可能导致其他问题。

# See Also - 其他参考

## Content Delivery - 内容交付

### [Unlocking Purchased Content](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/unlocking_purchased_content?language=objc) - 解锁已购买的内容

Deliver content to the user after validating the purchase.

在验证购买后向用户交付内容。

### [Persisting a Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/persisting_a_purchase?language=objc) - 持久化购买

Keep a persistent record of a purchase to continue making the product available as needed.

保留一份购买的永久记录，使得产品在需要时继续可用。

### [Finishing a Transaction](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/finishing_a_transaction?language=objc) - 完成交易

Finish the transaction to complete the purchase process.

完成交易以完成购买流程。

### [SKDownload](https://developer.apple.com/documentation/storekit/skdownload?language=objc)

Downloadable content associated with a product.

与产品关联的可下载内容。
