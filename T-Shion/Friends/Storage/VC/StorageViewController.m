//
//  StorageViewController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "StorageViewController.h"
#import "StorageView.h"
#import "StorageViewModel.h"

@interface StorageViewController ()

@property (strong , nonatomic) StorageView *mainView;
@property (strong , nonatomic) StorageViewModel *viewModel;

@end

@implementation StorageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [[self.viewModel.cleanSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *title) {
        @strongify(self)
        self.mainView.progressValue = (float)(rand() % 100) /100;
        NSLog(@"------------清理存储空间");
    }];
}

#pragma mark - getter and setter
- (StorageView *)mainView {
    if (!_mainView) {
        _mainView = [[StorageView alloc] initWithViewModel:self.viewModel];
        _mainView.progressValue = 0.6;
    }
    return _mainView;
}

- (StorageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[StorageViewModel alloc] init];
    }
    
    return _viewModel;
}
@end
