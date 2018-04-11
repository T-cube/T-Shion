//
//  TSImageGroupCell.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;

@interface TSImageGroupCell : UITableViewCell

- (void)reloadDataWithAssetCollection:(PHAssetCollection *)assetCollection;

@end
