//
//  DialogueViewModel.m
//  T-Shion
//
//  Created by together on 2018/3/22.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueViewModel.h"

@implementation DialogueViewModel


- (RACSubject *)dialogueCellClickSubject {
    if (!_dialogueCellClickSubject) {
        _dialogueCellClickSubject = [RACSubject subject];
    }
    return _dialogueCellClickSubject;
}

- (RACSubject *)menuCellClickSubject {
    if (!_menuCellClickSubject) {
        _menuCellClickSubject = [RACSubject subject];
    }
    return _menuCellClickSubject;
}

- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
@end
