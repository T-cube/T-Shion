

//
//  FriendsHeadView.m
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "FriendsHeadView.h"

@implementation FriendsHeadView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FriendsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.backView];
    [self addSubview:self.title];
    [self addSubview:self.seachView];
    [self addSubview:self.validation];
    [self setBackgroundColor:RGB(234, 234, 234)];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.seachView.mas_top).with.offset(-11);
        make.left.equalTo(self.seachView);
        make.size.mas_offset(CGSizeMake(200, 22));
    }];
    
    [self.seachView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.offset(35);
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
    }];
    
    [self.validation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.seachView.mas_right);
        make.bottom.equalTo(self.seachView.mas_top);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:22];
        _title.text = @"通讯录";
    }
    return _title;
}

- (UIView *)seachView {
    if (!_seachView) {
        _seachView = [[UIView alloc] init];
        _seachView.layer.masksToBounds = YES;
        _seachView.layer.cornerRadius = 3;
        _seachView.backgroundColor = [UIColor whiteColor];
        UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dialogue_Search"]];
        [_seachView addSubview:searchImage];
        [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_seachView).with.offset(5);
            make.centerY.equalTo(_seachView);
            make.size.mas_offset(CGSizeMake(25, 25));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            [self.viewModel.searchClickSubject sendNext:nil];
        }];
        [_seachView addGestureRecognizer:tap];
    }
    return _seachView;
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] init];
        UIImage *image = [[UIImage imageNamed:@"Friends_Header_Image"] resizableImageWithCapInsets:UIEdgeInsetsMake(173, 1, 1, 332) resizingMode:UIImageResizingModeStretch];
        _backView.image = image;
    }
    return _backView;
}

- (UIButton *)validation {
    if (!_validation) {
        _validation = [UIButton buttonWithType:UIButtonTypeCustom];
        [_validation setTitle:@"验证信息" forState:UIControlStateNormal];
        [_validation.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_validation setTitleColor:RGB(65, 119, 255) forState:UIControlStateNormal];
        @weakify(self)
        [[_validation rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.validationClickSubject sendNext:nil];
        }];
    }
    return _validation;
}
@end
