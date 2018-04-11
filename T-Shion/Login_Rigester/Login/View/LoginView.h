//
//  LoginView.h
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "LoginViewModel.h"

@interface LoginView : BaseView
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *registerBtn;
@property (strong, nonatomic) UIButton *forgetPwd;
@property (strong, nonatomic) UITextField *phoneNum;
@property (strong, nonatomic) UITextField *pwd;
@property (strong, nonatomic) LoginViewModel *viewModel;
@end
