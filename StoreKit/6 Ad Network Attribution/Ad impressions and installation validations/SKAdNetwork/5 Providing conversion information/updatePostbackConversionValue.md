# updatePostbackConversionValue(_:completionHandler:)

原文地址：[https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:completionhandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:completionhandler:))

Verifies the first launch of an advertised app and, on subsequent calls, updates the conversion value or calls a completion handler if the update fails.

验证广告应用的首次启动，并在后续调用中更新转化值，或者如果更新失败，则调用完成处理程序。

> iOS 15.4+
iPadOS 15.4+
Mac Catalyst 15.4+

```
class func updatePostbackConversionValue(
    _ conversionValue: Int,
    completionHandler completion: (((any Error)?) -> Void)? = nil
)
```
```
class func updatePostbackConversionValue(_ conversionValue: Int) async throws
```

# Parameters

- **conversionValue**

	An unsigned 6-bit value ≥0 and ≤63. The app or the ad network defines the meaning of the conversion value. For ad impressions signed with SKAdNetwork 3 or earlier, you need to increase the conversionValue each time you call this method. For ad impressions signed with SKAdNetwork 4 or later, you may use any valid conversionValue each time you call this method.
	
	一个无符号的 6 位值，≥0 且 ≤63。应用程序或广告网络定义了转化值的含义。对于使用 SKAdNetwork 3 或更早版本签名的广告展示，您需要在每次调用此方法时增加 `conversionValue`。对于使用 SKAdNetwork 4 或更高版本签名的广告展示，您可以在每次调用此方法时使用任何有效的 `conversionValue`。
	
- **completion**

	An optional completion handler you provide to catch and handle any errors this method encounters when you update a conversion value. Set this value to `nil` if you don’t provide a handler.
	
	一个可选的完成处理程序，用于捕获和处理此方法在更新转化值时遇到的任何错误。如果不提供处理程序，请将该值设置为 `nil`。


## Mentioned in - 提及

- [Configuring an advertised app](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app)
- [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)

# Discussion - 讨论

Invalid conversion values cause the method to fail and return error `SKANError.Code.invalidConversionValue`.

无效的转化值会导致该方法失败并返回错误 `SKANError.Code.invalidConversionValue`。

> **Note** **注意**
>
> Consider using [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))) instead of this method for newer implementations.
> 
> 考虑在新实现中使用 [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)) 替代该方法。

Apps call this method to update conversion values as people engage with the app. It’s up to the app or ad network to define the conversion value’s meaning. Call this method immediately when the user first launches the app to confirm the app’s launch. Call this method again, as needed, to reflect the person’s engagement with the app.

应用程序调用此方法来更新转化值，以反映用户与应用程序的互动。由应用程序或广告网络定义转化值的含义。当用户首次启动应用程序时立即调用此方法以确认应用程序的启动。根据需要再次调用此方法，以反映用户与应用程序的互动。

The final conversion value appears in the postback if sending the data meets Apple’s privacy threshold. Only postbacks that win the ad attribution can contain a conversion value. Nonwinning postbacks don’t contain conversion values. For more information, see [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks).

如果发送数据符合苹果的私有阈值，则最终转化值将出现在回传中。只有赢得广告归因的回传才能包含转化值。未赢得的回传不包含转化值。有关更多信息，请参阅《[接收广告归因和回传](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)》。

The way this method behaves depends on the ad’s version, as described in the following sections. Ad networks determine an ad’s version when they sign the ad. For more information about signing ads, see [Signing and providing ads](https://developer.apple.com/documentation/storekit/signing-and-providing-ads).

该方法的行为方式取决于广告的版本，如下节所述。广告网络在对广告签名时确定广告的版本。有关签署广告的更多信息，请参阅《[签署和提供广告](https://developer.apple.com/documentation/storekit/signing-and-providing-ads)》。

## Update the conversion value for version 3 ads and earlier - 更新版本 3 及更早版本广告的转化值

If the ad network signs the winning ad with version 3 or earlier, calling this method behaves as follows:

如果广告网络使用版本 3 或更早版本签署获胜广告，调用此方法的行为如下：

- Apps may call this method repeatedly before a rolling 24-hour timer expires.
- The 24-hour timer restarts each time the app calls this method with a valid `conversionValue` that’s greater than the previous value.
- When the timer expires, the conversion value is final and subsequent calls to updatePostbackConversionValue(_:completionHandler:) have no effect.
- The device sends the postback to the ad network’s URL within 0 to 24 hours after the timer expires. The postback contains the final conversion value only if sending the data meets Apple’s privacy threshold.

- 在滚动的 24 小时计时器到期之前，应用程序可以重复调用此方法。
- 每次应用程序使用大于先前值的有效 `conversionValue` 调用此方法时，24 小时计时器都会重新启动。
- 计时器到期后，转化值是最终值，后续调用 updatePostbackConversionValue(_:completionHandler:) 不会产生任何效果。
- 设备在计时器到期后的 0 到 24 小时内将回传发送到广告网络的 URL。如果发送数据符合苹果的私有阈值，则回传只包含最终转化值。

## Update the conversion value for version 4 ads and later - 更新版本 4 及更高版本广告的转化值

> **Note** **注意**
>
> This method supports ads signed with version 4 and later, however, it doesn’t provide advanced features, such as multiple postbacks and coarse conversion values, available starting in version 4. To get those advanced features for ads signed with version 4 and later, use [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)) instead of this method.
> 
> 该方法支持使用版本 4 及更高版本签署的广告，但不提供高级功能，例如在版本 4 中开始提供的多个回传和粗略转化值。要获取那些针对使用版本 4 及更高版本签署的广告的高级功能，请改用 [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))。

If the ad network signs the winning ad with version 4 or later, calling this method behaves as follows:

如果广告网络使用版本 4 或更高版本签署获胜广告，则调用此方法的行为如下：

- Apps may call this method repeatedly within the first conversion window.
- Provide any `conversionValue` within the valid range; the `conversionValue` doesn’t need to increase with each call.
- This method is available only during the first conversion window. Use [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)) to update conversion values in the subsequent conversion windows.
- When the first conversion window closes, the system sends the postback within 0 to 24 hours. The postback contains the final conversion value only if sending the data meets Apple’s privacy threshold.

- 应用程序可以在第一个转化窗口内重复调用此方法。
- 提供任何在有效范围内的 `conversionValue`；`conversionValue` 不需要在每次调用时增加。
- 此方法仅在第一个转化窗口内可用。在后续转化窗口中更新转化值，请使用 [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))。
- 当第一个转化窗口关闭时，系统将在 0 到 24 小时内发送回传。如果发送数据符合苹果的私有阈值，则回传只包含最终转化值。

# See Also - 其他参考

## Providing Conversion Information - 提供转化信息

### class func [updatePostbackConversionValue(Int, coarseValue: SKAdNetwork.CoarseConversionValue, lockWindow: Bool, completionHandler: (((any Error)?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))

Updates the fine and coarse conversion values and indicates whether to send the postback before the conversion window ends, and calls a completion handler if the update fails.

更新精细和粗略转化价值，并指示在转化窗口结束之前是否发送回传，如果更新失败则调用完成处理程序。

### class func [updatePostbackConversionValue(Int, coarseValue: SKAdNetwork.CoarseConversionValue, completionHandler: (((any Error)?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:))

Updates the fine and coarse conversion values, and calls a completion handler if the update fails.

更新精细和粗略转化价值，并在更新失败时调用完成处理程序。

### struct [CoarseConversionValue](https://developer.apple.com/documentation/storekit/skadnetwork/coarseconversionvalue)

Coarse values to use for updating conversion values.

用于更新转化价值的粗略值。

### class func [updatePostbackConversionValue(Int, completionHandler: ((Error?) -> Void)?)](https://developer.apple.com/documentation/storekit/skadnetwork/3919928-updatepostbackconversionvalue)

Verifies the first launch of an advertised app and on subsequent calls, updates the conversion value or calls a completion hander if the update fails.

验证广告应用的首次启动和后续调用，更新转化值 或 在更新失败时调用完成处理程序。
