**Class**

# SKStoreProductViewController

原文地址：[https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller?language=objc](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller?language=objc)

A view controller that provides a page where the user can purchase media from the App Store.

提供用户可以从 App Store 购买媒体的界面的视图控制器。

> **SDK**
>
> iOS 6.0+
>
> **Framework**
>
> StoreKit

# Overview - 概览

To display a store for users to purchase media from the App Store, create an `SKStoreProductViewController` object and set its delegate. Then, present the view controller modally from another view controller in your app. Your delegate dismisses the view controller when the user completes the purchase.

要给用户显示一个商店，以便从 App Store 购买媒体，创建一个 `SKStoreProductViewController` 对象并设置其代理。然后，从你 App 中的另一个视图控制器模态的展示这个视图控制器。你的代理在用户完成购买时关闭该视图控制器。

To indicate a specific product to sell, pass its iTunes item identifier to the [loadProductWithParameters:completionBlock:](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc) method.

要指示卖的特定产品，把它的 iTunes 项目标识传给 [loadProductWithParameters:completionBlock:](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc) 方法。

# Topics - 主题

## Setting a Delegate - 设置代理

[delegate](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620634-delegate?language=objc)

The store view controller’s delegate.

商店视图控制器的代理。

[SKStoreProductViewControllerDelegate](https://developer.apple.com/documentation/storekit/skstoreproductviewcontrollerdelegate?language=objc)

A protocol called when the user dismisses the store screen.

当用户关闭商店界面时调用的协议。

## Loading a New Product Screen - 加载新的产品界面

[- loadProductWithParameters:completionBlock:](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc)

Loads a new product screen to display.

加载新的产品界面以显示。

[Product Dictionary Keys](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/product_dictionary_keys?language=objc)

Keys for identifying products and the tokens for affiliates and campaigns.

用于标识产品以及代销和活动的令牌的 key。

# Relationships - 关系

## Inherits From - 继承自

[UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller?language=objc)

# See Also - 其他参考

## Affiliate Recommendations - 代销推荐

[SKAdNetwork](https://developer.apple.com/documentation/storekit/skadnetwork?language=objc)

A class that validates advertiser-driven app installations.

验证广告驱动的 App 安装情况的类。
