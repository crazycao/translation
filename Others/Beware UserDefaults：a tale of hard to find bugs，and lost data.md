# Beware UserDefaults: a tale of hard to find bugs, and lost data

# 小心 UserDefaults：一个关于难以找到的错误和丢失数据的故事

原文地址：[https://christianselig.com/2024/10/beware-userdefaults/](https://christianselig.com/2024/10/beware-userdefaults/)

Excuse the alarmist title, but I think it’s justified, as it’s an issue that’s caused me a ton of pain in both support emails and actually tracking it down, so I want to make others aware of it so they don’t similarly burned.

请原谅这个危言耸听的标题，但我认为这是正当的，因为这个问题给我在支持邮件和实际追踪中带来了很多痛苦，所以我想让其他人意识到这一点，以免他们遭受同样的痛苦。

# Brief intro - 简介

For the uninitiated, UserDefaults (née `NSUserDefaults`) is the de facto iOS standard for persisting non-sensitive, non-massive data to “disk” (AKA offline). In other words, are you storing some user preferences, maybe your user’s favorite ice cream flavors? UserDefaults is great, and used extensively from virtually every iOS app to Apple sample code. Large amount of data, or sensitive data? Look elsewhere! This is as opposed to just storing it in memory where if the user restarts the app all the data is wiped out.

对于不熟悉的人来说，UserDefaults（原名为 `NSUserDefaults`）是 iOS 中用于持久化非敏感、非大量数据到“磁盘”（即离线存储）的事实标准。换句话说，你正在存储一些用户偏好设置，也许是用户喜欢的冰淇淋口味？UserDefaults 很棒，并且从几乎每个 iOS 应用到 Apple 示例代码都被广泛使用。大量数据或敏感数据？请寻找其他解决方案！这（译者注：指离线存储）仅是相对于将数据存储在内存中，因为如果用户重新启动应用，在内存中的所有数据都会被清除。

It’s a really handy tool with a ton of nice, built-in things for you:

它是一个非常方便的工具，具有许多很好的内置功能：

- No needing to mess with writing to files yourself, and better yet, no need to coordinate when to persist values back to the disk
- Easy to share data between your app’s main target and secondary targets (like a widget target)
- Automatic serialization and deserialization: just feed in a String, Date, Int, and UserDefaults handles turning it into bytes and back from bytes
- Thread-safe!
- 无需自己操作文件写入，更重要的是，无需协调何时将值持久化回磁盘
- 易于在应用的主目标和辅助目标（比如小组件目标）之间共享数据
- 自动序列化和反序列化：只需提供一个字符串、日期、整数，UserDefaults 会处理将其转换为字节，然后再从字节转换回来
- 线程安全！

So it’s no wonder it’s used extensively. But yeah, keep the two limitations in mind that Apple hammers home:

因此，毫无疑问它被广泛使用。但是，请记住苹果强调的两个限制：


- Don’t store sensitive data in UserDefaults, that’s what Keychain is for
- Don’t store large amounts of data in UserDefaults, use something like Core Data or Swift Data
- 不要在 UserDefaults 中存储敏感数据，这就是 Keychain 的作用
- 不要在 UserDefaults 中存储大量数据，使用诸如 Core Data 或 Swift Data 这样的东西

# Okay, so what’s the problem - 那么，问题是什么

Turns out, sometimes you can request your saved data back from UserDefaults and it… just won’t have it! That’s a pretty big issue for a system that’s supposed to reliably store data for you.

事实证明，有时候你从 UserDefaults 请求获取已保存的数据，结果却发现它…竟然不见了！对于一个应该可靠存储数据的系统来说，这是一个相当严重的问题。

This can amount to an even bigger issue that leads to permanent data loss.

这可能导致更严重的问题，甚至导致永久数据丢失。

Imagine a situation where a user has been meticulously opening your app for 364 days in a row. On day 365, your app promised a cool reward! When the user last closed the app, you stored `364` to UserDefaults.

想象一种情况，用户已经连续364天认真打开你的应用。在第365天，你的应用承诺提供一个很酷的奖励！当用户上次关闭应用时，你将 `364` 存储到了 UserDefaults 中。

The user wakes up on day 365, excited for their reward:

用户在第365天醒来，为他们的奖励感到兴奋：

1. App launches
2. App queries UserDefaults for how many days in a row the user has opened the app
3. App returns `0` (UserDefaults is mysteriously unavailable so its API returns the default integer value of `0`)
4. It’s a new day, so you increment that value by `1`, so that `0` changes to `1`
5. Save that new value back to UserDefaults

>

1. 应用启动
2. 应用查询 UserDefaults 中用户连续打开应用的天数
3. 应用返回 `0`（UserDefaults 神秘地不可用，因此其 API 返回默认的整数值 `0`）
4. 这是一个新的一天，所以你将该值增加1，从 `0` 变为 `1`
5. 将这个新值保存回 UserDefaults

Now, instead of your user having a fun celebration, their data has been permanently overwritten and reset! They are having a Sad Day™.

现在，用户不再能享受欢乐的庆祝，他们的数据已经被永久覆盖和重置！他们度过了悲伤的一天。

It basically means, if at any point you trust UserDefaults to accurately return your data (which you know, sounds like a fair assumption) you might just get incorrect data, which you then might make worse by overwriting good data with.

基本上，这意味着，如果在任何时候你相信 UserDefaults 能够准确返回你的数据（这听起来像一个合理的假设），你可能会得到不正确的数据，然后通过覆盖好的数据使情况变得更糟。

And remember, you’re not meant to store sensitive data in UserDefaults, but even if it’s not sensitive data it might be valuable. The user’s day streak above is not sensitive data that would be bad if leaked online like a password, but it is valuable to that user. In fact I’d argue any data persisted to the disk is valuable, otherwise you wouldn’t be saving it. And you should be always be able to trust an API to reliably save your data.

请记住，你不应该在 UserDefaults 中存储敏感数据，但即使不是敏感数据，它也可能是有价值的。上面提到的用户连续打开应用的天数并不是像密码一样如果泄露到网上就会很糟糕的敏感数据，但对于用户来说是有价值的。实际上，我认为任何存储在磁盘上的数据都是有价值的，否则你就不会保存它。你应该始终能够信任一个 API 可靠地保存你的数据。

# What??? How is this happening? 😵‍💫 - 什么？？？怎么会这样？ 😵‍💫

As I understand it, there’s basically two systems coming together (and working incorrectly, if you ask me) to cause this:

据我了解，基本上是两个系统相互作用（而且如果你问我的话，它们的工作方式是不正确的）导致了这个问题：

## 1. Sensitive data encryption - 敏感数据加密

When using Keychain or files directly, as a developer you can mark data that should be encrypted until the device is unlocked by Face ID/Touch ID/passcode. This way if you’re storing a sensitive data like a token or password on the device, the contents are encrypted and thus unreadable until the device is unlocked.

当使用 Keychain 或直接操作文件时，作为开发人员，您可以标记应该在设备通过 Face ID/Touch ID/密码解锁之前进行加密的数据。这样，如果您在设备上存储了类似令牌或密码等敏感数据，内容将被加密，因此在设备解锁之前是无法阅读的。

This meant if the device was still locked, and you, say, had a Lock Screen Widget that performed an API request, you would have to show placeholder data until the user unlocked the device, because the sensitive data, namely the user’s API token, was encrypted and unable to be used by the app to fetch and show data until the user unlocked the device. Not the end of the world, but something to keep in mind for secure data like API tokens, passwords, secrets, etc.

这意味着，如果设备仍处于锁定状态，并且您比如说有一个在锁屏小部件上执行 API 请求的情况，您将不得不在用户解锁设备之前显示占位数据，因为敏感数据，即用户的 API 令牌，已被加密，无法被应用程序用于获取和显示数据，直到用户解锁设备。这并不是世界末日，但对于像 API 令牌、密码、秘密等安全数据，这是需要牢记的事情。

## 2. Application prewarming - 应用程序预热

Starting with iOS 15, iOS will sometimes wake up your application early so that when a user launches it down the road it launches even quicker for them, as iOS was able to do some of the heavy lifting early. This is called prewarming. Thankfully per Apple, your application doesn’t fully launch, it’s just some processes required to get your app working:

从 iOS 15 开始，iOS 有时会提前唤醒您的应用程序，以便当用户未来启动它时，它可以更快地启动，因为 iOS 能够提前完成一些繁重的工作。这被称为预热。幸运的是，根据苹果公司的说法，您的应用程序并不会完全启动，只是一些必要的流程来使您的应用程序正常运行：

> Prewarming executes an app’s launch sequence up until, but not including, when `main()` calls `UIApplicationMain(::::)`.
> 
> 预热执行应用程序的启动序列，直到 `main()` 调用 `UIApplicationMain(::::)` 之前。

Okay, so what happened with these two?

好的，那么这两者发生了什么？

It seems at some point, even though UserDefaults is intended for non-sensitive information, it started getting marked as data that needs to be encrypted and cannot be accessed until the user unlocked their device. I don’t know if it’s because Apple found developers were storing sensitive data in there even when they shouldn’t be, but the result is even if you just store something innocuous like what color scheme the user has set for your app, that theme cannot be accessed until the device is unlocked.

似乎在某个时候，即使 UserDefaults 旨在用于非敏感信息，它开始被标记为需要加密的数据，直到用户解锁设备为止无法访问。我不知道是因为苹果发现开发人员在那里存储敏感数据，即使他们不应该这样做，但结果是，即使您只存储像用户为您的应用设置的颜色方案这样无害的东西，该主题也无法在设备解锁之前访问。

Again, who cares? Users have to unlock the device before launching my app, right? I thought so too! It turns out, even though Apple’s prewarming documentation states otherwise, developers have been reporting for years that that’s just wrong, and your app can effectively be fully launched at any time, including before the device is even unlocked.

再说，谁在乎？用户必须在启动我的应用之前解锁设备，对吧？我也是这么认为的！结果发现，尽管苹果的预热文档表明不是这样，开发人员多年来一直报告说这是错误的，您的应用程序实际上可以在任何时候完全启动，甚至在设备解锁之前。

Combining this with the previous UserDefaults change, you’re left with the above situation where the app is launched with crucial data just completely unavailable because the device is still locked.

将这一点与之前的 UserDefaults 更改结合起来，您会发现上述情况，即应用程序在关键数据完全不可用的情况下启动，因为设备仍处于锁定状态。

UserDefaults also doesn’t make this clear at all, which it could do by for instance returning `nil` when trying to access `UserDefaults.standard` if it’s unavailable. Instead, it just looks like everything is as it should be, except none of your saved keys are available anymore, which can make your app think it’s in a “first launch after install” situation.

UserDefaults 也没有清楚地表明这一点，它可以通过例如在尝试访问 `UserDefaults.standard` 时返回 `nil` 来做到这一点，如果它不可用。相反，它看起来一切都如预期那样，只是您保存的键再也不可用，这可能会使您的应用程序认为自己处于“安装后首次启动”的情况。

The whole point of UserDefaults is that it’s supposed to reliably store simple, non-sensitive data so it can be accessed whenever. The fact that this has now changed drastically, and at the same time your app can be launched effectively whenever, makes for an incredibly confusing, dangerous, and hard to debug situation.

UserDefaults 的整个目的是可靠地存储简单的、非敏感的数据，以便随时访问。事实上，现在这种情况已经发生了 drastical 的变化，同时您的应用程序实际上可以在任何时候启动，这使得情况变得极端混乱、危险且难以调试。

# And it’s getting worse with Live Activities - 随着 Live Activities 的使用情况变得更糟糕

If you use Live Activities at all, the cool new API that puts activities in your Dynamic Island and Lock Screen, it seems if your app has an active Live Activity and the user reboots their device, virtually 100% of the time the above situation will occur where your app is launched in the background without UserDefaults being available to it. That means the next time your user actually launches the app, if at any point during your app launching you trusted the contents of UserDefaults, your app is likely in an incorrect state with incorrect data.

如果您使用 [Live Activities](https://developer.apple.com/cn/design/human-interface-guidelines/live-activities)（实时活动），这是一个很酷的新 API，可以将活动放在您的灵动岛和锁屏上，似乎如果您的应用程序具有活动的 Live Activity 并且用户重新启动他们的设备，上述情况几乎 100% 会发生，即您的应用程序在后台启动时无法访问 UserDefaults。这意味着下次用户实际启动应用程序时，如果在应用程序启动过程中的任何时候您信任 UserDefaults 的内容，您的应用程序可能处于不正确的状态，并包含不正确的数据。

This bit me badly, and I’ve had users email me over time that they’ve experienced data loss, and it’s been incredibly tricky to pinpoint why. It turns out it’s simply because the app started up, assuming UserDefaults would return good data, and when it transparently didn’t, it would ultimately overwrite their good data with the returned bad data.

这给我带来了很大困扰，我曾多次收到用户的电子邮件，称他们经历了数据丢失，而且非常难以准确定位原因。事实证明，这仅仅是因为应用程序启动时假设 UserDefaults 会返回良好的数据，但当它未能透明地这样做时，它最终会用返回的错误数据覆盖他们的良好数据。

I’ve talked to a few other developers about this, and they’ve also reported random instances of users being logged out or losing data, and after further experimenting been able to now pinpoint that this is what caused their bug. It happened in past apps to me as well (namely users getting signed out of Apollo due to a key being missing), and I could never figure out why, but this was assuredly it.

我已经与其他一些开发人员讨论过这个问题，他们也报告了用户随机注销或数据丢失的情况，并经过进一步实验，现在已经能够确定这是导致他们 bug 的原因。这在我之前的应用程序中也发生过（尤其是用户因为缺少密钥而从 Apollo 注销），我从未找出原因，但这确实是原因。

If you’ve ever scratched your head at a support email over a user’s app being randomly reset, hopefully this helps!

如果您曾因用户的应用程序被随机重置而感到困惑，希望这有所帮助！

# I don’t like this ☹️ - 我不喜欢这个 ☹️

I can’t overstate what a misstep I think this was. [Security is always a balance with convenience.](https://thecyberpatch.com/security-con-finding-the-right-balance/) Face ID and Touch ID strike this perfectly; they’re both ostensibly less secure per Apple’s own admission than, say, a 20 digit long password, but users are much more likely to adopt biometric security so it’s a massive overall win.

我无法过分强调我认为这是一个多么严重的失误。[安全性始终是便利性的平衡](https://thecyberpatch.com/security-con-finding-the-right-balance/)。Face ID 和 Touch ID 完美地实现了这一点；从苹果自己的承认来看，它们明显比起一个20位长的密码来说安全性更低，但用户更有可能采用生物识别安全，因此这是一个巨大的总体胜利。

Changing UserDefaults in this way feels more on the side of “Your company’s sysadmin requiring you to change your password every week”: dubious security gains at the cost of user productivity and headaches.

以这种方式更改 UserDefaults 更像是“您公司的系统管理员要求您每周更改密码”：怀疑的安全性收益以用户生产力和头痛为代价。

Further, it’s not as if UserDefaults is truly secure with this change. It’s only encrypted between the time the device is rebooted and first unlocked. So sure, if you shut down your phone and someone powers it back up, the name of your pet cow might be knowable to the attacker, but literally any time after you unlock the device after first boot, even if you re-lock it, Mr. Moo will be unencrypted.

此外，即使通过这种更改，UserDefaults 也并非真正安全。它只在设备重新启动并首次解锁之间进行加密。因此，当然，如果您关闭手机，然后有人重新开机，攻击者可能会知道您宠物牛的名字，但在您首次启动设备后解锁之后的任何时间，即使您重新锁定它，Mr. Moo 也将是未加密的。

**Update:** After more investigating it seems like this change has been around for years and years, but the results of it have just has gotten more prevalent with things like prewarming and Live Activities.

**更新：**经过进一步调查，似乎这种更改已经存在多年，但随着预热和 Live Activities 等因素，这个结果变得更加普遍。

I mean no shade to the nice folks at Apple working on UserDefaults, I’m sure there’s a lot of legacy considerations to take into account that I cannot fathom that makes this a complex machine. I’m just sad that this lovely, simple API has some really sharp edges in 2024.

我并不是在对苹果工作人员负责 UserDefaults 的好心人们抛出阴影，我相信有很多我无法理解的遗留考虑因素使这成为一个复杂的机器。我只是感到遗憾，这个可爱而简单的 API 在 2024 年有一些非常尖锐的边缘。

But enough moaning, let’s fix it.

不过，抱怨够了，让我们来解决这个问题。

# Solution 1 - 解决方案 1

Because iOS is now seemingly encrypting UserDefaults, the easiest solution is to check `UIApplication.isProtectedDataAvailable` and if it returns `false`, subscribe to NotificationCenter for when `protectedDataDidBecomeAvailableNotification` is fired. This was previously really useful for knowing when Keychain or locked files were accessible once the device was unlocked, but it now seemingly applies to UserDefaults (despite not being mentioned anywhere in its documentation or UserDefault’s documentation 🙃).

由于 iOS 现在似乎正在加密 UserDefaults，最简单的解决方案是检查 `UIApplication.isProtectedDataAvailable`，如果返回 `false`，则订阅 NotificationCenter，以便在 `protectedDataDidBecomeAvailableNotification` 被触发时得到通知。这在以前非常有用，用于了解设备解锁后 Keychain 或锁定文件何时可访问，但现在似乎也适用于 UserDefaults（尽管在其文档或 UserDefaults 文档中没有提到 🙃）。

I don’t love this solution, because it effectively makes UserDefaults either an asynchronous API (“Is it available? No? Okay I’ll wait here until it is.”), or one where you can only trust its values sometimes, because unlike the Keychain API for instance, UserDefaults API itself does not expose any information about this when you try to access it when it’s in a locked state.

我不太喜欢这个解决方案，因为它实际上使 UserDefaults 成为了一个异步 API（“它可用吗？不？好的，我会在这里等到它可用。”），或者你只能有时候信任它的值，因为与 Keychain API 不同，UserDefaults API 本身在您尝试在其处于锁定状态时访问时并不会提供任何关于此的信息。

Further, some developers have reported UserDefaults still being unavailable even once `isProtectedDataAvailable` returns `true`, presumably where (for one reason or another) UserDefaults isn’t reading the disk store back into memory even though the file became available.

此外，一些开发人员报告说，即使 `isProtectedDataAvailable` 返回 `true`，UserDefaults 仍然不可用，可能是因为（出于某种原因）UserDefaults 没有将磁盘存储重新读入内存，即使文件变为可用。

Further further, `UIApplication.isProtectedDataAvailable` is just not a great API for this use case. For one, it’s weirdly only available in a main app context, so if you’re executing code from a widget extension and want to check if protected data is available, you’ll have to resort to some other method, like trying to write to disk and read it back. And on top of this, isProtectedDataAvailable returns false when the device is locked, which will cause you to think UserDefaults is also unavailable. But remember, UserDefaults is only unavailable before the first lock upon reboot, any time after that it’s totally accessible, and this API will still return false in those cases as UserDefaults doesn’t follow the strict protection mechanism that that API tracks.

进一步说，`UIApplication.isProtectedDataAvailable` 对于这个使用场景来说并不是一个很好的 API。首先，奇怪的是它只在主应用程序上下文中可用，因此如果您从小组件扩展执行代码并希望检查受保护数据是否可用，您将不得不采用其他方法，比如尝试写入磁盘并读回来。此外，当设备被锁定时，`isProtectedDataAvailable` 返回 `false`，这将导致您认为 UserDefaults 也不可用。但请记住，只有在重新启动后的第一次锁定之前，UserDefaults 才不可用，在那之后任何时候都可以完全访问，而此 API 在这些情况下仍将返回 `false`，因为 UserDefaults 不遵循严格的保护机制，该 API 跟踪的机制。

# Solution 2 - 解决方案 2

For the mentioned reasons, I don’t really like/trust Solution 1. I want a version of UserDefaults that acts like what it says on the tin: simply, quickly, and reliably retrieve persisted, non-sensitive values. This is easy enough to whip up ourselves, we just want to keep in mind some of the things UserDefaults handles nicely for us, namely thread-safety, shared between targets, and an easy API where it serializes data without us having to worry about writing to disk. Let’s quickly show how we might approach some of this.

基于上述原因，我并不真的喜欢/信任解决方案 1。我想要一个行为符合其名字的 UserDefaults 版本：简单、快速、可靠地检索持久化的、非敏感值。这很容易自己动手实现，我们只需记住 UserDefaults 为我们处理得很好的一些事情，即线程安全性、在目标之间共享以及一个易于使用的 API，在这个 API 中，它会将数据序列化，而无需我们担心写入磁盘。让我们快速展示一下我们可能如何处理其中的一些内容。

UserDefaults is fundamentally just a plist file stored on disk that is read into memory, so let’s create our own file, and instead of marking it as requiring encryption like iOS weirdly does, we’ll say that’s not required:

UserDefaults 本质上只是存储在磁盘上的 plist 文件，它会被读入内存，因此让我们创建我们自己的文件，而不是像 iOS 奇怪地要求加密一样，我们会说这是不需要的：

```
// Example thing to save
// 要保存的示例内容
let favoriteIceCream = "chocolate"

// Save to your app's shared container directory so it can be accessed by other targets outside main
// 保存到您的应用程序的共享容器目录，以便其他目标（非主目标）可以访问
let appGroupID = ""

// Get the URL for the shared container
// 获取共享容器的 URL
guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID) else {
    fatalError("App Groups not set up correctly")
}

// Create the file URL within the shared container
// 在共享容器内创建文件的 URL
let fileURL = containerURL.appendingPathComponent("Defaults")
    
do {
    let data = favoriteIceCream.data(using: .utf8)
    try data.write(to: fileURL)

    // No encryption please I'm just storing the name of my digital cow Mister Moo
    // 请不要加密，我只是在存储我的数字牛 Mister Moo 的名字
    try FileManager.default.setAttributes([.protectionKey: .none], ofItemAtPath: fileURL.path)
    print("File saved successfully at \(fileURL)")
} catch {
    print("Error saving file: \(error.localizedDescription)")
}
```

(Note that you could theoretically modify the system UserDefaults file in the same way, but Apple documentation recommends against touching the UserDefaults file directly.)
（请注意，您理论上可以以相同的方式修改系统 UserDefaults 文件，但苹果文档建议不要直接触碰 UserDefaults 文件。）

Next let’s make it thread safe by using a DispatchQueue.

接下来，让我们通过使用 DispatchQueue 来确保线程安全。

```
private static let dispatchQueue = DispatchQueue(label: "DefaultsQueue")

func retrieveFavoriteIceCream() -> String? {
   return dispatchQueue.sync { 
      guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "app-group-id") else { return nil }

      let fileURL = containerURL.appendingPathComponent(fileName)
            
      do {
         let data = try Data(contentsOf: fileURL)
         return String(data: data, encoding: .utf8)
      } catch {
         print("Error retrieving file: \(error.localizedDescription)")
         return nil
      }
   }
}

func save(favoriteIceCream: String) {
   dispatchQueue.sync { 
      guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "app-group-id") else { return }

      let fileURL = containerURL.appendingPathComponent(fileName)

      do {
         let data = favoriteIceCream.data(using: .utf8)
         try data.write(to: fileURL)
         try FileManager.default.setAttributes([.protectionKey: .none], ofItemAtPath: fileURL.path)
         print("File saved successfully at \(fileURL)")
      } catch {
         print("Error saving file: \(error.localizedDescription)")
      }
   }
}
```

(You probably don’t need a concurrent queue for this, so I didn’t.)
（您可能不需要一个并发队列，所以我没有添加。）

But with that we have to worry about data types, let’s just make it so long as the type conforms to Codable we can save or retrieve it:

但是，我们需要担心数据类型，让我们只要类型符合 Codable 协议，就可以保存或检索它：

```
func saveCodable(_ codable: Codable, forKey key: String) {
    do {
        let data = try JSONEncoder().encode(codable)
        // Persist raw data bytes to a file like above
        // 像上面那样将原始数据字节持久化到文件中
    } catch {
        print("Unable to encode \(codable): \(error)")
    }
}

func codable<T: Codable>(forKey key: String, as type: T.Type) -> T? {
    let data = // Fetch raw data from disk as done above 
    // 从磁盘获取原始数据，就像上面那样
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        print("Error decoding \(T.self) for key \(key) with error: \(error)")
        return nil
    }
}

// Example usage:
// 示例用法：
let newFavoriteIceCream = "strawberry"
saveCodable(newFavoriteIceCream, forKey: "favorite-ice-cream")

let savedFavoriteIceCream = codable(forKey: "favorite-ice-cream", as: String.self)
```

Put those together, wrap it in a nice little library, and bam, you’ve got a UserDefaults replacement that acts as you would expect. In fact if you like the encryption option you can add it back pretty easily (don’t change the file protection attributes) and you could make it clear in the API when the data is inaccessible due to the device being locked, either by throwing an error, making your singleton nil, awaiting until the device is unlocked, etc.

将它们放在一起，封装成一个漂亮的小库，嘭，你就得到了一个符合你期望的 UserDefaults 替代品。实际上，如果你喜欢加密选项，你可以很容易地将它添加回来（不要更改文件保护属性），并且你可以在 API 中明确表明数据由于设备锁定而无法访问时的情况，可以通过抛出错误、使您的单例值为 `nil`、等待设备解锁等方式。

# Solution 3 - 解决方案 3

Update! I wrote a little library to kinda wrap all of the above into a handy little tool! It’s called [TinyStorage](https://github.com/christianselig/TinyStorage).

更新！我写了一个小库，将上述所有内容封装成一个方便的工具！它叫做 [TinyStorage](https://github.com/christianselig/TinyStorage)。

# End - 结束语

Maybe this is super obvious to you, but I’ve talked to enough developers where it wasn’t, that I hope in writing this it can save you the many, many hours I spent trying to figure out why once in a blue moon a user would be logged out, or their app state would look like it reset, or worst of all: they lost data.

也许对你来说这是非常显而易见的，但我已经和足够多的开发者交流过，他们并不清楚，希望通过写这篇文章能够帮助你节省我花在试图弄清楚为什么偶尔会有用户注销、他们的应用状态看起来像重置了，或者最糟糕的情况：他们丢失了数据，花费的那么多时间。