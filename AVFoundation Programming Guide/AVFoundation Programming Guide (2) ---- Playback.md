# AVFoundation Programming Guide 

原文地址：
[https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/TP40010188-CH3-SW1)

# 2 Playback - 播放

To control the playback of assets, you use an `AVPlayer` object. During playback, you can use an `AVPlayerItem` instance to manage the presentation state of an asset as a whole, and an `AVPlayerItemTrack` object to manage the presentation state of an individual track. To display video, you use an `AVPlayerLayer` object.

要控制asset的播放，你可以使用`AVPlayer`对象。在播放过程中，你可以使用`AVPlayerItem`实例管理整个asset的表现状态，并且可以使用`AVPlayerItemTrack`对象管理每个单独轨道的表现状态。要显示视频，你使用`AVPlayerLayer`对象。

## 2.1 Playing Assets - 播放asset

A player is a controller object that you use to manage playback of an asset, for example starting and stopping playback, and seeking to a particular time. You use an instance of `AVPlayer` to play a single asset. You can use an `AVQueuePlayer` object to play a number of items in sequence (`AVQueuePlayer` is a subclass of `AVPlayer`). On OS X you have the option of the using the AVKit framework’s `AVPlayerView` class to play the content back within a view.

A player provides you with information about the state of the playback so, if you need to, you can synchronize your user interface with the player’s state. You typically direct the output of a player to a specialized Core Animation layer (an instance of `AVPlayerLayer` or `AVSynchronizedLayer`). To learn more about layers, see *Core Animation Programming Guide*.

>**Multiple player layers:** You can create many `AVPlayerLayer` objects from a single `AVPlayer` instance, but only the most recently created such layer will display any video content onscreen.

Although ultimately you want to play an asset, you don’t provide assets directly to an `AVPlayer` object. Instead, you provide an instance of `AVPlayerItem`. A player item manages the presentation state of an asset with which it is associated. A player item contains player item tracks—instances of `AVPlayerItemTrack`—that correspond to the tracks in the asset. The relationship between the various objects is shown in Figure 2-1.

**Figure 2-1**  Playing an asset - 播放asset
![img](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/avplayerLayer_2x.png)

This abstraction means that you can play a given asset using different players simultaneously, but rendered in different ways by each player. Figure 2-2 shows one possibility, with two different players playing the same asset, with different settings. Using the item tracks, you can, for example, disable a particular track during playback (for example, you might not want to play the sound component).

**Figure 2-2**  Playing the same asset in different ways - 以不同的方式播放同一个asset
![img](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/playerObjects_2x.png)

You can initialize a player item with an existing asset, or you can initialize a player item directly from a URL so that you can play a resource at a particular location (`AVPlayerItem` will then create and configure an asset for the resource). As with `AVAsset`, though, simply initializing a player item doesn’t necessarily mean it’s ready for immediate playback. You can observe (using [key-value observing]()) an item’s `status` property to determine if and when it’s ready to play.

## 2.2 Handling Different Types of Asset - 处理不同类型的asset

The way you configure an asset for playback may depend on the sort of asset you want to play. Broadly speaking, there are two main types: file-based assets, to which you have random access (such as from a local file, the camera roll, or the Media Library), and stream-based assets (HTTP Live Streaming format).

**To load and play a file-based asset.** There are several steps to playing a file-based asset: 

- Create an asset using `AVURLAsset`.
- Create an instance of `AVPlayerItem` using the asset.
- Associate the item with an instance of `AVPlayer`.
- Wait until the item’s `status` property indicates that it’s ready to play (typically you use [key-value observing]() to receive a notification when the status changes).

This approach is illustrated in [Putting It All Together: Playing a Video File Using AVPlayerLayer](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/#//apple_ref/doc/uid/TP40010188-CH3-SW2).

**To create and prepare an HTTP live stream for playback.** Initialize an instance of `AVPlayerItem` using the URL. (You cannot directly create an `AVAsset` instance to represent the media in an HTTP Live Stream.)

```
NSURL *url = [NSURL URLWithString:@"<#Live stream URL#>];
// You may find a test stream at <http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8>.
self.playerItem = [AVPlayerItem playerItemWithURL:url];
[playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];
self.player = [AVPlayer playerWithPlayerItem:playerItem];
```

When you associate the player item with a player, it starts to become ready to play. When it is ready to play, the player item creates the `AVAsset` and `AVAssetTrack` instances, which you can use to inspect the contents of the live stream.

To get the duration of a streaming item, you can observe the `duration` property on the player item. When the item becomes ready to play, this property updates to the correct value for the stream.

>**Note:** Using the `duration` property on the player item requires iOS 4.3 or later. An approach that is compatible with all versions of iOS involves observing the `status` property of the player item. When the status becomes `AVPlayerItemStatusReadyToPlay`, the duration can be fetched with the following line of code:
>
>```
>[[[[[playerItem tracks] objectAtIndex:0] assetTrack] asset] duration];
>```

If you simply want to play a live stream, you can take a shortcut and create a player directly using the URL use the following code:

```
self.player = [AVPlayer playerWithURL:<#Live stream URL#>];
[player addObserver:self forKeyPath:@"status" options:0 context:&PlayerStatusContext];
```

As with assets and items, initializing the player does not mean it’s ready for playback. You should observe the player’s `status` property, which changes to `AVPlayerStatusReadyToPlay` when it is ready to play. You can also observe the `currentItem` property to access the player item created for the stream.

**If you don’t know what kind of URL you have,** follow these steps:

1. Try to initialize an `AVURLAsset` using the URL, then load its `tracks` key.

   If the tracks load successfully, then you create a player item for the asset.

2. If 1 fails, create an `AVPlayerItem` directly from the URL.

   Observe the player’s `status` property to determine whether it becomes playable.

If either route succeeds, you end up with a player item that you can then associate with a player.

## 2.3 Playing an Item - 播放一个项目

To start playback, you send a `play` message to the player.

```
- (IBAction)play:sender {
    [player play];
}
```

In addition to simply playing, you can manage various aspects of the playback, such as the rate and the location of the playhead. You can also monitor the play state of the player; this is useful if you want to, for example, synchronize the user interface to the presentation state of the asset—see [Monitoring Playback](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/#//apple_ref/doc/uid/TP40010188-CH3-SW8).

### 2.3.1 Changing the Playback Rate - 变更播放速率

You change the rate of playback by setting the player’s `rate` property. 

```
aPlayer.rate = 0.5;
aPlayer.rate = 2.0;
```

A value of 1.0 means “play at the natural rate of the current item”. Setting the rate to 0.0 is the same as pausing playback—you can also use `pause`.

Items that support reverse playback can use the rate property with a negative number to set the reverse playback rate. You determine the type of reverse play that is supported by using the playerItem properties `canPlayReverse` (supports a rate value of -1.0), `canPlaySlowReverse` (supports rates between 0.0 and 1.0) and `canPlayFastReverse` (supports rate values less than -1.0). 

### 2.3.2 Seeking—Repositioning the Playhead - 寻找——重新定位播放头

To move the playhead to a particular time, you generally use `seekToTime:` as follows:

```
CMTime fiveSecondsIn = CMTimeMake(5, 1);
[player seekToTime:fiveSecondsIn];
```

The `seekToTime:` method, however, is tuned for performance rather than precision. If you need to move the playhead precisely, instead you use `seekToTime:toleranceBefore:toleranceAfter:` as in the following code fragment:

```
CMTime fiveSecondsIn = CMTimeMake(5, 1);
[player seekToTime:fiveSecondsIn toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
```

Using a tolerance of zero may require the framework to decode a large amount of data. You should use zero only if you are, for example, writing a sophisticated media editing application that requires precise control.

After playback, the player’s head is set to the end of the item and further invocations of `play` have no effect. To position the playhead back at the beginning of the item, you can register to receive an `AVPlayerItemDidPlayToEndTimeNotification` notification from the item. In the notification’s callback method, you invoke `seekToTime:` with the argument `kCMTimeZero`.

```
// Register with the notification center after creating the player item.
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(playerItemDidReachEnd:)
        name:AVPlayerItemDidPlayToEndTimeNotification
        object:<#The player item#>];
 
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [player seekToTime:kCMTimeZero];
}
```

## 2.4 Playing Multiple Items - 播放多个项目

You can use an `AVQueuePlayer` object to play a number of items in sequence. The `AVQueuePlayer` class is a subclass of `AVPlayer`. You initialize a queue player with an array of player items.

```
NSArray *items = <#An array of player items#>;
AVQueuePlayer *queuePlayer = [[AVQueuePlayer alloc] initWithItems:items];
```

You can then play the queue using `play`, just as you would an `AVPlayer` object. The queue player plays each item in turn. If you want to skip to the next item, you send the queue player an `advanceToNextItem` message.

You can modify the queue using `insertItem:afterItem:`, `removeItem:`, and `removeAllItems`. When adding a new item, you should typically check whether it can be inserted into the queue, using `canInsertItem:afterItem:`. You pass `nil` as the second argument to test whether the new item can be appended to the queue.

```
AVPlayerItem *anItem = <#Get a player item#>;
if ([queuePlayer canInsertItem:anItem afterItem:nil]) {
    [queuePlayer insertItem:anItem afterItem:nil];
}
```

## 2.5 Monitoring Playback - 监视播放

You can monitor a number of aspects of both the presentation state of a player and the player item being played. This is particularly useful for state changes that are not under your direct control. For example:

- If the user uses multitasking to switch to a different application, a player’s `rate` property will drop to `0.0`.

- If you are playing remote media, a player item’s `loadedTimeRanges` and `seekableTimeRanges` properties will change as more data becomes available.

  These properties tell you what portions of the player item’s timeline are available.

- A player’s `currentItem` property changes as a player item is created for an HTTP live stream.

- A player item’s `tracks` property may change while playing an HTTP live stream.

  This may happen if the stream offers different encodings for the content; the tracks change if the player switches to a different encoding.

- A player or player item’s `status` property may change if playback fails for some reason.

You can use [key-value observing]() to monitor changes to values of these properties. 

>**Important:** You should register for KVO change notifications and unregister from KVO change notifications on the main thread. This avoids the possibility of receiving a partial notification if a change is being made on another thread. AV Foundation invokes `observeValueForKeyPath:ofObject:change:context:` on the main thread, even if the change operation is made on another thread.

### 2.5.1 Responding to a Change in Status - 响应状态的改变

When a player or player item’s status changes, it emits a key-value observing change notification. If an object is unable to play for some reason (for example, if the media services are reset), the status changes to `AVPlayerStatusFailed` or `AVPlayerItemStatusFailed` as appropriate. In this situation, the value of the object’s `error` property is changed to an error object that describes why the object is no longer be able to play.

AV Foundation does not specify what thread that the notification is sent on. If you want to update the user interface, you must make sure that any relevant code is invoked on the main thread. This example uses `dispatch_async` to execute code on the main thread.

```
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
 
    if (context == <#Player status context#>) {
        AVPlayer *thePlayer = (AVPlayer *)object;
        if ([thePlayer status] == AVPlayerStatusFailed) {
            NSError *error = [<#The AVPlayer object#> error];
            // Respond to error: for example, display an alert sheet.
            return;
        }
        // Deal with other status change if appropriate.
    }
    // Deal with other change notifications if appropriate.
    [super observeValueForKeyPath:keyPath ofObject:object
           change:change context:context];
    return;
}
```

### 2.5.2 Tracking Readiness for Visual Display - 视觉显示的跟踪准备

You can [observe]() an `AVPlayerLayer` object’s `readyForDisplay` property to be notified when the layer has user-visible content. In particular, you might insert the player layer into the layer tree only when there is something for the user to look at and then perform a transition from. 

### 2.5.3 Tracking Time - 跟踪时间

To track changes in the position of the playhead in an `AVPlayer` object, you can use `addPeriodicTimeObserverForInterval:queue:usingBlock:`or `addBoundaryTimeObserverForTimes:queue:usingBlock:`. You might do this to, for example, update your user interface with information about time elapsed or time remaining, or perform some other user interface synchronization.

- With `addPeriodicTimeObserverForInterval:queue:usingBlock:`, the block you provide is invoked at the interval you specify, if time jumps, and when playback starts or stops.
- With `addBoundaryTimeObserverForTimes:queue:usingBlock:`, you pass an array of `CMTime` structures contained in `NSValue` objects. The block you provide is invoked whenever any of those times is traversed.

Both of the methods return an opaque object that serves as an observer. You must keep a strong reference to the returned object as long as you want the time observation block to be invoked by the player. You must also balance each invocation of these methods with a corresponding call to `removeTimeObserver:`.

With both of these methods, AV Foundation does not guarantee to invoke your block for every interval or boundary passed. AV Foundation does not invoke a block if execution of a previously invoked block has not completed. You must make sure, therefore, that the work you perform in the block does not overly tax the system.

```
// Assume a property: @property (strong) id playerObserver;
 
Float64 durationSeconds = CMTimeGetSeconds([<#An asset#> duration]);
CMTime firstThird = CMTimeMakeWithSeconds(durationSeconds/3.0, 1);
CMTime secondThird = CMTimeMakeWithSeconds(durationSeconds*2.0/3.0, 1);
NSArray *times = @[[NSValue valueWithCMTime:firstThird], [NSValue valueWithCMTime:secondThird]];
 
self.playerObserver = [<#A player#> addBoundaryTimeObserverForTimes:times queue:NULL usingBlock:^{
 
    NSString *timeDescription = (NSString *)
        CFBridgingRelease(CMTimeCopyDescription(NULL, [self.player currentTime]));
    NSLog(@"Passed a boundary at %@", timeDescription);
}];
```

### 2.5.4 Reaching the End of an Item - 到达项目的末尾

You can register to receive an `AVPlayerItemDidPlayToEndTimeNotification` [notification]() when a player item has completed playback.

```
[[NSNotificationCenter defaultCenter] addObserver:<#The observer, typically self#>
                                         selector:@selector(<#The selector name#>)
                                             name:AVPlayerItemDidPlayToEndTimeNotification
                                           object:<#A player item#>];
```

## 2.6 Putting It All Together: Playing a Video File Using AVPlayerLayer - 把所有东西都放到一起：使用AVPlayerLayer播放视频文件

This brief code example illustrates how you can use an `AVPlayer` object to play a video file. It shows how to:

- Configure a view to use an `AVPlayerLayer` layer
- Create an `AVPlayer` object
- Create an `AVPlayerItem` object for a file-based asset and use key-value observing to observe its status
- Respond to the item becoming ready to play by enabling a button
- Play the item and then restore the player’s head to the beginning

>**Note:** To focus on the most relevant code, this example omits several aspects of a complete application, such as memory management and unregistering as an observer (for [key-value observing]() or for the notification center). To use AV Foundation, you are expected to have enough experience with Cocoa to be able to infer the missing pieces.

For a conceptual introduction to playback, skip to [Playing Assets](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html#//apple_ref/doc/uid/#//apple_ref/doc/uid/TP40010188-CH3-SW4).

### 2.6.1 The Player View - 播放器视图

To play the visual component of an asset, you need a view containing an `AVPlayerLayer` layer to which the output of an `AVPlayer` object can be directed. You can create a simple subclass of `UIView` to accommodate this:

```
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
 
@interface PlayerView : UIView
@property (nonatomic) AVPlayer *player;
@end
 
@implementation PlayerView
+ (Class)layerClass {
    return [AVPlayerLayer class];
}
- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}
@end
```

### 2.6.2 A Simple View Controller - 简单的视图控制器

Assume you have a simple view controller, declared as follows:

```
@class PlayerView;
@interface PlayerViewController : UIViewController
 
@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerItem *playerItem;
@property (nonatomic, weak) IBOutlet PlayerView *playerView;
@property (nonatomic, weak) IBOutlet UIButton *playButton;
- (IBAction)loadAssetFromFile:sender;
- (IBAction)play:sender;
- (void)syncUI;
@end
```

The `syncUI` method synchronizes the button’s state with the player’s state:

```
- (void)syncUI {
    if ((self.player.currentItem != nil) &&
        ([self.player.currentItem status] == AVPlayerItemStatusReadyToPlay)) {
        self.playButton.enabled = YES;
    }
    else {
        self.playButton.enabled = NO;
    }
}
```

You can invoke `syncUI` in the view controller’s `viewDidLoad` method to ensure a consistent user interface when the view is first displayed.

```
- (void)viewDidLoad {
    [super viewDidLoad];
    [self syncUI];
}
```

The other properties and methods are described in the remaining sections.

### 2.6.3 Creating the Asset - 创建asset

You create an asset from a URL using `AVURLAsset`. (The following example assumes your project contains a suitable video resource.)

```
- (IBAction)loadAssetFromFile:sender {
 
    NSURL *fileURL = [[NSBundle mainBundle]
        URLForResource:<#@"VideoFileName"#> withExtension:<#@"extension"#>];
 
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    NSString *tracksKey = @"tracks";
 
    [asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:
     ^{
         // The completion block goes here.
     }];
}
```

In the completion block, you create an instance of `AVPlayerItem` for the asset and set it as the player for the player view. As with creating the asset, simply creating the player item does not mean it’s ready to use. To determine when it’s ready to play, you can [observe]() the item’s `status` property. You should configure this observing before associating the player item instance with the player itself.

You trigger the player item’s preparation to play when you associate it with the player.

```
// Define this constant for the key-value observation context.
static const NSString *ItemStatusContext;
 
// Completion handler block.
         dispatch_async(dispatch_get_main_queue(),
            ^{
                NSError *error;
                AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
 
                if (status == AVKeyValueStatusLoaded) {
                    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
                     // ensure that this is done before the playerItem is associated with the player
                    [self.playerItem addObserver:self forKeyPath:@"status"
                                options:NSKeyValueObservingOptionInitial context:&ItemStatusContext];
                    [[NSNotificationCenter defaultCenter] addObserver:self
                                                              selector:@selector(playerItemDidReachEnd:)
                                                                  name:AVPlayerItemDidPlayToEndTimeNotification
                                                                object:self.playerItem];
                    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
                    [self.playerView setPlayer:self.player];
                }
                else {
                    // You should deal with the error appropriately.
                    NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
                }
            });
```

### 2.6.4 Responding to the Player Item’s Status Change - 响应播放器项目的状态变化

When the player item’s status changes, the view controller receives a key-value observing change notification. AV Foundation does not specify what thread that the notification is sent on. If you want to update the user interface, you must make sure that any relevant code is invoked on the main thread. This example uses `dispatch_async` to queue a message on the main thread to synchronize the user interface.

```
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
 
    if (context == &ItemStatusContext) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self syncUI];
                       });
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object
           change:change context:context];
    return;
}
```

### 2.6.5 Playing the Item - 播放项目

Playing the item involves sending a `play` message to the player.

```
- (IBAction)play:sender {
    [player play];
}
```

The item is played only once. After playback, the player’s head is set to the end of the item, and further invocations of the `play` method will have no effect. To position the playhead back at the beginning of the item, you can register to receive an `AVPlayerItemDidPlayToEndTimeNotification`from the item. In the notification’s callback method, invoke `seekToTime:` with the argument `kCMTimeZero`.

```
// Register with the notification center after creating the player item.
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(playerItemDidReachEnd:)
        name:AVPlayerItemDidPlayToEndTimeNotification
        object:[self.player currentItem]];
 
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.player seekToTime:kCMTimeZero];
}
```