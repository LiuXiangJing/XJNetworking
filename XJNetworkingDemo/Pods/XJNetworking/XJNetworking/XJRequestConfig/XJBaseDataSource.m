//
//  XJBaseDataSource.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/31.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJBaseDataSource.h"

@implementation XJBaseDataSource

- (XJRequestService *)requestService {
    return [XJRequestService sharedRequestService];
}

- (void)loginWithUserName:(NSString *)name password:(NSString *)password complete:(void(^)(NSObject * userInfo))complete {
    XJRequestConfig * config = [XJRequestConfig config];
    config.requestURL = @"user/login";
    config.paramDic = @{@"name":name,
                        @"pwd":password,
                        };
    config.mappingModel = [NSObject class];//这里应该是UserInfoModel 啦，如果不设置就是不映射。以原数据返回
    [self.requestService sendRequestWithConfig:config complete:^(id<XJRequestResultProtocol> result) {
        if (result.isSuccess) {
            complete(result.modelInfo);
        }else{
            NSLog(@"请求失败：%@",result.errorMsg);
            complete(nil);
        }
    }];
}
@end
