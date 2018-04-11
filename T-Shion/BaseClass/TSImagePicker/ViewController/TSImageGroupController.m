//
//  TSImageGroupController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageGroupController.h"
#import "TSImageCollectionController.h"
#import "TSImageHandler.h"
#import "TSImageGroupCell.h"

static NSString *const kPushToCollectionPageNotification = @"kPushToCollectionPageNotification";

@interface TSImageGroupController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic) UITableView *tableView;
@property (strong , nonatomic) UIButton *cancleBtn;
@property (strong , nonatomic) TSImageHandler *imageHandler;
@property (nonatomic, copy) NSArray <PHAssetCollection *>*assetCollections;

@property (nonatomic, assign) BOOL pushToCollectionPage;

@end

@implementation TSImageGroupController

- (instancetype)init {
    if (self = [super init]) {
        [self addObserver];
        [self setUpViews];
        [self loadPhotos];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"照片";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - private
- (void)setUpViews {
    self.pushToCollectionPage = NO;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:self.cancleBtn];
    self.navigationItem.rightBarButtonItem = barButton;
    
    __weak typeof(self) weakSelf = self;
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)loadPhotos {
    __weak typeof(self) weakSelf = self;
    [self.imageHandler enumeratePHAssetCollectionsWithResultHandler:^(NSArray<PHAssetCollection *> *result) {
        weakSelf.assetCollections = [NSArray arrayWithArray:result];
        [weakSelf.tableView reloadData];
        if (weakSelf.pushToCollectionPage) {
            [weakSelf pushToNextPage:0 animated:NO];
        }

    }];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePushToCollectionPage:) name:kPushToCollectionPageNotification object:nil];
}

- (void)handlePushToCollectionPage:(NSNotification *)notification {
    self.pushToCollectionPage = YES;
}

- (void)pushToNextPage:(NSInteger)index animated:(BOOL)animated {
    if (index >= self.assetCollections.count) {
        return;
    }

    TSImageCollectionController *imageCollectionVC = [[TSImageCollectionController alloc] init];
    PHAssetCollection *collection = self.assetCollections[index];
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    imageCollectionVC.assetCollection = collection;
    imageCollectionVC.fetchResult = fetchResult;
    [self.navigationController pushViewController:imageCollectionVC animated:animated];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assetCollections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TSImageGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([TSImageGroupCell class])] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell reloadDataWithAssetCollection:self.assetCollections[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToNextPage:indexPath.row animated:YES];
}

#pragma mark - getter and setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[TSImageGroupCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([TSImageGroupCell class])]];

    }
    return _tableView;
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

- (TSImageHandler *)imageHandler {
    if (!_imageHandler) {
        _imageHandler = [[TSImageHandler alloc] init];
    }
    return _imageHandler;
}





@end
