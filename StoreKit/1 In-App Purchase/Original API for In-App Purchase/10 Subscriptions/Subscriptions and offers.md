# Subscriptions and offers
# 订阅和促销

原文地址：[https://developer.apple.com/documentation/storekit/subscriptions-and-offers?language=objc](https://developer.apple.com/documentation/storekit/subscriptions-and-offers?language=objc)

Offer customers additional time-based content and services through purchases they make within your app.

通过客户在您应用内的购买行为，向他们提供额外的限时内容和服务。

# Topics 主题

## Essentials 要点

### [Handling Subscriptions Billing](https://developer.apple.com/documentation/storekit/handling-subscriptions-billing?language=objc) 处理订阅计费

Build logic around the date and time constraints of subscription products, while planning for all scenarios where you control access to content.

围绕订阅产品的日期和时限构建逻辑，同时针对所有你控制内容访问权限的场景做好规划。

### [Enabling App Store Server Notifications](https://developer.apple.com/documentation/storekit/enabling-app-store-server-notifications?language=objc) 启用 App Store 服务器通知

Configure your server and provide an HTTPS URL to receive notifications about in-app purchase events and unreported external purchase tokens.

配置你的服务器并提供一个 HTTPS 网址，以接收有关应用内购买事件和未报告的外部购买令牌的通知。

### [Offering a Subscription Across Multiple Apps](https://developer.apple.com/documentation/storekit/offering-a-subscription-across-multiple-apps?language=objc) 在多个应用中提供同一项订阅服务

Support a single auto-renewable subscription across multiple apps.

支持在多个应用中使用单一自动续期订阅服务。

### [Reducing Involuntary Subscriber Churn](https://developer.apple.com/documentation/storekit/reducing-involuntary-subscriber-churn?language=objc) 减少非自愿的订阅用户流失

Prevent unintentional loss of subscribers due to billing issues.

防止因计费问题导致订阅用户意外流失。

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

## Promotional offers 促销优惠

Provide discount pricing for existing or previously subscribed customers to encourage them to renew.

为现有或曾经订阅过的客户提供折扣价格，以鼓励他们续费。

### [Setting up promotional offers](https://developer.apple.com/documentation/storekit/setting-up-promotional-offers?language=objc) 设置促销优惠

Generate a key and configure offers for auto-renewable subscriptions in App Store Connect. 

在 App Store Connect 中生成密钥并为自动续期订阅配置优惠。

### [Implementing promotional offers in your app](https://developer.apple.com/documentation/storekit/implementing-promotional-offers-in-your-app?language=objc) 在你的应用中实施促销优惠

Offer discounted pricing for auto-renewable subscription products to eligible subscribers.

为符合条件的订阅用户的自动续期订阅产品提供折扣价格。

### [Generating a signature for promotional offers](https://developer.apple.com/documentation/storekit/generating-a-signature-for-promotional-offers?language=objc) 为促销优惠生成签名

Create a signature to validate a promotional offer using your private key.

使用你的私钥创建一个签名来验证促销优惠。

### [Generating a Promotional Offer Signature on the Server](https://developer.apple.com/documentation/storekit/generating-a-promotional-offer-signature-on-the-server?language=objc) 在服务器上生成促销优惠签名

Generate a signature using your private key and lightweight cryptography libraries.

使用你的私钥和轻量级加密库生成签名。

### [SKPaymentDiscount](https://developer.apple.com/documentation/storekit/skpaymentdiscount?language=objc) 【Deprecated】

The signed discount to apply to a payment.

应用于付款的已签名折扣。

## Subscription offer codes 订阅优惠码

Provide offer codes to customers to acquire, retain, and win back subscribers.

向客户提供优惠码，以获取、留存和赢回订阅用户。

### [Implementing offer codes in your app](https://developer.apple.com/documentation/storekit/implementing-offer-codes-in-your-app?language=objc) 在你的应用中实施优惠码

Provide subscription service for customers who redeem offer codes through the App Store or within an app that uses receipts.

为通过 App Store 或在使用收据的应用内兑换优惠码的客户提供订阅服务。

## Subscription service entitlement 订阅服务权益

### [Determining service entitlement on the server](https://developer.apple.com/documentation/storekit/determining-service-entitlement-on-the-server?language=objc) 在服务器上确定服务权益

Identify a customer’s entitlement to your service, offers, and messaging by analyzing a validated receipt and the state of their subscription.

通过分析经过验证的收据以及客户的订阅状态，确定客户对你的服务、优惠和消息推送的权益。
