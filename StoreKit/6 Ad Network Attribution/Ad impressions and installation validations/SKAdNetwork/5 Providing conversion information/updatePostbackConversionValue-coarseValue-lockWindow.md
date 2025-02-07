# updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)

原文地址：[https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))

Updates the fine and coarse conversion values and indicates whether to send the postback before the conversion window ends, and calls a completion handler if the update fails.

更新精细和粗略转化值，并指示是否在转化窗口结束之前发送回传，并在更新失败时调用完成处理程序。

> iOS 16.1+
iPadOS 16.1+
Mac Catalyst 16.1+

```
class func updatePostbackConversionValue(
    _ fineValue: Int,
    coarseValue: SKAdNetwork.CoarseConversionValue,
    lockWindow: Bool,
    completionHandler completion: (((any Error)?) -> Void)? = nil
)
```
```
class func updatePostbackConversionValue(
    _ fineValue: Int,
    coarseValue: SKAdNetwork.CoarseConversionValue,
    lockWindow: Bool
) async throws
```

# Parameters

- **fineValue**

	An unsigned 6-bit value ≥0 and ≤63. The app or the ad network defines the meaning of the fine conversion value.
	
	一个无符号的 6 位值，≥0 且 ≤63。应用程序或广告网络定义了精细转化值的含义。

- **coarseValue**

	An [SKAdNetwork.CoarseConversionValue](https://developer.apple.com/documentation/storekit/skadnetwork/coarseconversionvalue) value of `low`, `medium`, or `high`. The app or the ad network defines the meaning of the coarse conversion value.
	
	一个 [SKAdNetwork.CoarseConversionValue](https://developer.apple.com/documentation/storekit/skadnetwork/coarseconversionvalue) 值，可以是 `low`、`medium` 或 `high`。应用程序或广告网络定义了粗略转化值的含义。

- **lockWindow**

	A Boolean value that indicates whether to send the postback before the conversion window ends. Use `true` to tell the system to send the postback without waiting for the end of the conversion window. The default value is `false`.
	
	一个布尔值，指示是否在转化窗口结束之前发送回传。使用 `true` 告诉系统在不等待转化窗口结束的情况下发送回传。默认值为 `false`。

- **completion**

	An optional completion handler you provide to catch and handle any errors this method encounters when you update a conversion value. Set this value to `nil` if you don’t provide a handler.
	
	一个可选的完成处理程序，用于捕获和处理此方法在更新转化值时遇到的任何错误。如果不提供处理程序，请将该值设置为 `nil`。


## Mentioned in - 提及

- [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows)
- [SKAdNetwork 4 release notes](https://developer.apple.com/documentation/storekit/skadnetwork-4-release-notes)
- [Identifying the parameters in install-validation postbacks](https://developer.apple.com/documentation/storekit/identifying-the-parameters-in-install-validation-postbacks)
- [Configuring an advertised app](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app)
- [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)

# Discussion - 讨论

Call this method when the user first launches an app to register the app installation, and again to update conversion values as the user engages with the app. It’s up to your app to decide what the conversion values signify in your app, both the `fineValue` and the `coarseValue`.

当用户首次启动应用程序时调用此方法以注册应用安装，随着用户使用应用程序，再次调用以更新转化值。您的应用程序可以决定转化值在您的应用程序中的含义，包括 `fineValue` 和 `coarseValue`。

This method supports ads signed with any verison of SKAdNetwork, and you can use it instead of calling [updatePostbackConversionValue(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:completionhandler:)) and [updatePostbackConversionValue(_:coarseValue:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:)). The system automatically determines the method’s behavior based on the ad’s version, as the following sections describe — the app doesn’t need to know the ad version. To take advantage of the multiple postbacks available starting in version 4, use this method or [updatePostbackConversionValue(:coarseValue:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:)).

此方法支持使用任何 SKAdNetwork 版本签署的广告，您可以使用它来替代调用 [updatePostbackConversionValue(:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:completionhandler:)) 和 [updatePostbackConversionValue(:coarseValue:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:))。系统根据广告版本自动确定方法的行为，如下面的部分所述——应用程序无需知道广告版本。要采用从版本 4 开始提供的多个回传，请使用此方法或 [updatePostbackConversionValue(:coarseValue:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:))。

This method returns [SKANError.Code.invalidConversionValue](https://developer.apple.com/documentation/storekit/skanerror-swift.struct/code/invalidconversionvalue) if the `fineValue` is outside of the allowed range.

如果 `fineValue` 超出允许范围，此方法将返回 [SKANError.Code.invalidConversionValue](https://developer.apple.com/documentation/storekit/skanerror-swift.struct/code/invalidconversionvalue)。

> **Important** **重要**
>
> The system ignores calls to this method if the `fineValue` is outside of the valid range. Valid conversion updates your app sends before or after an invalid conversion remain available.
> 
> 如果 `fineValue` 超出有效范围，系统将忽略对此方法的调用。您的应用程序在无效转化之前或之后发送的有效转化更新仍然可用。（即使发生了无效的转化，之前或之后的有效转化数据仍然会被保留并可用。）

## Update the conversion value for version 4 ads and later - 更新版本 4 及更高版本广告的转化值

For ads that ad networks sign using version 4 or later, calling this method behaves as follows:

对于广告网络使用版本 4 或更高版本签署的广告，调用此方法的行为如下：

- Both the `fineValue` and `coarseValue` represent conversion values. The method ignores the `fineValue` after the first conversion window.
- Setting the `lockWindow` parameter to `true` indicates a final update for the conversion value for the current conversion window. The system ignores additional calls to update the conversion value until the end of the conversion window.
- Setting the `lockWindow` parameter to `false` continues updating the conversion value throughout the conversion window.

- `fineValue` 和 `coarseValue` 都代表转化值。在第一个转化窗口后，该方法会忽略 `fineValue`。
- 将 `lockWindow` 参数设置为 `true` 表示对当前转化窗口的转化值进行最终更新。系统会忽略在转化窗口结束之前对转化值的其他更新调用。
- 将 `lockWindow` 参数设置为 `false` 可以在整个转化窗口期间继续更新转化值。

For information about the data you may receive in postbacks, see [Receiving postbacks in multiple conversion windows](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows).

关于您可能在后续操作中收到的数据的信息，请参阅《[在多个转化窗口中接收后续操作](https://developer.apple.com/documentation/storekit/receiving-postbacks-in-multiple-conversion-windows)》。

## Update the conversion value for version 3 ads and earlier - 更新版本 3 及更早版本广告的转化值

For ads that ad networks sign using version 3 or earlier, calling this method behaves as follows:

对于广告网络使用版本 3 或更早版本签署的广告，调用此方法的行为如下：

- The `fineValue` represents the conversion value.
- The method ignores the `coarseValue` and `lockWindow` parameters.
- There’s a single conversion period that ends after a rolling 24-hour timer expires. The 24-hour timer restarts each time the app calls this method with a valid conversion value greater than the previous value. When the timer expires, the conversion value is final and subsequent calls to this method have no effect.
- The device sends the postback 0–24 hours after the timer expires.
- The postback contains the final conversion value only if the postback data tier contains the value.

- `fineValue` 代表转化值。
- 该方法会忽略 `coarseValue` 和 `lockWindow` 参数。
- 存在一个单一的转化期，在滚动的 24 小时计时器到期后结束。每次应用程序使用大于先前值的有效转化值调用此方法时，24 小时计时器都会重新启动。当计时器到期时，转化值是最终的，随后对此方法的调用不会产生任何效果。
- 设备在计时器到期后的 0-24 小时内发送后续操作。
- 仅当回传数据层包含最终转化值时，回传中才会包含该值。

For more information about SKAdNetwork versions, see [SKAdNetwork release notes](https://developer.apple.com/documentation/storekit/skadnetwork-release-notes).

有关 SKAdNetwork 版本的更多信息，请参阅《[SKAdNetwork 发行说明](https://developer.apple.com/documentation/storekit/skadnetwork-release-notes)》。

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
