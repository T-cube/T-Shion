//
//  CallRecordsViewModel.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsViewModel.h"

@implementation CallRecordsViewModel

#pragma mark - getter and setter
- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

- (RACSubject *)detaikClickSubject {
    if (!_detaikClickSubject) {
        _detaikClickSubject = [RACSubject subject];
    }
    return _detaikClickSubject;
}

@end
