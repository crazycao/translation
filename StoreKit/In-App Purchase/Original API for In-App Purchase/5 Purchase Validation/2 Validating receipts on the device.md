# Validating receipts on the device
# 使用 App Store 验证收据

原文地址：[https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device](https://developer.apple.com/documentation/appstorereceipts/validating_receipts_on_the_device)

> Technology
>
> StoreKit

Verify the contents of app receipts by decoding and parsing the receipt on the device.

通过在设备上解码和解析收据来验证应用收据的内容。

## Overview - 概览

When users install apps from the App Store, the app contains a cryptographically signed receipt that Apple creates and stores inside the app bundle, which you can then validate.

当用户从 App Store 安装应用程序时，应用程序包含一个由 Apple 创建并存储在应用程序包中的加密签名收据，您可以对其进行验证。

> **Note** **注意**
>
> The receipt isn’t necessary if you use [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction) to validate the app download, or [Transaction](https://developer.apple.com/documentation/storekit/transaction) to validate in-app purchases. Only use the receipt if your app uses the [Original API for in-app purchase](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase), or needs the receipt to validate the app download because it can’t use [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction).
>
> 如果您使用 [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction) 来验证应用程序下载，或使用 [Transaction](https://developer.apple.com/documentation/storekit/transaction) 来验证应用内购买，则不需要收据。仅当您的应用程序使用 [原始API进行应用内购买](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase)，或者需要收据来验证应用程序下载（因为无法使用 [AppTransaction](https://developer.apple.com/documentation/storekit/apptransaction)）时，才使用收据。

Validating the receipt locally requires you to develop or use code to read and decode the receipt as a `PKCS #7` container, as defined by [RFC 2315](https://www.rfc-editor.org/rfc/rfc2315). The App Store encodes the payload of the container using `Abstract Syntax Notation One (ASN.1)`, as defined by [ITU-T X.690](https://www.itu.int/rec/T-REC-X.690/). The payload contains a set of receipt attributes. Each receipt attribute contains a type, a version, and a value.

在本地验证收据需要开发或使用代码来将收据读取和解码为 `PKCS #7` 容器（由 [RFC 2315](https://www.rfc-editor.org/rfc/rfc2315) 定义）。App Store 使用 `抽象语法标记1（ASN.1）`（由 [ITU-T X.690](https://www.itu.int/rec/T-REC-X.690/) 定义）对容器的有效负载进行编码。有效负载包含一组收据属性。每个收据属性都包含类型、版本和值。

The App Store defines the structure of the payload with the following ASN.1 notation:

App Store 按照 ASN.1 语法定义有效负载的结构：

```
ReceiptModule DEFINITIONS ::=
BEGIN

ReceiptAttribute ::= SEQUENCE {
    type    INTEGER,
    version INTEGER,
    value   OCTET STRING
}

Payload ::= SET OF ReceiptAttribute

END
```

## Validate the receipt
In macOS and Mac apps built with Mac Catalyst, implement receipt validation in the main function, before the app calls [NSApplicationMain(_:_:)](https://developer.apple.com/documentation/appkit/1428499-nsapplicationmain).

在 macOS 和使用 Mac Catalyst 构建的 Mac 应用程序中，在应用程序调用 [NSApplicationMain(_:_:)](https://developer.apple.com/documentation/appkit/1428499-nsapplicationmain) 之前，在主函数中实现收据验证。

To validate the app receipt, perform the following tests in order:

1. Locate and load the app receipt from the app’s bundle. The class [Bundle](https://developer.apple.com/documentation/foundation/bundle) provides the location of the receipt with the property [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/bundle/1407276-appstorereceipturl).
2. Decode the app receipt as a `PKCS #7` container and verify that the chain of trust for the container’s signature traces back to the Apple Inc. Root certificate, available from [Apple PKI](https://www.apple.com/certificateauthority/). Use the `receipt_creation_date`, identified as [ASN.1 Field Type 12](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1) when validating the receipt signature.
3. Verify that the bundle identifier, identified as [ASN.1 Field Type 2](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1), matches your app’s bundle identifier.
4. Verify that the version identifier string, identified as [ASN.1 Field Type 3](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1), matches the version string in your app’s bundle.
5. Compute a `SHA-1` hash for the device that installs the app and verify that it matches the receipt’s hash, identified as [ASN.1 Field Type 5](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1).

要验证应用程序收据，请按顺序执行以下测试：

1. 从应用程序的包中定位并加载应用程序收据。[Bundle](https://developer.apple.com/documentation/foundation/bundle) 类通过 [appStoreReceiptURL](https://developer.apple.com/documentation/foundation/bundle/1407276-appstorereceipturl) 属性提供收据的位置。
2. 将应用程序收据解码为 `PKCS #7` 容器，并验证容器签名的信任链是否追溯到  Apple Inc. 根证书，该证书可以从 [Apple PKI](https://www.apple.com/certificateauthority/) 获取。在验证收据签名时，请使用 `receipt_creation_date`，标识为 [ASN.1 Field Type 12](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1) 。
3. 验证标识为 [ASN.1 Field Type 2](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1) 的捆绑标识符（bundle id），是否与您的应用程序的捆绑标识符相匹配。
4. 验证标识为 [ASN.1 Field Type 3](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1) 的版本标识符字符串，是否与您的应用程序的 bundle 里的版本字符串相匹配。
5. 为安装应用程序的设备计算 `SHA-1` 哈希，并验证它是否与标识为 [ASN.1 Field Type 5](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1) 的收据的哈希值相匹配。

The validation passes if all of the tests pass. If any test fails, the validation fails.

如果所有测试都通过，则验证成功。如果任意测试失败，则验证失败。

For information about the keys in a receipt, see [Receipt Fields](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1).

有关收据中的键的信息，请参阅《[收据字段](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1)》。

## Verify the certificate chain of trust - 验证证书信任链

Decode the app receipt as a `PKCS #7` container and verify that the chain of trust for the container’s signature traces back to the Apple Inc. Root certificate, available from [Apple PKI](https://www.apple.com/certificateauthority/).

将应用程序收据解码为 `PKCS #7` 容器，并验证容器签名的信任链是否追溯到 Apple Inc. 根证书，该证书可从 [Apple PKI](https://www.apple.com/certificateauthority/) 获取。

> **Tip** **提示**
>
> Don’t hardcode intermediate certificates in your app. Ensure that your code supports certificates that use `SHA-256` and `SHA-1` signing algorithms.
> 
> 不要在应用程序中硬编码中间证书。确保您的代码支持使用 `SHA-256` 和 `SHA-1` 签名算法的证书。

Make sure your app uses the date from the `receipt_creation_date` field, identified as [ASN.1 Field Type 12](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1), to validate the receipt’s signature. Many cryptographic libraries default to using the device’s current time and date when validating a `PKCS #7` package, but this may not produce the correct results when validating a receipt’s signature. For example, if the receipt was signed with a valid certificate, but the certificate has since expired, using the device’s current date incorrectly returns an invalid result.

确保您的应用程序使用 `receipt_creation_date` 字段的日期（标识为 [ASN.1 Field Type 12](https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ReceiptFields.html#//apple_ref/doc/uid/TP40010573-CH106-SW1)）来验证收据的签名。许多加密库在验证 `PKCS #7` 包时默认使用设备的当前时间和日期，但在验证收据的签名时，这可能不会产生正确的结果。例如，如果收据使用有效的证书进行签名，但该证书已过期，使用设备的当前日期会错误地返回一个无效的结果。

## Compute the SHA-1 hash - 计算 SHA-1 哈希值

Compute the `SHA-1` hash to match the local device with the device hash inside the App Store reciept. When computing the `SHA-1` hash, use the platform-specific data source. The source of bytes for each platform is:

计算本地设备的 `SHA-1` 哈希值，将与 App Store 收据中的设备哈希进行匹配。在计算 `SHA-1` 哈希值时，各个平台使用不同的数据源。每个平台的字节来源如下：

- watchOS: Use the raw bytes from the [uuid](https://developer.apple.com/documentation/foundation/uuid/1779678-uuid) property of the [UUID](https://developer.apple.com/documentation/foundation/uuid) that [identifierForVendor](https://developer.apple.com/documentation/watchkit/wkinterfacedevice/3538473-identifierforvendor) provides.
- iOS, iPadOS, tvOS, and iOS apps running on a Mac with Apple silicon: Use the raw bytes from the [uuid](https://developer.apple.com/documentation/foundation/uuid/1779678-uuid) property of the [UUID](https://developer.apple.com/documentation/foundation/uuid) that [identifierForVendor](https://developer.apple.com/documentation/watchkit/wkinterfacedevice/3538473-identifierforvendor) provides.
- macOS and apps built with Mac Catalyst: Use the data that returns from `copy_mac_address` from the example code below.

>

- watchOS：使用 [identifierForVendor](https://developer.apple.com/documentation/watchkit/wkinterfacedevice/3538473-identifierforvendor) 提供的 [UUID](https://developer.apple.com/documentation/foundation/uuid) 的 uuid 属性的原始字节。
- iOS、iPadOS、tvOS 以及在搭载 Apple Silicon 的 Mac 上运行的 iOS 应用程序：使用 [identifierForVendor](https://developer.apple.com/documentation/watchkit/wkinterfacedevice/3538473-identifierforvendor) 提供的 [UUID](https://developer.apple.com/documentation/foundation/uuid) 的 uuid 属性的原始字节。
- macOS以及使用Mac Catalyst构建的应用程序：使用从下面示例代码的 `copy_mac_address` 返回的数据。

The following two code examples illustrate how to retrieve an identifier in macOS, as the `copy_mac_address` function shows, for validating an App Store receipt.

以下两个代码示例说明了如何在 macOS 中检索标识符，如 `copy_mac_address` 函数所示，用于验证 App Store 收据。

In the following Swift code, the `io_service` function uses [IOKit](https://developer.apple.com/documentation/iokit) to retrieve network interfaces as an optional `IOKit` object. The `copy_mac_address` function looks up an appropriate network interface and returns the hardware address from the `IOKit` object as optional `CFData`.

在下面的 Swift 代码中，`io_service` 函数使用 [IOKit](https://developer.apple.com/documentation/iokit) 来检索网络接口作为可选的 `IOKit` 对象。`copy_mac_address` 函数查找适当的网络接口，并从 `IOKit` 对象中返回硬件地址作为可选的 `CFData`。

```
import IOKit
import Foundation


// Returns an object with a +1 retain count; the caller needs to release.
func io_service(named name: String, wantBuiltIn: Bool) -> io_service_t? {
    let default_port = kIOMasterPortDefault
    var iterator = io_iterator_t()
    defer {
        if iterator != IO_OBJECT_NULL {
            IOObjectRelease(iterator)
        }
    }


    guard let matchingDict = IOBSDNameMatching(default_port, 0, name),
        IOServiceGetMatchingServices(default_port,
                                     matchingDict as CFDictionary,
                                     &iterator) == KERN_SUCCESS,
        iterator != IO_OBJECT_NULL
    else {
        return nil
    }


    var candidate = IOIteratorNext(iterator)
    while candidate != IO_OBJECT_NULL {
        if let cftype = IORegistryEntryCreateCFProperty(candidate,
                                                        "IOBuiltin" as CFString,
                                                        kCFAllocatorDefault,
                                                        0) {
            let isBuiltIn = cftype.takeRetainedValue() as! CFBoolean
            if wantBuiltIn == CFBooleanGetValue(isBuiltIn) {
                return candidate
            }
        }


        IOObjectRelease(candidate)
        candidate = IOIteratorNext(iterator)
    }


    return nil
}


func copy_mac_address() -> CFData? {
    // Prefer built-in network interfaces.
    // For example, an external Ethernet adaptor can displace
    // the built-in Wi-Fi as en0.
    guard let service = io_service(named: "en0", wantBuiltIn: true)
            ?? io_service(named: "en1", wantBuiltIn: true)
            ?? io_service(named: "en0", wantBuiltIn: false)
        else { return nil }
    defer { IOObjectRelease(service) }


    if let cftype = IORegistryEntrySearchCFProperty(
        service,
        kIOServicePlane,
        "IOMACAddress" as CFString,
        kCFAllocatorDefault,
        IOOptionBits(kIORegistryIterateRecursively | kIORegistryIterateParents)) {
            return (cftype as! CFData)
    }


    return nil
}
```

The following Objective-C code works in the same fashion. This example uses `IOKit` to look up the relevant network interface, and returns the bytes that identify the built-in network interface:

以下 Objective-C 代码以相同的方式工作。此示例使用 `IOKit` 来查找相关的网络接口，并返回标识内置网络接口的字节：

```
#import <Foundation/Foundation.h>
#import <IOKit/network/IONetworkLib.h>


io_service_t io_service(const char *name, BOOL wantBuiltIn) {
    io_iterator_t iterator = IO_OBJECT_NULL;
    mach_port_t default_port = kIOMasterPortDefault;
    io_service_t service = IO_OBJECT_NULL;


    if (KERN_SUCCESS != IOMasterPort(MACH_PORT_NULL, &default_port)) {
        return IO_OBJECT_NULL;
    }


    CFMutableDictionaryRef matchingDict = IOBSDNameMatching(default_port,
                                                            0,
                                                            name);
    if (matchingDict == NULL) {
        return IO_OBJECT_NULL;
    }


    if (KERN_SUCCESS != IOServiceGetMatchingServices(default_port,
                                                     matchingDict,
                                                     &iterator)) {
        return IO_OBJECT_NULL;
    }


    if (iterator != IO_OBJECT_NULL) {
        io_service_t candidate = IOIteratorNext(iterator);
        while (candidate != IO_OBJECT_NULL) {
            CFTypeRef isBuiltIn =
            IORegistryEntryCreateCFProperty(candidate,
                                            CFSTR(kIOBuiltin),
                                            kCFAllocatorDefault,
                                            0);
            if (isBuiltIn != NULL && CFGetTypeID(isBuiltIn) == CFBooleanGetTypeID()) {
                if (wantBuiltIn == CFBooleanGetValue(isBuiltIn)) {
                    service = candidate;
                    break;
                }
            }


            IOObjectRelease(candidate);
            candidate = IOIteratorNext(iterator);
        }
        IOObjectRelease(iterator);
    }


    return service;
}


CFDataRef copy_mac_address() {
    CFDataRef macAddress = NULL;
    io_service_t service = io_service("en0", true);


    if (service == IO_OBJECT_NULL) {
        service = io_service("en1", true);
    }


    if (service == IO_OBJECT_NULL) {
        service = io_service("en0", false);
    }


    if (service != IO_OBJECT_NULL) {
        CFTypeRef property =
        IORegistryEntrySearchCFProperty(service,
                                        kIOServicePlane,
                                        CFSTR(kIOMACAddress),
                                        kCFAllocatorDefault,
                                        kIORegistryIterateRecursively | kIORegistryIterateParents);
        if (property != NULL) {
            if (CFGetTypeID(property) == CFDataGetTypeID()) {
                macAddress = property;
            }
            else {
                CFRelease(property);
            }
        }


        IOObjectRelease(service);
    }


    return macAddress;
}
```

## Respond to validation failures - 回应验证失败

If your app receipt validation fails, respond to that failure as follows:

- Don’t try to terminate the app. Without a validated receipt, assume the user doesn’t have access to premium content. Provide a user interface to gracefully handle this case and inform the user what they can do to get full access to your app’s features.
- If the app receipt is missing or corrupt, use the [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) object to refresh the app receipt.
- In the sandbox environment, if the app receipt is missing, assume the tester is a new customer and doesn’t have access to premium content.

如果您的应用程序收据验证失败，请按照以下方式回应该失败：

- 不要尝试终止应用程序。在没有通过验证的收据的情况下，应该让用户无法访问高级内容。提供用户界面以优雅地处理此情况，并告知用户可以采取什么措施来完全访问您的应用程序功能。
- 如果应用程序收据丢失或损坏，请使用 [SKReceiptRefreshRequest](https://developer.apple.com/documentation/storekit/skreceiptrefreshrequest) 对象刷新应用程序收据。
- 在沙盒环境中，如果应用程序收据丢失，应该把测试人员作为新用户，并且无法访问高级内容。

> **Note** **注意**
>
> For apps in iOS and iPadOS running in the sandbox environment and in StoreKit testing in Xcode, the app receipt is present only after the tester makes their first in-app purchase. The app receipt is always present in TestFlight on devices running macOS.
> 
> 对于在沙盒环境中运行的 iOS 和 iPadOS 中的应用程序以及在 Xcode 中进行的 StoreKit 测试，只有在测试人员进行第一次应用内购买后，应用程序收据才存在。在运行 macOS 的设备上的 TestFlight 中，应用程序收据始终存在。








