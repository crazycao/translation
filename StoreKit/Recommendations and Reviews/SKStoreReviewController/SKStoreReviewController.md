# SKStoreReviewController

原文地址：[https://developer.apple.com/documentation/storekit/skstorereviewcontroller?language=objc](https://developer.apple.com/documentation/storekit/skstorereviewcontroller?language=objc)

> **SDK**
>
> iOS 10.3+
>
> **Framework**
>
> StoreKit

# SKStoreReviewController

An object that controls the process of requesting App Store ratings and reviews from users.

控制请求来自用户的 App Store 评分和评论的过程的对象。

# Overview

Use the [requestReview](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview?language=objc) method to indicate when it makes sense within the logic of your app to ask the user for ratings and reviews within your app.

使用 [requestReview](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview?language=objc) 方法指出，在你的 App 的逻辑中，何时让用户在你的 App 里打分和评论是有意义的。

# Topics - 主题

## Indicating an Appropriate Time for a Review - 指出去评论的合适的事件

[+ requestReview](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview?language=objc)

Tells StoreKit to ask the user to rate or review your app, if appropriate.

告诉 StoreKit 让用户给你的 App 打分或评论，如果合适的话。

# Relationships - 关系

## Inherits From - 继承自

[NSObject](https://developer.apple.com/documentation/objectivec/nsobject?language=objc)