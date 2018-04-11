//
//  RegisterViewModel.h
//  T-Shion
//
//  Created by together on 2018/4/4.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseViewModel.h"

@interface RegisterViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *sendVerificationCodeCommand;//发送验证码
@property (strong, nonatomic) RACCommand *registerCommand;//注册
@property (strong, nonatomic) RACCommand *loginCommand;//登录
@property (strong, nonatomic) RACCommand *setNickNameCommand;//设置昵称
@property (strong, nonatomic) RACCommand *setHeadIconCommand;//设置头像

@property (strong, nonatomic) RACSubject *verificationSuccessSubject;//验证码成功回调
@property (strong, nonatomic) RACSubject *registerSubject;//注册成功回调
@property (strong, nonatomic) RACSubject *loginSubject;//登录成功回调
@property (strong, nonatomic) RACSubject *setNickNameSubject;//设置昵称成功回调
@property (strong, nonatomic) RACSubject *setHeadIconSubject;//设置头像成功回调
@end
