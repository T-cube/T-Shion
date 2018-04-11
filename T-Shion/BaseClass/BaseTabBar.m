//
//  BaseTabBar.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseTabBar.h"

@implementation BaseTabBar

- (instancetype)init {
    if (self = [super init]){
        [self addSubview:self.centerBtn];
        UIImage *image = [UIImage new];
        [self setBackgroundImage:image];
        [self setShadowImage:image];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self bringSubviewToFront:self.centerBtn];
            });
        });
    }
    return self;
}
//处理超出区域点击无效的问题
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == nil){
//        //转换坐标
//        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
//        //判断点击的点是否在按钮区域内
//        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
//            //返回按钮
//            return _centerBtn;
//        }
//    }
//    return view;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIButton *)centerBtn {
    if (!_centerBtn) {
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *normalImage = [UIImage imageNamed:@"TabBar_TakingPictures_Normal"];
        [_centerBtn setImage:normalImage forState:UIControlStateNormal];
        _centerBtn.frame = CGRectMake((SCREEN_WIDTH - 49)/2.0, - 15, 49, 49);
        _centerBtn.adjustsImageWhenHighlighted = NO;
        _centerBtn.layer.cornerRadius = 3;
        _centerBtn.layer.shadowColor = RGB(54,108,204).CGColor;
        _centerBtn.layer.shadowOpacity = 0.14f;
        _centerBtn.layer.shadowRadius = 5.0f;
        _centerBtn.layer.shadowOffset = CGSizeMake(0,0);
    }
    return _centerBtn;
}
@end
