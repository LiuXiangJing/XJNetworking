//
//  XJDevelopPlantform.m
//  XJNetworking
//
//  Created by liuxiangjing on 2018/5/30.
//  Copyright © 2018年 zhijian. All rights reserved.
//

#import "XJDevelopPlantform.h"
//当前平台
static NSString * const developPlantformNow = @"com.xj.develop.platform.now";
//通知的名字
NSString * const XJDevelopPlantformDidChangedNotification = @"XJDevelopPlantformDidChangedNotice";

@implementation XJDevelopPlantform
+ (XJDevelopPlantformType)currentPlantformType {
    NSInteger current = [[NSUserDefaults standardUserDefaults] integerForKey:developPlantformNow];
    return current;
}
+ (void)changeDevelopPlantform:(XJDevelopPlantformType)developPlantform {
    NSInteger currentPlantform = developPlantform;
    [[NSUserDefaults standardUserDefaults] setInteger:currentPlantform forKey:developPlantformNow];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:XJDevelopPlantformDidChangedNotification object:nil];
}
@end
