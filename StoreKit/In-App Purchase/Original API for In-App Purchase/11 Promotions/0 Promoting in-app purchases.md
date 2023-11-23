# Promoting in-app purchases
# 推广应用内购买

原文地址：[https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/promoting_in-app_purchases](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/promoting_in-app_purchases)

> Technology
>
> StoreKit

Show promoted in-app purchases on your product page and handle purchases that users initiate on the App Store.

在您的产品页面上显示推广的应用内购买，并处理用户在 App Store 上发起的购买。

## Overview - 概览

Starting in iOS 11, you can promote in-app purchases on the App Store.

从 iOS 11 开始，您可以在 App Store 中推广应用内购买。

> **Note** **注意**
>
> To support promoted in-app purchases in apps with a minimum version of iOS 16.4 and later, use [PurchaseIntent](https://developer.apple.com/documentation/storekit/purchaseintent). For more information, see [Supporting promoted in-app purchases in your app](https://developer.apple.com/documentation/storekit/in-app_purchase/supporting_promoted_in-app_purchases_in_your_app).
> 
> 要在最低版本为 iOS 16.4 及更高版本的应用中支持推广的应用内购买，请使用 [PurchaseIntent](https://developer.apple.com/documentation/storekit/purchaseintent)。更多有关信息，请参阅《[在您的应用中支持推广的应用内购买](https://developer.apple.com/documentation/storekit/in-app_purchase/supporting_promoted_in-app_purchases_in_your_app)》。

Promoted in-app purchases appear on your product page, can appear in search results, and can appear as featured items on an appropriate tab on the App Store. Users can start an in-app purchase on the App Store and then transition to your app to continue the transaction. If your app isn’t installed, they receive a prompt to download it.

推广的应用内购买会显示在您的产品页面上，可以出现在搜索结果中，并可以作为精选项出现在 App Store 的适当标签上。用户可以在 App Store 上开始应用内购买，然后切换到您的应用程序继续交易。如果用户未安装您的应用程序，他们将收到下载应用的提示。

Promoting in-app purchases requires two steps:

1. In App Store Connect, set up promotions by uploading promotional images. Use the App Store Promotions feature in App Store Connect to manage their order and visibility. For more information about the setup, see [Promote in-app purchases](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/promote-in-app-purchases).
2. In your app, implement the delegate method [paymentQueue(_:shouldAddStorePayment:for:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/2877502-paymentqueue) from the [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) protocol to handle the purchase.

进行应用内购买的推广需要两个步骤：

1. 在 App Store Connect 中，通过上传推广图片设置推广。使用 App Store Connect 中的 App Store 推广功能来管理它们的顺序和可见性。有关设置的更多信息，请参阅《[推广应用内购买](https://developer.apple.com/help/app-store-connect/configure-in-app-purchase-settings/promote-in-app-purchases)》。
2. 在您的应用程序中，实现 [SKPaymentTransactionObserver](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver) 协议的 [paymentQueue(_:shouldAddStorePayment:for:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/2877502-paymentqueue) 委托方法来处理购买事务。

> **Important** **重要**
>
> To enable promoted in-app purchases, your app needs to use either `PurchaseIntent` (starting in iOS 16.4) or `paymentQueue(_:shouldAddStorePayment:for:)` (starting in iOS 11). Don’t use both at the same time. If necessary, use conditional compilation to identify the OS version the app is running in. For more information, see [Running code on a specific platform or OS version](https://developer.apple.com/documentation/xcode/running-code-on-a-specific-version).
> 
> 要启用推广的应用内购买，您的应用程序需要使用 `PurchaseIntent`（从iOS 16.4开始）或 `paymentQueue(_:shouldAddStorePayment:for:)`（从iOS 11开始）。请不要同时使用两者。如果需要，可以使用条件编译来识别应用程序运行的操作系统版本。有关更多信息，请参阅《[在特定平台或操作系统版本上运行代码](https://developer.apple.com/documentation/xcode/running-code-on-a-specific-version)》。

To customize the list of promoted in-app purchases for users, you can override their default order and visibility using [SKProductStorePromotionController](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller). Use overrides to show promotions that are relevant to the user. Overrides are specific to a device, and take effect after the user launches the app at least once. Using [SKProductStorePromotionController](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller) is optional and isn’t required for your in-app purchases to appear on the App Store.

为了为用户自定义推广的应用内购买列表，您可以使用 [SKProductStorePromotionController](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller) 来覆盖它们的默认顺序和可见性。使用重载来展示与用户相关的推广内容。重载是特定于设备的，并在用户至少启动应用程序一次后生效。使用 [SKProductStorePromotionController](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller) 是可选的，并不是您的应用内购买在 App Store 上显示所必需的。

For marketing guidance on this feature, see [Promoting Your In-App Purchases](https://developer.apple.com/app-store/promoting-in-app-purchases/).

有关此功能的营销指导，请参阅《[推广你的 App 内购买项目](https://developer.apple.com/app-store/promoting-in-app-purchases/)》。

> **Note** **注意**
>
> Promoted in-app purchases aren’t available to compatible iPad or iPhone apps running in visionOS.
> 
> 在运行于 visionOS 的兼容 iPad 或 iPhone 应用程序中，不支持推广的应用内购买。

## Complete the purchase in the app - 在应用内完成购买

When a user selects an in-app product to purchase on the App Store, StoreKit automatically opens your app and sends the transaction information to the delegate in the `SKPaymentTransactionObserver` protocol. Your app needs to complete the purchase transaction and any related actions that are specific to it.

当用户在 App Store 上选择购买应用内产品时，StoreKit 会自动打开您的应用程序，并将交易信息发送给遵循 `SKPaymentTransactionObserver` 协议的委托对象。您的应用程序需要完成购买事务以及与之相关的特定操作。

In the delegate method, return `true` to continue the transaction, or `false` to defer or cancel it.

在委托方法中，返回 `true` 以继续交易，或返回 `false` 以推迟或取消交易。

If your app isn’t installed when the user selects to purchase the in-app product, the App Store automatically downloads the app or prompts the user to purchase it. If the installed version of your app is an older version that doesn’t support in-app purchase promotions, the App Store prompts the user to upgrade the app.

如果用户选择购买应用内产品时尚未安装您的应用程序，App Store 会自动下载该应用程序或提示用户购买。如果您安装的应用程序版本是不支持应用内购买推广的旧版本，App Store 会提示用户升级应用程序。

## Continue the transaction - 继续交易

To continue an in-app purchase transaction, implement the delegate method in the `SKPaymentTransactionObserver` protocol and return `true`. StoreKit then displays the payment sheet, and the user can complete the transaction.

要继续应用内购买交易，请在 `SKPaymentTransactionObserver` 协议中实现委托方法，并返回 `true`。然后，StoreKit 会显示支付页面，用户可以完成交易。

```
//Continuing a transaction from the App Store.
// 继续一个来自 App Store 的交易

//MARK: - SKPaymentTransactionObserver

func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment,
        for product: SKProduct) -> Bool {
    // Check to see if you can complete the transaction.
    // Return true if you can.
    // 检查看看你能否完成这个交易。若能则返回 true。
    return true
}
```

## Defer or cancel the transaction - 推迟或取消交易

If your app needs to defer or cancel a transaction, return `false`. For example, you may need to defer a transaction if the user is in the middle of onboarding, and continue it after they complete the onboarding. Or, you may need to cancel a transaction if the user has already unlocked the product they’re trying to buy.

如果您的应用程序需要推迟或取消交易，请返回 `false`。例如，如果用户正在进行入门操作，并在完成入门操作后继续交易，则可能需要推迟交易。或者，如果用户已经解锁了他们想购买的产品，则可能需要取消交易。

To defer a transaction:

1. Save the payment to use when the app is ready. The payment already contains information about the product. Don’t create a new [SKPayment](https://developer.apple.com/documentation/storekit/skpayment) with the same product.
2. Return `false`.
3. After the user finishes the onboarding or other actions that require a deferral, send the saved payment to the payment queue as you do with a typical in-app purchase.

推迟交易的步骤如下：

1. 保存支付信息以便在应用程序准备好时使用。支付信息已包含有关产品的信息。不要使用相同产品创建新的 [SKPayment](https://developer.apple.com/documentation/storekit/skpayment) 对象。
2. 返回 `false`。
3. 在用户完成入门操作或其他导致推迟的操作后，将保存的支付信息发送到支付队列中，就像处理典型的应用内购买一样。

To cancel a transaction:

1. Return `false`.
2. Provide feedback to the user. Although this step is optional, if you don’t provide feedback, the app’s lack of action after the user selects to purchase an in-app product in the App Store may seem like a bug.

取消交易的步骤如下：

1. 返回 `false`。
2. 向用户提供反馈。虽然这一步骤是可选的，但如果您不提供反馈，用户在 App Store 中选择购买应用内产品后应用程序没有任何操作可能会看起来像一个 bug。

```
//Handling a transaction from the App Store.
// 处理一个来自 App Store 的交易

//MARK: - SKPaymentTransactionObserver
func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment,
        for product: SKProduct) -> Bool {
    // Add code here to check if your app needs to defer the transaction.
    // 在这里添加代码检查你的 App 是否要推迟交易。
    let shouldDeferPayment = ...
    // If you need to defer until onboarding is complete, save the payment and return false.
    // 如果需要推迟直到入门操作完成，保存 payment 并返回 false。
    if shouldDeferPayment {
        self.savedPayment = payment
        return false
    }

    // Add code here to check if your app needs to cancel the transaction.
    // 在这里添加代码检查你的 App 是否要取消交易。
    let shouldCancelPayment = ...
    // If you need to cancel the transaction, then return false:
    // 如果需要取消交易，返回 false。
    if shouldCancelPayment {
        return false
    }
}


// If you cancel the transaction, provide feedback to the user.
// 如果你取消了交易，请向用户提供反馈。

// Continuing a previously deferred payment.
// 继续之前被推迟的 payment。
SKPaymentQueue.default().add(savedPayment)
```

## Get visibility settings - 获取可见性设置

To get the visibility settings for a promoted product, call [fetchStorePromotionVisibility(for:completionHandler:)](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller/2915867-fetchstorepromotionvisibility), providing the product information.

要获取推广产品的可见性设置，请调用 [fetchStorePromotionVisibility(for:completionHandler:)](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller/2915867-fetchstorepromotionvisibility) 方法，其中提供了产品信息。

```
// Reading visibility override of a promoted in-app purchase.
// 读取推广的应用内购买的可见性覆盖。

// Fetch product info for "Hidden Beaches pack."
// 获取“隐藏海滩包”的产品信息。
let storePromotionController = SKProductStorePromotionController.default()
storePromotionController.fetchStorePromotionVisibility(forProduct: hiddenBeaches,
    completionHandler: { visibility: SKProductSTorePromotionVisiblity, error: Error?) in
        // visibility == .default
})
```

## Override visibility settings - 覆盖可见性设置

For each device, you can decide whether to make in-app purchases visible or hidden. For example, you may want to hide products the customer already purchased, and show only the products they can buy.

对于每个设备，您可以决定是否将应用内购买设置为可见或隐藏。例如，您可能希望隐藏客户已经购买的产品，并仅显示他们可以购买的产品。

For example, to hide the Pro Subscription product after a user purchases it, fetch the product information and update the store promotion controller with the .hide setting, as the following code example shows. The Pro Subscription promoted in-app purchase no longer appears in the App Store on the device.

例如，要在用户购买 Pro Subscription 产品后隐藏它，可以获取产品信息，并使用 `.hide` 设置更新商店推广控制器，如下面的代码示例所示。在该设备的 App Store 中，Pro Subscription 的推广应用内购买将不再显示。

```
// Hide the promoted product Pro Subscription after the user purchases it.
// 在用户购买推广的产品 Pro Subscription 后将其隐藏。

let storePromotionController = SKProductStorePromotionController.default()
storePromotionController.update(storePromotionVisibility: .hide, for: proSubscription,
    completionHandler: { (error: Error?) in
        // Completion.
    })
 ```
 
## Override the order of promoted products - 覆盖推广产品的顺序

You can customize the promoted in-app purchases on each device by overriding their default order. Use overrides to show promotions that are relevant to the user. For example, you can override the order to promote an in-app purchase that unlocks a level in your game when a user reaches the preceding level.

您可以通过覆盖默认顺序来自定义每个设备上的推广应用内购买。使用覆盖来展示与用户相关的促销内容。例如，您可以通过覆盖顺序，在用户达到前一级别时推广一个解锁游戏中某个关卡的应用内购买。

To override the promotion order, add the product information to an array in the order they are to appear. Pass the array to the [update(storePromotionOrder:completionHandler:)](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller/2915874-update) method. The App Store displays the products in the array, followed by the remaining promoted products, which appear in the same relative order that you set in App Store Connect.

要覆盖推广顺序，将产品信息按照它们应该显示的顺序添加到一个数组中。将该数组传递给 [update(storePromotionOrder:completionHandler:)](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller/2915874-update) 方法。App Store将按照数组中的产品顺序显示它们，并在其后显示其余的推广产品，这些产品的相对顺序与您在 App Store Connect 中设置的顺序相同。

```
// Overriding the order of promoted in-app purchases.
// 覆盖推广的应用内购买的顺序。

// Fetch product information for three products: Pro Subscription, Fishing Hot Spots, and Hidden Beaches.
// 获取这三个产品的产品信息：Pro Subscription, Fishing Hot Spots, and Hidden Beaches。

let storePromotionController = SKProductStorePromotionController.default()

// Update the order.
// 更新顺序
let newProductsOrder = [hiddenBeaches, proSubscription, fishingHotSpots]
storePromotionController.updateStorePromotionOrder(newProductsOrder,
    completionHandler: { (error: Error?) in
        // Complete.
    })
```

## Cancel order overrides - 取消顺序覆盖

To remove overrides and use the default promotion order, send an empty product array to the update(storePromotionOrder:completionHandler:) method. The App Store then displays the promoted in-app purchase products in the default order that you set in App Store Connect.

要删除覆盖并使用默认的推广顺序，请向update(storePromotionOrder:completionHandler:)方法发送一个空的产品数组。然后，App Store 将按照您在 App Store Connect 中设置的默认顺序显示推广的应用内购买产品。

## Fetch order overrides - 获取顺序覆盖

To get the product promotion order for the device, call fetchStorePromotionOrder(completionHandler:). This method returns an array of products that have an overridden order. If you get an empty array, there aren’t any overrides and the products are in the default order.

要获取设备的产品推广顺序，请调用 fetchStorePromotionOrder(completionHandler:) 方法。该方法返回一个具有覆盖顺序的产品数组。如果返回一个空数组，则表示没有任何覆盖，产品将按照默认顺序显示。

```
// Getting the order override of promoted in-app purchases.
// 获取推广的应用内购买的顺序覆盖

let storePromotionController = SKProductStorePromotionController.default()
storePromotionController.fetchStorePromotionOrder(completionHandler: {
    (products: [SKProduct], error: Error?) in
        // products == [hiddenBeaches, proSubscription, fishingHotSpots]
    })
```

# See Also - 其他参考

## Promotions - 推广

### [Testing promoted in-app purchases](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_promoted_in-app_purchases)

Test your in-app purchases before making your app available in the App Store.

在将您的应用程序发布到 App Store 之前，请先测试应用内购买功能。

### class [SKProductStorePromotionController](https://developer.apple.com/documentation/storekit/skproductstorepromotioncontroller)

A product promotion controller for customizing the order and visibility of in-app purchases per device.

产品促销控制器，用于根据每个设备自定义应用内购买的顺序和可见性。