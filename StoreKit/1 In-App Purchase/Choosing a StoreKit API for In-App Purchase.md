# Choosing a StoreKit API for In-App Purchase 

原文地址：[https://developer.apple.com/documentation/storekit/choosing_a_storekit_api_for_in-app_purchase?language=objc](https://developer.apple.com/documentation/storekit/choosing_a_storekit_api_for_in-app_purchase?language=objc)

> Technology
>
> StoreKit

Use the latest API to support in-app purchases in your new or existing app, or the original API for an existing app.

使用最新的API支持在新应用或现有应用中的应用内购买，或在现有应用中使用原始API。

# Overview - 概览

The StoreKit framework provides two APIs for implementing a store in your app and offering in-app purchases:

StoreKit 框架提供了两套 API，用于在应用程序中实现商店和提供应用内购买：

- [In-App Purchase](https://developer.apple.com/documentation/storekit/in-app_purchase?language=objc), a Swift-based API that provides Apple-signed transactions in JSON Web Signature (JWS) format, available starting in iOS 15, macOS 12, tvOS 15, and watchOS 8.

- [应用内购买](https://developer.apple.com/documentation/storekit/in-app_purchase?language=objc)，一套基于 Swift 的以  JSON Web Signature （JWS）格式提供苹果签署的交易的API，从 iOS  15、macOS 12、tvOS 15、watchOS 8 开始可用。

- [Original API for In-App Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase?language=objc), an API that provides transaction information using App Store receipts, available starting in iOS 3, macOS 10.7, tvOS 9, and watchOS 6.2.

-  [应用内购买原始 API](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase?language=objc)，一套使用 App Store 收据提供交易信息的 API，从 iOS 3、macOS 10.7、tvOS 9、watchOS 6.2 开始可用。

Both APIs provide access to your data in the App Store, such as your configured in-app purchases and transaction information for your customers. They also provide the same user experience with the App Store for your customers. In-app purchases that users make using either API are fully available to both APIs.

这两套 API 都提供了对 App Store 中数据的访问，例如为客户配置的应用内购买和交易信息。它们还为您的客户提供与 App Store 相同的用户体验。用户使用任一 API 进行的应用内购买对两套 API 都完全可用。

# Use the Original API to Support Certain Features - 使用原始 API 支持某些功能

You may need to use the original in-app purchase API if your app depends on any of the following features:

如果你的应用依赖于以下任何功能，你可能需要使用原始的应用内购买 API：

- To provide support for the Volume Purchase Program (VPP). For more information, see [Device Management](https://developer.apple.com/documentation/devicemanagement?language=objc).

- 为批量采购计划（VPP）提供支持。有关更多信息，请参阅《[设备管理](https://developer.apple.com/documentation/devicemanagement?language=objc)》。

- To provide app pre-orders. For more information, see [Offering Your App for Pre-Order](https://developer.apple.com/app-store/pre-orders/).

- 提供应用程序预购。有关更多信息，请参阅《[为预购开发 App](https://developer.apple.com/app-store/pre-orders/)》。

- Your app changed from a premium to a freemium model, or vice versa.

- 你的应用程序从高级版改为免费版，反之亦然。

Use the original API for existing and legacy apps.

将原始 API 用于现有的和遗留的应用程序。

# See Also - 其他参考

## In-App Purchase - 应用内购买

### [In-App Purchase](https://developer.apple.com/documentation/storekit/in-app_purchase?language=objc)

Offer users additional content and services by using a modern Swift-based interface.

使用基于 Swift 的现代界面，向用户提供更多的内容和服务。

### [Original API for In-App Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase?language=objc)

Offer users additional content and services using the original In-App Purchase API.

使用原始的应用内购买 API，向用户提供更多的内容和服务。
