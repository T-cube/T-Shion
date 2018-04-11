//
//  OhterInformationTableViewCell.m
//  T-Shion
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "OtherInformationTableViewCell.h"

@implementation OtherInformationFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setupViews {
    self.backgroundColor = DEFAULT_COLOR;
    [self addSubview:self.title];
    [self addSubview:self.noteName];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    
    [self.noteName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor =RGB(64, 64, 64);
    }
    return _title;
}

- (UITextField *)noteName {
    if (!_noteName) {
        _noteName = [[UITextField alloc] init];
        _noteName.textAlignment = NSTextAlignmentRight;
        _noteName.font = [UIFont systemFontOfSize:13];
        _noteName.textColor = RGB(153, 153, 153);
        _noteName.text = @"哈哈哈哈哈哈根达斯";
    }
    return _noteName;
}
@end

@implementation OtherInformationNormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self addSubview:self.title];
    self.backgroundColor = DEFAULT_COLOR;
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    [super updateConstraints];
}
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor =RGB(64, 64, 64);
    }
    return _title;
}
@end


@implementation OtherInformationSwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setupViews {
    self.backgroundColor = DEFAULT_COLOR;
    [self addSubview:self.title];
    [self addSubview:self.switchBtn];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.size.mas_offset(CGSizeMake(52, 30));
    }];
    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor =RGB(64, 64, 64);
    }
    return _title;
}

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        _switchBtn.onTintColor = RGB(65, 119, 255);
        _switchBtn.thumbTintColor = [UIColor whiteColor];
    }
    return _switchBtn;
}
@end

