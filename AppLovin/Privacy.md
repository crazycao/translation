# Privacy

链接地址：[https://dash.applovin.com/documentation/mediation/ios/getting-started/privacy](https://dash.applovin.com/documentation/mediation/ios/getting-started/privacy)

The AppLovin SDK requires you to set a flag that indicates whether a user who is located in the European Union, European Economic Area, United Kingdom, and Switzerland (collectively, the “European Countries”) has provided opt-in consent for the collection and use of personal data for interest-based advertising. This framework facilitates GDPR compliance. It also enables you to comply with certain California privacy requirements and various children data restrictions under GDPR, COPPA, and App Store policies.

AppLovin SDK 要求您设置一个标志，表明位于欧盟、欧洲经济区、英国和瑞士（统称为“欧洲国家”）的用户是否已经选择允许收集和使用个人数据用于基于兴趣的广告。该框架有助于 GDPR 合规性。它还允许您遵守某些加利福尼亚隐私要求以及 GDPR、COPPA和App Store政策下的各种儿童数据限制。

The AppLovin SDK writes your app’s privacy states (“Age Restricted User”, “Has User Consent”, and “Do Not Sell”) to the log. It does this when you initialize the SDK, so it is a good practice to set those privacy states before you do this initialization. This helps to ensure that the privacy states are set correctly. See the section marked “Privacy States” in the logs to verify that the values are as you expect.

AppLovin SDK 将应用程序的隐私状态（“年龄限制用户”、“拥有用户同意”和“不出售”）写入日志。它在初始化 SDK 时会执行此操作，因此在执行此初始化之前设置这些隐私状态是一种很好的做法。这有助于确保隐私状态设置正确。请参阅日志中标记为“Privacy States”的部分，以验证这些值是否符合预期。

You can also refer to the [Mediation Debugger](https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger) to see if you have set these values correctly.

您还可以引用[中介调试器](https://dash.applovin.com/documentation/mediation/ios/testing-networks/mediation-debugger)，查看是否正确设置了这些值。

The following sections of this page describe the GDPR, children data, and CCPA requirements in detail.

本页的以下部分详细描述了 GDPR、儿童数据和 CCPA 的要求。

## General Data Protection Regulation (“GDPR”) - 通用数据保护法规

AppLovin recommends that, after you initialize the AppLovin SDK, you use the AppLovin SDK configuration object to determine if you should prompt a user in the European Countries with a consent dialog. If the user is located in the European Countries, AppLovin concludes that GDPR applies to that user and that you should prompt the user with a consent dialog.

AppLovin 建议，在初始化 AppLovin SDK 后，使用 AppLovin SDK 配置对象确定是否应向欧洲国家/地区的用户提示同意对话框。如果用户位于欧洲国家，AppLovin 得出结论，GDPR 适用于该用户，您应该向用户提示同意对话框。

```
[[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
        if ( configuration.consentDialogState == ALConsentDialogStateApplies )
        {
            // Show user consent dialog
            // 展示用户同意对话框
        }
        else if ( configuration.consentDialogState == ALConsentDialogStateDoesNotApply )
        {
            // No need to show consent dialog, proceed with initialization
            // 无需显示同意对话框，继续初始化
        }
        else
        {
            // Consent dialog state is unknown. Proceed with initialization, but check if the consent
            // dialog should be shown on the next application initialization
            //同意对话框状态未知。继续初始化，但检查是否同意
            //对话框应在下次应用程序初始化时显示
        }
}];
```

If the user consents, set the user consent flag to `true`/`YES` by calling `setHasUserConsent`,and start requesting ads. Once you set the consent value to `true`/`YES`, AppLovin will respect that value for the lifetime of your application or until the user revokes consent.

如果用户同意，请通过调用\ `setHasUserConsent` 将用户同意标志设置为 `true`/`YES`，然后开始请求广告。一旦将同意值设置为`true`/`YES`，AppLovin 将在应用程序的生命周期内尊重用户的选择，直到用户撤销同意为止。

```
[ALPrivacySettings setHasUserConsent: YES];
```

If the user does not consent, set the user consent flag to `false`/`NO` by calling `setHasUserConsent`,and start requesting ads. Once you set the consent value to `false`/`NO`, AppLovin will respect that value for the lifetime of your application or until the user consents.

如果用户同意，请通过调用\ `setHasUserConsent` 将用户同意标志设置为 `false`/`NO`，然后开始请求广告。一旦将同意值设置为`false`/`NO`，AppLovin 将在应用程序的生命周期内尊重用户的选择，直到用户撤销同意为止。

```
[ALPrivacySettings setHasUserConsent: NO];
```

You do not have to set this flag for users who are outside of the European Countries. If you do set the flag for such users, this will not impact how ads are served to them.

您不必为欧洲国家以外的用户设置此标志。如果您确实为这些用户设置了标志，这将不会影响向他们提供广告的方式。

The “Has User Consent” value that you can see in the logs will be either “true” or “false” if you set it correctly. Otherwise, it retains the default value of “No value set”. Note that once you set the consent value, AppLovin will treat it accordingly for the lifetime of your application or until you change the consent value.

如果设置正确，您在日志中看到的“Has User approve”值将为“true”或“false”。否则，它将保留默认值“No value set”。请注意，一旦设置了同意值，AppLovin 将在应用程序的生命周期内对其进行相应的处理，直到您更改同意值。

You can also refer to the Mediation Debugger to see if you have set user consent correctly.

你还可以引用中介调试器查看是否你是否已经正确的设置了用户同意值。

![MAX Mediation Debugger](https://dash.applovin.com/documentation/static/1038/991aabe42e9b5100e216d0b3052ce5f0.png)

AppLovin MAX helps you obtain consent values on behalf of supported mediation partners. MAX shares these consent values via adapters. You must be on GDPR-supported network SDKs. Please consult with your network partner to determine correct SDK versions.

AppLovin MAX 可帮助您代表支持的中介伙伴获取同意值。MAX 通过适配器共享这些同意值。您必须在 GDPR 支持的网络 SDK 上。请咨询您的网络合作伙伴以确定正确的 SDK 版本。

**AppLovin MAX does not help you obtain consent on behalf of Meta, Inc.** For those networks on whose behalf AppLovin MAX does not help you to obtain consent values, you must work directly with the network to understand your obligations for GDPR compliance.

**AppLovin MAX 不会帮助您代表 Meta, Inc 获得同意值。**对于 AppLovin MAX 不帮助您获得同意值的网络，您必须直接与网络合作，以了解您对 GDPR 合规性的义务。

## Children Data - 儿童数据

iOS Apps in the “Kids” category or iOS Apps intended for children may not use the AppLovin SDK per App Store Review Guidelines 1.3 and 5.1.4.

根据 App Store Review Guidelines 1.3和5.1.4，属于“儿童”类别的iOS应用程序或面向儿童的iOS应用程序不得使用AppLovin SDK。

To ensure COPPA, GDPR, and Google Play policy compliance, you should indicate when a user is a child. If you know that the user is in an age-restricted category (i.e., under the age of 16), set the age-restricted user flag to `true`/`YES`.

为了确保符合 COPPA、GDPR 和 Google Play 策略，您应该指出用户何时是儿童。如果您知道该用户属于年龄限制类别（即16岁以下），请将年龄限制用户标志设置为 `true`/`YES`。

```
[ALPrivacySettings setIsAgeRestrictedUser: YES];
```

If you know that the user is not in an age-restricted category (i.e., age 16 or older), set the age-restricted user flag to `false`/`NO`.

如果您知道该用户不属于年龄限制类别（即16岁或以上），请将年龄限制用户标志设置为 `false`/`NO`。

```
[ALPrivacySettings setIsAgeRestrictedUser: NO];
```

## California Consumer Privacy Act (“CCPA”) - 加州消费者隐私法案

You may choose to display a “Do Not Sell My Personal Information” link. If so, you may set a flag that indicates whether a user who is located in California, USA, has opted not to allow their personal data to be sold.

您可以选择显示“请勿出售我的个人信息”链接。如果这么做，您可以设置一个标志，指示位于美国加利福尼亚州的用户是否选择不允许出售其个人数据。

If such a user does not opt out of the sale of their personal information, set the do-not-sell flag to `false`/`NO`.

如果此类用户没有选择退出其个人信息的销售，请将“不销售”标志设置为 `false`/`NO`。

```
[ALPrivacySettings setDoNotSell: NO];
```

If such a user opts out of the sale of their personal information, set the do-not-sell flag to `true`/`YES`.

如果此类用户选择不出售其个人信息，请将“不出售”标志设置为 `true`/`YES`。

```
[ALPrivacySettings setDoNotSell: YES];
```

You do not need to set this flag for users who are outside California (or the USA). If you do set this flag for such users, this will not impact how ads are served to them.

您不需要为加利福尼亚（或美国）以外的用户设置此标志。如果您为这些用户设置了此标志，则不会影响向他们提供广告的方式。

AppLovin MAX helps you to obtain CCPA opt-out values on behalf of supported mediation partners. For those networks on whose behalf MAX does not help you to obtain opt-out values, you must work directly with the network to understand your obligations for CCPA compliance. Please consult with your network partner on the correct SDK versions.

AppLovin MAX帮助您代表支持的中介合作伙伴获取 CCPA 选择退出值。对于那些 MAX 不能帮助您获得退出价值的网络，您必须直接与网络合作，了解您对 CCPA 合规的义务。请向您的网络合作伙伴咨询正确的 SDK 版本。

### Meta Audience Network Data Processing Options for Users in California - 面向加利福尼亚用户的元受众网络数据处理选项

To learn how to implement Meta Audience Network’s “Limited Data Use” flag, read the [Meta for Developers documentation](https://developers.facebook.com/docs/marketing-apis/data-processing-options).

要了解如何实现元受众网络的“有限数据使用”标志，请阅读 [Meta for Developers 文档](https://developers.facebook.com/docs/marketing-apis/data-processing-options)。

> You are now done with basic integration. See the [Preparing Mediated Networks](https://dash.applovin.com/documentation/mediation/ios/mediation-adapters) page to learn your next steps.
> 
> 您现在完成了基本集成。请参阅[准备中介网络]((https://dash.applovin.com/documentation/mediation/ios/mediation-adapters))页面以了解下一步操作。

