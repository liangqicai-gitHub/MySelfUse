//
//  MultiScroller.m
//  sdfd
//
//  Created by 梁齐才 on 17/6/15.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "MultiScroller.h"
#import "mytableView.h"

@interface MultiScroller ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    UIView *_header;
    mytableView *_tableView;
}

@end

@implementation MultiScroller

#pragma mark - life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVars];
    [self initViews];
}

- (BOOL)navigationBarHidden
{
    return YES;
}


- (void)initVars
{
    _header = [[UIView alloc] init];
    _header.backgroundColor = [UIColor redColor];
    
    _tableView = [[mytableView alloc] init];
    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

- (void)initViews
{
    [self.view addSubview:_header];
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(300);
        make.top.mas_equalTo(0);
    }];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_header.mas_bottom);
        make.left.bottom.right.mas_equalTo(0);
    }];
    [_tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"1"];
    cell.textLabel.text = Str_F(@"----  %zd",indexPath.row + 1);
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    

    [_header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(y * -1);
    }];
    

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    scrollView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0);
    
}

@end
