//
//  UIImage+TS.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TS)

//切圆角
- (UIImage *)circleImage;

/**
 *  用color生成image
 *
 *  @param color 颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  改变image透明度
 *
 *  @param alpha 透明度
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

//旋转角度
- (UIImage *)rotation:(UIImageOrientation)orientation;

@end
