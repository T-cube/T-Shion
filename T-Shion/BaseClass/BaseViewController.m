//
//  BaseViewController.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBar];
    self.view.backgroundColor = self.navigationController.navigationBar.barTintColor = self.navigationController.navigationBar.backgroundColor = DEFAULT_COLOR;
    
    //右滑pop功能
    //1.获取系统interactivePopGestureRecognizer对象的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
    UIPanGestureRecognizer * pann = [[UIPanGestureRecognizer alloc]initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];//
    //3.设置代理
    pann.delegate = self;
    //4.添加到导航控制器的视图上
    [self.navigationController.view addGestureRecognizer:pann];
    //5.禁用系统的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self addChildView];
    [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - 滑动开始会触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1) return NO;
    return YES;
}


- (void) setUpNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationItem.leftBarButtonItem = self.navigationController.childViewControllers.count == 1 ? [self mainLeftButton] : [self leftButton];//设置导航栏左边按钮
    self.navigationItem.rightBarButtonItem = [self rightButton];//设置导航栏右边按钮
    self.navigationItem.titleView = [self centerView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}

- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"NavigationBar_Back"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIBarButtonItem *)rightButton {
    return nil;
}

- (UIBarButtonItem *)mainLeftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"NavigationBar_Menu"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(hiddenFriendsViewController:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
- (UIView *)centerView {
    return nil;
}

- (void)actionOnTouchBackButton:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hiddenFriendsViewController:(UIButton *)button {
    [[TShionSingleCase shared].friends show];
}

- (void)hideTabbar:(BOOL)hidden {
    self.tabBarController.tabBar.hidden = hidden;//隐藏导航栏
}


- (void)addChildView {
}

- (void)bindViewModel {
    
}
@end
