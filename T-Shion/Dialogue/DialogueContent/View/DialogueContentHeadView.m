//
//  DialogueContentHeadView.m
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentHeadView.h"

@implementation DialogueContentHeadView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (DialogueContentViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.loginInformation];
    [self addSubview:self.videoButton];
    [self addSubview:self.callButton];
    [self addSubview:self.pushButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(25);
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(300, 22));
    }];
    
    [self.loginInformation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.nameLabel);
        make.size.mas_offset(CGSizeMake(300, 12));
    }];

    [self.pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pushButton.mas_left).with.offset(-20);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
    [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(22, 22));
        make.right.equalTo(self.videoButton.mas_left).with.offset(-20);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:22];
        _nameLabel.textColor = RGB(64, 64, 64);
        _nameLabel.text = @"疾风剑豪·亚索";
    }
    return _nameLabel;
}

- (UILabel *)loginInformation {
    if (!_loginInformation) {
        _loginInformation = [[UILabel alloc] init];
        _loginInformation.textColor = RGB(176, 175, 175);
        _loginInformation.text = @"最近登录:星期五 15:55PM";
        _loginInformation.font = [UIFont systemFontOfSize:11];
    }
    return _loginInformation;
}

- (UIButton *)videoButton {
    if (!_videoButton) {
        _videoButton = [self creatButtonWithImage:@"Seting_Video_Icon" tag:2];
    }
    return _videoButton;
}

- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [self creatButtonWithImage:@"Seting_Calling_Icon" tag:1];
    }
    return _callButton;
}

- (UIButton *)pushButton {
    if (!_pushButton) {
        _pushButton = [self creatButtonWithImage:@"Seting_Push_Icon" tag:3];
    }
    return _pushButton;
}

- (UIButton *)creatButtonWithImage:(NSString *)image tag:(int)tag{
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTag:tag];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     @strongify(self)
        
    }];
    return button;
}
@end
