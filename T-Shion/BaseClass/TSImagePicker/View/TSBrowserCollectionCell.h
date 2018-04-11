//
//  TSBrowserCollectionCell.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface TSBrowserCollectionCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *phAsset;

- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block;

@end
