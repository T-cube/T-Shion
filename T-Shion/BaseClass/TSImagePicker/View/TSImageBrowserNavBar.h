//
//  TSImageBrowserNavBar.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TSImageBrowserSelectedBlock) (UIButton *sender, BOOL isSelected);

@interface TSImageBrowserNavBar : UIView

- (void)handleBackActionWithBlock:(dispatch_block_t)block;

- (void)handleSelectedActionWithBlock:(TSImageBrowserSelectedBlock)block;

@property (nonatomic ,assign) BOOL isShow;

- (void)resetSelectBtn:(NSInteger)currentIndex isSelected:(BOOL)isSelected;

@end
