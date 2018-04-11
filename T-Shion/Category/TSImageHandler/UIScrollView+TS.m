//
//  UIScrollView+TS.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "UIScrollView+TS.h"

@implementation UIScrollView (TS)

- (void)scrollsToBottomAnimated:(BOOL)animated {
    CGFloat offset = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    if (offset > 0) {
        [self setContentOffset:CGPointMake(0, offset) animated:animated];
    }
}


@end
