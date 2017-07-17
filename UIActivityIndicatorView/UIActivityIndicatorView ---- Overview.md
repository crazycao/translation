# UIActivityIndicatorView

原文地址：
[https://developer.apple.com/documentation/uikit/uiactivityindicatorview?language=objc](https://developer.apple.com/documentation/uikit/uiactivityindicatorview?language=objc)

>__Framework__
>
> UIKit
>
>__SDKs__
>
>iOS 2.0+ | tvOS 9.0+ 

# UIActivityIndicatorView 活动指示器视图

A view that shows that a task is in progress.

一个展示有一个任务正在进行中的视图。

# Overview 概述

You control when an activity indicator animates by calling the [startAnimating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622835-startanimating?language=objc) and [stopAnimating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622842-stopanimating?language=objc) methods. To automatically hide the activity indicator when animation stops, set the [hidesWhenStopped](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622837-hideswhenstopped?language=objc) property to YES.

你通过调用 [startAnimating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622835-startanimating?language=objc) 和 [stopAnimating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622842-stopanimating?language=objc) 方法来控制活动指示器何时显示动画。要再动画停止时自动将活动指示器隐藏，请将 [hidesWhenStopped](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622837-hideswhenstopped?language=objc) 属性设置成 YES 。

You can set the color of the activity indicator by using the [color](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622836-color?language=objc) property.

你可以通过使用 [color](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622836-color?language=objc) 属性来设置活动指示器的颜色。

# Topics 主题

## Initializing an Activity Indicator 初始化一个活动指示器

### [- initWithActivityIndicatorStyle:](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622840-initwithactivityindicatorstyle?language=objc)

Initializes and returns an activity-indicator object.

初始化并返回一个活动指示器对象。

### [- initWithFrame:](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622841-initwithframe?language=objc)

### [- initWithCoder:](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622844-initwithcoder?language=objc)

## Managing an Activity Indicator 管理一个活动指示器

### [- startAnimating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622835-startanimating?language=objc)

Starts the animation of the progress indicator.

开始过程指示器的动画。

### [- stopAnimating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622842-stopanimating?language=objc)

Stops the animation of the progress indicator.

停止过程指示器的动画。

### [animating](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/2097554-animating?language=objc)

A Boolean value indicating whether the activity indicator is currently running its animation.

指出活动指示器当前是否正在运行其动画的布尔值。

### [hidesWhenStopped](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622837-hideswhenstopped?language=objc)

A Boolean value that controls whether the receiver is hidden when the animation is stopped.

控制接收者是否在动画停止时就隐藏的布尔值。

## Configuring the Activity Indicator Appearance 配置活动指示器的外观

### [activityIndicatorViewStyle](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622847-activityindicatorviewstyle?language=objc)

The basic appearance of the activity indicator.

活动指示器的基本外观。

### [color](https://developer.apple.com/documentation/uikit/uiactivityindicatorview/1622836-color?language=objc)

The color of the activity indicator.

活动指示器的颜色。

## Constants 常量

### [UIActivityIndicatorViewStyle](https://developer.apple.com/documentation/uikit/uiactivityindicatorviewstyle?language=objc)

The visual style of the progress indicator.

过程指示器的可见样式。

# Relationships 关系

## Inherits From
[UIView](https://developer.apple.com/documentation/uikit/uiview?language=objc)

## Conforms To
[NSCoding](https://developer.apple.com/documentation/foundation/nscoding?language=objc)

# See Also 其它参考

## Content Views 内容视图

### [UIImageView](https://developer.apple.com/documentation/uikit/uiimageview?language=objc)

An object that displays a single image or a sequence of animated images in your interface.

在你的界面显示单个图像或一系列带动画的图像的对象。

### [UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview?language=objc)

A view that uses a spinning-wheel or slot-machine metaphor to show one or more sets of values.

使用一个滚轮或类似老虎机的东西展示一组或多组值的视图。

### [UIProgressView](https://developer.apple.com/documentation/uikit/uiprogressview?language=objc)

A view that depicts the progress of a task over time.

描绘一个耗时任务的进度的视图。

### [UIWebView](https://developer.apple.com/documentation/uikit/uiwebview?language=objc)

A view that embeds web content in your app.

在你的App中嵌入web内容的视图。
