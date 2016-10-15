//
//  iOS8FixedCell.h
//  sdfd
//
//  Created by 梁齐才 on 16/10/14.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iOS8FixedCellModel;
@interface iOS8FixedCell : UITableViewCell

@property (nonatomic,strong) iOS8FixedCellModel *cellModel;

@end


@interface iOS8FixedCellModel : NSObject

@property (nonatomic,copy) NSString *name;

@end
