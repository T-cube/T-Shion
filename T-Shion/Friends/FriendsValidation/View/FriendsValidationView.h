//
//  FriendsValidationView.h
//  T-Shion
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "FriendsValidationViewModel.h"

@interface FriendsValidationView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UILabel *navTitle;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) FriendsValidationViewModel *viewModel;
@end
