//
//  NameCardView.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"

@class UserInfoModel;

@interface NameCardView : BaseView

@property (strong, nonatomic) UserInfoModel *infoModel;

@property (assign, nonatomic) BOOL isOneself;

@property (copy, nonatomic) void (^buttonClickBlock)(int index);
@end
