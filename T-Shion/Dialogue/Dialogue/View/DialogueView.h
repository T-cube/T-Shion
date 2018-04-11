//
//  DialogueView.h
//  T-Shion
//
//  Created by together on 2018/3/22.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "DialogueViewModel.h"
#import "DialogueHeadView.h"
#import "DialogueTableViewCell.h"
#import "DialogueTableView.h"

@interface DialogueView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) DialogueViewModel *viewModel;
@property (nonatomic, strong) DialogueTableView *table;
@property (nonatomic, strong) DialogueHeadView *headView;
@end
