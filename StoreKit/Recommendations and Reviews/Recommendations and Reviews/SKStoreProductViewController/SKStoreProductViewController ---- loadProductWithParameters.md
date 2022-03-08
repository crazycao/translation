**Instance Method**

# loadProductWithParameters:completionBlock:

原文地址：[https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/1620632-loadproductwithparameters?language=objc)

> **SDK**
>
> iOS 6.0+
>
> **Framework**
>
> StoreKit
>
> **Class**
>
> SKStoreProductViewController

Loads a new product screen to display.

加载新的产品界面以显示。

# Declaration - 声明

	- (void)loadProductWithParameters:(NSDictionary<NSString *,id> *)parameters 
                  completionBlock:(void (^)(BOOL result, NSError *error))block;

# Parameters - 参数

**parameters**

A dictionary describing the content you want the view controller to display.

描述你希望视图控制器显示的内容的字典。

See [Product Dictionary Keys](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/product_dictionary_keys?language=objc) for keys that describe the product.

描述产品的 key 参见 [Product Dictionary Keys](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/product_dictionary_keys?language=objc)。

See [Ad Network Install Validation Keys](https://developer.apple.com/documentation/storekit/skadnetwork/ad_network_install_validation_keys?language=objc) for keys that describe an impression in an advertising campaign.

描述广告活动中印记的 key 参见 [Ad Network Install Validation Keys](https://developer.apple.com/documentation/storekit/skadnetwork/ad_network_install_validation_keys?language=objc)。

**block**

A block to be called when the product information has been loaded from the App Store. The completion block is called on the main thread and receives the following parameters:

当产品信息已经从 App Store 加载时调用的 block。完成 block 在主线程调用，并收到下列参数：

_result_

YES if the product information was successfully loaded, otherwise NO.

如果产品信息成功加载，为YES。否则为NO。

_error_

If an error occurred, this object describes the error. If the product information was successfully loaded, this value is nil.

如果发生错误，这个对象会描述这个错误。如果产品信息成功加载，这个值为nil。

# Discussion - 讨论

In most cases, you should load the product information and then present the view controller. However, if you load new product information while the view controller is presented, the contents of the view controller are replaced after the new product data is loaded.

在大部分情况下，你应该加载产品信息，然后展示视图控制器。然而，如果你要在视图控制器已经展示时加载新的产品信息，视图控制器的内容将在新的产品数据加载完成时被替换。

# See Also - 其他参考

## Loading a New Product Screen - 加载新的产品界面

[Product Dictionary Keys](https://developer.apple.com/documentation/storekit/skstoreproductviewcontroller/product_dictionary_keys?language=objc)

Keys for identifying products and the tokens for affiliates and campaigns.

标识产品的 key，以及代销商和活动的 token。