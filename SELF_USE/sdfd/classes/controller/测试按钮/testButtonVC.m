//
//  testButtonVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/24.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "testButtonVC.h"
#import "testNavigationB.h"


@interface testButtonVC ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bttons;

@end

@implementation testButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIButton *sender in _bttons) {
        [sender layoutButtonWithEdgeInsetsStyle:sender.tag
                                imageTitlespace:10];
    }
    
}


- (BOOL)navigationBarHidden
{
    return YES;
}


- (NSString *)title
{
    return @"测试button";
}


- (IBAction)A:(UIButton *)sender
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSArray <UIViewController *>*controllers = self.navigationController.viewControllers;
    [controllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
        if (idx != controllers.count - 1){
            [arrM addObject:obj];
        }
    }];
    
    [arrM addObject:[[BaseViewController alloc] init]];
    
    [self.navigationController setViewControllers:arrM animated:YES];
}


@end
