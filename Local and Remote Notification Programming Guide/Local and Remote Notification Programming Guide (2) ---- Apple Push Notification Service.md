# Local and Remote Notification Programming Guide

原文地址：
[https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1)

# 2 Apple Push Notification Service - 苹果推送通知服务

## 2.1 APNs Overview - APNs概览

*Apple Push Notification service* (APNs) is the centerpiece of the remote notifications feature. It is a robust, secure, and highly efficient service for app developers to propagate information to iOS (and, indirectly, watchOS), tvOS, and macOS devices.

On initial launch of your app on a user’s device, the system automatically establishes an accredited, encrypted, and persistent IP connection between your app and APNs. This connection allows your app to perform setup to enable it to receive notifications, as explained in [Configuring Remote Notification Support](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW1).

The other half of the connection for sending notifications—the persistent, secure channel between a provider server and APNs—requires configuration in your online [developer account](https://developer.apple.com/account/) and the use of Apple-supplied cryptographic certificates. A *provider* is a server, that you deploy and manage, that you configure to work with APNs. Figure 6-1 shows the path of delivery for a remote notification.

**Figure 6-1**Delivering a remote notification from a provider to an app
![6-1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/remote_notif_simple_2x.png)

With push notification setup complete on your providers and in your app, your providers can then send notification requests to APNs. APNs conveys corresponding notification payloads to each targeted device. On receipt of a notification, the system delivers the payload to the appropriate app on the device, and manages interactions with the user.

If a notification for your app arrives with the device powered on but with the app not running, the system can still display the notification. If the device is powered off when APNs sends a notification, APNs holds on to the notification and tries again later (for details, see Quality of Service, Store-and-Forward, and Coalesced Notifications).

### 2.1.1 Provider Responsibilities - 提供者责任

Your provider servers have the following responsibilities for participating with APNs:

- Receiving, via APNs, globally-unique, app-specific device tokens and other relevant data from instances of your app on user devices. This allows a provider to know about each running instance your app. 
- Determining, according to the design of your notification system, when remote notifications need to be sent to each device. 
- Building and sending notification requests to APNs, each request containing a notification payload and delivery information; APNs then delivers corresponding notifications to the intended devices on your behalf. 

For each remote notification request a provider sends, it must:

1. Construct a JSON dictionary containing the notification’s payload, as described in [Creating the Remote Notification Payload](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW1). 
2. Add the payload, a globally-unique device token, and other delivery information to an HTTP/2 request. For information about device tokens, see APNs-to-Device Connection Trust and Device Tokens. For information about the HTTP/2 request format, and the possible responses and errors from APNs, see [Communicating with APNs](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW1). 
3. Send the HTTP/2 request to APNs, including cryptographic credentials in the form of a token or a certificate, over a persistent, secure channel. Establishing this secure channel is described in Security Architecture. 

### 2.1.2 Using Multiple Providers - 使用多个提供者

Figure 6-2 depicts the sort of virtual network that APNs enables for the devices running your apps. To handle the notification load, you would typically deploy multiple providers, each one with its own persistent and secure connection to APNs. Each provider can then send notification requests targeting any device for which the provider has a valid device token.

**Figure 6-2**Pushing remote notifications from multiple providers to multiple devices

![6-2](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/remote_notif_multiple_2x.png)

### 2.1.3 Quality of Service, Store-and-Forward, and Coalesced Notifications - 服务质量，存储转发，以及合并的通知

Apple Push Notification service includes a Quality of Service (QoS) component that performs a store-and-forward function. If APNs attempts to deliver a notification and the destination device is offline, APNs stores the notification for a limited period of time and delivers it when the device becomes available again. This component stores only the most recent notification per device and per app. If a device is offline, sending a notification request targeting that device causes the previous request to be discarded. If a device remains offline for a long time, all its stored notifications in APNs are discarded.

To allow the coalescing of similar notifications, you can include a *collapse identifier* within a notification request. Normally, when a device is online, each notification request that you send to APNs results in a notification delivered to the device. However, when the apns-collapse-id key is present in your HTTP/2 request header, APNs coalesces requests whose value for that key is the same. For example, a news service that sends the same headline twice could use the same collapse identifier value for both requests. APNs would then coalesce the two requests into a single notification for delivery to the device. For details on the `apns-collapse-id` key, see [Table 8-2](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW13).

### 2.1.4 Security Architecture - 安全架构

APNs enforces end-to-end, cryptographic validation and authentication using two levels of trust: *connection trust* and *device token trust*.

*Connection trust* works between providers and APNs, and between APNs and devices.

- **Provider-to-APNs connection trust** establishes certainty that connection between a provider and APNs is possible only for an authorized provider, owned by a company that has an agreement with Apple for push notification delivery. You must take steps to ensure connection trust exists between your provider servers and APNs, as described in this section. 
- **APNs-to-device connection trust** ensures that only authorized devices can connect to APNs to receive notifications. APNs automatically enforces connection trust with each device to ensure the legitimacy of the device. 

For a provider to communicate with APNs, it must employ a valid authentication key certificate (for token-based connection trust) or SSL certificate (for certificate-based connection trust). You obtain either of these certificates from your online [developer account](https://developer.apple.com/account/), as explained in “[Configure push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073)” in Xcode Help. To choose between the two certificate types, read Provider-to-APNs Connection Trust. Whichever certificate type you choose, provider connection trust is prerequisite to a provider sending push notification requests to APNs.

*Device token trust* works end-to-end for each remote notification. It ensures that notifications are routed only between the correct start (provider) and end (device) points.

A device token is an opaque [NSData](https://developer.apple.com/reference/foundation/nsdata) instance that contains a unique identifier assigned by Apple to a specific app on a specific device. Only APNs can decode and read the contents of a device token. Each app instance receives its unique device token when it registers with APNs, and must then forward the token to its provider, as described in [Configuring Remote Notification Support](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW1). The provider must include the device token in each push notification request that targets the associated device; APNs uses the device token to ensure the notification is delivered only to the unique app-device combination for which it is intended.

APNs can issue a new device token for a variety of reasons:

- User installs your app on a new device 
- User restores device from a backup 
- User reinstalls the operating system 
- Other system-defined events 

As a result, apps must request the device token at launch time, as described in APNs-to-Device Connection Trust and Device Tokens. For code examples, see [Registering to Receive Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW3).

>IMPORTANT
>
>To protect user privacy, do not use device tokens to identify user devices.

#### 2.1.4.1 Provider-to-APNs Connection Trust - 提供者到APNs的连接信任

There are two schemes available for negotiating connection trust between your provider servers and Apple Push Notification service:

- **Token-based provider connection trust**: A provider using the HTTP/2-based API can use *JSON web tokens* (JWT) to provide validation credentials for connection with APNs. In this scheme, you provision a public key to be retained by Apple, and a private key which you retain and protect. Your providers then use your private key to generate and sign JWT *provider authentication tokens*. Each of your push notification requests must include a provider authentication token. 
  
  You can use a single, token-based connection between a provider and APNs can to send push notification requests to *all the apps* whose bundle IDs are listed in your online [developer account](https://developer.apple.com/account/). 
  
  Every push notification request results in an HTTP/2 response from APNs, returning details on success or failure to your provider. 
- **Certificate-based provider connection trust**: A provider can, alternatively, employ a unique *provider certificate and private cryptographic key*. The provider certificate, provisioned by Apple when you establish your push service in your online [developer account](https://developer.apple.com/account/), identifies one *topic*, which is the bundle ID for one of your apps. 
  
  You can use a certificate-based connection between a provider and APNs to send push notification requests to *exactly one app*, which you specify when configuring the certificate in your online [developer account](https://developer.apple.com/account/). 

>IMPORTANT
>
>To establish HTTP/2-based TLS sessions with APNs, you must ensure that a GeoTrust Global CA root certificate is installed on each of your providers. If a provider is running macOS, this root certificate is in the keychain by default. On other systems, this certificate might require explicit installation. You can download this certificate from the [GeoTrust Root Certificates website](https://www.geotrust.com/resources/root-certificates/). Here is a [direct link to the certificate](https://www.geotrust.com/resources/root_certificates/certificates/GeoTrust_Global_CA.pem).
>
>If you are instead using the legacy binary interface to APNs, you must ensure that each of your providers has an Entrust Certification Authority (2048) root certificate, available from the [Entrust SSL Certificates website](https://www.entrust.com/ssl-certificates/).

#### 2.1.4.2 Token-Based Provider-to-APNs Trust - 基于令牌的提供者到APNs信任

Token-based provider trust employs a certificate of type “Apple Push Notification Authentication Key (Sandbox & Production).” You configure and obtain this certificate using your online [developer account](https://developer.apple.com/account/), as explained in “[Generate a universal provider token signing key](http://help.apple.com/xcode/mac/current/#/dev11b059073?sub=dev1eb5dfe65)” in Xcode Help. This certificate has the following characteristics:

- The one certificate is valid for sending push notification requests for every app associated with your account. 
  
  The certificate is also valid for connections to Apple Watch complications for your apps, and for voice-over-Internet Protocol (VoIP) status notifications for your apps. APNs delivers these notifications even when those items are running in the background. See [APNs Provider Certificates](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW5) for details, and see [Voice Over IP (VoIP) Best Practices](https://developer.apple.com/library/content/documentation/Performance/Conceptual/EnergyGuide-iOS/OptimizeVoIP.html#//apple_ref/doc/uid/TP40015243-CH30) in [*Energy Efficiency Guide for iOS Apps*](https://developer.apple.com/library/content/documentation/Performance/Conceptual/EnergyGuide-iOS/index.html#//apple_ref/doc/uid/TP40015243). 
- When you send a push notification request over a JWT token-based APNs connection, you must include your provider authentication token. 
- The APNs authentication key certificate never expires, but you can revoke it permanently using your online [developer account](https://developer.apple.com/account/); once revoked, the certificate can never be used again 

Figure 6-3 illustrates using the HTTP/2-based APNs provider API to establish trust, and using JWT provider authentication tokens for sending notifications.

**Figure 6-3**Establishing and using token-based provider connection trust

![6-3](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/service_provider_ct_2x.png)

As shown in Figure 6-3, token-based provider trust works as follows:

1. Your provider asks for a secure connection with APNs using transport layer security (TLS), represented as the arrow labeled “TLS initiation” in the figure. 
2. APNs then gives your provider an APNs certificate, represented by the next arrow in the figure (labeled “APNs certificate”), which your provider then validates. 
   At this point, connection trust is established and your provider server is enabled to send token-based remote push notification requests to APNs. 
3. Each notification request that your provider sends must be accompanied by a JWT authentication token, represented in the figure as the arrow labeled “Notification push.” 
4. APNs replies to each push, represented in the figure as the arrow labeled “HTTP/2 response.” 
   For specifics on the responses your provider can receive for this step, see [HTTP/2 Response from APNs](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW2). 

#### 2.1.4.3 Certificate-Based Provider-to-APNs Trust - 基于证书的提供者到APNs信任

A certificate-based provider connection is valid for delivery to one specific app, identified by the topic (the app bundle ID) specified in the provider certificate (which you must have previously created, as explained in “[Generate a universal APNs client SSL certificate](http://help.apple.com/xcode/mac/current/#/dev11b059073?sub=dev2178d70ae)” in Xcode Help). Depending on how you configure and provision the certificate, the trusted connection can also be valid for delivery of remote notifications to other items associated with your app, including Apple Watch complications for your apps, and for voice-over-Internet Protocol (VoIP) status notifications for your apps. APNs delivers these notifications even when those items are running in the background. See [Communicating with APNs](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW1) for details, and see [Voice Over IP (VoIP) Best Practices](https://developer.apple.com/library/content/documentation/Performance/Conceptual/EnergyGuide-iOS/OptimizeVoIP.html#//apple_ref/doc/uid/TP40015243-CH30) in [*Energy Efficiency Guide for iOS Apps*](https://developer.apple.com/library/content/documentation/Performance/Conceptual/EnergyGuide-iOS/index.html#//apple_ref/doc/uid/TP40015243).

With certificate-based trust, APNs maintains a certificate revocation list; if a provider’s certificate is on the revocation list, APNs can revoke provider trust (that is, APNs can refuse the TLS initiation connection).

Figure 6-4 illustrates the use of an Apple-issued SSL certificate to establish trust between a provider and APNs. Unlike Figure 6-3, this figure does not show a notification push itself, but stops at the establishment of a Transport Layer Security (TLS) connection. In the certificate-based trust scheme, push notification requests are not authenticated but they are validated using the accompanying device token.

**Figure 6-4**Establishing certificate-based provider connection trust
![6-4](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/service_provider_ct_certificate_2x.png)

As shown in Figure 6-4, certificate-based provider-to-APNs trust works as follows:

1. Your provider asks for a secure connection with APNs using transport layer security (TLS), represented as the arrow labeled “TLS initiation” in the figure. 
2. APNs then gives your provider an APNs certificate, represented by the next arrow in the figure (labeled “APNs certificate”), which your provider then validates. 
3. Your provider must then send its Apple-provisioned provider certificate (which you have previously obtained from your online [developer account](https://developer.apple.com/account/), as explained in “[Generate a universal APNs client SSL certificate](http://help.apple.com/xcode/mac/current/#/dev11b059073?sub=dev2178d70ae)” in Xcode Help) back to APNs, represented as the arrow labeled “Provider certificate.” 
4. APNs then validates your provider certificate, thereby confirming that the connection request originated from a legitimate provider, and establishes your TLS connection. 
   At this point, connection trust is established and your provider server is enabled to send certificate-based remote push notification requests to APNs. 

#### 2.1.4.4 APNs-to-Device Connection Trust and Device Tokens - APNs到设备的连接信任及设备令牌

Trust between APNs and each device is established automatically, without participation by your app, as described in this section.

Each device has a cryptographic certificate and a private cryptographic key, provided by the operating system at initial device activation and stored in the device’s keychain. During activation, APNs authenticates and validates the connection to the device, based on the certificate and key, as shown in Figure 6-5.

**Figure 6-5**Establishing connection trust between a device and APNs

![6-5](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/service_device_ct_2x.png)

As shown in Figure 6-5, APNs-to-device trust works as follows:

1. Trust negotiation begins when the device initiates a TLS connection with APNs, as shown in the top arrow in the figure. 
2. APNs returns an APNs certificate to the device. 
3. The operating system validates this certificate and then, as shown in the “Device certificate” arrow, sends the device certificate to APNs. 
4. Finally, as indicated by the bottom arrow in the figure, APNs validates the device certificate, establishing trust. 

With a TLS connection established between APNs and the device, apps on the device can register with APNs to receive their app-specific device tokens for remote notifications. For details and code examples, see [Registering to Receive Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW3) in [Configuring Remote Notification Support](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW1).

After receiving the device token, an app must connect to the app’s associated provider and forward the token to it. This step is necessary because a provider must include the device token later when it sends a notification request, to APNs, targeting the device. The code you write for forwarding the token is also shown in [Registering to Receive Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW3).

Whether a user is activating a device for the first time, or whether APNs has issued a new device token, the process is similar and is shown in Figure 6-6.

**Figure 6-6**Managing the device token
![6-6](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/token_generation_2x.png)

Obtaining and handling an app-specific device token works as follows:

1. Your app registers with APNs for remote notifications, as shown in the top arrow. If the app is already registered and the app-specific device token has not changed, the system quickly returns the existing token to the app and this process skips to step 4. 
2. When a new device token is needed, APNs generates one using information contained in the device’s certificate. It encrypts the token using a token key and returns it to the device, as shown in the middle, right-pointing arrow. 
3. The system delivers the device token back to your app by calling your [application:didRegisterForRemoteNotificationsWithDeviceToken:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1622958-application) delegate method. 
4. Upon receiving the token, your app (within the delegate method) must forward it to your provider in either binary or hexadecimal format. Your provider cannot send notifications to the device without this token. For details, see [Registering to Receive Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW3) in [Configuring Remote Notification Support](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW1). 

>IMPORTANT
>
>APNs device tokens are of variable length. Do not hard-code their size.

When your provider sends a push notification request to APNs, it includes a device token that identifies a unique app-device combination. This step is shown in the “Token, Payload” arrow between the provider and APNs in Figure 6-7. APNs decrypts the token to ensure the validity of the request and to determine the target device. If APNs determines that the sender and recipient are legitimate, it then sends the notification to the identified device.

**Figure 6-7**Remote notification path from provider to device
![6-7](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/token_trust_2x.png)

After the device receives the notification (and after the final step shown in Figure 6-7), the system forwards the remote notification to your app.

### 2.1.5 Provisioning Procedures - 配置程序

APNs is available to apps distributed through the iOS App Store, tvOS App Store, and Mac App Store, as well as to enterprise apps. Your app must be provisioned and code signed to use APNs. If you are developing as part of a team, most of these configuration steps can be performed only by a team agent or administrator.

APNs对通过iOS App Store、tvOS App Store和Mac App Store发布的程序，以及企业app是可用的。你的程序必须配置并进行代码签名才能使用APNs。如果你作为团队的一员进行开发，这些配置步骤的大部分可以只由团队代理人或管理者执行。

For information on how to configure push notification support in Xcode and in your online [developer account](https://developer.apple.com/account/), read “[Configure push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073)” in Xcode Help.

关于如何在Xcode和你的在线[开发者账户](https://developer.apple.com/account/)中配置推送通知支持的信息，请阅读Xcode帮助中的“[Configure push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073)”。

## 2.2 Creating the Remote Notification Payload - 创建远程通知负载

Each notification your provider server sends to the Apple Push Notification service (APNs) includes a payload. The payload contains any custom data that you want to send to your app and includes information about how the system should notify the user. You construct this payload as a JSON dictionary and send it as the body content of your HTTP/2 message. The maximum size of the payload depends on the notification you are sending:

- For regular remote notifications, the maximum size is 4KB (4096 bytes) 
- For Voice over Internet Protocol (VoIP) notifications, the maximum size is 5KB (5120 bytes) 

>NOTE
>
>If you are using the legacy APNs binary interface to send notifications instead of an HTTP/2 request, the maximum payload size is 2KB (2048 bytes)

APNs refuses notifications whose payload exceeds the maximum allowed size.

Because the delivery of remote notifications is not guaranteed, never include sensitive data or data that can be retrieved by other means in your payload. Instead, use notifications to alert the user to new information or as a signal that your app has data waiting for it. For example, an email app could use remote notifications to badge the app’s icon or to alert the user that new email is available in a specific account, as opposed to sending the contents of email messages directly. Upon receiving the notification, the app should open a direct connection to your email server to retrieve the email messages.

### 2.2.1 Creating the JSON Dictionary - 创建JSON字典

The following examples illustrate the structure of the JSON dictionary and the keys you can include for your notifications. The most important part of the payload is the aps dictionary, which contains Apple-defined keys and is used to determine how the system receiving the notification should alert the user, if at all. The examples also includes keys whose names include the string “acme”, which represent custom data included by a fictional app. Although the examples include whitespace and line breaks for readability, in practice, you should omit whitespace and line breaks to reduce the size of the payload.

**Example 1.** The following payload contains an aps dictionary with a simple alert message. The acme2 key contains an array of app-specific data.

	{
	    "aps" : { "alert" : "Message received from Bob" },
	    "acme2" : [ "bang",  "whiz" ]
	}

**Example 2.** The following payload asks the system to display an alert with a Close button and a single action button. The title and body keys provide the contents of the alert. The “PLAY” string is used to retrieve a localized string from the appropriate Localizable.strings file of the app. The resulting string is used by the alert as the title of an action button. This payload also asks the system to badge the app’s icon with the number 5.

	{
	    "aps" : {
	        "alert" : {
	            "title" : "Game Request",
	            "body" : "Bob wants to play poker",
	            "action-loc-key" : "PLAY"
	        },
	        "badge" : 5
	    },
	    "acme1" : "bar",
	    "acme2" : [ "bang",  "whiz" ]
	}

**Example 3.** The following payload specifies that the device should display an alert message, plays a sound, and badges the app’s icon.

	{
	    "aps" : {
	        "alert" : "You got your emails.",
	        "badge" : 9,
	        "sound" : "bingbong.aiff"
	    },
	    "acme1" : "bar",
	    "acme2" : 42
	}

**Example 4.** The following payload uses the loc-key to specify a localized string in the app’s Localizable.strings file. That string is displayed as the message of the alert. The loc-args contains values to substitute into the string before displaying it. The payload also specifies a custom sound to play with the alert.

	{
	    "aps" : {
	        "alert" : {
	            "loc-key" : "GAME_PLAY_REQUEST_FORMAT",
	            "loc-args" : [ "Jenna", "Frank"]
	        },
	        "sound" : "chime.aiff"
	    },
	    "acme" : "foo"
	}

For a complete list of Apple-specific keys that you can include in notification payloads, see [Payload Key Reference](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html#//apple_ref/doc/uid/TP40008194-CH17-SW1).

### 2.2.2 Configuring a Silent Notification - 配置静默通知

Silent notifications improve the user experience by helping you keep your app up-to-date, even when it is not running. When apps do not run for extended periods of time, their data can become outdated. When the user finally launches the app again, the outdated data must be replaced, which can cause a delay in using the app. Silent notifications give you a way to wake up your app periodically so that it can refresh its data in the background.

>IMPORTANT
>
>Silent notifications are not meant as a way to keep your app awake in the background, nor are they meant for high priority updates. APNs treats silent notifications as low priority and may throttle their delivery altogether if the total number becomes excessive. The actual limits are dynamic and can change based on conditions, but try not to send more than a few notifications per hour.

The sending of a silent notification requires a special configuration of the notification’s payload. If your payload is not configured properly, the notification might be displayed to the user instead of being delivered to your app in the background. In your payload, make sure the following conditions are true:

- The payload’s aps dictionary must include the content-available key with a value of 1. 
- The payload’s aps dictionary must *not* contain the alert, sound, or badge keys. 

When a silent notification is delivered to the user’s device, iOS wakes up your app in the background and gives it up to 30 seconds to run. In iOS, the system delivers silent notifications by calling the [application:didReceiveRemoteNotification:fetchCompletionHandler:](https://developer.apple.com/reference/uikit/uiapplicationdelegate/1623013-application) method of your app delegate. Use that method to initiate any download operations needed to fetch new data. Processing remote notifications in the background requires that you add the appropriate background modes to your app.

**To configure your app to process silent notifications in the background**

1. In the Project Navigator, select your project. 
2. In the editor, select your iOS app target. 
3. Select the Capabilities tab. 
4. Enable the Background Modes capability. 
5. Enable the Remote notifications background mode.  

![7-1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/remote_notification_mode_2x.png)

Listing 7-1 shows an example of a JSON payload for a silent notification.

**Listing 7-1**Configuring a silent notification

	{
	    "aps" : {
	        "content-available" : 1
	    },
	    "acme1" : "bar",
	    "acme2" : 42
	}

For more information about how to handle remote notifications, see [Handling Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/HandlingRemoteNotifications.html#//apple_ref/doc/uid/TP40008194-CH6-SW2).

### 2.2.3 Assigning Custom Actions to a Remote Notification - 给远程通知分配自定义操作

To display custom actions with a remote notification, include the category key in the aps dictionary of the notification’s payload. At launch time, apps can register categories that include custom actions. When a notification includes the category key, the system displays the actions for that category as buttons in the banner or alert interface. When the user selects a button, the system notifies your app so that it can perform any associated tasks. Notifications configured with a category must also be configured to display an alert.

Listing 7-2 shows a sample payload for a notification that displays an alert and includes a category with custom actions. The “NEW_MESSAGE_CATEGORY” string corresponds to the name of a category already registered by the app. In this case, the category includes custom actions for responding to the message.

**Listing 7-2**Including a category in the payload

	{
	   "aps" : {
	      "category" : "NEW_MESSAGE_CATEGORY"
	      "alert" : {
	         "body" : "Acme message received from Johnny Appleseed",
	      },
	      "badge" : 3,
	      "sound" : “chime.aiff"
	   },
	   "acme-account" : "jane.appleseed@apple.com",
	   "acme-message" : "message123456"
	}

For information about how to register the categories and custom actions that your app supports, see [Configuring Categories and Actionable Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SupportingNotificationsinYourApp.html#//apple_ref/doc/uid/TP40008194-CH4-SW26). For information about how to handle the selection of custom actions in your app, see [Responding to the Selection of a Custom Action](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html#//apple_ref/doc/uid/TP40008194-CH5-SW2).

### 2.2.4 Localizing the Content of Your Remote Notifications - 本地化远程通知的内容

There are two ways to localize the content of remote notifications:

- Provide localized content from your provider server. 
- Store localized message strings in your app bundle. 

Both localization approaches have advantages and disadvantages and you should choose the technique that best fits your needs. Providing localized content from your server lets you specify any text you want, but it also requires discovering and tracking the user’s current language preference and potentially translating content dynamically. Storing localized strings in your app bundle is simpler, but requires that you define all of your notification messages in advance and include them in your app’s Localizable.strings resource files.

#### 2.2.4.1 Supplying the User’s Language Preference to Your Server - 在你的服务器中提供用户的语言偏好

If your provider server handles the localization of notification messages, your app should communicate the user’s language preference to that server. Users set language preferences locally on the device, and apps can retrieve these preferences using the [preferredLanguages](https://developer.apple.com/reference/foundation/nslocale/1415614-preferredlanguages) property of NSLocale.

Listing 7-3 illustrates a technique for obtaining the currently selected language and communicating it to your provider server. The example fetches the user’s first preferred language and encodes it as a UTF8 string. It then sends that string to its provider using a custom method. You might also consider sending the first few languages from the [preferredLanguages](https://developer.apple.com/reference/foundation/nslocale/1415614-preferredlanguages) property in case the user’s first language is not one that you support. If you do not support any of the user’s preferred languages, consider using a widely spoken language such as English or Spanish as a fallback.

**Listing 7-3**Getting the current supported language and sending it to the provider

	NSString *preferredLang = [[NSLocale preferredLanguages] objectAtIndex:0];
	const char *langStr = [preferredLang UTF8String];
	[self sendProviderCurrentLanguage:langStr]; // custom method
	}

Because users can change their preferred language settings, apps should observe the [NSCurrentLocaleDidChangeNotification](https://developer.apple.com/reference/foundation/nslocale/1418141-currentlocaledidchangenotificati) notification. Use that notification to send any language-related changes to your server.

#### 2.2.4.2 Storing Localized Content in Your App Bundle - 在你的程序包中存储本地化的内容

If you use a consistent set of messages for your notifications, you can store localized versions of the message text in your app bundle and use the loc-key and loc-args keys in your payload to specify which message to display. The loc-key and loc-args keys define the message content of the notification. When present, the local system searches the app’s Localizable.strings files for a key string matching the value in loc-key. It then uses the corresponding value from the strings file as the basis for the message text, replacing any placeholder values with the strings specified by the loc-args key. (You can also specify a title string for the notification using the title-loc-key and title-loc-args keys.)

To illustrate how to use these keys, consider an example of a game app whose provider server sends notifications when a user is invited to play the game. Because the invitation text never changes, that text is included in the app’s Localizable.strings files using the following entry:

	"GAME_PLAY_REQUEST_FORMAT" = "%@ and %@ have invited you to play Monopoly";

When the provider server wants to send a notification about a game request, it builds the payload using the loc-key and loc-args keys. It sets the value of loc-key to the string GAME_PLAY_REQUEST_FORMAT and sets the value of loc-args to the names of the participants initiating the game play request. For example, if two users named Jenna and Frank initiated the request, the provider server would send a payload with the following contents:

	{
	    "aps" : {
	        "alert" : {
	            "loc-key" : "GAME_PLAY_REQUEST_FORMAT",
	            "loc-args" : [ "Jenna", "Frank"]
	        }
	    }
	}

Upon receiving the remote notification with the preceding payload, the device fetches the GAME_PLAY_REQUEST_FORMAT string from the appropriate Localizable.strings file of the app and incorporates the provided player names. For a user whose preferred language is English, the resulting message string becomes “Jenna and Frank have invited you to play Monopoly.” For other languages, the string would be an appropriately translated version of the message that incorporates the provided names.

When crafting message strings for your Localizable.strings file, you can use the same format specifiers that you use for any localized content. For example, you can use positional specifiers of the form `%`*n*`$@` to allow for the rearranging of parameters and you can use the %% specifier to create a percent sign character.

For additional information about the keys you can include in the notification’s payload, see [Payload Key Reference](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html#//apple_ref/doc/uid/TP40008194-CH17-SW1). For more information about internationalization and providing localized content for your app, see [*Internationalization and Localization Guide*](https://developer.apple.com/library/content/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i).

## 2.3 Communicating with APNs - 与APNs交互

The APNs provider API lets you send remote notification requests to APNs. APNs then conveys notifications to your app on iOS, tvOS, and macOS devices, and to Apple Watch via iOS.

The provider API is based on the HTTP/2 network protocol. Each interaction starts with a POST request, from your provider, that contains a JSON payload and a device token. APNs forwards the notification payload to your app on the specific user device identified by the request’s included device token.

A *provider* is a server, that you deploy and manage, that you configure to work with APNs.

### 2.3.1 Provider Authentication Tokens - 提供者的授权令牌

To securely connect to APNs, you can use provider authentication tokens or provider certificates. This section describes connections using tokens.

The provider API supports the JSON Web Token (JWT) specification, letting you pass statements and metadata, called *claims*, to APNs, along with each push notification. For details, refer to the specification at [https://tools.ietf.org/html/rfc7519](https://tools.ietf.org/html/rfc7519). For additional information about JWT, along with a list of available libraries for generating signed JWTs, see [https://jwt.io](https://jwt.io/)

A provider authentication token is a JSON object that you construct, whose header must include:

- The encryption algorithm (alg) you use to encrypt the token 
- A 10-character *key identifier* (kid) key, obtained from [your developer account](https://developer.apple.com/account/) 

The claims payload of the token must include:

- The *issuer* (iss) registered claim key, whose value is your 10-character Team ID, obtained from [your developer account](https://developer.apple.com/account/) 
- The *issued at* (iat) registered claim key, whose value indicates the time at which the token was generated, in terms of the number of seconds since Epoch, in UTC 

After you create the token, you must sign it with a private key. You must then encrypt the token using the Elliptic Curve Digital Signature Algorithm (ECDSA) with the P-256 curve and the SHA-256 hash algorithm. Specify the value ES256 in the algorithm header key (alg). For information on how to configure your token, see “[Configure push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073)” in Xcode Help.

A decoded JWT provider authentication token for APNs has the following format:

	{
	    "alg": "ES256",
	    "kid": "ABC123DEFG"
	}
	{
	    "iss": "DEF123GHIJ",
	    "iat": 1437179036
	}

>NOTE
>
>APNs supports only provider authentication tokens that are signed with the ES256 algorithm. Unsecured JWTs, or JWTs signed with other algorithms, are rejected, and your provider receives the InvalidProviderToken (403) response.

To ensure security, APNs requires new tokens to be generated periodically. A new token has an updated *issued at* claim key, whose value indicates the time the token was generated. If the timestamp for token issue is not within the last hour, APNs rejects subsequent push messages, returning an ExpiredProviderToken (403) error.

If you suspect your provider token signing key is compromised, you can revoke it from [your developer account](https://developer.apple.com/account/). You can issue a new key pair and can then generate new tokens with the new private key. For maximum security, close all your connections to APNs that had been using tokens signed with the now-revoked key, and reconnect before using tokens signed with the new key.

### 2.3.2 APNs Provider Certificates - APNs提供者证书

Your APNs provider certificate, which you obtain as explained in “[Configure push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073)” in Xcode Help, enables connection to both the APNs Production and Development environments.

You can use your APNs certificate to send notifications to your primary app, as identified by its bundle ID, as well as to any Apple Watch complications or backgrounded VoIP services associated with that app. Use the ( 1.2.840.113635.100.6.3.6 ) extension in the certificate to identify the topics for your push notifications. For example, if you provide an app with the bundle ID com.yourcompany.yourexampleapp, you can specify the following topics in the certificate:

	Extension ( 1.2.840.113635.100.6.3.6 )
	Critical NO
	Data com.yourcompany.yourexampleapp
	Data app
	Data com.yourcompany.yourexampleapp.voip
	Data voip
	Data com.yourcompany.yourexampleapp.complication
	Data complication

### 2.3.3 APNs Connections - APNs连接

The first step in sending a remote notification is to establish a connection with the appropriate APNs server:

- **Development server:** api.development.push.apple.com:443 
- **Production server:** api.push.apple.com:443 

>NOTE
>
>You can alternatively use port 2197 when communicating with APNs. You might do this, for example, to allow APNs traffic through your firewall but to block other HTTPS traffic.

Your provider must support TLS 1.2 or higher when connecting to APNs. You can use the provider client certificate which you obtain from [your developer account](https://developer.apple.com/account/), as described in [Creating a Universal Push Notification Client SSL Certificate](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppDistributionGuide/AddingCapabilities/AddingCapabilities.html#//apple_ref/doc/uid/TP40012582-CH26-SW11).

To connect without an APNs provider certificate, you must instead create a provider authentication token, signed with the key provisioned through [your developer account](https://developer.apple.com/account/) (see “[Configure push notifications](http://help.apple.com/xcode/mac/current/#/dev11b059073)” in Xcode Help). After you have this token, you can start to send push messages. You must then periodically update the token; each APNs provider authentication token has validity interval of one hour.

APNs allows multiple concurrent streams for each connection. The exact number of streams differs based on your use of a provider certificate or an authentication token, and also differs based on server load. Do not assume a specific number of streams.

When establishing a connection to APNs using a token rather than a certificate, only one stream is allowed on the connection until you send a push message with valid provider authentication token. APNs ignores HTTP/2 PRIORITY frames, so do not send them on your streams.

#### 2.3.3.1 Best Practices for Managing Connections - 管理连接的最佳实践

Keep your connections with APNs open across multiple notifications; do not repeatedly open and close connections. APNs treats rapid connection and disconnection as a denial-of-service attack. You should leave a connection open unless you know it will be idle for an extended period of time—for example, if you only send notifications to your users once a day, it is acceptable practice to use a new connection each day.

Do not generate a new provider authentication token for each push request that you send. After you obtain a token, continue to use it for all your push requests during the token’s period of validity, which is one full hour.

You can establish multiple connections to APNs servers to improve performance. When you send a large number of remote notifications, distribute them across connections to several server endpoints. This improves performance, compared to using a single connection, by letting you send remote notifications faster and by letting APNs deliver them faster.

If your provider certificate is revoked, or if the key you are using to sign provider tokens is revoked, close all existing connections to APNs and then open new connections.

You can check the health of your connection using an HTTP/2 PING frame.

#### 2.3.3.2 Terminating an APNs Connection - 终止APNs连接

If APNs decides to terminate an established HTTP/2 connection, it sends a GOAWAY frame. The GOAWAY frame includes JSON data in its payload with a reason key, whose value indicates the reason for the connection termination. For a list of possible values for the reason key, see Table 8-6.

Normal request failures do not result in termination of a connection.

### 2.3.4 APNs Notification API - APNs通知API

The APNs Provider API consists of a request and a response that you configure and send using an HTTP/2 POST command. You use the request to send a push notification to the APNs server and use the response to determine the results of that request.

#### 2.3.4.1 HTTP/2 Request to APNs - 到APNs的HTTP/2请求

Use a request to send a notification to a specific user device.

**Table 8-1**HTTP/2 request fields

| Name    | Value        |
| ------- | ------------ |
| :method | POST         |
| :path   | /3/device/*\<device-token>* |

For the *\<device-token>* parameter, specify the hexadecimal bytes of the device token for the target device.

APNs requires the use of HPACK (header compression for HTTP/2), which prevents repeated header keys and values. APNs maintains a small dynamic table for HPACK. To help avoid filling up the APNs HPACK table and necessitating the discarding of table data, encode headers in the following way—especially when sending a large number of streams:

- The :path value should be encoded as a literal header field without indexing 

- The authorization request header, if present, should be encoded as a literal header field without indexing 

- The appropriate encoding to employ for the apns-id, apns-expiration, and apns-collapse-id request headers differs depending on whether it is part of the initial or a subsequent POST operation, as follows: 

  - The first time you send these headers, encode them with *incremental indexing* to allow the header names to be added to the dynamic table 
  - Subsequent times you send these headers, encode them as *literal header fields without indexing* 

Encode all other headers as literal header fields with incremental indexing. For specifics on header encoding, see [tools.ietf.org/html/rfc7541#section-6.2.1](http://tools.ietf.org/html/rfc7541#section-6.2.1) and [tools.ietf.org/html/rfc7541#section-6.2.2](http://tools.ietf.org/html/rfc7541#section-6.2.2).

APNs ignores request headers other than the ones listed in Table 8-2.

**Table 8-2**APNs request headers

| Header           | Description                              |
| ---------------- | ---------------------------------------- |
| authorization    | The provider token that authorizes APNs to send push notifications for the specified topics. The token is in Base64URL-encoded JWT format, specified as bearer \<provider token>.When the provider certificate is used to establish a connection, this request header is ignored. |
| apns-id          | A canonical UUID that identifies the notification. If there is an error sending the notification, APNs uses this value to identify the notification to your server.The canonical form is 32 lowercase hexadecimal digits, displayed in five groups separated by hyphens in the form 8-4-4-4-12. An example UUID is as follows:123e4567-e89b-12d3-a456-42665544000If you omit this header, a new UUID is created by APNs and returned in the response. |
| apns-expiration  | A UNIX epoch date expressed in seconds (UTC). This header identifies the date when the notification is no longer valid and can be discarded.If this value is nonzero, APNs stores the notification and tries to deliver it at least once, repeating the attempt as needed if it is unable to deliver the notification the first time. If the value is 0, APNs treats the notification as if it expires immediately and does not store the notification or attempt to redeliver it. |
| apns-priority    | The priority of the notification. Specify one of the following values:10–Send the push message immediately. Notifications with this priority must trigger an alert, sound, or badge on the target device. It is an error to use this priority for a push notification that contains only the content-available key. 5—Send the push message at a time that takes into account power considerations for the device. Notifications with this priority might be grouped and delivered in bursts. They are throttled, and in some cases are not delivered. If you omit this header, the APNs server sets the priority to 10. |
| apns-topic       | The topic of the remote notification, which is typically the bundle ID for your app. The certificate you create in your developer account must include the capability for this topic.If your certificate includes multiple topics, you must specify a value for this header.If you omit this request header and your APNs certificate does not specify multiple topics, the APNs server uses the certificate’s Subject as the default topic.If you are using a provider token instead of a certificate, you must specify a value for this request header. The topic you provide should be provisioned for the your team named in your developer account. |
| apns-collapse-id | Multiple notifications with the same collapse identifier are displayed to the user as a single notification. The value of this key must not exceed 64 bytes. For more information, see [Quality of Service, Store-and-Forward, and Coalesced Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW5). |

The body content of your message is the JSON dictionary object for your notification’s payload. The body data must not be compressed and its maximum size is 4KB (4096 bytes). For a Voice over Internet Protocol (VoIP) notification, the body data maximum size is 5KB (5120 bytes). For information about the keys and values to include in the body content, see [Payload Key Reference](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html#//apple_ref/doc/uid/TP40008194-CH17-SW1).

#### 2.3.4.2 HTTP/2 Response from APNs - 来自APNs的HTTP/2响应

The response to a request has the format listed in Table 8-3.

**Table 8-3**APNs response headers

| Header name | Value                                    |
| ----------- | ---------------------------------------- |
| apns-id     | The apns-id value from the request. If no value was included in the request, the server creates a new UUID and returns it in this header. |
| :status     | The HTTP status code. For a list of possible status codes, see Table 8-4. |

Table 8-4 lists the possible status codes for a request. These values are included in the :status header of the response.

**Table 8-4**Status codes for an APNs response

| Status code | Description                              |
| ----------- | ---------------------------------------- |
| 200         | Success                                  |
| 400         | Bad request                              |
| 403         | There was an error with the certificate or with the provider authentication token |
| 405         | The request used a bad :method value. Only POST requests are supported. |
| 410         | The device token is no longer active for the topic. |
| 413         | The notification payload was too large.  |
| 429         | The server received too many requests for the same device token. |
| 500         | Internal server error                    |
| 503         | The server is shutting down and unavailable. |

For a successful request, the body of the response is empty. On failure, the response body contains a JSON dictionary with the keys listed in Table 8-5. This JSON data might also be included in the GOAWAY frame when a connection is terminated.

**Table 8-5**APNs JSON data keys

| Key       | Description                              |
| --------- | ---------------------------------------- |
| reason    | The error indicating the reason for the failure. The error code is specified as a string. For a list of possible values, see Table 8-6. |
| timestamp | If the value in the :status header is 410, the value of this key is the last time at which APNs confirmed that the device token was no longer valid for the topic.Stop pushing notifications until the device registers a token with a later timestamp with your provider. |

Table 8-6 lists the possible error codes included in the reason key of a response’s JSON payload.

**Table 8-6**Values for the APNs JSON reason key

| Status code | Error string                | Description                              |
| ----------- | --------------------------- | ---------------------------------------- |
| 400         | BadCollapseId               | The collapse identifier exceeds the maximum allowed size |
| 400         | BadDeviceToken              | The specified device token was bad. Verify that the request contains a valid token and that the token matches the environment. |
| 400         | BadExpirationDate           | The apns-expiration value is bad.        |
| 400         | BadMessageId                | The apns-id value is bad.                |
| 400         | BadPriority                 | The apns-priority value is bad.          |
| 400         | BadTopic                    | The apns-topic was invalid.              |
| 400         | DeviceTokenNotForTopic      | The device token does not match the specified topic. |
| 400         | DuplicateHeaders            | One or more headers were repeated.       |
| 400         | IdleTimeout                 | Idle time out.                           |
| 400         | MissingDeviceToken          | The device token is not specified in the request :path. Verify that the :path header contains the device token. |
| 400         | MissingTopic                | The apns-topic header of the request was not specified and was required. The apns-topic header is mandatory when the client is connected using a certificate that supports multiple topics. |
| 400         | PayloadEmpty                | The message payload was empty.           |
| 400         | TopicDisallowed             | Pushing to this topic is not allowed.    |
| 403         | BadCertificate              | The certificate was bad.                 |
| 403         | BadCertificateEnvironment   | The client certificate was for the wrong environment. |
| 403         | ExpiredProviderToken        | The provider token is stale and a new token should be generated. |
| 403         | Forbidden                   | The specified action is not allowed.     |
| 403         | InvalidProviderToken        | The provider token is not valid or the token signature could not be verified. |
| 403         | MissingProviderToken        | No provider certificate was used to connect to APNs and Authorization header was missing or no provider token was specified. |
| 404         | BadPath                     | The request contained a bad :path value. |
| 405         | MethodNotAllowed            | The specified :method was not POST.      |
| 410         | Unregistered                | The device token is inactive for the specified topic.Expected HTTP/2 status code is 410; see Table 8-4. |
| 413         | PayloadTooLarge             | The message payload was too large. See [Creating the Remote Notification Payload](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW1) for details on maximum payload size. |
| 429         | TooManyProviderTokenUpdates | The provider token is being updated too often. |
| 429         | TooManyRequests             | Too many requests were made consecutively to the same device token. |
| 500         | InternalServerError         | An internal server error occurred.       |
| 503         | ServiceUnavailable          | The service is unavailable.              |
| 503         | Shutdown                    | The server is shutting down.             |

#### 2.3.4.3 HTTP/2 Request/Response Examples for APNs - APNs的HTTP/2请求/响应的例子

Listing 8-1 shows a sample request constructed for a provider certificate.

**Listing 8-1**Sample request for a certificate with a single topic

	HEADERS
	  - END_STREAM
	  + END_HEADERS
	  :method = POST
	  :scheme = https
	  :path = /3/device/00fc13adff785122b4ad28809a3420982341241421348097878e577c991de8f0
	  host = api.development.push.apple.com
	  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
	  apns-expiration = 0
	  apns-priority = 10
	DATA
	  + END_STREAM
	    { "aps" : { "alert" : "Hello" } }

Listing 8-2 shows a sample request constructed for a provider authentication token.

**Listing 8-2**Sample request for a provider authentication token

	HEADERS
	  - END_STREAM
	  + END_HEADERS
	  :method = POST
	  :scheme = https
	  :path = /3/device/00fc13adff785122b4ad28809a3420982341241421348097878e577c991de8f0
	  host = api.development.push.apple.com
	  authorization = bearer eyAia2lkIjogIjhZTDNHM1JSWDciIH0.eyAiaXNzIjogIkM4Nk5WOUpYM0QiLCAiaWF0I
	 jogIjE0NTkxNDM1ODA2NTAiIH0.MEYCIQDzqyahmH1rz1s-LFNkylXEa2lZ_aOCX4daxxTZkVEGzwIhALvkClnx5m5eAT6
	 Lxw7LZtEQcH6JENhJTMArwLf3sXwi
	  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
	  apns-expiration = 0
	  apns-priority = 10
	  apns-topic = <MyAppTopic>
	DATA
	  + END_STREAM
	    { "aps" : { "alert" : "Hello" } }

Listing 8-3 shows a sample request constructed for a certificate that contains multiple topics.

**Listing 8-3**Sample request for a certificate with multiple topics

	HEADERS
	  - END_STREAM
	  + END_HEADERS
	  :method = POST
	  :scheme = https
	  :path = /3/device/00fc13adff785122b4ad28809a3420982341241421348097878e577c991de8f0
	  host = api.development.push.apple.com
	  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
	  apns-expiration = 0
	  apns-priority = 10
	  apns-topic = <MyAppTopic> 
	DATA
	  + END_STREAM
	    { "aps" : { "alert" : "Hello" } }

Listing 8-4 shows a sample response for a successful push request.

**Listing 8-4**Sample response for a successful request

	HEADERS
	  + END_STREAM
	  + END_HEADERS
	  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
	  :status = 200

Listing 8-5 shows a sample response when an error occurs.

**Listing 8-5**Sample response for a request that encountered an error

	HEADERS
	  - END_STREAM
	  + END_HEADERS
	  :status = 400
	  content-type = application/json
	    apns-id: <a_UUID>
	DATA
	  + END_STREAM
	  { "reason" : "BadDeviceToken" }

## 2.4 Payload Key Reference - 负载关键词参考

For each notification, you provide a payload with app-specific information and details about how to deliver the notification to the user. The payload is a JSON dictionary object (as defined by [RFC 4627](http://www.ietf.org/rfc/rfc4627.txt)) that you create on your server. The JSON dictionary object must contain an aps key, the value of which is a dictionary containing data used by the system to deliver the notification. The main contents of the aps dictionary determine whether the system does any of the following:

- Displays an alert message to the user 
- Applies a badge to the app’s icon 
- Plays a sound 
- Delivers the notification silently 

In addition to the aps dictionary, the JSON dictionary can include custom keys and values with your app-specific content. Custom values must use the JSON structure and use only primitive types such as dictionary (object), array, string, number, and Boolean. Do not include customer information or any sensitive data in your payload unless that data is encrypted or useless outside of the context of your app. For example, you could include a conversation identifier that your an instant messaging app could then use to locate the corresponding user conversation. The data in a notification should never be destructive—that is, your app should never use a notification to delete data on the user’s device.

When using the HTTP/2 based APNS provider API, the maximum size for your JSON dictionary is 4KB. For legacy APIs, the payload size is smaller.

For information and examples of how to create payloads, see [Creating the Remote Notification Payload](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW1).

### 2.4.1 APS Dictionary Keys - APS字典关键词

The aps dictionary contains the keys used by Apple to deliver the notification to the user’s device. The keys specify the type of interactions that you want the system to use when alerting the user. Table 9-1 lists the keys to include in this dictionary along with the type of information to include in each. Any other keys in the aps dictionary are ignored by Apple.

**Table 9-1**Keys and values of the `aps` dictionary

| Key               | Value type           | Comment                                  |
| ----------------- | -------------------- | ---------------------------------------- |
| `alert`             | Dictionary or String | Include this key when you want the system to display a standard alert or a banner. The notification settings for your app on the user’s device determine whether an alert or banner is displayed.The preferred value for this key is a dictionary, the keys for which are listed in Table 9-2. If you specify a string as the value of this key, that string is displayed as the message text of the alert or banner.The JSON `\U` notation is not supported. Put the actual UTF-8 character in the alert text instead. |
| `badge`             | Number               | Include this key when you want the system to modify the badge of your app icon.If this key is not included in the dictionary, the badge is not changed. To remove the badge, set the value of this key to `0`. |
| `sound`             | String               | Include this key when you want the system to play a sound. The value of this key is the name of a sound file in your app’s main bundle or in the `Library/Sounds` folder of your app’s data container. If the sound file cannot be found, or if you specify `default` for the value, the system plays the default alert sound.For details about providing sound files for notifications; see [Preparing Custom Alert Sounds](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SupportingNotificationsinYourApp.html#//apple_ref/doc/uid/TP40008194-CH4-SW10). |
| `content-available` | Number               | Include this key with a value of `1` to configure a silent notification. When this key is present, the system wakes up your app in the background and delivers the notification to its app delegate. For information about configuring and handling silent notifications, see [Configuring a Silent Notification](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW8). |
| `category`          | String               | Provide this key with a string value that represents the notification’s type. This value corresponds to the value in the [identifier](https://developer.apple.com/reference/uikit/uimutableusernotificationcategory/1615376-identifier) property of one of your app’s registered categories. To learn more about using custom actions, see [Configuring Categories and Actionable Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SupportingNotificationsinYourApp.html#//apple_ref/doc/uid/TP40008194-CH4-SW26). |
| `thread-id`         | String               | Provide this key with a string value that represents the app-specific identifier for grouping notifications. If you provide a Notification Content app extension, you can use this value to group your notifications together. For local notifications, this key corresponds to the [threadIdentifier](https://developer.apple.com/reference/usernotifications/unnotificationcontent/1649860-threadidentifier) property of the [UNNotificationContent](https://developer.apple.com/reference/usernotifications/unnotificationcontent) object. |

### 2.4.2 Alert Keys - 提醒关键词

Table 9-2 lists the keys and expected values for the alert dictionary.

**Table 9-2**Child properties of the `alert` property

| Key            | Value type               | Comment                                  |
| -------------- | ------------------------ | ---------------------------------------- |
| `title`          | String                   | A short string describing the purpose of the notification. Apple Watch displays this string as part of the notification interface. This string is displayed only briefly and should be crafted so that it can be understood quickly. This key was added in iOS 8.2. |
| `body`           | String                   | The text of the alert message.           |
| `title-loc-key`  | String or `null`           | The key to a title string in the `Localizable.strings` file for the current localization. The key string can be formatted with `%@` and `%`*n*`$@` specifiers to take the variables specified in the `title-loc-args` array. See [Localizing the Content of Your Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW9) for more information. This key was added in iOS 8.2. |
| `title-loc-args` | Array of strings or `null` | Variable string values to appear in place of the format specifiers in `title-loc-key`. See [Localizing the Content of Your Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW9) for more information. This key was added in iOS 8.2. |
| `action-loc-key` | String or `null`           | If a string is specified, the system displays an alert that includes the Close and View buttons. The string is used as a key to get a localized string in the current localization to use for the right button’s title instead of “View”. See [Localizing the Content of Your Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW9) for more information. |
| `loc-key`        | String                   | A key to an alert-message string in a Localizable.strings file for the current localization (which is set by the user’s language preference). The key string can be formatted with `%@` and `%`*n*`$@` specifiers to take the variables specified in the `loc-args` array. See [Localizing the Content of Your Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW9) for more information. |
| `loc-args`       | Array of strings         | Variable string values to appear in place of the format specifiers in `loc-key`. See [Localizing the Content of Your Remote Notifications](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW9) for more information. |
| `launch-image`   | String                   | The filename of an image file in the app bundle, with or without the filename extension. The image is used as the launch image when users tap the action button or move the action slider. If this property is not specified, the system either uses the previous snapshot, uses the image identified by the `UILaunchImageFile` key in the app’s `Info.plist` file, or falls back to `Default.png`. |