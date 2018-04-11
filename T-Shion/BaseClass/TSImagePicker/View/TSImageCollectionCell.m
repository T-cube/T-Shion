//
//  TSImageCollectionCell.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageCollectionCell.h"
#import <Photos/Photos.h>
#import "PHAsset+TS.h"
#import "UIImage+TS.h"
#import "TSImageSelectedHandler.h"

static CGFloat const kPadding = 3.f;
#define kImageCollectionCellWidth (SCREEN_WIDTH - 5 * kPadding) / 4

@interface TSImageCollectionCell()

@property (strong , nonatomic) UIImageView *imageView;
@property (strong , nonatomic) UIButton *selectedBtn;


@end

@implementation TSImageCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.selectedBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(3);
        make.right.equalTo(self.contentView).offset(-3);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    
    [super layoutSubviews];
}

- (void)selectedBtnClick:(UIButton *)sender {
    if (!sender.selected && [[TSImageSelectedHandler shareInstance] selectedIndexs].count >= [[TSImageSelectedHandler shareInstance] maxSelectedCount]) {
        NSLog(@"----------超过选中数量，不能再选了");
        return;
    }
    
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [[TSImageSelectedHandler shareInstance] addAsset:self.phAsset];
        [[TSImageSelectedHandler shareInstance] addIndex:self.indexPath];
        [self postSelectAssetsAddNotification:self.indexPath];
        [self addScaleAnimation:sender];
        
        NSInteger index = [[[TSImageSelectedHandler shareInstance] selectedIndexs] indexOfObject:self.indexPath] + 1;
        
        [self.selectedBtn setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
     
    } else {
        [[TSImageSelectedHandler shareInstance] removeAsset:self.phAsset];
        [[TSImageSelectedHandler shareInstance] removeIndex:self.indexPath];
        [self postSelectAssetsRemoveNotification:self.indexPath];
        [self.selectedBtn setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)resetSelected:(BOOL)selected {
    self.selectedBtn.selected = selected;
    if (selected) {
        NSInteger index = [[[TSImageSelectedHandler shareInstance] selectedIndexs] indexOfObject:self.indexPath] + 1;
        
        [self.selectedBtn setTitle:[NSString stringWithFormat:@"%ld",index] forState:UIControlStateNormal];
    } else {
        [self.selectedBtn setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)postSelectAssetsRemoveNotification:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectAssetsRemoveNotification object:indexPath];
}

- (void)postSelectAssetsAddNotification:(NSIndexPath *)indexPath {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectAssetsAddNotification object:indexPath];
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
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setBackgroundImage:[UIImage imageNamed:@"photo_selected_n"] forState:UIControlStateNormal];
        [_selectedBtn setBackgroundImage:[UIImage imageWithColor:[UIColor TSBlueColor]] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(selectedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectedBtn.layer.cornerRadius = 10;
        _selectedBtn.layer.masksToBounds = YES;
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _selectedBtn;
}

- (void)setPhAsset:(PHAsset *)phAsset {
    _phAsset = phAsset;
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        @strongify(self)
        [phAsset thumbnail:CGSizeMake((SCREEN_WIDTH - 5 * kPadding) / 4, (SCREEN_WIDTH - 5 * kPadding) / 4) resultHandler:^(UIImage *result, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = result;
            });
        }];
    });
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}
@end
