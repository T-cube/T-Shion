//
//  SocketViewController.m
//  T-Shion
//
//  Created by together on 2018/4/9.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "SocketViewController.h"
#import <SocketRocket/SocketRocket.h>

@interface SocketViewController ()<SRWebSocketDelegate, UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic, strong)UITextView *shouField;
@property(nonatomic, strong)UITextField *FaField;

@property(nonatomic, strong)SRWebSocket *webSocket;


@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
}


// 启动 webSocket
- (void)setSocket {
    _webSocket.delegate = nil;
    [_webSocket close];
//        _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://114.55.57.51:8282"]]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.1.237:3014"]]];
    _webSocket.delegate = self;
    NSLog(@"Opening Connection...");
    [_webSocket open];
}

// 协议方法 链接成功 给服务器发送id
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    //      如果需要发送数据到服务器使用下面代码
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"id":@"chat",@"clientid":@"hxz",@"to":@""} options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [webSocket send:jsonString];
}

// 协议方法  接收消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"接收的消息:%@", message);
    self.shouField.text = message;
}

// 协议方法 Websocket 打开失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket 打开失败 %@", error);
    webSocket = nil;
    // 断开连接后每过1s重新建立一次连接
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setSocket];
    });
}


// 连接关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed, reason:%@", reason);
    webSocket = nil;
    
}


- (void)sendButAction {
    NSLog(@"发送");
    if (self.FaField.text.length > 0) {
        [_webSocket send:self.FaField.text];
    } else {
        NSLog(@"输入为空");
    }
}

- (void)openButAction {
    NSLog(@"打开");
    [self setSocket];   // 启动 webSocket
}

- (void)offButAction {
    NSLog(@"关闭");
    _webSocket.delegate = nil;
    [_webSocket close];
}


-(void)createView {
    
    UILabel *jieshouLabel = [UILabel new];
    jieshouLabel.text = @"接收:";
    jieshouLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:jieshouLabel];
    [jieshouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.view).offset(10);
    }];
    
    
    UITextView *shouField = [UITextView new];
    shouField.delegate = self;
    shouField.textColor = [UIColor whiteColor];
    shouField.backgroundColor = [UIColor grayColor];
    shouField.returnKeyType = UIReturnKeySearch;
    shouField.font = [UIFont systemFontOfSize:13];
    shouField.layer.masksToBounds = YES;
    shouField.layer.cornerRadius = 5;
    [self.view addSubview:shouField];
    [shouField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jieshouLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(140);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    self.shouField = shouField;
    
    
    UILabel *faSongLabel = [UILabel new];
    faSongLabel.text = @"发送:";
    faSongLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:faSongLabel];
    [faSongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shouField.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.view).offset(10);
    }];
    
    // 发
    UITextField *FaField = [UITextField new];
    FaField.delegate = self;
    FaField.textColor = [UIColor whiteColor];
    FaField.backgroundColor = [UIColor grayColor];
    FaField.returnKeyType = UIReturnKeySearch;
    FaField.font = [UIFont systemFontOfSize:13];
    FaField.layer.masksToBounds = YES;
    FaField.layer.cornerRadius = 5;
    [self.view addSubview:FaField];
    [FaField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(faSongLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    self.FaField = FaField;
    
    UIButton *but = [UIButton buttonWithType: UIButtonTypeCustom];
    but.backgroundColor = [UIColor greenColor];
    [but setTitle:@"发送" forState:UIControlStateNormal];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    [but addTarget:self action:@selector(sendButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.top.equalTo(FaField.mas_bottom).offset(20);
        
    }];
    
    
    // 打开
    UIButton *openBut = [UIButton buttonWithType: UIButtonTypeCustom];
    openBut.backgroundColor = [UIColor orangeColor];
    [openBut setTitle:@"打开" forState:UIControlStateNormal];
    openBut.layer.masksToBounds = YES;
    openBut.layer.cornerRadius = 5;
    [openBut addTarget:self action:@selector(openButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openBut];
    [openBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.top.equalTo(but.mas_bottom).offset(20);
        
    }];
    
    
    // 关闭
    UIButton *offBut = [UIButton buttonWithType: UIButtonTypeCustom];
    offBut.backgroundColor = [UIColor orangeColor];
    [offBut setTitle:@"关闭" forState:UIControlStateNormal];
    offBut.layer.masksToBounds = YES;
    offBut.layer.cornerRadius = 5;
    [offBut addTarget:self action:@selector(offButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:offBut];
    [offBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.top.equalTo(but.mas_bottom).offset(20);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
