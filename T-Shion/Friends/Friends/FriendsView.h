//
//  FriendsView.h
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "MenuTableView.h"
#import "FriendsViewModel.h"

@interface FriendsView : BaseView<UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) FriendsViewModel *viewModel;
@property (nonatomic,assign) BOOL canLeft;
@property (nonatomic,assign) BOOL canRight;
@property (strong, nonatomic) MenuTableView *menuTableView;
#pragma mark method
- (void)show;
- (void)hidden;
@end
