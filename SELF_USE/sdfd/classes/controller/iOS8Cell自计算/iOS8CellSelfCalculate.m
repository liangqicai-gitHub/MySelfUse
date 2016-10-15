//
//  iOS8CellSelfCalculate.m
//  sdfd
//
//  Created by 梁齐才 on 16/10/14.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "iOS8CellSelfCalculate.h"
#import "iOS8FixedCell.h"
#import "iOS8VariableCell.h"

@interface iOS8CellSelfCalculate ()
<
UITableViewDelegate,UITableViewDataSource
>
{
    NSString *_cellIDIOSFixedCell;//不可变
    NSString *_cellIDIOSVariableCell;//可变
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *datas;

@end

@implementation iOS8CellSelfCalculate

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configerVars];
    [self confiverViews];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self buildDatas];
        [_tableView performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:NO];
    });
}

- (NSString *)title
{
    return @"iOS8Cell高度自计算";
}

- (void)configerVars
{
    _cellIDIOSFixedCell = @"a";
    _cellIDIOSVariableCell = @"b";
}


- (void)buildDatas
{
    NSMutableArray *dataM = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++){
        
        id model = nil;
        if (i % 2){
            model = [self modelWithInt:i];
        }else{
            model = [self variableCellWithIndex:i];
        }
        [dataM addObject:model];
    }
    _datas = dataM;
}


- (iOS8FixedCellModel *)modelWithInt:(NSInteger)index
{
    iOS8FixedCellModel *model = [[iOS8FixedCellModel alloc] init];
    model.name = Str_F(@"FixedCell%zd",index);
    return model;
}

- (iOS8VariableCellModel *)variableCellWithIndex:(NSInteger )index
{
    @autoreleasepool {
    
        iOS8VariableCellModel *model = [[iOS8VariableCellModel alloc] init];
        model.name = Str_F(@"VariableCell%zd",index);
        
        NSMutableAttributedString *des = [[NSMutableAttributedString alloc]
                                          initWithString:@"VariableCell_开始_"];
        [des addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}
                     range:NSMakeRange(0, des.length)];
        
        NSInteger newIndex = index > 15 ? 15 : index;
        
        for (NSInteger i = 0; i < newIndex; i++) {
            
            NSInteger fontRange = (arc4random() % 20) + 1;
            NSInteger colorRangeR = (arc4random() % 224) + 1;
            NSInteger colorRangeG = (arc4random() % 224) + 1;
            NSInteger colorRangeB = (arc4random() % 224) + 1;
            
            NSAttributedString *stringM = [[NSAttributedString alloc]
                                           initWithString:Str_F(@"__第%zd个哈哈medadsns__",i)
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontRange],
                                                        NSForegroundColorAttributeName:RGB(colorRangeR,
                                                                                           colorRangeB,
                                                                                           colorRangeG)
                                                        }];
            
            [des appendAttributedString:stringM];
            
        }
        model.des = des;
        
        return model;
    }
}


- (void)confiverViews
{
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView
     registerNib:[UINib nibWithNibName:@"iOS8FixedCell"
                                bundle:nil]
     forCellReuseIdentifier:_cellIDIOSFixedCell];
    
    [_tableView
     registerNib:[UINib nibWithNibName:@"iOS8VariableCell"
                                bundle:nil]
     forCellReuseIdentifier:_cellIDIOSVariableCell];
    
}


#pragma mark - UITableViewDelegate  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _datas[indexPath.row];
    
    UITableViewCell *cell = nil;
    if ([model isKindOfClass:[iOS8FixedCellModel class]]){
        cell = [tableView dequeueReusableCellWithIdentifier:_cellIDIOSFixedCell];
        [(iOS8FixedCell *)cell setCellModel:model];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:_cellIDIOSVariableCell];
        [(iOS8VariableCell *)cell setCellModel:model];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10.0f;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
}

@end
