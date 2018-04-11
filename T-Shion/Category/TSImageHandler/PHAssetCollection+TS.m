//
//  PHAssetCollection+TS.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "PHAssetCollection+TS.h"

@implementation PHAssetCollection (TS)

- (void)posterImage:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    CGSize const defaultSize = CGSizeMake(100, 100);
    [self posterImage:defaultSize resultHandler:resultHandler];
}

- (void)posterImage:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self options:nil];
    if (fetchResult.count == 0) { return; }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        PHAsset *asset = fetchResult.lastObject;
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resultHandler) {
                    resultHandler(result,info);
                }
            });
        }];
    });
}

- (NSInteger)numberOfAssets {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    // 注意 %zd 这里不识别，直接导致崩溃
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:self options:fetchOptions];
    return result.count;
}

@end
