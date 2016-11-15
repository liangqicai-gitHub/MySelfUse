//
//  YearCell.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "YearCell.h"
#import "dayCell.h"

@implementation YearCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"a"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"dayCell" bundle:nil] forCellWithReuseIdentifier:@"a"];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat hah = self.frame.size.width / 5 - 2;
    return CGSizeMake(hah, hah);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


@end
