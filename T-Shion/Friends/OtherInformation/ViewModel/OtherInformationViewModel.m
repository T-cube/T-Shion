//
//  OhterInformationViewModel.m
//  T-Shion
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "OtherInformationViewModel.h"

@implementation OtherInformationViewModel

- (RACSubject *)menuItemClickSubject {
    if (!_menuItemClickSubject) {
        _menuItemClickSubject = [RACSubject subject];
    }
    return _menuItemClickSubject;
}
@end
