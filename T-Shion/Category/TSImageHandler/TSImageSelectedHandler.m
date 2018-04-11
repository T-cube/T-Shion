//
//  TSImageSelectedHandler.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageSelectedHandler.h"
#import <Photos/Photos.h>

static NSInteger const defaultMaxSelectedCount = 9;

@interface TSImageSelectedHandler ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, assign) NSInteger maxSelectCount;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation TSImageSelectedHandler

+ (instancetype)shareInstance {
    static TSImageSelectedHandler *selectHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectHandler = [[TSImageSelectedHandler alloc] init];
        selectHandler.dataArray = [NSMutableArray array];
        selectHandler.indexArray = [NSMutableArray array];
        selectHandler.maxSelectCount = defaultMaxSelectedCount;
        selectHandler.concurrentQueue = dispatch_queue_create("com.concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
        selectHandler.needOriginal = NO;
    });
    return selectHandler;
}

- (NSArray *)selectedAssets {
    __block NSArray *assets;
    dispatch_sync(self.concurrentQueue, ^{
        assets = [NSArray arrayWithArray:_dataArray];
    });
    return assets;
}

- (NSArray *)selectedIndexs {
    __block NSArray *indexs;
    dispatch_sync(self.concurrentQueue, ^{
        indexs = [NSArray arrayWithArray:_indexArray];
    });
    return indexs;
}

- (void)addIndex:(id)index {
    if (!index) {return;}

    dispatch_barrier_async(self.concurrentQueue, ^{
        [_indexArray addObject:index];
    });
}

- (void)removeIndex:(id)index {
    if (!index || ![_indexArray containsObject:index]) {return;}

    dispatch_barrier_async(self.concurrentQueue, ^{
        [_indexArray removeObject:index];
    });
}

- (void)removeAllIndexs {
    dispatch_barrier_async(self.concurrentQueue, ^{
        [_indexArray removeAllObjects];
    });
}

- (void)addAsset:(id)asset {
    if (!asset) {return;}
    dispatch_barrier_async(self.concurrentQueue, ^{
        [_dataArray addObject:asset];
    });
}

- (void)removeAsset:(id)asset {
    if (!asset || ![_dataArray containsObject:asset]) {return;}

    dispatch_barrier_async(self.concurrentQueue, ^{
        [_dataArray removeObject:asset];
    });
}

- (void)removeAllAssets {
    dispatch_barrier_async(self.concurrentQueue, ^{
        [_dataArray removeAllObjects];
    });
}

- (BOOL)containsAsset:(id)asset {
    if (!asset || (![asset isKindOfClass:[PHAsset class]])) {
        return NO;
    }
    return [[self selectedAssets] containsObject:asset];
}

- (BOOL)containsIndex:(id)index {
    if (!index || ![index isKindOfClass:[NSIndexPath class]]) {
        return NO;
    }
    return [[self selectedIndexs] containsObject:index];
}

- (void)postSelectAssetsUpdateNotification:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectAssetsUpdateNotification object:indexPath];
}

- (NSInteger)maxSelectedCount {
    return self.maxSelectCount;
}

- (void)setMaxSelectedCount:(NSInteger)maxSelectedCount {
    _maxSelectCount = maxSelectedCount;
}


@end
