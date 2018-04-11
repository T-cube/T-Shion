//
//  TSBrowserCollectionCell.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSBrowserCollectionCell.h"
#import "TSBrowserScrollView.h"
#import "PHAsset+TS.h"

@interface TSBrowserCollectionCell ()

@property (nonatomic, strong) TSBrowserScrollView *scrollView;

@end


@implementation TSBrowserCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block {
    [_scrollView handleSingleTapActionWithBlock:block];
}

#pragma mark - getter and setter
- (TSBrowserScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[TSBrowserScrollView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    }
    return _scrollView;
}

- (void)setPhAsset:(PHAsset *)phAsset {
    _phAsset = phAsset;
    _scrollView.zoomScale = 1.f;
    _scrollView.contentSize = _scrollView.size;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        [phAsset requestImageForTargetSize:[UIScreen mainScreen].bounds.size resultHandler:^(UIImage *result, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _scrollView.image = result;
            });
        }];
    });

}

@end
