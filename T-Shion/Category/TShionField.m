//
//  TShionField.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TShionField.h"

@implementation TShionField

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(5, 0, bounds.size.width-5, bounds.size.height);
}

//-(CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectMake(5, 0, bounds.size.width-5, bounds.size.height);
//}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (self.clearButtonMode == UITextFieldViewModeAlways) {
        return CGRectMake(5, 0, bounds.size.width-5-19, bounds.size.height);
    }else {
        return CGRectMake(5, 0, bounds.size.width-5, bounds.size.height);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
