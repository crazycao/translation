# Registering an ad network
# 注册广告网络

原文地址：[https://developer.apple.com/documentation/storekit/registering-an-ad-network](https://developer.apple.com/documentation/storekit/registering-an-ad-network)

Use the install-validation APIs for your ad campaigns after registering your ad network with Apple.

验证广告驱动的应用程序安装的类。

# Overview - 概览

Ad networks provide and cryptographically sign ads that are eligible for ad attribution through SKAdNetwork. Ad networks need to register with Apple before using the SKAdNetwork API.

广告网络通过 SKAdNetwork 提供进行广告归因的广告，并对其进行加密签名。广告网络在使用 SKAdNetwork API 之前需要向苹果注册。

To register your ad network, go to [Ad Network ID Request Form](https://developer.apple.com/contact/request/ad-network-id/), which prompts you to sign in to Apple Developer and opens the request form.

要注册您的广告网络，请转到《[广告网络 ID 请求表单](https://developer.apple.com/contact/request/ad-network-id/)》，该表单会提示您登录 Apple Developer 并打开请求表单。

When registering, you:

- Receive your ad network ID.
- Create an elliptic curve cryptographic key pair and share your public key with Apple for signature verification.
- Provide a URL for receiving SKAdNetwork install-validation postback requests.

在注册时，您需要：

- 获取您的广告网络ID。
- 创建一个椭圆曲线加密密钥对，并与苹果分享您的公钥以进行签名验证。
- 提供一个用于接收 SKAdNetwork 安装验证回传请求的 URL。

## Share your ad network ID with developers - 将您的广告网络 ID 与开发人员分享

The ad network ID is a unique lowercased identifier in the format of “`example123.skadnetwork`”. Share your ad network ID with app developers who display your ads. Developers need to include your ad network ID in their app’s information property list to initiate the app install-validation process.

广告网络 ID 是一个唯一的小写标识符，格式为“`example123.skadnetwork`”。与展示您广告的应用程序开发人员分享您的广告网络 ID。开发人员需要在其应用程序的信息属性列表中包含您的广告网络 ID，以启动应用程序安装验证流程。

> **Important** **重要**
>
> Lowercase the ad network ID string; otherwise, the system doesn’t recognize it as valid.
> 
> 将广告网络 ID 字符串转换为小写；否则，系统将认为其无效。

## Generate your private key - 生成您的私钥

Ad networks use a private cryptographic key to generate a signature for each ad that an app displays. During registration, ad networks create a public-private key pair, and send the public key to Apple. The private key you create uses an Elliptic Curve Digital Signature Algorithm (ECDSA) with a prime256v1 curve.

广告网络使用私密加密密钥为应用程序显示的每个广告生成签名。在注册过程中，广告网络创建一个公私密钥对，并将公钥发送给苹果。您创建的私钥使用采用 prime256v1 曲线的椭圆曲线数字签名算法（ECDSA）。

To create your private key, open Terminal and enter the following command:

要创建您的私钥，请打开终端并输入以下命令：

```
openssl ecparam -name prime256v1 -genkey -noout -out companyname_skadnetwork_private_key.pem
```

In the command, replace `companyname` with the name of your company. For example, the name of the private key file for a company named `Example` is `example_skadnetwork_private_key.pem`.

在命令中，将 `companyname` 替换为您公司的名称。例如，对于名为 `Example` 的公司，私钥文件的名称为`example_skadnetwork_private_key.pem`。

> **Important** **重要**
>
> Secure your private keys as you do other credentials, such as passwords. Don’t share your private keys, store keys in a code repository, or include keys in client-side code. Share only your public key.
> 
> 像对待其他凭据（如密码）一样保护您的私钥。不要分享您的私钥，不要将密钥存储在代码库中，也不要在客户端代码中包含密钥。仅分享您的公钥。

## Generate and share your public key - 生成并分享您的公钥

Next, you create a public key from the private key you created in the previous section. The public key is a PEM-encoded PKCS#8 EC key that uses the prime256v1 curve. In Terminal, enter the following command, again replacing companyname with the name of your company:

接下来，您将根据前一节中创建的私钥生成一个公钥。公钥是一个使用 prime256v1 曲线的 PEM 编码的 PKCS#8 EC 密钥。在终端中，再次输入以下命令，将 `companyname` 替换为您公司的名称：


```
openssl ec -in companyname_skadnetwork_private_key.pem -pubout -out companyname_skadnetwork_public_key.pem
```

This command creates the file `companyname_skadnetwork_public_key.pem`, which contains your public key. Run this command any time to generate a copy of your public key file.

这个命令将创建包含您的公钥的文件 `companyname_skadnetwork_public_key.pem`。随时运行此命令以生成您的公钥文件的副本。

Send your public key file to Apple when you register your ad network.

在注册广告网络时，将您的公钥文件发送给苹果。

# See Also - 其他参考

## Registering Ad Networks and Configuring Apps - 注册广告网络和配置应用程序

### [Registering an Ad Network](https://developer.apple.com/documentation/storekit/skadnetwork/registering_an_ad_network) - 注册广告网络

Register your ad network with Apple to use the install-validation APIs for your ad campaigns.

向 Apple 注册你的广告网络，以便对你的广告活动使用安装验证 API。

### [Configuring a Source App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_a_source_app) - 配置源应用

Configure a source app to participate in ad campaigns.

配置源应用以参与广告活动。

### [Configuring an Advertised App](https://developer.apple.com/documentation/storekit/skadnetwork/configuring_an_advertised_app) - 配置广告应用

Prepare an advertised app to participate in ad campaigns.

准备广告应用以参与广告活动。

### property list key [SKAdNetworkItems](https://developer.apple.com/documentation/bundleresources/information_property_list/skadnetworkitems)

An array of dictionaries containing a list of ad network identifiers.

包含广告网络标识符列表的字典数组。

### property list key [NSAdvertisingAttributionReportEndpoint](https://developer.apple.com/documentation/bundleresources/information_property_list/nsadvertisingattributionreportendpoint)

The URL where Private Click Measurement and SKAdNetwork send attribution information.

私人点击测量 和 SKAdNetwork 发送归因信息的URL。