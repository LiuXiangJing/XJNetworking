//
//  ViewController.m
//  XJNetworkingDemo
//
//  Created by liuxiangjing on 2018/6/1.
//  Copyright © 2018年 liuxiangjing. All rights reserved.
//

#import "ViewController.h"
#import "TestDataSource.h"
@interface ViewController () {
    TestDataSource * _dataSource;
}
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[TestDataSource alloc]init];
    [_dataSource getHomeData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
