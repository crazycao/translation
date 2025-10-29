# AppKit

原文地址：[https://developer.apple.com/documentation/appkit/](https://developer.apple.com/documentation/appkit/)

Construct and manage a graphical, event-driven user interface for your macOS app.

为您的 macOS 应用程序构建和管理图形化、事件驱动的用户界面。

> macOS 10.0+
Mac Catalyst 13.0+

# Overview - 概览

AppKit contains the objects you need to build the user interface for a macOS app. In addition to drawing windows, buttons, panels, and text fields, it handles all the event management and interaction between your app, people, and macOS.

AppKit 包含构建 macOS 应用程序用户界面所需的对象。除了绘制窗口、按钮、面板和文本字段外，它还处理应用程序、用户和 macOS 之间的所有事件管理和交互。

![An image of a MacBook Pro showing Calendar, Maps, and the Dock on the screen.](https://docs-assets.developer.apple.com/published/005975c6a3/rendered2x-1683133099.png)

Aside from drawing and managing interactions, AppKit handles printing, animating, as well as creating documents with large amounts of data efficiently. The framework also contains built-in support for localization and accessibility to ensure that your app reaches as many people as possible.

除了绘制和管理交互，AppKit 还处理打印、动画以及高效创建包含大量数据的文档。该框架还包含内置的本地化和辅助功能支持，以确保您的应用程序能够触达尽可能多的人群。

AppKit also works with SwiftUI, so you can implement parts of your AppKit app in SwiftUI or mix interface elements between the two frameworks. For example, you can place AppKit views and view controllers inside SwiftUI views, and vice versa.

AppKit 也与 SwiftUI 协同工作，因此您可以在 SwiftUI 中实现 AppKit 应用程序的部分功能，或在两个框架之间混合界面元素。例如，您可以将 AppKit 视图和视图控制器放置在 SwiftUI 视图中，反之亦然。

> **Note** **注意**
>
> For information about bringing your iPad app to Mac, see [Mac Catalyst](https://developer.apple.com/documentation/uikit/mac_catalyst). To build an iOS app, you can use SwiftUI to create an app that works across all of Apple’s platforms, or use UIKit to create an app for iOS only.
> 
> 有关将 iPad 应用程序移植到 Mac 的信息，请参阅 [Mac Catalyst](https://developer.apple.com/documentation/uikit/mac_catalyst)。要构建 iOS 应用程序，您可以使用 SwiftUI 创建一个可在所有 Apple 平台上运行的应用程序，或者使用 UIKit 仅为 iOS 创建应用程序。

# Topics - 主题

## Essentials - 基础要素

### Adopting Liquid Glass - 采用液态玻璃（Liquid Glass）

Find out how to bring the new material to your app.

了解如何将这种新材料应用到你的应用中。

### AppKit updates - AppKit 更新

Learn about important changes to AppKit.

了解 AppKit 的重要变更。

### Protecting the User’s Privacy - 保护用户隐私

Secure personal data, and respect user preferences for how data is used.

保障个人数据安全，并尊重用户对数据使用方式的偏好。

### Porting your macOS apps to Apple silicon - 将 macOS 应用移植到 Apple 芯片

Create a version of your macOS app that runs on both Apple silicon and Intel-based Mac computers.

创建可在 Apple 芯片和基于 Intel 的 Mac 电脑上运行的 macOS 应用版本。

## App Structure - 应用结构

### App and Environment - 应用与环境

Learn about the objects that you use to interact with the system.

了解用于与系统交互的对象。

### Documents, Data, and Pasteboard - 文档、数据与剪贴板

Organize your app’s data and preferences, and share that data on the pasteboard or in iCloud.

组织应用的数据和偏好设置，并在剪贴板或 iCloud 中共享这些数据。

### Cocoa Bindings - Cocoa 绑定

Automatically synchronize your data model with your app’s interface using Cocoa Bindings.

使用 Cocoa 绑定自动同步数据模型与应用界面。

### Resource Management - 资源管理

Manage the storyboards and nib files containing your app’s user interface, and learn how to load data that is stored in resource files.

管理包含应用用户界面的故事板和 nib 文件，了解如何加载存储在资源文件中的数据。

### App Extensions - 应用扩展

Extend your app’s basic functionality to other parts of the system.

将应用的基本功能扩展到系统的其他部分。

### User Interface - 用户界面

Your app’s user interface provides visual, audible, and tactile feedback to the user about what your app is doing.

应用的用户界面通过视觉、听觉和触觉反馈，向用户传达应用的运行状态。

### Views and Controls - 视图与控件

Present your content onscreen and handle user input and events.

在屏幕上呈现内容，并处理用户输入和事件。

### View Management - 视图管理

Manage your user interface, including the size and position of views in a window.

管理用户界面，包括窗口中视图的大小和位置。

### View Layout -  视图布局

Position and size views using a stack view or Auto Layout constraints.

使用栈视图或自动布局约束来定位和调整视图大小。

### Appearance Customization - 外观定制

Add Dark Mode support to your app, and use appearance proxies to modify your UI.

为应用添加深色模式支持，并使用外观代理修改用户界面。

### Animation - 动画

Animate your views and other content to create a more engaging experience for users.

为视图和其他内容添加动画，为用户创造更具吸引力的体验。

### Windows, Panels, and Screens - 窗口、面板与屏幕

Organize your view hierarchies and facilitate their display onscreen.

组织视图层级，并便于它们在屏幕上显示。

### Sound, Speech, and Haptics - 声音、语音与触觉反馈

Play sounds and haptic feedback, and incorporate speech recognition and synthesis into your interface.

播放声音和触觉反馈，将语音识别和合成整合到界面中。

### Supporting Continuity Camera in Your Mac App - 在 Mac 应用中支持 Continuity Camera

Incorporate scanned documents and pictures from a user’s iPhone, iPad, or iPod touch into your Mac app using Continuity Camera.

通过 Continuity Camera 将用户的 iPhone、iPad 或 iPod touch 上的扫描文档和图片整合到 Mac 应用中。

## User Interactions - 用户交互

### Mouse, Keyboard, and Trackpad - 鼠标、键盘与触控板

Handle events related to mouse, keyboard, and trackpad input. 

处理与鼠标、键盘和触控板输入相关的事件。

### Menus, Cursors, and the Dock - 菜单、光标与程序坞

Implement menus and cursors to facilitate interactions with your app, and use your app’s Dock tile to convey updated information.

实现菜单和光标以方便与应用交互，并使用应用的程序坞图标传达更新信息。

### Gestures - 手势

Encapsulate your app’s event-handling logic in gesture recognizers so that you can reuse that code throughout your app.

将应用的事件处理逻辑封装在手势识别器中，以便在整个应用中重用该代码。

### Touch Bar - 触控栏

Display interactive content and controls in the Touch Bar.

在触控栏中显示交互式内容和控件。

### Drag and Drop - 拖放

Support the direct manipulation of your app’s content using drag and drop.

支持通过拖放直接操作应用内容。

### Accessibility for AppKit - AppKit 的无障碍功能

Make your AppKit apps accessible to everyone who uses macOS.

让你的 AppKit 应用对所有 macOS 用户都具有可访问性。

## Graphics, Drawing, Color, and Printing - 图形、绘图、颜色与打印

### Images and PDF - 图像与 PDF

Create and manage images, in bitmap, PDF, and other formats.

创建和管理位图、PDF 及其他格式的图像。

### Drawing - 绘图

Draw shapes, images, and other content on the screen.

在屏幕上绘制形状、图像和其他内容。

### Color - 颜色

Represent colors using built-in or custom formats, and give users options for selecting and applying colors.

使用内置或自定义格式表示颜色，并为用户提供选择和应用颜色的选项。

### Printing - 打印

Display the system print panels and manage the printing process.

显示系统打印面板并管理打印过程。

## Text - 文本

### Text Display - 文本显示

Display text and check spelling.

显示文本和检查拼写。

### TextKit

Manage text storage and perform custom layout of text-based content in your app’s views.

管理文本存储，并在应用视图中对基于文本的内容执行自定义布局。

### Fonts - 字体

Manage the fonts used to display text.

管理用于显示文本的字体。

### Writing Tools - 写作工具

Add support for Writing Tools to your app’s text views.

为应用的文本视图添加对写作工具的支持。

## Deprecated - 已弃用

Avoid using deprecated classes and protocols in your apps.

避免在应用中使用已弃用的类和协议。

### Deprecated Symbols - 已弃用的符号

Review symbols that are no longer supported, and find the replacements to use instead.

查看不再受支持的符号，并找到可替代使用的符号。

## Reference - 参考

### Enumerations - 枚举

Enumerations for use with multiple classes.

可用于多个类的枚举。

### Constants - 常量

Constants for use with multiple classes.

可用于多个类的常量。

### Data Types - 数据类型

Data types for use with multiple classes.

可用于多个类的数据类型。

### Macros - 宏

Macros for use with multiple classes.

可用于多个类的宏。