//
//  TSImageBrowserToolBar.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSImageBrowserToolBar : UIToolbar

- (instancetype)initWithFrame:(CGRect)frame barStyle:(UIBarStyle)barStyle;

- (void)handleFinishedButtonWithBlock:(dispatch_block_t)block;
- (void)handlePreviewButtonWithBlock:(dispatch_block_t)block;
- (void)resetSelectPhotosNumber:(NSInteger)number;

@end
