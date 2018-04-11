//
//  DialogueViewModel.h
//  T-Shion
//
//  Created by together on 2018/3/22.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "BaseViewModel.h"

@interface DialogueViewModel : BaseViewModel
@property (strong, nonatomic) RACSubject *dialogueCellClickSubject;

@property (strong, nonatomic) RACSubject *menuCellClickSubject;

@property (strong, nonatomic) RACSubject *cellClickSubject;
@end
