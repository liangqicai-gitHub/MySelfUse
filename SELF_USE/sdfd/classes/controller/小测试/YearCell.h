//
//  YearCell.h
//  sdfd
//
//  Created by 梁齐才 on 16/11/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearCell : UICollectionViewCell
<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
