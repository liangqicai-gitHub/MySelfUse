//
//  BVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/22.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BVC.h"
#import "searchVC.h"
@interface BVC ()
@property (weak, nonatomic) IBOutlet UIView *vie;

@end

@implementation BVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (BOOL)navigationBarHidden
{
    return NO;
}

- (IBAction)action:(UIButton *)sender
{
//    BVC *vc = [[BVC alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    searchVC *vc = [[searchVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:NO];
    
}


- (NSString *)title
{
    return @"B";
}



@end
