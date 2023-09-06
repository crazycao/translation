# NSCache

原文地址：[https://developer.apple.com/documentation/foundation/nscache](https://developer.apple.com/documentation/foundation/nscache)

A mutable collection you use to temporarily store transient key-value pairs that are subject to eviction when resources are low.

一个可变的集合，用于临时存储暂时的键值对，在资源不足时可能会被删除。

> iOS 4.0+
iPadOS 4.0+
macOS 10.6+
Mac Catalyst 13.1+
tvOS 9.0+
watchOS 2.0+
visionOS 1.0+ Beta


# Overview 概览

Cache objects differ from other mutable collections in a few ways:

缓存对象与其他可变集合有几个不同之处：

- The NSCache class incorporates various auto-eviction policies, which ensure that a cache doesn’t use too much of the system’s memory. If memory is needed by other applications, these policies remove some items from the cache, minimizing its memory footprint.
- NSCache 类集成了各种自动清除策略，确保缓存不会使用系统过多的内存。如果其他应用程序需要内存，这些策略将从缓存中移除一些项，最小化其内存占用。

- You can add, remove, and query items in the cache from different threads without having to lock the cache yourself.
- 您可以在不需要自己给 cache 加锁的情况下，从不同线程中添加、删除和查询缓存中的项。

- Unlike an NSMutableDictionary object, a cache does not copy the key objects that are put into it.
- 与 NSMutableDictionary 对象不同，cache 不会复制放入其中的键对象。

You typically use NSCache objects to temporarily store objects with transient data that are expensive to create. Reusing these objects can provide performance benefits, because their values do not have to be recalculated. However, the objects are not critical to the application and can be discarded if memory is tight. If discarded, their values will have to be recomputed again when needed.

通常使用 NSCache 对象来临时存储具有临时数据而创建代价高昂的对象。重复使用这些对象可以提供性能优势，因为它们的值无需重新计算。然而，这些对象对于应用程序并非关键，如果内存紧张可以被丢弃。如果被丢弃，需要时它们的值将需要重新计算。

Objects that have subcomponents that can be discarded when not being used can adopt the NSDiscardableContent protocol to improve cache eviction behavior. By default, NSDiscardableContent objects in a cache are automatically removed if their content is discarded, although this automatic removal policy can be changed. If an NSDiscardableContent object is put into the cache, the cache calls discardContentIfPossible() on it upon its removal.

具有在未使用时可以丢弃的子组件的对象可以采用 NSDiscardableContent 协议，以改善缓存清除行为。默认情况下，如果 NSCache 中的 NSDiscardableContent 对象的内容被丢弃，它们将自动被移除，尽管可以更改此自动移除策略。如果将 NSDiscardableContent 对象放入缓存中，缓存在移除时会调用其上的 discardContentIfPossible() 方法。

# Topics

## Managing the Name

var name: String
The name of the cache.
Managing Cache Size
var countLimit: Int
The maximum number of objects the cache should hold.
var totalCostLimit: Int
The maximum total cost that the cache can hold before it starts evicting objects.
Managing Discardable Content
var evictsObjectsWithDiscardedContent: Bool
Whether the cache will automatically evict discardable-content objects whose content has been discarded.
protocol NSDiscardableContent
You implement this protocol when a class’s objects have subcomponents that can be discarded when not being used, thereby giving an application a smaller memory footprint.
Managing the Delegate
var delegate: NSCacheDelegate?
The cache’s delegate.
protocol NSCacheDelegate
The delegate of an NSCache object implements this protocol to perform specialized actions when an object is about to be evicted or removed from the cache.
Getting a Cached Value
func object(forKey: KeyType) -> ObjectType?
Returns the value associated with a given key.
Adding and Removing Cached Values
func setObject(ObjectType, forKey: KeyType)
Sets the value of the specified key in the cache.
func setObject(ObjectType, forKey: KeyType, cost: Int)
Sets the value of the specified key in the cache, and associates the key-value pair with the specified cost.
func removeObject(forKey: KeyType)
Removes the value of the specified key in the cache.
func removeAllObjects()
Empties the cache.
