# Configuring a source app
# 配置源应用

原文地址：[https://developer.apple.com/documentation/storekit/configuring-a-source-app](https://developer.apple.com/documentation/storekit/configuring-a-source-app)

Set up a source app to participate in ad campaigns.

配置源应用以参与广告活动。

# Overview - 概览

A source app is an app that participates in ad campaigns by displaying ads that an ad network signs. To participate in install validation, the source app needs to include ad network IDs in its `Info.plist` file. Ad networks are responsible for publishing or providing their ad network IDs to developers.

一个源应用程序是通过显示广告来参与广告活动的应用程序，这些广告是广告网络签署的。为了参与安装验证，源应用程序需要在其 `Info.plist` 文件中包含广告网络 ID。广告网络负责发布或向开发人员提供他们的广告网络 ID。

Only ads from ad networks that have an entry in the app’s `Info.plist` file are eligible for install validation. To work with multiple ad networks, include each of the ad network IDs in the source app’s `Info.plist` file, as follows:

1. Select `Info.plist` in the Project navigator in Xcode.
2. Click the Add button (`+`) beside a key in the property list editor and press Return.
3. Type the key name [SKAdNetworkItems](https://developer.apple.com/documentation/bundleresources/information_property_list/skadnetworkitems).
4. Choose Array from the pop-up menu in the Type column.

只有来自指定广告网络的广告才有资格进行安装验证，这些广告网络通过在应用程序的 `Info.plist` 文件中有条目的进行指定。要与多个广告网络一起工作，请在源应用程序的 `Info.plist` 文件中包含每个广告网络ID，步骤如下：

1. 在 Xcode 的项目导航器中选择 `Info.plist`。
2. 单击属性列表编辑器中键旁边的添加按钮（`+`）并按回车键。
3. 键入键名 [SKAdNetworkItems](https://developer.apple.com/documentation/bundleresources/information_property_list/skadnetworkitems)。
4. 在类型列中的弹出菜单中选择数组。

Create an array that contains one dictionary for each allowed ad network, using the single key [SKAdNetworkIdentifier](https://developer.apple.com/documentation/BundleResources/Information-Property-List/SKAdNetworkItems/SKAdNetworkIdentifier). The string value for the key is the ad network ID.

创建一个包含每个允许的广告网络的字典的数组，使用单个键[SKAdNetworkIdentifier](https://developer.apple.com/documentation/BundleResources/Information-Property-List/SKAdNetworkItems/SKAdNetworkIdentifier)。键的字符串值是广告网络ID。

> **Important** **重要**
>
> Lowercase the ad network ID string; otherwise, the system doesn’t recognize it as valid.
> 
> 将广告网络ID字符串转换为小写；否则，系统将认为其无效。

The following example shows an array with two dictionaries that represent the example ad network IDs `example100.skadnetwork` and `example200.skadnetwork`:

下面的例子展示了一个包含两个字典的数组，分别代表了了示例广告网络 ID `example100.skadnetwork` 和 `example200.skadnetwork`：

```
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>example100.skadnetwork</string>
    </dict>
    <dict>   
         <key>SKAdNetworkIdentifier</key>
         <string>example200.skadnetwork</string>
    </dict>
</array>
```

For more information about property lists, see [Edit property lists](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6).

关于属性列表的更多信息，参见《[编辑属性列表](https://help.apple.com/xcode/mac/current/#/dev3f399a2a6)》。


# See Also - 其他参考

## Registering Ad Networks and Configuring Apps - 注册广告网络和配置应用程序

### [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network) - 注册广告网络

Register your ad network with Apple to use the install-validation APIs for your ad campaigns.

向 Apple 注册你的广告网络，以便对你的广告活动使用安装验证 API。

### [Configuring a Source App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app) - 配置源应用

Configure a source app to participate in ad campaigns.

配置源应用以参与广告活动。

### [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app) - 配置被广告应用

Prepare an advertised app to participate in ad campaigns.

准备被广告应用以参与广告活动。

### property list key [SKAdNetworkItems](https://developer.apple.com/documentation/bundleresources/information_property_list/skadnetworkitems)

An array of dictionaries containing a list of ad network identifiers.

包含广告网络标识符列表的字典数组。

### property list key [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/bundleresources/information_property_list/nsadvertisingattributionreportendpoint)

The URL where Private Click Measurement and SKAdNetwork send attribution information.

私人点击测量 和 SKAdNetwork 发送归因信息的URL。