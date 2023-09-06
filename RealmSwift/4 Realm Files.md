# Work with Realm Files - 使用 Realm 文件

原文地址：[https://www.mongodb.com/docs/realm/sdk/swift/realm-files/](https://www.mongodb.com/docs/realm/sdk/swift/realm-files/)

A realm is the core data structure used to organize data in Realm. A realm is a collection of the objects that you use in your application, called Realm objects, as well as additional metadata that describe the objects. To learn how to define a Realm object, see _Define an Object Model_.

Realm 是用于组织 Realm 中的数据的核心数据结构。Realm 是您在应用程序中使用的对象的集合，称为 Realm 对象，以及描述这些对象的附加元数据。要了解如何定义 Realm 对象，请参阅《定义对象模型》。

## Realm Files - Realm 文件

Realm stores a binary encoded version of every object and type in a realm in a single .realm file. The file is located at a specific path that you can define when you open the realm. You can open, view, and edit the contents of these files with Realm Studio.

Realm 将领域中每个对象和类型的二进制编码版本存储在一个单独的 .realm 文件中。文件位于打开 realm 时定义的特定路径上。您可以使用 Realm Studio 打开、查看和编辑这些文件的内容。