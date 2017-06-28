//
//  searchVC.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/6.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "searchVC.h"

@interface searchVC ()
@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation searchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _search.transform = CGAffineTransformMakeTranslation(250, 0);
    _btn.transform = CGAffineTransformMakeTranslation(-50, 0);
    [_btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}


- (BOOL)navigationBarHidden
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [_search becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        _search.transform = CGAffineTransformIdentity;
        _btn.transform = CGAffineTransformIdentity;
    }];
}


- (void)close
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
