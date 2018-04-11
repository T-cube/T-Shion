//
//  RegisterSecondViewController.m
//  T-Shion
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "RegisterSecondViewController.h"
#import "RegisterThirdViewController.h"
#import "RegisterViewModel.h"

@interface RegisterSecondViewController ()
@property (strong, nonatomic) UILabel *navTitle;

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIImageView *icon;

@property (strong, nonatomic) UILabel *verification;

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UIButton *nextStep;

@property (strong, nonatomic) RegisterViewModel *viewModel;

@property (assign, nonatomic) int timeOut;
@end

@implementation RegisterSecondViewController

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
    [self.view addSubview:self.verification];
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

- (void)bindViewModel {
    @weakify(self)
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:@"17689209921" forKey:@"mobile"];
//    NSString *hex = [RSA encryptString:@"17689209921" publicKey:RSAPublicKey];
//    //            [dic setObject:@"+86" forKey:@"nation_code"];
//    [dic setObject:hex forKey:@"hex"];
//    [self.viewModel.sendVerificationCodeCommand execute:dic];
    [self.viewModel.verificationSuccessSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [TShionSingleCase shared].timerLabel = self.verification;
    }];
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
        _navTitle.text = @"验证码";
    }
    return _navTitle;
}

- (UILabel *)verification {
    if (!_verification) {
        _verification = [[UILabel alloc] init];
        _verification.frame = CGRectMake(0, 0, 80, 30);
        [_verification setFont:[UIFont systemFontOfSize:13]];
        _verification.text = @"发送验证码";
        _verification.textColor = RGB(65, 119, 255);
        _verification.userInteractionEnabled = YES;
        @weakify(self)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:@"13606920527" forKey:@"mobile"];
//            [dic setObject:@"+86" forKey:@"nation_code"];
            NSString *hex = [RSA encryptString:@"13606920527" publicKey:RSAPublicKey];
            [dic setObject:hex forKey:@"hex"];
            [self.viewModel.sendVerificationCodeCommand execute:dic];
        }];
        [_verification addGestureRecognizer:tap];
    }
    return _verification;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField creatLoginTypeWithImage:@"Register_Validation_Code" placeholder:@"请输入您收到的验证码"];
        _textField.rightView = self.verification;
        _textField.rightViewMode = UITextFieldViewModeAlways;
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
            if (self.textField.text.length<4) {
                return;
            }
            RegisterThirdViewController *registerThird = [[RegisterThirdViewController alloc] init];
            registerThird.phone = self.telPhone;
            registerThird.verificationCode = self.textField.text;
            [self.navigationController pushViewController:registerThird animated:YES];
        }];
    }
    return _nextStep;
}

- (RegisterViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RegisterViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc {
    NSLog(@"注册二界面释放了");
}
@end
