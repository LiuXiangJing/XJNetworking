//
//  XJRequestBasicConfig.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJRequestBasicConfig.h"
@interface XJRequestBasicConfig ()
{
    NSMutableDictionary * _baseUrlDic;
}
@end
@implementation XJRequestBasicConfig
@synthesize debugLogEnabled = _debugLogEnabled,needAnalysis = _needAnalysis;
#pragma mark - init
+ (instancetype)sharedConfig {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _baseUrlDic = [NSMutableDictionary dictionaryWithCapacity:4];
        _debugLogEnabled = NO;
        _statusKey = @"code";
        _statusValue = @"0";
        _successKey = @"code";
        _successValue = @"0";
        _dataKey = @"data";
        _messageKey = @"message";
        _timeoutInterval = 10;
        _needAnalysis = NO;
    }
    return self;
}
#pragma mark - baseURL
- (void)setBaseURL:(NSString *)baseURL forPlantform:(XJDevelopPlantformType)platform {
    NSNumber * number = [NSNumber numberWithInteger:platform];
    [_baseUrlDic setObject:baseURL forKey:number.stringValue];
}
- (NSString *)baseURL {
    XJDevelopPlantformType currentType = [XJDevelopPlantform currentPlantformType];
    NSNumber * number = [NSNumber numberWithInteger:currentType];
    return _baseUrlDic[number.stringValue];
}

@end
