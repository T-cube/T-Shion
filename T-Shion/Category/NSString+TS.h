//
//  NSString+TS.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TS)

/**
 * 获取相册名字进行中文转化
 */
+ (NSString *)replaceEnglishAssetCollectionNamme:(NSString *)englishName;
/**
 * 字符串转16进制
 */
+ (NSString *)convertStringToHexStr:(NSString *)str;
@end
