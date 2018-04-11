//
//  FriendsViewModel.m
//  T-Shion
//
//  Created by together on 2018/3/26.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "FriendsViewModel.h"

@implementation FriendsViewModel

- (RACSubject *)searchClickSubject {
    if (!_searchClickSubject) {
        _searchClickSubject = [RACSubject subject];
    }
    return _searchClickSubject;
}

- (RACSubject *)setingClickSubject {
    if (!_setingClickSubject) {
        _setingClickSubject = [RACSubject subject];
    }
    return _setingClickSubject;
}

- (RACSubject *)callingClickSubject {
    if (!_callingClickSubject) {
        _callingClickSubject = [RACSubject subject];
    }
    return _callingClickSubject;
}

- (RACSubject *)sendMessageClickSubject {
    if (!_sendMessageClickSubject) {
        _sendMessageClickSubject = [RACSubject subject];
    }
    return _sendMessageClickSubject;
}

- (RACSubject *)validationClickSubject {
    if (!_validationClickSubject) {
        _validationClickSubject = [RACSubject subject];
    }
    return _validationClickSubject;
}
@end
