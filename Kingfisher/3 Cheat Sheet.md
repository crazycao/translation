# Cheat Sheet - 速查表

原文地址：[https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet](https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet)


> Feel free to copy & paste code below.
> 
> 请随意复制并粘贴下面的代码。

This documentation will describe some most common usage of Kingfisher. The code snippet is based on iOS. However, the similar code should also work for other platforms like macOS or tvOS, by replacing the corresponding class (such as `UIImage` to `NSImage`, etc).

这份文档将描述一些 Kingfisher 最常见的用法。代码片段基于 iOS 平台，但是类似的代码也适用于其他平台，比如 macOS 或者 tvOS，只需要将对应的类进行替换（比如 `UIImage` 替换为 `NSImage`，等等）。

This guide covers the most useful part of Kingfisher components. If you want to know the detail of them, please also check the full [API Reference](https://swiftpackageindex.com/onevcat/Kingfisher/master/documentation/kingfisher/).

本指南涵盖了 Kingfisher 组件中最常用的部分。如果您想了解它们的详细信息，请同时查阅完整的《[API 参考文档](https://swiftpackageindex.com/onevcat/Kingfisher/master/documentation/kingfisher/)》。

## Most common tasks - 最常见的任务

The view extension based APIs (for UIImageView, NSImageView, UIButton and NSButton) should be your first choice whenever possible. It keeps your code simple and elegant.

尽可能基于视图扩展的 API（针对 UIImageView、NSImageView、UIButton 和 NSButton）应该是您的首选。它能使您的代码保持简洁和优雅。

### Setting image with a URL - 使用 URL 设置图像
```
let url = URL(string: "https://example.com/image.jpg")
imageView.kf.setImage(with: url)
```

This simple code:

1. Checks whether an image is cached under the key `url.absoluteString`.
2. If an image was found in the cache (either in memory or disk), sets it to `imageView.image`.
3. If not, creates a request and download it from `url`.
4. Converts the downloaded data to a `UIImage` object.
5. Caches the image to memory cache, and store the data to the disk cache.
6. Sets the `imageView.image` to display it.

Later, when you call `setImage` with the same `url` again, only the first two steps will be performed, unless the cache is purged.

这段简单的代码：

1. 检查是否在以 `url.absoluteString` 作为键的缓存中存在图像。
2. 如果在缓存中找到图像（无论是在内存中还是磁盘上），则将其设置为 `imageView.image`。
3. 如果没有找到图像，则创建一个请求并从 `url` 下载图像。
4. 将下载的数据转换为 `UIImage` 对象。
5. 将图像缓存到内存缓存中，并将数据存储到磁盘缓存中。
6. 将 `imageView.image` 设置为显示图像。

以后，当再次使用相同的 `url` 调用 `setImage` 时，除非缓存被清除，只会执行前两个步骤。

### Showing a placeholder - 展示占位图
```
let image = UIImage(named: "default_profile_icon")
imageView.kf.setImage(with: url, placeholder: image)
```

The `image` will show in the `imageView` while downloading from `url`.

在从 `url` 下载的过程中，这个 `image` 将会在 `imageView` 中显示。

> You could also use a customized `UIView` or `NSView` as placeholder, by conforming it to `Placeholder`:
> 
> 你也可以使用自定义的 `UIView` 或 `NSView` 作为占位图，只要让它遵守 `Placeholder` 协议：
> 
> ```
> class MyView: UIView { /* Your implementation of view */ }
> extension MyView: Placeholder { /* Just leave it empty */}
> imageView.kf.setImage(with: url, placeholder: MyView())
> ```
> The `MyView` instance will be added to / removed from the `imageView` as needed.
> 
> `MyView` 实例将会按照需要被添加到 `imageView` 或从 `imageView` 移除。

### Showing a loading indicator while downloading - 在下载时展示 loading 指示器
```
imageView.kf.indicatorType = .activity
imageView.kf.setImage(with: url)
```

Show a `UIActivityIndicatorView` in center of image view while downloading.

在下载时，在图像视图的中心展示一个 `UIActivityIndicatorView`。

### Fading in downloaded image - 已下载图像中的淡入淡出效果
```
imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
```

### Completion handler - 完成句柄
```
imageView.kf.setImage(with: url) { result in
    // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
    // `result` 是 `.success(RetrieveImageResult)` 或 `.failure(KingfisherError)`
    switch result {
    case .success(let value):
        // The image was set to image view:
        // 设置到图像视图的图像
        print(value.image)

        // From where the image was retrieved:
        // - .none - Just downloaded.
        // - .memory - Got from memory cache.
        // - .disk - Got from disk cache.
        // 从哪里获取的图像：
        // - .none - 刚刚下载的。
        // - .memory - 从内存缓存获得。
        // - .disk - 从磁盘缓存获得。
        print(value.cacheType)

        // The source object which contains information like `url`.
        // 包含像 `url` 这样的信息的来源对象。
        print(value.source)

    case .failure(let error):
        // The error happens
        // 发生的错误
        print(error) 
    }
}
```

### Round conner image - 圆角图片
```
let processor = RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.setImage(with: url, options: [.processor(processor)])
```

> There are also a bunch of built-in processors in Kingfisher. See the [Processor](https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#processor) section below.
>
> Kingfisher 还提供了一系列内置的图像处理器。请参阅下面的《[处理器](https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet#processor)》部分。

### Getting an image without UI - 不用 UI 获取图像
Sometimes, you just want to get the image with Kingfisher instead of setting it to an image view. Use `KingfisherManager` for it:

有时候，您可能只想使用 Kingfisher 来获取图像，而不是将其设置到图像视图中。在这种情况下，可以使用 `KingfisherManager`：

```
KingfisherManager.shared.retrieveImage(with: url) { result in 
    // Do something with `result`
    // 使用 `result` 来做一些事情
}
```

## Cache - 缓存

Kingfisher is using a hybrid `ImageCache` to manage the cached images, It consists of a memory storage and a disk storage, and provides high-level APIs to manipulate the cache system. If not specified, the `ImageCache.default` instance will be used across in Kingfisher.

Kingfisher 使用混合图像缓存来管理缓存的图像，其中包括内存存储和磁盘存储，并提供高级 API 来操作缓存系统。如果没有指定，Kingfisher 将在整个应用中使用默认的 `ImageCache.default` 实例。

### Using another cache key - 使用其他缓存键

By default, URL will be used to create a string for the cache key. For network URLs, the `absoluteString` will be used. In any case, you change the key by creating an `ImageResource` with your own key.

默认情况下，将用 URL 来创建一个字符串作为缓存键。对于网络 URL，将使用其 `absoluteString`。但是您可以通过创建一个带有自定义键的 `ImageResource` 来更改键。

```
let resource = ImageResource(downloadURL: url, cacheKey: "my_cache_key")
imageView.kf.setImage(with: resource)
```

Kingfisher will use the `cacheKey` to search images in cache later. Use a different key for a different image.

之后，Kingfisher 将使用 `cacheKey` 来在缓存中搜索图像。请为不同的图像使用不同的键。

### Check whether an image in the cache - 检查图像是否在缓存中

```
let cache = ImageCache.default
let cached = cache.isCached(forKey: cacheKey)

// To know where the cached image is:
// 要知道缓存图像的位置
let cacheType = cache.imageCachedType(forKey: cacheKey)
// `.memory`, `.disk` or `.none`.
```

If you used a processor when you retrieve the image, the processed image will be stored in cache. In this case, also pass the processor identifier:

如果在检索图像时使用了处理器，会把处理后的图像存储在缓存中。在这种情况下，还需要传递处理器标识符：

```
let processor = RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.setImage(with: url, options: [.processor(processor)])

// Later 之后
cache.isCached(forKey: cacheKey, processorIdentifier: processor.identifier)
```

### Get an image from cache - 从缓存中获取图像

```
cache.retrieveImage(forKey: "cacheKey") { result in
    switch result {
    case .success(let value):
        print(value.cacheType)

        // If the `cacheType is `.none`, `image` will be `nil`.
        // 如果 cacheType 是 `.none`，`image` 将为 `nil`。
        print(value.image)

    case .failure(let error):
        print(error)
    }
}
```

### Set limit for cache - 设置缓存限制

For memory storage, you can set its `totalCostLimit` and `countLimit`:

对于内存存储，您可以设置其 `totalCostLimit` 和 `countLimit`：

```
// Limit memory cache size to 300 MB.
// 将内存缓存大小限制为 300 MB。
cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024

// Limit memory cache to hold 150 images at most. 
// 将内存缓存限制为最多容纳 150 个图像。
cache.memoryStorage.config.countLimit = 150
```

By default, the `totalCostLimit` of memory cache is 25% of your total memory in the device, and there is no limit on image count.

默认情况下，内存缓存的 `totalCostLimit` 是设备总内存的 25%，而图像数量没有限制。

For disk storage, you can set `sizeLimit` for space on the file system.

对于磁盘存储，您可以设置文件系统上的空间的 `sizeLimit`：

```
// Limit disk cache size to 1 GB.
// 将磁盘缓存大小限制为 1 GB。
cache.diskStorage.config.sizeLimit =  = 1000 * 1024 * 1024
```

### Set default expiration for cache - 设置默认缓存过期时间

Both memory storage and disk storage have default expiration setting. Images in memory storage will expire after 5 minutes from last accessed, while it is a week for images in disk storage. You can change this value by:

内存存储和磁盘存储都有默认的过期设置。内存存储中的图像在最后访问后的5分钟内过期，而磁盘存储中的图像在一周后过期。您可以通过以下方式更改这个值：

```
// Memory image expires after 10 minutes.
// 内存中的图像在10分钟后过期。
cache.memoryStorage.config.expiration = .seconds(600)

// Disk image never expires.
// 磁盘中的图像永不过期。
cache.diskStorage.config.expiration = .never
```

If you want to override this expiration for a certain image when caching it, pass in with an option:

如果您希望在缓存某个特定图像时覆盖该过期设置，请使用选项进行设置：

```
// This image will never expire in memory cache.
// 此图像在内存缓存中永不过期。
imageView.kf.setImage(with: url, options: [.memoryCacheExpiration(.never)])
```

The expired memory cache will be purged with a duration of 2 minutes. If you want it happens more frequently:

过期的内存缓存将在2分钟后被清除。如果您希望更频繁地清除它：

```
// Check memory clean up every 30 seconds.
// 每30秒检查一次内存清理。
cache.memoryStorage.config.cleanInterval = 30
```

### Store images to cache manually - 手动将图像存储到缓存中

By default, view extension methods and `KingfisherManager` will store the retrieved image to cache automatically. But you can also store an image to cache yourself:

默认情况下，视图扩展方法和 `KingfisherManager` 会自动将检索到的图像存储到缓存中。但您也可以自己手动将图像存储到缓存中：

```
let image: UIImage = //...
cache.store(image, forKey: cacheKey)
```

If you have the original data of that image, also pass it to `ImageCache`, it helps Kingfisher to determine in which format the image should be stored:

如果您拥有该图像的原始数据，请同时将其传递给 `ImageCache`，这有助于 Kingfisher 确定以哪种格式存储图像：

```
let data: Data = //...
let image: UIImage = //...
cache.store(image, original: data, forKey: cacheKey)
```

### Remove images from cache manually - 手动从缓存中移除图像

Kingfisher manages its cache automatically. But you still can manually remove a certain image from cache:

Kingfisher 会自动管理其缓存，而您仍然可以手动从缓存中移除特定的图像：

```
cache.default.removeImage(forKey: cacheKey)
```

Or, with more control:

或者，更加灵活地控制：

```
cache.removeImage(
    forKey: cacheKey,
    processorIdentifier: processor.identifier,
    fromMemory: false,
    fromDisk: true)
{
    print("Removed!")
}
```

### Clear the cache - 清除缓存

```
// Remove all.
// 移除全部。
cache.clearMemoryCache()
cache.clearDiskCache { print("Done") }

// Remove only expired.
// 只移除过期的。
cache.cleanExpiredMemoryCache()
cache.cleanExpiredDiskCache { print("Done") }
```

### Report the disk storage size - 报告磁盘存储的大小

```
ImageCache.default.calculateDiskStorageSize { result in
    switch result {
    case .success(let size):
        print("Disk cache size: \(Double(size) / 1024 / 1024) MB")
    case .failure(let error):
        print(error)
    }
}
```

### Create your own cache and use it - 创建你自己的缓存并使用

```
// The `name` parameter is used to identify the disk cache bound to the `ImageCache`.
// `name` 参数用于标识与 `ImageCache` 相关联的磁盘缓存。
let cache = ImageCache(name: "my-own-cache")
imageView.kf.setImage(with: url, options: [.targetCache(cache)])
```

## Downloader - 下载器

`ImageDownloader` wraps a `URLSession` for downloading an image from the Internet. Similar to `ImageCache`, there is an `ImageDownloader.default` for downloading tasks.

`ImageDownloader` 封装了 `URLSession` 用于从互联网上下载图像。类似于 `ImageCache`，也有一个默认的 `ImageDownloader.default` 用于下载任务。

### Downloading an image manually - 手动下载图像

Usually, you may use Kingfisher's view extension methods or `KingfisherManager` to retrieve an image. They will try to search in the cache first to prevent unnecessary download task. In some cases, if you only want to download a target image without caching it:

通常情况下，您可以使用 Kingfisher 的视图扩展方法或 `KingfisherManager` 来检索图像。它们会首先尝试在缓存中查找，以避免不必要的下载任务。在某些情况下，如果您只想下载目标图像而不缓存它：

```
let downloader = ImageDownloader.default
downloader.downloadImage(with: url) { result in
    switch result {
    case .success(let value):
        print(value.image)
    case .failure(let error):
        print(error)
    }
}
```

### Modify a request before sending - 在发送请求之前修改请求

When you have permission control for your image resource, you can modify the request by using a `.requestModifier`:

如果您对图像资源有权限控制，可以使用 `.requestModifier` 来修改请求：

```
let modifier = AnyModifier { request in
    var r = request
    r.setValue("abc", forHTTPHeaderField: "Access-Token")
    return r
}
downloader.downloadImage(with: url, options: [.requestModifier(modifier)]) { 
    result in
    // ...
}

// This option also works for view extension methods.
// 这个选项也适用于视图扩展方法。
imageView.kf.setImage(with: url, options: [.requestModifier(modifier)])
```

### Async Request Modifier - 异步请求修改器

If you need to perform some asynchronous operation before modifying the request, create a type and conform to `AsyncImageDownloadRequestModifier`:

如果您需要在修改请求之前执行一些异步操作，请创建一个类型并遵从 `AsyncImageDownloadRequestModifier` 协议：

```
class AsyncModifier: AsyncImageDownloadRequestModifier {
    var onDownloadTaskStarted: ((DownloadTask?) -> Void)?

    func modified(for request: URLRequest, reportModified: @escaping (URLRequest?) -> Void) {
        var r = request
        someAsyncOperation { result in
            r.someProperty = result.property
            reportModified(r)
        }
    }
}
```

Similar as above, you can use the `.requestModifier` to use this modifier. In this case, the `setImage(with:options:)` or `ImageDownloader.downloadImage(with:options:)` method will not return a `DownloadTask` anymore (since it does not start the download task immediately). Instead, you observe one from the `onDownloadTaskStarted` callback if you need a reference to the task:

与前面的描述类似，您可以使用 `.requestModifier` 来使用此修改器。在这种情况下，`setImage(with:options:)` 或 `ImageDownloader.downloadImage(with:options:)` 方法不再返回 `DownloadTask`（因为它不会立即启动下载任务）。相反，如果您需要对任务引用，可以从 `onDownloadTaskStarted` 回调中观察到它：

```
let modifier = AsyncModifier()
modifier.onDownloadTaskStarted = { task in
    if let task = task {
        print("A download task started: \(task)")
    }
}
let nilTask = imageView.kf.setImage(with: url, options: [.requestModifier(modifier)])
```

### Cancelling a download task - 取消下载任务

If the downloading started, a `DownloadTask` will be returned. You can use it to cancel an on-going download task:

如果下载已经开始，将返回一个 `DownloadTask`。您可以使用它来取消正在进行的下载任务：

```
let task = downloader.downloadImage(with: url) { result in
    // ...
    case .failure(let error):
        print(error.isTaskCancelled) // true
    }

}

// After for a while, before download task finishes.
// 在一段时间后，在下载任务完成之前。
task?.cancel()
```

If the task already finished when you call `task?.cancel()`, nothing will happen.

如果在调用 `task?.cancel()` 时任务已经完成，将不会发生任何事情。

Similar, the view extension methods also return `DownloadTask`. You can store and cancel it:

类似地，视图扩展方法也会返回 `DownloadTask`。您可以存储并取消它：

```
let task = imageView.kf.set(with: url)
task?.cancel()
```

Or, you can call `cancelDownloadTask` on the image view to cancel the current downloading task:

或者，您可以调用图像视图的 `cancelDownloadTask` 方法来取消当前的下载任务：

```
let task1 = imageView.kf.set(with: url1)
let task2 = imageView.kf.set(with: url2)

imageView.kf.cancelDownloadTask()
// `task2` will be cancelled, but `task1` is still running. 
// However, the downloaded image for `task1` will not be set because the image view expects a result from `url2`.
// `task2` 将被取消，但 `task1` 仍在运行。 
// 但是，`task1` 的下载图像不会被设置，因为图像视图期望从 `url2` 获取结果。
```

### Authentication with NSURLCredential - 使用 NSURLCredential 进行身份验证

The `ImageDownloader` uses a default behavior (`.performDefaultHandling`) when receives a challenge from server. If you need to provide your own credentials, setup an `authenticationChallengeResponder`:

`ImageDownloader` 在收到来自服务器的挑战时使用默认行为（`.performDefaultHandling`）。如果您需要提供自己的凭据，请设置 `authenticationChallengeResponder`：

```
// In ViewController
// 在 ViewController 中
ImageDownloader.default.authenticationChallengeResponder = self

extension ViewController: AuthenticationChallengeResponsable {

    var disposition: URLSession.AuthChallengeDisposition { /* */ }
    let credential: URLCredential? { /* */ }

    func downloader(
        _ downloader: ImageDownloader,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        // Provide your `AuthChallengeDisposition` and `URLCredential`
        // 提供您的 `AuthChallengeDisposition` 和 `URLCredential`
        completionHandler(disposition, credential)
    }

    func downloader(
        _ downloader: ImageDownloader,
        task: URLSessionTask,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        // Provide your `AuthChallengeDisposition` and `URLCredential`
        // 提供您的 `AuthChallengeDisposition` 和 `URLCredential`
        completionHandler(disposition, credential)
    }
}
```

### Download timeout - 下载超时

By default, the download timeout for a request is 15 seconds. To set it for the downloader:

默认情况下，一个请求的下载超时时间是 15 秒。可以通过下载器来设置。

```
// Set timeout to 1 minute.
// 设置超时时间为 1 分钟。
downloader.downloadTimeout = 60
```

To define a timeout for a certain request, use a `.requestModifier`:

要为特定请求定义超时时间，请使用 `.requestModifier`：

```
let modifier = AnyModifier { request in
    var r = request
    r.timeoutInterval = 60
    return r
}
downloader.downloadImage(with: url, options: [.requestModifier(modifier)])
```

## Processor - 处理器

`ImageProcessor` transforms an image (or data) to another image. You can provide a processor to `ImageDownloader` to apply it to the downloaded data. Then processed image will be sent to the image view and the cache.

`ImageProcessor` 用于将一个图像（或数据）转换为另一个图像。您可以将处理器提供给 `ImageDownloader`，以将其应用于下载的数据。然后，处理后的图像将发送到图像视图和缓存中。

### Use the default processor - 使用默认处理器

```
// Just without anything
// 什么都不加
imageView.kf.setImage(with: url)
// It equals to
// 等同于
imageView.kf.setImage(with: url, options: [.processor(DefaultImageProcessor.default)])
```

> `DefaultImageProcessor` converts downloaded data to a corresponded image object. PNG, JPEG, and GIF are supported.
> 
> `DefaultImageProcessor` 将下载的数据转换为相应的视图对象。支持 PNG、JPEG 和 GIF。

### Built-in processors - 内置处理器

```
// Round corner - 圆角
let processor = RoundCornerImageProcessor(cornerRadius: 20)

// Downsampling - 采样
let processor = DownsamplingImageProcessor(size: CGSize(width: 100, height: 100))

// Cropping - 裁剪
let processor = CroppingImageProcessor(size: CGSize(width: 100, height: 100), anchor: CGPoint(x: 0.5, y: 0.5))

// Blur - 模糊
let processor = BlurImageProcessor(blurRadius: 5.0)

// Overlay with a color & fraction - 叠加颜色恶核透明度
let processor = OverlayImageProcessor(overlay: .red, fraction: 0.7)

// Tint with a color - 着色
let processor = TintImageProcessor(tint: .blue)

// Adjust color - 调色
let processor = ColorControlsProcessor(brightness: 1.0, contrast: 0.7, saturation: 1.1, inputEV: 0.7)

// Black & White - 黑白
let processor = BlackWhiteProcessor()

// Blend (iOS) - 混合（iOS）
let processor = BlendImageProcessor(blendMode: .darken, alpha: 1.0, backgroundColor: .lightGray)

// Compositing - 合成
let processor = CompositingImageProcessor(compositingOperation: .darken, alpha: 1.0, backgroundColor: .lightGray)

// Use the process in view extension methods. - 在视图扩展方法中使用处理器
imageView.kf.setImage(with: url, options: [.processor(processor)])
```

### Multiple processors - 多处理器

```
// First blur the image, then make it round cornered.
// 先模糊图像，然后给它添加圆角
let processor = BlurImageProcessor(blurRadius: 4) |> RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.setImage(with: url, options: [.processor(processor)])
```

### Creating your own processor - 创建你自己的处理器

Make a type conforming to `ImageProcessor` by implementing `identifier` and `process`:

```
struct MyProcessor: ImageProcessor {

    // `identifier` should be the same for processors with the same properties/functionality
    // It will be used when storing and retrieving the image to/from cache.
    // `identifier`应该对于具有相同属性/功能的处理器是相同的
    // 在存储和检索图像到/从缓存中时将使用它。
    let identifier = "com.yourdomain.myprocessor"
    
    // Convert input data/image to target image and return it.
    // 将输入的数据/图像转换为目标图像并返回它。
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            // A previous processor already converted the image to an image object.
            // You can do whatever you want to apply to the image and return the result.
            // 先前的处理器已将图像转换为图像对象。
       	     // 您可以对图像应用任何所需的处理并返回结果。
            return image
        case .data(let data):
            // Your own way to convert some data to an image.
            // 您自己的方法来将一些数据转换为图像。
            return createAnImage(data: data)
        }
    }
}

// Then pass it to the `setImage` methods:
// 然后将其传递给 `setImage` 方法：
let processor = MyProcessor()
let url = URL(string: "https://example.com/my_image.png")
imageView.kf.setImage(with: url, options: [.processor(processor)])
```

### Creating a processor from CIFilter - 从 CIFilter 创建处理器

If you have a prepared `CIFilter`, you can create a processor quickly from it.

如果您有一个准备好的 `CIFilter`，可以快速创建处理器。

```
struct MyCIFilter: CIImageProcessor {

    let identifier = "com.yourdomain.myCIFilter"
    
    let filter = Filter { input in
        guard let filter = CIFilter(name: "xxx") else { return nil }
        filter.setValue(input, forKey: kCIInputBackgroundImageKey)
        return filter.outputImage
    }
}
```

## Serializer - 序列化器

`CacheSerializer` will be used to convert some data to an image object for retrieving from disk cache and vice versa for storing to the disk cache.

`CacheSerializer` 用于将某些数据转换为图像对象以从磁盘缓存中检索，并反之亦然，以便存储到磁盘缓存。。

### Use the default serializer - 使用默认序列化器

```
// Just without anything
// 什么都不加
imageView.kf.setImage(with: url)
// It equals to
// 等同于
imageView.kf.setImage(with: url, options: [.cacheSerializer(DefaultCacheSerializer.default)])
```

> `DefaultCacheSerializer` converts cached data to a corresponded image object and vice versa. PNG, JPEG, and GIF are supported by default.
> 
> `DefaultCacheSerializer` 将缓存的数据转换为相应的图像对象，反之亦然。默认支持PNG、JPEG和GIF格式。

### Serializer to force a format - 强制指定格式的序列化器

To specify a certain format an image should be, use FormatIndicatedCacheSerializer. It provides serializers for all built-in supported format: `FormatIndicatedCacheSerializer.png`, `FormatIndicatedCacheSerializer.jpeg` and `FormatIndicatedCacheSerializer.gif`.

要指定图像应该具有的特定格式，请使用 `FormatIndicatedCacheSerializer`。它提供的序列化器支持所有内置的格式：`FormatIndicatedCacheSerializer.png`、`FormatIndicatedCacheSerializer.jpeg` 和 `FormatIndicatedCacheSerializer.gif`。

By using the `DefaultCacheSerializer`, Kingfisher respects the input image data format and try to keep it unchanged. However, sometimes this default behavior might be not what you want. A common case is that, when you using a RoundCornerImageProcessor, in most cases maybe you want to have an alpha channel (for the corner part). If your original image is JPEG, the alpha channel would be lost when storing to disk. In this case, you may also want to set the png serializer to force converting the images to PNG:

通过使用 `DefaultCacheSerializer`，Kingfisher 尊重输入图像数据的格式并尝试保持其不变。然而，有时这种默认行为可能不是您想要的。一个常见的情况是，当您使用 `RoundCornerImageProcessor` 时，大多数情况下可能希望有一个 alpha 通道（用于圆角部分）。如果原始图像是 JPEG 格式，存储到磁盘时 alpha 通道将丢失。在这种情况下，您可能还希望设置 png 序列化器，以强制将图像转换为 PNG 格式：

```
let roundCorner = RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.setImage(with: url, 
    options: [.processor(roundCorner), 
              .cacheSerializer(FormatIndicatedCacheSerializer.png)]
)
```

### Creating your own serializer - 创建你自己的序列化器

Make a type conforming to `CacheSerializer` by implementing `data(with:original:)` and `image(with:options:)`:

通过实现 `data(with:original:)` 和 `image(with:options:)`，创建一个符合 `CacheSerializer` 协议的类型：

```
struct MyCacheSerializer: CacheSerializer {
    func data(with image: Image, original: Data?) -> Data? {
        return MyFramework.data(of: image)
    }
    
    func image(with data: Data, options: KingfisherParsedOptionsInfo?) -> Image? {
        return MyFramework.createImage(from: data)
    }
}

// Then pass it to the `setImage` methods:
// 然后将其传递给 `setImage` 方法：
let serializer = MyCacheSerializer()
let url = URL(string: "https://yourdomain.com/example.png")
imageView.kf.setImage(with: url, options: [.cacheSerializer(serializer)])
```

## Prefetch - 预先获取

You could prefetch some images and cache them before you display them on the screen. This is useful when you know a list of image resources you know they would probably be shown later.

在将图片显示在屏幕上之前，您可以预先获取并缓存一些图片。当您知道一组图片资源可能会在稍后显示时，这非常有用。

```
let urls = ["https://example.com/image1.jpg", "https://example.com/image2.jpg"]
           .map { URL(string: $0)! }
let prefetcher = ImagePrefetcher(urls: urls) {
    skippedResources, failedResources, completedResources in
    print("These resources are prefetched: \(completedResources)")
}
prefetcher.start()

// Later when you need to display these images:
// 随后当你需要显示这是图像时：
imageView.kf.setImage(with: urls[0])
anotherImageView.kf.setImage(with: urls[1])
```

### Using `ImagePrefetcher` with `UICollectionView` or `UITableView` - 在 `UICollectionView` 或 `UITableView` 中使用 `ImagePrefetcher`

From iOS 10, Apple introduced a cell prefetching behavior. It could work seamlessly with Kingfisher's `ImagePrefetcher`.

从 iOS 10 开始，Apple引入了一种单元格预取行为。它可以与Kingfisher的ImagePrefetcher无缝协作。

```
override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.prefetchDataSource = self
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.flatMap { URL(string: $0.urlString) }
        ImagePrefetcher(urls: urls).start()
    }
}
```

See [WWDC 16 - Session 219](https://developer.apple.com/videos/play/wwdc2016/219/) for more about changing of it in iOS 10.

请参阅 [WWDC 16 - Session 219](https://developer.apple.com/videos/play/wwdc2016/219/)，了解更多关于 iOS 10 中此变化的详细信息。

## ImageDataProvider - 图像数据提供器

Instead of downloading an image from the network, Kingfisher also supports to set image from a data provider. This is useful when you have local data for images. At the same time, you want to use Kingfisher's options to process and manage them.

除了从网络下载图像外，Kingfisher 还支持通过数据提供器设置图像。当您拥有图像的本地数据，同时希望使用 Kingfisher 的选项来处理和管理它们时，这将非常有用。

### Image from local file - 来自本地文件的图像

`LocalFileImageDataProvider` is a type conforming to `ImageDataProvider`. It is used to load an image from a local file URL:

`LocalFileImageDataProvider` 是一种符合 `ImageDataProvider` 协议的类型。它用于从本地文件 URL 加载图像：

```
let url = URL(fileURLWithPath: path)
let provider = LocalFileImageDataProvider(fileURL: url)
imageView.kf.setImage(with: provider)
```

You can also pass options to it:

您也可以向其传递选项：

```
let processor = RoundCornerImageProcessor(cornerRadius: 20)
imageView.kf.setImage(with: provider, options: [.processor(processor)])
```

### Image from Base64 String - 来自 Base64 字符串的图像

Use `Base64ImageDataProvider` to provide an image from base64 encoded data. All other features you expected, such as cache or image processors, should work as they are as when getting images from an URL.

使用 `Base64ImageDataProvider` 提供经 Base64 编码的数据的图像。所有其他您期望的功能，例如缓存或图像处理器，应与从 URL 获取图像时一样。

```
let provider = Base64ImageDataProvider(base64String: "\/9j\/4AAQSkZJRgABAQA...", cacheKey: "some-cache-key")
imageView.kf.setImage(with: provider)
```

### Generating Image from AVAsset - 从 AVAsset 生成图像

Use `AVAssetImageDataProvider` to generate an image from a video URL or `AVAsset` at a given time:

使用 `AVAssetImageDataProvider` 可以根据给定的时间从视频 URL 或 `AVAsset` 生成图像：

```
let provider = AVAssetImageDataProvider(
    assetURL: URL(string: "https://example.com/your_video.mp4")!,
    seconds: 15.0
)
```

### Creating your own image data provider - 创建自己的图像数据提供器

If you want to create your own image data provider type, conform to `ImageDataProvider` protocol by implementing a `cacheKey` and a `data(handler:)` method to provide image data:

如果您想要创建自己的图像数据提供器类型，请遵循 `ImageDataProvider` 协议，通过实现 `cacheKey` 和 `data(handler:)` 方法来提供图像数据：

```
struct UserNameLetterIconImageProvider: ImageDataProvider {
    var cacheKey: String { return letter }
    let letter: String
    
    init(userNameFirstLetter: String) {
        self.letter = userNameFirstLetter
    }
    
    func data(handler: @escaping (Result<Data, Error>) -> Void) {
        
        // You can ignore these detail below.
        // It generates some data for an image with `letter` being rendered in the center.
        // 你可以忽略下面的细节。
        // 它为中心呈现 `letter` 的图像生成一些数据。

        let letter = self.letter as NSString
        let rect = CGRect(x: 0, y: 0, width: 250, height: 250)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let data = renderer.pngData { context in
            UIColor.black.setFill()
            context.fill(rect)
            
            let attributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                                      .font: UIFont.systemFont(ofSize: 200)
            ]
            
            let textSize = letter.size(withAttributes: attributes)
            let textRect = CGRect(
                x: (rect.width - textSize.width) / 2,
                y: (rect.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height)
            letter.draw(in: textRect, withAttributes: attributes)
        }

        // Provide the image data in `handler`.
        // 在 `handler` 中提供图像数据
        handler(.success(data))
    }
}

// Set image for user "John"
// 为用户 `John` 设置图像
let provider = UserNameLetterIconImageProvider(userNameFirstLetter: "J")
imageView.kf.setImage(with: provider)
```

Maybe you have already noticed, the `data(handler:)` contains a callback to you. You can provide the image data in an asynchronous way from another thread if it is too heavy in the main thread.

也许您已经注意到，`data(handler:)` 中包含了对您的回调。如果主线程中的图像数据太重，则可以从另一个线程以异步方式提供图像数据。

## Indicator - 指示器

### Using an image as the indicator - 使用图像作为指示器

```
let path = Bundle.main.path(forResource: "loader", ofType: "gif")!
let data = try! Data(contentsOf: URL(fileURLWithPath: path))

imageView.kf.indicatorType = .image(imageData: data)
imageView.kf.setImage(with: url)
```

### Using a customized view - 使用自定义视图

```
struct MyIndicator: Indicator {
    let view: UIView = UIView()
    
    func startAnimatingView() { view.isHidden = false }
    func stopAnimatingView() { view.isHidden = true }
    
    init() {
        view.backgroundColor = .red
    }
}

let i = MyIndicator()
imageView.kf.indicatorType = .custom(indicator: i)
```

### Updating your own indicator with percentage - 按百分比更新你自己的指示器

```
imageView.kf.setImage(with: url, progressBlock: {
    receivedSize, totalSize in
    let percentage = (Float(receivedSize) / Float(totalSize)) * 100.0
    print("downloading progress: \(percentage)%")
    myIndicator.percentage = percentage
})
```

The `progressBlock` will be only called if your server response contains the "Content-Length" in the header.

只有当服务器响应头中包含 “Content-Length” 时，`progressBlock` 才会被调用。

## Retry - 重试

Use `.retryStrategy` and `DelayRetryStrategy` to implement a simple retry mechanism when setting an image:

使用 `.retryStrategy` 和 `DelayRetryStrategy`，在设置图像时实现简单的重试机制：

```
let retry = DelayRetryStrategy(maxRetryCount: 5, retryInterval: .seconds(3))
imageView.kf.setImage(with: url, options: [.retryStrategy(retry)])
```

This will retry the target URL for at most 5 times, with a constant 3 seconds as the interval between each attempt. You can also choose an `.accumulated(3)` as the retry interval, which gives you an accumulated `3 -> 6 -> 9 -> 12 -> 15` retry interval. Or you can even define your own interval pattern by `.custom`.

这将对目标 URL 最多重试 5 次，每次尝试之间的间隔为 3 秒。您还可以选择以 `.accumulated(3)` 作为重试间隔，这样会得到累积的 `3 -> 6 -> 9 -> 12 -> 15` 的重试间隔。或者您甚至可以通过 `.custom` 定义自己的间隔模式。

If you need more control for the retry strategy, implement your own type conforming to the `RetryStrategy` protocol.

如果您需要更多对重试策略的控制，可以实现符合 `RetryStrategy` 协议的自己的类型，。

## Other options - 其他选项

### Skipping cache searching, force downloading image again - 跳过缓存搜索，强制重新下载图片

```
imageView.kf.setImage(with: url, options: [.forceRefresh])
```

### Only search cache for the image, do not download if not existing - 仅搜索缓存，如果图像不存在也不下载

This makes your app to an "offline" mode.

这会让您的 App 进入“离线”模式。

```
imageView.kf.setImage(with: url, options: [.onlyFromCache])
```

If the image is not existing in the cache, a `.cacheError` with `.imageNotExisting` reason will be raised.

如果图像在缓存中不存在，将引发一个带有 `.imageNotExisting` 原因的 `.cacheError`。

### Loading disk file synchronously - 同步加载磁盘文件

By default, all operations, including disk cache loading, are asynchronous for performance. Sometimes, you may want to reload an image (in a table view, for example). If the cached images only exist in the disk cache, you will find a flickering. That is because the image setting is dispatched to an I/O queue first. When the image loading/processing finished, it is dispatched back to the main queue asynchronously.

默认情况下，为了提高性能，所有操作，包括磁盘缓存加载，都是异步的。有时，您可能希望重新加载图像（例如在表视图中）。如果缓存的图像仅存在于磁盘缓存中，您会发现会出现闪烁。这是因为图像设置首先被分派到一个 I/O 队列中。当图像加载/处理完成后，它会异步地分派回主队列。

To change this behavior and get rid of the flickering, you can pass `.loadDiskFileSynchronously` when reloading:

要更改此行为并消除闪烁，您可以在重新加载时传递 `.loadDiskFileSynchronously` 参数：

```
let options: [KingfisherOptionsInfo]? = isReloading ? [.loadDiskFileSynchronously] : nil
imageView.kf.set(with: image, options: options)
```

### Waiting for cache finishing - 等待缓存完成

Storing images to disk cache is an asynchronous operation. However, it is not required to be done before we can set the image view and call the completion handler in view extension methods. In other words, the disk cache may not exist yet in the completion handler below:

存储图像到磁盘缓存是一个异步操作。然而，在设置图像视图并调用视图扩展方法的完成处理程序之前，不需要等待磁盘缓存完成。换句话说，完成处理程序下面的磁盘缓存可能尚不存在：

```
imageView.kf.setImage(with: url) { _ in
    ImageCache.default.retrieveImageInDiskCache(forKey: url.cacheKey) { result in
        switch result {
        case .success(let image):
            // `image` might be `nil` here.
            // 这里 `image` 可能是 `nil`。
        case .failure: break
        }
    }
}
```

This is not a problem for most use cases. However, if your logic depends on the existing of disk cache, pass `.waitForCache` as an option. Kingfisher will then wait until the disk cache finishes before calling the handler:

对于大多数用例，这不是一个问题。但是，如果您的逻辑依赖于磁盘缓存的存在，请传入 `.waitForCache` 选项。这样，Kingfisher  将在调用句柄之前等待磁盘缓存完成：

```
imageView.kf.setImage(with: url, options: [.waitForCache]) { _ in
    ImageCache.default.retrieveImageInDiskCache(forKey: url.cacheKey) { result in
        switch result {
        case .success(let image):
            // `image` exists.
            // `image` 存在。
        case .failure: break
        }
    }
}
```

This is only for disk image cache, which involves to async I/O. For the memory cache, everything goes synchronously, so the image should be always in the memory cache.

这仅适用于涉及异步 I/O 的磁盘图像缓存。对于内存缓存，一切都是同步进行的，因此图像应始终位于内存缓存中。

### Low Data Mode - 低数据模式

From iOS 13, Apple allows user to choose to turn on [Low Data Mode] to save cellular and Wi-Fi usage. To respect this setting, you can provide an alternative (usually low-resolution) version of the image and Kingfisher will use that when Low Data Mode is enabled:

自 iOS 13 起，Apple 允许用户选择启用“低数据模式”以节省蜂窝数据和 Wi-Fi 使用量。为了遵守此设置，您可以提供一个替代版本（通常是低分辨率）的图像，当低数据模式启用时，Kingfisher将使用该版本：

```
imageView.kf.setImage(
    with: highResolutionURL, 
    options: [.lowDataSource(.network(lowResolutionURL)]
)
```

If there is no network restriction applied by user, `highResolutionURL` will be used. Otherwise, when the device is under Low Data Mode and the `highResolutionURL` version is not hit in the cache, `lowResolutionURL` will be used.

如果用户没有应用网络限制，则将使用 `highResolutionURL`。否则，当设备处于低数据模式且 `highResolutionURL` 版本不在缓存中时，将使用 `lowResolutionURL`。

Since `.lowDataSource` accept any `Source` parameter instead of only a URL, you can also pass in a local image provider to prevent any downloading task:

由于 `.lowDataSource` 接受任何 `Source` 参数而不仅仅是URL，您还可以传递本地图像提供器以防止任何下载任务：

```
imageView.kf.setImage(
    with: highResolutionURL, 
    options: [
        .provider(LocalFileImageDataProvider(fileURL: localFileURL))
    ]
)
```

If `.lowDataSource` option is not provided, the `highResolutionURL `will be always used, regardless of the Low Data Mode setting on the device.

如果未提供 `.lowDataSource` 选项，将始终使用 `highResolutionURL`，而不考虑设备上的低数据模式设置。

### For UIButton & NSButton - 对于 UIButton 和 NSButton

```
let uiButton: UIButton = //...
uiButton.kf.setImage(with: url, for: .normal)
uiButton.kf.setBackgroundImage(with: url, for: .normal)

let nsButton: NSButton = //...
nsButton.kf.setImage(with: url)
nsButton.kf.setAlternateImage(with: url)
```

## Animated Images - 动态图像

Kingfisher supports to display GIF images.

Kingfisher 支持显示 GIF 图像。

### Loading a GIF - 加载GIF图像

```
let imageView: UIImageView = ...
imageView.kf.setImage(with: URL(string: "your_animated_gif_image_url")!)
```

If you encountered to memory issues when dealing with large GIF, try to use `AnimatedImageView` instead of regular image view to display GIF. It will only decode several frames of your GIF image to get a smaller memory footprint (but high CPU load).

如果在处理大型 GIF 图像时遇到内存问题，请尝试使用 `AnimatedImageView` 而不是常规图像视图来显示 GIF。它只会解码 GIF 图像的几个帧，以获得较小的内存占用（但CPU负载较高）。

```
let imageView = AnimatedImageView()
imageView.kf.setImage(with: URL(string: "your_large_animated_gif_image_url")!)
```

### Only load the first frame from GIF - 仅加载 GIF 的第一帧

```
imageView.kf.setImage(
    with: URL(string: "your_animated_gif_image_url")!, 
    options: [.onlyLoadFirstFrame])
```

It will be useful when you just want to display a static preview of the first frame from a GIF image.

这在您只想显示 GIF 图像的第一帧作为静态预览时非常有用。

## Performance Tips - 性能建议

### Cancelling unnecessary downloading tasks - 取消不必要的下载任务

Once a downloading task initialized, even when you set another URL to the image view, that task will continue until finishes.

一旦初始化了下载任务，即使您将另一个 URL 设置给图像视图，该任务将继续直到完成。

```
imageView.kf.setImage(with: url1) { result in 
    // `result` is `.failure(.imageSettingError(.notCurrentSourceTask))`
    // But the download (and cache) is done.
    // `result` 是 `.failure(.imageSettingError(.notCurrentSourceTask))`
    // 但是下载（和缓存）已完成。
}

// Set again immediately.
// 立即再次设置。
imageView.kf.setImage(with: url2) { result in 
    // `result` is `.success`
    // `result` 是 `.success`
}
```

Although setting for `url1` results in a `.failure` since the setting task was overridden by `url2`, the download task itself is finished. The downloaded image data is also processed and cached.

尽管由于加载任务被 `url2` 覆盖，`url1` 的加载结果是 `.failure`，但是下载任务本身已经完成。下载的图像数据也已经被处理和缓存。

The downloading and caching operation for the image at `url1` is not free, it costs network, CPU time, memory and also, battery.

对于 `url1` 的图像的下载和缓存操作并不是没有开销的，它需要消耗网络、CPU时间、内存和电池资源。

In most cases, it worths to do that. Since there is a chance that the image is shown to the user again. But if you are sure that you do not need the image from `url1`, you can cancel the downloading before starting another one:

在大多数情况下，这是值得的。因为还有可能再次向用户显示图像。但是如果您确定不需要来自 `url1` 的图像，您可以在开始另一个下载之前取消下载：

```
imageView.kf.setImage(with: ImageLoader.sampleImageURLs[8]) { result in
    // `result` is `.failure(.requestError(.taskCancelled))`
    // Now the download task is cancelled.
    // `result` 是 `.failure(.requestError(.taskCancelled))`
    // 现在下载任务已取消。
}

imageView.kf.cancelDownloadTask()
imageView.kf.setImage(with: ImageLoader.sampleImageURLs[9]) { result in
    // `result` is `.success`
    // `result` 是 `.success`
}
```

This technology sometimes is useful in a table view or collection view. When users scrolling the list fast, maybe quite a lot of image downloading tasks would be created. You can cancel unnecessary tasks in the `didEndDisplaying` delegate method:

这项技术有时在表视图或集合视图中很有用。当用户快速滚动列表时，可能会创建很多图像下载任务。您可以在 `didEndDisplaying` 委托方法中取消不必要的任务：

```
func collectionView(
    _ collectionView: UICollectionView,
    didEndDisplaying cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath)
{
    // This will cancel the unfinished downloading task when the cell disappearing.
    // 当单元格消失时，这将取消未完成的下载任务。
    cell.imageView.kf.cancelDownloadTask()
}
```

### Using processor with ImageCache - 使用带有 ImageCache 的处理器

Kingfisher is smart enough to cache the processed images and then get it back if you specify the correct `ImageProcessor` in the option. Each `ImageProcessor` contains an `identifier`. It is used when caching the processed images.

Kingfisher 聪明地缓存处理后的图像，并且如果您在选项中指定了正确的 `ImageProcessor`，它将从缓存中获取图像。每个 `ImageProcessor` 都包含一个标识符，它用于在缓存处理后的图像时使用。

Without the `identifier`, Kingfisher will not be able to tell which is the correct image in cache. Think about the case you have to store two versions of an image from the same url, one should be round cornered and another should be blurred. You need two different cache keys. In all Kingfisher's built-in image processors, the identifier will be determined by the kind of processor, combined with its parameters for each instance. For example, a round corner processor with 20 as its corner radius might have an `identifier` as `round-corner-20`, while a 40 radius one's could be `round-corner-40`. (Just for demonstrating, they are not that simple value in real)

如果没有标识符，Kingfisher 将无法确定缓存中的正确图像。想象一下这样一个情况：您必须从同一个URL存储两个版本的图像，一个应该是圆角的，另一个应该是模糊的。您需要两个不同的缓存键。在所有 Kingfisher 内置的图像处理器中，标识符将根据处理器的类型和其每个实例的参数来确定。例如，带有以 20 为圆角半径的圆角处理器的标识符可能是 `round-corner-20`，而以 40 为半径的圆角处理器的标识符可能是 `round-corner-40`。（仅用于演示，实际上它们不是这么简单的值）

So, when you create your own processor, you need to make sure that you provide a different `identifier` for any different processor instance, with its parameter considered. This helps the processors work well with the cache. Furthermore, it prevents unnecessary downloading and processing.

因此，当您创建自己的处理器时，您需要确保为任何不同的处理器实例提供不同的考虑到其参数的标识符。这有助于处理器与缓存良好配合。此外，它还可以避免不必要的下载和处理。

### Cache original image when using a processor - 在使用处理器时缓存原始图像

If you are trying to do one of these:

1. Process the same image with different processors to get different versions of the image.
2. Process an image with a processor other than the default one, and later need to display the original image.

如果您想执行以下操作之一：

1. 使用不同的处理器处理相同图像以获取图像的不同版本。
2. 使用非默认处理器处理图像，然后稍后需要显示原始图像。

It worths passing `.cacheOriginalImage` as an option. This will store the original downloaded image to cache as well:

可以通过传入 `.cacheOriginalImage` 选项来实现。这将同时将原始下载的图像存储到缓存中：

```
let p1 = MyProcessor()
imageView.kf.setImage(with: url, options: [.processor(p1), .cacheOriginalImage])
```

Both the processed image by `p1` and the original downloaded image will be cached. Later, when you process with another processor:

`p1` 处理后的图像和原始下载的图像都将被缓存。稍后，当您使用另一个处理器进行处理时：

```
let p2 = AnotherProcessor()
imageView.kf.setImage(with: url, options: [.processor(p2)])
```

The processed image for `p2` is not in cache yet, but Kingfisher now has a chance to check whether the original image for `url` being in cache or not. Instead of downloading the image again, Kingfisher will reuse the original image and then apply `p2` on it directly.

`p2` 的处理后的图像尚未在缓存中，但是 Kingfisher 现在有机会检查缓存中是否存在 `url` 的原始图像。而不是重新下载图像， Kingfisher 将直接重用原始图像，并在其上直接应用 `p2`。

### Using DownsamplingImageProcessor for high resolution images - 使用DownsamplingImageProcessor处理高分辨率图像

Think about the case we want to show some large images in a table view or a collection view. In the ideal world, we expect to get smaller thumbnails for them, to reduce downloading time and memory use. But in the real world, maybe your server doesn't prepare such a thumbnail version for you. The newly added `DownsamplingImageProcessor` rescues. It downsamples the high-resolution images to a certain size before loading to memory:

考虑一种情况，我们想在表视图或集合视图中显示一些大图像。在理想情况下，我们希望获取它们的较小缩略图，以减少下载时间和内存使用。但在现实世界中，也许您的服务器没有为您准备这样的缩略图版本。新增的 `DownsamplingImageProcessor` 就派上用场了。它在加载到内存之前将高分辨率图像进行降采样：

```
imageView.kf.setImage(
    with: resource,
    placeholder: placeholderImage,
    options: [
        .processor(DownsamplingImageProcessor(size: imageView.size)),
        .scaleFactor(UIScreen.main.scale),
        .cacheOriginalImage
    ])
```

Typically, `DownsamplingImageProcessor` is used with `.scaleFactor` and `.cacheOriginalImage`. It provides a reasonable image pixel scale for your UI, and prevent future downloading by caching the original high-resolution image.

通常，`DownsamplingImageProcessor` 与 `.scaleFactor` 和 `.cacheOriginalImage` 一起使用。它为您的 UI 提供了合理的图像像素比例，并通过缓存原始高分辨率图像来避免将来的下载。