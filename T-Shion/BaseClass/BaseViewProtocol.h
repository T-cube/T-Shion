//
//  BaseViewProtocol.h
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseViewModelProtocol.h"

@protocol BaseViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <BaseViewModelProtocol>)viewModel;

- (void)bindViewModel;
- (void)setupViews;

@end
