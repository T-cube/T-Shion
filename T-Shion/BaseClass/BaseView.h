//
//  BaseView.h
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseView.h"
#import "BaseViewProtocol.h"
#import <UIKit/UIKit.h>

@interface BaseView : UIView<BaseViewProtocol>
- (void)loadingFailed;
- (void)hiddenLoadingFailed;
@end
