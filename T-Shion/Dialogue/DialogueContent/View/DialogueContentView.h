//
//  DialogueContentView.h
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "DialogueContentViewModel.h"
#import "DialogueContentViewTableViewCell.h"
#import "DialogueContentModel.h"
#import "DialogueContentHeadView.h"
#import "DialogueContentToolView.h"

@interface DialogueContentView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) DialogueContentViewModel *viewModel;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) DialogueContentHeadView *headView;

@property (strong, nonatomic) DialogueContentToolView *toolView;

@end
