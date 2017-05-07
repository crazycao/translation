# AVFoundation Programming Guide 

原文地址：
[https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/TP40010188-CH7-SW1)

# 1 Using Assets - 使用asset

Assets can come from a file or from media in the user’s iPod library or Photo library. When you create an asset object all the information that you might want to retrieve for that item is not immediately available. Once you have a movie asset, you can extract still images from it, transcode it to another format, or trim the contents.

Asset来自于一个文件或来自于用户iPod库或Photo库中的媒体。当你创建一个asset对象时，所有你想要取回的该项目的信息都不是立即可用的。一旦你有了一个电影asset，你可以从中提取静态图像，将其转码为另一种格式，或者修剪其内容。

## 1.1 Creating an Asset Object - 创建asset对象

To create an asset to represent any resource that you can identify using a URL, you use `AVURLAsset`. The simplest case is creating an asset from a file:

	NSURL *url = <#A URL that identifies an audiovisual asset such as a movie file#>;
	AVURLAsset *anAsset = [[AVURLAsset alloc] initWithURL:url options:nil];

### 1.1.1 Options for Initializing an Asset - 初始化asset时的选项

The `AVURLAsset` initialization methods take as their second argument an options dictionary. The only key used in the dictionary is `AVURLAssetPreferPreciseDurationAndTimingKey`. The corresponding value is a Boolean (contained in an `NSValue` object) that indicates whether the asset should be prepared to indicate a precise duration and provide precise random access by time.

Getting the exact duration of an asset may require significant processing overhead. Using an approximate duration is typically a cheaper operation and sufficient for playback. Thus:

- If you only intend to play the asset, either pass `nil` instead of a dictionary, or pass a dictionary that contains the `AVURLAssetPreferPreciseDurationAndTimingKey` key and a corresponding value of `NO` (contained in an `NSValue` object).

- If you want to add the asset to a composition (`AVMutableComposition`), you typically need precise random access. Pass a dictionary that contains the `AVURLAssetPreferPreciseDurationAndTimingKey` key and a corresponding value of `YES` (contained in an `NSValue` object—recall that `NSNumber` inherits from `NSValue`):

```
NSURL *url = <#A URL that identifies an audiovisual asset such as a movie file#>;
NSDictionary *options = @{ AVURLAssetPreferPreciseDurationAndTimingKey : @YES };
AVURLAsset *anAssetToUseInAComposition = [[AVURLAsset alloc] initWithURL:url options:options];
```

### 1.1.2 Accessing the User’s Assets - 访问用户的asset

To access the assets managed by the iPod library or by the Photos application, you need to get a URL of the asset you want.

- To access the iPod Library, you create an `MPMediaQuery` instance to find the item you want, then get its URL using `MPMediaItemPropertyAssetURL`.

  For more about the Media Library, see *Multimedia Programming Guide*.

- To access the assets managed by the Photos application, you use `ALAssetsLibrary`.

The following example shows how you can get an asset to represent the first video in the Saved Photos Album.

```
ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
 
// Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
[library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
 
// Within the group enumeration block, filter to enumerate just videos.
[group setAssetsFilter:[ALAssetsFilter allVideos]];
 
// For this example, we're only interested in the first item.
[group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0]
                        options:0
                     usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
 
                         // The end of the enumeration is signaled by asset == nil.
                         if (alAsset) {
                             ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                             NSURL *url = [representation url];
                             AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
                             // Do something interesting with the AV asset.
                         }
                     }];
                 }
                 failureBlock: ^(NSError *error) {
                     // Typically you should handle an error more gracefully than this.
                     NSLog(@"No groups");
                 }];
```

## 1.2 Preparing an Asset for Use - 为使用准备asset

Initializing an asset (or track) does not necessarily mean that all the information that you might want to retrieve for that item is immediately available. It may require some time to calculate even the duration of an item (an MP3 file, for example, may not contain summary information). Rather than blocking the current thread while a value is being calculated, you should use the `AVAsynchronousKeyValueLoading` [ protocol]() to ask for values and get an answer back later through a completion handler you define using a [block](). (`AVAsset` and `AVAssetTrack` conform to the `AVAsynchronousKeyValueLoading` protocol.)

You test whether a value is loaded for a property using `statusOfValueForKey:error:`. When an asset is first loaded, the value of most or all of its properties is `AVKeyValueStatusUnknown`. To load a value for one or more properties, you invoke `loadValuesAsynchronouslyForKeys:completionHandler:`. In the completion handler, you take whatever action is appropriate depending on the property’s status. You should always be prepared for loading to not complete successfully, either because it failed for some reason such as a network-based URL being inaccessible, or because the load was canceled.

```
NSURL *url = <#A URL that identifies an audiovisual asset such as a movie file#>;
AVURLAsset *anAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
NSArray *keys = @[@"duration"];
 
[asset loadValuesAsynchronouslyForKeys:keys completionHandler:^() {
 
    NSError *error = nil;
    AVKeyValueStatus tracksStatus = [asset statusOfValueForKey:@"duration" error:&error];
    switch (tracksStatus) {
        case AVKeyValueStatusLoaded:
            [self updateUserInterfaceForDuration];
            break;
        case AVKeyValueStatusFailed:
            [self reportError:error forAsset:asset];
            break;
        case AVKeyValueStatusCancelled:
            // Do whatever is appropriate for cancelation.
            break;
   }
}];
```

If you want to prepare an asset for playback, you should load its `tracks` property. For more about playing assets, see [Playback](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/01_UsingAssets.html#//apple_ref/doc/uid/02_Playback.html#//apple_ref/doc/uid/TP40010188-CH3-SW1).

## 1.3 Getting Still Images From a Video - 从视频中获取静态图像

To get still images such as thumbnails from an asset for playback, you use an `AVAssetImageGenerator` object. You initialize an image generator with your asset. Initialization may succeed, though, even if the asset possesses no visual tracks at the time of initialization, so if necessary you should test whether the asset has any tracks with the visual characteristic using `tracksWithMediaCharacteristic:`. 

```
AVAsset anAsset = <#Get an asset#>;
if ([[anAsset tracksWithMediaType:AVMediaTypeVideo] count] > 0) {
    AVAssetImageGenerator *imageGenerator =
        [AVAssetImageGenerator assetImageGeneratorWithAsset:anAsset];
    // Implementation continues...
}
```

You can configure several aspects of the image generator, for example, you can specify the maximum dimensions for the images it generates and the aperture mode using `maximumSize` and `apertureMode` respectively.You can then generate a single image at a given time, or a series of images. You must ensure that you keep a strong reference to the image generator until it has generated all the images.

### 1.3.1 Generating a Single Image - 生成一个单独的图像

You use `copyCGImageAtTime:actualTime:error:` to generate a single image at a specific time. AVFoundation may not be able to produce an image at exactly the time you request, so you can pass as the second argument a pointer to a CMTime that upon return contains the time at which the image was actually generated.

```
AVAsset *myAsset = <#An asset#>];
AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:myAsset];
 
Float64 durationSeconds = CMTimeGetSeconds([myAsset duration]);
CMTime midpoint = CMTimeMakeWithSeconds(durationSeconds/2.0, 600);
NSError *error;
CMTime actualTime;
 
CGImageRef halfWayImage = [imageGenerator copyCGImageAtTime:midpoint actualTime:&actualTime error:&error];
 
if (halfWayImage != NULL) {
 
    NSString *actualTimeString = (NSString *)CMTimeCopyDescription(NULL, actualTime);
    NSString *requestedTimeString = (NSString *)CMTimeCopyDescription(NULL, midpoint);
    NSLog(@"Got halfWayImage: Asked for %@, got %@", requestedTimeString, actualTimeString);
 
    // Do something interesting with the image.
    CGImageRelease(halfWayImage);
}
```

### 1.3.2 Generating a Sequence of Images - 生成一系列图像

To generate a series of images, you send the image generator a `generateCGImagesAsynchronouslyForTimes:completionHandler:` message. The first argument is an array of `NSValue` objects, each containing a `CMTime` structure, specifying the asset times for which you want images to be generated. The second argument is a [block]() that serves as a callback invoked for each image that is generated. The block arguments provide a result constant that tells you whether the image was created successfully or if the operation was canceled, and, as appropriate:

- The image
- The time for which you requested the image and the actual time for which the image was generated
- An error object that describes the reason generation failed

In your implementation of the block, check the result constant to determine whether the image was created. In addition, ensure that you keep a strong reference to the image generator until it has finished creating the images.

```
AVAsset *myAsset = <#An asset#>];
// Assume: @property (strong) AVAssetImageGenerator *imageGenerator;
self.imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:myAsset];
 
Float64 durationSeconds = CMTimeGetSeconds([myAsset duration]);
CMTime firstThird = CMTimeMakeWithSeconds(durationSeconds/3.0, 600);
CMTime secondThird = CMTimeMakeWithSeconds(durationSeconds*2.0/3.0, 600);
CMTime end = CMTimeMakeWithSeconds(durationSeconds, 600);
NSArray *times = @[NSValue valueWithCMTime:kCMTimeZero],
                  [NSValue valueWithCMTime:firstThird], [NSValue valueWithCMTime:secondThird],
                  [NSValue valueWithCMTime:end]];
 
[imageGenerator generateCGImagesAsynchronouslyForTimes:times
                completionHandler:^(CMTime requestedTime, CGImageRef image, CMTime actualTime,
                                    AVAssetImageGeneratorResult result, NSError *error) {
 
                NSString *requestedTimeString = (NSString *)
                    CFBridgingRelease(CMTimeCopyDescription(NULL, requestedTime));
                NSString *actualTimeString = (NSString *)
                    CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
                NSLog(@"Requested: %@; actual %@", requestedTimeString, actualTimeString);
 
                if (result == AVAssetImageGeneratorSucceeded) {
                    // Do something interesting with the image.
                }
 
                if (result == AVAssetImageGeneratorFailed) {
                    NSLog(@"Failed with error: %@", [error localizedDescription]);
                }
                if (result == AVAssetImageGeneratorCancelled) {
                    NSLog(@"Canceled");
                }
  }];
```

You can cancel the generation of the image sequence by sending the image generator a `cancelAllCGImageGeneration` message.

## 1.4 Trimming and Transcoding a Movie - 视频修剪和视频转码

You can transcode a movie from one format to another, and trim a movie, using an `AVAssetExportSession` object. The workflow is shown in Figure 1-1. An export session is a controller object that manages asynchronous export of an asset. You initialize the session using the asset you want to export and the name of a export preset that indicates the export options you want to apply (see `allExportPresets`). You then configure the export session to specify the output URL and file type, and optionally other settings such as the metadata and whether the output should be optimized for network use.

**Figure 1-1**  The export session workflow - 输出会话工作流
![img](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/export_2x.png)

You can check whether you can export a given asset using a given preset using `exportPresetsCompatibleWithAsset:` as illustrated in this example:

```
AVAsset *anAsset = <#Get an asset#>;
NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:anAsset];
if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality]) {
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]
        initWithAsset:anAsset presetName:AVAssetExportPresetLowQuality];
    // Implementation continues.
}
```

You complete the configuration of the session by providing the output URL (The URL must be a file URL.) `AVAssetExportSession` can infer the output file type from the URL’s path extension; typically, however, you set it directly using `outputFileType`. You can also specify additional properties such as the time range, a limit for the output file length, whether the exported file should be optimized for network use, and a video composition. The following example illustrates how to use the `timeRange` property to trim the movie:

```
    exportSession.outputURL = <#A file URL#>;
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
 
    CMTime start = CMTimeMakeWithSeconds(1.0, 600);
    CMTime duration = CMTimeMakeWithSeconds(3.0, 600);
    CMTimeRange range = CMTimeRangeMake(start, duration);
    exportSession.timeRange = range;
```

To create the new file, you invoke `exportAsynchronouslyWithCompletionHandler:`. The completion handler [block]() is called when the export operation finishes; in your implementation of the handler, you should check the session’s `status` value to determine whether the export was successful, failed, or was canceled:

```
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
 
        switch ([exportSession status]) {
            case AVAssetExportSessionStatusFailed:
                NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                break;
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"Export canceled");
                break;
            default:
                break;
        }
    }];
```

You can cancel the export by sending the session a `cancelExport` message.

The export will fail if you try to overwrite an existing file, or write a file outside of the application’s sandbox. It may also fail if:

- There is an incoming phone call
- Your application is in the background and another application starts playback

In these situations, you should typically inform the user that the export failed, then allow the user to restart the export.