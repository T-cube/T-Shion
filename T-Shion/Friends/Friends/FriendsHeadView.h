//
//  FriendsHeadView.h
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "FriendsView.h"
#import "FriendsViewModel.h"

@interface FriendsHeadView : BaseView
@property (strong, nonatomic) FriendsViewModel *viewModel;

@property (strong, nonatomic) UIImageView *backView;

@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UIView *seachView;

@property (strong, nonatomic) UIButton *validation;
@end
