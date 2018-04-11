//
//  DialogueContentModel.h
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 消息类型
 */
typedef NS_OPTIONS(NSUInteger, MessageType) {
    MessageTypeText=1,//文字
    MessageTypeVoice,//声音
    MessageTypeImage//图片
};


/*
 消息发送方
 */
typedef NS_OPTIONS(NSUInteger, MessageSenderType) {
    MessageSenderTypeOther=1,//其他人
    MessageSenderTypeUser//自己
    
};



/*
 消息发送状态
 */

typedef NS_OPTIONS(NSUInteger, MessageSentStatus) {
    MessageSentStatusSended=1,//送达
    MessageSentStatusUnSended, //未发送
    MessageSentStatusSending, //正在发送
    
};

/*
 消息接收状态
 */

typedef NS_OPTIONS(NSUInteger, MessageReadStatus) {
    MessageReadStatusRead=1,//消息已读
    MessageReadStatusUnRead //消息未读
    
};


/*
 只有当消息送达的时候，才会出现 接收状态，
 消息已读 和未读 仅仅针对自己
 
 未送达显示红色，
 发送中显示菊花
 送达状态彼此互斥
 */





@interface DialogueContentModel : NSObject
@property (nonatomic, assign) MessageType         messageType;//消息类型
@property (nonatomic, assign) MessageSenderType   messageSenderType;//消息发送类型
@property (nonatomic, assign) MessageSentStatus   messageSentStatus;//消息发送状态
@property (nonatomic, assign) MessageReadStatus   messageReadStatus;//消息读取状态
/*
 消息时间
 */
@property (nonatomic, copy) NSString *messageTime;
/*
 图像url
 */
@property (nonatomic, copy) NSString *logoUrl;
/*
 消息文本内容
 */
@property (nonatomic, copy) NSString *messageText;
/*
 消息音频url
 */
@property (nonatomic, copy) NSString *voiceUrl;
/*
 图片文件
 */
@property (nonatomic, copy) NSString *imageUrl;
/*
 图片文件
 */
@property (nonatomic, strong) UIImage *imageSmall;
/*
 音频时间
 */
@property (nonatomic, assign) NSInteger duringTime;
/*
 是否显示小时的时间
 */
@property (nonatomic, assign) BOOL showMessageTime;
/*
 内容的高度
 */
@property (nonatomic, assign) CGFloat contentHeight;
/*
 内容的尺寸
 */
@property (nonatomic, assign) CGSize contentSize;

@end
