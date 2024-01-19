# Testing at all stages of development with Xcode and the sandbox 
#使用 Xcode 和沙盒在开发过程中的各个阶段进行测试

原文地址：[https://developer.apple.com/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_the_sandbox](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_the_sandbox)

官方中文地址：[https://developer.apple.com/cn/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_sandbox/](https://developer.apple.com/cn/documentation/storekit/in-app_purchase/testing_at_all_stages_of_development_with_xcode_and_sandbox/)

Verify your implementation of in-app purchases by testing your code throughout its development.

通过在整个开发过程中测试代码来验证你的 App 内购买项目的实现。

# Overview - 概览

Use the Apple sandbox and Xcode test environments to test your implementation of in-app purchases using the StoreKit framework. Comprehensive testing can help you:

- Ensure a seamless purchase flow to provide a positive customer experience in your app.

- Implement sound logic that covers all scenarios, such as purchases, restores, and subscription offers.

- Validate that purchases behave correctly in production after your app is available in the App Store.

The tools you need to test in-app purchases, non-renewing subscriptions, and auto-renewable subscriptions from early development through beta testing are:

- StoreKit Testing in Xcode

  For early development, continuous integration, and debugging. For more information, see StoreKit Test.

- Sandbox
  
  For testing scenarios using in-app purchase data you set up in App Store Connect. For more information, see Testing in-app purchases with sandbox.

- TestFlight

  For managing beta testing with internal and external testers. TestFlight uses a beta build of your app or App Clip that you upload to App Store Connect. For more information, see Beta Testing Made Simple with TestFlight.

Choose the tools that support the test scenarios you need. Make sure you’re able to perform the setup required for the tools you choose.

During the early stages of development, you may not be ready to configure in-app purchases in App Store Connect. StoreKit Testing in Xcode lets you configure the information locally. You can test StoreKit transactions before you create Sandbox Apple IDs, without a network connection. You can test your app in Simulator or on real devices.

After you set up in-app purchases in App Store Connect, start using the sandbox environment to test the product information your app will use in production. Testing in the sandbox lets you test transactions from end-to-end and from your app to your server. You can also test any server-to-server functionalities your app depends on, such as transaction validation and App Store Server Notifications.

TestFlight lets you get feedback from members of your team or from external testers. TestFlight uses the sandbox environment for in-app purchases. Transactions and purchases that occur in the sandbox don’t incur charges. The following table compares the test environments and features:

| Test environment | Requires App Store Connect setup | Provides receipts and JSON Web Signature (JWS) transactions signed by the App Store | Provides subscription renewal information signed by the App Store |
|:-:|:-:|:-:|:-:|
|StoreKit Testing in Xcode|No|No (signed by Xcode)|No (signed by Xcode)|
Sandbox|Yes|Yes|Yes
TestFlight (uses the sandbox)|Yes|Yes|Yes

None of the test environments charge users when they test buying a product. The App Store doesn’t send emails for purchases or refunds made in the test environments.

使用 Xcode 和沙盒中的 Apple 测试环境，对你利用 StoreKit 框架实施的 App 内购买项目进行测试。全面的测试有助于你实现以下目标：

- 确保流畅的购买流程，在 App 中提供积极的客户体验。
- 实施充分的逻辑来覆盖所有场景，如购买、恢复和使用订阅优惠。
- 验证 App 在 App Store 上架后，购买项目在生产环境中是否具有正确的行为。

在早期开发阶段中通过 Beta 测试来测试 App 内购买项目时，你需要以下工具：

- Xcode 中的 StoreKit 测试功能

  适用于早期开发、持续集成和调试。
- 沙盒技术

  适用于利用你在 App Store Connect 中设置的数据的测试场景。要开始测试，请参阅“创建沙盒测试员账户”。

- TestFlight

  适用于管理通过内部和外部测试员进行的 Beta 测试。有关更多信息，请参阅“TestFlight 让 Beta 测试更简单”。

选取相应的工具，这些工具应支持你需要的测试场景，并要求采用你已准备就绪的设置。

在开发的早期阶段，你可能尚未准备好在 App Store Connect 中配置 App 内购买项目。借助 Xcode 中的 StoreKit 测试功能，你可以在本地配置信息，从而在创建沙盒 Apple ID 之前测试 StoreKit 交易，甚至也可在没有网络连接的情况下进行测试。你可以在 Xcode 模拟器中或真实设备上测试 App。

在 App Store Connect 中设置 App 内购买项目后，就能开始使用沙盒来测试 App 在生产环境中使用的相同产品信息。在沙盒中测试时，你可以测试端到端交易以及从客户端到服务器的交易。也可以测试你的 App 可能依赖的服务器对服务器功能，例如收据验证和 App Store 服务器通知。

借助 TestFlight，你可以从团队成员或外部测试员那里获取反馈，并将沙盒环境用于 App 内购买项目。沙盒内的交易不会产生任何购买项目的费用。下表就环境设置和功能做了比较。

工具|需要 App Store Connect 设置|提供由 App Store 签名的 App 收据|在测试“购买”交易时向用户收费|
|:-:|:-:|:-:|:-:|
Xcode 中的 StoreKit 测试功能|否|否 (由 Xcode 签名)|否
沙盒技术|是|是|否
TestFlight (使用沙盒)|是|是|否


## Control the test environment - 控制测试环境

To set up and run test scenarios, you often need to control the test environment. For example, you may want to reset a test account to rerun the same test multiple times, or mimic actions users take outside your app that affect the test conditions. The following table shows the capabilities each tool has to control the test environment:

Test scenario|Sandbox|StoreKit Testing in Xcode
|:-:|:-:|:-:|
Test different storefronts to affect price tiers and locale|Yes|Limited (no price tiers)
Clear the purchase history|Yes|Yes
Test subscription upgrades, downgrades, cross-grades, and auto-renew cancellations|Yes|Yes
Reset eligibility for introductory offers|Yes|Yes
Introduce forced StoreKit errors for testing|No|Yes
Speed up or slow down the rate of time for testing subscription renewals|Yes|Yes

For more information about speeding up renewal periods for testing, see Test in-app purchases.

要设置和运行测试场景，你通常需要控制测试环境。例如，你可能需要重置测试账户来重新运行几次同一测试，或者模拟用户在你的 App 外进行并影响测试条件的操作。下表显示了各项工具具备的可控制测试环境的功能。

测试场景|沙盒技术|Xcode 中的 StoreKit 测试功能
|:-:|:-:|:-:|
测试影响价格等级和语言区的不同商店|是|有限。(无价格等级)
清除购买历史记录|否|是
测试订阅升级、降级、跨级和取消自动续订|是|是
重置推介促销优惠的资格条件|是|是
引入强制 StoreKit 错误来进行测试|否|是
加快或减慢时间流速以测试订阅续期|否|是

## Test common StoreKit scenarios - 测试常见的 StoreKit 场景
All apps that offer in-app purchases need to support restoring purchases, displaying in-app purchases to the customer, and handling basic transactions. The following table lists common test scenarios and whether they’re testable in the sandbox or Xcode:

Test scenario|Sandbox|StoreKit Testing in Xcode
|:-:|:-:|:-:|
Restore purchases|Yes|Yes
Finish a transaction with finish() or finishTransaction(_:)|Yes|Yes
Buy a consumable or non-consumable in-app purchase|Yes|Yes
Repurchase a non-consumable purchase for repeated testing|Yes|Yes
Purchase an auto-renewable subscription|Yes|Yes
Purchase a non-renewing subscription|Yes|Yes
Refund an in-app purchase|Yes|Yes
Test an interrupted purchase, where the user must complete actions outside the app|Yes|Yes
Test a failed purchase attempt when payment authorization fails|No|Yes
Retrieve configured in-app purchases from App Store Connect|Yes|Yes (optionally); can also retrieve data from a StoreKit configuration file
Manage subscriptions within your app with showManageSubscriptions(in:) and manageSubscriptionsSheet(isPresented:)|Yes|Yes
Initiate a refund request. For more information, see Testing refund requests.|Yes|Yes

所有支持 App 内购买项目的 App 都需要支持恢复购买项目，向客户展示 App 内购买项目，以及处理基本的交易。下表列出了常见的测试场景，以及它们是不是能够在沙盒或 Xcode 中进行测试。

测试场景|沙盒技术|Xcode 中的 StoreKit 测试功能
|:-:|:-:|:-:|
恢复购买项目|是|是
调用 finishTransaction(_:) (英文)|是|是
购买消耗型或非消耗型 App 内购买项目|是|是
再次购买非消耗型购买项目，以进行重复测试|否|是
购买自动续期订阅产品|是|是
购买非续期订阅产品|是|否
为 App 内购买项目退款|否|是
测试中断的购买 (客户必须在 App 外完成操作)|是|是
测试付款授权失败时未能成功完成的购买尝试|否|是
从 App Store Connect 检索配置的 App 内购买项目|是|否 (从 StoreKit 配置文件返回数据)

## Test subscriptions and Ask to Buy - 测试订阅和“购买前询问”
Depending on the in-app purchases your app offers, you may need to test scenarios that involve auto-renewing subscriptions, introductory offers, promotional offers, and Ask to Buy. The following table lists test scenarios and whether they’re testable in the sandbox or Xcode:

Test scenario|Sandbox|StoreKit Testing in Xcode
|:-:|:-:|:-:|
Initiate an Ask to Buy transaction that results in a deferred state|Yes|Yes
Resolve an Ask to Buy transaction by approving or rejecting it|No|Yes
Redeem an introductory offer for an auto-renewable subscription|Yes|Yes
Redeem a promotional offer for an auto-renewable subscription|Yes|Yes
Redeem an offer code for an auto-renewable subscription|No|Yes
Process a subscription renewal|Yes|Yes
Process a revoked or refunded subscription|Yes|Yes
Respond to a customer canceling a subscription and disabling auto-renew|Yes|Yes
Respond to an expired subscription|Yes|Yes
Process a subscription upgrade or downgrade|Yes|Yes
Process a subscription cross-grade with the same or different duration|Yes|Yes
Test a price increase for an auto-renewable subscription|No|Yes
Test billing retry and billing grace period|No|Yes

For more information, see Approve what kids buy with Ask to Buy and Testing introductory offers.

根据 App 提供的 App 内购买项目，你可能需要对涉及自动续期订阅、推介促销优惠和“购买前询问”的场景进行测试。下表列出了这些测试场景，以及它们是不是能够在沙盒或 Xcode 中进行测试。

测试场景|沙盒技术|Xcode 中的 StoreKit 测试功能
|:-:|:-:|:-:|
发起导致延迟状态的“购买前询问”交易|是|是
通过批准或拒绝来解决“购买前询问”交易|否|是
兑换自动续期订阅产品的推介促销优惠|是|是
兑换自动续期订阅产品的促销优惠|是|是
处理订阅续期|是|是
处理已取消或退款的订阅|否|是
回复客户的取消订阅和停用自动续期请求|是|是
响应已到期的订阅|是|是
处理订阅升级或降级|是|是
处理具有相同或不同订阅期的订阅跨级|是|是

有关更多信息，请参阅“通过‘购买前询问’请求和进行购买”。

# See Also - 另请参阅

## Testing in-app purchases

### [Testing in-app purchases with sandbox](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in-app_purchases_with_sandbox)

Test your implementation of in-app purchases using real product information and server-to-server transactions in the sandbox environment.

### [Testing refund requests](https://developer.apple.com/documentation/storekit/transaction/testing_refund_requests)

Test your app’s implementation of refund requests, and your app’s and server’s handling of approved and declined refunds.

## 测试 App 内购买项目

### [在 Xcode 中设置 StoreKit 测试 (英文)](https://developer.apple.com/documentation/xcode/setting_up_storekit_testing_in_xcode/)

设置测试环境以使用你在本地配置的数据测试 App 内购买项目。

### [在 Xcode 中测试 App 内购买项目 (英文)](https://developer.apple.com/documentation/storekit/in-app_purchase/testing_in-app_purchases_in_xcode/)

使用你在本地配置的产品数据测试和调试 App 内购买项目的实现。

### [使用沙盒测试 App 内购买项目](https://developer.apple.com/cn/documentation/storekit/in-app_purchase/testing_in-app_purchases_with_sandbox/)

在沙盒环境中使用真实产品信息和服务器对服务器交易测试你的 App 内购买项目的实现。
