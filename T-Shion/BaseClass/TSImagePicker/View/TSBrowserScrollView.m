//
//  TSBrowserScrollView.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSBrowserScrollView.h"

static CGFloat const kMAXZoomScale = 3.f;
static CGFloat const kMINZoomScale = 1.f;

@interface TSBrowserScrollView ()<UIScrollViewDelegate>

@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , copy) dispatch_block_t singleBlock;
@property (nonatomic , copy) dispatch_block_t doubleBlock;

@end


@implementation TSBrowserScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.imageView];
        
        self.delegate = self;
        self.maximumZoomScale = kMAXZoomScale;
        self.minimumZoomScale = kMINZoomScale;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapAction:)];
        singleTap.numberOfTapsRequired = 1;
        [_imageView addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapAction:)];
        doubleTap.numberOfTapsRequired = 2;
        [_imageView addGestureRecognizer:doubleTap];
        
        // 只有当没有检测到doubleTap或者检测doubleTap失败singleTap才有效
        // 解决单击和双击手势冲突
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

#pragma mark - private
- (void)handleSingleTapAction:(UITapGestureRecognizer *)singleTap {
    if (_singleBlock) {
        _singleBlock();
    }
}

- (void)handleDoubleTapAction:(UITapGestureRecognizer *)doubleTap {
    if (_doubleBlock) {
        _doubleBlock();
    }
    
    if (self.zoomScale == kMINZoomScale) {
        [self setZoomScale:kMAXZoomScale animated:YES];
    } else {
        [self setZoomScale:kMINZoomScale animated:YES];
    }
}

- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block {
    self.singleBlock = block;
}

- (void)handleDoubleTapActionWithBlock:(dispatch_block_t)block {
    self.doubleBlock = block;
}

- (void)resetImageViewFrame:(CGSize)imageViewSize imageSize:(CGSize)imageSize {
    if (imageViewSize.width > 0 && imageViewSize.height > 0) {
        if (imageSize.width > 0 && imageSize.height > 0) { // 横条样式
            imageViewSize = CGSizeMake(self.width, imageSize.height / imageSize.width * imageViewSize.width);
        } else { // 竖条样式
            imageViewSize = CGSizeMake(imageSize.width / imageSize.height * imageViewSize.height, self.height);
        }
        self.imageView.frame = CGRectMake((self.width - imageViewSize.width) / 2, (self.height - imageViewSize.height) / 2, imageViewSize.width, imageViewSize.height);
    }
}

#pragma mark - scrollView protocol methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat centerX = scrollView.centerX;
    CGFloat centerY = scrollView.centerY;
    
    centerX = scrollView.contentSize.width > scrollView.width ? scrollView.contentSize.width / 2 : centerX;
    centerY = scrollView.contentSize.height > scrollView.height ? scrollView.contentSize.height / 2 : centerY;
    self.imageView.center = CGPointMake(centerX, centerY);
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
    [self resetImageViewFrame:self.size imageSize:image.size];
}

@end
