//
//  QRCodeViewController.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeViewModel.h"
#import "QRCodeView.h"

@interface QRCodeViewController ()
@property (strong, nonatomic) QRCodeView *mainView;
@property (strong, nonatomic) QRCodeViewModel *viewModel;
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (QRCodeView *)mainView {
    if (!_mainView) {
        _mainView = [[QRCodeView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (QRCodeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[QRCodeViewModel alloc] init];
    }
    return _viewModel;
}
@end
