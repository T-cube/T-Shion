//
//  AboutUsViewController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (strong , nonatomic) UILabel *titleLabel;
@property (strong , nonatomic) UILabel *agreementLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.agreementLabel];
    
    __weak typeof(self) weakSelf = self;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(15);
        make.left.equalTo(weakSelf.view).offset(25);
    }];
    
    [self.agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(-30);
        make.centerX.equalTo(weakSelf.view);
    }];
}

- (void)tapAction:(UIGestureRecognizer *)sender {
    NSLog(@"-------去服务条款");
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor TSTextDarkColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"关于TShion";
        _titleLabel.font = [UIFont systemFontOfSize:21];
    }
    return _titleLabel;
}

- (UILabel *)agreementLabel {
    if (!_agreementLabel) {
        _agreementLabel = [[UILabel alloc] init];
        _agreementLabel.textColor = RGB(81,143,255);
        _agreementLabel.textAlignment = NSTextAlignmentCenter;
        _agreementLabel.text = @"TShion服务条款";
        _agreementLabel.font = [UIFont systemFontOfSize:13];
        
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_agreementLabel addGestureRecognizer:tapGesturRecognizer];
        _agreementLabel.userInteractionEnabled = YES;
    }
    return _agreementLabel;
}

@end
