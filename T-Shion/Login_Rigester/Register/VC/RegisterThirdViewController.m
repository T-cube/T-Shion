//
//  RegisterThirdViewController.m
//  T-Shion
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "RegisterThirdViewController.h"
#import "RegisterFourthViewController.h"
#import "RegisterViewModel.h"

@interface RegisterThirdViewController ()
@property (strong, nonatomic) UILabel *navTitle;

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIButton *areaCode;

@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) UIButton *nextStep;

@property (strong, nonatomic) RegisterViewModel *viewModel;
@end

@implementation RegisterThirdViewController

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

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.registerSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:@"password" forKey:@"grant_type"];
        [param setObject:@"com_tlifang_web" forKey:@"client_id"];
        [param setObject:@"Y=tREBruba$+uXeZaya=eThaD3hukuwu" forKey:@"client_secret"];
        [param setObject:self.phone forKey:@"username"];
        [param setObject:self.textField.text forKey:@"password"];
        [self.viewModel.loginCommand execute:param];
    }];
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        RegisterFourthViewController *registerSecond = [[RegisterFourthViewController alloc] init];
        [self.navigationController pushViewController:registerSecond animated:YES];
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
        _navTitle.text = @"输入密码";
    }
    return _navTitle;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField creatLoginTypeWithImage:@"Login_Pwd" placeholder:@"请输入密码"];
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
            if (self.textField.text.length<6) {
                return ;
            }
            NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
            [param setObject:self.verificationCode forKey:@"code"];
            [param setObject:self.phone forKey:@"mobile"];
            [param setObject:self.textField.text forKey:@"password"];
            [param setObject:@"mobile" forKey:@"type"];
            [self.viewModel.registerCommand execute:param];
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
    NSLog(@"注册三界面释放了");
}
@end

