//
//  OhterInformationViewModel.h
//  T-Shion
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseViewModel.h"

@interface OtherInformationViewModel : BaseViewModel
@property (strong, nonatomic) RACSubject *cellClickSubject;
@property (strong, nonatomic) RACSubject *menuItemClickSubject;
@end
