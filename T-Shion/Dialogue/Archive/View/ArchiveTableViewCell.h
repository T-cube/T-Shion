//
//  ArchiveTableViewCell.h
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ArchiveTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) UILabel *content;

@property (strong, nonatomic) UILabel *time;

@property (strong, nonatomic) UIImageView *icon;

@property (strong, nonatomic) UIButton *archive;

@property (copy, nonatomic) void (^archiveBlock)(void);
@end
