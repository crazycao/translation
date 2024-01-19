# Fetching Product Information from the App Store
# 从 App Store 获取产品信息

原文地址：[https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store)

> Technology
>
> StoreKit

Retrieve up-to-date information about the products for sale in your app to display to the user.

检索要向用户显示的在 App 中的销售的产品的最新信息。

# Overview - 概览

To make sure your users see only products that are available for them to purchase, query the App Store before displaying your app’s store UI. Compare the App Store’s list of product identifiers to your local product identifiers. To retrieve a list of your app’s product identifiers, see [https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers).

要确保用户只看到可供其购买的产品，请在展示你的 app 的商店 UI 之前查询 App Store。将 App Store 的产品标识符列表与本地产品标识符进行比较。要检索你的 app 的产品标识符列表，请参阅《[加载应用内产品标识符](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers)》。

## Request Product Information - 请求产品信息

To query the App Store, create an [SKProductsRequest](https://developer.apple.com/documentation/storekit/skproductsrequest) and initialize it with a list of your product identifiers. Keep a strong reference to the request object; otherwise, the system might deallocate the request before it can complete.

要查询 App Store，请创建 [SKProductsRequest](https://developer.apple.com/documentation/storekit/skproductsrequest) 并使用产品标识符列表对其进行初始化。保持对请求对象的强引用；否则，系统可能会在请求完成之前回收请求对象。

The products request retrieves information about valid products, along with a list of invalid product identifiers, and then calls its delegate to process the result. The delegate must implement the [SKProductsRequestDelegate](https://developer.apple.com/documentation/storekit/skproductsrequestdelegate) protocol to handle the response from the App Store. Here’s a simple implementation of both pieces of code:

该产品请求会检索有关有效产品的信息以及无效产品标识符的列表，然后调用其委托来处理结果。委托必须实现 [SKProductsRequestDelegate](https://developer.apple.com/documentation/storekit/skproductsrequestdelegate) 协议来处理来自 App Store 的响应。下面是这两段代码的简单实现：

```
// Keep a strong reference to the product request.
var request: SKProductsRequest!

func validate(productIdentifiers: [String]) {
     let productIdentifiers = Set(productIdentifiers)

     request = SKProductsRequest(productIdentifiers: productIdentifiers)
     request.delegate = self 
     request.start()
}

var products = [SKProduct]()
// Create the SKProductsRequestDelegate protocol method 
// to receive the array of products.
func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    if !response.products.isEmpty {
       products = response.products
       // Implement your custom method here.
       displayStore(products)
    }

    for invalidIdentifier in response.invalidProductIdentifiers {
       // Handle any invalid product identifiers as appropriate.
    }
}
```

Keep a reference to the array of [SKProduct](https://developer.apple.com/documentation/storekit/skproduct) objects that the delegate receives. Use these same product objects to create a payment request when a user purchases a product.

保留对代理接收到的 [SKProduct](https://developer.apple.com/documentation/storekit/skproduct) 对象数组的引用。当用户购买产品时，使用这些相同的产品对象创建付款请求。

If the list of products sold in your app is subject to change, such as when you add or remove a product from sale, consider creating a custom class that encapsulates a reference to the product object along with other information, such as pictures or description text that you fetch from your server. For more information on payment requests, see [Requesting a Payment from the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/requesting_a_payment_from_the_app_store).

如果应用程序中销售的产品列表可能会发生更改，例如当您从销售中添加或删除产品时，请考虑创建一个自定义类，该类封装对产品对象的引用以及其他信息，例如从服务器获取的图片或描述文本。有关付款请求的更多信息，请参阅《[从 App Store 请求付款](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/requesting_a_payment_from_the_app_store)》。

## Troubleshoot Invalid Product IDs - 对无效的产品 ID 进行故障排除

Invalid product identifiers in the App Store response to your products request usually indicate an error in your app’s list of product identifiers. Invalid product identifiers could also mean you configured the product incorrectly in App Store Connect. Actionable UI and insightful logging can help you resolve this type of issue:

App Store 对产品请求的响应中的无效产品标识符，通常表示您的应用程序的产品标识符列表中存在错误。无效的产品标识符也可能意味着您在 App Store Connect 中配置的产品不正确。可操作的 UI 和深入的日志记录可以帮助您解决此类问题：

- In production builds, display your app’s store UI and omit the invalid product.
- In development builds, display an error to call attention to the issue.
- In both production and development builds, use [NSLog](https://developer.apple.com/documentation/foundation/1395275-nslog) to write a message to the console to record the invalid identifier.
- If your app fetches the list from your server, you can define a logging mechanism to let your app send the list of invalid identifiers back to your server.
- Verify that you have a signed Paid Application agreement for your developer account. For more information about this agreement, see [Sign and update agreements](https://help.apple.com/app-store-connect/#/deva001f4a14).

- 在生产版本中，显示应用程序的商店 UI 并忽略无效产品。
- 在开发构建中，显示错误以引起对问题的注意。
- 在生产和开发构建中，使用 [NSLog](https://developer.apple.com/documentation/foundation/1395275-nslog) 向控制台写入消息以记录无效标识符。
- 如果你的应用程序从服务器获取列表，你可以定义一个日志机制，让你的应用程序将无效标识符列表发送回服务器。
- 验证您是否已为开发人员帐户签署了**付费应用程序**协议。有关此协议的更多信息，请参阅《[签署和更新协议](https://help.apple.com/app-store-connect/#/deva001f4a14)》。

For more information about troubleshooting invalid product identifiers, see [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers).

有关排除无效产品标识符故障的更多信息，请参阅 [invalidProductIdentifiers](https://developer.apple.com/documentation/storekit/skproductsresponse/1505985-invalidproductidentifiers)。

# See Also - 其他参考

## Product Information - 产品信息

### [Loading In-App Product Identifiers](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers?language=objc) - 加载应用内产品唯一标识符

Load the unique identifiers for your in-app products in order to retrieve product information from the App Store.

加载应用内产品的唯一标识符，以便从 App Store 检索产品信息。

### [Fetching Product Information from the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store?language=objc) - 从 App Store 获取产品信息

Retrieve up-to-date information about the products for sale in your app to display to the user.

检索要向用户显示的在 App 中的销售的产品的最新信息。

### [SKProductsRequest](https://developer.apple.com/documentation/storekit/skproductsrequest?language=objc)

An object that can retrieve localized information from the App Store about a specified list of products.

可以从 App Store 检索关于指定产品列表的本地化信息的对象。

### [SKProductsResponse](https://developer.apple.com/documentation/storekit/skproductsresponse?language=objc)

An App Store response to a request for information about a list of products.

App Store 对产品列表信息请求的响应。

### [SKProduct](https://developer.apple.com/documentation/storekit/skproduct?language=objc)

Information about a product previously registered in App Store Connect.

先前在 App Store Connect 注册的产品的信息。
包含苹果应用商店店面位置和唯一标识符的对象。