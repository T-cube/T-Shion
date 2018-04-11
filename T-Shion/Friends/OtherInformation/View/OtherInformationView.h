//
//  OhterInformationView.h
//  T-Shion
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "NameCardView.h"
#import "OtherInformationViewModel.h"

@interface OtherInformationView : BaseView <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) OtherInformationViewModel *viewModel;

@property (strong, nonatomic) NameCardView *informationView;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) NSMutableArray *titleArray;
@end
