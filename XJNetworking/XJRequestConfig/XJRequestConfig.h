//
//  XJRequestConfig.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
//task的网络请求方式
typedef NS_ENUM(NSInteger, XJRequestMethod)
{
    XJRequestMethodGet,
    XJRequestMethodPost,
};
@interface XJRequestConfig : NSObject

+ (instancetype)config;

/** http请求的相对url 必填 */
@property (nonatomic, copy) NSString * requestURL;

/** 请求方式 必填.默认 KZHttpMethodTypePost */
@property (nonatomic, assign) XJRequestMethod requestMethod;

/** post或者get请求参数的字典 选填 */
@property (nonatomic, copy) NSDictionary* paramDic;

/** 需要被映射的Model的名字 选填 */
@property (nonatomic, assign) Class mappingModel;

/** 要映射解析的字段名，服务器返回json中的字段名，model对应的字段名，选填 */
@property (nonatomic, copy) NSString * mappingParseName;

/** 要下载的文件存放的本地路径或目标路径 */
@property (nonatomic, copy) NSString * filePath;


@end
