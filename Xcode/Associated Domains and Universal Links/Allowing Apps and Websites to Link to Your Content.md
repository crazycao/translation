# Allowing Apps and Websites to Link to Your Content
# 允许应用程序和网站链接到您的内容

原文地址：[https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content)

Use universal links to link directly to content within your app and share data securely.

使用通用链接直接链接到应用程序中的内容，并安全地共享数据。

# Overview - 概览

You can connect to content deep inside your app with universal links. Users open your app in a specified context, allowing them to accomplish their goals efficiently.

你可以通过通用链接连接到应用程序的深层内容。用户在特定的上下文中打开你的应用程序，使他们能够高效地完成目标。

When users tap or click a universal link, the system redirects the link directly to your app without routing through Safari or your website. In addition, because universal links are standard HTTP or HTTPS links, one URL works for both your website and your app. If the user has not installed your app, the system opens the URL in Safari, allowing your website to handle it.

当用户触碰或点击一个通用链接时，系统会将链接直接重定向到你的应用程序，而无需通过 Safari 或你的网站进行路由。此外，因为通用链接是标准的 HTTP 或 HTTPS 链接，所以一个 URL 既适用于您的网站，也适用于您的应用程序。如果用户尚未安装你的应用程序，系统会在 Safari 中打开 URL，让你的网站来处理。

When users install your app, the system checks a file stored on your web server to verify that your website allows your app to open URLs on its behalf. Only you can store this file on your server, securing the association of your website and your app.

用户安装了应用程序时，系统会检查存储在 web 服务器上的文件，以验证您的网站是否允许应用程序代表其打开 URL。只有你才可以将此文件存储在你的服务器上，这可以保护您的网站和应用程序的关联。

# Support Universal Links - 支持通用链接

Take the following steps to support universal links:

采取以下步骤来支持通用链接：

1. Create a two-way association between your app and your website and specify the URLs that your app handles, as described in [Supporting Associated Domains](https://developer.apple.com/documentation/Xcode/supporting-associated-domains).
2. Update your app delegate to respond to the user activity object the system provides when a universal link routes to your app, as described in [Supporting Universal Links in Your App](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app).

>

1. 在应用程序和网站之间创建双向关联，并指定应用程序处理的URL，如《[支持关联域名](https://developer.apple.com/documentation/Xcode/supporting-associated-domains)》中所述。
2. 更新应用程序委托，以响应在通用链接路由到应用程序时系统提供的用户活动对象，如《[在应用程序中支持通用链接](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app)》中所述。

With universal links, users open your app when they click links to your website within Safari and [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview), and when they click links that result in a call to:

通过通用链接，用户在 Safari 和 [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview) 中单击指向您网站的链接时，以及在单击调用下面这些方法的链接时，都会打开您的应用程序：

- [open(_:options:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open) in iOS and tvOS
- [openSystemURL(_:)](https://developer.apple.com/documentation/watchkit/wkextension/1628224-opensystemurl) in watchOS
- [open(_:withApplicationAt:configuration:completionHandler:)](https://developer.apple.com/documentation/appkit/nsworkspace/3172702-open) in macOS
- [openURL](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/openURL) in SwiftUI

>

- 在 iOS 和 tvOS 中的 [open(_:options:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open) 方法
- 在 watchOS 中的 [openSystemURL(_:)](https://developer.apple.com/documentation/watchkit/wkextension/1628224-opensystemurl) 方法
- 在 macOS 中的 [open(_:withApplicationAt:configuration:completionHandler:)](https://developer.apple.com/documentation/appkit/nsworkspace/3172702-open) 方法
- 在 SwiftUI 中的 [openURL](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/openURL) 方法

> **Note** **注意**
> 
> If your app uses one of the above methods to open a universal link to your website, the link won’t open in your app.
> 
> 如果你的 APP 使用了上述方法之一打开指向你的网站的通用链接，这个链接就不会在你的 APP 中打开。

When a user browses your website in Safari and taps a universal link in the same domain, the system opens that link in Safari, respecting the user’s most likely intent to continue within the browser. If the user taps a universal link in a different domain, the system opens the link in your app.

当用户在 Safari 中浏览您的网站并点击同一域名中的通用链接时，系统会在Safari中打开该链接，尊重用户最有可能在浏览器中继续的意图。如果用户点击其他域名中的通用链接，系统会就在应用程序中打开该链接。

# Communicate with Other Apps - 与其他应用程序通信

Apps can communicate through universal links. Supporting universal links allows other apps to send small amounts of data directly to your app without using a third-party server. 

应用程序可以通过通用链接进行通信。支持通用链接允许其他应用直接向您的应用发送少量数据，而无需使用第三方服务器。

Define the parameters that your app handles within the URL query string. The following example code for a photo library app specifies parameters that include the name of an album and the index of a photo to display.

在URL查询字符串中定义应用程序处理的参数。以下是照片库应用程序的示例代码，指定了包括相册名称和要显示的照片索引的参数。

```
https://myphotoapp.example.com/albums?albumname=vacation&index=1
https://myphotoapp.example.com/albums?albumname=wedding&index=17
```

Other apps craft URLs based on your domain, path, and parameters and ask your app to open them by calling:

其他应用程序会根据你的域名、路径和参数精心制作 URL，并通过调用以下方法让你的应用程序通打开它们：

- The  [open(_:options:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open) of [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication) in iOS and tvOS
- The [openSystemURL(_:)](https://developer.apple.com/documentation/watchkit/wkextension/1628224-opensystemurl) method of [WKExtension](https://developer.apple.com/documentation/watchkit/wkextension) in watchOS
- The [open(_:withApplicationAt:configuration:completionHandler:)](https://developer.apple.com/documentation/appkit/nsworkspace/3172702-open) method of [NSWorkspace](https://developer.apple.com/documentation/appkit/nsworkspace) in macOS
- The [openURL](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/openURL) environment value in SwiftUI

>

- 在 iOS 和 tvOS 中，[UIApplication](https://developer.apple.com/documentation/uikit/uiapplication) 的 [open(_:options:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open) 方法
- 在 watchOS 中，[WKExtension](https://developer.apple.com/documentation/watchkit/wkextension) 的 [WKExtension](https://developer.apple.com/documentation/watchkit/wkextension) 方法
- 在 macOS 中，[NSWorkspace](https://developer.apple.com/documentation/appkit/nsworkspace) 的 [open(_:withApplicationAt:configuration:completionHandler:)](https://developer.apple.com/documentation/appkit/nsworkspace/3172702-open) 方法
- 在 SwiftUI 中， [openURL](https://developer.apple.com/documentation/SwiftUI/EnvironmentValues/openURL) 环境变量值

The calling app can ask the system to inform it when your app opens the URL.

调用方应用可以让系统当应用打开 URL 时通知它。

In this example code, an app calls your universal link in iOS and tvOS:

在此示例代码中，应用程序在 iOS 和 tvOS 中调用了你的通用链接：

```
if let appURL = URL(string: "https://myphotoapp.example.com/albums?albumname=vacation&index=1") {
    UIApplication.shared.open(appURL) { success in
        if success {
            print("The URL was delivered successfully.")
        } else {
            print("The URL failed to open.")
        }
    }
} else {
    print("Invalid URL specified.")
}
```

In this example code, an app calls your universal link in watchOS:

在此示例代码中，应用程序在 wathchOS 中调用了你的通用链接：

```
if let appURL = URL(string: "https://myphotoapp.example.com/albums?albumname=vacation&index=1") {
    WKExtension.shared().openSystemURL(appURL)
} else {
    print("Invalid URL specified.")
}
```

In this example code, an app calls your universal link in macOS:

在此示例代码中，应用程序在 macOS 中调用了你的通用链接：

```
if let appURL = URL(string: "https://myphotoapp.example.com/albums?albumname=vacation&index=1") {
    let configuration = NSWorkspace.OpenConfiguration()
    NSWorkspace.shared.open(appURL, configuration: configuration) { (app, error) in
        guard error == nil else {
            print("The URL failed to open.")
            return
        }
        print("The URL was delivered successfully.")
    }
} else {
    print("Invalid URL specified.")
}
```

For more information on handling links within your app, see [Supporting Universal Links in Your App](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app).

关于通过你的 app 处理链接的更多信息，参见《[在APP中支持通用链接](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app)》。

# Topics - 主题

## Universal Links - 通用链接

### [Supporting Universal Links in Your App](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app) - 在你的 app 中支持通用链接

Prepare your app to respond to an incoming universal link.

让你的 app 准备好响应传入的通用链接。

## Associated Domains - 关联域名

### [Supporting Associated Domains](https://developer.apple.com/documentation/xcode/supporting-associated-domains) - 支持关联域名

Connect your app and a website to provide both a native app and a browser experience.

将你的应用程序和网站连接起来，提供原生程序和浏览器体验。

## Custom URLs - 自定义 URL

### [Defining a Custom URL Scheme for Your App](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app) - 为你的 app 定义一个自定义 URL Scheme

Use specially formatted URLs to link to content within your app.

使用特殊格式的 URL 链接到应用程序中的内容。

## Default Apps - 默认 App

### [Preparing Your App to be the Default Browser or Email Client](https://developer.apple.com/documentation/xcode/preparing-your-app-to-be-the-default-browser-or-email-client) - 让你的 app 准备成为默认浏览器或者邮件客户端

Configure your browser or email app so users can set it as the default on their device instead of Safari or Mail.

配置你的浏览器或电子邮件 app，以便用户可以将其设置为设备上的默认应用程序，而不是 Safari 或 Mail。
