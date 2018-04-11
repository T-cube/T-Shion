//
//  TSImageSelectedHandler.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Foundation/Foundation.h>

// 选中图片更新通知
static NSString *const kSelectAssetsUpdateNotification = @"kSelectAssetsUpdateNotification";

static NSString *const kSelectAssetsRemoveNotification = @"kSelectAssetsRemoveNotification";

static NSString *const kSelectAssetsAddNotification = @"kSelectAssetsAddNotification";


@interface TSImageSelectedHandler : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign) BOOL needOriginal;

- (NSArray *)selectedAssets;

- (NSArray *)selectedIndexs;

- (void)addAsset:(id)asset;

- (void)removeAsset:(id)asset;

- (void)removeAllAssets;

- (void)addIndex:(id)index;

- (void)removeIndex:(id)index;

- (void)removeAllIndexs;

- (BOOL)containsAsset:(id)asset;

- (BOOL)containsIndex:(id)index;

- (NSInteger)maxSelectedCount;

- (void)setMaxSelectedCount:(NSInteger)maxSelectedCount;


@end
