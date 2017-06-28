//
//  DMGPlayerView.m
//  DM2
//
//  Created by 梁齐才 on 17/6/3.
//  Copyright © 2017年 LeiXiao CQ. All rights reserved.
//

#import "DMGPlayerView.h"
#import "DMGPlayerCell.h"

@interface DMGPlayerView ()
<
UICollectionViewDelegate,UICollectionViewDataSource
>
{
    UIScrollView *_scrollView;
    UICollectionView *_fview;
    UICollectionView *_sView;
    UICollectionView *_tView;
    NSString *_cellId;
    CGFloat _oneLenght;
    double _beginOffSet;
}


@end


@implementation DMGPlayerView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self initVars];
        [self initViews];
    }
    return self;
}


- (void)initVars
{
    _beginOffSet = 2.0 * 24.0 * 3600.0 * 5000.0;
    
//    NSDictionary *locale = @{NSLocaleDecimalSeparator :@","};    //以","当做分隔符格式
//    NSDecimalNumber *time = [NSDecimalNumber decimalNumberWithString:@"31536000,00" locale:locale];
//    NSDecimalNumber *distanceInASecond = [NSDecimalNumber decimalNumberWithString:@"5000,00" locale:locale];
//    NSDecimalNumber *totalDis = [time decimalNumberByMultiplyingBy:distanceInASecond];
//    _beginOffSet = totalDis.doubleValue;
    
    
    LQCDLog(@"_beginOffSet_beginOffSet %f    ",_beginOffSet);
    _scrollView = [[UIScrollView alloc] init];
    _cellId = @"a";
    _fview = [self collectionView];
    _sView = [self collectionView];
    _tView = [self collectionView];
}


- (UICollectionView *)collectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(84, 69);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0.0f;
    UICollectionView *rs = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    rs.delegate = self;
    rs.dataSource = self;;
    rs.userInteractionEnabled = NO;
    [rs registerNib:[UINib nibWithNibName:@"DMGPlayerCell" bundle:nil] forCellWithReuseIdentifier:_cellId];
    return rs;
}


- (void)initViews
{
    [self addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView addSubview:_fview];
    [_scrollView addSubview:_sView];
    [_scrollView addSubview:_tView];
}



- (void)setPlayers:(NSArray<NSDictionary *> *)players
{
    _players = players;
    
    if (![_players isKindOfClass:[NSArray class]]){
        _players = @[];
    }
    
    CGFloat length = _players.count * 84.0;
    CGFloat height = self.bounds.size.height;
    
    
    [_scrollView setFrame:(CGRect){0,0,length,height}];
//    [_scrollView setContentOffset:CGPointMake(_beginOffSet, height)];
    [_scrollView setContentSize:(CGSize){_beginOffSet * 2.0,height}];
    
    LQCDLog(@"dsfasdfadsf %f    %f",_scrollView.contentSize.width,_beginOffSet);
    [_scrollView setContentOffset:CGPointMake(_beginOffSet, 0)];
    _scrollView.backgroundColor = [UIColor yellowColor];
    _scrollView.delegate = self;
    
    [_fview setFrame:(CGRect){_beginOffSet - length,0,length,height}];
    [_sView setFrame:(CGRect){_beginOffSet,0,length,height}];
    [_tView setFrame:(CGRect){_beginOffSet + length,0,length,height}];

    [_fview reloadData];
    [_sView reloadData];
    [_tView reloadData];
    
}


#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return _players.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellId
                                                                           forIndexPath:indexPath];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView != _scrollView) return;
    
    LQCDLog(@"----%f",scrollView.contentOffset.x);
    
}

@end
