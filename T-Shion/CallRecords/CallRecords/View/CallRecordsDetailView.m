//
//  CallRecordsDetailView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsDetailView.h"
#import "CallRecordsDetailViewModel.h"
#import "CallRecordsDetailHeadView.h"
#import "SettingViewModel.h"

@interface CallRecordsDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *mainTableView;
@property (strong , nonatomic) CallRecordsDetailHeadView *headView;
@property (strong , nonatomic) CallRecordsDetailViewModel *viewModel;
@property (strong , nonatomic) SettingViewModel *nameCardViewModel;
@property (copy , nonatomic) NSArray *titleArray;

@property (strong , nonatomic) UISwitch *stickSwitch;
@property (strong , nonatomic) UISwitch *blacklistSwitch;


@end

@implementation CallRecordsDetailView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (CallRecordsDetailViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - private
- (void)setupViews {
    [self addSubview:self.mainTableView];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idResuse = @"CallRecordsDetailTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idResuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idResuse];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.textColor = indexPath.row < self.titleArray.count - 1 ? [UIColor TSTextNormalColor] : [UIColor TSRedColor];
    
    cell.accessoryType = indexPath.row < self.titleArray.count - 1 ?UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    
    if (indexPath.row == 2) {
        cell.accessoryView = self.stickSwitch;
    } else if (indexPath.row == 3) {
        cell.accessoryView = self.blacklistSwitch;
    }
    
    cell.selectionStyle = indexPath.row == 2 || indexPath.row == 3 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
    
    cell.backgroundColor = [UIColor TSKeyBackgroundColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2 || indexPath.row == 2) {return;}
    [self.viewModel.cellClickSubject sendNext:@"点击-cell"];
}

#pragma mark - getter and setter
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = [UIColor TSKeyBackgroundColor];
        _mainTableView.tableHeaderView = self.headView;
    }
    return _mainTableView;
}

- (CallRecordsDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[CallRecordsDetailHeadView alloc] initWithViewModel:self.nameCardViewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    }
    return _headView;
}

- (UISwitch *)stickSwitch {
    if (!_stickSwitch) {
        _stickSwitch = [[UISwitch alloc] init];
        _stickSwitch.tag = 10001;
    }
    return _stickSwitch;
}

- (UISwitch *)blacklistSwitch {
    if (!_blacklistSwitch) {
        _blacklistSwitch = [[UISwitch alloc] init];
        _blacklistSwitch.tag = 10002;
    }
    return _blacklistSwitch;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"全部通话记录",
                        @"设置备注",
                        @"置顶聊天",
                        @"消息勿扰",
                        @"加入黑名单",
                        @"删除联系人"];
    }
    return _titleArray;
}

@end
