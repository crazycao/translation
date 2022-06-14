# Requesting a Payment from the App Store
# 请求从 App Store 付款

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/requesting_a_payment_from_the_app_store](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/requesting_a_payment_from_the_app_store)

> Technology
>
> StoreKit

Submit a payment request to the App Store when a user selects a product to buy.

当用户选择要购买的产品时，向 App Store 提交付款请求。

# Overview - 概览

After you present your app's store UI, users can make purchases from within your app. When the user chooses a product, your app creates and submits a payment request to the App Store.

在你展示你的 App 的商店 UI 后，用户可以在 App 内进行购买。当用户选择某一产品时，你的 App 将创建付款请求并将其提交给 App Store。

Implementing an in-app purchase flow can be divided into three stages. In the first stage, your app retrieves product information. Then your app requests payment when the user selects a product in your app's store. Finally, your app delivers the products. This article details the steps performed by your app and the App Store in the second stage, as highlighted in Figure 1.

实施应用内购买流程可分为三个阶段。在第一阶段，应用程序检索产品信息。然后，当用户在应用程序的商店中选择产品时，应用程序请求付款。最后，你的应用程序提供产品。本文详细介绍了你的应用程序和 App Store 在第二阶段执行的步骤，如图1所示。

**Figure 1** Continue the purchase process by requesting a payment from the App Store

**图1** 通过请求从 App Store 付款来继续购买过程

![A flow chart depicting the steps of the in-app purchase process. The payment request stage is diagrammed as two steps between your app and the App Store. After the user selects a product in your app and the App Store, your app makes a payment request.](https://docs-assets.developer.apple.com/published/3bfebc5bf1/IAPPG-migration-2@2x.png)

## Create a Payment Request - 创建付款请求

When the user selects a product to buy, create a payment request using the corresponding `SKProduct` object and set the quantity if needed, as shown below. The product object comes from the array of products returned by your app’s products request, as discussed in [Fetching Product Information from the App Store](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store).

当用户选择要购买的产品时，使用相应的 `SKProduct` 对象创建付款请求，并根据需要设置数量，如下所示。产品对象来自于 App 的产品请求返回的产品列表，如《[从 App Store 获取产品信息](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store)》中所述。

```
// Use the corresponding SKProduct object returned in the array from SKProductsRequest.
// 使用 SKProductsRequest 返回的列表中相应的 SKProduct 对象
let payment = SKMutablePayment(product: product)
payment.quantity = 2
```

## Submit a Payment Request - 提交付款请求

Submit your payment request to the App Store by adding it to the payment queue. If you add a payment object to the queue more than once, it's submitted to the App Store multiple times, charging the user and requiring your app to deliver the product each time.

通过将其添加到支付队列来提交你的付款请求。如果你向队列中添加了好几次付款对象，它就会被多次提交给 App Store，而每次都会向用户收费并要求你的 App 交付产品。

```
SKPaymentQueue.default().add(payment)
```

For every payment request your app submits, it receives a corresponding transaction to process. For more information about transactions and the payment queue, see [Processing a Transaction](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction).

对于你的 App 提交的每个付款请求，都会收到相应的待处理交易。关于交易和支付队列的更多信息，参见《[处理交易](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction)》

For auto-renewable subscriptions, you may submit a payment request with a subscription offer for users you determine eligible to receive an offer. For more information, see [Implementing Promotional Offers in Your App](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_promotional_offers_in_your_app).

对于自动续费订阅，你可以为确定有资格接收优惠的用户提交带有订阅优惠的付款请求。更多信息，参见《[在你的 App 中实现促销优惠](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_promotional_offers_in_your_app)》。


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
