//
//  DialogueViewController.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueViewController.h"
#import "DialogueViewModel.h"
#import "DialogueView.h"
#import "DialogueMenuView.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
#import "DialogueContentViewController.h"
#import "FriendsValidationViewController.h"
#import "AddFriendsViewController.h"
#import "OtherInformationViewController.h"
#import "SocketViewController.h"

@interface DialogueViewController ()
@property (strong, nonatomic) DialogueViewModel *viewModel;
@property (strong, nonatomic) DialogueView *mainView;
@end

@implementation DialogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRightNavigationItems];
}

- (void)setRightNavigationItems {
    self.navigationItem.rightBarButtonItems  = @[[self creatBarButtonItemWithImage:@"NavigationBar_More" tag:0],[self creatBarButtonItemWithImage:@"NavigationBar_Flash" tag:1]];
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

- (void)bindViewModel {
    @weakify(self)
    [[[TShionSingleCase shared].friends.viewModel.sendMessageClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [[TShionSingleCase shared].friends hidden];
        
    }];
    
    [[[TShionSingleCase shared].friends.viewModel.setingClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [[TShionSingleCase shared].friends hidden];
        SettingViewController *seting = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:seting animated:YES];
    }];
    
    [[[TShionSingleCase shared].friends.viewModel.callingClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [[TShionSingleCase shared].friends hidden];
        
    }];
    
    [[[TShionSingleCase shared].friends.viewModel.searchClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [[TShionSingleCase shared].friends hidden];
    }];
    
    [[[TShionSingleCase shared].friends.viewModel.validationClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [[TShionSingleCase shared].friends hidden];
        FriendsValidationViewController *friendsValidation = [[FriendsValidationViewController alloc] init];
        [self.navigationController pushViewController:friendsValidation animated:YES];
    }];
    
    [[self.viewModel.dialogueCellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        DialogueContentViewController *dialogue = [[DialogueContentViewController alloc] init];
        [self.navigationController pushViewController:dialogue animated:YES];
    }];
    
    [[[TShionSingleCase shared].friends.viewModel.sendMessageClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        OtherInformationViewController *otherInformation = [[OtherInformationViewController alloc] init];
        [self.navigationController pushViewController:otherInformation animated:YES];
    }];
    
    [[self.viewModel.menuCellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
    }];
}

- (UIBarButtonItem *)creatBarButtonItemWithImage:(NSString *)image tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    button.tag = tag;
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        switch (x.tag) {
            case 0: {
                DialogueMenuView *menuView = [[DialogueMenuView alloc] initWithViewModel:self.viewModel];
                [self.tabBarController.view addSubview:menuView];
                [menuView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.tabBarController.view);
                }];
            }
                break;
            case 1: {
                LoginViewController *login = [[LoginViewController alloc] init];
                [self.navigationController pushViewController:login animated:YES];
                //                SocketViewController *login = [[SocketViewController alloc] init];
                //                [self.navigationController pushViewController:login animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
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
- (DialogueView *)mainView {
    if (!_mainView) {
        _mainView = [[DialogueView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (DialogueViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DialogueViewModel alloc] init];
    }
    return _viewModel;
}

@end
