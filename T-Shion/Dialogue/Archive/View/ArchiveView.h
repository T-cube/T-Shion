//
//  ArchiveView.h
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "ArchiveViewModel.h"

@interface ArchiveView : BaseView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) ArchiveViewModel *viewModel;

@property (strong, nonatomic) UILabel *navTitle;

@property (strong, nonatomic) UITableView *table;

@end
