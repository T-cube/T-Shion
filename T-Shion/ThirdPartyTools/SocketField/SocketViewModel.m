//
//  SocketViewModel.m
//  T-Shion
//
//  Created by together on 2018/4/8.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "SocketViewModel.h"


static SocketViewModel *socketIO;

@implementation SocketViewModel
+ (SocketViewModel *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketIO = [[SocketViewModel alloc] init];
    });
    return socketIO;
}

-(void)connectWithToken:(NSString *)host success:(void (^)(void))success fail:(void (^)(void))fail {
    NSURL* url = [[NSURL alloc] initWithString:host];
    /**
     log 是否打印日志
     forceNew      这个参数设为NO从后台恢复到前台时总是重连，暂不清楚原因
     forcePolling  是否强制使用轮询
     reconnectAttempts 重连次数，-1表示一直重连
     reconnectWait 重连间隔时间
     connectParams 参数
     forceWebsockets 是否强制使用websocket, 解释The reason it uses polling first is because some firewalls/proxies block websockets. So polling lets socket.io work behind those.
     来源：https://github.com/socketio/socket.io-client-swift/issues/449
     */
    SocketIOClient* socket;
    if (!self.client) {
        socket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"compress": @YES}];
    }
    else {
        socket = self.client;
    }
    
    
    // 连接超时时间设置为15秒
    [socket connectWithTimeoutAfter:15 withHandler:^{
        
        fail();
    }];
    
    // 监听一次连接成功
    [socket once:@"connect" callback:^(NSArray * _Nonnull data, SocketAckEmitter * _Nonnull ack) {
        
        success();
    }];
    
    _client = socket;
}


- (Pomelo *)pomelo {
    if (!_pomelo) {
        _pomelo = [[Pomelo alloc] initWithDelegate:self];
    }
    return _pomelo;
}
@end
