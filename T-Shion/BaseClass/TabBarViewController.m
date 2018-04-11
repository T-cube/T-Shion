//
//  TabBarViewController.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TabBarViewController.h"
#import "BaseTabBar.h"
#import "DialogueViewController.h"
#import "TakingPicturesViewController.h"
#import "CallRecordsViewController.h"
#import "BaseNavigationViewController.h"

@interface TabBarViewController ()
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildController];

    BaseTabBar *tabbar = [[BaseTabBar alloc] init];
    [tabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    tabbar.tintColor = RGB(38, 195, 236);
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    tabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildController {
    [self setupChildVc:[[DialogueViewController alloc] init] title:@"对话" image:@"TabBar_Dialogue_Normal" selectedImage:@"TabBar_Dialogue_Selected"];
    [self setupChildVc:[[CallRecordsViewController alloc] init] title:@"通话" image:@"TabBar_CallRecords_Normal" selectedImage:@"TabBar_CallRecords_Selected"];
}

- (void)buttonAction:(UIButton *)sender {
    
    TakingPicturesViewController *takingPictures = [[TakingPicturesViewController alloc] init];
    [self presentViewController:takingPictures animated:YES completion:nil];
    
    
    
    
//    TSImagePickerController *imagePicker = [[TSImagePickerController alloc] init];
//    imagePicker.autoJumpToPhotoSelectPage = YES;
//    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置文字和图片
//    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:vc];
    nav.view = nil;
//        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_image"] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    [nav.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(51, 51, 51),
                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                                }];
    if (title.length>1) {
        [self addChildViewController:nav];
    }
}


@end
