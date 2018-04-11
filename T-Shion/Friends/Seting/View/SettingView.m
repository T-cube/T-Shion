//
//  SettingView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/23.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "SettingView.h"
#import "SettingViewModel.h"
#import "NameCardView.h"

#define idResuse  @"SettingCell"


@interface SettingView ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic) UITableView *mainTableView;
@property (strong , nonatomic) NameCardView *headView;
@property (strong , nonatomic) UIButton *signOutBtn;
@property (strong , nonatomic) SettingViewModel *viewModel;

@end

@implementation SettingView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (SettingViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
#pragma mark - privite
- (void)setupViews {
    [self addSubview:self.mainTableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)bindViewModel {
    
}
#pragma mark - system
- (void)updateConstraints {
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idResuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idResuse];
    }
    
    cell.textLabel.text = self.viewModel.titleArray[indexPath.row];
    cell.textLabel.textColor = RGB(51, 51, 51);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = DEFAULT_COLOR;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewModel.cellClickSubject sendNext:@(indexPath.row)];
}

#pragma mark - getter and setter
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = DEFAULT_COLOR;
        _mainTableView.tableFooterView = self.signOutBtn;
        _mainTableView.tableHeaderView = self.headView;
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:idResuse];
    }
    return _mainTableView;
}

- (NameCardView *)headView {
    if (!_headView) {
        _headView = [[NameCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _headView.isOneself = YES;
        @weakify(self)
        _headView.buttonClickBlock = ^(int index) {
            @strongify(self)
            [self.viewModel.cardClickSubject sendNext:@(index)];
        };
    }
    return _headView;
}

- (UIButton *)signOutBtn {
    if (!_signOutBtn) {
        _signOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [_signOutBtn setTitleColor:RGB(255,99,121) forState:UIControlStateNormal];
        [_signOutBtn setTitle:@"退出当前用户" forState:UIControlStateNormal];
        [_signOutBtn setTitleColor:[UIColor TSRedColor] forState:UIControlStateNormal];
    }
    return _signOutBtn;
}
@end
