//
//  TSRequest+Api.h
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSRequest.h"

@interface TSRequest (Api)
//post 提交数据
+ (id)postRequetWithApi:(NSString *)api withParam:(NSDictionary*)data_dic
                 error:(NSError* __autoreleasing*)error;
//get 获取数据
+ (id)getRequetWithApi:(NSString *)api withParam:(NSDictionary*)data_dic
                error:(NSError* __autoreleasing*)error;
//delete 方式
+ (id)deleteRequetWithApi:(NSString *)api withParam:(NSDictionary *)data_dic
                   error:(NSError *__autoreleasing *)error;
@end
