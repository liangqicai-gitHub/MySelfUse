//
//  RDRiceChatVC.m
//  sdfd
//
//  Created by 梁齐才 on 17/5/19.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "RDRiceChatVC.h"

@interface RDRiceChatVC ()
<
UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
>
{
    NSInteger _datas;
}

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation RDRiceChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVars];
    [self initViews];
}


- (void)initVars
{
    _datas = 100;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:(CGRect){0,0,DeviceWidth,DeviceHeight}];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"a"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

- (void)initViews
{
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_collectionView];
    
    [_collectionView setFrame:(CGRect){0,0,DeviceWidth,_datas * 55}];
    [_scrollView setContentSize:(CGSize){DeviceWidth,_datas * 55}];
    
    [_collectionView reloadData];
    
    _collectionView.scrollEnabled = NO;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return _datas;

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 100);
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    LQCDLog(@"cell %p",cell);
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _datas --;
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    
   return UIEdgeInsetsMake(2, 2, 2, 2);
}

@end
