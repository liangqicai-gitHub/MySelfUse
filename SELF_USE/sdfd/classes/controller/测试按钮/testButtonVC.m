//
//  testButtonVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/24.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "testButtonVC.h"


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


@end
