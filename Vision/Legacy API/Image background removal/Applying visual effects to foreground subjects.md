# Applying visual effects to foreground subjects 为前景主体应用视觉效果

原文地址：[https://developer.apple.com/documentation/vision/applying-visual-effects-to-foreground-subjects](https://developer.apple.com/documentation/vision/applying-visual-effects-to-foreground-subjects)

Segment the foreground subjects of an image and composite them to a new background with visual effects.

对图像的前景主体进行分割，并将其与具有视觉效果的新背景进行合成。

[Download 下载](https://docs-assets.developer.apple.com/published/870d284c2b71/ApplyingVisualEffectsToForegroundSubjects.zip)

> iOS 17.0+ | iPadOS 17.0+ | Xcode 15.0+

## Overview 概览

> **Note** **说明**
>
> This sample code project is associated with WWDC23 session 10176: Lift subjects from images in your app.
> 
> 此示例代码项目与 WWDC23（苹果全球开发者大会 2023）第 10176 场会议《在应用中提取图像主体》相关。

## Configure the sample code project 配置示例代码项目

Before you run the sample code project in Xcode, set the run destination to an iOS 17 device.

在 Xcode 中运行此示例代码项目前，请将运行目标设备设置为搭载 iOS 17 的设备。

# See Also

## Image background removal 图像背景移除

### class [VNInstanceMaskObservation](https://developer.apple.com/documentation/vision/vninstancemaskobservation)

An observation that contains an instance mask that labels instances in the mask.

包含实例掩码的观察结果，该掩码用于标记掩码中的实例。

### class [VNGenerateForegroundInstanceMaskRequest](https://developer.apple.com/documentation/vision/vngenerateforegroundinstancemaskrequest)

A request that generates an instance mask of noticable objects to separate from the background.

一种请求，用于生成可从背景中分离的显著对象的实例掩码。

### let [VNGenerateForegroundInstanceMaskRequestRevision1](https://developer.apple.com/documentation/vision/vngenerateforegroundinstancemaskrequestrevision1): Int
A constant for specifying the first revision of the foreground instance mask request.

用于指定前景实例掩码请求第一个版本的常量。
