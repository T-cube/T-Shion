//
//  TSImageBrowserNavBar.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageBrowserNavBar.h"
#import "UIImage+TS.h"
#import "TSImageSelectedHandler.h"

@interface TSImageBrowserNavBar ()

@property (strong , nonatomic) UIButton *backBtn;
@property (strong , nonatomic) UIButton *selectedBtn;

@property (copy , nonatomic) dispatch_block_t backBlock;
@property (copy , nonatomic) TSImageBrowserSelectedBlock selectedBlock;

@end

@implementation TSImageBrowserNavBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBACOLOR(34, 34, 34, 0.6);
        self.isShow = YES;
        [self addSubview:self.backBtn];
        [self addSubview:self.selectedBtn];
        
        __weak typeof(self) weakSelf = self;
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(20, 20));
            make.centerY.equalTo(weakSelf);
            make.left.mas_equalTo(15);
        }];
        
        [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(24, 24));
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf).offset(-15);
        }];
    }
    return self;
}

- (void)backBtnClick:(UIButton *)sender {
    if (_backBlock) {
        _backBlock();
    }
}

- (void)selectedBtnClick:(UIButton *)sender {
    if (!sender.selected && [[TSImageSelectedHandler shareInstance] selectedIndexs].count >= [[TSImageSelectedHandler shareInstance] maxSelectedCount]) {
        NSLog(@"----------超过选中数量，不能再选了");
        return;
    }

    sender.selected = !sender.isSelected;
    [self addScaleAnimation:sender];
    if (_selectedBlock) {
        _selectedBlock(sender,sender.isSelected);
    }
}

- (void)handleBackActionWithBlock:(dispatch_block_t)block {
    self.backBlock = block;
}

- (void)handleSelectedActionWithBlock:(TSImageBrowserSelectedBlock)block {
    self.selectedBlock = block;
}

- (void)resetSelectBtn:(NSInteger)currentIndex isSelected:(BOOL)isSelected {
    self.selectedBtn.selected = isSelected;
    if (isSelected) {
        [self.selectedBtn setTitle:[NSString stringWithFormat:@"%ld",currentIndex + 1] forState:UIControlStateNormal];
    } else {
        [self.selectedBtn setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)addScaleAnimation:(UIView *)totalView {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.duration = 0.4f;
    NSValue *value0 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.25, 1.25, 1)];
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)];
    NSValue *value3 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    NSValue *value4 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)];
    NSValue *value5 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    animation.values = @[value0,
                         value1,
                         value2,
                         value3,
                         value4,
                         value5];
    if (totalView.layer) {
        [totalView.layer addAnimation:animation forKey:nil];
    }
}


#pragma mark - getter and setter
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"NavigationBar_Back_white"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setBackgroundImage:[UIImage imageNamed:@"photo_selected_n"] forState:UIControlStateNormal];
        [_selectedBtn setBackgroundImage:[UIImage imageWithColor:[UIColor TSBlueColor]] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectedBtn.layer.masksToBounds = YES;
        _selectedBtn.layer.cornerRadius = 12;
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _selectedBtn;
}



@end
