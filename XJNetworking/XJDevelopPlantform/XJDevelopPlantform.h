//
//  XJDevelopPlantform.h
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
//开发的平台发生了改变的通知
FOUNDATION_EXPORT NSNotificationName const XJDevelopPlantformDidChangedNotification;

typedef NS_ENUM(NSInteger, XJDevelopPlantformType)
{
    XJDevelopPlantformRelease = 0,//发布环境
    XJDevelopPlantformDebug = 1,//开发环境
    XJDevelopPlantformTest = 2,//测试环境
    XJDevelopPlantformUAT = 3,//UAT环境
};

/**
 开发平台切换
 */
@interface XJDevelopPlantform : NSObject

/**当前开发平台。 默认是 XJDevelopPlantformRelease */
+ (XJDevelopPlantformType)currentPlantformType;
/**
 切换平台
 @param developPlantform 将要切换成为的平台
 */
+ (void)changeDevelopPlantform:(XJDevelopPlantformType)developPlantform;
@end
