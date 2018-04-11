//
//  CallRecordsHeadView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "CallRecordsHeadView.h"

@implementation CallRecordsHeadView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (CallRecordsViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}

- (void)setupViews {
    [self addSubview:self.seachView];
}

- (void)layoutSubviews {
    [self.seachView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-32, 35));
    }];
    [super layoutSubviews];
}

- (UIView *)seachView {
    if (!_seachView) {
        _seachView = [[UIView alloc] init];
        _seachView.layer.masksToBounds = YES;
        _seachView.layer.cornerRadius = 3;
        _seachView.backgroundColor = [UIColor whiteColor];
        UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dialogue_Search"]];
        [_seachView addSubview:searchImage];
        [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_seachView).with.offset(5);
            make.centerY.equalTo(_seachView);
            make.size.mas_offset(CGSizeMake(19, 19));
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        //                @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            //            @strongify(self)
            NSLog(@"111");
        }];
        [_seachView addGestureRecognizer:tap];
        
    }
    return _seachView;
}

@end
