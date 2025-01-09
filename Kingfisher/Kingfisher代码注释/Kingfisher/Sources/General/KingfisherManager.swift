//
//  KingfisherManager.swift
//  Kingfisher
//
//  Created by Wei Wang on 15/4/6.
//
//  Copyright (c) 2019 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import Foundation
#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// The downloading progress block type.
/// The parameter value is the `receivedSize` of current response.
/// The second parameter is the total expected data length from response's "Content-Length" header.
/// If the expected length is not available, this block will not be called.
/// 下载进度 block 类型。
/// 参数值为当前响应的 receivedSize。
/// 第二个参数是来自 “Content-Length” 响应头的总预期数据长度。
/// 如果预期长度不可用，则不会调用此块。
public typealias DownloadProgressBlock = ((_ receivedSize: Int64, _ totalSize: Int64) -> Void)

/// Represents the result of a Kingfisher retrieving image task.
/// 代表 Kingfisher 检索图像任务的结果。
public struct RetrieveImageResult {
    /// Gets the image object of this result.
    /// 获取此结果的图像对象。
    public let image: KFCrossPlatformImage

    /// Gets the cache source of the image. It indicates from which layer of cache this image is retrieved.
    /// If the image is just downloaded from network, `.none` will be returned.
    /// 获取图像的缓存来源。它指示从缓存的哪一层检索到了这个图像。
    /// 如果图像刚从网络下载，将返回 .none。
    public let cacheType: CacheType

    /// The `Source` which this result is related to. This indicated where the `image` of `self` is referring.
    /// 与此结果相关的Source。这表明了self的image引用的位置。
    public let source: Source

    /// The original `Source` from which the retrieve task begins. It can be different from the `source` property.
    /// When an alternative source loading happened, the `source` will be the replacing loading target, while the
    /// `originalSource` will be kept as the initial `source` which issued the image loading process.
    /// 检索任务开始的原始Source。它可能与source属性不同。
    /// 当发生替代源加载时，source将成为替换加载目标，而originalSource将保留为发起图像加载过程的初始source。
    public let originalSource: Source
    
    /// Gets the data behind the result.
    /// 获取结果背后的数据。
    ///
    /// If this result is from a network downloading (when `cacheType == .none`), calling this returns the downloaded
    /// data. If the reuslt is from cache, it serializes the image with the given cache serializer in the loading option
    /// and returns the result.
    /// 如果此结果来自网络下载（当 cacheType == .none 时），调用此方法将返回已下载的数据。如果结果来自缓存，它将使用加载选项中提供的缓存序列化器对图像进行序列化，并返回结果。
    ///
    /// - Note:
    /// This can be a time-consuming action, so if you need to use the data for multiple times, it is suggested to hold
    /// it and prevent keeping calling this too frequently.
    /// - 注意：
    /// 这可能是一个耗时的操作，因此如果您需要多次使用数据，建议保存数据并避免过于频繁地调用此方法。
    public let data: () -> Data?
}

/// A struct that stores some related information of an `KingfisherError`. It provides some context information for
/// a pure error so you can identify the error easier.
/// 一个结构体，用于存储与KingfisherError相关的一些信息。它为纯错误提供一些上下文信息，以便您更容易地识别错误。
public struct PropagationError {

    /// The `Source` to which current `error` is bound.
    /// 当前error绑定的Source。
    public let source: Source

    /// The actual error happens in framework.
    /// 发生在框架中的实际错误。
    public let error: KingfisherError
}


/// The downloading task updated block type. The parameter `newTask` is the updated new task of image setting process.
/// It is a `nil` if the image loading does not require an image downloading process. If an image downloading is issued,
/// this value will contain the actual `DownloadTask` for you to keep and cancel it later if you need.
/// 下载任务更新的 block 类型。参数newTask是图像设置过程更新后的新任务。
/// 如果图像加载不需要图像下载过程，则为nil。如果发出了图像下载请求，此值将包含实际的DownloadTask，供您稍后保留并在需要时取消。
public typealias DownloadTaskUpdatedBlock = ((_ newTask: DownloadTask?) -> Void)

/// Main manager class of Kingfisher. It connects Kingfisher downloader and cache,
/// to provide a set of convenience methods to use Kingfisher for tasks.
/// You can use this class to retrieve an image via a specified URL from web or cache.
/// Kingfisher的主管理类。它连接了Kingfisher的下载器和缓存，提供了一组便捷的方法来使用Kingfisher执行任务。您可以使用这个类通过指定的URL从网络或缓存中检索图像。
public class KingfisherManager {

    /// Represents a shared manager used across Kingfisher.
    /// Use this instance for getting or storing images with Kingfisher.
    /// 表示在整个Kingfisher中共享的管理器。使用这个实例来使用Kingfisher获取或存储图像。
    public static let shared = KingfisherManager()

    // Mark: Public Properties
    // 公共属性

    /// The `ImageCache` used by this manager. It is `ImageCache.default` by default.
    /// If a cache is specified in `KingfisherManager.defaultOptions`, the value in `defaultOptions` will be
    /// used instead.
    /// 该管理器使用的ImageCache。默认情况下为ImageCache.default。
    /// 如果在KingfisherManager.defaultOptions中指定了缓存，则将使用defaultOptions中的值。
    public var cache: ImageCache
    
    /// The `ImageDownloader` used by this manager. It is `ImageDownloader.default` by default.
    /// If a downloader is specified in `KingfisherManager.defaultOptions`, the value in `defaultOptions` will be
    /// used instead.
    /// 该管理器使用的ImageDownloader。默认情况下为ImageDownloader.default。
    /// 如果在KingfisherManager.defaultOptions中指定了下载器，则将使用defaultOptions中的值。
    public var downloader: ImageDownloader
    
    /// Default options used by the manager. This option will be used in
    /// Kingfisher manager related methods, as well as all view extension methods.
    /// You can also passing other options for each image task by sending an `options` parameter
    /// to Kingfisher's APIs. The per image options will overwrite the default ones,
    /// if the option exists in both.
    /// 管理器使用的默认选项。这些选项将在Kingfisher管理器相关方法以及所有视图扩展方法中使用。
    /// 您还可以通过向Kingfisher的API发送一个options参数来为每个图像任务传递其他选项。如果在两者中都存在该选项，则每个图像的选项将覆盖默认选项。
    public var defaultOptions = KingfisherOptionsInfo.empty
    
    // Use `defaultOptions` to overwrite the `downloader` and `cache`.
    // 使用defaultOptions来覆盖downloader和cache。
    private var currentDefaultOptions: KingfisherOptionsInfo {
        return [.downloader(downloader), .targetCache(cache)] + defaultOptions
    }

    private let processingQueue: CallbackQueue
    
    private convenience init() {
        self.init(downloader: .default, cache: .default)
    }

    /// Creates an image setting manager with specified downloader and cache.
    /// 使用指定的下载器和缓存创建图像设置管理器。
    ///
    /// - Parameters:
    ///   - downloader: The image downloader used to download images.
    ///   - cache: The image cache which stores memory and disk images.
    /// - Parameters:
    /// - downloader: 用于下载图像的图像下载器。
    /// - cache: 存储内存和磁盘图像的图像缓存。
    public init(downloader: ImageDownloader, cache: ImageCache) {
        self.downloader = downloader
        self.cache = cache

        let processQueueName = "com.onevcat.Kingfisher.KingfisherManager.processQueue.\(UUID().uuidString)"
        processingQueue = .dispatch(DispatchQueue(label: processQueueName))
    }

    // MARK: - Getting Images
    // 获取图像

    /// Gets an image from a given resource.
    /// 从给定资源获取图像。
    /// - Parameters:
    ///   - resource: The `Resource` object defines data information like key or URL.
    ///   - options: Options to use when creating the image.
    ///   - progressBlock: Called when the image downloading progress gets updated. If the response does not contain an
    ///                    `expectedContentLength`, this block will not be called. `progressBlock` is always called in
    ///                    main queue.
    ///   - downloadTaskUpdated: Called when a new image downloading task is created for current image retrieving. This
    ///                          usually happens when an alternative source is used to replace the original (failed)
    ///                          task. You can update your reference of `DownloadTask` if you want to manually `cancel`
    ///                          the new task.
    ///   - completionHandler: Called when the image retrieved and set finished. This completion handler will be invoked
    ///                        from the `options.callbackQueue`. If not specified, the main queue will be used.
    /// - Returns: A task represents the image downloading. If there is a download task starts for `.network` resource,
    ///            the started `DownloadTask` is returned. Otherwise, `nil` is returned.
    /// - 参数:
    /// - resource: Resource 对象定义了数据信息，如键或 URL。
    /// - options: 创建图像时使用的选项。
    /// - progressBlock: 当图像下载进度更新时调用。如果响应不包含expectedContentLength，则不会调用此块。progressBlock 总是在主队列中调用。
    /// - downloadTaskUpdated: 当为当前图像检索创建新的图像下载任务时调用。当使用替代源替换原始（失败的）任务时通常会发生这种情况。如果要手动cancel新任务，可以更新 DownloadTask 的引用。
    /// - completionHandler: 当图像检索和设置完成时调用。此完成处理程序将从options.callbackQueue调用。如果未指定，将使用主队列。
    /// - Returns: 表示图像下载的任务。如果为.network资源启动了下载任务，则返回启动的DownloadTask。否则，返回nil。
    ///
    /// - Note:
    ///    This method will first check whether the requested `resource` is already in cache or not. If cached,
    ///    it returns `nil` and invoke the `completionHandler` after the cached image retrieved. Otherwise, it
    ///    will download the `resource`, store it in cache, then call `completionHandler`.
    /// - 注意：
    /// 此方法首先检查请求的resource是否已经在缓存中。如果已缓存，它将返回nil，并在检索到缓存图像后调用completionHandler。否则，它将下载resource，将其存储在缓存中，然后调用completionHandler。
    @discardableResult
    public func retrieveImage(
        with resource: Resource,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        downloadTaskUpdated: DownloadTaskUpdatedBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask?
    {
        return retrieveImage(
            with: resource.convertToSource(),
            options: options,
            progressBlock: progressBlock,
            downloadTaskUpdated: downloadTaskUpdated,
            completionHandler: completionHandler
        )
    }

    /// Gets an image from a given resource.
    ///
    /// - Parameters:
    ///   - source: The `Source` object defines data information from network or a data provider.
    ///   - options: Options to use when creating the image.
    ///   - progressBlock: Called when the image downloading progress gets updated. If the response does not contain an
    ///                    `expectedContentLength`, this block will not be called. `progressBlock` is always called in
    ///                    main queue.
    ///   - downloadTaskUpdated: Called when a new image downloading task is created for current image retrieving. This
    ///                          usually happens when an alternative source is used to replace the original (failed)
    ///                          task. You can update your reference of `DownloadTask` if you want to manually `cancel`
    ///                          the new task.
    ///   - completionHandler: Called when the image retrieved and set finished. This completion handler will be invoked
    ///                        from the `options.callbackQueue`. If not specified, the main queue will be used.
    /// - Returns: A task represents the image downloading. If there is a download task starts for `.network` resource,
    ///            the started `DownloadTask` is returned. Otherwise, `nil` is returned.
    ///
    /// - Note:
    ///    This method will first check whether the requested `source` is already in cache or not. If cached,
    ///    it returns `nil` and invoke the `completionHandler` after the cached image retrieved. Otherwise, it
    ///    will try to load the `source`, store it in cache, then call `completionHandler`.
    ///
    @discardableResult
    public func retrieveImage(
        with source: Source,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        downloadTaskUpdated: DownloadTaskUpdatedBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask?
    {
        let options = currentDefaultOptions + (options ?? .empty)
        let info = KingfisherParsedOptionsInfo(options)
        return retrieveImage(
            with: source,
            options: info,
            progressBlock: progressBlock,
            downloadTaskUpdated: downloadTaskUpdated,
            completionHandler: completionHandler)
    }

    func retrieveImage(
        with source: Source,
        options: KingfisherParsedOptionsInfo,
        progressBlock: DownloadProgressBlock? = nil,
        downloadTaskUpdated: DownloadTaskUpdatedBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask?
    {
        var info = options
        if let block = progressBlock {
            info.onDataReceived = (info.onDataReceived ?? []) + [ImageLoadingProgressSideEffect(block)]
        }
        return retrieveImage(
            with: source,
            options: info,
            downloadTaskUpdated: downloadTaskUpdated,
            progressiveImageSetter: nil,
            completionHandler: completionHandler)
    }

    func retrieveImage(
        with source: Source,
        options: KingfisherParsedOptionsInfo,
        downloadTaskUpdated: DownloadTaskUpdatedBlock? = nil,
        progressiveImageSetter: ((KFCrossPlatformImage?) -> Void)? = nil,
        referenceTaskIdentifierChecker: (() -> Bool)? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask?
    {
        var options = options
        if let provider = ImageProgressiveProvider(options, refresh: { image in
            guard let setter = progressiveImageSetter else {
                return
            }
            guard let strategy = options.progressiveJPEG?.onImageUpdated(image) else {
                setter(image)
                return
            }
            switch strategy {
            case .default: setter(image)
            case .keepCurrent: break
            case .replace(let newImage): setter(newImage)
            }
        }) {
            options.onDataReceived = (options.onDataReceived ?? []) + [provider]
        }
        if let checker = referenceTaskIdentifierChecker {
            options.onDataReceived?.forEach {
                $0.onShouldApply = checker
            }
        }
        
        let retrievingContext = RetrievingContext(options: options, originalSource: source)
        var retryContext: RetryContext?

        func startNewRetrieveTask(
            with source: Source,
            downloadTaskUpdated: DownloadTaskUpdatedBlock?
        ) {
            let newTask = self.retrieveImage(with: source, context: retrievingContext) { result in
                handler(currentSource: source, result: result)
            }
            downloadTaskUpdated?(newTask)
        }

        func failCurrentSource(_ source: Source, with error: KingfisherError) {
            // Skip alternative sources if the user cancelled it.
            guard !error.isTaskCancelled else {
                completionHandler?(.failure(error))
                return
            }
            // When low data mode constrained error, retry with the low data mode source instead of use alternative on fly.
            guard !error.isLowDataModeConstrained else {
                if let source = retrievingContext.options.lowDataModeSource {
                    retrievingContext.options.lowDataModeSource = nil
                    startNewRetrieveTask(with: source, downloadTaskUpdated: downloadTaskUpdated)
                } else {
                    // This should not happen.
                    completionHandler?(.failure(error))
                }
                return
            }
            if let nextSource = retrievingContext.popAlternativeSource() {
                retrievingContext.appendError(error, to: source)
                startNewRetrieveTask(with: nextSource, downloadTaskUpdated: downloadTaskUpdated)
            } else {
                // No other alternative source. Finish with error.
                if retrievingContext.propagationErrors.isEmpty {
                    completionHandler?(.failure(error))
                } else {
                    retrievingContext.appendError(error, to: source)
                    let finalError = KingfisherError.imageSettingError(
                        reason: .alternativeSourcesExhausted(retrievingContext.propagationErrors)
                    )
                    completionHandler?(.failure(finalError))
                }
            }
        }

        func handler(currentSource: Source, result: (Result<RetrieveImageResult, KingfisherError>)) -> Void {
            switch result {
            case .success:
                completionHandler?(result)
            case .failure(let error):
                if let retryStrategy = options.retryStrategy {
                    let context = retryContext?.increaseRetryCount() ?? RetryContext(source: source, error: error)
                    retryContext = context

                    retryStrategy.retry(context: context) { decision in
                        switch decision {
                        case .retry(let userInfo):
                            retryContext?.userInfo = userInfo
                            startNewRetrieveTask(with: source, downloadTaskUpdated: downloadTaskUpdated)
                        case .stop:
                            failCurrentSource(currentSource, with: error)
                        }
                    }
                } else {
                    failCurrentSource(currentSource, with: error)
                }
            }
        }

        return retrieveImage(
            with: source,
            context: retrievingContext)
        {
            result in
            handler(currentSource: source, result: result)
        }

    }
    
    private func retrieveImage(
        with source: Source,
        context: RetrievingContext,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask?
    {
        let options = context.options
        if options.forceRefresh {
            return loadAndCacheImage(
                source: source,
                context: context,
                completionHandler: completionHandler)?.value
            
        } else {
            let loadedFromCache = retrieveImageFromCache(
                source: source,
                context: context,
                completionHandler: completionHandler)
            
            if loadedFromCache {
                return nil
            }
            
            if options.onlyFromCache {
                let error = KingfisherError.cacheError(reason: .imageNotExisting(key: source.cacheKey))
                completionHandler?(.failure(error))
                return nil
            }
            
            return loadAndCacheImage(
                source: source,
                context: context,
                completionHandler: completionHandler)?.value
        }
    }

    func provideImage(
        provider: ImageDataProvider,
        options: KingfisherParsedOptionsInfo,
        completionHandler: ((Result<ImageLoadingResult, KingfisherError>) -> Void)?)
    {
        guard let  completionHandler = completionHandler else { return }
        provider.data { result in
            switch result {
            case .success(let data):
                (options.processingQueue ?? self.processingQueue).execute {
                    let processor = options.processor
                    let processingItem = ImageProcessItem.data(data)
                    guard let image = processor.process(item: processingItem, options: options) else {
                        options.callbackQueue.execute {
                            let error = KingfisherError.processorError(
                                reason: .processingFailed(processor: processor, item: processingItem))
                            completionHandler(.failure(error))
                        }
                        return
                    }

                    options.callbackQueue.execute {
                        let result = ImageLoadingResult(image: image, url: nil, originalData: data)
                        completionHandler(.success(result))
                    }
                }
            case .failure(let error):
                options.callbackQueue.execute {
                    let error = KingfisherError.imageSettingError(
                        reason: .dataProviderError(provider: provider, error: error))
                    completionHandler(.failure(error))
                }

            }
        }
    }

    private func cacheImage(
        source: Source,
        options: KingfisherParsedOptionsInfo,
        context: RetrievingContext,
        result: Result<ImageLoadingResult, KingfisherError>,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?
    )
    {
        switch result {
        case .success(let value):
            let needToCacheOriginalImage = options.cacheOriginalImage &&
                                           options.processor != DefaultImageProcessor.default
            let coordinator = CacheCallbackCoordinator(
                shouldWaitForCache: options.waitForCache, shouldCacheOriginal: needToCacheOriginalImage)
            let result = RetrieveImageResult(
                image: options.imageModifier?.modify(value.image) ?? value.image,
                cacheType: .none,
                source: source,
                originalSource: context.originalSource,
                data: {  value.originalData }
            )
            // Add image to cache.
            let targetCache = options.targetCache ?? self.cache
            targetCache.store(
                value.image,
                original: value.originalData,
                forKey: source.cacheKey,
                options: options,
                toDisk: !options.cacheMemoryOnly)
            {
                _ in
                coordinator.apply(.cachingImage) {
                    completionHandler?(.success(result))
                }
            }

            // Add original image to cache if necessary.

            if needToCacheOriginalImage {
                let originalCache = options.originalCache ?? targetCache
                originalCache.storeToDisk(
                    value.originalData,
                    forKey: source.cacheKey,
                    processorIdentifier: DefaultImageProcessor.default.identifier,
                    expiration: options.diskCacheExpiration)
                {
                    _ in
                    coordinator.apply(.cachingOriginalImage) {
                        completionHandler?(.success(result))
                    }
                }
            }

            coordinator.apply(.cacheInitiated) {
                completionHandler?(.success(result))
            }

        case .failure(let error):
            completionHandler?(.failure(error))
        }
    }

    @discardableResult
    func loadAndCacheImage(
        source: Source,
        context: RetrievingContext,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> DownloadTask.WrappedTask?
    {
        let options = context.options
        func _cacheImage(_ result: Result<ImageLoadingResult, KingfisherError>) {
            cacheImage(
                source: source,
                options: options,
                context: context,
                result: result,
                completionHandler: completionHandler
            )
        }

        switch source {
        case .network(let resource):
            let downloader = options.downloader ?? self.downloader
            let task = downloader.downloadImage(
                with: resource.downloadURL, options: options, completionHandler: _cacheImage
            )


            // The code below is neat, but it fails the Swift 5.2 compiler with a runtime crash when 
            // `BUILD_LIBRARY_FOR_DISTRIBUTION` is turned on. I believe it is a bug in the compiler. 
            // Let's fallback to a traditional style before it can be fixed in Swift.
            //
            // https://github.com/onevcat/Kingfisher/issues/1436
            //
            // return task.map(DownloadTask.WrappedTask.download)

            if let task = task {
                return .download(task)
            } else {
                return nil
            }

        case .provider(let provider):
            provideImage(provider: provider, options: options, completionHandler: _cacheImage)
            return .dataProviding
        }
    }
    
    /// Retrieves image from memory or disk cache.
    ///
    /// - Parameters:
    ///   - source: The target source from which to get image.
    ///   - key: The key to use when caching the image.
    ///   - url: Image request URL. This is not used when retrieving image from cache. It is just used for
    ///          `RetrieveImageResult` callback compatibility.
    ///   - options: Options on how to get the image from image cache.
    ///   - completionHandler: Called when the image retrieving finishes, either with succeeded
    ///                        `RetrieveImageResult` or an error.
    /// - Returns: `true` if the requested image or the original image before being processed is existing in cache.
    ///            Otherwise, this method returns `false`.
    ///
    /// - Note:
    ///    The image retrieving could happen in either memory cache or disk cache. The `.processor` option in
    ///    `options` will be considered when searching in the cache. If no processed image is found, Kingfisher
    ///    will try to check whether an original version of that image is existing or not. If there is already an
    ///    original, Kingfisher retrieves it from cache and processes it. Then, the processed image will be store
    ///    back to cache for later use.
    func retrieveImageFromCache(
        source: Source,
        context: RetrievingContext,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) -> Bool
    {
        let options = context.options
        // 1. Check whether the image was already in target cache. If so, just get it.
        let targetCache = options.targetCache ?? cache
        let key = source.cacheKey
        let targetImageCached = targetCache.imageCachedType(
            forKey: key, processorIdentifier: options.processor.identifier)
        
        let validCache = targetImageCached.cached &&
            (options.fromMemoryCacheOrRefresh == false || targetImageCached == .memory)
        if validCache {
            targetCache.retrieveImage(forKey: key, options: options) { result in
                guard let completionHandler = completionHandler else { return }
                
                // TODO: Optimize it when we can use async across all the project.
                func checkResultImageAndCallback(_ inputImage: KFCrossPlatformImage) {
                    var image = inputImage
                    if image.kf.imageFrameCount != nil && image.kf.imageFrameCount != 1, let data = image.kf.animatedImageData {
                        // Always recreate animated image representation since it is possible to be loaded in different options.
                        // https://github.com/onevcat/Kingfisher/issues/1923
                        image = options.processor.process(item: .data(data), options: options) ?? .init()
                    }
                    if let modifier = options.imageModifier {
                        image = modifier.modify(image)
                    }
                    let value = result.map {
                        RetrieveImageResult(
                            image: image,
                            cacheType: $0.cacheType,
                            source: source,
                            originalSource: context.originalSource,
                            data: { options.cacheSerializer.data(with: image, original: nil) }
                        )
                    }
                    completionHandler(value)
                }
                
                result.match { cacheResult in
                    options.callbackQueue.execute {
                        guard let image = cacheResult.image else {
                            completionHandler(.failure(KingfisherError.cacheError(reason: .imageNotExisting(key: key))))
                            return
                        }
                        
                        if options.cacheSerializer.originalDataUsed {
                            let processor = options.processor
                            (options.processingQueue ?? self.processingQueue).execute {
                                let item = ImageProcessItem.image(image)
                                guard let processedImage = processor.process(item: item, options: options) else {
                                    let error = KingfisherError.processorError(
                                        reason: .processingFailed(processor: processor, item: item))
                                    options.callbackQueue.execute { completionHandler(.failure(error)) }
                                    return
                                }
                                options.callbackQueue.execute {
                                    checkResultImageAndCallback(processedImage)
                                }
                            }
                        } else {
                            checkResultImageAndCallback(image)
                        }
                    }
                } onFailure: { error in
                    options.callbackQueue.execute {
                        completionHandler(.failure(KingfisherError.cacheError(reason: .imageNotExisting(key: key))))
                    }
                }
            }
            return true
        }

        // 2. Check whether the original image exists. If so, get it, process it, save to storage and return.
        let originalCache = options.originalCache ?? targetCache
        // No need to store the same file in the same cache again.
        if originalCache === targetCache && options.processor == DefaultImageProcessor.default {
            return false
        }

        // Check whether the unprocessed image existing or not.
        let originalImageCacheType = originalCache.imageCachedType(
            forKey: key, processorIdentifier: DefaultImageProcessor.default.identifier)
        let canAcceptDiskCache = !options.fromMemoryCacheOrRefresh
        
        let canUseOriginalImageCache =
            (canAcceptDiskCache && originalImageCacheType.cached) ||
            (!canAcceptDiskCache && originalImageCacheType == .memory)
        
        if canUseOriginalImageCache {
            // Now we are ready to get found the original image from cache. We need the unprocessed image, so remove
            // any processor from options first.
            var optionsWithoutProcessor = options
            optionsWithoutProcessor.processor = DefaultImageProcessor.default
            originalCache.retrieveImage(forKey: key, options: optionsWithoutProcessor) { result in

                result.match(
                    onSuccess: { cacheResult in
                        guard let image = cacheResult.image else {
                            assertionFailure("The image (under key: \(key) should be existing in the original cache.")
                            return
                        }

                        let processor = options.processor
                        (options.processingQueue ?? self.processingQueue).execute {
                            let item = ImageProcessItem.image(image)
                            guard let processedImage = processor.process(item: item, options: options) else {
                                let error = KingfisherError.processorError(
                                    reason: .processingFailed(processor: processor, item: item))
                                options.callbackQueue.execute { completionHandler?(.failure(error)) }
                                return
                            }

                            var cacheOptions = options
                            cacheOptions.callbackQueue = .untouch

                            let coordinator = CacheCallbackCoordinator(
                                shouldWaitForCache: options.waitForCache, shouldCacheOriginal: false)

                            let image = options.imageModifier?.modify(processedImage) ?? processedImage
                            let result = RetrieveImageResult(
                                image: image,
                                cacheType: .none,
                                source: source,
                                originalSource: context.originalSource,
                                data: { options.cacheSerializer.data(with: processedImage, original: nil) }
                            )

                            targetCache.store(
                                processedImage,
                                forKey: key,
                                options: cacheOptions,
                                toDisk: !options.cacheMemoryOnly)
                            {
                                _ in
                                coordinator.apply(.cachingImage) {
                                    options.callbackQueue.execute { completionHandler?(.success(result)) }
                                }
                            }

                            coordinator.apply(.cacheInitiated) {
                                options.callbackQueue.execute { completionHandler?(.success(result)) }
                            }
                        }
                    },
                    onFailure: { _ in
                        // This should not happen actually, since we already confirmed `originalImageCached` is `true`.
                        // Just in case...
                        options.callbackQueue.execute {
                            completionHandler?(
                                .failure(KingfisherError.cacheError(reason: .imageNotExisting(key: key)))
                            )
                        }
                    }
                )
            }
            return true
        }

        return false
    }
}

class RetrievingContext {

    var options: KingfisherParsedOptionsInfo

    let originalSource: Source
    var propagationErrors: [PropagationError] = []

    init(options: KingfisherParsedOptionsInfo, originalSource: Source) {
        self.originalSource = originalSource
        self.options = options
    }

    func popAlternativeSource() -> Source? {
        guard var alternativeSources = options.alternativeSources, !alternativeSources.isEmpty else {
            return nil
        }
        let nextSource = alternativeSources.removeFirst()
        options.alternativeSources = alternativeSources
        return nextSource
    }

    @discardableResult
    func appendError(_ error: KingfisherError, to source: Source) -> [PropagationError] {
        let item = PropagationError(source: source, error: error)
        propagationErrors.append(item)
        return propagationErrors
    }
}

class CacheCallbackCoordinator {

    enum State {
        case idle
        case imageCached
        case originalImageCached
        case done
    }

    enum Action {
        case cacheInitiated
        case cachingImage
        case cachingOriginalImage
    }

    private let shouldWaitForCache: Bool
    private let shouldCacheOriginal: Bool
    private let stateQueue: DispatchQueue
    private var threadSafeState: State = .idle

    private (set) var state: State {
        set { stateQueue.sync { threadSafeState = newValue } }
        get { stateQueue.sync { threadSafeState } }
    }

    init(shouldWaitForCache: Bool, shouldCacheOriginal: Bool) {
        self.shouldWaitForCache = shouldWaitForCache
        self.shouldCacheOriginal = shouldCacheOriginal
        let stateQueueName = "com.onevcat.Kingfisher.CacheCallbackCoordinator.stateQueue.\(UUID().uuidString)"
        self.stateQueue = DispatchQueue(label: stateQueueName)
    }

    func apply(_ action: Action, trigger: () -> Void) {
        switch (state, action) {
        case (.done, _):
            break

        // From .idle
        case (.idle, .cacheInitiated):
            if !shouldWaitForCache {
                state = .done
                trigger()
            }
        case (.idle, .cachingImage):
            if shouldCacheOriginal {
                state = .imageCached
            } else {
                state = .done
                trigger()
            }
        case (.idle, .cachingOriginalImage):
            state = .originalImageCached

        // From .imageCached
        case (.imageCached, .cachingOriginalImage):
            state = .done
            trigger()

        // From .originalImageCached
        case (.originalImageCached, .cachingImage):
            state = .done
            trigger()

        default:
            assertionFailure("This case should not happen in CacheCallbackCoordinator: \(state) - \(action)")
        }
    }
}
