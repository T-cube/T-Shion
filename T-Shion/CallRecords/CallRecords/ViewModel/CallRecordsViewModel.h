//
//  CallRecordsViewModel.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseViewModel.h"

@interface CallRecordsViewModel : BaseViewModel

@property (strong, nonatomic) RACSubject *cellClickSubject;
@property (strong, nonatomic) RACSubject *detaikClickSubject;

@end
