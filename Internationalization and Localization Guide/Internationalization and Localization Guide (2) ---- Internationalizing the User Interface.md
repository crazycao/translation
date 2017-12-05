# Internationalization and Localization Guide (1) ---- Internationalizing the User Interface

原文地址：
[https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html#//apple_ref/doc/uid/10000171i-CH3-SW3](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html#//apple_ref/doc/uid/10000171i-CH3-SW3)

# 2 Internationalizing the User Interface - 国际化用户界面

Xcode provides several technologies to help you develop an internationalized app. Xcode separates user-facing text from your views and layout so user-facing text can be easily translated independent of your Xcode project. Xcode also provides tools to maintain this separation when you change the user interface. In addition, you may have different sets of other types of resource files for each language you support.

Xcode 提供了若干帮助你开发国际化的 App 的技术。Xcode 把面向用户的文本与你的视图和布局分离，因此面向用户的文本可以很容易的独立于你的 Xcode 工程之外进行翻译。Xcode 也可以提供工具在你改变用户界面时管理该分离。另外，你可能对你支持的每个语言有不同的其他类型的资源文件集合。

## 2.1 Using Base Internationalization - 使用基本国际化

Base internationalization separates user-facing strings from `.storyboard` and `.xib` files. It relieves localizers of the need to modify `.storyboard` and `.xib` files in Interface Builder. Instead, an app has just one set of `.storyboard` and `.xib` files where strings are in the development language—the language that you used to create the `.storyboard` and `.xib` files. These `.storyboard` and `.xib` files are called the base internationalization. When you export localizations, the development language strings are the source that is translated into multiple languages. When you import localizations, Xcode generates language-specific strings files for each `.storyboard` and `.xib` file. The strings files don’t appear in the project navigator until you import localizations or add languages.

基本国际化分离了面向用户的字符串从 `.storyboard` 和 `.xib` 文件。它减轻了本地化者在 Interface Builder 中修改 `.storyboard` 和 `.xib` 文件的需求。相反，App 只要一组使用开发语言 —— 也就是你用来创建 `.storyboard` 和 `.xib` 文件的语言 —— 的 `.storyboard` 和 `.xib` 文件。这些 `.storyboard` 和 `.xib` 文件被称为基础国际化。当你导入本地化是，开发语言字符串是翻译成多种语言的源头。当你引入本地化，Xcode 为每个 `.storyboard` 和 `.xib` 文件生成指定语言的字符串。字符串文件不会在工程导航中出现，除非你引入本地化或添加语言。

In Xcode 5 and later, base internationalization is enabled by default. If you have an older project, enable base internationalization before continuing, as described in [Enabling Base Internationalization](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html#//apple_ref/doc/uid/10000171i-CH3-SW4).

在 Xcode 5 及以后版本，基础国际化是默认启用的。如果你有一个更老的工程，要在继续其他工作之前先启用基础国际化，如《[Enabling Base Internationalization](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html#//apple_ref/doc/uid/10000171i-CH3-SW4)》所述。

## 2.2 Using Auto Layout - 使用自动布局

Use Auto Layout to lay out your views relative to each other without fixed origins, widths, and heights, so that views reposition and resize appropriately when the language or locale changes. Auto Layout makes it possible to have one set of `.storyboard` and `.xib` files for all languages.

使用 Auto Layout 相对布局你的视图，而不使用固定的起点、宽度和高度，以便当语言或位置改变时视图能够正确的重定位和重新计算尺寸。Auto Layout 让用一组 `.storyboard` 和 `.xib` 文件适配所有语言称为可能。

Follow these tips when using Auto Layout for internationalized apps:

当为国际化的 App 使用 Auto Layout 时要遵守下面的忠告：

**Remove fixed width constraints.** Allow views that display localized text to resize. If you use fixed width constraints, localized text may appear cropped in some languages.

**移除固定的宽度约束。**允许显示本地化的文本的视图重新计算大小。如果你使用固定宽度的约束，本地化的文本在某些语言中可能会被裁剪。

**Use intrinsic content sizes.** The default behavior for text fields and labels is to resize automatically. If a view is not adjusting to the size of localized text, select the view and choose Editor > Size To Fit Content.

**使用固有内容尺寸。**文本框和标签的默认行为是会自动重新计算大小的。如果视图不调整本地化的文本的尺寸，点击视图，然后选择 Editor >  Size To Fit Content。

**Use leading and trailing attributes.** When adding constraints, use the attributes leading and trailing for horizontal constraints. For left-to-right languages, such as English, the attributes leading and trailing are equivalent to left and right. For right-to-left language, such as Hebrew or Arabic, leading and trailing are equivalent to right and left. The leading and trailing attributes are the default values for horizontal constraints.

**使用 leading 和 trailing 属性。**当添加约束时，使用 leading 和 trailing 属性作为水平约束。对于从左到右的语言，比如英语，leading 和 trailing 属性与 left 和 right 是相等的。队友从右到左的语言，比如希伯来语或阿拉伯语，leading 和 trailing 等于 right 和 left。Leading 和 Trailing 属性也是水平约束的默认值。

**Pin views to adjacent views.** Pinning causes a domino effect. When one view resizes to fit localized text, other views do the same. Otherwise, views may overlap in some languages.

**把视图 pin 到相邻的视图。**Pin 会导致多米诺骨牌一样的影响。当一个视图重新计算大小以适应本地化的文本，其他视图也做相同的事。否则在某些语言下视图可能部分重叠。

**Constantly test your layout changes.** Test your app using different language settings, as described in [Testing Your Internationalized App](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/TestingYourInternationalApp/TestingYourInternationalApp.html#//apple_ref/doc/uid/10000171i-CH7-SW1).

**不断测试布局变化。**使用不同的语言设置测试你的 App，如《[Testing Your Internationalized App](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/TestingYourInternationalApp/TestingYourInternationalApp.html#//apple_ref/doc/uid/10000171i-CH7-SW1)》所述。

**Don’t set the minimum size or maximum size of a window.** Let the window and its content view adjust to the size of the containing views, which may change when the language changes.

**不要设置 window 的最小尺寸或最大尺寸。让 window 和它的内容视图调节包含的视图的尺寸，这也随着语言改变而改变。

Auto Layout is enabled by default when you create a new project. To enable Auto Layout for an older project, read Adopting Auto Layout in [Auto Layout Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853). To learn how to add constraints and resolve constraint issues, read Auto Layout Guide.

当你创建一个新工程师，Auto Layout 是默认启用。要为一个更老的工程启用 Auto Layout，可阅读 [Auto Layout Guide](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853) d 

Detecting Problems Using Pseudolocalizations

In Interface Builder, you can preview the user interface using pseudolocalizations to detect Auto Layout problems. Before you localize your app and add languages, only pseudolocalizations are available in Interface Builder.

To preview the user interface in a pseudolocalization

In project navigator, select the .storyboard or .xib file you want to preview.
Choose View > Assistant Editor > Show Assistant Editor.
In the assistant editor jump bar, open the Assistant pop-up menu, scroll to the Preview item, and choose the .storyboard or .xib file.
If a preview of the app’s user interface doesn’t appear in the assistant editor, select the window or view you want to preview in the icon or outline view.

In the assistant editor, choose the pseudolocalization you want to use from the language pop-up menu in the lower-right corner.
../Art/ib_preview_double_length1_2x.png
For example, choose “Double-Length Pseudo-Language” from the menu to replace all user-facing strings with duplicate strings. A preview of the localization appears in the assistant editor.
../Art/ib_preview_double_length_2x.png
Enabling Base Internationalization

Verify that your project is using base internationalization and if necessary, enable it before continuing.

To enable base internationalization

In the project navigator, select the project (not a target) and click Info.
If necessary, click the disclosure triangle next to Localizations to reveal the settings.
../Art/bi_disabled_2x.png
If necessary, select the Use Base Internationalization checkbox.
In the dialog that appears, specify the development language for your .storyboard and .xib files.
Select the .storyboard and .xib files in the Resource File column and the development language in the Reference Language column.

../Art/bi_enabled_dialog_2x.png
Xcode modifies your project folder according to the selections you make in this dialog. Xcode creates a Base.lproj folder in your project folder and adds to it the resource files you select. Xcode creates a language folder for the development language but only adds resources that need translation to the folder. For example, if you select English as the development language, Xcode inserts the resource file in the Base.lproj project folder but not the en.lproj folder because the resource is already in English.
If no resources appear in the dialog, add your .storyboard and .xib files to a language, as described in Adding Languages, and repeat these steps.

Click the Finish button.
In the Language table, the number of localized resource files for the Development Language changes from 0 to the number of files you selected.

../Art/bi_enabled_2x.png