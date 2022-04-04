# Loading In-App Product Identifiers
# 加载应用内产品标识符

原文地址：[https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers?language=objc](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers?language=objc)

> Technology
>
> StoreKit

Load the unique identifiers for your in-app products in order to retrieve product information from the App Store.

加载应用内产品的唯一标识符，以便从 App Store 检索产品信息。

# Overview - 概览

Implementing an in-app purchase flow can be divided into three stages. In the first stage of the purchase process, your app retrieves information about its products from the App Store, presents its store UI to the user, and lets the user select products. Your app requests payment when the user selects a product in your app's store, and finally, your app delivers the product. The steps performed by your app and the App Store in the first stage are highlighted in Figure 1.

实现应用内购买工作流可以被分为三个阶段。在购买过程的第一阶段，你的 app 从应用商店检索关于产品的信息，向用户展示其商店 UI，并让用户选择产品。当用户在你的 app 的商店中选择了一个产品时，你的 app 就请求支付；并且，最后将由你的 app 交付产品。图1突出显示了应用程序和应用商店在第一阶段执行的步骤。

**Figure 1** Begin the purchase process by retrieving product information from the App Store

**图1** 通过从 App Store 检索产品信息开始购买过程

![A flow chart depicting the steps of the in-app purchase process. The product information retrieval stage is diagrammed as three steps between your app and the App Store. First, your app makes a request for a product; the App Store provides the product information requested; and finally, your app displays its store UI with the product information.](https://docs-assets.developer.apple.com/published/d3a9466a13/IAPPG-migration-3~dark@2x.png)

To begin the purchase process, your app must know its product identifiers so it can retrieve information about the products from the App Store and present its store UI to the user. Every product sold in your app has a unique product identifier. You provide this value in App Store Connect when you create a new in-app purchase product (see [Create an In-App Purchase](https://help.apple.com/app-store-connect/#/devae49fb316) for more information). Your app uses these product identifiers to fetch information about products available for sale in the App Store, such as pricing, and to submit payment requests when users purchase those products.

要开始购买过程，你的应用程序必须知道它的产品标识符，这样它就可以从 App Store 中检索有关产品的信息，并向用户展示其商店界面。App 中销售的每个产品都有一个唯一的产品标识符。创建新的应用内购买产品时，您要在 App Store Connect 中提供此值（有关更多信息，请参阅《[创建应用内购买](https://help.apple.com/app-store-connect/#/devae49fb316)》）。你的 app 使用这些产品标识符获取 App Store 中可供销售的产品的信息，如价格，并在用户购买这些产品时提交付款请求。

There are several strategies for storing a list of product identifiers in your app, such as embedding in the app bundle or storing on your server. You can then retrieve the product identifiers by reading them locally in the app bundle or fetching them from your server. Choose the method that best serves your app's needs.

在应用程序中存储产品标识符列表有几种策略，例如嵌入 app 包里或存储在服务器上。然后，您可以在应用程序包中本地读取或者从服务器获取来检索产品标识符。可以选择最能满足应用需求的方法。

> **Note 注意**
>
> There is no runtime mechanism to fetch a list of all products configured in App Store Connect for a particular app. You are responsible for managing your app’s list of products and providing that information to your app. If you need to manage a large number of products, consider using the bulk XML upload/download feature in App Store Connect.
> 
> 没有运行时机制来获取在 App Store Connect 中为特定应用配置的所有产品的列表。您负责管理应用程序的产品列表，并将该信息提供给应用程序。如果需要管理大量产品，请考虑在 App Store Connect 中使用大容量 XML 上传/下载功能。

## Retrieve Product IDs from the App Bundle - 从 App 包里检索产品ID

Embed the product identifiers in your app bundle if:

如果你的 app 符合以下条件，建议把产品标识符嵌入你的 app 包中：

- Your app has a fixed list of in-app purchase products. For example, apps with an in-app purchase to remove ads or unlock functionality can embed the product identifier list in the app bundle.
- 你的 app 有一个固定的应用内产品列表。例如，通过应用内购买移除广告或者解锁功能的 app 可以把产品标识符列表嵌入 app 包里。
- You expect users to update the app in order to see new in-app purchase products.
- 你希望用户更新 app 才能看到新的应用内购买产品。
- The app or product does not require a server.
- 你的 app 或产品不依赖服务端。

Include a property list file in your app bundle containing an array of product identifiers, such as the following:

在应用程序包中包含一个属性列表文件，其中包含一系列产品标识符，例如：

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
    <string>com.example.level1</string>
    <string>com.example.level2</string>
    <string>com.example.rocket_car</string>
</array>
</plist>
```

To get product identifiers from the property list, locate the file in the app bundle and read it.

要从属性列表中获取产品标识符，请在应用程序包中找到该文件并读取它。

```
NSURL *url = [[NSBundle mainBundle] URLForResource:@"product_ids"
                                     withExtension:@"plist"];
NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
```

## Retrieve Product IDs from Your Server - 从服务端检索产品ID

Store the product identifiers on your server if:

如果你的 app 符合以下条件，建议把产品标识储存在服务端：

- You update the list of in-app products frequently, without updating your app. For example, games that supports additional levels or characters should fetch the product identifiers list from your server.
- 你会频繁的更新应用内产品列表，而不更新 app。例如，支持附加关卡或角色的游戏应该从服务器获取产品标识符列表。
- The products consist of delivered content.
- 产品由交付的内容组成。
- Your app or product requires a server.
- 你的 app 或产品依赖服务端。

Host a JSON file on your server with the product identifiers. For example, the following JSON file contains three product IDs:

在服务器上托管一个带有产品标识符的JSON文件。例如，下面的JSON文件包含三个产品ID：

```
[
    "com.example.level1",
    "com.example.level2",
    "com.example.rocket_car"
]

```

To get product identifiers from your server, fetch and read the JSON file.

要从服务器获取产品标识符，请获取并读取 JSON 文件。

```
- (void)fetchProductIdentifiersFromURL:(NSURL *)url delegate:(id)delegate
{
    dispatch_queue_t global_queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global_queue, ^{
        NSError *err;
        NSData *jsonData = [NSData dataWithContentsOfURL:url
                                                 options:NULL
                                                   error:&err];
        if (!jsonData) { /* Handle the error. */ }

        NSArray *productIdentifiers = [NSJSONSerialization
            JSONObjectWithData:jsonData options:NULL error:&err];
        if (!productIdentifiers) { /* Handle the error. */ }

        dispatch_queue_t main_queue = dispatch_get_main_queue();
        dispatch_async(main_queue, ^{
            [delegate displayProducts:productIdentifiers]; // Custom method.
        });
    });
}

```

Consider versioning the JSON file so that future versions of your app can change its structure without breaking older versions of your app. For example, you could name the file that uses the old structure `products_v1.json` and the file that uses a new structure products_v2.json. This is especially useful if your JSON file is more complex than the simple array in the example.

考虑对 JSON 文件进行版本化，以便应用程序的未来版本能够更改其结构，而不必破坏旧版本的应用程序。例如，可以将使用旧结构的文件命名为 `products_v1.json`，而将使用新结构的文件命名为 `products_v2.json`。如果你的 JSON 文件比示例中的简单数组更复杂，这一点尤其有用。

To ensure that your app remains responsive, use a background thread to download the JSON file and extract the list of product identifiers. To minimize the data transferred, use standard HTTP caching mechanisms, such as the `Last-Modified` and `If-Modified-Since` headers.

为了确保应用程序保持响应，请使用后台线程下载 JSON 文件并提取产品标识符列表。为了尽可能减少传输的数据，请使用标准的HTTP缓存机制，例如使用 `Last-Modified` 和 `If-Modified-Since` 请求头。

After loading all in-app product identifiers, pass them into the product information request to the App Store. For details on obtaining product information, see [Fetching Product Information from the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store?language=objc).

加载所有应用内产品标识符后，将其传递到应用商店的产品信息请求中。有关获取产品信息的详细信息，请参阅《[从App Store获取产品信息](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store?language=objc)》。

# See Also - 其他参考

## Product Information - 产品信息

### [Loading In-App Product Identifiers](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/loading_in-app_product_identifiers?language=objc) - 加载应用内产品唯一标识符

Load the unique identifiers for your in-app products in order to retrieve product information from the App Store.

加载应用内产品的唯一标识符，以便从 App Store 检索产品信息。

### [Fetching Product Information from the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/fetching_product_information_from_the_app_store?language=objc) - 从 App Store 获取产品信息

Retrieve up-to-date information about the products for sale in your app to display to the user.

在应用程序中检索要向用户显示的待售产品的最新信息。

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