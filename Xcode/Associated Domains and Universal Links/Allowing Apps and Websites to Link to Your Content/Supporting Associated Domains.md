# Supporting Associated Domains
# 支持关联域名

原文地址：[https://developer.apple.com/documentation/Xcode/supporting-associated-domains](https://developer.apple.com/documentation/Xcode/supporting-associated-domains)

Connect your app and a website to provide both a native app and a browser experience.

将你的应用程序和网站连接起来，提供原生程序和浏览器体验。

# Overview - 概览

Associated domains establish a secure association between domains and your app so you can share credentials or provide features in your app from your website. For example, an online retailer may offer an app to accompany their website and enhance the user experience.

关联域名在域名和应用程序之间建立安全关联，以便您可以从网站共享证书或在应用程序中提供功能。例如，一家在线零售商可能会提供一个伴随他们的网站的应用程序，并增强用户体验。

Shared web credentials, universal links, Handoff, and App Clips all use associated domains. Associated domains provide the underpinning to universal links, a feature that allows an app to present content in place of all or part of its website. Users who don’t download the app get the same information in a web browser instead of the native app.

共享的网络证书、通用链接、接力（Handoff）和 轻App（App Clips）都要使用关联域名。关联域名为通用链接提供了基础，该功能允许应用程序在其网站的全部或部分位置呈现内容。未下载应用程序的用户在 web 浏览器中获得相同的信息，而不是在本地应用程序中。

To associate a website with your app, you’ll need to have the associated domain file on your website and the appropriate entitlement in your app. The apps in the `apple-app-site-association` file on your website must have a matching [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains).

要将网站与应用程序关联，你需要在网站上有一个关联域名文件，并在应用程序中设置相应的授权。在你的网站上的 `apple-app-site-association` 文件中的 app 必须有匹配的[关联域名授权](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains)。

# Add the Associated Domain File to Your Website - 将关联域名文件添加到你的网站

When a user installs your app, the system attempts to download the associated domain file and verify the domains in your entitlement.

当用户安装你的 app 时，系统会尝试下载关联域名文件，并验证你的授权文件中的域名。

> **Note** **注意**
> 
> If your site uses multiple subdomains (such as example.com, www.example.com, or support.example.com), each requires its own entry in the [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains), and each must serve its own `apple-app-site-association` file.
> 
> 如果你的网站使用多个子域名（比如 example.com，www.example.com，或 support.example.com），每个子域名都要在[关联域名授权](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains)中有自己的条目，并且每个子域名上必须都能下载到自己的 `apple-app-site-association` 文件。

To add the associated domain file to your website, create a file named `apple-app-site-association` (without an extension). Update the JSON code in the file for the services you’ll support on the domain. For universal links, be sure to list the app identifiers for your domain in the `applinks` service. Similarly, if you create an App Clip, be sure to list your App Clip’s app identifier using the `appclips` service.

要将关联域名文件添加到您的网站，请创建一个名为 `apple-app-site-association` （无扩展名）的文件。在文件中放入 JSON代码，以获得您将在域上支持的服务。对于通用链接，请确保在 `applinks` 服务中列出域名对应的应用程序标识符。同样，如果创建 轻App，请确保在 `appclips` 服务中列出你的 轻App 的应用程序标识符。

The following JSON code represents the contents of a simple association file.

下面的 JSON 代码展示了一个简单的关联文件的内容。

```
{
  "applinks": {
      "details": [
           {
             "appIDs": [ "ABCDE12345.com.example.app", "ABCDE12345.com.example.app2" ],
             "components": [
               {
                  "#": "no_universal_links",
                  "exclude": true,
                  "comment": "Matches any URL whose fragment equals no_universal_links and instructs the system not to open it as a universal link - 匹配包含 no_universal_links 字符串的任何URL，并告诉系统不要将其作为通用链接打开"
               },
               {
                  "/": "/buy/*",
                  "comment": "Matches any URL whose path starts with /buy/ - 匹配路径以 /buy/ 开头的任何URL"
               },
               {
                  "/": "/help/website/*",
                  "exclude": true,
                  "comment": "Matches any URL whose path starts with /help/website/ and instructs the system not to open it as a universal link - 匹配路径以 /help/website/ 开头的任何URL，并告诉系统不要将其作为通用链接打开"
               },
               {
                  "/": "/help/*",
                  "?": { "articleNumber": "????" },
                  "comment": "Matches any URL whose path starts with /help/ and which has a query item with name 'articleNumber' and a value of exactly 4 characters - 匹配路径以 /help/ 开头且查询参数中包含 key 为 “articleNumber” 而 value 正好为4个字符的查询项的任何URL"
               }
             ]
           }
       ]
   },
   "webcredentials": {
      "apps": [ "ABCDE12345.com.example.app" ]
   },

    "appclips": {
        "apps": ["ABCED12345.com.example.MyApp.Clip"]
    }
}
```

The appIDs and apps keys specify the application identifiers for the apps that are available for use on this website along with their service types. Use the following format for the values in these keys:

其中的 `appIDs` 和 `apps` 关键字指定了可以在这个网站上使用的应用程序及其服务类型。这些关键字的值都采用如下格式：

```
<Application Identifier Prefix>.<Bundle Identifier>  //（译者注：即 <TeamID>.<BundleID> ）
```

The `details` dictionary only applies to the [applinks](https://developer.apple.com/documentation/bundleresources/applinks) service type; other service types don’t use it. The `components` key is an array of dictionaries that provides pattern matching for components of the URL.

其中的 `details` 字典仅适用于 [applinks](https://developer.apple.com/documentation/bundleresources/applinks) 服务类型；其他服务类型不使用它。`components` 关键字是一组字典，为 URL 的 components 提供模式匹配。

After you construct the association file, place it in your site’s `.well-known` directory. The file’s URL should match the following format:

构建关联文件后，将其放置在网站的 `.well-known` 目录下。文件的 URL 应与以下格式相匹配：

```
https://<fully qualified domain>/.well-known/apple-app-site-association
```

You must host the file using `https://` with a valid certificate and with no redirects.

您必须使用 `https:// `托管该文件，并提供有效的证书，且无重定向。

# Add the Associated Domains Entitlement to Your App - 将关联域名授权添加到你的 App

To set up the entitlement in your app, open the target’s `Signing & Capabilities` tab in Xcode and add the `Associated Domains` capability. If they’re not already present, this step adds the [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains) to your app and the associated domains feature to your app ID.

要在应用程序中设置授权，请在 Xcode 中打开 target 的 `Signing & Capabilities` 选项卡，并添加 `Associated Domains` 功能。如果它们并不是已经出现，此步骤会将 [关联域名授权](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains) 添加到应用程序中，并将关联域名功能添加到 app ID中。

> **Important** **重要**
> 
> For watchOS apps, you must add the `Associated Domains` capability to the `WatchKit Extension` target.
> 
> 对于 watchOS 应用，你必须把 `Associated Domains` 功能添加到 `WatchKit Extension` target 中。

To add your domain to the entitlement, click `Add (+)` at the bottom of the `Domains` table to add a placeholder domain. Replace the placeholder with the appropriate prefix for the service your app will support and your site’s domain. Make sure to only include the desired subdomain and the top-level domain. Don’t include path and query components or a trailing slash (`/`).

要将您的域名添加到授权中，请单击 `Domains` 表底部的 `Add (+)` 以添加占位符域名。然后将占位符替换为应用程序支持的服务和网站域名的相应前缀。确保只包含所需的子域名和顶级域名。不要包含路径和查询 components 或尾部斜杠（`/`）。

![Screenshot showing how to add the associated domains for your app.](https://docs-assets.developer.apple.com/published/4cbbb0bb235bdd82277b0f8d294afab8/17400/images/supporting-associated-domains-1@2x.png)

Add the domains that share credentials with your app. For services other than appclips, you can prefix a domain with `*.` to match all of its subdomains.

添加与你的 app 共享证书的域名。对于除了 `appclips` 以外的服务，可以在域名前面加上 `*.` 以匹配其所有子域名。

Each domain you specify uses the following format:

你指定的每个域名都需要采用以下格式：

```
<service>:<fully qualified domain>
```

Starting with macOS 11 and iOS 14, apps no longer send requests for `apple-app-site-association` files directly to your web server. Instead, they send these requests to an Apple-managed content delivery network (CDN) dedicated to associated domains.

从 macOS 11 和 iOS 14 开始，app 不再需要直接发送 `apple-app-site-association` 文件的请求到你的 web 服务器。取而代之的是，它们可以发送这些请求到苹果管理的专用于关联域名的内容交付网络（CDN）。

While you’re developing your app, if your web server is unreachable from the public internet, you can use the alternate mode feature to bypass the CDN and connect directly to your private domain.

在开发应用程序时，如果无法从公共互联网访问你的 web 服务器，您可以使用备用模式功能绕过 CDN，直接连接到您的私有域名。

You enable an alternate mode by adding a query string to your associated domain’s entitlement as follows:

通过将查询字符串添加到关联域名的授权文件中，可以启用备用模式，如下所示：

```
<service>:<fully qualified domain>?mode=<alternate mode>
```

For more information on alternate modes, see [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains). For information on universal links, see [Allowing Apps and Websites to Link to Your Content](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content). For information about Handoff, see the [Handoff Programming Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/Handoff/HandoffFundamentals/HandoffFundamentals.html#//apple_ref/doc/uid/TP40014338). For information about App Clips, see [Configuring the Launch Experience of Your App Clip](https://developer.apple.com/documentation/app_clips/configuring_the_launch_experience_of_your_app_clip).

有关备用模式的更多信息，请参阅《[关联域名授权](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains)》。有关通用链接的信息，请参阅《[允许应用程序和网站链接到您的内容](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content)》。有关接力的信息，请参阅《[接力编程指南](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/Handoff/HandoffFundamentals/HandoffFundamentals.html#//apple_ref/doc/uid/TP40014338)》。有关 轻App 的信息，请参阅《[配置你的轻App的启动体验](https://developer.apple.com/documentation/app_clips/configuring_the_launch_experience_of_your_app_clip)》。

> **Important** **重要**
> 
> Apple’s Content Delivery Network requests the `apple-app-site-association` file for your domain within 24 hours. Devices check for updates approximately once per week after app installation.
> 
> 苹果的内容交付网络会在 24 小时内为您的域名请求 `apple-app-site-association` 文件。安装应用程序后，设备大约每周检查一次更新。

# Topics - 主题

## Entitlements - 授权

### [Associated Domains Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains) - 关联域名授权

The associated domains for specific services, such as shared web credentials, universal links, and App Clips.

特定服务的关联域名，例如共享 web 证书、通用链接和 轻App。

## Services - 服务

### [applinks](https://developer.apple.com/documentation/bundleresources/applinks)

The root object for a universal links service definition.

通用链接服务定义的根对象。

