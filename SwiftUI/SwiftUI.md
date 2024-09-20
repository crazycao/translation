# SwiftUI

原文地址：[https://developer.apple.com/documentation/swiftui/](https://developer.apple.com/documentation/swiftui/)
官方中文地址：[https://developer.apple.com/cn/documentation/swiftui/](https://developer.apple.com/cn/documentation/swiftui/)

Declare the user interface and behavior for your app on every platform.

在每个平台上声明 App 的用户界面和行为。

> iOS 13.0+
iPadOS 13.0+
Mac Catalyst 13.0+
macOS 10.15+
tvOS 13.0+
visionOS 1.0+
watchOS 6.0+

# Overview - 概览

SwiftUI provides views, controls, and layout structures for declaring your app’s user interface. The framework provides event handlers for delivering taps, gestures, and other types of input to your app, and tools to manage the flow of data from your app’s models down to the views and controls that users see and interact with.

Define your app structure using the App protocol, and populate it with scenes that contain the views that make up your app’s user interface. Create your own custom views that conform to the View protocol, and compose them with SwiftUI views for displaying text, images, and custom shapes using stacks, lists, and more. Apply powerful modifiers to built-in views and your own views to customize their rendering and interactivity. Share code between apps on multiple platforms with views and controls that adapt to their context and presentation.

A screenshot of Xcode showing an app and its preview.

You can integrate SwiftUI views with objects from the UIKit, AppKit, and WatchKit frameworks to take further advantage of platform-specific functionality. You can also customize accessibility support in SwiftUI, and localize your app’s interface for different languages, countries, or cultural regions.