//
//  RegisterFifthViewController.m
//  T-Shion
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "RegisterFifthViewController.h"

@interface RegisterFifthViewController ()
@property (strong, nonatomic) UILabel *navTitle;

@property (strong, nonatomic) UIImageView *headIcon;

@property (strong, nonatomic) UIButton *camera;

@property (strong, nonatomic) UIButton *nextStep;
@end

@implementation RegisterFifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addChildView {
    [self.view addSubview:self.navTitle];
    [self.view addSubview:self.headIcon];
    [self.view addSubview:self.camera];
    [self.view addSubview:self.nextStep];
}


- (void)viewDidLayoutSubviews {
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(200, 33));
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.navTitle.mas_bottom).with.offset(51);
        make.size.mas_offset(CGSizeMake(150, 150));
    }];
    
    [self.camera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).with.offset(36);
        make.bottom.equalTo(self.headIcon.mas_bottom);
        make.size.mas_offset(CGSizeMake(32, 26));
    }];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 44));
    }];
    [super viewDidLayoutSubviews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UILabel *)navTitle {
    if (!_navTitle) {
        _navTitle = [[UILabel alloc] init];
        _navTitle.font = [UIFont systemFontOfSize:20];
        _navTitle.text = @"设置头像";
    }
    return _navTitle;
}

- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.backgroundColor = RGB(234, 234, 234);
        _headIcon.layer.masksToBounds = YES;
        _headIcon.layer.cornerRadius = 75;
    }
    return _headIcon;
}

- (UIButton *)camera {
    if (!_camera) {
        _camera = [UIButton buttonWithType:UIButtonTypeCustom];
        [_camera setImage:[UIImage imageNamed:@"Register_Camera"] forState:UIControlStateNormal];
    }
    return _camera;
}

- (UIButton *)nextStep {
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStep setTitle:@"完成" forState:UIControlStateNormal];
        [_nextStep.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _nextStep.layer.cornerRadius = 3;
        _nextStep.layer.masksToBounds = YES;
        _nextStep.backgroundColor = RGB(56, 145, 255);
        @weakify(self)
        [[_nextStep rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.navigationController popToRootViewControllerAnimated:YES];

        }];
    }
    return _nextStep;
}

- (void)dealloc {
    NSLog(@"注册五界面释放了");
}
@end
