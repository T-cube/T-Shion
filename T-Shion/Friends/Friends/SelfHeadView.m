//
//  SelfHeadView.m
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "SelfHeadView.h"

@implementation SelfHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.icon];
        [self.backView addSubview:self.name];
        [self.backView addSubview:self.phoneNum];
    }
    return self;
}


- (void)layoutSubviews {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.centerY.equalTo(self.backView);
        make.size.mas_offset(CGSizeMake(55, 55));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(35.5);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.height.offset(68);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).with.offset(15);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.right.equalTo(self.backView.mas_right);
        make.height.offset(15);
    }];
    
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
        make.left.equalTo(self.name);
        make.right.equalTo(self.backView.mas_right);
        make.height.offset(12);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 27.5;
        _icon.backgroundColor = [UIColor greenColor];
        _icon.layer.borderWidth = 1;
        _icon.layer.borderColor = [UIColor whiteColor].CGColor;
        _icon.layer.shadowColor = [UIColor whiteColor].CGColor;
        _icon.layer.shadowOpacity = 0.6f;
        _icon.layer.shadowRadius = 5.0f;
        _icon.layer.shadowOffset = CGSizeMake(0,0);
        
    }
    return _icon;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:RGB(58, 130, 255)];
        _backView.layer.cornerRadius = 3;
        _backView.layer.shadowColor = RGB(147, 180, 240).CGColor;
        _backView.layer.shadowOpacity = 0.6f;
        _backView.layer.shadowRadius = 5.0f;
        _backView.layer.shadowOffset = CGSizeMake(0,5);
    }
    return _backView;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:15];
        _name.textColor = RGB(230,254,255);
        _name.text = @"just let me go";
    }
    return _name;
}

- (UILabel *)phoneNum {
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc] init];
        _phoneNum.font = [UIFont systemFontOfSize:12];
        _phoneNum.textColor = RGB(230,254,255);
        _phoneNum.text = @"本机号码:+86 13456789921";
    }
    return _phoneNum;
}
@end
