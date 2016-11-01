//
//  FootprintTestVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/1.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "FootprintTestVC.h"
#import "KTRFootprintBottomView.h"

@interface FootprintTestVC ()
<
UITableViewDelegate,UITableViewDataSource,
KTRFootprintBottomViewDelegate
>
{
    NSString *_cellId;
}

@end

@implementation FootprintTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    _cellId = @"a";
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_cellId];
        
        KTRFootprintBottomView *view = [KTRFootprintBottomView newInstance];
        [cell.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 10));
        }];
        
        view.tag = 100;
    }
    
    KTRFootprintBottomView *view = [cell.contentView viewWithTag:100];
    view.scanNumber = indexPath.row + 23;
    view.zanNumber = indexPath.row * 2 + 1;
    view.commentNumber = indexPath.row * 3 + 3;
    view.zanStatus = (indexPath.row % 3 == 0) ? FootprintBottomViewZanStatus_Already : FootprintBottomViewZanStatus_NotYet;
    view.delegate = self;
    return cell;
}



- (void)didClickedZanButtonInFootprintBottomView:(KTRFootprintBottomView *)footprintBottomView
{
    switch (footprintBottomView.zanStatus) {
        case FootprintBottomViewZanStatus_Already:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [footprintBottomView setZanStatus:FootprintBottomViewZanStatus_NotYet animation:YES];
                });
            });
        }
            break;
        case FootprintBottomViewZanStatus_NotYet:
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [footprintBottomView setZanStatus:FootprintBottomViewZanStatus_Already animation:YES];
                });
            });
        }
            break;
        default:
            break;
    }
}


@end
