//
//  AddFriendsView.h
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "AddFriendsViewModel.h"

@interface AddFriendsView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) AddFriendsViewModel *viewModel;

@property (strong, nonatomic) UITableView *table;

@end
