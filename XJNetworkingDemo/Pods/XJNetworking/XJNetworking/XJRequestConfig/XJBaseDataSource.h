//
//  XJBaseDataSource.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/31.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJRequestService.h"
@interface XJBaseDataSource : NSObject

@property (nonatomic,readonly)XJRequestService * requestService;

@end
