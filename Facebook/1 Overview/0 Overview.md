# Overview - 概览

链接地址：[https://developers.facebook.com/docs/marketing-apis/overview](https://developers.facebook.com/docs/marketing-apis/overview)

The Marketing API is an HTTP-based API that you can use to programmatically query data, create and manage ads, and perform a wide variety of other tasks. This section covers general information on the Marketing APIs, access, versioning, and more.

市场营销 API 是一种基于 HTTP 的 API，您可使用其以编程方式查询数据、创建和管理广告，以及执行各种其他任务。本文介绍有关市场营销 API、访问权限、版本管理等内容的一般信息。

Since the API is [HTTP-based](https://developers.facebook.com/docs/graph-api/overview#http-1-1), it works with any language or software that supports HTTP, including cURL and almost all modern web browsers. The Marketing API is build on top of Facebook's [Graph API](https://developers.facebook.com/docs/graph-api), so almost all requests should be passed to the graph.facebook.com [host URL](https://developers.facebook.com/docs/graph-api/overview#host-url).

此 API [以 HTTP 为基础](https://developers.facebook.com/docs/graph-api/overview#http-1-1)，因此可以与支持 HTTP 的任何语言或软件结合使用，包括 cURL 和几乎所有现代网页浏览器。市场营销 API 以 Facebook 的[图谱 API](https://developers.facebook.com/docs/graph-api) 为构建基础，因此几乎所有请求都应传递至 graph.facebook.com [托管网址](https://developers.facebook.com/docs/graph-api/overview#host-url)。

## Basic Concepts - 基本概念

Concepts you should understand to better use the Marketing API:

为更好地利用市场营销 API，您应了解以下概念：

- [Ad Campaign Structure](https://developers.facebook.com/docs/marketing-api/campaign-structure)

Facebook organizes ads in a structure with three levels: campaign, ad set and ad. In the API, developers have access to a fourth level called creative.

Facebook 的广告架构分为三个层级：广告系列、广告组和广告。在市场营销 API 中，开发者有权访问第四个层级，即广告创意。

- [Authorization](https://developers.facebook.com/docs/marketing-api/overview/authorization) - 授权

To access Marketing API endpoints, your app must clear multiple layers of Graph API authorization.

如要访问市场营销 API 端点，您的应用必须清除图谱 API 授权的多个层级。

- [Authentication](https://developers.facebook.com/docs/marketing-apis/overview/authentication) - 身份验证

Learn how to get and store the access token you need for your API calls.

了解如何获取和存储调用 API 所需的访问口令。

- [Rate Limiting](https://developers.facebook.com/docs/marketing-apis/rate-limiting) - 流量限制

The Marketing API has it is own rate limiting logic and is excluded from all the Graph API rate limitations.

市场营销 API 有专门的流量限制逻辑，并独立于所有图谱 API 流量限制之外。

- [Versioning](https://developers.facebook.com/docs/marketing-api/versions) - 版本管理

Facebook's Platform has a core and extended versioning model. Learn more about upcoming changes and deprecations using our versioning and migration systems. See Version Schedules, Migrations, and Changelog.

Facebook 平台拥有核心和扩展版本控制模型。使用我们的版本管理和迁移系统，详细了解即将发布的变更和停用情况。请参阅版本计划、迁移，以及更新日志。

- [App Review](https://developers.facebook.com/docs/app-review) - 应用审核

To use the Marketing API, your app must undergo App Review, with a few exceptions for Server-Side API and Offline Conversions.

如要使用市场营销 API，您的应用必须通过应用审核，但服务端 API 和线下转化除外。

- [Permissions](https://developers.facebook.com/docs/marketing-api/overview/authorization#access_token) - 权限

There are two main ads permissions: `ads_management` and `ads_read`. Permissions should be granted to the app you are using to make your calls. Permissions can be requested during the app review process. See [list of available permissions for Business Apps](https://developers.facebook.com/docs/development/create-an-app/app-dashboard/app-types#available-permissions).

共有两个主要广告权限：`ads_management` 和 `ads_read`。您应该为发出调用的应用授予权限。您可在应用审核流程中请求相关权限。请参阅[业务应用的可用权限列表](https://developers.facebook.com/docs/development/create-an-app/app-dashboard/app-types#available-permissions)。

- [Error Codes](https://developers.facebook.com/docs/marketing-api/error-reference) - 错误码

You may see error codes while using the API. Use this as a reference to learn more about each error code.

您在使用 API 时可能会看到错误代码。以此作为参考，详细了解每个错误代码。

- [Post-Processing](https://developers.facebook.com/docs/marketing-api/using-the-api/post-processing) - 后处理

Understand the post processing phase after a request is received by Facebook.

了解 Facebook 收到请求后的后处理阶段。