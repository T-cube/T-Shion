//
//  FriendsValidationTableViewCell.m
//  T-Shion
//
//  Created by together on 2018/3/30.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "FriendsValidationTableViewCell.h"

@implementation FriendsValidationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self setBackgroundColor:DEFAULT_COLOR];
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.headIcon];
    [self.backView addSubview:self.message];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.phoneNum];
    [self.backView addSubview:self.ignore];
    [self.backView addSubview:self.agree];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(10, 15, 0, 15));
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(15);
        make.top.equalTo(self.backView).with.offset(10);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).with.offset(-15);
        make.top.equalTo(self.backView).with.offset(10);
        make.size.mas_offset(CGSizeMake(150, 60));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(300, 22));
    }];
    
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon);
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(110, 30));
    }];
    
    [self.ignore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-30)/2, 44));
    }];
    
    [self.agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-30)/2, 44));
    }];
    
    [super updateConstraints];
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:[UIColor whiteColor]];
        _backView.layer.cornerRadius = 5;
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:RGB(222, 222, 222)];
        [_backView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_backView);
            make.bottom.equalTo(_backView.mas_bottom).with.offset(-44);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 0.33));
        }];
        _backView.layer.shadowColor = RGB(65, 119, 255).CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, 0);
        _backView.layer.shadowOpacity = 0.1f;
        _backView.layer.shadowRadius = 5.0f;
    }
    return _backView;
}

- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.layer.masksToBounds = YES;
        _headIcon.layer.cornerRadius = 30;
        _headIcon.backgroundColor = [UIColor greenColor];
    }
    return _headIcon;
}

- (UILabel *)message {
    if (!_message) {
        _message = [[UILabel alloc] init];
        _message.font = [UIFont systemFontOfSize:12];
        _message.textAlignment = NSTextAlignmentRight;
        _message.textColor = RGB(200, 200, 200);
        _message.numberOfLines = 0;
        _message.text = @"我于杀戮之中盛放，亦如黎明中的花朵。";
    }
    return _message;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        [_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [_name setText:@"戏命师·烬"];
    }
    return _name;
}

- (UIButton *)phoneNum {
    if (!_phoneNum) {
        _phoneNum = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneNum setImage:[UIImage imageNamed:@"Login_Phone"] forState:UIControlStateNormal];
        [_phoneNum setTitle:@"12345678910" forState:UIControlStateNormal];
        [_phoneNum setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_phoneNum.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _phoneNum.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _phoneNum.imageEdgeInsets = UIEdgeInsetsMake(6, 0, 6, 3);
    }
    return _phoneNum;
}

- (UIButton *)ignore {
    if (!_ignore) {
        _ignore = [self creatButtonWithTitle:@"忽略" tag:0 titleColor:RGB(200, 200, 200)];
    }
    return _ignore;
}

- (UIButton *)agree {
    if (!_agree) {
        _agree = [self creatButtonWithTitle:@"同意" tag:1 titleColor:RGB(65,119,255)];
    }
    return _agree;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title tag:(int)tag titleColor:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTag:tag];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        self.buttonClickBlock((int)x.tag);
    }];
    return button;
}


@end
