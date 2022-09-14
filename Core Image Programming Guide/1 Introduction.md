# About Core Image - 关于 Core Image

原文链接：[https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html#//apple_ref/doc/uid/TP30001185-CH1-TPXREF101](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_intro/ci_intro.html#//apple_ref/doc/uid/TP30001185-CH1-TPXREF101)

Core Image is an image processing and analysis technology designed to provide near real-time processing for still and video images. It operates on image data types from the Core Graphics, Core Video, and Image I/O frameworks, using either a GPU or CPU rendering path. Core Image hides the details of low-level graphics processing by providing an easy-to-use application programming interface (API). You don’t need to know the details of OpenGL, OpenGL ES, or Metal to leverage the power of the GPU, nor do you need to know anything about Grand Central Dispatch (GCD) to get the benefit of multicore processing. Core Image handles the details for you.

Core Image 是一种图像处理和分析技术，旨在为静态和视频图像提供近实时处理。它使用 GPU 或 CPU 渲染路径，对来自 Core Graphics，Core Video 和 Image I / O 框架的图像数据类型进行操作。Core Image 通过提供易于使用的应用程序编程接口（API）隐藏了低级图形处理的细节。你不需要了解 OpenGL，OpenGL ES 或 Metal 的细节就能充分利用 GPU 的强大功能，也无需了解Grand Central Dispatch（GCD）以获得多核处理的优势。Core Image 会为你处理这些细节。

**Figure I-1**  Core Image in relation to the operating system **图 I-1** Core Image 与操作系统的关系

![Core Image in relation to other graphics technologies](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/art/architecture_2x.png)

## At a Glance - 导读

The Core Image framework provides:

Core Image框架提供：

- Access to built-in image processing filters
- Feature detection capability
- Support for automatic image enhancement
- The ability to chain multiple filters together to create custom effects
- Support for creating custom filters that run on a GPU
- Feedback-based image processing capabilities

- 访问内置图像处理滤镜
- 特征检测功能
- 支持自动图像增强
- 将多个滤镜链接在一起以创建自定义效果的功能
- 支持创建在 GPU 上运行的自定义滤镜
- 基于反馈的图像处理功能

On macOS, Core Image also provides a means for packaging custom filters for use by other apps.

在macOS上，Core Image 还提供了一种打包自定义滤镜以供其他应用程序使用的方法。

### Core Image is Efficient and Easy to Use for Processing and Analyzing Images - Core Image 高效且易于用于处理和分析图像

Core Image provides hundreds of built-in filters. You set up filters by supplying key-value pairs for a filter’s input parameters. The output of one filter can be the input of another, making it possible to chain numerous filters together to create amazing effects. If you create a compound effect that you want to use again, you can subclass CIFilter to capture the effect “recipe.”

Core Image 提供数百种内置滤镜。你可以通过为滤镜的输入参数提供键值对来设置滤镜。一个滤镜的输出可以是另一个滤镜的输入，从而可以将多个滤镜链接在一起而产生惊人的效果。如果你要创建一个想再次使用的复合效果，则可以将 CIFilter 子类化以获得特效“配方”。

There are more than a dozen categories of filters. Some are designed to achieve artistic results, such as the stylize and halftone filter categories. Others are optimal for fixing image problems, such as color adjustment and sharpen filters.

有十几种类别的滤镜。有些旨在实现艺术效果，例如风格化和半色调类别的滤镜。其他的最适合修复图像问题，例如颜色调整和锐化滤镜。

Core Image can analyze the quality of an image and provide a set of filters with optimal settings for adjusting such things as hue, contrast, and tone color, and for correcting for flash artifacts such as red eye. It does all this with one method call on your part.

Core Image 可以分析图像的质量，并提供一组具有最佳设置的滤镜，用于调整色相，对比度和色调等内容，以及校正闪光瑕疵（如红眼）。它通过一个方法调用完成所有这一切。

Core Image can detect human face features in still images and track them over time in video images. Knowing where faces are can help you determine where to place a vignette or apply other special filters.

Core Image 可以检测静止图像中的人脸特征，并在视频图像中随时间跟踪它们。了解面部的位置可以帮助您确定放置小插图的位置或应用其他特殊滤镜。

> **Relevant chapters:** [Processing Images](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-TPXREF101), [Detecting Faces in an Image](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_detect_faces/ci_detect_faces.html#//apple_ref/doc/uid/TP30001185-CH8-SW1), [Auto Enhancing Images](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_autoadjustment/ci_autoadjustmentSAVE.html#//apple_ref/doc/uid/TP30001185-CH11-SW1), [Subclassing CIFilter: Recipes for Custom Effects](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_filer_recipes/ci_filter_recipes.html#//apple_ref/doc/uid/TP30001185-CH4-SW1)
> 
> **相关章节：**《[处理图像](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-TPXREF101)》、《[在图像中检测人脸](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_detect_faces/ci_detect_faces.html#//apple_ref/doc/uid/TP30001185-CH8-SW1)》、《[自动增强图像](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_autoadjustment/ci_autoadjustmentSAVE.html#//apple_ref/doc/uid/TP30001185-CH11-SW1)》、《[子类化 CIFilter：自定义效果的配方](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_filer_recipes/ci_filter_recipes.html#//apple_ref/doc/uid/TP30001185-CH4-SW1)》

### Query Core Image to Get a List of Filters and Their Attributes - 查询 Core Image 以获取滤镜及其属性列表

Core Image has “built-in” reference documentation for its filters. You can query the system to find out which filters are available. Then, for each filter, you can retrieve a dictionary that contains its attributes, such as its input parameters, defaults parameter values, minimum and maximum values, display name, and more.

Core Image 为其滤镜提供了“内置”参考文档。你可以查询系统找出可用的滤镜。然后，对于每个滤镜，您可以检索包含其属性的字典，例如其输入参数，默认参数值，最小值和最大值，显示名称等。

> **Relevant chapter:**  [Querying the System for Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_concepts/ci_concepts.html#//apple_ref/doc/uid/TP30001185-CH2-TPXREF101)
> 
> **相关章节：**《[查询滤镜系统](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_concepts/ci_concepts.html#//apple_ref/doc/uid/TP30001185-CH2-TPXREF101)》

### Core Image Can Achieve Real-Time Video Performance - Core Image 可以优化实时视频处理性能

If your app needs to process video in real-time, there are several things you can do to optimize performance.

如果你的应用需要实时处理视频，你可以采取一些措施来优化性能。

> **Relevant chapter:** [Getting the Best Performance](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_performance/ci_performance.html#//apple_ref/doc/uid/TP30001185-CH10-SW1)
> 
> **相关章节：**《[获得最佳性能](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_performance/ci_performance.html#//apple_ref/doc/uid/TP30001185-CH10-SW1)》

### Use an Image Accumulator to Support Feedback-Based Processing - 使用图像累加器支持基于反馈的处理

The CIImageAccumulator class is designed for efficient feedback-based image processing, which you might find useful if your app needs to image dynamical systems.

CIImageAccumulator 类专为高效的基于反馈的图像处理而设计，如果你的应用需要对动态系统进行成像，你可能会觉得这很有用。

> **Relevant chapter:**  [Using Feedback to Process Images](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_feedback_based/ci_feedback_based.html#//apple_ref/doc/uid/TP30001185-CH5-SW5)
> 
> **相关章节：**《[使用反馈处理图像](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_feedback_based/ci_feedback_based.html#//apple_ref/doc/uid/TP30001185-CH5-SW5)》

### Create and Distribute Custom Kernels and Filters 创建和分发自定义内核和滤镜

If none of the built-in filters suits your needs, even when chained together, consider creating a custom filter. You’ll need to understand kernels—programs that operate at the pixel level—because they are at the heart of every filter.

如果内置滤镜即使链接在一起也不能满足你的需求，也可以考虑创建自定义滤镜。你需要了解内核 —— 在像素级别运行的程序 —— 因为它们是每个滤镜的核心。

In macOS, you can package one or more custom filter as an image unit so that other apps can load and use them.

在 macOS 中，您可以将一个或多个自定义滤镜打包为图像单元，以便其他应用程序可以加载和使用它们。

> **Relevant chapters:** [What You Need to Know Before Writing a Custom Filter](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_advanced_concepts/ci.advanced_concepts.html#//apple_ref/doc/uid/TP30001185-CH9-SW1), [Creating Custom Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_custom_filters/ci_custom_filters.html#//apple_ref/doc/uid/TP30001185-CH6-TPXREF101), [Packaging and Loading Image Units](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_image_units/ci_image_units.html#//apple_ref/doc/uid/TP30001185-CH7-SW12)
> 
> **相关章节：**《[在编写自定义滤镜前你需要知道的事](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_advanced_concepts/ci.advanced_concepts.html#//apple_ref/doc/uid/TP30001185-CH9-SW1)》、《[创建自定义滤镜](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_custom_filters/ci_custom_filters.html#//apple_ref/doc/uid/TP30001185-CH6-TPXREF101)》、《[打包和加载图像单元](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_image_units/ci_image_units.html#//apple_ref/doc/uid/TP30001185-CH7-SW12)》

## See Also - 其他参考

Other important documentation for Core Image includes:

Core Image 的其他重要文档包括：

- [Core Image Reference Collection](https://developer.apple.com/documentation/coreimage) provides a detailed description of the classes available in the Core Image framework.
- [Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346) describes the built-in image processing filters that Apple provides, and shows how images appear before and after processing with a filter.
- [Core Image Kernel Language Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CIKernelLangRef/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004397) describes the language for creating kernel routines for custom filters.

- 《[Core Image Reference Collection](https://developer.apple.com/documentation/coreimage)》提供了 Core Image 框架中可用类的详细描述。
- 《[Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346)》描述了 Apple 提供的内置图像处理滤镜，并展示了使用滤镜处理前后图像的显示方式。
- 《[Core Image Kernel Language Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CIKernelLangRef/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004397)》描述了为自定义滤镜创建内核程序的语言。


