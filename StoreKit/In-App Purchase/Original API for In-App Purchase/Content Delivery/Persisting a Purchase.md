# Persisting a Purchase
# 持久化购买

原文地址：[https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/persisting_a_purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/persisting_a_purchase)

> Technology
>
> StoreKit

Keep a persistent record of a purchase to continue making the product available as needed.

保留一份购买的永久记录，使得产品在需要时继续可用。

# Overview - 概览

After making a product available, your app should make a persistent record of the purchase. Your app uses that persistent record to continue making the product available on launch and to restore purchases. Your app’s persistence strategy depends on the type of products you sell:

在提供产品后，你的应用程序应该持续记录购买情况。您的应用程序在启动和恢复购买时使用该持久记录继续提供产品。你的应用程序的持久性策略取决于你销售的产品类型：

- For non-consumable products and auto-renewable subscriptions, use the app receipt as your persistent record. If the app receipt is not available, use the user defaults system or iCloud to keep a persistent record.
- 对于非消费品和自动续费订阅，请使用应用程序收据作为永久记录。如果应用程序的收据不可用，请使用用户默认系统（UserDefaults）或 iCloud 保存永久记录。
- For non-renewing subscriptions, use iCloud or your own server to keep a persistent record.
- 对于不续费的订阅，请使用 iCloud 或您自己的服务器保存永久记录。
- For consumable products, your app updates its internal state to reflect the purchase. Ensure that the updated state is part of an object that supports state preservation (in iOS) or that you manually preserve the state across app launches (in iOS or macOS).
- 对于消费品，应用程序会更新其内部状态以反映购买情况。确保更新的状态是支持状态保留的对象的一部分（在 iOS 中），或者在应用程序启动时手动保留状态（在 iOS 或 macOS 中）。

When using the user defaults system or iCloud, your app can store a value, such as a number or Boolean, or a copy of the transaction receipt. In macOS, the user can edit the user defaults system using the defaults command. Storing a receipt requires more application logic but prevents the persistent record from being tampered with.

使用用户默认系统或 iCloud 时，你的应用程序可以存储一个值，例如数字或布尔值，或交易凭证的副本。在 macOS 中，用户可以使用 defaults 命令编辑用户默认系统。存储收据需要更多的应用程序逻辑，但可以防止永久记录被篡改。

> **Note** **注意**
> 
> When persisting via iCloud, your app’s persistent record is synced across devices, but your app is responsible for downloading any associated content on other devices.
> 
> 通过 iCloud 进行持久化时，应用程序的持久化记录会跨设备同步，但应用程序要负责在其他设备上下载任何相关内容。

## Persist Purchases Using the App Receipt - 使用 App 收据持久化购买

The app receipt contains a record of the user’s purchases, cryptographically signed by Apple. For more information, see [Choosing a Receipt Validation Technique](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/choosing_a_receipt_validation_technique).

App 收据包含了一份用户购买的记录，由苹果加密签名。更多信息，参见《[选择收据验证技术](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/choosing_a_receipt_validation_technique)》。

Information about consumable products is added to the receipt when they’re paid for and remains in the receipt until you finish the transaction. After you finish the transaction, this information is removed the next time the receipt is updated, such as the next time the user makes a purchase.

消费品的相关信息在付款时被添加到收据中，并保留在收据中，直到您完成交易。完成交易后，该信息将在下次更新收据时删除，例如用户下次购买时。

Information about all other kinds of purchases is added to the receipt when the products are paid for, and remains in the receipt indefinitely.

其他种类的购买的相关信息在付款时被添加到收据中，并无限期的保存在收据中。

## Persist a Value in User Defaults or iCloud -  在 UserDefaults 或 iCloud 中持久化一个值

To store information in user defaults or iCloud, set the value for a key.

要在用户默认系统或 iCloud 中储存信息，只要对一个 key 设置值即可。

```
#if USE_ICLOUD_STORAGE
let storage = NSUbiquitousKeyValueStore.default
#else
let storage = UserDefaults.standard
#endif

storage.set(true, forKey: "enable_rocket_car")
storage.set(highestUnlockedLevel, forKey: "highest_unlocked_level")
```

## Persist Purchases Using Your Own Server - 使用你自己的服务器持久化购买

Send a copy of the receipt to your server along with credentials or an identifier so you can keep track of which receipts belong to a particular user. For example, let users identify themselves to your server with a username and password. Don't use the `identifierForVendor` property of `UIDevice`. Different devices have different values for this property, so you can't use it to identify and restore purchases made by the same user on a different device.

将收据副本连同证书或标识符一起发送到你的服务器，以便跟踪哪些收据属于哪个用户。例如，让用户使用用户名和密码向你的服务器标识自己。不要使用 `UIDevice` 的 `identifierForVendor` 属性。这个属性在不同的设备上会有不同的值，因此你不能用它来标识和恢复同一个用户在不同设备上的购买。

# See Also - 其他参考

## Content Delivery - 内容交付

### [Unlocking Purchased Content](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/unlocking_purchased_content?language=objc) - 解锁已购买的内容

Deliver content to the user after validating the purchase.

在验证购买后向用户交付内容。

### [Persisting a Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/persisting_a_purchase?language=objc) - 持久化购买

Keep a persistent record of a purchase to continue making the product available as needed.

保留一份购买的永久记录，使得产品在需要时继续可用。

### [Finishing a Transaction](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/finishing_a_transaction?language=objc) - 完成交易

Finish the transaction to complete the purchase process.

完成交易以完成购买流程。

### [SKDownload](https://developer.apple.com/documentation/storekit/skdownload?language=objc)

Downloadable content associated with a product.

与产品关联的可下载内容。
