//
//  NSString+TS.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "NSString+TS.h"

@implementation NSString (TS)

+ (NSString *)replaceEnglishAssetCollectionNamme:(NSString *)englishName {
    if([englishName isEqualToString:@"My Photo Stream"]) {
        return @"我的照片流";
    }
    if([englishName isEqualToString:@"Selfies"]) {
        return @"自拍";
    }
    if([englishName isEqualToString:@"Bursts"]) {
        return @"连拍";
    }
    if([englishName isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    }
    if([englishName isEqualToString:@"Favorites"]) {
        return @"喜欢";
    }
    if([englishName isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    }
    if([englishName isEqualToString:@"Videos"]) {
        return @"视频";
    }
    if([englishName isEqualToString:@"Panoramas"]) {
        return @"全景";
    }
    if([englishName isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    if([englishName isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    }
    return englishName;
}

+ (NSString *)convertStringToHexStr:(NSData *)myD {
//    NSData *myD = [str dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

@end
