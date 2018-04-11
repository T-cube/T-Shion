//
//  FriendsValidationView.m
//  T-Shion
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "FriendsValidationView.h"
#import "FriendsValidationTableViewCell.h"

@implementation FriendsValidationView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FriendsValidationViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.navTitle];
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(25);
        make.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(200, 33));
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.navTitle.mas_bottom).with.offset(10);
        make.width.offset(SCREEN_WIDTH);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [super updateConstraints];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsValidationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FriendsValidationTableViewCell class])] forIndexPath:indexPath];
    cell.buttonClickBlock = ^(int index) {
        NSLog(@"%d",index);
    };
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
        [_table registerClass:[FriendsValidationTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FriendsValidationTableViewCell class])]];
    }
    return _table;
}

- (UILabel *)navTitle {
    if (!_navTitle) {
        _navTitle = [[UILabel alloc] init];
        _navTitle.font = [UIFont systemFontOfSize:20];
        _navTitle.text = @"验证信息";
    }
    return _navTitle;
}


@end
