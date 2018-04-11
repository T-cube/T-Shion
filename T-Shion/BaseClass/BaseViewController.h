//
//  BaseViewController.h
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
@property(nonatomic,copy)NSString *centerTitle;
- (void)hideTabbar:(BOOL)hidden;
- (UIView *)centerView;
- (UIBarButtonItem *)leftButton;
- (UIBarButtonItem *)mainLeftButton;
- (UIBarButtonItem *)rightButton;
- (void)addChildView;
- (void)bindViewModel;
@end
