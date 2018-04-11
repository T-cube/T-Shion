//
//  DialogueContentModel.m
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentModel.h"

#define RIGHT_WITH (SCREEN_WIDTH > 750 ? 120:100)
#define ContentTextWidth (SCREEN_WIDTH - RIGHT_WITH - 20 - 15)
#define MAX_IMAGE_WH 141.0

@implementation DialogueContentModel

- (CGFloat)contentHeight {
    if (!_contentHeight) {
        switch (self.messageType) {
            case 1:
                return [self contentTextHeight];
                break;
            case 2:
                return [self voiceHeight];
                break;
            case 3:
                return [self imageHeight];
                break;
                
            default:
                break;
        }
    }
    return _contentHeight;
}

- (CGFloat)contentTextHeight {
    
    UIFont *textFont = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    
    NSDictionary *attributes = @{NSFontAttributeName: textFont};
    
    CGRect rect = [_messageText boundingRectWithSize:CGSizeMake(ContentTextWidth, MAXFLOAT)

                                                  options:NSStringDrawingUsesLineFragmentOrigin
                   
                                               attributes:attributes
                   
                                                  context:nil];
    
    return rect.size.height;
}

- (CGFloat)voiceHeight {
    CGFloat topMargin = _showMessageTime == YES ? 37.0f: 10.0f;
    return 52+topMargin;
}

- (CGFloat)imageHeight {
    CGSize size=[self imageShowSize:_imageSmall];
    return 40 + size.height+ 20;
}

/*
 判断图片长度&宽度
 
 */
- (CGSize)imageShowSize:(UIImage *)image {
    
    CGFloat imageWith=image.size.width;
    CGFloat imageHeight=image.size.height;
    //宽度大于高度
    if (imageWith>=imageHeight) {
        // 宽度超过标准宽度
        return CGSizeMake(MAX_IMAGE_WH, imageHeight*MAX_IMAGE_WH/imageWith);
        
        
    }else{
        return CGSizeMake(imageWith*MAX_IMAGE_WH/imageHeight, MAX_IMAGE_WH);
    }
    
    return CGSizeZero;
}
/*
 声音长度
 */
- (CGFloat)voiceLength:(NSInteger)seconds {
    if (seconds==0) {
        return 75;
    }
    CGFloat max = SCREEN_WIDTH > 750 ? 230:197;

    return 207;
}
/*
 cell内容的尺寸
 */
- (CGSize)contentSize {
    switch (_messageType) {
        case 1:
            return CGSizeMake(ContentTextWidth+26, self.contentHeight+12 +17);
            break;
        case 2:
            return CGSizeMake(207, self.contentHeight);
            break;
        case 3:
            return CGSizeMake(141, self.contentHeight);
            break;
        default:
            break;
    }
    return CGSizeZero;
}
@end
