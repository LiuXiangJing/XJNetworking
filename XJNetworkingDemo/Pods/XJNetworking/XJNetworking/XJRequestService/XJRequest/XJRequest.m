//
//  XJRequest.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJRequest.h"

@implementation XJRequest
@synthesize requestTask = _requestTask;
- (instancetype)initWithRequestTask:(NSURLSessionDataTask *)requestTask {
    self = [super init];
    if (self) {
        _requestTask =  requestTask;
    }
    return self;
}
@end
