//
//  TSImageCollectionController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageCollectionController.h"
#import "TSImageHandler.h"
#import "UIScrollView+TS.h"
#import "NSString+TS.h"
#import "TSImageCollectionCell.h"
#import "TSImageSelectedHandler.h"
#import "TSImageBrowserController.h"
#import "TSImageBrowserToolBar.h"

@interface TSImageCollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic , strong) UIButton *cancleBtn;

@property (nonatomic , assign) BOOL needOriginal;
@property (nonatomic , copy) NSArray <PHAsset *>*phAssetsArray;
@property (nonatomic , assign) NSInteger lastSelectedIndex;
@property (nonatomic , strong) PHCachingImageManager *cachingImageManager;
@property (nonatomic , strong) TSImageHandler *imageHandler;
@property (nonatomic , strong) TSImageBrowserToolBar *toolBar;

@end

@implementation TSImageCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver];
    [self addChildView];
    [self loadPhotos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //预览回来进行刷新
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[TSImageSelectedHandler shareInstance] removeAllAssets];
    [[TSImageSelectedHandler shareInstance] removeAllIndexs];
}

- (void)addChildView {
    self.title = [NSString replaceEnglishAssetCollectionNamme:self.assetCollection.localizedTitle];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolBar];
    self.view.userInteractionEnabled = YES;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:self.cancleBtn];
    self.navigationItem.rightBarButtonItem = barButton;
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)loadPhotos {
    @weakify(self)
    [self.imageHandler enumerateAssetsInAssetCollection:self.assetCollection finishBlock:^(NSArray <PHAsset *>*result) {
        @strongify(self)
        self.phAssetsArray = [NSArray arrayWithArray:result];
        [self.collectionView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollsToBottomAnimated:NO];
        });
    }];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAssetsAddNotification:) name:kSelectAssetsAddNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAssetsRemoveNotification:) name:kSelectAssetsRemoveNotification object:nil];
}

- (void)selectAssetsAddNotification:(NSNotification *)notification {
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:[[TSImageSelectedHandler shareInstance] selectedIndexs]];
    [array removeLastObject];
    [self.collectionView reloadItemsAtIndexPaths:array];
    [_toolBar resetSelectPhotosNumber:[[TSImageSelectedHandler shareInstance] selectedIndexs].count];
}

- (void)selectAssetsRemoveNotification:(NSNotification *)notification {
     [self.collectionView reloadItemsAtIndexPaths:[[TSImageSelectedHandler shareInstance] selectedIndexs]];
    [_toolBar resetSelectPhotosNumber:[[TSImageSelectedHandler shareInstance] selectedIndexs].count];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.phAssetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TSImageCollectionCell class])] forIndexPath:indexPath];
    cell.phAsset = self.phAssetsArray[indexPath.row];
    cell.indexPath = indexPath;
    [cell resetSelected:[[TSImageSelectedHandler shareInstance] containsAsset:cell.phAsset]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    TSImageBrowserController *browserVC = [[TSImageBrowserController alloc] init];
    browserVC.phAssetsArray = self.phAssetsArray;
    browserVC.currentIndex = indexPath.row;
    [self.navigationController pushViewController:browserVC animated:YES];
}


#pragma mark - getter and setter;
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor TSKeyBackgroundColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TSImageCollectionCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TSImageCollectionCell class])]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        CGFloat kPadding = 3.f;
        CGFloat kWidth = (SCREEN_WIDTH - 5 * kPadding) / 4;
        _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionViewFlowLayout.itemSize = CGSizeMake(kWidth, kWidth);
        _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(kPadding, kPadding, kPadding + 50, kPadding);
        _collectionViewFlowLayout.minimumInteritemSpacing = kPadding;
        _collectionViewFlowLayout.minimumLineSpacing = kPadding;
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _collectionViewFlowLayout;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor TSWhiteColor] forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancleBtn.frame = CGRectMake(0, 0, 50, 34);
        @weakify(self)
        [[_cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _cancleBtn;
}

- (TSImageBrowserToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[TSImageBrowserToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50) barStyle:UIBarStyleDefault];
        [_toolBar resetSelectPhotosNumber:[[TSImageSelectedHandler shareInstance] selectedIndexs].count];
        @weakify(self)
        [_toolBar handlePreviewButtonWithBlock:^{
            @strongify(self)
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
            TSImageBrowserController *browserVC = [[TSImageBrowserController alloc] init];
            browserVC.phAssetsArray = self.phAssetsArray;
            NSIndexPath *tempIndexPath = [[TSImageSelectedHandler shareInstance] selectedIndexs][0];
            browserVC.currentIndex = tempIndexPath.row;
            [self.navigationController pushViewController:browserVC animated:YES];
        }];
        
        [_toolBar handleFinishedButtonWithBlock:^{
            
        }];
    }
    return _toolBar;
}

- (TSImageHandler *)imageHandler {
    if (!_imageHandler) {
        _imageHandler = [[TSImageHandler alloc] init];
    }
    return _imageHandler;
}

- (PHCachingImageManager *)cachingImageManager {
    if (!_cachingImageManager) {
        _cachingImageManager = [[PHCachingImageManager alloc] init];
    }
    return _cachingImageManager;
}

@end
