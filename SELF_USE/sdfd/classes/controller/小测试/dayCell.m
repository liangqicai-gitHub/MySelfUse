//
//  dayCell.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "dayCell.h"

@implementation dayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _label.layer.cornerRadius = 2;
    _label.layer.masksToBounds = YES;
}

@end
