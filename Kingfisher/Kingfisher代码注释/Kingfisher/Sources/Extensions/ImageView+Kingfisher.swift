//
//  ImageView+Kingfisher.swift
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

#if !os(watchOS)

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension KingfisherWrapper where Base: KFCrossPlatformImageView {

    // MARK: Setting Image
    // MARK: 设置图像

    /// Sets an image to the image view with a `Source`.
    /// 使用 Source 将图像设置到图像视图中。
    ///
    /// - Parameters:
    ///   - source: The `Source` object defines data information from network or a data provider.
    ///   - placeholder: A placeholder to show while retrieving the image from the given `resource`.
    ///   - options: An options set to define image setting behaviors. See `KingfisherOptionsInfo` for more.
    ///   - progressBlock: Called when the image downloading progress gets updated. If the response does not contain an
    ///                    `expectedContentLength`, this block will not be called.
    ///   - completionHandler: Called when the image retrieved and set finished.
    /// - 参数:
    /// - source: Source 对象定义了来自网络或数据提供者的数据信息。
    /// - placeholder: 在从给定 resource 检索图像时显示的占位符。
    /// - options: 一个选项集，用于定义图像设置行为。查看 KingfisherOptionsInfo 了解更多信息。
    /// - progressBlock: 当图像下载进度更新时调用。如果响应不包含 expectedContentLength，则不会调用此块。
    /// - completionHandler: 当图像检索并设置完成时调用。
    ///
    /// - Returns: A task represents the image downloading.
    /// - 返回: 代表图像下载的任务。
    ///
    /// - Note:
    /// This is the easiest way to use Kingfisher to boost the image setting process from a source. Since all parameters
    /// have a default value except the `source`, you can set an image from a certain URL to an image view like this:
    /// - 说明:
    /// 这是使用 Kingfisher 从源快速设置图像的最简单方式。由于除了 source 外，所有参数都有默认值，因此您可以像这样将来自特定 URL 的图像设置到图像视图中：
    ///
    /// ```
    /// // Set image from a network source.
    /// // 从网络源设置图像。
    /// let url = URL(string: "https://example.com/image.png")!
    /// imageView.kf.setImage(with: .network(url))
    ///
    /// // Or set image from a data provider.
    /// // 或者从数据提供者设置图像。
    /// let provider = LocalFileImageDataProvider(fileURL: fileURL)
    /// imageView.kf.setImage(with: .provider(provider))
    /// ```
    ///
    /// For both `.network` and `.provider` source, there are corresponding view extension methods. So the code
    /// above is equivalent to:
    /// 对于 .network 和 .provider 源，有相应的视图扩展方法。因此，上述代码等效于：
    ///
    /// ```
    /// imageView.kf.setImage(with: url)
    /// imageView.kf.setImage(with: provider)
    /// ```
    ///
    /// Internally, this method will use `KingfisherManager` to get the source.
    /// Since this method will perform UI changes, you must call it from the main thread.
    /// Both `progressBlock` and `completionHandler` will be also executed in the main thread.
    /// 在内部，此方法将使用 KingfisherManager 来获取源。
    /// 由于此方法将执行 UI 更改，因此必须从主线程调用它。
    /// progressBlock 和 completionHandler 也将在主线程中执行。
    ///
    @discardableResult
    public func setImage(
        with source: Source?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        let options = KingfisherParsedOptionsInfo(KingfisherManager.shared.defaultOptions + (options ?? .empty))
        return setImage(with: source, placeholder: placeholder, parsedOptions: options, progressBlock: progressBlock, completionHandler: completionHandler)
    }

    /// Sets an image to the image view with a `Source`.
    ///
    /// - Parameters:
    ///   - source: The `Source` object defines data information from network or a data provider.
    ///   - placeholder: A placeholder to show while retrieving the image from the given `resource`.
    ///   - options: An options set to define image setting behaviors. See `KingfisherOptionsInfo` for more.
    ///   - completionHandler: Called when the image retrieved and set finished.
    /// - Returns: A task represents the image downloading.
    ///
    /// - Note:
    /// This is the easiest way to use Kingfisher to boost the image setting process from a source. Since all parameters
    /// have a default value except the `source`, you can set an image from a certain URL to an image view like this:
    ///
    /// ```
    /// // Set image from a network source.
    /// let url = URL(string: "https://example.com/image.png")!
    /// imageView.kf.setImage(with: .network(url))
    ///
    /// // Or set image from a data provider.
    /// let provider = LocalFileImageDataProvider(fileURL: fileURL)
    /// imageView.kf.setImage(with: .provider(provider))
    /// ```
    ///
    /// For both `.network` and `.provider` source, there are corresponding view extension methods. So the code
    /// above is equivalent to:
    ///
    /// ```
    /// imageView.kf.setImage(with: url)
    /// imageView.kf.setImage(with: provider)
    /// ```
    ///
    /// Internally, this method will use `KingfisherManager` to get the source.
    /// Since this method will perform UI changes, you must call it from the main thread.
    /// The `completionHandler` will be also executed in the main thread.
    ///
    @discardableResult
    public func setImage(
        with source: Source?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        return setImage(
            with: source,
            placeholder: placeholder,
            options: options,
            progressBlock: nil,
            completionHandler: completionHandler
        )
    }

    /// Sets an image to the image view with a requested resource.
    ///
    /// - Parameters:
    ///   - resource: The `Resource` object contains information about the resource.
    ///   - placeholder: A placeholder to show while retrieving the image from the given `resource`.
    ///   - options: An options set to define image setting behaviors. See `KingfisherOptionsInfo` for more.
    ///   - progressBlock: Called when the image downloading progress gets updated. If the response does not contain an
    ///                    `expectedContentLength`, this block will not be called.
    ///   - completionHandler: Called when the image retrieved and set finished.
    /// - Returns: A task represents the image downloading.
    ///
    /// - Note:
    /// This is the easiest way to use Kingfisher to boost the image setting process from network. Since all parameters
    /// have a default value except the `resource`, you can set an image from a certain URL to an image view like this:
    ///
    /// ```
    /// let url = URL(string: "https://example.com/image.png")!
    /// imageView.kf.setImage(with: url)
    /// ```
    ///
    /// Internally, this method will use `KingfisherManager` to get the requested resource, from either cache
    /// or network. Since this method will perform UI changes, you must call it from the main thread.
    /// Both `progressBlock` and `completionHandler` will be also executed in the main thread.
    ///
    @discardableResult
    public func setImage(
        with resource: Resource?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        return setImage(
            with: resource?.convertToSource(),
            placeholder: placeholder,
            options: options,
            progressBlock: progressBlock,
            completionHandler: completionHandler)
    }

    /// Sets an image to the image view with a requested resource.
    ///
    /// - Parameters:
    ///   - resource: The `Resource` object contains information about the resource.
    ///   - placeholder: A placeholder to show while retrieving the image from the given `resource`.
    ///   - options: An options set to define image setting behaviors. See `KingfisherOptionsInfo` for more.
    ///   - completionHandler: Called when the image retrieved and set finished.
    /// - Returns: A task represents the image downloading.
    ///
    /// - Note:
    /// This is the easiest way to use Kingfisher to boost the image setting process from network. Since all parameters
    /// have a default value except the `resource`, you can set an image from a certain URL to an image view like this:
    ///
    /// ```
    /// let url = URL(string: "https://example.com/image.png")!
    /// imageView.kf.setImage(with: url)
    /// ```
    ///
    /// Internally, this method will use `KingfisherManager` to get the requested resource, from either cache
    /// or network. Since this method will perform UI changes, you must call it from the main thread.
    /// The `completionHandler` will be also executed in the main thread.
    ///
    @discardableResult
    public func setImage(
        with resource: Resource?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        return setImage(
            with: resource,
            placeholder: placeholder,
            options: options,
            progressBlock: nil,
            completionHandler: completionHandler
        )
    }

    /// Sets an image to the image view with a data provider.
    ///
    /// - Parameters:
    ///   - provider: The `ImageDataProvider` object contains information about the data.
    ///   - placeholder: A placeholder to show while retrieving the image from the given `resource`.
    ///   - options: An options set to define image setting behaviors. See `KingfisherOptionsInfo` for more.
    ///   - progressBlock: Called when the image downloading progress gets updated. If the response does not contain an
    ///                    `expectedContentLength`, this block will not be called.
    ///   - completionHandler: Called when the image retrieved and set finished.
    /// - Returns: A task represents the image downloading.
    ///
    /// Internally, this method will use `KingfisherManager` to get the image data, from either cache
    /// or the data provider. Since this method will perform UI changes, you must call it from the main thread.
    /// Both `progressBlock` and `completionHandler` will be also executed in the main thread.
    ///
    @discardableResult
    public func setImage(
        with provider: ImageDataProvider?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        return setImage(
            with: provider.map { .provider($0) },
            placeholder: placeholder,
            options: options,
            progressBlock: progressBlock,
            completionHandler: completionHandler)
    }

    /// Sets an image to the image view with a data provider.
    ///
    /// - Parameters:
    ///   - provider: The `ImageDataProvider` object contains information about the data.
    ///   - placeholder: A placeholder to show while retrieving the image from the given `resource`.
    ///   - options: An options set to define image setting behaviors. See `KingfisherOptionsInfo` for more.
    ///   - completionHandler: Called when the image retrieved and set finished.
    /// - Returns: A task represents the image downloading.
    ///
    /// Internally, this method will use `KingfisherManager` to get the image data, from either cache
    /// or the data provider. Since this method will perform UI changes, you must call it from the main thread.
    /// The `completionHandler` will be also executed in the main thread.
    ///
    @discardableResult
    public func setImage(
        with provider: ImageDataProvider?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        return setImage(
            with: provider,
            placeholder: placeholder,
            options: options,
            progressBlock: nil,
            completionHandler: completionHandler
        )
    }


    func setImage(
        with source: Source?,
        placeholder: Placeholder? = nil,
        parsedOptions: KingfisherParsedOptionsInfo,
        progressBlock: DownloadProgressBlock? = nil,
        completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) -> DownloadTask?
    {
        var mutatingSelf = self
        guard let source = source else {
            mutatingSelf.placeholder = placeholder
            mutatingSelf.taskIdentifier = nil
            completionHandler?(.failure(KingfisherError.imageSettingError(reason: .emptySource)))
            return nil
        }

        var options = parsedOptions

        let isEmptyImage = base.image == nil && self.placeholder == nil
        if !options.keepCurrentImageWhileLoading || isEmptyImage {
            // Always set placeholder while there is no image/placeholder yet.
            mutatingSelf.placeholder = placeholder
        }

        let maybeIndicator = indicator
        maybeIndicator?.startAnimatingView()

        let issuedIdentifier = Source.Identifier.next()
        mutatingSelf.taskIdentifier = issuedIdentifier

        if base.shouldPreloadAllAnimation() {
            options.preloadAllAnimationData = true
        }

        if let block = progressBlock {
            options.onDataReceived = (options.onDataReceived ?? []) + [ImageLoadingProgressSideEffect(block)]
        }

        let task = KingfisherManager.shared.retrieveImage(
            with: source,
            options: options,
            downloadTaskUpdated: { mutatingSelf.imageTask = $0 },
            progressiveImageSetter: { self.base.image = $0 },
            referenceTaskIdentifierChecker: { issuedIdentifier == self.taskIdentifier },
            completionHandler: { result in
                CallbackQueue.mainCurrentOrAsync.execute {
                    maybeIndicator?.stopAnimatingView()
                    guard issuedIdentifier == self.taskIdentifier else {
                        let reason: KingfisherError.ImageSettingErrorReason
                        do {
                            let value = try result.get()
                            reason = .notCurrentSourceTask(result: value, error: nil, source: source)
                        } catch {
                            reason = .notCurrentSourceTask(result: nil, error: error, source: source)
                        }
                        let error = KingfisherError.imageSettingError(reason: reason)
                        completionHandler?(.failure(error))
                        return
                    }

                    mutatingSelf.imageTask = nil
                    mutatingSelf.taskIdentifier = nil

                    switch result {
                    case .success(let value):
                        guard self.needsTransition(options: options, cacheType: value.cacheType) else {
                            mutatingSelf.placeholder = nil
                            self.base.image = value.image
                            completionHandler?(result)
                            return
                        }

                        self.makeTransition(image: value.image, transition: options.transition) {
                            completionHandler?(result)
                        }

                    case .failure:
                        if let image = options.onFailureImage {
                            mutatingSelf.placeholder = nil
                            self.base.image = image
                        }
                        completionHandler?(result)
                    }
                }
            }
        )
        mutatingSelf.imageTask = task
        return task
    }

    // MARK: Cancelling Downloading Task
    // MARK: 取消下载任务

    /// Cancels the image download task of the image view if it is running.
    /// Nothing will happen if the downloading has already finished.
    /// 如果图像视图的下载任务正在运行，则取消图像下载任务。
    /// 如果下载已经完成，则不会发生任何事情。
    public func cancelDownloadTask() {
        imageTask?.cancel()
    }

    private func needsTransition(options: KingfisherParsedOptionsInfo, cacheType: CacheType) -> Bool {
        switch options.transition {
        case .none:
            return false
        #if os(macOS)
        case .fade: // Fade is only a placeholder for SwiftUI on macOS.
            return false
        #else
        default:
            if options.forceTransition { return true }
            if cacheType == .none { return true }
            return false
        #endif
        }
    }

    private func makeTransition(image: KFCrossPlatformImage, transition: ImageTransition, done: @escaping () -> Void) {
        #if !os(macOS)
        // Force hiding the indicator without transition first.
        UIView.transition(
            with: self.base,
            duration: 0.0,
            options: [],
            animations: { self.indicator?.stopAnimatingView() },
            completion: { _ in
                var mutatingSelf = self
                mutatingSelf.placeholder = nil
                UIView.transition(
                    with: self.base,
                    duration: transition.duration,
                    options: [transition.animationOptions, .allowUserInteraction],
                    animations: { transition.animations?(self.base, image) },
                    completion: { finished in
                        transition.completion?(finished)
                        done()
                    }
                )
            }
        )
        #else
        done()
        #endif
    }
}

// MARK: - Associated Object
// MARK: - 关联对象
private var taskIdentifierKey: Void?
private var indicatorKey: Void?
private var indicatorTypeKey: Void?
private var placeholderKey: Void?
private var imageTaskKey: Void?

extension KingfisherWrapper where Base: KFCrossPlatformImageView {

    // MARK: Properties
    // MARK: 属性
    public private(set) var taskIdentifier: Source.Identifier.Value? {
        get {
            let box: Box<Source.Identifier.Value>? = getAssociatedObject(base, &taskIdentifierKey)
            return box?.value
        }
        set {
            let box = newValue.map { Box($0) }
            setRetainedAssociatedObject(base, &taskIdentifierKey, box)
        }
    }

    /// Holds which indicator type is going to be used.
    /// Default is `.none`, means no indicator will be shown while downloading.
    /// 保存将要使用的指示器类型。
    /// 默认为 .none，表示在下载过程中不会显示任何指示器。
    public var indicatorType: IndicatorType {
        get {
            return getAssociatedObject(base, &indicatorTypeKey) ?? .none
        }
        
        set {
            switch newValue {
            case .none: indicator = nil
            case .activity: indicator = ActivityIndicator()
            case .image(let data): indicator = ImageIndicator(imageData: data)
            case .custom(let anIndicator): indicator = anIndicator
            }

            setRetainedAssociatedObject(base, &indicatorTypeKey, newValue)
        }
    }
    
    /// Holds any type that conforms to the protocol `Indicator`.
    /// The protocol `Indicator` has a `view` property that will be shown when loading an image.
    /// It will be `nil` if `indicatorType` is `.none`.
    /// 保存符合协议 Indicator 的任何类型。
    /// 协议 Indicator 具有一个 view 属性，该属性在加载图像时显示。
    /// 如果 indicatorType 是 .none，则该属性将为 nil。
    public private(set) var indicator: Indicator? {
        get {
            let box: Box<Indicator>? = getAssociatedObject(base, &indicatorKey)
            return box?.value
        }
        
        set {
            // Remove previous
            // 移除前一个
            if let previousIndicator = indicator {
                previousIndicator.view.removeFromSuperview()
            }
            
            // Add new
            // 添加新的
            if let newIndicator = newValue {
                // Set default indicator layout
                // 设置默认的指示器布局
                let view = newIndicator.view
                
                base.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.centerXAnchor.constraint(
                    equalTo: base.centerXAnchor, constant: newIndicator.centerOffset.x).isActive = true
                view.centerYAnchor.constraint(
                    equalTo: base.centerYAnchor, constant: newIndicator.centerOffset.y).isActive = true

                switch newIndicator.sizeStrategy(in: base) {
                case .intrinsicSize:
                    break
                case .full:
                    view.heightAnchor.constraint(equalTo: base.heightAnchor, constant: 0).isActive = true
                    view.widthAnchor.constraint(equalTo: base.widthAnchor, constant: 0).isActive = true
                case .size(let size):
                    view.heightAnchor.constraint(equalToConstant: size.height).isActive = true
                    view.widthAnchor.constraint(equalToConstant: size.width).isActive = true
                }
                
                newIndicator.view.isHidden = true
            }

            // Save in associated object
            // Wrap newValue with Box to workaround an issue that Swift does not recognize
            // and casting protocol for associate object correctly. https://github.com/onevcat/Kingfisher/issues/872
            // 保存在关联对象中
            // 使用 Box 将 newValue 包装起来，以解决 Swift 无法正确识别和转换协议以用于关联对象的问题。参考：https://github.com/onevcat/Kingfisher/issues/872
            setRetainedAssociatedObject(base, &indicatorKey, newValue.map(Box.init))
        }
    }
    
    private var imageTask: DownloadTask? {
        get { return getAssociatedObject(base, &imageTaskKey) }
        set { setRetainedAssociatedObject(base, &imageTaskKey, newValue)}
    }

    /// Represents the `Placeholder` used for this image view. A `Placeholder` will be shown in the view while
    /// it is downloading an image.
    /// 代表用于此图像视图的 Placeholder。在下载图像时，Placeholder 将显示在视图中。
    public private(set) var placeholder: Placeholder? {
        get { return getAssociatedObject(base, &placeholderKey) }
        set {
            if let previousPlaceholder = placeholder {
                previousPlaceholder.remove(from: base)
            }
            
            if let newPlaceholder = newValue {
                newPlaceholder.add(to: base)
            } else {
                base.image = nil
            }
            setRetainedAssociatedObject(base, &placeholderKey, newValue)
        }
    }
}


extension KFCrossPlatformImageView {
    @objc func shouldPreloadAllAnimation() -> Bool { return true }
}

#endif
