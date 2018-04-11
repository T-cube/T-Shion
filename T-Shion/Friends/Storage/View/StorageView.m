//
//  StorageView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "StorageView.h"
#import "StorageViewModel.h"

@interface StorageView ()

@property (strong , nonatomic) StorageViewModel *viewModel;
@property (strong , nonatomic) UILabel *titleLabel;
@property (strong , nonatomic) UIView *whiteBGView;
@property (strong , nonatomic) UIProgressView *progressView;
@property (strong , nonatomic) UILabel *totalLabel;
@property (strong , nonatomic) UILabel *usedLabel;
@property (strong , nonatomic) UIButton *cleanBtn;

@end


@implementation StorageView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (StorageViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - private
- (void)setupViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.whiteBGView];
    [self addSubview:self.cleanBtn];
    [self.whiteBGView addSubview:self.progressView];
    [self.whiteBGView addSubview:self.totalLabel];
    [self.whiteBGView addSubview:self.usedLabel];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(25);
    }];
    
    [self.whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_offset(106);
    }];
    
    [self.cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteBGView.mas_bottom).offset(80);
        make.size.mas_offset(CGSizeMake(150, 40));
        make.centerX.equalTo(self);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteBGView).offset(40);
        make.left.equalTo(self.whiteBGView).offset(20);
        make.height.mas_offset(8);
        make.width.mas_offset(200);
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_left);
        make.top.equalTo(self.progressView.mas_bottom).offset(17);
    }];
    
    [self.usedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalLabel.mas_right).offset(30);
        make.top.equalTo(self.totalLabel.mas_top);
    }];
    
    [super updateConstraints];
}

#pragma mark - getter and setter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:21];
        _titleLabel.textColor = [UIColor TSTextDarkColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"存储空间";
    }
    
    return _titleLabel;
}

- (UIView *)whiteBGView {
    if (!_whiteBGView) {
        _whiteBGView = [[UIView alloc] init];
        _whiteBGView.layer.cornerRadius = 3;
        _whiteBGView.layer.masksToBounds = YES;
        _whiteBGView.backgroundColor = [UIColor TSWhiteColor];
        _whiteBGView.layer.shadowColor = RGB(220,226,233).CGColor;
        _whiteBGView.layer.shadowOpacity = 0.7f;
        _whiteBGView.layer.shadowRadius = 4.0f;
        _whiteBGView.layer.shadowOffset = CGSizeMake(0,0);
    }
    
    return _whiteBGView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = [UIColor TSBlueColor];
        _progressView.trackTintColor = [UIColor TSKeyBackgroundColor];
        _progressView.layer.masksToBounds = YES;
        _progressView.layer.cornerRadius = 4;
    }
    return _progressView;
}

- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.textColor = [UIColor TSTextGrayColor];
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        _totalLabel.font = [UIFont systemFontOfSize:12];
        _totalLabel.text = @"总可用空间：40G";
    }
    return _totalLabel;
}

- (UILabel *)usedLabel {
    if (!_usedLabel) {
        _usedLabel = [[UILabel alloc] init];
        _usedLabel.textColor = [UIColor TSTextGrayColor];
        _usedLabel.textAlignment = NSTextAlignmentLeft;
        _usedLabel.font = [UIFont systemFontOfSize:12];
        _usedLabel.text = @"TShion占用空间100M";
    }
    return _usedLabel;
}

- (UIButton *)cleanBtn {
    if (!_cleanBtn) {
        _cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cleanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_cleanBtn setTitle:@"清理存储空间" forState:UIControlStateNormal];
        [_cleanBtn setTitleColor:[UIColor TSBlueColor] forState:UIControlStateNormal];
        @weakify(self)
        [[_cleanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.cleanSubject sendNext:@""];
        }];
    }
    return _cleanBtn;
}

- (void)setProgressValue:(double)progressValue {
    _progressValue = progressValue;
    [_progressView setProgress:progressValue animated:YES];
//    _progressView.progress = progressValue;
}

@end
