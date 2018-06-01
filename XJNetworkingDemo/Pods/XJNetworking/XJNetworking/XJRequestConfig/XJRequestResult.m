//
//  XJRequestResult.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJRequestResult.h"
@interface XJRequestResult()
{
    id _responseObjc;
    NSError * _error;
    
    BOOL _success;
    NSString * _errorMsg;
    id _modelInfo;
}
@end
#import "XJRequestBasicConfig.h"
#import "XJRequestConfig.h"
#import "XJMapperWithMJ.h"
@implementation XJRequestResult
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
        _success = NO;
        _errorMsg = [NSString stringWithFormat:@"%@(%ld)",error.localizedDescription,(long)error.code];
        return;
    }
    NSString * successKey = [XJRequestBasicConfig sharedConfig].successKey;
    NSString * successValue = [XJRequestBasicConfig sharedConfig].successValue;
    NSString * dataKey = [XJRequestBasicConfig sharedConfig].dataKey;
    NSString * messageKey = [XJRequestBasicConfig sharedConfig].messageKey;
    _success = NO;
    _errorMsg = @"响应数据为空";
    if (_responseObjc && [_responseObjc isKindOfClass:[NSDictionary class]]) {
        NSString * code = [NSString stringWithFormat:@"%@",_responseObjc[successKey]];
        _errorMsg = _responseObjc[messageKey];

        if ([code isEqualToString:successValue]) {
            _success = YES;
            id dataObjc = _responseObjc[dataKey];
            if (config.mappingModel) {
                NSError * error = nil;
                _modelInfo = [XJMapperWithMJ mapperToModel:config.mappingModel response:dataObjc key:config.mappingParseName error:&error];
                _error = error;
            }else{
                _modelInfo = dataObjc;
            }
        }
    }
}

#pragma mark - getter

- (NSError *)error {
    return _error;
}
- (id)responseObject {
    return _responseObjc;
}
- (BOOL)isSuccess {
    return _success;
}
- (NSString *)errorMsg {
    return _errorMsg;
}
- (id)modelInfo {
    return _modelInfo;
}
@end
