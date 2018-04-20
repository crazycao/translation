# Product Dictionary Keys

原文地址：[https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/product_dictionary_keys?language=objc](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/product_dictionary_keys?language=objc)

> **Framework**
>
> StoreKit

Keys for identifying products and the tokens for affiliates and campaigns.

标识产品的 key ，以及代理商和活动的 token。

# Overview - 概览

These dictionary keys are used in the parameter for the [loadProductWithParameters:completionBlock:](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc) method.

这些字典 key 用在 [loadProductWithParameters:completionBlock:](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc) 方法的参数中。

The [SKStoreProductParameterITunesItemIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteritunesitemidentifier?language=objc) key represents the product to display, and is always required. Other keys provide optional affiliate or promoted product information.

[SKStoreProductParameterITunesItemIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteritunesitemidentifier?language=objc) key 代表显示的产品，并且总是必须的。其他的 key 提供可选的代理商或促销产品的信息。

Learn more about the Affiliate Program at [https://apple.com/itunes/affiliates](https://apple.com/itunes/affiliates).

关于 Affiliate Program 的更多信息，见 [https://apple.com/itunes/affiliates](https://apple.com/itunes/affiliates)。

# Topics - 主题

## Required Key - 必须的 key

[SKStoreProductParameterITunesItemIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteritunesitemidentifier?language=objc)

The key representing the iTunes identifier for the item you want the store to display when the view controller is presented.

当视图控制器展示时，表示你希望商店显示的项目的 iTunes 标识符。

## Affiliate and Analytics Keys - 代理商和分析 key

[SKStoreProductParameterProductIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameterproductidentifier?language=objc)

The key representing the product identifier for the promoted product you want the store to display at the top of the page.

表示你想要商店在页面顶部显示的促销产品的产品标识符的 key。

[SKStoreProductParameterAdvertisingPartnerToken](https://developer.apple.com/documentation/storekit/skstoreproductparameteradvertisingpartnertoken?language=objc)

The key representing the advertising partner you wish to use for any purchase made through the view controller.

表示你想要用于通过视图控制器进行任何购买的广告合作伙伴的 key。

[SKStoreProductParameterAffiliateToken](https://developer.apple.com/documentation/storekit/skstoreproductparameteraffiliatetoken?language=objc)

The key representing the affiliate identifier you wish to use for any purchase made through the view controller.

表示你想要用于通过视图控制器进行任何购买的代理商的 key。

[SKStoreProductParameterCampaignToken](https://developer.apple.com/documentation/storekit/skstoreproductparametercampaigntoken?language=objc)

The key representing an App Analytics campaign.

表示 App Analytics 活动的 key。

[SKStoreProductParameterProviderToken](https://developer.apple.com/documentation/storekit/skstoreproductparameterprovidertoken?language=objc)

The key representing the provider token for the developer that created the app specified by the 
[SKStoreProductParameterITunesItemIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteritunesitemidentifier?language=objc) key.

表示创建 App 的开发者的提供者 token 的 key。该 App 由 [SKStoreProductParameterITunesItemIdentifier](https://developer.apple.com/documentation/storekit/skstoreproductparameteritunesitemidentifier?language=objc) key 指定。

# See Also - 其他参考

## Loading a New Product Screen - 加载新的产品界面

[- loadProductWithParameters:completionBlock:](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc)

Loads a new product screen to display.

加载新的产品界面以显示。