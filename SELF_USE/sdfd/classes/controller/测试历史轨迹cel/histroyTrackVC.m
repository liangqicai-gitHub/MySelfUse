//
//  histroyTrackVC.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "histroyTrackVC.h"
#import "KTRHistoryTrackCell.h"

@interface histroyTrackVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_cellId;
}
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation histroyTrackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellId = @"a";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                              style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"KTRHistoryTrackCell" bundle:nil] forCellReuseIdentifier:_cellId];
    [_tableView setRowHeight:UITableViewAutomaticDimension];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}





#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KTRHistoryTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId];
    
    return cell;
}






@end
