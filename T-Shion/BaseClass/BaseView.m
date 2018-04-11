//
//  BaseView.m
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()
@property(nonatomic,strong) UIImageView *loadingFail;
@property(nonatomic,strong) UILabel *promptLabel;
@end

@implementation BaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        [self setupViews];
        [self bindViewModel];
    }
    return self;
}


- (void)bindViewModel {

}

- (void)setupViews {

}

- (void)hiddenLoadingFailed {
    [self.loadingFail setHidden:YES];
    [self.promptLabel setHidden:YES];
}

- (void)loadingFailed {
    [self.loadingFail setHidden:NO];
    [self.promptLabel setHidden:NO];
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc]init];
        _promptLabel.text = @"暂无数据";
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont systemFontOfSize:20];
        _promptLabel.hidden = YES;
        
    }
    return _promptLabel;
}

- (UIImageView *)loadingFail {
    if (!_loadingFail) {
        _loadingFail = [[UIImageView alloc] init];
        _loadingFail.image = [UIImage imageNamed:@"LoadingFailed_View"];
        _loadingFail.hidden = YES;
    }
    return _loadingFail;
}
@end
