#GitHub Guides

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

##No coding necessary 不需要编码

To complete this tutorial, you need a [GitHub.com account](http://github.com/) and Internet access. You don’t need to know how to code, use the command line, or install Git (the version control software GitHub is built on).

要完成本辅导，你需要一个[GitHub.com账号](https://github.com)以及网络访问。你不需要知道如何编码，使用命令行，或者安装Git（GitHub开发的版本控制软件）。

>Tip: Open this guide in a separate browser window (or tab) so you can see it while you complete the steps in the tutorial.

>提示：在独立的浏览器窗口（或标签）打开这篇指南，这样你就能一边看着指南一边完成辅导中的步骤。

#Step 1. Create a Repository 步骤1.创建仓库
A repository is usually used to organize a single project. Repositories can contain folders and files, images, videos, spreadsheets, and data sets – anything your project needs. We recommend including a *README*, or a file with information about your project. GitHub makes it easy to add one at the same time you create your new repository. It also offers other common options such as a license file.

仓库通常用于组织一个工程。仓库可以包含文件夹和文件、图像、视频、电子表格以及数据集合——你的工程需要的任何东西。我们建议你包含一个*README*文件，或者一个记录关于工程信息的文件。GitHub为了方便帮你在创建新仓库时添加了一个（*README*文件）。它也可以提供其他通用设置，如许可文件。

Your *hello-world* repository can be a place where you store ideas, resources, or even share and discuss things with others.

你的*hello-world*仓库可以是一个你想存放点子、资源，或者分支是与其他人分享和讨论内容的地方。

##To create a new repository 创建一个新仓库

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

The *master* branch
A new branch called feature (because we’re doing ‘feature work’ on this branch)
The journey that feature takes before it’s merged into master
a branch

Have you ever saved different versions of a file? Something like:

story.txt
story-joe-edit.txt
story-joe-edit-reviewed.txt
Branches accomplish similar goals in GitHub repositories.

Here at GitHub, our developers, writers, and designers use branches for keeping bug fixes and feature work separate from our *master* (production) branch. When a change is ready, they merge their branch into master.

To create a new branch

Go to your new repository hello-world.
Click the drop down at the top of the file list that says branch: master.
Type a branch name, readme-edits, into the new branch text box.
Select the blue Create branch box or hit “Enter” on your keyboard.
branch gif

Now you have two branches, *master* and readme-edits. They look exactly the same, but not for long! Next we’ll add our changes to the new branch.
