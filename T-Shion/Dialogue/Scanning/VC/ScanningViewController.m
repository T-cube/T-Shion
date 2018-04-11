//
//  ScanningViewController.m
//  T-Shion
//
//  Created by together on 2018/4/11.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "ScanningViewController.h"
#import "ScanningView.h"
#import "ScanningViewModel.h"

@interface ScanningViewController ()
@property (strong, nonatomic) ScanningView *mainView;
@property (strong, nonatomic) ScanningViewModel *viewModel;
@end

@implementation ScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (ScanningView *)mainView {
    if (!_mainView) {
        _mainView = [[ScanningView alloc] init];
    }
    return _mainView;
}

- (ScanningViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ScanningViewModel alloc] init];
    }
    return _viewModel;
}
@end
