//
//  SettingViewController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingView.h"
#import "SettingViewModel.h"
#import "NameCardView.h"
#import "BlackListViewController.h"
#import "ArchiveViewController.h"
#import "QRCodeViewController.h"
#import "StorageViewController.h"
#import "AboutUsViewController.h"

@interface SettingViewController ()

@property (strong , nonatomic) SettingView *mainView;
@property (strong , nonatomic) SettingViewModel *viewModel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

#pragma mark - system
- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

#pragma mark - private
- (void)bindViewModel {
    @weakify(self);
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        switch ([x intValue]) {
            case 0:
            
                break;
            case 1: {
                ArchiveViewController *archive = [[ArchiveViewController alloc] init];
                [self.navigationController pushViewController:archive animated:YES];
            }
                break;
            case 2: {
                BlackListViewController *blackList = [[BlackListViewController alloc] init];
                [self.navigationController pushViewController:blackList animated:YES];
            }
                break;
            case 3: {
                StorageViewController *storage = [[StorageViewController alloc] init];
                [self.navigationController pushViewController:storage animated:YES];
            }
                break;
            case 4: {
                AboutUsViewController *about = [[AboutUsViewController alloc] init];
                [self.navigationController pushViewController:about animated:YES];
            }
                break;
            default:
                break;
        }
    }];

    [[self.viewModel.cardClickSubject takeUntil:self.rac_willDeallocSignal]subscribeNext:^(id x) {
        @strongify(self)
        if ([x intValue]) {
            QRCodeViewController *qrCode = [[QRCodeViewController alloc] init];
            [self.navigationController pushViewController:qrCode animated:YES];
        }
    }];
    
}

#pragma mark - getter and setter
- (SettingView *)mainView {
    if (!_mainView) {
        _mainView = [[SettingView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (SettingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SettingViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc {
    NSLog(@"释放了");
    
}
@end
