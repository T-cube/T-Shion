//
//  CallRecordsSegmentControl.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsSegmentControl.h"
#import "CallRecordsViewModel.h"

@interface CallRecordsSegmentControl ()

@property (strong , nonatomic) UISegmentedControl *segmentCtl;
@property (strong , nonatomic) CallRecordsViewModel *viewModel;

@end


@implementation CallRecordsSegmentControl

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (CallRecordsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - system
- (void)updateConstraints {
    [self.segmentCtl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [super updateConstraints];
}

- (void)setupViews {
    [self addSubview:self.segmentCtl];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

#pragma mark - getter and setter
- (UISegmentedControl *)segmentCtl {
    if (!_segmentCtl) {
        _segmentCtl = [[UISegmentedControl alloc] initWithItems:@[@"所有通话",@"未接来电"]];
        _segmentCtl.selectedSegmentIndex = 0;
    }
    return _segmentCtl;
}

@end
