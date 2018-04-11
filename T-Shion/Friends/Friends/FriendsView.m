//
//  FriendsView.m
//  T-Shion
//
//  Created by together on 2018/3/21.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "FriendsView.h"

#define AnimateTime 0.4
#define TableWidth  320

@implementation FriendsView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.menuTableView];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)layoutSubviews {
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:AnimateTime animations:^{
        self.menuTableView.frame = CGRectMake(0, 0, TableWidth, SCREEN_HEIGHT);
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    } completion:^(BOOL finished) {
    }];
}

- (void)hidden {
    [UIView animateWithDuration:AnimateTime animations:^{
        self.menuTableView.frame = CGRectMake(-TableWidth, 0, TableWidth, SCREEN_HEIGHT);
        [self setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hidden];
}

- (MenuTableView *)menuTableView {
    if (!_menuTableView) {
        _menuTableView = [[MenuTableView alloc] initWithViewModel:self.viewModel];
        _menuTableView.frame = CGRectMake(-TableWidth, 0, TableWidth, SCREEN_HEIGHT);
        _menuTableView.backgroundColor = [UIColor whiteColor];
        _menuTableView.userInteractionEnabled = YES;
    }
    return _menuTableView;
}

- (FriendsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FriendsViewModel alloc] init];
    }
    return _viewModel;
}
@end
