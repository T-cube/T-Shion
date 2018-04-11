//
//  LoginViewModel.m
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
- (void)initialize {
    @weakify(self)
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.getInfoCommand execute:nil];
    }];
    
    [self.getInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.loginSubject sendNext:x];
    }];
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest postRequetWithApi:@"/oauth/token" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            NSLog(@"登录成功data=%@",data);
                            [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"access_token"] forKey:@"access_token"];
                            [subscriber sendNext:data];
                        }else {
                            NSLog(@"%@",error);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

- (RACCommand *)getInfoCommand {
    if (!_getInfoCommand) {
        _getInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest getRequetWithApi:@"/api/user/info" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            NSLog(@"获取个人信息成功data=%@",data);
                            [subscriber sendNext:data];
                        }else {
                            NSLog(@"%@",error);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getInfoCommand;
}

- (RACSubject *)buttonClickSubject {
    if (!_buttonClickSubject) {
        _buttonClickSubject = [RACSubject subject];
    }
    return _buttonClickSubject;
}

- (RACSubject *)forgetClickSubject {
    if (!_forgetClickSubject) {
        _forgetClickSubject = [RACSubject subject];
    }
    return _forgetClickSubject;
}

- (RACSubject *)loginSubject {
    if (!_loginSubject) {
        _loginSubject = [RACSubject subject];
    }
    return _loginSubject;
}

@end
