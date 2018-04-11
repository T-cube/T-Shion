//
//  FriendsTableViewCell.m
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "FriendsTableViewCell.h"

@implementation FriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self.contentView setBackgroundColor:RGB(234, 234, 234)];
    [self setBackgroundColor:RGB(234, 234, 234)];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.icon];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.calling];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(36);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-36);
        make.height.offset(70);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.left.equalTo(self.backView).with.offset(10);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(11);
        make.centerY.equalTo(self.backView);
        make.right.equalTo(self.calling.mas_right);
        make.height.offset(20);
    }];
    
    [self.calling mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.name);
        make.right.equalTo(self.backView.mas_right).with.offset(-13);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];

    [super updateConstraints];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:RGB(248, 247, 247)];
        _backView.layer.cornerRadius = 3;
        _backView.layer.shadowColor = RGB(222, 231, 239).CGColor;
        _backView.layer.shadowOpacity = 0.7f;
        _backView.layer.shadowRadius = 4.0f;
        _backView.layer.shadowOffset = CGSizeMake(0,0);
    }
    return _backView;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor greenColor];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 20;
        _icon.layer.borderWidth = 1;
        _icon.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"Just let me go";
        _name.font = [UIFont systemFontOfSize:13];
        _name.textColor = RGB(64, 64, 64);
    }
    return _name;
}

- (UIButton *)calling {
    if (!_calling) {
        _calling = [UIButton buttonWithType:UIButtonTypeCustom];
        [_calling setImage:[UIImage imageNamed:@"Friends_Calling"] forState:UIControlStateNormal];
        @weakify(self)
        [[_calling rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.cellClickBlock();
        }];
    }
    return _calling;
}



@end
