//
//  BaseViewModelProtocol.h
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HeaderRefresh_HasMoreData = 1,
    HeaderRefresh_HasNoMoreData,
    FooterRefresh_HasMoreData,
    FooterRefresh_HasNoMoreData,
    RefreshError,
    RefreshUI,
} LSRefreshDataStatus;

@protocol BaseViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;


/**
 *  初始化
 */
- (void)initialize;

@end
