//
//  DialogueContentHeadView.h
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "DialogueContentViewModel.h"

@interface DialogueContentHeadView : BaseView
@property (strong, nonatomic) DialogueContentViewModel *viewModel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *loginInformation;
@property (strong, nonatomic) UIButton *callButton;
@property (strong, nonatomic) UIButton *videoButton;
@property (strong, nonatomic) UIButton *pushButton;
@end
