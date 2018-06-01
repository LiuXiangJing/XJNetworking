//
//  XJMapperWithMJ.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/31.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJMapperWithMJ.h"

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

#import <pthread/pthread.h>
@implementation XJMapperWithMJ
+ (id)mapperToModel:(Class)model response:(id)response key:(NSString *)key error:(NSError**)error {
    
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    id mappingData = nil;
    pthread_mutex_lock(&mutex);
    if (response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            if (key) {
                id keyData = response[key];
                if ([keyData isKindOfClass:[NSArray class]]) {
                    mappingData = [model mj_objectArrayWithKeyValuesArray:keyData];
                }else{
                    mappingData = [model mj_objectWithKeyValues:keyData];
                }
            }else{
                mappingData = [model mj_objectWithKeyValues:response];
            }
        }else if ([response isKindOfClass:[NSArray class]]){
            mappingData = [model mj_objectArrayWithKeyValuesArray:response];
        }
        if (mappingData == nil) {
            *error = [NSError errorWithDomain:@"数据映射失败" code:99 userInfo:@{NSLocalizedDescriptionKey:@"数据格式不支持，映射失败"}];
        }
    }else{
        *error = [NSError errorWithDomain:@"数据映射失败" code:100 userInfo:@{NSLocalizedDescriptionKey:@"数据为空，映射失败"}];
        
    }
    pthread_mutex_unlock(&mutex);
    return mappingData;
}
@end
