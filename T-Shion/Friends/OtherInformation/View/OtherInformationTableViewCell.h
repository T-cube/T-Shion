//
//  OhterInformationTableViewCell.h
//  T-Shion
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OtherInformationFieldTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UITextField *noteName;
@end

@interface OtherInformationSwitchTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UISwitch *switchBtn;
@end

@interface OtherInformationNormalTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@end




