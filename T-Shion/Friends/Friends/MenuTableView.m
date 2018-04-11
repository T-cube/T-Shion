//
//  MenuTableView.m
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "MenuTableView.h"
#import "FriendsTableViewCell.h"

@implementation MenuTableView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (FriendsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.friendsHeadView];
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.friendsHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.offset(126);
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.friendsHeadView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
    }];
    
    [super updateConstraints];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] init];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 30, 30)];
    [title setText:self.array[section]];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor blackColor];
    [sectionView addSubview:title];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FriendsTableViewCell class])] forIndexPath:indexPath];
    @weakify(self)
    cell.cellClickBlock = ^{
     @strongify(self)
        [self.viewModel.callingClickSubject sendNext:nil];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.sendMessageClickSubject sendNext:nil];
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
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = RGB(234, 234, 234);
        _table.tableHeaderView = self.selfHeadView;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[FriendsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FriendsTableViewCell class])]];
    }
    return _table;
}

- (FriendsHeadView *)friendsHeadView {
    if (!_friendsHeadView) {
        _friendsHeadView = [[FriendsHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _friendsHeadView;
}

- (SelfHeadView *)selfHeadView {
    if (!_selfHeadView) {
        _selfHeadView = [[SelfHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _selfHeadView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
         @strongify(self)
            [self.viewModel.setingClickSubject sendNext:nil];
        }];
        [_selfHeadView addGestureRecognizer:tap];
    }
    return _selfHeadView;
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#", nil];
    }
    return _array;
}

@end
