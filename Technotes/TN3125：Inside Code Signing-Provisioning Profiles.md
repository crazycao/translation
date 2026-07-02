# TN3125: Inside Code Signing: Provisioning Profiles
# TN3125: 在代码签名内：描述文件

原文地址：
[https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles)

Learn how provisioning profiles enable third-party code to run on Apple platforms.

了解配置文件如何使第三方代码能够在苹果平台上运行。

# Overview 概览

Code signing is a foundational technology on all Apple platforms. Many documents that discuss code signing focus on solving a specific problem. The _Inside Code Signing_ technote series is different: It peeks behind the code signing curtain, to give you a better understanding of how this technology works. Read these technotes to make better code signing choices up front, to understand why Apple’s code signing tools work they way they do, to inform your investigation of any code signing issues you encounter, and because learning stuff is fun!

代码签名是在所有苹果平台上的基础技术。许多有关代码签名的文档都侧重于解决特定问题。而《Inside Code Signing》技术笔记系列与众不同：它深入了解代码签名的内部机制，帮助您更好地理解这项技术的工作原理。通过阅读这些技术笔记，您可以在代码签名之前做出更好的选择，了解为什么苹果的代码签名工具以其特定方式工作，帮助您调查任何代码签名问题，并且因为学习东西是有趣的！

The other technotes in the Inside Code Signing series are:

《Inside Code Signing》系列中的其他技术笔记有：

- [TN3126: Inside Code Signing: Hashes](https://developer.apple.com/documentation/technotes/tn3126-inside-code-signing-hashes)

- [TN3127: Inside Code Signing: Requirements](https://developer.apple.com/documentation/technotes/tn3127-inside-code-signing-requirements)

> **Important**
>
> The _Inside Code Signing_ technotes discuss code signing details that aren’t considered API. The structure of a code signature has changed numerous times in the past and may well change again in the future. Don’t encode this information in your product. When signing code, use Xcode (all platforms) or the codesign tool (macOS only). To get information or validate a code signature, use the codesign tool or the [Code Signing Services](https://developer.apple.com/documentation/security/code_signing_services) API. Apple updates these facilities to accommodate any changes to the code signature structure as they roll out.
> 
> 《Inside Code Signing》技术笔记讨论的代码签名细节不能被视为 API。代码签名的结构在过去已经多次发生变化，并且将来可能会再次改变。请不要将这些信息编码到您的产品中。在签署代码时，请使用 Xcode（适用于所有平台）或 codesign 工具（仅适用于 macOS）。要获取信息或验证代码签名，请使用 codesign 工具或 [Code Signing Services](https://developer.apple.com/documentation/security/code_signing_services) API。苹果会更新这些工具以适应代码签名结构的任何变化。

# Provisioning profile fundamentals 描述文件基础知识

Apple platforms, except macOS, won’t run arbitrary third-party code. All execution of third-party code must be authorized by Apple. This authorization comes in the form of a provisioning profile, which ties together five criteria:

除了 macOS 之外，苹果平台不会运行任意的第三方代码。所有第三方代码的执行必须经过苹果的授权。这种授权以描述文件的形式呈现，将以下五个条件联系在一起：

- Who is allowed to sign code?
- What apps are they allowed to sign?
- Where can those apps run?
- When can those apps run?
- How can those apps be entitled?

- 谁有权签署代码？
- 他们被允许签署哪些应用程序？
- 这些应用程序可以在哪里运行？
- 这些应用程序可以在什么时候运行？
- 这些应用程序如何获得授权？

> **Note** 
>
> In this document the term _app_ refers to a main executable packaged in a bundle structure. This encompasses apps, app extensions, App Clips, system extensions, and XPC Services.
> 
> 在本文档中，术语“应用程序”指的是打包在包结构中的主要可执行文件。这包括应用程序、应用程序扩展、App Clips、系统扩展和 XPC 服务。

You create provisioning profiles using the Apple Developer website, either directly using the website or indirectly using Xcode or the [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi).

您可以使用苹果开发者网站创建描述文件，可以直接在网站上进行操作，也可以通过 Xcode 或 [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi) 进行间接创建。

When the Apple Developer website creates a profile for you, it cryptographically signs it. When you run an app on a device, the device checks this signature to determine if the profile is valid and, if so, checks that the app meets the criteria in the profile.

当苹果开发者网站为您创建描述文件时，会对其进行加密签名。当您在设备上运行应用程序时，设备会检查此签名以确定描述文件是否有效，并且如果有效，则检查应用程序是否符合描述文件中的条件。

> **Note**
>
> Unlike Apple’s other platforms, macOS doesn’t require a provisioning profile to run third-party code. However, provisioning profiles are still relevant on macOS, as explained in [Entitlements on macOS](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#Entitlements-on-macOS).
> 
> 与苹果的其他平台不同，macOS 不需要描述文件来运行第三方代码。然而，在 macOS 上，描述文件仍然具有相关性，正如在《[macOS 上的权限](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#Entitlements-on-macOS)》中所解释的那样。

There is one interesting edge case with provisioning profiles: When you submit your app to the App Store, the App Store re-signs the app as part of the distribution process. Before doing that, it checks that the app is signed and provisioned correctly. That check means that each individual device doesn’t need to perform further security checks, so the final app doesn’t have a provisioning profile. However, this third-party code was still authorized by a profile, albeit during the App Store distribution process.

描述文件有一个有趣的边界情况：当您将应用程序提交到 App Store 时，App Store 会重新对应用程序进行签名，这是发布过程的一部分。在此之前，它会检查应用程序的签名和描述文件是否正确。这个检查意味着每个设备不需要执行进一步的安全检查，因此最终的应用程序不包含描述文件。然而，这些第三方代码仍然是通过描述文件授权的，尽管是在 App Store 发布过程中进行的授权。

# Unpack a profile 解包描述文件

A provisioning profile is a property list wrapped within a Cryptographic Message Syntax (CMS) signature. To view the original property list, remove the CMS wrapper using the security tool:

一个描述文件是一个包装在加密消息语法（CMS）签名内的属性列表。要查看原始的属性列表，可以使用安全工具移除CMS包装。

```
% security cms -D -i Profile_Explainer_iOS_Dev.mobileprovision -o Profile_Explainer_iOS_Dev-payload.plist
% cat Profile_Explainer_iOS_Dev-payload.plist 
…
<dict>
  … lots of properties …
</dict>
</plist>
```

For more details on CMS, see [RFC 5652](https://tools.ietf.org/html/rfc5652).

关于 CMS 的更多详情，参见 [RFC 5652](https://tools.ietf.org/html/rfc5652)。

> **Important**
>
> The exact format of provisioning profiles isn’t documented and could change at any time. Use the techniques shown here for understanding and debugging purposes. Avoid building a product based on these details; if you do build such a product, be prepared to update it as the Apple development story evolves.
> 
> 描述文件的确切格式没有详细文档，并且可能随时发生变化。使用本文中展示的技术来进行理解和调试的目的。避免基于这些细节构建产品；如果您确实构建了这样的产品，请准备根据苹果开发情况的变化进行更新。

To illustrate this point, the traditional property list view of a profile is no longer the source of truth on modern systems. Rather, each profile contains a DER-Encoded-Profile property which holds a binary form of the profile that’s the new source of truth. For more on this switch, see [The Future is DER](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#The-future-is-DER).

有一点需要阐明，描述文件的传统的属性列表视图不再是现代系统上的真实来源。相反，每个描述文件都包含一个 `DER-Encoded-Profile` 属性，其中保存了描述文件的二进制形式，这才是新的真实来源。有关此转换的更多信息，请参阅《[未来是 DER](https://developer.apple.com/documentation/technotes/tn3125-inside-code-signing-provisioning-profiles#The-future-is-DER)》。

Still, the property list is easier to read and so the bulk of this technote focuses on that.

尽管如此，属性列表更容易阅读，因此本技术文档的大部分内容将聚焦在属性列表上。

For more information about the tools used in these examples, read their man pages. If you’re unfamiliar with that process, see [Reading UNIX Manual Pages](https://developer.apple.com/documentation/os/reading_unix_manual_pages).

要了解这些示例中使用的工具的更多信息，请阅读它们的手册页。如果您对该过程不熟悉，请参阅《[阅读UNIX手册页](https://developer.apple.com/documentation/os/reading_unix_manual_pages)》。