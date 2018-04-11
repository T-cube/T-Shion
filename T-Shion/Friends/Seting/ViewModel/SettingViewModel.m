//
//  SettingViewModel.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "SettingViewModel.h"

@implementation SettingViewModel

#pragma mark - getter and setter
- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

- (RACSubject *)cardClickSubject {
    if (!_cardClickSubject) {
        _cardClickSubject = [RACSubject subject];
    }
    return _cardClickSubject;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"我的收藏",
                        @"归档",
                        @"黑名单",
                        @"存储空间",
                        @"关于Tshion"];
    }
    return _titleArray;
}

@end
