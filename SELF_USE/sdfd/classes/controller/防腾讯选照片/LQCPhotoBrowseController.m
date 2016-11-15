//
//  PhotoBrowseController.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/3.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "LQCPhotoBrowseController.h"
#import "LQCPhotoBrowseCell.h"

@interface LQCPhotoBrowseController ()
<
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
>
{
    UICollectionView *_collectionView;
    NSString *_cellId;
}

@end

@implementation LQCPhotoBrowseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initVars];
    [self initViews];
}

- (void)initVars
{
    _cellId = @"a";
}


- (void)initViews
{
    
    UICollectionViewFlowLayout *layout = [self newLayoutWithItemSize:CGSizeMake(DeviceWidth, DeviceHeight)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)
                                         collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"LQCPhotoBrowseCell" bundle:nil]
      forCellWithReuseIdentifier:_cellId];
    [self.view addSubview:_collectionView];
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor greenColor];
    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, -10));
    }];
}



- (UICollectionViewFlowLayout *)newLayoutWithItemSize:(CGSize)itemSize
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = itemSize;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 10);
    return layout;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGSize newSize = self.view.bounds.size;
    UICollectionViewFlowLayout *layout =
    [self newLayoutWithItemSize:newSize];
    layout.minimumLineSpacing = 10.0f;
    [_collectionView setCollectionViewLayout:layout animated:YES];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}




#pragma mark - delegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQCPhotoBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellId forIndexPath:indexPath];
    return cell;
}




@end
