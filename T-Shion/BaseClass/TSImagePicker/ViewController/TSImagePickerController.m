//
//  TSImagePickerController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImagePickerController.h"
#import "TSImageGroupController.h"
#import "UINavigationBar+TS.h"
#import "TakingPicturesViewController.h"

static NSString *const kPushToCollectionPageNotification = @"kPushToCollectionPageNotification";

@interface TSImagePickerController ()

@property (nonatomic, copy, readwrite) PHAssetsBlock phAssetsBlock;

@end

@implementation TSImagePickerController

- (instancetype)init {
    self = [super initWithRootViewController:[[TSImageGroupController alloc] init]];
    if (self) {
        [self.navigationBar ts_setImagePickerStyle];
        self.navigationBar.tintColor = [UIColor TSWhiteColor];
        [self.navigationBar setTitleTextAttributes:@{
                                                     NSForegroundColorAttributeName:[UIColor TSWhiteColor],
                                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                                    }];
        self.allowSelectReturnType = NO;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAutoJumpToPhotoSelectPage:(BOOL)autoJumpToPhotoSelectPage {
    _autoJumpToPhotoSelectPage = autoJumpToPhotoSelectPage;
    if (autoJumpToPhotoSelectPage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPushToCollectionPageNotification object:nil];
    }
}

- (void)getSelectedPHAssetsWithBlock:(PHAssetsBlock)block {
    
}

@end
