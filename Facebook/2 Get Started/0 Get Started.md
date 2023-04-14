# Get Started - 入门指南

链接地址：[https://developers.facebook.com/docs/marketing-apis/get-started](https://developers.facebook.com/docs/marketing-apis/get-started)

Create your first ad with the Marketing API by following these steps.

请按照以下步骤，使用市场营销 API 创建首条广告。

## Before You Start - 准备工作

You should get familiar with the Graph API and Facebook's Ad Campaign Structure. Once you are ready to start making calls, you need:

您应熟悉图谱 API 和 Facebook 的广告架构。准备好开始调用后，您需要：

- **Facebook Developer Account**: Use to access our developer tools and create Facebook apps.
- **Facebook App**: A container for any type of Facebook ads functionality you build.
- **Access Token**: You can get a system user access token or a user access token with long-lived expiration.
- **Permissions**, depending on how you are using the API.
- **Ad Account**: You need an ad account to manage access to your ads, billing settings, and spending limits. Find your account's number by visiting Ad Account Setup inside Ads Manager.

- **Facebook 开发者帐户**：用于访问我们的开发者工具和创建 Facebook 应用。
- **Facebook 应用**：作为容纳您构建的各类 Facebook 广告功能的容器。
- **访问口令**：您可以获得系统用户访问口令或长期用户访问口令。
- **权限**：根据您使用 API 的具体方式而定。
- **广告帐户**：您需要一个广告帐户来管理广告、账单设置和花费限额的访问权限。可通过访问广告管理工具中的广告帐户设置来查找您的帐户编号。

After that, you can get started. Don't forget to check [general best practices](https://developers.facebook.com/docs/marketing-api/best-practices) for using the Marketing API.

之后，您便可开始使用。别忘记查看使用市场营销 API 的[通用最佳实践](https://developers.facebook.com/docs/marketing-api/best-practices)。

## Step 1: Create a Campaign - 第 1 步：创建广告系列

Start the process creating a new campaign object from the class `Campaign`. At this stage, you need to set an objective for your ads, which is the overall goal of your campaign. We recommend that you create a `PAUSED` campaign initially, so you do not get billed while testing.

从 `Campaign` 类开始新建广告系列对象的流程。在此阶段，您需要为自己的广告设置一个目标，这也是您广告系列的总目标。我们建议您先创建一个 `PAUSED` 广告系列，避免在测试期间产生费用。

```
curl -X POST \
  -F 'name="My campaign"' \
  -F 'objective="LINK_CLICKS"' \
  -F 'status="PAUSED"' \
  -F 'special_ad_categories=[]' \
  -F 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v15.0/act_<AD_ACCOUNT_ID>/campaigns
```

On success, we return an ID for your newly created ad campaign. Remember to save this ID. You can also verify your campaign has been created in ads manager.

操作成功后，我们会为您新创建的广告系列返回一个编号。切记保存此编号。您可在广告管理工具中验证是否已创建广告系列。

### Resources: - 资源

- [List Of Ad Campaign Objectives in PHP](https://github.com/facebook/facebook-php-business-sdk/blob/main/src/FacebookAds/Object/Values/CampaignObjectiveValues.php) - PHP 版广告目标代码
- [List Of Ad Campaign Objectives in Python](https://github.com/facebook/facebook-python-business-sdk/blob/199daddec0174ac45d4ee985490b987739cb13af/facebookads/mixins.py#L128) - Python 版广告目标代码

## Step 2: Define Targeting - 第 2 步：定义目标受众

Before moving to create your ad sets, you need to define your target audience. In the next step, you create an ad set and specify your audience's attributes.

您需要先定义自己的目标受众，然后再开始创建广告组。在下一步中，创建广告组并指定受众属性。

You have many [targeting options](https://developers.facebook.com/docs/marketing-api/audiences). In this example, we use [targeting search](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search) to find predefined values that can be used to set up an audience.

您有多个[目标受众定位选项](https://developers.facebook.com/docs/marketing-api/audiences)。本示例中，我们会使用[目标受众定位搜索](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search)来查找可用于设置受众的预定义值。

First, let's look for [available countries](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search#geo) including the word "united":

首先，我们来查找包含“united”一词的[可用国家/地区](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search#geo)：

```
curl -G \
  -d 'location_types=["country"]' \
  -d 'type=adgeolocation' \
  -d 'q=united' \
  -d 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v<API_VERSION>/search
```

Then, we can look for [interests](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search#interests) including the word "movie":

然后，我们可以查找包含“movie”一词的[兴趣](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search#interests)：

```
curl -G \
  -d 'type=adinterest' \
  -d 'q=movie' \
  -d 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v<API_VERSION>/search
```

Based on the values returned from the calls above, we know that we can create an audience of people in the United States that are interested in movies. The targeting spec looks like this:

基于上述调用返回的值，我们可以将对电影有兴趣的美国用户创建为受众。目标受众定位规范如下所示：

```
targeting={ 
    "geo_locations": {"countries":["US"]}, 
    "interests": [{id: 6003139266461, 'name': 'Movies'}]
}
```

### Reference Docs - 参考文档
- [Targeting Specs](https://developers.facebook.com/docs/marketing-api/targeting-specs) - 目标受众定位规范
- [Targeting Search](https://developers.facebook.com/docs/marketing-api/audiences/reference/targeting-search) - 目标受众定位搜索

## Step 3: Create Ad Set and Define Budget, Billing, Optimization, and Duration - 步骤 3：创建广告组，并定义预算、账单、优化目标和投放时长

An ad set is a group of ads that share the same daily or lifetime budget, schedule, billing, optimization, and targeting data. In this step, you need to create a new object from the class `AdSet` and specify:

广告组是一组共享相同单日预算或总预算、排期、账单、优化目标和目标受众定位数据的广告。此步骤中，您需要从 `AdSet` 类中创建一个新对象并指定：

- **Duration**: How long your ads will run. Set it using `start_time` and `end_time`.
- **Budget**: How much money you want to spend. Use `daily_budget` or `lifetime_budget`.
- **Optimization**: What result you want to achieve with your ad. Set up using `optimization_goal`.
- **Billing**: How you want to pay. Use `billing_event`.
- **Bid**: What value you place on the occurrence of your optimization event. Use the `bid_amount` field.
- **Targeting**: Use the targeting spec created in **Step 2**.

- **投放时长**：广告的投放时长。使用 `start_time` 和 `end_time` 完成设置。
- **预算**：您愿意花费的金额。使用 `daily_budget` 或 `lifetime_budget`。
- **优化**：希望通过广告获得的成效。使用 `optimization_goal` 进行设置。
- **账单**：付费方式。使用 `billing_event`。
- **竞价**：您愿意为执行优化事件支付的金额。使用 `bid_amount` 字段。
- **设置目标受众**：使用**第 2 步**中创建的目标受众定位规范。

To create your ad set, you also need the ad campaign ID you saved from **Step 1**:

要创建广告组，您还需使用**第 1 步**中保存的广告系列编号：

```
curl \
  -F 'name=My Ad Set' \
  -F 'optimization_goal=REACH' \
  -F 'billing_event=IMPRESSIONS' \
  -F 'bid_amount=2' \
  -F 'daily_budget=1000' \
  -F 'campaign_id=<CAMPAIGN_ID>' \
  -F 'targeting={"geo_locations": {"countries":["US"]}, "interests": [{id: 6003139266461, 'name': 'Movies'}]}' \
  -F 'start_time=2020-10-06T04:45:17+0000' \
  -F 'status=PAUSED' \
  -F 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v<API_VERSION>/act_<AD_ACCOUNT_ID>/adsets
```

We recommend the creation of an ad set with the `PAUSED` status to avoid charges during your test.

我们推荐您使用 `PAUSED` 状态创建广告组，以免在测试期间产生费用。

## Step 4: Provide Ad Creative - 第 4 步：提供广告创意

In this step, you will use the `AdCreative` object to provide the visual elements of your ad. The information you need to provide depends on your objective, but common attributes are:

在此步骤中，您将使用 `AdCreative` 对象提供广告的视觉元素。您应根据广告目标构思需要传达的信息，但常用属性如下：

- Images and videos
- Title and description
- Links
- Call to Action buttons

- 图像和视频
- 标题和描述
- 链接
- 触发行动的按钮

Depending on your objective you may have to provide advanced fields. For example, ads for an iOS app require an app store URL.

根据您的目标，您可能需要提供某些高级字段。例如，iOS 应用的广告必须提供 App Store 的网址。

You can define creative as part of an ad set or standalone. In either case, we store your ad creative in your ad account's creative library to use in ads.

您可以将创意定义为广告组或独立广告的一部分。无论是哪种情况，我们都会将您的广告创意存储在您广告帐户下要用于广告的创意库中。

### Example - 示例

This example shows how to provide an image and create the `AdCreative` object.

此示例会演示如何提供图像和创建 `AdCreative` 对象。

First, create an `AdImage` object from an image file:

首先，根据图像文件创建一个 `AdImage` 对象：

```
curl \
  -F 'filename=@<IMAGE_PATH>' \
  -F 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v<API_VERSION>/act_<AD_ACCOUNT_ID>/adimages
```

Then, use the image hash to create the `AdCreative`:

然后，使用图像哈希创建 `AdCreative`：

```
curl -X POST \
  -F 'name="Sample Creative"' \
  -F 'object_story_spec={
       "page_id": "<PAGE_ID>",
       "link_data": {
         "image_hash": "<IMAGE_HASH>",
         "link": "https://facebook.com/<PAGE_ID>",
         "message": "try it out"
       }
     }' \
  -F 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v15.0/act_<AD_ACCOUNT_ID>/adcreatives
```

Verify your image upload by going to your **Image Library** inside **ads manager**.

前往**广告管理工具**中的**图像资源库**，验证图像上传情况。

At this point, the `AdCreative` with your link is not yet visible in Ads Manager. You see this data once you book your ad. You can debug your ad creative with Graph API Explorer and specify any fields you want to read:

此时还无法在广告管理工具中查看包含您的链接的 `AdCreative`。预订广告后，您会看到此数据。您可以使用图谱 API 探索工具调试广告创意，并指定您想读取的任何字段：

```
GET /{my-creative-id} HTTP/1.1
Host: graph.facebook.com/?fields=object_story_spec
```

### Reference Docs - 参考文档

- [Ad Creative](https://developers.facebook.com/docs/marketing-api/reference/ad-creative) - 广告创意

## Step 5: Schedule Delivery - 第 5 步：投放排期

Finally, create your Ad object to link your `AdCreative` and `AdSet`. Set the `status` of your `Ad` to `paused` to avoid placing an order instantly.

最后，创建广告对象，以将 `AdCreative` 和 `AdSet` 关联起来。将 `Ad` 的 `status` 设置为 `paused`，以避免即时下单。

```
Copy Codecurl -X POST \
  -F 'name="My Ad"' \
  -F 'adset_id="<AD_SET_ID>"' \
  -F 'creative={
       "creative_id": "<CREATIVE_ID>"
     }' \
  -F 'status="PAUSED"' \
  -F 'access_token=<ACCESS_TOKEN>' \
  https://graph.facebook.com/v15.0/act_<AD_ACCOUNT_ID>/ads
```

Verify that your ad exists in the ads manager. Click on the campaign you just created, then on the ad set, and on the ad.

在广告管理工具中检查广告是否存在。点击您刚刚创建的广告系列，然后点击广告组和广告。

Once you're comfortable booking ads with the API, set the status to `active`. First, the ad goes through ad review, and has the status `PENDING_REVIEW`. Once the review is done, it goes back to the status of `ACTIVE`.

准备好通过 API 预订广告后，将状态设置为 `active`。广告必须先经过审核，并处于 `PENDING_REVIEW` 状态中。审核结束后，广告会恢复为 `ACTIVE` 状态。

### Copying Ads - 复制广告

Alternatively, you can copy an existing ad, asset or campaign. It helps you quickly duplicate a campaign to change configurations or create test groups to extract performance knowledge. For more details, see:

此外，您还可以复制现有广告、素材或广告系列。这有助于您快速复制广告系列，以便更改配置或创建测试组，进而获得效果数据。详情请参阅：

- [Campaign Copies](https://developers.facebook.com/docs/marketing-api/reference/ad-campaign-group/copies) - 广告系列副本
- [Ad Set Copies](https://developers.facebook.com/docs/marketing-api/reference/ad-campaign/copies) - 广告组副本
- [Ad Copies](https://developers.facebook.com/docs/marketing-api/reference/adgroup/copies) - 广告副本




















