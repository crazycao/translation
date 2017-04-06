#1 Using CocoaPods
原文链接：[https://guides.cocoapods.org/using/getting-started.html](https://guides.cocoapods.org/using/getting-started.html)

#1.1 Using Unreleased Features
Instructions to use CocoaPods from a feature branch or a Work-in-progress fork

从特性分支或开发中的分支使用CocoaPods的介绍。
##1.1.1 Using Unreleased Features 使用未发布的特性
There may be times when you may want to test an upcoming feature in CocoaPods. At times code for such features may be already available in a 'feature branch'. This document is based on an existing Pull Request which can/will change with time, as such it may be out of date slightly.

你可能有好几次想要在CocoaPods中试试即将发布的特性。有时这些特性的代码已经存在于‘特性分支’中是可用的了。本节是基于现有的Pull请求的介绍，它可能/将会随时改变，因为它可能已经稍微过时了。

##1.1.2 Two Options
###1.1.2.1 Use a Gemfile
This isn't covered in this guide, but instead in Using a Gemfile. This is a simpler technique, but requires you to remember to use bundle exec before running any pod command.

###1.1.2.2 Set up a local dev copy of CocoaPods
The technique to run a branch version of CocoaPods is:

* Clone a copy of CocoaPods locally.
* Check out the version to the branch you want.
* Run bundle install to get CocoaPods set up.
* Use the full path to the new pod binary, instead of the one installed via rubygems.

Then when you want to update you go back to that local install and run git pull, then bundle install again.

##1.1.3 Real world walk-through
Let's use @mrackwitz's Swift Pull Request CocoaPods#2835 as a example. Note, the swift branch does not exist anymore. You can see all the current branches here.

###1.1.3.1 Clone a local copy
By looking at the subheading mrackwitz wants to merge 85 commits into master from swift you can infer that this pull request comes from a branch on the CocoaPods repo. If it looked like Pull Request CocoaPods#2880 ([...] CocoaPods:master from samdmarshall:xclegacy-build-setting-build-dir-fix) then you could see that it comes from the samdmarshall fork and you would need to clone from that repo.

	Cloning a local copy
	cd projects/cocoapods/
	git clone https://github.com/CocoaPods/CocoaPods.git
###1.1.3.2 Check out the branch, and run bundle install
This is easy for our pull request, we first need to cd in to the new folder :

	cd CocoaPods
	git checkout swift
	bundle install
###1.1.3.3 Using the new version as your pod command
The new pod command lives in the git repo you have just cloned. It can be found in the bin folder.

To get the full path of the command for CocoaPods run:

	echo $(pwd)"/bin/pod"
	# e.g. /Users/orta/spiel/ruby/CocoaPods/bin/pod
This is the command you can use to run the branch version of CocoaPods:

	cd ~/projects/dev/eidolon
	/Users/orta/spiel/ruby/CocoaPods/bin/pod install

###1.1.3.4 Aliasing the command
The terminal supports using aliases as a way of reducing the length of commands. The default terminal shell is called bash, if you'd like to learn how to set a bash alias I would recommend reading this StackOverflow. You can create an alias like spod that uses this folder:

	alias spod='/Users/orta/spiel/ruby/CocoaPods/bin/pod'
This means you can instead run spod install to use your custom version of CocoaPods.

###1.1.3.5 Alternative options
Another option is to use Bundler ( CocoaPods for ruby projects ) to maintain your own fork/branches, this is a better option if you are in a team and want to ensure consistency within developers. See CocoaPods Is Ready for Swift for an example of how to do this.

#1.2 Geting Started
This is a guide for setting up CocoaPods and working with your first project.

搭建CocoaPods并在你的第一个工程中使用的引导。
##1.2.1 What is CocoaPods 什么是CocoaPods？
CocoaPods manages library dependencies for your Xcode projects.

CocoaPods管理了Xcode工程的库依赖。

The dependencies for your projects are specified in a single text file called a Podfile. CocoaPods will resolve dependencies between libraries, fetch the resulting source code, then link it together in an Xcode workspace to build your project.

工程依赖在一个成为Podfile的独立文本文件中指明。CocoaPods将会分析两个库的依赖关系，获取最终的源码，然后在Xcode工作空间中将它们链接到一起以构建你的工程。

Ultimately the goal is to improve discoverability of, and engagement in, third party open-source libraries by creating a more centralised ecosystem.

最终目标是通过创建一个更集中化的生态系统提高第三方开源库的可发现度和嵌入便捷度。

###1.2.2 Prefer video? 更喜欢视频？
Google have created a great overview for Route 85 video series going through this entire guide and more.

谷歌已经创建了一个伟大的85路系列视频概述，贯穿整个指南和其他部分。

[视频连接](https://www.youtube.com/watch?v=iEAjvNRdZa0&spfreload=10)

###1.2.3 Getting Started 开始
####1.2.3.1 Installation 安装

CocoaPods is built with Ruby and it will be installable with the default Ruby available on macOS. You can use a Ruby Version manager, however we recommend that you use the standard Ruby available on macOS unless you know what you're doing.

CocoaPods用Ruby语言构建，所以需要在macOS上默认Ruby可用才能安装。你可以使用Ruby版本管理器，但是我们建议在macOS上使用标准版的Ruby，除非你知道你在干什么。

Using the default Ruby install will require you to use sudo when installing gems. (This is only an issue for the duration of the gem installation, though.)

使用默认Ruby安装需要你在安装gem时使用sudo命令。（这是在安装gem的过程中的唯一问题。）

	$ sudo gem install cocoapods

If you encounter any problems during installation, please visit this guide.

如果你在安装过程中遭遇任何问题，请参考本指南。

####1.2.3.2 Sudo-less installation 不使用Sudo的安装

If you do not want to grant RubyGems admin privileges for this process, you can tell RubyGems to install into your user directory by passing either the --user-install flag to gem install or by configuring the RubyGems environment. The latter is in our opinion the best solution. To do this, create or edit the .profile file in your home directory and add or amend it to include these lines:

如果你不想为这个进程给予RubyGems管理员特权，你可以让RubyGems安装到你的用户目录下，通过传递*--user-install*标识到gem安装，或者通过配置RubyGems环境也可以。在我们看来后者是最好的解决方案。要做到这个，需要在你的home目录里创建或者编辑.profile文件，添加或修改文件包含以下行：

	export GEM_HOME=$HOME/.gem
	export PATH=$GEM_HOME/bin:$PATH

Note that if you choose to use the --user-install option, you will still have to configure your .profile file to set the PATH or use the command prepended by the full path. You can find out where a gem is installed with gem which cocoapods. E.g.

注意如果你选择使用*--user-install*设置，你仍然要配置.profile文件设置PATH，或者通过完整路径使用预置的命令。你可以使用*gem which cocoapods*找到gem安装在哪儿。例如：

	$ gem install cocoapods --user-install
	$ gem which cocoapods
	/Users/eloy/.gem/ruby/2.0.0/gems/cocoapods-0.29.0/lib/cocoapods.rb
	$ /Users/eloy/.gem/ruby/2.0.0/bin/pod install

####1.2.3.3 Updating CocoaPods 更新CocoaPods

To update CocoaPods you simply install the gem again

要更新CocoaPods只要简单的再安装gem就好。

	$ [sudo] gem install cocoapods

Or for a pre-release version 

或者使用先前发布的版本。

	$ [sudo] gem install cocoapods --pre

If you originally installed the cocoapods gem using sudo, you should use that command again.

如果你最开始使用了sudo命令安装cocoapods gem，那你这里需要再次使用这个命令。

Later on, when you're actively using CocoaPods by installing pods, you will be notified when new versions become available with a *CocoaPods X.X.X is now available, please update* message.

在这以后，当时正在通过安装pods使用CocoaPods时，如果有新版本可用，你将会收到消息通知，*CocoaPods X.X.X is now available, please update*。

####1.2.3.4 Using a CocoaPods Fork 使用CocoaPods分支

There are two ways to do this, using a Gemfile (recommended) or using a development build that are in discussion or in implementation stage.

有两种方法可以实现，[using a Gemfile](https://guides.cocoapods.org/using/a-gemfile.html)（推荐），或者使用还在讨论或实现阶段的[development build](https://guides.cocoapods.org/using/unreleased-features)。

###1.2.4 External resources 扩展资源
* [CocoaPods at Treehouse](http://teamtreehouse.com/library/ios-tools/cocoapods/cocoapods)

###<span id="1">1.3 pod install vs. pod update  
Explains the difference between pod install and pod update and when to use each.

解释*pod install*和*pod update*的区别，以及什么时候该使用哪个。[id]

###1.3.1 Introduction 介绍

Many people starting with CocoaPods seem to think pod install is only used the first time you setup a project using CocoaPods and pod update is used afterwards. But that's not the case at all.

许多刚开始使用CocoaPods的人似乎认为*pod install*只用于第一次建立使用CocoaPods的工程，而在这之后要用*pod update*。但这并不完全正确。

The aim of this guide is to explain when you should use pod install and when you should use pod update.

这篇引导的目的就是解释什么该使用*pod install*什么时候该使用*pod update*。

_TL;DR:_

*  Use *pod install* to install new pods in your project. Even if you already have a Podfile and ran pod install before; so even if you are just adding/removing pods to a project already using CocoaPods.

   *使用*pod install*在你的工程里安装新的pods。尽管你已经有了一个*Podfile*并且之前运行过*pod install*；尽管你只是在已经使用了CocoaPods的工程中添加/移除了pod，你都要使用*pod install*。

   *Use *pod update [PODNAME]* only when you want to update pods to a newer version.

   *只有在你想要更新pods到新的版本时才使用*pod update [PODNAME]*。

###1.3.2 Detailed presentation of the commands 这两个命令的详细表达式

Note: the vocabulary of install vs. update is not actually specific to CocoaPods. It is inspired by a lot of other dependency managers like bundler, RubyGems or composer, which have similar commands, with the exact same behavior and intents as the one described in this document.

注意：*install*和*update*这两个词实际上并不是CocoaPods独有的。它们也被许多其他依赖的管理器推荐使用，如bundler，RubyGems或者composer，它们都有类似的命令，并且有与本文描述完全相同的行为和意图。

####1.3.2.1 pod install

This is to be used the first time you want to retrieve the pods for the project, but also every time you edit your Podfile to add, update or remove a pod.

用于工程中第一次取回pods，也用于每次编辑**Podfile**添加、更新或移除pod时。

* Every time the pod install command is run — and downloads and install new pods — it writes the version it has installed, for each pods, in the Podfile.lock file. This file keeps track of the installed version of each pod and locks those versions.

* 每次运行*pod install*命令时——下载和安装新的pods——并将每个已经安装的pods的版本号写入**Podfile.lock**文件。这个文件会保持对每个pod已安装的版本的跟踪，并且锁定这些版本。

* When you run pod install, it only resolves dependencies for pods that are not already listed in the Podfile.lock.

* 当你运行*pod install*时，它只会处理没有被记录在**Podfile.lock**文件中的pods的依赖。

  * For pods listed in the Podfile.lock, it downloads the explicit version listed in the Podfile.lock without trying to check if a newer version is available

  * 对于已经记录在**Podfile.lock**中的pods，会下载记录在**Podfile.lock**文件中的准确版本，而不去检查是否有新版本可用。

  * For pods not listed in the Podfile.lock yet, it searches for the version that matches what is described in the Podfile (like in pod 'MyPod', '~>1.2')

  * 对于没有记录在**Podfile.lock**文件中的pods，会查找匹配**Podfile**中描述的版本（如*pod 'MyPod', '~>1.2'*）。

####1.3.2.2 pod outdated

When you run pod outdated, CocoaPods will list all pods which have newer versions than the ones listed in the Podfile.lock (the versions currently installed for each pod). This means that if you run pod update PODNAME on those pods, they will be updated — as long as the new version still matches the restrictions like pod 'MyPod', '~>x.y' set in your Podfile.

当你运行*pod outdated*命令，CocoaPods会列出所有有新版本的pods，新版本是指比记录在**Podfile.lock**文件中的版本（即当前每个pod安装的版本）更新的版本。这意味着如果你对这些pod运行*pod update PODNAME*，它们将会更新——只要这些版本仍然满足如*pod 'MyPod', '~>x.y'*这样设置在**Podfile**中的约束。

####1.3.2.3 pod update

When you run pod update PODNAME, CocoaPods will try to find an updated version of the pod PODNAME, without taking into account the version listed in Podfile.lock. It will update the pod to the latest version possible (as long as it matches the version restrictions in your Podfile).

当你运行*pod update PODNAME*命令，CocoaPods将会尝试找到*PODNAME*指定pod的更新版本，而不会顾及**Podfile.lock**文件中记录的版本。它将会更新pod的最新可用版本（只要满足**Podfile**中的版本约束）。

If you run pod update with no pod name, CocoaPods will update every pod listed in your Podfile to the latest version possible.

如果你运行*pod update*而不带pod名称，CocoaPods将会更新**Podfile**文件中记录的每一个pod到最新可用版本。

###1.3.3 Intended usage 推荐用法

With pod update PODNAME, you will be able to only update a specific pod (check if a new version exists and update the pod accordingly). As opposed to pod install which won't try to update versions of pods already installed.

使用*pod update PODNAME*，你可以只更新指定的pod（检查是否存在新版本并相应的更新这个pod）。相反*pod install*不会尝试更新已经安装的pod的版本。

When you add a pod to your Podfile, you should run pod install, not pod update — to install this new pod without risking to update existing pod in the same process.

当你添加一个pod到你的**Podfile**，你应该运行*pod install*，而不是*pod update*——才能安装这个新的pod，同时不会带来在同一个处理过程中更新已存在的pod的风险。

You will only use pod update when you want to update the version of a specific pod (or all the pods).

当你想要更新指定pod（或所有pod）的版本时，应该只使用*pod update*。

###1.3.4 Commit your Podfile.lock 提交Podfile.lock文件

As a reminder, even if your policy is not to commit the Pods folder into your shared repository, you should always commit & push your Podfile.lock file.

作为提醒，除非你的策略是*不能提交Pods文件夹到共享仓库*，否则你应该总是提交并推送你的**Podfile.lock**文件。

Otherwise, it would break the whole logic explained above about pod install being able to lock the installed versions of your pods.

**否则，你将会打破上述关于*pod install*将会锁定你的pods的已安装版本的整个逻辑。**

###1.3.5 Scenario Example 场景例子

Here is a scenario example to illustrate the various use cases one might encounter during the life of a project.

以下是一些场景例子列举了在工程周期中可能遭遇的各种使用情况。

####1.3.5.1 Stage 1: User1 creates the project 场景1：用户1创建工程

user1 creates a project and wants to use pods A,B,C. They create a Podfile with those pods, and run pod install.

用户1创建了一个工程，并想使用**pods A、B、C**。他创建了这些pods的**Podfile**，然后运行*pod install*。

This will install pods A,B,C, which we'll say are all in version 1.0.0.

这将会安装**pods A、B、C**，我们假定它们都是版本**1.0.0**.

The Podfile.lock will keep track of that and note that A,B and C are each installed as version 1.0.0.

**Podfile.lock**文件将会持续跟踪，并记住**A、B和C**都已经安装为版本**1.0.0**。

>Incidentally, because that's the first time they run pod install and the Pods.xcodeproj project doesn't exist yet, the command will also create the Pods.xcodeproj and the .xcworkspace, but that's a side effect of the command, not its primary role.

>另外，由于这是第一次运行*pod install*，并且*Pods.xcodeproj*工程并不存在，该命令也会创建*Pods.xcodeproj*和*.xcworkspace*，但这只是该命令的副作用而非主要功能。

####1.3.5.2 Stage 2: User1 adds a new pod 场景2：用户1添加了新的pod

Later, user1 wants to add a pod D into their Podfile.

随后，用户1想要添加**pod D**到他们的**Podfile**。

They should thus run pod install afterwards, so that even if the maintener of pod B released a version 1.1.0 of their pod since the first execution of pod install, the project will keep using version 1.0.0 — because user1 only wants to add pod D, without risking an unexpected update to pod B.

他们在这之后也应该运行*pod install*，因此即使**pod B**的维护者在第一次执行*pod install*之后发布了版本**1.1.0**，这个工程也将继续使用版本**1.0.0**——因为用户1只想要添加**pod D**，而不想有意外的更新了**pod B**的风险。

>That's where some people get it wrong, because they use pod update here — probably thinking this as "I want to update my project with new pods"? — instead of using pod install — to install new pods in the project.

>这就是某些人犯错的地方，因为他们在这里使用了*pod update*——可能认为这就是“用新的pods更新工程”的意思？——而不是使用*pod install*——才能在工程中安装新的pods。

####1.3.5.3 Stage 3: User2 joins the project 场景3：用户2加入到工程中

Then user2, who never worked on the project before, joins the team. They clone the repository then use pod install.

然后用户2，一个以前从未参与过这个工程的人，加入到团队之中。他克隆了仓库，然后使用*pod install*。

The contents of Podfile.lock (which should be committed onto the git repo) will guarantee they will get the exact same pods, with the exact same versions that user1 was using.

**Podfile.lock**文件（应该被提交到git仓库中）的内容会保证用户2能获得完全相同的pods，以及与用户1使用的完全相同的版本。

Even if a version 1.2.0 of pod C is now available, user2 will get the pod C in version 1.0.0. Because that's what is registered in Podfile.lock. pod C is locked to version 1.0.0 by the Podfile.lock (hence the name of this file).

尽管**pod C**的**1.2.0**版本现在已经可用，用户2仍将获得**pod C**的**1.0.0**版本。因为这就是写在**Podfile.lock**中的内容。**pod C**被**Podfile.lock**文件锁在了**1.0.0**版本（因此这个文件叫这个名字）。

####1.3.5.4 Stage 4: Checking for new versions of a pod 场景4：检查pod的新版本

Later, user1 wants to check if any updates are available for the pods. They run pod outdated which will tell them that pod B have a new 1.1.0 version, and pod C have a new 1.2.0 version released.

后来，用户1想要检查这些pods是否有更新可以用。他运行了*pod outdates*，这个命令会告诉他**pod B**有新的**1.1.0**版本且**pod C**有新的**1.2.0**版本。

user1 decides they want to update pod B, but not pod C; so they will run pod update B which will update B from version 1.0.0 to version 1.1.0 (and update the Podfile.lock accordingly) but will keep pod C in version 1.0.0 (and won't update it to 1.2.0).

用户1决定他们要更新**pod B**，但是不更新**pod C**；因此他运行*pod update B*，让**B**从版本**1.0.0**升到版本**1.1.0**（同时**Podfile.lock**文件也随之更新），但是将**pod C**保持在**1.0.0**版本（不会更新到**1.2.0**）。

###1.3.6 Using exact versions in the Podfile is not enough 在Podfile中使用准确版本号是不够的

Some might think that by specifying exact versions of their pods in their Podfile, like pod 'A', '1.0.0', is enough to guarantee that every user will have the same version as other people on the team.

有些人可能想通过在他们的**Podfile**中指定pods的准确版本号，如*pod 'a', '1.0.0'*，就能够保证团队中的其他人拥有相同的版本。

Then they might even use pod update, even when just adding a new pod, thinking it would never risk to update other pods because they are fixed to a specific version in the Podfile.

然后他们即使使用了*pod update*，即使添加了新的pod，认为这将不会有更新到其他pods的风险，因为他们已经在**Podfile**中绑定到指定的版本了。

But in fact, that is not enough to guarantee that user1 and user2 in our above scenario will always get the exact same version of all their pods.

但实际上，**这不足以保证我们在上面场景中提到的用户1和用户2总能得到所有pods的相同版本**。

One typical example is if the pod A has a dependency on pod A2 — declared in A.podspec as dependency 'A2', '~> 3.0'. In such case, using pod 'A', '1.0.0' in your Podfile will indeed force user1 and user2 to both always use version 1.0.0 of the pod A, but:

一个典型的例子是，如果**pod A**依赖了**A2**——在**A.podspec**中有声明*dependency 'A2', '~> 3.0'*。此时，在**Podfile**中使用*pod 'A','1.0.0'*，确实会强制用户1和用户2都总是使用**pod A**的**1.0.0**版本，但是：

user1 might end up with pod A2 in version 3.4 (because that was A2's latest version at that time)
while when user2 runs pod install when joining the project later, they might get pod A2 in version 3.5 (because the maintainer of A2 might have released a new version in the meantime).

用户1可能最后得到**pod A2**的**3.4**版本（因为这是**A2**那时的最新版本），而当用户2在之后加入工程运行*pod install*时，他可能得到**pod A2**的**3.5**版本（因为**A2**的维护者可能在这段时间里发布了新的版本）。

That's why the only way to ensure every team member work with the same versions of all the pod on each's computer is to use the Podfile.lock and properly use pod install vs. pod update.

这就是为什么确保每一个团队成员都能在各自的电脑上使用相同版本的pod库的唯一方法就是使用**Podfile.lock**，并且正确的使用**pod install**和**pod update**。

##1.4 Using CocoaPods
Integration instructions and best practices.

集成指令和最佳实践。

###1.4.1 Adding Pods to an Xcode project 将Pods添加到Xcode工程
**Before you begin**

1. Check the Specs repository or cocoapods.org to make sure the libraries you would like to use are available.
2. Install CocoaPods on your computer.

**在你开始前**

1. 检查确保你要用到的**Specs**仓库或者**cocoapods.org**是可用的。
2. 将**CocoaPods**安装到你的电脑。

####1.4.1.1 Installation 安装

* Create a Podfile, and add your dependencies:

* 创建一个**Podfile**文件，然后添加你的依赖：

>
	target 'MyApp' do
	  pod 'AFNetworking', '~> 3.0'
	  pod 'FBSDKCoreKit', '~> 4.9'
	end

* Run *$ pod install* in your project directory.
* Open App.xcworkspace and build.

* 在你的工程目录下运行*$ pod install*。
* 打开*App.xcworkspace*并进行构建。

####1.4.1.2 Creating a new Xcode project with CocoaPods 创建带CocoaPods的新Xcode工程

To create a new project with CocoaPods, follow these simple steps:

按照以下步骤创建带CocoaPods的新工程：

* Create a new project in Xcode as you would normally.
* Open a terminal window, and $ cd into your project directory.
* Create a Podfile. This can be done by running $ pod init.
* Open your Podfile. The first line should specify the platform and version supported.

* 照常在Xcode中创建一个新工程。
* 打开终端窗口，并且*$ cd*进入你的工程目录。
* 创建一个**Podfile**。可以通过运行*$ pod init*完成创建。
* 打开**Podfile**。第一行应该指明支持的平台和版本。

>
	platform :ios, '9.0'


* In order to use CocoaPods you need to define the Xcode target to link them to. So for example if you are writing an iOS app, it would be the name of your app. Create a target section by writing target '$TARGET_NAME' do and an end a few lines after.
* Add a CocoaPod by specifying pod '$PODNAME' on a single line inside your target block.

* 为了使用CocoaPods，你需要定义Xcode目标以连接它们。因此，例如，如果你要写一个iOS应用，它应该是你应用的名字。创建一个目标章节，写入*target '$TARGET_NAME' do*，并在几行之后写一个*end*。
* 通过在目标块内部一个单独的行指明*pod '$PODNAME'*添加一个CocoaPod。

>
	target 'MyApp' do
  		pod 'ObjectiveSugar'
	end

* Save your Podfile.
* Run $ pod install
* Open the MyApp.xcworkspace that was created. This should be the file you use everyday to create your app.

* 保存**Podfile**。
* 运行*$ pod install*。
* 打开创建的*MyApp.xcworkspace*。这就是你每天都要用到的来创建app的文件。

####1.4.1.3 Integration with an existing workspace 集成到一个已存在的工作空间

Integrating CocoaPods with an existing workspace requires one extra line in your Podfile. Simply specify the .xcworkspace filename in outside your target blocks like so:

将CocoaPods集成到一个已存在的工作空间需要在你的**Podfile**中额外的添加一行。在你的目标块之外简单的指明*.xcworkspace*文件，如：
>
	workspace 'MyWorkspace'

###1.4.2 When to use *pod install* vs *pod update*? 何时使用*pod install* 和 *pod update*?
Many people are confused about when to use pod install and when to use pod update. Especially, they often use pod update where they should instead use pod install.

许多人会将何时使用*pod install*和何时使用*pod update*混淆。特别是，他们经常在使用*pod install*的地方使用了*pod update*。

You can find a detailed explanation about when to use each and what are the intended usage of each command in this dedicated guide.

你可以在[给出的引导](#1)中找到关于何时使用哪一个以及每个命令的期望用途是什么的详细的解释。

#### 1.4.3 Should I check the Pods directory into source control? 是否应该将Pods目录提交到源码管理中？

Whether or not you check in your Pods folder is up to you, as workflows vary from project to project. We recommend that you keep the Pods directory under source control, and don't add it to your .gitignore. But ultimately this decision is up to you:

是否将**Pods**文件夹提交取决于你自己，随着工程的不同而不同。我们推荐你将Pods目录保持在源码管理中，而不要添加到你的**.gitignore**中。但是这个决定最终还是取决于你自己：

##### 1.4.3.1 Benefits of checking in the Pods directory 提交Pods目录的好处

- After cloning the repo, the project can immediately build and run, even without having CocoaPods installed on the machine. There is no need to run pod install, and no Internet connection is necessary.
- 在克隆仓库之后，工程可以立即编译运行，甚至不需要再计算机上安装CocoaPods。不需要运行*pod install*，也不需要连接网络。
- The Pod artifacts (code/libraries) are always available, even if the source of a Pod (e.g. GitHub) were to go down.
- Pod工件（代码和库）总是可用的，即使Pod的来源（如GitHub）已经挂了。
- The Pod artifacts are guaranteed to be identical to those in the original installation after cloning the repo.
- Pod工件可以保证跟克隆仓库之后的初始安装一模一样。

##### 1.4.3.2 Benefits of ignoring the Pods directory 忽略Pods目录的好处

- The source control repo will be smaller and take up less space.
- 源码管理仓库会更小，使用更少的空间。
- As long as the sources (e.g. GitHub) for all Pods are available, CocoaPods is generally able to recreate the same installation. (Technically there is no guarantee that running pod install will fetch and recreate identical artifacts when not using a commit SHA in the Podfile. This is especially true when using zip files in the Podfile.)
- 只要源（如GitHub）是可用的，CocoaPods通常可以重新建立相同的安装。（保证这一点的技术是在没有提交**SHA**到**Podfile**时运行*pod install*获取和重建相同的工件。这在使用**Podfile**中的压缩文件时相当正确。）
- There won't be any conflicts to deal with when performing source control operations, such as merging branches with different Pod versions.
- 在执行源码管理操作时不会有任何要处理的冲突，例如合并有不同Pod版本的分支。

Whether or not you check in the Pods directory, the Podfile and Podfile.lock should always be kept under version control.

无论你是否提交**Pods**目录，**Podfile**和**Podfile.lock**应该总保持在版本管理中。

#### 1.4.4 What is Podfile.lock? 什么是Podfile.lock？

This file is generated after the first run of pod install, and tracks the version of each Pod that was installed. For example, imagine the following dependency specified in the Podfile:

这个文件在第一次运行*pod install*之后生成，它会跟踪已安装的每一个Pod的版本。例如，假设在**Podfile**中指定了如下依赖：

>
>	pod 'RestKit'

Running pod install will install the current version of RestKit, causing a Podfile.lock to be generated that indicates the exact version installed (e.g. RestKit 0.10.3). Thanks to the Podfile.lock, running pod install on this hypothetical project at a later point in time on a different machine will still install RestKit 0.10.3 even if a newer version is available. CocoaPods will honour the Pod version in Podfile.lock unless the dependency is updated in the Podfile or pod update is called (which will cause a new Podfile.lock to be generated). In this way CocoaPods avoids headaches caused by unexpected changes to dependencies.

运行*pod install*将会安装**RestKit**的当前版本，这将会生成一个**Podfile.lock**文件指明已安装的准确版本（例如**RestKit 0.10.3**）。由于**Podfile.lock**文件，在往后的时间点在不同的设备上对这个假设的工程运行*pod install*仍然会安装RestKit 0.10.3，即使有新版本可用了。CocoaPods会还原**Podfile.lock**中的Pod版本，除非**Podfile**中的依赖已经更新或者调用了*pod update*（这会生成一个新的**Podfile.lock**文件）。通过这种方式，CocoaPods避免了由于依赖的库的未知变更带来的头疼问题。

There's a great video from Google about how this works: ["CocoaPods and Lockfiles (Route 85)"](https://www.youtube.com/watch?v=H-zK1mEwTe0).

下面是来自谷歌的视频，介绍了这是如何工作的： ["CocoaPods and Lockfiles (Route 85)"](https://www.youtube.com/watch?v=H-zK1mEwTe0)。

#### 1.4.5 What is happening behind the scenes? 在下面的场景中发生了什么？

In Xcode, with references directly from the [ruby source](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L61-L65), it:

1. Creates or updates a [workspace](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L82).

2. [Adds your project to the workspace](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L88-L94) if needed.

3. Adds the [CocoaPods static library project to the workspace](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/target_installer.rb#L40-L61) if needed.

4. Adds libPods.a to: [targets => build phases => link with libraries](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer.rb#L385-L393).

5. Adds the CocoaPods [Xcode configuration file](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator/target_integrator.rb#L112) to your app’s project.

6. Changes your app's [target configurations](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/generator/xcconfig/aggregate_xcconfig.rb#L46-L73) to be based on CocoaPods's.

7. Adds a build phase to [copy resources from any pods](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator/target_integrator.rb#L145) you installed to your app bundle. i.e. a ‘Script build phase’ after all other build phases with the following:

   * Shell: /bin/sh

   - Script: ${SRCROOT}/Pods/PodsResources.sh


Note that steps 3 onwards are skipped if the CocoaPods static library is already in your project. This is largely based on Jonah Williams' work on [Static Libraries](http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4).

直接参考[ruby 源码](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L61-L65)，在Xcode中它：

1. 创建或更新一个[工作空间](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L82)。
2. 如有必要[将你的工程添加到这个工作空间](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L88-L94)。
3. 如有必要 [将CocoaPods静态库工程添加到这个工作空间](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/target_installer.rb#L40-L61)。
4. 添加libPods.a到[targets => build phases => link with libraries](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer.rb#L385-L393)。
5. 添加CocoaPods的[Xcode配置文件](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator/target_integrator.rb#L112)到你的app工程中。
6. 修改你app中基于CocoaPods的[目标配置](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/generator/xcconfig/aggregate_xcconfig.rb#L46-L73)。
7. 添加一个构建阶段以便[从每个安装的pods拷贝资源](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator/target_integrator.rb#L145)到你的app包中。换句话说，在所有其他构建阶段之后有一个如下的“脚本构建阶段”：
   * Shell: /bin/sh
   * Script: ${SRCROOT}/Pods/PodsResources.sh

注意如果CocoaPods静态库已经在你的工程中，第3步以前可能会被跳过。这大部分是基于Jonah Williams关于[Static Libraries](http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4)的工作。

#### 1.4.6 Pods and Submodules Pods和子模块

CocoaPods and git submodules attempt to solve very similar problems. Both strive to simplify the process of including 3rd party code in your project. Submodules link to a specific commit of that project, while a CocoaPod is tied to a versioned developer release.

CocoaPods和git子模块试图解决非常类似的问题。他们都力争简化将第三方代码引入你的工程的步骤。子模块连接到工程的特定提交，而CocoaPod绑定了开发者发布的版本。

##### 1.4.6.1 Switching from submodules to CocoaPods 从子模块切换到CocoaPods

Before you decide to make the full switch to CocoaPods, make sure that the libraries you are currently using are all available. It is also a good idea to record the versions of the libraries you are currently using, so that you can setup CocoaPods to use the same ones. It's also a good idea to do this incrementally, going dependency by dependency instead of one big move.

1. Install CocoaPods, if you have not done so already

2. Create your [Podfile](https://guides.cocoapods.org/using/the-podfile.html)

3. [Remove the submodule reference](http://davidwalsh.name/git-remove-submodule)

4. Add a reference to the removed library in your Podfile

5. Run pod install

在你决定完全切换到CocoaPods之前，你当前使用的所有库都是可用的。记录下当前使用的库的版本也是个好主意，这样就可以使用相同的库安装CocoaPods。也可以逐渐完成切换，一个接一个的依赖，而不是做大的移动。

1. ​安装CocoaPods，如果你还没有做好。
2. 创建你的[Podfile](https://guides.cocoapods.org/using/the-podfile.html)。
3. [移除子模块引用](http://davidwalsh.name/git-remove-submodule)
4. 在Podfile中添加对移除的库的引用
5. 运行*pod install*

##1.5 The Podfile
Learn all about the Podfile, which is used to declare dependencies for your project.
学习关于Podfile的一切。Podfile用于在工程中声明依赖。

###1.5.1 What is a Podfile? Podfile是什么？
The Podfile is a specification that describes the dependencies of the targets of one or more Xcode projects. The file should simply be named Podfile. All the examples in the guides are based on CocoaPods version 1.0 and onwards.

Podfile是描述一个或多个Xcode工程的目标的依赖的明确说明。这个文件被简单命名为**Podfile**。本指南中的所有例子都是基于CocoaPods1.0及以前版本的。

> A Podfile can be very simple, this adds Alamofire to a single target:
>
> Podfile文件可以非常简单，这里就是添加*Alamofire*到一个单独目标的代码：
>
> 	target 'MyApp' do
> 		use_frameworks!
> 		pod 'Alamofire', '~> 3.0'
> 	end
>
>  An example of a more complex Podfile linking an app and its test bundle:
>
> 更复杂的Podfile的例子是链接app和它的测试包：
>
> 	source 'https://github.com/CocoaPods/Specs.git'
> 	source 'https://github.com/Artsy/Specs.git'
> 	
> 	platform :ios, '9.0'
> 	inhibit_all_warnings!
> 	
> 	target 'MyApp' do
> 		pod 'GoogleAnalytics', '~> 3.1'
> 	
> 		# Has its own copy of OCMock
> 		# and has access to GoogleAnalytics via the app
> 		# that hosts the test target
> 	
> 		target 'MyAppTests' do
> 			inherit! :search_paths
> 			pod 'OCMock', '~> 2.0.1'
> 		end
> 	end
> 	
> 	post_install do |installer|
> 		installer.pods_project.targets.each do |target|
> 			puts target.name
> 		end
> 	end
>
> If you want multiple targets to share the same pods, use an *abstract_target*.
>
> 如果你想要多个目标共享相同的pods，使用*抽象目标（abstract_target）*。
>
> 	# There are no targets called "Shows" in any Xcode projects
> 	abstract_target 'Shows' do
> 		pod 'ShowsKit'
> 		pod 'Fabric'
> 	
> 		# Has its own copy of ShowsKit + ShowWebAuth
> 		target 'ShowsiOS' do
> 			pod 'ShowWebAuth'
> 		end
> 	
> 		# Has its own copy of ShowsKit + ShowTVAuth
> 		target 'ShowsTV' do
> 			pod 'ShowTVAuth'
> 		end
> 	end
>
> There is implicit abstract target at the root of the Podfile, so you could write the above example as:
> 也可以在Podfile的根节点隐含抽象目标，因此上面的例子可以写成：
>
> 	pod 'ShowsKit'
> 	pod 'Fabric'
> 	
> 	# Has its own copy of ShowsKit + ShowWebAuth
> 	target 'ShowsiOS' do
> 		pod 'ShowWebAuth'
> 	end
> 	
> 	# Has its own copy of ShowsKit + ShowTVAuth
> 	target 'ShowsTV' do
> 		pod 'ShowTVAuth'
> 	end

####1.5.1.1 Migrating from 0.x to 1.0 从0.x前移到1.0 

We have a [blog post](http://blog.cocoapods.org/CocoaPods-1.0/) explaining the changes in depth.

我们有一个[博客帖子](http://blog.cocoapods.org/CocoaPods-1.0/)深入的解释了这个变化。

##### 1.5.1.2 Specifying pod versions 指定pod版本

> When starting out with a project it is likely that you will want to use the latest version of a Pod. If this is the case, simply omit the version requirements.
>
> 当开始一个工程时，可能你想要使用某个Pod库的最新版本。在这种情况下，简单的删除版本要求即可。

>	pod 'SSZipArchive'

> Later on in the project you may want to freeze to a specific version of a Pod, in which case you can specify that version number.
> 之后在这个工程里你可能想要冻结这个Pod的指定版本，在这种情况下你可以指定版本号。

>	pod 'Objection', '0.9'

Besides no version, or a specific one, it is also possible to use logical operators:

除了不指定版本，或者指定一个版本，也可以使用逻辑运算符：

- '> 0.1' Any version higher than 0.1 任何比0.1大的版本
- '>= 0.1' Version 0.1 and any higher version 任何大于等于0.1的版本
- '< 0.1' Any version lower than 0.1 任何比0.1小的版本
- '<= 0.1' Version 0.1 and any lower version 任何小于等于0.1的版本

In addition to the logic operators CocoaPods has an optimistic operator ~>:

在逻辑运算符之外，CocoaPods还有乐观运算符**~>**：

- '~> 0.1.2' Version 0.1.2 and the versions up to 0.2, not including 0.2 and higher 大于等于0.1.2且小于0.2的版本，不包含0.2及更高版本
- '~> 0.1' Version 0.1 and the versions up to 1.0, not including 1.0 and higher 大于等于0.1且小于1.0的版本，不包含1.0及更高版本
- '~> 0' Version 0 and higher, this is basically the same as not having it. 版本0及以上版本，这与不写基本没区别

For more information, regarding versioning policy, see:

关于版本策略的更多信息，请参考：

- [Semantic Versioning](http://semver.org/)
- [RubyGems Versioning Policies](http://guides.rubygems.org/patterns/#semantic-versioning)
- There's a great video from Google about how this works: ["CocoaPods and the Case of the Squiggly Arrow (Route 85)"](https://www.youtube.com/watch?v=x4ARXyovvPc).

###1.5.2 Using the files from a folder local to the machine. 从本地设备的文件夹路径使用文件
> If you would like to develop a Pod in tandem with its client project you can use *:path*.
> 如果你想要联合开发一个Pod库及它的客户端工程，你可以使用*:path*。
> 	pod 'Alamofire', :path => '~/Documents/Alamofire'

Using this option CocoaPods will assume the given folder to be the root of the Pod and will link the files directly from there in the Pods project. This means that your edits will persist between CocoaPods installations. The referenced folder can be a checkout of your favourite SCM or even a git submodule of the current repo.

使用这个选项时，CocoaPods会假定给出的文件夹是Pod库的根节点，并且直接从那儿连接文件到Pods工程。这意味着你的编辑会在CocoaPods的安装中保持。引用的文件夹可以是从你最喜欢的SCM检出，或者甚至是当前repo（仓库）的git子模块。

Note that the **podspec** of the Pod file is expected to be in that the designated folder.

注意Pod文件的**podspec**应该在指定的文件夹里。

##### 1.5.2.1 From a podspec in the root of a library repo. 从库repo的根节点里的podspec开始

Sometimes you may want to use the bleeding edge version of a Pod, a specific revision or your own fork. If this is the case, you can specify that with your pod declaration.

有时你可能想使用Pod库的最前沿版本、指定的修正版或者你自己的分支。在这种情况下，你可以指定你的pod声明。

> To use the master branch of the repo:
> 要使用repo的主干分支：
> 	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git'
> To use a different branch of the repo:
> 要使用repo的不同分支：
> 	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'dev'
> To use a tag of the repo:
> 要使用repo的tag标签：
> 	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => '3.1.1'
> Or specify a commit:
> 或者指定一次提交：
> 	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :commit => '0f506b1c45'

It is important to note, though, that this means that the version will have to satisfy any other dependencies on the Pod by other Pods.

非常重要的提醒是，这意味着这个Pod的版本要满足来自于其他Pods的任何其他依赖。

The **podspec** file is expected to be in the root of the repo, if this library does not have a **podspec** file in its repo yet, you will have to use one of the approaches outlined in the sections below.

**podspec**文件应该在repo的根节点，如果这个库在它的repo中没有**podspec**文件，你将不得不使用后面章节中介绍的方法之一。

###1.5.3 External resources 扩展资源
- [Non-trivial Podfile in Artsy/Eigen](https://github.com/artsy/eigen/blob/master/Podfile)
- [Podfile for a Swift project in Artsy/Eidolon](https://github.com/artsy/eidolon/blob/master/Podfile)

##1.6 Troubleshooting
The solutions to common problems.

通用问题的处理。

#### 1.6.1 Installing CocoaPods 安装CocoaPods

- If you are installing on macOS 10.9.0-10.9.2, you may run into an issue when RubyGems tries to install the json gem. To fix this follow [these](https://gist.github.com/alloy/62326fcbc5b8ef987c17) instructions.
- 如果你在MacOS 10.9.0-10.9.2版本上安装，你可能在RubyGems尝试安装**json** gem时遇到问题。请按照[这些](https://gist.github.com/alloy/62326fcbc5b8ef987c17)指导来解决这个问题。
- After upgrading from macOS 10.8 to 10.9 the installed CocoaPods gem doesn’t work anymore, even after re-installing the gem. To solve this, you might need to uninstall the gem first and then re-install.
- 在从MacOS 10.8升级到10.9之后已安装的CocoaPods gem不再工作，甚至重新安装gem也无效。要解决这个问题，可能需要先卸载gem，然后再重新安装。

>
>	$ gem uninstall cocoapods
>	$ gem install cocoapods

* The gem might not be able to compile, to solve this you might need to [symlink GCC](http://www.relaxdiego.com/2012/02/using-gcc-when-xcode-43-is-installed.html).
* Gem可能不能编译，要解决这个问题你可能需要[符号连接GCC](http://www.relaxdiego.com/2012/02/using-gcc-when-xcode-43-is-installed.html)。
* If you used an pre release version of Xcode you might need to update the command line tools.
* 如果你使用Xcode的早期版本，你需要更新命令行工具。
* CocoaPods is not compatible with MacRuby.
* CocoaPods与MacRuby不兼容。
* If you get the error "ERROR: While executing gem ... (Errno::EPERM); Operation not permitted - /usr/bin/fuzzy_match" then try: $ sudo gem install -n /usr/local/bin cocoapods
* 如果你得到一个错误“*ERROR: While executing gem ... (Errno::EPERM); Operation not permitted - /usr/bin/fuzzy_match*”，请尝试*$ sudo gem install -n /usr/local/bin cocoapods*。

#### 1.6.2 Using the CocoaPods Project 使用CocoaPods工程

1. If something doesn’t seem to work, first of all ensure that you are not completely overriding any options set from the Pods.xcconfig file in your project’s build settings. To add values to options from your project’s build settings, prepend the value list with $(inherited).

   如果某些东西似乎不工作了，首先请确认你完全没有改动你工程构建设置中**Pods.xcconfig**文件里的任何设置。要在你的工程构建设置添加值，优先考虑值列表中的*$(inherited)*。

2. If Xcode can’t find the headers of the dependencies:

   如果Xcode找不到依赖的头文件：

   - Check if the pod header files are correctly symlinked in Pods/Headers and you are not overriding the HEADER_SEARCH_PATHS (see #1).
   - 检查是否pod头文件正确的符号连接到**Pods/Headers**路径，并且你没有改动**HEADER_SEARCH_PATHS**（见1）。
   - Make sure your project is using the Pods.xcconfig. To check this select your project file, then select it in the second pane again and open the Info section in the third pane. Under configurations you should select Pods.xcconfig for each configurations requiring your installed pods.
   - 确保你的工程使用了**Pods.xcconfig**。要检查这个请选中你的工程文件，然后再在第二个窗口中选择它，并在第三个窗口打开**Info**部分。在配置项中，你要为每个需要已安装的pods的配置选择**Pods.xcconfig**。
   - If Xcode still can’t find them, as a last resort you can prepend your imports, e.g. #import "Pods/SSZipArchive.h".
   - 如果Xcode仍然找不到它们，最后一招是你可以优先考虑你的引入，如*#import "Pods/SSZipArchive.h"*。

3. If you're getting errors about unrecognised C compiler command line options, e.g. cc1obj: error: unrecognised command line option "-Wno-sign-conversion":

   如果你得到关于不可识别的C编译器命令行选项的错误，如* cc1obj: error: unrecognised command line option "-Wno-sign-conversion"*：

   - Make sure your project build settings are [configured](https://img.skitch.com/20111120-brfn4mp8qwrju8w8325wphan9h.png) to use "Apple LLVM compiler" (clang)
   - 确保你的工程构建设置被[设定](https://img.skitch.com/20111120-brfn4mp8qwrju8w8325wphan9h.png)成了使用*"Apple LLVM compiler"*（当当当敲黑板）
   - Are you setting the CC, CPP or CXX environment variable, e.g. in your ~/.profile? This may interfere with the Xcode build process. Remove the environment variable from your ~/.profile.
   - 你是否在，比如**~/.profile**文件中，设置了**CC**，**CPP**，**CXX**环境变量？这可能会干扰Xcode构建过程。从**~/.profile**文件中移除环境变量。

4. If Xcode complains when linking, e.g. Library not found for -lPods, it doesn't detect the implicit dependencies:

   如果Xcode在连接时报错，如*Library not found for -lPods*，这说明Xcode没有探测到隐含的依赖库：

   - Go to Product > Edit Scheme
   - Click on Build
   - Add the Pods static library, and make sure it's at the top of the list
   - Clean and build again
   - If that doesn't work, verify that the source for the spec you are trying to include has been pulled from GitHub. Do this by looking in <Project Dir>/Pods/<Name of spec you are trying to include>. If it is empty (it should not be), verify that the ~/.cocoapods/master/<spec>/<spec>.podspec has the correct git hub url in it.
   - If still doesn't work, check your Xcode build locations settings. Go to Preferences -> Locations -> Derived Data -> Advanced and set build location to "Relative to Workspace".
   - 点击**Product** > **Edit Scheme**。
   - 点击**Build**。
   - 添加**Pods**静态库，并确保它在列表的顶部。
   - 清理并再次构建。
   - 如果仍然不起作用，核对你想要引入的spec源码已经从GitHub上拉下来了。你可以查看*\<Project Dir>/Pods/\<你想要引入的spec的名称>*。如果这个目录是空的（它不应该是空的），核对*~/.cocoapods/master/\<spec>/\<spec>.podspec*里有正确的git hub url。

- If you tried to submit app to App Store, and found that "Product" > "Archive" produce nothing in "Organizer":
   - In Xcode "Build Settings", find "Skip Install". Set the value for "Release" to "NO" on your application target. Build again and it should work.
- 如果你尝试提交app到App Store，却发现"**Product**" > "**Archive**"之后在"**Organizer**"中什么也没有生成：
   - 在Xcode的"**Build Settings**"中找到"**Skip Install**"。在你的应用目标下设置"**Release**"的值为"**NO**"。再次构建就能生效。

*Different Xcode versions can have various problems. Ask for help and tell us what version you're using.*

*不同的Xcode版本可能有各种各样的问题。可以向我们请求帮助，并告诉我们你正使用的版本。*

###1.6.3 Can I workaround ‘Duplicate Symbol’ errors with static libraries? 有没有变通办法处理静态库中的‘符号重复‘问题？

This usually occurs when you’re using a closed-source third-party library that includes a common dependency of your application. One brute-force workaround is to remove the dependency from the static library, as described [here](http://atnan.com/blog/2012/01/12/avoiding-duplicate-symbol-errors-during-linking-by-removing-classes-from-static-libraries)

这通常发生在你使用的闭源第三方库包含了你的应用的公共依赖库的时候。一个野蛮-强迫的变通办法是从静态库中移除这个依赖库，像[这里](http://atnan.com/blog/2012/01/12/avoiding-duplicate-symbol-errors-during-linking-by-removing-classes-from-static-libraries)描述的那样。

However, in general, the vendor should really prefix any dependencies it includes, so you don’t need to deal with it. When this happens, please contact the vendor and ask them to fix it on their side and use the above method as a temporary workaround.

然而，通常情况下，提供者应该真正的预置它包含的所有依赖库，因此你不需要解决这个问题。当问题发生时，请联系提供者，让他们在他们那边修改，而使用上述方法只作为临时的变通方法。

###1.6.4 I'm getting permission errors while running pod commands 在运行pod命令时得到许可错误

As of CocoaPods 0.32.0 we have removed the ability to run the pod commands as root to prevent CocoaPods from getting into an inconsistent state when you mix and match running as root.

自CocoaPods 0.32.0版本开始我们就移除了以root身份运行pod命令的能力，以避免当你以root身份混合或搭配运行时进入异常状态。

If you have ran CocoaPods as root at one stage you may start getting permission denied errors when performing certain operations. When you come across permission errors you may need to delete old files which run as root such as the cache data. You can do this with the following commands.

如果你已经在一个状态以root身份运行CocoaPods，你可能开始获得在执行某些操作时许可拒绝错误。而当你偶然发现许可错误时，你需要以root身份删除旧文件，如缓存数据。你可以使用下面的命令实现这一点。

>	$ sudo rm -fr ~/Library/Caches/CocoaPods/
>	$ sudo rm -fr ~/.cocoapods/repos/master/

Alongside those global files, there may also be a Pods directory in any place you have a Podfile. If you still receive permission errors you should delete this directory too, and afterwards run pod install.

与这些全局文件一样，可能还有一个**Pods**目录在你放置**Podfile**文件的地方。如果你仍然受到许可错误，你应该也删除这个目录，然后运行*pod install*。

>	$ sudo rm -fr Pods/

#### 1.6.5 The Fix I want is in master / a branch, but I'm blocked on this right now 解决想要到主干/分支，但是被锁定在这里的问题

There is [a guide for using a version of CocoaPods to try new features](https://guides.cocoapods.org/using/unreleased-features) that are in discussion or in implementation stage.

这是[一篇使用CocoaPods版本尝试新特性的指南](https://guides.cocoapods.org/using/unreleased-features)，不过还在讨论或实现阶段。

#### 1.6.6 I didn't find the solution to my problem! 我找不到问题的解决办法！

We have multiple avenues for support, here they are in the order we prefer.

我们有许多支持途径，这里按照我们的推荐顺序给出。

- [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods), get yourself some internet points. This keeps the pressure off the CocoaPods dev team and gives us time to work on the project and not support. One of the advantages of using Stack Overflow is that the answer is then easily accessible for others.
- [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods)，给你自己一些互联网元素。这会减轻CocoaPods开发团队的压力，并给我们时间为项目而不是支持工作。使用Stack Overflow的一个好处是答案可以很容易被其他人看到。
- [CocoaPods Mailing List](http://groups.google.com/group/cocoapods), the mailing list is mainly used for announcements of related projects and for support.
- [CocoaPods Mailing List](http://groups.google.com/group/cocoapods)，这个邮件列表主要用于相关工程的通告和支持。
- If your question is regarding a library (to be) distributed through CocoaPods, refer to the [spec repo](https://github.com/CocoaPods/Specs).
- 如果你的问题是关于（即将）从CocoaPods发布的库，参考[spec repo](https://github.com/CocoaPods/Specs)。

#### 1.6.7 I think this is a bug with CocoaPods 我认为这是CocoaPods的bug

In this case we want to get it on a GitHub issues tracker, we use this to keep track of the development work we have to do.

在这种情况下，我们想要通过GitHub问题跟踪获器得它，我们使用这个方式保持对我们不得不做的开发工作进行跟踪。

- **Search tickets before you file a new one.** Add to existing tickets if you have new information about the issue.
- **在你发布新问题前搜索标签。**如果你有关于这个问题的新信息，请添加到已存在的标签上。
- **Only file tickets about the CocoaPods tool itself.** This includes [CocoaPods](https://github.com/CocoaPods/CocoaPods/issues), [CocoaPods/Core](https://github.com/CocoaPods/Core/issues), and [Xcodeproj](https://github.com/CocoaPods/Xcodeproj/issues).
- **只发布关于CocoaPods工具自身的标签。**包括[CocoaPods](https://github.com/CocoaPods/CocoaPods/issues), [CocoaPods/Core](https://github.com/CocoaPods/Core/issues), 和[Xcodeproj](https://github.com/CocoaPods/Xcodeproj/issues)。
- **Keep tickets short but sweet.** Make sure you include all the context needed to solve the issue. Don't overdo it. Great tickets allow us to focus on solving problems instead of discussing them.
- **保持标签简单而清晰**。确保你包含了解决问题所需的所有内容。不要做过头了。好的标签会让我们关注对问题的的解决而不是讨论。

##1.7 F.A.Q
Is CocoaPods ready for prime-time? Why not just use git submodules? etc. etc.

CocoaPods是否已经准备进入黄金时段？为什么不只用git子模块？等等。

#### 1.7.1 "Will CocoaPods stop development now that Swift has a built-in package manager?" “现在Swift已经有了内置的包管理器，CocoaPods会不会停止开发？”

As of writing, the [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager) is in "early design and development" [[1\]](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/README.md#a-work-in-progress). It does not currently support iOS, watch OS, or Objective-C [[2\]](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/Documentation/Package.swift.md#depending-on-apple-modules-eg-foundation)[[3\]](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/Documentation/PackageManagerCommunityProposal.md#support-for-other-languages). CocoaPods will continue development supporting both Swift and Objective-C while SPM develops. As SPM approaches maturity, we will evaluate the best course forward for CocoaPods and the CocoaPods community.

到本文撰写为止，[Swift包管理器(SPM)](https://github.com/apple/swift-package-manager)还处在“早期设计和开发阶段”【[1](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/README.md#a-work-in-progress)】。它当前并不支持iOS，watch OS，或者Objective-C【[2](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/Documentation/Package.swift.md#depending-on-apple-modules-eg-foundation)】【[3](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/Documentation/PackageManagerCommunityProposal.md#support-for-other-languages)】。在SPM开发的同时，CocoaPods也会持续开发以同时支持Swift和Objective-C。到SPM接近成熟的时候，我们将会评估CocoaPods和CocoaPods社区的最好的前进方向。

#### 1.7.2 "Why not just use git submodules?"“为什么不只用git子模块？”

CocoaPods is **not** about downloading code. While it does do that, it’s arguably the least interesting part.

CocoaPods并**不是**用来下载代码的。当它完成下载工作时，这只是它最小的一部分功能。

What defines CocoaPods are the (cross) dependency resolution, (semantic) version management, and automating the ‘integrating it into Xcode’ parts.

对CocoaPods的定位是（交叉）依赖解决方案，（语义上的）版本管理，以及自动“集成到Xcode中”。

Finally, even if you’re looking just for a downloader, consider that there are in fact other SCMs being used than just git. CocoaPods, on the other hand, is agnostic and handles Subversion, Mercurial, and zip/tarballs from local or HTTP locations.

最后，即使你仅把CocoaPods看成一个下载器，实际上也使用了其他的SCMs而不只是git。从另一个角度来看，CocoaPods是个黑盒，从本地或HTTP位置控制子版本、Mercurial以及zip/tarball压缩。

#### 1.7.3 “How can I donate to CocoaPods?” “如何向CocoaPods捐赠？”

TL;DR: While we very much appreciate the sentiment, the project (as an entity) does not accept financial donations. We have a [great blog post](https://blog.cocoapods.org/Why-we-dont-accept-donations/) on this.

简单的说，我们非常感谢这份好意，本项目（作为一个实体）不接受经济捐赠。我们有一片关于这个的[博客帖子](https://blog.cocoapods.org/Why-we-dont-accept-donations/)。

#### 1.7.4 “CocoaPods doesn’t do X, so it’s unusable.” “CocoaPods做不了X，所以它没什么用。”

First see point #2, then consider that unless you tell us about the missing feature and why it is important, it won’t happen at all. We don’t scour Twitter to look for work, so please file a [ticket](https://github.com/CocoaPods/CocoaPods/issues/new), or, better yet, in the form of a pull-request.

请先看第二点（1.7.2），然后除非你告诉我们缺失了什么功能以及它为什么很重要，否则这种情况不可能存在。我们没有擦去Twitter以查看工作，因此请做一个 [标记](https://github.com/CocoaPods/CocoaPods/issues/new)，或者最好是以“拉取请求”的方式

#### 1.7.5 “CocoaPods doesn’t do dependency resolution.” “CocoaPods并未做依赖解决方案。”

CocoaPods has always done dependency resolution, but until version 0.35 it lacked automatic conflict resolution. As of now, CocoaPods can resolve any conflict that is possible to resolve.

CocoaPods通常已经做了依赖解决，但在0.35版本之前都缺少自动处理冲突的解决方案。现在，CocoaPods已经能够解决所有可以解决的冲突。

#### 1.7.6 “CocoaPods is bad for the community, because it makes it too easy for users to add many dependencies.” “CocoaPods对团队有害，因为它让用户太容易添加过多的依赖。”

This is akin to saying "we should not have cars", as they make us lazy and we forget walking/running. Or "we should not use [IDEs](http://programmers.stackexchange.com/questions/39798/being-ide-dependent-how-can-it-harm-me/39809#39809)" as they make us bad programmers, who can't code in editor and can't remember syntax. Furthermore, this reasoning applies to basically any means of fetching code (e.g. git) and as such is not a discussion worth having.

这等于在说“我们不应该有汽车”，因为它们让我们懒惰，而我们忘记了走路/跑步。或者“我们不该使用[IDEs](http://programmers.stackexchange.com/questions/39798/being-ide-dependent-how-can-it-harm-me/39809#39809)”，因为它们让我们变成差劲的程序员，不在编辑器中写代码，并且记不得语法。此外，这个原因适用于获取代码（如，git）的根本意义，以及对于是否应该有的讨论。

What *is* worth discussing, however, is informing the user to be responsible. Ironically enough, the original author of CocoaPods is convinced using a lot of dependencies is a really bad idea. For practical advice on how to deal with this, you should read [this blog post](http://www.fngtps.com/2013/a-quick-note-on-minimal-dependencies-in-ruby-on-rails/) by [Manfred Stienstra](https://twitter.com/manfreds).

然而值得讨论的东西是，要让用户负责任。非常讽刺的是，CocoaPods最初的开发者已经被说服了，也认为使用大量的依赖不是好主意。关于如何解决这个问题的切实可行的建议，你可以阅读[Manfred Stienstra](https://twitter.com/manfreds)写的[这篇博客帖子](http://www.fngtps.com/2013/a-quick-note-on-minimal-dependencies-in-ruby-on-rails/)。

#### 1.7.7 “CocoaPods uses workspaces, which are considered user data. Why does it not use normal sub-projects?” “CocoaPods使用了工作空间，而工作空间被认为是用户数据。为什么不使用常见的子工程？”

Starting from Xcode 4, [Apple introduced workspaces for this very purpose](http://developer.apple.com/library/ios/#featuredarticles/XcodeConcepts/Concept-Workspace.html).

从Xcode 4开始，[苹果正是为了这个目的推出了工作空间](http://developer.apple.com/library/ios/#featuredarticles/XcodeConcepts/Concept-Workspace.html)。

Since then, they have also added workspace files to each xcodeproj document, leading people to believe that a workspace is user data only. This is simply incorrect and you should **not** ignore workspace documents any longer, if you were doing so.

从此以后，他们也在每个xcodeproj文档中添加了工作空间文件，这导致人们认为工作空间只是用户数据。这显然错了，如果你曾经这么认为，那么你**不**应该再忽略工作空间文档了。

Note that CocoaPods itself does not require the use of a workspace. If you prefer to use sub-projects, you can do so by running pod install --no-integrate, which will leave integration into your project up to you as you see fit.

注意CocoaPods自身并不需要使用工作空间。如果你更喜欢使用子工程，你也可以这么做，只要运行*pod install --no-integrat*，这将会让你可以按照你看着爽的方式将pod库整合到你的工程中。

#### 1.7.8 “Why do I have to install Ruby to use CocoaPods?” “为什么我在使用CocoaPods前不得不安装Ruby？”

You don’t, macOS comes with a Ruby 2.0.0 or newer pre-installed in /usr/bin/ruby which are our baselines and these should work out of the box.

你不是必须这么做，macOS自带了Ruby 2.0.0或者更新的版本，预装在**/usr/bin/ruby**目录下，这是我们的基础，我们必须在这个盒子里工作。









附：缩写

repo = repository，代码仓库