//
//  XJRequest.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 目前没什么用呢还 */
@interface XJRequest : NSObject

- (instancetype)initWithRequestTask:(NSURLSessionDataTask *)requestTask;

@property (nonatomic,strong,readonly)NSURLSessionDataTask * requestTask;

@end
