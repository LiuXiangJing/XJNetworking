//
//  XJRequestResultProtocol.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XJRequestConfig;
@protocol XJRequestResultProtocol <NSObject>

/** 实例化请求结果 */
+ (instancetype)requestResultWithConfig:(XJRequestConfig *)config response:(id)response error:(NSError*)error;

/** 返回的原请求结果(一般是AF-json后的结果) */
@property (nonatomic,readonly) id responseObject;
/** 返回的原错误信息(一般是AF-json后的结果) */
@property (nonatomic,readonly) NSError * error;



/** 是否成功 */
@property (nonatomic,readonly) BOOL isSuccess;

/** code值 */
@property (nonatomic,readonly) NSString * code;
/** 信息描述 */
@property (nonatomic,readonly) NSString * errorMsg;
/** model映射之后的结果，一般是一个实例化的model或model数组 */
@property (nonatomic,readonly) id modelInfo;

@end
