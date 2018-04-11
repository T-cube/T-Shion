//
//  DialogueHeadView.h
//  T-Shion
//
//  Created by together on 2018/3/22.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "DialogueViewModel.h"

@interface DialogueHeadView : BaseView
@property (strong, nonatomic) DialogueViewModel *viewModel;
@property (strong, nonatomic) UIView *seachView;
@end
