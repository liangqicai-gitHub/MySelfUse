//
//  TestForCollectionView.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "TestForCollectionView.h"
#import "YearCell.h"

@interface TestForCollectionView ()
<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    BOOL _hehe;
}

@end

@implementation TestForCollectionView
- (IBAction)ss:(UIButton *)sender
{
    _hehe = !_hehe;
    [_collectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"a"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"YearCell" bundle:nil] forCellWithReuseIdentifier:@"a"];
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat a = _hehe ? 30 : 60;
    return CGSizeMake(100, 100);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}



@end
