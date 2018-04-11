//
//  TSImageBrowserController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageBrowserController.h"
#import "TSBrowserCollectionCell.h"
#import "TSImageBrowserNavBar.h"
#import "TSImageBrowserToolBar.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "TSImageSelectedHandler.h"

@interface TSImageBrowserController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic , strong) TSImageBrowserNavBar *customNavBar;
@property (nonatomic , strong) TSImageBrowserToolBar *bottomToolBar;

@end

@implementation TSImageBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fd_interactivePopDisabled = NO;
    self.fd_prefersNavigationBarHidden = YES;
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.customNavBar];
    [self.view addSubview:self.bottomToolBar];
    
    [self.collectionView setContentOffset:CGPointMake(self.currentIndex * self.collectionView.width, 0) animated:NO];
    
    [self resetNavbarSelectedBtn];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)resetNavbarSelectedBtn {
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
    
    if ([[TSImageSelectedHandler shareInstance] containsIndex:currentIndexPath]) {
        NSInteger navIndex = [[[TSImageSelectedHandler shareInstance] selectedIndexs] indexOfObject:currentIndexPath];
        [self.customNavBar resetSelectBtn:navIndex isSelected:YES];
    } else {
        [self.customNavBar resetSelectBtn:0 isSelected:NO];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.phAssetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSBrowserCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TSBrowserCollectionCell class])] forIndexPath:indexPath];
    cell.phAsset = self.phAssetsArray[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    
    [cell handleSingleTapActionWithBlock:^{
        if (weakSelf.customNavBar.isShow) {
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.customNavBar.origin = CGPointMake(0, -64);
                weakSelf.bottomToolBar.origin = CGPointMake(0, SCREEN_HEIGHT + 1);
            }];
            weakSelf.customNavBar.isShow = NO;
        } else {
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.customNavBar.origin = CGPointMake(0, 0);
                weakSelf.bottomToolBar.origin = CGPointMake(0, SCREEN_HEIGHT - 50);
            }];
            weakSelf.customNavBar.isShow = YES;
        }
    }];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = round(scrollView.contentOffset.x / scrollView.width);
    [self resetNavbarSelectedBtn];
    
//    [self setOriginSize];
}

- (void)setOriginSize {
}

#pragma mark - getter and setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH + 20, SCREEN_HEIGHT) collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[TSBrowserCollectionCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TSBrowserCollectionCell class])]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        CGFloat const kLineSpacing = 20;
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewFlowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, kLineSpacing);
        _collectionViewFlowLayout.minimumLineSpacing = kLineSpacing;
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _collectionViewFlowLayout;
}

- (TSImageBrowserNavBar *)customNavBar {
    if (!_customNavBar) {
        _customNavBar = [[TSImageBrowserNavBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        
        @weakify(self)
        [_customNavBar handleBackActionWithBlock:^{
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [_customNavBar handleSelectedActionWithBlock:^(UIButton *sender, BOOL isSelected) {
            @strongify(self)
             NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            
            if (isSelected)
            {
                [[TSImageSelectedHandler shareInstance] addAsset:self.phAssetsArray[self.currentIndex]];
                [[TSImageSelectedHandler shareInstance] addIndex:currentIndexPath];
                
            }
            else
            {
                [[TSImageSelectedHandler shareInstance] removeAsset:self.phAssetsArray[self.currentIndex]];
                [[TSImageSelectedHandler shareInstance] removeIndex:currentIndexPath];
            }
            
            [self.bottomToolBar resetSelectPhotosNumber:[[TSImageSelectedHandler shareInstance] selectedIndexs].count];
            [self resetNavbarSelectedBtn];
        }];
    }
    return _customNavBar;
}

- (TSImageBrowserToolBar *)bottomToolBar {
    if (!_bottomToolBar) {
        _bottomToolBar = [[TSImageBrowserToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50) barStyle:UIBarStyleBlack];
        [_bottomToolBar resetSelectPhotosNumber:[[TSImageSelectedHandler shareInstance] selectedIndexs].count];
    }
    return _bottomToolBar;
}

@end
