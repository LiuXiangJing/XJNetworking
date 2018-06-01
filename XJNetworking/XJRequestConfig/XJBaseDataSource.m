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

@end
