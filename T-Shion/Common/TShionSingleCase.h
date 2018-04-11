//
//  TShionSingleCase.h
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarViewController.h"
#import "FriendsView.h"

@interface TShionSingleCase : NSObject
@property (assign, nonatomic) CGFloat navigationBarHeight;

@property (strong, nonatomic) TabBarViewController *main;

@property (strong, nonatomic) FriendsView *friends;

@property (weak, nonatomic) UILabel *timerLabel;//verification code UILabel

@property (strong, nonatomic) NSTimer *countdownTimer;//verification code countdown

@property (assign, nonatomic) int countdownSeconds;//The current number of seconds
#pragma mark  method
+ (TShionSingleCase *)shared;
@end
