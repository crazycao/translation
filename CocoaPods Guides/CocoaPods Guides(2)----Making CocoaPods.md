#2 Making CocoaPods

原文链接：[https://guides.cocoapods.org/making/index.html](https://guides.cocoapods.org/making/index.html)

If you want to release some of your own code to the world, or are interesting in having your own repository of podspecs for internal use, this is what you're looking for. Here you can find out about making your own Podspecs, creating a private repo and understand what we consider to be the best practices for libraries.

如果你想要发布一些你自己的代码到全世界，或者对于让你自己的podspecs仓库可以内部使用感兴趣，这就是你正寻找的东西。在这里你可以学习到如何制作自己的Podspecs，创建私有仓库以及理解我们认为怎样才是对于库的最佳实践。

#2.1 [Making a CocoaPod](https://guides.cocoapods.org/making/making-a-cocoapod.html)制作一个CocoaPod

Instructions for creating and maintaining a CocoaPod.

对于创建和管理CocoaPod的说明。

Creating your own CocoaPod is fairly straight forward. If you already have a separate component, you're most of the way there. This guide is an overview to the entire process, with the other guides in this section serving as more of a deep-dive for more advanced users.

创建你自己的CocoaPad是相当直接的。如果你已经有一个分离的组件，这是你最重要的方式。本指南是整个过程的概述，而本节中的其他指南则是作为深入的更多知识为更高级的用户提供的。

We recommend letting CocoaPods do the hard work here. Running `pod lib create [pod name]` will set you up with a well thought out library structure allowing you to easily include your files and get started quickly, we have a [guide for this](https://guides.cocoapods.org/making/using-pod-lib-create). If you'd like an up-to-date walkthrough of the whole process through to pushing to trunk, check out this 3rd party [tutorial from tutsplus](http://code.tutsplus.com/tutorials/creating-your-first-cocoapod--cms-24332).

我们建议让CocoaPods在这里做更困难的工作。运行`pod lib create [pod name]`将为你设置一个经过深思熟虑的库结构，让你可以很简单的包含你的文件并迅速开始，我们有一个[为此而写的教程](https://guides.cocoapods.org/making/using-pod-lib-create)。如果你想要一个更新到最新的整个过程的指南，以推送到主干，可以检出[由tutsplus提供的第三方教程](http://code.tutsplus.com/tutorials/creating-your-first-cocoapod--cms-24332)。

###2.1.1 [The Pod Files](https://guides.cocoapods.org/making/#the-pod-files) Pod文件

There are only a few differences between a CocoaPod and a generic open source library. The most important ones, aside from the actual source, are the `.podspec` and `LICENSE`. We do not accept libraries into the trunk without a code license. For information on what license to choose, we suggest reading [this article on CodingHorror](http://www.codinghorror.com/blog/2007/04/pick-a-license-any-license.html) or [tl;dr Legal](http://www.tldrlegal.com/).

在CocoaPod和普通的开源库之间只有少量不同。其中最重要的东西，不是实际的源，而是`.podspec`和`LICENSE`。我们不会接受把库放到没有代码许可证的主干中。关于要选择什么许可证的信息，我们建议阅读[这篇CodingHorror上的文章](http://www.codinghorror.com/blog/2007/04/pick-a-license-any-license.html)或者[tl;dr Legal](http://www.tldrlegal.com/)

####2.1.1.1 [Development](https://guides.cocoapods.org/making/#development) 开发

You can work on the library from its folder on your system.

你可以在你的系统上的文件夹中完成库的工作。

> Alternatively you can work from an application project using the `:path` option:
> 
> 或者你可以在应用工程中使用`:path`选项工作：

```
pod 'Name', :path => '~/code/Pods/'
```

####2.1.1.2 [Testing](https://guides.cocoapods.org/making/#testing) 测试

You can test the syntax of your Podfile by linting the pod against the files of its directory, this won't test the downloading aspect of linting.

你可以通过对器目录中pod文件的拉取测试你的Podfile的语法，这将不会测试拉取的下载方面进行测试。

```
$ cd ~/code/Pods/NAME
$ pod lib lint

```

Before releasing your new Pod to the world its best to test that you can install your pod successfully into an Xcode project. You can do this in a couple of ways:

在发布你的新Pod到全世界之前，最好测试一下你成否成功将你的pod安装到Xcode工程中。你可以用两种方法实现：

> Push your podspec to your repository, then create a new Xcode project with a Podfile and add your pod to the file like so:
> 
> 把你的podspec推送到你的仓库，然后创建一个带Podfile的新Xcode工程，并添加你的pod到该文件，如下：

```
pod 'NAME', :git => 'https://example.com/URL/to/repo/NAME.git'

```

> Then run
> 然后运行

```
pod install
-- or --
pod update

```

> Alternatively if you have a separate Xcode project for your unit tests you can use a Podfile for this project that references your development podspec
> 
> 或者，如果你有一个独立的Xcode工程用于单元测试，你可以为该工程使用一个Podfile，并引用你的开发podspec。

```
xcodeproj 'NAMETests'
workspace '../NAME'

pod 'NAME', :path => '../'
```

####2.1.1.3 [Release](https://guides.cocoapods.org/making/#release) 发布

Once you have a release ready you'll need to make the corresponding tag. First run a quick `pod lib lint` then create your tag and push it.

一旦你准备好发布，你需要制作相应的标签。首先运行快速的`pod lib lint`，然后创建你的标签，并推送它。

> The release workflow is similar to the following.
> 
> 发布工作流与下面类似。

```
$ cd ~/code/Pods/NAME
$ edit NAME.podspec
# set the new version to 0.0.1
# set the new tag to 0.0.1
$ pod lib lint

$ git add -A && git commit -m "Release 0.0.1."
$ git tag '0.0.1'
$ git push --tags

```

#####2.1.1.3.1 Submitting Open Source Code 提交开源代码

Once your tags are pushed you can use the command:

在推送你的标签之后，你可以使用这个命令：

```
pod trunk push NAME.podspec

```

to send your library to the Specs repo. For more information on getting this setup see [Getting Setup With Trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk).

将你的库发送到Specs仓库。关于获得此设置的更多信息，参见《[Getting Setup With Trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk)》。

#####2.1.1.3.2 Submitting Private Code 提交私有代码

Once your tags are pushed you can use the command:

在推送你的标签之后，你可以使用这个命令：

```
pod repo push [repo] NAME.podspec

```

to send your library to the named private specs repo. For more information on getting this setup see [Private CocoaPods](https://guides.cocoapods.org/making/private-cocoapods).

将你的库发送到已命名的私有描述仓库。关于获得此设置的更多信息，参见《[Private CocoaPods](https://guides.cocoapods.org/making/private-cocoapods)》。

###2.1.2 [Library Versioning](https://guides.cocoapods.org/making/#library-versioning) 库版本

There is, unfortunately, often an issue of developers not interpreting version numbers well or assigning emotional value to certain version numbers.

很不幸，这通常都是开发者的问题，不关注版本号或者随意的设置主版本数字。

However, arbitrary revisions as version is not a good idea for a library manager instead of a proper version number (see [Semantic Versioning](http://semver.org)). Let us explain how, in an ideal world, we’d prefer people to interact with it:

然而，对于库管理来说，随意修改版本并不是一个好主意，而应该用正确的版本号（参见《[Semantic Versioning](http://semver.org)》）。让我们解释一下，在理想的世界中，我们希望人们如何与它互动：

- “I want to start using CocoaLumberjack, the current version will be fine for now.” So the dev adds a dependency on the lib *without* a version requirement and `pod install`s which will use the latest version:
- “我想要开始使用CocoaLumberjack，当前版本现在就很好了。”所以开发添加了对这个库的依赖*而没有*带上版本要求，`pod install`将会使用最近的版本：

```
  pod 'CocoaLumberjack'

```

- Some time into the future, the dev wants to update the dependencies, and to do so runs the install command again, which will now install the version of the lib which is the latest version *at that time*.
- 在未来的某个时候，开发想要更新依赖，然后再次运行安装命令，这将会安装这个库*在那时*的最新版本。
- At some point the dev is finished on the client work (or a newer version of the lib changes the API and the changes aren’t needed) so the dev adds a version requirement to the dependency. For instance, consider that the author of the lib follows the semver guidelines, you can somewhat trust that between ‘1.0.7’ and ‘1.1.0’ **no** API changes will be made, but only bug fixes. So instead of requiring a specific version, the dev can specify that *any* ‘1.0.x’ is allowed as long as it’s higher than ‘1.0.7’:
- 在某个节点，开发完成了客户端工作（或者这个库的新版本修改了API而这个修改不是必须的），那么开发添加版本要求到依赖。举个例子，假如这个库的作者遵照semver指南，你会一定程度认为在‘1.0.7’和‘1.1.0’之间**没有**API做了修改，而只是修正了bug。那么就不需要指定的版本，开发可以指定接受*任意*‘1.0.x’只要它高于‘1.0.7’：

```
pod 'CocoaLumberjack', '~> 1.0.7'

```

The point is that developers can easily keep track of newer versions of dependencies, by simply running `pod install` again, which they might otherwise do less if they had to change everything manually. CocoaPods uses a less stringent form of Semantic versioning in that it will not force you to use `X.Y.Z`, you can use `X.Y` versions.

开发者可以简单的保持对依赖的新版本的跟踪，只需要再次运行`pod install`，这将能够比他们手动修改每一件事情做更少的工作。CocoaPods使用Semantic版本的不严格形式，在这里不强制你使用`X.Y.Z`，你也可以使用`x.y`版本。

####2.1.2.1 [CocoaPods Versioning Specifics](https://guides.cocoapods.org/making/#cocoapods-versioning-specifics) CocoaPods版本详情

CocoaPods uses RubyGems versions for specifying pod spec versions. The [RubyGems Versioning Policies](http://guides.rubygems.org/patterns/#semantic-versioning) describes the rules used for interpreting version numbers. The [RubyGems version specifiers](http://guides.rubygems.org/patterns/#declaring-dependencies) describes exactly how to use the comparison operators that specify dependency versions.

CocoaPods使用RubyGems版本说明pod详情版本。《[RubyGems Versioning Policies](http://guides.rubygems.org/patterns/#semantic-versioning)》描述了用于解释版本号的规则。《[RubyGems version specifiers](http://guides.rubygems.org/patterns/#declaring-dependencies)》确切的描述了如何使用具体依赖版本的比较器。

Following the pattern established in RubyGems, pre-release versions can also be specified in CocoaPods. A pre-release of version 1.2, for example, can be specified by `1.2-beta3`. In this example, the dependency specifier `~> 1.2-beta` will match `1.2-beta3`.

按照RubyGems建立的模式，在CocoaPods中也可以指定预发布版本。例如，版本1.2的预发布版本可能是`1.2-beta3`。在这个例子中，依赖分类符`~> 1.2-beta`将会匹配到`1.2-beta3`。

There's a great video from Google about how this works: ["CocoaPods and the Case of the Squiggly Arrow (Route 85)"](https://www.youtube.com/watch?v=x4ARXyovvPc).

这里有个谷歌的大视频介绍它是如何工作的：["CocoaPods and the Case of the Squiggly Arrow (Route 85)"](https://www.youtube.com/watch?v=x4ARXyovvPc)。

###2.1.3 [Documenting a Pod](https://guides.cocoapods.org/making/#documenting-a-pod) 给Pod写文档

Right now the best place to get information on documenting your Pods is NSHipster's blog post on [Obj-C](http://nshipster.com/documentation/) and [Swift](http://nshipster.com/swift-documentation/) Documentation. [CocoaDocs](http://github.com/cocoapods/cocoadocs.org) will release an appledoc/jazzy parsed code based on your Podspec's public API roughly 15 minutes after it is pushed. More information on CocoaDocs can be found on the [CocoaDocs developer README](http://cocoadocs.org/readme).

现在给你的Pod写文档以获取信息的最好的地方是NSHipster的博客，以[Obj-C](http://nshipster.com/documentation/)和[Swift](http://nshipster.com/swift-documentation/)文档发布。[CocoaDocs](http://github.com/cocoapods/cocoadocs.org)大致在将其推送15分钟之后，就会发布基于你的Podspec的公共API的appledoc/jazzy语法的代码。关于CocoaDocs的更多信息可以在《[CocoaDocs developer README](http://cocoadocs.org/readme)》中找到。

###2.1.4 [Where can I ask questions?](https://guides.cocoapods.org/making/#where-can-i-ask-questions) 在哪里可以提问？

We have multiple avenues for support, here they are in the order we prefer.

我们支持多个渠道，这里是我们推荐的使用顺序。

- [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods), get yourself some internet points. This keeps the pressure off the CocoaPods dev team and gives us time to work on the project and not support. One of the advantages of using Stack Overflow is that the answer is then easily accessible for others.
- [CocoaPods Mailing List](http://groups.google.com/group/cocoapods), the mailing list is mainly used for announcements of related projects and occasionally for support.
- [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods)，自己获得一些网上的观点。这可以减轻CocoaPods开发团队的压力，并给我们时间为工程和其他未支持的地方工作。使用Stack Overflow的另一个好处是，答案在之后可以很容易被其他人访问到。
- [CocoaPods Mailing List](http://groups.google.com/group/cocoapods)，邮件列表主要用于相关工程的通告，偶尔用于提供支持。

###2.1.5 [External resources](https://guides.cocoapods.org/making/#external-resources) 扩展资源

- [Why your podspec is failing](http://codeslingers.co.uk/2014/05/16/why-your-podspec-is-failing/) 为什么你的podspec会失败

##2.2 [Using Pod Lib Create](https://guides.cocoapods.org/making/using-pod-lib-create.html) 使用Pod Lib创建

The guide for getting a CocoaPod up and running quickly.

本指导用于快速建立一个CocoaPod并运行。

###2.2.1 Getting started 开始

We're going to through the creation of an entire pod using `pod lib create` to bootstrap the process. So let's start with the initial command:

我们使用`pod lib create`引导该过程贯穿整个pod的创建。那么我们将从这个初始命令开始：

```
pod lib create MyLibrary

```

> Note: To use your own [pod-template](https://github.com/cocoapods/pod-template) you can add the parameter `--template-url=URL` where URL is the git repo containing a compatible template.
> 
> 注意：要使用你自己的[pod-template](https://github.com/cocoapods/pod-template)，你可以添加参数`--template-url=URL`，URL就是包含一个兼容模板的git repo。
> 
> Second Note: you can press return to select the default (underlined) option.
> 
> 第二个注意：你可以按下返回以选择默认（下划线的）设置。

###2.2.2 [Objective-C or Swift](https://guides.cocoapods.org/making/#objective-c-or-swift) Objective-C还是Swift

The first question you're asked is what language you want to build a pod in. For both choices CocoaPods will set up your library as a framework.

第一个问题是你想要使用哪种语言建立一个pod。对于任何一个选择CocoaPods都会把你的库设置成一个框架。

###2.2.3 [Making a Demo Application](https://guides.cocoapods.org/making/#making-a-demo-application) 制作一个Demo程序

The template will generate an Xcode project for your library. This means you don't have to go through creating a new project in Xcode.

模板会为你的库生成一个Xcode工程。这意味着你不需要完成在Xcode中创建新工程的整个过程。

If you want to have an example project for `pod try MyLib` or need to have your library's tests run inside an application ( interaction tests, custom fonts, etc ) then you should say yes. A good metric is *"Should this Pod include a screenshot?"*; if so, then you should have a demo.

如果你想要有一个为`pod try MyLib`提供的示例工程或者需要让你的库测试在程序内部运行（交互测试，自定义字体，等等），然后你可能说是的。*"这个Pod是否包含屏幕截图？"*是一个很好的衡量标准；如果这样，那么你应该有一个demo。

###2.2.4 [Choosing a Test Framework](https://guides.cocoapods.org/making/#choosing-a-test-framework) 选择一个测试框架

You should be testing your library. Testing ensures stability for people using your library. In open source libraries this means people can make changes knowing that they haven't broken implicit expectations. We recommend using a testing framework rather than relying on Apple's XCTest but that is included. In Objective-C we include a choice of two popular testing frameworks; Specta/Expecta and Kiwi. If you can't decide, use Specta/Expecta.

你应该要测试你的库。测试确保人们能稳定使用你的库。在开源库中，这意味着人们能在做出修改时知道他们没有打破隐含的预期。我们推荐使用测试框架而不是依赖苹果的XCTest，但这也是包含的。在Objective-C，我们推荐两个常用测试框架供选择；Specta/Expecta和Kiwi。如果你无法决定，那就使用Specta/Expecta吧。

####2.2.4.1 Specta/Expecta

A light-weight TDD / BDD framework for Objective-C & Cocoa.

一个为Objective-C和Cocoa提供的轻量级TDD/BDD框架。

> [GitHub repo](https://github.com/specta/specta)

####2.2.4.2 Kiwi

Kiwi is a Behaviour Driven Development library for iOS development. The goal is to provide a BDD library that is exquisitely simple to setup and use.

Kiwi是是一个为iOS开发提供的行为驱动开发（BDD）库。其目标是提供一个极度简易安装和使用的BDD库。

> [GitHub repo](https://github.com/kiwi-bdd/Kiwi)

The major differences is that Kiwi is an all-in-one approach to Stubs/Mocks/Expectations whereas Specta/Expecta is a modular approach through different Podspecs. We include all the necessary includes and setup for your testing framework in `MyLib-Tests.pch` so that you don't have to include them in each file.

二者的主要区别是，Kiwi为Stubs、Mocks、Expectations提供了一体化方法，而Specta/Expecta通过不同的Podspecs提供模块化方法。我们在`MyLib-Tests.pch`中为你的测试框架包含了所有必要的包含和设置，这样你就不用再每一个文件中包含它们。

In Swift we only offer the choice of [Quick/Nimble](https://github.com/Quick/Quick) as this looks to be the dominant testing library.

在Swift中我们只提供一个选择[Quick/Nimble](https://github.com/Quick/Quick)，因为它看起来是最好的测试库。

###2.2.5 [View-based Testing](https://guides.cocoapods.org/making/#view-based-testing) 基于视图的测试

Depending on what library you are building you may find Snapshot based testing to be a smart way to verify the results of [different](https://github.com/neilang/NAMapKit/blob/master/Demo/DemoTests/NAInteractiveDemoViewControllerTests.m) [actions](https://github.com/orta/ORStackView/blob/master/ORStackViewExampleTests/ORFourthViewControllerTests.m) [on](https://github.com/liaojinxing/StarRatingView/blob/599390e258b44e8efe2121356bac5d74494086f9/StarRatingViewTests/StarRatingViewTests.m) [your](https://github.com/AshFurrow/ARCollectionViewMasonryLayout/blob/58f2b987756bd1d1b710a74c51aa48204006fc99/IntegrationTests/ARCollectionViewMasonryLayoutTests.m) [views](https://github.com/yujinakayama/NAKPlaybackIndicatorView/blob/b81c29b399e109c56024eefdffd89dfd606d662c/Tests/SnapshotTests.m). We recommend using [FBSnapShotTestCase](https://github.com/facebook/ios-snapshot-test-case), if you are using Specta/Expecta then we [include a Pod](https://github.com/dblock/ios-snapshot-test-case-expecta) to improve the syntax.

取决于你构建什么库，你可能发现基于Snapshot的测试是一个聪明的方法验证你的视图上的不同操作。我们推荐使用[FBSnapShotTestCase](https://github.com/facebook/ios-snapshot-test-case)，如果你使用Specta/Expecta然后我们[包含一个Pod](https://github.com/dblock/ios-snapshot-test-case-expecta)以改善该语法。

###2.2.6 [Prefixes for Objective-C](https://guides.cocoapods.org/making/#prefixes-for-objective-c) Objective-C前缀

To wrap up an Objective-C project we want to know your class prefix. This means that we can make all the classes generated by CocoaPods fit in with your style, also all classes generated from inside Xcode will start with your prefix. We know that Apple is deprecating prefixes, but in reality they still have their place in Objective-C codebases.

要圆满完成一个Objective-C工程，我们想要知道你的类前缀。这意味着我们可以让所有由CocoaPods生成的类都适应你的风格，并且所有在Xcode中生成的类都以你的前缀开头。我们知道Apple反对前缀，但是实际上在Objective-C代码库中仍然有它们的位置。

###2.2.7 [The Pod Lib Create Template](https://guides.cocoapods.org/making/#the-pod-lib-create-template) Pod库创建模板

With the questions over, we run `pod install` on the newly created Project. Let's look at the results:

随着问题发展，我们在新创建的工程中运行`pod install`。让我们看看结果： 

```
$ tree MyLib -L 2

  MyLib
  ├── .travis.yml
  ├── _Pods.xcproject
  ├── Example
  │   ├── MyLib
  │   ├── MyLib.xcodeproj
  │   ├── MyLib.xcworkspace
  │   ├── Podfile
  │   ├── Podfile.lock
  │   ├── Pods
  │   └── Tests
  ├── LICENSE
  ├── MyLib.podspec
  ├── Pod
  │   ├── Assets
  │   └── Classes
  │     └── RemoveMe.[swift/m]
  └── README.md

```

We've tried to keep the amount in the root folder minimised, You will see the following files:

我们试图尽量减少根文件夹中的文件数量，我们将看到下面的文件：

- `.travis.yml` - a setup file for [travis-ci](https://travis-ci.org/).
- `_Pods.xcproject` - a symlink to your Pod's project for Carthage support
- `LICENSE` - defaulting to the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
- `MyLib.podspec` - the Podspec for your Library.
- `README.md` - a default README in markdown.
- `RemoveMe.swift/m` - a single file to to ensure compilation works initially.
- `.travis.yml` - 一个[travis-ci](https://travis-ci.org/)的配置文件。
- `_Pods.xcproject` - 给你的Pod工程提供Carthage支持的符号链接
- `LICENSE` - 默认的[MIT许可](http://en.wikipedia.org/wiki/MIT_License).
- `MyLib.podspec` - 你的库的Podspec
- `README.md` - 用Markdown写的默认README
- `RemoveMe.swift/m` - 起初确保编译工作的单一文件

and the following folders:

以及下面的文件夹：

- `Pod` - This is where you place your library's classes
- `Example` - This is the generated Demo & Testing bundle
- `Pod` - 放置你的库的类的地方
- `Example` - 生成的Demo和Testing包

###2.2.8 [Putting your Library Together](https://guides.cocoapods.org/making/#putting-your-library-together) 把你的库放到一起

CocoaPods will open your Xcode project straight away; from there you can edit all of the files generated by CocoaPods. Let's look at an expanded version of Xcode:

CocoaPods将直接打开你的Xcode工程；在那里你可以编辑所有由CocoaPods生成的文件。让我们在Xcode的扩展版本中查看：

[![img](https://guides.cocoapods.org/assets/images/pod_lib_create/xcode.png)](https://guides.cocoapods.org/assets/images/pod_lib_create/xcode.png)

1. You can edit your Podspec metadata, this lets you change your README and Podspec.
2. This is the Demo Library, you will be missing this if you didn't say yes to it.
3. Here is a stubbed out test spec for the framework you had chosen earlier.
4. This is the Development Pods section, and actually where you can work on your library. See below for more information.
5. Finally the Pods used in setting up the project.

>

1. 你可以编辑你的Podspec元数据，这让你修改你的README和Podspec。
2. 这是Demo库，如果你没有勾选就不会有。
3. 这是你更早些时候选择的为框架做spec测试的遗留。
4. 这是Development Pod部分，你实际为你的库工作的地方。下面有更多介绍。
5. 最后是用于建立这个工程的Pod。

It's worth mentioning here, as this catches people quite often, a Swift library needs to have its classes declared as `public` for you to see them in your example library.

这里值得注意的是，由于这经常困住人们，Swift库需要将它的类声明为`public`，以便你可以在你的示例库中看到它们。

####2.2.8.1 Development Pods 开发Pods

Development Pods are different from normal CocoaPods in that they are symlinked files, so making edits to them will change the original files, so you can work on your library from inside Xcode. Your demo & tests will need to include references to headers using the `#import <MyLib/XYZ.h>`format.

Development Pod与正常CocoaPods不同，它们是已经符号链接的文件，因此编辑它们会修改原始的文件，那么你就可以从Xcode内部在你的库上工作。你的demo和测试将需要使用`#import <MyLib/XYZ.h>`格式包含头文件的引用。

> `[!] Note:` Due to a Development Pods implementation detail, when you add new/existing files to `Pod/Classes` or `Pod/Assets` or update your podspec, you should run `pod install` or `pod update`.
> 
> `[!] 注意：`由于Development Pod的实现细节，当你添加新的/已存在的文件到`Pod/Classes`或`Pod/Assets`或更新你的podspec，你都应该运行`pod instrall`或`pod update`。

###2.2.9 [Adding Travis CI](https://guides.cocoapods.org/making/#adding-travis-ci) 添加Travis CI

The template includes a `.travis.yml` file that will run the default tests included in the project. If you have an open source repo on GitHub, open [your profile](https://travis-ci.org/profile/) on Travis CI and turn the library on.

模板包含一个`.travis.yml`文件，这将运行包含在工程中的默认测试。如果你在GitHub上有一个开源repo，在Travis CI中打开[your profile](https://travis-ci.org/profile/)并开启库。

![/assets/images/pod_lib_create/travis-ci.png](https://guides.cocoapods.org/assets/images/pod_lib_create/travis-ci.png)

###2.2.10 [Deploying your Library](https://guides.cocoapods.org/making/#deploying-your-library) 部署你的库

So you've got your library ready to go. First you should check if the Podspec lints correctly, as you can't deploy with errors. This can be done with two methods, `pod lib lint` and `pod spec lint`. The difference between them is that `pod lib lint` does not access the network, whereas `pod spec lint` checks the external repo and associated tag.

那么你已经准备好了你的库将进行下一步。首先你要检查Podspec拉取是否正确，因为你不能带着错误部署。这可以用两个方法来做，`pod lib lint`和`pod spec lint`。二者不同在于`pod lib lint`不会访问网络，而`pod spec lint`会检查额外的repo和相关联的标签。

If you're deploying an Open Source library to [trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk), you cannot have CocoaPods warnings. You can have Xcode warnings though. You should continue to the [getting started with trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk) guide to deploy to the public.

如果你正发布一个开源库到[主干](https://guides.cocoapods.org/making/getting-setup-with-trunk)，你不能有CocoaPods警告。尽管你可以由Xcode警告。你可以继续到《[getting started with trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk)》学习发布到公共空间的指南。

If you're deploying to a private Specs repo, you will need to have already added that repo. See the guides on [Private Specs Repos](https://guides.cocoapods.org/making/private-cocoapods) to set that up. If you are deploying to an existing Private Repo, use this command to deploy:

如果你正发布一个私有Spec仓库，你需要已经添加这个仓库。参见《[Private Specs Repos](https://guides.cocoapods.org/making/private-cocoapods)》指南设置它。如果你正发布一个已存在的私有仓库，使用这个命令发布即可：

```
pod repo push SPEC_REPO *.podspec --verbose

```

###2.2.11 [Done](https://guides.cocoapods.org/making/#done)

👍

#3 [Getting setup with Trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk.html) 通过Trunk获取设置

Instructions for creating a CocoaPods user account

创建CocoaPods用户账户的使用说明

##3.1 CocoaPods Trunk 

CocoaPods Trunk is an authentication and CocoaPods API service. To publish new or updated libraries to CocoaPods for public release you will need to be registered with Trunk and have a valid Trunk session on your current device. You can read about Trunk's history and development on [the blog](https://blog.cocoapods.org/CocoaPods-Trunk/), and about [private pods](https://guides.cocoapods.org/making/private-cocoapods.html) for yourself or your team.

CocoaPods Trunk是认证和CocoaPods API服务。要发布新的或更新的库到CocoaPods作为公开发行版，你需要在Trunk注册并且在你当前设备上有一个可用的Trunk会话。你可以在[博客](https://blog.cocoapods.org/CocoaPods-Trunk/)看到关于Trunk的历史和发展，以及你自己或你的团队的[私有pods](https://guides.cocoapods.org/making/private-cocoapods.html)。

CocoaPods Trunk is available starting with CocoaPods 0.33. A collection of commands under `pod trunk` automate the deployment and management of your Podspecs. At any time you can run `pod trunk [command] --help` to see inline help.

CocoaPods Trunk从CocoaPods 0.33版本开始可用。`pod trunk`下的一系列命令可以自动化部署和管理你的Podspecs。任何时候你都可以运行`pod trunk [command] --help`查看在线帮助。

###3.1.1 [Getting started](https://guides.cocoapods.org/making/#getting-started) 开始

First sign up for an account with your email address. This begins a session on your current device.

首先用你的邮箱注册一个账号。这会在你的当前设备上开始一个会话。

We recommend including a description with your session to give some context when you list your sessions later. For example:

我们建议在你的会话中包含一个说明，以后当你列出所有会话时可以得到一些上下文信息。例如：

```
$ pod trunk register orta@cocoapods.org 'Orta Therox' --description='macbook air'

```

You must click a link in an email Trunk sends you to verify the connection between your Trunk account and the current computer. You can list your sessions by running `pod trunk me`.

你必须在Trunk发给你的邮件中点击一个连接，证实你的Trunk账号和当前计算机之间的连接。你可以通过运行`pod trunk me`列出你的会话。

Trunk accounts do not have passwords, only per-computer session tokens.

Trunk账户没有密码，只有每台计算机唯一的会话令牌。

###3.1.2 [Deploying a library](https://guides.cocoapods.org/making/#deploying-a-library) 部署一个库

`pod trunk push [NAME.podspec]` will deploy your Podspec to Trunk and make it publicly available. You can also deploy Podspecs to your own private specs repo with `pod repo push REPO [NAME.podspec]`.

`pod trunk push [NAME.podspec]`将部署你的Podspec到Trunk并使其公开可用。你也可以部署Podspecs到你自己的私有specs仓库，使用`pod repo push REPO [NAME.podspec]`。

Deploying with `push`:

使用`push`部署：

- Lints your Podspec locally. You can lint at any time with `pod spec lint [NAME.podspec]`
- A successful lint pushes your Podspec to Trunk or your private specs repo
- Trunk will publish a canonical JSON representation of your Podspec
- 在本地lint你的Podspec。你可以在任何时候使用`pod spec lint [NAME.podspec]`命令进行lint。
- 成功的lint会推送你的Podspec到Trunk或你的私有spec仓库。
- Trunk将会发布你的Podspec的标注JSON表达式。

Trunk will also post a web hook to other services alerting them of a new CocoaPod, for example [CocoaDocs.org](http://cocoadocs.org) and [@CocoaPodsFeed](https://twitter.com/cocoapodsfeed).

Trunk也会发送一个web hook到其他服务器，如[CocoaDocs.org](http://cocoadocs.org)和[@CocoaPodsFeed](https://twitter.com/cocoapodsfeed)，通知它们有新的CocoaPod。

###3.1.3 [Adding other people as contributors](https://guides.cocoapods.org/making/#adding-other-people-as-contributors) 添加其他人作为贡献者

The first person to push a Podspec version to Trunk can add other maintainers. For example, to add `kyle@cocoapods.org` to the library `ARAnalytics`:

第一个推送Podspec版本到Trunk的人可以添加其他维护者。例如，添加`kyle@cocoapods.org`到`ARAnalytics`库：

```
$ pod trunk add-owner ARAnalytics kyle@cocoapods.org

```

This will then list all the known library owners. Note: they need to already have registered an account set up on trunk in order for you to add them to a library.

这然后会列出所有已知的库拥有者。注意：他们需要已经在建立的trunk上注册账户，你才能添加他们到库。

###3.1.5 [Claiming an existing library](https://guides.cocoapods.org/making/#claiming-an-existing-library) 认领一个已存在的库

If you want to claim a library that someone has already claimed, then you can use [our Claims form](https://trunk.cocoapods.org/claims/new)to say that you are the owner or maintainer of a collection of libraries. Any issues regarding ownership of libraries will be arbitrated by the CocoaPods dev team.

如果你想要认领一个其他人已经认领的库，你可以使用[我们的Claims形式](https://trunk.cocoapods.org/claims/new)声明你是一些库的拥有者或维护者。任何关于库的所有权的问题将由CocoaPods开发团队裁决。

#4 [Quality Indexes](https://guides.cocoapods.org/making/quality-indexes.html) 质量索引

Increasing your CocoaPod's Search Rank 提升你的CocoaPod的搜索排名

After the submission of a Podspec to [Trunk](https://guides.cocoapods.org/making/making/getting-setup-with-trunk.html), the documentation service CocoaDocs generates a collection of metrics for the Pod. You can look these metrics for any Pod on [metrics.cocoapods.org/api/v1/pods/\[Pod\]](http://metrics.cocoapods.org/api/v1/pods/ORStackView). These metrics are used to generate a variety of Quality Modifiers which eventually turns into a single number called the Quality Index.

在提交Podspec到[Trunk](https://guides.cocoapods.org/making/making/getting-setup-with-trunk.html)之后，文档服务CocoaDocs会为Pod生成一系列的衡量标准。你可以在[metrics.cocoapods.org/api/v1/pods/\[Pod\]](http://metrics.cocoapods.org/api/v1/pods/ORStackView)查看任意Pod的这些衡量标准。这些度量用于生成各种各样的质量修饰符，质量修饰符又最终转为一个简单的数字，即被称为质量索引。

This document is a form of [literate programming](https://en.wikipedia.org/wiki/Literate_programming#cite_note-19) within the [CocoaDocs-API](https://github.com/CocoaPods/cocoadocs-api/blob/master/quality_modifiers.rb). As such it contains the actual ruby code that is ran in order to generate the individual scores. Plus, Swift looks like Ruby anyway - so you can read it ;).

本文是一种在[CocoaDocs-API](https://github.com/CocoaPods/cocoadocs-api/blob/master/quality_modifiers.rb)范围内的[literate programming](https://en.wikipedia.org/wiki/Literate_programming#cite_note-19)文学编程。因此，它包含了运行以产生个人得分的实际的ruby代码。此外，Swift看起来和Ruby很像——所以你可以读懂它的;)。

The aim of the Quality Index is to highlight postive metrics, and downplay the negative. It is very possible to have a Pod for which no modifier is actually applied. Meaning the Index stays at the default number of 50. This is a pretty reasonable score.

质量索引的目标是突出正向指标，而淡化负面的。非常可能有一个Pod并没有实际接受的修饰符。意味着索引停留在默认值50。这是一个非常合理的得分。

A good example of the mentality we have towards the modifiers is to think of a Pod with a majority of it's code in Swift. It gets a boost, while an Objective-C one doesn't get modified. It's not about reducing points for Objective-C, but highlighting that right now a Swift library represents forward thinking best practices.

我们面对修改者的心态的一个很好的例子是，把Pod想成用Swift写的一堆代码。它升级了，而Objective-C写的地方不会被修改。这并不是要减少Objective-C的点，而是要突出现在Swift库代表未来认可的最佳实践。

Finally, before we get started. These metrics are not set in stone, they have been evolving since their unveiling and will continue to do so in the future. Feedback is appreciated, ideally in [issues](https://github.com/CocoaPods/cocoapods.org/issues/new) - so they can be discussed.

最后，让我们开始吧。这些衡量标准并不是固定的，它们从揭晓之后就一直在进化，并将在未来持续进化。如有反馈我们会很感激，放在[issues](https://github.com/CocoaPods/cocoapods.org/issues/new)中是会合适——这样就可以讨论它们了。

##4.1 Popularity Metrics 流行度标准

It's a pretty safe bet that an extremely popular library is going to be a well looked after, and maintained library. We weighed different metrics according to how much more valuable the individual metric is rather than just using stars as the core metric.

这是一个非常安全的推测，一个非常流行的库将会是一个被很好的照看和维护的库。我们会依据单个标准有多少价值来权衡不同的标准，而不是只使用打星作为核心标准。

```
 Modifier.new("Very Popular", "The popularity of a project is a useful way of discovering if it is useful, and well maintained.", 30, { |...|
   value = stats[:contributors].to_i * 90 +  stats[:subscribers].to_i * 20 +  stats[:forks].to_i * 10 + stats[:stargazers].to_i
   value > 9000
 }),

```

However, not every idea needs to be big enough to warrent such high metrics. A high amount of engagement is useful in it's own right.

然而，不是每个点子都需要很大才能承担如此高的标准。在它自己的权限中大量的参与也是有用的。

```
 Modifier.new("Popular", "A popular library means there can be a community to help improve and maintain a project.", 10, { |...|
   value = stats[:contributors].to_i * 90 +  stats[:subscribers].to_i * 20 +  stats[:forks].to_i * 10 + stats[:stargazers].to_i
   value > 1500
 }),

```

At the moment this is entirely focused on libraries that are coming from GitHub. In the future, once Stats for downloads/installs are mature then we will move over to that in order to accomodate libraries not using GitHub.

现在，完全关注来自GitHub的库。未来，一旦下载/安装的统计功能成熟，我们将越过它，也可以适应不使用GitHub的库。

##4.2 Swift Package Manager Swift包管理器

We want to encourage support of Apple's Swift Package Manager, it's better for the community to be unified. For more information see our [FAQ](https://guides.cocoapods.org/using/faq.html). This currently checks for the existence of `Package.swift`, once SPM development has slowed down, we may transistion to testing that it supports the latest release.

我们想要鼓励对苹果的Swift Package Manager的支持，这对团队统一更好。更多信息请看我们的[FAQ](https://guides.cocoapods.org/using/faq.html)。现在会检查`Package.swift`的存在，一旦SPM开发放缓，我们可能过度到测试其是否支持最近的版本。

```
 Modifier.new("Supports Swift Package Manager", "Supports Apple's official package manager for Swift.", 10, { |...|
   cd_stats[:spm_support]
 }),

```

##4.3 Inline Documentation 在线文档

A lot of the generated documentation comes from inside the library itself. These metrics are about the usage of [Appledoc](http://nshipster.com/documentation/) and [Headerdoc](http://nshipster.com/swift-documentation/) within your public API. This means either from the parts of Swift that you have classed as `public` or from the public headers.

Xcode uses this documentation to give inline hints, and CocoaDocs will create online documentation based on this documentation. Making it much easier for anyone using your library to work with.

```
 Modifier.new("Great Documentation", "A full suite of documentation makes it easier to use a library.", 3, { |...|
   cd_stats[:doc_percent].to_i > 90
 }),

 Modifier.new("Documentation", "A well documented library makes it easier to understand what's going on.", 2, { |...|
   cd_stats[:doc_percent].to_i > 60
 }),

```

Providing no inline comments can make it tough for people to work with your code without having to juggle between multiple contexts. We use -1 to determine that no value was generated.

```
 Modifier.new("Badly Documented", "Small amounts of documentation generally means the project is immature.", -8, { |...|
   cd_stats[:doc_percent].to_i < 20 && cd_stats[:doc_percent].to_i != -1
 }),

```

##4.4 README Scoring

The README score is based on an algorithm that looks at the variety of the *bundled* README. You can run the algorithm against any URL here on [clayallsopp.github.io/readme-score](http://clayallsopp.github.io/readme-score). A README is the front-page of your library, it can provide an overview of API or show what the library can do.

Strange as it sounds, if you are providing a binary CocoaPod, it is worth embedding your README.md inside the zip. This means CocoaPods can use it to generate your Pod page. We look for a `README{,.md,.markdown}` for two directories from the root of your project.

*Note:* These modifiers are still in flux a bit, as we want to take a Podspec's `documentation_url`into account.

```
 Modifier.new("Great README", "A well written README gives a lot of context for the library, providing enough information to get started. ", 5, { |...|
   cd_stats[:readme_complexity].to_i > 75
 }),

 Modifier.new("Minimal README", "The README is an overview for a library's API. Providing a minimal README means that it can be hard to understand what the library does.", -5, { |...|
   cd_stats[:readme_complexity].to_i < 40
 }),

 Modifier.new("Empty README", "The README is the front page of a library. To have this applied you may have a very empty README.", -8, { |...|
   cd_stats[:readme_complexity].to_i < 25 && spec.documentation_url == nil
 }),

```

##4.5 CHANGELOG

Having a CHANGELOG means that its easier for people for compare older verions, as a metric of quality this generally shows a more mature library with care taken by the maintainer to show changes. We look for a `CHANGELOG{,.md,.markdown}` for two directories from the root of your project.

```
 Modifier.new("Has a CHANGELOG", "CHANGELOGs make it easy to see the differences between versions of your library.", 5, { |...|
   cd_stats[:rendered_changelog_url] != nil
 }),

```

##4.6 Language Choices

Swift is slowly happening. We wanted to positively discriminate people writing libraries in Swift.

```
 Modifier.new("Built in Swift", "Swift is where things are heading.", 5, { |...|
   cd_stats[:dominant_language] == "Swift"
 }),

```

Objective-C++ libraries can be difficult to integrate with Swift, and can require a different paradigm of programming from what the majority of projects are used to.

```
 Modifier.new("Built in Objective-C++", "Usage of Objective-C++ makes it difficult for others to contribute.", -5, { |...|
   cd_stats[:dominant_language] == "Objective-C++"
 }),

```

##4.7 Licensing Issues

The GPL is a legitimate license to use for your code. However it is [incompatible](http://www.fsf.org/blogs/licensing/more-about-the-app-store-gpl-enforcement) with putting an App on the App Store, which most people would end up doing. To protect against this case we detract points from GPL'd libraries.

```
 Modifier.new("Uses GPL", "There are legal issues around distributing GPL'd code in App Store environments.", -20, { |...|
   cd_stats[:license_short_name] =~ /GPL/i || false
 }),

```

There were also quite a few libraries using the WTFPL, which is a license that aims to not be a license. It was rejected by the [OSI](http://opensource.org/) ( An open source licensing body. ) as being no different than not including a license. If you want to do that, use a [public domain](http://choosealicense.com/licenses/unlicense/) license.

```
 Modifier.new("Uses WTFPL", "WTFPL was denied as an OSI approved license. Thus it is not classed as code license.", -5, { |...|
   cd_stats[:license_short_name] == "WTFPL"
 }),

```

##4.8 Code Calls

Testing a library is important. When you have a library that people are relying on, being able to validate that what you expected to work works increases the quality.

```
 Modifier.new("Has Tests", "Testing a library shows that the developers care about long term quality on a project as internalized logic is made explicit via testing.", 4, { |...|
     cd_stats[:total_test_expectations].to_i > 10
 }),

 Modifier.new("Test Expectations / Line of Code", "Having more code covered by tests is great.", 10, { |...|
   lines = cd_stats[:total_lines_of_code].to_f
   expectations = cd_stats[:total_test_expectations].to_f
   if lines != 0
     0.045 < (expectations / lines)
   else
     false
   end
 }),

```

A larger library will increase the size of other people's application. Making them slower to launch. CocoaDocs look at the folder size of the library after CocoaPods has removed anything that is not to be integrated in the app.

```
 Modifier.new("Install size", "Too big of a library (usually caused by media assets) can impact an app's startup time.", -10, { |...|
   cd_stats[:install_size].to_i > 10000
 }),

```

CocoaPods makes it easy to create a library with multiple files, we wanted to encourage adoption of smaller more composable libraries.

```
 Modifier.new("Lines of Code / File", "Smaller, more composeable classes tend to be easier to understand.", -8, { |...|
   files = cd_stats[:total_files].to_i
   if files != 0
     (cd_stats[:total_lines_of_code].to_f / cd_stats[:total_files].to_f) > 250
   else
     false
   end
 }),

```

##4.9 Ownership

The CocoaPods Specs Repo isn't curated, and for the larger SDKs people will create un-official Pods. We needed a way to state that this Pod has come for the authors of the library, so, we have verified accounts. These are useful for the companies the size of; Google, Facebook, Amazon and Dropbox. We are applying this very sparingly, and have been reaching out to companies individually.

```
 Modifier.new("Verified Owner", "When a pod comes from a large company with an official account.", 20, { |...|
   owners.find { |owner| owner.owner.is_verified } != nil
 }),

```

##4.10 Maintainance

We want to encourage people to ship semantic versions with their libraries. It can be hard to know what to expect from a library that is not yet at 1.0.0 given there is no social contract there. This is because before v1.0.0 a library author makes no promise on backwards compatability.

```
 Modifier.new("Post-1.0.0", "Has a Semantic Version that is above 1.0.0", 5, { |...|
   Pod::Version.new("1.0.0") < Pod::Version.new(spec.version)
 }),

```

When it's time to deprecate a library, we should reflect that in the search results.

```
 Modifier.new("Is Deprecated", "Latest Podspec is declared to be deprecated", -20, { |...|
   spec.deprecated || spec.deprecated_in_favor_of || false
 }),

```

##4.11 Misc - GitHub specific

This is an experiment in figuring out if a project is abandoned. Issues could be used as a TODO list, but leaving 50+ un-opened feels a bit off. It's more likely that the project has been sunsetted.

```
 Modifier.new("Lots of open issues", "A project with a lot of open issues is generally abandoned. If it is a popular library, then it is usually offset by the popularity modifiers.", -8, { |...|
   stats[:open_issues].to_i > 50
 })
```

#5 [Private Pods](https://guides.cocoapods.org/making/private-cocoapods.html)

How to setup a private Podspec repo for maintaining internal libraries.

##5.1 Private Pods

CocoaPods is a great tool not only for adding open source code to your project, but also for sharing components across projects. You can use a private Spec Repo to do this.

There are a few steps to getting a private pods setup for your project; creating a private repository for them, letting CocoaPods know where to find it and adding the podspecs to the repository.

###5.1.1 [1. Create a Private Spec Repo](https://guides.cocoapods.org/making/#-create-a-private-spec-repo)

To work with your collection of private pods, we suggest creating your own Spec repo. This should be in a location that is accessible to all who will use the repo.

**You do not need to fork the CocoaPods/Specs Master repo.** Make sure that everyone on your team has access to this repo, but it does not need to be public.

###5.1.2 [2. Add your Private Repo to your CocoaPods installation](https://guides.cocoapods.org/making/#-add-your-private-repo-to-your-cocoapods-installation)

```
$ pod repo add REPO_NAME SOURCE_URL

```

Note: If you plan on creating pods locally, you should have push access to SOURCE_URLTo check if your installation is successful and ready to go:

```
$ cd ~/.cocoapods/repos/REPO_NAME
$ pod repo lint .

```

###5.1.3 [3. Add your Podspec to your repo](https://guides.cocoapods.org/making/#-add-your-podspec-to-your-repo)

> Make sure you've tagged and versioned your source appropriately, then run:

```
$ pod repo push REPO_NAME SPEC_NAME.podspec

```

This will run `pod spec lint`, and take care of all the little details for setting up the spec in your private repo.

> The structure of your repo should mirror this:

```
.
├── Specs
    └── [SPEC_NAME]
        └── [VERSION]
            └── [SPEC_NAME].podspec

```

##5.2 [That's it!](https://guides.cocoapods.org/making/#thats-it)

Your private Pod is ready to be used in a Podfile. You can use the spec repository with the [`source`directive](https://guides.cocoapods.org/syntax/podfile.html#source) in your Podfile as shown in the following example:

```
source 'URL_TO_REPOSITORY'

```

##5.3 [An Example](https://guides.cocoapods.org/making/#an-example)

###5.3.1 [1. Create a Private Spec Repo](https://guides.cocoapods.org/making/#-create-a-private-spec-repo)

> Create a repo on your server. This can be achieved on Github or on your own server as follows

```
$ cd /opt/git
$ mkdir Specs.git
$ cd Specs.git
$ git init --bare

```

(The rest of this example uses the repo at [https://github.com/artsy/Specs](https://github.com/artsy/Specs))

###5.3.2 [2. Add your repo to your CocoaPods installation](https://guides.cocoapods.org/making/#-add-your-repo-to-your-cocoapods-installation)

> Using the URL of your repo on your server, add your repo using

```
$ pod repo add artsy-specs git@github:artsy/Specs.git

```

> Check your installation is successful and ready to go:

```
$ cd ~/.cocoapods/repos/artsy-specs
$ pod repo lint .

```

###5.3.3 [3. Add your Podspec to your repo](https://guides.cocoapods.org/making/#-add-your-podspec-to-your-repo)

> Create your Podspec

```
cd ~/Desktop
touch Artsy+OSSUIFonts.podspec

```

> Artsy+OSSUIFonts.podspec should be opened in the text editor of your choice. Typical contents are 

```
Pod::Spec.new do |s|
  s.name             = "Artsy+OSSUIFonts"
  s.version          = "1.1.1"
  s.summary          = "The open source fonts for Artsy apps + UIFont categories."
  s.homepage         = "https://github.com/artsy/Artsy-OSSUIFonts"
  s.license          = 'Code is MIT, then custom font licenses.'
  s.author           = { "Orta" => "orta.therox@gmail.com" }
  s.source           = { :git => "https://github.com/artsy/Artsy-OSSUIFonts.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/artsy'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*'

  s.frameworks = 'UIKit', 'CoreText'
  s.module_name = 'Artsy_UIFonts'
end

```

> Save your Podspec and add to the repo

```
pod repo push artsy-specs ~/Desktop/Artsy+OSSUIFonts.podspec

```

> Assuming your Podspec validates, it will be added to the repo. The repo will now look like this

```
.
├── Specs
    └── Artsy+OSSUIFonts
        └── 1.1.1
            └── Artsy+OSSUIFonts.podspec

```

> See this [Podfile](https://github.com/artsy/eigen/blob/master/Podfile) for an example of how the repo URL is included

##5.4 [How to remove a Private Repo](https://guides.cocoapods.org/making/#how-to-remove-a-private-repo)

`pod repo remove [name]`

##5.5 [External resources](https://guides.cocoapods.org/making/#external-resources)

- [Using CocoaPods to Modularise a Big iOS App by @aroldan](http://dev.hubspot.com/blog/architecting-a-large-ios-app-with-cocoapods)

#6 [Specs and the Specs Repo](https://guides.cocoapods.org/making/specs-and-specs-repo.html)

Learn about creating Podspec's and the Spec repo.

A Podspec, or Spec, describes a version of a Pod library. One Pod, over the course of time, will have many Specs. It includes details about where the source should be fetched from, what files to use, the build settings to apply, and other general metadata such as its name, version, and description.

You can create one by hand, or run `pod spec create` to generate a stub. Podspecs are ruby files.

> Here is an example spec:

```
Pod::Spec.new do |spec|
  spec.name             = 'Reachability'
  spec.version          = '3.1.0'
  spec.license          = { :type => 'BSD' }
  spec.homepage         = 'https://github.com/tonymillion/Reachability'
  spec.authors          = { 'Tony Million' => 'tonymillion@gmail.com' }
  spec.summary          = 'ARC and GCD Compatible Reachability Class for iOS and macOS.'
  spec.source           = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' }
  spec.source_files     = 'Reachability.h,m'
  spec.framework        = 'SystemConfiguration'
  spec.requires_arc     = true
end

```

The [Specs Repo](https://github.com/CocoaPods/Specs) is the repository on GitHub that contains the list of all available pods. Every library has an individual folder, which contains sub folders of the available versions of that pod. 

See the [Private Pods](https://guides.cocoapods.org/making/private-cocoapods.html) section for an explanation of the Spec repo's file structure.

##6.1 [Examples of Specifications](https://guides.cocoapods.org/making/#examples-of-specifications)

> A Simple specification.

```
Pod::Spec.new do |spec|
  spec.name         = 'libPusher'
  spec.version      = '1.3'
  spec.license      = 'MIT'
  spec.summary      = 'An Objective-C client for the Pusher.com service'
  spec.homepage     = 'https://github.com/lukeredpath/libPusher'
  spec.author       = 'Luke Redpath'
  spec.source       = { :git => 'git://github.com/lukeredpath/libPusher.git', :tag => 'v1.3' }
  spec.source_files = 'Library/*'
  spec.requires_arc = true
  spec.dependency 'SocketRocket'
end

```

> A specification with subspecs

```
Pod::Spec.new do |spec|
  spec.name          = 'ShareKit'
  spec.source_files  = 'Classes/ShareKit/{Configuration,Core,Customize UI,UI}/**/*.{h,m,c}'
  # ...

  spec.subspec 'Evernote' do |evernote|
    evernote.source_files = 'Classes/ShareKit/Sharers/Services/Evernote/**/*.{h,m}'
  end

  spec.subspec 'Facebook' do |facebook|
    facebook.source_files   = 'Classes/ShareKit/Sharers/Services/Facebook/**/*.{h,m}'
    facebook.compiler_flags = '-Wno-incomplete-implementation -Wno-missing-prototypes'
    facebook.dependency 'Facebook-iOS-SDK'
  end
  # ...
end

```

[Subspecs](https://guides.cocoapods.org/syntax/podspec.html#group_subspecs) are a way of chopping up the functionality of a Podspec, allowing people to install a subset of your library. 

With the above example a Podfile using `pod 'ShareKit'` results in the inclusion of the whole library, while `pod 'ShareKit/Facebook'` can be used if you are interested only in the Facebook specific parts.

###6.1.1 [A specification with subspecs within submodules](https://guides.cocoapods.org/making/#a-specification-with-subspecs-within-submodules)

If you have some submodules in the repository you need to set the `:submodules` key of the `s.source` hash to true. Then you'll be able to specify subspec like above.

```
Pod::Spec.new do |spec|
  spec.name          = 'SDLoginKit'
  spec.source        =  { 
      :git => 'https://github.com/dulaccc/SDLoginKit.git',
      :tag => '1.0.2', 
      :submodules => true 
  }
  # ...

  spec.subspec 'SDKit' do |sdkit|
    sdkit.source_files = 'SDKit/**/*.{h,m}'
    sdkit.resources    = 'SDKit/**/Assets/*.png'
  end
  # ...
end

```

##6.2 [How does the Specs Repo work?](https://guides.cocoapods.org/making/#how-does-the-specs-repo-work)

To ensure a high quality, reliable collection of Pods, the Specs Repo is strict about the podspecs added. One of the primary purposes of this repo is to guarantee the integrity of existing CocoaPods installations.

When you are preparing a podspec for submission, you should make sure to do the following:

1. Run `pod spec lint`. This is used to validate specifications. Your podspec should pass without any errors or warnings.
2. Update your library to use [Semantic Versioning](http://semver.org/), if it already does not follow that scheme. See our [wiki on cross dependency resolution](https://github.com/CocoaPods/Specs/wiki/Cross-dependencies-resolution-example) for more details. Essentially it makes everyone's life easier.
3. Make sure any updates you submit do not break previous installations.
4. Perform manual testing of your Podspec by [including the local Podspec](https://guides.cocoapods.org/syntax/podfile.html#pod) in the Podfile of a real application and/or your demo application, and ensuring it works as expected. **You alone** are responsible for ensuring your Podspec functions properly for your users.

In general this means that:

- A specification cannot be deleted.
- Specifications can be updated only if they don't affect existing installations.
  - Broken specifications can be updated.
  - Subspecs can be added as they are included by the parent specification by default.
- Only authoritative versions are accepted.

##6.3 [How do I update an existing Pod?](https://guides.cocoapods.org/making/#how-do-i-update-an-existing-pod)

1. Create your Podspec as described above.
2. Run `pod spec lint` to check for errors.
3. Submit your Podspec to Trunk with `pod trunk push NAME.podspec`

##6.4 [How do I get my library on CocoaDocs?](https://guides.cocoapods.org/making/#how-do-i-get-my-library-on-cocoadocs)

[CocoaDocs](http://cocoadocs.org) receives notifications from the [CocoaPods/Specs](https://github.com/CocoaPods/Specs) repo on GitHub whenever a CocoaPod is updated. This triggers a process that will generate documentation for *objective-c*projects via [appledoc](http://gentlebytes.com/appledoc/) and host them for the community. This process can take around 15 minutes after your Podspec is merged. If you host your own documentation, you can use the [documentation_url](https://guides.cocoapods.org/syntax/podspec.html#documentation_url).