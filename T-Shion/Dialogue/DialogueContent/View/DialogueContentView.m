//
//  DialogueContentView.m
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentView.h"

@implementation DialogueContentView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (DialogueContentViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.headView];
    [self addSubview:self.table];
    [self addSubview:self.toolView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 46));
    }];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 46));
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.toolView.mas_top);
        make.width.offset(SCREEN_WIDTH);
    }];
    
    [super updateConstraints];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogueContentModel *model = self.viewModel.dataList[indexPath.row];
    CGFloat timeHeight = model.showMessageTime == YES ? 38: 11;
    return model.contentSize.height+timeHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogueContentViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DialogueContentViewTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataList[indexPath.row];
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
        _table.backgroundColor  = RGB(246, 246, 246);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[DialogueContentViewTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DialogueContentViewTableViewCell class])]];
    }
    return _table;
}

- (DialogueContentHeadView *)headView {
    if (!_headView) {
        _headView = [[DialogueContentHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _headView;
}

- (DialogueContentToolView *)toolView {
    if (!_toolView) {
        _toolView = [[DialogueContentToolView alloc] initWithViewModel:self.viewModel];
    }
    return _toolView;
}
@end
