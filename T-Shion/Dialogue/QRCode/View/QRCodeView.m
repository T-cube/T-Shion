//
//  QRCodeView.m
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "QRCodeView.h"

@implementation QRCodeView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (QRCodeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.navTitle];
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.qrCodeView];
    [self.qrCodeView addSubview:self.iconImageView];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(200, 23));
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navTitle.mas_bottom).with.offset(110);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(280, 280));
    }];
    
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backgroundView);
        make.size.mas_offset(CGSizeMake(230, 230));
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.qrCodeView);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    [super updateConstraints];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (UILabel *)navTitle {
    if (!_navTitle) {
        _navTitle = [[UILabel alloc] init];
        _navTitle.font = [UIFont systemFontOfSize:20];
        _navTitle.text = @"我的二维码";
    }
    return _navTitle;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.layer.masksToBounds = YES;
        _backgroundView.layer.cornerRadius = 3;
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIImageView *)qrCodeView {
    if (!_qrCodeView) {
        _qrCodeView = [[UIImageView alloc] init];
        _qrCodeView.backgroundColor = [UIColor greenColor];
        // 实例化二维码滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        // 恢复滤镜的默认属性
        [filter setDefaults];
        
        NSString *phoneNum = @"lz88897";
        // 将字符串转换成NSdata
        NSData *data = [phoneNum dataUsingEncoding:NSUTF8StringEncoding];
        // 通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
        [filter setValue:data forKey:@"inputMessage"];
        // 设置 filter 容错等级
        [filter setValue:@"M" forKey:@"inputCorrectionLevel"];
        // 生成二维码
        CIImage *outputImage = [filter outputImage];
        
        _qrCodeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:230.0];
 
    }
    return _qrCodeView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 4;
        _iconImageView.layer.borderWidth = 1;
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _iconImageView;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
@end
