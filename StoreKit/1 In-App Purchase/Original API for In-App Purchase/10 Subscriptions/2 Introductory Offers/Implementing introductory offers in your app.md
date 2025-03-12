# Implementing introductory offers in your app
# 订阅和促销

原文地址：[https://developer.apple.com/documentation/storekit/subscriptions-and-offers?language=objc](https://developer.apple.com/documentation/storekit/subscriptions-and-offers?language=objc)

Offer introductory pricing for auto-renewable subscriptions to eligible users.

为符合条件的用户的自动续期订阅提供推介优惠价格。

## 1 Overview 概述

Apps with auto-renewable subscriptions can offer a discounted introductory price, including a free trial, to eligible users. You can make introductory offers to customers who haven’t previously received an introductory offer for the given product, or for any products in the same subscription group.

带有自动续期订阅功能的应用可以为符合条件的用户提供折扣性的推介价格，包括免费试用。如果客户之前的未获得过特定产品或同一订阅组内的任何产品的推介优惠，您可以向该客户提供推介优惠。

Start by setting up introductory offers in App Store Connect. Then, in your app, determine if the user is eligible to receive an introductory offer. When the app queries the App Store for a list of available products, display the introductory pricing if the user is eligible to receive them.

首先在 App Store Connect 中设置推介优惠。然后，在您的应用中，判断用户是否有资格获得推介优惠。当应用向 App Store 查询可用产品列表时，如果用户有资格获得推介优惠价格，则显示该价格。

## 2 Set Up Introductory Offers 设置推介优惠

Before you can display introductory offers in your app, you must first configure the offers in App Store Connect. For more information, see [Set an introductory offer for an auto-renewable subscription](https://help.apple.com/app-store-connect/#/deve1d49254f).

在您的应用中显示推介优惠之前，必须先在 App Store Connect 中配置这些优惠。更多信息，请参阅《[为自动续期订阅设置推介优惠](https://help.apple.com/app-store-connect/#/deve1d49254f)》。

Choose from one of three types of introductory offers, which differ in their mode of payment. All subscriptions renew at the regular price when the introductory period is over. The offer types are “pay as you go”, “pay up front”, and “free trial”.

从三种推介优惠类型中选择一种，它们的付款方式各不相同。所有订阅在推介期结束后都将按正常价格续费。优惠类型包括 “随用随付”、“预付” 和 “免费试用”。

### 2.1 Pay As You Go 随用随付

The [SKProductDiscountPaymentModePayAsYouGo](https://developer.apple.com/documentation/storekit/skproductdiscount/paymentmode-swift.enum/payasyougo?language=objc) value represents the pay as you go offer type. In this introductory offer, new subscribers pay an introductory price each billing period for a specific duration (for example, $1.99 per month for 3 months).

[SKProductDiscountPaymentModePayAsYouGo](https://developer.apple.com/documentation/storekit/skproductdiscount/paymentmode-swift.enum/payasyougo?language=objc) 值代表随用随付的优惠类型。在这种推介优惠中，新订阅用户在特定时间段内的每个计费周期支付推介价格（例如，连续 3 个月每月支付 1.99 美元）。

![Pay as you go timeline 随用随付时间线](https://docs-assets.developer.apple.com/published/cdf7424c589eb68fe7962e3c551ebba1/media-3149470@2x.png)

### 2.2 Pay Up Front 提前支付

The [SKProductDiscountPaymentModePayUpFront](https://developer.apple.com/documentation/storekit/skproductdiscount/paymentmode-swift.enum/payupfront?language=objc) value represents the pay up front offer type. In this introductory offer, new subscribers pay a one-time introductory price for a specific duration (for example, $1.99 for 2 months).

[SKProductDiscountPaymentModePayUpFront](https://developer.apple.com/documentation/storekit/skproductdiscount/paymentmode-swift.enum/payupfront?language=objc) 值代表提前支付的优惠类型。在这种推介优惠中，新订阅用户为特定时间段一次性支付推介价格（例如，支付 1.99 美元享受 2 个月的服务）。

![Pay up front timeline 提前支付时间线](https://docs-assets.developer.apple.com/published/d4efc45f4203f1875f488fa0f304656f/media-3149471@2x.png)

### 2.3 Free Trial 免费试用

The [SKProductDiscountPaymentModeFreeTrial](https://developer.apple.com/documentation/storekit/skproductdiscount/paymentmode-swift.enum/freetrial?language=objc) value represents a free trial offer type. In this introductory offer, new subscribers access content for free for a specified duration. Subscriptions begin immediately, but subscribers won’t be billed until the free trial period is over.

[SKProductDiscountPaymentModeFreeTrial](https://developer.apple.com/documentation/storekit/skproductdiscount/paymentmode-swift.enum/freetrial?language=objc) 值代表免费试用的优惠类型。在这种推介优惠中，新订阅用户在指定时间段内免费访问内容。订阅会立即开始，但在免费试用期结束之前不会向用户收费。

![Free trial timeline 免费试用时间线](https://docs-assets.developer.apple.com/published/987bbe3dd419145066746cc36e06f45c/media-3174516@2x.png)

## 3 Determine Eligibility 判断资格

To determine if a user is eligible for an introductory offer, check their receipt:

要判断用户是否有资格获得推介优惠，请检查他们的收据：

1. Validate the receipt as described in [Validating receipts with the App Store](https://developer.apple.com/documentation/storekit/validating-receipts-with-the-app-store?language=objc).
2. In the receipt, check the values of the `is_trial_period` and the `is_in_intro_offer_period` for all in-app purchase transactions. If either of these fields are `true` for a given subscription, the user is not eligible for an introductory offer on that subscription product or any other products within the same subscription group. Use `subscription_group_identifier` in the `responseBody.Pending_renewal_info` array to determine the subscription group to which the subscription belongs.

>

1. 按照《[使用 App Store 验证收据](https://developer.apple.com/documentation/storekit/validating-receipts-with-the-app-store?language=objc)》中所述的方法验证收据。
2. 在收据中，检查所有应用内购买交易的 `is_trial_period` 和 `is_in_intro_offer_period` 的值。如果对于给定的订阅，这两个字段中的任何一个为 `true`，则用户没有资格获得该订阅产品或同一订阅组内任何其他产品的推介优惠。使用 `responseBody.Pending_renewal_info` 数组中的 `subscription_group_identifier` 来确定该订阅所属的订阅组。

Typically, you check the user’s eligibility from your server. Determine eligibility early—for example, on the first launch of the app, if possible.

通常，您从服务器检查用户的资格。请尽早判断资格 —— 例如，如果可能的话，在应用首次启动时进行判断。

![Diagram showing that introductory offers are available to new subscribers, and to lapsed subscribers who receive an introductory offer for the first time. 图表显示了推介优惠对新订阅用户和首次获得推介优惠的已失效订阅用户可用。](https://docs-assets.developer.apple.com/published/3700fb494140a08886656f52e6c8f493/media-2942147@2x.png)

Based on the receipt, you will find that new and returning customers are eligible for introductory offers, including free trials:

根据收据，您会发现新客户和重新订阅的客户有资格获得推介优惠，包括免费试用：

- New subscribers are always eligible.
- Lapsed subscribers who renew are eligible if they haven’t previously used an introductory offer for the given product (or any product within the same subscription group).

- 新订阅用户始终有资格。
- 重新订阅的已失效订阅用户，如果他们之前未对给定产品（或同一订阅组内的任何产品）使用过推介优惠，则有资格获得推介优惠。

Existing subscribers are not eligible for an introductory offer for any product within the same subscription group. For example, customers are not eligible if they are upgrading, downgrading, or crossgrading their subscription from another product, regardless of whether they consumed an introductory offer in the past.

现有订阅用户没有资格获得同一订阅组内任何产品的推介优惠。例如，无论用户过去是否曾享受过推介优惠，当他们从其他产品升级、降级或交叉升级其订阅时，也没有资格获得介绍性优惠。

## 4 Display the Introductory Offer 显示推介优惠

Once you determine the user is eligible for an introductory offer, query the App Store for available products, and present the offer to the user:

一旦确定用户有资格获得推介优惠，就向 App Store 查询可用产品，并向用户展示该优惠：

1. Retrieve localized information from the App Store about a specified list of subscription products using the `SKProductsRequest` class. Products that have an available discount defined in App Store Connect always include an `introductoryPrice` object.
2. Use the properties in the `introductoryPrice` object to display the discounted price for the subscription. Based on the type of the introductory offer (represented by `SKProductDiscountPaymentMode`), display a UI that describes the offer accordingly.

> 

1. 使用 `SKProductsRequest` 类从 App Store 检索有关指定订阅产品列表的本地化信息。在 App Store Connect 中定义了可用折扣的产品始终会包含一个 `introductoryPrice` 对象。
2. 使用 `introductoryPrice` 对象中的属性来显示订阅的折扣价格。根据推介优惠的类型（由 `SKProductDiscountPaymentMode` 表示），相应地显示描述该优惠的用户界面。

For design guidance, see Human [Interface Guidelines > In-App Purchase](https://developer.apple.com/design/human-interface-guidelines/in-app-purchase/overview/).

有关设计指南，请参阅[《人机界面指南》-> 应用内购买]((https://developer.apple.com/design/human-interface-guidelines/in-app-purchase/overview/))。

# See Also 其他参考

## Related Documentation 相关文档

### [Receipt Validation Programming Guide](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Introduction.html?language=objc#//apple_ref/doc/uid/TP40010573) 收据校验编程指南

## Introductory offers 推介优惠

Provide discount pricing for new customers to encourage them to subscribe.

为新客户提供折扣价格，以鼓励他们订阅。

### [Implementing introductory offers in your app](https://developer.apple.com/documentation/storekit/implementing-introductory-offers-in-your-app?language=objc) 在你的应用中实施推介优惠

Offer introductory pricing for auto-renewable subscriptions to eligible users.

为符合条件的用户的自动续期订阅提供推介优惠价格。

### [Testing introductory offers](https://developer.apple.com/documentation/storekit/testing-introductory-offers?language=objc) 测试推介优惠

Test your introductory pricing in a variety of user scenarios.

在各种用户场景中测试你的推介优惠价格。

### [SKProductDiscount](https://developer.apple.com/documentation/storekit/skproductdiscount?language=objc) 【Deprecated】

The details of an introductory offer or a promotional offer for an auto-renewable subscription.

自动续期订阅的推介优惠或促销优惠的详细信息。