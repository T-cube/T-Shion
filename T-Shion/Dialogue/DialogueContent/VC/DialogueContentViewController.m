//
//  DialogueContentViewController.m
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentViewController.h"
#import "DialogueContentView.h"
#import "DialogueContentViewModel.h"

@interface DialogueContentViewController ()
@property (strong, nonatomic) DialogueContentViewModel *viewModel;

@property (strong, nonatomic) DialogueContentView *mainView;
@end

@implementation DialogueContentViewController

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
    [super updateViewConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (DialogueContentView *)mainView {
    if (!_mainView) {
        _mainView = [[DialogueContentView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (DialogueContentViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DialogueContentViewModel alloc] init];
    }
    return _viewModel;
}
@end
