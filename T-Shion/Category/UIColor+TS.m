//
//  UIColor+TS.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "UIColor+TS.h"

#define kColorBlackDark     0x404040      //深黑 （大标题色）
#define kColorBlackNormal   0x333333      //正常黑 （正常黑色字体色）
//#define kColorBlackLight  0x666666      //浅黑
//#define kColorBlackTiny   0x999999      //更浅黑

#define kColorRed           0xff6379      //红色

#define kColorGrayNormal    0xf3f4f6      //正常灰 (正常背景色)
#define kColorGrayLight     0xe2e2e2      //浅灰 （更浅的背景色）
#define kColorWhite         0xffffff      //白色
#define kColorTextGray      0x999999      //灰字体色
#define kColorTextLight     0xb0afaf      //浅灰字体色



@implementation UIColor (TS)

+ (UIColor *)TSKeyColor {
    return HEXCOLOR(kColorGrayNormal);
}

+ (UIColor *)TSKeyBackgroundColor {
    return HEXCOLOR(kColorGrayNormal);
}

+ (UIColor *)TSLightBackgroundColor {
    return HEXCOLOR(kColorGrayLight);
}

+ (UIColor *)TSWhiteColor {
    return HEXCOLOR(kColorWhite);
}

+ (UIColor *)TSBlackDarkColor {
    return HEXCOLOR(kColorBlackDark);
}

+ (UIColor *)TSBlackNormalColor {
    return HEXCOLOR(kColorBlackNormal);
}

+ (UIColor *)TSTextDarkColor {
    return HEXCOLOR(kColorBlackDark);
}

+ (UIColor *)TSTextNormalColor {
    return HEXCOLOR(kColorBlackNormal);
}

+ (UIColor *)TSTextGrayColor {
    return HEXCOLOR(kColorTextGray);
}

+ (UIColor *)TSTextLightColor {
    return HEXCOLOR(kColorTextLight);
}

+ (UIColor *)TSRedColor {
    return HEXCOLOR(kColorRed);
}

+ (UIColor *)TSBlueColor {
    return RGB(81, 143, 255);
}

@end
