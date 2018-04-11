//
//  DialogueTableView.m
//  T-Shion
//
//  Created by together on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueTableView.h"

@implementation DialogueTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = DEFAULT_COLOR;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    self.tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    if (!(IOS_Version_11)) {
        for (UIView *subview in self.subviews) {
            if([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                UIView *swipeActionPullView = subview;
                swipeActionPullView.backgroundColor = DEFAULT_COLOR;
                UIButton *moreBtn = subview.subviews[0];
                if ([moreBtn isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                    moreBtn.layer.cornerRadius = 3.0f;
                    moreBtn.layer.masksToBounds = YES;
                    CGFloat moreBtnX = moreBtn.frame.origin.x;
                    moreBtn.frame = CGRectMake(moreBtnX, 10, 69, 71);
                    moreBtn.layer.cornerRadius = 5.f;
                    moreBtn.layer.masksToBounds = YES;
                    moreBtn.backgroundColor = RGB(187, 187, 187);
                }
                
                UIButton *archiveBtn = subview.subviews[1];
                if ([archiveBtn isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                    CGFloat archiveBtnX = moreBtn.frame.size.width + 5.0f;
                    archiveBtn.frame = CGRectMake(archiveBtnX, 10, 69, 71);
                    //2.1修改按钮背景色
                    archiveBtn.backgroundColor =  RGB(81, 143, 255);
                    //2.2修改按钮背景圆角
                    archiveBtn.layer.cornerRadius = 3.0f;
                    archiveBtn.layer.masksToBounds = YES;
                }
            }
        }
    }
    [super layoutSubviews];
}
@end
