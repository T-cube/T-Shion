    //
//  RegisterViewModel.m
//  T-Shion
//
//  Created by together on 2018/4/4.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel
- (void)initialize {
    @weakify(self)
    [self.sendVerificationCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.verificationSuccessSubject sendNext:nil];
    }];
    
    [self.registerCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.registerSubject sendNext:nil];
    }];
    
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.loginSubject sendNext:nil];
    }];
    
    [self.setNickNameCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.setNickNameSubject sendNext:nil];
    }];
    
    [self.setHeadIconCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.setHeadIconSubject sendNext:nil];
    }];
}

- (RACCommand *)sendVerificationCodeCommand {
    if (!_sendVerificationCodeCommand) {
        _sendVerificationCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest postRequetWithApi:@"/api/account/send-sms" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            NSLog(@"验证码发送成功");
                            [subscriber sendNext:nil];
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
    return _sendVerificationCodeCommand;
}

- (RACCommand *)registerCommand {
    if (!_registerCommand) {
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest postRequetWithApi:@"/api/account/register" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            NSLog(@"注册成功");
                            [subscriber sendNext:nil];
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
    return _registerCommand;
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest postRequetWithApi:@"/oauth/token" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            NSLog(@"登录成功");
                            [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"access_token"] forKey:@"access_token"];
                            [subscriber sendNext:nil];
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

- (RACCommand *)setNickNameCommand {
    if (!_setNickNameCommand) {
        _setNickNameCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest postRequetWithApi:@"/api/user/info" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            NSLog(@"设置昵称成功");
                            [subscriber sendNext:nil];
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
    return _setNickNameCommand;
}

- (RACCommand *)setHeadIconCommand {
    if (!_setHeadIconCommand) {
        _setHeadIconCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    id data = [TSRequest postRequetWithApi:@"/api/user/avatar/upload" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            NSLog(@"设置头像成功");
                            [subscriber sendNext:nil];
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
    return _setHeadIconCommand;
}

- (RACSubject *)verificationSuccessSubject {
    if (!_verificationSuccessSubject) {
        _verificationSuccessSubject = [RACSubject subject];
    }
    return _verificationSuccessSubject;
}

- (RACSubject *)registerSubject {
    if (!_registerSubject) {
        _registerSubject = [RACSubject subject];
    }
    return _registerSubject;
}

- (RACSubject *)loginSubject {
    if (!_loginSubject) {
        _loginSubject = [RACSubject subject];
    }
    return _loginSubject;
}

- (RACSubject *)setNickNameSubject {
    if (!_setNickNameSubject) {
        _setNickNameSubject = [RACSubject subject];
    }
    return _setNickNameSubject;
}

- (RACSubject *)setHeadIconSubject {
    if (!_setHeadIconSubject) {
        _setHeadIconSubject = [RACSubject subject];
    }
    return _setHeadIconSubject;
}
@end
