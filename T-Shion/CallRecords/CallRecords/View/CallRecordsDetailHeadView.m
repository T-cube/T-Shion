//
//  CallRecordsDetailHeadView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsDetailHeadView.h"
#import "NameCardView.h"
#import "SettingViewModel.h"

@interface CallRecordsDetailHeadView ()

@property (strong , nonatomic) UILabel *titleLabel;
@property (strong , nonatomic) NameCardView *nameCardView;

@end

@implementation CallRecordsDetailHeadView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.nameCardViewModel = (SettingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    self.backgroundColor = [UIColor TSKeyBackgroundColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.nameCardView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(30);
    }];
    
    [self.nameCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - getter and setter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:21];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor TSTextDarkColor];
        _titleLabel.text = @"通话详情";
    }
    return _titleLabel;
}

- (NameCardView *)nameCardView {
    if (!_nameCardView) {
        _nameCardView = [[NameCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    }
    return _nameCardView;
}

@end
