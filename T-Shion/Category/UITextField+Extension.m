//
//  UITextField+Extension.m
//  T-Shion
//
//  Created by together on 2018/4/4.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
+ (UITextField *)creatLeftIconTextFieldWithImage:(NSString *)image {
    UITextField *field = [[UITextField alloc] init];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 44)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backView);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    field.leftView = backView;
    field.leftViewMode = UITextFieldViewModeAlways;
    return field;
}

+ (UITextField *)creatLoginTypeWithImage:(NSString *)image placeholder:(NSString *)placeholder{
    UITextField *field = [UITextField creatLeftIconTextFieldWithImage:image];
    field.backgroundColor = [UIColor whiteColor];
    [field setPlaceholder:placeholder];
    field.font = [UIFont systemFontOfSize:13];
    field.layer.borderWidth = 0.5f;
    field.layer.borderColor = RGB(221,221,221).CGColor;
    field.layer.masksToBounds = YES;
    field.layer.cornerRadius = 3;
    return field;
}

@end
