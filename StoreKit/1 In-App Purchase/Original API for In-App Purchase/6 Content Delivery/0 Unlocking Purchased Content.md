# Unlocking Purchased Content
# 解锁已购买的内容

原文地址：[https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/unlocking_purchased_content](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/unlocking_purchased_content)

> Technology
>
> StoreKit

Deliver content to the user after validating the purchase.

在验证购买后向用户交付内容。

# Overview - 概览

Once a purchase is completed, it's your responsibility to make sure that you programmatically make the content available to the user.

一旦购买完成，你就要负责确保以编程方式向用户提供可用的内容。

## Identify the Purchased Content - 标识已购买的内容

For an in-app purchase product that enables app functionality, such as a premium subscription, set a Boolean value to enable the code path and update your user interface as needed. Consult a persistent record of transactions that occur in your app to determine the functionality to unlock. Your app must update this Boolean value whenever the user completes a purchase and at app launch. For information on making a persistent record, see [Persisting a Purchase](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/persisting_a_purchase).

对于启用应用程序功能的应用程序内购买产品，如高级版的订阅，请设置布尔值以启用代码路径，并根据需要更新用户界面。查阅应用程序中发生的交易的持久记录，以确定要解锁的功能。每当用户完成购买和应用程序启动时，应用程序必须更新此布尔值。有关创建持久记录的信息，请参阅《[持久化购买](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/persisting_a_purchase)》。

For example, using the app receipt, your code might look like the following:

例如，使用 app 收据时，你的代码可能像下面这样：

```
guard let receiptURL = Bundle.main.appStoreReceiptURL else { customError() }
do {
    let receiptData = try Data(contentsOf: receiptURL)
    // Custom method to work with receipts
    // 自定义方法处理收据
    let rocketCarEnabled = receipt(receiptData, includesProductID: "com.example.rocketCar")
} catch {
    print(error)
}
```
   
Or, using the user defaults system:

或者，使用用户默认系统：

```
let defaults = UserDefaults.standard
let rocketCarEnabled = defaults.bool(forKey: "enable_rocket_car")
```

After you define the Boolean variable, use the purchase information to enable the appropriate code paths in your app:

定义布尔变量后，在应用程序中使用购买信息启用适当的代码路径：

```
if (rocketCarEnabled) {
    // Use the rocket car.
    // 使用火箭车。
} else {
    // Use the regular car.
    // 使用普通车。
}
```

## Deliver Associated Content - 交付相关内容

Your app must deliver any content associated with the purchased product to the user. For example, purchasing instruments in a music app requires delivering the sound files needed to let the user play those instruments. You can embed that content in your app’s bundle or download it as needed. Each approach has its advantages and disadvantages.

你的应用程序必须向用户交付与购买产品相关的内容。例如，在音乐应用程序中购买乐器需要交付让用户演奏这些乐器所需的声音文件。您可以将该内容嵌入应用程序包中，或根据需要下载。每种方法都有其优缺点。

Embed smaller files (up to a few megabytes) in your app, especially if you expect most users to buy that product. You can make the content in your app bundle available immediately after the user purchases it. However, to add or update content in your app bundle, you must submit an updated version of your app.

可以在你的应用程序中嵌入较小的文件（最多可达几兆字节），尤其是当你希望大多数用户购买该产品时。在用户购买后，您可以立即让 app 包中的内容可用。但是，要在 app 包中添加或更新内容，就必须提交应用程序的更新版本。

Download larger files only when needed. Separating content from your app bundle keeps your app’s initial download small. For example, a game can include the first level in its app bundle and let users download additional levels as they purchase them. Assuming your app fetches its list of product identifiers from your server and the information isn't hard-coded in the app bundle, you don't need to resubmit your app to add or update content that your app downloads.

仅在需要时下载较大的文件。将内容与 app 包分离，可以保持 app 的初始包很小。例如，一款游戏可以在其应用程序包中包含第一个关卡，并让用户在购买时再下载其他关卡。假设你的应用程序从你的服务器获取了它的产品标识符列表，并且信息没有硬编码在应用程序包中，你就不需要重新提交应用程序来添加或更新应用程序要下载的内容。

> **Note** **注意**
> 
> You can’t patch your app binary or download executable code. Your app must contain all executable code needed to support all of its functionality when you submit it. If a new product requires code changes, submit an updated version of your app.
> 
> 你无法修补你的应用程序二进制文件或下载可执行代码。提交应用程序时，应用程序必须包含支持其所有功能所需的所有可执行代码。如果新产品需要更改代码，请提交应用程序的更新版本。

## Load Local Content - 加载本地内容

Load local content using the `NSBundle` class as you load other resources from your app bundle.

使用 `NSBundle` 类加载本地内容，就像你从 app 包中加载其他资源一样。

```
guard let url = Bundle.main.url(forResource: "rocketCar", withExtension: "plist") else { fatalError() }
loadVehicle(at: url)
```

## Download Hosted Content from Apple’s Server - 从苹果服务器下载托管的内容

Most apps should use Apple-hosted content for downloaded files. You create an Apple-hosted content bundle using the In-App Purchase Content target in Xcode and submit it to App Store Connect. Apple's servers store your app’s content using the same infrastructure that supports other large-scale operations, such as the App Store. Apple-hosted content automatically downloads in the background even if your app is not running.

大多数应用程序应该使用苹果托管内容下载文件。您可以在 Xcode 中使用应用内购买内容 target 创建苹果托管的内容包，并将其提交给 App Store Connect。苹果的服务器会使用支持其他大规模操作（如应用商店）的相同基础设施存储应用的内容。即使你的应用程序没有运行，苹果托管的内容也会在后台自动下载。

If you need to support older versions of iOS or share your server infrastructure across multiple platforms, you may choose to host your own content using your own server infrastructure.

如果您需要支持 iOS 的旧版本，或者跨多个平台共享服务器基础设施，您可以选择使用自己的服务器基础设施托管自己的内容。

When the user purchases a product that has associated Apple-hosted content, the transaction passed to your transaction queue observer also includes an instance of [SKDownload](https://developer.apple.com/documentation/storekit/skdownload) that lets you download the associated content.

当用户购买已经与苹果托管内容关联的产品时，传递给交易队列观察者的交易还包括一个 [SKDownload](https://developer.apple.com/documentation/storekit/skdownload) 实例，该实例允许您下载关联的内容。

To download the content, add the download objects from the transaction’s [downloads](https://developer.apple.com/documentation/storekit/skpaymenttransaction/1411282-downloads) property to the transaction queue by calling the [start(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505998-start) method of [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue). If the value of the `downloads` property is `nil`, there’s no Apple-hosted content for that transaction. Unlike downloading apps, downloading content does not automatically require a Wi-Fi connection for content larger than a certain size. Avoid using cellular networks to download large files without an explicit action from the user.

要下载内容，请通过调用 [SKPaymentQueue](https://developer.apple.com/documentation/storekit/skpaymentqueue) 的 [start(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1505998-start) 方法将下载对象从交易的 [downloads](https://developer.apple.com/documentation/storekit/skpaymenttransaction/1411282-downloads) 属性添加到交易队列中。如果 `downloads` 属性的值为 `nil`，则说明该交易没有苹果托管的内容。与下载应用程序不同，下载内容时并不会自动在超过一定大小的内容时要求连接 Wi-Fi。请避免在没有用户明确操作的情况下使用蜂窝网络下载大型文件。

> **Note** **注意**
> 
> Alternatively, you can use [On-Demand Resources(ODR)](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/On_Demand_Resources_Guide/index.html) for more flexibility in downloading data in your app. ODR is an Apple-hosted service you can use to store in-app purchase data for the user to download content once you've verified the user's purchase using the app receipt. The advantage of this alternative over SKDownload is that ODR doesn't require you to call to restore transactions and authenticate the user to download content hosted on Apple's server.
> 
> 或者，您也可以使用[按需资源（ODR）](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/On_Demand_Resources_Guide/index.html)，以便在应用程序中下载数据时更加灵活。ODR是一个苹果托管的服务，你可以使用它来存储应用内购买数据，以便用户在使用应用收据验证用户购买后下载内容。与 SKDownload 相比，这种替代方案的优势在于，ODR不需要您调用方法来恢复事务，也不需要验证用户以下载苹果服务器上托管的内容。

Implement the [paymentQueue(_:updatedDownloads:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506073-paymentqueue) method on the transaction queue observer to respond to changes in a download’s state, such as by updating progress in your UI. If a download fails, use the information in its error property to present the error to the user.

在交易队列观察者中实现 [paymentQueue(_:updatedDownloads:)](https://developer.apple.com/documentation/storekit/skpaymenttransactionobserver/1506073-paymentqueue) 方法以响应下载状态的更改，例如更新 UI 中的进度。如果下载失败，使用其 [error](https://developer.apple.com/documentation/storekit/skdownload/1458914-error) 属性中的信息向用户显示错误。

Ensure that your app handles errors gracefully. For example, if the device runs out of disk space during a download, give the user the option to discard the partial download or to resume the download later when space becomes available.

确保你的应用程序优雅地处理错误。例如，如果设备在下载过程中磁盘空间不足，则允许用户放弃部分下载，或在空间可用时继续下载。

While the content is downloading, update your user interface using the values of the [progress](https://developer.apple.com/documentation/storekit/skdownload/1458945-progress) and [timeRemaining](https://developer.apple.com/documentation/storekit/skdownload/1458943-timeremaining) properties. You can use the [pause(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506053-pause), [resume(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506096-resume), and [cancel(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506092-cancel) methods of `SKPaymentQueue` from your UI to let the user control in-progress downloads. Use the [downloadState](https://developer.apple.com/documentation/storekit/skdownload/1620412-downloadstate) property to determine whether the download has completed. Don’t use the `progress` or `timeRemaining` property of the download object to check its status; these properties are for updating your UI.

下载内容时，使用 [progress](https://developer.apple.com/documentation/storekit/skdownload/1458945-progress) 和 [timeRemaining](https://developer.apple.com/documentation/storekit/skdownload/1458943-timeremaining) 属性的值更新用户界面。您可以使用 `SKPaymentQueue` 的 [pause(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506053-pause)、[resume(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506096-resume) 和  [cancel(_:)](https://developer.apple.com/documentation/storekit/skpaymentqueue/1506092-cancel) 方法，让用户从 UI 中控制正在进行的下载。使用 [downloadState](https://developer.apple.com/documentation/storekit/skdownload/1620412-downloadstate) 属性确定下载是否已完成。不要使用下载对象的 `progress` 或 `timeRemaining` 属性来检查其状态；这些属性用于更新用户界面。

> **Important** **重要**
> 
> Download all Apple-hosted content before finishing the transaction. After a transaction is complete, its download objects become unusable.
> 
> 在完成交易之前下载所有的苹果托管内容。在完成交易后，其下载对象就不可用了。

In iOS, your app can manage the downloaded files. The StoreKit framework saves these files for you in the `Caches` directory with the backup flag unset. After the download completes, your app is responsible for moving these files to the appropriate location. For content that can be deleted if the device runs out of disk space (and downloaded again later by your app), keep the files in the `Caches` directory. Otherwise, move the files to the `Documents` folder and set the flag to exclude them from user backups.

在 iOS 中，你的应用程序可以管理已下载的文件。StoreKit 框架将这些文件保存在 `Caches` 目录中，未设置备份标志。下载完成后，你的应用程序负责将这些文件移动到适当的位置。对于设备磁盘空间不足时可以删除的内容（应用程序稍后会再次下载），请将文件保留在  `Caches` 目录中。否则，请将文件移动到 `Documents` 文件夹，并设置标志以将其从用户备份中排除。

```
// This is the downloaded content url.
guard var url = download.contentURL else { fatalError() }

var resourceValues = URLResourceValues()
resourceValues.isExcludedFromBackup = true

do {
    try url.setResourceValues(resourceValues)
} catch {
    print(error)
}
```

In macOS, the system manages the downloaded files; your app can’t move or delete them directly. To locate the content after downloading it, use the [contentURL](https://developer.apple.com/documentation/storekit/skdownload/1458930-contenturl) property of the download object. To locate the file on subsequent launches, use the [contentURL(forProductID:)](https://developer.apple.com/documentation/storekit/skdownload/1458924-contenturl) class method of `SKDownload`. To delete a file, use the [deleteContent(forProductID:)](https://developer.apple.com/documentation/storekit/skdownload/1458926-deletecontent) class method. For information about reading the app receipt, see [Validating Receipts with the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/validating_receipts_with_the_app_store).

在 macOS 中，由系统管理下载的文件；你的应用程序无法直接移动或删除它们。要在下载后定位下载的内容，请使用下载对象的 [contentURL](https://developer.apple.com/documentation/storekit/skdownload/1458930-contenturl) 属性。要在后续启动时找到该文件，请使用 `SKDownload` 的 [contentURL(forProductID:)](https://developer.apple.com/documentation/storekit/skdownload/1458924-contenturl) 类方法。要删除文件，请使用 [deleteContent(forProductID:)](https://developer.apple.com/documentation/storekit/skdownload/1458926-deletecontent) 类方法。有关读取应用收据的信息，请参阅《[使用应用商店验证收据](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/validating_receipts_with_the_app_store)》。

## Download Content from Your Own Server - 从你自己的服务器下载内容

As with all other interactions between your app and your server, the details and mechanics of the process of downloading content from your own server are your responsibility. The communication consists of, at a minimum, the following steps:

与应用程序和服务器之间的所有其他交互一样，从你自己的服务器下载内容的过程的细节和机制由你自己负责。通信应至少包括以下步骤：

1. Your app sends the receipt to your server and requests the content.
2. Your server validates the receipt to establish that the content has been purchased, as described in [Validating Receipts with the App Store](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/validating_receipts_with_the_app_store).
3. Assuming the receipt is valid, your server responds to your app with the content.

>

1. App 将收据发送到服务器并请求内容。
2. 服务器验证收据以确定内容已购买，如《[使用应用商店验证收据](https://developer.apple.com/documentation/storekit/original_api_for_in-app_purchase/validating_receipts_with_the_app_store)》中所述。
3. 假设收据有效，你的服务器会用内容回复给 app。

Ensure that your app handles errors gracefully. For example, if the device runs out of disk space during a download, give the user the option to discard the partial download or to resume the download later when space becomes available.

确保你的应用程序优雅地处理错误。例如，如果设备在下载过程中磁盘空间不足，则允许用户放弃部分下载，或在空间可用时继续下载。

Consider the security implications of how you host your content and how your app communicates with your server. For more information, see [Security Overview](https://developer.apple.com/library/archive/documentation/Security/Conceptual/Security_Overview/Introduction/Introduction.html#//apple_ref/doc/uid/TP30000976).

考虑一下如何托管您的内容以及应用程序如何与服务器通信的安全含义。更多相关信息，请参阅《[安全概述](https://developer.apple.com/library/archive/documentation/Security/Conceptual/Security_Overview/Introduction/Introduction.html#//apple_ref/doc/uid/TP30000976)》。

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
