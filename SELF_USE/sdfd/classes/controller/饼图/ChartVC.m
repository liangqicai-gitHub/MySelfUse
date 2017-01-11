//
//  ChartVC.m
//  sdfd
//
//  Created by 梁齐才 on 17/1/10.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "ChartVC.h"
#import "JHChartHeader.h"
#import "PeiChartView.h"

@interface ChartVC ()

@end

@implementation ChartVC


- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    PeiChartView *view = [[PeiChartView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    view.ringWidth = 50;
    view.itemsSpace = 0.00f;
    
    PieChartItem *item1 = [[PieChartItem alloc] init];
    item1.color = [UIColor greenColor];
    item1.number = 4.32f;

    PieChartItem *item2 = [[PieChartItem alloc] init];
    item2.color = [UIColor orangeColor];
    item2.number = 5.35f;
    
    PieChartItem *item3 = [[PieChartItem alloc] init];
    item3.color = [UIColor redColor];
    item3.number = 0.5f;
    
    PieChartItem *item4 = [[PieChartItem alloc] init];
    item4.color = [UIColor blueColor];
    item4.number = 6.58f;
    
    PieChartItem *item5 = [[PieChartItem alloc] init];
    item5.color = [UIColor lightGrayColor];
    item5.number = 4.24f;
    
    PieChartItem *item6 = [[PieChartItem alloc] init];
    item6.color = [UIColor brownColor];
    item6.number = 4.24f;
    
    PieChartItem *item7 = [[PieChartItem alloc] init];
    item7.color = [UIColor magentaColor];
    item7.number = 7.22f;
    
    view.items = @[item1,item2,item3,item4,item5,item6,item7];
    
    [view showWithAnimations:YES];

}




@end
