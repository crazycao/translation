# Testing introductory offers
# 测试推介优惠

原文地址：[https://developer.apple.com/documentation/storekit/testing-introductory-offers?language=objc](https://developer.apple.com/documentation/storekit/testing-introductory-offers?language=objc)

Test your introductory pricing in a variety of user scenarios.

在各种用户场景中测试你的推介优惠价格。

## Overview 概述

To test introductory offers, verify that users see the same subscription and introductory offer prices in your app as they do in the App Store. As part of your test, make sure your app presents introductory offers only to users that are eligible for them.

为了测试推介优惠，需验证用户在您的应用中看到的订阅价格和推介优惠价格与在 App Store 中看到的是否一致。作为测试的一部分，要确保您的应用仅向符合资格的用户展示推介优惠。

To test introductory offers:

1. Configure test accounts, as described in [Create a sandbox tester account](https://help.apple.com/app-store-connect/#/dev8b997bee1). Create a variety of accounts that are eligible or ineligible for offers.

2. Initiate in-app purchases from within the app for each test user.

3. Verify that the user experience and pricing information dynamically represent the accurate price of your subscription.

要测试推介优惠：

1. 按照《[创建沙盒测试员账户](https://help.apple.com/app-store-connect/#/dev8b997bee1)》中所述的方法配置测试账户。创建各种符合优惠资格或不符合优惠资格的账户。
2. 为每个测试用户在应用内发起应用内购买操作。
3. 验证用户体验和定价信息是否动态呈现了您订阅服务的准确价格。

Introductory offers are only offered once, but when testing your app, you can reset the status of the test account to allow you to redeem an introductory offer more than once. To reset offer eligibility for the sandbox account:

1. On the test iOS device, open Settings > Apple ID > Media & Purchases (or iTunes & App Store for iOS 13 and earlier). Under the Sandbox Account section, tap your highlighted Sandbox Apple ID then tap Manage to open the sandbox Subscription Management page.

2. Tap the expired subscription you want to reactivate. The subscription products that appear are those you configured in App Store Connect under the same subscription group.

3. If the test account used an introductory offer, then the system diplays a Reset Eligibility button that lets you reset and redeem another introductory offer.

推介优惠仅提供一次，但在测试您的应用时，您可以重置测试账户的状态，以便能够多次兑换推介优惠。要重置沙盒账户的优惠资格：

1. 在测试的 iOS 设备上，打开 “设置”> [您的 Apple ID] >“媒体与购买项目”（对于 iOS 13 及更早版本为 “iTunes 与 App Store”）。在 “沙盒账户” 部分下，轻点高亮显示的沙盒 Apple ID，然后轻点 “管理” 以打开沙盒订阅管理页面。
2. 轻点您想要重新激活的已过期订阅。显示的订阅产品是您在 App Store Connect 中同一订阅组下配置的那些产品。
3. 如果测试账户曾使用过推介优惠，那么系统会显示一个 “重置资格” 按钮，您可以通过该按钮重置并兑换另一个推介优惠。

![A screenshot of the edit subscriptions sheet for an app’s subscriptions. The sheet shows the app’s subscription options and the currently selected subscription. Below the subscription options, the sheet displays a Reset Eligibility button and a Cancel Free Trial button.一张应用订阅的编辑订阅表单的屏幕截图。该表单显示了应用的订阅选项和当前选定的订阅。在订阅选项下方，该表单显示了一个 “重置资格” 按钮和一个 “取消免费试用” 按钮。](https://docs-assets.developer.apple.com/published/718f2e24fd660ccad2dfed18105033b6/media-3866189@2x.png)