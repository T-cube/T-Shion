//
//  FriendsTableViewCell.h
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FriendsTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UIButton *calling;
@property (copy, nonatomic) void (^cellClickBlock)(void);
@end
