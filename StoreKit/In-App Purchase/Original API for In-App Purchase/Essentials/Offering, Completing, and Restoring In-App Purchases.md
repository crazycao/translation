# Offering, Completing, and Restoring In-App Purchases
# 提供、完成和恢复应用内购买

原文地址：[https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/offering_completing_and_restoring_in-app_purchases?language=objc](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/offering_completing_and_restoring_in-app_purchases?language=objc)

> Technology
>
> StoreKit

Fetch, complete, and restore transactions in your app.

在你的应用程序中获取、完成和恢复交易。

# Overview - 概览

In-App Purchase allows users to purchase virtual goods within your app or directly from the App Store using the StoreKit framework. This sample code demonstrates how to retrieve, display, and restore in-app purchases. First, you set up your app to register and use a single-transaction queue observer at launch. The transaction queue observer manages all payment transactions and handles all transactions states. Confirm that it’s a shared instance of a custom class that conforms to the [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver?language=objc) protocol. Then, remove the transaction observer when the system is about to terminate the app. See [Setting Up the Transaction Observer for the Payment Queue](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue?language=objc) for more information.

应用内购买允许用户在应用内购买虚拟商品，或使用 StoreKit 框架直接从应用商店购买虚拟商品。此示例代码演示了如何检索、显示和恢复应用程序内的购买。首先，你将应用程序设置为在启动时注册并使用单个交易队列观察者。交易队列观察者管理所有支付交易，并处理所有交易状态。确认自定义类的共享实例符合 [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver?language=objc) 协议。然后，当系统即将终止应用程序时，移除交易观察者。更多有关信息，请参阅《[设置支付队列的交易观察者](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue?language=objc)》。

This sample, which builds the `InAppPurchases` app, supports the iOS, macOS, and tvOS platforms. After launching, InAppPurchases queries the App Store about product identifiers saved in the `Products.plist` file. InAppPurchases updates its UI with the App Store’s response, which may include available products for sale, unrecognized product identifiers, or both. The app also displays all available purchased and restored payment transactions in its UI.

此示例构建了一个名为 `InAppPurchases` 的应用程序，支持 iOS、macOS 和 tvOS 平台。启动后，`InAppPurchases` 会向应用商店查询产品中保存在 `Products.plist` 文件中的产品标识符。`InAppPurchases` 根据应用商店的响应更新其用户界面，其中可能包括可供销售的产品、无法识别的产品标识符，或两者兼而有之。该应用还在其用户界面中显示所有可用的已购买的和已恢复的支付交易。

## Configure the Sample Code Project - 配置示例代码工程

Before you can run and test this sample, you need to:

1. Start with a completed app that supports in-app purchases and has some in-app purchases configured in App Store Connect. See steps 1 and 2 of [Workflow for configuring in-app purchases](https://help.apple.com/app-store-connect/#/devb57be10e7) for more information.
2. Create a sandbox test user account in the App Store Connect. See [Create a sandbox tester account](https://help.apple.com/app-store-connect/#/dev8b997bee1) for details.
3. Open this sample in Xcode, select the target that you wish to build, then change its `bundle ID` to one that supports in-app purchase. Next, select the right team to let Xcode automatically manage your provisioning profile. See [Assign a project to a team](https://help.apple.com/xcode/mac/current/#/dev23aab79b4) for details.
4. Open the `ProductIds.plist` file in the sample and update its content with your existing in-app purchases’ product IDs.
5. For iOS and tvOS devices, build and run the `InAppPurchases` and `InAppPurchasestvOS` targets, respectively, which the sample uses to build `InAppPurchases`. Read [If a code signing error occurs](https://help.apple.com/xcode/mac/current/#/dev01865b392) if you’re running into any code-signing issues.
6. For macOS, before building the `InAppPurchasesmacOS` target, sign out of the Mac App Store. Build the target, then launch the resulting app from the Finder the first time to obtain a receipt. See [Testing at All Stages of Development with Xcode and Sandbox](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_sandbox?language=objc) for details.
7. The `InAppPurchases` app queries the App Store about the product identifiers contained in `ProductIds.plist` upon launching. When successful, it displays a list of products available for sale in the App Store. Tap any product in that list to purchase it. When prompted to authenticate the purchase, use your test user account created in step 2. When the product requests fails, see [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers?language=objc)’ discussion for various reasons why the App Store may return invalid product identifiers.

>

在运行和测试该示例之前，你需要：

1. 首先，需要一个支持应用内购买的完整应用程序，并在 App Store Connect 中配置了一些应用内购买。更多信息请参阅《[配置应用内购买的工作流](https://help.apple.com/app-store-connect/#/devb57be10e7)》中的步骤1和2。
2. 在 App Store Connect 中创建沙盒测试用户帐户。详情参阅《[创建沙盒测试人员帐户](https://help.apple.com/app-store-connect/#/dev8b997bee1)》。
3. 在 Xcode 中打开此示例，选择要构建的目标，然后将其 `bundle ID` 更改为支持应用内购买的ID。接下来，选择正确的团队，让 Xcode 自动管理描述的描述文件。详情参阅《[将项目分配给团队](https://help.apple.com/xcode/mac/current/#/dev23aab79b4)》。
4. 打开示例中的 `ProductIds.plist` 文件，并将其内容更新为你现有的应用内购买的产品ID。
5. 对于 iOS 和 tvOS 设备，分别构建和运行 `InAppPurchases` 和 `InAppPurchasestvOS` 目标，示例会使用它们来构建 `InAppPurchases` 程序。如果遇到任何代码签名问题，请阅读《[如果发生代码签名错误](https://help.apple.com/xcode/mac/current/#/dev01865b392)》。
6. 对于 macOS，在构建 `InAppPurchasesmacOS` 目标之前，请退出 Mac应用商店。构建目标，然后第一次从 Finder 启动生成的应用程序来获取收据。详情参阅《[使用 Xcode 和 Sandbox 在开发的所有阶段进行测试](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_sandbox?language=objc)》。
7. `InAppPurchases` 程序在启动后向应用商店查询  `ProductIds.plist` 中包含的产品标识符。如果查询成功，它会显示应用商店中的可供销售的产品列表。点击列表中的任意产品即可购买。当提示验证购买时，请使用在步骤2中创建的测试用户帐户。当产品请求失败时，请参阅 [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers?language=objc) 的讨论，了解应用商店可能返回无效产品标识符的各种原因。

## Display Available Products for Sale with Localized Pricing - 以本地化定价展示可供销售的产品

The sample configures the app so it confirms that the user is authorized to make payments on the device, before presenting products for sale.

该示例对应用程序进行了配置，以便在展示产品供销售之前确认用户有权在设备上付款。

```
var isAuthorizedForPayments: Bool {
    return SKPaymentQueue.canMakePayments()
}
```

Once the app confirms authorization, it sends a products request to the App Store to fetch localized product information from the App Store. Querying the App Store ensures that the app only presents users with products available for purchase. The app initializes the products request with a list of product identifiers associated with products that it wishes to sell in its UI. See [Product ID](https://help.apple.com/app-store-connect/#/dev84b80958f) for more information. Be sure to keep a strong reference to the products request object; the system may release it before the request completes.

一旦应用程序确认了授权，它就会向应用商店发送产品请求，从应用商店获取本地化的产品信息。向应用商店查询可确保应用仅向用户提供可供购买的产品。应用程序使用产品标识符列表来初始化产品请求，这些产品标识符关联这想要在其用户界面上销售的产品。更多信息请参阅《[产品ID](https://help.apple.com/app-store-connect/#/dev84b80958f)》。确保强引用产品请求对象；系统可能会在请求完成之前释放它。

```
fileprivate func fetchProducts(matchingIdentifiers identifiers: [String]) {
    // Create a set for the product identifiers. 
    // 创建一个产品标识符的集合。
    let productIdentifiers = Set(identifiers)
    
    // Initialize the product request with the above identifiers. 
    // 使用上面的标识符初始化产品请求。
    productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productRequest.delegate = self
    
    // Send the request to the App Store.
    // 把请求发送给 App Store
    productRequest.start()
}
```

The App Store responds to the products request with an [SKProductsResponse](https://developer.apple.com/documentation/storekit/skproductsresponse?language=objc) object. Its [products](https://developer.apple.com/documentation/storekit/skproductsresponse/1506047-products?language=objc) property contains information about all the products that are actually available for purchase in the App Store. The app uses this property to update its UI. The response’s [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers?language=objc) property includes all product identifiers that weren’t recognized by the App Store. See the [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers?language=objc)’ discussion for various reasons why the App Store may return invalid product identifiers.

应用商店使用 [SKProductsResponse](https://developer.apple.com/documentation/storekit/skproductsresponse?language=objc) 对象响应产品请求。其 [products](https://developer.apple.com/documentation/storekit/skproductsresponse/1506047-products?language=objc) 属性包含应用商店中实际可供购买的所有产品的信息。应用程序使用此属性更新其UI。响应的 [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers?language=objc) 属性包含了应用商店无法识别的所有产品标识符。有关应用商店可能返回无效产品标识符的各种原因，请参阅 [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers?language=objc) 的讨论。

```
// products contains products whose identifiers have been recognized by the App Store. As such, they can be purchased.
// products 包含了已经被 App Store 识别了标识符的所有产品。因此，它们可以被购买。
if !response.products.isEmpty {
    availableProducts = response.products
}

// invalidProductIdentifiers contains all product identifiers not recognized by the App Store.
// invalidProductIdentifiers 包含了所有不可被 App Store 识别的产品。
if !response.invalidProductIdentifiers.isEmpty {
    invalidProductIdentifiers = response.invalidProductIdentifiers
}
```
To display the price of a product in the UI, use the locale and currency returned by the App Store. For instance, consider a user who is logged into the French App Store and their device uses the United States locale. When attempting to purchase a product, the App Store displays the product’s price in euros. Thus, converting and showing the product’s price in U.S. dollars to match the device’s locale in the UI would be incorrect.

要在 UI 中显示产品的价格，请使用从 App Store 返回的区域设置和货币。例如，假设有一些登录到法国应用程序商店的用户，他们的设备使用美国区域设置。当尝试购买产品时，应用商店会以欧元显示产品的价格。因此，在 UI 中转换和显示产品的美元价格以匹配设备的区域设置是不正确的。

```
extension SKProduct {
    /// - returns: The cost of the product formatted in the local currency.
    /// 返回：以当地货币格式化的产品价格。
    var regularPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}
```

## Interact with the App to Purchase Products - 从 App 到 购买的产品之间的交互

Tap any product available for sale in the UI to purchase it. The app allows users to restore non-consumable products and auto-renewable subscriptions. Use the `Restore` button and `Settings` >` Restore all restorable purchases` to implement this feature in the iOS and tvOS version of the app, respectively. Select the `Store` > `Restore` menu item to restore purchases in the macOS version of the app. Tapping any purchased item brings up purchase information such as product identifier, transaction identifier, and transaction date. When the purchased item is a hosted product, the purchase information additionally includes its content identifier, content version, and content length. When the purchase is a restored one, the purchase information also contains its original transaction’s identifier and date.

点击 UI 中可供销售的任意产品即可购买。该应用允许用户恢复非消费品和自动续费订阅。在 iOS 和 tvOS 版本的应用程序中分别使用 `Restore` 按钮和 `Settings` >` Restore all restorable purchases` 实现了此功能。在 macOS 版本的应用程序中选择 `Store` > `Restore` 菜单项以恢复购买。点击任意购买项都会显示购买信息，如产品标识符、交易标识符和交易日期。当购买的商品是托管产品时，购买信息还包括其内容标识符、内容版本和内容长度。当购买项是一个已恢复的购买时，购买信息还包含其原始交易的标识符和日期。

## Handle Payment Transaction States - 处理购买交易状态

When a transaction is pending in the payment queue, StoreKit notifies the app’s transaction observer by calling its [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) method. Every transaction has five possible states, including [SKPaymentTransactionStatePurchasing](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchasing?language=objc), [SKPaymentTransactionStatePurchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc), [SKPaymentTransactionStateFailed](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatefailed?language=objc), [SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc), and [SKPaymentTransactionStateDeferred](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatedeferred?language=objc); see [SKPaymentTransactionState](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate?language=objc) for more information. Apps should make sure that their observer’s [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) can respond to any of these states at any time. They should implement the [paymentQueue:updatedDownloads:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506073-paymentqueue?language=objc) method on their observer when providing products hosted by Apple.

当交易在支付队列中挂起时，StoreKit 通过调用其 [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) 方法通知应用程序的交易观察者。每笔交易都有五种可能的状态，包括 [正在购买](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchasing?language=objc)、[已购买](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc)、[交易失败](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatefailed?language=objc)、[已恢复](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc) 和[等待确认](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatedeferred?language=objc)；更多相关信息，请参阅 [SKPaymentTransactionState](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate?language=objc)。应用程序应该确保其观察者的  [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) 方法可以在任何时候响应这些状态。在提供苹果托管的产品时，他们应该在自己的观察者上实现 [paymentQueue:updatedDownloads:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506073-paymentqueue?language=objc) 方法。

```
func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
        switch transaction.transactionState {
        case .purchasing: break
        // Do not block the UI. Allow the user to continue using the app.
        // 不要阻塞 UI。允许用户继续使用 app。
        case .deferred: print(Messages.deferred)
        // The purchase was successful.
        // 购买成功。
        case .purchased: handlePurchased(transaction)
        // The transaction failed.
        // 交易失败。
        case .failed: handleFailed(transaction)
        // There're restored products.
        // 这是已恢复的产品。
        case .restored: handleRestored(transaction)
        @unknown default: fatalError(Messages.unknownPaymentTransaction)
        }
    }
}
```

When a transaction fails, inspect its [error](https://developer.apple.com/documentation/storekit/skpaymenttransaction/1411269-error?language=objc) property to determine what happened. Only display errors whose code is different from [paymentCancelled](https://developer.apple.com/documentation/storekit/skerror/2330537-paymentcancelled?language=objc).

当交易失败时，检查其 [error](https://developer.apple.com/documentation/storekit/skpaymenttransaction/1411269-error?language=objc) 属性以确定发生了什么。仅显示错误码不是 [paymentCancelled](https://developer.apple.com/documentation/storekit/skerror/2330537-paymentcancelled?language=objc) 的错误。

```
// Do not send any notifications when the user cancels the purchase.
// 当用户取消购买时，不要发送任何通知。
if (transaction.error as? SKError)?.code != .paymentCancelled {
    DispatchQueue.main.async {
        self.delegate?.storeObserverDidReceiveMessage(message)
    }
}
```

When the user defers a transaction, apps should allow them to continue using the UI while waiting for StoreKit to update the transaction.

当用户推迟交易时，应用程序应允许他们在等待 StoreKit 更新交易时继续使用 UI。

## Restore Completed Purchases - 恢复已完成的购买

When users purchase non-consumables, auto-renewable subscriptions, or non-renewing subscriptions, they expect them to be available on all their devices and indefinitely. See [Original API for In-App Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase?language=objc) for more information. The app provides a UI that allows users to restore their past purchases.

当用户购买非消耗品、自动续费订阅或非续费订阅时，他们希望它们可以在所有设备上无限期地使用。有关更多信息，请参阅《[应用内购买的原始API](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase?language=objc)》。该应用程序提供了一个用户界面，允许用户恢复过去的购买。

```
@IBAction func restore(_ sender: UIBarButtonItem) {
    // Calls StoreObserver to restore all restorable purchases.
    // 调用 StoreObserver 恢复所有可以恢复的购买。
    StoreObserver.shared.restore()
}
```

Use [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue?language=objc)’s [restoreCompletedTransactions](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions?language=objc) to restore non-consumables and auto-renewable subscriptions. StoreKit notifies the app’s transaction observer by calling [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) with a transaction state of [SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc) for each restored transaction. If restoring fails, see [restoreCompletedTransactions](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions?language=objc)’ discussion for details on how to resolve it. Restoring non-renewing subscriptions isn’t within the scope of this sample.

使用 [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue?language=objc) 的 [restoreCompletedTransactions](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions?language=objc) 恢复非消耗品和自动续费订阅。StoreKit 通过调用 [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) 通知应用程序的交易观察者，每个已还原的交易的交易状态为 [SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc)。如果恢复失败，请参阅 [restoreCompletedTransactions](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506123-restorecompletedtransactions?language=objc) 的讨论，了解如何解决该问题的详细信息。还原非续订订阅不在本示例的范围内。

## Provide Content and Finish the Transaction - 提供内容并完成交易

Apps must deliver the content or unlock the purchased functionality after receiving a transaction whose state is [SKPaymentTransactionStatePurchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc) or [SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc) . These states indicate that the App Store has received a payment for a product from the user. When the purchased product includes hosted content from the App Store, call [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue?language=objc) [startDownloads:](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505998-startdownloads?language=objc) to download the content.

在收到状态为 [SKPaymentTransactionStatePurchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc) 或 [SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc) 的交易后，应用程序必须交付内容或解锁购买的功能。这些状态表示应用商店已收到用户对产品的付款。当购买的产品包含应用商店的托管内容时，调用 [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue?language=objc) 的 [startDownloads:](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505998-startdownloads?language=objc) 方法下载内容。

Unfinished transactions stay in the payment queue. StoreKit calls the app’s persistent observer’s [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) every time upon launching or resuming from the background until the app finishes these transactions. As a result, the App Store may repeatedly prompt users to authenticate their purchases or prevent them from purchasing products from the app.

未完成的交易留在付款队列中。StoreKit 会在每次启动或从后台恢复时调用应用程序的持久观察者的 [paymentQueue:updatedTransactions:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506107-paymentqueue?language=objc) 方法，直到应用程序完成这些事务。因此，App Store 可能会反复提示用户验证他们购买的产品，或阻止他们从 App 购买产品。

Call [finishTransaction:](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction?language=objc) on transactions whose state is [SKPaymentTransactionStateFailed](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatefailed?language=objc), [SKPaymentTransactionStatePurchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc), or [SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc) to remove them from the queue. Finished transactions aren’t recoverable. Therefore, apps must provide the purchased content, download all Apple-hosted content of a product, or complete their purchase process before finishing transactions.

对状态为 [SKPaymentTransactionStateFailed](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatefailed?language=objc)、[SKPaymentTransactionStatePurchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc) 或[SKPaymentTransactionStateRestored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstaterestored?language=objc) 的交易调用 [finishTransaction:](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction?language=objc) 方法，将其从队列中删除。已完成的交易无法重新获得。因此，应用程序必须在完成交易之前提供购买的内容，下载产品的所有苹果托管内容，或者完成购买过程。

```
// Finish the successful transaction.
// 完成成功的交易。
SKPaymentQueue.default().finishTransaction(transaction)
```

# See Also - 其他参考

## Essentials - 要素

### [Setting Up the Transaction Observer for the Payment Queue](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue?language=objc) - 设置支付队列的交易观察者

Enable your app to receive and handle transactions by adding an observer.

通过添加观察者，使应用程序能够接收和处理事务。

### [Offering, Completing, and Restoring In-App Purchases](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/offering_completing_and_restoring_in-app_purchases?language=objc) - 提供、完成和恢复应用内购买

Fetch, complete, and restore transactions in your app.

在你的应用程序中获取、完成和恢复交易。

### [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue?language=objc)

A queue of payment transactions to be processed by the App Store.

App Store 要处理的支付交易队列。

### [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver?language=objc)

A set of methods that process transactions, unlock purchased functionality, and continue promoted in-app purchases.

一组处理交易、解锁购买功能和继续推广应用内购买的方法。

### [SKPaymentQueueDelegate](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc)

The protocol implemented to provide information needed to complete transactions.

为提供完成交易所需的信息而实现的协议。

### [SKRequest](https://developer.apple.com/documentation/storekit/skrequest?language=objc)

An abstract class that represents a request to the App Store.

表示对 App Store 的请求的抽象类。
