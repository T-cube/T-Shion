//
//  TShionSingleCase.m
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TShionSingleCase.h"

static TShionSingleCase *singleCase;

@implementation TShionSingleCase
+ (TShionSingleCase *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleCase = [[TShionSingleCase alloc] init];
    });
    return singleCase;
}
#pragma mark  method
- (void)verificationCodeCountdown {
    self.countdownSeconds ++;
    if (self.countdownSeconds == 60) {
        self.countdownSeconds = 0;
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        _timerLabel.text = @"获取验证码";
        _timerLabel.userInteractionEnabled = YES;
        _timerLabel = nil;
    } else {
        _timerLabel.text = [NSString stringWithFormat:@"%d秒",60-self.countdownSeconds];
    }
    
}

- (void)setTimerLabel:(UILabel *)timerLabel {
    _timerLabel = timerLabel;
    _timerLabel.userInteractionEnabled = NO;
    [self.countdownTimer timeInterval];
}

//+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum{
//    /* 手机号码
//     * 移动:134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通:130,131,132,152,155,156,185,186 * 电信:133,1349,153,180,189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])//d{8}$";
//    /* 10
//     * 中国移动:China Mobile 11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188 12
//     */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])//d)//d{7}$";
//    /** 15
//     * 中国联通:China Unicom 16 * 130,131,132,152,155,156,185,186 17
//     */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])//d{8}$";
//    /** 20
//     * 中国电信:China Telecom 21 * 133,1349,153,177,180,189 22
//     */
//    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)//d{7}$";
//    /** 25
//     * 大陆地区固话及小灵通 26
//     * 区号:010,020,021,022,023,024,025,027,028,029 27
//     * 号码:七位或八位 28
//     */
//    //NSString * PHS = @"^0(10|2[0-5789]|//d{3})//d{7,8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    if(([regextestmobile evaluateWithObject:cellNum] == YES) || ([regextestcm evaluateWithObject:cellNum] == YES) || ([regextestct evaluateWithObject:cellNum] == YES) || ([regextestcu evaluateWithObject:cellNum] == YES)){
//        return YES;
//    } else {
//        return NO;
//    }
//}

#pragma mark  懒加载
- (TabBarViewController *)main {
    if (!_main) {
        _main = [[TabBarViewController alloc] init];
    }
    return _main;
}

- (FriendsView *)friends {
    if (!_friends) {
        _friends = [[FriendsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _friends;
}

- (CGFloat)navigationBarHeight {
    if (!_navigationBarHeight) {
        _navigationBarHeight = KIsiPhoneX == YES ? 88 : 64;
    }
    return _navigationBarHeight;
}

- (NSTimer *)countdownTimer {
    if (!_countdownTimer) {
        _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(verificationCodeCountdown) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:_countdownTimer forMode:NSDefaultRunLoopMode];
    }
    return _countdownTimer;
}


@end
