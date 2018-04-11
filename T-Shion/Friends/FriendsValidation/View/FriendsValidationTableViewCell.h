//
//  FriendsValidationTableViewCell.h
//  T-Shion
//
//  Created by together on 2018/3/30.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FriendsValidationTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *headIcon;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *message;
@property (strong, nonatomic) UIButton *phoneNum;
@property (strong, nonatomic) UIButton *ignore;
@property (strong, nonatomic) UIButton *agree;
@property (copy, nonatomic) void (^buttonClickBlock)(int index);
@end
