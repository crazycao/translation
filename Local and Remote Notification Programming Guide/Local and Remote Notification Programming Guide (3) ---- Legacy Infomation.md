# Local and Remote Notification Programming Guide

原文地址：
[https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/BinaryProviderAPI.html#//apple_ref/doc/uid/TP40008194-CH13-SW1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/BinaryProviderAPI.html#//apple_ref/doc/uid/TP40008194-CH13-SW1)

# 3 Legacy Infomation - 旧版信息

## 3.1 Binary Provider API - 二进制提供者API

The legacy binary interface required your provider server to employ the binary API described in this appendix. All developers should migrate their remote notification provider servers to the more capable and more efficient HTTP/2-based API described in [Communicating with APNs](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW1).

### 3.1.1 General Provider Requirements - 通用提供者要求

As a provider, you can communicate with Apple Push Notification service over a binary interface. This interface is a high-speed, high-capacity interface for providers; it uses a streaming TCP socket design in conjunction with binary content. The binary interface is asynchronous. The interface is supported, but you should prefer the use of the modern APNs API if possible.

The binary interface of the production environment is available through `gateway.push.apple.com`, port 2195; the binary interface of the development environment is available through `gateway.sandbox.push.apple.com`, port 2195.

For each interface, use TLS (or SSL) to establish a secured communications channel. The SSL certificate required for these connections is obtained from [your developer account](https://developer.apple.com/account/). (See [APNs Overview](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html#//apple_ref/doc/uid/TP40008194-CH8-SW1) for details.) To establish a trusted provider identity, present this certificate to APNs at connection time using peer-to-peer authentication.

>NOTE
>
>To establish a TLS session with APNs, an Entrust Secure CA root certificate must be installed on the provider’s server. If the server is running macOS, this root certificate is already in the keychain. On other systems, the certificate might not be available. You can download this certificate from the [Entrust SSL Certificates website](https://www.entrust.com/ssl-certificates/).

As a provider, you are responsible for the following aspects of remote notifications:

- You must compose the notification payload (see [Creating the Remote Notification Payload](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW1)). 
- You are responsible for supplying the badge number to be displayed on the app icon. 
- Connect regularly with the feedback service and fetch the current list of those devices that have repeatedly reported failed-delivery attempts. Then stop sending notifications to the devices associated with those apps. See The Feedback Service for more information. 

If you intend to support notification messages in multiple languages, but do not use the loc-key and loc-args properties of the aps payload dictionary for client-side fetching of localized alert strings, you need to localize the text of alert messages on the server side. To do this, you need to find out the current language preference from the client app. [Supplying the User’s Language Preference to Your Server](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW12) suggests an approach for obtaining this information. See [Creating the Remote Notification Payload](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH10-SW1) for information about the loc-key and loc-args properties.

### 3.1.2 The Binary Interface and Notification Format - 二进制接口和通知格式

The binary interface employs a plain TCP socket for binary content that is streaming in nature. For optimum performance, batch multiple notifications in a single transmission over the interface, either explicitly or using a TCP/IP Nagle algorithm. The format of notifications is shown in Figure A-1.

**Figure A-1**Notification format

![A-1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/aps_binary_provider_3_2x.png)

>NOTE
>
>All data is specified in network order, that is big endian.

The top level of the notification format is made up of the following, in order:

**Table A-1**Top-level fields for remote notifications

| Field name   | Length          | Discussion                               |
| ------------ | --------------- | ---------------------------------------- |
| Command      | 1 byte          | Populate with the number 2.              |
| Frame length | 4 bytes         | The size of the frame data.              |
| Frame data   | variable length | The frame contains the body, structured as a series of items. |

The frame data is made up of a series of items. Each item is made up of the following, in order:

**Table A-2**Fields for remote notification frames

| Field name       | Length          | Discussion                               |
| ---------------- | --------------- | ---------------------------------------- |
| Item ID          | 1 byte          | The item identifier, as listed in Table A-3. For example, the item identifier of the payload is 2. |
| Item data length | 2 bytes         | The size of the item data.               |
| Item data        | variable length | The value for the item.                  |

The items and their identifiers are as follows:

**Table A-3**Item identifiers for remote notifications

| Item ID | Item Name               | Length                                   | Data                                     |
| ------- | ----------------------- | ---------------------------------------- | ---------------------------------------- |
| 1       | Device token            | 32 bytes                                 | The device token in binary form, as was registered by the device.A remote notification must have exactly one device token. |
| 2       | Payload                 | variable length, less than or equal to 2 kilobytes | The JSON-formatted payload. A remote notification must have exactly one payload.The payload must not be null-terminated. |
| 3       | Notification identifier | 4 bytes                                  | An arbitrary, opaque value that identifies this notification. This identifier is used for reporting errors to your server.Although this item is not required, you should include it to allow APNs to restart the sending of notifications upon encountering an error. |
| 4       | Expiration date         | 4 bytes                                  | A UNIX epoch date expressed in seconds (UTC) that identifies when the notification is no longer valid and can be discarded.If this value is non-zero, APNs stores the notification tries to deliver the notification at least once. Specify zero to indicate that the notification expires immediately and that APNs should not store the notification at all. |
| 5       | Priority                | 1 byte                                   | The notification’s priority. Provide one of the following values:10 The push message is sent immediately. The remote notification must trigger an alert, sound, or badge on the device. It is an error to use this priority for a push that contains only the content-available key. 5 The push message is sent at a time that conserves power on the device receiving it. Notifications with this priority might be grouped and delivered in bursts. They are throttled, and in some cases are not delivered. |

If you send a notification that is accepted by APNs, nothing is returned.

If you send a notification that is malformed or otherwise unintelligible, APNs returns an error-response packet and closes the connection. Any notifications that you sent after the malformed notification using the same connection are discarded, and must be resent. Figure A-2 shows the format of the error-response packet.

**Figure A-2**Format of error-response packet

![A-2](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/aps_binary_error_2x.png)

The packet has a command value of 8 followed by a one-byte status code and the notification identifier of the malformed notification. Table A-4 lists the possible status codes and their meanings.

**Table A-4**Codes in error-response packet

| Status code | Description                              |
| ----------- | ---------------------------------------- |
| 0           | No errors encountered                    |
| 1           | Processing error                         |
| 2           | Missing device token                     |
| 3           | Missing topic                            |
| 4           | Missing payload                          |
| 5           | Invalid token size                       |
| 6           | Invalid topic size                       |
| 7           | Invalid payload size                     |
| 8           | Invalid token                            |
| 10          | Shutdown                                 |
| 128         | Protocol error (APNs could not parse the notification) |
| 255         | None (unknown)                           |

A status code of 10 indicates that the APNs server closed the connection (for example, to perform maintenance). The notification identifier in the error response indicates the last notification that was successfully sent. Any notifications you sent after it have been discarded and must be resent. When you receive this status code, stop using this connection and open a new connection.

Take note that the device token in the production environment and the device token in the development environment are not the same value.

### 3.1.3 The Feedback Service - 反馈服务

The Apple Push Notification service includes a feedback service to give you information about failed remote notifications. When a remote notification cannot be delivered because the intended app does not exist on the device, the feedback service adds that device’s token to its list. Remote notifications that expire before being delivered are not considered a failed delivery and don’t impact the feedback service. By using this information to stop sending remote notifications that will fail to be delivered, you reduce unnecessary message overhead and improve overall system performance.

Query the feedback service daily to get the list of device tokens. Use the timestamp to verify that the device tokens haven’t been reregistered since the feedback entry was generated. For each device that has not been reregistered, stop sending notifications. APNs monitors providers for their diligence in checking the feedback service and refraining from sending remote notifications to nonexistent apps on devices.

>NOTE
>
>The feedback service maintains a separate list for each push topic. If you have multiple apps, you must connect to the feedback service once for each app, using the corresponding certificate, in order to receive all feedback.

The feedback service has a binary interface similar to the interface used for sending remote notifications. You access the production feedback service via feedback.push.apple.com on port 2196 and the development feedback service via feedback.sandbox.push.apple.com on port 2196. As with the binary interface for remote notifications, use TLS (or SSL) to establish a secured communications channel. You use the same SSL certificate for connecting to the feedback service as you use for sending notifications. To establish a trusted provider identity, present this certificate to APNs at connection time using peer-to-peer authentication.

Once you are connected, transmission begins immediately; you do not need to send any command to APNs. Read the stream from the feedback service until there is no more data to read. The received data is in tuples with the following format:

**Figure A-3**Binary format of a feedback tuple

![A-3](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/aps_feedback_binary_2x.png)

**Table A-5**Table

| Timestamp    | A timestamp (as a four-byte time_t value) indicating when APNs determined that the app no longer exists on the device. This value, which is in network order, represents the seconds since 12:00 midnight on January 1, 1970 UTC. |
| ------------ | ---------------------------------------- |
| Token length | The length of the device token as a two-byte integer value in network order. |
| Device token | The device token in binary format.       |

The feedback service’s list is cleared after you read it. Each time you connect to the feedback service, the information it returns lists only the failures that have happened since you last connected.

## 3.2 Legacy Notification Format - 旧版通知格式

New development should use the modern format to connect to APNs, as described in [Communicating with APNs](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CommunicatingwithAPNs.html#//apple_ref/doc/uid/TP40008194-CH11-SW1).

These formats do not include a priority; a priority of 10 is assumed.

### 3.2.1 Legacy Notification Format - 旧版通知格式

Figure B-1 shows this format.

**Figure B-1**Legacy notification format

![B-1](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/aps_provider_binary_2x.png)

The first byte in the legacy format is a command value of 0 (zero). The other fields are the same as the enhanced format. Listing B-1 gives an example of a function that sends a remote notification to APNs over the binary interface using the legacy notification format. The example assumes prior SSL connection to gateway.push.apple.com (or gateway.sandbox.push.apple.com) and peer-exchange authentication.

**Listing B-1**Sending a notification in the legacy format via the binary interface

```
static bool sendPayload(SSL *sslPtr, char *deviceTokenBinary, char *payloadBuff, size_t payloadLength)
{
    bool rtn = false;
    if (sslPtr && deviceTokenBinary && payloadBuff && payloadLength)
    {
        uint8_t command = 0; /* command number */
        char binaryMessageBuff[sizeof(uint8_t) + sizeof(uint16_t) +
            DEVICE_BINARY_SIZE + sizeof(uint16_t) + MAXPAYLOAD_SIZE];
        /* message format is, |COMMAND|TOKENLEN|TOKEN|PAYLOADLEN|PAYLOAD| */
        char *binaryMessagePt = binaryMessageBuff;
        uint16_t networkOrderTokenLength = htons(DEVICE_BINARY_SIZE);
        uint16_t networkOrderPayloadLength = htons(payloadLength);
 
        /* command */
        *binaryMessagePt++ = command;
 
       /* token length network order */
        memcpy(binaryMessagePt, &networkOrderTokenLength, sizeof(uint16_t));
        binaryMessagePt += sizeof(uint16_t);
 
        /* device token */
        memcpy(binaryMessagePt, deviceTokenBinary, DEVICE_BINARY_SIZE);
        binaryMessagePt += DEVICE_BINARY_SIZE;
 
        /* payload length network order */
        memcpy(binaryMessagePt, &networkOrderPayloadLength, sizeof(uint16_t));
        binaryMessagePt += sizeof(uint16_t);
 
        /* payload */
        memcpy(binaryMessagePt, payloadBuff, payloadLength);
        binaryMessagePt += payloadLength;
        if (SSL_write(sslPtr, binaryMessageBuff, (binaryMessagePt -  binaryMessageBuff)) > 0)
            rtn = true;
    }
    return rtn;
}
```

### 3.2.2 Enhanced Notification Format - 增强通知格式

The enhanced format has several improvements over the legacy format:

- **Error response**. With the legacy format, if you send a notification packet that is malformed in some way—for example, the payload exceeds the stipulated limit—APNs responds by severing the connection. It gives no indication why it rejected the notification. The enhanced format lets a provider tag a notification with an arbitrary identifier. If there is an error, APNs returns a packet that associates an error code with the identifier. This response enables the provider to locate and correct the malformed notification. 
- **Notification expiration**. APNs has a store-and-forward feature that keeps the most recent notification sent to an app on a device. If the device is offline at time of delivery, APNs delivers the notification when the device next comes online. With the legacy format, the notification is delivered regardless of the pertinence of the notification. In other words, the notification can become “stale” over time. The enhanced format includes an expiry value that indicates the period of validity for a notification. APNs discards a notification in store-and-forward when this period expires. 

Figure B-2 depicts the format for notification packets.

**Figure B-2**Enhanced notification format
![B-2](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/aps_binary_provider_2_2x.png)

The first byte in the notification format is a command value of 1. The remaining fields are as follows:

- **Identifier**—An arbitrary value that identifies this notification. This same identifier is returned in a error-response packet if APNs cannot interpret a notification. 
- **Expiry**—A fixed UNIX epoch date expressed in seconds (UTC) that identifies when the notification is no longer valid and can be discarded. The expiry value uses network byte order (big endian). If the expiry value is non-zero, APNs tries to deliver the notification at least once. Specify zero to request that APNs not store the notification at all. 
- **Token length**—The length of the device token in network order (that is, big endian) 
- **Device token**—The device token in binary form. 
- **Payload length**—The length of the payload in network order (that is, big endian). The payload must not exceed 256 bytes and must *not* be null-terminated. 
- **Payload**—The notification payload. 

Listing B-2 composes a remote notification in the enhanced format before sending it to APNs. It assumes prior SSL connection to gateway.push.apple.com (or gateway.sandbox.push.apple.com) and peer-exchange authentication.

**Listing B-2** Sending a notification in the enhanced format via the binary interface

```
static bool sendPayload(SSL *sslPtr, char *deviceTokenBinary, char *payloadBuff, size_t payloadLength)
{
  bool rtn = false;
  if (sslPtr && deviceTokenBinary && payloadBuff && payloadLength)
  {
      uint8_t command = 1; /* command number */
      char binaryMessageBuff[sizeof(uint8_t) + sizeof(uint32_t) + sizeof(uint32_t) + sizeof(uint16_t) +
          DEVICE_BINARY_SIZE + sizeof(uint16_t) + MAXPAYLOAD_SIZE];
      /* message format is, |COMMAND|ID|EXPIRY|TOKENLEN|TOKEN|PAYLOADLEN|PAYLOAD| */
      char *binaryMessagePt = binaryMessageBuff;
      uint32_t whicheverOrderIWantToGetBackInAErrorResponse_ID = 1234;
      uint32_t networkOrderExpiryEpochUTC = htonl(time(NULL)+86400); // expire message if not delivered in 1 day
      uint16_t networkOrderTokenLength = htons(DEVICE_BINARY_SIZE);
      uint16_t networkOrderPayloadLength = htons(payloadLength);
 
      /* command */
      *binaryMessagePt++ = command;
 
     /* provider preference ordered ID */
     memcpy(binaryMessagePt, &whicheverOrderIWantToGetBackInAErrorResponse_ID, sizeof(uint32_t));
     binaryMessagePt += sizeof(uint32_t);
 
     /* expiry date network order */
     memcpy(binaryMessagePt, &networkOrderExpiryEpochUTC, sizeof(uint32_t));
     binaryMessagePt += sizeof(uint32_t);
 
     /* token length network order */
      memcpy(binaryMessagePt, &networkOrderTokenLength, sizeof(uint16_t));
      binaryMessagePt += sizeof(uint16_t);
 
      /* device token */
      memcpy(binaryMessagePt, deviceTokenBinary, DEVICE_BINARY_SIZE);
      binaryMessagePt += DEVICE_BINARY_SIZE;
 
      /* payload length network order */
      memcpy(binaryMessagePt, &networkOrderPayloadLength, sizeof(uint16_t));
      binaryMessagePt += sizeof(uint16_t);
 
      /* payload */
      memcpy(binaryMessagePt, payloadBuff, payloadLength);
      binaryMessagePt += payloadLength;
      if (SSL_write(sslPtr, binaryMessageBuff, (binaryMessagePt - binaryMessageBuff)) > 0)
          rtn = true;
  }
  return rtn;
}
```

