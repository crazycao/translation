# StoreKit 

原文地址：[https://developer.apple.com/documentation/storekit](https://developer.apple.com/documentation/storekit)

> SDKs
>
> iOS 3.0+ | macOS 10.7+ | tvOS 9.0+

Support in-app purchases and interactions with the App Store.

支持应用内购买和与 App Store 的交互。

# Overview - 概览

Using StoreKit in your app, you can provide the following features and services:

在你的 App 中使用 StoreKit，可以提供以下特性和服务：

- **In-App Purchase.** Offer and promote in-app purchases for content and services.
- **Apple Music.** Check a user's Apple Music capabilities and offer a subscription.
- **Recommendations and reviews.** Provide recommendations for third-party content and enable users to rate and review your app.
- **应用内购买。**提供和升级对内容和服务的应用内购买。
- **苹果音乐。**检查用户的 Apple Music 能力，并提供订阅。
- **推荐和评论。**为第三方内容提供推荐，并让用户可以对你的 App 进行打分和评论。

# Topics - 主题

## In-App Purchase - 应用内购买

### [In-App Purchase](https://developer.apple.com/documentation/storekit/in_app_purchase)

Offer users additional content and services through purchases they make within your app.

通过在你的 App 内部进行的购买，向用户提供更多的内容和服务。

## Ad Network Attribution - 广告网络归因

### class [SKAdNetwork](https://developer.apple.com/documentation/storekit/skadnetwork)

A class that validates advertisement-driven app installations.

验证广告驱动的应用程序安装的类。

### class [SKAdImpression](https://developer.apple.com/documentation/storekit/skadimpression)

A class that defines an ad impression for a view-through ad.

定义通过广告查看的广告印象的类。

### enum [SKANError.Code](https://developer.apple.com/documentation/storekit/skanerror/code)

Constants that indicate the type of error for an ad network attribution operation.

指示广告网络归因操作的错误类型的常量。

### struct [SKANError](https://developer.apple.com/documentation/storekit/skanerror)

An error that an ad network attribution operation returns.

广告网络归因操作返回的错误。

### let [SKANErrorDomain](https://developer.apple.com/documentation/storekit/skanerrordomain): String

A string that identifies the SKAdNetwork error domain.

标识 SKAdNetwork 错误域的字符串。

## Apple Music - 苹果音乐

### [Apple Music](https://developer.apple.com/documentation/storekit/apple_music)

Offer users the option to sign up for an Apple Music subscription and provide access to the Apple Music library.

向用户提供 Apple Music 订阅的注册选项，并提供对 Apple Music 库的访问。

## Recommendations and Reviews - 推荐和评论

### [Recommendations and Reviews](https://developer.apple.com/documentation/storekit/recommendations_and_reviews)

Offer users the option to buy other apps, music, and video media, and to rate and review apps.

向用户提供购买其他 App、音乐和视频媒体的选项，以及对 App 的打分和评论。

## Errors

### [Handling Errors](https://developer.apple.com/documentation/storekit/handling_errors)

Handle errors resulting from StoreKit requests.

处理来自 StoreKit 请求的错误结果。

### [SKErrorCode](https://developer.apple.com/documentation/storekit/skerrorcode?language=objc)

Error codes for StoreKit errors.

StoreKit 错误的错误码。

### [SKErrorDomain](https://developer.apple.com/documentation/storekit/skerrordomain?language=objc)

The error domain name for StoreKit errors.

StoreKit 错误的错误域名称。

# See Also - 其他参考

## Related Documentation - 相关文档

### [In-App Purchase Programming Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/StoreKitGuide/Introduction.html#//apple_ref/doc/uid/TP40008267?language=objc)

### [Receipt Validation Programming Guide](https://developer.apple.com/library/content/releasenotes/General/ValidateAppStoreReceipt/Introduction.html#//apple_ref/doc/uid/TP40010573?language=objc)
