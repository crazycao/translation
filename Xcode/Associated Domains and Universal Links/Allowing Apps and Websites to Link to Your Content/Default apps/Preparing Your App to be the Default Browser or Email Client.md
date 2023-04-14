# Preparing Your App to be the Default Browser or Email Client
# 让你的 app 准备成为默认浏览器或者邮件客户端

原文地址：[https://developer.apple.com/documentation/xcode/preparing-your-app-to-be-the-default-browser-or-email-client](https://developer.apple.com/documentation/xcode/preparing-your-app-to-be-the-default-browser-or-email-client)

Configure your browser or email app so users can set it as the default on their device instead of Safari or Mail.

配置你的浏览器或电子邮件 app，以便用户可以将其设置为设备上的默认应用程序，而不是 Safari 或 Mail。

# Overview - 概览

In iOS 14 and later, users can select an app to be their default web browser or email app. To make your app a choice, confirm that your app meets the requirements below, then request a managed entitlement.

在 iOS 14 及以后的版本，用户可以选择一个 app 作为他们的默认 web 浏览器或邮件程序。要让你的 app 成为一个可选项，请确认你的应用程序满足以下要求，然后申请托管授权。

# Configure Your App to be a Default Browser - 配置你的 app 成为默认浏览器

The system invokes the default web browser in iOS whenever the user opens an HTTP or HTTPS link. Because this app becomes the user’s primary gateway to the internet, Apple requires that web browsing apps meet specific functional criteria to protect user privacy and ensure proper access to internet resources.

每当用户打开 HTTP 或 HTTPS 链接时，系统就会调用在 iOS 中的默认 web 浏览器。由于该应用程序已成为用户接入互联网的主要网关，苹果要求网络浏览应用程序满足特定的功能标准，以保护用户隐私并确保正确访问互联网资源。

Apps express their capability to be a default web browser by using the [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) managed entitlement. Request permission to use this entitlement by emailing `default-browser-requests@apple.com`. This starts the process of generating the necessary signing permission for your app.

应用程序使用 [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) 托管授权来表达其作为默认 web 浏览器的能力。通过向   `default-browser-requests@apple.com` 发邮件来请求使用这个授权。这将开始为应用程序生成必要的签名权限的过程。

## Fulfilling Default Browser Requirements - 满足默认浏览器要求

Apps that register as a default web browser option must satisfy the following criteria:

注册成为默认 web 浏览器选项的应用程序必须满足以下条件：

- Your app must specify the HTTP and HTTPS schemes in its `Info.plist` file.
- Your app can’t use [UIWebView](https://developer.apple.com/documentation/uikit/uiwebview).
- On launch, the app must provide a text field for entering a URL, search tools for finding relevant links on the internet, or curated lists of bookmarks.

>

- 你的 app 必须在其 `Info.plist` 文件中指定 HTTP 和 HTTPS scheme。
- 你不能使用 [UIWebView](https://developer.apple.com/documentation/uikit/uiwebview)。
- 在启动时，该 app 必须提供用于输入 URL 的文本框，或者用于在互联网上查找相关链接的搜索工具，或者管理好的的书签列表。

When opening an HTTP or HTTPS URL in its default configuration:

在默认配置下打开 HTTP 或 HTTPS URL时：

- The app must navigate directly to the specified destination and render the expected web content. Apps that redirect to unexpected locations or render content not specified in the destination’s source code don’t meet the requirements of a default web browser.
- Apps designed to operate in a parental controls or locked down mode may restrict navigation to comply with those goals.
- Your app may present a “Safe Browsing” or other warning for content suspected of phishing or other problems.
- Your app may offer a native authentication UI for a site that also offers a native web sign-in flow.

>

- 应用程序必须直接导航到指定的目标网站，并呈现期望的 web 内容。重定向到意外位置或呈现目标网站的源代码中未指定内容的应用程序都不符合默认 web 浏览器的要求。
- 设计为在家长控制或锁定模式下运行的应用程序可能会限制导航以符合这些要求。
- 应用程序可能会对涉嫌网络钓鱼或其他问题的内容发出“安全浏览警告”或其他警告。
- 应用程序可能会为提供了本地 web 登录流的网站提供一套本地身份验证 UI。

## Using Default Browser Capabilities - 使用默认浏览器能力

Apps that use the [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) managed entitlement can:

使用 [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) 管理授权的 app 可以：

- Be an option for the user to choose as their default browser.
- Load pages from all domains with full script access.
- Use Service Workers in [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) instances.

>

- 是用户选择作为默认浏览器的选项。
- 加载所有域名的页面以及全部脚本的访问权限。
- 在 [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) 实例中使用 Service Workers。

## Adhering to Browser Restrictions -  遵守浏览器限制

Apps that have the [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) managed entitlement may not claim to respond to Universal Links for specific domains. The system will ignore any such claims. Apps with the entitlement can still open Universal Links to other apps as usual.

具有 [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) 管理授权的 app 可能不会响应指定域名的通用链接。系统将忽略任何此类请求。拥有该授权的 app 仍然可以像往常一样打开与其他应用程序的通用链接。

Because of their privileged position in a user’s web browsing, browser apps should avoid unnecessary access to personal data. Apps that use any of the following `Info.plist` keys while using the [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) managed entitlement will be rejected:

由于在用户的网络浏览中处于特权地位，浏览器应用应该避免不必要地访问个人数据。使用了 [com.apple.developer.web-browser](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_web-browser) 授权而又同时使用下列任意 `Info.plist` 关键字的 app 将被拒绝：

- [NSPhotoLibraryUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryusagedescription) — For saving images, your app should only specify [NSPhotoLibraryAddUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryaddusagedescription). [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) can still upload photos and files without your app needing access to a user’s entire photo library. To access individual photos your app should use [PHPickerViewController](https://developer.apple.com/documentation/photokit/phpickerviewcontroller) which doesn’t require [NSPhotoLibraryUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryusagedescription), instead of [UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller).
- [NSLocationAlwaysUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationalwaysusagedescription), [NSLocationAlwaysAndWhenInUseUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationalwaysandwheninuseusagedescription) — For determining the user’s location, request while in-use authorization instead ([NSLocationWhenInUseUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationwheninuseusagedescription)). Browsers are restricted from always-on location access.
- [NSHomeKitUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nshomekitusagedescription) — Browsers can’t access the user’s HomeKit database.
- [NSBluetoothAlwaysUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothalwaysusagedescription) — Browsers can’t poll for Bluetooth devices when the app is in the background. Browsers should use `NSBluetoothWhileInUseUsageDescription` for Bluetooth features.
- [NSHealthShareUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nshealthshareusagedescription), [NSHealthUpdateUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nshealthupdateusagedescription) — Browsers can’t access the user’s health database.

>

- [NSPhotoLibraryUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryusagedescription) —— 要保存图片，你的 app 应该仅指定 [NSPhotoLibraryAddUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryaddusagedescription)。[WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) 仍然可以上传照片和文件，而你的应用程序不需要访问用户的整个照片库。要访问个人照片，你的 app 应该使用 [PHPickerViewController](https://developer.apple.com/documentation/photokit/phpickerviewcontroller) 而不是 [UIImagePickerController](https://developer.apple.com/documentation/uikit/uiimagepickercontroller)，它并不需要 [NSPhotoLibraryUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryusagedescription)。
- [NSLocationAlwaysUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationalwaysusagedescription)、[NSLocationAlwaysAndWhenInUseUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationalwaysandwheninuseusagedescription) —— 要确定用户的位置，请求“仅在使用中”权限（[NSLocationWhenInUseUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationwheninuseusagedescription)）。浏览器被严格限制“总是”进行位置访问。
- [NSHomeKitUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nshomekitusagedescription) —— 浏览器无法访问用户的 HomeKit 数据库。
- [NSBluetoothAlwaysUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsbluetoothalwaysusagedescription) —— 当应用程序位于后台时，浏览器无法轮询蓝牙设备。浏览器应该使用 `NSBluetoothWhileInUseUsageDescription` 访问蓝牙功能。
- [NSHealthShareUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nshealthshareusagedescription)、[NSHealthUpdateUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nshealthupdateusagedescription) —— 浏览器无法访问用户的健康数据库。

> **Note** **注意**
>
> [NSLocationAlwaysUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationalwaysusagedescription) was deprecated in iOS 10. For more information, see [Choosing the Location Services Authorization to Request](https://developer.apple.com/documentation/corelocation/choosing_the_location_services_authorization_to_request).
> 
> [NSLocationAlwaysUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nslocationalwaysusagedescription) 在 iOS 10 被废弃。更多信息，参见《[选择要请求的定位服务权限](https://developer.apple.com/documentation/corelocation/choosing_the_location_services_authorization_to_request)》。

# Configure Your App to be a Default Email App - 配置你的 app 成为默认邮箱程序

The system launches the default mail client in iOS whenever a user opens a `mailto:` link. Since email is a critical avenue for communication, Apple requires that email apps must meet specific functional criteria aimed at ensuring private and accurate access for users.

每当用户打开 `mailto:` 链接时，系统就会启动 iOS  中的默认邮件客户端。由于电子邮件是一种重要的沟通渠道，苹果要求电子邮件应用程序必须满足特定的功能标准，以确保用户私密且准确的访问。

Apps signal their intent to be used as a default mail app by using the [com.apple.developer.mail-client](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_mail-client) managed entitlement. Request permission to use this entitlement by emailing `default-mail-app-requests@apple.com`.

应用程序通过使用 [com.apple.developer.mail-client](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_mail-client) 管理授权来表明其被用作默认邮件程序的意图。通过使用这个授权向 `default-mail-app-requests@apple.com` 发送邮件来请求许可。

## Fulfilling Default Email App Requirements - 满足默认邮件程序的要求

Any app that registers as a default email client option must:

任何注册为默认电子邮件客户端选项的应用程序必须：

- Specify the `mailto:` scheme in its `Info.plist` file.
- Be able to send a message to any valid email recipient.
- Be able to receive a message from any email sender. Apps that provide user-controlled incoming mail screening features are permitted.

>

- 在其 `Info.plist` 文件中指定 `mailto:` scheme。
- 能够向任何有效的电子邮件收件人发送消息。
- 能够接收来自任何电子邮件发件人的消息。提供用户控制的邮件屏蔽功能的应用程序才被允许上架。
-