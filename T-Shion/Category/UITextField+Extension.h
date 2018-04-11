//
//  UITextField+Extension.h
//  T-Shion
//
//  Created by together on 2018/4/4.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)
+ (UITextField *)creatLeftIconTextFieldWithImage:(NSString *)image;
+ (UITextField *)creatLoginTypeWithImage:(NSString *)image placeholder:(NSString *)placeholder;
@end
