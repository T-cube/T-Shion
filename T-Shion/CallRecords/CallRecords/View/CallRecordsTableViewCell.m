//
//  CallRecordsTableViewCell.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsTableViewCell.h"

@interface CallRecordsTableViewCell ()

@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UIView *bgVIew;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIImageView *typeFlagView;
@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *timeLabel;
//@property (strong, nonatomic) UILabel *messageNumLabel;
//@property (strong, nonatomic) UIView *messageNumView;
@property (strong, nonatomic) UIButton *detailBtn;

@end


@implementation CallRecordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self.contentView setBackgroundColor:[UIColor TSKeyBackgroundColor]];
    [self setBackgroundColor:[UIColor TSKeyBackgroundColor]];
    
    [self.contentView addSubview:self.bgVIew];
    [self.contentView addSubview:self.avatarView];
    [self.bgVIew addSubview:self.timeLabel];
    [self.bgVIew addSubview:self.nameLabel];
    [self.bgVIew addSubview:self.typeFlagView];
    [self.bgVIew addSubview:self.typeLabel];
    [self.bgVIew addSubview:self.detailBtn];
}

- (void)layoutSubviews {
    if (IOS_Version_11) {
        for (UIView *subview in self.subviews) {
            if([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
                UIView *swipeActionPullView = subview;
                //1.0修改背景颜色
                swipeActionPullView.backgroundColor = [UIColor TSKeyBackgroundColor];
                
                //2.0修改按钮-颜色
                UIVisualEffectView *moreBtn = subview.subviews[0];
                if ([moreBtn isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
                    moreBtn.layer.cornerRadius = 3.0f;
                    moreBtn.layer.masksToBounds = YES;
                    CGFloat moreBtnX = moreBtn.frame.origin.x;
                    moreBtn.frame = CGRectMake(moreBtnX, 10, 60, 71);
                    moreBtn.backgroundColor = RGB(187, 187, 187);
                }
            }
        }
    }

    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(52, 52));
    }];
    
    [self.bgVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(30);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.offset(71);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarView.mas_right).with.offset(10);
        make.top.equalTo(self.bgVIew.mas_top).with.offset(10);
        make.right.equalTo(self.bgVIew);
        make.height.offset(14);
    }];
    
    [self.typeFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.avatarView.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(10, 10));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeFlagView.mas_right).with.offset(6);
        make.right.equalTo(self.bgVIew);
        make.height.offset(10);
        make.centerY.equalTo(self.typeFlagView.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgVIew.mas_right).with.offset(-40);
        make.top.equalTo(self.bgVIew).with.offset(12);
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgVIew.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(26, 26));
        make.top.mas_equalTo(22);
    }];
    [super layoutSubviews];
}

#pragma mark - getter and setter

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.layer.cornerRadius = 26;
        _avatarView.backgroundColor = [UIColor greenColor];
        _avatarView.layer.borderWidth = 2;
        _avatarView.layer.borderColor = [UIColor TSWhiteColor].CGColor;
        _avatarView.layer.shadowColor = RGB(220,226,233).CGColor;
        _avatarView.layer.shadowOpacity = 0.9f;
        _avatarView.layer.shadowRadius = 2.5f;
        _avatarView.layer.shadowOffset = CGSizeMake(0,0);

    }
    return _avatarView;
}

- (UIView *)bgVIew {
    if (!_bgVIew) {
        _bgVIew = [[UIView alloc] init];
        _bgVIew.layer.cornerRadius = 3;
        _bgVIew.layer.shadowColor = RGB(220,226,233).CGColor;
        _bgVIew.layer.shadowOpacity = 0.7f;
        _bgVIew.layer.shadowRadius = 4.0f;
        _bgVIew.layer.shadowOffset = CGSizeMake(0,0);
        _bgVIew.backgroundColor = [UIColor TSWhiteColor];
    }
    return _bgVIew;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"群组头像显示";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor TSTextNormalColor];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"10:23PM";
        _timeLabel.textColor = [UIColor TSTextGrayColor];
    }
    return _timeLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:10];
        _typeLabel.text = @"呼出电话";
        _typeLabel.textColor = [UIColor TSTextGrayColor];
    }
    return _typeLabel;
}

- (UIImageView *)typeFlagView {
    if (!_typeFlagView) {
        _typeFlagView = [[UIImageView alloc] init];
        _typeFlagView.backgroundColor = [UIColor redColor];
    }
    return _typeFlagView;
}

//- (UIView *)messageNumView {
//    if (!_messageNumView) {
//        _messageNumView = [[UIView alloc] init];
//        _messageNumView.backgroundColor = RGB(255,99,121);
//        _messageNumView.layer.cornerRadius = 13;
//        _messageNumView.layer.shadowColor = RGB(128,145,160).CGColor;
//        _messageNumView.layer.shadowOpacity = 0.5f;
//        _messageNumView.layer.shadowRadius = 2.0f;
//        _messageNumView.layer.shadowOffset = CGSizeMake(0,0);
//    }
//    return _messageNumView;
//}
//
//- (UILabel *)messageNumLabel {
//    if (!_messageNumLabel) {
//        _messageNumLabel = [[UILabel alloc] init];
//        _messageNumLabel.textColor = [UIColor TSWhiteColor];
//        _messageNumLabel.font = [UIFont systemFontOfSize:10];
//        _messageNumLabel.textAlignment = NSTextAlignmentCenter;
//        _messageNumLabel.text = @"12";
//    }
//    return _messageNumLabel;
//}

- (UIButton *)detailBtn {
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] init];
        _detailBtn.backgroundColor = [UIColor blueColor];
        _detailBtn.layer.masksToBounds = YES;
        _detailBtn.layer.cornerRadius = 13;
        @weakify(self);
        [[_detailBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
                      [self.viewModel.detaikClickSubject sendNext:self];
        }];
    }
    return _detailBtn;
}



@end
