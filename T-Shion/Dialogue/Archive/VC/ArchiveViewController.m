//
//  ArchiveViewController.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "ArchiveViewController.h"
#import "ArchiveViewModel.h"
#import "ArchiveView.h"

@interface ArchiveViewController ()
@property (strong, nonatomic) ArchiveViewModel *viewModel;
@property (strong, nonatomic) ArchiveView *mainView;
@end

@implementation ArchiveViewController

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
- (ArchiveView *)mainView {
    if (!_mainView) {
        _mainView = [[ArchiveView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (ArchiveViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ArchiveViewModel alloc] init];
    }
    return _viewModel;
}
@end
