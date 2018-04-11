//
//  DialogueContentViewTableViewCell.h
//  T-Shion
//
//  Created by together on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DialogueContentModel.h"



@class ReceiveTextCell ;
@class SendTextCell ;
@class ReceiveVoiceCell;
@class SendVoiceCell;
@class ReceiveImageCell;
@class SendImageCell;

@interface DialogueContentViewTableViewCell : BaseTableViewCell

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) ReceiveTextCell *receiveText;//别人的消息

@property (strong, nonatomic) SendTextCell *sendTextCell;//自己的消息

@property (strong, nonatomic) ReceiveVoiceCell *receiveVoiceCell;//接收语音消息

@property (strong, nonatomic) SendVoiceCell *sendVoiceCell;//发送语音消息

@property (strong, nonatomic) ReceiveImageCell *receiveImageCell;//接收图片消息

@property (strong, nonatomic) SendImageCell *sendImageCell;//发送图片消息

@property (weak, nonatomic) UIView *cellView;
@end

#pragma mark  协议方法
@protocol DialogueContentViewProtocol <NSObject>
@optional
- (instancetype)initWithModel:(DialogueContentModel *)Model;
@end
#pragma mark  六种View

@interface SendTextCell : UIView<DialogueContentViewProtocol>

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) UIImageView *imageBackView;

@property (strong, nonatomic) UILabel *contentText;

@property (strong, nonatomic) UILabel *time;
@end

@interface ReceiveTextCell : UIView<DialogueContentViewProtocol>

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) UIImageView *imageBackView;

@property (strong, nonatomic) UILabel *contentText;

@property (strong, nonatomic) UILabel *time;
@end

@interface SendVoiceCell : UIView<DialogueContentViewProtocol>

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) UIImageView *imageBackView;

@property (strong, nonatomic) UIImageView *playerIcon;

@property (strong, nonatomic) UISlider *contentSlider;

@property (strong, nonatomic) UILabel *longSeconds;//时长

@property (strong, nonatomic) UILabel *time;//时间
@end

@interface ReceiveVoiceCell : UIView<DialogueContentViewProtocol>

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) UIImageView *imageBackView;

@property (strong, nonatomic) UIImageView *playerIcon;

@property (strong, nonatomic) UISlider *contentSlider;

@property (strong, nonatomic) UIView *redView;

@property (strong, nonatomic) UILabel *longSeconds;//时长

@property (strong, nonatomic) UILabel *time;//时间
@end

@interface SendImageCell : UIView<DialogueContentViewProtocol>

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) UIImageView *imageBackView;

@property (strong, nonatomic) UIImageView *contentImage;

@property (strong, nonatomic) UILabel *time;
@end

@interface ReceiveImageCell : UIView<DialogueContentViewProtocol>

@property (strong, nonatomic) DialogueContentModel *model;

@property (strong, nonatomic) UIImageView *imageBackView;

@property (strong, nonatomic) UIImageView *contentImage;

@property (strong, nonatomic) UILabel *time;
@end
