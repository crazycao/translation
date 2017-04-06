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

###2.1.1 [The Pod Files](https://guides.cocoapods.org/making/#the-pod-files)

There are only a few differences between a CocoaPod and a generic open source library. The most important ones, aside from the actual source, are the `.podspec` and `LICENSE`. We do not accept libraries into the trunk without a code license. For information on what license to choose, we suggest reading [this article on CodingHorror](http://www.codinghorror.com/blog/2007/04/pick-a-license-any-license.html) or [tl;dr Legal](http://www.tldrlegal.com/).

####2.1.1.1 [Development](https://guides.cocoapods.org/making/#development)

You can work on the library from its folder on your system.

> Alternatively you can work from an application project using the `:path` option:

```
pod 'Name', :path => '~/code/Pods/'
```

####2.1.1.2 [Testing](https://guides.cocoapods.org/making/#testing)

You can test the syntax of your Podfile by linting the pod against the files of its directory, this won't test the downloading aspect of linting.

```
$ cd ~/code/Pods/NAME
$ pod lib lint

```

Before releasing your new Pod to the world its best to test that you can install your pod successfully into an Xcode project. You can do this in a couple of ways:

> Push your podspec to your repository, then create a new Xcode project with a Podfile and add your pod to the file like so:

```
pod 'NAME', :git => 'https://example.com/URL/to/repo/NAME.git'

```

> Then run

```
pod install
-- or --
pod update

```

> Alternatively if you have a separate Xcode project for your unit tests you can use a Podfile for this project that references your development podspec

```
xcodeproj 'NAMETests'
workspace '../NAME'

pod 'NAME', :path => '../'
```

####2.1.1.3 [Release](https://guides.cocoapods.org/making/#release)

Once you have a release ready you'll need to make the corresponding tag. First run a quick `pod lib lint` then create your tag and push it.

> The release workflow is similar to the following.

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

#####2.1.1.3.1 Submitting Open Source Code

Once your tags are pushed you can use the command:

```
pod trunk push NAME.podspec

```

to send your library to the Specs repo. For more information on getting this setup see [Getting Setup With Trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk).

#####2.1.1.3.2 Submitting Private Code

Once your tags are pushed you can use the command:

```
pod repo push [repo] NAME.podspec

```

to send your library to the named private specs repo. For more information on getting this setup see [Private CocoaPods](https://guides.cocoapods.org/making/private-cocoapods).

###2.1.2 [Library Versioning](https://guides.cocoapods.org/making/#library-versioning)

There is, unfortunately, often an issue of developers not interpreting version numbers well or assigning emotional value to certain version numbers.

However, arbitrary revisions as version is not a good idea for a library manager instead of a proper version number (see [Semantic Versioning](http://semver.org)). Let us explain how, in an ideal world, we’d prefer people to interact with it:

- “I want to start using CocoaLumberjack, the current version will be fine for now.” So the dev adds a dependency on the lib *without* a version requirement and `pod install`s which will use the latest version:

```
  pod 'CocoaLumberjack'

```

- Some time into the future, the dev wants to update the dependencies, and to do so runs the install command again, which will now install the version of the lib which is the latest version *at that time*.
- At some point the dev is finished on the client work (or a newer version of the lib changes the API and the changes aren’t needed) so the dev adds a version requirement to the dependency. For instance, consider that the author of the lib follows the semver guidelines, you can somewhat trust that between ‘1.0.7’ and ‘1.1.0’ **no** API changes will be made, but only bug fixes. So instead of requiring a specific version, the dev can specify that *any* ‘1.0.x’ is allowed as long as it’s higher than ‘1.0.7’:

```
pod 'CocoaLumberjack', '~> 1.0.7'

```

The point is that developers can easily keep track of newer versions of dependencies, by simply running `pod install` again, which they might otherwise do less if they had to change everything manually. CocoaPods uses a less stringent form of Semantic versioning in that it will not force you to use `X.Y.Z`, you can use `X.Y` versions.

####2.1.2.1 [CocoaPods Versioning Specifics](https://guides.cocoapods.org/making/#cocoapods-versioning-specifics)

CocoaPods uses RubyGems versions for specifying pod spec versions. The [RubyGems Versioning Policies](http://guides.rubygems.org/patterns/#semantic-versioning) describes the rules used for interpreting version numbers. The [RubyGems version specifiers](http://guides.rubygems.org/patterns/#declaring-dependencies) describes exactly how to use the comparison operators that specify dependency versions.

Following the pattern established in RubyGems, pre-release versions can also be specified in CocoaPods. A pre-release of version 1.2, for example, can be specified by `1.2-beta3`. In this example, the dependency specifier `~> 1.2-beta` will match `1.2-beta3`.

There's a great video from Google about how this works: ["CocoaPods and the Case of the Squiggly Arrow (Route 85)"](https://www.youtube.com/watch?v=x4ARXyovvPc).

###2.1.3 [Documenting a Pod](https://guides.cocoapods.org/making/#documenting-a-pod)

Right now the best place to get information on documenting your Pods is NSHipster's blog post on [Obj-C](http://nshipster.com/documentation/) and [Swift](http://nshipster.com/swift-documentation/) Documentation. [CocoaDocs](http://github.com/cocoapods/cocoadocs.org) will release an appledoc/jazzy parsed code based on your Podspec's public API roughly 15 minutes after it is pushed. More information on CocoaDocs can be found on the [CocoaDocs developer README](http://cocoadocs.org/readme)

###2.1.4 [Where can I ask questions?](https://guides.cocoapods.org/making/#where-can-i-ask-questions)

We have multiple avenues for support, here they are in the order we prefer.

- [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods), get yourself some internet points. This keeps the pressure off the CocoaPods dev team and gives us time to work on the project and not support. One of the advantages of using Stack Overflow is that the answer is then easily accessible for others.
- [CocoaPods Mailing List](http://groups.google.com/group/cocoapods), the mailing list is mainly used for announcements of related projects and occasionally for support.

###2.1.5 [External resources](https://guides.cocoapods.org/making/#external-resources)

- [Why your podspec is failing](http://codeslingers.co.uk/2014/05/16/why-your-podspec-is-failing/)

##2.2 [Using Pod Lib Create](https://guides.cocoapods.org/making/using-pod-lib-create.html)

The guide for getting a CocoaPod up and running quickly.

###2.2.1 Getting started

We're going to through the creation of an entire pod using `pod lib create` to bootstrap the process. So let's start with the initial command:

```
pod lib create MyLibrary

```

> Note: To use your own [pod-template](https://github.com/cocoapods/pod-template) you can add the parameter `--template-url=URL` where URL is the git repo containing a compatible template.
> Second Note: you can press return to select the default (underlined) option.

###2.2.2 [Objective-C or Swift](https://guides.cocoapods.org/making/#objective-c-or-swift)

The first question you're asked is what language you want to build a pod in. For both choices CocoaPods will set up your library as a framework.

###2.2.3 [Making a Demo Application](https://guides.cocoapods.org/making/#making-a-demo-application)

The template will generate an Xcode project for your library. This means you don't have to go through creating a new project in Xcode.

If you want to have an example project for `pod try MyLib` or need to have your library's tests run inside an application ( interaction tests, custom fonts, etc ) then you should say yes. A good metric is *"Should this Pod include a screenshot?"*; if so, then you should have a demo.

###2.2.4 [Choosing a Test Framework](https://guides.cocoapods.org/making/#choosing-a-test-framework)

You should be testing your library. Testing ensures stability for people using your library. In open source libraries this means people can make changes knowing that they haven't broken implicit expectations. We recommend using a testing framework rather than relying on Apple's XCTest but that is included. In Objective-C we include a choice of two popular testing frameworks; Specta/Expecta and Kiwi. If you can't decide, use Specta/Expecta.

####2.2.4.1 Specta/Expecta

A light-weight TDD / BDD framework for Objective-C & Cocoa.

> [GitHub repo](https://github.com/specta/specta)

####2.2.4.2 Kiwi

Kiwi is a Behaviour Driven Development library for iOS development. The goal is to provide a BDD library that is exquisitely simple to setup and use.

> [GitHub repo](https://github.com/kiwi-bdd/Kiwi)

The major differences is that Kiwi is an all-in-one approach to Stubs/Mocks/Expectations whereas Specta/Expecta is a modular approach through different Podspecs. We include all the necessary includes and setup for your testing framework in `MyLib-Tests.pch` so that you don't have to include them in each file.

In Swift we only offer the choice of [Quick/Nimble](https://github.com/Quick/Quick) as this looks to be the dominant testing library.

###2.2.5 [View-based Testing](https://guides.cocoapods.org/making/#view-based-testing)

Depending on what library you are building you may find Snapshot based testing to be a smart way to verify the results of [different](https://github.com/neilang/NAMapKit/blob/master/Demo/DemoTests/NAInteractiveDemoViewControllerTests.m) [actions](https://github.com/orta/ORStackView/blob/master/ORStackViewExampleTests/ORFourthViewControllerTests.m) [on](https://github.com/liaojinxing/StarRatingView/blob/599390e258b44e8efe2121356bac5d74494086f9/StarRatingViewTests/StarRatingViewTests.m) [your](https://github.com/AshFurrow/ARCollectionViewMasonryLayout/blob/58f2b987756bd1d1b710a74c51aa48204006fc99/IntegrationTests/ARCollectionViewMasonryLayoutTests.m) [views](https://github.com/yujinakayama/NAKPlaybackIndicatorView/blob/b81c29b399e109c56024eefdffd89dfd606d662c/Tests/SnapshotTests.m). We recommend using [FBSnapShotTestCase](https://github.com/facebook/ios-snapshot-test-case), if you are using Specta/Expecta then we [include a Pod](https://github.com/dblock/ios-snapshot-test-case-expecta) to improve the syntax.

###2.2.6 [Prefixes for Objective-C](https://guides.cocoapods.org/making/#prefixes-for-objective-c)

To wrap up an Objective-C project we want to know your class prefix. This means that we can make all the classes generated by CocoaPods fit in with your style, also all classes generated from inside Xcode will start with your prefix. We know that Apple is deprecating prefixes, but in reality they still have their place in Objective-C codebases.

###2.2.7 [The Pod Lib Create Template](https://guides.cocoapods.org/making/#the-pod-lib-create-template)

With the questions over, we run `pod install` on the newly created Project. Let's look at the results:

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

- `.travis.yml` - a setup file for [travis-ci](https://travis-ci.org/).
- `_Pods.xcproject` - a symlink to your Pod's project for Carthage support
- `LICENSE` - defaulting to the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
- `MyLib.podspec` - the Podspec for your Library.
- `README.md` - a default README in markdown.
- `RemoveMe.swift/m` - a single file to to ensure compilation works initially.

and the following folders:

- `Pod` - This is where you place your library's classes
- `Example` - This is the generated Demo & Testing bundle

###2.2.8 [Putting your Library Together](https://guides.cocoapods.org/making/#putting-your-library-together)

CocoaPods will open your Xcode project straight away; from there you can edit all of the files generated by CocoaPods. Let's look at an expanded version of Xcode:

[![img](https://guides.cocoapods.org/assets/images/pod_lib_create/xcode.png)](https://guides.cocoapods.org/assets/images/pod_lib_create/xcode.png)

1. You can edit your Podspec metadata, this lets you change your README and Podspec.
2. This is the Demo Library, you will be missing this if you didn't say yes to it.
3. Here is a stubbed out test spec for the framework you had chosen earlier.
4. This is the Development Pods section, and actually where you can work on your library. See below for more information.
5. Finally the Pods used in setting up the project.

It's worth mentioning here, as this catches people quite often, a Swift library needs to have its classes declared as `public` for you to see them in your example library.

####2.2.8.1 Development Pods

Development Pods are different from normal CocoaPods in that they are symlinked files, so making edits to them will change the original files, so you can work on your library from inside Xcode. Your demo & tests will need to include references to headers using the `#import <MyLib/XYZ.h>`format.

> `[!] Note:` Due to a Development Pods implementation detail, when you add new/existing files to `Pod/Classes` or `Pod/Assets` or update your podspec, you should run `pod install` or `pod update`.

###2.2.9 [Adding Travis CI](https://guides.cocoapods.org/making/#adding-travis-ci)

The template includes a `.travis.yml` file that will run the default tests included in the project. If you have an open source repo on GitHub, open [your profile](https://travis-ci.org/profile/) on Travis CI and turn the library on.

![/assets/images/pod_lib_create/travis-ci.png](https://guides.cocoapods.org/assets/images/pod_lib_create/travis-ci.png)

###2.2.10 [Deploying your Library](https://guides.cocoapods.org/making/#deploying-your-library)

So you've got your library ready to go. First you should check if the Podspec lints correctly, as you can't deploy with errors. This can be done with two methods, `pod lib lint` and `pod spec lint`. The difference between them is that `pod lib lint` does not access the network, whereas `pod spec lint` checks the external repo and associated tag.

If you're deploying an Open Source library to [trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk), you cannot have CocoaPods warnings. You can have Xcode warnings though. You should continue to the [getting started with trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk) guide to deploy to the public.

If you're deploying to a private Specs repo, you will need to have already added that repo. See the guides on [Private Specs Repos](https://guides.cocoapods.org/making/private-cocoapods) to set that up. If you are deploying to an existing Private Repo, use this command to deploy:

```
pod repo push SPEC_REPO *.podspec --verbose

```

###2.2.11 [Done](https://guides.cocoapods.org/making/#done)

👍

#3 [Getting setup with Trunk](https://guides.cocoapods.org/making/getting-setup-with-trunk.html)

Instructions for creating a CocoaPods user account

##3.1 CocoaPods Trunk

CocoaPods Trunk is an authentication and CocoaPods API service. To publish new or updated libraries to CocoaPods for public release you will need to be registered with Trunk and have a valid Trunk session on your current device. You can read about Trunk's history and development on [the blog](https://blog.cocoapods.org/CocoaPods-Trunk/), and about [private pods](https://guides.cocoapods.org/making/private-cocoapods.html) for yourself or your team.

CocoaPods Trunk is available starting with CocoaPods 0.33. A collection of commands under `pod trunk` automate the deployment and management of your Podspecs. At any time you can run `pod trunk [command] --help` to see inline help.

###3.1.1 [Getting started](https://guides.cocoapods.org/making/#getting-started)

First sign up for an account with your email address. This begins a session on your current device.

We recommend including a description with your session to give some context when you list your sessions later. For example:

```
$ pod trunk register orta@cocoapods.org 'Orta Therox' --description='macbook air'

```

You must click a link in an email Trunk sends you to verify the connection between your Trunk account and the current computer. You can list your sessions by running `pod trunk me`.

Trunk accounts do not have passwords, only per-computer session tokens.

###3.1.2 [Deploying a library](https://guides.cocoapods.org/making/#deploying-a-library)

`pod trunk push [NAME.podspec]` will deploy your Podspec to Trunk and make it publicly available. You can also deploy Podspecs to your own private specs repo with `pod repo push REPO [NAME.podspec]`.

Deploying with `push`:

- Lints your Podspec locally. You can lint at any time with `pod spec lint [NAME.podspec]`
- A successful lint pushes your Podspec to Trunk or your private specs repo
- Trunk will publish a canonical JSON representation of your Podspec

Trunk will also post a web hook to other services alerting them of a new CocoaPod, for example [CocoaDocs.org](http://cocoadocs.org) and [@CocoaPodsFeed](https://twitter.com/cocoapodsfeed).

###3.1.3 [Adding other people as contributors](https://guides.cocoapods.org/making/#adding-other-people-as-contributors)

The first person to push a Podspec version to Trunk can add other maintainers. For example, to add `kyle@cocoapods.org` to the library `ARAnalytics`:

```
$ pod trunk add-owner ARAnalytics kyle@cocoapods.org

```

This will then list all the known library owners. Note: they need to already have registered an account set up on trunk in order for you to add them to a library.

###3.1.5 [Claiming an existing library](https://guides.cocoapods.org/making/#claiming-an-existing-library)

If you want to claim a library that someone has already claimed, then you can use [our Claims form](https://trunk.cocoapods.org/claims/new)to say that you are the owner or maintainer of a collection of libraries. Any issues regarding ownership of libraries will be arbitrated by the CocoaPods dev team.

#4 [Quality Indexes](https://guides.cocoapods.org/making/quality-indexes.html)

Increasing your CocoaPod's Search Rank

After the submission of a Podspec to [Trunk](https://guides.cocoapods.org/making/making/getting-setup-with-trunk.html), the documentation service CocoaDocs generates a collection of metrics for the Pod. You can look these metrics for any Pod on [metrics.cocoapods.org/api/v1/pods/[Pod\]](http://metrics.cocoapods.org/api/v1/pods/ORStackView). These metrics are used to generate a variety of Quality Modifiers which eventually turns into a single number called the Quality Index.

This document is a form of [literate programming](https://en.wikipedia.org/wiki/Literate_programming#cite_note-19) within the [CocoaDocs-API](https://github.com/CocoaPods/cocoadocs-api/blob/master/quality_modifiers.rb). As such it contains the actual ruby code that is ran in order to generate the individual scores. Plus, Swift looks like Ruby anyway - so you can read it ;).

The aim of the Quality Index is to highlight postive metrics, and downplay the negative. It is very possible to have a Pod for which no modifier is actually applied. Meaning the Index stays at the default number of 50. This is a pretty reasonable score.

A good example of the mentality we have towards the modifiers is to think of a Pod with a majority of it's code in Swift. It gets a boost, while an Objective-C one doesn't get modified. It's not about reducing points for Objective-C, but highlighting that right now a Swift library represents forward thinking best practices.

Finally, before we get started. These metrics are not set in stone, they have been evolving since their unveiling and will continue to do so in the future. Feedback is appreciated, ideally in [issues](https://github.com/CocoaPods/cocoapods.org/issues/new) - so they can be discussed.

##4.1 Popularity Metrics

It's a pretty safe bet that an extremely popular library is going to be a well looked after, and maintained library. We weighed different metrics according to how much more valuable the individual metric is rather than just using stars as the core metric.

```
 Modifier.new("Very Popular", "The popularity of a project is a useful way of discovering if it is useful, and well maintained.", 30, { |...|
   value = stats[:contributors].to_i * 90 +  stats[:subscribers].to_i * 20 +  stats[:forks].to_i * 10 + stats[:stargazers].to_i
   value > 9000
 }),

```

However, not every idea needs to be big enough to warrent such high metrics. A high amount of engagement is useful in it's own right.

```
 Modifier.new("Popular", "A popular library means there can be a community to help improve and maintain a project.", 10, { |...|
   value = stats[:contributors].to_i * 90 +  stats[:subscribers].to_i * 20 +  stats[:forks].to_i * 10 + stats[:stargazers].to_i
   value > 1500
 }),

```

At the moment this is entirely focused on libraries that are coming from GitHub. In the future, once Stats for downloads/installs are mature then we will move over to that in order to accomodate libraries not using GitHub.

##4.2 Swift Package Manager

We want to encourage support of Apple's Swift Package Manager, it's better for the community to be unified. For more information see our [FAQ](https://guides.cocoapods.org/using/faq.html). This currently checks for the existence of `Package.swift`, once SPM development has slowed down, we may transistion to testing that it supports the latest release.

```
 Modifier.new("Supports Swift Package Manager", "Supports Apple's official package manager for Swift.", 10, { |...|
   cd_stats[:spm_support]
 }),

```

##4.3 Inline Documentation

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