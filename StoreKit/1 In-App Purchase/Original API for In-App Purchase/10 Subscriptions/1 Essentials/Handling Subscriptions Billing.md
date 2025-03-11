# Handling Subscriptions Billing
# 处理订阅计费

原文地址：[https://developer.apple.com/documentation/storekit/handling-subscriptions-billing?language=objc](https://developer.apple.com/documentation/storekit/handling-subscriptions-billing?language=objc)

Build logic around the date and time constraints of subscription products, while planning for all scenarios where you control access to content.

围绕订阅产品的日期和时限构建逻辑，同时针对所有你控制内容访问权限的场景做好规划。

# Overview - 概览



# Topic - 主题

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

## Product Information - 产品信息

### [Loading In-App Product Identifiers](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers?language=objc) - 加载应用内产品唯一标识符

Load the unique identifiers for your in-app products in order to retrieve product information from the App Store.

加载应用内产品的唯一标识符，以便从 App Store 检索产品信息。

### [Fetching Product Information from the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store?language=objc) - 从 App Store 获取产品信息

Retrieve up-to-date information about the products for sale in your app to display to the user.

检索要向用户显示的在 App 中的销售的产品的最新信息。

### [SKProductsRequest](https://developer.apple.com/documentation/storekit/skproductsrequest?language=objc)

An object that can retrieve localized information from the App Store about a specified list of products.

可以从 App Store 检索关于指定产品列表的本地化信息的对象。

### [SKProductsResponse](https://developer.apple.com/documentation/storekit/skproductsresponse?language=objc)

An App Store response to a request for information about a list of products.

App Store 对产品列表信息请求的响应。

### [SKProduct](https://developer.apple.com/documentation/storekit/skproduct?language=objc)

Information about a product previously registered in App Store Connect.

先前在 App Store Connect 注册的产品的信息。

## Storefronts - 店面

### [SKStorefront](https://developer.apple.com/documentation/storekit/skstorefront?language=objc)

An object containing the location and unique identifier of an Apple App Store storefront.

包含苹果应用商店店面位置和唯一标识符的对象。

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

## Purchase Validation - 购买验证

### [Choosing a Receipt Validation Technique](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/choosing_a_receipt_validation_technique?language=objc) - 选择收据验证技术

Select the type of receipt validation that works for your app.

选择适用于应用程序的收据验证类型。

### [Validating Receipts with the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/validating_receipts_with_the_app_store?language=objc) - 通过 App Store 验证收据

Verify transactions with the App Store on a secure server.

在安全服务器上验证与 App Store 的交易。

### [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/nsbundle/1407276-appstorereceipturl?language=objc)

The file URL for the bundle’s App Store receipt.

应用包的 App Store 收据的文件 URL。

[SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest?language=objc)

A request to refresh the receipt, which represents the user's transactions with your app.

刷新收据的请求，该收据代表用户与应用程序的交易。

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

## Refunds - 退款

### [Handling Refund Notifications](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/handling_refund_notifications?language=objc) - 处理退款通知

Respond to notifications created during customer refunds for consumable, non-consumable, and non-renewing subscription products.

响应用户退款期间针对消耗类、非消耗类和非续费订阅类产品创建的通知。

## Providing Access to Previously Purchased Products - 提供对以前购买的产品的访问

### [Restoring Purchased Products](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/restoring_purchased_products?language=objc) - 恢复购买的产品

Give users functionality that restores their purchases in your app, to maintain access to purchased content.

为用户提供在应用程序中恢复其购买的功能，以保持对购买内容的访问。

### [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest?language=objc)

A request to refresh the receipt, which represents the user's transactions with your app.

刷新收据的请求，该收据代表用户与应用程序的交易。

### [SKRequest](https://developer.apple.com/documentation/storekit/skrequest?language=objc)

An abstract class that represents a request to the App Store.

表示对应用商店的请求的抽象类。

### [SKPaymentTransaction](https://developer.apple.com/documentation/storekit/skpaymenttransaction?language=objc)

An object in the payment queue.

支付队列中的对象。

### [SKTerminateForInvalidReceipt](https://developer.apple.com/documentation/storekit/1620081-skterminateforinvalidreceipt?language=objc)

Terminates an app if the license to use the app has expired.

如果应用的使用许可证已过期，则终止该应用。

## Family Sharing - 家庭共享

### [Supporting Family Sharing in Your App](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/supporting_family_sharing_in_your_app?language=objc) - 在应用程序中支持家庭共享

Provide service to share subscriptions and non-consumable products to family members.

向家庭成员提供订阅类和非消费类产品共享服务。

### [isFamilyShareable](https://developer.apple.com/documentation/storekit/skproduct/3564805-isfamilyshareable?language=objc)

A Boolean value that indicates whether the product is available for family sharing in App Store Connect.

一个布尔值，指出产品是否可用于 App Store Connect 中的家庭共享。

### [- paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue?language=objc)

Tells an observer that the user is no longer entitled to one or more family-shared purchases.

告诉观察者用户不再拥有对一个或多个家庭共享的购买的权限。

## Subscriptions - 订阅

### [Subscriptions and Offers](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/subscriptions_and_offers?language=objc) - 订阅和优惠

Offer users additional time-based content and services through purchases made within your app.

通过在应用程序中进行购买，为用户提供额外的基于时间的内容和服务。

## Promotions - 推广

### [Promoting In-App Purchases](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/promoting_in-app_purchases?language=objc) - 推广应用内购买

Show your in-app purchases on your app's product page.

在应用程序的产品页面上显示应用内购买的内容。

### [Testing Promoted In-App Purchases](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/testing_promoted_in-app_purchases?language=objc) - 测试推广的应用内购买

Test your in-app purchases before making your app available in the App Store.

在 App Store 中提供应用程序之前，测试你的应用内购买。

### [SKProductStorePromotionController](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller?language=objc)

A product promotion controller for customizing the order and visibility of in-app purchases per device.

产品推广控制器，用于定制每台设备的应用内购买的顺序和可见性。

## Testing In-App Purchases - 测试应用内购买

### [Testing at All Stages of Development with Xcode and Sandbox](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_sandbox?language=objc) - 使用 Xcode 和 Sandbox 在开发的所有阶段进行测试

Verify your implementation of in-app purchases by testing your code throughout its development.

通过在开发过程中测试代码，验证应用内购买的实现。

### [Setting Up StoreKit Testing in Xcode](https://developer.apple.com/documentation/xcode/setting-up-storekit-testing-in-xcode?language=objc) - 在 Xcode 中设置 StoreKit 测试

Set up your test environment to test in-app purchases with data you configure locally.

设置测试环境，使用本地配置的数据测试应用内购买。

### [Testing In-App Purchases in Xcode](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/testing_in-app_purchases_in_xcode?language=objc) - 在 Xcode 中测试应用内购买

Test and debug your in-app purchases implementation using product data you configure locally.

使用本地配置的产品数据测试和调试应用内购买实现。

### [Testing In-App Purchases with Sandbox](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in-app_purchases_with_sandbox?language=objc) - 用 Sandbox 测试应用内购买

Test your implementation of in-app purchases using real product information and server-to-server transactions in the sandbox environment.

在沙盒环境中，使用真实的产品信息和服务器到服务器的事务来测试应用内购买的实现。

## Errors - 错误

### [Handling Errors](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/handling_errors?language=objc) - 处理错误

Handle errors resulting from StoreKit requests.

处理由 StoreKit 请求导致的错误。

### [SKErrorCode](https://developer.apple.com/documentation/storekit/skerrorcode?language=objc)

Error codes for StoreKit errors.

StoreKit 错误的错误代码。

### [SKErrorDomain](https://developer.apple.com/documentation/storekit/skerrordomain?language=objc)

The error domain name for StoreKit errors.

StoreKit 错误的错误域名。

# See Also - 其他参考

## In-App Purchase - 应用内购买

### [Choosing a StoreKit API for In-App Purchase](https://developer.apple.com/documentation/storekit/choosing_a_storekit_api_for_in-app_purchase?language=objc) - 选择应用内购买的 StoreKit API

Use the latest API to support in-app purchases in your new or existing app, or the original API for an existing app.

使用最新的API支持在新应用或现有应用中的应用内购买，或在现有应用中使用原始API。

### [In-App Purchase](https://developer.apple.com/documentation/storekit/in-app_purchase?language=objc)

Offer users additional content and services by using a modern Swift-based interface.

使用基于 Swift 的现代界面，向用户提供更多的内容和服务。

### [Original API for In-App Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase?language=objc)

Offer users additional content and services using the original In-App Purchase API.

使用原始的应用内购买 API，向用户提供更多的内容和服务。
