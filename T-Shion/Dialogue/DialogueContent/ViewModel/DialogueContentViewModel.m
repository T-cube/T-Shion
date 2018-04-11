//
//  DialogueContentViewModel.m
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentViewModel.h"

@implementation DialogueContentViewModel



- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc] init];
        for (int i = 0; i<3; i++) {
            DialogueContentModel *model = [[DialogueContentModel alloc] init];
            model.messageType = MessageTypeText;
            model.messageSenderType = i%2;
            model.messageText = @"死亡如风，常伴吾身。正义，好个冠冕堂皇之词，仁义道德，也是一种奢侈";
            [_dataList addObject:model];
        }
        for (int i = 0; i<4; i++) {
            DialogueContentModel *model = [[DialogueContentModel alloc] init];
            model.messageType = MessageTypeVoice;
            model.messageSenderType = i%2;
            [_dataList addObject:model];
        }
        for (int i = 0; i<4; i++) {
            DialogueContentModel *model = [[DialogueContentModel alloc] init];
            model.messageType = MessageTypeImage;
            model.messageSenderType = i%2;
            model.imageSmall = [UIImage imageNamed:@"test_Image"];
            [_dataList addObject:model];
        }
    }
    return _dataList;
}
@end
