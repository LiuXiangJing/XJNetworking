//
//  AppRequestConfiger.m
//  XJNetworkingDemo
//
//  Created by liuxiangjing on 2018/6/1.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "AppRequestConfiger.h"
#import <XJNetworking/XJRequestBasicConfig.h>

@implementation AppRequestConfiger
+ (void)configAllRequest {
    XJRequestBasicConfig * config = [XJRequestBasicConfig sharedConfig];
    config.debugLogEnabled = YES;
    [config setBaseURL:@"https://www.sojson.com/" forPlantform:XJDevelopPlantformRelease];
    config.needAnalysis = NO;
    
}
@end
