//
//  BlackListView.h
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "BlackListViewModel.h"

@interface BlackListView : BaseView <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) BlackListViewModel *viewModel;

@property (strong, nonatomic) UILabel *navTitle;

@property (strong, nonatomic) UITableView *table;

@end
