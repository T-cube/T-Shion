//
//  CallRecordsViewController.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsViewController.h"
#import "CallRecordsSegmentControl.h"
#import "CallRecordsViewModel.h"
#import "CallRecordsView.h"
#import "CallRecordsDetailViewController.h"

@interface CallRecordsViewController ()

@property (strong , nonatomic) CallRecordsSegmentControl *segmentCtl;
@property (strong , nonatomic) CallRecordsView *mainView;
@property (strong , nonatomic) CallRecordsViewModel *viewModel;

@end

@implementation CallRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.segmentCtl;
    [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - system
- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - private
- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *title) {
        NSLog(@"------------%@",title);
    }];
    
    [[self.viewModel.detaikClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        CallRecordsDetailViewController *detailVC = [[CallRecordsDetailViewController alloc] init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
        NSLog(@"=====进入详情");
    }];
}

#pragma mark - getter and setter
- (CallRecordsSegmentControl *)segmentCtl {
    if (!_segmentCtl) {
        _segmentCtl = [[CallRecordsSegmentControl alloc] initWithViewModel:self.viewModel];
        _segmentCtl.frame = CGRectMake(0, 0, 174, 30);
//        _segmentCtl.layer.shadowColor = HEXCOLOR(0x3a89ff).CGColor;
//        _segmentCtl.layer.shadowOpacity = 0.7f;
//        _segmentCtl.layer.shadowRadius = 4.0f;
//        _segmentCtl.layer.shadowOffset = CGSizeMake(0,0);
    }
    return _segmentCtl;
}

- (CallRecordsView *)mainView {
    if (!_mainView) {
        _mainView = [[CallRecordsView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (CallRecordsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[CallRecordsViewModel alloc] init];
    }
    return _viewModel;
}

@end
