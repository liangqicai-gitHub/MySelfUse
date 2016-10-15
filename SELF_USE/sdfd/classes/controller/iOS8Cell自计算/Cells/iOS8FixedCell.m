//
//  iOS8FixedCell.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/14.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "iOS8FixedCell.h"

@interface iOS8FixedCell ()
@property (weak, nonatomic) IBOutlet UILabel *llabel;
@end


@implementation iOS8FixedCell


- (void)setCellModel:(iOS8FixedCellModel *)cellModel
{
    if (![cellModel isKindOfClass:[iOS8FixedCellModel class]]){
        return;
    }
    
    _llabel.text = cellModel.name;
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
}


@end




@implementation iOS8FixedCellModel

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
}

@end
