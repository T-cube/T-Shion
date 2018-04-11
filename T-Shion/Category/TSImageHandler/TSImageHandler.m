//
//  TSImageHandler.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageHandler.h"
#import "PHAssetCollection+TS.h"

static CGFloat const kDefaultThumbnailWidth = 100;

@interface TSImageHandler ()

@property (nonatomic, weak) PHPhotoLibrary *photoLibrary;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation TSImageHandler

+ (TSAuthorizationStatus)requestAuthorization {
    return (TSAuthorizationStatus)[PHPhotoLibrary authorizationStatus];
}

+ (void)requestAuthorization:(void (^)(TSAuthorizationStatus))handler {
    handler((TSAuthorizationStatus)[PHPhotoLibrary authorizationStatus]);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        self.concurrentQueue = dispatch_queue_create("com.LLImageHandler.global", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

//获取所有相册: PHAssetCollection
- (void)enumeratePHAssetCollectionsWithResultHandler:(void (^)(NSArray<PHAssetCollection *> *))resultHandler {
    NSMutableArray *groups = [NSMutableArray array];
    
    dispatch_sync(self.concurrentQueue, ^{
        //系统
        PHFetchResult <PHAssetCollection *>*systemAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        //自定义相册
        
        PHFetchResult <PHAssetCollection *>*userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];

        for (PHAssetCollection *collection in systemAlbums) {
            // 过滤照片数量为0的相册
            if ([collection numberOfAssets] == 0) {
                continue;
            }
            
            if ([collection.localizedTitle isEqualToString:@"Camera Roll"] || [collection.localizedTitle isEqualToString:@"相机胶卷"] ||
                [collection.localizedTitle isEqualToString:@"所有照片"] ||
                [collection.localizedTitle isEqualToString:@"All Photos"])
            {
                [groups insertObject:collection atIndex:0];
            }
            else
            {
                [groups addObject:collection];
            }
        }
        
        
        for (PHAssetCollection *collection in userAlbums) {
            if ([collection numberOfAssets] == 0) {
                continue;
            }
            [groups addObject:collection];
        }
    });
    
    dispatch_sync(self.concurrentQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            resultHandler(groups);
        });
    });
}

/**
 *  获取某相册下的资源
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection finishBlock:(void(^)(NSArray <PHAsset *>*result))finishBlock {
    __block NSMutableArray <PHAsset *>*results = [NSMutableArray array];
    
    dispatch_async(self.concurrentQueue, ^{
        // 获取collection这个相册中的所有资源
        PHFetchResult <PHAsset *>*assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.mediaType == PHAssetMediaTypeImage) {
                [results addObject:obj];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            finishBlock(results);
        });
    });
}

@end
