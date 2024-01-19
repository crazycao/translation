# Supporting Family Sharing in your app
# 支持应用程序中的家庭共享

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/supporting_family_sharing_in_your_app](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/supporting_family_sharing_in_your_app)

> Technology
>
> StoreKit

Provide service to share subscriptions and non-consumable products to family members.

提供服务，将订阅和非消耗品共享给家庭成员。

## Overview - 概览

Family Sharing allows a user to share access to auto-renewable subscriptions or non-consumables with up to five family members on all of their Apple devices. Enabling Family Sharing for a subscription can make your content or service more appealing to subscribers, and may encourage conversion to a paid subscription, increase user engagement, and improve retention. Developers can choose to turn on Family Sharing for in-app purchases and non-consumables in App Store Connect. Users can also choose whether to share their purchases with family.

家庭共享允许用户在所有苹果设备上与最多五名家庭成员共享自动续费订阅或非消耗型商品。为订阅启用家庭共享可以使您的内容或服务对订阅用户更有吸引力，并可能鼓励转换为付费订阅，提高用户参与度，提高留存率。开发者可以选择在 App Store Connect 中打开应用内购买和非消耗型商品的家庭共享。用户也可以选择是否与家人分享他们购买的物品。

When users share a purchase through Family Sharing, each family member gets their own unique receipts and transactions. Process the transactions in the same way you already handle purchases — you don’t need any special logic for shared products. However, you do need to implement a new method in your transaction observer, and listen for a new notification type in server notifications. Specifically, to support Family Sharing, you need to:

当用户通过家庭共享分享购买时，每个家庭成员都会获得自己独特的收据和交易。您可以像处理其他购买一样处理这些交易，无需特殊逻辑来处理共享产品。但是，您确实需要在事务观察器中实现一个新方法，并在服务器通知中侦听新的通知类型。具体来说，要支持家庭共享，您需要：

- Enable Family Sharing for your in-app purchases in App Store Connect. For more information, see [Turn on Family Sharing for in-app purchases](https://help.apple.com/app-store-connect/#/dev45b03fab9).
- During runtime, check whether in-app purchases support Family Sharing using either [isFamilyShareable](https://developer.apple.com/documentation/storekit/product/3749585-isfamilyshareable) in [Product](https://developer.apple.com/documentation/storekit/product) or [isFamilyShareable](https://developer.apple.com/documentation/storekit/skproduct/3564805-isfamilyshareable) in [SKProduct](https://developer.apple.com/documentation/storekit/skproduct). Then inform users when merchandising your subscriptions.
- Process purchased and restored transactions in your app. This is standard processing you already do for any purchases.
- Implement [paymentQueue(_:didRevokeEntitlementsForProductIdentifiers:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue) in your transaction observer to handle conditions in which products are no longer shared.
- Listen for the `REVOKE` [notification_type](https://developer.apple.com/documentation/appstoreservernotifications/notification_type) from [App Store Server Notifications](https://developer.apple.com/documentation/appstoreservernotifications) on your server.

- 在 App Store Connect 中为应用内购买启用家庭共享。有关更多信息，请参阅《[为应用内购买启用家庭共享](https://help.apple.com/app-store-connect/#/dev45b03fab9)》。
- 在运行时，使用 [Product](https://developer.apple.com/documentation/storekit/product) 中的 [isFamilyShareable](https://developer.apple.com/documentation/storekit/product/3749585-isfamilyshareable) 或 [SKProduct](https://developer.apple.com/documentation/storekit/skproduct) 中的 [isFamilyShareable](https://developer.apple.com/documentation/storekit/skproduct/3564805-isfamilyshareable) 检查应用内购买是否支持家庭共享。然后，在宣传订阅时通知用户。
- 在您的应用中处理已购买和已恢复的交易。按照处理任何购买的标准过程来做即可。
- 在交易观察器中实现 [paymentQueue(_:didRevokeEntitlementsForProductIdentifiers:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue) 来处理不再共享产品的情况。
- 在您的服务器上监听来自 [App Store服务器通知](https://developer.apple.com/documentation/appstoreservernotifications) 的 `REVOKE` [notification_type](https://developer.apple.com/documentation/appstoreservernotifications/notification_type)。

> **Related Sessions from WWDC20**
> Session 10661: [What's new with in-app purchase](https://developer.apple.com/videos/play/wwdc2020/10661/)

## Enable Family Sharing for in-app purchases - 启用应用内购买的家庭共享

To make Family Sharing available for an in-app purchase, developers need to turn on Family Sharing in App Store Connect. After you enable Family Sharing for an in-app purchase, you can’t turn it off. For more information, see [Turn on Family Sharing for in-app purchases](https://help.apple.com/app-store-connect/#/dev45b03fab9).

要使家庭共享适用于应用内购买，开发人员需要在App Store Connect中启用家庭共享。启用家庭共享后，无法再将其关闭。有关更多信息，请参阅《[为应用内购买启用家庭共享](https://help.apple.com/app-store-connect/#/dev45b03fab9)》。

Users can choose whether to share their purchases with family. As users join or leave family groups and enable or disable sharing, your app needs to update the family’s access to your products. For information about how users manage their Family Sharing choices, see [Set Up Family Sharing on iPhone](https://support.apple.com/guide/iphone/set-up-family-sharing-iph223f61318/ios).

用户可以选择是否与家人共享他们的购买内容。当用户加入或离开家庭组，并启用或禁用共享时，您的应用需要更新家庭对您的产品的访问权限。有关用户如何管理其家庭共享选择的信息，请参阅《[在iPhone上设置家庭共享](https://support.apple.com/guide/iphone/set-up-family-sharing-iph223f61318/ios)》。

## Provide access to shared purchases - 提供对共享购买内容的访问

Your app receives a unique receipt for each family member entitled to a shared purchase, on each of their devices. For subscriptions, your app unlocks access through the normal purchase flow. For non-consumable products, unlocking access may require users to initiate a restored purchase, depending on the Family Sharing settings at the time of purchase.

您的应用程序会收到每个有权访问共享购买的家庭成员在其设备上的独特收据。对于订阅，您的应用程序通过正常的购买流程解锁访问权限。对于非消耗型商品，根据购买时的家庭共享设置，解锁访问权限可能需要用户发起恢复购买操作。

To provide access for family members to a subscription or non-consumable, your app needs to handle purchased and restored transactions as usual. Specifically, follow these steps:

为了让家庭成员访问订阅或非消耗型商品，您的应用程序需要像处理常规购买和恢复交易一样处理。具体操作如下：

1. Set up a transaction observer at app launch so your app receives transactions that occur outside of your app, such as receiving a Family Sharing purchase. For more information on this best practice, see [Setting up the transaction observer for the payment queue](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue?language=objc).
2. Verify the receipt. Look for a transaction in the latest receipt info array (responseBody.Latest_receipt_info) with the new Family Sharing purchase.
3. Handle purchased ([SKPaymentTransactionState.purchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/skpaymenttransactionstatepurchased?language=objc)) transactions. This is a standard state apps need to handle, and you don’t need anything special for Family Sharing. For shared subscriptions, the transaction always has a purchased state. For shared non-consumable products, the transaction has a purchased state if Family Sharing was enabled for the product at the time of the purchase. For more information about handling transactions, see [Processing a transaction](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction).
4. Handle restored ([SKPaymentTransactionState.restored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/restored)) transactions, which is also a standard state apps need to handle. For shared non-consumable products, your app gets a restored transaction if developers enable Family Sharing after the user purchases the product. To gain access to the shared product, family members use your app’s restore functionality. For more information about restoring, see [Restoring purchased products](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/restoring_purchased_products).
5. Unlock access to the shared subscription or non-consumable product.
6. Call [finishTransaction:](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction).

>

1. 在应用程序启动时设置交易观察器，以便您的应用程序接收在应用程序之外发生的交易，例如接收家庭共享购买。有关此最佳实践的更多信息，请参阅《[设置付款队列的交易观察器](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/setting_up_the_transaction_observer_for_the_payment_queue?language=objc)》。
2. 验证收据。在最新收据信息数组（[responseBody.Latest_receipt_info](https://developer.apple.com/documentation/appstorereceipts/responsebody/latest_receipt_info)）中查找包含新的家庭共享购买的交易。
3. 处理已购买的交易（[SKPaymentTransactionState.purchased](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/purchased)）。这是应用程序需要处理的标准状态，家庭共享不需要任何特别的处理。对于家庭共享的订阅，交易始终是已购买的状态。对于家庭共享的非消耗型商品，如果购买时启用了家庭共享，则交易就是已购买的状态。有关处理交易的更多信息，请参阅《[处理交易](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/processing_a_transaction)》。
4. 处理已恢复的交易（[SKPaymentTransactionState.restored](https://developer.apple.com/documentation/storekit/skpaymenttransactionstate/restored)），这也是应用
5. 程序需要处理的标准状态。对于共享的非消耗型商品，如果开发人员在用户购买产品后启用了家庭共享，则您的应用程序会收到已恢复的交易。为了获得对共享产品的访问权限，家庭成员使用您 App 的还原功能。有关还原购买的更多信息，请参阅《[还原已购买的产品](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/restoring_purchased_products)》。
5. 解锁对共享订阅或非消耗型商品的访问权限。
6. 调用  [finishTransaction:](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506003-finishtransaction)。

## Revoke access if Family Sharing is disabled - 家庭共享禁用时撤销访问权限

With Family Sharing products, users have access to products only while Family Sharing is enabled. If the purchaser leaves the group, gets a refund, or stops sharing, the expectation is that the family’s access to the product stops immediately.

对于家庭共享产品，只有在启用家庭共享时用户才能访问产品。如果购买者离开了家庭组、发生退款或停止共享，那么家庭对该产品的访问权限应立即停止。

When a condition occurs that disables sharing, StoreKit informs your app by updating the receipt, and then calling the [paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue) method of the [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) protocol. Implement this method on your transaction observer, and do the following:

当发生禁用共享的情况时，StoreKit通过更新收据来通知您的应用，并调用 [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) 协议的 [paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue) 方法。在您的交易观察器上实现此方法，并执行以下操作：

1. Verify the receipt. Revoked products appear in the receipt with a `cancellation_date` field present.
2. Provide the app with access to all the products to which the user is entitled.

>

1. 验证收据。被撤销的产品将在收据中显示，并带有一个 `cancellation_date` 字段。
2. 为应用程序提供用户有权访问的所有产品的访问权限。

For more information, including a list of conditions that trigger this call, see [paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue).

有关更多信息，包括触发此调用的条件列表，请参阅 [paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue)。

## Listen for the revoke notification - 监听撤销通知

If you set up your server to receive App Store Server Notifications, your server gets a `REVOKE` [notification_type](https://developer.apple.com/documentation/appstoreservernotifications/notification_type) as soon as a shared purchase is no longer shared. This notification serves the same purpose as the [paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue) call. Listen for and process this notification by:

如果您设置了服务器接收 App Store 服务器通知，那么一旦共享的购买不再共享，您的服务器将立即收到一个 `REVOKE` [notification_type](https://developer.apple.com/documentation/appstoreservernotifications/notification_type) 的通知。此通知与 [paymentQueue:didRevokeEntitlementsForProductIdentifiers:](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue) 调用具有相同的目的。通过以下方式监听并处理此通知：

1. Checking the latest receipt ([unified_receipt.Latest_receipt_info](https://developer.apple.com/documentation/appstoreservernotifications/unified_receipt/latest_receipt_info)) in the response body. Revoked products appear in the receipt with a `cancellation_date` field present.
2. Providing the app with access to all products to which the user is entitled.
3. Updating your records, if you keep server-based records to manage your customers' subscriptions.

>

1. 检查响应体中的最新收据（[unified_receipt.Latest_receipt_info](https://developer.apple.com/documentation/appstoreservernotifications/unified_receipt/latest_receipt_info)）。被撤销的产品将在收据中显示，并带有一个 `cancellation_date` 字段。
2. 为应用程序提供用户有权访问的所有产品的访问权限。
3. 如果您保留了基于服务器的记录以管理客户的订阅，则更新您的记录。

## Indicate to users when products support Family Sharing - 当产品支持家庭共享时向用户指示

When your app displays in-app purchases, indicate in your UI whether users can share the product with family. Call [isFamilyShareable](https://developer.apple.com/documentation/storekit/skproduct/3564805-isfamilyshareable) to determine at runtime whether the in-app purchase supports Family Sharing. Knowing whether a product is shareable helps users make a selection that best fits their needs.

当你的应用程序展示应用内购买时，请在你的 UI 中指示用户是否可以与家人共享产品。调用 [isFamilyShareable](https://developer.apple.com/documentation/storekit/skproduct/3564805-isfamilyshareable) 可在运行时确定应用内购买是否支持家庭共享。了解产品是否可共享有助于用户做出最适合他们需求的选择。

# See Also - 其他参考

## Family Sharing - 家庭共享

### var [isFamilyShareable](https://developer.apple.com/documentation/storekit/skproduct/3564805-isfamilyshareable): Bool

A Boolean value that indicates whether the product is available for Family Sharing in App Store Connect.

一个布尔值，指示产品在 App Store Connect 中是否可供家庭共享。

### [func paymentQueue(SKPaymentQueue, didRevokeEntitlementsForProductIdentifiers: [String])](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/3564804-paymentqueue)

Tells an observer that the user is no longer entitled to one or more Family Sharing purchases.

通知观察者用户不再有权访问一个或多个家庭共享购买。







