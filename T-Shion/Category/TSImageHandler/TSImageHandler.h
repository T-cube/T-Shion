//
//  TSImageHandler.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/**
 *   访问相册授权状态
 */
typedef NS_ENUM(NSInteger, TSAuthorizationStatus) {
    
    TSAuthorizationStatusNotDetermined = 0,// 未确定授权
    
    TSAuthorizationStatusRestricted,// 限制授权
    
    TSAuthorizationStatusDenied,// 拒绝授权
    
    TSAuthorizationStatusAuthorized,// 已授权
};


@interface TSImageHandler : NSObject

+ (TSAuthorizationStatus)requestAuthorization;

+ (void)requestAuthorization:(void(^)(TSAuthorizationStatus status))handler;

/**
 *  获取所有相册
 */
- (void)enumeratePHAssetCollectionsWithResultHandler:(void(^)(NSArray <PHAssetCollection *>*result))resultHandler;

/**
 *  获取某相册下的资源
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection finishBlock:(void(^)(NSArray <PHAsset *>*result))finishBlock;

@end
