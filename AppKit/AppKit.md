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