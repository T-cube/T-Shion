//
//  TSImagePickerController.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

typedef void (^PHAssetsBlock) (NSArray <UIImage *>*imageArray, NSArray <PHAsset *>*assetsArray);

@interface TSImagePickerController : UINavigationController

- (instancetype)init;

@property (nonatomic ,assign) NSInteger maxSelectedCount;

@property (nonatomic, assign) BOOL autoJumpToPhotoSelectPage;

@property (nonatomic, assign) BOOL allowSelectReturnType;

@property (nonatomic, copy, readonly) PHAssetsBlock phAssetsBlock;

- (void)getSelectedPHAssetsWithBlock:(PHAssetsBlock)block;

@end
