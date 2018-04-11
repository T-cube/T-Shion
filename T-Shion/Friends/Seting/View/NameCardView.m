//
//  NameCardView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "NameCardView.h"
#import "SettingViewModel.h"

#define  topEdge   15.0
#define  paddingEdge   20.0f

@interface NameCardView ()

@property (strong , nonatomic) UIView *whiteBgView;

@property (strong , nonatomic) UILabel *phoneLabel;

@property (strong , nonatomic) UILabel *nameLabel;

@property (strong , nonatomic) UIImageView *avatarView;

@property (strong , nonatomic) UIImageView *phoneFlagView;

@property (strong , nonatomic) UIButton *codeButton;

@property (strong , nonatomic) UIButton *shareButton;

@property (strong , nonatomic) UIButton *videoButton;

@property (strong , nonatomic) UIButton *callButton;

@property (strong , nonatomic) SettingViewModel *viewModel;

@end

@implementation NameCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DEFAULT_COLOR;
        [self setupViews];
    }
    return self;
}


#pragma mark - private
- (void)setupViews {
    [self addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.avatarView];
    [self.whiteBgView addSubview:self.codeButton];
    [self.whiteBgView addSubview:self.nameLabel];
    [self.whiteBgView addSubview:self.phoneFlagView];
    [self.whiteBgView addSubview:self.phoneLabel];
    [self.whiteBgView addSubview:self.shareButton];
    [self.whiteBgView addSubview:self.videoButton];
    [self.whiteBgView addSubview:self.callButton];
}
#pragma mark - system
- (void)layoutSubviews {
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(topEdge, topEdge, topEdge, topEdge));
    }];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.whiteBgView).with.offset(paddingEdge);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_top);
        make.right.equalTo(self.whiteBgView.mas_right).with.offset(-paddingEdge);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(paddingEdge);
        make.left.equalTo(self.avatarView.mas_left);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-100, 19));
    }];
    
    [self.phoneFlagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.whiteBgView).with.offset(-17);
        make.left.equalTo(self.avatarView.mas_left);
        make.size.mas_equalTo(CGSizeMake(10, 15));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneFlagView.mas_right).with.offset(7);
        make.centerY.equalTo(self.phoneFlagView);
        make.size.mas_offset(CGSizeMake(100, 13));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteBgView.mas_right).with.offset(-paddingEdge);
        make.bottom.equalTo(self.whiteBgView).offset(-18);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareButton.mas_left).with.offset(-paddingEdge);
        make.centerY.equalTo(self.shareButton);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.videoButton.mas_left).with.offset(-paddingEdge);
        make.centerY.equalTo(self.shareButton);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [super layoutSubviews];
}

- (void)setIsOneself:(BOOL)isOneself {
    self.shareButton.hidden = self.videoButton.hidden = self.callButton.hidden = isOneself;
}
#pragma mark - getter and setter
- (UIView *)whiteBgView {
    if (!_whiteBgView) {
        _whiteBgView = [[UIView alloc] init];
        _whiteBgView.backgroundColor = [UIColor TSWhiteColor];
        _whiteBgView.layer.cornerRadius = 3.0f;
        _whiteBgView.layer.shadowOpacity = 0.7;
        _whiteBgView.layer.shadowRadius = 7.5;
        _whiteBgView.layer.shadowColor = RGB(222, 231, 239).CGColor;
        _whiteBgView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _whiteBgView;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.backgroundColor = [UIColor redColor];
        _avatarView.layer.cornerRadius = 25;
        _avatarView.layer.borderWidth = 1;
        _avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarView.layer.shadowOpacity = 0.7;
        _avatarView.layer.shadowRadius = 4.0;
        _avatarView.layer.shadowColor = RGB(220, 226, 233).CGColor;
        _avatarView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return _avatarView;
}

- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [self creatButtonWithImage:@"Seting_QRCode_Icon" tag:3];
    }
    return _codeButton;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textColor = [UIColor TSTextDarkColor];
        _nameLabel.text = @"just let me go";
    }
    return _nameLabel;
}

- (UIImageView *)phoneFlagView {
    if (!_phoneFlagView) {
        _phoneFlagView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Seting_Phone_Icon"]];
    }
    return _phoneFlagView;
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.textColor = [UIColor TSTextLightColor];
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        _phoneLabel.text = @"18650019090";
    }
    return _phoneLabel;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [self creatButtonWithImage:@"Seting_Push_Icon" tag:2];
    }
    return _shareButton;
}

- (UIButton *)videoButton {
    if (!_videoButton) {
        _videoButton = [self creatButtonWithImage:@"Seting_Video_Icon" tag:1];
    }
    return _videoButton;
}

- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [self creatButtonWithImage:@"Seting_Calling_Icon" tag:0];
    }
    return _callButton;
}

- (void)setInfoModel:(UserInfoModel *)infoModel {
    _infoModel = infoModel;
}


- (UIButton *)creatButtonWithImage:(NSString *)image tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTag:tag];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        int index = (int)x.tag;
        self.buttonClickBlock(index);
    }];
    return button;
}
@end
