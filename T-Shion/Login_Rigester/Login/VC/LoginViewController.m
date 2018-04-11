//
//  LoginViewController.m
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginView.h"
#import "RegisterViewController.h"
#import "LookingForPwdViewController.h"
#import "PomeloProtocol.h"

@interface LoginViewController ()
@property (strong, nonatomic) LoginView *mainView;
@property (strong, nonatomic) LoginViewModel *viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[SocketViewModel shared] connectWithToken:HostSocketUrl success:^{
        NSLog(@"成功");
        [self requestMainSocketUrl];
    } fail:^{
        NSLog(@"失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.buttonClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        switch ([x intValue]) {
            case 0: {
                NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
                [param setObject:@"password" forKey:@"grant_type"];
                [param setObject:@"com_tlifang_web" forKey:@"client_id"];
                [param setObject:@"Y=tREBruba$+uXeZaya=eThaD3hukuwu" forKey:@"client_secret"];
                [param setObject:self.mainView.phoneNum.text forKey:@"username"];
                [param setObject:self.mainView.pwd.text forKey:@"password"];
                [self.viewModel.loginCommand execute:param];
            }
                break;
            case 1: {
                RegisterViewController *registerVc = [[RegisterViewController alloc] init];
                [self.navigationController pushViewController:registerVc animated:YES];
            }
                break;
            default:
                break;
        }
        
    }];
    
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
//       @strongify(self)
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        [param setObject:@"ios" forKey:@"client"];
        [param setObject:@"fd90ebe3e930c2ef3cdf11b1d91b38f52f8d8c73" forKey:@"token"];
        [param setObject:@"5ac9c408a951af962e637d4b" forKey:@"uid"];
//        [[SocketViewModel shared].pomelo requestWithRoute:@"gate.gateHandler.queryEntry" andParams:param andCallback:cb];
    }];
    
    [[self.viewModel.forgetClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
//        LookingForPwdViewController *looking = [[LookingForPwdViewController alloc] init];
//        [self.navigationController pushViewController:looking animated:YES];
        [self requestMainSocketUrl];
    }];
}

- (void)requestMainSocketUrl {
//    @{@"client":@"ios",@"token":@"fd90ebe3e930c2ef3cdf11b1d91b38f52f8d8c73",@"uid":@"5ac9c408a951af962e637d4b"}
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:@"ios" forKey:@"client"];
    [param setObject:@"fd90ebe3e930c2ef3cdf11b1d91b38f52f8d8c73" forKey:@"token"];
    [param setObject:@"5ac9c408a951af962e637d4b" forKey:@"uid"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *endstring = [PomeloProtocol encodeWithId:0 andRoute:@"gate.gateHandler.queryEntry" andBody:string];
    [[SocketViewModel shared].client on:@"gate.gateHandler.queryEntry" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [[[SocketViewModel shared].client emitWithAck:@"gate.gateHandler.queryEntry" with:@[endstring]] timingOutAfter:10 callback:^(NSArray * _Nonnull data) {
            NSLog(@"%@",data);
        }];
        NSLog(@"%@",data);
    }];
    
//    [[SocketViewModel shared].client on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
//        double cur = [[data objectAtIndex:0] floatValue];
//
//        [[[SocketViewModel shared].client emitWithAck:@"canUpdate" with:@[@(cur)]] timingOutAfter:0 callback:^(NSArray* data) {
//            [[SocketViewModel shared].client emit:@"update" with:@[@{@"amount": @(cur + 2.50)}]];
//        }];
//
//        [ack with:@[@"Got your currentAmount, ", @"dude"]];
//    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (LoginView *)mainView {
    if (!_mainView) {
        _mainView = [[LoginView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc {
    NSLog(@"登录界面释放了");
}
@end
