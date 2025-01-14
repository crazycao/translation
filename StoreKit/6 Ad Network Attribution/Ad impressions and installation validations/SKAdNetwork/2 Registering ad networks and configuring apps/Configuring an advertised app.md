# Configuring an advertised app
# 配置广告应用

原文地址：[https://developer.apple.com/documentation/storekit/configuring-an-advertised-app](https://developer.apple.com/documentation/storekit/configuring-an-advertised-app)

Prepare an advertised app to participate in ad campaigns.

准备广告应用以参与广告活动。

# Overview - 概览

An advertised app is an app a user installs after viewing an ad that an ad network signs. The advertised app doesn’t require any configuration to participate in install validation. However, to register ad attributions, the app needs to call one of the methods that update conversion values when the app first launches. Those methods are: [updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:)), [updatePostbackConversionValue(_:coarseValue:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:)), and [updatePostbackConversionValue(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:completionhandler:)).

一个被广告应用是用户在查看广告后安装的应用程序，该广告是广告网络签署的。被广告应用不需要任何配置来参与安装验证。然而，为了注册广告归因，应用程序需要在它首次启动时调用其中一个更新转化值的方法。这些方法包括：[updatePostbackConversionValue(_:coarseValue:lockWindow:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:lockwindow:completionhandler:))、[updatePostbackConversionValue(_:coarseValue:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:coarsevalue:completionhandler:)) 和  [updatePostbackConversionValue(_:completionHandler:)](https://developer.apple.com/documentation/storekit/skadnetwork/updatepostbackconversionvalue(_:completionhandler:))。

Developers opt in to get copies of winning install-validation postbacks.

开发人员可以选择接收获胜的安装验证回传的副本。

## Configure your app to receive copies of winning install-validation postbacks - 配置您的应用以接收获胜的安装验证回传的副本

To opt in to receive copies of winning install-validation postbacks for your advertised app, add the [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSAdvertisingAttributionReportEndpoint) key in your app’s `Info.plist` file, and configure your server to receive the postbacks.

要选择接收您的被广告应用程序的获胜的安装验证回传的副本，请在您的应用程序的 `Info.plist` 文件中添加 [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSAdvertisingAttributionReportEndpoint) 键，并配置您的服务器以接收这些回传。

To add the key in your app’s `Info.plist` file:

1. Select `Info.plist` in the Project navigator in Xcode.
2. Click the Add button (`+`) beside a key in the property list editor and press Return.
3. Type the key name [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSAdvertisingAttributionReportEndpoint).
4. Choose String from the pop-up menu in the Type column.
5. Type a valid URL in the format of “`https://example.com`” that contains your domain name in place of `example.com`.

要在您的应用程序的 `Info.plist` 文件中添加该键：

1. 在 Xcode 的项目导航器中选择 `Info.plist`。
2. 点击属性列表编辑器中键旁边的添加按钮（`+`），然后按回车键。
3. 输入键名 [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSAdvertisingAttributionReportEndpoint)。
4. 在类型列的弹出菜单中选择字符串。
5. 以“`https://example.com`”的格式输入一个有效的 URL，将 `example.com` 替换为您的域名。

For more information about editing property lists, see [Edit property lists](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6).

要了解有关编辑属性列表的更多信息，请查看《[编辑属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)》。

The system uses the registrable part of the domain name you provide in the key, and ignores any subdomains. Using your domain name, the system generates a `well-known path` and sends postbacks to that URL. To receive postbacks, your domain needs to have a valid SSL certificate. Configure your server to accept HTTPS POST messages at the following well-known path:

系统将使用您在键中提供的域名的可注册部分，并忽略任何子域。使用您的域名，系统会生成一个 `well-known` 路径，并将回传发送到该 URL。要接收这些回传，您的域名需要具有有效的 SSL 证书。请在下面的 well-known 路径配置您的服务器以接受 HTTPS POST 消息：

```
https://example.com/.well-known/skadnetwork/report-attribution/
```

Replace `example.com` with your domain name.

请将 `example.com` 替换为您的域名。

For more information about receiving postbacks, see [Receiving ad attributions and postbacks](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks).

要了解关于接收回传的更多信息，请查看《[接收广告归因和回传](https://developer.apple.com/documentation/storekit/receiving-ad-attributions-and-postbacks)》。

# See Also - 其他参考

## Registering Ad Networks and Configuring Apps - 注册广告网络和配置应用程序

### [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network) - 注册广告网络

Register your ad network with Apple to use the install-validation APIs for your ad campaigns.

向 Apple 注册你的广告网络，以便对你的广告活动使用安装验证 API。

### [Configuring a Source App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app) - 配置源应用

Configure a source app to participate in ad campaigns.

配置源应用以参与广告活动。

### [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app) - 配置广告应用

Prepare an advertised app to participate in ad campaigns.

准备广告应用以参与广告活动。

### property list key [SKAdNetworkItems](https://developer.apple.com/documentation/bundleresources/information_property_list/skadnetworkitems)

An array of dictionaries containing a list of ad network identifiers.

包含广告网络标识符列表的字典数组。

### property list key [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/bundleresources/information_property_list/nsadvertisingattributionreportendpoint)

The URL where Private Click Measurement and SKAdNetwork send attribution information.

私人点击测量 和 SKAdNetwork 发送归因信息的URL。