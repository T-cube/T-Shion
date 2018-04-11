//
//  BaseTableViewCellProtocol.h
//  RDFuturesApp
//
//  Created by user on 17/3/1.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellProtocol <NSObject>
@optional

- (void)setupViews;
- (void)bindViewModel;
@end
