//
//  CallRecordsHeadView.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "CallRecordsViewModel.h"

@interface CallRecordsHeadView : BaseView

@property (strong, nonatomic) CallRecordsViewModel *viewModel;
@property (strong, nonatomic) UIView *seachView;

@end
