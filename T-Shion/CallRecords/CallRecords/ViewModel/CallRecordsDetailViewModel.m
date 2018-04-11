//
//  CallRecordsDetailViewModel.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsDetailViewModel.h"

@implementation CallRecordsDetailViewModel

- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

@end
