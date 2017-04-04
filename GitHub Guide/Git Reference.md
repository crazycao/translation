#Git Reference

原文地址：[http://gitref.org](http://gitref.org)

>	git
	英 [gɪt]   美 [ɡɪt]  
	n.
	饭桶，无用的人

##目录
- 0 [INTRODUCTION TO THE GIT REFERENCE](#0) [Git Refrence介绍]
	- 0.1 [HOW TO THINK LIKE GIT](#0.1) 如何像Git一样思考
- 1 [GETTING AND CREATING PROJECTS](#1) [获取和创建工程]
	- 1.1 [`git init` initializes a directory as a Git repository](#1.1) 初始化一个目录作为Git仓库
	- 1.2 [`git clone` copy a git repository so you can add to it](#1.2) 拷贝一个git仓库你才能向里面添加
- 2 [BASIC SNAPSHOTTING](#2) [基本快照]
	- 2.1 [`git add` adds file contents to the staging area](#2.1) 添加文件内容到暂存区域
	- 2.2 [`git status` view the status of your files in the working directory and staging area](#2.2) 查看在工作目录和暂存区域的文件状态) 查看在工作目录和暂存区域的文件状态
	- 2.3 [`git diff` shows diff of what is staged and what is modified but unstaged](#2.3) 展示已暂存和修改了但没有暂存的内容的不同
		- 2.3.1 [`git diff` show diff of unstaged changes](#2.3.1) 展示未暂存的改动的不同
		- 2.3.2 [`git diff --cached` show diff of staged changes](#2.3.2) 展示已暂存的修改的不同
		- 2.3.3 [`git diff HEAD` show diff of all staged or unstaged changes](#2.3.3) 展示所有暂存或未暂存的修改
		- 2.3.4 [`git diff --stat` show summary of changes instead of a full diff](#2.3.4) 展示修改的概要而不是完整的不同
	- 2.4 [`git commit` records a snapshot of the staging area](#2.4) 记录暂存区域的快照
		- 2.4.1 [`git commit -a` automatically stage all tracked, modified files before the commit](#2.4.1) 在提交之前自动暂存所有已跟踪的和已修改的文件
	- 2.5 [`git reset` undo changes and commits](#2.5) 撤销修改和提交
		- 2.5.1 [`git reset HEAD` unstage files from index and reset pointer to HEAD](#2.5.1) 从索引中取消暂存的文件并且重置指针到HEAD
		- 2.5.2 [`git reset --soft` moves HEAD to specified commit reference, index and staging are untouched](#2.5.2) 将HEAD移动到指定的提交引用，索引和暂存都不动
		- 2.5.3 [`git reset --hard` unstage files AND undo any changes in the working directory since last commit](#2.5.3) 不暂存文件并且撤销从上次提交之后在文件目录中的所有修改
	- 2.6 [`git rm` remove files from the staging area](#2.6) 从暂存区域移除文件
		- 2.6.1 [`git mv` git rm --cached orig; mv orig new; git add new](#2.6.1)
	- 2.7 [`git stash` save changes made in the current index and working directory for later](#2.7) 保存在当前索引和工作目录做的修改为了以后使用
		- 2.7.1 [`git stash` add current changes to the stack](#2.7.1) 将当前修改添加到栈
		- 2.7.2 [`git stash list` view stashes currently on the stack](#2.7.2) 在栈上查看当前的stash
		- 2.7.3 [`git stash apply` grab the item from the stash list and apply to current working directory](#2.7.3) 从stash列表中抓取项目应用到当前工作目录
		- 2.7.4 [`git stash drop` remove an item from the stash list](#2.7.5) 从stash列表移除项目
- 3 [BRANCHING AND MERGING](#3) [分支与合并]
	- 3.1 [`git branch` list, create and manage working contexts](#3.1) 列出，创建和管理工作你上下文
		- 3.1.1 [`git branch` list your available branches](#3.1.1) 列出你的可用分支
		- 3.1.2 [`git branch (branchname)` create a new branch](#3.1.2) 创建一个新的分支
		- 3.1.3 [`git branch -v` see the last commit on each branch](#3.1.3) 查看每个分支上的上一次提交
		- 3.1.4 [`git branch -d (branchname)` delete a branch](#3.1.4) 删除一个分支
		- 3.1.5 [`git push (remote-name) :(branchname)` delete a remote branch](#3.1.5) 删除一个远程分支
	- 3.2 [`git checkout` switch to a new branch context](#3.2) 切换到新的上下文
		- 3.2.1 [`git checkout -b (branchname)` create and immediately switch to a branch](#3.2.1) 创建并立即切换到一个分支
	- 3.3 [`git merge` merge a branch context into your current one](#3.3) 合并一个分支上下文到你当前的分支
		- 3.3.1 [more complex merges](#3.3.1) 更复杂的合并
		- 3.3.2 [merge conflicts](#3.3.2) 合并冲突
	- 3.4 [`git log` show commit history of a branch](#3.4) 展示一个分支的提交历史
	- 3.5 [`git tag` tag a point in history as important](#3.5) 在历史中重要的节点设置标签
4 [SHARING AND UPDATING PROJECTS](#4) [分享和更新工程]
	- 4.1 [`git remote` list, add and delete remote repository aliases](#4.1) 列出，添加和删除远程仓库的化名
		- 4.1.1 [`git remote` list your remote aliases](#4.1.1) 列出你的远程化名
		- 4.1.2 [`git remote add` add a new remote repository of your project](#4.1.2) 添加新的远程库到你的工程
		- 4.1.3 [`git remote rm` removing an existing remote alias](#4.1.3) 移除已存在的远程化名
		- 4.1.4 [`git remote rename [old-alias] [new-alias]` rename remote aliases](#4.1.4) 重命名远程化名
		- 4.1.5 [`git remote set-url` update an existing remote URL](#4.1.5) 更新一个已存在的远程URL
	- 4.2 [`git fetch` download new branches and data from a remote repository](#4.2) 从远程仓库下载新的分支和数据
	- 4.3 [`git pull` fetch from a remote repo and try to merge into the current branch](#4.3) 从远程分支获取并尝试合并到当前分支
	- 4.4 [`git push` push your new branches and data to a remote repository](#4.4) 推送你的新分支和数据到远程仓库
- 5 [INSPECTION AND COMPARISON](#5) [检查和比较]
	- 5.1 [`git log` filter your commit history](#5.1) 过滤你的提交历史
		- 5.1.1 [`git log --author` look for only commits from a specific author](#5.1.1) 仅查找特定作者的提交
		- 5.1.2 [`git log --since --before` filter commits by date committed](#5.1.2) 通过提交日期过滤提交
		- 5.1.3 [`git log --grep` filter commits by commit message](#5.1.3) 通过提交信息过滤提交
		- 5.1.4 [`git log -S` filter by introduced diff](#5.1.4) 通过引入的不同过滤
		- 5.1.5 [`git log -p` show patch introduced at each commit](#5.1.5) 展示在每次提交引入的补丁
		- 5.1.6 [`git log --stat` show diffstat of changes introduced at each commit](#5.1.6) 展示在每一次提交引入的修改的diff状态
	- 5.2 [`git diff`](#5.2)
		
<span id = "0">
#0 INTRODUCTION TO THE GIT REFERENCE [Git Refrence介绍](http://gitref.org)
This is the Git reference site. It is meant to be a quick reference for learning and remembering the most important and commonly used Git commands. The commands are organized into sections of the type of operation you may be trying to do, and will present the common options and commands needed to accomplish these common tasks.

这是Git Reference网站。它的目的是快速学习和记忆最重要和最常用的Git命令。这些命令被组织成章节，按照你可能尝试要做的操作分类，并将呈现用于完成这些常见任务所需的常见命令和选项。

Each section will link to the next section, so it can be used as a tutorial. Every page will also link to more in-depth Git documentation such as the official manual pages and relevant sections in the **Pro Git book**, so you can learn more about any of the commands. First, we'll start with thinking about source code management like Git does.

每一节都会链接到下一节，因此这可以用作一个教程。每一页也会链接到更加深入的Git文档，如官方手册页面和**Pro Git book**的相关章节，以便你学习关于命令的更多知识。首先，我们要从思考像Git那样进行源代码管理开始。

<span id = "0.1">
##0.1 HOW TO THINK LIKE GIT 如何像Git一样思考
The first important thing to understand about Git is that it thinks about version control very differently than Subversion or Perforce or whatever SCM you may be used to. It is often easier to learn Git by trying to forget your assumptions about how version control works and try to think about it in the Git way.

理解Git的首要事情是它对版本控制的思考与Subversion或Perforce或你用过的任意一种SCM可能都非常不同。尝试忘记你关于版本控制如何工作的假定通常会让学习Git更简单，尝试以Git的方式思考它。

Let's start from scratch. Assume you are designing a new source code management system. How did you do basic version control before you used a tool for it? Chances are that you simply copied your project directory to save what it looked like at that point.

让我们从零开始。假设你正在设计一个新的源码管理系统。在你使用工具进行基本版本控制之前你是如何做的？有可能你只是简单的拷贝你的工程目录，以保存它在那个节点看起来的样子。

	 $ cp -R project project.bak 

That way, you can easily revert files that get messed up later, or see what you have changed by comparing what the project looks like now to what it looked like when you copied it.

这种方式，你可以在之后混乱时很容易回滚文件，或者查看你改变了什么，只要比较工程现在的样子和你拷贝它时的样子就行。

If you are really paranoid, you may do this often, maybe putting the date in the name of the backup:

如果你真的很多疑，你可能会经常做这些，可能在备份的名称上加一个日期：

	 $ cp -R project project.2010-06-01.bak 

In that case, you may have a bunch of snapshots of your project that you can compare and inspect from. You can even use this model to fairly effectively share changes with someone. If you zip up your project at a known state and put it on your website, other developers can download that, change it and send you a patch pretty easily.

在那种情况下，你可能有一串你的工程的快照，可以用于对比和检查。你甚至可以使用这个模型非常搞笑的将改动分享给其他人。如果你在一个已知的状态打包你的工程并将其放到你的网站上，其他开发者就可以下载它、修改它并非常方便的给你发一个补丁。

	 $ wget http://example.com/project.2010-06-01.zip
	 $ unzip project.2010-06-01.zip
	 $ cp -R project.2010-06-01 project-my-copy
	 $ cd project-my-copy
	 $ (change something)
	 $ diff project-my-copy project.2010-06-01 > change.patch
	 $ (email change.patch)

Now the original developer can apply that patch to their copy of the project and they have your changes. This is how many open source projects have been collaborated on for several years.

现在最初的开发者可以接受对他们工程的拷贝的补丁了，他们拥有了你的修改。这就是多少开源工程曾经进行了若干年的合作方式。

This actually works fairly well, so let's say we want to write a tool to make this basic process faster and easier. Instead of writing a tool that versions each file individually, like Subversion, we would probably write one that makes it easier to store snapshots of our project without having to copy the whole directory each time.

这确实工作得非常好，因此假如我们想要写个工具让这个基本过程更快和更简单。除了像Subversion一样写一个工具独立管理每个文件的版本，我们很可能只有写个能让存储工程快照更简单的工具了，不需要每次拷贝整个目录。

This is essentially what Git is. You tell Git you want to save a snapshot of your project with the `git commit` command and it basically records a manifest of what all of the files in your project look like at that point. Then most of the commands work with those manifests to see how they differ or pull content out of them, etc.

这就是Git的本质。你通过`git commit`命令告诉Git你想要保存一份你工程的快照，它本质上记录了你的工程中所有文件在这个节点上像什么样子的清单。然后大部分命令都与这些清单一起工作，看看它们有什么不同或者如何从它们中拉取内容，等等。

![snapshots](http://gitref.org/images/snapshots.png)

If you think about Git as a tool for storing and comparing and merging snapshots of your project, it may be easier to understand what is going on and how to do things properly.

如果你把Git想成用来存储、对比和合并你的工程的快照的工具，可能会更容易理解将会发生什么以及如何正确的完成工作。

<span id = "1">
#1 GETTING AND CREATING PROJECTS [获取和创建工程](http://gitref.org/creating/)

In order to do anything in Git, you need to have a Git repository. This is where Git stores the data for the snapshots you are saving.

无论要在Git中做什么事情，你都需要由一个Git仓库。这就是Git为你保存的快照存放数据的地方。

There are two main ways to get a Git repository. One way is to simply initialize a new one from an existing directory, such as a new project or a project new to source control. The second way is to clone one from a public Git repository, as you would do if you wanted a copy or wanted to work with someone on a project. We will cover both of these here.

这里有两种主要的方法可以得到一个Git仓库。方法之一是简单的从已存在的目录初始化一个的新的仓库，如新的工程或者新要进行源码控制的工程。另一种方法是从公共Git仓库克隆一个，如果你想要一份拷贝或者与其他人在同一个工程中工作时你都会这么做。我们这里将覆盖着两种的介绍。

<span id = "1.1">
##1.1 `git init` initializes a directory as a Git repository 初始化一个目录作为Git仓库
[docs](http://git-scm.com/docs/git-init) 
[book](http://git-scm.com/book/en/Git-Basics-Getting-a-Git-Repository#Initializing-a-Repository-in-an-Existing-Directory)

To create a repository from an existing directory of files, you can simply run `git init` in that directory. For example, let's say we have a directory with a few files in it, like this:

要从一个已存在的文件目录创建仓库，你可以只是在那个目录中运行`git init`。假如，假如我们有一个目录里面有一些文件，像这样：

	$ cd konnichiwa
	$ ls
	README   hello.rb

This is a project where we are writing examples of the "Hello World" program in every language. So far, we just have Ruby, but hey, it's a start. To start version controlling this with Git, we can simply run git init.

这是一个工程，在这里我们正用每种语言“Hello world”程序的例子。到目前为止，我们只写好了Ruby的，但是，嘿，这只是一个开始。要开始使用Git对他们进行版本控制，我们可以简单的运行`git init`。

	$ git init
	Initialized empty Git repository in /opt/konnichiwa/.git/

Now you can see that there is a `.git` subdirectory in your project. This is your Git repository where all the data of your project snapshots are stored.

现在你可以看到工程中有了一个`.git`子目录。这就是你的Git仓库，你的工程快照的所有数据都储存在这里。

	$ ls -a
	.        ..       .git     README   hello.rb

Congratulations, you now have a skeleton Git repository and can start snapshotting your project.

恭喜，你现在有了一个概要的Git仓库，并且可以开始对你的工程制作快照。

>**In a nutshell**, you use `git init` to make an existing directory of content into a new Git repository. You can do this in any directory at any time, completely locally.

>**简而言之**，你使用`git init`将现有的内容目录编程新的Git仓库。你可以在任何时候在任何目录中这么做，完全是本地的。

<span id = "1.2">
##1.2 `git clone` copy a git repository so you can add to it 拷贝一个git仓库你才能向里面添加
[docs](http://git-scm.com/docs/git-clone)
[book](http://git-scm.com/book/en/Git-Basics-Getting-a-Git-Repository#Cloning-an-Existing-Repository)

If you need to collaborate with someone on a project, or if you want to get a copy of a project so you can look at or use the code, you will clone it. You simply run the `git clone [url]` command with the URL of the project you want to copy.

如果你想要与某人在一个工程上合作，或者你想要获取一个工程的拷贝以便你能够查看或使用其代码，你可以克隆它。你只要运行`git clone [url]`命令传入你想要拷贝的工程的URL即可。

	$ git clone git://github.com/schacon/simplegit.git
	Initialized empty Git repository in /private/tmp/simplegit/.git/
	remote: Counting objects: 100, done.
	remote: Compressing objects: 100% (86/86), done.
	remote: Total 100 (delta 35), reused 0 (delta 0)
	Receiving objects: 100% (100/100), 9.51 KiB, done.
	Resolving deltas: 100% (35/35), done.
	$ cd simplegit/
	$ ls
	README   Rakefile lib

This will copy the entire history of that project so you have it locally and it will give you a working directory of the main branch of that project so you can look at the code or start editing it. If you change into the new directory, you can see the `.git` subdirectory - that is where all the project data is.

这将会拷贝该工程的全部历史，然后你在本地就拥有了它，它将给你一个该工程的主分支的工作目录以便你可以查看代码或者开始编辑。如果你切换到新的目录，你可以看到`.git`子目录——这就是所有工程数据所在的地方。

	$ ls -a
	.        ..       .git     README   Rakefile lib
	$ cd .git
	$ ls
	HEAD        description info        packed-refs
	branches    hooks       logs        refs
	config      index       objects

By default, Git will create a directory that is the same name as the project in the URL you give it - basically whatever is after the last slash of the URL. If you want something different, you can just put it at the end of the command, after the URL.

默认情况下，Git会创建一个你给出的URL中的工程相同名字的目录——基本上是URL的最后一段。如果你想要不同的名字，你可以将名字放在命令的末尾，URL之后。

>**In a nutshell**, you use `git clone` to get a local copy of a Git repository so you can look at it or start modifying it.
>
>**简而言之**，你使用`git clone`获得一份Git仓库的本地拷贝，然后你可以查看它或开始修改它。

<span id = "2">
#2 BASIC SNAPSHOTTING [基本快照](http://gitref.org/basic/)
[book](http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository)

Git is all about composing and saving snapshots of your project and then working with and comparing those snapshots. This section will explain the commands needed to compose and commit snapshots of your project.

Git就是关于组织和保存你的工程的快照然后与这些快照工作和对比的一切。本节将解释用于组织和提交你的工程快照的命令。

An important concept here is that Git has an 'index', which acts as sort of a staging area for your snapshot. This allows you to build up a series of well composed snapshots from changed files in your working directory, rather than having to commit all of the file changes at once.

此处有一个重要概念是Git有一个“索引”，它将作为你的快照暂存区域的排序。这允许你从你的工作目录中的已更改文件建立一系列组织好的快照，而不需要一次提交所有文件改动。

>**In a nutshell**, you will use `git add` to start tracking new files and also to stage changes to already tracked files, then `git status` and `git diff` to see what has been modified and staged and finally `git commit` to record your snapshot into your history. This will be the basic workflow that you use most of the time.
>
>**简而言之**，你将使用`git add`开始跟踪新的文件及暂存已跟踪的文件的变化，然后使用`git status`和`git diff`查看已经修改和暂存的内容，最后使用`git commit`将你的快照记录到你的历史中。这将是你在大部分时候使用的基本工作流。

<span id = "2.1">
##2.1 `git add` adds file contents to the staging area 添加文件内容到暂存区域
[docs](http://git-scm.com/docs/git-add)
[book](http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository#Tracking-New-Files)

In Git, you have to add file contents to your staging area before you can commit them. If the file is new, you can run `git add` to initially add the file to your staging area, but even if the file is already "tracked" - ie, it was in your last commit - you still need to call `git add` to add new modifications to your staging area. Let's see a few examples of this.

在Git中，在你提交文件内容之前，你需要添加它们到你的暂存区域。如果文件是新的，你可以运行`git add`初始化的添加文件到你的暂存区域，但是即使文件已经是“被跟踪的”——例如，它在你的上一次提交中——你仍然需要调用`git add`添加新的修改到你的暂存区域。让我们看一些这样的例子：

Going back to our Hello World example, once we've initiated the project, we would now start adding our files to it and we would do that with `git add`. We can use `git status` to see what the state of our project is.

回到我们的Hello World例子，一旦我们已经初始化了工程，我们现在要开始添加我们的文件到其中，我们需要使用`git add`才能做到。我们可以使用`git status`查看我们的工程现在是什么状态。

	$ git status -s
	?? README
	?? hello.rb

So right now we have two untracked files. We can now add them.

所以现在我们有两个未跟踪的文件。我们现在可以添加它们。

	$ git add README hello.rb

Now if we run `git status` again, we'll see that they've been added.

现在我们再次运行`git status`，我们将看到我们添加的东西。

	$ git status -s
	A  README
	A  hello.rb

It is also common to recursively add all files in a new project by specifying the current working directory like this: `git add .`. Since Git will recursively add all files under a directory you give it, if you give it the current working directory, it will simply start tracking every file there. In this case, a `git add .` would have done the same thing as a `git add README hello.rb`, or for that matter so would `git add *`, but that's only because we don't have subdirectories which the `*` would not recurse into.

通过像这样`git add .`指定当前工作目录递归的添加一个新工程中的所有文件也很常见。由于Git将递归添加你给出的目录下的所有文件，如果你给出当前工作目录，它将仅开始跟踪在这里的每个文件。在这种情况下，`git add .`将完成与`git add README hello.rb`相同的事情，或者在那个情况下也可以使用`git add *`，但是这仅仅因为我们没有子目录，`*`不会向下递归。

OK, so now if we edit one of these files and run `git status` again, we will see something odd.

好了，那么现在如果我们编辑这些文件中的一个，并再次运行`git status`，我们将看到一些东西。

	$ vim README
	$ git status -s
	AM README
	A  hello.rb

The 'AM' status means that the file has been modified on disk since we last added it. This means that if we commit our snapshot right now, we will be recording the version of the file when we last ran `git add`, not the version that is on our disk. Git does not assume that what the file looks like on disk is necessarily what you want to snapshot - you have to tell Git with the `git add` command.

‘AM’状态的意思是这个文件从我们上次添加它之后已经在硬盘中被修改了。这意味着如果我们现在提交我们的快照，我们将会记录这个文件在我们上次运行`git add`时的版本，而不是我们硬盘中的版本。Git不会假定文件在硬盘上看起来的样子是必定你想要快照的——你必须使用`git add`命令告诉Git。

>**In a nutshell**, you run `git add` on a file when you want to include whatever changes you've made to it in your next commit snapshot. Anything you've changed that is not added will not be included - this means you can craft your snapshots with a bit more precision than most other SCM systems.

>**简而言之**，当你想要把你做出的改动包含到你的下一个提交快照中时，你就对文件运行`git add`。你修改了但是没有添加的任何东西都不会被包含——这意味着你可以精确的制作你的快照，比其他大部分SCM系统更加精确。

For a very interesting example of using this flexibility to stage only parts of modified files at a time, see the `-p` option to `git add` in the Pro Git book.

关于使用这种灵活性一次暂存一部分已修改的文件的有趣的例子，参见`git add`在Pro Git book中的`-p`选项。

##2.2 `git status` view the status of your files in the working directory and staging area 查看在工作目录和暂存区域的文件状态
[docs](http://git-scm.com/docs/git-status)
[book](http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository#Checking-the-Status-of-Your-Files)

As you saw in the `git add` section, in order to see what the status of your staging area is compared to the code in your working directory, you can run the `git status` command. Using the `-s` option will give you short output. Without that flag, the `git status` command will give you more context and hints. Here is the same status output with and without the `-s`. The short output looks like this:

正如你在`git add`章节中看到的，为了查看你暂存区域的状态与你工作目录的代码做比较，你可以运行`git status`命令。使用`-s`选项将给你简短的输出。不带这个标志，`git status`命令将给你更多上下文和暗示。带上和不带`-s`的状态输出是一样的。简短输出看起来像这样：

	$ git status -s
	AM README
	A  hello.rb

Where the same status with the long output looks like this:

同样的状态使用长输出看起来像这样：

	$ git status
	# On branch master
	#
	# Initial commit
	#
	# Changes to be committed:
	#   (use "git rm --cached <file>..." to unstage)
	#
	# new file:   README
	# new file:   hello.rb
	#
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	# modified:   README
	#

You can easily see how much more compact the short output is, but the long output has useful tips and hints as to what commands you may want to use next.

你可以很容易看出短输出有多么简洁，但是长输出有有用的建议和暗示你接下来可能使用什么命令。

Git will also tell you about files that were deleted since your last commit or files that were modified or staged since your last commit.

Git也会告诉你从你上次提交之后被删除了的文件，或者从你上次提交之后被修改或暂存的文件。

	$ git status -s
	M  README
	 D hello.rb

You can see there are two columns in the short status output. The first column is for the staging area, the second is for the working directory. So for example, if you have the README file staged and then you modify it again without running `git add` a second time, you'll see this:

你可以看到在短状态输出中有两列。第一列是暂存区域的，第二列是工作目录的。所以例如，如果你的README文件已经暂存，而后你又再次修改了它，没有第二次运行`git add`，你将看到这样：

	$ git status -s
	MM README
	 D hello.rb

>**In a nutshell**, you run `git status` to see if anything has been modified and/or staged since your last commit so you can decide if you want to commit a new snapshot and what will be recorded in it.
>
>**简而言之**，你运行`git status`看看是否有什么东西从你上次提交之后被修改了或者暂存了，以便你能决定是否要提交一个新的快照和记录在其中的东西。

<span id = "2.3">
##2.3 `git diff` shows diff of what is staged and what is modified but unstaged 展示已暂存和修改了但没有暂存的内容的不同
[docs](http://git-scm.com/docs/git-diff)
[book](http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository#Viewing-Your-Staged-and-Unstaged-Changes)

There are two main uses of the `git diff` command. One use we will describe here, the other we will describe later in the "Inspection and Comparison" section. The way we're going to use it here is to describe the changes that are staged or modified on disk but unstaged.

`git diff`命令有两个主要的用处。其中一个用处我们将在这里介绍，另一个我们稍后将在"Inspection and Comparison"章节中介绍。我们将在这里使用它的途径是描述已暂存的或在磁盘中修改了但没有暂存的改动。

<span id = "2.3.1">
###2.3.1 `git diff` show diff of unstaged changes 展示未暂存的改动的不同

Without any extra arguments, a simple `git diff` will display in unified diff format (a patch) what code or content you've changed in your project since the last commit that are not yet staged for the next commit snapshot.

没有额外的参数，简单的`git diff`将以统一的不同格式（一个补丁）显示从上次提交之后你在你的工程中修改了但没有为下次提交快照暂存的代码或内容。

	$ vim hello.rb
	$ git status -s
	 M hello.rb
	$ git diff
	diff --git a/hello.rb b/hello.rb
	index d62ac43..8d15d50 100644
	--- a/hello.rb
	+++ b/hello.rb
	@@ -1,7 +1,7 @@
	 class HelloWorld
	
	   def self.hello
	-    puts "hello world"
	+    puts "hola mundo"
	   end
	
	 end

So where `git status` will show you what files have changed and/or been staged since your last commit, `git diff` will show you what those changes actually are, line by line. It's generally a good follow-up command to `git status`

因此`git status`将展示已经修改或者从你上次提交已经暂存的文件，`git diff`将逐行展示这些修改实际是什么。它一般都是跟在`git status`后面的很好的命令。

<span id = "2.3.2">
###2.3.2 `git diff --cached` show diff of staged changes 展示已暂存的修改的不同

The `git diff --cached` command will show you what contents have been staged. That is, this will show you the changes that will currently go into the next commit snapshot. So, if you were to stage the change to `hello.rb` in the example above, `git diff` by itself won't show you any output because it will only show you what is not yet staged.

`git diff --cached`命令将会向你展示什么内容已经暂存了。也就是说，这将向你展示当前哪些改动将进入下一次提交快照。因此，如果你在上面的例子中暂存了改动到`hello.rb`中，`git diff`自己不会展示给你任何输出，因为它只会展示什么是没有暂存的。

	$ git status -s
	 M hello.rb
	$ git add hello.rb 
	$ git status -s
	M  hello.rb
	$ git diff
	$ 

If you want to see the staged changes, you can run `git diff --cached` instead.

如果你想要查看已暂存的修改，你可以运行`git diff --cached`命令。

	$ git status -s
	M  hello.rb
	$ git diff
	$ 
	$ git diff --cached
	diff --git a/hello.rb b/hello.rb
	index d62ac43..8d15d50 100644
	--- a/hello.rb
	+++ b/hello.rb
	@@ -1,7 +1,7 @@
	 class HelloWorld
	
	   def self.hello
	-    puts "hello world"
	+    puts "hola mundo"
	   end
	
	 end

<span id = "2.3.3">
###2.3.3 `git diff HEAD` show diff of all staged or unstaged changes 展示所有暂存或未暂存的修改

If you want to see both staged and unstaged changes together, you can run `git diff HEAD` - this basically means you want to see the difference between your working directory and the last commit, ignoring the staging area. If we make another change to our `hello.rb` file then we'll have some changes staged and some changes unstaged. Here are what all three `diff` commands will show you:

如果你想要一起查看已暂存和未暂存的修改，你可以运行`git diff HEAD`命令——这根本上意味着你想要查看你的工作目录和上次提交的不同，而忽略掉暂存区域。如果我们对我们的`hello.rb`文件又做了另一个修改，然后我们就有了一些暂存的修改和一些未暂存的修改。这是三个`diff`命令将展示给你的东西：

	$ vim hello.rb 
	$ git diff
	diff --git a/hello.rb b/hello.rb
	index 4f40006..2ae9ba4 100644
	--- a/hello.rb
	+++ b/hello.rb
	@@ -1,7 +1,7 @@
	 class HelloWorld
	
	+  # says hello
	   def self.hello
	     puts "hola mundo"
	   end
	
	 end
	$ git diff --cached
	diff --git a/hello.rb b/hello.rb
	index 2aabb6e..4f40006 100644
	--- a/hello.rb
	+++ b/hello.rb
	@@ -1,7 +1,7 @@
	 class HelloWorld
	
	   def self.hello
	-    puts "hello world"
	+    puts "hola mundo"
	   end
	
	 end
	$ git diff HEAD
	diff --git a/hello.rb b/hello.rb
	index 2aabb6e..2ae9ba4 100644
	--- a/hello.rb
	+++ b/hello.rb
	@@ -1,7 +1,8 @@
	 class HelloWorld
	
	+  # says hello
	   def self.hello
	-    puts "hello world"
	+    puts "hola mundo"
	   end
	
	 end

<span id = "2.3.4">
###2.3.4 `git diff --stat` show summary of changes instead of a full diff 展示修改的概要而不是完整的不同

If we don't want the full diff output, but we want more than the `git status` output, we can use the `--stat` option, which will give us a summary of changes instead. Here is the same example as above, but using the `--stat` option instead.

如果我们不想要完整的不同输出，但是我们又想要比`git status`输出更多的东西，我们可以换成使用`--stat`选项，这会给我们一份修改的概要。这里跟上面同一个例子，但是换成使用`--stat`选项。

	$ git status -s
	MM hello.rb
	$ git diff --stat
	 hello.rb |    1 +
	 1 files changed, 1 insertions(+), 0 deletions(-)
	$ git diff --cached --stat
	 hello.rb |    2 +-
	 1 files changed, 1 insertions(+), 1 deletions(-)
	$ git diff HEAD --stat
	 hello.rb |    3 ++-
	 1 files changed, 2 insertions(+), 1 deletions(-)

You can also provide a file path at the end of any of these options to limit the `diff` output to a specific file or subdirectory.

你也可以在任意配置后面提供一个文件路径，以限制`diff`只针对一个特定文件或子目录输出。

>**In a nutshell**, you run `git diff` to see details of the `git status` command - how files have been modified or staged on a line by line basis.
>
>**简而言之**，你可以运行`git diff`查看`git status`命令的详情——文件在逐行的基础上如何被修改或暂存。

<span id = "2.4">
##2.4 `git commit` records a snapshot of the staging area 记录暂存区域的快照
[docs](http://git-scm.com/docs/git-commit)
[book](http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository#Committing-Your-Changes)

Now that you have staged the content you want to snapshot with the `git add` command, you run `git commit` to actually record the snapshot. Git records your name and email address with every commit you make, so the first step is to tell Git what these are.

现在你已经使用`git add`命令暂存了你想要快照的内容，你需要运行`git commit`才能真正记录下快照。Git会在你每次提示时记录你的名字和邮件地址，因此第一步是告诉Git它们是什么。

	$ git config --global user.name 'Your Name'
	$ git config --global user.email you@somedomain.com

Let's stage and commit all the changes to our `hello.rb` file. In this first example, we'll use the `-m` option to provide the commit message on the command line.

让我们暂存和提交所有的修改到`hello.rb`文件中。在这第一个例子中，我们使用`-m`选项在命令行提供提交信息。

	$ git add hello.rb 
	$ git status -s
	M  hello.rb
	$ git commit -m 'my hola mundo changes'
	[master 68aa034] my hola mundo changes
	 1 files changed, 2 insertions(+), 1 deletions(-)

Now we have recorded the snapshot. If we run `git status` again, we will see that we have a "clean working directory", which means that we have not made any changes since our last commit - there is no un-snapshotted work in our checkout.

现在我们已经记录了快照。如果我们再次运行`git status`，我们将会看到我们已经“清扫了工作目录”，这意味着我们从上次提交之后没有做任何修改——在我们的检查中没有未进行快照的工作。

	$ git status
	# On branch master
	nothing to commit (working directory clean)

If you leave off the `-m` option, Git will try to open a text editor for you to write your commit message. In `vim`, which it will default to if it can find nothing else in your settings, the screen might look something like this:

如果你没有带上`-m`选项，Git将尝试为你打开一个文本编辑器编写你的提交信息。如果在你的设置中找不到其他的，那默认就是`vim`。在`vim`中，屏幕可能看起来像这样：

	# Please enter the commit message for your changes. Lines starting
	# with '#' will be ignored, and an empty message aborts the commit.
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	# modified:   hello.rb
	#
	~
	~
	".git/COMMIT_EDITMSG" 9L, 257C

At this point you add your actual commit message at the top of the document. Any lines starting with '#' will be ignored - Git will put the output of the `git status` command in there for you as a reminder of what you have modified and staged.

在这个时候你在文档的顶部添加实际的提交信息。任何以‘#’号开始的行都会被忽略——Git会在这里放入`git status`的输出，提醒你修改和暂存了什么。

In general, it's very important to write a good commit message. For open source projects, it's generally a rule to write your message more or less in this format:

通常，写一个好的提交信息是很重要的。对于开源工程，通常规定要或多或少的按照这个格式写下你的信息：

	Short (50 chars or less) summary of changes
	
	More detailed explanatory text, if necessary.  Wrap it to about 72
	characters or so.  In some contexts, the first line is treated as the
	subject of an email and the rest of the text as the body.  The blank
	line separating the summary from the body is critical (unless you omit
	the body entirely); some git tools can get confused if you run the
	two together.
	
	Further paragraphs come after blank lines.
	
	 - Bullet points are okay, too
	
	 - Typically a hyphen or asterisk is used for the bullet, preceded by a
	   single space, with blank lines in between, but conventions vary
	   here
	
	# Please enter the commit message for your changes. Lines starting
	# with '#' will be ignored, and an empty message aborts the commit.
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	# modified:   hello.rb
	#
	~
	~
	~
	".git/COMMIT_EDITMSG" 25L, 884C written

The commit message is very important. Since much of the power of Git is this flexibility in carefully crafting commits locally and then sharing them later, it is very powerful to be able to write three or four commits of logically separate changes so that your work may be more easily peer reviewed. Since there is a separation between committing and pushing those changes, do take the time to make it easier for the people you are working with to see what you've done by putting each logically separate change in a separate commit with a nice commit message so it is easier for them to see what you are doing and why.

提交信息是非常重要的。因为Git的大量能力就是它的灵活性，可以小心的在本地进行精确的提交然后再将它们分享出去，能够写三四个本地独立修改的提交将会非常有用，因此你的工作可以更易于仔细审核。因为提交和推送这些修改之间是分离的，请花点时间让与你一起工作的人更容易看到你做了什么，通过把每个独立的本地改动放到独立的提交中并带有一条漂亮的提交信息，这就更容易看出你做了什么以及为什么这么做。

<span id = "2.4.1">
###2.4.1 `git commit -a` automatically stage all tracked, modified files before the commit 在提交之前自动暂存所有已跟踪的和已修改的文件

If you think the `git add` stage of the workflow is too cumbersome, Git allows you to skip that part with the `-a` option. This basically tells Git to run `git add` on any file that is "tracked" - that is, any file that was in your last commit and has been modified. This allows you to do a more Subversion style workflow if you want, simply editing files and then running `git commit -a` when you want to snapshot everything that has been changed. You still need to run `git add` to start tracking new files, though, just like Subversion.

如果你觉得用`git add`命令暂存工作流非常累赘，Git也允许你使用`-a`选项跳过这一部分。这本质上是告诉Git在所有“已跟踪”的文件上运行`git add`——也就是，所有你上次提交的并且已经修改的文件。这允许你做成一个更加Subversion样式的工作流，如果你想要的话，只是编辑文件然后在想要的时候运行`git commit -a`快照修改了的所有事情。然而，你仍然需要运行`git add`命令开始跟踪新的文件，正如Subversion一样。

	$ vim hello.rb
	$ git status -s
	 M  hello.rb
	$ git commit -m 'changes to hello file'
	# On branch master
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	# modified:   hello.rb
	#
	no changes added to commit (use "git add" and/or "git commit -a")
	$ git commit -am 'changes to hello file'
	[master 78b2670] changes to hello file
	 1 files changed, 2 insertions(+), 1 deletions(-)

Notice how if you don't stage any changes and then run `git commit`, Git will simply give you the output of the `git status` command, reminding you that nothing is staged. The important part of that message has been highlighted, saying that nothing is added to be committed. If you use `-a`, it will add and commit everything at once.

注意如果你没有暂存任何改动然后运行`git commit`，Git只会给你`git status`命令的输出，提醒你没有暂存。这个消息的重要部分被高亮显示，述说着没有内容被添加以提交。如果你使用`-a`，将会一次添加和提交每件事。
	
This now lets you complete the entire snapshotting workflow - you make changes to your files, then use `git add` to stage files you want to change, `git status` and `git diff` to see what you've changed, and then finally `git commit` to actually record the snapshot forever.

现在让你完成整个快照工作流——你修改了你的文件，然后使用`git add`暂存你想要修改的文件，使用`git status`和`git diff`查看你已经修改的内容，最后使用`git commit`真正的永久记录快照。

>**In a nutshell**, you run `git commit` to record the snapshot of your staged content. This snapshot can then be compared, shared and reverted to if you need to.
>
>**简而言之**，你运行`git commit`记录你暂存内容的快照。然后快照可以对比、分享和回滚到你想要的快照。

<span id = "2.5">
##2.5 `git reset` undo changes and commits 撤销修改和提交
[docs](http://git-scm.com/docs/git-reset)
[book](http://git-scm.com/book/en/Git-Basics-Undoing-Things#Unstaging-a-Staged-File)

`git reset` is probably the most confusing command written by humans, but it can be very useful once you get the hang of it. There are three specific invocations of it that are generally helpful.

`git reset`可能是最容易被人们写错的命令，但是一旦你掌握它将会非常有用。有三种特定的调用一般都是有帮助的。

<span id = "2.5.1">
###2.5.1 `git reset HEAD` unstage files from index and reset pointer to HEAD 从索引中取消暂存的文件并且重置指针到HEAD

First, you can use it to unstage something that has been accidentally staged. Let's say that you have modified two files and want to record them into two different commits. You should stage and commit one, then stage and commit the other. If you accidentally stage both of them, how do you un-stage one? You do it with `git reset HEAD --` file. Technically you don't have to add the `--` - it is used to tell Git when you have stopped listing options and are now listing file paths, but it's probably good to get into the habit of using it to separate options from paths even if you don't need to.

首先，你可以使用它来取消暂存某些被意外暂存的东西。假设你修改了两个文件，并想要把它们记录到两个不同的提交。你应该暂存并提交一个，然后再暂存并提交另一个。如果你意外的一次暂存了它们两个，你要如何取消暂存一个？你可以使用`git reset HEAD --`文件做到。在技术上你不必须添加`--`——它用于告诉Git你停止列举选项了现在在列举文件路径，不过使用它分割选项和路径可能是个好习惯，即使你不是必须这么做。

Let's see what it looks like to unstage something. Here we have two files that have been modified since our last commit. We will stage both, then unstage one of them.

让我们看看取消暂存是怎么样的。这里我们自从上次提交已经修改了两个文件。我们将暂存它们两个，然后取消暂存其中一个。

	$ git status -s
	 M README
	 M hello.rb
	$ git add .
	$ git status -s
	M  README
	M  hello.rb
	$ git reset HEAD -- hello.rb 
	Unstaged changes after reset:
	M hello.rb
	$ git status -s
	M  README
	 M hello.rb

Now you can run a `git commit` which will just record the changes to the `README` file, not the now unstaged `hello.rb`.

现在你可以运行`git commit`，这将只会记录`README`文件的，而不会记录现在取消暂存的`hello.rb`。

In case you're curious, what it's actually doing here is it is resetting the checksum of the entry for that file in the "index" to be what it was in the last commit. Since `git add` checksums a file and adds it to the "index", `git reset HEAD` overwrites that with what it was before, thereby effectively unstaging it.

假如你很好奇，它在这里实际上做了什么，它只是在“索引”中重置了文件条目的校验，重置到它上一次提交。从`git add`校验一个文件并将其添加到“索引”以后，`git reset HEAD`用它过去的样子覆盖了现在的，因此有效的对其取消。

If you want to be able to just run `git unstage`, you can easily setup an alias in Git. Just run `git config --global alias.unstage "reset HEAD"`. Once you have run that, you can then just run `git unstage [file]` instead.

如果你想要能够只是运行`git unstage`，你可以在Git中简单的设置一个别名。只要运行`git config --global alias.unstage "reset HEAD"`。只要运行过这个，然后你就可以只是运行`git unstage [file]`就行了。

If you forget the command to unstage something, Git is helpful in reminding you in the output of the normal `git status` command. For example, if you run `git status` without the `-s` when you have staged files, it will tell you how to unstage them:

如果你忘记了取消暂存的命令，Git是很有帮助的，在普通的`git status`命令的输出中就会提醒你。例如，如果你运行`git status`而不带上`-s`，当你已经暂存了文件，它会告诉你如何取消暂存。

	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#   modified:   README
	#   modified:   hello.rb
	#

When you run `git reset` without specifying a flag it defaults to `--mixed`. The other options are `--soft` and `--hard`.

当你运行`git reset`而不指定一个标志，它默认是`--mixed`。其他的选项有`--soft`和`--hard`。

<span id = "2.5.2">
###2.5.2 `git reset --soft` moves HEAD to specified commit reference, index and staging are untouched 将HEAD移动到指定的提交引用，索引和暂存都不动

The first thing `git reset` does is undo the last commit and put the files back onto the stage. If you include the `--soft` flag this is where it stops. For example, if you run `git reset --soft HEAD~` (the parent of the HEAD) the last commit will be undone and the files touched will be back on the stage again.

	$ git status -s
	M  hello.rb
	$ git commit -am 'hello with a flower'
	[master 5857ac1] hello with a flower
	 1 files changed, 3 insertions(+), 1 deletions(-)
	$ git status
	# On branch master
	nothing to commit (working directory clean)
	$ git reset --soft HEAD~
	$ git status -s
	M  hello.rb

This is basically doing the same thing as `git commit --amend`, allowing you to do more work before you roll in the file changes into the same commit.

<span id = "2.5.3">
###2.5.3 `git reset --hard` unstage files AND undo any changes in the working directory since last commit 不暂存文件并且撤销从上次提交之后在文件目录中的所有修改

The third option is to go `--hard`. This command discards your staged changes and the changes in your working directory. In other words: it resets your staging area and working directory to the state they were in at the given commit. This is the most dangerous option and is not working directory safe. Any changes not committed will be lost.

	$ git status
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	# modified:   README
	#
	# Changes not staged for commit:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	# modified:   README
	#
	$ git reset --hard HEAD
	HEAD is now at 5857ac1 hello with a flower
	$ git status
	# On branch master
	nothing to commit (working directory clean)

In the above example, while we had both changes ready to commit and ready to stage, a `git reset --hard` wiped them out. The working tree and staging area are reset to the tip of the current branch or HEAD.

You can replace `HEAD` with a commit SHA-1 or another parent reference to reset to that specific point.

>**In a nutshell**, you run `git reset HEAD` to undo the last commit, unstage files that you previously ran `git add` on and wish to not include in the next commit snapshot
>
>**简而言之**，你运行`git reset HEAD`命令撤销上次提交，取消暂存你之前对其运行了`git add`而又不希望在下次提交快照中包含进去的文件。

<span id = "2.6">
##2.6 `git rm` remove files from the staging area 从暂存区域移除文件
[docs](http://git-scm.com/docs/git-rm)
[book](http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository#Removing-Files)

`git rm` will remove entries from the staging area. This is a bit different from `git reset HEAD` which "unstages" files. To "unstage" means it reverts the staging area to what was there before we started modifying things. `git rm` on the other hand just kicks the file off the stage entirely, so that it's not included in the next commit snapshot, thereby effectively deleting it.

By default, a `git rm file` will remove the file from the staging area entirely and also off your disk (the working directory). To leave the file in the working directory, you can use `git rm --cached` .

<span id = "2.6.1">
###2.6.1 `git mv` git rm --cached orig; mv orig new; git add new

Unlike most other version control systems, Git does not track file renames. Instead, it just tracks the snapshots and then figures out what files were likely renamed by comparing snapshots. If a file was removed from one snapshot and another file was added to the next one and the contents are similar, Git figures it was most likely a rename. So, although the `git mv` command exists, it is superfluous - all it does is a `git rm --cached`, moves the file on disk, then runs a `git add` on the new file. You don't really need to use it, but if it's easier, feel free.

In its normal form the command is used to delete files. But it's often easier to just remove the files off your disk and then run `git commit -a`, which will also automatically remove them from your index.

>**In a nutshell**, you run `git rm` to remove files from being tracked in Git. It will also remove them from your working directory.
>
>**简而言之**，你运行`git rm`命令从Git移除已跟踪的文件。这也会将它们从你的工作目录移除。

<span id = "2.7">
##2.7 `git stash` save changes made in the current index and working directory for later 保存在当前索引和工作目录做的修改为了以后使用
[docs](http://git-scm.com/docs/git-stash)
[book](http://git-scm.com/book/en/Git-Tools-Stashing)

You're in the middle of some changes but something comes up that you need to jump over to, like a so-urgent-right-now bugfix, but don't want to commit or lose your current edits. `git stash` is there for you.

当你正在一些修改的中间，但是某些事情来了你需要跳过去，比如一个“如此紧急马上”的bug修复，但你不想提交或丢失你当前的编辑。`git stash`就是为你准备的。

<span id = "2.7.1">
###2.7.1 `git stash` add current changes to the stack 将当前修改添加到栈

Stashing takes the current state of the working directory and index, puts it on a stack for later, and gives you back a clean working directory. It will then leave you at the state of the last commit.

Stash取得当前工作目录和索引的状态，将其放入栈为以后使用，并且让你回到一个清扫干净的工作目录。然后留给你的将是上次提交的状态。

If you have untracked files, `git stash` will not include them. You can either stage those files with `git add` (you don't have to commit) before stashing, or, if you have a recent Git version (1.7.7 or above), you can use `git stash -u` to also stash also unversioned files.

如果你有未跟踪的文件，`git stash`不会包含它们。你可以在stash之前用`git add`暂存它们（不需要提交），或者，如果你有一个最近的Git版本（1.7.7或以上），你可以使用`git stash -u`也可以stash未添加到版本的文件。

	$ git status -s
	M hello.rb
	$ git stash
	Saved working directory and index state WIP on master: 5857ac1 hello with a flower
	HEAD is now at 5857ac1 hello with a flower
	$ git status
	# On branch master
	nothing to commit (working directory clean)

<span id = "2.7.2">
###2.7.2 `git stash list` view stashes currently on the stack 在栈上查看当前的stash

It's helpful to know what you've got stowed on the stash and this is where `git stash list` comes in. Running this command will display a queue of current stash items.

知道你已经把什么装入栈了会非常有帮助，在这里`git stash list`就来了。运行这个命令将显示当前stash项目的队列。

	$ git stash list
	stash@{0}: WIP on master: 5857ac1 hello with a flower
	
The last item added onto the stash will be referenced by `stash@{0}` and increment those already there by one.

最后一个添加到stash中的项目将由`stash@{0}`引用，并且逐个递增。
	
	$ vim hello.rb
	$ git commit -am 'it stops raining'
	[master ee2d2c6] it stops raining
	1 files changed, 1 insertions(+), 1 deletions(-)
	$ vim hello.rb
	$ git stash
	Saved working directory and index state WIP on master: ee2d2c6 it stops raining
	HEAD is now at ee2d2c6 it stops raining
	$ git stash list
	stash@{0}: WIP on master: ee2d2c6 it stops raining
	stash@{1}: WIP on master: 5857ac1 hello with a flower

<span id = "2.7.3">
###2.7.3 `git stash apply` grab the item from the stash list and apply to current working directory 从stash列表中抓取项目应用到当前工作目录

When you're ready to continue from where you left off, run the `git stash apply` command to bring back the saved changes onto the working directory.

当你准备从你离开的地方继续，运行`git stash apply`命令将已保存的修改带回到工作目录。

	$ git stash apply
	# On branch master
	# Changes not staged for commit:
	#   (use "git add <file>..." to update what will be committed)
	#   (use "git checkout -- <file>..." to discard changes in working directory)
	#
	# modified:   hello.rb
	#
	no changes added to commit (use "git add" and/or "git commit -a")

By default it will reapply the last added stash item to the working directory. This will be the item referenced by `stash@{0}`. You can grab another stash item instead if you reference it in the arguments list. For example, `git stash apply stash@{1}` will apply the item referenced by `stash@{1}`.

默认只会重新应用最后添加到stash的项目到工作目录。就是由`stash@{0}`引用的项目。如果你在参数列表中加上引用，你就可以抓取其他的stash项目取代它。例如，`git stash apply stash@{1}`将会应用由`stash@{1}`引用的项目。

If you also want to remove the item from the stack at the same time, use git stash pop instead.

如果你也想要同时从栈中移除项目，使用`git stash pop`命令。

<span id = "2.7.4">
###2.7.4 `git stash drop` remove an item from the stash list 从stash列表移除项目

When you're done with the stashed item and/or want to remove it from the list, run the `git stash drop` command. By default this will remove the last added stash item. You can also remove a specific item if you include it as an argument.

当你完成了已stash项目的工作，并且/或者想要将它从列表中移除，运行`git stash drop`命令。默认会移除最后添加的stash项目。如果你包含引用到参数中，也可以移除指定的项目。

In this example, our stash list has at least two items, but we want to get rid of the item added before last, which is referenced by `stash@{1}`.

在个例子中，我们的stash列表中有至少两个项目，我们想要丢弃在最后一次之前添加的项目，这个项目由`stash@{1}`引用。

	$ git stash drop stash@{1}
	Dropped stash@{1} (0b1478540189f30fef9804684673907c65865d8f)

If you want to remove of all the stored items, just run the `git stash clear` command. But only do this if you're sure you're done with the stash.

如果你想要移除所有储存的项目，只需要运行`git stash clear`命令即可。但是请你确保你已经完成了stash中的工作时才这么做。

>**In a nutshell**, run `git stash` to quickly save some changes that you're not ready to commit or save, but want to come back to while you work on something else.
>
>**简而言之**，运行`git stash`可以快速保存你还没有准备好提交或保存的修改，并且在你完成其他工作时回来。

<span id = "3">
#3 BRANCHING AND MERGING [分支与合并](http://gitref.org/branching/)
[book](http://git-scm.com/book/en/Git-Branching)

Branching in Git is one of its many great features. If you have used other version control systems, it's probably helpful to forget most of what you think about branches - in fact, it may be more helpful to think of them practically as contexts since that is how you will most often be using them. When you checkout different branches, you change contexts that you are working in and you can quickly context-switch back and forth between several different branches.

Git中的分支是其众多大特性之一。如果你用过其他版本控制系统，忘掉大部分你对分支的认识会更有帮助——实际上，把它们想成上下文可能更有帮助，因为这是你最常使用它们的方式。当你检出不同的分支，你就变更了你工作的上下文，你可以快速的将上下文切换回去，甚至在若干个不同的分支之间切换。

>**In a nutshell**, you can create a branch with `git branch (branchname)`, switch into that context with `git checkout (branchname)`, record commit snapshots while in that context, then can switch back and forth easily. When you switch branches, Git replaces your working directory with the snapshot of the latest commit on that branch so you don't have to have multiple directories for multiple branches. You merge branches together with `git merge`. You can easily merge multiple times from the same branch over time, or alternately you can choose to delete a branch immediately after merging it.

>**简而言之**，你可以使用`git branch (branchname)`创建一个分支，使用`git branch (branchname)`切换到该上下文，在该上下文中记录提交快照，然后有很容易的切换回去或切换走。当你切换分支时，Git会用该分支上最后一次提交的快照替换你的工作目录，因此你不会因为有多个分支就有多个目录。你可以使用`git merge`将分支合并到一起。你可以很容易的在不同时候多次合并同一个分支，或者你可以交替的选择在合并一份分支后立即删除它。

<span id = "3.1">
##3.1 `git branch` list, create and manage working contexts 列出，创建和管理工作你上下文
[docs](http://git-scm.com/docs/git-branch)
[book](http://git-scm.com/book/en/Git-Branching-What-a-Branch-Is)

The `git branch` command is a general branch management tool for Git and can do several different things. We'll cover the basic ones that you'll use most - listing branches, creating branches and deleting branches. We will also cover basic `git checkout` here which switches you between your branches.

`git branch`命令时Git上通用的分支管理工具，可以做若干不同的事情。我们将覆盖你使用最多的基础命令——列出分支，创建分支和删除分支。我们也会在这里列出基本的`git checkout`命令在分支之间切换。

<span id = "3.1.1">
###3.1.1 `git branch` list your available branches 列出你的可用分支

Without arguments, `git branch` will list out the local branches that you have. The branch that you are currently working on will have a star next to it and if you have **coloring turned on**, will show the current branch in green.

不带参数，`git branch`就会列出你拥有的所有本地分支。你当前正在工作的分支前面有一个星号，如果你开启了颜色，当前分支就会显示成绿色。

	$ git branch
	* master

This means that we have a 'master' branch and we are currently on it. When you run `git init` it will automatically create a 'master' branch for you by default, however there is nothing special about the name - you don't actually have to have a 'master' branch but since it's the default that is created, most projects do.

这意味着我们有一个‘master’分支，并且我们当前正在上面。当我们运行`git init`时，默认会自动的为你创建‘master’分支，不过这个名字没什么特别的——你实际上不是一定要一个‘master’分支，但是因为它是默认创建的，所以大部分工程都这么做。

<span id = "3.1.2">
###3.1.2 `git branch (branchname)` create a new branch 创建一个新的分支
So let's start by creating a new branch and switching to it. You can do that by running `git branch (branchname)`.

那么让我们开始创建一个新的分支并且切换到它。你可以通过运行`git branch (branchname)`做到。

	$ git branch testing
	$ git branch
	* master
	  testing

Now we can see that we have a new branch. When you create a branch this way it creates the branch at your last commit so if you record some commits at this point and then switch to 'testing', it will revert your working directory context back to when you created the branch in the first place - you can think of it like a bookmark for where you currently are. Let's see this in action - we use `git checkout (branch)` to switch the branch we're currently on.

现在我们可以看到我们有了新的分支。当你用这种方式创建分支时，它会在你最后一次提交的节点创建分支，因此如果你在这个节点记录了一些提交然后切换到‘testing’，将会把你的工作目录上下文回滚到你创建这个分支的第一个位置——你可以把它看成像是在你当前的位置的一个书签。让我们看看这个操作——我们使用`git checkout (branch)`切换到我们当前所在的分支。

	$ ls
	README   hello.rb
	$ echo 'test content' > test.txt
	$ echo 'more content' > more.txt
	$ git add *.txt
	$ git commit -m 'added two files'
	[master 8bd6d8b] added two files
	 2 files changed, 2 insertions(+), 0 deletions(-)
	 create mode 100644 more.txt
	 create mode 100644 test.txt
	$ ls
	README   hello.rb more.txt test.txt
	$ git checkout testing
	Switched to branch 'testing'
	$ ls
	README   hello.rb

So now we can see that when we switch to the 'testing' branch, our new files were removed. We could switch back to the 'master' branch and see them re-appear.

那么现在我们可以看到我们切换到‘testing’分支，我们的新文件被移除了。我们可以切换回‘master’分支，并且看到它们又出现了。

	$ ls
	README   hello.rb
	$ git checkout master
	Switched to branch 'master'
	$ ls
	README   hello.rb more.txt test.txt

<span id = "3.1.3">
###3.1.3 `git branch -v` see the last commit on each branch 查看每个分支上的上一次提交

If we want to see last commits on each branch we can run `git branch -v` to see them.

如果我们想要看到每一个分支上的上一次提交，我们可以运行`git branch -v`查看它们。

	$ git branch -v
	* master      54b417d fix javascript issue
	  development 74c111d modify component.json file
	  testing     62a557a update test scripts

<span id = "3.1.5">
###3.1.4 `git branch -d (branchname)` delete a branch 删除一个分支

If we want to delete a branch (such as the 'testing' branch in the previous example, since there is no unique work on it), we can run `git branch -d (branch)` to remove it.

如果我们想要删除一个分支（例如前面例子中的‘testing’分支，因为不再在上面单独工作了），我们可以运行`git branch -d (branch)`以移除它。

	$ git branch
	* master
	  testing
	$ git branch -d testing
	Deleted branch testing (was 78b2670).
	$ git branch
	* master

<span id = "3.1.5">
###3.1.5 `git push (remote-name) :(branchname)` delete a remote branch 删除一个远程分支

When you're done with a remote branch, whether it's been merged into the remote master or you want to abandon it and sweep it under the rug, you'll issue a `git push` command with a specially placed colon symbol to remove that branch.

当你在一个远程分支上完成了工作，无论你是将它合并到远程主干还是想要抛弃它将它清理掉，你要使用带有特别放置的冒号的`git push`命令来移除那个分支。

	$ git push origin :tidy-cutlery
	To git@github.com:octocat/Spoon-Knife.git
	 - [deleted]         tidy-cutlery

In the above example you've deleted the "tidy-cutlery" branch of the "origin" remote. A way to remember this is to think of the `git push remote-name local-branch:remote-branch` syntax. This states that you want to push your local branch to match that of the remote. When you remove the local-branch portion you're now matching nothing to the remote, effectively telling the remote branch to become nothing.

在上面的例子中你从“orgin”远程库中删除了“tidy-cutlery”分支。记忆这个命令的方式是考虑`git push remote-name local-branch:remote-branch`句法。这说明你想要推送你的本地分支使其远程库中的分支相匹配。当你移除本地分支部分，你现在就正在将空白与远程库匹配，有效的告诉远程分支变成空白。

Alternatively, you can run `git push remote-name --delete branchname` which is a wrapper for the colon refspec (a `source:destination` pair) of deleting a remote branch.

或者，你可以运行`git push remote-name --delete branchname`命令，这是对删除远程分支的冒号语法（`source:destaination`对）的封装。

>**In a nutshell** you use `git branch` to list your current branches, create new branches and delete unnecessary or already merged branches.
>
>**简而言之**，你使用`git branch`列出你当前的分支，创建新的分支和删除没必要的或者已经合并的分支。

<span id = "3.2">
##3.2 `git checkout` switch to a new branch context 切换到新的上下文
[docs](http://git-scm.com/docs/git-checkout)
[book](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging)

<span id = "3.2.1">
###3.2.1 `git checkout -b (branchname)` create and immediately switch to a branch 创建并立即切换到一个分支

In most cases you will be wanting to switch to the branch immediately, so you can do work in it and then merging into a branch that only contains stable work (such as 'master') at a later point when the work in your new context branch is stable. You can do this pretty easily with `git branch newbranch; git checkout newbranch`, but Git gives you a shortcut for this: `git checkout -b newbranch`.

在大多数情况下，你会想要立即切换到某个分支，这样你可以在里面做一些工作，然后在晚一点的时候，当你的新上下文分支也稳定了，再将它们合并到只包含稳定工作的分支（如‘master’分支）。你也非常简单的使用`git branch newbranch; git checkout newbrancn`来实现，但是Git给了你关于这个的快捷方式：`git checkout -b newbranch`。

	$ git branch
	* master
	$ ls
	README   hello.rb more.txt test.txt
	$ git checkout -b removals
	Switched to a new branch 'removals'
	$ git rm more.txt 
	rm 'more.txt'
	$ git rm test.txt 
	rm 'test.txt'
	$ ls
	README   hello.rb
	$ git commit -am 'removed useless files'
	[removals 8f7c949] removed useless files
	 2 files changed, 0 insertions(+), 2 deletions(-)
	 delete mode 100644 more.txt
	 delete mode 100644 test.txt
	$ git checkout master
	Switched to branch 'master'
	$ ls
	README   hello.rb more.txt test.txt

You can see there how we created a branch, removed some of our files while in the context of that branch, then switched back to our main branch and we see the files return. Branching safely isolates work that we do into contexts we can switch between.

你可以在这里看到我们如何创建分支，在该分支的上下文移除一些文件，然后切换回我们的主分支，并看看文件是否回来了。分支将我们做的工作安全的剥离到上下文中，我们可以在之间切换。

If you start on work it is very useful to always start it in a branch (because it's fast and easy to do) and then merge it in and delete the branch when you're done. That way if what you're working on doesn't work out you can easily discard it and if you're forced to switch back to a more stable context your work in progress is easy to put aside and then come back to.

如果你正开始工作，这是非常有用的，通常在一个分支上开始工作（因为这很快并且很容易做），然后合并它并且删除我们已经完成的分支。这样，如果你正做的工作不工作了，你可以很容易的放弃它，并且如果你被迫切换到一个更稳定的上下文，你做到一半的工作很容易被放到一边，然后切换回来。

<span id = "3.3">
##3.3 `git merge` merge a branch context into your current one 合并一个分支上下文到你当前的分支
[docs](http://git-scm.com/docs/git-merge)
[book](http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging#Basic-Merging)

Once you have work isolated in a branch, you will eventually want to incorporate it into your main branch. You can merge any branch into your current branch with the `git merge` command. Let's take as a simple example the 'removals' branch from above. If we create a branch and remove files in it and commit our removals to that branch, it is isolated from our main ('master', in this case) branch. To include those deletions in your 'master' branch, you can just merge in the 'removals' branch.

一旦你已经独立在某个分支上工作，你最终将会想要把它合并到你的主分支。你可以使用`git merge`命令合并任何分支到你的当前分支。我们拿前面的‘removals’分支举个简单的例子。如果我们创建一个分支，然后移除其中的文件，再提交我们的移除到该分支，这就与我们的主分支（在这个例子中是‘master’分支）相脱离了想要在你的‘master’分支中 包含这些删除，你只需要合并到‘removals’分支。

	$ git branch
	* master
	  removals
	$ ls
	README   hello.rb more.txt test.txt
	$ git merge removals
	Updating 8bd6d8b..8f7c949
	Fast-forward
	 more.txt |    1 -
	 test.txt |    1 -
	 2 files changed, 0 insertions(+), 2 deletions(-)
	 delete mode 100644 more.txt
	 delete mode 100644 test.txt
	$ ls
	README   hello.rb

<span id = "3.3.1">
###3.3.1 more complex merges 更复杂的合并

Of course, this doesn't just work for simple file additions and deletions. Git will merge file modifications as well - in fact, it's very good at it. For example, let's see what happens when we edit a file in one branch and in another branch we rename it and then edit it and then merge these branches together. Chaos, you say? Let's see.

当然，这不仅仅是用作简单的文件增加和删除。Git也会合并文件修改——实际上，它做得非常好。例如，让我们看看，当我们在一个分支中编辑某个文件，然后在另一个分支中我们将它重命名并且编辑它，然后将这两个分支合并到一起。你说会乱掉？让我们看看吧。

	$ git branch
	* master
	$ cat hello.rb 
	class HelloWorld
	  def self.hello
	    puts "Hello World"
	  end
	end
	
	HelloWorld.hello

So first we're going to create a new branch named 'change_class' and switch to it so your class renaming changes are isolated. We're going to change each instance of 'HelloWorld' to 'HiWorld'.

那么首先我们将创建一个名叫‘change_class’的新分支并切换到它，这样你重命名类的修改就是独立的。我们将修改每一个‘HelloWorld’的实例到‘HiWorld’。

	$ git checkout -b change_class
	Switched to a new branch 'change_class'
	$ vim hello.rb 
	$ head -1 hello.rb 
	class HiWorld
	$ git commit -am 'changed the class name'
	[change_class 3467b0a] changed the class name
	 1 files changed, 2 insertions(+), 4 deletions(-)

So now we've committed the class renaming changes to the 'change_class' branch. To switch back to the 'master' branch the class name will revert to what it was before we switched branches. Here we can change something different (in this case the printed output) and at the same time rename the file from `hello.rb` to `ruby.rb`.

那么现在我们已经提交重命名类的修改到‘change_class’分支。要切换回‘master’分支，类名会回滚到我们切换分支之前的样子。这里我们将修改一些不同的东西（在这个例子中是打印输出），然后同时将`hello.rb`文件重命名为`ruby.rb`。

	$ git checkout master
	Switched to branch 'master'
	$ git mv hello.rb ruby.rb
	$ vim ruby.rb 
	$ git diff
	diff --git a/ruby.rb b/ruby.rb
	index 2aabb6e..bf64b17 100644
	--- a/ruby.rb
	+++ b/ruby.rb
	@@ -1,7 +1,7 @@
	 class HelloWorld
	
	   def self.hello
	-    puts "Hello World"
	+    puts "Hello World from Ruby"
	   end
	
	 end
	$ git commit -am 'added from ruby'
	[master b7ae93b] added from ruby
	 1 files changed, 1 insertions(+), 1 deletions(-)
	 rename hello.rb => ruby.rb (65%)

Now those changes are recorded in the 'master' branch. Notice that the class name is back to 'HelloWorld', not 'HiWorld'. To incorporate the 'HiWorld' change we can just merge in the 'change_class' branch. However, the name of the file has changed since we branched, what will Git do?

现在这些修改被记录在了‘master’分支。注意类名回到了‘HelloWorld’，而不是‘HiWorld’。要引入‘HiWorld’的修改我们只需要合并‘change_class’分支。但是，我们建立分支之后文件名已经修改了，Git会做什么呢？

	$ git branch
	  change_class
	* master
	$ git merge change_class
	Renaming hello.rb => ruby.rb
	Auto-merging ruby.rb
	Merge made by recursive.
	 ruby.rb |    6 ++----
	 1 files changed, 2 insertions(+), 4 deletions(-)
	$ cat ruby.rb
	class HiWorld
	  def self.hello
	    puts "Hello World from Ruby"
	  end
	end
	
	HiWorld.hello

Well, it will just figure it out. Notice that there are no merge conflicts and the file that had been renamed now has the 'HiWorld' class name change that was done in the other branch. Pretty cool.

好了，它就这样搞定它了。注意这里没有合并冲突，已经被重命名的文件现在也有了在其他分支完成的‘HiWorld’类名修改。太酷了！

<span id = "3.3.2">
###3.3.2 merge conflicts 合并冲突

So, Git merges are magical, we never ever have to deal with merge conflicts again, right? Not quite. In situations where the same block of code is edited in different branches there is no way for a computer to figure it out, so it's up to us. Let's see another example of changing the same line in two branches.

那么，Git合并是奇妙的，我们永远不会再处理合并冲突了，对吗？并不完全是。遇到同一个代码块在不同分支中被编辑的情况，计算机就没有办法搞定，那只有靠我们。让我们看看另一个例子，在两个分支中修改同一行。

	$ git branch
	* master
	$ git checkout -b fix_readme
	Switched to a new branch 'fix_readme'
	$ vim README 
	$ git commit -am 'fixed readme title'
	[fix_readme 3ac015d] fixed readme title
	 1 files changed, 1 insertions(+), 1 deletions(-)

Now we have committed a change to one line in our README file in a branch. Now let's change the same line in a different way back on our 'master' branch.

现在我们在一个分支中提交了对我们的README文件中的一行的修改。现在让我们回到‘master’分支，以不同的方式修改同一行。

	$ git checkout master
	Switched to branch 'master'
	$ vim README 
	$ git commit -am 'fixed readme title differently'
	[master 3cbb6aa] fixed readme title differently
	 1 files changed, 1 insertions(+), 1 deletions(-)

Now is the fun part - we will merge the first branch into our master branch, causing a merge conflict.

现在就是有趣的部分——我们将合并第一个分支到我们的master分支，导致一个合并冲突。

	$ git merge fix_readme
	Auto-merging README
	CONFLICT (content): Merge conflict in README
	Automatic merge failed; fix conflicts and then commit the result.
	$ cat README 
	<<<<<<< HEAD
	Many Hello World Examples
	=======
	Hello World Lang Examples
	>>>>>>> fix_readme

	This project has examples of hello world in
	nearly every programming language.

You can see that Git inserts standard merge conflict markers, much like Subversion, into files when it gets a merge conflict. Now it's up to us to resolve them. We will do it manually here, but check out **git mergetool** if you want Git to fire up a graphical mergetool (like kdiff3, emerge, p4merge, etc) instead.

你可以看到当发生合并冲突时，Git在文件中插入了标准合并冲突标记，非常类似Subversion。现在靠我们来解决它们。我们在此将手工完成，但如果你想要Git启动一个图形化合并工具（像kdiff3，emerge，p4merge等），你也可以检出**git mergetool**。

	$ vim README   # here I'm fixing the conflict
	$ git diff
	diff --cc README
	index 9103e27,69cad1a..0000000
	--- a/README
	+++ b/README
	@@@ -1,4 -1,4 +1,4 @@@
	- Many Hello World Examples
	 -Hello World Lang Examples
	++Many Hello World Lang Examples
	
	  This project has examples of hello world in

A cool tip in doing merge conflict resolution in Git is that if you run `git diff`, it will show you both sides of the conflict and how you've resolved it as shown here. Now it's time to mark the file as resolved. In Git we do that with `git add` - to tell Git the file has been resolved you have to stage it.

在Git中解决合并冲突的一个很酷的点是，如果你运行`git diff`，它会同时向你展示冲突的双方以及你如何处理它的。现在是标记文件已经被处理了的时候。在Git中，我们使用`git add`就可以做到——告诉Git文件已经被处理了你需要暂存它。

	$ git status -s
	UU README
	$ git add README 
	$ git status -s
	M  README
	$ git commit 
	[master 8d585ea] Merge branch 'fix_readme'

And now we've successfully resolved our merge conflict and committed the result.

现在我们已经成功的处理了我们的合并冲突并且提交了结果。

>**In a nutshell** you use `git merge` to combine another branch context into your current branch. It automatically figures out how to best combine the different snapshots into a new snapshot with the unique work of both.
>
>**简而言之**，你使用`git merge`合并另一个分支上下文到你当前的分支。它会自动找出如何最好的合并不同的快照到一个新的包含了两份独立的工作的新快照中。

<span id = "3.4">
##3.4 `git log` show commit history of a branch 展示一个分支的提交历史
[docs](http://git-scm.com/docs/git-log)
[book](http://git-scm.com/book/en/Git-Tools-Revision-Selection#Commit-Ranges)

So far we have been committing snapshots of your project and switching between different isolated contexts, but what if we've forgotten how we've got to where we are? Or what if we want to know how one branch differs from another? Git provides a tool that shows you all the commit messages that have lead up to the snapshot you are currently on, which is called `git log`.

To understand the log command, you have to understand what information is stored when you run the `git commit` command to store a snapshot. In addition to the manifest of files and commit message and information about the person who committed it, Git also stores the commit that you based this snapshot on. That is, if you clone a project, what was the snapshot that you modified to get to the snapshot that you saved? This is helpful to give context to how the project got to where it is and allows Git to figure out who changed what. If Git has the snapshot you save and the one you based it on, then it can automatically figure out what you changed. The commit that a new commit was based on is called the "parent".

To see a chronological list of the parents of any branch, you can run `git log` when you are in that branch. For example, if we run `git log` in the Hello World project that we have been working on in this section, we'll see all the commit messages that we've done.

	$ git log
	commit 8d585ea6faf99facd39b55d6f6a3b3f481ad0d3d
	Merge: 3cbb6aa 3ac015d
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 12:59:47 2010 +0200
	
	    Merge branch 'fix_readme'
	
	    Conflicts:
	        README
	
	commit 3cbb6aae5c0cbd711c098e113ae436801371c95e
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 12:58:53 2010 +0200
	
	    fixed readme title differently
	
	commit 3ac015da8ade34d4c7ebeffa2053fcac33fb495b
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 12:58:36 2010 +0200
	
	    fixed readme title
	
	commit 558151a95567ba4181bab5746bc8f34bd87143d6
	Merge: b7ae93b 3467b0a
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 12:37:05 2010 +0200
	
	    Merge branch 'change_class'
	...
To see a more compact version of the same history, we can use the `--oneline` option.

	$ git log --oneline
	8d585ea Merge branch 'fix_readme'
	3cbb6aa fixed readme title differently
	3ac015d fixed readme title
	558151a Merge branch 'change_class'
	b7ae93b added from ruby
	3467b0a changed the class name
	17f4acf first commit

What this is telling us is that this is the history of the development of this project. If the commit messages are descriptive, this can inform us as to what all changes have been applied or have influenced the current state of the snapshot and thus what is in it.

We can also use it to see when the history was branched and merged with the very helpful `--graph` option. Here is the same command but with the topology graph turned on:

	$ git log --oneline --graph
	*   8d585ea Merge branch 'fix_readme'
	|\
	| * 3ac015d fixed readme title
	* | 3cbb6aa fixed readme title differently
	|/
	*   558151a Merge branch 'change_class'
	|\
	| * 3467b0a changed the class name
	* | b7ae93b added from ruby
	|/
	* 17f4acf first commit

Now we can more clearly see when effort diverged and then was merged back together. This is very nice for seeing what has happened or what changes are applied, but it is also incredibly useful for managing your branches. Let's create a new branch, do some work in it and then switch back and do some work in our master branch, then see how the `log` command can help us figure out what is happening on each.

First we'll create a new branch to add the Erlang programming language Hello World example - we want to do this in a branch so that we don't muddy up our stable branch with code that may not work for a while so we can cleanly switch in and out of it.

	$ git checkout -b erlang
	Switched to a new branch 'erlang'
	$ vim erlang_hw.erl
	$ git add erlang_hw.erl 
	$ git commit -m 'added erlang'
	[erlang ab5ab4c] added erlang
	 1 files changed, 5 insertions(+), 0 deletions(-)
	 create mode 100644 erlang_hw.erl

Since we're having fun playing in functional programming languages we get caught up in it and also add a Haskell example program while still in the branch named 'erlang'.

	$ vim haskell.hs
	$ git add haskell.hs 
	$ git commit -m 'added haskell'
	[erlang 1834130] added haskell
	 1 files changed, 4 insertions(+), 0 deletions(-)
	 create mode 100644 haskell.hs

Finally, we decide that we want to change the class name of our Ruby program back to the way it was. So, we can go back to the master branch and change that and we decide to just commit it directly in the master branch instead of creating another branch.

	$ git checkout master
	Switched to branch 'master'
	$ ls
	README  ruby.rb
	$ vim ruby.rb 
	$ git commit -am 'reverted to old class name'
	[master 594f90b] reverted to old class name
	 1 files changed, 2 insertions(+), 2 deletions(-)

So, now say we don't work on the project for a while, we have other things to do. When we come back we want to know what the 'erlang' branch is all about and where we've left off on the master branch. Just by looking at the branch name, we can't know that we made Haskell changes in there, but using `git log` we easily can. If you give Git a branch name, it will show you just the commits that are "reachable" in the history of that branch, that is the commits that influenced the final snapshot.

	$ git log --oneline erlang
	1834130 added haskell
	ab5ab4c added erlang
	8d585ea Merge branch 'fix_readme'
	3cbb6aa fixed readme title differently
	3ac015d fixed readme title
	558151a Merge branch 'change_class'
	b7ae93b added from ruby
	3467b0a changed the class name
	17f4acf first commit

This way, it's pretty easy to see that we have Haskell code included in the branch (highlighted in the output). What is even cooler is that we can easily tell Git that we only are interested in the commits that are reachable in one branch that are not reachable in another, in other words which commits are unique to a branch in comparison to another.

In this case if we are interested in merging in the 'erlang' branch we want to see what commits are going to effect our snapshot when we do that merge. The way we tell Git that is by putting a `^` in front of the branch that we don't want to see. For instance, if we want to see the commits that are in the 'erlang' branch that are not in the 'master' branch, we can do `erlang ^master`, or vice versa. Note that the Windows command-line treats `^` as a special character, in which case you'll need to surround `^master` in quotes.

	$ git log --oneline erlang ^master
	1834130 added haskell
	ab5ab4c added erlang
	$ git log --oneline master ^erlang
	594f90b reverted to old class name

This gives us a nice, simple branch management tool. It allows us to easily see what commits are unique to which branches so we know what we're missing and what we would be merging in if we were to do a merge.

>**In a nutshell** you use `git log` to list out the commit history or list of changes people have made that have lead to the snapshot at the tip of the branch. This allows you to see how the project in that context got to the state that it is currently in.

<span id = "3.5">
##3.5 `git tag` tag a point in history as important 在历史中重要的节点设置标签
[docs](http://git-scm.com/docs/git-tag)
[book](http://git-scm.com/book/en/Git-Basics-Tagging)

If you get to a point that is important and you want to forever remember that specific commit snapshot, you can tag it with `git tag`. The `tag` command will basically put a permanent bookmark at a specific commit so you can use it to compare to other commits in the future. This is often done when you cut a release or ship something.

如果你到了一个重要节点，你希望永远记住这个特别的提交快照，你可以使用`git tag`给它设置标签。`tag`命令基本上会在特定的提交上方一个永久的书签，那么你可以在未来使用它与其他提交做比较。

Let's say we want to release our Hello World project as version "1.0". We can tag the last commit (`HEAD`) as "v1.0" by running `git tag -a v1.0`. The `-a` means "make an annotated tag", which allows you to add a tag message to it, which is what you almost always want to do. Running this without the `-a` works too, but it doesn't record when it was tagged, who tagged it, or let you add a tag message. It's recommended you always create annotated tags.

假如我们想要发布我们的Hello World工程作为版本“1.0”。我们可以通过运行`git tag -a v1.0`把最后一次提交（`HEAD`）标记为“1.0”。`-a`意味着“做一个带解释的标签”，这允许你向其添加标签信息，这也正是我们几乎总是想要做的事情。也可以不带`-a`运行这个命令工作，但是当它被设置标签时，不会记录谁创建了标签，并且不会让你添加一个标签消息。推荐你最好总是创建带解释的标签。

	$ git tag -a v1.0 

When you run the `git tag -a` command, Git will open your editor and have you write a tag message, just like you would write a commit message.

当你运行`git tag -a`命令，Git会打开你的编辑器并让你写一个标签消息，就像你撰写提交消息一样。

Now, notice when we run `git log --decorate`, we can see our tag there.

现在，注意，当我们运行`git log --decorate`，我们将会在这里看到我们的标签。

	$ git log --oneline --decorate --graph
	* 594f90b (HEAD, tag: v1.0, master) reverted to old class name
	*   8d585ea Merge branch 'fix_readme'
	|\
	| * 3ac015d (fix_readme) fixed readme title
	* | 3cbb6aa fixed readme title differently
	|/
	*   558151a Merge branch 'change_class'
	|\
	| * 3467b0a changed the class name
	* | b7ae93b added from ruby
	|/
	* 17f4acf first commit

If we do more commits, the tag will stay right at that commit, so we have that specific snapshot tagged forever and can always compare future snapshots to it.

如果我们做更多提交，标签也会停留在那个停缴那里，因此我们让那个特定快照永远标记上了，并可以总将它与未来的快照做比较。

We don't have to tag the commit that we're on, however. If we forgot to tag a commit that we released, we can retroactively tag it by running the same command, but with the commit SHA at the end. For example, say we had released commit `558151a` (several commits back) but forgot to tag it at the time. We can just tag it now:

然而，我们不需要给我们当前正处在其上的提交做标签。如果我们忘记给我们发布的提交做标签，我们也可以通过运行相同的命令追溯式的给它做标签，但是最后要带上提交SHA。例如，我们发表了提交`558151a`(若干次提交以前)，但忘记了在那是给它做标签，我们也可以现在给它标签上：

	$ git tag -a v0.9 558151a
	$ git log --oneline --decorate --graph
	* 594f90b (HEAD, tag: v1.0, master) reverted to old class name
	*   8d585ea Merge branch 'fix_readme'
	|\
	| * 3ac015d (fix_readme) fixed readme title
	* | 3cbb6aa fixed readme title differently
	|/
	*   558151a (tag: v0.9) Merge branch 'change_class'
	|\
	| * 3467b0a changed the class name
	* | b7ae93b added from ruby
	|/
	* 17f4acf first commit

Tags pointing to objects tracked from branch heads will be automatically downloaded when you fetch from a remote repository. However, tags that aren't reachable from branch heads will be skipped. If you want to make sure all tags are always included, you must include the `--tags` option.

当获取远程仓库时，指向从分支头部跟踪的对象的标签会自动下载。但是从分支头部无法到达的标签将会跳过。若你想要确保包含所有标签，你必须包含`--tags`选项。

	$ git fetch origin --tags
	remote: Counting objects: 1832, done.
	remote: Compressing objects: 100% (726/726), done.
	remote: Total 1519 (delta 1000), reused 1202 (delta 764)
	Receiving objects: 100% (1519/1519), 1.30 MiB | 1.21 MiB/s, done.
	Resolving deltas: 100% (1000/1000), completed with 182 local objects.
	From git://github.com:example-user/example-repo
	 * [new tag]         v1.0       -> v1.0
	 * [new tag]         v1.1       -> v1.1

If you just want a single tag, use `git fetch <remote> tag <tag-name>`.

如果你只是想要一个简单的标签，使用`git fetch <remote> tag <tag-name>`。

By default, tags are not included when you push to a remote repository. In order to explicitly update these you must include the `--tags` option when using `git push`.

默认情况下，当你推送到远程仓库时，不会创建新的标签。为了准确的更新这些，你必须在使用`git push`时包含`--tags`选项。

>**In a nutshell** you use `git tag` to mark a commit or point in your repo as important. This also allows you to refer to that commit with a more memorable reference than a SHA.
>
>**简而言之**，你使用`git tag`在仓库中标记一次重要的提交或节点。这也允许你引用一个比SHA更加有亲和力。

<span id = "4">
#4 SHARING AND UPDATING PROJECTS [分享和更新工程](http://gitref.org/remotes/)
[book](http://git-scm.com/book/en/Git-Basics-Working-with-Remotes)

Git doesn't have a central server like Subversion. All of the commands so far have been done locally, just updating a local database. To collaborate with other developers in Git, you have to put all that data on a server that the other developers have access to. The way Git does this is to synchronize your data with another repository. There is no real difference between a server and a client - a Git repository is a Git repository and you can synchronize between any two easily.

Git不像Subversion有一个中心服务器。所有的命令到目前为止都是在本地完成的，只是更新一个本地数据库。要在Git上与其他开发者合作，你必须将所有的数据放到其他开发者可以访问的服务器上。Git的实现方式是把你的数据同步到另一个仓库。服务器和客户端之间并没有真正的不同——Git仓库就是Git仓库，你可以很容易在任何两个之间同步。

Once you have a Git repository, either one that you set up on your own server, or one hosted someplace like GitHub, you can tell Git to either push any data that you have that is not in the remote repository up, or you can ask Git to fetch differences down from the other repo.

一旦你有了一个Git仓库，无论你把它设置在你自己的服务器上，还是放在一个像GitHub那样的地方，你都可以让Git将任何还没有在远程仓库中的数据推送上去，或者让Git从其他仓库获取不同的下载。

You can do this any time you are online, it does not have to correspond with a `commit` or anything else. Generally you will do a number of commits locally, then fetch data from the online shared repository you cloned the project from to get up to date, merge any new work into the stuff you did, then push your changes back up.

任何时候只要你在线，你都可以这么做，它不一定要跟一次`commit`或者其他东西保持一致。通常你会在本地做许多的提交，然后从你克隆工程的在线共享仓库获取数据获取最新的信息，把所有新工作合并到你完成的工作中，然后再推送你的修改进行备份。

>**In a nutshell** you can update your project with `git fetch` and share your changes with `git push`. You can manage your remote repositories with `git remote`.
>
>**简而言之**，你可以使用`git fetch`更新你的工程，使用`git push`分享你的修改。你可以使用`git remote`管理你的远程仓库。

<span id = "4.1">
##4.1 `git remote` list, add and delete remote repository aliases 列出，添加和删除远程仓库的化名
[docs](http://git-scm.com/docs/git-remote)
[book](http://git-scm.com/book/en/Git-Basics-Working-with-Remotes#Showing-Your-Remotes)

Unlike centralized version control systems that have a client that is very different from a server, Git repositories are all basically equal and you simply synchronize between them. This makes it easy to have more than one remote repository - you can have some that you have read-only access to and others that you can write to as well.

不像中心化版本控制系统拥有一个与服务端非常不同的客户端，Git仓库根本上是完全相同的，你可以在它们之间同步。这使得很容易拥有不止一个远程仓库——可能有一些你只有只读访问权限而另一些你也可以写。

So that you don't have to use the full URL of a remote repository every time you want to synchronize with it, Git stores an alias or nickname for each remote repository URL you are interested in. You use the `git remote` command to manage this list of remote repos that you care about.

因此你不必每次想要同步时都使用远程仓库的完整URL，Git为每个远程仓库URL储存了一个你感兴趣的化名或昵称。你使用`git remote`命令可以管理你关心的远程仓库列表。

<span id = "4.1.1">
###4.1.1 `git remote` list your remote aliases 列出你的远程化名

Without any arguments, Git will simply show you the remote repository aliases that it has stored. By default, if you cloned the project (as opposed to creating a new one locally), Git will automatically add the URL of the repository that you cloned from under the name 'origin'. If you run the command with the `-v` option, you can see the actual URL for each alias.

不带任何参数，Git将只是展示它存储的远程仓库化名。默认情况下，如果你克隆了某个工程（与在本地新建工程相反），Git会将你克隆的仓库的URL自动添加到名称‘origin’下。如果你使用`-v`选项运行该命令，你可以看到每个化名的实际URL。

	$ git remote
	origin
	$ git remote -v
	origin	git@github.com:github/git-reference.git (fetch)
	origin	git@github.com:github/git-reference.git (push)

You see the URL there twice because Git allows you to have different push and fetch URLs for each remote in case you want to use different protocols for reads and writes.

你看到这里URL出现了两次，因为Git允许你为每个远程库设置不同的推送和获取URL，用于你想要为读和写使用不同的协议的情况。

<span id = "4.1.2">
###4.1.2 `git remote add` add a new remote repository of your project 添加新的远程库到你的工程

If you want to share a locally created repository, or you want to take contributions from someone else's repository - if you want to interact in any way with a new repository, it's generally easiest to add it as a remote. You do that by running `git remote add [alias] [url]`. That adds `[url]` under a local remote named `[alias]`.

如果你想要分享一个本地创建的工程，或者你想要从其他人的仓库中获取他们的贡献——如果你想要以任何方式与一个新仓库交互，通常最简单的方法就是将它添加为一个远程仓库。你可以通过运行`git remote add [alias] [url]`完成这个工作。这会添加`[url]`到名为`[alias]`的本地远程库下。

For example, if we want to share our Hello World program with the world, we can create a new repository on a server (Using GitHub as an example), which should give you a URL, in this case "git@github.com:schacon/hw.git". To add that to our project so we can push to it and fetch updates from it we would do this:

例如，如果我们想要把我们的Hello World工程分享给全世界，我们可以在一个服务器上（例如使用GitHub）创建一个新的仓库，它会给你一个URL，在这个例子中是“git@github.com:schacon/hw.git”。要将其添加到我们的工程，以便我们能推送到它和从它上面获取更新，我们需要这么做：

	$ git remote
	$ git remote add github git@github.com:schacon/hw.git
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)

Like the branch naming, remote alias names are arbitrary - just as 'master' has no special meaning but is widely used because `git init` sets it up by default, 'origin' is often used as a remote name because `git clone` sets it up by default as the cloned-from URL. In this case we'll name the remote 'github', but you could name it just about anything.

与分支的命名类似，远程化名的命名也是直接完成的——正如‘master’没有特殊的意义但却被广泛使用，因为它是`git init`默认设置的，‘origin’也通常被用作远程名称，因为`git clone`默认将它设置在了🤕来源的URL上。在这个例子中我们将远程库命名成了‘github’，但是你可以将它命名成任何东西。

<span id = "4.1.3">
###4.1.3 `git remote rm` removing an existing remote alias 移除已存在的远程化名

Git addeth and Git taketh away. If you need to remove a remote - you are not using it anymore, the project is gone, etc - you can remove it with `git remote rm [alias]`.

加也Git删也Git。如果你需要移除一个远程库——你不再使用它的，工程已经完成，等等——你可以使用`git remote rm [alias]`移除它。

	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	$ git remote add origin git://github.com/pjhyett/hw.git
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/pjhyett/hw.git (fetch)
	origin	git://github.com/pjhyett/hw.git (push)
	$ git remote rm origin
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)

<span id = "4.1.4">
###4.1.4 `git remote rename [old-alias] [new-alias]` rename remote aliases 重命名远程化名

If you want to rename remote aliases without having to delete them and add them again you can do that by running `git remote rename [old-alias] [new-alias]`. This will allow you to modify the current name of the remote.

如果你想要不用删除了再添加就能重命名远程库的化名，你可以通过运行`git remote rename [old-alias] [new-alias]`来实现。这将允许你修改远程库的当前名称。

	$ git remote add github git@github.com:schacon/hw.git
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	$ git remote rename github origin
	$ git remote -v
	origin	git@github.com:schacon/hw.git (fetch)
	origin	git@github.com:schacon/hw.git (push)

>**In a nutshell** with `git remote` you can list our remote repositories and whatever URL that repository is using. You can use `git remote add` to add new remotes, `git remote rm` to delete existing ones or `git remote rename [old-alias] [new-alias]` to rename them.
>
>**简而言之**，使用`git remote`你可以列出我们的远程仓库以及这些仓库使用的URL。你可以使用`git remote add`添加新的远程库，使用`git remote rm`删除已存在的远程库，或者使用`git remote rename [old-alias] [new-alias]`重命名它们。

<span id = "4.1.5">
###4.1.5 `git remote set-url` update an existing remote URL 更新一个已存在的远程URL

Should you ever need to update a remote's URL, you can do so with the `git remote set-url` command.

倘若你需要更新一个远程库的URL，你可以使用`git remote set-url`命令来实现。

	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/pjhyett/hw.git (fetch)
	origin	git://github.com/pjhyett/hw.git (push)
	$ git remote set-url origin git://github.com/github/git-reference.git
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/github/git-reference.git (fetch)
	origin	git://github.com/github/git-reference.git (push)

In addition to this, you can set a different push URL when you include the `--push` flag. This allows you to fetch from one repo while pushing to another and yet both use the same remote alias.

除此之外，当你带上一个`--push`标识时，你可以设置一个不同的推送URL。这允许你从一个仓库获取而推送到另一个仓库，但是使用相同的远程化名。

	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/github/git-reference.git (fetch)
	origin	git://github.com/github/git-reference.git (push)
	$ git remote set-url --push origin git://github.com/pjhyett/hw.git
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/github/git-reference.git (fetch)
	origin	git://github.com/pjhyett/hw.git (push)

Internally, the `git remote set-url` command calls `git config remote`, but has the added benefit of reporting back any errors. `git config remote` on the other hand, will silently fail if you mistype an argument or option and not actually set anything.

在内部，`git remote set-url`命令调用了`git config remote`，但是添加了报告备份任何错误的功能。而另一边，如果你用错了参数或者配置，`git config remote`只会默默的失败，并且实际上不会设置任何东西。

For example, we'll update the github remote but instead reference it as guhflub in both invocations.

例如，我们将更新github远程库并且将其引用换成guhflub，再以上述两种方式调用。

	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/github/git-reference.git (fetch)
	origin	git://github.com/github/git-reference.git (push)
	$ git config remote.guhflub git://github.com/mojombo/hw.git
	$ git remote -v
	github	git@github.com:schacon/hw.git (fetch)
	github	git@github.com:schacon/hw.git (push)
	origin	git://github.com/github/git-reference.git (fetch)
	origin	git://github.com/github/git-reference.git (push)
	$ git remote set-url guhflub git://github.com/mojombo/hw.git
	fatal: No such remote 'guhflub'

>**In a nutshell**, you can update the locations of your remotes with `git remote set-url`. You can also set different push and fetch URLs under the same remote alias.
>
>**简而言之**，你可以使用`git remote set-url`更新你远程库的位置。你也可以在同一个远程化名下设置不同的推送和获取URL。

<span id = "4.2">
##4.2 `git fetch` download new branches and data from a remote repository 从远程仓库下载新的分支和数据
[docs](http://git-scm.com/docs/git-fetch)
[book](http://git-scm.com/book/en/Git-Basics-Working-with-Remotes#Fetching-and-Pulling-from-Your-Remotes)

<span id = "4.3">
##4.3 `git pull` fetch from a remote repo and try to merge into the current branch 从远程分支获取并尝试合并到当前分支
[docs](http://git-scm.com/docs/git-pull)
[book](http://git-scm.com/book/en/Git-Basics-Working-with-Remotes#Fetching-and-Pulling-from-Your-Remotes)

Git has two commands to update itself from a remote repository. `git fetch` will synchronize you with another repo, pulling down any data that you do not have locally and giving you bookmarks to where each branch on that remote was when you synchronized. These are called "remote branches" and are identical to local branches except that Git will not allow you to check them out - however, you can merge from them, diff them to other branches, run history logs on them, etc. You do all of that stuff locally after you synchronize.

Git有两个命令从远程仓库更新自己。`git fetch`会使用另一个仓库同步你，把所有你本地没有的数据拉下来，并在同步时帮你标记每个分支在远程时的地方。这些称为“远程分支”，并与本地分支一模一样，否则Git不会允许你检出它们——但是，你可以从它们合并，将它们与其他分支比较不同，在它们上面运行历史日志，等等。你可以在同步之后本地完成所有工作。

The second command that will fetch down new data from a remote server is `git pull`. This command will basically run a `git fetch` immediately followed by a `git merge` of the branch on that remote that is tracked by whatever branch you are currently in. Running the `fetch` and `merge` commands separately involves less magic and less problems, but if you like the idea of `pull`, you can read about it in more detail in the **official docs**.

第二个会从远程服务器获取下新数据的命令是`git pull`。这个命令根本上是运行了一个`git fetch`命令然后立即运行一个`git merge`命令，将远程的分支合并到你当前在的分支。分开运行`fetch`和`merge`命令会带来更少的意外和更少的问题，但是如果你喜欢使用`pull`，你可以在**官方文档**读到更多关于它的详情。

Assuming you have a remote all set up and you want to pull in updates, you would first run `git fetch [alias]` to tell Git to fetch down all the data it has that you do not, then you would run `git merge [alias]/[branch]` to merge into your current branch anything new you see on the server (like if someone else has pushed in the meantime). So, if you were working on a Hello World project with several other people and wanted to bring in any changes that had been pushed since we last connected, we would do something like this:

假定你有一个准备就绪并想要拉取更新的远程仓库，你可以先运行`git fetch [alias]`命令告诉Git拉取下来所有它有你没有的数据，然后你再运行`git merge [alias]/[branch]`命令将你在服务器上看到的任何新东西合并到你的分支（就好像有其他人在这个时候推送的一样）。那么，如果你在Hello World工程与若干其他人一起工作，并想要加入一些从我们上次连接之后被推送上来的修改，我们可以像这么做：

	$ git fetch github
	remote: Counting objects: 4006, done.
	remote: Compressing objects: 100% (1322/1322), done.
	remote: Total 2783 (delta 1526), reused 2587 (delta 1387)
	Receiving objects: 100% (2783/2783), 1.23 MiB | 10 KiB/s, done.
	Resolving deltas: 100% (1526/1526), completed with 387 local objects.
	From github.com:schacon/hw
	   8e29b09..c7c5a10  master     -> github/master
	   0709fdc..d4ccf73  c-langs    -> github/c-langs
	   6684f82..ae06d2b  java       -> github/java
	 * [new branch]      ada        -> github/ada
	 * [new branch]      lisp       -> github/lisp

Here we can see that since we last synchronized with this remote, five branches have been added or updated. The 'ada' and 'lisp' branches are new, where the 'master', 'c-langs' and 'java' branches have been updated. In our example case, other developers are pushing proposed updates to remote branches for review before they're merged into 'master'.

这里我们可以看到自从我们上次与远程仓库同步，有五个分支已经被添加或更新。‘ada’和‘lisp’分支是新的，‘master’、‘c-langs’和‘java’分支已经被更新。在我们的例子中，其他开发者正将建议的更新推送到远程仓库以待审核，在它们被合并到‘master’之前。

You can see the mapping that Git makes. The 'master' branch on the remote repository becomes a branch named 'github/master' locally. That way you can merge the 'master' branch on that remote into the local 'master' branch by running `git merge github/master`. Or, you can see what new commits are on that branch by running `git log github/master ^master`. If your remote is named 'origin' it would be `origin/master` instead. Almost any command you would run using local branches you can use remote branches with too.

你可以看到Git做的映射。远程仓库上的‘master’分支在本地就是名为‘github/master’的分支。你可以通过运行`git merge github/master`命令合并在远程的‘master’分支到本地‘master’分支。或者，你可以通过运行`git log github/master ^master`命令查看在该分支上有哪些新的提交。如果你的远程分支名叫‘origin’，那本地分支就会是`origin/master`。几乎所有你用于本地分支上运行的命令也可以用在远程分支上。

If you have more than one remote repository, you can either fetch from specific ones by running `git fetch [alias]` or you can tell Git to synchronize with all of your remotes by running `git fetch --all`.

如果你有不止一个远程仓库，你可以通过运行`git fetch [alias]`获取指定的一个，或者也可以通过运行`git fetch --all`告诉Git与所有的远程仓库同步。

>**In a nutshell** you run `git fetch [alias]` to synchronize your repository with a remote repository, fetching all the data it has that you do not into branch references locally for merging and whatnot.
>
>**简而言之**，你可以运行`git fetch [alias]`将一个远程仓库与你的仓库同步，获取所有它有你无的数据到本地分支引用，以进行合并或不合并。

<span id = "4.4">
##4.4 `git push` push your new branches and data to a remote repository 推送你的新分支和数据到远程仓库
[docs](http://git-scm.com/docs/git-push)
[book](http://git-scm.com/book/en/Git-Basics-Working-with-Remotes#Pushing-to-Your-Remotes)

To share the cool commits you've done with others, you need to push your changes to the remote repository. To do this, you run `git push [alias] [branch]` which will attempt to make your [branch] the new [branch] on the [alias] remote. Let's try it by initially pushing our 'master' branch to the new 'github' remote we created earlier.

要分享一个你做的酷酷的提交给其他人，你需要把你的修改推送到远程仓库。要做到这个，你需要运行`git push [alias] [branch]`，这个命令会尝试把你的[分支]做成[alias]远程仓库中的新[分支]。让我们试试首次推送我们的‘master’分支到我们早期创建的新的‘github’远程仓库。

	$ git push github master
	Counting objects: 25, done.
	Delta compression using up to 2 threads.
	Compressing objects: 100% (25/25), done.
	Writing objects: 100% (25/25), 2.43 KiB, done.
	Total 25 (delta 4), reused 0 (delta 0)
	To git@github.com:schacon/hw.git
	 * [new branch]      master -> master

Pretty easy. Now if someone clones that repository they will get exactly what we have committed and all of its history.

非常简单。现在如果有人克隆这个仓库，他们将确切的获得我们提交的内容及其所有的历史。

What if you have a topic branch like the 'erlang' branch created earlier and want to share just that? You can just push that branch instead.

如果你有一个更早创建的主题分支，像‘erlang’分支，你只想分享到这个分支怎么办？你可以只是推送到这个分支。

	$ git push github erlang
	Counting objects: 7, done.
	Delta compression using up to 2 threads.
	Compressing objects: 100% (6/6), done.
	Writing objects: 100% (6/6), 652 bytes, done.
	Total 6 (delta 1), reused 0 (delta 0)
	To git@github.com:schacon/hw.git
	 * [new branch]      erlang -> erlang

Now when people clone or fetch from that repository, they'll get an 'erlang' branch they can look at and merge from. You can push any branch to any remote repository that you have write access to in this way. If your branch is already on the server, it will try to update it, if it is not, Git will add it.

现在当人们从这个仓库克隆或抓取，他们讲获得‘erlang’分支，可以查看或合并该分支。你可以用这种方式推送任意分支到任意远程仓库，只要你有写权限。如果你的分支已经在服务器上了，它会尝试更新它，如果没有，Git将会添加它。

The last major issue you run into with pushing to remote branches is the case of someone pushing in the meantime. If you and another developer clone at the same time, you both do commits, then she pushes and then you try to push, Git will by default not allow you to overwrite her changes. Instead, it basically runs `git log` on the branch you're trying to push and makes sure it can see the current tip of the server's branch in your push's history. If it can't see what is on the server in your history, it concludes that you are out of date and will reject your push. You will rightly have to fetch, merge then push again - which makes sure you take her changes into account.

最后的主要问题是你使用推送跑进远程分支，而其他人同时也在推送。如果你和另一个开发者在同一个时间克隆，都提交了，然后她推送，然后你尝试推送，Git默认会不允许你覆盖她的修改。相反的，基本上要在你试图推送的分支上运行`git log`，确保可以看到在你的推送历史中有服务器分支的当前信息。如果在你的历史中看不到在服务器上有什么，可以推断你当前版本已经过时了，将会拒绝你的推送。你的正确做法是，拉取、合并，然后再次推送——这将确保你把她的修改也纳入进来了。

This is what happens when you try to push a branch to a remote branch that has been updated in the meantime:

这就是当你尝试推送一个分支到一个在此期间已经被更新了的远程分支时将会发生的事：

	$ git push github master
	To git@github.com:schacon/hw.git
	 ! [rejected]        master -> master (non-fast-forward)
	error: failed to push some refs to 'git@github.com:schacon/hw.git'
	To prevent you from losing history, non-fast-forward updates were rejected
	Merge the remote changes before pushing again.  See the 'Note about
	fast-forwards' section of 'git push --help' for details.

You can fix this by running `git fetch github; git merge github/master` and then pushing again.

你可以通过运行`git fetch github; git merge github/master`解决这个问题，然后再次推送。

>**In a nutshell** you run `git push [alias] [branch]` to update a remote repository with the changes you've made locally. It will take what your [branch] looks like and push it to be [branch] on the remote, if possible. If someone else has pushed since you last fetched and merged, the Git server will deny your push until you are up to date.
>
>**简而言之**，你运行`git push [alias] [branch]`使用你在本地做的修改更新远程仓库。它会获取你的[分支]，并将其推送到远程的[分支]，如果可能的话。如果有其他人从你上一次获取和合并之后已经推送了，Git服务器会拒绝你的推送，直到你更新到最新的。

#5 INSPECTION AND COMPARISON [检查和比较](http://gitref.org/inspect/)

[book](http://git-scm.com/book/en/Git-Basics-Viewing-the-Commit-History)

So now you have a bunch of branches that you are using for short lived topics, long lived features and what not. How do you keep track of them? Git has a couple of tools to help you figure out where work was done, what the difference between two branches are and more.

那么现在你有了许多的分支，用于短期的主题、或者长期的特性、或者都不是。你如何保持对他们的跟踪？Git有一些工具可以帮助你弄明白哪里的工作已经完成了，两个分支有什么不同，等等。

>**In a nutshell** you can use `git log` to find specific commits in your project history - by author, date, content or history. You can use `git diff` to compare two different points in your history - generally to see how two branches differ or what has changed from one version of your software to another.
>
>**简而言之**，你可以`git log`在你的工程历史中找到特定的提交——通过作者，日期，内容或历史。你可以使用`git diff`在你的历史中比较两个节点——通常用于查看两个分支有何不同或者你的软件的一个版本与另一个版本之间做了什么修改。

<span id = "5.1">
##5.1 `git log` filter your commit history 过滤你的提交历史
[docs](http://git-scm.com/docs/git-log)
[book](http://git-scm.com/book/en/Git-Basics-Viewing-the-Commit-History#Limiting-Log-Output)

We've already seen how to use `git log` to compare branches, by looking at the commits on one branch that are not reachable from another. (If you don't remember, it looks like this: `git log branchA ^branchB`). However, you can also use `git log` to look for specific commits. Here we'll be looking at some of the more commonly used `git log` options, but there are many. Take a look at the official docs for the whole list.

我们已经看到如何使用`git log`比较分支，查看一个分支上的提交，并没有到达另一个分支上的那些。（如果你不记得了，它看起来像这样：`git log branchA ^branchB`）。然而，你也可以使用`git log`查看指定的提交。这里我们将看到一些更加通用的`git log`选项，但是还有很多。可以到**官方文档**查看完整列表。

<span id = "5.1.1">
###5.1.1 `git log --author` look for only commits from a specific author 仅查找特定作者的提交

To filter your commit history to only the ones done by a specific author, you can use the `--author` option. For example, let's say we're looking for the commits in the Git source code done by Linus. We would type something like `git log --author=Linus`. The search is case sensitive and will also search the email address. The following example will use the `-[number]` option, which will limit the results to the last [number] commits.

要过滤你的提交历史只剩下由特定作者完成的那些，你可以使用`--author`选项。例如，加入我们在Git源代码中查找由Linus完成的提交。我们将写下类似`git log --author=Linus`的东西。该搜索是大小写敏感的，并且也会搜索邮箱地址。下面的例子还使用了`-[number]`选项，这回限制结果为最近的[number]次提交。

	$ git log --author=Linus --oneline -5
	81b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
	3bb7256 make "index-pack" a built-in
	377d027 make "git pack-redundant" a built-in
	b532581 make "git unpack-file" a built-in
	112dd51 make "mktag" a built-in

<span id = "5.1.2">
###5.1.2 `git log --since --before` filter commits by date committed 通过提交日期过滤提交

If you want to specify a date range that you're interested in filtering your commits down to, you can use a number of options such as `--since` and `--before`, or you can also use `--until` and `--after`. For example, to see all the commits in the Git project before three weeks ago but after April 18th, you could run this (We're also going to use --no-merges to remove merge commits):

如果你想要指定一个你感兴趣的日期区间过滤你的提交，你可以使用一些选项如`--since`和`--before`，或者你也可以使用`--until`和`--after`。例如，要查看Git工程中所有三周之前但是在4月18日之后的提交，你可以运行这个（我们还使用`--no-merges`去除了合并提交）：

	$ git log --oneline --before={3.weeks.ago} --after={2010-04-18} --no-merges
	5469e2d Git 1.7.1-rc2
	d43427d Documentation/remote-helpers: Fix typos and improve language
	272a36b Fixup: Second argument may be any arbitrary string
	b6c8d2d Documentation/remote-helpers: Add invocation section
	5ce4f4e Documentation/urls: Rewrite to accomodate transport::address
	00b84e9 Documentation/remote-helpers: Rewrite description
	03aa87e Documentation: Describe other situations where -z affects git diff
	77bc694 rebase-interactive: silence warning when no commits rewritten
	636db2c t3301: add tests to use --format="%N"

<span id = "5.1.3">
###5.1.3 `git log --grep` filter commits by commit message 通过提交信息过滤提交

You may also want to look for commits with a certain phrase in the commit message. Use `--grep` for that. Let's say there was a commit that dealt with using the P4EDITOR environment variable and you wanted to remember what that change looked like - you could find the commit with `--grep`.

你也可能想要使用一个在提交信息中的准确词组查找提交。使用`--grep`。假如有一个提交处理使用了P4EDITOR环境变量，你想要看看还有哪些看起来像这样的修改——你可以使用`--grep`找到该提交。

	$ git log --grep=P4EDITOR --no-merges
	commit 82cea9ffb1c4677155e3e2996d76542502611370
	Author: Shawn Bohrer
	Date:   Wed Mar 12 19:03:24 2008 -0500
	
	    git-p4: Use P4EDITOR environment variable when set
	
	    Perforce allows you to set the P4EDITOR environment variable to your
	    preferred editor for use in perforce.  Since we are displaying a
	    perforce changelog to the user we should use it when it is defined.
	
	    Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
	    Signed-off-by: Simon Hausmann <simon@lst.de>

Git will logically OR all `--grep` and `--author` arguments. If you want to use `--grep` and `--author` to see commits that were authored by someone AND have a specific message content, you have to add the `--all-match` option. In these examples we're going to use the --format option, so we can see who the author of each commit was.

Git逻辑上会对所有的`--grep`和`--author`参数进行“或”运算。如果你想要使用`--grep`和`--author`查看以某人为作者的“并且”包含指定消息内容的提交，你可以添加`--all-match`选项。在这些例子中，我们将使用`--format`选项，这样我们可以查看每一个提交的作者是谁。

If we look for the commit messages with 'p4 depo' in them, we get these three commits:

如果我们查找包含‘p4 depo’的提交信息，我们可以获得这样三条提交：

	$ git log --grep="p4 depo" --format="%h %an %s"
	ee4fd1a Junio C Hamano Merge branch 'master' of git://repo.or.cz/git/fastimport
	da4a660 Benjamin Sergeant git-p4 fails when cloning a p4 depo.
	1cd5738 Simon Hausmann Make incremental imports easier to use by storing the p4 d

If we add a `--author=Hausmann` argument, instead of further filtering it down to the one commit by Simon, it instead will show all commits by Simon OR commits with "p4 depo" in the message:

如果我们添加了一个`--author=Hausmann`参数，来进一步过滤到由Simon做的提交，结果将会展示所有有Simon完成“或”消息中带有‘p4 depo’的提交：

	$ git log --grep="p4 depo" --format="%h %an %s" --author="Hausmann"
	cdc7e38 Simon Hausmann Make it possible to abort the submission of a change to Pe
	f5f7e4a Simon Hausmann Clean up the git-p4 documentation
	30b5940 Simon Hausmann git-p4: Fix import of changesets with file deletions
	4c750c0 Simon Hausmann git-p4: git-p4 submit cleanups.
	0e36f2d Simon Hausmann git-p4: Removed git-p4 submit --direct.
	edae1e2 Simon Hausmann git-p4: Clean up git-p4 submit's log message handling.
	4b61b5c Simon Hausmann git-p4: Remove --log-substitutions feature.
	36ee4ee Simon Hausmann git-p4: Ensure the working directory and the index are cle
	e96e400 Simon Hausmann git-p4: Fix submit user-interface.
	38f9f5e Simon Hausmann git-p4: Fix direct import from perforce after fetching cha
	2094714 Simon Hausmann git-p4: When skipping a patch as part of "git-p4 submit" m
	1ca3d71 Simon Hausmann git-p4: Added support for automatically importing newly ap
	...

However, adding `--all-match` will get the results you're looking for:

然而，添加`--all-match`将得到你要搜索的结果：

	$ git log --grep="p4 depo" --format="%h %an %s" --author="Hausmann" --all-match
	1cd5738 Simon Hausmann Make incremental imports easier to use by storing the p4 d

<span id = "5.1.4">
###5.1.4 `git log -S` filter by introduced diff 通过引入的不同过滤

What if you write really horrible commit messages? Or, what if you are looking for when a function was introduced, or where variables started to be used? You can also tell Git to look through the diff of each commit for a string. For example, if we wanted to find which commits modified anything that looked like the function name 'userformat_find_requirements', we would run this: (note there is no '=' between the '-S' and what you are searching for)

如果你写了确实很讨厌的提交信息怎么办？或者，你正查找一个引入的函数或要使用的变量怎么办？你也可以告诉Git以字符串查找每一次提交的不同。例如，如果我们想要找到哪个提交修改了看起来像函数名‘userformat_find_requirements’的东西，我们可以这么运行：（注意这里在‘-S’和你查找的内容之间没有‘=’）

	$ git log -Suserformat_find_requirements
	commit 5b16360330822527eac1fa84131d185ff784c9fb
	Author: Johannes Gilger
	Date:   Tue Apr 13 22:31:12 2010 +0200
	
	    pretty: Initialize notes if %N is used
	
	    When using git log --pretty='%N' without an explicit --show-notes, git
	    would segfault. This patches fixes this behaviour by loading the needed
	    notes datastructures if --pretty is used and the format contains %N.
	    When --pretty='%N' is used together with --no-notes, %N won't be
	    expanded.
	
	    This is an extension to a proposed patch by Jeff King.
	
	    Signed-off-by: Johannes Gilger
	    Signed-off-by: Junio C Hamano

<span id = "5.1.5">
###5.1.5 `git log -p` show patch introduced at each commit 展示在每次提交引入的补丁

Each commit is a snapshot of the project, but since each commit records the snapshot it was based off of, Git can always calculate the difference and show it to you as a patch. That means for any commit you can get the patch that commit introduced to the project. You can either do this by running `git show [SHA]` with a specific commit SHA, or you can run `git log -p`, which tells Git to put the patch after each commit. It is a great way to summarize what has happened on a branch or between commits.

每一次提交都是工程的一份快照，但因此每次提交都是基于快照记录的，Git总是会计算不同并以一个补丁的形式展示给你。这意味着你的任何提交都可以得到一份提交的补丁引入到工程中。你既可以通过运行`git show [SHA]`带上一个特定的提交哈希值来完成，或者也可以运行`git log -p`，它告诉Git把补丁放在每一次提交的后面。这是总结在一个分支上或两次提交之间发生的什么的很好的方法。

	$ git log -p --no-merges -2
	commit 594f90bdee4faf063ad07a4a6f503fdead3ef606
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 15:46:55 2010 +0200
	
	    reverted to old class name
	
	diff --git a/ruby.rb b/ruby.rb
	index bb86f00..192151c 100644
	--- a/ruby.rb
	+++ b/ruby.rb
	@@ -1,7 +1,7 @@
	-class HiWorld
	+class HelloWorld
	   def self.hello
	     puts "Hello World from Ruby"
	   end
	 end
	
	-HiWorld.hello
	+HelloWorld.hello
	
	commit 3cbb6aae5c0cbd711c098e113ae436801371c95e
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 12:58:53 2010 +0200
	
	    fixed readme title differently
	
	diff --git a/README b/README
	index d053cc8..9103e27 100644
	--- a/README
	+++ b/README
	@@ -1,4 +1,4 @@
	-Hello World Examples
	+Many Hello World Examples
	 ======================
	
	 This project has examples of hello world in

This is a really nice way of summarizing changes or reviewing a series of commits before merging them or releasing something.

这真是一个非常好的方法，用于总结修改，或者在决定合并或放弃之前审核一串提交。

<span id = "5.1.6">
###5.1.6 `git log --stat` show diffstat of changes introduced at each commit 展示在每一次提交引入的修改的diff状态
If the `-p` option is too verbose for you, you can summarize the changes with `--stat` instead. Here is the same log output with `--stat` instead of `-p`

如果`-p`选项对于你来说太冗长了，你可以换用`--stat`总结修改。这是用`--stat`取代`-p`后的同一份日志输出。

	$ git log --stat --no-merges -2
	commit 594f90bdee4faf063ad07a4a6f503fdead3ef606
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 15:46:55 2010 +0200
	
	    reverted to old class name
	
	 ruby.rb |    4 ++--
	 1 files changed, 2 insertions(+), 2 deletions(-)
	
	commit 3cbb6aae5c0cbd711c098e113ae436801371c95e
	Author: Scott Chacon <schacon@gmail.com>
	Date:   Fri Jun 4 12:58:53 2010 +0200
	
	    fixed readme title differently
	
	 README |    2 +-
	 1 files changed, 1 insertions(+), 1 deletions(-)

Same basic information, but a little more compact - it still lets you see relative changes and which files were modified.

同样的基础信息，但是更加简洁——它仍然可以让你看到相应的修改和哪些文件被改动了。

<span id = "5.2">
##5.2 `git diff`
[docs](http://git-scm.com/docs/git-diff)
[book](http://git-scm.com/book/en/Distributed-Git-Maintaining-a-Project#Determining-What-Is-Introduced)

Finally, to see the absolute changes between any two commit snapshots, you can use the `git diff` command. This is largely used in two main situations - seeing how two branches differ from one another and seeing what has changed since a release or some other older point in history. Let's look at both of these situations.

最后，要查看任意两次提交快照之间的绝对变更，你可以使用`git diff`命令。在两种主要的情况它被大量使用——查看一个分支与另一个分支之间有何区别，以及查看从一个发布或者历史中的其他旧节点开始做了什么修改。让我们看看这两种情况。

To see what has changed since the last release, you can simply run `git diff [version]` (or whatever you tagged the release). For example, if we want to see what has changed in our project since the v0.9 release, we can run `git diff v0.9`.

要查看从上一个发布之后做了什么修改，你可以只是运行`git diff [version]`（或者你任何打了标签的发布）。例如，如果你想要查看从v0.9版本发布之后我们的工程中有什么修改，我们可以运行`git diff v0.9`。

	$ git diff v0.9
	diff --git a/README b/README
	index d053cc8..d4173d5 100644
	--- a/README
	+++ b/README
	@@ -1,4 +1,4 @@
	-Hello World Examples
	+Many Hello World Lang Examples
	 ======================
	
	 This project has examples of hello world in
	diff --git a/ruby.rb b/ruby.rb
	index bb86f00..192151c 100644
	--- a/ruby.rb
	+++ b/ruby.rb
	@@ -1,7 +1,7 @@
	-class HiWorld
	+class HelloWorld
	   def self.hello
	     puts "Hello World from Ruby"
	   end
	 end
	
	-HiWorld.hello
	+HelloWorld.hello

Just like `git log`, you can use the `--stat` option with it.

就像`git log`一样，你也可以对它使用`--stat`选项。

	$ git diff v0.9 --stat
	 README  |    2 +-
	 ruby.rb |    4 ++--
	 2 files changed, 3 insertions(+), 3 deletions(-)

To compare two divergent branches, however, you can run something like `git diff branchA branchB` but the problem is that it will do exactly what you are asking - it will basically give you a patch file that would turn the snapshot at the tip of branchA into the snapshot at the tip of branchB. This means if the two branches have diverged - gone in different directions - it will remove all the work that was introduced into branchA and then add everything that was introduced into branchB. This is probably not what you want - you want the changes added to branchB that are not in branchA, so you really want the difference between where the two branches diverged and the tip of branchB. So, if our history looks like this:

然而，要比较两个相异的分支，你虽然可以运行像`git diff branchA branchB`这样的东西，但问题是它将只会精确的做你提出的事情——它将基本上就是给你一个从分支A的顶部的快照到分支B的顶部的快照的补丁文件。这意味着如果两个分支是相异的——走向不同的方向——它将移除引入到分支A中的所有的工作，然后添加移入到分支B中的所有工作。这可能不是你想要的——你想要知道添加到分支B中但没有添加到分支A中的修改，那么你实际上是想要知道这两个分支的不同和分支B的顶部之间的区别。那么，如果我们的历史看起来像这样：

	$ git log --graph --oneline --decorate --all
	* 594f90b (HEAD, tag: v1.0, master) reverted to old class name
	| * 1834130 (erlang) added haskell
	| * ab5ab4c added erlang
	|/
	*   8d585ea Merge branch 'fix_readme'
	...

And we want to see what is on the "erlang" branch compared to the "master" branch, running `git diff master erlang` will give us the wrong thing.

以及我们想看看“erlang”分支上的东西与“master”分支的比较，运行`git diff master erlang`会提供给我们错误的东西。

	$ git diff --stat master erlang
	 erlang_hw.erl |    5 +++++
	 haskell.hs    |    4 ++++
	 ruby.rb       |    4 ++--
	 3 files changed, 11 insertions(+), 2 deletions(-)

You see that it adds the erlang and haskell files, which is what we did in that branch, but then the output also reverts the changes to the ruby file that we did in the master branch. What we really want to see is just the changes that happened in the "erlang" branch (adding the two files). We can get the desired result by doing the diff from the common commit they diverged from:

你看到添加了erlang和haskell文件，我们在这个分支上这么做了，但是最后输出回滚到我们在master分支上对ruby文件的修改。我们实际上看到的只是在“erlang”分支上发生的修改（添加了两个文件）。我们可以通过在他们分叉的共同提交上做比较就能获得想要的结果：

	$ git diff --stat 8d585ea erlang
	 erlang_hw.erl |    5 +++++
	 haskell.hs    |    4 ++++
	 2 files changed, 9 insertions(+), 0 deletions(-)

That's what we're looking for, but we don't want to have to figure out what commit the two branches diverged from every time. Luckily, Git has a shortcut for this. If you run `git diff master...erlang` (with three dots in between the branch names), Git will automatically figure out what the common commit (otherwise known as the "merge base") of the two commit is and do the diff off of that.

这就是我们正在寻找的，但如果我们不想每次都必须指出两个分支分叉的提交怎么办。幸运的是，Git有一个简便办法。如果你运行`git diff master...erlang`（在两个分支名称之间加三个点），Git会自动指出两个提交之间的共同提交（或这成为“合并基准”），并在这个基础上做比较。

	$ git diff --stat master erlang
	 erlang_hw.erl |    5 +++++
	 haskell.hs    |    4 ++++
	 ruby.rb       |    4 ++--
	 3 files changed, 11 insertions(+), 2 deletions(-)
	$ git diff --stat master...erlang
	 erlang_hw.erl |    5 +++++
	 haskell.hs    |    4 ++++
	 2 files changed, 9 insertions(+), 0 deletions(-)

Nearly every time you want to compare two branches, you'll want to use the triple-dot syntax, because it will almost always give you what you want.

几乎每次你想要比较两个分支，你都可以使用这种三点式语法，因为它几乎总能给出你想要的东西。

As a bit of an aside, you can also have Git manually calculate what the merge-base (first common ancestor commit) of any two commits would be with the `git merge-base` command:

作为一点旁白，你也可以让Git手动的计算任意两个提交的合并基准（第一个共同的原始提交），使用`git merge-base`命令

	$ git merge-base master erlang
	8d585ea6faf99facd39b55d6f6a3b3f481ad0d3d
	You can do the equivalent of git diff master...erlang by running this:
	
	$ git diff --stat $(git merge-base master erlang) erlang
	 erlang_hw.erl |    5 +++++
	 haskell.hs    |    4 ++++
	 2 files changed, 9 insertions(+), 0 deletions(-)

You may prefer using the easier syntax though.

不过你可能倾向于使用更简单的语法。

>**In a nutshell** you can use git diff to see how a project has changed since a known point in the past or to see what unique work is in one branch since it diverged from another. Always use `git diff branchA...branchB` to inspect branchB relative to branchA to make things easier.
>
>**简而言之**，你可以使用`git diff`查看一个工程自从过去的已知点开始有何变化，或者查看一个分支自从与另一个分支分叉之后做了什么独立的工作。使用`git diff branchA...branchB`总是更容易价差分支B与分支A的关系。

