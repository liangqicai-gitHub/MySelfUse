//
//  PhotoBrowseController.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/3.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "PhotoBrowseController.h"
#import "LQCPhotoBrowseCell.h"

@interface PhotoBrowseController ()
<
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
>
{
    UICollectionView *_collectionView;
    NSString *_cellId;
}

@end

@implementation PhotoBrowseController

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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.itemSize = CGSizeMake(DeviceWidth, DeviceHeight - 70);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight)
                                         collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    [_collectionView registerClass:[LQCPhotoBrowseCell class]
//        forCellWithReuseIdentifier:_cellId];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"LQCPhotoBrowseCell" bundle:nil]
      forCellWithReuseIdentifier:_cellId];

    [self.view addSubview:_collectionView];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
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
