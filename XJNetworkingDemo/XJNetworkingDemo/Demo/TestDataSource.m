//
//  TestDataSource.m
//  XJNetworkingDemo
//
//  Created by liuxiangjing on 2018/6/1.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "TestDataSource.h"

@implementation TestDataSource
- (void)getHomeData {
    XJRequestConfig * config = [XJRequestConfig config];
    config.requestURL = @"open/api/weather/json.shtml";
    config.requestMethod = XJRequestMethodGet;
    
    config.paramDic = @{
                        @"city":@"北京"
                        };
   [self.requestService sendRequestWithConfig:config complete:^(id<XJRequestResultProtocol> result) {
        if (result.isSuccess) {

        }else{
            
        }
    }];

}
@end
