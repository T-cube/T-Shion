//
//  QRCodeView.h
//  T-Shion
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseView.h"
#import "QRCodeViewModel.h"
#import <CoreImage/CoreImage.h>

@interface QRCodeView : BaseView
@property (strong, nonatomic) QRCodeViewModel *viewModel;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIImageView *qrCodeView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *navTitle;
@end
