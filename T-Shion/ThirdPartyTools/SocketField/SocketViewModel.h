//
//  SocketViewModel.h
//  T-Shion
//
//  Created by together on 2018/4/8.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseViewModel.h"
#import "Pomelo.h"

@interface SocketViewModel : BaseViewModel<PomeloDelegate>

@property (strong, nonatomic) RACCommand *onlineCommand;

@property (strong, nonatomic) SocketIOClient *client;

@property (strong, nonatomic) Pomelo *pomelo;

- (void)connectWithToken:(NSString *)host success:(void(^)(void))success fail:(void(^)(void))fail;

+ (SocketViewModel *)shared;
@end
