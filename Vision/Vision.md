# Vision 视觉

原文地址：[https://developer.apple.com/documentation/vision](https://developer.apple.com/documentation/vision)

Apply computer vision algorithms to perform a variety of tasks on input images and videos.

应用计算机视觉算法对输入的图像和视频执行各种任务。

> iOS 11.0+
iPadOS 11.0+
Mac Catalyst 13.0+
macOS 10.13+
tvOS 11.0+
visionOS 1.0+

# Overview 概览

The Vision framework combines machine learning technologies and Swift’s concurrency features to perform computer vision tasks in your app. Use the Vision framework to analyze images for a variety of purposes:

Vision 框架结合了机器学习技术和 Swift 的并发特性，以便在你的应用中执行计算机视觉任务。使用 Vision 框架可出于多种目的对图像进行分析：

- Tracking human and animal body poses or the trajectory of an object
- Recognizing text in 18 different languages
- Detecting faces and face landmarks, such as eyes, nose, and mouth
- Performing hand tracking to enable new device interactions
- Calculating an aesthetics score to determine how memorable a photo is

- 跟踪人类和动物的身体姿势，或者某个物体的运动轨迹
- 识别 18 种不同语言的文本
- 检测人脸以及人脸的特征点，如眼睛、鼻子和嘴巴
- 执行手部跟踪，从而实现新的设备交互方式
- 计算美学分数，以判断一张照片的令人印象深刻程度

![An illustration showing a dog, and a magnifying glass depicting the dog being analyzed.一张展示一只狗的插图，以及一个描绘正在分析这只狗的放大镜。](https://docs-assets.developer.apple.com/published/c745ff2988bec9749a8ba2313d77598e/vision-framework@2x.png)

To begin using the framework, you create a request for the type of analysis you want to do. Each request conforms to the [VisionRequest](https://developer.apple.com/documentation/vision/visionrequest) protocol. You then perform the request to get an observation object — or an array of observations — with the analysis details for the request. There are more than 25 requests available to choose from. Vision also allows the use of custom Core ML models for tasks like classification or object detection.

若要开始使用该框架，你需要针对你想要进行的分析类型创建一个请求。每个请求都遵循 [VisionRequest](https://developer.apple.com/documentation/vision/visionrequest) 协议。然后，你执行该请求，以获取一个观察对象（或者一组观察对象），其中包含该请求的分析细节。有超过 25 种请求可供选择。Vision 还允许使用自定义的 Core ML 模型来完成分类或目标检测等任务。

> **Note** **注意**
>
> Starting in iOS 18.0, the Vision framework provides a new Swift-only API. See [Original Objective-C and Swift API](https://developer.apple.com/documentation/vision/original-objective-c-and-swift-api) to view the original API.
> 
> 从 iOS 18.0 开始，Vision 框架提供了仅适用于 Swift 的新 API。请参阅《[原始的 Objective-C 和 Swift API](https://developer.apple.com/documentation/vision/original-objective-c-and-swift-api)》以查看原始 API。

# Topics 主题

## Still-image analysis 静态图像分析

### [Classifying images for categorization and search](https://developer.apple.com/documentation/vision/classifying-images-for-categorization-and-search) 对图像进行分类以便归类和搜索

Analyze and label images using a Vision classification request.

使用 Vision 分类请求来分析和标记图像。

### struct [ClassifyImageRequest](https://developer.apple.com/documentation/vision/classifyimagerequest)

A request to classify an image.

用于对图像进行分类的请求。

### protocol [ImageProcessingRequest](https://developer.apple.com/documentation/vision/imageprocessingrequest)

A type for image-analysis requests that focus on a specific part of an image.

一种专注于图像特定部分的图像分析请求类型。

### class [ImageRequestHandler](https://developer.apple.com/documentation/vision/imagerequesthandler)

An object that processes one or more image-analysis requests pertaining to a single image.

处理与单个图像相关的一个或多个图像分析请求的对象。

### protocol VisionRequest

A type for image-analysis requests.

一种图像分析请求类型。

### protocol VisionObservation

A type for objects produced by image-analysis requests.

由图像分析请求生成的对象类型。

## Image sequence analysis 图像序列分析

### class [GeneratePersonSegmentationRequest](https://developer.apple.com/documentation/vision/generatepersonsegmentationrequest)

A request that produces a matte image for a person it finds in the input image.

一种请求，在输入图像中找到的人物，并生成遮罩图像。

### struct [GeneratePersonInstanceMaskRequest](https://developer.apple.com/documentation/vision/generatepersoninstancemaskrequest)

A request that produces a mask of individual people it finds in the input image.

一种请求，在输入图像中找到的单个人物，并生成遮罩。

### struct [DetectDocumentSegmentationRequest](https://developer.apple.com/documentation/vision/detectdocumentsegmentationrequest)

A request that detects rectangular regions that contain text in the input image.

一种请求，检测输入图像中包含文本所在的矩形区域。

### protocol [StatefulRequest](https://developer.apple.com/documentation/vision/statefulrequest）

The protocol for a type that builds evidence of a condition over time.

一种类型的协议，该类型会随着时间推移构建某种条件的证据。

## Image aesthetics analysis 图像美学分析

### [Generating high-quality thumbnails from videos](https://developer.apple.com/documentation/vision/generating-thumbnails-from-videos) 从视频中生成高质量缩略图

Identify the most visually pleasing frames in a video by using the image-aesthetics scores request.

通过使用图像美学分数请求，识别视频中视觉上最令人愉悦的帧。

### struct [CalculateImageAestheticsScoresRequest](https://developer.apple.com/documentation/vision/calculateimageaestheticsscoresrequest)

A request that analyzes an image for aesthetically pleasing attributes.

一种请求，可分析图像中令人愉悦的美学属性。

## Saliency analysis 显著性分析

### struct [GenerateAttentionBasedSaliencyImageRequest](https://developer.apple.com/documentation/vision/generateattentionbasedsaliencyimagerequest) 基于注意力的显著性图像生成请求

An object that produces a heat map that identifies the parts of an image most likely to draw attention.

一个生成热图的对象，该热图可识别图像中最有可能吸引注意力的部分。

### struct [GenerateObjectnessBasedSaliencyImageRequest](https://developer.apple.com/documentation/vision/generateobjectnessbasedsaliencyimagerequest) 基于对象推测的显著性图像生成请求

A request that generates a heat map that identifies the parts of an image most likely to represent objects.

一种请求，可生成热图，以识别图像中最有可能代表物体的部分。

## Object tracking 对象跟踪

### class [TrackObjectRequest](https://developer.apple.com/documentation/vision/trackobjectrequest)

An image-analysis request that tracks the movement of a previously identified object across multiple images or video frames.

一种图像分析请求，可在多个图像或视频帧中跟踪先前已识别目标的移动。

### class [TrackRectangleRequest](https://developer.apple.com/documentation/vision/trackrectanglerequest)

An image-analysis request that tracks movement of a previously identified rectangular object across multiple images or video frames.

一种图像分析请求，可在多个图像或视频帧中跟踪先前已识别矩形目标的移动。

## Face and body detection 人脸和身体检测

### [Analyzing a selfie and visualizing its content](https://developer.apple.com/documentation/vision/analyzing-a-selfie-and-visualizing-its-content) 分析自拍照并可视化其内容

Calculate face-capture quality and visualize facial features for a collection of images using the Vision framework.

使用 Vision 框架为一组图像计算人脸拍摄质量并可视化面部特征。

### struct [DetectFaceRectanglesRequest](https://developer.apple.com/documentation/vision/detectfacerectanglesrequest)

A request that finds faces within an image.

一种在图像中查找人脸的请求。

### struct [DetectFaceLandmarksRequest](https://developer.apple.com/documentation/vision/detectfacelandmarksrequest)

An image-analysis request that finds facial features like eyes and mouth in an image.

一种图像分析请求，可在图像中查找眼睛和嘴巴等面部特征。

### struct [DetectFaceCaptureQualityRequest](https://developer.apple.com/documentation/vision/detectfacecapturequalityrequest)

A request that produces a floating-point number that represents the capture quality of a face in a photo.

一种请求，可生成一个浮点数，代表照片中人脸的拍摄质量。

### struct [DetectHumanRectanglesRequest](https://developer.apple.com/documentation/vision/detecthumanrectanglesrequest)

A request that finds rectangular regions that contain people in an image.

在图像中查找包含人物的矩形区域的请求。

## Body and hand pose detection 身体和手部姿势检测

### struct [DetectHumanBodyPoseRequest](https://developer.apple.com/documentation/vision/detecthumanbodyposerequest)

A request that detects a human body pose.

检测人体姿势的请求。

### struct [DetectHumanHandPoseRequest](https://developer.apple.com/documentation/vision/detecthumanhandposerequest)

A request that detects a human hand pose.

检测人手姿势的请求。

### protocol [PoseProviding](https://developer.apple.com/documentation/vision/poseproviding)

An observation that provides a collection of joints that make up a pose.

一种观察结果，提供构成某种姿势的关节集合。

### enum [Chirality](https://developer.apple.com/documentation/vision/chirality)

The hand sidedness of a pose.

姿势中手的左右属性。

### struct [Joint](https://developer.apple.com/documentation/vision/joint)

A pose joint represented as a normalized point in an image, along with a label and a confidence value.

一种姿势关节，在图像中表示为归一化的点，同时包含一个标签和一个置信度值。

## 3D body pose detection 3D 身体姿势检测

### class [DetectHumanBodyPose3DRequest](https://developer.apple.com/documentation/vision/detecthumanbodypose3drequest)

A request that detects points on human bodies in 3D space, relative to the camera.

一种请求，可检测相对于相机在 3D 空间中人体上的点。

### struct [Joint3D](https://developer.apple.com/documentation/vision/joint3d)

An object that represents a body pose joint in 3D space.

一个在 3D 空间中表示身体姿势关节的对象。

## Text detection 文本检测

### [Locating and displaying recognized text](https://developer.apple.com/documentation/vision/locating-and-displaying-recognized-text) 定位并显示识别出的文本

Perform text recognition on a photo using the Vision framework’s text-recognition request.

使用 Vision 框架的文本识别请求对照片执行文本识别。

### struct [DetectTextRectanglesRequest](https://developer.apple.com/documentation/vision/detecttextrectanglesrequest)

An image-analysis request that finds regions of visible text in an image.

一种图像分析请求，可在图像中查找可见文本区域。

### struct [RecognizeTextRequest](https://developer.apple.com/documentation/vision/recognizetextrequest)

An image-analysis request that recognizes text in an image.

一种图像分析请求，可识别图像中的文本。

## Barcode detection 条形码检测

### struct [DetectBarcodesRequest](https://developer.apple.com/documentation/vision/detectbarcodesrequest)

A request that detects barcodes in an image.

一种在图像中检测条形码的请求。

## Trajectory, contour, and horizon detection 轨迹、轮廓和地平线检测

### class [DetectTrajectoriesRequest](https://developer.apple.com/documentation/vision/detecttrajectoriesrequest)

A request that detects the trajectories of shapes moving along a parabolic path.

检测沿抛物线路径移动的形状的轨迹的请求。

### struct [DetectContoursRequest](https://developer.apple.com/documentation/vision/detectcontoursrequest)

A request that detects the contours of the edges of an image.

检测图像边缘轮廓的请求。

### struct [DetectHorizonRequest](https://developer.apple.com/documentation/vision/detecthorizonrequest)

An image-analysis request that determines the horizon angle in an image.

确定图像中的地平线角度的图像分析请求。

## Animal detection 动物检测

### struct [DetectAnimalBodyPoseRequest](https://developer.apple.com/documentation/vision/detectanimalbodyposerequest)

A request that detects an animal body pose.

检测动物身体姿势的请求。

### struct [RecognizeAnimalsRequest](https://developer.apple.com/documentation/vision/recognizeanimalsrequest)

A request that recognizes animals in an image.

在图像中识别动物的请求。

## Optical flow and rectangle detection 光流和矩形检测

### class [TrackOpticalFlowRequest](https://developer.apple.com/documentation/vision/trackopticalflowrequest)

A request that determines the direction change of vectors for each pixel from a previous to current image.

一种请求，可确定从先前图像到当前图像中每个像素的向量方向变化。

### struct [DetectRectanglesRequest](https://developer.apple.com/documentation/vision/detectrectanglesrequest)

An image-analysis request that finds projected rectangular regions in an image.

一种图像分析请求，可在图像中查找投影的矩形区域。

## Image alignment 图像对齐

### class [TrackTranslationalImageRegistrationRequest](https://developer.apple.com/documentation/vision/tracktranslationalimageregistrationrequest) 追踪平移变换的图像配准请求

An image-analysis request that you track over time to determine the affine transform necessary to align the content of two images.

一种图像分析请求，可随时间进行跟踪，以确定对齐两张图像内容所需的仿射变换。

### class [TrackHomographicImageRegistrationRequest](https://developer.apple.com/documentation/vision/trackhomographicimageregistrationrequest) 追踪单应变换的图像配准请求

An image-analysis request that you track over time to determine the perspective warp matrix necessary to align the content of two images.

一种图像分析请求，可随时间进行跟踪，以确定对齐两张图像内容所需的透视变换矩阵。

### protocol [TargetedRequest](https://developer.apple.com/documentation/vision/targetedrequest)

A type for analyzing two images together.

一种用于一起分析两张图像的类型。

## Image feature print and background removal 图像特征指纹和背景去除

### struct [GenerateImageFeaturePrintRequest](https://developer.apple.com/documentation/vision/generateimagefeatureprintrequest)

An image-based request to generate feature prints from an image.

一种基于图像的请求，用于从图像生成特征指纹。

### struct [GenerateForegroundInstanceMaskRequest](https://developer.apple.com/documentation/vision/generateforegroundinstancemaskrequest)

A request that generates an instance mask of noticeable objects to separate from the background.

一种请求，可生成显著物体的实例遮罩，以便与背景分离。

## Machine learning image analysis 机器学习图像分析

### struct [CoreMLRequest](https://developer.apple.com/documentation/vision/coremlrequest)

An image-analysis request that uses a Core ML model to process images.

一种图像分析请求，使用 Core ML 模型来处理图像。

### struct [CoreMLFeatureValueObservation](https://developer.apple.com/documentation/vision/coremlfeaturevalueobservation)

An object that represents a collection of key-value information that a Core ML image-analysis request produces.

一个对象，代表 Core ML 图像分析请求生成的一组键值信息。

### struct [ClassificationObservation](https://developer.apple.com/documentation/vision/classificationobservation)

An object that represents classification information that an image-analysis request produces.

一个对象，代表图像分析请求生成的分类信息。

### struct [PixelBufferObservation](https://developer.apple.com/documentation/vision/pixelbufferobservation)

An object that represents an image that an image-analysis request produces.

代表图像分析请求生成的图像的对象。

## Coordinate conversion 坐标转换

### struct [NormalizedPoint](https://developer.apple.com/documentation/vision/normalizedpoint)

A point in a 2D coordinate system.

二维坐标系中的一个点。

### struct [NormalizedRect](https://developer.apple.com/documentation/vision/normalizedrect)

The location and dimensions of a rectangle.

矩形的位置和尺寸。

### struct [NormalizedCircle](https://developer.apple.com/documentation/vision/normalizedcircle)

The center point and radius of a 2D circle.

二维圆的中心点和半径。

### enum [CoordinateOrigin](https://developer.apple.com/documentation/vision/coordinateorigin)

The origin of a coordinate system relative to an image.

相对于图像的坐标系原点。

## Request Handlers 请求处理程序

### class [ImageRequestHandler](https://developer.apple.com/documentation/vision/imagerequesthandler)

An object that processes one or more image-analysis requests pertaining to a single image.

处理与单个图像相关的一个或多个图像分析请求的对象。

### class [TargetedImageRequestHandler](https://developer.apple.com/documentation/vision/targetedimagerequesthandler)

An object that performs image-analysis requests on two images.

对两张图像执行图像分析请求的对象。

## Utilities 实用工具

### enum [ComputeStage](https://developer.apple.com/documentation/vision/computestage)

Types that represent the compute stage.

表示计算阶段的类型。

### class [VideoProcessor](https://developer.apple.com/documentation/vision/videoprocessor)

An object that performs offline analysis of video content.

对视频内容执行离线分析的对象。

## Errors 错误

### enum [VisionError](https://developer.apple.com/documentation/vision/visionerror)

The errors that the framework produces.

由该框架生成的错误。

## Legacy API 旧版 API

### [Original Objective-C and Swift API](https://developer.apple.com/documentation/vision/original-objective-c-and-swift-api)

## Structures 结构体

### struct [ImageCoordinateConversionHelpers](https://developer.apple.com/documentation/vision/imagecoordinateconversionhelpers)

### struct [ImagePixelDimensions](https://developer.apple.com/documentation/vision/imagepixeldimensions)

### struct [ResourceVersion](https://developer.apple.com/documentation/vision/resourceversion)

### struct [VNVideoProcessingOption](https://developer.apple.com/documentation/vision/vnvideoprocessingoption)【Deprecated】

Options to pass to the video processor when adding requests.

在添加请求时传递给视频处理器的选项。

## Type Aliases 类型别名

### typealias [DetectorKey](https://developer.apple.com/documentation/vision/detectorkey)

### typealias [NamedMultipleObjectDataAccessBlock](https://developer.apple.com/documentation/vision/namedmultipleobjectdataaccessblock)

### typealias [NamedObjectDataAccessBlock](https://developer.apple.com/documentation/vision/namedobjectdataaccessblock)

### typealias [NamedObjectsDictionary](https://developer.apple.com/documentation/vision/namedobjectsdictionary)