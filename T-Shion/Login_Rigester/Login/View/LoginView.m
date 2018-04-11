//
//  LoginView.m
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (LoginViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.phoneNum];
    [self addSubview:self.pwd];
    [self addSubview:self.forgetPwd];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registerBtn];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(100);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(200, 32));
    }];
    
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(50);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 44));
    }];
    
    [self.pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNum.mas_bottom).with.offset(15);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 44));
    }];
    
    [self.forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwd.mas_bottom).with.offset(10);
        make.right.equalTo(self.pwd.mas_right);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.forgetPwd.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 44));
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 44));
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGB(65, 119, 255);
        _titleLabel.text = @"Tshion";
        _titleLabel.font = [UIFont systemFontOfSize:31];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UITextField *)phoneNum {
    if (!_phoneNum) {
        _phoneNum = [UITextField creatLoginTypeWithImage:@"Login_Phone" placeholder:@"请输入手机号"];
    }
    return _phoneNum;
}

- (UITextField *)pwd {
    if (!_pwd) {
        _pwd = [UITextField creatLoginTypeWithImage:@"Login_Pwd" placeholder:@"请输入密码"];
    }
    return _pwd;
}

- (UIButton *)forgetPwd {
    if (!_forgetPwd) {
        _forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPwd setTitleColor:RGB(65, 119, 255) forState:UIControlStateNormal];
        [_forgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPwd.titleLabel setFont:[UIFont systemFontOfSize:13]];
        @weakify(self)
        [[_forgetPwd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.forgetClickSubject sendNext:nil];
        }];
    }
    return _forgetPwd;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [self creatButtonWithTitle:@"登  录" tag:0 backgroundColor:RGB(65, 119, 255) titleColor:[UIColor whiteColor]];
    }
    return _loginBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [self creatButtonWithTitle:@"注  册" tag:1 backgroundColor:[UIColor whiteColor] titleColor:RGB(65, 119, 255)];
    }
    return _registerBtn;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title tag:(int)tag backgroundColor:(UIColor *)backColor titleColor:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setBackgroundColor:backColor];
    [button setTag:tag];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel.buttonClickSubject sendNext:@(x.tag)];
    }];
    return button;
}
@end
