//
//  Common.h
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define RSAPublicKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnu8Hb0dmXy9BQ5vudc+AEBlDHw5ifCVthZrpaCaEcVIbFqacy6HcS3H6tmr3M1dMrs+YoLpSHdBtx2JsfS2fF7/W9AzoTZ4ZILNZMP763pJlRC5mlbVpSuZ6fIN0HVdCcWm2qJ2XLtxh3WbY/8bEJmJ/AKI7cd+JbJdX0wdaqbwIDAQAB"

#define IOS_VERSION   [[[UIDevice currentDevice] systemVersion] floatValue]//版本号

#define IOS_Version_11 IOS_VERSION < 11.0

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define KNavigationBarHeight  KIsiPhoneX == YES ? 24 : 0


#define DEFAULT_COLOR RGB(246,246,246)

//RGBA颜色设置
#define RGBACOLOR(r,g,b,a)   [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]

// 十六进制颜色设置
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : (alphaValue)]


#define RGB(r, g, b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//屏幕款
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//屏幕高

#define HostHttpUrl    @"http://192.168.1.237:3333"//服务器地址
#define HostSocketUrl    @"ws://192.168.1.237:3014"//服务器地址


#endif /* Common_h */
