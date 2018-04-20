**Type Method**
# requestReview

原文地址：[https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview?language=objc](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview?language=objc)

> **SDK**
> 
> iOS 10.3+
>
> **Framework**
>
> StoreKit
> 
> **Class**
> 
> SKStoreReviewController

Tells StoreKit to ask the user to rate or review your app, if appropriate.

告诉 StoreKit 让用户给你的 App 打分或评论，如果合适的话。

## Declaration - 声明

	+ (void)requestReview;

## Discussion - 讨论

Although you should call this method when it makes sense in the user experience flow of your app, the actual display of a rating/review request view is governed by App Store policy. Because this method may or may not present an alert, it's not appropriate to call it in response to a button tap or other user action.

尽管当在你的 App 的用户体验流中有意义时，你应该调用这个方法，但是评分/评论请求视图的实际显示是受 App Store 的策略控制的。由于这个方法可能显示也可能不显示弹窗，它并不适合作为按钮或其他用户操作的响应来调用。

> **Note**
> 
> When you call this method while your app is still in development mode, a rating/review request view is always displayed so that you can test the user interface and experience. However, this method has no effect when you call it in an app that you distribute using TestFlight.
> 
> 当你的 App 还在开发模式时，每当你调用这个方法，评分/评论请求视图总是会显示，以便你可以测试用户界面和体验。而当你在用 TestFlight 发布的 App 中调用它时，这个方法没有任何效果。

When you call this method in your shipping app and a rating/review request view is displayed, the system handles the entire process for you. In addition, you can continue to include a persistent link in the settings or configuration screens of your app that deep-links to your App Store product page. To automatically open a page on which users can write a review in the App Store, append the query parameter `action=write-review` to your product URL.

当你在已发布的 App 中调用这个方法，并且评分/评论请求视图已经显示，系统会帮你处理整个过程。另外，你可以继续在你的 App 的设置后配置界面包含一个永久的链接，深度链接到你的 App Store 产品页。要自动打开一个用户可以在 App Store 中写评论的界面，在你的产品 URL 中加上请求参数 `action=write-review`。