//
//  CallDetailViewController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallDetailViewController.h"
#import "CallDetailView.h"

@interface CallDetailViewController ()

@property (strong , nonatomic) CallDetailView *mainView;

@end

@implementation CallDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)addChildView {
    [self.view addSubview:self.mainView];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (CallDetailView *)mainView {
    if (!_mainView) {
        _mainView = [[CallDetailView alloc] init];
    }
    return _mainView;
}

@end
