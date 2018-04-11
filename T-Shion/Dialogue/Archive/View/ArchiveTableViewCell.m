//
//  ArchiveTableViewCell.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "ArchiveTableViewCell.h"

@implementation ArchiveTableViewCell

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
    [self.contentView addSubview:self.icon];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.content];
    [self.backView addSubview:self.time];
    [self.backView addSubview:self.archive];
    
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
        make.left.equalTo(self.backView).with.offset(-20);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(11);
        make.top.equalTo(self.icon).with.offset(5);
        make.right.equalTo(self.time.mas_right);
        make.height.offset(20);
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(11);
        make.top.equalTo(self.name.mas_bottom).with.offset(5);
        make.right.equalTo(self.time.mas_right);
        make.height.offset(20);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).with.offset(-11);
        make.top.equalTo(self.icon);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    
    [self.archive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_bottom).with.offset(5);
        make.right.equalTo(self.backView.mas_right).with.offset(-11);
        make.size.mas_offset(CGSizeMake(50, 22));
    }];
    
    [super updateConstraints];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:RGB(248, 247, 247)];
        _backView.layer.cornerRadius = 3;
        _backView.layer.shadowColor = RGB(222, 231, 239).CGColor;
        _backView.layer.shadowOpacity = 0.8f;
        _backView.layer.shadowRadius = 6.0f;
        _backView.layer.shadowOffset = CGSizeMake(0,0);
    }
    return _backView;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor greenColor];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 30;
        _icon.layer.borderWidth = 1;
        _icon.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"Just let me go";
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = RGB(64, 64, 64);
    }
    return _name;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.text = @"Just let me go to play";
        _content.font = [UIFont systemFontOfSize:10];
        _content.textColor = RGB(176,175,175);
    }
    return _content;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.text = @"13:33PM";
        _time.textAlignment = NSTextAlignmentRight;
        _time.font = [UIFont systemFontOfSize:10];
        _time.textColor = RGB(176,175,175);
    }
    return _time;
}

- (UIButton *)archive {
    if (!_archive) {
        _archive = [UIButton buttonWithType:UIButtonTypeCustom];
        [_archive.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [_archive setTitleColor:RGB(255,99,121) forState:UIControlStateNormal];
        [_archive setTitle:@"归档" forState:UIControlStateNormal];
        [_archive setTitle:@"已归档" forState:UIControlStateSelected];
        _archive.layer.cornerRadius = 3;
        _archive.layer.borderWidth = 0.4;
        _archive.layer.borderColor = RGB(255,99,121).CGColor;
        @weakify(self)
        [[_archive rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.archiveBlock();
        }];
    }
    return _archive;
}

@end
