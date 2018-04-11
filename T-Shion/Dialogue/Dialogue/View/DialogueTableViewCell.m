//
//  DialogueTableViewCell.m
//  T-Shion
//
//  Created by together on 2018/3/22.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueTableViewCell.h"

@implementation DialogueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self.contentView setBackgroundColor:DEFAULT_COLOR];
    [self setBackgroundColor:DEFAULT_COLOR];

    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.messageNumView];
    [self.messageNumView addSubview:self.messageNumber];
    [self.backView addSubview:self.receivingTime];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.detailsMessage];
}

- (void)layoutSubviews {
    if (IOS_Version_11) {
        for (UIView *subview in self.subviews) {
            if([subview isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
                UIView *swipeActionPullView = subview;
                //1.0修改背景颜色
                swipeActionPullView.backgroundColor = DEFAULT_COLOR;
                //2.0修改按钮-颜色
                UIVisualEffectView *moreBtn = subview.subviews[0];
                if ([moreBtn isKindOfClass:NSClassFromString(@"UIVisualEffectView")]) {
                    moreBtn.layer.cornerRadius = 3.0f;
                    moreBtn.layer.masksToBounds = YES;
                    CGFloat moreBtnX = moreBtn.frame.origin.x;
                    moreBtn.frame = CGRectMake(moreBtnX, 10, 60, 71);
                    moreBtn.backgroundColor = RGB(187, 187, 187);
                    
                }
                
                UIButton *archiveBtn = subview.subviews[1];
                if ([archiveBtn isKindOfClass:NSClassFromString(@"_UITableViewCellActionButton")]) {
                    archiveBtn.frame = CGRectMake(0, 10, 60, 71);
                    //2.1修改按钮背景色
                    archiveBtn.backgroundColor =  RGB(81, 143, 255);
                    //2.2修改按钮背景圆角
                    archiveBtn.layer.cornerRadius = 3.0f;
                    archiveBtn.layer.masksToBounds = YES;
                }
            }
        }
    }
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(52, 52));
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(30);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.offset(71);
    }];
   
    [self.messageNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).with.offset(5);
        make.top.equalTo(self.backView.mas_top).with.offset(-5);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.messageNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageNumView);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.backView.mas_top).with.offset(16);
        make.right.equalTo(self.backView);
        make.height.offset(14);
    }];
    
    [self.detailsMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.right.equalTo(self.backView);
        make.height.offset(10);
    }];
    
    [self.receivingTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).with.offset(-35);
        make.top.equalTo(self.backView).with.offset(15.5);
        make.size.mas_offset(CGSizeMake(200, 14));
    }];
    [super layoutSubviews];
    
}

#pragma mark method
- (void)willTransitionToState:(UITableViewCellStateMask)state {
    [super willTransitionToState:state];
    for (UIView *subview in self.subviews) {
        //1.修改背景
        if([subview isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
            UIView *swipeActionPullView = subview;
            //修改背景高度
            CGFloat swipeActionPullViewOX = swipeActionPullView.frame.origin.x;
            CGFloat swipeActionPullViewW  = swipeActionPullView.frame.size.width;
            swipeActionPullView.frame = CGRectMake(swipeActionPullViewOX, 10, swipeActionPullViewW, self.frame.size.height - 10);
            //修改背景颜色
            swipeActionPullView.backgroundColor = RGB(20, 20, 20);
            //修改背景圆角
            swipeActionPullView.layer.cornerRadius = 5.f;
            swipeActionPullView.layer.masksToBounds = YES;
            //2.修改按钮-颜色
            UIButton *swipeActionStandardBtn = subview.subviews[0];
            if ([swipeActionStandardBtn isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                swipeActionStandardBtn.backgroundColor = [UIColor colorWithRed:255/255.f green:173/255.f blue:69/255.f alpha:1.0f];
            }
        }
    }
}

#pragma mark 懒加载
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.layer.cornerRadius = 26;
        _icon.backgroundColor = [UIColor greenColor];
        _icon.layer.borderWidth = 2;
        _icon.layer.borderColor = [UIColor whiteColor].CGColor;
        _icon.layer.shadowColor = RGB(220,226,233).CGColor;
        _icon.layer.shadowOpacity = 0.9f;
        _icon.layer.shadowRadius = 2.5f;
        _icon.layer.shadowOffset = CGSizeMake(0,0);
    }
    return _icon;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.cornerRadius = 3;
        _backView.layer.shadowColor = RGB(220,226,233).CGColor;
        _backView.layer.shadowOpacity = 0.7f;
        _backView.layer.shadowRadius = 4.0f;
        _backView.layer.shadowOffset = CGSizeMake(0,0);
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.text = @"i like you";
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = RGB(64,64,64);
    }
    return _name;
}

- (UILabel *)detailsMessage {
    if (!_detailsMessage) {
        _detailsMessage = [[UILabel alloc] init];
        _detailsMessage.font = [UIFont systemFontOfSize:10];
        _detailsMessage.text = @"but just like you";
        _detailsMessage.textColor = RGB(176,175,175);
    }
    return _detailsMessage;
}

- (UILabel *)receivingTime {
    if (!_receivingTime) {
        _receivingTime = [[UILabel alloc] init];
        _receivingTime.font = [UIFont systemFontOfSize:10];
        _receivingTime.textAlignment = NSTextAlignmentRight;
        _receivingTime.text = @"10:23PM";
        _receivingTime.textColor = RGB(176,175,175);
    }
    return _receivingTime;
}

- (UILabel *)messageNumber {
    if (!_messageNumber) {
        _messageNumber = [[UILabel alloc] init];
        _messageNumber.textColor = [UIColor whiteColor];
        _messageNumber.font = [UIFont systemFontOfSize:10];
        _messageNumber.textAlignment = NSTextAlignmentCenter;
        _messageNumber.text = @"12";
    }
    return _messageNumber;
}

- (UIView *)messageNumView {
    if (!_messageNumView) {
        _messageNumView = [[UIView alloc] init];
        _messageNumView.backgroundColor = RGB(255,99,121);
        _messageNumView.layer.cornerRadius = 15;
        _messageNumView.layer.shadowColor = RGB(128,145,160).CGColor;
        _messageNumView.layer.shadowOpacity = 0.5f;
        _messageNumView.layer.shadowRadius = 2.0f;
        _messageNumView.layer.shadowOffset = CGSizeMake(0,0);
    }
    return _messageNumView;
}
@end
