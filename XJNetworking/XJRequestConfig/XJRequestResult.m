//
//  XJRequestResult.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJRequestResult.h"
@interface XJRequestResult() {
    
    id _responseObjc;
    NSError * _error;
    
    BOOL _isSuccess;
    NSString * _errorMsg;
    id _modelInfo;
}
@end
#import "XJRequestBasicConfig.h"
#import "XJRequestConfig.h"
#import "XJMapperWithMJ.h"
@implementation XJRequestResult
@synthesize error = _error,responseObject = _responseObjc,isSuccess = _isSuccess,errorMsg = _errorMsg,modelInfo = _modelInfo,code = _code;
#pragma mark - init
+ (instancetype)requestResultWithConfig:(XJRequestConfig *)config response:(id)response error:(NSError *)error {
    XJRequestResult * result = [[XJRequestResult alloc]init];
    [result configWithConfig:config response:response error:error];
    return result;
}
- (void)configWithConfig:(XJRequestConfig *)config response:(id)response error:(NSError *)error {
    
    _responseObjc = response;
    _error = error;

    if (error) {
        _isSuccess = NO;
        _errorMsg = [NSString stringWithFormat:@"%@(%ld)",error.localizedDescription,(long)error.code];
        return;
    }
    BOOL needAnalysis = [XJRequestBasicConfig sharedConfig].needAnalysis;
    if (needAnalysis == NO) {
        _isSuccess = YES;
        return;
    }
    NSString * successKey = [XJRequestBasicConfig sharedConfig].statusKey;
    NSString * successValue = [XJRequestBasicConfig sharedConfig].statusKey;
    NSString * dataKey = [XJRequestBasicConfig sharedConfig].dataKey;
    NSString * messageKey = [XJRequestBasicConfig sharedConfig].messageKey;
    _isSuccess = NO;
    _errorMsg = @"响应数据为空";
    if (_responseObjc && [_responseObjc isKindOfClass:[NSDictionary class]]) {
        _code = [NSString stringWithFormat:@"%@",_responseObjc[successKey]];
        
        _errorMsg = _responseObjc[messageKey];
        //状态对就是成功，否则就是失败
        if ([_code isEqualToString:successValue]) {
            _isSuccess = YES;
        }
        //数据的解析，无论成功与否都可以解析
        _modelInfo = _responseObjc[dataKey];
        if (config.mappingModel && _modelInfo) {
            NSError * error = nil;
            _modelInfo = [XJMapperWithMJ mapperToModel:config.mappingModel response:_modelInfo key:config.mappingParseName error:&error];
            _error = error;
        }
    }
}

@end
