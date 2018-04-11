//
//  OhterInformationViewController.m
//  T-Shion
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "OtherInformationViewController.h"
#import "OtherInformationViewModel.h"
#import "OtherInformationView.h"
#import "QRCodeViewController.h"

@interface OtherInformationViewController ()
@property (strong, nonatomic) OtherInformationView *mainView;
@property (strong, nonatomic) OtherInformationViewModel *viewModel;
@end

@implementation OtherInformationViewController

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
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *title) {
        //        @strongify(self);
        NSLog(@"------------%@",title);
    }];
    
    [[self.viewModel.menuItemClickSubject takeUntil:self.rac_willDeallocSignal]subscribeNext:^(id x) {
        @strongify(self)
        switch ([x intValue]) {
            case 0: {
                NSLog(@"-----拨打电话");
            }
                break;
                
            case 1:
                NSLog(@"-----点击视频聊天");
                break;
                
            case 2:
                NSLog(@"-----点击分享");
                break;
            case 3:{
                QRCodeViewController *qrCode = [[QRCodeViewController alloc] init];
                [self.navigationController pushViewController:qrCode animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - getter and setter
- (OtherInformationView *)mainView {
    if (!_mainView) {
        _mainView = [[OtherInformationView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (OtherInformationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[OtherInformationViewModel alloc] init];
    }
    return _viewModel;
}

- (void)dealloc {
    NSLog(@"释放了");
    
}
@end
