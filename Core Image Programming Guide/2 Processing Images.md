# Processing Images - 处理图像

原文链接：[https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-TPXREF101](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-TPXREF101)

Processing images means applying filters—an image filter is a piece of software that examines an input image pixel by pixel and algorithmically applies some effect in order to create an output image. In Core Image, image processing relies on the [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) and [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) classes, which describe filters and their input and output. To apply filters and display or export results, you can make use of the integration between Core Image and other system frameworks, or create your own rendering workflow with the [CIContext](https://developer.apple.com/documentation/coreimage/cicontext) class. This chapter covers the key concepts for working with these classes to apply filters and render results.

处理图像意味着应用滤镜 —— 图像滤镜是一个软件，它逐个像素地检查输入图像，并通过算法应用一些效果以创建输出图像。在 Core Image 中，图像处理依赖于 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 和 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 类，它们描述了滤镜及其输入和输出。要应用滤镜并显示或导出结果，您可以利用 Core Image 和其他系统框架之间的集成，或者使用 [CIContext](https://developer.apple.com/documentation/coreimage/cicontext) 类创建自己的渲染工作流。本章介绍了使用这些类来应用滤镜和呈现结果的关键概念。

## 1 Overview - 概述

There are many ways to use Core Image for image processing in your app. Listing 1-1 shows a basic example and provides pointers to further explanations in this chapter.

在应用程序中，有许多方法可以使用 Core Image 进行图像处理。清单1-1展示了一个基本示例，在本章中会对其作进一步的说明。

**Listing 1-1**  The basics of applying a filter to an image - **清单1-1** 将滤镜应用于图像的基本步骤

```
import CoreImage
 
let context = CIContext()                                           // 1
 
let filter = CIFilter(name: "CISepiaTone")!                         // 2
filter.setValue(0.8, forKey: kCIInputIntensityKey)
let image = CIImage(contentsOfURL: myURL)                           // 3
filter.setValue(image, forKey: kCIInputImageKey)
let result = filter.outputImage!                                    // 4
let cgImage = context.createCGImage(result, from: result.extent)    // 5
```

Here’s what the code does:

这些代码的作用是：

1. Create a `CIContext` object (with default options). You don’t always need your own Core Image context—often you can integrate with other system frameworks that manage rendering for you. Creating your own context lets you more precisely control the rendering process and the resources involved in rendering. Contexts are heavyweight objects, so if you do create one, do so as early as possible, and reuse it each time you need to process images. (See [Building Your Own Workflow with a Core Image Context](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW5).)
2. Instantiate a `CIFilter` object representing the filter to apply, and provide values for its parameters. (See [Filters Describe Image Processing Effects](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW3).)
3. Create a `CIImage` object representing the image to be processed, and provide it as the input image parameter to the filter. Reading image data from a URL is just one of many ways to create an image object. (See [Images are the Input and Output of Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4).)
4. Get a `CIImage` object representing the filter’s output. The filter has not yet executed at this point—the image object is a “recipe” specifying how to create an image with the specified filter, parameters, and input. Core Image performs this recipe only when you request rendering. (See  [Images are the Input and Output of Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4).)
5. Render the output image to a Core Graphics image that you can display or save to a file. (See [Building Your Own Workflow with a Core Image Context](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW5).)

>

1. 创建一个 `CIContext` 对象（使用默认选项）。您并不总是需要自己的 Core Image 上下文 —— 通常可以与管理渲染的其他系统框架集成。通过创建自己的上下文，您可以更精确地控制渲染过程和渲染所涉及的资源。上下文是重量级对象，因此如果您要创建一个，请尽早执行，并在每次需要处理图像时重复使用它。（参见《[使用 Core Image 上下文创建你自己的工作流](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW5)》）
2. 实例化表示要应用的滤镜的 `CIFilter` 对象，并为其参数提供值。（参见《[描述图像处理效果的滤镜](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW3)》）
3. 创建表示要处理的图像的 `CIImage` 对象，并将其作为输入图像参数提供给滤镜。从 URL 读取图像数据只是创建图像对象的众多方法之一。（参见《[图像是滤镜的输入和输出](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4)》）
4. 获取表示滤镜输出的 `CIImage` 对象。此时滤镜尚未执行 —— 图像对象是一个“配方”，指明如何使用指定的滤镜、参数和输入来创建图像。 Core Image 仅在您请求渲染时执行此配方。（参见《[图像是滤镜的输入和输出](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4)》）
5. 将输出图像渲染为可以显示或保存到文件的 Core Graphics 图像。（参见《[使用 Core Image 上下文创建你自己的工作流](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW5)》）


## 2 Images are the Input and Output of Filters - 图像是滤镜的输入和输出

Core Image filters process and produce Core Image images. A [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) instance is an immutable object representing an image. These objects don’t directly represent image bitmap data—instead, a [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) object is a “recipe” for producing an image. One recipe might call for loading an image from a file; another might represent output from a filter, or from a chain of filters. Core Image performs these recipes only when you request that an image be rendered for display or output.

Core Image 滤镜处理并生成 Core Image 图像。一个 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 实例是表示图像的一个不可变的对象。这些对象不直接表示图像位图数据 —— 相反，[CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 对象是用于产生图像的“配方”。一个配方可能要求从文件加载图像；另一个可能代表一个滤镜或一串滤镜的输出。仅当您请求渲染图像以供显示或输出时，Core Image 才会执行这些配方。

To apply a filter, create one or more [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) objects representing the images to be processed by the filter, and assign them to the input parameters of the filter (such as [kCIInputImageKey](https://developer.apple.com/documentation/coreimage/kciinputimagekey)). You can create a Core Image image object from nearly any source of image data, including:

要应用滤镜，请创建一个或多个 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 对象，他们表示要由滤镜处理的图像，并将它们分配给滤镜的输入参数（例如 [kCIInputImageKey](https://developer.apple.com/documentation/coreimage/kciinputimagekey)）。您几乎可以从任何图像数据源创建 Core Image 图像对象，包括：

- URLs referencing image files to be loaded or [NSData](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSDataClassCluster/Description.html#//apple_ref/occ/cl/NSData) objects containing image file data
- Quartz2D, UIKit, or AppKit image representations ([CGImageRef](https://developer.apple.com/documentation/coregraphics/cgimageref), [UIImage](https://developer.apple.com/documentation/uikit/uiimage), or [NSBitmapImageRep](https://developer.apple.com/documentation/appkit/nsbitmapimagerep) objects)
- Metal, OpenGL, or OpenGL ES textures
- CoreVideo image or pixel buffers ([CVImageBufferRef](https://developer.apple.com/documentation/corevideo/cvimagebufferref) or [CVPixelBufferRef](https://developer.apple.com/documentation/corevideo/cvpixelbuffer))
- [IOSurfaceRef](https://developer.apple.com/documentation/iosurface/iosurfaceref) objects that share image data between processes
- Image bitmap data in memory (a pointer to such data, or a `CIImageProvider` object that provides data on demand)

>

- 引用要加载的图像文件的 URL 或包含图像文件数据的 [NSData](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/Foundation/Classes/NSDataClassCluster/Description.html#//apple_ref/occ/cl/NSData) 对象
- Quartz2D，UIKit 或者 AppKit 的图像（[CGImageRef](https://developer.apple.com/documentation/coregraphics/cgimageref)，[UIImage](https://developer.apple.com/documentation/uikit/uiimage) 或 [NSBitmapImageRep](https://developer.apple.com/documentation/appkit/nsbitmapimagerep) 对象）
- Metal，OpenGL 或 OpenGL ES纹理
- CoreVideo 图像或像素缓冲区（[CVImageBufferRef](https://developer.apple.com/documentation/corevideo/cvimagebufferref) 或 [CVPixelBufferRef](https://developer.apple.com/documentation/corevideo/cvpixelbuffer)）
- 在进程之间共享图像数据的 [IOSurfaceRef](https://developer.apple.com/documentation/iosurface/iosurfaceref)  对象
- 内存中的图像位图数据（指向此类数据的指针，或按需提供数据的 `CIImageProvider` 对象）

For a full list of ways to create a `CIImage` object, see [CIImage Class Reference](https://developer.apple.com/documentation/coreimage/ciimage).

有关创建CIImage对象的完整方法列表，请参阅《[CIImage 类参考](https://developer.apple.com/documentation/coreimage/ciimage)》。

Because a `CIImage` object describes how to produce an image (instead of containing image data), it can also represent filter output. When you access the [outputImage](https://developer.apple.com/documentation/coreimage/cifilter/1438169-outputimage) property of a [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) object, Core Image merely identifies and stores the steps needed to execute the filter. Those steps are performed only when you request that the image be rendered for display or output. You can request rendering either explicitly, using one of the [CIContext](https://developer.apple.com/documentation/coreimage/cicontext) render or draw methods (see [Building Your Own Workflow with a Core Image Context](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW5)), or implicitly, by displaying an image using one of the many system frameworks that work with Core Image (see [Integrating with Other Frameworks](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW6)).

因为 `CIImage` 对象描述了如何生成图像（而不是包含图像数据），所以它也可以表示滤镜的输出。当您访问 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 对象的 [outputImage](https://developer.apple.com/documentation/coreimage/cifilter/1438169-outputimage) 属性时，Core Image 仅标识并存储执行滤镜所需的步骤。仅当您请求渲染图像以供显示或输出时，才会执行这些步骤。您可以使用 [CIContext](https://developer.apple.com/documentation/coreimage/cicontext) 的 render 或 draw 方法中的一个来显式请求渲染（请参阅《[使用 Core Image 上下文构建您自己的工作流](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW5)》），或者通过使用与 Core Image 一起工作的众多系统框架之一显示图像来隐式请求渲染（请参阅《[与其他框架集成](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW6)》）。

Deferring processing until rendering time makes Core Image fast and efficient. At rendering time, Core Image can see if more than one filter needs to be applied to an image. If so, it automatically concatenates multiple “recipes” and organizes them to eliminate redundant operations, so that each pixel is processed only once rather than many times.


把处理工作延迟到渲染时才执行使得 Core Image 快速高效。在渲染时，Core Image 可以查看是否需要将多个滤镜应用于图像。如果是这样，它会自动连接多个“配方”并组织它们以消除冗余操作，这样每个像素只处理一次而不是多次。

## 3 Filters Describe Image Processing Effects - 滤镜描述图像处理效果

An instance of the [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) class is a mutable object representing an image processing effect and any parameters that control that effect’s behavior. To use a filter, you create a [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) object, set its input parameters, and then access its output image (see [Images are the Input and Output of Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4) below). Call the [filterWithName:](https://developer.apple.com/documentation/coreimage/cifilter/1438255-filterwithname) initializer to instantiate a filter object using the name of a filter known to the system (see [Querying the System for Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_concepts/ci_concepts.html#//apple_ref/doc/uid/TP30001185-CH2-TPXREF101) or [Core Image Filter Reference](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346)).

[CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 类的实例是表示图像处理效果以及控制该效果行为的所有参数的可变对象。要使用滤镜，可以创建一个 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 对象，设置其输入参数，然后访问其输出图像（请参阅《[图像是滤镜的输入和输出](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4)》的后面部分）。使用系统已知的滤镜名称，调用 [filterWithName:](https://developer.apple.com/documentation/coreimage/cifilter/1438255-filterwithname) 初始化方法，可以实例化滤镜对象（请参阅《[查询系统滤镜](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_concepts/ci_concepts.html#//apple_ref/doc/uid/TP30001185-CH2-TPXREF101)》或《[Core Image 滤镜参考](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346)》）。

Most filters have one or more input parameters that let you control how processing is done. Each input parameter has an attribute class that specifies its data type, such as `NSNumber`. An input parameter can optionally have other attributes, such as its default value, the allowable minimum and maximum values, the display name for the parameter, and other attributes described in [CIFilter Class Reference](https://developer.apple.com/documentation/coreimage/cifilter). For example, the [CIColorMonochrome](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorMonochrome) filter has three input parameters—the image to process, a monochrome color, and the color intensity.

大多数滤镜都有一个或多个输入参数，可让您控制处理过程如何完成。每个输入参数都有一个属性类，用于指定其数据类型，例如`NSNumber`。输入参数可以选择具有其他属性，例如其默认值，允许的最小值和最大值，参数的显示名称以及《[CIFilter 类参考](https://developer.apple.com/documentation/coreimage/cifilter)》中描述的其他属性。例如，[CIColorMonochrome](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIColorMonochrome) 滤镜有三个输入参数 —— 要处理的图像，单色和颜色强度。

Filter parameters are defined as key-value pairs; to work with parameters, you typically use the [valueForKey:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/EOF/EOControl/Classes/NSObjectAdditions/Description.html#//apple_ref/occ/instm/NSObject/valueForKey:) and [setValue:forKey:](https://developer.apple.com/documentation/objectivec/nsobject/1415969-setvalue) methods or other features that build upon key-value coding (such as Core Animation). The key is a constant that identifies the attribute and the value is the setting associated with the key. Core Image attribute values typically use one of the data types listed in Attribute value data types .

滤镜参数定义为键值对；要使用参数，通常使用 [valueForKey:](https://developer.apple.com/library/archive/documentation/LegacyTechnologies/WebObjects/WebObjects_3.5/Reference/Frameworks/ObjC/EOF/EOControl/Classes/NSObjectAdditions/Description.html#//apple_ref/occ/instm/NSObject/valueForKey:) 和 [setValue:forKey:](https://developer.apple.com/documentation/objectivec/nsobject/1415969-setvalue) 方法，或基于键值编码构建的其他功能（例如 Core Animation）。键是标识属性的常量，值是与键关联的设置。Core Image 属性值通常使用表 1-1 中列出的数据类型之一。

**Table 1-1**  Attribute value data types

| Data Type | Object | Description |
|:-:|:-:|:-:|
| Strings | NSString | Text, typically for display to the user
| Floating-point values | NSNumber | A scalar value, such as an intensity level or radius
| Vectors | CIVector | A set of floating-point values that can specify positions, sizes, rectangles, or untagged color component values
| Colors | CIColor | A set of color component values, tagged with a color space specifying how to interpret them
| Images | CIImage | An image; see [Images are the Input and Output of Filters](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4)
| Transforms | NSData, NSAffineTransform | A coordinate transformation to apply to an image

**表1-1** 属性值数据类型

| 数据类型 | 对象 | 描述 |
|:-:|:-:|:-:|
| 字符串 | NSString | 文本，通常用于向用户显示
| 浮点值 | NSNumber | 标量值，例如强度等级或半径
| 矢量 | CIVector | 一组浮点值，可指定位置、大小、矩形或未标记的颜色分量值
| 颜色 | CIColor | 一组颜色分量值，标记有指定如何解释它们的颜色空间
| 图像 | CIImage | 一个图像; 请参阅《[图像是滤镜的输入和输出](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/ci_tasks/ci_tasks.html#//apple_ref/doc/uid/TP30001185-CH3-SW4)》
| 变换 | NSData, NSAffineTransform | 要应用于图像的坐标转换

> **Important:** CIFilter objects are mutable, so you cannot safely share them between different threads. Each thread must create its own CIFilter objects. However, a filter’s input and output CIImage objects are immutable, and thus safe to pass between threads.
> 
> **重要：**CIFilter 对象是可变的，因此你无法在不同的线程之间安全地共享它们。每个线程都必须创建自己的 CIFilter 对象。但是，滤镜的输入和输出 CIImage 对象是不可变的，因此可以安全地在线程之间传递。

### 3.1 Chaining Filters for Complex Effects - 用于复杂效果的链接滤镜

Every Core Image filter produces an output `CIImage` object, so you can use this object as input to another filter. For example, the sequence of filters illustrated in Figure 1-1 applies a color effect to an image, then adds a glow effect, and finally crops a section out of the result.

每个 Core Image 滤镜都会生成一个输出 `CIImage` 对象，因此你可以将此对象用作另一个滤镜的输入。例如，图1-1中所示的滤镜序列将颜色效果应用于图像，然后添加发光效果，最后从结果中裁剪出一个部分。

**Figure 1-1**  Construct a filter chain by connecting filter inputs and outputs - **图1-1** 通过连接滤镜的输入和输出构建滤镜链

![Figure 1-1](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/art/filter_chain01_2x.png)

Core Image optimizes the application of filter chains such as this one to render results quickly and efficiently. Each CIImage object in the chain isn’t a fully rendered image, but instead merely a “recipe” for rendering. Core Image doesn’t need to execute each filter individually, wasting time and memory rendering intermediate pixel buffers that will never be seen. Instead, Core Image combines filters into a single operation, and can even reorganize filters when applying them in a different order will produce the same result more efficiently. Figure 1-2 shows a more accurate rendition of the example filter chain from Figure 1-1.

Core Image 优化了此类滤镜链的应用，以快速高效地呈现结果。滤镜链中的每个 `CIImage` 每个对象都不是完全渲染的图像，而只是用于渲染的“配方”。Core Image 不需要单独执行每个滤镜，浪费时间和内存渲染这些永远不会被看到的中间像素缓冲区。相反，Core Image 将滤镜组合到一个操作中，甚至可以在应用滤镜时以不同顺序重新组织滤镜，从而更有效地生成相同的结果。图1-2更准确的再现了图1-1中示例的滤镜链。

**Figure 1-2**  Core Image optimizes a filter chain to a single operation - **图1-2** Core Image 将滤镜链优化为单个操作

![Figure 1-2](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/CoreImaging/art/filter_chain02_2x.png)

Notice that in Figure 1-2, the crop operation has moved from last to first. That filter results in large areas of the original image being cropped out of the final output. As such, there’s no need to apply the color and sharpen filters to those pixels. By performing the crop first, Core Image ensures that expensive image processing operations apply only to pixels that will be visible in final output.

请注意，在图1-2中，裁剪操作已从最后移动到第一个。该滤镜最终结果是原始图像的大部分区域从最终输出中被裁掉。因此，无需对这些像素应用颜色和锐化滤镜。通过首先执行裁剪，Core Image 确保昂贵的图像处理操作仅应用于最终输出中可见的像素。

Listing 1-2 shows how to set up a filter chain like that illustrated above.

清单1-2显示了如何设置如上所示的滤镜链。

**Listing 1-2**  Creating a filter chain - **清单 1-2** 创建一个滤镜链

```
func applyFilterChain(to image: CIImage) -> CIImage {
    // The CIPhotoEffectInstant filter takes only an input image
    // CIPhotoEffectInstant 滤镜仅传入一个输入图像
    let colorFilter = CIFilter(name: "CIPhotoEffectProcess", withInputParameters:
        [kCIInputImageKey: image])!
    
    // Pass the result of the color filter into the Bloom filter
    // and set its parameters for a glowy effect.
    // 将颜色滤镜的结果传入 Bloom 滤镜，并为发光效果设置参数
    let bloomImage = colorFilter.outputImage!.applyingFilter("CIBloom",
                                                             withInputParameters: [
                                                                kCIInputRadiusKey: 10.0,
                                                                kCIInputIntensityKey: 1.0
        ])
    
    // imageByCroppingToRect is a convenience method for
    // creating the CICrop filter and accessing its outputImage.
    // imageByCroppingToRect 是一个创建 CICrop 滤镜并访问其 outputImage 的便捷方法
    let cropRect = CGRect(x: 350, y: 350, width: 150, height: 150)
    let croppedImage = bloomImage.cropping(to: cropRect)
    
    return croppedImage
}
```

Listing 1-2 also shows a few different convenience methods for configuring filters and accessing their results. In summary, you can use any of these methods to apply a filter, either individually or as part of a filter chain:

清单1-2还显示了一些配置滤镜和访问其结果的便捷方法。总之，您可以使用以下任何方法单独或作为滤镜链的一部分应用滤镜：

- Create a [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) instance with the [filterWithName:](https://developer.apple.com/documentation/coreimage/cifilter/1438255-filterwithname) initializer, set parameters using the [setValue:forKey:](https://developer.apple.com/documentation/objectivec/nsobject/1415969-setvalue) method (including the [kCIInputImageKey](https://developer.apple.com/documentation/coreimage/kciinputimagekey) for the image to process), and access the output image with the [outputImage](https://developer.apple.com/documentation/coreimage/cifilter/1438169-outputimage) property. (See Listing 1-1.)
- Create a [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) instance and set its parameters (including the input image) in one call with the [filterWithName:withInputParameters:](https://developer.apple.com/documentation/coreimage/cifilter/1437894-init) initializer, then use the the [outputImage](https://developer.apple.com/documentation/coreimage/cifilter/1438169-outputimage) property to access output. (See the colorFilter example in Listing 1-2.)
- Apply a filter without creating a [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) instance by using the [imageByApplyingFilter:withInputParameters:](https://developer.apple.com/documentation/coreimage/ciimage/1437589-applyingfilter) method to a [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) object. (See the bloomImage example in Listing 1-2.)
- For certain commonly used filter operations, such as cropping, clamping, and applying coordinate transforms, use other [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) instance methods listed in Creating an Image by Modifying an Existing Image. (See the croppedImage example in Listing 1-2.)

>

- 使用 [filterWithName:](https://developer.apple.com/documentation/coreimage/cifilter/1438255-filterwithname) 初始化程序创建 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 实例，使用 [setValue:forKey:](https://developer.apple.com/documentation/objectivec/nsobject/1415969-setvalue) 方法设置参数（包含 [kCIInputImageKey](https://developer.apple.com/documentation/coreimage/kciinputimagekey) 用于设置要处理的图像 ），并使用 [outputImage](https://developer.apple.com/documentation/coreimage/cifilter/1438169-outputimage) 属性访问输出图像。（参见见清单1-1。）
- 使用 [filterWithName:withInputParameters:](https://developer.apple.com/documentation/coreimage/cifilter/1437894-init) 初始化程序在一次调用中创建 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 实例并设置其参数（包括输入图像），然后使用 [outputImage](https://developer.apple.com/documentation/coreimage/cifilter/1438169-outputimage) 属性访问输出。（参见清单1-2中的 colorFilter 示例。）
- 通过将 [imageByApplyingFilter:withInputParameters:](https://developer.apple.com/documentation/coreimage/ciimage/1437589-applyingfilter) 方法用于 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 对象，直接应用滤镜而不创建 [CIFilter](https://developer.apple.com/documentation/coreimage/cifilter) 实例。（参见清单1-2中的 bloomImage 示例。）
- 对于某些常用的滤镜操作，例如裁剪和应用坐标变换，请使用《[通过修改现有图像创建图像](https://developer.apple.com/documentation/coreimage/ciimage/1437589-applyingfilter)》中列出的其他 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 实例方法。（参见清单1-2中的 croppedImage 示例。）

### 3.2 Using Special Filter Types for More Options - 使用特殊滤镜类型获得更多选项

Most of the built-in Core Image filters operate on a main input image (possibly with additional input images that affect processing) and create a single output image. But there are several additional types of that you can use to create interesting effects or combine with other filters to produce more complex workflows.

大多数内置 Core Image 滤镜都在主输入图像上操作（可能还有影响处理的附加输入图像）并创建单个输出图像。但是，您可以使用其他几种类型来创建有趣的效果，或者与其他滤镜结合使用以生成更复杂的工作流程。

- A `compositing (or blending) filters` combine two images according to a preset formula. For example:
	- The [CISourceInCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceInCompositing) filter combines images such that only the areas that are opaque in both input images are visible in the output image.
	- The [CIMultiplyBlendMode](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMultiplyBlendMode) filter multiplies pixel colors from both images, producing a darkened output image.
  
  For the complete list of compositing filters, query the CICategoryCompositeOperation category.

- `合成滤镜`（或`混合滤镜`）可以根据预设的公式组合两个图像。例如：
	- [CISourceInCompositing](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISourceInCompositing) 滤镜组合图像，使得仅在两个输入图像上都是不透明的区域才能在输出图像中可见。
	- [CIMultiplyBlendMode](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMultiplyBlendMode) 滤镜将两个图像上的像素颜色相乘，产生变暗的输出图像。 

  有关合成滤镜的完整列表，请查询 [CICategoryCompositeOperation](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW71) 分类。
  
> **Note:** You can arrange input images before compositing them by applying geometry adjustments to each. See the [CICategoryGeometryAdjustment](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW157) filter category or the [imageByApplyingTransform:](https://developer.apple.com/documentation/coreimage/ciimage/1438203-imagebyapplyingtransform) method.
> 
> **注意：**您可以在合成输入图像之前，通过对每个图像应用几何体调整来排列输入图像。请参阅 [CICategoryGeometryAdjustment](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW157) 滤镜类别或 [imageByApplyingTransform:](https://developer.apple.com/documentation/coreimage/ciimage/1438203-imagebyapplyingtransform) 方法。

- A `generator filters` take no input images. Instead, these filters use other input parameters to create a new image from scratch. Some generators produce output that can be useful on its own, and others can be combined in filter chains to produce more interesting images. Some examples from among the built-in Core Image filters include:
	- Filters like [CIQRCodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator) and [CICode128BarcodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator) generate barcode images that encode specified input data.
	- Filters like [CIConstantColorGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIConstantColorGenerator), [CICheckerboardGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICheckerboardGenerator), and [CILinearGradient](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILinearGradient) generate simple procedural images from specified colors. You can combine these with other filters for interesting effects—for example, the [CIRadialGradient](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIRadialGradient) filter can create a mask for use with the [CIMaskedVariableBlur](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMaskedVariableBlur) filter.
	- Filters like [CILenticularHaloGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILenticularHaloGenerator) and [CISunbeamsGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISunbeamsGenerator) create standalone visual effects—combine these with compositing filters to add special effects to an image.

  To find generator filters, query the [CICategoryGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW142) and [CICategoryGradient](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW166) categories.

- `生成器滤镜` 不需要任何输入图像。相反，这些滤镜使用其他输入参数从头开始创建新图像。某些生成器产生的输出图像可以单独使用，而另一些可以与其他滤镜组合在滤镜链中以产生更有趣的图像。内置 Core Image 滤镜中的一些示例包括：
	- [CIQRCodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator) 和 [CICode128BarcodeGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICode128BarcodeGenerator) 等滤镜对指定输入数据进行编码生成条形码图像。
	- [CIConstantColorGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIConstantColorGenerator)，[CICheckerboardGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICheckerboardGenerator) 和 [CILinearGradient](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILinearGradient) 等滤镜可以根据指定的颜色生成简单程序图像。您可以将这些与其他滤镜结合使用以获得有趣的效果 —— 例如，[CIRadialGradient](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIRadialGradient) 滤镜可以创建一个遮罩，以便与 [CIMaskedVariableBlur](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIMaskedVariableBlur) 滤镜一起使用。
	- [CILenticularHaloGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CILenticularHaloGenerator) 和 [CISunbeamsGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CISunbeamsGenerator) 等滤镜可以创建独立的视觉效果 —— 将这些滤镜与合成滤镜结合起来，为图像添加特殊效果。

  要找到生成器滤镜，请查询 [CICategoryGenerator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW142) 和 [CICategoryGradient](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW166) 类别。

- A `reduction filter` operates on an input image, but instead of creating an output image in the traditional sense, its output describes information about the input image. For example:
	- The [CIAreaMaximum](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAreaMaximum) filter outputs a single color value representing the brightest of all pixel colors in a specified area of an image.
	- The [CIAreaHistogram](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAreaHistogram) filter outputs information about the numbers of pixels for each intensity value in a specified area of an image.

  All Core Image filters must produce a [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) object as their output, so the information produced by a reduction filter is still an image. However, you usually don’t display these images—instead, you read color values from single-pixel or single-row images, or use them as input to other filters.

  For the complete list of reduction filters, query the [CICategoryReduction](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW184)  category.

- `缩减滤镜`在输入图像上操作，并不是在传统意义上创建输出图像，它的输出是描述有关输入图像的信息。例如：
	- [CIAreaMaximum](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAreaMaximum) 滤镜输出表示在图像的指定区域中的最亮的所有像素的颜色的单个颜色值。 
	- [CIAreaHistogram](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAreaHistogram) 滤镜输出关于在图像的指定区域中的每个强度值的像素的数量的信息。

  所有 Core Image 滤镜都必须生成一个 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) 对象作为输出，因此缩减滤镜产生的信息仍然是图像。但是，您通常不显示这些图像 —— 而是从单像素或单行图像中读取颜色值，或将其用于其他滤镜的输入。
  
  有关缩减滤镜的完整列表，请查询 [CICategoryReduction](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW184) 类别。

- A `transition filter` takes two input images and varies its output between them in response to an independent variable—typically, this variable is time, so you can use a transition filter to create an animation that starts with one image, ends on another, and progresses from one to the other using an interesting visual effect. Core Image provides several built-in transition filters, including:
	- The [CIDissolveTransition](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIDissolveTransition) filter produces a simple cross-dissolve, fading from one image to another.
	- The [CICopyMachineTransition](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICopyMachineTransition) filter simulates a photocopy machine, swiping a bar of bright light across one image to reveal another.

  For the complete list of transition filters, query the [CICategoryTransition](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW239) category.

- `过渡滤镜`采用了两个输入图像，并根据一个独立变量在它们之间改变其输出 —— 通常这个变量是时间，所以可以使用一个过渡滤镜来创建以一个图像开始，以另一个图像结束的动画，并且使用有趣的视觉效果执行从一个到另一个的过程。Core Image 提供了几个内置的过渡滤镜，包括：
	- [CIDissolveTransition](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIDissolveTransition) 滤镜产生一个简单的交叉叠，从一个图像褪色到另一个图像。
	- [CICopyMachineTransition](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CICopyMachineTransition) 滤镜模拟复印机，滑动明亮的光条从一个图像跨越到另一个图像。

  有关过渡图像的完整列表，请查询 [CICategoryTransition](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW239) 类别。

## 4 Integrating with Other Frameworks - 与其他框架集成

Core Image interoperates with several other technologies in iOS, macOS, and tvOS. Thanks to this tight integration, you can use Core Image to easily add visual effects to games, video, or images in your app’s user interface without needing to build complex rendering code. The following sections cover several of the common ways to use Core Image in an app and the conveniences system frameworks provide for each.

Core Image 可与 iOS，macOS 和 tvOS 中的其他几种技术进行互操作。由于这种紧密集成，您可以使用 Core Image 轻松地在应用程序的用户界面中为游戏，视频或图像添加视觉效果，而无需构建复杂的渲染代码。以下部分介绍了在应用程序中使用 Core Image 的几种常用方法，以及为每种方法提供的便利系统框架。

### 4.1 Processing Still Images in UIKit and AppKit - 在 UIKit 和 AppKit 中处理静止图像

UIKit and AppKit provide easy ways to add Core Image processing to still images, whether those images appear in your app’s UI or are part of its workflow. For example:

UIKit 和 AppKit 提供了简单的方法来向静态图像添加 Core Image 处理，无论这些图像是出现在应用程序的 UI 中还是其工作流程的一部分。例如：

- A travel app might present stock photography of destinations in a list, then apply filters to those images to create a subtle background for each destination’s detail page.
- A social app might apply filters to user avatar pictures to indicate mood for each post.
- A photography app might allow the user to customize images with filters upon capture, or offer a Photos app extension for adding effects to pictures in the user’s Photos library (see [Photo Editing](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Photos.html#//apple_ref/doc/uid/TP40014214-CH17) in [App Extension Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/index.html#//apple_ref/doc/uid/TP40014214)).

>

- 旅行应用可能会在列表中显示目的地的照片，然后对这些图像应用滤镜，以便为每个目的地的详细信息页面创建巧妙的背景。
- 社交应用可能会对用户头像图片应用滤镜以表示每个帖子的心情。
- 摄影应用可能会允许用户在拍摄定制具有滤镜的图像，或提供照片应用扩展以便为用户照片库中的图片添加效果（见《[应用程序扩展编程指南](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/index.html#//apple_ref/doc/uid/TP40014214)》中的《[照片编辑](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Photos.html#//apple_ref/doc/uid/TP40014214-CH17)》）。

> **Note:** Don’t use Core Image to create blur effects that are part of a user interface design (like those seen in the translucent sidebars, toolbars, and backgrounds of the macOS, iOS, and tvOS system interfaces). Instead, see the [NSVisualEffectView](https://developer.apple.com/documentation/appkit/nsvisualeffectview) (macOS) or [UIVisualEffectView](https://developer.apple.com/documentation/uikit/uivisualeffectview) (iOS/tvOS) classes, which automatically match the system appearance and provide efficient real-time rendering.
> 
> **注意：**请勿使用 Core Image 创建作为用户界面设计一部分的模糊效果（如同 macOS，iOS 和 tvOS 系统界面的半透明侧边栏，工具栏以及背景中所见到的那样）。相反，请参阅 [NSVisualEffectView](https://developer.apple.com/documentation/appkit/nsvisualeffectview)（macOS）或 [UIVisualEffectView](https://developer.apple.com/documentation/uikit/uivisualeffectview)（iOS / tvOS）类，它们自动匹配系统外观并提供高效的实时渲染。

In iOS and tvOS, you can apply Core Image filters anywhere you work with UIImage objects. Listing 1-3 shows a simple method for using filters with an image view.

在 iOS 和 tvOS 中，您可以在使用 UIImage 对象的任何位置应用 Core Image 滤镜。清单1-3显示了对图像视图使用滤镜的简单方法。

**Listing 1-3**  Applying a filter to an image view (iOS/tvOS) - **清单1-3** 对图像视图应用滤镜（iOS/tvOS）

```
class ViewController: UIViewController {
    let filter = CIFilter(name: "CISepiaTone",
                          withInputParameters: [kCIInputIntensityKey: 0.5])!
    @IBOutlet var imageView: UIImageView!
    
    func displayFilteredImage(image: UIImage) {
        // Create a Core Image image object for the input image.
        // 创建一个 Core Image 图像对象作为输入图像。
        let inputImage = CIImage(image: image)!
        // Set that image as the filter's input image parameter.
        // 将该图像设置为滤镜的输入图像参数。
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        // Get a UIImage representation of the filter's output and display it.
        // 获取滤镜输出的 UIImage 表述，并显示。
        imageView.image = UIImage(CIImage: filter.outputImage!)
    }
}
```

In macOS, use the [initWithBitmapImageRep:](https://developer.apple.com/documentation/coreimage/ciimage/1535335-init) method to create [CIImage](https://developer.apple.com/documentation/coreimage/ciimage) objects from bitmap images and the [NSCIImageRep](https://developer.apple.com/documentation/appkit/nsciimagerep) class to create images you can use anywhere [NSImage](https://developer.apple.com/documentation/appkit/nsimage) objects are supported.

在 macOS 中，使用 [initWithBitmapImageRep:](https://developer.apple.com/documentation/coreimage/ciimage/1535335-init)  方法从位图创建 [CIImage](https://developer.apple.com/documentation/coreimage/ciimage)  对象，并使用 [NSCIImageRep](https://developer.apple.com/documentation/appkit/nsciimagerep) 类创建可在任何支持 [NSImage](https://developer.apple.com/documentation/appkit/nsimage)  对象的地方使用的图像。

### 4.2 Processing Video with AV Foundation - 与 AV Foundation 一起处理视频

The AVFoundation framework provides a number of high level utilities for working with video and audio content. Among these is the [AVVideoComposition](https://developer.apple.com/documentation/avfoundation/avvideocomposition) class, which you can use to combine or edit video and audio tracks into a single presentation. (For general information on compositions, see [Editing](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/03_Editing.html#//apple_ref/doc/uid/TP40010188-CH8) in [AVFoundation Programming Guide](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40010188).) You can use an [AVVideoComposition](https://developer.apple.com/documentation/avfoundation/avvideocomposition) object to apply Core Image filters to each frame of a video during playback or export, as shown in Listing 1-4.

AVFoundation 框架提供了许多用于处理视频和音频内容的高级实用程序。其中包括 [AVVideoComposition](https://developer.apple.com/documentation/avfoundation/avvideocomposition) 类，您可以使用它将视频和音频轨道组合或编辑到单个演示文稿中。（有关合成的一般信息，请参阅《[AVFoundation编程指南](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40010188)》中的《[编辑](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/03_Editing.html#//apple_ref/doc/uid/TP40010188-CH8)》。）您可以使用 [AVVideoComposition](https://developer.apple.com/documentation/avfoundation/avvideocomposition) 对象在播放或导出期间将 Core Image 滤镜应用于视频的每个帧，如清单1-4所示。

**Listing 1-4**  Applying a filter to a video composition **清单1-4** 将滤镜应用于视频合成

```
let filter = CIFilter(name: "CIGaussianBlur")!
let composition = AVVideoComposition(asset: asset, applyingCIFiltersWithHandler: { request in
    
    // Clamp to avoid blurring transparent pixels at the image edges
    // 避免模糊图像边缘的透明像素
    let source = request.sourceImage.clampingToExtent()
    filter.setValue(source, forKey: kCIInputImageKey)
    
    // Vary filter parameters based on video timing
    // 根据视频的时间修改滤镜参数
    let seconds = CMTimeGetSeconds(request.compositionTime)
    filter.setValue(seconds * 10.0, forKey: kCIInputRadiusKey)
    
    // Crop the blurred output to the bounds of the original image
    // 将模糊处理的输出裁剪为原始图像大小
    let output = filter.outputImage!.cropping(to: request.sourceImage.extent)
    
    // Provide the filter output to the composition
    // 向合成提供滤镜输出
    request.finish(with: output, context: nil)
})
```

When you create a composition with the [videoCompositionWithAsset:applyingCIFiltersWithHandler:](https://developer.apple.com/documentation/avfoundation/avvideocomposition/1389556-init) initializer, you supply a handler that’s responsible for applying filters to each frame of video. AVFoundation automatically calls your handler during playback or export. In the handler, you use the provided [AVAsynchronousCIImageFilteringRequest](https://developer.apple.com/documentation/avfoundation/avasynchronousciimagefilteringrequest) object first to retrieve the video frame to be filtered (and supplementary information such as the frame time), then to provide the filtered image for use by the composition.

使用 [videoCompositionWithAsset:applyingCIFiltersWithHandler:](https://developer.apple.com/documentation/avfoundation/avvideocomposition/1389556-init) 初始化程序创建合成时，您要提供一个负责将滤镜应用于视频的每一帧的处理程序。AVFoundation 在播放或导出期间自动调用您的处理程序。在处理程序中，首先使用提供的 [AVAsynchronousCIImageFilteringRequest](https://developer.apple.com/documentation/avfoundation/avasynchronousciimagefilteringrequest) 对象来检索要使用滤镜的视频帧（以及补充信息，如帧时间），然后提供滤镜后的图像以供合成使用。

To use the created video composition for playback, create an [AVPlayerItem](https://developer.apple.com/documentation/avfoundation/avplayeritem) object from the same asset used as the composition’s source, then assign the composition to the player item’s [videoComposition](https://developer.apple.com/documentation/avfoundation/avplayeritem/1388818-videocomposition) property. To export the composition to a new movie file, create an [AVAssetExportSession](https://developer.apple.com/documentation/avfoundation/avassetexportsession) object from the same source asset, then assign the composition to the export session’s [videoComposition](https://developer.apple.com/documentation/avfoundation/avplayeritem/1388818-videocomposition) property.

要使用创建的视频合成进行播放，请使用与合成源相同的资源创建 [AVPlayerItem](https://developer.apple.com/documentation/avfoundation/avplayeritem) 对象，然后将合成分配给播放器项目的 [videoComposition](https://developer.apple.com/documentation/avfoundation/avplayeritem/1388818-videocomposition) 属性。要将合成导出到新的影片文件，请用同一份源资源创建 [AVAssetExportSession](https://developer.apple.com/documentation/avfoundation/avassetexportsession) 对象，然后将合成分配给导出会话的 [videoComposition](https://developer.apple.com/documentation/avfoundation/avplayeritem/1388818-videocomposition) 属性。

> **Tip:** Listing 1-4 also shows another useful Core Image technique. By default, a blur filter also softens the edges of an image by blurring image pixels together with the transparent pixels that (in the filter’s image processing space) surround the image. This effect can be undesirable in some circumstances, such as when filtering video.
>
> **提示：**清单1-4还展示另一种有用的 Core Image 技术。默认情况下，模糊滤镜也可以通过模糊图像像素以及（在滤镜的图像处理空间中）环绕图像的透明像素来柔化图像的边缘。这种效果在某些情况下可能是不需要的，例如对视频做滤镜时。
>
> To avoid this effect, use the [imageByClampingToExtent](https://developer.apple.com/documentation/coreimage/ciimage/1437628-clampedtoextent) method (or the [CIAffineClamp](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAffineClamp) filter) to extend the edge pixels of the image infinitely in all directions before blurring. Clamping creates an image of infinite size, so you should also crop the image after blurring.
> 
> 要避免此效果，请使用 [imageByClampingToExtent](https://developer.apple.com/documentation/coreimage/ciimage/1437628-clampedtoextent) 方法（或 [CIAffineClamp](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAffineClamp) 滤镜）在模糊之前在所有方向上无限延伸图像的边缘像素。Clamping 会创建无限大小的图像，因此您还应该在模糊后裁剪图像。

### 4.3 Processing Game Content with SpriteKit and SceneKit - 与 SpriteKit 和 SceneKit 一起处理游戏内容

SpriteKit is a technology for building 2D games and other types of apps that feature highly dynamic animated content; SceneKit is for working with 3D assets, rendering and animating 3D scenes, and building 3D games. (For more information on each technology, see [SpriteKit Programming Guide](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013043) and [SceneKit Framework Reference](https://developer.apple.com/documentation/scenekit).) Both frameworks provide high-performance real-time rendering, with easy ways to add Core Image processing to all or part of a scene.

SpriteKit 是一种用于构建 2D 游戏和其他类型具有高度动态动画内容的应用程序的技术；SceneKit 用于处理3D资源，渲染和动画 3D 场景以及构建 3D 游戏。（有关每种技术的更多信息，请参阅《[SpriteKit 编程指南](https://developer.apple.com/library/archive/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40013043)》和《[SceneKit 框架参考](https://developer.apple.com/documentation/scenekit)》。）两种框架都提供高性能的实时渲染，可以通过简单的方法将 Core Image 处理添加到场景的全部或部分。

In SpriteKit, you can add Core Image filters using the [SKEffectNode](https://developer.apple.com/documentation/spritekit/skeffectnode) class. To see an example of this class in use, create a new Xcode project using the Game template (for iOS or tvOS), select SpriteKit as the game technology, and modify the [touchesBegan:withEvent:](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan) method in the `GameScene` class to use the code in Listing 1-5. (For the macOS Game template, you can make similar modifications to the [mouseDown:](https://developer.apple.com/documentation/appkit/nsresponder/1524634-mousedown) method.)

在 SpriteKit 中，您可以使用 [SKEffectNode](https://developer.apple.com/documentation/spritekit/skeffectnode) 类添加 Core Image 滤镜。要查看正在使用的此类的示例，请使用 Game 模板（对于 iOS 或 tvOS）创建一个新的 Xcode 项目，选择 SpriteKit 作为游戏技术，并修改 `GameScene` 类中的 [touchesBegan:withEvent:](https://developer.apple.com/documentation/uikit/uiresponder/1621142-touchesbegan) 方法以使用清单1-5中的代码。（对于 macOS Game 模板，您可以对 [mouseDown:](https://developer.apple.com/documentation/appkit/nsresponder/1524634-mousedown) 方法进行类似的修改。）

**Listing 1-5**  Applying filters in SpriteKit - **清单1-5** 在 SpriteKit 中应用滤镜

```
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    for touch in touches {
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.setScale(0.5)
        sprite.position = touch.location(in: self)
        sprite.run(.repeatForever(.rotate(byAngle: 1, duration:1)))
        
        let effect = SKEffectNode()
        effect.addChild(sprite)
        effect.shouldEnableEffects = true
        effect.filter = CIFilter(name: "CIPixellate",
                                 withInputParameters: [kCIInputScaleKey: 20.0])
        
        self.addChild(effect)
    }
}
```

Note that the [SKScene](https://developer.apple.com/documentation/spritekit/skscene) class itself is a subclass of [SKEffectNode](https://developer.apple.com/documentation/spritekit/skeffectnode), so you can also apply a Core Image filter to an entire SpriteKit scene.

请注意，[SKScene](https://developer.apple.com/documentation/spritekit/skscene) 类本身是 [SKEffectNode](https://developer.apple.com/documentation/spritekit/skeffectnode) 子类，因此您也可以将 Core Image 滤镜应用于整个 SpriteKit 场景。

In SceneKit, the [filters](https://developer.apple.com/documentation/scenekit/scnnode/1407949-filters) property of the [SCNNode](https://developer.apple.com/documentation/scenekit/scnnode) class can apply Core Image filters to any element of a 3D scene. To see this property in action, create a new Xcode project using the Game template (for iOS, tvOS, or macOS), select SceneKit as the game technology, and modify the [viewDidLoad](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload) method in the `GameViewController` class to use the code in Listing 1-6.

在 SceneKit 中，[SCNNode](https://developer.apple.com/documentation/scenekit/scnnode) 类的 [filters](https://developer.apple.com/documentation/scenekit/scnnode/1407949-filters) 属性可以将 Core Image 滤镜应用于 3D 场景的任何元素。要查看此属性，请使用 Game 模板（对于iOS，tvOS或macOS）创建一个新的 Xcode 项目，选择 SceneKit 作为游戏技术，并修改 `GameViewController` 类中的 [viewDidLoad](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload) 方法以使用清单1-6中的代码。

**Listing 1-6**  Applying filters in SceneKit - **清单1-6** 在 SceneKit 中应用滤镜

```
// Find this line in the template code:
// 在模板代码中找到这一行
let ship = rootNode.childNode(withName: "ship", recursively: true)!
 
// Add these lines after it:
// 在它后面添加这些行
let pixellate = CIFilter(name: "CIPixellate",
                         withInputParameters: [kCIInputScaleKey: 20.0])!
ship.filters = [ pixellate ]
```

You can also animate filter parameters on a SceneKit node—for details, see the reference documentation for the [filters](https://developer.apple.com/documentation/scenekit/scnnode/1407949-filters) property.

您还可以在 SceneKit 节点上设置滤镜参数的动画 —— 有关详细信息，请参阅 [filters](https://developer.apple.com/documentation/scenekit/scnnode/1407949-filters) 属性的参考文档。

In both SpriteKit and SceneKit, you can use transitions to change a view’s scene with added visual flair. (See the [presentScene:transition:](https://developer.apple.com/documentation/spritekit/skview/1520090-presentscene) method for SpriteKit and the [presentScene:withTransition:incomingPointOfView:completionHandler:](https://developer.apple.com/documentation/scenekit/scnscenerenderer/1523028-presentscene) method for SceneKit.) Use the [SKTransition](https://developer.apple.com/documentation/spritekit/sktransition) class and its [transitionWithCIFilter:duration:](https://developer.apple.com/documentation/spritekit/sktransition/1395895-init) initializer to create a transition animation from any Core Image transition filter.

在 SpriteKit 和 SceneKit 中，您可以使用 transitions 在更改视图场景时增加视觉效果。（请参阅 SpriteKit 的[presentScene:transition:](https://developer.apple.com/documentation/spritekit/skview/1520090-presentscene) 方法和 SceneKit 的 [presentScene:withTransition:incomingPointOfView:completionHandler:](https://developer.apple.com/documentation/scenekit/scnscenerenderer/1523028-presentscene) 方法。）使用 [SKTransition](https://developer.apple.com/documentation/spritekit/sktransition) 类及其 [transitionWithCIFilter:duration:](https://developer.apple.com/documentation/spritekit/sktransition/1395895-init) 初始化程序从任何 Core Image 过渡滤镜创建过渡动画。

### 4.4 Processing Core Animation Layers (macOS) - 处理核心动画层（macOS）

In macOS, you can use the filters property to apply [filters](https://developer.apple.com/documentation/quartzcore/calayer/1410901-filters) to the contents of any CALayer-backed view, and add animations that vary filter parameters over time. See [Filters Add Visual Effects to OS X Views](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/SettingUpLayerObjects/SettingUpLayerObjects.html#//apple_ref/doc/uid/TP40004514-CH13-SW21) and [Advanced Animation Tricks](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AdvancedAnimationTricks/AdvancedAnimationTricks.html#//apple_ref/doc/uid/TP40004514-CH8) in [Core Animation Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004514).

在 macOS 中，你可以使用 [filters](https://developer.apple.com/documentation/quartzcore/calayer/1410901-filters) 属性将滤镜应用到任何 CALayer 视图的内容，并添加随时间改变滤镜参数的动画。参见《[核心动画编程指南](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004514)》中的《[滤镜为 OS X 视图添加视觉效果](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/SettingUpLayerObjects/SettingUpLayerObjects.html#//apple_ref/doc/uid/TP40004514-CH13-SW21)》和《[高级动画技巧](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AdvancedAnimationTricks/AdvancedAnimationTricks.html#//apple_ref/doc/uid/TP40004514-CH8)》。

## 5 Building Your Own Workflow with a Core Image Context - 使用 Core Image 上下文构建您自己的工作流



### 5.1 Rendering with an Automatic Context - 使用自动上下文进行渲染




### 5.2 Real-Time Rendering with Metal - 使用 Metal 进行实时渲染



### 5.3 Real-Time Rendering with OpenGL or OpenGL ES - 使用 OpenGL 或 OpenGL ES 进行实时渲染



### 5.4 CPU-Based Rendering with Quartz 2D - 使用 Quartz 2D 进行基于 CPU 的渲染