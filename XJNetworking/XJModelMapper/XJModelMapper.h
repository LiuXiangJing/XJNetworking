//
//  XJModelMapper.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XJModelMapper <NSObject>
//要映射成的类，服务器响应的数据，从哪个key开始映射，失败error
+ (id)mapperToModel:(Class)model response:(id)response key:(NSString *)key error:(NSError**)error;
@end
