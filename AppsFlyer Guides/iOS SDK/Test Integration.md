# Test Integration - 测试集成

原文链接：[https://dev.appsflyer.com/hc/docs/testing-ios](https://dev.appsflyer.com/hc/docs/testing-ios)

## Before you begin - 开始之前

To successfully complete the test in this document, you must:

要成功完成文档中的测试，你必须：

- Integrate the SDK
- Register your testing device.


- 集成 SDK
- 注册你的测试设备

## Test iOS SDK integration - 测试 iOS SDK 集成

The test consists of:

测试包括：

1. Simulating an ad click and installing the app:

   模拟广告点击和安装 app：

	- If you implement ATT, follow these instructions.
	- If you don't implement ATT, follow these instructions.

	
	- 如果你实现了 ATT，请遵从这些说明。
	- 如果你没有实现 ATT，请遵从这些说明。

2. Inspection the conversion data of the install.

    检查安装的转换数据。

## Apps that implement ATT - 实现了 ATT 的 app

Follow these instructions if you implement App Tracking Transparency (ATT) in your app.

如果你在你的 app 中实现了 App Tracking Transparency (ATT) ，请遵从这些说明。

Attribution will occur via ID matching if the following conditions are met:

如果满足以下条件，将通过 ID 匹配进行归因：

- The attribution link contains the `idfa` parameter
- ATT is implemented and:
	- `requestTrackingAuthorization` is called before `start` (by utilizing waitForATTUserAuthorization)
	- User consent is given.

- 归因链接包含 `idfa` 参数
- ATT 已经实现，并且：
	- 在 `start` 之前 （使用 `waitForATTUserAuthorization`）调用了 `requestTrackingAuthorization` 方法
	- 用户同意跟踪。

### Step 1: Simulate ad click - 第1步：模拟广告点击

Simulate an ad click via an attribution link. Structure the attribution link as follows:

通过归因链接模拟广告点击。归因链接的结构如下：

```
https://app.appsflyer.com/<app_id>?pid=<media_source>
&idfa=<registered_device_idfa>
```

Where:

- app_id is your AppsFlyer app ID (including id prefix)
- pid is the media source to which the install should be attributed to
- idfa is the registered device's IDFA.

其中：

- `app_id` 是你的 AppsFlyer app ID（包括 id 前缀）
- `pid` 是安装应归因的媒体源
- `idfa` 是已注册的设备的 IDFA

#### Example - 例子

If your app ID is id123456789, the attribution link might look like this:

如果你的 app ID 是 id123456789，那么归因链接可能看起来像这样：

```
https://app.appsflyer.com/id123456789?pid=conversionTest1&idfa=1A2B3C4D-9128-4597-1234- 
04E23D654321
```

### Step 2: Install the app - 第2步：安装 app

Enable debug mode and install the app on a registered test device.

启用调试模式并在注册的测试设备上安装应用程序。

### Step 3: Execute test - 第3步：执行测试

Proceed to inspect conversion data.

继续检查转换数据。

## Apps that don't implement ATT - 未实现 ATT 的 app

### Step 1: Simulate an ad click - 第1步：模拟广告点击

Simulate an ad click via an attribution link. Structure the attribution link as follows:

通过归因链接模拟广告点击。归因链接的结构如下：

```
https://app.appsflyer.com/<app_id>?pid=<media_source>
```

Where:

- `app_id` is your AppsFlyer app ID (including id prefix)
- `pid` is the media source to which the install should be attributed to.

其中：

- `app_id` 是你的 AppsFlyer app ID（包括 id 前缀）
- `pid` 是安装应归因的媒体源

#### Example - 例子

If your app ID is id123456789, the attribution link might look like this:

如果你的 app ID 是 id123456789，那么归因链接可能看起来像这样：

```
https://app.appsflyer.com/id123456789?pid=conversionTest1
```

### Step 2: Install the app - 第2步：安装 app

Enable debug mode and install the app on any device–since the IDFA used to register the device isn't available, device registration has no effect in this case.

启用调试模式并在注册的测试设备上安装应用程序。——由于用于注册设备的IDAF不可用，所以在这种情况下设备注册无效。

### Step 3: Execute test - 执行测试

Proceed to inspect conversion data.

继续检查转换数据。

## Inspect conversion data - 检查转换数据

After simulating an ad click and installing the app, follow these steps to inspect the install's conversion data.

在模拟广告点击并安装 app 之后，按照这些步骤检查安装的转换数据。

### Step 1: Retrieve install UID - 第1步：检索安装 UID

Once the app is installed, In the Xcode terminal, search for `conversions.appsflyer`. Look for the uid parameter and copy its value.

装好 app 之后，在 Xcode 终端上，查找 `conversions.appsflyer`。找到 `uid` 参数，并拷贝它的值。

![pic 1](https://files.readme.io/223ae48-log-gcd-payload_en-us.png)

### Step 2: Execute test and inspect response - 第2步：执行测试和检查数据

Go to the Get the conversion data and fill in the required fields:

前往  Get the conversion data 页面，并填入所需的字段：

1. `app-id`: Your app ID
2. `devkey`: Your AppsFlyer dev key
3. `device_id`: paste the value of `uid` from step 1.

1. `app-id`: 你的 app ID
2. `devkey`：你的 AppsFlyer dev key
3. `device_id`：黏贴来自第1步中的 `uid` 的值

![pic](https://files.readme.io/f7577c6-2021-10-17_22-09-25_1.gif)

Then, click **Try it!** to execute the test.

然后，点击 **Try it!** 执行测试。

#### Expected results - 期望的结果

If ATT is implemented and user consent is given, the result is a 200 response similar to (truncated for readability):

如果已经实现 ATT 并且用户同意跟踪，结果是一个类似这样的 200 的响应（为了可读性而截断）：

```
{
    ...
    "af_status" = "Non-organic";
    ...
    "match_type" = id_matching;
    "media_source" = conversionTest1;
    ...
}
```

Otherwise, attribution occurs probabilistically and the result is a 200 response similar to (truncated for readability):

否则，归因会以概率方式发生，结果是一个类似这样的 200 的响应（为了可读性而截断）：

```
{
    ...
    "af_status" = "Non-organic";
    ...
    "match_type" = probabilistic;
    "media_source" = conversionTest1;
    ...
}
```

If the install isn't attributed, the result is a 200 response with the following payload:

如果安装未被归因，结果是带有如下内容的 200 响应：

```
{
    "af_message" = "organic install";
    "af_status" = Organic;
    "install_time" = "2021-08-23 06:59:51.194";
    "is_first_launch" = 1;
}
```

> **Note** **注意**
>
> It might take up to 30 minutes for installs to appear in the dashboard.
>
> 可能需要30分钟安装信息才能显示在仪表板中。

## Troubleshooting the iOS SDK integration - iOS SDK 集成故障排除

### Installs and events are not recorded - 未记录安装和事件

There could be several reasons why installs and events are not recorded:

可能有若干原因会导致安装和事件未被记录：

- **Bad App ID format**: If you specify an app ID in the wrong format, installs and events are not recorded. When setting the app ID in the delegate file, make sure that it is comprised of numbers only. In case the app ID is in the wrong format, the log displays the following error:

- **错误的 App ID 格式**：如果你以错误的格式指定 app ID，则不会记录安装和事件。在代理文件中设置 app ID 时，请确保它仅由数字组成。如果 app ID 的格式错误，日志将显示如下错误信息：

```
\[ERROR\] AppsFlyer: -\[AppsFlyerTracker validateAppID\] 
    AppsFlyer Error: appleAppID should be a number!
```
 
- **Incorrect App ID**: If you specify an app ID that doesn't exist in your account, install and events are not recorded. The log shows the following error:
 
- **App ID 不正确**：如果你指定的 app ID 在你的账户中不存在，则不会记录安装和事件。日志将显示如下错误信息：

```
AppsFlyer: -[AppsFlyerHTTPClient sendRequestEventToServer:isRequestFromCache:appID:isDebug:
        completionHandler:]_block_invoke sent information to server, status = 404
```

The 404 error indicates that the SDK is unable to find the app in your account.

404 错误表示 SDK 在你的账户中找不到该 app。

- **Bad Dev Key**: If you specify an incorrect dev key, installs and events are not recorded. The log shows the following error:

- **错误的 dev key**：如果你指定了错误的 dev key，则不会记录安装和事件。日志将显示如下错误信息：

```
AppsFlyer: -[AppsFlyerHTTPClient 
sendRequestEventToServer:isRequestFromCache:appID:isDebug:completionHandler:]
        _block_invoke sent information to server, status = 400
```

The 400 error indicates that the SDK is unable to authenticate the request to record installs and events. Check that the dev key is the correct one. Also, make sure that the dev key contains only alphanumeric characters.

错误表示 SDK 无法验证记录安装和事件的请求。请检查 dev key 是否正确。此外，确保 dev key 只包含字母和数字字符。

**Correct**:

**正确**：

```
[AppsFlyerLib shared].appleAppID = @"340954503";
```

**Incorrect**:

**错误**：

```
[AppsFlyerLib shared].appleAppID = @"id340954503";
```

**Incorrect**:

**错误**：

```
[AppsFlyerLib shared].appleAppID = @"com.appslyer.sampleapp";
```

### App ID and dev key are correct but install is not recorded - App ID 和 dev key 是正确的，但是安装未被记录

**Scenario**

**场景**

The app contains the correct app ID and dev key but installs are not recorded.

App 包含了正确的 app ID 和 dev key，但是安装未被记录。

**Possible reasons**

**可能原因**

The SDK is not initiated correctly. Make sure to call the `start` method in `applicationDidBecomeActive`:

SDK 没有正确初始化。请确保在 `applicationDidBecomeActive` 中调用 `start` 方法：

```
- (void)applicationDidBecomeActive:(UIApplication *)application { 
      [[AppsFlyerLib shared] start]; 
}
```

### The log shows "AppsFlyer dev key missing or empty. aborting" - 日志显示  "AppsFlyer dev key missing or empty. aborting"

**Scenario**

**场景**

You are trying to see installs and in-app events in the log. The log shows "AppsFlyer dev key missing or empty. Aborting".

你尝试在日志中查看安装和 in-app 事件。而日志显示 "AppsFlyer dev key missing or empty. Aborting"。

**Possible reasons**

**可能原因**

The dev key is not set. Make sure to set it in `appDelegate` in the `didFinishLaunchingWithOptions` method:

未设置 dev key。请确保在 `appDelegate` 的 `didFinishLaunchingWithOptions` 方法中设置它：

```
[AppsFlyerLib shared].appsFlyerDevKey = @"<AF_DEV_KEY>";
```

### Install always attributed to organic - 安装始终归因为自然量

**Scenario**

**场景**

You are testing attribution using attribution links. You've implemented the SDK conversion listener but the log always shows that the install is organic. In addition, no non-organic install is recorded in the dashboard.

你正使用归因链接测试归因。你已经实现了 SDK 转换监听，但是日志总是显示安装是自然量。另外，在后台也没有记录非自然量安装。

**Possible reasons**

**可能原因**

1. The attribution link you are using is incorrect. See our [guide on attribution links](https://support.appsflyer.com/hc/en-us/articles/207447163).
2. Make sure that the device you are testing on is registered.

>

1. 你使用的归因链接不正确。参见我们[关于归因链接的指南](https://support.appsflyer.com/hc/en-us/articles/207447163)。
2. 去报你正测试的设备是已经注册的。

### Revenue is not recorded properly - 收入未正确记录

**Scenario**

**场景**

You are testing in-app events with revenue. The events appear in the dashboard but revenue is not recorded

你正在测试带收入的 in-app 事件。在后台可以看到事件，但是收入未被记录。

**Possible reasons**

**可能原因**

The revenue parameter is not formatted correctly. Do NOT format the revenue value in any way. It should not contain comma separators, currency signs, or text. A revenue event should be similar to 1234.56, for example.

收入参数格式不正确。不要以任何方式格式化收入值。它不应包含逗号分隔符、货币符号或文本。例如，收入事件应类似于1234.56。

### I'm getting a 404 on install or event recording - 在记录安装或事件时得到 404

**Scenario**

**场景**

You are testing installs and in-app events to see that they are attributed to the correct media source. However, response 404 appears for both install and in-app events. Neither the install nor the in-app events appear in the dashboard.

您正在测试安装和应用内事件，以查看它们是否属于正确的媒体源。但是，对于安装和应用内事件，都会出现 404 响应。后台中既不显示安装事件，也不显示应用内事件。

**Possible reasons**

**可能原因**

A 404 response indicates that the app ID is incorrect. See [Installs and Events are not recorded](https://support.appsflyer.com/hc/en-us/articles/360001559405-Testing-AppsFlyer-SDK-Integration#debugging-common-issues-with-ios-sdk).

404 响应表示 app ID 不正确。参见 [未记录安装和事件](https://support.appsflyer.com/hc/en-us/articles/360001559405-Testing-AppsFlyer-SDK-Integration#debugging-common-issues-with-ios-sdk)。

### I get response 400 on install or event recording - 在记录安装或事件时得到 400 响应

**Scenario**

**场景**

You are trying to test in-app events in the log. When you trigger events you see response 400 in the logs.

您正在尝试在日志中测试应用内事件。当您触发事件时，您在日志中看到响应码为 400。

**Possible reasons**

**可能原因**

This might indicate an issue with the dev key. Check that the dev key is the correct one. Also, make sure that the dev key contains only alphanumeric characters. See [Installs and Events are not recorded](https://support.appsflyer.com/hc/en-us/articles/360001559405-Testing-AppsFlyer-SDK-Integration#debugging-common-issues-with-ios-sdk).

这可能表明开发密钥存在问题。请检查开发密钥是否正确。此外，请确保开发密钥仅包含字母数字字符。请查看[安装和事件是否未记录](https://support.appsflyer.com/hc/en-us/articles/360001559405-Testing-AppsFlyer-SDK-Integration#debugging-common-issues-with-ios-sdk)。

### I get response 403 on install or event recording - 在记录安装或事件时得到 403 响应

**Scenario**

**场景**

You are trying to test installs and other conversion events in the log. When you trigger these events, you see response 403 (forbidden) in the logs.

您正在尝试在日志中测试安装和其他转化事件。当您触发这些事件时，在日志中看到的响应码为 403（禁止）。

**Possible reasons**

**可能原因**

This might be because you have the Zero package, which does not include attribution data; only data on clicks and impressions. To start receiving attribution data, learn more about the different AppsFlyer packages, and update as needed. You can also contact our customer engagement team at hello@appsflyer.com if you have questions about our packages.

这可能是因为您使用的是 Zero 套餐，该套餐不包括归因数据，只包含点击和曝光数据。要开始接收归因数据，请了解更多关于不同 AppsFlyer 套餐的信息，并根据需要进行更新。如果您对我们的套餐有疑问，也可以通过 hello@appsflyer.com 联系我们的客户参与团队。

### My SDK connection to AppsFlyer is secured by TLS 1.0 or 1.1 - 我连接到 AppsFlyer 的 SDK 是由 TLS 1.0 或 1.1 加密的

To ensure that the connection to AppsFlyer is secured by TLS 1.2 or 1.3 and not by lower TLS versions use the appsflyersdk.com endpoint without a prefix. Specifically call the setHost function in the following way: setHost("","[appsflyersdk.com](http://appsflyersdk.com/)")

为确保连接到 AppsFlyer 的加密采用 TLS 1.2 或 1.3，而非较低版本的 TLS，请使用不带前缀的 appsflyersdk.com 终点。具体调用 setHost 函数的方式如下：setHost("","appsflyersdk.com")












