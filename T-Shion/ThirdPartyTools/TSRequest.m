//
//  TSRequest.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//


#import "TSRequest.h"


@implementation TSRequest
static AFHTTPSessionManager *operationManager ;

+ (instancetype)request {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
    success:(void (^)(TSRequest * request, id response))success
    failure:(void (^)(TSRequest * request, NSError *error))failure {
    self.operationQueue=self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

    NSString *accessToken =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if ([self isValidateString:accessToken]==YES) {
        [self.operationManager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    }

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self.operationManager GET:URLString
                    parameters:parameters
                      progress:^(NSProgress * _Nonnull downloadProgress) {
                          
                      }
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           success(self,object);
                       
                           dispatch_semaphore_signal(semaphore);
                           
                       }
                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           failure(self,error);
                       

                           dispatch_semaphore_signal(semaphore);
                       }
     ];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(TSRequest *request, id response))success
     failure:(void (^)(TSRequest *request, NSError *error))failure{
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    NSString *accessToken =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if ([self isValidateString:accessToken]==YES) {
        [self.operationManager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    }
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [self.operationManager POST:URLString
                     parameters:parameters
                       progress:^(NSProgress * _Nonnull uploadProgress) {
                           
                       }
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            id object;
                            if ([responseObject isKindOfClass:[NSData class]]) {
                                object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                            }else{
                                object =responseObject;
                            }
                            success(self,object);
                           
                            dispatch_semaphore_signal(semaphore);
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            id object;
                            NSData *errorData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                            if ([errorData isKindOfClass:[NSData class]]) {
                                object = [NSJSONSerialization JSONObjectWithData:errorData options:kNilOptions error:nil];
                            }
                            NSLog(@"%@",object);
                            failure(self,error);
                            dispatch_semaphore_signal(semaphore);
                        }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)DELETE:(NSString *)URLString
  parameters:(NSDictionary*)parameters
     success:(void (^)(TSRequest *request, id response))success
     failure:(void (^)(TSRequest *request, NSError *error))failure {
    
    self.operationQueue = self.operationManager.operationQueue;
    self.operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    self.operationManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

    NSString *accessToken =  [ [NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if ([self isValidateString:accessToken]==YES) {
        [self.operationManager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self.operationManager DELETE:URLString
                       parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           id object;
                           if ([responseObject isKindOfClass:[NSData class]]) {
                               object = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                           }else{
                               object =responseObject;
                           }
                           success(self,object);
                           dispatch_semaphore_signal(semaphore);

                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           failure(self,error);
                       
                           dispatch_semaphore_signal(semaphore);

                       }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
}

- (BOOL)isValidateString:(NSString*)str {
    if (str == nil) {
        return NO;
    }
    
    if ([str isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([str isEqualToString:@""]) {
        return NO;
    }
    
    if ([str length] == 0) {
        return NO;
    }
    
    return YES;
}

- (void)postWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters {
    
    [self POST:URLString
    parameters:parameters
       success:^(TSRequest *request, id  response) {
           if ([self.delegate respondsToSelector:@selector(TSRequest:finished:)]) {
               [self.delegate TSRequest:request finished:response];
               
           }
       }
       failure:^(TSRequest *request, NSError *error) {
           if ([self.delegate respondsToSelector:@selector(TSRequest:Error:)]) {
               [self.delegate TSRequest:request Error:error.description];
           }
       }];
}

- (void)getWithURL:(NSString *)URLString {
    [self GET:URLString parameters:nil success:^(TSRequest *request, id response) {
        if ([self.delegate respondsToSelector:@selector(TSRequest:finished:)]) {
            [self.delegate TSRequest:request finished:response];
        }
    } failure:^(TSRequest *request, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(TSRequest:Error:)]) {
            [self.delegate TSRequest:request Error:error.description];
        }
    }];
}

- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}

-(AFHTTPSessionManager *)operationManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        operationManager = [AFHTTPSessionManager manager];
        operationManager.requestSerializer.timeoutInterval = 15;
        
    });
    
    return operationManager;
}
@end
