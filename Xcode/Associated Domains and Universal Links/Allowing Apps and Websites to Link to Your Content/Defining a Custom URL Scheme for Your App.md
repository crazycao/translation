# Defining a Custom URL Scheme for Your App
# 在你的App中支持通用链接

原文地址：[https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app)

Use specially formatted URLs to link to content within your app.

使用特殊格式的 URL 链接到应用程序中的内容。

# Overview - 概览

Custom URL schemes provide a way to reference resources inside your app. Users tapping a custom URL in an email, for example, launch your app in a specified context. Other apps can also trigger your app to launch with specific context data; for example, a photo library app might display a specified image.
While custom URL schemes are an acceptable form of deep linking, universal links are strongly recommended. For more information on universal links, see Allowing Apps and Websites to Link to Your Content.
Apple supports common schemes associated with system apps, such as mailto, tel, sms, and facetime. You can define your own custom scheme and register your app to support it.
Warning
URL schemes offer a potential attack vector into your app, so make sure to validate all URL parameters and discard any malformed URLs. In addition, limit the available actions to those that don’t risk the user’s data. For example, don’t allow other apps to directly delete content or access sensitive information about the user. When testing your URL-handling code, make sure your test cases include improperly formatted URLs.
To support a custom URL scheme:
Define the format for your app’s URLs.
Register your scheme so that the system directs appropriate URLs to your app.
Handle the URLs that your app receives.
URLs must start with your custom scheme name. Add parameters for any options your app supports. For example, a photo library app might define a URL format that includes the name or index of a photo album to display. Examples of URLs for such a scheme could include the following:
myphotoapp:albumname?name="albumname"
myphotoapp:albumname?index=1
Clients craft URLs based on your scheme and ask your app to open them by calling the open(_:options:completionHandler:) method of UIApplication. Clients can ask the system to inform them when your app opens the URL.
let url = URL(string: "myphotoapp:Vacation?index=1")

UIApplication.shared.open(url!) { (result) in
    if result {
       // The URL was delivered successfully!
    }
}

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


