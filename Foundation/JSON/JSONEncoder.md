# JSONEncoder


An object that encodes instances of a data type as JSON objects.

一个将数据类型的实例编码为 JSON 对象的对象。

原文地址：[https://developer.apple.com/documentation/foundation/jsonencoder](https://developer.apple.com/documentation/foundation/jsonencoder)

> iOS 8.0+
iPadOS 8.0+
Mac Catalyst 8.0+
macOS 10.10+
tvOS 9.0+
visionOS 1.0+
watchOS 2.0+

```
class JSONEncoder
```

# Mentioned in 在以下内容中提及

- [Uploading data to a website](https://developer.apple.com/documentation/foundation/uploading-data-to-a-website)

	《[向网站上传数据](https://developer.apple.com/documentation/foundation/uploading-data-to-a-website)》

- [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/encoding-and-decoding-custom-types)

	《[自定义类型的编码与解码](https://developer.apple.com/documentation/foundation/encoding-and-decoding-custom-types)》
	
# Overview 概览

The example below shows how to encode an instance of a simple `GroceryProduct` type from a JSON object. The type adopts [Codable](https://developer.apple.com/documentation/Swift/Codable) so that it’s encodable as JSON using a JSONEncoder instance.

下面的示例展示了如何将一个简单的 `GroceryProduct` 类型的实例从 JSON 对象进行编码。该类型遵循 [Codable](https://developer.apple.com/documentation/Swift/Codable) 协议，因此可以使用 JSONEncoder 实例将其编码为 JSON 格式。

```
struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var description: String?
}


let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear.")


let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted


let data = try encoder.encode(pear)
print(String(data: data, encoding: .utf8)!)


/* Prints:
 {
   "name" : "Pear",
   "points" : 250,
   "description" : "A ripe pear."
 }
*/
```

# Topics 主题

## First Steps 第一步

### init()

Creates a new, reusable JSON encoder with the default formatting settings and encoding strategies.
	
创建一个新的、可重用的 JSON 编码器，使用默认的格式设置和编码策略。
	
### func encode<T>(T) throws -> Data

Returns a JSON-encoded representation of the value you supply.
	
返回你提供的值的 JSON 编码表示形式。
	
## Customizing Encoding 自定义编码

### var outputFormatting: JSONEncoder.OutputFormatting

A value that determines the readability, size, and element order of the encoded JSON object.

一个值，用于确定编码后的 JSON 对象的可读性、大小和元素顺序。

### struct OutputFormatting

The output formatting options that determine the readability, size, and element order of an encoded JSON object.

输出格式选项，用于确定编码后的 JSON 对象的可读性、大小和元素顺序。

### var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy

A value that determines how to encode a type’s coding keys as JSON keys.

一个值，用于确定如何将一个类型的编码键（coding keys）编码为 JSON 键。

enum KeyEncodingStrategy
The values that determine how to encode a type’s coding keys as JSON keys.
var userInfo: [CodingUserInfoKey : any Sendable]
A dictionary you use to customize the encoding process by providing contextual information.
Encoding Dates
var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy
The strategy used when encoding dates as part of a JSON object.
enum DateEncodingStrategy
The formatting strategies available for formatting dates when encoding a date as JSON.
Encoding Raw Data
var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy
The strategy that an encoder uses to encode raw data.
enum DataEncodingStrategy
The strategies for encoding raw data.
Encoding Exceptional Numbers
var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy
The strategy used by an encoder when it encounters exceptional floating-point values.
enum NonConformingFloatEncodingStrategy
The strategies for encoding nonconforming floating-point numbers, also known as IEEE 754 exceptional values.
Instance Methods
func encode<T, C>(T, configuration: C.Type) throws -> Data
func encode<T>(T, configuration: T.EncodingConfiguration) throws -> Data
Relationships
Conforms To
Copyable
NetworkEncoder
Sendable
SendableMetatype
TopLevelEncoder
See Also
JSON
class JSONDecoder
An object that decodes instances of a data type from JSON objects.
class JSONSerialization
An object that converts between JSON and the equivalent Foundation objects.