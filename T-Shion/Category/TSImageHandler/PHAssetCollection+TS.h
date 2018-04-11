//
//  PHAssetCollection+TS.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAssetCollection (TS)

- (void)posterImage:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)posterImage:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (NSInteger)numberOfAssets;

@end
