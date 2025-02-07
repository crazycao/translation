# Testing ad attributions with a downloaded profile 
# 使用下载的配置文件测试广告稿归因

原文地址：[https://developer.apple.com/documentation/storekit/testing-ad-attributions-with-a-downloaded-profile](https://developer.apple.com/documentation/storekit/testing-ad-attributions-with-a-downloaded-profile)

Reduce the time window for ad attributions and inspect postbacks using a proxy during testing.

减少广告归因的时间窗口，并在测试期间使用代理检查回传。

# Overview - 概览

You can reduce the time window for receiving ad attribution postbacks by installing an SKAdNetwork testing profile on your test device.

您可以通过在测试设备上安装一个 SKAdNetwork 测试配置文件来缩短接收广告归因回传请求的时间窗口。

> **Important** **重要**
>
> To download the latest profile, see the [AdAttributionKit](https://developer.apple.com/documentation/AdAttributionKit) article on [Testing ad attributions with a downloaded profile](https://developer.apple.com/documentation/AdAttributionKit/testing-ad-attributions-with-a-downloaded-profile). This profile is compatible with both AdAttributionKit and SKAdNetwork.
> 
> 要下载最新配置文件，请参阅 [AdAttributionKit](https://developer.apple.com/documentation/AdAttributionKit) 文章中有关《[使用下载配置文件测试广告归因](https://developer.apple.com/documentation/AdAttributionKit/testing-ad-attributions-with-a-downloaded-profile)》的内容。该配置文件兼容 AdAttributionKit 和 SKAdNetwork。

For information about installing profiles, see [Install a configuration profile on your iPhone or iPad](https://support.apple.com/en-us/HT209435). You can install this profile on devices running iOS or iPadOS 14 or later.

有关安装配置文件的信息，请参阅《[在您的 iPhone 或 iPad 上安装配置文件](https://support.apple.com/en-us/HT209435)》。您可以在运行 iOS 或 iPadOS 14 或更高版本的设备上安装此配置文件。

With this profile, the installed app has five minutes to update the conversion value after initially registering. The device sends the postback within another five minutes after the rolling five-minute timer for conversion updates expires. Using this profile reduces the conversion value update and postback window from 24–48 hours to 5–10 minutes.

通过此配置文件，安装的应用程序在最初注册后有五分钟的时间来更新转化价值。设备在转化更新的滚动五分钟计时器到期后的另外五分钟内发送回传。使用此配置文件将将转化价值更新和回传窗口从 24-48 小时缩短至 5-10 分钟。

This testing profile expires two weeks after you install it on the device. To continue testing, download the latest profile and reinstall it.

此测试配置文件在您将其安装在设备上两周后将会过期。要继续测试，请下载最新配置文件并重新安装。

## Log in with an Apple ID to test ad attributions - 使用 Apple ID 登录以测试广告归因

To test ad attributions, you must log in to the device with a production Apple ID. SKAdNetwork doesn’t support Sandbox Apple IDs.

要测试广告归因，您必须使用生产环境的 Apple ID 登录设备。SKAdNetwork 不支持沙盒 Apple ID。

## Inspect postbacks using an HTTP proxy - 使用 HTTP 代理检查回传

On devices running iOS 14.7 and later with this profile installed, the system can send SKAdNetwork postbacks through an HTTP proxy that you configure. By using an HTTP proxy, you can monitor the HTTP traffic between your device and the network, including SKAdNetwork postbacks.

在安装了此配置文件的 iOS 14.7 及更高版本的设备上，系统可以通过您配置的 HTTP 代理发送 SKAdNetwork 回传请求。通过使用 HTTP 代理，您可以监控设备和网络之间的 HTTP 流量，包括 SKAdNetwork 回传请求。

To configure the HTTP proxy, do the following on a testing device:

1. Go to Settings > Wi-Fi and select the Wi-Fi network you’re connected to.
2. Under the HTTP Proxy heading, select Configure Proxy.
3. Select Manual to configure the Server, Port, and Authentication settings for your proxy, or select Automatic to provide a URL for your proxy.
4. Tap Save.

要配置 HTTP 代理，请在测试设备上执行以下操作：

1. 打开“设置” > “Wi-Fi”，然后选择您连接到的 Wi-Fi 网络。
2. 在“HTTP 代理”标题下，选择“配置代理”。
3. 选择“手动”以配置您的代理服务器、端口和身份验证设置，或选择“自动”以提供您的代理的 URL。
4. 点击“保存”。

With the profile installed, the SKAdNetwork postbacks that the device sends now go through the proxy you configured.

安装了配置文件后，现在设备发送的 SKAdNetwork 回传会经过您配置的代理。


# See Also - 其他参考

## Testing Ad Attributions and Postbacks - 测试广告归因和回传

### [Testing Ad Attributions with a Downloaded Profile](https://developer.apple.com/documentation/storekit/skadnetwork/testing_ad_attributions_with_a_downloaded_profile) - 使用下载的配置文件测试广告稿归因

Reduce the time window for ad attributions and inspect postbacks using a proxy during testing.

减少广告归因的时间窗口，并在测试期间使用代理检查回传。

### [Testing and Validating Ad Impression Signatures and Postbacks for SKAdNetwork](https://developer.apple.com/documentation/storekittest/testing_and_validating_ad_impression_signatures_and_postbacks_for_skadnetwork) - 测试和验证SKAdNetwork 的广告印象签名和回传

Validate your ad impressions and test your postbacks by creating unit tests using the StoreKit Test framework.

通过使用 StoreKit Test 框架创建单元测试，验证广告印象并测试回传。


