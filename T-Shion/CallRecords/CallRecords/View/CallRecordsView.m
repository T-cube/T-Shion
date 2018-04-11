//
//  CallRecordsView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsView.h"
#import "CallRecordsViewModel.h"
#import "CallRecordsTableViewCell.h"
#import "CallRecordsHeadView.h"

@interface CallRecordsView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *mainTableView;
@property (strong , nonatomic) CallRecordsHeadView *headView;
@property (strong , nonatomic) CallRecordsViewModel *viewModel;

@end


@implementation CallRecordsView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (CallRecordsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - private
- (void)setupViews {
    [self addSubview:self.mainTableView];
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
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CallRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CallRecordsTableViewCell class])] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.viewModel = self.viewModel;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 在数据源中删除一行
        
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray  *btnArray = [NSMutableArray array];
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除记录" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"删除了");
    }];
    
    deleteRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    [btnArray addObject:deleteRowAction];
    return btnArray;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        [_mainTableView registerClass:[CallRecordsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CallRecordsTableViewCell class])]];
        _mainTableView.tableHeaderView = self.headView;

    }
    return _mainTableView;
}

- (CallRecordsHeadView *)headView {
    if (!_headView) {
        _headView = [[CallRecordsHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 55);
    }
    return _headView;
}


@end
