//
//  CallDetailView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallDetailView.h"

@interface CallDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *mainTableView;
@property (strong , nonatomic) UIView *headView;

@end

@implementation CallDetailView

- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *idResuse = @"CallRecordsDetailTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idResuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idResuse];
    }
    
    cell.textLabel.text = @"呼出电话";
    cell.detailTextLabel.text = @"2018-03-34 12:30";
    cell.textLabel.textColor = [UIColor TSTextNormalColor];
    cell.detailTextLabel.textColor = [UIColor TSTextGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = [UIColor TSKeyBackgroundColor];
    return cell;
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

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        _headView.backgroundColor = [UIColor TSKeyBackgroundColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 55)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:21];
        titleLabel.textColor = [UIColor TSTextDarkColor];
        titleLabel.text = @"通话详情";
        [_headView addSubview:titleLabel];
    }
    return _headView;
}


@end
