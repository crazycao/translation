#GitHub Guides

原文链接：[https://guides.github.com/activities/hello-world/](https://guides.github.com/activities/hello-world/)

The **Hello World** project is a time-honored tradition in computer programming. It is a simple exercise that gets you started when learning something new. Let’s get started with GitHub!

**Hello World**工程在计算机编程中是一个历史悠久的传统。这是一个让你在学习新东西时的迅速入门的简单例子。让我们开始学习GitHub！

**You’ll learn how to:**

- Create and use a repository
- Start and manage a new branch
- Make changes to a file and push them to GitHub as commits
- Open and merge a pull request

**你将学习如何：**

- 创建和使用仓库
- 开始和管理一个新分支
- 修改文件并通过提交推动改动到GitHub
- 打开和合并一个拉取请求

#What is GitHub? 什么是GitHub？

GitHub is a code hosting platform for version control and collaboration. It lets you and others work together on projects from anywhere.

GitHub是一个用于版本控制和合作的代码托管平台。它可以让你和来自任何地方的其他人一起开发同一个工程。

This tutorial teaches you GitHub essentials like repositories, branches, commits, and Pull Requests. You’ll create your own Hello World repository and learn GitHub’s Pull Request workflow, a popular way to create and review code.

该辅导将教会你GitHub的基本要素，如仓库、分支、提交以及拉取请求。你可以创建你自己的Hello World仓库并且学习GitHub的拉取请求工作流、创建和检查代码的常用方式。

###No coding necessary 不需要编码

To complete this tutorial, you need a [GitHub.com account](http://github.com/) and Internet access. You don’t need to know how to code, use the command line, or install Git (the version control software GitHub is built on).

要完成本辅导，你需要一个[GitHub.com账号](https://github.com)以及网络访问。你不需要知道如何编码，使用命令行，或者安装Git（GitHub开发的版本控制软件）。

>Tip: Open this guide in a separate browser window (or tab) so you can see it while you complete the steps in the tutorial.

>提示：在独立的浏览器窗口（或标签）打开这篇指南，这样你就能一边看着指南一边完成辅导中的步骤。

#Step 1. Create a Repository 步骤1.创建仓库
A repository is usually used to organize a single project. Repositories can contain folders and files, images, videos, spreadsheets, and data sets – anything your project needs. We recommend including a *README*, or a file with information about your project. GitHub makes it easy to add one at the same time you create your new repository. It also offers other common options such as a license file.

仓库通常用于组织一个工程。仓库可以包含文件夹和文件、图像、视频、电子表格以及数据集合——你的工程需要的任何东西。我们建议你包含一个*README*文件，或者一个记录关于工程信息的文件。GitHub为了方便帮你在创建新仓库时添加了一个（*README*文件）。它也可以提供其他通用设置，如许可文件。

Your *hello-world* repository can be a place where you store ideas, resources, or even share and discuss things with others.

你的*hello-world*仓库可以是一个你想存放点子、资源，或者分支是与其他人分享和讨论内容的地方。

###To create a new repository 创建一个新仓库

1. In the upper right corner, next to your avatar or identicon, click **"+"** and then select **New repository**.
2. Name your repository hello-world.
3. Write a short description.
4. Select **Initialize this repository with a README**.

>

1. 在右上角，你的头像旁边，点击**"+"**号，然后选择**新仓库**。
2. 将你的仓库命名为*hello-world*。
3. 写一个简短的描述。
4. 选中**初始化仓库时创建README文件**。

![create-new-repo.png](https://guides.github.com/activities/hello-world/create-new-repo.png)

Click **Create repository**. 

点击**创建仓库**。

#Step 2. Create a Branch 步骤2.创建分支
Branching is the way to work on different versions of a repository at one time.

分支是同时在仓库的不同版本上工作的方法。

By default your repository has one branch named *master* which is considered to be the definitive branch. We use branches to experiment and make edits before committing them to *master*.

默认情况下，你的仓库有一个名叫*master*的分支，这被认为是最权威的分支。我们使用分支做实验，并且在将它们提交到*master*之前进行编辑。

When you create a branch off the *master* branch, you’re making a copy, or snapshot, of *master* as it was at that point in time. If someone else made changes to the *master* branch while you were working on your branch, you could pull in those updates.

当你创建*master*分支之外的分支，你可以创建*master*那个时间点的拷贝或快照。当你在自己的分支上工作时，如果其他人修改了*master*分支，你可以拉取那些更新。

This diagram shows:

- The *master* branch
- A new branch called *feature* (because we’re doing ‘feature work’ on this branch)
- The journey that *feature* takes before it’s merged into *master*

下图展示了：

- *master*分支
- 一个被称为*feature*的分支（因为我们正在这个分支上做“突出介绍”工作）
- *feature*分支被合并到*master*之前经过的路程

![branching.png](https://guides.github.com/activities/hello-world/branching.png)

Have you ever saved different versions of a file? Something like:

- *story.txt*
- *story-joe-edit.txt*
- *story-joe-edit-reviewed.txt*

你是否曾经保存过一个文件的不同版本？一些像这样的东西：

- *story.txt*
- *story-joe-edit.txt*
- *story-joe-edit-reviewed.txt*

Branches accomplish similar goals in GitHub repositories.

GitHub仓库中的分支完成类似的目标。

Here at GitHub, our developers, writers, and designers use branches for keeping bug fixes and feature work separate from our *master* (production) branch. When a change is ready, they merge their branch into *master*.

在GitHub中，我们的开发者、编写者和设计者使用不同分支持续修正bug，在*master*（生产）分支之外专注工作。当修改准备好了，他们就将他们的分支合并到*master*。

###To create a new branch 创建一个新分支

1. Go to your new repository *hello-world*.
2. Click the drop down at the top of the file list that says **branch: master**.
3. Type a branch name, *readme-edits*, into the new branch text box.
4. Select the blue **Create branch** box or hit “Enter” on your keyboard.

>

1. 进入你的新仓库*hello-world*。
2. 点击文件列表上方的下拉菜单，上面写着**branch: master**。
3. 输入一个分支名称，*readme-edits*，写入新分支文本框。
4. 选中蓝色的**Create branch**框或者在键盘上敲下“Enter”。

![readme-edits.gif](https://guides.github.com/activities/hello-world/readme-edits.gif)

Now you have two branches, *master* and *readme-edits*. They look exactly the same, but not for long! Next we’ll add our changes to the new branch.

现在你有两个分支了，*master*和*readme-edits*。它们看起来完全一样，但是不会太久！下一步我们就将添加我们的修改到新的分支。

#Step 3. Make and commit changes 修改和提交改动
Bravo! Now, you’re on the code view for your *readme-edits* branch, which is a copy of *master*. Let’s make some edits.

好的！现在你已经在*readme-edits*分支的代码界面了，这是*master*分支的一份拷贝。让我们来做一些编辑。

On GitHub, saved changes are called *commits*. Each commit has an associated *commit message*, which is a description explaining why a particular change was made. Commit messages capture the history of your changes, so other contributors can understand what you’ve done and why.

在GitHub上，保存改动被称为*提交*。每一个提交有一个相关联的*提交消息*，它解释了为什么要做一个特别的改动。提交消息捕获你改动的历史，因此其他投稿人可以理解你做了什么以及为什么。

###Make and commit changes 改动和提交改动

1. Click the *README.md* file.
2. Click the ✏️ pencil icon in the upper right corner of the file view to edit.
3. In the editor, write a bit about yourself.
4. Write a commit message that describes your changes.
5. Click **Commit changes** button.

>

1. 点击*README.md*文件。
2. 点击✏️铅笔图标以编辑，图标在文件视图的右上角。
3. 在编辑者中，写一小段关于自己的信息。
4. 写一个提交消息描述你的改动。
5. 点击**提交改动**按钮。

![commit.png](https://guides.github.com/activities/hello-world/commit.png)

These changes will be made to just the *README* file on your *readme-edits* branch, so now this branch contains content that’s different from *master*.

这些改动仅被放入了*readme-edits*分支的*README*文件，因此现在该分支与*master*包含不同的内容。

#Step 4. Open a Pull Request 打开一个拉取请求
Nice edits! Now that you have changes in a branch off of *master*, you can open a *pull request*.

编辑好了！现在你已经修改了*master*之外的分支，你可以打开一个*拉取请求*。

Pull Requests are the heart of collaboration on GitHub. When you open a pull request, you’re proposing your changes and requesting that someone review and pull in your contribution and merge them into their branch. Pull requests show diffs, or differences, of the content from both branches. The changes, additions, and subtractions are shown in green and red.

拉取请求是GitHub合作的核心。当你打开一个拉取请求时，你提出你的修改、请求其他人审核并拉取你的贡献合并到他们分支。拉取请求展示了两个分支的不同。修改、增加和删除都以红色和绿色展示出来。

As soon as you make a commit, you can open a pull request and start a discussion, even before the code is finished.

在你提交的时候，你可以打开一个拉取请求并发起一次讨论，甚至在代码完成之前也可以这么做。

By using GitHub’s [@mention system](https://help.github.com/articles/about-writing-and-formatting-on-github/#text-formatting-toolbar) in your pull request message, you can ask for feedback from specific people or teams, whether they’re down the hall or 10 time zones away.

通过在你的拉取请求消息中使用GitHub的[@提醒系统](https://help.github.com/articles/about-writing-and-formatting-on-github/#text-formatting-toolbar)，你可以请求指定人员或团队的反馈，无论他们是在本地或者10个时区之外。

You can even open pull requests in your own repository and merge them yourself. It’s a great way to learn the GitHub Flow before working on larger projects.

你甚至可以在你自己的仓库中打开一个拉取请求并且自己合并它们。这是在为大工程工作之前学习GitHub流的重要方式。

###Open a Pull Request for changes to the README 打开对README的修改的拉取请求

1.Click the **Pull Request** tab, then from the Pull Request page, click the green **New pull request** button. 

1.点击**Pull Request**标签，然后从拉取请求页，点击绿色的 **New pull request** 按钮。

![pr-tab.gif](https://guides.github.com/activities/hello-world/pr-tab.gif)

2.Select the branch you made, *readme-edits*, to compare with *master* (the original).

2.选中你创建的分支，*readme-edits*，与*master*分支（原始分支）做比较。

![pick-branch.png](https://guides.github.com/activities/hello-world/pick-branch.png)|

3.Look over your changes in the diffs on the Compare page, make sure they’re what you want to submit.

3.在比较页查看你的修改的不同，确保这是你想要提交的内容。

![diff.png](https://guides.github.com/activities/hello-world/diff.png)|

4.When you’re satisfied that these are the changes you want to submit, click the big green **Create Pull Request** button.

4.当你对你想要提交的修改满意了，点击大大的绿色**Create Pull Request**按钮。

![create-pr.png](https://guides.github.com/activities/hello-world/create-pr.png)

5.Give your pull request a title and write a brief description of your changes.

给你的拉取请求一个标题，并写一个关于你的修改的简单描述。

	|![pr-form.png](https://guides.github.com/activities/hello-world/pr-form.png)

When you’re done with your message, click **Create pull request**!

当你已经完成了你的信息填写，点击**Create pull request**！

>Tip: You can use emoji and drag and drop images and gifs onto comments and Pull Requests.

>提示：你可以使用表情，并可以拖动图像和gif放入注释和拉取请求。

#Step 5. Merge your Pull Request 步骤5.合并你的拉取请求
In this final step, it’s time to bring your changes together – merging your *readme-edits* branch into the *master* branch.

在这最后的步骤里，是时候把你的改动放到一起了——合并你的*readme-edits*分支到*master*分支。

1. Click the green **Merge pull request** button to merge the changes into *master*.
2. Click **Confirm merge**.
3. Go ahead and delete the branch, since its changes have been incorporated, with the **Delete branch** button in the purple box.

>

1. 点击绿色的**Merge pull request**按钮合并修改到*master*分支。
2. 点击**Confirm merge**。
3. 然后就是删除分支，因为它的改动已经被合并了，使用紫色框里的**Delete branch**按钮。

![merge-button.png](https://guides.github.com/activities/hello-world/merge-button.png)

#Celebrate! 祝贺你！

By completing this tutorial, you’ve learned to create a project and make a pull request on GitHub! 

通过完成本辅导，你已经学会了在GitHub上创建工程和创建拉取请求。

Here’s what you accomplished in this tutorial:

- Created an open source repository
- Started and managed a new branch
- Changed a file and committed those changes to GitHub
- Opened and merged a Pull Request

这里是你在这篇辅导中完成的内容：

- 创建一个开源仓库
- 开始和管理一个新的分支
- 修改文件和提交修改到GitHub
- 打开和合并一个拉取请求

Take a look at your GitHub profile and you’ll see your new *contribution squares*!

看一下你的GitHub个人简介，你可以看到你的新*贡献方格*！

To learn more about the power of Pull Requests, we recommend reading the [GitHub Flow Guide](http://guides.github.com/overviews/flow/). You might also visit [GitHub Explore](http://github.com/explore) and get involved in an Open Source project.

要学习关于拉取请求的力量的更多知识，我们推荐阅读[GitHub Flow Guide](http://guides.github.com/overviews/flow/)。你也可以访问[GitHub Explore](http://github.com/explore)参与开源项目。

>Tip: Check out our other [Guides](http://guides.github.com/), [YouTube Channel](http://youtube.com/githubguides) and [On-Demand Training](https://services.github.com/on-demand/) for more on how to get started with GitHub.

>提示：查看其它[引导](http://guides.github.com/), [YouTube 频道](http://youtube.com/githubguides) 以及 [必要的培训](https://services.github.com/on-demand/)了解关于如何开始使用GitHub的更多知识。