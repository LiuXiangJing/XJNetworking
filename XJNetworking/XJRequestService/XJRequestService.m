//
//  XJRequestService.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJRequestService.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#import "XJRequestBasicConfig.h"
void XJRequestLog(NSString *format, ...) {
#ifdef DEBUG
    if (![XJRequestBasicConfig sharedConfig].debugLogEnabled) {
        return;
    }
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}

@interface XJRequestService()

@property (nonatomic,strong)AFHTTPSessionManager * sessionManager;
@end
#import "XJRequestResult.h"

static NSTimeInterval fileTimeout = 60;
@implementation XJRequestService
#pragma mark - init
+ (instancetype)sharedRequestService {
    static XJRequestService *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[XJRequestService alloc]init];
    });
    return service;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", nil];
        [self configWithBasicConfig];
    }
    return self;
}
- (void)configWithBasicConfig {
    XJRequestBasicConfig * basicConfig = [XJRequestBasicConfig sharedConfig];
    
    self.sessionManager.requestSerializer.timeoutInterval = basicConfig.timeoutInterval;
    if (basicConfig.expandHttpHeader) {
        [basicConfig.expandHttpHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self.sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
}
#pragma mark - public
- (XJRequest *)downloadRequestWithConfig:(XJRequestConfig *)config progress:(void (^)(NSProgress *))progress complete:(XJRequestResultBlock)complete {
    self.sessionManager.requestSerializer.timeoutInterval = fileTimeout;
    return [self sendAllRequesWithConfig:config appenddata:nil progress:progress complete:complete];
}
- (XJRequest *)sendRequestWithConfig:(XJRequestConfig *)config complete:(XJRequestResultBlock)complete {
    self.sessionManager.requestSerializer.timeoutInterval = [XJRequestBasicConfig sharedConfig].timeoutInterval;
    return [self sendAllRequesWithConfig:config appenddata:nil progress:nil complete:complete];
}
- (XJRequest *)uploadRequestWithConfig:(XJRequestConfig *)config appenddata:(void (^)(id<AFMultipartFormData>))appenddata progress:(void (^)(NSProgress *))progress complete:(XJRequestResultBlock)complete {
    self.sessionManager.requestSerializer.timeoutInterval = fileTimeout;
    return [self sendAllRequesWithConfig:config appenddata:appenddata progress:progress complete:complete];
}

#pragma mark - private
#pragma mark 发起请求前的配置
- (NSDictionary *)getAllParameterFromConfig:(XJRequestConfig *)config {
    NSMutableDictionary * allParameter = [NSMutableDictionary dictionaryWithDictionary:config.paramDic];
    XJRequestBasicConfig * basicConfig = [XJRequestBasicConfig sharedConfig];
    if (basicConfig.publicParameter) {
        [allParameter addEntriesFromDictionary:basicConfig.publicParameter];
    }
    return allParameter;
}
- (NSString *)getRequestURLWithConfig:(XJRequestConfig *)config {
    XJRequestBasicConfig * basicConfig = [XJRequestBasicConfig sharedConfig];
    NSAssert(basicConfig.baseURL != nil, @"BaseURL should not be nil");
    if (config.requestURL){
        return [basicConfig.baseURL stringByAppendingString:config.requestURL];
    }
    return basicConfig.baseURL;
}
#pragma mark 汇总网络请求
- (XJRequest *)sendAllRequesWithConfig:(XJRequestConfig *)config appenddata:(void (^)(id<AFMultipartFormData>))appenddata progress:(void (^)(NSProgress *))progress complete:(XJRequestResultBlock)complete  {
    NSDictionary * paramDic = [self getAllParameterFromConfig:config];
    NSString * requestURL = [self getRequestURLWithConfig:config];
    
    XJRequestLog(@"请求的URL：%@\n请求的参数：%@",requestURL,paramDic);

   NSURLSessionDataTask * requestTask = [self requesturl:requestURL method:config.requestMethod parameters:paramDic constructingBodyWithBlock:appenddata progress:progress success:^(NSURLSessionDataTask *task, id responseObject) {
        XJRequestLog(@"请求的URL：%@\n请求的成功：%@",requestURL,responseObject);
        XJRequestResult * resullt = [XJRequestResult requestResultWithConfig:config response:responseObject error:nil];
        complete(resullt);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XJRequestLog(@"请求的URL：%@\n请求的失败：%@",requestURL,error);
        XJRequestResult * resullt = [XJRequestResult requestResultWithConfig:config response:nil error:error];
        complete(resullt);
    }];
    return [[XJRequest alloc]initWithRequestTask:requestTask];
}
#pragma mark 创建任务
- (NSURLSessionDataTask *)requesturl:(NSString *)url
                              method:(XJRequestMethod)method
                          parameters:(NSDictionary *)parameters
           constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                            progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    switch (method) {
        case XJRequestMethodGet:{
            return [self.sessionManager GET:url parameters:parameters progress:uploadProgress success:success failure:failure];
            break;
        }
        case XJRequestMethodPost:{
            if (block) {
                return [self.sessionManager POST:url parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
            }else{
                return [self.sessionManager POST:url parameters:parameters progress:uploadProgress success:success failure:failure];
            }
            break;
        }
        default:
            failure(nil,[NSError errorWithDomain:@"请求方式不支持" code:1 userInfo:nil]);
            return nil;
            break;
    }
}

@end
