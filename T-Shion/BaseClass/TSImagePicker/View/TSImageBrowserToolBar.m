//
//  TSImageBrowserToolBar.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageBrowserToolBar.h"
#import "UIImage+TS.h"

@interface TSImageBrowserToolBar ()

@property (nonatomic, strong) UIButton *finishedButton;
@property (nonatomic, strong) UIButton *previewButton;

@property (nonatomic, copy) dispatch_block_t previewBlock;
@property (nonatomic, copy) dispatch_block_t finishedBlock;

@end

@implementation TSImageBrowserToolBar

- (instancetype)initWithFrame:(CGRect)frame barStyle:(UIBarStyle)barStyle {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.barStyle = barStyle;
        
        [self addSubview:self.finishedButton];
        [self addSubview:self.previewButton];
        
        self.previewButton.hidden = self.barStyle == UIBarStyleBlack;
        
        __weak typeof(self) weakSelf = self;
        
        [self.finishedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(weakSelf);
            make.width.mas_equalTo(80);
        }];
        
        [self.previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(weakSelf);
            make.width.mas_equalTo(80);
        }];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    NSArray *subViewArray = [self subviews];
    
    for (id view in subViewArray) {
        if ([view isKindOfClass:(NSClassFromString(@"_UIToolbarContentView"))]) {
            UIView *testView = view;
            testView.userInteractionEnabled = NO;
        }
    }
}

- (void)handleFinishedButtonWithBlock:(dispatch_block_t)block {
    if (block) {
        self.finishedBlock = block;
    }
}

- (void)handlePreviewButtonWithBlock:(dispatch_block_t)block {
    if (block) {
        self.previewBlock = block;
    }
}

- (void)resetSelectPhotosNumber:(NSInteger)number {
    if (number == 0) {
        _finishedButton.enabled = NO;
         _previewButton.enabled = NO;
        [_finishedButton setTitle:@"发送" forState:UIControlStateNormal];
    } else {
        _finishedButton.enabled= YES;
        _previewButton.enabled = YES;
        [_finishedButton setTitle:[NSString stringWithFormat:@"发送( %ld )",number] forState:UIControlStateNormal];
    }
}

//- (void)previewButtonClick:(UIButton *)sender {
//    NSLog(@"-----dwaddddd");
//    self.previewBlock();
//}

#pragma mark - getter and setter
- (UIButton *)finishedButton {
    if (!_finishedButton) {
        _finishedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishedButton setTitle:@"发送" forState:UIControlStateNormal];
        
        [_finishedButton setTitleColor:[UIColor TSBlueColor] forState:UIControlStateNormal];
        [_finishedButton setTitleColor:[UIColor TSTextGrayColor] forState:UIControlStateDisabled];
        _finishedButton.titleLabel.font = [UIFont systemFontOfSize:15];

        @weakify(self)
        [[_finishedButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"-----dwad");
            if (self.finishedBlock) {
                self.finishedBlock();
            }
        }];
        
    }
    return _finishedButton;
}

- (UIButton *)previewButton {
    if (!_previewButton) {
        _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor TSBlueColor] forState:UIControlStateNormal];
        [_previewButton setTitleColor:[UIColor TSTextGrayColor] forState:UIControlStateDisabled];
        _previewButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
//        [_previewButton addTarget:self action:@selector(previewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        @weakify(self)
        [[_previewButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"-----dwad");
            if (self.previewBlock) {
                self.previewBlock();
            }
        }];
        
    }
    return _previewButton;
}

@end
