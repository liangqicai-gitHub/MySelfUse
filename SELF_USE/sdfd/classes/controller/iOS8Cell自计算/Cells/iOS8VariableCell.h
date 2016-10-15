//
//  iOS8VariableCell.h
//  sdfd
//
//  Created by 梁齐才 on 16/10/14.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iOS8VariableCellModel;
@interface iOS8VariableCell : UITableViewCell

@property (nonatomic,strong) iOS8VariableCellModel *cellModel;

@end



@interface iOS8VariableCellModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSAttributedString *des;

@end
