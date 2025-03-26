# SKProductDiscount

原文地址：[https://developer.apple.com/documentation/storekit/skproductdiscount](https://developer.apple.com/documentation/storekit/skproductdiscount)

The details of an introductory offer or a promotional offer for an auto-renewable subscription.

自动续订订阅的推介优惠或促销优惠的详细信息。

> iOS 11.2–18.0
Deprecated
iPadOS 11.2–18.0
Deprecated
Mac Catalyst 13.1–18.0
Deprecated
macOS 10.13.2–15.0
Deprecated
tvOS 11.2–18.0
Deprecated
visionOS 1.0–2.0
Deprecated
watchOS 6.2–11.0
Deprecated


```
class SKProductDiscount
```

> **Deprecated**
>
> Use Product.SubscriptionOffer

# Mentioned in

[Implementing promotional offers in your app](https://developer.apple.com/documentation/storekit/implementing-promotional-offers-in-your-app)

# Overview - 概览

You set up introductory and promotional offers in App Store Connect. `SKProductDiscount` contains the offer information as retrieved from the App Store.

你可以在 App Store Connect 中设置推介和促销优惠。`SKProductDiscount` 包含从 App Store 检索到的优惠信息。

For more information about setting up offers, see [Set an introductory offer for an auto-renewable subscription](https://help.apple.com/app-store-connect/#/deve1d49254f) and [Set up promotional offers for auto-renewable subscriptions](https://help.apple.com/app-store-connect/#/dev16dfca448).

有关设置优惠的详细信息，请参见《[为自动可续期订阅设置推介优惠](https://help.apple.com/app-store-connect/#/deve1d49254f)》和《[为自动可续期订阅设置促销优惠](https://help.apple.com/app-store-connect/#/dev16dfca448)》。

# Topics - 主题

## Identifying the Discount - 标识折扣

### var identifier: String?

A string used to uniquely identify a discount offer for a product.

用于唯一标识产品折扣优惠的字符串。

### var type: SKProductDiscount.Type

The type of discount offer.

折扣优惠的类型。

### enum Type

Values representing the types of discount offers an app can present.

表示应用可以提供的折扣优惠类型的值。

## Getting Price and Payment Mode 获取价格和支付模式

### var price: NSDecimalNumber

The discount price of the product in the local currency.

本地货币中产品的折扣价格。

### var priceLocale: Locale

The locale used to format the discount price of the product.

用于格式化产品折扣价格的区域设置。

### var paymentMode: SKProductDiscount.PaymentMode

The payment mode for this product discount.

该产品折扣的支付模式。

### enum PaymentMode

Values representing the payment modes for a product discount.

表示产品折扣支付模式的值。

## Getting the Discount Duration - 获取折扣持续时间

### var numberOfPeriods: Int

An integer that indicates the number of periods the product discount is available.

一个整数，指示产品折扣适用的周期数。

### var subscriptionPeriod: SKProductSubscriptionPeriod

An object that defines the period for the product discount.

定义产品折扣适用周期的对象。

# Relationships

## Inherits From

NSObject

## Conforms To

CVarArg
CustomDebugStringConvertible
CustomStringConvertible
Equatable
Hashable
NSObjectProtocol
Sendable