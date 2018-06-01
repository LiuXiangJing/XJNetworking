//
//  XJRequestService.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//
/**
 这是一个对`AFNetwoking`封装的网络请求库。
 详细介绍请阅读XJNetworking.md
 */
#import <Foundation/Foundation.h>

#import "XJRequestConfig.h"
#import "XJRequestResultProtocol.h"
#import "XJRequest.h"
@protocol AFMultipartFormData;

typedef void(^XJRequestResultBlock)(id<XJRequestResultProtocol> result);

FOUNDATION_EXPORT void XJRequestLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2);

/* 网络请求基类 */
@interface XJRequestService : NSObject

+ (instancetype)sharedRequestService;

/*
 普通网路请求
 */
- (XJRequest *)sendRequestWithConfig:(XJRequestConfig *)config complete:(XJRequestResultBlock)complete;

/*
 普通单个上传文件(不支持断点续传)
 */
- (XJRequest *)uploadRequestWithConfig:(XJRequestConfig *)config
                     appenddata:(void(^)(id<AFMultipartFormData>))appenddata
                       progress:( void (^)(NSProgress * progress))progress
                       complete:(XJRequestResultBlock)complete;

/**
 普通单个下载文件(不支持断点续传)
 */
- (XJRequest *)downloadRequestWithConfig:(XJRequestConfig *)config
                         progress:( void (^)(NSProgress * progress))progress
                         complete:(XJRequestResultBlock)complete;
@end
