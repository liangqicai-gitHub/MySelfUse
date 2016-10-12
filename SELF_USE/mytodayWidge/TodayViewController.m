//
//  TodayViewController.m
//  mytodayWidge
//
//  Created by 梁齐才 on 16/10/9.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <AFNetworking/AFNetworking.h>


@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://www.baidu.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       _label.text = @"成功";
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _label.text = @"失败";
    }];
    
}

@end
