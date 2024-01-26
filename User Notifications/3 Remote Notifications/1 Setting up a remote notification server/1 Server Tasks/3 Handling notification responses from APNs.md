# Handling notification responses from APNs - 处理来自 APNs 的通知响应

原文地址：
[https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns)

Respond to the status codes that the APNs servers return.

响应 APNs 服务器返回的状态代码。

# Overview 概述

Apple Push Notification service (APNs) provides a response to each POST request your server transmits. Each response contains a header with fields indicating the status of the response. If the request was successful, the body of the response is empty. If an error occurred, the body contains a JSON dictionary with additional information about the error.

Apple Push Notification service（APNs）为您的服务器发送的每个 POST 请求提供响应。每个响应包含一个带有字段的头部，指示响应的状态。如果请求成功，响应的 body 为空。如果发生错误，则响应的 body 包含一个带有相关错误的额外信息的 JSON 字典。

If you find your device is having trouble receiving notifications, check the common problems listed in [Troubleshoot problems with receiving notifications](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns#3394526).

如果您发现设备无法接收通知，请检查《[解决接收通知问题](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns#3394526)》中列出的常见问题。

## Interpret header responses 解释头响应

Table 1 describes the meaning of the keys in the header response.

表1 描述了头响应中键的含义。

**Table 1** Header keys **表 1** 头键

Header name</br>头名称|Value</br>值
|:-:|:-:|
apns-id|The same value found in the apns-id field of the request’s header. Use this value to identify the notification. If you don’t specify an apns-id field in your request, APNs creates a new UUID and returns it in this header. </br>与在请求头中的 `apns-id` 字段相同的值。可以使用此值来标识通知。如果在请求中未指定 `apns-id` 字段，则 APNs 会创建一个新的 UUID 并在这个 header 中返回它。
:status|The HTTP status code.  </br>HTTP 状态码。
apns-unique-id|An identifier that is only available in the Developement enviroment. Use this to query Delivery Log information for the corresponding notification in Push Notifications Console. For more information, see [Testing notifications using the Push Notification Console](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console).  </br>仅在开发环境中可用的标识符。可用于在推送通知控制台中查询相应通知的传递日志信息。有关更多信息，请参阅《[使用推送通知控制台进行通知测试](https://developer.apple.com/documentation/usernotifications/testing_notifications_using_the_push_notification_console)》。

Table 2 lists the possible values in the `:status` header of the response.

表 2 列出了响应的 `:status` 头中的可能的值。 

**Table 2** HTTP status codes **表 2** HTTP 状态码

Status code   </br>状态码|Description  </br>描述
|:-:|:-:|
200|Success.    成功。
400|Bad request.  错误的请求。
403|There was an error with the certificate or with the provider’s authentication token.   </br>证书或提供者的身份验证令牌存在错误。
404|The request contained an invalid `:path` value.  </br>请求中包含无效的 `:path` 值。
405|The request used an invalid `:method` value. Only POST requests are supported.   </br>请求使用了无效的 `:method` 值。仅支持 POST 请求。
410|The device token is no longer active for the topic.   </br>设备令牌对该主题不再有效。
413|The notification payload was too large.   </br>通知负载过大。
429|The server received too many requests for the same device token.   </br>服务器接收到了太多针对相同设备令牌的请求。
500|Internal server error.  内部服务器错误。
503|The server is shutting down and unavailable.  </br> 服务器正在关闭并且不可用。

## Understand error codes 了解错误码

Table 3 lists the keys found in the JSON dictionary for unsuccessful requests. The JSON data might also be included in a GOAWAY frame when a connection is terminated.

Table 3 Response keys

Key|Description
|:-:|:-:|
reason|The error code (specified as a string) indicating the reason for the failure. For a list of possible values, see the Response error strings table below.
timestamp|The time, represented in milliseconds since Epoch, at which APNs confirmed the token was no longer valid for the topic. This key is included only when the error in the :status field is 410.

Table 4 lists the possible error codes included in the reason key of a response’s JSON payload.

Table 4 Response error strings

Status code|Error string|Description
|:-:|:-:|:-:|
400|BadCollapseId|The collapse identifier exceeds the maximum allowed size.
400|BadDeviceToken|The specified device token is invalid. Verify that the request contains a valid token and that the token matches the environment.
400|BadExpirationDate|The apns-expiration value is invalid.
400|BadMessageId|The apns-id value is invalid.
400|BadPriority|The apns-priority value is invalid.
400|BadTopic|The apns-topic value is invalid.
400|DeviceTokenNotForTopic|The device token doesn’t match the specified topic.
400|DuplicateHeaders|One or more headers are repeated.
400|IdleTimeout|Idle timeout.
400|InvalidPushType|The apns-push-type value is invalid.
400|MissingDeviceToken|The device token isn’t specified in the request :path. Verify that the :path header contains the device token.
400|MissingTopic|The apns-topic header of the request isn’t specified and is required. The apns-topic header is mandatory when the client is connected using a certificate that supports multiple topics.
400|PayloadEmpty|The message payload is empty.
400|TopicDisallowed|Pushing to this topic is not allowed.
403|BadCertificate|The certificate is invalid.
403|BadCertificateEnvironment|The client certificate is forthe wrong environment.
403|ExpiredProviderToken|The provider token is stale and a new token should be generated.
403|Forbidden|The specified action is not allowed.
403|InvalidProviderToken|The provider token is not valid, or the token signature can't be verified.
403|MissingProviderToken|No provider certificate was used to connect to APNs, and the authorization header is missing or no provider token is specified.
404|BadPath|The request contained an invalid :path value.
405|MethodNotAllowed|The specified :method value isn’t POST.
410|ExpiredToken|The device token has expired.
410|Unregistered|The device token is inactive for the specified topic. There is no need to send further pushes to the same device token, unless your application retrieves the same device token, see Registering your app with APNs
413|PayloadTooLarge|The message payload is too large. For information about the allowed payload size, see Create a POST request to APNs.
429|TooManyProviderTokenUpdates|The provider’s authentication token is being updated too often. Update the authentication token no more than once every 20 minutes.
429|TooManyRequests|Too many requests were made consecutively to the same device token.
500|InternalServerError|An internal server error occurred.
503|ServiceUnavailable|The service is unavailable.
503|Shutdown|The APNs server is shutting down.

Listing 1 shows a sample response for a successful push request.

Listing 1 A successful response

```
HEADERS
  + END_STREAM
  + END_HEADERS
  apns-id = eabeae54-14a8-11e5-b60b-1697f925ec7b
  :status = 200
```

Listing 2 shows a sample response when an error occurs.

Listing 2 An error response

```
HEADERS
  - END_STREAM
  + END_HEADERS
  :status = 400
  content-type = application/json
  apns-id: <a_UUID>
DATA
  + END_STREAM
  { "reason" : "BadDeviceToken" }
```

Troubleshoot problems with receiving notificationsin page link
During testing, if you find that your test devices aren’t receiving push notifications sent by your provider server, examine the following possible causes:

Make sure that your provider server has an up-to-date device token for your test device. Each time your app launches, it should request its current token and forward that token to your provider server. You should also implement the appropriate failure handler methods to determine if APNs reported an error. See Registering your app with APNs.

Check for errors returned by APNs. When failures occur, APNs reports an appropriate error back to your provider server. Use the error code to decide the proper action that makes sense for your app.

Make sure you included the apns-push-type key in your request headers. This key is required starting in watchOS 6. The absence of this key may delay the delivery of notifications, or prevent their delivery altogether. See .

Check to see if you’re sending requests to the same device too quickly. APNs queues only one notification at a time for each device, and the device must acknowledge receipt of the notification before APNs dequeues it. If you send multiple notification requests in a very short period of time, each new request might overwrite the previous request.

Check to see if silent notifications are being throttled. APNs sends a limited number of silent notifications—notifications with the content-available key. In addition, if the device has already exceeded its power budget for the day, silent notifications aren’t sent again until the power budget resets, which happens once a day. These limits are disabled when testing your app from Xcode. See Pushing background updates to your App.

Check the firewall settings of your server and devices. To send notifications, your provider server must allow inbound and outbound TCP packets over port 443 for HTTP/2 connections, or port 2195 when using the binary interface. Devices connecting to APNs over Wi-Fi need to allow inbound and outbound TCP packets over port 5223, falling back to port 443 if port 5223 is unavailable.

Verify that you aren't spamming the device. If you send too many notifications to the same device within a short timespan, APNs may treat it as a denial-of-service attack and temporarily block your server from sending notifications.

If your provider server is unable to connect to APNs, examine the following possible causes:

Make sure you have the needed certificates installed on your provider server. If your provider server doesn't have the proper certificates for TLS/SSL validation, it cannot connect to APNs. For certificate-based connections, your provider server must also have the certificate you obtained from Apple. See Establishing a certificate-based connection to APNs.

Check how often your provider server connects to APNs. If your provider server opens and closes its connection to APNs repeatedly, APNs may treat it as a denial-of-service attack and temporarily block your server from connecting.

You can verify the TLS handshake between your provider server and APNs by running the OpenSSL s_client command from your server, as shown in Listing 3. This command can also show if your TLS/SSL certificates are expired or revoked.

Listing 3 Verifying the TLS handshake

```
$ openssl s_client -connect api.development.push.apple.com:443 -cert YourSSLCertAndPrivateKey.pem -debug 
-showcerts -CAfile server-ca-cert.pem
```

# See Also - 其他参考

## Server Tasks - 服务器任务

###  Generating a remote notification - 生成远程通知

Send notifications to the user’s device with a JSON payload.

携带 JSON 负载向用户的设备发送通知。

### Sending notification requests to APNs - 向 APNs 发送通知请求

Transmit your remote notification payload and device token information to Apple Push Notification service (APNs).

将您的远程通知负载和设备令牌信息传输到苹果推送通知服务（APNs）。

### Handling notification responses from APNs - 处理来自 APNs 的通知响应

Respond to the status codes that the APNs servers return.

响应 APNs 服务器返回的状态代码。

### Delivering a notification with Apple Push Notification service - 使用苹果推送通知服务传递通知

Understand the factors that determine the delivery of a push notification with APNs.

了解决定使用APN发送推送通知的因素。

### Pushing background updates to your App - 推送后台更新到您的应用程序

Deliver notifications that wake your app and update it in the background.

发送在后台唤醒您的应用程序并进行更新的通知。
