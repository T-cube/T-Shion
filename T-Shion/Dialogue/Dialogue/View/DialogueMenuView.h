//
//  DialogueMenuView.h
//  T-Shion
//
//  Created by together on 2018/3/30.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "DialogueViewModel.h"

@interface DialogueMenuView : BaseView <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) DialogueViewModel *viewModel;

@property (strong, nonatomic) UIView *menuBackgroundView;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) NSArray *imageArray;
@end
