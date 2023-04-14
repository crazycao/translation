# Defining a Custom URL Scheme for Your App
# 为你的 app 定义一个自定义 URL Scheme

原文地址：[https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app)

Use specially formatted URLs to link to content within your app.

使用特殊格式的 URL 链接到应用程序中的内容。

# Overview - 概览

Custom URL schemes provide a way to reference resources inside your app. Users tapping a custom URL in an email, for example, launch your app in a specified context. Other apps can also trigger your app to launch with specific context data; for example, a photo library app might display a specified image.

自定义 URL Scheme 提供了一种在应用程序中引用资源的方法。例如，用户点击电子邮件中的自定义 URL，就可以在指定的上下文中启动应用程序。其他应用程序也可以让你的应用程序带着特定的上下文数据启动；例如，照片库应用程序可能会显示指定的图像。

While custom URL schemes are an acceptable form of deep linking, universal links are strongly recommended. For more information on universal links, see [Allowing Apps and Websites to Link to Your Content](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content).

虽然自定义 URL 方案是一种可接受的深度链接形式，但强烈建议使用通用链接。有关通用链接的更多信息，请参阅《[允许应用程序和网站链接到的你内容](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content)》。

Apple supports common schemes associated with system apps, such as mailto, tel, sms, and facetime. You can define your own custom scheme and register your app to support it.

苹果支持一些关联到系统应用程序的常见 scheme，如 mailto、tel、sms 和 facetime。您可以定义自己的自定义 scheme，并注册应用程序以支持该 scheme。

> **Warning** **警告**
> 
> URL schemes offer a potential attack vector into your app, so make sure to validate all URL parameters and discard any malformed URLs. In addition, limit the available actions to those that don’t risk the user’s data. For example, don’t allow other apps to directly delete content or access sensitive information about the user. When testing your URL-handling code, make sure your test cases include improperly formatted URLs.
> 
> URL scheme 为您的应用程序提供了潜在的攻击向量，因此请确保验证所有 URL 参数并丢弃任何格式错误的 URL。此外，将可用的操作限制在不危及用户数据的操作上。例如，不允许其他应用直接删除内容或访问有关用户的敏感信息。测试 URL 处理代码时，请确保测试用例中包含格式不正确的 URL。

To support a custom URL scheme:

要支持自定义 URL scheme，请执行以下操作：

1. Define the format for your app’s URLs.
2. Register your scheme so that the system directs appropriate URLs to your app.
3. Handle the URLs that your app receives.

>

1. 定义你的应用程序的 URL 的格式。
2. 注册你的 scheme，以便系统将适当的 URL 定向到你的应用程序。
3. 处理应用程序接收到的 URL。

URLs must start with your custom scheme name. Add parameters for any options your app supports. For example, a photo library app might define a URL format that includes the name or index of a photo album to display. Examples of URLs for such a scheme could include the following:

URL 必须以自定义 scheme 名称开头。为应用程序支持的任意选项添加参数。例如，照片库应用程序可能会定义 URL 格式，其中包括要显示的相册的名称或索引。此类 scheme 的 URL 可能包括以下内容：

```
myphotoapp:albumname?name="albumname"
myphotoapp:albumname?index=1
```

Clients craft URLs based on your scheme and ask your app to open them by calling the [open(_:options:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open) method of [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication). Clients can ask the system to inform them when your app opens the URL.

客户端根据您的 scheme 创建 URL，并通过调用 [UIApplication](https://developer.apple.com/documentation/uikit/uiapplication) 的 [open(_:options:completionHandler:)](https://developer.apple.com/documentation/uikit/uiapplication/1648685-open) 方法，让您的应用程序打开它们。客户端可以要求系统在应用程序打开 URL 时通知他们。

```
let url = URL(string: "myphotoapp:Vacation?index=1")

UIApplication.shared.open(url!) { (result) in
    if result {
       // The URL was delivered successfully!
    }
}
```

# Register Your URL Scheme - 注册你的 URL Scheme

URL scheme registration specifies which URLs to redirect to your app. Register your scheme in Xcode from the `Info` tab of your project settings. Update the `URL Types` section to declare all of the URL schemes your app supports, as shown in the following illustration.

URL Scheme 的注册指定了要重定向到你的 app 的 URL。从在 Xcode 的项目设置中的 `Info` 选项卡注册 scheme。在 `URL Types` 部分声明你的 app 支持的所有 URL scheme，如下图所示。

- In the `URL Schemes` box, specify the prefix you use for your URLs.
- Choose a role for your app: either an editor role for URL schemes you define, or a viewer role for schemes your app adopts but doesn’t define.
- Specify an identifier for your app.

>

- 在“URL Schemes”框中，指定用于 URL 的前缀。
- 为你的应用程序选择一个角色：为你定义的 URL scheme 选择编辑者角色，或为你的应用程序采用但未定义的 scheme 选择查看者角色。
- 为你的应用指定一个标识符。

![Screenshot of Xcode showing the URL Types section with a URL that reads “com.example.myphotoapp.”](https://docs-assets.developer.apple.com/published/33d1c93a0355274a4c27075ab11717f7/17400/images/defining-a-custom-url-scheme-for-your-app-1@2x.png)

The identifier you supply with your scheme distinguishes your app from others that declare support for the same scheme. To ensure uniqueness, specify a reverse DNS string that incorporates your company’s domain and app name. Although using a reverse DNS string is a best practice, it doesn’t prevent other apps from registering the same scheme and handling the associated links. Use universal links instead of custom URL schemes to define links that are uniquely associated with your website.

您在 scheme 中提供的 Identifier 将您的应用程序与声明支持同一 scheme 的其他应用程序区分开来。为确保唯一性，请指定包含公司域名和应用程序名的反向 DNS 字符串。尽管使用反向DNS字符串是最佳实践，但它不会阻止其他应用注册相同的方案并处理相关链接。建议使用通用链接而不是自定义 URL scheme 来定义与网站唯一关联的链接。

Some URL schemes are reserved for system use. The system directs well-known types of URLs to the corresponding system apps, and well-known http–based URLs to specific apps such as Maps, YouTube, and Music. For information about the schemes supported by Apple, see [Apple URL Scheme Reference](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899).

一些 URL scheme 保留供系统使用。系统将已知类型的 URL 定向到相应的系统应用程序，并将基于 http 的已知 URL 定向到特定应用程序，如地图、YouTube 和音乐。有关 Apple 支持的 scheme 的信息，请参阅《[Apple URL Scheme 参考](https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899)》。

# Handle Incoming URLs - 处理收到的 URL

When another app opens a URL containing your custom scheme, the system launches your app, if necessary, and brings it to the foreground. The system delivers the URL to your app by calling your app delegate’s [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) method. Add code to the method to parse the contents of the URL and take appropriate actions. To ensure the URL is parsed correctly, use [NSURLComponents](https://developer.apple.com/documentation/foundation/nsurlcomponents) APIs to extract the components. Obtain additional information about the URL, such as which app opened it, from the system-provided `options` dictionary.

当另一个 app 打开包含了你的自定义 scheme 的 URL，系统会启动你的 app（如果有必要），并将 app 放到前台。系统通过调用你的 app 代理的 [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) 方法把 URL 交付给你的 app。请添加代码到这个方法里，以解析 URL 的内容并采取适当的操作。为了确保正确解析 URL，请使用 [NSURLComponents](https://developer.apple.com/documentation/foundation/nsurlcomponents) API 提取组件。可以从系统提供的 `options` 字典获得关于 URL 的更多信息，比如哪个 app 打开了它。

```
func application(_ application: UIApplication,
                 open url: URL,
                 options: [UIApplicationOpenURLOptionsKey : Any] = [:] ) -> Bool {

    // Determine who sent the URL.
    let sendingAppID = options[.sourceApplication]
    print("source application = \(sendingAppID ?? "Unknown")")

    // Process the URL.
    guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
        let albumPath = components.path,
        let params = components.queryItems else {
            print("Invalid URL or album path missing")
            return false
    }

    if let photoIndex = params.first(where: { $0.name == "index" })?.value {
        print("albumPath = \(albumPath)")
        print("photoIndex = \(photoIndex)")
        return true
    } else {
        print("Photo index missing")
        return false
    }
}
```

The system also uses your app delegate’s [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) method to open custom file types that your app supports.

系统也使用你的 app 代理的 [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) 方法打开你的 app 支持的自定义文件类型。

If your app has opted into Scenes, and your app is not running, the system delivers the URL to the [scene(_:willConnectTo:options:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3197914-scene) delegate method after launch, and to [scene(_:openURLContexts:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3238059-scene) when your app opens a URL while running or suspended in memory.

如果你的 app 选择了 [Scenes](https://developer.apple.com/documentation/uikit/app_and_environment/scenes)，并且你的 app 未运行，系统会在启动后将通用链接交付给 [scene(_:willConnectTo:options:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3197914-scene) 代理方法；而当你的 app 正在运行或在内存中挂起时点击了通用链接，就会交付给  [scene(_:openURLContexts:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3238059-scene) 方法。

```
func scene(_ scene: UIScene, 
           willConnectTo session: UISceneSession, 
           options connectionOptions: UIScene.ConnectionOptions) {

    // Determine who sent the URL.
    if let urlContext = connectionOptions.urlContexts.first {

        let sendingAppID = urlContext.options.sourceApplication
        let url = urlContext.url
        print("source application = \(sendingAppID ?? "Unknown")")
        print("url = \(url)")

        // Process the URL similarly to the UIApplicationDelegate example.
    }

    /*
     *
     */
}
```
