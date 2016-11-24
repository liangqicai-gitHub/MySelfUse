//
//  searchVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/24.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "searchVC.h"

@interface searchVC ()
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation searchVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [_text becomeFirstResponder];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)s:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:NO];
    
//    searchVC *vc = [[searchVC alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}


- (BOOL)navigationBarHidden
{
    return YES;
}



@end
