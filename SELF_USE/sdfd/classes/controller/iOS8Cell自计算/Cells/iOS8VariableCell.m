//
//  iOS8VariableCell.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/14.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "iOS8VariableCell.h"

@interface iOS8VariableCell ()
@property (weak, nonatomic) IBOutlet UILabel *lnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ldesLabel;
@end


@implementation iOS8VariableCell

- (void)setCellModel:(iOS8VariableCellModel *)cellModel
{
    if (![cellModel isKindOfClass:[iOS8VariableCellModel class]]){
        return;
    }
    
    _lnameLabel.text = cellModel.name;
    _ldesLabel.attributedText = cellModel.des;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
}

@end



@implementation iOS8VariableCellModel

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
}



@end
