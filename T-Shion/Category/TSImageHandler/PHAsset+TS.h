//
//  PHAsset+TS.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (TS)

// 缩略图
- (void)thumbnail:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)thumbnail:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

// 原图
- (void)original:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

// 目标尺寸视图
- (void)requestImageForTargetSize:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)originalSize:(void(^)(NSString *result))result;

@end
