# UILocalizedIndexedCollation ---- sectionForObject:collationStringSelector:

原文地址：
[https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620378-sectionforobject?language=objc](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620378-sectionforobject?language=objc)

Returns an integer identifying the section in which a model object belongs.

返回一个整数用于标识模型对象所属的节。

## Declaration

```
- (NSInteger)sectionForObject:(id)object 
      collationStringSelector:(SEL)selector;
```

## Parameters

### object

A model object of the application that is part of the data model for the table view.

应用的模型对象，是列表视图的数据模型的一部分。

### selector

A selector that identifies a method returning an identifying string for object that is used in collation. The method should take no arguments and return an [NSString](https://developer.apple.com/documentation/foundation/nsstring?language=objc) object. For example, this could be a name property on the object.

标识方法的选择器，返回在整理对象时使用的标识字符串。这个方法应该没有参数并返回一个 [NSString](https://developer.apple.com/documentation/foundation/nsstring?language=objc) 对象。例如，可以是对象的名称属性。

## Return Value

An integer that identifies the section in which the model object belongs. The numbers returned indicate a sequential ordering.

标识模型对象所属的节的整数。返回的数字表示排序。

## Discussion

The table-view controller should iterate through all model objects for the table view and call this method for each object. If the application provides a `Localizable.strings` file for the current language preference, the indexed-collation object localizes each string returned by the method identified by `selector`. It uses this localized name when collating titles. The controller should use the returned integer to identify a local “section” array in which it should insert object.

列表视图的控制器应该遍历它的所有模型对象，并为每个对象调用该方法。如果应用程序为当前语言偏好提供了`Localizable.strings`文件，已索引的整理对象会本地化由`selector`指定的方法返回的每一个字符串。它在整理标题时也使用本地化的名称。控制器应该使用返回的整数确定应该在本地“节”数组的哪里插入对象。

# See Also

## Preparing the Sections and Section Indexes 准备节和节索引

### [- sortedArrayFromArray:collationStringSelector:](https://developer.apple.com/documentation/uikit/uilocalizedindexedcollation/1620382-sortedarrayfromarray?language=objc)

Sorts the objects within a section by their localized titles.

使用本地化的标题排序一个节中的对象。