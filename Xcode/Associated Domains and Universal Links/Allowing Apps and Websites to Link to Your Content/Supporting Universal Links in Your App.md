# Supporting Universal Links in Your App
# 在你的App中支持通用链接

原文地址：[https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app](https://developer.apple.com/documentation/xcode/supporting-universal-links-in-your-app)

Prepare your app to respond to an incoming universal link.

让你的 app 准备好响应传入的通用链接。

# Overview - 概览

When a user activates a universal link, the system launches your app and sends it an [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) object. Query this object to find out how your app launched and to decide what action to take.

当用户激活一个通用链接时，系统会启动你的应用程序并向其发送一个 [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) 对象。查询这个对象以了解应用程序是如何启动的，并决定要采取的操作。

To support universal links in your app:

要在你的 app 中支持通用链接：

1. Create a two-way association between your app and your website and specify the URLs that your app handles. See [Supporting Associated Domains](https://developer.apple.com/documentation/Xcode/supporting-associated-domains).
2. Update your app delegate to respond when it receives an [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) object with the [activityType](https://developer.apple.com/documentation/foundation/nsuseractivity/1409611-activitytype) set to [NSUserActivityTypeBrowsingWeb](https://developer.apple.com/documentation/foundation/nsuseractivitytypebrowsingweb).

>

1. 在你的程序和网站之间创建双向关联，并指定应用程序处理的 URL。请参阅《[支持关联域名](https://developer.apple.com/documentation/Xcode/supporting-associated-domains)》。
2. 更新应用程序代理，使其在收到 [activityType](https://developer.apple.com/documentation/foundation/nsuseractivity/1409611-activitytype) 设置为 [NSUserActivityTypeBrowsingWeb](https://developer.apple.com/documentation/foundation/nsuseractivitytypebrowsingweb) 的 [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) 对象时做出响应。

> **Warning** **警告**
>
> Universal links offer a potential attack vector into your app, so make sure to validate all URL parameters and discard any malformed URLs. In addition, limit the available actions to those that don’t risk the user’s data. For example, don’t allow universal links to directly delete content or access sensitive information about the user. When testing your URL-handling code, make sure your test cases include improperly formatted URLs.
> 
> 通用链接对您的应用程序提供了潜在的攻击向量，因此请确保验证所有 URL 参数并丢弃任何格式错误的 URL。此外，将可用的操作限制在不危及用户数据的操作上。例如，不要允许通用链接直接删除内容或访问有关用户的敏感信息。测试 URL 处理代码时，请确保测试用例中包含格式不正确的 URL。

# Update Your App Delegate to Respond to a Universal Link - 更新 app 代理以响应通用链接

When the system opens your app as the result of a universal link, your app receives an [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) object with an [activityType](https://developer.apple.com/documentation/foundation/nsuseractivity/1409611-activitytype) value of [NSUserActivityTypeBrowsingWeb](https://developer.apple.com/documentation/foundation/nsuseractivitytypebrowsingweb). The activity object’s [webpageURL](https://developer.apple.com/documentation/foundation/nsuseractivity/1418086-webpageurl) property contains the HTTP or HTTPS URL that the user accesses. Use [NSURLComponents](https://developer.apple.com/documentation/foundation/nsurlcomponents) APIs to extract the components of the URL. See the examples that follow.

当系统通过通用链接打开你的应用程序时，你的应用程序会收到一个 [activityType](https://developer.apple.com/documentation/foundation/nsuseractivity/1409611-activitytype) 值为 [NSUserActivityTypeBrowsingWeb](https://developer.apple.com/documentation/foundation/nsuseractivitytypebrowsingweb) 的 [NSUserActivity](https://developer.apple.com/documentation/foundation/nsuseractivity) 对象。活动对象的 [webpageURL](https://developer.apple.com/documentation/foundation/nsuseractivity/1418086-webpageurl) 属性包含用户访问的 HTTP 或 HTTPS URL。使用 [NSURLComponents](https://developer.apple.com/documentation/foundation/nsurlcomponents) API 提取 URL 的组件。看看下面的例子。

This example code shows how to handle a universal link in macOS:

此示例代码展示了如何在 macOS 中处理通用链接：

```
func application(_ application: NSApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool
{
    // Get URL components from the incoming user activity.
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
        return false
    }

    // Check for specific URL components that you need.
    guard let path = components.path,
    let params = components.queryItems else {
        return false
    }    
    print("path = \(path)")

    if let albumName = params.first(where: { $0.name == "albumname" } )?.value,
        let photoIndex = params.first(where: { $0.name == "index" })?.value {            
        print("album = \(albumName)")
        print("photoIndex = \(photoIndex)")
        return true  

    } else {
        print("Either album name or photo index missing")
        return false
    }
}
```

This example code shows how to handle a universal link in iOS and tvOS:

此示例代码展示了如何在 iOS 和 tvOS 中处理通用链接：

```
func application(_ application: UIApplication,
                 continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
{
    // Get URL components from the incoming user activity.
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
        return false
    }

    // Check for specific URL components that you need.
    guard let path = components.path,
    let params = components.queryItems else {
        return false
    }    
    print("path = \(path)")

    if let albumName = params.first(where: { $0.name == "albumname" } )?.value,
        let photoIndex = params.first(where: { $0.name == "index" })?.value {

        print("album = \(albumName)")
        print("photoIndex = \(photoIndex)")
        return true

    } else {
        print("Either album name or photo index missing")
        return false
    }
}
```

If your app has opted into [Scenes](https://developer.apple.com/documentation/uikit/app_and_environment/scenes), and your app is not running, the system delivers the universal link to the [scene(_:willConnectTo:options:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3197914-scene) delegate method after launch, and to [scene(_:continue:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3238056-scene) when the universal link is tapped while your app is running or suspended in memory.

如果你的 app 选择了 [Scenes](https://developer.apple.com/documentation/uikit/app_and_environment/scenes)，并且你的 app 未运行，系统会在启动后将通用链接交付给 [scene(_:willConnectTo:options:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3197914-scene) 代理方法；而当你的 app 正在运行或在内存中挂起时点击了通用链接，就会交付给 [scene(_:continue:)](https://developer.apple.com/documentation/uikit/uiscenedelegate/3238056-scene) 方法。

```
func scene(_ scene: UIScene, willConnectTo
           session: UISceneSession,
           options connectionOptions: UIScene.ConnectionOptions) {
    
    // Get URL components from the incoming user activity.
    guard let userActivity = connectionOptions.userActivities.first,
        userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
        return
    }

    // Check for specific URL components that you need.
    guard let path = components.path,
        let params = components.queryItems else {
        return
    }
    print("path = \(path)")

    if let albumName = params.first(where: { $0.name == "albumname" })?.value,
        let photoIndex = params.first(where: { $0.name == "index" })?.value {
        
        print("album = \(albumName)")
        print("photoIndex = \(photoIndex)")
    } else {
        print("Either album name or photo index missing")
    }
}
```

This example code shows how to handle a universal link in watchOS:

此示例代码展示了如何在 watchOS 中处理通用链接：

```
func handle(_ userActivity: NSUserActivity)
{
    // Get URL components from the incoming user activity.
    guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
        let incomingURL = userActivity.webpageURL,
        let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else { return }

    // Check for specific URL components that you need.
    guard let path = components.path,
    let params = components.queryItems else { return }    
    print("path = \(path)")

    if let albumName = params.first(where: { $0.name == "albumname" } )?.value,
        let photoIndex = params.first(where: { $0.name == "index" })?.value {            
        print("album = \(albumName)")
        print("photoIndex = \(photoIndex)")
    } else {
        print("Either album name or photo index missing")
    }
}
```

> **Note** **注意**
> 
> In watchOS, a Safari-like interface is available for apps such as Messages and Mail. For other apps, when the user clicks a universal link that points to content in a companion app that the user doesn’t have installed, the system notifies the user to view the URL on their iPhone.
> 
> 在 watchOS 中，在消息和邮件等应用程序中也有类似 Safari 的界面。对于其他应用程序，当用户单击指向用户尚未安装的配套应用程序中内容的通用链接时，系统会通知用户在他们的 iPhone 上查看 URL。


