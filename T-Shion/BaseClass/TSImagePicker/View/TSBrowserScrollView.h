//
//  TSBrowserScrollView.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSBrowserScrollView : UIScrollView

@property (nonatomic, strong) UIImage *image;

- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block;

- (void)handleDoubleTapActionWithBlock:(dispatch_block_t)block;


@end
