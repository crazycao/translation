# Advanced Memory Management Programming Guide

高级内存管理编程指南

原文链接：[https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/MemoryMgmt.html#//apple_ref/doc/uid/10000011-SW1](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/MemoryMgmt.html#//apple_ref/doc/uid/10000011-SW1)

# 1. About Memory Management 关于内存管理

Application memory management is the process of allocating memory during your program’s runtime, using it, and freeing it when you are done with it. A well-written program uses as little memory as possible. In Objective-C, it can also be seen as a way of distributing ownership of limited memory resources among many pieces of data and code. When you have finished working through this guide, you will have the knowledge you need to manage your application’s memory by explicitly managing the life cycle of objects and freeing them when they are no longer needed.

应用程序的内存管理是指，在程序运行时分配内存、使用内存、和使用后释放内存的过程。一个编写良好的程序会尽可能少使用内存。在Objective-C中,它还可以被看成在许多块数据和代码分配有限内存资源的所有权的途径。当你已经通过本指南完成了工作，你将拥有管理应用程序的内存所需的知识，可以精确的管理对象的生命周期并在不需要的时候释放它们。

Although memory management is typically considered at the level of an individual object, your goal is actually to manage object graphs. You want to make sure that you have no more objects in memory than you actually need.

尽管内存管理通常被认为是在单个对象级别的行为，但你的目标实际上是管理整个对象图。你要确保内存中不会有比你实际需要更多的对象。

![Figure 0-1](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/MemoryMgmt/Art/memory_management_2x.png)

## 1.1 At a Glance概述
Objective-C提供了两种应用程序内存管理方法。

1. “手动保留释放（manual retain-release）”，或称MRR。你可以通过追踪你拥有的对象显式的管理内存。该方法通过使用一个被称为引用计数的模型来实现，基础类conjunction结合运行时环境提供了这个模型。
2. “自动引用计数（Automatic Reference Counting）”，或称ARC。系统使用了与MRR相同的引用计数系统，但是在编译时插入了适当的内存管理方法调用。强烈建议在新工程中使用ARC。如果使用ARC，通常都不需要了解本文所描述的底层实现，尽管这些知识在某些情况下是有益的。关于ARC的更多知识，请参考《[Transitioning to ARC Release Notes](https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226)》。
1.2 Good Practices Prevent Memory-Related Problems良好的实践可以避免内存相关问题
不正确的内存管理将导致两类主要的问题：
	释放或重写仍在使用的数据
这将导致内存损坏，通常在程序中的结果就是崩溃，或者更糟的是损坏用户数据。
	没有释放不再使用的数据导致内存泄露
内存泄露是指已经申请的内存即使永不再使用也没有释放。泄露会导致应用使用的内存数量持续增加，从而导致系统性能变差或者应用程序被终止。
从引用计数的角度思考内存管理，往往适得其反，因为人们趋向于在实现细节方面考虑内存管理而不是实际目的。与之相反的，你应该从对象所有权和对象图的角度去思考内存管理。
当你通过一个方法拥有了一个对象时，Cocoa会使用直接了当的命名规则来指出。
请参考 Memory Management Policy.
尽管基础策略已经直接说了，但你还可以采用一些实践步骤使得管理内存更加简单，并且有助于确保你的程序更加可靠和健壮，同时最小化其资源需求。
请参考 Practical Memory Management.
自动释放池block提供了一种机制，在这个机制里你可以向一个对象发送“延迟”释放消息。当你想要放弃一个对象的所有权但又不想立即释放它的时候（例如在一个方法中返回一个对象），这非常有用。有很多场合你可能会使用到自动释放池block。
请参考 Using Autorelease Pool Blocks.
1.3 Use Analysis Tools to Debug Memory Problems使用分析工具处理内存问题
想要在编译时定位代码中的问题，你可以使用Xcode中集成的Clang静态分析器。
如果内存管理问题仍然出现，还可以使用其他的工具和技术定位和诊断问题。
在Technical Note TN2239, iOS Debugging Magic一章中介绍了许多工具盒技术，尤其是NSZombie的使用可以帮助找到过度释放的对象。
你可以使用Instruments跟踪引用计数事件并查看内存泄露。参考Collecting Data on Your App。
2. Memory Management Policy 内存管理策略
在引用计数环境中用于内存管理的基础模型，由定义在NSObject协议（注2）中的方法和标准方法命名规范相结合而来。NSObject类也定义了dealloc方法，当对象被销毁的时候该方法会自动调用。本文介绍了在Cocoa编程中正确的管理内存需要知道的所有基础规则，并提供了一些正确使用的例子。
2.1 Base Memory Management Rules 基础内存管理规则
内存管理模型的基础是对象的所有权。每个对象可能有一个或多个所有者。只要一个对象有了至少一个所有者，它就继续存在。如果一个对象没有任何所有者，运行时系统会自动销毁它。为了确保我们清楚什么时候拥有了一个对象而什么时候又没有，Cocoa设定了以下规则：
	你拥有你创建的任何对象
你可以使用以“alloc”、“new”、“copy”或者“mutableCopy”开头的方法创建对象。（例如alloc，newObject或mutableCopy）
	你可以使用retain获得一个对象的所有权。
返回对象通常保证在收到的方法里仍然有效，并且该方法也可以安全的返回给它的调用者。在下面两种情况下你需要使用retain：
（1）	在accessor方法或init方法的实现中，获取你想要存为属性值的对象的所有权；
（2）放置一个对象由于某些其他操作的副作用被置为无效的（在Avoid Causing Deallocation of Objects You’re Using中会详细解释）
	当你不再需要一个你拥有的对象时，你必须放弃其所有权
通过向一个对象发送release或autorelease消息可以放弃对它的所有权。因此，在Cocoa术语中，放弃一个对象的所有权通常也被称为“释放”一个对象。
	你不能放弃不是你拥有的对象的所有权
这只是前一条规则的推论，只是明确的指出来。
2.1.1 A Simple Example 一个简单的例子
为了阐明这些策略，请看以下代码片段：
{
    Person *aPerson = [[Person alloc] init];
    // ...
    NSString *name = aPerson.fullName;
    // ...
    [aPerson release];
}
Person对象是使用alloc方法创建的，所以随后不再需要它时向它发送了release消息。Person的name取得时没有被任何所有权方法，所以不用向它发送release消息。注意，本例中使用的是release而不是autorelease。
2.1.2 Use autorelease to Send a Deferred by Reference 使用自动释放发出延迟释放请求
当你需要发送一个延迟release消息时你可以使用autorelease——通常是在从方法中返回一个对象的时候。例如，你可以像这样实现fullName方法：
- (NSString *)fullName {
    NSString *string = [[[NSString alloc] initWithFormat:@"%@ %@",
                                          self.firstName, self.lastName] autorelease];
    return string;
}
你拥有了通过alloc返回的string。为了遵守内存管理规则，你必须在你失去对它的引用之前放弃对它的所有权。如果你使用release，这个string就会在返回之前被销毁（这个方法也会返回一个无效的对象）。使用autorelease，你既表示了将要放弃所有权，又允许方法的调用者在返回的string被销毁前使用它。
你也可以像这样实现fullName方法：
- (NSString *)fullName {
    NSString *string = [NSString stringWithFormat:@"%@ %@",
                                 self.firstName, self.lastName];
    return string;
}
按照基本规则，你不会拥有stringWithFormat:方法返回的string对象，所以你也可以安全的从该方法中返回string。
作为对照，下面的实现方式是错误的：
- (NSString *)fullName {
    NSString *string = [[NSString alloc] initWithFormat:@"%@ %@",
                                         self.firstName, self.lastName];
    return string;
}
根据命名规则，没有任何地方说明了fullName方法的调用者拥有返回的string。因此调用者没有任何理由释放返回的string，这样它将被泄露。
2.1.3 You Don’t Own Objects Returned by Reference 你不会通过引用持有返回的对象
Cocoa中的某些方法指明了对象是通过引用返回的（比如，参数类型是ClassName **或id *的方法）。常见的模式是在发生错误时使用一个包含了错误信息的NSError对象，例如initWithContentsOfURL:options:error: (NSData)方法和initWithContentsOfFile:encoding:error: (NSString)方法。
在这些情况下，前面介绍的规则同样适用。当你调用任何这样的方法，你没有创建NSError对象，所以你不拥有它。因此你不需要释放它。如下面的例子所示：
NSString *fileName = <#Get a file name#>;
NSError *error;
NSString *string = [[NSString alloc] initWithContentsOfFile:filename
                        encoding:NSUTF8StringEncoding error:&error];
if (string == nil) {
    // Deal with error...
}
// ...
[string release];
2.2 Implement dealloc to Relinquish Ownership of Objects 实现dealloc方法以放弃对象的所有权
NSObject类定义了一个方法，dealloc，当对象没有拥有者并且其内存被回收时会自动调用——在Cocoa术语中称为它被“释放”或“销毁”。Dealloc方法的角色是释放对象自己的内存，并且清除它持有的所有资源，包括所有对象实例变量的所有权。
下面的例子展示了应该如何实现Person类的dealloc方法：
@interface Person : NSObject
@property (retain) NSString *firstName;
@property (retain) NSString *lastName;
@property (assign, readonly) NSString *fullName;
@end
 
@implementation Person
// ...
- (void)dealloc
    [_firstName release];
    [_lastName release];
    [super dealloc];
}
@end
注意：
永远不要直接调用另一个对象的dealloc方法。
你必须在你的实现末尾调用父类的实现。
你不应该将系统资源的管理与对象生命周期绑在一起；参考Don’t Use dealloc to Manage Scarce Resources。
当应用被终止时，对象可能不会收到dealloc消息。因为进程的内存在退出时自动清理了，允许操作系统清理资源比调用所有的内存管理方法更加高效。
2.3 Core Foundation Uses Similar but Different Rules 使用Core Foundation中类似但不同的规则
Core Foundation对象有一些类似的内存管理规则（参考Memory Management Programming Guide for Core Foundation）。但是Cocoa与Core Foundation的命名规范是不同的。特别是Core Foundation的创建规则（参考The Create Rule），它不接受返回返回Objective-C对象的方法。例如，在下面的代码片段中，你并不负责放弃myInstance的所有权：
MyClass *myInstance = [MyClass createInstance];
3. Practical Memory Management 实践内存管理
尽管Memory Management Policy中直接介绍了基本的概念，但你还可以采用一些实践步骤使得管理内存更加简单，并且有助于确保你的程序更加可靠和健壮，同时最小化其资源需求。
3.1 Use Accessor Methods to Make Memory Management Easier 使用Accessor方法让内存管理更容易
如果你的类有一个属性是对象，你就必须确保设置成它的值的任何对象在你使用时没有被销毁。因此在设置时你必须声明该对象的所有权。你也必须确保你最后放弃了所有当前持有的值的所有权。
尽管有时显得多余或者过于迂腐，但是如果你坚持使用accessor方法，你遇到内存管理问题的机会将会大大减少。如果你整个代码自始至终都在使用retain和release处理实例变量，那你几乎肯定做了错误的事情。
考虑有一个计数器对象，你可以设置其计数。
@interface Counter : NSObject
@property (nonatomic, retain) NSNumber *count;
@end;
该属性（注3）声明了两个accessor方法。通常，都是编译器合成这两个方法；不过，看看它是如何实现的会非常有益。
在“get”方法中，只是返回了合成实例变量，所以不需要retain或release：
- (NSNumber *)count {
    return _count;
}
在“set”方法中，如果其他人按照相同的规则操作，你就不得不考虑新的count对象可能在任何时候被清理，所以你不得不获取该对象的所有权——通过向其发送retain消息——以确保其不被清理。你也必须在这里放弃旧的count对象的所有权，需要向它发送一个release消息。（在Objective-C中允许向nil发送消息，所以该实现在_count从未设置时也仍然可以工作。）你必须在[newCount retain]之后发送这个release消息，如果这两个count是同一个对象——你一定不希望无意中将它销毁吧。
- (void)setCount:(NSNumber *)newCount {
    [newCount retain];
    [_count release];
    // Make the new assignment.
    _count = newCount;
}
3.1.1 Use Accessor Methods to Set Property Values 使用Accessor方法设置属性值
假如你想要实现一个方法重置计数器。你有两种选择。第一种实现方法用alloc创建了一个NSNumber实例，因此你需要相应的用release取得平衡。
- (void)reset {
    NSNumber *zero = [[NSNumber alloc] initWithInteger:0];
    [self setCount:zero];
    [zero release];
}
第二种实现方法使用了一个便捷构造器创建新的NSNumber对象。因此不需要retain或者release消息。
- (void)reset {
    NSNumber *zero = [NSNumber numberWithInteger:0];
    [self setCount:zero];
}
注意上述两种方法都使用了set accessor方法。
接下来的方法在简单的情况下几乎肯定是正确执行的，但是尽管避开accessor方法是多么诱人，这么做在某些场景几乎肯定会导致错误（例如，当你忘记retain或者release时，或者如果这个实例变量的内存管理语义发生变化）。
- (void)reset {
    NSNumber *zero = [[NSNumber alloc] initWithInteger:0];
    [_count release];
    _count = zero;
}
也要注意如果你使用键值观察，采用这种方法改动变量是不符合KVO的。
3.1.2 Don’t Use Accessor Methods in Initializer and dealloc 不要在初始化方法和dealloc方法中使用Accessor方法
唯一一个不应该使用accessor方法设置实例变量的地方是初始化方法和dealloc方法中。要初始化一个表示0的number的计数器对象，你应该像这样实现init方法：
- init {
    self = [super init];
    if (self) {
        _count = [[NSNumber alloc] initWithInteger:0];
    }
    return self;
}
要允许计数器被另一个数字而不是0来初始化，你应该实现initWithCount:方法如下：
- initWithCount:(NSNumber *)startingCount {
    self = [super init];
    if (self) {
        _count = [startingCount copy];
    }
    return self;
}
因为Counter类有一个对象实例变量，你也必须实现dealloc方法。需要向所有实例变量的发送release消息放弃它们的所有权，最后需要调用父类的实现：
- (void)dealloc {
    [_count release];
    [super dealloc];
}
3.2 Use Weak References to Avoid Retain Cycles 使用弱引用避免循环持有
Retain一个对象创建了一个对该对象的强引用。对象只有在它的所有强引用都被释放时才会被销毁。有这样一个问题，被称为循环持有，如果两个对象循环引用就会发生——也就是说他们互相发生强引用（直接互相引用，或者通过其他对象组成一个链条，每一个强引用下一个，最后一个引用第一个）。
图1展示了一个永久循环持有的对象关系。Document对象有一个Page对象表示文章里的每一页。每一个Page对象又有一个属性跟踪是在哪个文章里。如果Document对象强引用了Page对象，而Page对象也强引用了Document对象，两个对象都永远不会被销毁。Document对象的引用计数不会变成0除非Page对象被释放，而Page对象不会释放除非Document对象被销毁。
Figure 1  An illustration of cyclical references
 
循环持有问题的解决办法就是使用弱引用。弱引用是一种非拥有的关系，在这种关系里源对象不持有被引用对象。
为了保持对象图完成，我们必须在某些地方使用强引用（如果这些地方只有弱引用，Page和Paragraph可能没有任何所有者而被销毁）。因此，Cocoa建立了一个约定，“父对象”应该强引用持有其“子对象”，而“子对象”只能弱引用它们的“父对象”。
所以，在图1中，Document对象强引用（持有）它的Page对象，但是Page对象只是弱引用（不持有）Document对象。
在Cocoa中弱引用的例子很多，包括但不限于table数据源、离线视图项目、通知观察者以及各种各样的target和delegate。
需要小心的向你仅仅是弱引用的对象发消息。如果你在一个对向被销毁后向它发送消息，你的应用将会崩溃。当对象可用时，你必须有明确定义的先决条件。在大多数情况下，被弱引用的对象知道其它对象弱引用了它，正如循环引用的例子中那样，它就有责任在它被销毁时通知其它对象。例如，当你在通知中心注册一个对象，通知中心就保存了一个该对象的弱引用，并且会在适当的通知发出时向它发消息。当这个对象被销毁时，你需要在通知中心进行反注册，以避免通知中心以后再向它发送任何消息，它已经不存在了。同样的，当delegate对象被释放时，你需要移除代理连接，想其它对象发送一个setDelegate:消息并附带nil参数。这些消息通常都在对象的dealloc方法中发出。
3.3 Avoid Causing Deallocation of Objects You’re Using 避免你正在使用的对象被释放
Cocoa的所有权策略指定接收到的对象应该在贯穿整个调用方法的范围内都是有效的。应该也可以从当前的作用域中返回一个接收到的对象，而不用担心它被释放。对于应用程序来说，对象的getter方法返回缓存的实例变量或者返回计算的值都没有关系。重要的是在你需要它们的时候，它们仍然是有效的。
对于这条规则来说，会出现偶然的异常情况，主要是下面两种情形之一：
1.	当对象从一个基础集合类中移除的时候。
heisenObject = [array objectAtIndex:n];
[array removeObjectAtIndex:n];
// heisenObject could now be invalid.
当对象从一个基础集合类中移除的时候，它会收到一个release消息（而不是autorelease消息）。如果这个集合是被移除对象的唯一所有者，被移除对象（例子中的heisenObject）就会立即被销毁。
2.	当“父对象”被销毁时。
id parent = <#create a parent object#>;
// ...
heisenObject = [parent child] ;
[parent release]; // Or, for example: self.parent = nil;
// heisenObject could now be invalid.
在某些情况下，你会从另一个对象取回一个对象，然后又直接或间接的释放了父对象。如果释放父对象导致父对象被销毁，而这个父对象又是这个子对象的唯一的所有者，那么这个子对象（例子中的heisenObject）就会同时被销毁（就好像在父对象的dealloc方法中向子对象发送了一个release消息而不是autorelease消息）。
为了避免这些情况，你应该在拿到heisenObject时就retain它，然后在用完以后release它。例如：
heisenObject = [[array objectAtIndex:n] retain];
[array removeObjectAtIndex:n];
// Use heisenObject...
[heisenObject release];
3.4 Don’t Use dealloc to Manage Scarce Resources 不要使用dealloc方法管理稀有资源
通常，不应该再dealloc方法中管理稀有资源，例如文件描述符、网络连接、缓冲区或者缓存。特别要注意，dealloc方法不会在你想要调用它时它就会被调用，不应该这样设计一个类。Dealloc的调用可能被延迟或者回避，可能是因为bug，也可能是因为应用被关闭。
相反，你如果有一个管理稀有资源的类，你应该将你的应用设计成你知道你什么时候不再使用这些资源了，然后告知这个类的实例在那个时候就“清理”掉。通常是释放掉实例，接着就会调用dealloc方法，但是这样做的话，即使dealloc方法没有被调用也不会出现另外的问题。
如果你试图在dealloc顶部背负起资源管理，那问题可能会增加。例如：
1.	对象图关闭的顺序依赖。
对象图关闭机制本质上是无序的。尽管你通常期望——并得到了——一个特殊的顺序，但你需要知道这个排序的脆弱性。如果一个对象出乎意料的自动释放而不是直接释放，那关闭顺序也可能改变，这就可能导致预料之外的结果了。
2.	未回收稀有资源
内存泄露通常不是立即致命的，但这类bug也应该被修正。如果稀有资源在你希望它们释放的时候没有被释放，你可能会走入更严重的问题中。例如，如果应用程序在文件描述符之外运行，用户可能无法保存数据。
3.	清理逻辑在错误的线程执行。
如果对象在意外的时间自动释放，它可能在任何线程的自动释放池block里被销毁。这对于只能在一个线程中接触的资源是极易致命的。
3.5 Collections Own the Objects They Contain 集合会拥有它们包含的对象
当把对象添加到集合（例如Array、Dictionary或Set）中，集合就获得了它的所有权。当对象从集合中移除或者集合自己被释放时，集合都会放弃所有权。那么，举个例子说，如果你想要创建一个数字对象的数组，你可能像下面其中一种这样做：
NSMutableArray *array = <#Get a mutable array#>;
NSUInteger i;
// ...
for (i = 0; i < 10; i++) {
    NSNumber *convenienceNumber = [NSNumber numberWithInteger:i];
    [array addObject:convenienceNumber];
}
在这个案例中，你没有调用alloc，所以不需要调用release。不要要持有新的数字对象（convenienceNumber），因为数组持有了它们。
NSMutableArray *array = <#Get a mutable array#>;
NSUInteger i;
// ...
for (i = 0; i < 10; i++) {
    NSNumber *allocedNumber = [[NSNumber alloc] initWithInteger:i];
    [array addObject:allocedNumber];
    [allocedNumber release];
}
在这个案例中，你需要在for循环的作用域内向allocedNumber发送release消息以平衡alloc。因为数字在被addObject:方法添加到数组时被数组持有，所以当它在数组中时不会被销毁。
要理解这些，请将自己放在集合类的实现者的位置。你想要确保没有任何交给你照看的对象在你的面前消失，因此你需要在它们传过来时就向它们发一个retain消息。如果它们被移除，你需要相应的发一个release消息；而且在你调用自己的dealloc方法时，要给所有还在的对象都发一个release消息。
3.6 Ownership Policy Is Implemented Using Retain Counts 通过引用计数实现所有权策略
所有权策略通过引用计数来实现——引用计数通常在retain方法后被称为“retain count”。每一个对象有一个retain count。
	当创建一个对象时，它的retain count就是1。
	当向一个对象发送retain消息，它的retain count加1。
	当向一个对象发送release消息，它的retain count减1。
当向一个对象发送autorelease消息，它的retain count在当前自动释放池block的末尾减1。
	如果对象的retain count被减为0，它就会被销毁。
注意：没必要明确的向对象查询它的retain count是多少（参考retainCount）。这样做的结果通常会令人误入歧途，因为你可能不知道哪个框架对象持有了你关注的对象。在调试内存管理问题时，你关注的应该只是确保你的代码符合所有权规则。
4. Using Autorelease Pool Blocks 使用自动释放池block
自动释放池block提供了一种机制，在这种机制例你可以放弃一个对象的所有权而避免它立即被销毁的可能性（例如当你从一个方法返回一个对象时）。通常你不需要创建你自己的自动释放池block，但是在某些情况下你必须这么做或者最好这么做。
4.1 About Autorelease Pool Blocks 关于自动释放池block
自动释放池使用@autoreleasepool标记，如下面的例子所阐述的：
@autoreleasepool {
    // Code that creates autoreleased objects.
}
在自动释放池block的末尾，向block里接收了autorelease消息的对象发送了一条release消息——在block里的对象每被发送一次autolease消息此时就会接到一次release消息。
就像所有其他的代码block一样，自动释放池block也可以嵌套：
@autoreleasepool {
    // . . .
    @autoreleasepool {
        // . . .
    }
    . . .
}
（你可能不常看到代码恰好像上面那样；常见的是一个源文件中的自动释放池block中的代码调用另一个源文件中的自动释放池中的代码。）对于一个给定的autorelease消息，相应的release消息在autorelease消息被发送的自动释放池block的末尾被发送。
Cocoa总是希望代码在自动释放池block中执行，否则自动释放的对象不会被释放，应用就会泄露内存。（如果你在自动释放池block之外发送一个autorelease消息，Cocoa会将其作为一个错误消息记入日志。）AppKit和UIKit框架都在自动释放池block中处理每一个事件循环迭代（比如鼠标点击事件或触碰事件）。因此你通常不需要自己创建自动释放池block，甚至看不到用于创建的代码。然而，有三个场合你可能要使用自己的自动释放池block：
	如果你正在写的程序不是基于UI框架的，例如写一个命令行工具。
	如果你正在写一个创建了大量临时对象的循环。
你可以在循环里使用自动释放池block，以便在下一个迭代之前处理这些对象。在循环中使用自动释放池block有助于降低应用程序的最大内存占用。
	如果你大量创建第二线程。
你必须在线程执行的开始就创建你自己的自动释放池；否则，应用程序将会泄露对象。（详情参考Autorelease Pool Blocks and Threads）
4.2 Use Local Autorelease Pool Blocks to Reduce Peak Memory Footprint 使用本地自动释放池block减少内存占用峰值
许多程序都会创建要自动释放的临时对象。这些对象会加入到程序的内存占用直到block的结尾。在多数情况下，允许临时对象积累到当前事件循环迭代的末尾不会导致过多的开销；然而，在某些情况下，你可能会创建大量的临时对象，它们实际上已添加到内存占用，而你又想更快速的清理它们。在后一种情况，你可以创建自己的自动释放池block。在block的末尾，临时对象就被释放了，这通常结果就是销毁，因此减少了程序的内存占用。
接下来的例子展示了应该如何在一个for循环中使用自动释放池block。
NSArray *urls = <# An array of file URLs #>;
for (NSURL *url in urls) {

    @autoreleasepool {
        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfURL:url
                                         encoding:NSUTF8StringEncoding error:&error];
        /* Process the string, creating and autoreleasing more objects. */
    }
}
这个for循环一次处理一个文件。每一个在自动释放池block中被发送了autorelease消息的对象会在block的末尾被释放。
在自动释放池block之后，你应该注意到在block中自动释放的对象已经被“清理”了。不要再向这些对象发消息或者将它们返回给你的方法的调用者。如果你必须要在自动释放池block之外使用临时对象，你可以在block中向该对象发送一条retain消息，然后在block之后向它发送一条autorelease消息，如下面例子所示：
– (id)findMatchingObject:(id)anObject {

    id match;
    while (match == nil) {
        @autoreleasepool {

            /* Do a search that creates a lot of temporary objects. */
            match = [self expensiveSearchForObject:anObject];

            if (match != nil) {
                [match retain]; /* Keep match around. */
            }
        }
    }

    return [match autorelease];   /* Let match go and return it. */
}
在自动释放池block里面向match发送retain，然后再自动释放池block之后向match发送autorelease以延长其生命周期，允许它在循环之外接收消息，并将它返回给findMatchingObject:方法的调用者。
4.3 自动释放池block与线程
Cocoa应用的每一个线程都维护了自己的自动释放池栈。如果你正在写一个只有Foundation的程序或者分离一个线程，你需要创建自己的自动释放池block。
如果你的应用或线程长期潜在的生成大量自动释放的对象，你应该使用自动释放池block（像AppKit和UIKit在主线程做的一样）；否则，自动释放的对象会积累起来，内存占用也会增长。如果你分离出的线程没有调用Cocoa方法，那你不需使用自动释放池block。
注意：如果你使用POSIX线程API而不是NSThread创建辅助线程，你将不能使用Cocoa，除非Cocoa处在多线程模式。Cocoa只有在分离出第一个NSThread对象才会进入多线程模式。想要在辅助的POSIX线程中使用Cocoa，你的应用必须首先分离至少一个NSThread对象，可以在NSThread线程创建之后立即退出。你可以使用NSThread类的isMultiThreaded方法测试Cocoa是否在多线程模式。

5. Document Revision History文档修订历史
下表描述了本文的变化。
Date	Notes
2012-07-17	Updated to describe autorelease in terms of @autoreleasepool blocks.
2011-09-28	Updated to reflect new status as a consequence of the introduction of ARC.
2011-03-24	Major revision for clarity and conciseness.
2010-12-21	Clarified the naming rule for mutable copy.
2010-06-24	Minor rewording to memory management fundamental rule, to emphasize simplicity. Minor additions to Practical Memory Management.
2010-02-24	Updated the description of handling memory warnings for iOS 3.0; partially rewrote "Object Ownership and Disposal."
2009-10-21	Augmented section on accessor methods in Practical Memory Management.
2009-08-18	Added links to related concepts.
2009-07-23	Updated guidance for declaring outlets on OS X.
2009-05-06	Corrected typographical errors.
2009-03-04	Corrected typographical errors.
2009-02-04	Updated "Nib Objects" article.
2008-11-19	Added section on use of autorelease pools in a garbage collected environment.
2008-10-15	Corrected missing image.
2008-02-08	Corrected a broken link to the "Carbon-Cocoa Integration Guide."
2007-12-11	Corrected typographical errors.
2007-10-31	Updated for OS X v10.5. Corrected minor typographical errors.
2007-06-06	Corrected minor typographical errors.
2007-05-03	Corrected typographical errors.
2007-01-08	Added article on memory management of nib files.
2006-06-28	Added a note about dealloc and application termination.
2006-05-23	Reorganized articles in this document to improve flow; updated "Object Ownership and Disposal."
2006-03-08	Clarified discussion of object ownership and dealloc. Moved discussion of accessor methods to a separate article.
2006-01-10	Corrected typographical errors. Updated title from "Memory Management."
2004-08-31	Changed Related Topics links and updated topic introduction.
2003-06-06	Expanded description of what gets released when an autorelease pool is released to include both explicitly and implicitly autoreleased objects in Using Autorelease Pool Blocks.
2002-11-12	Revision history was added to existing topic. It will be used to record changes to the content of the topic.

