//
//  RegisterViewController.m
//  T-Shion
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterSecondViewController.h"

@interface RegisterViewController ()
@property (strong, nonatomic) UILabel *navTitle;

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIButton *areaCode;

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UIButton *nextStep;
@end

@implementation RegisterViewController

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
    [self.view addSubview:self.textField];
    [self.view addSubview:self.nextStep];
}


- (void)viewDidLayoutSubviews {
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.top.equalTo(self.view);
        make.size.mas_offset(CGSizeMake(200, 33));
    }];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.navTitle.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 44));
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
        _navTitle.text = @"注册";
    }
    return _navTitle;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 3;
        _backView.layer.borderWidth = 0.5f;
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _backView;
}


- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField creatLoginTypeWithImage:@"Login_Phone" placeholder:@"请输入您的手机号"];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}

- (UIButton *)nextStep {
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStep.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _nextStep.layer.cornerRadius = 3;
        _nextStep.layer.masksToBounds = YES;
        _nextStep.backgroundColor = RGB(56, 145, 255);
        @weakify(self)
        [[_nextStep rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.textField.text.length != 11) {
                return ;
            }
            RegisterSecondViewController *registerSecond = [[RegisterSecondViewController alloc] init];
            registerSecond.telPhone = self.textField.text;
            [self.navigationController pushViewController:registerSecond animated:YES];
        }];
    }
    return _nextStep;
}

- (void)dealloc {
    NSLog(@"注册一界面释放了");
}
@end
