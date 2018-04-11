//
//  MenuTableView.h
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "FriendsHeadView.h"
#import "SelfHeadView.h"
#import "FriendsViewModel.h"

@interface MenuTableView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) FriendsViewModel *viewModel;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) FriendsHeadView *friendsHeadView;
@property (strong, nonatomic) SelfHeadView *selfHeadView;
@property (strong, nonatomic) NSMutableArray *array;
@end
