//
//  XJRequestBasicConfig.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJDevelopPlantform.h"

/** 网络请求的一些公共信息的配置 */
@interface XJRequestBasicConfig : NSObject
+ (instancetype)sharedConfig;

/** 网络请求的域名。默认是nil */
@property (nonatomic,copy,readonly) NSString * baseURL;

/** 是否可以输出log,默认是NO */
@property (nonatomic,assign) BOOL debugLogEnabled;
/** 公共参数 ,默认是nil*/
@property (nonatomic,strong) NSDictionary * publicParameter;

/** 增加httpHeader的值，如果重复则覆盖 ,默认是nil */
@property (nonatomic,strong) NSDictionary * expandHttpHeader;

/** 普通网络请求默认超时时长 默认是10s，上传或下载的时候是60s */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

- (void)setBaseURL:(NSString *)baseURL forPlantform:(XJDevelopPlantformType)platform;




#pragma mark - 对请求结果的一些解析设置
/**
 解释：一般网络请求的结果都包含在固定格式中，例如：
 {
 code:0,
 data:{},
 msg:"请求成功"
 }
 
 {
 success:1,
 data:{},
 msg:"请求成功"
 }
 固，我们一般解析的话就解析data内的model即可，外层的是否成功我们来解析掉，便把结果通过<XJRequestResultProtocol>回调出去
 当然，如果并不需要解析<XJRequestResultProtocol>也会把原数据传递出去的。
 */

/**
 是否需要使用这种格式解析。默认是NO
 */
@property (nonatomic,assign)BOOL needAnalysis;
/** 标记成功的字段名 默认是`code` */
@property (nonatomic,copy)NSString * successKey;

/** 成功的值，非此值一律表示失败 默认是 `0` */
@property (nonatomic,copy)NSString * successValue;

/** 表示data的字段名，默认是`data` */
@property (nonatomic,copy)NSString * dataKey;
/** 表示错误或成功信息的字段名，默认是`message` */
@property (nonatomic,copy)NSString * messageKey;
@end
