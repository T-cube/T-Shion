//
//  AddFriendsViewController.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "AddFriendsViewModel.h"
#import "AddFriendsView.h"

@interface AddFriendsViewController ()
@property (strong, nonatomic) AddFriendsViewModel *viewModel;
@property (strong, nonatomic) AddFriendsView *mainView;
@end

@implementation AddFriendsViewController

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

//- (UIBarButtonItem *)leftButton {
//    UIButton *nilBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [nilBtn setFrame:CGRectMake(0, 0, 5, 10)];
//    return nil;
//}

//- (UIBarButtonItem *)rightButton {
//    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancel.frame = CGRectMake(0, 0, 46, 30);
//    [cancel.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [cancel setTitle:@"搜索" forState:UIControlStateNormal];
//    [cancel setTitleColor:RGB(81, 143, 255) forState:UIControlStateNormal];
//    @weakify(self)
//    [[cancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        @strongify(self)
//    }];
//    return [[UIBarButtonItem alloc] initWithCustomView:cancel];
//}

- (UIView *)centerView {
    TShionField *searchField = [[TShionField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 86, 35)];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 35)];
    UIImageView *search = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8.5, 18, 18)];
    [search setImage:[UIImage imageNamed:@"Dialogue_Search"]];
    [leftView addSubview:search];
    searchField.leftView = leftView;
    searchField.leftViewMode = UITextFieldViewModeUnlessEditing;
    searchField.clearButtonMode = UITextFieldViewModeAlways;
    searchField.layer.masksToBounds = YES;
    searchField.layer.cornerRadius = 4;
    return searchField;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (AddFriendsView *)mainView {
    if (!_mainView) {
        _mainView = [[AddFriendsView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (AddFriendsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AddFriendsViewModel alloc] init];
    }
    return _viewModel;
}
@end
