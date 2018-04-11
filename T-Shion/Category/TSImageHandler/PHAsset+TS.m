//
//  PHAsset+TS.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "PHAsset+TS.h"

static CGFloat const kDefaultThumbnailWidth = 100;

@implementation PHAsset (TS)

- (void)thumbnail:(void (^)(UIImage *, NSDictionary *))resultHandler {
    CGSize const defaultSize = CGSizeMake(kDefaultThumbnailWidth, kDefaultThumbnailWidth);
    [self thumbnail:defaultSize resultHandler:resultHandler];
}

- (void)thumbnail:(CGSize)targetSize resultHandler:(void (^)(UIImage *, NSDictionary *))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        options.synchronous = YES;
        
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resultHandler) {
                    resultHandler(result,info);
                }
            });
        }];
    });
}

- (void)original:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resultHandler) {
                    resultHandler(result,info);
                }
            });
        }];
    });
}

- (void)requestImageForTargetSize:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.synchronous = YES;
//        option.networkAccessAllowed = YES;
//        option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
//        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resultHandler) {
                    resultHandler(result,info);
                }
            });
        }];
    });
}

- (void)originalSize:(void(^)(NSString *result))result {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeNone;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        option.version = PHImageRequestOptionsVersionOriginal;
        option.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:self options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            unsigned long size = imageData.length / 1024;
            NSString *sizeString = [NSString stringWithFormat:@"%liK", size];
            if (size > 1024) {
                NSInteger integral = size / 1024.0;
                NSInteger decimal = size % 1024;
                NSString *decimalString = [NSString stringWithFormat:@"%li",decimal];
                if(decimal > 100){ //取两位
                    decimalString = [decimalString substringToIndex:2];
                }
                sizeString = [NSString stringWithFormat:@"%li.%@M", integral, decimalString];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    result(sizeString);
                }
            });
        }];
    });
}

@end
