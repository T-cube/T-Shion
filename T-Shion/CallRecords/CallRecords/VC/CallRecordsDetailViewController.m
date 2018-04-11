//
//  CallRecordsDetailViewController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsDetailViewController.h"
#import "CallRecordsDetailView.h"
#import "CallRecordsDetailViewModel.h"
#import "CallDetailViewController.h"

@interface CallRecordsDetailViewController ()

@property (strong , nonatomic) CallRecordsDetailView *mainView;
@property (strong , nonatomic) CallRecordsDetailViewModel *viewModel;

@end

@implementation CallRecordsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
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

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        CallDetailViewController *detailVC = [[CallDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        NSLog(@"=====进入通话列表");
    }];
}

#pragma mark - getter and setter
- (CallRecordsDetailView *)mainView {
    if (!_mainView) {
        _mainView = [[CallRecordsDetailView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (CallRecordsDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CallRecordsDetailViewModel alloc] init];
    }
    return _viewModel;
}

@end
