//
//  TSRequest+Api.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSRequest+Api.h"

@implementation TSRequest (Api)

+ (id)deleteRequetWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error {
    NSString *request_Url = [HostHttpUrl stringByAppendingString:api];
    __block id model = nil;
    __block NSError *blockError = nil;
    [[TSRequest request] DELETE:request_Url
                     parameters:data_dic
                        success:^(TSRequest *request, id response) {
                            model = response;
                        } failure:^(TSRequest *request, NSError *error) {
                        blockError = error;
                    }];
    if (blockError) {
        *error = blockError;
    }
    return model;
}

+ (id)postRequetWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error {

    NSString *request_Url = [HostHttpUrl stringByAppendingString:api];
    __block id model=nil;
    __block NSError *blockError = nil;
    
    [[TSRequest request] POST:request_Url
                   parameters:data_dic
                      success:^(TSRequest *request, id response) {
                          model = response;
                      }failure:^(TSRequest *request, NSError *error) {
                          blockError = error;
                      }];
    if (blockError) {
        *error = blockError;
    }
    return model;
}

+ (id)getRequetWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError *__autoreleasing *)error {
    NSString *request_Url = [HostHttpUrl stringByAppendingString:api];
    __block id model = nil;
    __block NSError *blockError = nil;
    
    [[TSRequest request] GET:request_Url
                  parameters:data_dic
                     success:^(TSRequest *request, id response) {
                         model = response;
                    } failure:^(TSRequest *request, NSError *error) {
                        blockError = error;
                    }];

    if (blockError) {
        *error = blockError;
    }
    return model;
}

@end
