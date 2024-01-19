# SKProduct

原文地址：[https://developer.apple.com/documentation/storekit/skproduct](https://developer.apple.com/documentation/storekit/skproduct)

> Technology
>
> StoreKit

Information about a registered product in App Store Connect.

在 App Store Connect 注册的产品的信息。

> iOS 3.0+
iPadOS 3.0+
macOS 10.7+
Mac Catalyst 13.1+
tvOS 9.0+
watchOS 6.2+
visionOS 1.0+ Beta

```
class SKProduct : NSObject
```

# Overview - 概览

SKProduct objects are returned as part of an SKProductsResponse object.

SKProduct 对象作为 SKProductsResponse 对象的一部分返回。

# Topics - 主题

## Getting the Product Identifier - 获取产品标识符

### var productIdentifier: String
The string that identifies the product to the Apple App Store.

用于标识在Apple App Store中的产品的字符串。

### Getting Product Attributes - 获取产品属性

### var localizedDescription: String
A description of the product.

产品的描述。

### var localizedTitle: String
The name of the product.

产品的名称。

### var contentVersion: String
A string that identifies the version of the content.

一个用于标识内容版本的字符串。

### var isFamilyShareable: Bool
A Boolean value that indicates whether the product is available for Family Sharing in App Store Connect.

一个布尔值，指示产品在 App Store Connect 中是否可供家庭共享。

### var contentLengths: [NSNumber] 【弃用】
The total size of the content, in bytes.

内容的总大小，以字节为单位。

## Getting Pricing Information - 获取定价信息

### var price: NSDecimalNumber
The cost of the product in the local currency.

以当地货币计算的产品花费。

### var priceLocale: Locale
The locale used to format the price of the product.

用于格式化产品价格的区域设置。

### var introductoryPrice: SKProductDiscount?
The object containing introductory price information for the product.

包含产品推介价格信息的对象。

### var discounts: [SKProductDiscount]
An array of subscription offers available for the auto-renewable subscription.

可用于自动续订订阅的订阅优惠数组。

### class SKProductDiscount
The details of an introductory offer or a promotional offer for an auto-renewable subscription.

自动续订订阅的推介优惠或促销优惠的详细信息。

## Getting Subscription Information - 获取订阅信息

### var subscriptionGroupIdentifier: String?
The identifier of the subscription group to which the subscription belongs.

订阅所属的订阅组的标识符。

### var subscriptionPeriod: SKProductSubscriptionPeriod?
The period details for products that are subscriptions.

订阅产品的周期详情。

### class SKProductSubscriptionPeriod
An object containing the subscription period duration information.

一个包含订阅周期持续时间信息的对象。

### enum SKProduct.PeriodUnit
Values representing the duration of an interval, from a day up to a year.

表示间隔持续时间的值，从一天到一年。

## Getting Downloadable Content Information - 获取可下载内容信息

### var isDownloadable: Bool
A Boolean value that indicates whether the App Store has downloadable content for this product.

一个布尔值，表示 App Store 是否有此产品的可下载内容。

### var downloadContentLengths: [NSNumber]
The lengths of the downloadable files available for this product.

该产品可用的可下载文件的长度。

### var downloadContentVersion: String
A string that identifies which version of the content is available for download.

一个字符串，用于标识可供下载的内容的版本。

### var downloadable: Bool 【弃用】
A Boolean value that indicates whether the App Store has downloadable content for this product.

一个布尔值，表示 App Store 是否有此产品的可下载内容。

# Relationships

## Inherits From

NSObject

## Conforms To

Sendable