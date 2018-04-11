//
//  ArchiveView.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "ArchiveView.h"
#import "ArchiveTableViewCell.h"

@implementation ArchiveView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.navTitle];
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(100, 23));
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.navTitle.mas_bottom).with.offset(20);
        make.bottom.equalTo(self.mas_bottom);
        make.width.offset(SCREEN_WIDTH);
    }];
    [super updateConstraints];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArchiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ArchiveTableViewCell class])] forIndexPath:indexPath];
    
    return cell;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = DEFAULT_COLOR;
        _table.sectionHeaderHeight = 0.5f;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[ArchiveTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ArchiveTableViewCell class])]];
    }
    return _table;
}

- (UILabel *)navTitle {
    if (!_navTitle) {
        _navTitle = [[UILabel alloc] init];
        _navTitle.font = [UIFont systemFontOfSize:20];
        _navTitle.text = @"归档";
    }
    return _navTitle;
}

@end
